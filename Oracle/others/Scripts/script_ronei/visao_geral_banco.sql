rem  ==========================================================================
rem  File      : <b>DBMap.sql</b>
rem  date      :  2-Dec-1998
rem  author    : R. Schierbeek
rem  copyright : Bytelife bv Netherlands
rem
rem  uses: dba_segments, dba_data_files, v$logfile, v$log
rem  comp: Oracle 7, Oracle 8
rem  desc: Shows database information: owners, # of tables, indexes etc.
rem  outp: Generates a DBMAP.htm file, suitable for any browser.
rem  Instruction: * Change the spool file or directory, when needed. 
rem               * Connect as SYSTEM.
rem               * Start the script.
rem  ==========================================================================
rem  Modifications 
rem   2-sep-00  Layout improved
rem  25-jun-01  spool to C:\temp\DBMAP||name.htm
rem  26-jul-01  Auto-extending datafiles
rem  16-aug-01  Tables with chained rows 
rem  ==========================================================================
clear columns breaks
col owner format A12 trunc
set feed off head off echo off verify OFF wrap OFF trimspool ON
set linesize 300
define spooldir=C:\temp\

prompt spooling to file &spooldir\DBMAP.htm ...

set term OFF verify off echo off feed off wrap off heading off 
spool tmpspool.sql
   select 'spool &spooldir\DBMAP'||name||'.htm'
   from  v$database  ;
spool off
@tmpspool.sql
host del tmpspool.sql

prompt <html><head>
prompt <meta name="description" content="generated by dbMap.sql- bytelife bv">
prompt <title>Database information </title> </head><body>
prompt <a name="top"></a>

prompt <table cellpadding=2 width=670 cellpadding=3 cellspacing=0 border=3>
prompt <tr bgcolor=#EFEFEF><td colspan=3 align=center>
prompt <font size=5 color=#333366> Database report </font>
prompt <tr bgcolor=#EFEFEF><td>
select '<font size=4 color=#333366>database: <b>'||name  
from   v$database ;
select '<td><font size=4> date: '||to_char(sysdate,'DD-mon-YYYY')
from   dual;
select '<td><font size=4> time: '||to_char(sysdate,'HH:MI')
from   dual;
prompt </table>

prompt <p></p>
prompt <h3> Tables and indexes </h3>

prompt <blockquote> <font face=Courier size=2>
prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> owner
prompt <td> tablespace 
prompt <td> type
prompt <td align=RIGHT><font face=Courier size=2>Nr. of objects
set wrap on

select '<tr><td> '||owner
      ,'<td> <a href=#'||tablespace_name||'>'||tablespace_name||'</a>'
      ,'<td> '||segment_type
      ,'<td align=RIGHT><font face=Courier size=2>'||count(*)
from   sys.dba_segments
where  owner != 'SYS'
group by owner,tablespace_name,segment_type
/
prompt </table></blockquote></font>

prompt <h3> Tablespaces and datafiles </h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=2 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> tablespace 
prompt  <td> file name
prompt  <td align=RIGHT><font face=Courier size=2>Kbyte
set wrap on

select '<tr><td> <a name='||tablespace_name||'>'||tablespace_name||'</a>' 
      ,'<td> '||file_name
      ,'<td align=right><font face=Courier size=2>'||trunc(bytes/1024,0)
from   sys.DBA_data_files 
order by tablespace_name,file_name
/
prompt </table> <p>


prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> tablespace 
prompt  <td> status
prompt  <td> contents
set wrap on

select '<tr><td> '
        ||tablespace_name||'</a>' 
      ,'<td> '||status
      ,'<td> '||decode(contents,'TEMPORARY'
                                                 ,'<font color=BLUE>TEMPORARY'
                                                 ,contents)                   
from   sys.DBA_tablespaces
order by tablespace_name
/
prompt </table></blockquote></font><p>

prompt <h3> Auto-extending datafiles </h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> Nr.
prompt  <td> file name
prompt  <td> Kbyte
prompt  <td> Maxsize Kb
prompt  <td> Increase Kb
prompt <tr bgcolor=#EFEFEF><td colspan=5>

col name    format A60
col KBYTE   format 999,999,999
col Maxsize format 999,999,999
col Increase format 999,999,999

select '<tr><td>'||X.FILE#
      ,'<td>'||F.FILE_NAME              name
      ,'<td>'||F.bytes/1024             KBYTE
      ,'<td>'||(MAXEXTEND * value)/1024 Maxsize
      ,'<td>'||(INC * value)/1024       Increase
from   sys.filext$     X
      ,dba_data_files  F
      ,v$parameter     P
where  F.file_id = X.FILE#
and    P.name = 'db_block_size'
/
prompt </table></blockquote></font>

prompt Note: if table filext$ doen't exist then the files are not auto-extending. <p>
prompt <a href=#top>goto top</a>

col member format A40
prompt <h3> Control and Log files</h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF>  
prompt  <td> group   <td>Logfile member

select '<tr><td>',group#
      ,'<td>'||   member 
from  v$logfile
order by group#,member ;

prompt <tr bgcolor=#EFEFEF>  
prompt  <td> nr   <td>Controlfile name 

select '<tr><td>',rownum
      ,'<td>'||   name
from  v$controlfile ;
prompt </table></blockquote></font>


prompt <h3> Archive, Init and Alert files</h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>

prompt <tr bgcolor=#EFEFEF>  
prompt  <td> name   <td> location

col value format A70 trunc
select '<tr><td>',initcap(name)||' : '
      ,'<td>'||  value  from   v$parameter where  name in 
  ('ifile','background_dump_dest','log_archive_dest' ) ;

prompt </table></blockquote></font>

prompt <h3> Misplaced indexes </h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF>  
prompt   <td>Table owner <td>Table name
prompt   <td>Index owner <td>Index name

select '<tr><td>'||T.owner
      ,'<td>'||T.table_name
      ,'<td>'||I.owner
      ,'<td>'||I.index_name
from   DBA_TABLES   T
      ,DBA_INDEXES  I
where  T.table_name = I.table_name
and    T.owner      = I.table_owner
and    I.owner != T.owner
order by T.owner,I.owner
/
prompt </table></blockquote></font>


col SX for A30 head 'Index' trunc
col SY for A30 head 'Table' trunc
col I1 for 999,999,999 head 'Index size'
col TS for 999,999,999 head 'Table size' 

prompt <h3>Indexes which are quite large compared to table they're on</h3>
prompt <blockquote><font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF>  
prompt  <td>Index <td align=right> Kbyte <td align=right> extents
prompt  <td>Table <td align=right> Kbyte <td align=right> extents

select '<tr><td>'||       S1.segment_name SX
      ,'<td align=right>',S1.bytes/1024   I1
      ,'<td align=right>',S1.extents
      ,'<td>'||           S2.segment_name SY
      ,'<td align=right>',S2.bytes/1024   TS
      ,'<td align=right>'||S2.extents
from  dba_segments S1
     ,dba_segments S2
     ,dba_indexes  I
where I.INDEX_NAME =S1.segment_name
and   I.TABLE_NAME =S2.segment_name
and   S1.bytes >= S2.bytes*1.4
and   S1.bytes > 2000000
and   I.owner not in ('SYS')
/
prompt </table></blockquote> </font>


prompt <h3> Procedures and Package body's</h3>
prompt <blockquote> <font face=Courier size=2>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF> <td>Owner
prompt   <td> Name <td>Type <td>status <td align=right> lines 

select '<tr><td>'||S.Owner
      ,'<td>'||name
      ,'<td>'||initcap(type)
      ,'<td>'||lower(status)
      ,'<td align=right>'||max(line) Lines
from   dba_source  S
      ,dba_objects O
where  S.name  = O.object_name
and    S.type  = O.object_type
and    S.OWNER not in ('SYS')
and    S.type in ('PACKAGE BODY','PROCEDURE','FUNCTION')
group by S.OWNER,NAME,initcap(type),lower(status)
order by S.OWNER,NAME
/
prompt </table></blockquote></font> 


prompt <h3> Objects changed in the last 30 days ordered by LAST_DDL_TIME DESC</h3>
prompt <blockquote> <font face=Times size=1>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF> <td> Owner   <td> Name
prompt   <td> Name <td> Created <td>Last DDL<br>Change <td>status

col O1 for A22 trunc
col N2 for A40 trunc
col D1 for A16
col D2 for A16

select '<tr><td>'||OWNER   O1
      ,'<td>'||OBJECT_NAME N2
      ,'<td>'||initcap(OBJECT_TYPE)
      ,'<td>'||to_char(CREATED,'DD-MM-YY')       D1
      ,'<td>'||to_char(LAST_DDL_TIME,'DD-MM-YY') D2
      ,'<td>'||lower(status)
from  dba_objects
where  sysdate - LAST_DDL_TIME < 30
and status != 'INVALID'
order by LAST_DDL_TIME DESC
/
prompt </table></blockquote></font> 



prompt <h3> Invalid objects </h3>
prompt <blockquote> <font face=Times size=1>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF> <td> Owner  <td> Name
prompt   <td> Name <td> Created <td>Last DDL<br>Change <td>status

select '<tr><td>'||OWNER   O1
      ,'<td>'||OBJECT_NAME N2
      ,'<td>'||initcap(OBJECT_TYPE)
      ,'<td>'||to_char(CREATED,'DD-MM-YY')       D1
      ,'<td>'||to_char(LAST_DDL_TIME,'DD-MM-YY') D2
      ,'<td>'||lower(status)
from  dba_objects
where status='INVALID'
order by OWNER,OBJECT_NAME
/
prompt </table></blockquote></font> 

prompt <h3> Number of analyzed tables </h3>
prompt <blockquote> <font face=Times size=1>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> Owner <td> Count

select '<tr><td>'||OWNER   O1
      ,'<td>'||count(*)  N2
from   dba_tables
where  num_rows >= 0
group by OWNER 
/
prompt </table></blockquote></font> 


prompt <h3> Tables with chained rows (only analyzed tables)</h3>
prompt <blockquote> <font face=Times size=1>

prompt <table border=0 cellpadding=1 cellspacing=0 width=630>
prompt <tr bgcolor=#EFEFEF><td> Owner <td>table name <td align=right> Totalrows
prompt   <td align=right>Chained rows <td align=right>chainded/<br>total rows Pct

select '<tr><td>'||OWNER   O1
      ,'<td>'||table_name  N2
      ,'<td align=right>'||num_rows
      ,'<td align=right>'||chain_cnt
      ,'<td align=right>'||trunc((100 * chain_cnt/num_rows),1 )
from   dba_tables
where  CHAIN_CNT > 0
order by CHAIN_CNT  DESC
/
prompt </table></blockquote></font> 

prompt <hr>
prompt <font size=-1>
prompt <a href=#top>goto top</a>
prompt <p align=RIGHT>
select 'Generated on : '||TO_CHAR(sysdate,'DD-MON-YYYY') from dual ;

prompt </body></html>
spool OFF

set head on feed on term ON linesize 90
prompt  End of dbMap script


