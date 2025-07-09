# rocks-demos.go-runtime

How to deploy a **dynamically-linked** Go binary on a Chiseled Ubuntu base
container.

## Scenarios

In all scenarios, the resulting images should have ~29MB (14MB compressed) and
the output shall look something like this:

```
2025-07-08T07:29:03.830Z [app] 2025/07/08 07:29:03 Go: Hello World!
2025-07-08T07:29:04.495Z [app] 2025/07/08 07:29:04 [https://golang.org] https request succeeded
```

### Using Rockcraft

1. find the `rockcraft.yaml` file in the root of this repository, which defines
the declarative recipe for building a Chiseled Ubuntu base container with a freshly compiled Go application
    - *Ref: [what is Rockcraft](https://documentation.ubuntu.com/rockcraft/en/stable/)*
2. run `rockcraft pack` to build the rock. This will create a `.rock` file in the root of the repository
    - *Ref: [build your 1st rock](https://documentation.ubuntu.com/rockcraft/en/stable/tutorial/hello-world/)*
3. copy the `.rock` file to your target system like a container registry, or
simply your local Docker daemon. Example:

   ```bash
   rockcraft.skopeo copy --insecure-policy \
        oci-archive:go-app_24.04_amd64.rock \
        docker-daemon:go-app:latest
   ```

4. test it:

   ```bash
   docker run --rm go-app:latest --verbose
   ```

### Using Dockerfiles

> [!NOTE]
> This `Dockerfile` will use the development image
`ghcr.io/canonical/rocks-demos.go-runtime/chiseled-base:24.04_edge` as a base.

1. find the `Dockerfile` in the root of this repository, which defines a
multi-stage build process, compiling the Go application and then packaging
it into a Chiseled Ubuntu base container (alongside a new Pebble layer to
add the new Go app as a Pebble service).

1. build the Docker image with `docker`:

   ```bash
   docker build -t go-app:latest .
   ```

2. test it:

   ```bash
   docker run --rm go-app:latest --verbose
   ```
