### NAME
fail2ban-server - start the server

### SYNOPSIS
       fail2ban-server [OPTIONS]

### DESCRIPTION
Fail2Ban  v0.10.2  reads log file that contains password failure report
and bans the corresponding IP addresses using firewall rules.

### OPTIONS
       -c <DIR>
              configuration directory

       -s <FILE>
              socket path

       -p <FILE>
              pidfile path

       --loglevel <LEVEL>
              logging level

       --logtarget <TARGET>
              logging target, use  file-name  or  stdout,  stderr,  syslog  or
              sysout.

       --syslogsocket auto|<FILE>

       -d     dump configuration. For debugging

       --dp, --dump-pretty
              dump the configuration using more human readable representation

       -t, --test
              test configuration (can be also specified with start parameters)

       -i     interactive mode

       -v     increase verbosity

       -q     decrease verbosity

       -x     force execution of the server (remove socket file)

       -b     start server in background (default)

       -f     start server in foreground

       --async
              start  server in async mode (for internal usage only, don't read
              configuration)

       --timeout
              timeout to wait for the server (for internal usage  only,  don't
              read configuration)

       --str2sec <STRING>
              convert time abbreviation format to seconds

       -h, --help
              display this help message

       -V, --version
              print the version

### REPORTING BUGS
Report  bugs via Debian bug tracking system http://www.debian.org/Bugs/
.

### COPYRIGHT
Copyright © 2004-2008 Cyril Jaquier, 2008- Fail2Ban Contributors
Copyright of modifications held by their respective authors.   Licensed
under the GNU General Public License v2 (GPL).

### SEE ALSO
fail2ban-client(1)

fail2ban-server v0.10.2          January 2018               FAIL2BAN-SERVER(1)

