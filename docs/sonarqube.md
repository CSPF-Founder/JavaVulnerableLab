
## Add configuration

We need to add sonar configuration for the project to let mvn scan it.

```sh
echo "
sonar.projectKey=org.cysecurity:JavaVulnerableLab
sonar.projectName=pJavaVulnerableLab
sonar.projectVersion=0.0.1-SNAPSHOT
sonar.sources=src/main/java
sonar.sourceEncoding=UTF-8
sonar.binaries=target/classes
sonar.java.binaries=target/classes
sonar.tests=src/test/java
sonar.scm.provider=git

#Java report only
sonar.language=java

sonar.zaproxy.reportPath=${WORKSPACE}/zaproxy-report.xml
" > ./sonar-project.properties
```

The line below indicates to the Maven Sonar plugin to use the ZAP-Proxy plugin when do a scan in the project codebase : 

```
sonar.zaproxy.reportPath=${WORKSPACE}/zaproxy-report.xml
```

## ZAP Sonar plugin

We can use a plugin that has been developed by Gene Gotimer ([zap-sonar-plugin](https://github.com/Coveros/zap-sonar-plugin)). And for information, as per the time this is being tested, that plugin requires SonarQube 7.9.

## SonarQube instance

In order to be able to scan the code for vulnerabilities as well as for code qualimetry (coverage, duplication...), we need a running instance of SonarQube. 
Here we can use Docker to provide that instance. It's the simpliest way. The sonarqube/Dockerfile is doing the job for you. Within the Dockerfile, the Zap-Proxy plugin jar is added. As per the time this is written, that plugin requires the current LTS version is 7.9 of SonarQube. 

You may run the below commands on the machine (Vagrant VM, or VPS, local machine) :

```
docker-compose build sonarqube
docker-compose up -d sonarqube
```

## Run a scan

Run this command to analyse the codebase :

If using Vagrant :

```sh
vagrant ssh
sudo su -
cd /vagrant
docker-compose up -d sonarqube
sleep 5
docker exec vagrant_javavulnlab_1 mvn sonar:sonar -Dsonar.host.url=http://192.168.10.10:9000
```

If SonarQube is running inside a container on a VM :

```sh
docker exec javavulnerablelab_javavulnlab_1 mvn sonar:sonar -Dsonar.host.url=http://HOSTNAME_OR_IP_ADDRESS:9000
```

If you are directly on a machine :

```sh
mvn sonar:sonar
```

Here, by default it connects to http://localhost:9000.

It connects to the SonarQube server to retrieve information, such as rules and plugins to apply while scanning the code. 
Once the scan is completed, the resulting metrics are sent to the SonarQube server. Then you may see the dashboard [here](http://localhost:9000).

## Quality Metrics

Once this is done, we can see the [vulnerabilities](http://127.0.0.1:9000/project/issues?id=org.cysecurity%3AJavaVulnerableLab&resolved=false&sonarsourceSecurity=sql-injection&types=SECURITY_HOTSPOT) metrics on SonarQube.

![Alt Text](assets/Java-SonarQube-OWASP-Vulnerabilities.png)