#!/bin/sh
#
# Set das variaveis de ambiente
DISPLAY=s-sebu112:0.0
export DISPLAY
ORACLE_HOME=/u01/app/oracle/product/10.1
export ORACLE_HOME
ORACLE_BASE=/u01/app
export ORACLE_BASE
NLS_LANG='American_America.WE8ISO8859P1'
export NLS_LANG
PATH=$PATH:$ORACLE_HOME:$ORACLE_HOME/bin:/usr/bin:/etc:/usr/ccs/bin:/usr/bin/X11:/usr/local/bin:/usr/sbin
export PATH
ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
export ORA_NLS33
ORACLE_SID=case9i
export ORACLE_SID
#
# Initialize default connect string variables:
target='target /'
catalog='rcvcat rman_case9i/rman@rman_catalog2' # force user to supply catalog option
# Initialize filenames:
obsolete_tape=/u02/backup/ob_tape.log;   # list of obsolete tape backups
cmdfile=/u02/backup/delete.cmd;          # the generated RMAN commmand script
delete_log=/u02/backup/log/deleted_case9i.log;      # execution log from generated script

> $obsolete_tape
chmod 777 $obsolete_tape
> $cmdfile
chmod 777 $cmdfile
> $delete_log
chmod 777 $delete_log

# Get a list of obsolete tape files:
rman $target $catalog msglog $obsolete_tape << EOF > /dev/null
report obsolete redundancy 2 device type 'sbt_tape';
exit;
EOF
#
# Create the RMAN command file to delete the obsolete files:
#
echo "allocate channel for delete type 'sbt_tape';" >> $cmdfile
ps -ef | grep 'Backup Set' /u02/backup/ob_tape.log>/u02/backup/ob_tape1.log
linhas=`ps -ef | grep -ci 'Backup Set' /u02/backup/ob_tape1.log`
count=1
while [ $count -le $linhas ];
 do
  echo "change backupset `head -$count /u02/backup/ob_tape1.log |tail -1 | cut -c20-28` delete;" >> $cmdfile 
 count=`expr $count + 1`
 done
echo "release channel;" >> $cmdfile
#
# Execute the RMAN command file to delete the obsolete files:
#
rman $target $catalog msglog $delete_log cmdfile $cmdfile
# rman1.sh
rm -f /u02/backup/ob_tape1.log
rm -f /u02/backup/ob_tape.log
rm -f /u02/backup/delete.cmd
exit
