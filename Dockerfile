# Use an official Maven image as a parent image
FROM maven:3.8.4-openjdk-8 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project's POM file
COPY ./pom.xml ./pom.xml

# Copy the rest of the project
COPY ./src ./src

# Build the project and package it into a JAR
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime as a parent image for the runtime image
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file from the build image
COPY --from=build /app/target/java8-2.0.jar app.jar

# Expose the port that your Spring Boot application will run on
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "app.jar"]

