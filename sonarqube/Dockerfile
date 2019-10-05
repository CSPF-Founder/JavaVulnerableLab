
FROM sonarqube:lts
USER root
RUN apt-get update && apt-get install -y wget

USER sonarqube
RUN wget https://github.com/Coveros/zap-sonar-plugin/releases/download/sonar-zap-plugin-1.2.0/sonar-zap-plugin-1.2.0.jar -O /opt/sonarqube/extensions/plugins/sonar-zap-plugin-1.2.0.jar

ENTRYPOINT ["./bin/run.sh"]

