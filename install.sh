#!/bin/bash -x
# TODO: deconflict the listening ports for ssl-based services

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
# TODO: determine if it's an issue: lmccay isn't trusted with the keys file.
# Is trusting him something that can be automated, or should it be reported to knox?
# Currently, an interactive way is to run
#  gpg --edit-key lmccay
#  > trust
#  5 
# not even sure if that's the right trust level
gpg --verify knox-1.3.0.zip.asc

unzip knox-1.3.0.zip /usr/local

# clean up directory
rm KEYS knox-1.3.0.zip knox-1.3.0.zip.asc 

mv /usr/local/knox-1.3.0 /usr/local/knox

# create a knox user, make it a service account (to match the rpm-based install)
useradd -r knox -d /usr/local/knox
chown -R knox:knox /usr/local/knox

# put the logs in the var partition, and make knox own them
rm -rf /usr/local/knox/logs
mkdir -p /var/log/knox
ln -s /var/log/knox /usr/local/knox/logs
chown -R knox:knox /usr/local/knox/logs /var/log/knox

# pid's are small, so put off moving them 'til later...

# TODO: figure out what the heck this is...
# got it from looking at /usr/local/knox/logs/gateway.log
# verify the install with:
# su knox bash -c "/usr/local/knox/bin/knoxcli.sh create-master --master mastersecret"

# /usr/local/knox/bin/gateway.sh start succeeded, so moving to the next thing...

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

