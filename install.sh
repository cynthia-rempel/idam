#!/bin/bash -x
echo "installing apache-knox"

# TODO: add logic to not install java if it's there
# install java
rpm --import https://archive.cloudera.com/cm6/6.3.0/redhat7/yum/RPM-GPG-KEY-cloudera
curl -O https://archive.cloudera.com/cm6/6.3.1/redhat7/yum/cloudera-manager.repo
mv cloudera-manager.repo /etc/yum.repos.d/
# kick-back and drink some coffee/tea/etc. this will take a while
curl -O https://archive.cloudera.com/cm6/6.3.1/redhat7/yum/RPMS/x86_64/oracle-j2sdk1.8-1.8.0+update181-1.x86_64.rpm
yum -y localinstall oracle-j2sdk1.8-1.8.0+update181-1.x86_64.rpm

# add java to the PATH
# tested with
#   sudo su knox bash -c "java -version"
alternatives --install /usr/bin/java /usr/java/jdk1.8.0_181-cloudera/bin/java 1000


# import the gpg key
curl -O https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
rpm --import RPM-GPG-KEY-Jenkins

# download knox
# kick-back and drink some coffee/tea/etc. this will take a while
curl -O https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/knox/knox-1.3.0.7.0.3.0-79.noarch.rpm

# increase the probability knox can be updated
# and apparently handle some dependency issues
curl -O https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/cdh_public.repo
mv cdh_public.repo /etc/yum.repos.d/

# install knox
yum -y localinstall knox-1.3.0.7.0.3.0-79.noarch.rpm

# fix permissions
# tested permissions with: 
#   sudo su knox bash -c "/usr/lib/knox/bin/gateway.sh start 
chown -R knox:knox /usr/lib/knox

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





