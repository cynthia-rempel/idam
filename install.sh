#!/bin/bash -x
# TODO: deconflict the listening ports for ssl-based services
# using:
# lsof -i
# knox listens on 8443
# apacheds listens on 10389
# apacheds listens on 10636
# keycloak listens on 9080
# keycloak listens on 10990
# keycloak listens on 9443
# apache/phpldapadmin listens on 80
# curl -v http://127.0.0.1/phpldapadmin/index.php

echo "installing apache-knox to serve as a reverse-proxy to enable multiple servers to show up on the same port"
./apache-knox/apache-knox-install.sh

# TODO: add logic to not install java if it's there
# leaving this here because other apps depend on java and unzip
# install java-1.8.0-openjdk
yum -y install java-1.8.0-openjdk
# kick-back and drink some coffee/tea/etc. this will take a while

# install unzip, as many packages installed come as zip's
yum -y install unzip

echo "installing apacheds"

# get and install the gpgkey
curl -O https://www.apache.org/dist/directory/KEYS
curl -O https://www.apache.org/dist/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm.asc

# download apacheds
curl -O https://apache.osuosl.org/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm

gpg --import KEYS
# gpg --edit-keys elecharny trust
# select a number, then yes
gpg --verify apacheds-2.0.0.AM25-x86_64.rpm.asc apacheds-2.0.0.AM25-x86_64.rpm

# install apacheds
yum -y localinstall apacheds-2.0.0.AM25-x86_64.rpm

# install keycloak
curl -O https://downloads.jboss.org/keycloak/8.0.0/keycloak-8.0.0.zip
unzip keycloak-8.0.0.zip -d /usr/local
mv /usr/local/keycloak-8.0.0 /usr/local/keycloak
useradd keycloak -r -d /usr/local/keycloak
chown -R keycloak:keycloak /usr/local/keycloak

./apache-fortress/apache-fortress-install.sh

# install phpldapadmin
# get the package installed
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-EPEL-7
yum -y install phpldapadmin

# wget https://github.com/leenooks/phpLDAPadmin/archive/1.2.5.tar.gz
# tar -xf 1.2.5.tar.gz
# mv 1.2.5 to webroot, and change perms 
# change the port and ssl enable it /etc/httpd/conf.d/phpldapadmin.conf
# eventually take ideas from: https://www.surekhatech.com/blog/install-and-configure-phpldapadmin-web-client

# Create a self-signed cert
# Shamelessly lifted from: https://unix.stackexchange.com/questions/104171/create-ssl-certificate-non-interactively
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout www.example.com.key  -out www.example.com.cert

