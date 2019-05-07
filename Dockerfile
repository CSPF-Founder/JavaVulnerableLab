FROM tomcat:8

ARG org
ARG token

RUN echo "using org ID $org and token $token"

### Dependencies
RUN curl -L https://stg.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin
RUN apt-get update; apt-get install maven default-jdk -y; update-alternatives --config javac

RUN sl --no-diagnostic auth --org "$org" --token "$token"

### Build
COPY . .
RUN mvn clean package ; cp target/*.war /usr/local/tomcat/webapps/

### Analyze
RUN sl analyze --app jvl --wait

### Run
CMD ["sl", "run", "catalina.sh","run"]
