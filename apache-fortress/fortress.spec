Name:           directory-fortress
Version:        master
Release:        1%{?dist}
Summary:        A standards-based access management system, written in Java, supports ANSI INCITS 359 RBAC and more. 
License:        Apache License
URL:            https://directory.apache.org/fortress/gen-docs/latest/apidocs/org/apache/directory/fortress/core/doc-files/ten-minute-guide.html
Source0:        directory-fortress-core-master.tar.gz
Source1:        directory-fortress-realm-master.tar.gz
Source2:        directory-fortress-commander-master.tar.gz
Source3:        directory-fortress-enmasse-master.tar.gz
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
%setup -n directory-fortress-core-master -b 0
%setup -n directory-fortress-realm-master -b 1
%setup -n directory-fortress-commander-master -b 2
%setup -n directory-fortress-enmasse-master -b 3
cd ..
%build
cd ..
cd directory-fortress-core-master/
cp build.properties.example build.properties
%mvn_build -s
cd ..
cd directory-fortress-realm-master/
%mvn_build -s
cd ..
cd directory-fortress-commander-master/
cp ../directory-fortress-core-master/config/bootstrap/fortress.properties src/main/resources
%mvn_build -s
cd ..
cd directory-fortress-enmasse-master/
cp ../directory-fortress-core-master/config/bootstrap/fortress.properties src/main/resources
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
