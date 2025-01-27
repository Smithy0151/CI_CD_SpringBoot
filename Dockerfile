# Use official OpenJDK image to build the application
FROM maven:3.8.1-openjdk-17 as build

# Set working directory
WORKDIR /app

# Copy pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src /app/src

# Build the application
RUN mvn clean package -DskipTests

# Second stage to create the final image with only the needed artifacts
FROM openjdk:17-jre-slim

# Set working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the app will run on
EXPOSE 8080

# Command to run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]

