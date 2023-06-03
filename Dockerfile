FROM maven:3.81-jdk-11-slim AS build
LABEL AUTHOR="Priya-270"
WORKDIR /app
COPY . .
RUN mvn clean package

# stage 2 - create the final Docker image
FROM openjdk:11-jre-slim
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz  .
RUN tar xf apache-tomcat-9.0.75.tar.gz
RUN mv apache-tomcat-9.0.75.tar.gz
COPY --from=build /app/target/hr-api.war /opt/tomcat9/webapps
EXPOSE 8080
CMD ["/app/tomcat9/bin/catalina.sh","run"]

