#!/bin/bash
cd rpmbuild/SOURCES
wget https://github.com/apache/directory-project/archive/44.zip
wget http://apache.osuosl.org//directory/fortress/dist/2.0.3/fortress-core-2.0.3-source-release.zip
wget http://apache.osuosl.org//directory/fortress/dist/2.0.3/fortress-realm-2.0.3-source-release.zip
wget http://apache.osuosl.org//directory/fortress/dist/2.0.3/fortress-rest-2.0.3-source-release.zip
wget http://apache.osuosl.org//directory/fortress/dist/2.0.3/fortress-web-2.0.3-source-release.zip
wget https://github.com/apache/directory-fortress-enmasse/archive/2.0.3.zip
cd ../..
rpmbuild -bs fortress.spec
