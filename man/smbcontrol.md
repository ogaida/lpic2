### NAME
smbcontrol - send messages to smbd, nmbd or winbindd processes

### SYNOPSIS
       smbcontrol [-s] [-t|--timeout]

       smbcontrol [destination] [message-type] [parameter]

### DESCRIPTION
This tool is part of the samba(7) suite.

smbcontrol is a very small program, which sends messages to a smbd(8),
a nmbd(8), or a winbindd(8) daemon running on the system.

### OPTIONS
       -?|--help
           Print a summary of command line options.

       --usage
           Display brief usage message.

       -d|--debuglevel=level
           level is an integer from 0 to 10. The default value if this
           parameter is not specified is 1.

           The higher this value, the more detail will be logged to the log
           files about the activities of the server. At level 0, only critical
           errors and serious warnings will be logged. Level 1 is a reasonable
           level for day-to-day running - it generates a small amount of
           information about operations carried out.

           Levels above 1 will generate considerable amounts of log data, and
           should only be used when investigating a problem. Levels above 3
           are designed for use only by developers and generate HUGE amounts
           of log data, most of which is extremely cryptic.

           Note that specifying this parameter here will override the log
           level parameter in the smb.conf file.

       -V|--version
           Prints the program version number.

       -s|--configfile=<configuration file>
           The file specified contains the configuration details required by
           the server. The information in this file includes server-specific
           information such as what printcap file to use, as well as
           descriptions of all the services that the server is to provide. See
           smb.conf for more information. The default configuration file name
           is determined at compile time.

       -l|--log-basename=logdirectory
           Base directory name for log/debug files. The extension ".progname"
           will be appended (e.g. log.smbclient, log.smbd, etc...). The log
           file is never removed by the client.

       --option=<name>=<value>
           Set the smb.conf(5) option "<name>" to value "<value>" from the
           command line. This overrides compiled-in defaults and options read
           from the configuration file.

       -t|--timeout
           Set timeout to seconds.

       destination
           One of nmbd, smbd, winbindd or a process ID.

           The all destination causes the message to "broadcast" to all
           running daemons including nmbd and winbind. This is a change for
           Samba 3.3, prior to this the parameter smbd used to do this.

           The smbd destination causes the message to be sent to the smbd
           daemon specified in the smbd.pid file.

           The nmbd destination causes the message to be sent to the nmbd
           daemon specified in the nmbd.pid file.

           The winbindd destination causes the message to be sent to the
           winbind daemon specified in the winbindd.pid file.

           If a single process ID is given, the message is sent to only that
           process.

       message-type
           Type of message to send. See the section MESSAGE-TYPES for details.

       parameters
           any parameters required for the message-type

### MESSAGE-TYPES
       Available message types are:

       close-share
           Order smbd to close the client connections to the named share. Note
           that this doesn't affect client connections to any other shares.
           This message-type takes an argument of the share name for which
           client connections will be closed, or the "*" character which will
           close all currently open shares. This may be useful if you made
           changes to the access controls on the share. This message can only
           be sent to smbd.

       debug
           Set debug level to the value specified by the parameter. This can
           be sent to any of the destinations. If this message is sent to
           either the smbd or winbindd daemons, the parent process will
           rebroadcast the message to all child processes changing the debug
           level in each one.

       kill-client-ip
           Order smbd to close the client connections from a given IP address.
           This message-type takes an argument of the IP address from which
           client connections will be closed. This message can only be sent to
           smbd.

       force-election
           This message causes the nmbd daemon to force a new browse master
           election.

       ping
           Send specified number of "ping" messages and wait for the same
           number of reply "pong" messages. This can be sent to any of the
           destinations.

       profile
           Change profile settings of a daemon, based on the parameter. The
           parameter can be "on" to turn on profile stats collection, "off" to
           turn off profile stats collection, "count" to enable only
           collection of count stats (time stats are disabled), and "flush" to
           zero the current profile stats. This can be sent to any smbd or
           nmbd destinations.

       debuglevel
           Request debuglevel of a certain daemon and write it to stdout. This
           can be sent to any of the destinations.

       profilelevel
           Request profilelevel of a certain daemon and write it to stdout.
           This can be sent to any smbd or nmbd destinations.

       printnotify
           Order smbd to send a printer notify message to any Windows NT
           clients connected to a printer. This message-type takes the
           following arguments:

           queuepause printername
               Send a queue pause change notify message to the printer
               specified.

           queueresume printername
               Send a queue resume change notify message for the printer
               specified.

           jobpause printername unixjobid
               Send a job pause change notify message for the printer and unix
               jobid specified.

           jobresume printername unixjobid
               Send a job resume change notify message for the printer and
               unix jobid specified.

           jobdelete printername unixjobid
               Send a job delete change notify message for the printer and
               unix jobid specified.

           Note that this message only sends notification that an event has
           occurred. It doesn't actually cause the event to happen.

           This message can only be sent to smbd.

       dmalloc-mark
           Set a mark for dmalloc. Can be sent to both smbd and nmbd. Only
           available if samba is built with dmalloc support.

       dmalloc-log-changed
           Dump the pointers that have changed since the mark set by
           dmalloc-mark. Can be sent to both smbd and nmbd. Only available if
           samba is built with dmalloc support.

       shutdown
           Shut down specified daemon. Can be sent to both smbd and nmbd.

       pool-usage
           Print a human-readable description of all talloc(pool) memory usage
           by the specified daemon/process. Available for both smbd and nmbd.

       ringbuf-log
           Fetch and print the ringbuf log. Requires logging = ringbuf.
           Available for smbd, winbindd and nmbd.

       drvupgrade
           Force clients of printers using specified driver to update their
           local version of the driver. Can only be sent to smbd.

       reload-config
           Force daemon to reload smb.conf configuration file. Can be sent to
           smbd, nmbd, or winbindd.

       reload-printers
           Force smbd to reload printers. Can only be sent to smbd.

       idmap
           Notify about changes of id mapping. Can be sent to smbd or (not
           implemented yet) winbindd.

           flush [uid|gid]
               Flush caches for sid <-> gid and/or sid <-> uid mapping.

           delete <ID>
               Remove a mapping from cache. The mapping is given by <ID> which
               may either be a sid: S-x-..., a gid: "GID number" or a uid:
               "UID number".

           kill <ID>
               Remove a mapping from cache. Terminate smbd if the id is
               currently in use.

       num-children
           Query the number of smbd child processes. This message can only be
           sent to smbd.

### VERSION
This man page is correct for version 3 of the Samba suite.

### SEE ALSO
nmbd(8) and smbd(8).

### AUTHOR
The original Samba software and related utilities were created by
Andrew Tridgell. Samba is now developed by the Samba Team as an Open
Source project similar to the way the Linux kernel is developed.

The original Samba man pages were written by Karl Auer. The man page
sources were converted to YODL format (another excellent piece of Open
Source software, available at ftp://ftp.icce.rug.nl/pub/unix/) and
updated for the Samba 2.0 release by Jeremy Allison. The conversion to
DocBook for Samba 2.2 was done by Gerald Carter. The conversion to
DocBook XML 4.2 for Samba 3.0 was done by Alexander Bokovoy.

