# ARG behavior GOTCHA

When ARG is used before FROM, then it is NOT available later (!!!)
```containerfile
ARG foo=bar
FROM ubunyu
RUN echo "Foo: $foo"
```

-->

```
Foo: 
```

but

```containerfile

FROM ubunyu
ARG foo=bar
RUN echo "Foo: $foo"
```

-->

```
Foo: bar
```
