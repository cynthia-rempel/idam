Name:           directory-fortress
Version:        master
Release:        1%{?dist}
Summary:        A standards-based access management system, written in Java, supports ANSI INCITS 359 RBAC and more. 
License:        Apache License
URL:            https://directory.apache.org/fortress/gen-docs/latest/apidocs/org/apache/directory/fortress/core/doc-files/ten-minute-guide.html
Source0:        directory-project-master.tar.gz
Source1:        directory-fortress-core-master.tar.gz
Source2:        directory-fortress-realm-master.tar.gz
Source3:        directory-fortress-commander-master.tar.gz
Source4:        directory-fortress-enmasse-master.tar.gz
BuildArch:      noarch

BuildRequires:  maven-local
BuildRequires:  unzip
Requires:       apacheds
Requires:       openldap-clients
Requires:       tomcat
%description
This is simple Maven project.

%package        javadoc
Summary:        Javadoc for %{name}

%description javadoc
This package contains the API documentation for %{name}.

%prep
%setup

%build
rm -rf directory*
cd directory-fortress-core/
cp build.properties.example build.properties
%mvn_build -s
cd ..
cd directory-fortress-realm/
%mvn_build -s
cd ..
cd directory-fortress-commander/
cp ../directory-fortress-core/config/target/fortress.properties src/main/resources
%mvn_build -s
cd ..
cd directory-fortress-enmasse/
cp ../directory-fortress-core/config/target/fortress.properties src/main/resources
%mvn_build -s
cd ..
%install
%mvn_install

%files -f .mfiles
%dir %{_javadir}/%{name}
%files javadoc -f .mfiles-javadoc

%changelog
* Mon Oct 14 2013 Michal Srb <msrb@redhat.com> - 1.0-1
- Initial packaging
