# data=`date |tail -1 | cut -c1-4`
# if [ "$data" = "Sun" ]; then
#    at -f /u02/backup/bkp_full.sh now + 1 weeks
# fi
#!/bin/sh
# -----------------------------------------------------------------
# Backup script generated on 07/25/03 16:41:31
# Shell Script name: /u02/bkp_all.sh
# Description: todas as base de dados do servidor sebu59
#
# VERITAS NetBackup for oracle on UNIX
$VRTScprght: Copyright 1993 - 2002 VERITAS Software Corporation, All Rights Reserved $ #
# -----------------------------------------------------------------

ORACLE_HOME=/u01/app/oracle/product/10.1
ORACLE_SID=homolog
TARGET_INIT_FILE=/u01/app/oracle/product/10.1/dbs/orapwhomolog
RMAN_LOG_FILE=/u02/backup/log/rman_full_homolog.log
TARGET_CONNECT_STR=/
CATALOG_CONNECT_STR=rman_homolog/rman@rman_catalog
TEMPLATE_OWNER=oracle
RUN_AS_USER=oracle
RMAN=$ORACLE_HOME/bin/rman
CUSER=`id | cut -d"(" -f2 | cut -d ")" -f1`

# -----------------------------------------------------------------
# Initialize the log file.
# -----------------------------------------------------------------

> $RMAN_LOG_FILE
chmod 777 $RMAN_LOG_FILE

# -----------------------------------------------------------------
# Log the start of this script.
# -----------------------------------------------------------------

echo Script $0 >> $RMAN_LOG_FILE
echo ==== started on `date` ==== >> $RMAN_LOG_FILE
echo >> $RMAN_LOG_FILE

# -----------------------------------------------------------------
# rman commands for database ifr1dw.
# -----------------------------------------------------------------

CMD="
ORACLE_HOME=/u01/app/oracle/product/10.1
export ORACLE_HOME
ORACLE_SID=homolog
export ORACLE_SID
$RMAN target $TARGET_CONNECT_STR rcvcat $CATALOG_CONNECT_STR msglog $RMAN_LOG_FILE append <<EOF
ALLOCATE CHANNEL FOR MAINTENANCE TYPE DISK;
CHANGE ARCHIVELOG ALL CROSSCHECK;

RUN {
BACKUP DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;
}
EOF
"

if [ "$CUSER" = "root" ]
then
    su - $RUN_AS_USER -c "$CMD" >> $RMAN_LOG_FILE
    RSTAT=$?
else
    sh -c "$CMD" >> $RMAN_LOG_FILE
    RSTAT=$?
fi


if [ "$RSTAT" = "0" ]
then
    LOGMSG="ended successfully"
else
    LOGMSG="ended in error"
fi

# -----------------------------------------------------------------
# Log the completion of this script.
# -----------------------------------------------------------------

echo >> $RMAN_LOG_FILE
echo Script $0 >> $RMAN_LOG_FILE
echo ==== $LOGMSG on `date` ==== >> $RMAN_LOG_FILE
