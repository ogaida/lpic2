### NAME
doveadm - Dovecot's administration utility

### SYNOPSIS
        doveadm  [-Dv]  [-f formatter] command [command_options] [command_argu‐
        ments]

### DESCRIPTION
doveadm is the Dovecot administration tool. It can be  used  to  manage
various parts of Dovecot, as well as access users' mailboxes.
Execute doveadm help, for a command usage listing.

### OPTIONS
        Global doveadm(1) options:
 
        -D     Enables verbosity and debug messages.
 
        -f formatter
               Specifies  the  formatter  for formatting the output.  Supported
               formatters are:
 
               flow   prints each line with key=value pairs.
 
               pager  prints each key: value pair on its own line and separates
                      records with form feed character (^L).
 
               tab    prints  a  table  header  followed by tab separated value
                      lines.
 
               table  prints a table header followed by adjusted value lines.
 
        -o setting=value
               Overrides  the  configuration  setting  from  /etc/dovecot/dove‐
               cot.conf  and from the userdb with the given value.  In order to
               override multiple settings, the -o option may be specified  mul‐
               tiple times.
 
        -v     Enables verbosity, including progress counter.

### COMMANDS
        These commands work directly with Dovecot's master process.
 
    reload
        doveadm reload
 
        Force dovecot(1) to reload the configuration.
 
    stop
        doveadm stop
 
        Stop dovecot(1) and all its child processes.
 
    ADDITIONAL MASTER COMMANDS
        doveadm director
               doveadm-director(1),  Manage Dovecot directors (if used by proxy
               servers).
 
        doveadm exec
               doveadm-exec(1),  Easily   execute   commands   from   Dovecot's
               libexec_dir.
 
        doveadm instance
               doveadm-instance(1),   Manage   the   list  of  running  Dovecot
               instances.
 
        doveadm kick
               doveadm-kick(1),  Disconnect  users  by  user  name  and/or   IP
               address.
 
        doveadm log
               doveadm-log(1), Locate, test or reopen Dovecot's log files.
 
        doveadm mount
               doveadm-mount(1), Manage the list of mountpoints where mails are
               stored.
 
        doveadm penalty
               doveadm-penalty(1), Show current penalties.
 
        doveadm proxy
               doveadm-proxy(1), Handle Dovecot proxy connections.
 
        doveadm who
               doveadm-who(1); Show who is logged in to the Dovecot server.
 
    AUTHENTICATION COMMANDS
        doveadm auth
               doveadm-auth(1), Test authentication for a user.
 
        doveadm pw
               doveadm-pw(1), Dovecot's password hash generator.
 
        doveadm user
               doveadm-user(1), Perform a user lookup in Dovecot's userdbs
 
    MAILBOX COMMANDS
        doveadm acl
               doveadm-acl(1), Manage Access Control List (ACL).
 
        doveadm altmove
               doveadm-altmove(1), Move matching mails to the alternative stor‐
               age.
 
        doveadm backup
               doveadm-backup(1),  Dovecot's  one-way  mailbox  synchronization
               utility.
 
        doveadm batch
               doveadm-batch(1), Execute multiple commands for multiple users.
 
        doveadm copy
               doveadm-copy(1), Copy messages matching the given  search  query
               into another mailbox.
 
        doveadm deduplicate
               doveadm-deduplicate(1), Expunge duplicate messages.
 
        doveadm dump
               doveadm-dump(1),  Dump  the  content of Dovecot's binary mailbox
               index/log.
 
        doveadm expunge
               doveadm-expunge(1),  Expunge  messages  matching  given   search
               query.
 
        doveadm fetch
               doveadm-fetch(1), Fetch messages matching given search query.
 
        doveadm flags
               doveadm-flags(1), Add, remove or replace messages' flags.
 
        doveadm fts
               doveadm-fts(1), Manipulate the Full Text Search (FTS) index.
 
        doveadm force-resync
               doveadm-force-resync(1),  Repair broken mailboxes, in case Dove‐
               cot doesn't automatically do that.
 
        doveadm import
               doveadm-import(1), Import messages matching given search query.
 
        doveadm index
               doveadm-index(1), Index messages in a given mailbox.
 
        doveadm mailbox
               doveadm-mailbox(1), Various commands related to  handling  mail‐
               boxes.
 
        doveadm move
               doveadm-move(1)  Move  messages  matching the given search query
               into another mailbox.
 
        doveadm purge
               doveadm-purge(1) Remove  messages  with  refcount=0  from  mdbox
               files.
 
        doveadm quota
               doveadm-quota(1),  Initialize/recalculate  or show current quota
               usage.
 
        doveadm replicator
               doveadm-replicator(1), Manage users' mail replicaton.
 
        doveadm stats
               doveadm-stats(1), Inspect or reset stats.
 
        doveadm sync
               doveadm-sync(1), Dovecot's two-way mailbox synchronization util‐
               ity.
 
        doveadm search
               doveadm-search(1), Show a list of mailbox GUIDs and message UIDs
               matching given search query.

### EXIT STATUS
        doveadm will exit with one of the following values:
 
        0   Selected command was executed successful.
 
        >0  Command failed in some way.

### ENVIRONMENT
        USER   This environment variable is used to determine  the  user  if  a
               command accepts a user but none was specified.

### FILES
        /etc/dovecot/dovecot.conf
               Dovecot's main configuration file.
 
        /etc/dovecot/conf.d/10-mail.conf
               Mailbox locations and namespaces.
 
        /etc/dovecot/conf.d/90-plugin.conf
               Plugin specific settings.

### REPORTING BUGS
Report  bugs, including doveconf -n output, to the Dovecot Mailing List
<dovecot@dovecot.org>.  Information about reporting bugs  is  available
at: http://dovecot.org/bugreport.html

### SEE ALSO
doveadm-help(1), doveconf(1), dovecot(1), doveadm-search-query(7)

