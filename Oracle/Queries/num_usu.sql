set feed on
SELECT INST_ID,SID,SERIAL# ,USERNAME ,STATUS,server,machine,program
FROM GV$SESSION
WHERE  username is not null
and username not in ('SYSTEM','SYS','DBSNMP','SYSMAN')
ORDER BY INST_ID,username
/


SELECT INST_ID,COUNT(*) CONECTADOS
FROM GV$SESSION
WHERE  username is not null
and username not in ('SYSTEM','SYS','DBSNMP','SYSMAN')
GROUP BY INST_ID
ORDER BY INST_ID
/


SELECT INST_ID,COUNT(*) ATIVOS
FROM GV$SESSION
WHERE  username is not null
and username not in ('SYSTEM','SYS','DBSNMP','SYSMAN')
and status ='ACTIVE'
GROUP BY INST_ID
ORDER BY INST_ID
/


