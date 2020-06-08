FROM tomcat

COPY . /code
WORKDIR /code

RUN apt-get update \
    && apt-get install -y \
        maven \
        openjdk-8-jdk

RUN mvn clean package
RUN cp target/JavaVulnerableLab.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
