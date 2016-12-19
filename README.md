# SpringSecurityLdapAuthenticationApp

LDAP authentication is one of the most popular authentication mechanism around the world for enterprise application and Active directory (an LDAP implementation by Microsoft for Windows) is another widely used LDAP server. In many projects we need to authenticate against active directory using LDAP by credentials provided in login screen. Some time this simple task gets tricky because of various issues faced during implementation and integration and no standard way of doing LDAP authentication. Java provides LDAP support but in this article I will mostly talk about spring security because its my preferred Java framework for authentication, authorization and security related stuff. you can do same thing in Java by writing your own program for doing LDAP search and than LDAP bind but as I said its much easier and cleaner when you use spring security for LDAP authentication.
Along with LDAP Support, Spring Security also provides several other feature which is required by enterprise java application including SSL Security, encryption of passwords and session timeout facilities.


This project contains both **Ldap authentication** and **spring embedded LDAP authentication**
  1. To enable LDAP authentication uncomment <import resource="SpringSecurityLdap-servlet.xml"/> in SpringSecuritybase-servlet.xml
  2. To enable embedded LDAP authentication uncomment <import resource="SpringSecurityEmbedded-servlet-servlet.xml"/> in SpringSecuritybase-servlet.xml.For embedded LDAP there is sample ldif file which is at resources directory,you can modify users based on your requirment.


##### Build and Deploy :

mvn clean install

copy SpringSecurityLdapAuthenticationApp.war file to Tomcat/webapps directory.
