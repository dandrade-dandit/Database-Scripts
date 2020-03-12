Select a.GRANTEE, a.GRANTED_ROLE, a.ADMIN_OPTION, a.DEFAULT_ROLE
From dba_role_privs a
, (Select  grantee, count(*) Qtd
from dba_role_privs
where GRANTED_ROLE like '&1%'
group by grantee
having count(*) > 1) b
where a.grantee = b.grantee
and a.GRANTED_ROLE like '&1%'
and a.grantee <> 'SYSTEM'
/
