---
title: 208 http Dienste
---

# {{ page.title }}

## 208.1 Grundlegende Apache-Konfiguration

### Vorbereitende Installationen

- Apache2.4:

Die Paketnamen lauten für mein Distributionen:

| Distribution   | Paketname |
| -------------- | --------- |
| suse           | apache2   |
| debian, ubuntu | apache2   |
| centos         | httpd     |

Playbook `playbooks/install_apache2.yml`:

```yml
---
- name: Install Apache
  hosts:
    - lpic
  vars:
    apache2:
    - suse
    - debian
    - ubuntu
  become: yes
  gather_facts: no
  tasks:
  - name: install apache2
    package:
      name: apache2
    when: inventory_hostname != "centos"
  - name: start apache2
    service:
      name: apache2
      state: started
      enabled: yes
    when: inventory_hostname != "centos"
  - name: install apache2
    package:
      name: httpd
    when: inventory_hostname == "centos"
  - name: start apache2
    service:
      name: httpd
      state: started
      enabled: yes
    when: inventory_hostname == "centos"
```

Installation

```
ansible-playbook playbooks/install_apache2.yml
```

Kontrolle mit `systemctl`:

```
ansible lpic -b -a 'systemctl -a' | grep -P '>>|http|apache'
debian | CHANGED | rc=0 >>
  apache2.service                                                                          loaded    active   running   The Apache HTTP Server
ubuntu | CHANGED | rc=0 >>
  apache2.service                                                                           loaded    active   running   The Apache HTTP Server
centos | CHANGED | rc=0 >>
  httpd.service                                                                                                  loaded    active   running   The Apache HTTP Server
suse | CHANGED | rc=0 >>
  apache2.service                                                                          loaded    active   running   The Apache Webserver
  apache2.target                                                                           loaded    inactive dead      Apache target allowing to control multi setup
```

Prozesse anschauen:

```
ansible lpic -b -a 'ps -ef' | grep -P '>>|http|apache'
debian | CHANGED | rc=0 >>
root     16499     1  0 10:50 ?        00:00:00 /usr/sbin/apache2 -k start
www-data 16501 16499  0 10:50 ?        00:00:06 /usr/sbin/apache2 -k start
www-data 16502 16499  0 10:50 ?        00:00:06 /usr/sbin/apache2 -k start
ubuntu | CHANGED | rc=0 >>
root      2437     1  0 02:50 ?        00:00:00 /usr/sbin/apache2 -k start
www-data  2439  2437  0 02:50 ?        00:00:00 /usr/sbin/apache2 -k start
www-data  2440  2437  0 02:50 ?        00:00:00 /usr/sbin/apache2 -k start
centos | CHANGED | rc=0 >>
root      3236     1  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache    3237  3236  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache    3238  3236  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache    3239  3236  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache    3240  3236  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache    3241  3236  0 14:38 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
suse | CHANGED | rc=0 >>
root      7299     1  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
wwwrun    7306  7299  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
wwwrun    7307  7299  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
wwwrun    7308  7299  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
wwwrun    7309  7299  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
wwwrun    7310  7299  0 14:38 ?        00:00:00 /usr/sbin/httpd-prefork -DSYSCONFIG -C PidFile /var/run/httpd.pid -C Include /etc/apache2/sysconfig.d//loadmodule.conf -C Include /etc/apache2/sysconfig.d//global.conf -f /etc/apache2/httpd.conf -c Include /etc/apache2/sysconfig.d//include.conf -DSYSTEMD -DFOREGROUND -k start
```

### 208.1.1 wichtige Direktiven

- `MinSpareServers` Minimale Anzahl der unbeschäftigten Kindprozesse des Servers. siehe auch [https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers](https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers)

### 208.1.2 Authentifizierung

#### Modul `mod_auth_basic`

Hier wird über die Direktive [AuthUserFile](https://httpd.apache.org/docs/2.4/mod/mod_authn_file.html#authuserfile) die Datei mit den verschlüsselten Passwörtern verlinkt.
Diese Datei wird mit dem Befehl `htpasswd` erzeugt.

wichtige `htpasswd`-Parameter sind (siehe auch [https://cht.sh/htpasswd](https://cht.sh/htpasswd))

- Create/overwrite htpasswd file:

`htpasswd -c path/to/file user_name`

- Add user to htpasswd file or update existing user:

`htpasswd path/to/file user_name`

- Add user to htpasswd file in batch mode without an interactive password prompt (for script usage):

`htpasswd -b path/to/file user_name password`

- Delete user from htpasswd file:

`htpasswd -D path/to/file user_name`

- Verify user password:

`htpasswd -v path/to/file user_name`

#### Modul `mod_authz_host`

Ausführliche Beschreibung unter [https://httpd.apache.org/docs/2.4/mod/mod_authz_host.html](https://httpd.apache.org/docs/2.4/mod/mod_authz_host.html).

Die Direktiven des Modules können in `<Directory>`, `<Files>`, oder `<Location>` Sektionen oder in der `.htaccess`-Datei verwendet werden. Dabei wird der Zugriff über Hostnamen oder IP-Adressen gesteuert. Grundsätzlich sind alle Request-Methoden (GET, PUT, POST, etc) davon betroffen, es sei denn man übersteuert das Verhalten mit einer `<Limit>`-Sektion.

- __`Require ip`__

Die Einschränkung über IP-Adressen kann folgende Formen haben:

Vollständig:

```apache
Require ip 192.168.1.104 192.168.1.205
```

Partiale Angaben:

```apache
Require ip 10 172.20 192.168.2
```

Netzwerk/Netzmaske Pärchen:

```apache
Require ip 10.1.0.0/255.255.0.0
```

CIDR-Notation:

```apache
# private Adresse:
Require ip 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8
```

IPv6

```apache
Require ip 2001:db8::a00:20ff:fea7:ccea
Require ip 2001:db8:1:1::a
Require ip 2001:db8:2:1::/64
```

- __`Require host`__

Die angegebenen top-Level, second-Level etc. Domain-Namen müssen konkret übereinstimmen, Teilstrings der jeweiligen Level matchen nicht. Bei diesem Verfahren findet erst ein Reverse-DNS-Lookup und danach ein DNS-Lookup statt. Im folgenden Beispiel matched `123.example.org` aber nicht `1example.org`

```apache
Require host example.org
Require host .net example.edu
```

- __`Require forward-dns`__

Hier findet nur ein DNS-Lookup statt. Wenn die IP-Adresse des Clients mit der eines der DNS-Lookups übereinstimmt, ist die Require-Direktive bestätigt.

```apache
Require forward-dns bla.example.org
```

- __`Require local`__

bedient alle lokalen Anfragen, also immer verwenden, wenn auf dem Webserver lokale Anfragen durchgeführt werden.

__ACHTUNG:__ Anfragen die über einen Proxy reinkommen, müssen entweder dort kontrolliert werden, oder mit `mod_remoteip` behandelt werden. Das geht vermutlich über den LPIC2 Rahmen hinaus.

#### Modul `mod_authz_groupfile`

mit hilfe dieses Modules kann man eine weitere Textdatei über die Direktive `AuthGroupFile <path>` einbinden, in der man User zu Gruppen zuordnet:

```
grp1: user1 user2
grp2: user3 user4
```

um dann später nur bestimmte Gruppe zuzulassen verwendet man die Direktive `Require group <groupname1> [<groupname2> ...]`

```apache
AuthGroupFile /data/groups
Require group grp1 grp2
```

#### `.htaccess` Datei verwenden

die Authorisierungsderiktiven können auch über eine `.htacces` Datei im DocumentRoot des vhosts oder eines seiner Unterverzeichnisse verwaltet werden. Das muss jedoch über
die Apache-Konfiguration in einer `Directory`-Sektion erlaubt werden. Zum Beispiel mit:

```apache
<Directory /data/www/my.domain.tdl/html/>
  AllowOverride AuthConfig # oder mit dem stärkeren `AllowOverride All`
</Directory>
```

#### Anwendung

```apache
<Location />
  <RequireAny>
     AuthType Basic
     AuthName "Geheimer Bereich"
     AuthBasicProvider file
     AuthUserFile /data/pwfile
     Require user oliver.gaida # alternativ auch: Require group grp1 ... oder Require valid-user
     # private Adresse brauchen sich nicht authentifizieren
     Require ip 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8
  </RequireAny>
</Location>
```

Bemerkung: Innerhalb der `RequireAny`-Sektion genügt es, wenn eine der angegebenen `Require`-Direktiven erfüllt ist, damit der Zugriff erlaubt wird.

Erzeugen des Passwortfiles :

```bash
$ sudo htpasswd -c /data/pwfile oliver.gaida
New password:
Re-type new password:
Adding password for user oliver.gaida
```

[HOME](./)
