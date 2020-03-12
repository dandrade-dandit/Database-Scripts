select 'alter system kill session '''||SID||','||SERIAL#||''';' SQL
, to_char(logon_time, 'dd/mm/yy hh24:mi:ss') datahora, status, username
from v$session
where to_date(logon_time, 'dd/mm/yy') <> to_date(sysdate, 'dd/mm/yy')
and username is not null
/
