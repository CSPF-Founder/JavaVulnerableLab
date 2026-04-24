# JavaVulnerableLab - Project Context

## Project Overview
**JavaVulnerableLab** is an intentionally vulnerable web application developed by Cyber Security and Privacy Foundation (CSPF) for educational purposes. It's designed to teach Java programmers and security professionals about common web application vulnerabilities and how to write secure code.

⚠️ **WARNING**: This is a deliberately vulnerable application. Never deploy to production or any internet-accessible server. Use only in isolated virtual machines or Docker containers.

## Project Purpose
- Educational tool for learning web application security vulnerabilities
- Hands-on practice for identifying and exploiting common security flaws
- Reference for understanding secure coding practices by studying vulnerable examples
- Part of CSPF's Java Security Course (https://github.com/CSPF-Founder/JavaSecurityCourse)

## Technology Stack
- **Language**: Java
- **Web Framework**: Java Servlets & JSP
- **Application Server**: Apache Tomcat
- **Build Tool**: Maven
- **Database**: MySQL
- **ORM**: Hibernate 4.0.1.Final
- **Servlet API**: 2.3
- **JSTL**: 1.2
- **MySQL Connector**: 5.1.26

## Project Structure

### Source Code Organization
```
src/main/java/org/cysecurity/cspf/jvl/
├── controller/          # Servlet controllers
│   ├── Install.java
│   ├── LoginValidator.java
│   ├── Register.java
│   ├── Logout.java
│   ├── SendMessage.java
│   ├── ForwardMe.java
│   ├── AddPage.java
│   ├── UsernameCheck.java
│   ├── EmailCheck.java
│   ├── XPathQuery.java
│   ├── xxe.java
│   ├── BlindSQLInjection.java (latest addition)
│   └── ...
└── model/              # Data models and utilities
    ├── DBConnect.java
    ├── HashMe.java
    └── orm/
        └── Users.java

src/main/webapp/
├── WEB-INF/
│   ├── web.xml          # Servlet mappings and configuration
│   └── AdminPanel.jsp
├── vulnerability/       # Vulnerability demonstration pages
│   ├── sqli/           # SQL Injection examples
│   ├── xss/            # Cross-Site Scripting examples
│   ├── csrf/           # CSRF examples
│   ├── idor/           # Insecure Direct Object Reference
│   ├── Injection/      # Various injection attacks
│   ├── unvalidated/    # Unvalidated redirects
│   ├── baasm/          # Broken Authentication
│   ├── sde/            # Sensitive Data Exposure
│   ├── securitymisconfig/
│   └── mfac/
├── admin/              # Admin panel pages
├── header.jsp
├── footer.jsp
├── index.jsp
├── login.jsp
└── ...
```

## Vulnerabilities Demonstrated

The application intentionally includes the following OWASP Top 10 vulnerabilities:

1. **SQL Injection**
   - Classic SQL injection in login forms
   - Union-based SQL injection
   - Blind SQL injection (boolean-based)
   - File: `BlindSQLInjection.java`, `download_id.jsp`, `download_id_union.jsp`

2. **Cross-Site Scripting (XSS)**
   - Reflected XSS
   - Stored XSS
   - DOM-based XSS
   - Directory: `vulnerability/xss/`

3. **Cross-Site Request Forgery (CSRF)**
   - Password change without CSRF tokens
   - Profile update vulnerabilities
   - Directory: `vulnerability/csrf/`

4. **Insecure Direct Object References (IDOR)**
   - Email change without authorization
   - File download with predictable IDs
   - Directory: `vulnerability/idor/`

5. **XML External Entity (XXE)**
   - File: `xxe.java`, `xxe.jsp`

6. **XPath Injection**
   - File: `XPathQuery.java`, `xpath_login.jsp`

7. **Broken Authentication and Session Management**
   - URL rewriting exposing session tokens
   - Directory: `vulnerability/baasm/`

8. **Sensitive Data Exposure**
   - Weak hashing mechanisms
   - Directory: `vulnerability/sde/`

9. **Security Misconfiguration**
   - Directory: `vulnerability/securitymisconfig/`

10. **Unvalidated Redirects and Forwards**
    - Files: `ForwardMe.java`, `OpenURL.jsp`, `OpenForward.jsp`

## Recent Changes
- **Latest**: Added Blind SQL Injection vulnerability example
  - Servlet: `BlindSQLInjection.java`
  - JSP: `blind-injection.jsp`
  - Demonstrates boolean-based blind SQL injection
  - Educational content with attack examples
  - Endpoint: `/BlindSQLInjection.do`

## Setup Instructions

### Docker (Recommended)
```bash
docker-compose up
# Access: http://localhost:8080/JavaVulnerableLab/install.jsp
# Change JDBC URL to: jdbc:mysql://mysql:3306
```

### Local Development
```bash
# Build
mvn clean package

# Deploy WAR to Tomcat
cp target/JavaVulnerableLab.war $TOMCAT_HOME/webapps/

# Access
http://localhost:8080/JavaVulnerableLab/install.jsp
```

### Requirements
- JDK 7 or higher
- Apache Tomcat 7 or higher
- MySQL 5.x
- Maven 3.x

## Git Information
- **Main Branch**: `master`
- **Current Branch**: `feature/blind-sql-injection`
- **Remote**: GitHub repository

## Important Conventions

### Code Style
- Package structure: `org.cysecurity.cspf.jvl.*`
- Controllers follow servlet pattern
- JSP pages in semantic directory structure
- Vulnerability examples grouped by OWASP category

### Adding New Vulnerabilities
1. Create servlet in `src/main/java/org/cysecurity/cspf/jvl/controller/`
2. Create JSP in appropriate `src/main/webapp/vulnerability/` subdirectory
3. Register servlet in `web.xml`
4. Add navigation link in `header.jsp`
5. Include educational content explaining the vulnerability
6. Provide example attack vectors

### Database
- Connection managed by `DBConnect.java`
- Uses JDBC directly for most queries (intentionally vulnerable)
- Hibernate ORM available but selectively used

## Security Analysis Notes

When working with this codebase:
- **Never propose fixes** - vulnerabilities are intentional and educational
- **Document vulnerabilities** clearly when adding new examples
- **Include attack examples** to help students understand exploitation
- **Add educational content** explaining why code is vulnerable
- **Test exploits** to ensure vulnerabilities work as intended
- **Reference OWASP** guidelines where applicable

## Related Resources
- Full Course: https://github.com/CSPF-Founder/JavaSecurityCourse
- Udemy Course: https://www.udemy.com/hacking-securing-java-web-programming/
- VulnerableSpring Project: https://github.com/CSPF-Founder/VulnerableSpring
- CSPF Website: https://www.cysecurity.org

## Development Notes
- **Purpose**: Educational demonstration of vulnerabilities
- **Target Audience**: Java developers learning security, security researchers, students
- **Legal Usage**: Only in authorized testing environments (VM, Docker, isolated networks)
- **License**: Check repository for specific license terms
- **Contribution**: Follow existing patterns when adding new vulnerability examples

## Build Output
- **Artifact**: JavaVulnerableLab.war
- **Deployment**: Standard Java WAR file for servlet containers
- **Configuration**: web.xml follows Servlet 2.3 spec

## Dependencies Summary
- **mysql-connector-java**: 5.1.26 (MySQL database connectivity)
- **json**: 20090211 (JSON processing)
- **jstl**: 1.2 (JSP Standard Tag Library)
- **hibernate-core**: 4.0.1.Final (ORM framework)
- **servlet-api**: 2.3 (Servlet specification)
- **junit**: 3.8.1 (Testing framework)

---
*Last Updated: 2026-02-24*
*Project: JavaVulnerableLab by CSPF*
*Context Document for Claude Code Assistant*
