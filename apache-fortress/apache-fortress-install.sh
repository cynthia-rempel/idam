#!/bin/bash -x

# install fortress
# install tomcat
yum -y install tomcat

# download the stuff
wget https://apache.osuosl.org/directory/fortress/dist/2.0.3/fortress-core-2.0.3.jar
wget https://apache.osuosl.org/directory/fortress/dist/2.0.3/fortress-realm-impl-2.0.3.jar
wget https://apache.osuosl.org/directory/fortress/dist/2.0.3/fortress-realm-proxy-2.0.3.jar
wget https://apache.osuosl.org/directory/fortress/dist/2.0.3/fortress-rest-2.0.3.war
wget https://apache.osuosl.org/directory/fortress/dist/2.0.3/fortress-web-2.0.3.war

# fortress realm and tomcat
# https://github.com/apache/directory-fortress-core/blob/master/README-QUICKSTART-APACHEDS.md 
# Step 5

# put the jars where they go
mv fortress-realm-proxy-2.0.3.jar /usr/share/tomcat/lib/
mv fortress-web-2.0.3.war /usr/share/tomcat/webapps/
mv fortress-rest-2.0.3.war /usr/share/tomcat/webapps/

# Step 6
# patch /etc/tomcat/tomcat-users.xml
# with
# 
# <role rolename="manager-script"/>
# <role rolename="manager-gui"/>
# <user username="tcmanager" password="m@nager123" roles="manager-script"/>
# <user username="tcmanagergui" password="m@nager123" roles="manager-gui"/>
