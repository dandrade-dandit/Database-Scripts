spool rec_query1.out
set echo on
set pagesize 2000 linesize 200 trimspool on
col name form a60
col status form a10
col dbname form a15
col member form a60
col inst_id form 999
col resetlogs_time form a25
col created form a25
col DB_UNIQUE_NAME form a15
col stat form 9999999999

alter session set nls_date_format='DD-MM-RR hh24:mi:ss';

select dbid, name dbname, open_mode, database_role,
to_char(created,'dd-Mon-YYYY hh24:mi:ss') created,
to_char(resetlogs_time,'dd-Mon-YYYY hh24:mi:ss') resetlogs_time
from v$database;

archive log list;

select count(*) from v$backup where status = 'ACTIVE';

select * from v$log;
select * from v$logfile;
select * from v$recover_file order by 1;

select distinct(status)from v$datafile;
select FILE#,TS# , status, NAME from v$datafile
where status not in ('SYSTEM','ONLINE')
order by 1;

select fhsta, count(*)
from X$KCVFH group by fhsta;

select min(fhrba_Seq), max(fhrba_Seq)
from X$KCVFH;

select hxfil FILE#,fhsta STAT,fhscn SCN,
fhrba_Seq SEQUENCE,fhtnm TABLESPACE
from x$kcvfh order by 1;

spool off
