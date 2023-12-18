FROM --platform=linux/amd64 docker.io/library/eclipse-temurin:11-jre-jammy

ARG OTEL_VERSION="1.32.0"
ARG STARDOG_VERSION="9.2.0"

ENV STARDOG_HOME="/var/opt/stardog"

# Upgrade dependencies and install required tools
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y gnupg \
  && apt-get clean

# Install Stardog
RUN curl http://packages.stardog.com/stardog.gpg.pub | apt-key add \
  && echo "deb http://packages.stardog.com/deb/ stable main" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y "stardog=${STARDOG_VERSION}" \
  && apt-get clean

# Get the OpenTelemetry instrumentation agent.
# https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/
RUN mkdir -p /opt/stardog/opentelemetry
RUN curl --silent --fail \
  --output /opt/stardog/opentelemetry/opentelemetry-javaagent.jar \
  -L "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_VERSION}/opentelemetry-javaagent.jar"

EXPOSE 5820
CMD [ "/opt/stardog/bin/stardog-admin", "server", "start", "--upgrade", "--foreground", "--port", "5820", "--home", "/var/opt/stardog" ]
