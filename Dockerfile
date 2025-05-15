# Stage 1: Build the application
FROM eclipse-temurin:17-jdk-alpine AS builder
RUN apk add --no-cache maven
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Stage 2: Create the final image
FROM eclipse-temurin:17-jre-alpine
VOLUME /tmp
EXPOSE 8080
COPY --from=builder /app/target/springboot-aws-deploy-service.jar springboot-aws-deploy-service.jar
ENTRYPOINT ["java","-jar","/springboot-aws-deploy-service.jar"]
