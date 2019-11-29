# idam
Ideas for creating an idam appliance, of course, 
the right answer is probably the Univention Corporate Server or FreeIPA, 
but I want to have fun mixing and matching

## Reverse Proxies

0. Docker, but everyone does that!

1. Nginx

2. Apache HTTPD

3. Apache Knox (what is this new thing?)

## Directory + Kerberos Servers

Endless possibilities... note: this project doesn't install all of this, more of a tracker for what did (and didn't hold my attention)

Starting from the top

### ApacheDS

I like this because I like Apache... I'm struggling with identifying which web-apps will be useful for configuring it...

Install options:

0. Install from RPM
1. Install from zip
2. Install from source (I'm curious how far I can get without building it though :)

### 389 Directory Server

It has a nice GUI, and it's redhat, so that's cool...

### OpenLDAP

It's really popular, and very specialiazed

### FreeIPA

Like UCS it is the kitchen sink of everything :)

## LDAP web clients

PHPLDAPAdmin

Web2LDAP ?

DSGW https://directory.fedoraproject.org/docs/389ds/administration/dsgw.html ? (389 GUI)

Apache Fortress ?

Directory Studio + VNC/noNVC ?

## Tabled ideas

Ideas that are probably good, but I'm struck by something else...

Cloudera has a supported version of apache knox, and great documentation, 
but I think it needed dependencies that I didn't install
