---
title: 208 http Dienste
---

# {{ page.title }}

## 208.1 Grundlegende Apache-Konfiguration


### wichtige Direktiven


- `MinSpareServers` Minimale Anzahl der unbeschäftigten Kindprozesse des Servers. siehe auch [https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers](https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers)

### Authentifizierung

##### Module `mod_auth_basic`

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

#### Module `mod_authz_host`

Ausführliche Beschreibung unter [https://httpd.apache.org/docs/2.4/mod/mod_authz_host.html](https://httpd.apache.org/docs/2.4/mod/mod_authz_host.html).

Die Direktiven des Modules können in `<Directory>`, `<Files>`, oder `<Location>` Sektionen oder in der `.htaccess`-Datei verwendet werden. Dabei wird der Zugriff über Hostnamen oder IP-Adressen gesteuert. Grundsätzlich sind alle Request-Methoden (GET, PUT, POST, etc) davon betroffen, es sei denn man übersteuert das Verhalten mit einer `<Limit>`-Sektion.

- __`Require ip`__

Die Einschränkung über IP-Adressen kann folgende Formen haben:

Vollständig:

```
Require ip 192.168.1.104 192.168.1.205
```

Partiale Angaben:

```
Require ip 10 172.20 192.168.2
```

Netzwerk/Netzmaske Pärchen:

```
Require ip 10.1.0.0/255.255.0.0
```

CIDR-Notation:

```
# private Adresse:
Require ip 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8
```

IPv6

```
Require ip 2001:db8::a00:20ff:fea7:ccea
Require ip 2001:db8:1:1::a
Require ip 2001:db8:2:1::/64
```

- __`Require host`__

Die angegebenen top-Level, second-Level etc. Domain-Namen müssen konkret übereinstimmen, Teilstrings der jeweiligen Level matchen nicht. Bei diesem Verfahren findet erst ein Reverse-DNS-Lookup und danach ein DNS-Lookup statt. Im folgenden Beispiel matched `123.example.org` aber nicht `1example.org`

```
Require host example.org
Require host .net example.edu
```

- __`Require forward-dns`__

Hier findet nur ein DNS-Lookup statt. Wenn die IP-Adresse des Clients mit der eines der DNS-Lookups übereinstimmt, ist die Require-Direktive bestätigt.

```
Require forward-dns bla.example.org
```

- __`Require local`__

bedient alle lokalen Anfragen, also immer verwenden, wenn auf dem Webserver lokale Anfragen durchgeführt werden.

__ACHTUNG:__ Anfragen die über einen Proxy reinkommen, müssen entweder dort kontrolliert werden, oder mit `mod_remoteip` behandelt werden. Das geht vermutlich über den LPIC2 Rahmen hinaus.

#### Anwendung

```
<Location />
  <RequireAny>
     AuthType Basic
     AuthName "Geheimer Bereich"
     AuthBasicProvider file
     AuthUserFile /data/pwfile
     Require user oliver.gaida
     # private Adresse brauchen sich nicht authentifizieren
     Require ip 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8
  </RequireAny>
</Location>
```

Bemerkung: Innerhalb der `RequireAny`-Sektion genügt es, wenn eine der angegebenen `Require`-Deriktive erfüllt ist, damit der Zugriff erlaubt wird.

Erzeugen des Passwortfiles:

```
$ sudo htpasswd -c /data/pwfile oliver.gaida
New password:
Re-type new password:
Adding password for user oliver.gaida
```
