#!/bin/sh
#
ORACLE_HOME=/u01/app/oracle/product/10.1
export ORACLE_HOME
ORACLE_SID=ifr1
export ORACLE_SID

# Initialize default connect string variables:
target='target /'
catalog='rcvcat rman_prodsede/rman@rman_catalog' # force user to supply catalog option
# Initialize filenames:
obsolete_tape=/backup/ob_tape.log;   # list of obsolete tape backups
cmdfile=/backup/delete.cmd;          # the generated RMAN commmand script
delete_log=/backup/log/deleted.log;      # execution log from generated script

> $obsolete_tape
chmod 777 $obsolete_tape
> $cmdfile
chmod 777 $cmdfile
> $delete_log
chmod 777 $delete_log

# Get a list of obsolete tape files:
/u01/app/oracle/product/10.1/bin/rman $target $catalog msglog $obsolete_tape << EOF > /dev/null
#report obsolete redundancy 2 device type 'sbt_tape';
report obsolete device type 'sbt_tape';
exit;
EOF
#
# Create the RMAN command file to delete the obsolete files:
#
echo "allocate channel for delete type 'sbt_tape';" >> $cmdfile
ps -ef | grep 'Backup Set' /backup/ob_tape.log>/backup/ob_tape1.log
linhas=`ps -ef | grep -ci 'Backup Set' /backup/ob_tape1.log`
count=1
while [ $count -le $linhas ];
 do
  echo "change backupset `head -$count /backup/ob_tape1.log |tail -1 | cut -c20-28` delete;" >> $cmdfile 
 count=`expr $count + 1`
 done
echo "release channel;" >> $cmdfile
#
# Execute the RMAN command file to delete the obsolete files:
#
/u01/app/oracle/product/10.1/bin/rman $target $catalog msglog $delete_log cmdfile $cmdfile
# rman1.sh
rm -f /backup/ob_tape1.log
rm -f /backup/ob_tape.log
rm -f /backup/delete.cmd
exit
