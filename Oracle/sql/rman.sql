allocate channel for maintenance type 'SBT_TAPE' PARMS='SBT_LIBRARY=/opt/simpana/Base/libobk.so,ENV=(CvClientName=s-sebu32,CvInstanceName=Instance001)';


change backupset   1502829 delete;
YES
release channel;

report obsolete redundancy 1 device type DISK;

report obsolete redundancy 2 device type 'SBT_TAPE';

DELETE ARCHIVELOG ALL BACKED UP 2 TIMES TO DEVICE TYPE DISK;

DELETE ARCHIVELOG ALL BACKED UP 2 TIMES TO DEVICE TYPE 'SBT_TAPE';

DELETE OBSOLETE RECOVERY WINDOW OF 7 DAYS;

DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 7 DAYS;

DELETE NOPROMPT OBSOLETE redundancy 1;

delete expired backup;

crosscheck controlfilecopy "/voloralog/app/ifrprod/oradata/SMOBakCtl_1276567294703_1";


change controlfilecopy all crosscheck;
change archivelog all crosscheck;

allocate channel for maintenance type 'SBT_TAPE' PARMS='SBT_LIBRARY=/opt/simpana/Base/libobk.so,ENV=(CvClientName=s-sebu72,CvInstanceName=Instance001)'; 
crosscheck backup of database;


crosscheck backuppiece '/volorarman/rman_prodsede/IFRPROD_DB_24linkdv_4164_1';


rman target / rcvcat rman_prodsede/rman@rman_catalog
--********************************

run
{
allocate channel c1 type 'sbt_tape'
PARMS="SBT_LIBRARY=/opt/simpana/Base/libobk.so,ENV=(CvClientName=s-sebu127,CvInstanceName=Instance001)";
backup database;
}
 
 

run {execute script BkpFullNivel0;}
run {execute script BkpFullNivel1;}
run {execute script BkpFullNivel2;}
run {execute script BkpFullArchives;}

--Para o Prodsede2 (Linux)
create script BkpFullNivel0 {
allocate channel d1 type disk maxpiecesize 2000M;
backup incremental level 0 format '/mnt/bkp_win/rman/bk_%s_%p_%t'
tag bkpfullnivel0  filesperset 4
(database include current controlfile);
sql 'alter system archive log current';
release channel d1;}

create script BkpFullNivel1 {
allocate channel d1 type disk maxpiecesize 2000M;
backup incremental level 1 format '/mnt/bkp_win/rman/bk_%s_%p_%t'
tag bkpfullnivel1  filesperset 4
(database include current controlfile);
sql 'alter system archive log current';
release channel d1;}

create script BkpFullNivel2 {
allocate channel d1 type disk maxpiecesize 2000M;
backup incremental level 2 format '/mnt/bkp_win/rman/bk_%s_%p_%t'
tag bkpfullnivel2  filesperset 4
(database include current controlfile);
sql 'alter system archive log current';
release channel d1;}

create script BkpFullArchives {
allocate channel ch00 type disk maxpiecesize 2000M;
backup
   filesperset 20
   format '/mnt/bkp_win/rman/bkp_arc_%s_%p_%t'
   archivelog all ;
release channel ch00; }

--Para os TRU64
create script BkpFullNivel0 {
allocate channel d1 type 'sbt_tape';
allocate channel d2 type 'sbt_tape';
backup incremental level 0 format 'bk_%s_%p_%t'
tag bkpfullnivel0 filesperset 5
(database include current controlfile);
sql 'alter system archive log current';
release channel d1; 
release channel d2;}


create script BkpFullNivel1 {
allocate channel d1 type 'sbt_tape';
allocate channel d2 type 'sbt_tape';
backup incremental level 1 format 'bk_%s_%p_%t'
tag bkpfullnivel0 filesperset 5
(database include current controlfile);
sql 'alter system archive log current';
release channel d1; 
release channel d2;}


create script BkpFullNivel2 {
allocate channel d1 type 'sbt_tape';
allocate channel d2 type 'sbt_tape';
backup incremental level 2 format 'bk_%s_%p_%t'
tag bkpfullnivel0 filesperset 5
(database include current controlfile);
sql 'alter system archive log current';
release channel d1; 
release channel d2;}


create script BkpFullNivel0_2 {
allocate channel d1 type disk;
backup incremental level 0 format '/u02/backup/rman/bk_%s_%p_%t'
tag bkpfullnivel0 filesperset 5
(database include current controlfile);
sql 'alter system archive log current';
release channel d1; }


create script BkpFullNivel1_2 {
allocate channel d1 type disk;
backup incremental level 1 format '/u02/backup/rman/bk_n1_%s_%p_%t'
tag bkpfullnivel0 filesperset 5
(database include current controlfile);
sql 'alter system archive log current';
release channel d1; }

create script BkpFullArchives {
allocate channel ch00 type 'sbt_tape';
backup
   filesperset 20
   format 'al_%s_%p_%t'
   archivelog all delete input;
release channel ch00; }


create script BkpFullArchives_2 {
allocate channel ch00 type disk;
backup
   filesperset 20
   format '/u02/backup/rman/arc_%s_%p_%t'
   archivelog all delete input;
release channel ch00; }

list backup;

run { host "rm /u01/app/oradata/ifr1dw/teste.dbf";}
run { host "ls -las /u01/app/oradata/ifr1dw";}
run { host "df -k";}
run { host "ls -lsa /u03/app/rman";}
run { host "ls -lsa /archive/";}
run { host "rm /archive/arc*.arc";}
run { host "rm /u02/backup/rman/bk*";}

run {
allocate channel d1 type 'SBT_TAPE';
sql "alter tablespace teste_rman offline immediate";
restore tablespace teste_rman;
recover tablespace teste_rman;
sql "alter tablespace teste_rman online";
release channel d1; }

run {
allocate channel d1 type 'SBT_TAPE';
sql "alter database mount";
restore database;
recover database;
sql "alter database open";
release channel d1; }

allocate channel for delete type disk;
delete expired backup;
release channel;


allocate channel for maintenance type 'SBT_TAPE';
change archivelog all crosscheck;
change archivelog '/archifr5/arch_2_3858.arc' uncatalog;
release channel;


allocate channel for maintenance type 'SBT_TAPE';

change backuppiece 392, 393, 394, 395 delete;
change backuppiece 392, 393, 394, 395 crosscheck;
release channel;

allocate channel for maintenance type 'SBT_TAPE';
change backupset 366, 367, 368, 369 delete;
change backupset 366, 367, 368, 369 crosscheck;
change backupset 2905,2910,2985,2990,3105,3185,3200,3245,3260,3310,3317,3368,3374,3468,3483,3530,3537 UNAVAILABLE;
release channel;

allocate channel for maintenance type 'SBT_TAPE';
change archivelog until time 'sysdate-7' delete;
release channel;


list copy of database archivelog all;

list backup of archivelog all;


allocate channel for maintenance type 'SBT_TAPE'; 
crosscheck backup of database; 
delete expired backup; 
release channel;

report obsolete redundancy 2 device type 'SBT_TAPE'; 

report obsolete device type 'SBT_TAPE'; 


run {
allocate channel d1 type 'SBT_TAPE';
restore archivelog from logseq 4495 until logseq 4506;
release channel d1; }

--Depois de um open resetlogs executar o comando abaixo...
reset database;


--exemplos change

change backuppiece | backupset 2222 delete | crosscheck | uncatalog | available | unavailable;
change datafilecopy | controlfilecopy '/dskkls/kdkddbzf' delete | crosscheck | uncatalog | available | unavailable;

--TESTES************

ALLOCATE CHANNEL FOR MAINTENANCE TYPE DISK parms 'ENV=(DSMO_NODE=mc05)';
CHANGE ARCHIVELOG ALL CROSSCHECK;

run {
allocate channel t1 type 'sbt_tape' parms 'ENV=(DSMO_NODE=mc04)';
allocate channel t2 type 'sbt_tape' connect internal/classea190@bdsede5 parms 'ENV=(DSMO_NODE=mc05)';
backup FORMAT 'arch-s%s-p%p-t%t' FILESPERSET 15
      (archivelog from logseq 130 until logseq 131
       thread 1 channel t1);
backup FORMAT 'arch-s%s-p%p-t%t' FILESPERSET 15
      (archivelog from logseq 92 until logseq 93
       thread 2 channel t2);      
release channel t1;
release channel t2;}


run {
allocate channel t1 type 'sbt_tape' connect internal/classea190@bdsede4.infraero.gov.br parms 'ENV=(DSMO_NODE=mc05)';
allocate channel t2 type 'sbt_tape' connect internal/classea190@bdsede5 parms 'ENV=(DSMO_NODE=mc05)';
backup FORMAT 'arch-s%s-p%p-t%t' FILESPERSET 15
      (archivelog until time 'SYSDATE' 
       thread 1 channel t1);      
backup FORMAT 'arch-s%s-p%p-t%t' FILESPERSET 15
      (archivelog until time 'SYSDATE' 
       thread 2 channel t2); 
release channel t1;
release channel t2;}


until time 'SYSDATE' 


RMAN> run 
2> { 
3> allocate channel t1 type 'sbt_tape' connect internal/oracle@prod1; 
4> allocate channel t2 type 'sbt_tape' connect internal/oracle@prod2; 
5> set archivelog destination to '/temp01/rman' ; 
6> restore (archivelog from logseq 14007 until logseq 14008 thread 2 channel t2); 
7> restore (archivelog from logseq 41700 until logseq 41702 thread 1 channel t1); 
8> release channel t1; 
9> release channel t2; 
10> } 


rman target / rcvcat rman_sebu59/infraero@sebn07


--Estava no script da SEBU04
# Backup Archived Logs

# For an offline backup, remove the following sql statement
sql 'alter system archive log current';

BACKUP
    FILESPERSET 15
    FORMAT 'arch-s%s-p%p-t%t'
    ARCHIVELOG
             ALL;

# Control file backup

BACKUP
    FORMAT 'bk_u%u_s%s_p%p_t%t'
    CURRENT CONTROLFILE;
RELEASE CHANNEL ch00;

allocate channel for maintenance type 'SBT_TAPE';
change archivelog all crosscheck;
run {
allocate channel t2 type 'sbt_tape' ;    
backup FORMAT 'arch-s%s-p%p-t%t' FILESPERSET 15
      (archivelog all delete input); 
release channel t2;}


run {
 sql 'ALTER TABLESPACE TSD_FINAN OFFLINE IMMEDIATE';
 allocate channel d1 type 'SBT_TAPE';
 set newname for datafile '/dev/rdrd/drd9' to '/dev/rdrd/drd27';
 set newname for datafile '/dev/rdrd/drd10' to '/dev/rdrd/drd31';
 restore tablespace tsd_finan;
 switch datafile all;
 recover tablespace TSD_FINAN;
 sql 'ALTER TABLESPACE TSD_FINAN ONLINE';
release channel d1; }


run {
 sql 'ALTER TABLESPACE TSD_FINAN OFFLINE IMMEDIATE';
 allocate channel d1 type 'SBT_TAPE';
 set newname for datafile '/dev/rdrd/drd9' to '/dev/rdrd/drd27';
 set newname for datafile '/dev/rdrd/drd10' to '/dev/rdrd/drd31';
 restore tablespace tsd_finan;
 switch datafile all;
 recover tablespace TSD_FINAN;
 sql 'ALTER TABLESPACE TSD_FINAN ONLINE';
release channel d1; }


run {
allocate channel d1 type 'SBT_TAPE';
set newname for datafile 6 to '/dev/rdrd/drd15';
set newname for datafile 19 to '/dev/rdrd/drd16';
restore datafile 12,13;
switch datafile all;
recover tablespace TSD_FINAN;
sql 'ALTER TABLESPACE TSD_FINAN ONLINE';
release channel d1; }


delete FORCE noprompt obsolete;

--************************************************************
-- RMAN 10g
--************************************************************

--rman target / rcvcat rman_prodsede/rman@rman_catalog
--rman target / rcvcat rman_prodsede_new/rman@rman_catalog
--rman target / rcvcat rman_prodsede2/rman@rman_catalog
--rman target / rcvcat rman_homolog/rman@rman_catalog
--rman target / rcvcat rman_bdportal/rman@rman_catalog
--rman target / rcvcat rman_case9i/rman@rman_catalog2
--rman target / rcvcat rman_ifr1c/rman@rman_catalog
--change archivelog all crosscheck;

run{
ALLOCATE CHANNEL c1 DEVICE TYPE sbt;
BACKUP ARCHIVELOG LIKE '/archifr2%' DELETE ALL INPUT;
}

BACKUP DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;
BACKUP INCREMENTAL LEVEL 1 DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;
BACKUP INCREMENTAL LEVEL 2 DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;


BACKUP ARCHIVELOG LIKE '/arch%' DELETE ALL INPUT;
BACKUP ARCHIVELOG ALL DELETE ALL INPUT;

--Configura os canais para os nós do RAC
CONFIGURE DEVICE TYPE sbt PARALLELISM 3;
CONFIGURE DEFAULT DEVICE TYPE TO sbt;
CONFIGURE CHANNEL 1 DEVICE TYPE sbt CONNECT 'SYS/hydro@SEBU122' PARMS 'ENV=(NSR_SERVER=bkserv1)';
CONFIGURE CHANNEL 2 DEVICE TYPE sbt CONNECT 'SYS/hydro@SEBU124' PARMS 'ENV=(NSR_SERVER=bkserv2)';
CONFIGURE CHANNEL 3 DEVICE TYPE sbt CONNECT 'SYS/hydro@SEBU125' PARMS 'ENV=(NSR_SERVER=bkserv3)';

--Limpa a configuração dos canais para os nós do RAC
CONFIGURE CHANNEL 1 DEVICE TYPE sbt CLEAR;

---
expdp operacao/infraero FULL=Y DIRECTORY=EXP_DUMP DUMPFILE=EXP_FULL.DPM LOGFILE=EXP_FULL.LOG PARALLEL=4

CREATE DIRECTORY export_ged AS '/u02/backup/export';
create user operacao identified by infraero default tablespace sysaux quota unlimited on sysaux;
GRANT CONNECT,RESOURCE,EXP_FULL_DATABASE TO OPERACAO;
GRANT READ ON DIRECTORY export_ged TO OPERACAO;
GRANT WRITE ON DIRECTORY export_ged TO OPERACAO;

--
create user rman_ecm2 identified by rman default tablespace tsd_rman quota unlimited on tsd_rman;
grant CONNECT,RESOURCE,RECOVERY_CATALOG_OWNER to rman_ecm2;

----
create catalog;
register database;
CONFIGURE DEFAULT DEVICE TYPE TO sbt;
CONFIGURE CHANNEL 1 DEVICE TYPE sbt format 'bkp_%U';
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE 'SBT_TAPE' TO '%F';


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
ORACLE_SID=homolog
export ORACLE_SID


#Local para link do netbackup com Oracle
/usr/openv/netbackup/bin




CONFIGURE DEFAULT DEVICE TYPE TO DISK;

CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/volorarman/rman_prodsede/%d_DB_%u_%s_%p';

CONFIGURE BACKUP OPTIMIZATION ON;

configure device type disk backuptype to compressed 

BACKUP AS COMPRESSED BACKUPSET DATABASE;