FROM eclipse-temurin:17 as builder
WORKDIR application
ARG ARTIFACT_NAME
COPY ${ARTIFACT_NAME}.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract

# Download dockerize and cache that layer
ARG DOCKERIZE_VERSION
RUN wget -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz
RUN tar xzf dockerize.tar.gz
RUN chmod +x dockerize
ADD AppServerAgent-1.8-23.5.0.34821/ AppdAgent/
ADD entrypoint.sh .
FROM eclipse-temurin:17

WORKDIR application

# Dockerize
COPY --from=builder application/dockerize ./
COPY --from=builder application/entrypoint.sh ./
COPY --from=builder application/AppdAgent ./AppdAgent
ARG EXPOSED_PORT
EXPOSE ${EXPOSED_PORT}

ENV SPRING_PROFILES_ACTIVE docker
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
RUN mkdir /application/logs
ENTRYPOINT ["./entrypoint.sh"]
