#!/bin/bash -x
echo "installing apache-knox"

# TODO: add logic to not install java if it's there
# install java-1.8.0-openjdk
yum -y install java
# kick-back and drink some coffee/tea/etc. this will take a while

# import the gpg key
curl -O https://dist.apache.org/repos/dist/release/knox/KEYS
curl -O https://www.apache.org/dist/knox/1.3.0/knox-1.3.0.zip.asc

# download knox
curl -O http://apache.cs.utah.edu/knox/1.3.0/knox-1.3.0.zip
# kick-back and drink some coffee/tea/etc. this will take a while

gpg --import KEYS
gpg --verify knox-1.3.0.zip.asc

echo "installing apacheds"

# get and install the gpgkey
wget https://www.apache.org/dist/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm.asc
rpm --import apacheds-2.0.0.AM25-x86_64.rpm.asc

# download apacheds
wget https://apache.osuosl.org/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm

# install apacheds
yum -y localinstall apacheds-2.0.0.AM25-x86_64.rpm

# install phpldapadmin
# get the package installed
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-EPEL-7
wget https://download.fedoraproject.org/pub/epel/7/x86_64/Packages/p/phpldapadmin-1.2.3-10.el7.noarch.rpm
yum -y localinstall phpldapadmin-1.2.3-10.el7.noarch.rpm

wget https://github.com/leenooks/phpLDAPadmin/archive/1.2.5.tar.gz
tar -xf 1.2.5.tar.gz
# mv 1.2.5 to webroot, and change perms 
# change the port and ssl enable it /etc/httpd/conf.d/phpldapadmin.conf
# eventually take ideas from: https://www.surekhatech.com/blog/install-and-configure-phpldapadmin-web-client





