--USU�RIOS
spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\USUARIOS_ROLE_BDE_VIEWS.SQL

SELECT 'GRANT BDE_VIEWS TO ' || GRANTEE || ';'
FROM 	DBA_ROLE_PRIVS
WHERE   GRANTED_ROLE = 'BDE_VIEWS'
/
                                
SPO OFF

--ROLES

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_SRH_BEN_10.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || OWNER || '.' || TABLE_NAME || ' TO SRH_BEN_10;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'SRH_BEN_10'
ORDER BY
	OWNER
/
                                
SPO OFF

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_SRH_BEN_12.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SRH_BEN_12;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'SRH_BEN_12'
/
                                
SPO OFF

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_SRH_BEN_14.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO SRH_BEN_14;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'SRH_BEN_14'
/
                                
SPO OFF

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_COB_USR2.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO COB_USR2;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'COB_USR2'
/
                                
SPO OFF

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_ORC_DFOT2.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO ORC_DFOT2;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'ORC_DFOT2'
/
                                
SPO OFF

spo MIGRACOES\Migracao_Homolog\ROLES_DELETADAS\GRANTS_ROLE_ORC_EMP_DFOT2.SQL

SELECT 'GRANT ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' TO ORC_EMP_DFOT2;'
FROM 	DBA_TAB_PRIVS
WHERE   GRANTEE = 'ORC_EMP_DFOT2'
/
                                
SPO OFF