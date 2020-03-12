--Está isntalado no prodsede2 - 10.0.17.126
1)
 smo diag jdbc -sid homolog -host 10.0.17.112 -port 1521 -username ifrnetapp -password monoceros

2)
 smo credential list
 smo credential clear
 
3)
 smo credential set -host -name s-sebu126.infraero.gov.br -password Infr@Net@pp -verbose
 
4)
 smo credential set -repository -dbname homolog -host 10.0.17.112 -login -username ifrnetapp -password monoceros -port 1521 -verbose
 smo credential set -repository -dbname homolog -host 10.0.17.112 -login -username sys -password lambda -port 1521 -verbose

5)
 smo profile create -profile PRODSEDE -profile-password Infr@94Zty0 -repository -dbname homolog -login -username ifrnetapp -port 1521 -host 10.0.17.126 -database -dbname ifr1 -port 1521 -host 10.0.17.126 -osaccount oracle -osgroup oinstall -retain 5 -verbose
 
6)
 smo repository show -repository -port 1521 -dbname ifr.infraero.gov.br -host s-sebu126 -login -username ifrnetapp

7) 
 smo backup create -online -full -profile PRODSEDE_UNIX -label BKP_QUARTA_TARDE
 
8)SCRIPT PARA EXECUTAR BACKUP

9) resync do catalogo quando troca de servidor
smo profile sync -repository -dbname ifr1a -host 10.0.17.126 -port 1521 -login -username ifrnetapp

ORACLE_SID=ifr1; export ORACLE_SID
ORACLE_BASE=/volorahome/app/oracle; export ORACLE_BASE
ORACLE_LOG=/voloralog/oracle/app/oracle/admin/ifr; export ORACLE_LOG
ORACLE_HOME=/volorahome/app/oracle/product/10.1; export ORACLE_HOME
ORA_CRS_HOME=/volorahome/crs/oracle/product/10.1/crs_1; export ORA_CRS_HOME
TNS_ADMIN=$ORACLE_HOME/network/admin; export TNS_ADMIN
NLS_LANG=American_America.WE8ISO8859P1; export NLS_LANG
NLS_CHARACTERSET=WE8ISO8859P1; export NLS_CHARACTERSET
PATH=$PATH:/volorahome/app/oracle/product/10.1/bin:/voloracrs/crs/oracle/product/10.1/crs_1/bin:/usr/bin:/bin:/usr/bin/X11
export PATH
PATH=$ORACLE_HOME/bin:$PATH
export PATH


MES=`date| cut -c5-7`
DIA=`date| cut -c10-11`
ANO=`date| cut -c26-29`
HORA=`date| cut -c12-19`
SEM=`date| cut -c1-3`

STR_DATA=`echo $DIA`-`echo $MES`-`echo $ANO`-`echo $HORA`-`echo $SEM`

smo backup create -online -full -profile PRODSEDE_UNIX -label BKP_PRODSEDE_`echo $STR_DATA`

9) CRONTAB

#Backup DAILY via netapp.
0 9,11,13,15,17,19 * * 1,2,3,4,5 /volorahome/backup/bkp_netapp_prodsede_daily.sh
#Backup FULL via netapp.
0 3,22 * * * /volorahome/backup/bkp_netapp_prodsede_full.sh

10)
