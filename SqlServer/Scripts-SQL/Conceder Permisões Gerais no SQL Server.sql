SET NOCOUNT ON

DECLARE @DatabaseName varchar(100)
,		@sql varchar(4000)

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	name 
FROM	master..sysdatabases
WHERE	name not in ('tempdb', 'model', 'msdb')

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DatabaseName
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @sql = 'Use ' + @DatabaseName + CHAR(13) 

	SET @sql = @sql + 'CREATE USER [usr_idm] FOR LOGIN [usr_idm] ' + CHAR(13) 
	SET @sql = @sql + 'EXEC sp_addrolemember N''db_securityadmin'', N''usr_idm'' ' + CHAR(13) 
	
    PRINT '--*************************************************************************************'
	PRINT @sql
	--EXECUTE (@sql)
	PRINT 'PERMISSÕES CRIADAS'+ CHAR(13) 
	PRINT '--*************************************************************************************'

FETCH
NEXT
FROM _databases
INTO
@DatabaseName
END
CLOSE _databases
DEALLOCATE _databases

/*

USE [master]
GO
CREATE LOGIN [usr_idm] WITH PASSWORD=N'Idm0xY759hjK', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

*/