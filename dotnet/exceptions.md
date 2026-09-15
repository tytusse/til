# `StackTraceHiddenAttribute` less known facts
The [docs](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.stacktracehiddenattribute?view=net-10.0) say
> Types and Methods attributed with StackTraceHidden will be omitted from the stack trace text shown in StackTrace.ToString() and Exception.StackTrace

However **in F#** it seems that if exception is thrown inside given method, it **will** be included.
## C# is fine

In `csharprepl`:

```C#
using System.Diagnostics;

class Foo {
  [StackTraceHidden]
  public static void Bar(Action other) {
    other();
  }

  [StackTraceHidden]
  public static void BarThrow(Action other) {
    try{ other(); } catch(Exception x) { throw new Exception("rethrow", x); }
  }
}
```
then
```C#
try { Foo.Bar(() => Foo.Bar(() => throw new Exception("oops"))); } catch (Exception x) { Console.WriteLine(x.StackTrace); }
```
yielded
```
   at Submission#13.<>c.<<Initialize>>b__0_1()
   at Submission#13.<>c.<<Initialize>>b__0_0()
   at Submission#13.<<Initialize>>d__0.MoveNext()
```
```C#
try { Foo.Bar(() => Foo.BarThrow(() => throw new Exception("oops"))); } catch (Exception x) { Console.WriteLine(x.StackTrace); }
```
Is also fine
```
   at Submission#7.<>c.<<Initialize>>b__0_0()
   at Submission#7.<<Initialize>>d__0.MoveNext()
```

## F# is NOT fine

in `dotnet fsi`, having

```F#
open System.Diagnostics

[<StackTraceHidden>]
let runThrow f : unit =
  try f()
  with x -> raise(exn("wrapped inner", x))

[<StackTraceHidden>]
let run f: unit = f();;
```

Using non throwing one is ok:
```F#
run(fun() -> run(fun() -> run(fun() -> failwith "oops")));;
```

```
System.Exception: oops
   at <StartupCode$FSI_0026>.$FSI_0026.main@() in /home/tomek/repos/dotnet-research/stdin:line 94
   at System.RuntimeMethodHandle.InvokeMethod(ObjectHandleOnStack target, Void** arguments, ObjectHandleOnStack sig, BOOL isConstructor, ObjectHandleOnStack result)
   at System.RuntimeMethodHandle.InvokeMethod(ObjectHandleOnStack target, Void** arguments, ObjectHandleOnStack sig, BOOL isConstructor, ObjectHandleOnStack result)
   at System.Reflection.MethodBaseInvoker.InterpretedInvoke_Method(Object obj, IntPtr* args)
   at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
```

**However**, throwin one gets included:

```F#
run(fun() -> run(fun() -> runThrow(fun() -> failwith "oops")))
```
yields
```
System.Exception: wrapped inner
 ---> System.Exception: oops
   at FSI_0027.it@95-10.Invoke(Unit unitVar0) in /home/tomek/repos/dotnet-research/stdin:line 95
   at FSI_0024.runThrow(FSharpFunc`2 f) in /home/tomek/repos/dotnet-research/stdin:line 88
   --- End of inner exception stack trace ---
   at <StartupCode$FSI_0027>.$FSI_0027.main@() in /home/tomek/repos/dotnet-research/stdin:line 95
   at System.RuntimeMethodHandle.InvokeMethod(ObjectHandleOnStack target, Void** arguments, ObjectHandleOnStack sig, BOOL isConstructor, ObjectHandleOnStack result)
   at System.RuntimeMethodHandle.InvokeMethod(ObjectHandleOnStack target, Void** arguments, ObjectHandleOnStack sig, BOOL isConstructor, ObjectHandleOnStack result)
   at System.Reflection.MethodBaseInvoker.InterpretedInvoke_Method(Object obj, IntPtr* args)
   at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
```


