DECLARE @DATABASE varchar(30)
,		@sql varchar(4000)

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	LTRIM(RTRIM(name )) name
FROM	master.sys.databases
WHERE	name NOT IN ('DBSCOMMON','DBSallc','DBSarpc','DBSbank','DBSbdgt','DBSbill','DBScand','DBScfrm','DBScmre',
'DBScntl','DBScons','DBScost','DBScred','DBSctlg','DBSdbis','DBSdclm','DBSdemo','DBSentp','DBSeuro','DBSfast',
'DBSfund','DBSfwrk','DBSglep','DBShist','DBSiplm','DBSjepc','DBSmabl','DBSosst','DBSosxp','DBSotpm','DBSpcde',
'DBSpclh','DBSpiqd','DBSpjal','DBSpjcm','DBSplmm','DBSpmam','DBSpoan','DBSpplm','DBSproj','DBSprqt','DBSpscb',
'DBSpuen','DBSpurg','DBSpwrk','DBSpymt','DBSrcth','DBSreqm','DBSropm','DBSrrcv','DBSrsmm','DBSstrm','DBSudef',
'DBSuomm','DBSvend','DBSvmst','DBSvpur','DBSwact','DBSwsam','master','model','msdb','tempdb','BASEMF')


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

	SET @sql = @sql + 'PRINT ''--SCRIPT PARA GERAÇÃO DOS USUÁRIOS''' + CHAR(13)
	--para USER
	SET @sql = @sql + 'SELECT	''DROP SCHEMA ['' + name + ''];'' + CHAR(13) + ''DROP USER ['' + name + ''];'' ' + CHAR(13)
	SET @sql = @sql + 'FROM	sysusers' + CHAR(13)
	SET @sql = @sql + 'WHERE	name not in (''INFORMATION_SCHEMA'',''sys'',''DBSSecurity'',''guest'',''dbo'',''public'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'',''Backup$Operators'')' + CHAR(13)
	SET @sql = @sql + 'AND		issqlrole = 0' + CHAR(13)

	SET @sql = @sql + 'PRINT ''--SCRIPT PARA GERAÇÃO DAS ROLES''' + CHAR(13)

	--para ROLES
	SET @sql = @sql + 'SELECT	''DROP SCHEMA ['' + name + ''];'' + CHAR(13) + ''DROP ROLE ['' + name + ''];''' + CHAR(13)
	SET @sql = @sql + 'FROM	sysusers' + CHAR(13)
	SET @sql = @sql + 'WHERE	name not in (''DBSSecurity'',''guest'',''dbo'',''public'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'',''Backup$Operators'')' + CHAR(13)
	SET @sql = @sql + 'AND		issqlrole = 1' + CHAR(13)
	
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