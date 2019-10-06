# Java Vulnerabilities Experiment

This is a "Vulnerable" Web Application developed by Cyber Security and Privacy Foundation(www.cysecurity.org). This app is intended for the Java Programmers and other people who wish to learn about Web application vulnerabilities and write secure code.

## Prerequisites:

- git
- docker docker-compose
- vagrant

## Deploy it

1. Using Docker to run on a machine :

```sh
git clone https://github.com/softwaresecured/JavaVulnerableLab.git
cd JavaVulnerableLab
docker-compose up
```

2. Using Vagrant to run this application in a VM (containers are launched inside it) :

```sh
git clone https://github.com/softwaresecured/JavaVulnerableLab.git
cd JavaVulnerableLab
vagrant up
```

3. If not using Docker at all, you'll need to the JDBC URL in `config.properties` and `install.jsp` from :

```
dburl=jdbc:mysql://mysql:3306/
```

to this :

```
jdbc:mysql://localhost:3306 
```

4. If you want to play with it on a VPS, you'll need to the JDBC URL in `config.properties` and `install.jsp` from :
                                      
```
dburl=jdbc:mysql://mysql:3306/
```

to this :

```
jdbc:mysql://IP_ADDRESS:3306 
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

## Notes

**The full course on Hacking and Securing Web Java Programs is available in** 

https://www.udemy.com/hacking-securing-java-web-programming/

**Warning**: It's not recommanded to run this app in `Your Main Machine` or in an `online server`.  Prefer using Docker or a VM (vagrant).

You can also get the VulnerableSpring Project from [here](https://github.com/CSPF-Founder/VulnerableSpring).

