set heading off
SET FEEDBACK OFF
set verify off

SPOOL C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\LOG_SINONIMOS_SEM_OBJETOS.LOG

SELECT 'DROP '||A.OWNER||' SYNONYM '||A.TABLE_OWNER||'.'||A.TABLE_NAME||';'
FROM DBA_SYNONYMS A
WHERE   A.TABLE_OWNER LIKE 'IFR%' AND
               A.TABLE_OWNER||A.TABLE_NAME NOT IN (SELECT B.OWNER||B.OBJECT_NAME
                                                                                      FROM DBA_OBJECTS B
                                                                                      WHERE B.OBJECT_NAME=A.TABLE_NAME AND 
                                                                                                   B.OBJECT_TYPE<>'SYNONYM')
ORDER BY A.TABLE_OWNER,A.TABLE_NAME;
SPOOL OFF