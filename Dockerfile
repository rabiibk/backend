# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11-slim 
WORKDIR /app
COPY pom.xml .
COPY src src/
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:11-jre-slim
WORKDIR /home/rabii/backend/Dockerfile
COPY --from=build /app/target/java8-2.0.jar java8.jar
EXPOSE 8080
CMD ["java", "-jar", "java8.jar"]
