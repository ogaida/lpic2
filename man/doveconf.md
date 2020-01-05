### NAME
doveconf - Dovecot's configuration dumping utility

### SYNOPSIS
       doveconf [-adnNSx] [-c config-file] [-f filter] [-m module]
       doveconf [-n] [-c config-file] section_name ...
       doveconf [-h] [-c config-file] [-f filter] setting_name ...

### DESCRIPTION
doveconf  reads  and  parses Dovecot's configuration files and converts
them into a simpler format used by the rest of Dovecot. All  standalone
programs,  such  as dovecot(1) and dovecot-lda(1), will first get their
settings by executing doveconf.

For system administrators, doveconf is mainly useful  for  dumping  the
configuration in easy human readable output.

### OPTIONS
       -a     Show all settings with their currently configured values.

       -c config-file
              read  configuration  from  the  given  config-file.   By default
              /etc/dovecot/dovecot.conf will be used.

       -d     Show the setting's default value instead of  the  one  currently
              configured.

       -f filter
              Show  the matching configuration for the specified filter condi‐
              tion.  The filter option string has to be  given  as  name=value
              pair.   For multiple filter conditions the -f option can be sup‐
              plied multiple times.
              Possible names for the filter are:

              lname  The local hostname,  e.g.  mail.example.com.   This  will
                     only match hostnames which were configured like:
                     local_name mail.example.com { # special settings }

              local  The  server's  hostname  or  IP  address.  This will also
                     match hostnames which were configured like:
                     local imap.example.net { # special settings }

              protocol, service
                     The protocol, e.g. imap or pop3

              remote The client's hostname or IP address.

       -h     Hide the setting's name, show only the setting's value.

       -m module
              Show only settings for the given module.
              e.g.  imap, imap-login, lmtp, pop3 or pop3-login

       -n     Show only settings with non-default values.

       -N     Show settings with non-default values and explicitly set default
              values.

       -S     Dump settings in simplified machine parsable/readable format.

       -x     Expand  configuration variables (e.g. $mail_plugins ⇒ quota) and
              show file contents (from e.g. ssl_cert  =  </etc/ssl/certs/dove‐
              cot.pem).

       section_name
              Show  only  the  current  configuration of one or more specified
              sections.

       setting_name
              Show only the setting of one or more  setting_name(s)  with  the
              currently configured value. You can show a setting inside a sec‐
              tion using '/' as the section separator, e.g.  service/imap/exe‐
              cutable.

### EXAMPLE
       When  Dovecot  was  configured  to use different settings for some net‐
       works/subnets it is possible to show which settings will be applied for
       a specific connection.

       doveconf -f local=10.0.0.110 -f remote=10.11.1.2 -f service=pop3 -n

       doveconf can be also used to convert v1.x configuration files into v2.x
       format.

       doveconf -n -c /oldpath/dovecot.conf > /etc/dovecot/dovecot.conf.new

       This example shows how to ask doveconf for a global setting and a  pro‐
       tocol specific setting.  The second command uses also the -h option, in
       order to hide the setting's name.

       doveconf mail_plugins
       mail_plugins = quota
       doveconf  -h -f protocol=imap mail_plugins
       quota imap_quota

       This example demonstrates how to dump a whole configuration section.

       doveconf dict
       dict {
         quota = pgsql:/etc/dovecot/dovecot-dict-sql.conf.ext
       }

       Or how to dump only the quota dict:

       doveconf dict/quota
       dict/quota = pgsql:/etc/dovecot/dovecot-dict-sql.conf.ext

### REPORTING BUGS
Report bugs, including doveconf -n output, to the Dovecot Mailing  List
<dovecot@dovecot.org>.   Information  about reporting bugs is available
at: http://dovecot.org/bugreport.html

### SEE ALSO
doveadm(1), dovecot(1), dovecot-lda(1), dsync(1)

