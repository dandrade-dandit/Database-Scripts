Select grantee from dba_ROLE_PRIVS
where granted_role = 'RESOURCE'
AND (grantee NOT LIKE '%SYS%' AND 
       grantee NOT LIKE '%ADMIN%' AND
       grantee NOT LIKE '%RMAN%' AND
       grantee NOT IN ('AURORA$JIS$UTILITY$','DBSNMP','ORDPLUGINS', 'OWF_MGR', 'OUTLN')) 
/


select 'insert into ifrbanco.tabelas values (''' || owner ||''',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
where owner IN (
Select grantee 
from dba_ROLE_PRIVS
where granted_role = 'RESOURCE'
AND (grantee NOT LIKE '%SYS%' AND 
       grantee NOT LIKE '%ADMIN%' AND
       grantee NOT LIKE '%RMAN%' AND
       grantee NOT IN ('AURORA$JIS$UTILITY$','DBSNMP','ORDPLUGINS', 'OWF_MGR', 'OUTLN', 'XDB')) 
)
and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
/
