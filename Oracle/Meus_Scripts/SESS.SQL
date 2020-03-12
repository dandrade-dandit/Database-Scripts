SET ECHO off
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') FROM DUAL;
SELECT COUNT(*) " total sessoes" FROM V$SESSION;
SELECT COUNT(*) " total ativos" FROM V$SESSION WHERE STATUS='ACTIVE';
set echo on