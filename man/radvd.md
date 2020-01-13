### NAME
radvd - router advertisement daemon for IPv6

### SYNOPSIS
           radvd [ -hsvc ] [ -d debuglevel ] [ -C configfile ] [ -p pidfile ] [ -m
           logmethod ] [ -l logfile ] [ -f facility ] [ -t chrootdir ] [ -u  user‐
           name ]

### DESCRIPTION
radvd is the router advertisement daemon for IPv6. It listens to router
solicitations and sends router advertisements as described in "Neighbor
Discovery  for  IP Version 6 (IPv6)" (RFC 4861).  With these advertise‐
ments hosts can automatically configure their addresses and some  other
parameters.  It  also defines "Neighbor Discovery Optimization for IPv6
over Low-Power Wireless Personal Area Networks  (6LoWPANs)"  (RFC6775).
They also can choose a default router based on these advertisements.

The  configuration file must not be writable by others, and if non-root
operation is requested, not even by self/own group.

### OPTIONS
           For every one character option there is also a long  option,  which  is
           listed right next to the "short" option name:
    
           -v, --version
                  Displays the version of radvd and then aborts.
    
           -h, --help
                  Displays a short usage description and then aborts.
    
           -c, --configtest
                  Test configuration and do startup tests and then exit.
    
           -d debuglevel, --debug debuglevel
                  With  this  option you turn on debugging information. The debug‐
                  ging level is an integer in the range from 1 to 5,  from   quiet
                  to  very  verbose.  A  debugging level of 0 completely turns off
                  debugging. If a debugging level greater than 0  is  used,  radvd
                  doesn't  background itself on start. The default debugging level
                  is 0.
    
           -C configfile, --config configfile
                  Specifies an alternate config file.  Normally  the  compiled  in
                  default /etc/radvd.conf is used.
    
           -p pidfile, --pidfile pidfile
                  Specifies an alternate pidfile. Normally the compiled in default
                  /var/run/radvd.pid is used.
    
           -m method, --logmethod method
                  Specifies the logging method to use. Possibly values are:
    
                  none   Completely disables any logging.
    
                  logfile
                         Logs to the logfile which is specified by the -l  option.
                         If  no  logfile  is specified on the command line, then a
                         compiled in default is used (see next option).
    
                  stderr Logs to standard error.
    
                  stderr_syslog
                         Logs only the high messages (of at least  LOG_ERR  prior‐
                         ity) to standard error, and everything to syslog (default
                         method).
    
                  syslog Logs to syslog.
    
           -l logfile, --logfile logfile
                  Specifies the logfile to use when using the logging method  log‐
                  file.  The default logfile is /var/log/radvd.log.
    
           -f facility, --facility facility
                  Specifies  the  facility  (as an integer) when using syslog log‐
                  ging. Default is LOG_DAEMON.
    
           -t chrootdir, --chrootdir chrootdir
                  If specified, switches to chrootdir before doing anything  else.
                  This  directory  and its subdirectories must have been populated
                  first.  For security reasons, -u must always be used when  using
                  chrootdir.
    
                  Note  that  on Linux radvd requires access to the /proc filesys‐
                  tem, so it is more challenging to set up the chroot environment.
    
           -u username, --username username
                  If specified, drops root privileges and changes user ID to user‐
                  name  and  group  ID  to the primary group of username.  This is
                  recommended for security reasons.  You might also need to use -p
                  to  point  to  a  file  in  a username -writable directory (e.g.
                  /var/run/radvd/radvd.pid).

### FILES
/usr/sbin/radvd
/etc/radvd.conf
/var/run/radvd.pid
/var/log/radvd.log

### BUGS
           There certainly are some bugs. If you find them or have  other  sugges‐
           tions please contact Reuben Hawkins <reubenhwk@gmail.com>.

### SEE ALSO
radvd.conf(5), radvdump(8)

### AUTHORS
           Pedro Roque    <roque@di.fc.ul.pt> - wrote first version for Linux
           Lars Fenneberg <lf@elemental.net>  - previous maintainer
           Nathan Lutchansky   <lutchann@litech.org>    - previous maintainer
           Pekka Savola   <pekkas@netcore.fi>     - previous maintainer
           Craig Metz     <cmetz@inner.net>   - port to NRL's IPv6 code for BSD4.4
           Marko Myllynen <myllynen@lut.fi>   - RFC 2461 update, Mobile IPv6 support
           Jim Paris <jim@jtan.com>      - Privilege separation support
           Reuben Hawkins  <reubenhwk@gmail.com>   - current maintainer
           Pierre Ossman   <pierre@ossman.eu>      - RFC6106 (DNSSL) support
           Varka Bhadram  <varkabhadram@gmail.com> - 6LoWPAN-ND (RFC6775) support
           Robin H. Johnson    <robbat2@gentoo.org>     - RA splitting per RFC 6980 & RFC4861#6.2.3
    
    radvd 2.16                        14 Dec 2010                         RADVD(8)

