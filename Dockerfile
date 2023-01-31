FROM tomcat:10.1.5-jdk11

COPY . .

RUN apt-get update ; apt-get install maven default-jdk -y ; update-alternatives --config javac

RUN mvn clean package ; cp target/*.war /usr/local/tomcat/webapps/

CMD ["catalina.sh","run"]
