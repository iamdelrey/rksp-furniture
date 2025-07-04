﻿FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

COPY --from=build /app/target/java-render-example-0.0.1.jar ./app.jar

EXPOSE 8080
CMD ["java","-jar","app.jar"]
