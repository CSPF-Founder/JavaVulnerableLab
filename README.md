This is a "Vulnerable" Web Application developed by Cyber Security and Privacy Foundation(www.cysecurity.org). This app is intended for the Java Programmers and other people who wish to learn about Web application vulnerabilities and write secure code.

##### Prerequisites:
- docker-compose
- git

##### Steps:
- Clone the repo:<br>`git clone https://github.com/softwaresecured/JavaVulnerableLab.git`

- Change into the directory:<br>`cd JavaVulnerableLab/`

- And start the app:<br> `sudo docker-compose up`

- After the build process, navigate to:<br>
`http://localhost:8080/JavaVulnerableLab/install.jsp`

- And click *Install* (leaving the default options)<br>




### The following is the previous README describing other installation methods

----------------------------------
The full course on Hacking and Securing Web Java Programs is available in
-----------------------------------
https://www.udemy.com/hacking-securing-java-web-programming/

**Warning**: Don't run this app in Your Main Machine or in  an online server.  Install it in Vitual Machine.


How to Use/Setup ?
-------------

**Method 1.Very Easiest Method : VirtualBox VM**
  The Most easiest way to use Java Vulnerable is using the VirtualBox VM which has everything set up and ready to use.

  Steps:

      1. Install the VirtualBox : https://www.virtualbox.org/wiki/Downloads
      2. Download the VM Image from here : http://sourceforge.net/projects/javavulnerablelab/files/v0.1/JavaVulnerableLab.ova/download
      3. Import the JavaVulnerable.ova into VirtualBox.
      4. Change the Network Settings to Host-Only Network
      5. Start the Machine and Log into the Machine( Credentials; username: root password: cspf)
      6. Start Tomcat by entering "service tomcat start" in the Terminal
      7. Start mysql by entering "service mysql start" in the Terminal
      8. Find the IP Address of Machine
      9. In your Browser, go to "http://[IP_ADDRESS_OF_VM]:8080/JavaVulnerableLab/install.jsp
      10. Click the Install Button
      11. Enjoy :)

**Method 2.Easiest Method : Standalone Web Application**
  In this mehtod, you will be running an executable "JAR" file which runs the application with an embedded Apache Tomcat.

    Steps:

        1. Install JDK
        2. Download Executable Jar from here: http://sourceforge.net/projects/javavulnerablelab/files/v0.2/JavaVulnerableLab.jar/download
        3. Double Click the JavaVulnerable.jar to run( if double click is not working, run this command "java -jar JavaVulnerable.jar" in your Terminal or CMD)
        4. In your Browser, go to "http://localhost:8080/JavaVulnerableLab/install.jsp
        5. Click the Install Button

**Method 3. Using War file:**
  This is a NORMAL method to deploy the WAR file.

  Steps:

       1. Install Apache Tomcat server
       2. Go to http://[Tomcat_INSTALLED_IP]:8080/manager/  (make sure you have modified tomcat-users.xml file of the tomcat to allow the manager).
       3. Download our WAR file from here: https://sourceforge.net/projects/javavulnerablelab/files/latest/JavaVulnerableLab.war/download
       4. Deploy the WAR in Apache Tomcat manager.
       5. Go to http://[Tomcat_INSTALLED_IP]:8080/JavaVulnerableLab/install.jsp
       6. Click the Install Button


Get the VulnerableSpring Project from here:
https://github.com/breakthesec/VulnerableSpring
