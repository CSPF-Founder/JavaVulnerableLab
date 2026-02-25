# Repository Guidelines

## Project Structure & Module Organization
- `src/main/java/org/cysecurity/cspf/jvl/`: Java servlets and models. Controllers live in `controller/`, data/utility classes in `model/`.
- `src/main/webapp/`: JSPs and static web assets. Vulnerability demos are grouped under `vulnerability/` by OWASP category (e.g., `vulnerability/sqli/`, `vulnerability/xss/`).
- `src/main/webapp/WEB-INF/web.xml`: servlet mappings and configuration.
- Root files: `pom.xml` (Maven build), `docker-compose.yml` (Docker stack).

## Build, Test, and Development Commands
- `mvn clean package`: build the WAR (`target/JavaVulnerableLab.war`).
- `docker-compose up`: start app + MySQL via Docker; then open `http://localhost:8080/JavaVulnerableLab/install.jsp` and set JDBC URL to `jdbc:mysql://mysql:3306`.
- Deploy manually: copy WAR to Tomcat `webapps/` and open `http://localhost:8080/JavaVulnerableLab/install.jsp`.

## Coding Style & Naming Conventions
- Java package root: `org.cysecurity.cspf.jvl.*`.
- Controllers are servlet classes in `controller/` and are registered in `web.xml`.
- JSPs should be placed in the matching vulnerability subfolder (e.g., SQLi pages in `vulnerability/sqli/`).
- Naming: servlet classes in PascalCase (e.g., `BlindSQLInjection.java`), JSPs in lowercase with hyphens or descriptive names (e.g., `blind-injection.jsp`).

## Testing Guidelines
- JUnit is listed as a dependency, but there are no automated tests in the repo right now.
- If you add tests, place them under `src/test/java/` and keep names ending with `Test`.
- Run tests with `mvn test` after adding any test suites.

## Commit & Pull Request Guidelines
- Commits in history use short imperative subjects (e.g., `Add Blind SQL Injection vulnerability example`, `Update README.md`). Follow that style.
- PRs should describe the vulnerability demonstrated, include the new servlet/JSP paths, and list the exact endpoint(s) added.

## Security & Configuration Notes
- This application is intentionally vulnerable. Do not harden or “fix” vulnerabilities unless explicitly asked.
- Never deploy to production or a public server. Use Docker/VMs only.
- When adding new vulnerability examples, include educational text and attack examples in the JSP, and add navigation links in `src/main/webapp/header.jsp`.
