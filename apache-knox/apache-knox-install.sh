#!/bin/bash -x

echo "Installing Apache-Knox!"

# TODO: add logic to not install java if it's there
# TODO: determine if this is the right version of java

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
su knox bash -c "/usr/local/knox/bin/knoxcli.sh create-master --master mastersecret"

# TODO: script a test to verify installation
# /usr/local/knox/bin/gateway.sh start succeeded, so moving to the next thing...

# TODO: script installation of service file
