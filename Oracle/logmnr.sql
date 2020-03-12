--maquina4
exec dbms_logmnr_d.build('ifr1adict.ora', '/u01/backup/bkp_arch');

exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_760.arc', dbms_logmnr.NEW);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_761.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_762.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_763.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_764.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_765.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_766.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_767.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_768.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bkp_arch/arch_1_769.arc', dbms_logmnr.ADDFILE);

exec dbms_logmnr.start_logmnr(dictfilename=>'/u01/backup/bkp_arch/ifr1adict.ora', starttime=>to_date('11/02/2003 05:00:00', 'DD/MM/YYYY HH24:MI:SS'), endtime=>to_date('11/02/2003 23:00:00', 'DD/MM/YYYY HH24:MI:SS'));


--maquina5
exec dbms_logmnr_d.build('ifr1bdict.ora', '/u01/backup/bck_arch');

exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_489.arc', dbms_logmnr.NEW);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_490.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_491.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_492.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_493.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_494.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_495.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_496.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_497.arc', dbms_logmnr.ADDFILE);
exec dbms_logmnr.add_logfile('/u01/backup/bck_arch/arch_2_498.arc', dbms_logmnr.ADDFILE);

exec dbms_logmnr.start_logmnr(dictfilename=>'/u01/backup/bck_arch/ifr1bdict.ora', starttime=>to_date('11/02/2003 00:01:00', 'DD/MM/YYYY HH24:MI:SS'), endtime=>to_date('13/02/2003 00:01:00', 'DD/MM/YYYY HH24:MI:SS'));


create table trace_movimentacao (
	timestamp	date
, 	sql_undo	VARCHAR2(4000)
, 	sql_redo	VARCHAR2(4000)
, 	row_id		VARCHAR2(19)
, 	table_space	VARCHAR2(32)
, 	seg_owner	VARCHAR2(32)
, 	seg_name        VARCHAR2(32)
, 	seg_type_name   VARCHAR2(32)
, 	session#        number
, 	serial#		number
, 	username	VARCHAR2(32)
, 	operation	VARCHAR2(32)
, 	info		VARCHAR2(32)
, 	status          NUMBER
,	host 		varchar2(10)
)                       
                        

insert into ifrsrh.trace_movimentacao
select timestamp, sql_undo, sql_redo, row_id, table_space,seg_owner, 
seg_name, seg_type_name, session#, serial#, username, operation, info, status, 's-sebu04'
from v$logmnr_contents where seg_name like '%MOV%';

exec dbms_logmnr.end_logmnr;
