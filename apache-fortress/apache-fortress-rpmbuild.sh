#!/bin/bash
cd rpmbuild/SOURCES
curl -Ol https://codeload.github.com/apache/directory-project/tar.gz/master
mv master directory-project-master.tar.gz
curl -Ol https://codeload.github.com/apache/directory-fortress-core/tar.gz/master
mv master directory-fortress-core-master.tar.gz
curl -Ol https://codeload.github.com/apache/directory-fortress-realm/tar.gz/master
mv master directory-fortress-realm-master.tar.gz
curl -Ol https://codeload.github.com/apache/directory-fortress-commander/tar.gz/master
mv master directory-fortress-commander-master.tar.gz
curl -Ol https://codeload.github.com/apache/directory-fortress-enmasse/tar.gz/master
mv master directory-fortress-enmasse-master.tar.gz
cd ../..
rpmbuild -bs fortress.spec
