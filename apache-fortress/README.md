# Installing and Configuring Fortress

Eventually, how to install and configure fortress

## Try building an RPM

As I'd prefer to install packaged software (over building it), I decided I'd push myself to work on learning the process to package a java application.

What I learned so far is:

1. You have to download the sources before making a source RPM
2. pwd in a spec file is your friend
3. mock/xmvn-builddep might generate BuildRequires

[Using mock to get BuildRequires](https://blog.packagecloud.io/eng/2015/05/11/building-rpm-packages-with-mock/)

**Create a backup .spec and make Temporary Changes to get a build.log for xmv-builddep**
1. fortress.spec -> BuildRequires: maven
2. fortress.spec -> %mvn_build -> mvn install
mvn compiler:compile -Dmaven.artifact.threads=30
```
mock epel-7-x86_64 --init
mock -r epel-7-x86_64 rebuild package-1.1-1.src.rpm
```
**Be sure to change back once the log is generated**
### References:

http://xuctarine.blogspot.com/2015/10/how-to-install-apache-fortress-with.html
