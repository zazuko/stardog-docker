FROM docker.io/stardog/stardog:8.2.1-java11-preview

ARG OTEL_VERSION=1.17.0

RUN mkdir -p /opt/stardog/opentelemetry

# get the OpenTelemetry instrumentation agent
RUN curl --silent --fail \
  --output /opt/stardog/opentelemetry/opentelemetry-javaagent.jar \
  -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_VERSION}/opentelemetry-javaagent.jar
