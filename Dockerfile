FROM ubuntu:24.04 as builder

RUN apt-get update && \
    apt-get install -y golang ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /staging

COPY src/ .

RUN go build

# Copy the Go app into the chiseled-base image
FROM ghcr.io/canonical/rocks-demos.go-runtime/chiseled-base:24.04_edge

COPY --from=builder /staging/app /app

# Define the Pebble layer that will manage the Go application
COPY 002-docker-image-pebble-layer.yaml /var/lib/pebble/default/layers/
# Setting an entrypoint would override the base image's Pebble entrypoint.
# ENTRYPOINT [ "/app" ]