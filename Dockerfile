# Stage 1: Build Stage
FROM eclipse-temurin:25-jdk AS build

WORKDIR /app

# Copy the source code into the Docker image
COPY . .

# Install Maven and JDK, then build the project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package && \
    mvn dependency:copy-dependencies -DincludeArtifactIds=mysql-connector-java -DoutputDirectory=/app/shared-libs

# Stage 2: Runtime Stage
FROM tomcat:7.0.82

# Copy the WAR file built in the previous stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/

# Copy the JDBC driver into Tomcat's shared lib so the pool DataSource (declared
# in META-INF/context.xml and loaded by the container classloader) can find it.
COPY --from=build /app/shared-libs/*.jar /usr/local/tomcat/lib/

# Copy the pre-prepared tomcat-users.xml to set up user roles
COPY default-tomcat.xml /usr/local/tomcat/conf/tomcat-users.xml

ENV CATALINA_OPTS="-Xms256m -Xmx1024m"

# CMD to start Tomcat
CMD ["catalina.sh", "run"]
