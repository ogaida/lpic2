### NAME
squid - HTTP web proxy caching server

### SYNOPSIS
       squid [-dhisrvzCFNRSVYX] [-l facility ] [-f config-file ] [-[au] port ]
       [-k signal ] [-n service-name ] [-O command-line ]

### DESCRIPTION
squid is a high-performance proxy caching server for web clients,  sup‐
porting  FTP,  gopher,  ICAP,  ICP, HTCP and HTTP data objects.  Unlike
traditional caching software, Squid handles all requests in  a  single,
non-blocking process.

Squid  keeps meta data and especially hot objects cached in RAM, caches
DNS lookups, supports non-blocking DNS lookups, and implements negative
caching of failed requests.

Squid  supports  SSL,  extensive access controls, and full request log‐
ging.  By using the lightweight Internet Cache Protocols ICP,  HTCP  or
CARP,  Squid  caches  can  be arranged in a hierarchy or mesh for addi‐
tional bandwidth savings.

Squid consists of a main server program squid , some optional  programs
for  custom  processing  and  authentication,  and  some management and
client tools.  When squid starts up, it spawns a configurable number of
helper  processes,  each  of  which can perform parallel lookups.  This
reduces the amount of time the cache waits for results.

Squid is derived from the ARPA-funded Harvest Project.

This manual page only lists the command line arguments.  For details on
how  to  configure Squid see the file /etc/squid/squid.conf.documented,
the Squid wiki FAQ and examples at  http://wiki.squid-cache.org/  ,  or
the  configuration  manual  on  the  Squid  home page http://www.squid-
cache.org/Doc/config/

### OPTIONS
       -a port     Specify HTTP port number  where  Squid  should  listen  for
                   requests,  in  addition  to any http_port specifications in
                   squid.conf

       -C          Do not catch fatal signals.

       -d level    Write debugging to stderr also.

       -f file     Use the given config-file instead of  /etc/squid/squid.conf
                   .   If  the  file  name  starts  with  a !  or | then it is
                   assumed to be an external command or command line.  Can for
                   example  be used to pre-process the configuration before it
                   is being read by Squid.   To  facilitate  this  Squid  also
                   understands  the  common  #line notion to indicate the real
                   source file.

       -F          Don't serve any requests until store is rebuilt.

       -h          Print help message.

       -i          Install as a Windows Service (see -n option).

       -k reconfigure | rotate | shutdown | interrupt | kill | debug | check |
       parse
                   Parse  configuration file, then send signal to running copy
                   (except -k parse ) and exit.

       -l facility Use specified syslog facility. Implies -s

       -n name     Specify Windows Service name to use for service operations,
                   default is: Squid

       -N          No daemon mode.

       -O options  Set Windows Service Command line options in Registry.

       -r          Remove a Windows Service (see -n option).

       -R          Do not set REUSEADDR on port.

       -s          Enable    logging   to   syslog.   Also   configurable   in
                   /etc/squid/squid.conf

       -S          Double-check swap during rebuild.

       -u port     Specify ICP port number (default: 3130), disable with 0.

       -v          Print version and build details.

       -X          Force full debugging.

       -Y          Only return UDP_HIT or UDP_MISS_NOFETCH during fast reload.

       -z          Create missing swap directories and other missing cache_dir
                   structures,  then exit. All cache_dir types create the con‐
                   figured top-level directory if it is missing. Other actions
                   are  type-specific.  For example, ufs-based storage systems
                   create missing L1 and L2 directories while Rock creates the
                   missing database file.

                   This  option does not enable validation of any present swap
                   structures. Its focus is on creation of missing pieces.  If
                   nothing  is  missing,  squid  -z just exits. If you suspect
                   cache_dir  corruption,  you  must  delete   the   top-level
                   cache_dir directory before running squid -z.

                   By  default, squid -z runs in daemon mode (so that configu‐
                   ration macros and other SMP features work as expected). Use
                   -N option to overwrite this.

### FILES
       Squid configuration files located in /etc/squid/:

       squid.conf
              The  main configuration file. You must initially make changes to
              this file for squid to work. For example, the default configura‐
              tion  only  allows  access  from RFC private LAN networks.  Some
              packaging distributions block even that.

       squid.conf.default
              Reference copy of the configuration file. Always kept up to date
              with the version of Squid you are using.

              Use  this to look up the default configuration settings and syn‐
              tax after upgrading.

       squid.conf.documented
              Reference copy of the configuration file. Always kept up to date
              with the version of Squid you are using.

              Use  this  to  read  the documentation for configuration options
              available in your build of Squid. The online configuration  man‐
              ual  is  also  available  for a full reference of options.  see‐
              http://www.squid-cache.org/Doc/config/

       cachemgr.conf
              The main configuration file for the web cachemgr.cgi tools.

       msntauth.conf
              The main configuration file for the Sample MSNT authenticator.

       errorpage.css
              CSS Stylesheet to control the display of generated error  pages.
              Use  this to set any company branding you need, it will apply to
              every language Squid provides error pages for.

       Some files also located elsewhere:

       /usr/share/squid/mime.conf (mime_table)
              MIME type mappings for FTP gatewaying

       /usr/share/squid/errors
              Location of Squid error pages and templates.

### AUTHOR
Squid was written over many years by a changing team of developers  and
maintained  in  turn  by  Duane  Wessels <duane@squid-cache.org> Henrik
Nordstrom  <hno@squid-cache.org>  Amos  Jeffries   <amosjeffries@squid-
cache.org>

With  contributions  from many others in the Squid community.  see CON‐
TRIBUTORS for a full list of individuals  who  contributed  code.   see
CREDITS for a list of major code contributing copyright holders.

### COPYRIGHT
*  Copyright (C) 1996-2017 The Squid Software Foundation and contribu‐
       tors
*
* Squid software is distributed under GPLv2+ license and includes
* contributions from numerous individuals and organizations.
* Please see the COPYING and CONTRIBUTORS files for details.

### QUESTIONS
       Questions on the usage of this program can be sent to the  Squid  Users
       mailing list <squid-users@squid-cache.org>

### REPORTING BUGS
Bug  reports  need  to  be  made  in  English.   See http://wiki.squid-
cache.org/SquidFaq/BugReporting for details of what you need to include
with your bug report.

Report bugs or bug fixes using http://bugs.squid-cache.org/

Report serious security bugs to Squid Bugs <squid-bugs@squid-cache.org>

Report  ideas for new improvements to the Squid Developers mailing list
<squid-dev@squid-cache.org>

### SEE ALSO
cachemgr.cgi (8), squidclient (1), basic_pam_auth (8),  basic_ldap_auth
(8),  ext_ldap_group_acl  (8),  ext_session_acl (8), ext_unix_group_acl
(8),
The Squid FAQ wiki http://wiki.squid-cache.org/SquidFaq
The Squid Configuration Manual http://www.squid-cache.org/Doc/config/

                                                               squid(8)

