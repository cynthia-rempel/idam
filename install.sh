#!/bin/bash -x
echo "installing apache-knox"

# import the gpg key
wget https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
rpm --import RPM-GPG-KEY-Jenkins

# download knox
wget https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/knox/knox-1.3.0.7.0.3.0-79.noarch.rpm

# increase the probability knox can be updated
wget https://archive.cloudera.com/cdh7/7.0.3.0/redhat7/yum/cdh_public.repo
mv cdh_public.repo /etc/yum.repos.d/

# install knox
yum -y localinstall knox-1.3.0.7.0.3.0-79.noarch.rpm

echo "installing apacheds"

# get and install the gpgkey
wget https://www.apache.org/dist/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm.asc
rpm --import apacheds-2.0.0.AM25-x86_64.rpm.asc

# download apacheds
wget https://apache.osuosl.org/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm

# install apacheds
yum -y localinstall apacheds-2.0.0.AM25-x86_64.rpm

# install phpldapadmin
wget https://github.com/leenooks/phpLDAPadmin/archive/1.2.5.tar.gz

# eventually take ideas from: https://www.surekhatech.com/blog/install-and-configure-phpldapadmin-web-client





