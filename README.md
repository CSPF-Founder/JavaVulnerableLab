# Java Vulnerabilities Experiment

This is a "Vulnerable" Web Application developed by Cyber Security and Privacy Foundation(www.cysecurity.org). This app is intended for the Java Programmers and other people who wish to learn about Web application vulnerabilities and write secure code.

## Prerequisites:

- [git](https://git-scm.com/downloads)
- with [Docker](https://docs.docker.com/install/), [docker-compose](https://docs.docker.com/compose/install/) and [Vagrant](https://www.vagrantup.com/docs/installation/)
- or [JDK8+](https://openjdk.java.net/install/), [Maven](http://maven.apache.org/install.html) and [tomcat 8](https://tomcat.apache.org/tomcat-8.5-doc/setup.html)

## Deploy it

There are many easy way to deploy this application.

1. Using Vagrant to run this application in a VM (containers are launched inside it, as describe in option #2) :

```sh
git clone https://github.com/softwaresecured/JavaVulnerableLab.git
cd JavaVulnerableLab
vagrant up
```

2. Using Docker to run on a machine :

```sh
git clone https://github.com/softwaresecured/JavaVulnerableLab.git
cd JavaVulnerableLab
docker-compose up -d javavulnlab mysql
```

3. If not using Docker at all, you'll need to the JDBC URL in `config.properties` and `install.jsp` from :

```
dburl=jdbc:mysql://mysql:3306/  => jdbc:mysql://localhost:3306 
```

4. If you want to play with it on a VPS, you'll need to the JDBC URL in `config.properties` and `install.jsp` from :
                                      
```
dburl=jdbc:mysql://mysql:3306/  => jdbc:mysql://SERVER_HOSTNAME_OR_IP_ADDRESS:3306 
```

And the link at next step will require the server hostname or IP address.

5. You already have a tomcat, and want to deploy the application with a war. 
  
  Steps:
  
       1. Go to http://[Tomcat_INSTALLED_IP]:8080/manager/  (make sure you have modified tomcat-users.xml file of the tomcat to allow the manager).
       2. Download our WAR file from here: https://sourceforge.net/projects/javavulnerablelab/files/latest/JavaVulnerableLab.war/download
       3. Deploy the WAR in Apache Tomcat manager.

## Experiment it

1. Once the build is completed and the application is started, go to [/JavaVulnerableLab/install.jsp](http://localhost:8080/JavaVulnerableLab/install.jsp)

2. And click on `Install` button, by leaving default values as-is.

## Vulnerabilities Scan

The Open Web Application Security Project (OWASP) team recommends many [tools](https://www.owasp.org/index.php/Appendix_A:_Testing_Tools) to address security matters. 
One of the most popular is the OWASP `Zed Attack Proxy` (**ZAP**) tool to scan the vulnerabilities. please refer to [this guideline](docs/owasp-zap.md). 
Also, if you need to automate everything in your Continuous Integration and Continuous Delivery (**CI/CD**) toolchain, you can go through this [this guideline](docs/sonarqube.md).

## Notes

**The full course on Hacking and Securing Web Java Programs is available in** 

https://www.udemy.com/hacking-securing-java-web-programming/

**Warning**: It's not recommanded to run this app in `Your Main Machine` or in an `online server`.  Prefer using Docker or a VM (vagrant).

You can also get the VulnerableSpring Project from [here](https://github.com/CSPF-Founder/VulnerableSpring).

