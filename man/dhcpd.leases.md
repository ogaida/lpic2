### NAME
dhcpd.leases - DHCP client lease database

### DESCRIPTION
The Internet Systems Consortium DHCP Server keeps a persistent database
of leases that it has assigned.  This database  is  a  free-form  ASCII
file  containing a series of lease declarations.  Every time a lease is
acquired, renewed or released, its new value is recorded at the end  of
the  lease  file.   So if more than one declaration appears for a given
lease, the last one in the file is the current one.

When dhcpd is first installed, there is no lease  database.    However,
dhcpd  requires  that a lease database be present before it will start.
To make the initial lease database, just create an  empty  file  called
/var/lib/dhcp/dhcpd.leases.   You can do this with:

     touch /var/lib/dhcp/dhcpd.leases

In  order to prevent the lease database from growing without bound, the
file is rewritten from time to time.   First, a temporary  lease  data‐
base  is created and all known leases are dumped to it.   Then, the old
lease database is renamed /var/lib/dhcp/dhcpd.leases~.    Finally,  the
newly written lease database is moved into place.

In  order  to  process both DHCPv4 and DHCPv6 messages you will need to
run two separate  instances  of  the  dhcpd  process.   Each  of  these
instances will need it's own lease file.  You can use the -lf option on
the server's command line to specify a different lease  file  name  for
one or both servers.

### FORMAT
       Lease  descriptions  are  stored in a format that is parsed by the same
       recursive  descent  parser  used  to   read   the   dhcpd.conf(5)   and
       dhclient.conf(5)  files.   Lease  files can contain lease declarations,
       and  also  group  and  subgroup  declarations,  host  declarations  and
       failover state declarations.  Group, subgroup and host declarations are
       used to record objects created using the OMAPI protocol.

       The lease file is a log-structured file - whenever a lease changes, the
       contents of that lease are written to the end of the file.   This means
       that it is entirely possible and quite reasonable for there to  be  two
       or  more  declarations  of the same lease in the lease file at the same
       time.   In that case,  the  instance  of  that  particular  lease  that
       appears last in the file is the one that is in effect.

       Group,  subgroup and host declarations in the lease file are handled in
       the same manner, except that if any of these  objects  are  deleted,  a
       rubout  is  written to the lease file.   This is just the same declara‐
       tion, with { deleted; } in the scope of  the  declaration.    When  the
       lease  file  is  rewritten, any such rubouts that can be eliminated are
       eliminated.   It is possible to delete a declaration in the  dhcpd.conf
       file;  in  this  case,  the  rubout  can  never  be eliminated from the
       dhcpd.leases file.

### COMMON STATEMENTS FOR LEASE DECLARATIONS
       While the lease file formats for DHCPv4 and DHCPv6 are  different  they
       share  many  common  statements and structures.  This section describes
       the common statements while the succeeding sections describe the proto‐
       col specific statements.

       Dates

       A  date  is specified in two ways, depending on the configuration value
       for the db-time-format parameter.  If it was set to default,  then  the
       date fields appear as follows:

       weekday year/month/day hour:minute:second

       The weekday is present to make it easy for a human to tell when a lease
       expires - it's specified as a number from zero to six, with zero  being
       Sunday.   The  day  of week is ignored on input.  The year is specified
       with the century, so it should generally  be  four  digits  except  for
       really long leases.  The month is specified as a number starting with 1
       for January.  The day of the month is likewise specified starting  with
       1.   The hour is a number between 0 and 23, the minute a number between
       0 and 59, and the second also a number between 0 and 59.

       Lease times are specified in Universal Coordinated Time (UTC),  not  in
       the  local time zone.  There is probably nowhere in the world where the
       times recorded on a lease are always the same as wall clock times.   On
       most  unix  machines, you can display the current time in UTC by typing
       date -u.

       If the db-time-format was configured to local,  then  the  date  fields
       appear as follows:

        epoch  <seconds-since-epoch>;  #  <day-name> <month-name> <day-number>
       <hours>:<minutes>:<seconds> <year>

       The seconds-since-epoch is as according to  the  system's  local  clock
       (often  referred  to  as "unix time").  The # symbol supplies a comment
       that describes what actual time this is as according  to  the  system's
       configured timezone, at the time the value was written.  It is provided
       only for human inspection.

       If a lease will never expire, date is never instead of an actual date.

       General Variables

       As part of the processing of a lease information may be attached to the
       lease  structure,  for example the DDNS information or if you specify a
       variable in your configuration file.  Some  of  these,  like  the  DDNS
       information, have specific descriptions below.  For others, such as any
       you might define, a generic line of the following will be included.

       set variable = value;

       The set statement sets the value of a variable on the lease.  For  gen‐
       eral information on variables, see the dhcp-eval(5) manual page.

       DDNS Variables

       The ddns-text and ddns-dhcid variables

       These variables are used to record the value of the client's identification
       record when the server has updated DNS for a particular lease.  The text
       record is used with the interim DDNS update style while the dhcid record
       is used for the standard DDNS update style.

       The ddns-fwd-name variable

       This variable records the value of the name used in
       updating the client's A record if a DDNS update has been successfully
       done by the server.   The server may also have used this name to
       update the client's PTR record.

       The ddns-client-fqdn variable

       If the server is configured both to use the interim or standard DDNS update
       style, and to allow clients to update their own FQDNs, then if the
       client did in fact update its own FQDN, the
       ddns-client-fqdn variable records the name that the client has
       indicated it is using.   This is the name that the server will have
       used to update the client's PTR record in this case.

       The ddns-rev-name variable

       If the server successfully updates the client's PTR record, this
       variable will record the name that the DHCP server used for the PTR
       record.   The name to which the PTR record points will be either the
       ddns-fwd-name or the ddns-client-fqdn.

       Executable Statements

       on events { statements... }
       The on statement records a list of statements to execute if a
       certain event occurs.   The possible events that can occur for an
       active lease are release and expiry.   More than one event
       can be specified - if so, the events are separated by '|' characters.

       The authoring-byte-order statement

         authoring-byte-order [ big-endian | little-endian ] ;

         This statement is automatically added to the top of new lease files by
         the server. It indicates the internal byte order of the server.  This
         permits lease files generated on a server with one form of byte order
         to be read by a server with a different form.  Lease files which do not
         contain this entry are simply treated as having the same byte order as
         the server reading them.  If you are migrating lease files generated
         by a server that predates this statement and is of a different byte
         order than the your destination server, you can manually add this
         statement.  It must proceed any lease entries.  Valid values for this
         parameter are little-endian and big-endian.

### THE DHCPv4 LEASE DECLARATION
       lease ip-address { statements... }

       Each  lease  declaration  includes  the single IP address that has been
       leased to the client.   The statements within  the  braces  define  the
       duration of the lease and to whom it is assigned.

       starts date;
       ends date;
       tstp date;
       tsfp date;
       atsfp date;
       cltt date;

       The  start  and  end  time of a lease are recorded using the starts and
       ends statements.   The tstp statement is present if the failover proto‐
       col  is  being used, and indicates what time the peer has been told the
       lease expires.   The tsfp statement is also  present  if  the  failover
       protocol  is  being  used, and indicates the lease expiry time that the
       peer has acknowledged.  The atsfp statement is  the  actual  time  sent
       from  the  failover  partner.   The cltt statement is the client's last
       transaction time.

       See the description of dates in the section on common structures.

       hardware hardware-type mac-address;

       The hardware statement records the MAC address of the network interface
       on which the lease will be used.   It is specified as a series of hexa‐
       decimal octets, separated by colons.

       uid client-identifier;

       The uid statement records the client identifier used by the  client  to
       acquire  the  lease.    Clients are not required to send client identi‐
       fiers, and this statement only appears if the client did in  fact  send
       one.    Client  identifiers  are  normally an ARP type (1 for ethernet)
       followed by the MAC address, just like in the hardware  statement,  but
       this is not required.

       The client identifier is recorded as a colon-separated hexadecimal list
       or as a quoted string.   If it is recorded as a quoted  string  and  it
       contains  one  or  more  non-printable characters, those characters are
       represented as octal escapes - a backslash character followed by  three
       octal  digits.   The  format  used is determined by the lease-id-format
       parameter, which defaults to octal.

       client-hostname hostname ;

       Most DHCP clients will send their hostname in the host-name option.  If
       a  client  sends  its hostname in this way, the hostname is recorded on
       the lease with a client-hostname statement.   This is not  required  by
       the  protocol,  however, so many specialized DHCP clients do not send a
       host-name option.

       binding state state;
       next binding state state;

       The binding state statement declares the lease's binding  state.   When
       the  DHCP  server  is  not  configured  to use the failover protocol, a
       lease's binding state may be active, free or abandoned.   The  failover
       protocol  adds  some  additional  transitional  states,  as well as the
       backup state, which indicates that the lease is available  for  alloca‐
       tion  by  the  failover  secondary. Please see the dhcpd.conf(5) manual
       page for more information about abandoned leases.

       The next binding state statement indicates what state  the  lease  will
       move  to  when  the  current state expires.   The time when the current
       state expires is specified in the ends statement.

       rewind binding state state;

       This statement is part of an optimization for use with failover.   This
       helps a server rewind a lease to the state most recently transmitted to
       its peer.

       option agent.circuit-id string;
       option agent.remote-id string;

       These statements are used to  record  the  circuit  ID  and  remote  ID
       options  sent  by  the  relay  agent, if the relay agent uses the relay
       agent information option.   This allows these options to be  used  con‐
       sistently in conditional evaluations even when the client is contacting
       the server directly rather than through its relay agent.

       The vendor-class-identifier variable

       The server retains the client-supplied Vendor Class  Identifier  option
       for  informational  purposes,  and  to  render  them  in DHCPLEASEQUERY
       responses.

       bootp;
       reserved;

       If present, they indicate that the BOOTP and  RESERVED  failover  flags
       (respectively)  should  be  set.  BOOTP and RESERVED dynamic leases are
       treated differently than normal dynamic leases, as  they  may  only  be
       used by the client to which they are currently allocated.

       Other  Additional options or executable statements may be included, see
       the description of them in the section on common structures.

### THE DHCPv6 LEASE (IA) DECLARATION
       ia_ta  IAID_DUID { statements... }
       ia_na  IAID_DUID { statements... }
       ia_pd  IAID_DUID { statements... }

       Each lease declaration starts with a tag indicating  the  type  of  the
       lease.   ia_ta  is  for temporary addresses, ia_na is for non-temporary
       addresses and ia_pd is for prefix delegation.  Following  this  tag  is
       the combined IAID and DUID from the client for this lease.

       The  IAID_DUID  value is recorded as a colon-separated hexadecimal list
       or as a quoted string.   If it is recorded as a quoted  string  and  it
       contains  one  or  more  non-printable characters, those characters are
       represented as octal escapes - a backslash character followed by  three
       octal  digits.   The  format  used  is  governed by the lease-id-format
       parameter, which defaults to octal.

       cltt date;

       The cltt statement is the client's last transaction time.

       See the description of dates in the section on common structures.

       iaaddr ipv6-address { statements... }
       iaprefix ipv6-address/prefix-length { statements... }

       Within a given lease there can be multiple iaaddr and iaprefix statements.
       Each will have either an IPv6 address or an IPv6 prefix (an address and
       a prefix length indicating a CIDR style block of addresses).  The following
       statements may occur Within each iaaddr or iaprefix.

       binding state state;

       The binding state statement declares the lease's binding state.
       In DHCPv6 you will normally see this as active or expired.

       preferred-life lifetime;

       The IPv6 preferred lifetime associated with this address, in seconds.

       max-life lifetime;

       The valid lifetime associated with this address, in seconds.

       ends date;

       The end time of the lease.  See the description of dates in the section on
       common structures.

       Additional options or executable statements may be included.  See the description
       of them in the section on common structures.

### THE FAILOVER PEER STATE DECLARATION
       The state of any failover peering arrangements is also recorded in  the
       lease file, using the failover peer statement:

       failover peer name state {
       my state state at date;
       peer state state at date;
       }

       The  states  of the peer named name is being recorded.   Both the state
       of the running server (my state) and the other failover  partner  (peer
       state)  are  recorded.    The  following  states are possible: unknown-
       state, partner-down,  normal,  communications-interrupted,  resolution-
       interrupted,   potential-conflict,   recover,  recover-done,  shutdown,
       paused, and startup.

### FILES
/var/lib/dhcp/dhcpd.leases /var/lib/dhcp/dhcpd.leases~

### SEE ALSO
dhcpd(8),  dhcp-options(5),   dhcp-eval(5),   dhcpd.conf(5),   RFC2132,
RFC2131.

### AUTHOR
dhcpd(8) is maintained by ISC.  Information about Internet Systems Con‐
sortium can be found at: https://www.isc.org/

                                                        dhcpd.leases(5)

