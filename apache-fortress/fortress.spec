Name:           simplemaven
Version:        1.0
Release:        1%{?dist}
Summary:        Simple Maven project
License:        BSD
URL:            https://directory.apache.org/fortress/gen-docs/latest/apidocs/org/apache/directory/fortress/core/doc-files/ten-minute-guide.html
Source0:        https://git-wip-us.apache.org/repos/asf/directory-fortress-core.git
Source1:        https://git-wip-us.apache.org/repos/asf/directory-fortress-realm.git
Source2:        https://git-wip-us.apache.org/repos/asf/directory-fortress-commander.git
Source3:        https://git-wip-us.apache.org/repos/asf/directory-fortress-enmasse.git
BuildArch:      noarch

BuildRequires:  maven-local
BuildRequires:  git
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
# %setup -q

%build
git clone %{Source0}
git clone %{Source1}
git clone %{Source2}
git clone %{Source3}
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
