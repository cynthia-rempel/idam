#!/bin/bash
cd rpmbuild/SOURCES
curl -Ol https://codeload.github.com/apache/directory-project/archive/zip/master
mv master directory-project-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-core/archive/zip/master
mv master directory-fortress-core-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-realm/archive/zip/master
mv master directory-fortress-realm-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-commander/archive/zip/master
mv master directory-fortress-commander-master.zip
curl -Ol https://codeload.github.com/apache/directory-fortress-enmasse/archive/zip/master
mv master directory-fortress-enmasse-master.zip
cd ../..
rpmbuild -bs fortress.spec
