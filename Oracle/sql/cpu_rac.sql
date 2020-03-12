set linesize 200
set pagesize 1000
column machine format a30
column username format a15
column program format a60
SELECT INST_ID,SID,SERIAL# ,USERNAME ,machine,program
FROM GV$SESSION 
WHERE STATUS='ACTIVE' 
and username is not null
and username not in('SYSMAN','DBSNMP','SYSTEM')
ORDER BY INST_ID,username
/
