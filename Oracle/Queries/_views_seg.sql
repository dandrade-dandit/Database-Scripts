--SQL SERVER 2005

CREATE VIEW VIW_TABLE_PRIVILEGES AS
SELECT * FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
GO
CREATE VIEW VIW_ROLE_PRIVILEGES AS
SELECT	u.name 'GRANTEE', dp.name as 'GRANTED_ROLE'
FROM	sys.database_role_members drm
,		sys.database_principals dp
,		sys.sysusers u
WHERE	dp.type = 'R'
and		dp.principal_id =drm.role_principal_id
and		drm.member_principal_id = u.uid
and     u.name != 'dbo'
GO


grant select on VIW_ROLE_PRIVILEGES to public
GO

grant select on VIW_TABLE_PRIVILEGES to public


--ORACLE
grant select on dba_tab_privs to ifrbanco with grant option;

grant select on dba_role_privs to ifrbanco with grant option;

CREATE OR REPLACE VIEW IFRBANCO.VIW_TABLE_PRIVILEGES AS SELECT * FROM sys.dba_tab_privs;

CREATE OR REPLACE VIEW IFRBANCO.VIW_ROLE_PRIVILEGES AS SELECT * FROM sys.dba_role_privs;

CREATE PUBLIC SYNONYM VIW_TABLE_PRIVILEGES FOR IFRBANCO.VIW_TABLE_PRIVILEGES;

CREATE PUBLIC SYNONYM VIW_ROLE_PRIVILEGES FOR IFRBANCO.VIW_ROLE_PRIVILEGES;

GRANT SELECT ON VIW_TABLE_PRIVILEGES TO PUBLIC;

GRANT SELECT ON VIW_ROLE_PRIVILEGES TO PUBLIC;
