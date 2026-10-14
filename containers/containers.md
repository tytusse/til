# Podman/docker caches are simply about "what layer was before" and "what exactly the instruction does"

`One.Dockerfile`:
```Dockerfile
FROM ubuntu
RUN echo foo
```

`Two.Dockerfile`:
```Dockerfile
FROM ubuntu
RUN echo foo
RUN echo baz
```

Assuming that image/layer cache is empty, we build two images each one from other file

```bash
podman image build -t=test-layers-1 . -f One.Dockerfile
podman image build -t=test-layers-2 . -f Two.Dockerfile
```
Then 2nd image build (for `test-layers-2`:
- **use cached layers** for `FROM ubuntu` and `RUN echo foo`
- will only build new layer for `RUN echo baz`.

Also note, that if we'd swap `podman build` commands, then two 1st layers would also be reused.

The result is:
```console
> podman image build -t=test-layers-1 . -f One.Dockerfile
STEP 1/3: FROM ubuntu
STEP 2/3: RUN echo Foo
Foo
--> ba8e5dc52da3
STEP 3/3: RUN echo Bar
Bar
COMMIT test-layers-1
--> a145059a6a85
Successfully tagged localhost/test-layers-1:latest
a145059a6a8555e637cdd806c802e3e1a527cbafca105a2b1b480f27c913526f
> podman image build -t=test-layers-2 . -f Two.Dockerfile
STEP 1/4: FROM ubuntu
STEP 2/4: RUN echo Foo
--> Using cache ba8e5dc52da3f12f35c4a69e2361f2d73cd68dca62db78359307efd623b1abe6
--> ba8e5dc52da3
STEP 3/4: RUN echo Bar
--> Using cache a145059a6a8555e637cdd806c802e3e1a527cbafca105a2b1b480f27c913526f
--> a145059a6a85
STEP 4/4: RUN echo Baz
Baz
COMMIT test-layers-2
--> 41ae22d9f0f3
Successfully tagged localhost/test-layers-2:latest
41ae22d9f0f3615d2b5a67f7eb4355ead3ce9ace4e558addda7cd180e49f935b
```


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
