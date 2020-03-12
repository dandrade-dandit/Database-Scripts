#!/bin/sh
#
# Initialize default connect string variables:
target='target /'
catalog='rcvcat rman_sebu59/infraero@sebn07' # force user to supply catalog option
# Initialize filenames:
obsolete_tape=/u02/backup/ob_tape.log;   # list of obsolete tape backups
cmdfile=/u02/backup/delete.cmd;          # the generated RMAN commmand script
delete_log=/u02/backup/deleted.log;      # execution log from generated script

> $obsolete_tape
chmod 777 $obsolete_tape
> $cmdfile
chmod 777 $cmdfile
> $delete_log
chmod 777 $delete_log

# Get a list of obsolete tape files:
rman $target $catalog msglog $obsolete_tape << EOF > /dev/null
report obsolete device type 'sbt_tape';
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
