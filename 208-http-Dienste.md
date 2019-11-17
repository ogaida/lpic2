---
title: 208 http Dienste
---

# {{ page.title }}

## 208.1 Grundlegende Apache-Konfiguration


### wichtige Direktiven


- `MinSpareServers` Minimale Anzahl der unbeschäftigten Kindprozesse des Servers. siehe auch [https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers](https://httpd.apache.org/docs/2.4/mod/prefork.html#minspareservers)

### Authentifizierung

##### htpaaswd-Parameter:

- Create/overwrite htpasswd file:

`htpasswd -c {{path/to/file}} {{user_name}}`

- Add user to htpasswd file or update existing user:

`htpasswd {{path/to/file}} {{user_name}}`

- Add user to htpasswd file in batch mode without an interactive password prompt (for script usage):

`htpasswd -b {{path/to/file}} {{user_name}} {{password}}`

- Delete user from htpasswd file:

`htpasswd -D {{path/to/file}} {{user_name}}`

- Verify user password:

`htpasswd -v {{path/to/file}} {{user_name}}`


```

```
