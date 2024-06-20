# Stage 1: Build Stage
FROM openjdk:8 as build

WORKDIR /app

# Copy the source code into the Docker image
COPY . .

# Install Maven and JDK, then build the project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package

# Stage 2: Runtime Stage
FROM tomcat:7.0.82

# Copy the WAR file built in the previous stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/

# Copy the pre-prepared tomcat-users.xml to set up user roles
COPY default-tomcat.xml /usr/local/tomcat/conf/tomcat-users.xml

# CMD to start Tomcat
CMD ["catalina.sh", "run"]
