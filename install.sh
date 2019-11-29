#!/bin/bash -x
echo "installing apache-knox to serve as a reverse-proxy to enable multiple servers to show up on the same port"

# TODO: add logic to not install java if it's there
# install java-1.8.0-openjdk
yum -y install java-1.8.0-openjdk
# kick-back and drink some coffee/tea/etc. this will take a while

# install unzip, as many packages installed come as zip's
yum -y install unzip


# import the gpg key
curl -O https://dist.apache.org/repos/dist/release/knox/KEYS
curl -O https://www.apache.org/dist/knox/1.3.0/knox-1.3.0.zip.asc

# download knox
curl -O http://apache.cs.utah.edu/knox/1.3.0/knox-1.3.0.zip
# kick-back and drink some coffee/tea/etc. this will take a while

# make sure the gpg is used during the run, by making sure gpg is initialized, then the shell is exited
su `whoami` bash -c "gpg --import KEYS"
gpg --import KEYS
gpg --verify knox-1.3.0.zip.asc

unzip knox-1.3.0.zip /usr/local
mv /usr/local/knox-1.3.0 /usr/local/knox

# TODO: figure out what the heck this is...
# got it from looking at /usr/local/knox/logs/gateway.log
/usr/local/knox/bin/knoxcli.sh create-master --master mastersecret

# /usr/local/knox/bin/gateway.sh start succeeded, so moving to the next thing...

echo "installing apacheds"

# get and install the gpgkey
curl -O https://www.apache.org/dist/directory/KEYS
curl -O https://www.apache.org/dist/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm.asc

# download apacheds
curl -O https://apache.osuosl.org/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm

gpg --import KEYS
gpg --verify apacheds-2.0.0.AM25-x86_64.rpm.asc apacheds-2.0.0.AM25-x86_64.rpm

# install apacheds
yum -y localinstall apacheds-2.0.0.AM25-x86_64.rpm

# install keycloak
curl -O https://downloads.jboss.org/keycloak/8.0.0/keycloak-8.0.0.zip
unzip keycloak-8.0.0.zip -d /usr/local
mv /usr/local/keycloak-8.0.0 /usr/local/keycloak
useradd keycloak
chown -R keycloak:keycloak /usr/local/keycloak

# install phpldapadmin
# get the package installed
# yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-EPEL-7
# wget https://download.fedoraproject.org/pub/epel/7/x86_64/Packages/p/phpldapadmin-1.2.3-10.el7.noarch.rpm
# yum -y localinstall phpldapadmin-1.2.3-10.el7.noarch.rpm

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

