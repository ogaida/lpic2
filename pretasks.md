---
title: Vorbereitung meiner Testumgebung
---

# {{ page.title }}

## ansible-inventory-file

```
[lpic]
centos ansible_host=127.0.0.1 ansible_port=2223
debian ansible_host=127.0.0.1 ansible_port=2224
suse ansible_host=127.0.0.1 ansible_port=2225
ubuntu ansible_host=127.0.0.1 ansible_port=2226
```

## ping test

```bash
WSL-001@~$ansible lpic -m ping
 [WARNING]: Platform linux on host debian is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.8/reference_appendices/interpreter_discovery.html for more information.

debian | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
centos | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
 [WARNING]: Platform linux on host suse is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.8/reference_appendices/interpreter_discovery.html for more information.

suse | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
ubuntu | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

Dann habe ich in der `ansible.cfg` den entsprechenden Wert gesetzt, der die Warnung ausblendet:

```bash
tail -1 /etc/ansible/ansible.cfg
interpreter_python = auto_silent
```

## Python-Versionen

Nun die Python-Versionen prüfen:

```bash
ansible lpic -a "python --version"
debian | CHANGED | rc=0 >>
Python 2.7.13

ubuntu | CHANGED | rc=0 >>
Python 2.7.15+

centos | CHANGED | rc=0 >>
Python 2.7.5

suse | CHANGED | rc=0 >>
Python 2.7.13
```

## Kurznamen der Distros

```
ansible lpic -b -m setup -a "filter=ansible_distribution_file_variety" | grep ansible_distribution_file_variety
        "ansible_distribution_file_variety": "Debian",
        "ansible_distribution_file_variety": "SUSE",
        "ansible_distribution_file_variety": "RedHat",
        "ansible_distribution_file_variety": "Debian",
```

## sinvolle Paketinstallationen

### locate / updatedb

- Apache2.4:

Die Paketnamen lauten für meine verwendeten Distributionen:

| Distribution         | Paketname |
| -------------------- | --------- |
| debian, ubuntu | locate   |
| centos,suse               | mlocate   |

```
ansible centos,suse -b -m package -a "name=mlocate"
ansible ubuntu,debian -b -m package -a "name=locate"
```

### curl

```
ansible lpic -b -m package -a "name=curl"
```

[HOME](./)
