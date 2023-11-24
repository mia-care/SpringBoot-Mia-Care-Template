FROM alpine AS build

ARG COMMIT_SHA=<not-specified>
ARG BUILD_FILE_NAME=springboot-template

WORKDIR /build

COPY ./target/${BUILD_FILE_NAME}.jar ./application.jar
COPY LICENSE .

RUN echo "service-name: $COMMIT_SHA" >> ./commit.sha

FROM openjdk:11-jre-slim

LABEL maintainer="alessandro.bonadei@mia-care.io" \
      name="springboot-template" \
      description="This is the best template to start creating a service in Springboot integrated inside the Platform" \
      eu.mia-platform.url="https://www.mia-platform.eu" \
      eu.mia-platform.version="0.1.0"

# set deployment directory
WORKDIR /home/java/app

COPY --from=build /build .

USER 1000

CMD ["java", "-jar", "./application.jar"]
