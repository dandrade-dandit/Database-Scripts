select owner||'.'||table_name||' '||grantee||' '||privilege
from dba_tab_privs
where table_name like 'LOG%' and
privilege in ('DELETE','UPDATE','INSERT')
order by owner,table_name,grantee