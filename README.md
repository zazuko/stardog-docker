# Docker image for Stardog

This is a non-official Docker image for Stardog.

It includes the OpenTelemetry instrumentation agent.

## Required Java arguments

Add those elements to your `STARDOG_SERVER_JAVA_ARGS` environment variable:

```
-javaagent:/opt/stardog/opentelemetry/opentelemetry-javaagent.jar
-Dotel.resource.attributes=service.name=stardog
-Dotel.traces.exporter=otlp
-Dotel.metrics.exporter=otlp
-Dotel.exporter.otlp.endpoint=http://<url to your otlp collector endpoint>
```
