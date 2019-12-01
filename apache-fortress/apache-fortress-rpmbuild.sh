#!/bin/bash
cd rpmbuild/SOURCES
curl -Ol https://codeload.github.com/apache/directory-project/archive/tar.gz/master
mv master directory-project-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-core/archive/tar.gz/master
mv master directory-fortress-core-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-realm/archive/tar.gz/master
mv master directory-fortress-realm-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-commander/archive/tar.gz/master
mv master directory-fortress-commander-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-enmasse/archive/tar.gz/master
mv master directory-fortress-enmasse-master.zip
cd ../..
rpmbuild -bs fortress.spec
