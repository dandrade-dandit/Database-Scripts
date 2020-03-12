ORACLE_HOME=/u01/app/oracle/product/10.1
export ORACLE_HOME

ORACLE_BASE=/u01/app
export ORACLE_BASE

ORACLE_SID=homolog
export ORACLE_SID

PATH=$ORACLE_HOME:$ORACLE_HOME/bin:$PATH
export PATH

chmod 770 /u02/backup/export/*

exp operacao/infraero FULL=Y FILE=/u02/backup/export/EXP_FULL_HOMOLOG.DMP LOG=/u02/backup/export/EXP_FULL_HOMOLOG.LOG STATISTICS=none

ORACLE_SID=case9i
export ORACLE_SID

exp operacao/infraero FULL=Y FILE=/u02/backup/export/EXP_FULL_CASE9I.DMP LOG=/u02/backup/export/EXP_FULL_CASE9I.LOG STATISTICS=none

/usr/openv/netbackup/bin/bpbackup -p Unix_Oracle_Export -s User_Export -S s-segu113 -t 0 /u02/backup/export
