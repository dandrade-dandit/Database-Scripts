#!/bin/sh
ORACLE_HOME=/ora00/app/oracle/product/8.1.7
export ORACLE_HOME
ORACLE_BASE=/ora00/app
export ORACLE_BASE
PATH=$PATH:$ORACLE_HOME:$ORACLE_HOME/bin:/usr/bin:/etc:/usr/ccs/bin:/usr/bin/X11:/usr/local/bin:/usr/sbin
export PATH
ORACLE_SID=inet
export ORACLE_SID

/ora00/app/oracle/product/8.1.7/bin/sqlplus -s /nolog <<EOF
connect operacao/operacao@inet
set feedback off ;
set termout on ;
set pagesize 0 ;
spool /ora05/scripts/kill_sess.sh
select  'kill -9 ' || p.spid CMD_KILL_UNIX
from v\$session s, v\$process p
where p.addr = s.paddr
and s.sid in (select sid from v\$session
              where to_date(logon_time, 'dd/mm/yy') <> to_date(sysdate, 'dd/mm/yy')
              and username is not null)
/
spool off;
set feedback on;
set termout off;
set pages 45;
host chmod 750 /ora05/scripts/kill_sess.sh
host /ora05/scripts/kill_sess.sh
host rm -Rf /ora05/scripts/kill_sess.sh
EOF

echo linha para crontab...
echo /ora05/scripts/KillHoldSessions.sh