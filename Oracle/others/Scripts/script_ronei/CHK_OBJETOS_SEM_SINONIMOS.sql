set heading off
SET FEEDBACK OFF
set verify off

SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\LOG_OBJETOS_SEM_SINONIMOS.LOG

SELECT 'DROP '||A.OBJECT_TYPE||' '||A.OWNER||'.'||A.OBJECT_NAME||';'
FROM DBA_OBJECTS A
WHERE   A.OWNER LIKE 'IFR%' AND A.OBJECT_TYPE NOT IN ('INDEX','TRIGGER') AND
               A.OWNER||A.OBJECT_NAME NOT IN (SELECT B.TABLE_OWNER||B.TABLE_NAME
                                                                           FROM DBA_SYNONYMS B
                                                                           WHERE B.TABLE_OWNER=A.OWNER AND 
                                                                                        B.TABLE_NAME=A.OBJECT_NAME)
ORDER BY A.OBJECT_TYPE,A.OWNER,A.OBJECT_NAME;

SPOOL OFF