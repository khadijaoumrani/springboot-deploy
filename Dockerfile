# Build Stage
FROM maven:3.6.3-openjdk-11 AS build

WORKDIR /opt/app

# Copiez tous les fichiers de l'application
COPY ./ /opt/app

# Construisez le projet Maven sans exécuter les tests
RUN mvn clean install -DskipTests

# Docker Build Stage
FROM adoptopenjdk/openjdk11:alpine-slim

# Copiez le fichier JAR généré à partir de l'étape de construction
COPY --from=build /opt/app/target/*.jar /app/app.jar

# Définissez le port et exposez-le
ENV PORT 8082
EXPOSE $PORT

# Définissez le point d'entrée pour exécuter l'application
ENTRYPOINT ["java", "-jar", "-Dserver.port=${PORT}", "/app/app.jar"]
