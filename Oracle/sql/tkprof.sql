--tkprof ora_1221.trc output.log sort=prsdsk,exedsk,fchdsk print=10
C:\oracle\product\10.2.0\client_1\BIN\tkprof d:\temp\ifr1a_ora_2621.trc d:\temp\output.log explain=ifrdba/xpto@prodsede2 table=IFRDBA.SQLN_EXPLAIN_PLAN insert=storea.sql sys=no sort=execpu,fchcpu

tkprof ifrprod2_ora_13895.trc output_sess4.log explain=ifrdba/xpto table=IFRDBA.SQLN_EXPLAIN_PLAN insert=storea_sess4.sql sys=no sort=execpu,fchcpu

tkprof ifrprod1_ora_1353.trc output.log explain=ifrdba table=ifrdba.plan_table insert=storea.sql sys=no sort=execpu,fchcpu

tkprof ifrprod2_s011_6235.trc output2.log

SELECT s.SID, s.SERIAL#, s.USERNAME, s.OSUSER, s.STATUS, s.SERVER, s.Program --,s.TERMINAL
FROM v$session s
WHERE s.USERNAME NOT IN (' ')
--AND   s.USERNAME =  'SYSAD'
ORDER BY
   s.SERVER
,  s.OSUSER
,  s.USERNAME
/

execute sys.dbms_system.set_sql_trace_in_session(2355,58131, true);

execute sys.dbms_support.start_trace_in_session(10,20,waits=>true,binds=>true);

--10g
EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(2355,58131  , true, FALSE);

------*********************************************************************************
--86
EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(609, 2296  , true, true);

EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(907,	29972  , true, true);

--87
EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(1182,	2908  , true, true);

EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(1348,	1408  , true, true);

select  *
  from  v$session
 where  username = 'IFRMAXIMO'


select 	s.SID
, 	s.SERIAL#
,      	s.USERNAME
, 	'alter system DISCONNECT session '''||s.SID||','||s.SERIAL#||''' IMMEDIATE;' CMD_KILL_ORACLE
,   'execute sys.dbms_system.set_sql_trace_in_session('||s.SID||','||s.SERIAL#||', true);' CMD_TKPROF
from v$session s
where username = 'IFRMAXIMO'

 
 --pegar a informação da coluna PADDR...
 
 select *
   from v$process
  where addr IN (
'0000000491D4F290',
'0000000491D3EE90',
'0000000491D3AD90',
'0000000491D3FED0',
'0000000491D40F10',
'0000000491D3CE10',
'0000000491D3DE50',
'0000000491D41F50')

------*********************************************************************************
--86  
exec dbms_monitor.session_trace_disable(907,	29972);

--87
exec dbms_monitor.session_trace_disable(1348,1408);
  
--***********************************************************

4,0K -rw-r-----  1 oracle asmadmin 2,3K Nov 22 13:36 ifrprod1_ora_26233.trc
4,0K -rw-r-----  1 oracle asmadmin   98 Nov 22 13:36 ifrprod1_ora_26233.trm
4,0K -rw-r-----  1 oracle asmadmin 2,3K Nov 22 13:35 ifrprod1_ora_30680.trc
4,0K -rw-r-----  1 oracle asmadmin   97 Nov 22 13:35 ifrprod1_ora_30680.trm
4,0K -rw-r-----  1 oracle asmadmin 1,6K Nov 22 13:36 ifrprod1_ora_4454.trc
4,0K -rw-r-----  1 oracle asmadmin   73 Nov 22 13:36 ifrprod1_ora_4454.trm
4,0K -rw-r-----  1 oracle asmadmin 1,3K Nov 22 13:35 ifrprod1_ora_4700.trc
4,0K -rw-r-----  1 oracle asmadmin   63 Nov 22 13:35 ifrprod1_ora_4700.trm

/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod1/trace/ifrprod1_ora_1353.trc
/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod1/trace/ifrprod1_ora_20043.trc
/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod1/trace/ifrprod1_ora_12119.trc
/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod1/trace/ifrprod1_ora_12117.trc

  
--87

EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(2006, 3347  , true, true);

EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(1461, 22812  , true, true);

execute sys.dbms_system.set_sql_trace_in_session(1461, 22812,true);

execute sys.dbms_system.set_sql_trace_in_session(2006, 3347,true);


[oracle@s-sebu87 trace]$ ls -lsah
total 1,4M
1,4M drwxr-xr-x  2 oracle asmadmin 1,4M Nov 22 13:44 .
4,0K drwxr-xr-x 13 oracle asmadmin 4,0K Set  3 17:49 ..
4,0K -rw-r-----  1 oracle asmadmin  715 Nov 22 13:42 alert_ifrprod2.log
4,0K -rw-r-----  1 oracle asmadmin 1,7K Nov 22 13:44 ifrprod2_lmd0_8674.trc
4,0K -rw-r-----  1 oracle asmadmin  180 Nov 22 13:44 ifrprod2_lmd0_8674.trm
8,0K -rw-r-----  1 oracle asmadmin 4,7K Nov 22 13:42 ifrprod2_ora_10212.trc
4,0K -rw-r-----  1 oracle asmadmin  176 Nov 22 13:42 ifrprod2_ora_10212.trm
4,0K -rw-r-----  1 oracle asmadmin 1,3K Nov 22 13:42 ifrprod2_ora_14384.trc
4,0K -rw-r-----  1 oracle asmadmin   64 Nov 22 13:42 ifrprod2_ora_14384.trm
4,0K -rw-r-----  1 oracle asmadmin 1,3K Nov 22 13:44 ifrprod2_ora_2401.trc
4,0K -rw-r-----  1 oracle asmadmin   63 Nov 22 13:44 ifrprod2_ora_2401.trm
4,0K -rw-r-----  1 oracle asmadmin 1,6K Nov 22 13:42 ifrprod2_ora_2604.trc
4,0K -rw-r-----  1 oracle asmadmin   73 Nov 22 13:42 ifrprod2_ora_2604.trm
4,0K -rw-r-----  1 oracle asmadmin 1,6K Nov 22 13:44 ifrprod2_ora_3356.trc
4,0K -rw-r-----  1 oracle asmadmin   74 Nov 22 13:44 ifrprod2_ora_3356.trm
4,0K -rw-r-----  1 oracle asmadmin 1,9K Nov 22 13:44 ifrprod2_ora_3639.trc
4,0K -rw-r-----  1 oracle asmadmin   84 Nov 22 13:44 ifrprod2_ora_3639.trm
[oracle@s-sebu87 trace]$
[oracle@s-sebu87 trace]$

/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod2/trace/ifrprod2_ora_28846.trc
/u01/rdbms/oracle/diag/rdbms/ifrprod/ifrprod2/trace/ifrprod2_ora_22503.trc



--**************************************
TRACE ANALYZER

ALTER SESSION SET EVENTS '10046 TRACE NAME CONTEXT FOREVER, LEVEL 12';

@trcanlzr.sql desenv_ora_1245.trc

:ONDE desenv_ora_1245.trc DEVE ESTAR NO DIRETÓRIO /u01/app/oracle/diag/rdbms/desenv/desenv/trace

--1
select p.PID,p.SPID,s.SID
from v$process p,v$session s
where s.paddr = p.addr
and s.username = 'IFRMAXIMO'
/

--2 (PID)
connect / as sysdba
oradebug setorapid 44
oradebug unlimit
oradebug event 10046 trace name context forever,level 12


--3
oradebug event 10046 trace name context off


--Oracle pid: 44, Unix process pid: 32311, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 46, Unix process pid: 32313, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 47, Unix process pid: 1249, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 48, Unix process pid: 32315, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 49, Unix process pid: 32317, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 50, Unix process pid: 32319, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 51, Unix process pid: 32321, image: oracle@s-sebd71.infraero.gov.br
--Oracle pid: 64, Unix process pid: 31023, image: oracle@s-sebd71.infraero.gov.br


@trcanlzr.sql desenv_ora_1249.trc
@trcanlzr.sql desenv_ora_32311.trc
@trcanlzr.sql desenv_ora_32313.trc
@trcanlzr.sql desenv_ora_32315.trc
@trcanlzr.sql desenv_ora_32317.trc
@trcanlzr.sql desenv_ora_32319.trc
@trcanlzr.sql desenv_ora_32321.trc
desenv_ora_32323.trc

