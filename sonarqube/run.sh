#!/bin/sh

set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

#chown -R sonarqube:sonarqube $SONARQUBE_HOME
exec
  java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  -Dsonar.security.realm="$SONARQUBE_SECURITY_REALM" \
  -Dsonar.security.savePassword="$SONARQUBE_SECURITY_SAVEPASSWORD" \
  -Dldap.bindDn="$SONARQUBE_LDAP_BINDDN" \
  -Dldap.bindPassword="$SONARQUBE_LDAP_BINDPASSWORD" \
  -Dldap.url="$SONARQUBE_LDAP_URL" \
  -Dldap.user.baseDn="$SONARQUBE_LDAP_USER_BASEDN" \
  -Dldap.user.request="$SONARQUBE_LDAP_USER_REQUEST" \
  -Dldap.user.realNameAttribute="$SONARQUBE_LDAP_USER_REALNAMEATTRIBUTE" \
  -Dldap.group.baseDn="$SONARQUBE_LDAP_GROUP_BASEDN" \
  -Dldap.group.request="$SONARQUBE_LDAP_GROUP_REQUEST" \
  -Dldap.group.idAttribute="$SONARQUBE_LDAP_GROUP_IDATTRIBUTE" \
  -Dsonar.ce.javaOpts="$SONARQUBE_CE_JVM_OPTS" \
  -Dsonar.web.javaOpts="$SONARQUBE_WEB_JVM_OPTS" \
  -Dsonar.web.javaAdditionalOpts="-Djava.security.egd=file:/dev/./urandom" \
  "$@"