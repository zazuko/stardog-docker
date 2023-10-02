# Docker image for Stardog

This is a non-official Docker image for Stardog.

It includes the Java OpenTelemetry instrumentation agent.

## Quick Start

The Docker image only supports amd64 architecture for now.

First, put your Stardog license file in the `volumes/stardog` directory.

Then start the Stardog instance using the following command:

```sh
docker run --rm -it \
  -p 5820:5820 \
  -v ./volumes/stardog:/var/opt/stardog \
  -e STARDOG_SERVER_JAVA_ARGS="-Xmx8g -Xms8g -XX:MaxDirectMemorySize=12g" \
  ghcr.io/zazuko/stardog:latest
```

You now have a local Stardog instance running on port 5820.

You can also use the following command to build and run the Docker image locally:

```sh
docker-compose up -d
```

This will expose:

- Stardog on port 5820
- Stardog Studio on port 8080

And to remove the stack, use:

```sh
docker-compose down
```

## Required Java arguments for OpenTelemetry support

Add those elements to your `STARDOG_SERVER_JAVA_ARGS` environment variable to enable OpenTelemetry support:

```sh
-javaagent:/opt/stardog/opentelemetry/opentelemetry-javaagent.jar
-Dotel.resource.attributes=service.name=stardog
-Dotel.traces.exporter=otlp
-Dotel.metrics.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://<url to your otlp collector endpoint>
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
