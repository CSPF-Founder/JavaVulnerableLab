FROM tomcat:8.5.20-jre8

RUN pwd
RUN ls

COPY . /code
WORKDIR /code

RUN apt-get update && apt-get install -y --no-install-recommends \
		maven \
		openjdk-8-jdk

RUN mvn clean
RUN mvn package

RUN cp target/JavaVulnerableLab.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
