set linesize 140
col spid for a6
col program for a35 trunc
select p.spid SPID,to_char(s.LOGON_TIME,'DDMonYY HH24:MI') date_login,s.username,decode(nvl(p.background,0),1,bg.description, s.program ) program,
ss.value/100 CPU,physical_reads disk_io,(trunc(sysdate,'J')-trunc(logon_time,'J')) days,
round((ss.value/100)/(decode((trunc(sysdate,'J')-trunc(logon_time,'J')),0,1,(trunc(sysdate,'J')-trunc(logon_time,'J')))),2) cpu_per_day 
from V$PROCESS p,V$SESSION s,V$SESSTAT ss,V$SESS_IO si,V$BGPROCESS bg
where s.paddr=p.addr and ss.sid=s.sid
and ss.statistic#=12 and si.sid=s.sid
and bg.paddr(+)=p.addr 
and round((ss.value/100),0) > 10 
order by 8;

select S.USERNAME||'('||s.sid||')-'||s.osuser UNAM
-- ,s.program||'-'||s.terminal||'('||s.machine||')' PROG
,s.sid||'/'||serial# sid
,s.status "Status"
,sql_text sqltext
from v$sqltext_with_newlines t,V$SESSION s
where t.address =s.sql_address
and t.hash_value = s.sql_hash_value 
and s.sid = 2601
order by s.sid,t.piece

select a.sid, a.serial#, b.sql_text
from v$session a, v$sqlarea b
where a.sql_address=b.address
and a.sid = 2601;

select 
   blocking_session, 
   sid, 
   serial#, 
   wait_class,
   seconds_in_wait
from 
   v$session
where 
   blocking_session is not NULL
order by 
   blocking_session;
   

SELECT s.sid, s.serial#, s.username, s.program, i.physical_reads, i.block_changes
FROM v$session s, v$sess_io i
WHERE s.sid = i.sid
ORDER BY 6 desc
/

select 
s.osuser, 
p.spid "PID", 
s.sid "SID", 
s.terminal, 
s.program, 
s.status, 
to_char(logon_time, 'DD-MON HH24:MI:SS') "Login Time" 
from 
v$session s, 
v$process p 
where p.addr = s.paddr 
and s.osuser != 'oracle' 
order by sid, s.status;

--222 I9435685    20597   2601    SE10303985      ACTIVE  06-SET 14:47:28
--*********************************************************************************************************************
set linesize 140
col spid for a6
col program for a35 trunc
select p.spid SPID,to_char(s.LOGON_TIME,'DDMonYY HH24:MI') date_login,s.username,decode(nvl(p.background,0),1,bg.description, s.program ) program,
ss.value/100 CPU,physical_reads disk_io,(trunc(sysdate,'J')-trunc(logon_time,'J')) days,
round((ss.value/100)/(decode((trunc(sysdate,'J')-trunc(logon_time,'J')),0,1,(trunc(sysdate,'J')-trunc(logon_time,'J')))),2) cpu_per_day 
from V$PROCESS p,V$SESSION s,V$SESSTAT ss,V$SESS_IO si,V$BGPROCESS bg
where s.paddr=p.addr and ss.sid=s.sid
and ss.statistic#=12 and si.sid=s.sid
and bg.paddr(+)=p.addr 
and round((ss.value/100),0) > 10 
order by 8;

--*********************************************************************************************************************
set verify off lines 192 head on 

col UNAM format a20 word heading 'User'
col STMT format a56 word heading 'Statement'
col RUNT format a08 word heading 'Run Time'
col ltim format a20 word heading 'Logon Time'
col etim format a20 word heading 'Connect Time'
col PROG format a30 word heading 'Program|Client Terminal Details'
col SID format a10 word heading 'SID/|Serial#'
col DR format 999999999 heading 'Disk Reads'
col BG format 999999999 heading 'Buffer Gets'
col sqltext format A64 wrap heading 'Last SQL'

select S.USERNAME||'('||s.sid||')-'||s.osuser UNAM
-- ,s.program||'-'||s.terminal||'('||s.machine||')' PROG
,s.sid||'/'||serial# sid
,s.status "Status"
,sql_text sqltext
from v$sqltext_with_newlines t,V$SESSION s
where t.address =s.sql_address
and t.hash_value = s.sql_hash_value 
order by s.sid,t.piece

--*********************************************************************************************************************



--*********************************************************************************************************************




--*********************************************************************************************************************




--*********************************************************************************************************************
