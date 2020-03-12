SELECT  s.SID
, 	    s.SERIAL#
,      	s.USERNAME
, 	    'alter system kill session '''||s.SID||','||s.SERIAL#||''';' CMD_KILL_ORACLE
, 	     to_char(s.logon_time, 'dd/mm/yy hh24:mi:ss') datahora
,	     s.OSUSER
FROM    V$SESSION S
WHERE   USERNAME IN (
SELECT  'I'  || SUBSTR(EMP_NUMERO_MATRICULA + 10000000, 2, 7)
FROM    CADASTROS
WHERE   EMP_NUMERO_MATRICULA IN (
    SELECT  DISTINCT (SUBSTR(USERNAME, 2, 7))
    FROM    V$SESSION
    WHERE   USERNAME LIKE 'I%' 
    AND     USERNAME NOT LIKE 'IFR%' 
    AND     USERNAME NOT LIKE 'INFRA%' 
    AND     USERNAME NOT LIKE 'INTEGRA%')
AND EMP_DEP_CODIGO_FISICO = 1 )
UNION
SELECT  s.SID
, 	    s.SERIAL#
,      	s.USERNAME
, 	    'alter system kill session '''||s.SID||','||s.SERIAL#||''';' CMD_KILL_ORACLE
, 	     to_char(s.logon_time, 'dd/mm/yy hh24:mi:ss') datahora
,	     s.OSUSER
FROM    V$SESSION S
WHERE   USERNAME LIKE 'T%'
AND     USERNAME NOT LIKE 'TECA%' 
UNION
SELECT  s.SID
, 	    s.SERIAL#
,      	s.USERNAME
, 	    'alter system kill session '''||s.SID||','||s.SERIAL#||''';' CMD_KILL_ORACLE
, 	     to_char(s.logon_time, 'dd/mm/yy hh24:mi:ss') datahora
,	     s.OSUSER
FROM    V$SESSION S
WHERE   USERNAME LIKE 'E%'
AND     USERNAME NOT LIKE 'TECA%' 