DECLARE @DATABASE varchar(30)
,		@sql varchar(4000)

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	LTRIM(RTRIM(name )) name
FROM	master..sysdatabases
WHERE	name not in ('tempdb', 'model', 'msdb')

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DATABASE
WHILE @@FETCH_STATUS = 0
BEGIN

	PRINT 'Use ' + @DATABASE

	SET @sql = 'Use ' + @DATABASE + CHAR(13) 

	SET @sql = @sql + 'set nocount on ' + CHAR(13)


	SET @sql = @sql + 'PRINT ''--SCRIPT PARA GERAÇÃO DAS ROLES''' + CHAR(13)

	--para ROLES
	SET @sql = @sql + 'SELECT	''CREATE ROLE ['' + name + ''];''' + CHAR(13)
	SET @sql = @sql + 'FROM	sysusers' + CHAR(13)
	SET @sql = @sql + 'WHERE	name not in (''DBSSecurity'',''guest'',''dbo'',''public'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'',''Backup$Operators'')' + CHAR(13)
	SET @sql = @sql + 'AND		issqlrole = 1' + CHAR(13)


	SET @sql = @sql + 'PRINT ''--SCRIPT PARA GERAÇÃO DOS USUÁRIOS''' + CHAR(13)
	--para USER
	SET @sql = @sql + 'SELECT	''CREATE USER ['' + name + ''] WITH DEFAULT_SCHEMA = [dbo];'' ' + CHAR(13)
	SET @sql = @sql + 'FROM	sysusers' + CHAR(13)
	SET @sql = @sql + 'WHERE	name not in (''DBSSecurity'',''guest'',''dbo'',''public'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'',''Backup$Operators'')' + CHAR(13)
	SET @sql = @sql + 'AND		issqlrole = 0' + CHAR(13)



	SET @sql = @sql + 'PRINT ''--SCRIPT PARA GERAÇÃO DA RELAÇÃO USUÁRIOS POR ROLES''' + CHAR(13)
	SET @sql = @sql + 'SELECT	''exec sp_addrolemember N'''''' + (select name from sysusers where issqlrole = 1 and uid = groupuid) + '''''', '''''' + (select name from sysusers where issqlrole = 0 and uid = memberuid) + ''''''''' + CHAR(13)
	SET @sql = @sql + 'FROM	sysmembers ' + CHAR(13)
	
	EXECUTE (@sql)
	--print @sql

	FETCH
	NEXT
	FROM _databases
	INTO
	@DATABASE
END
CLOSE _databases
DEALLOCATE _databases

/*
sp_grantdbaccess 

sp_addrole [ @rolename = ] 'role' [ , [ @ownername = ] 'owner' ] 


sp_adduser @loginame = 'leo'

*/