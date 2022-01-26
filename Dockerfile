FROM docker.io/stardog/stardog:7.8.3-java11-preview

ARG OTEL_VERSION=1.10.0

RUN mkdir -p /opt/stardog/opentelemetry

# get the OpenTelemetry instrumentation agent
RUN curl --silent --fail \
  --output /opt/stardog/opentelemetry/opentelemetry-javaagent.jar \
  -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_VERSION}/opentelemetry-javaagent.jar
