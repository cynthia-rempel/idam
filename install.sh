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


