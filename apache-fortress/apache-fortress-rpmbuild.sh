#!/bin/bash
cd rpmbuild/SOURCES
wget https://github.com/apache/directory-project/archive/master.zip
mv master.zip directory-project-master.zip
wget https://github.com/apache/directory-fortress-core/archive/master.zip
mv master.zip directory-fortress-core-master.zip
wget https://github.com/apache/directory-fortress-realm/archive/master.zip
mv master.zip directory-fortress-realm-master.zip
wget https://github.com/apache/directory-fortress-commander/archive/master.zip
mv master.zip directory-fortress-commander-master.zip
wget https://github.com/apache/directory-fortress-enmasse/archive/master.zip
mv master.zip directory-fortress-enmasse-master.zip
cd ../..
rpmbuild -bs fortress.spec
