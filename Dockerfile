# Build Stage
FROM maven:3.9.6-openjdk-21 AS build

WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests

# Docker Build Stage
FROM adoptopenjdk/openjdk21:alpine-slim

COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 8080
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Dserver.port=${PORT}","app.jar"]
