FROM eclipse-temurin:17-jdk-alpine

# Install Maven
RUN apk add --no-cache maven

WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install

VOLUME /tmp
EXPOSE 8080
ADD target/springboot-aws-deploy-service.jar springboot-aws-deploy-service.jar
ENTRYPOINT ["java","-jar","/springboot-aws-deploy-service.jar"]
