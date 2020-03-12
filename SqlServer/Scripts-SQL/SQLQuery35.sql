SET NOCOUNT ON

DECLARE @UserName varchar(100)
,		@DatabaseName varchar(100)
,		@errStatement [varchar](8000)
,		@msgStatement [varchar](8000)
,		@DatabaseUserID [smallint]
,		@RoleName [varchar](8000)
,		@ObjectID [int]
,		@ObjectName [varchar](261)
,		@sql varchar(4000)
,		@sql2 varchar(4000)

DECLARE _databases
CURSOR
LOCAL
FORWARD_ONLY
READ_ONLY
FOR
SELECT	name 
FROM	master..sysdatabases
WHERE	name not in ('tempdb', 'model', 'msdb','master', 'sqlnexus')

PRINT 'SET NOCOUNT ON'

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DatabaseName
WHILE @@FETCH_STATUS = 0
BEGIN

	PRINT 'PRINT ''Use ' + @DatabaseName + ''''

	SET @sql = 'Use ' + @DatabaseName + CHAR(13) 

	SET @sql = @sql + 'SELECT ''EXEC sp_addrolemember N''''db_datawriter'''', N'''''' + name + '''''''' ' + CHAR(13) 
	SET @sql = @sql + ' FROM sys.sysusers ' + CHAR(13) 
	SET @sql = @sql + '  WHERE issqlrole = 1 ' + CHAR(13) 
	SET @sql = @sql + '    AND name not in (''Backup$Operators'',''DBSSecurity'', ''public'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'') ' + CHAR(13) 


    PRINT @sql

FETCH
NEXT
FROM _databases
INTO
@DatabaseName
END
CLOSE _databases
DEALLOCATE _databases


/*
SELECT 'EXEC sp_addrolemember N''db_datawriter'', N''' + name + ''''
  FROM sys.sysusers
 WHERE issqlrole = 1
   and name not in ('Backup$Operators','DBSSecurity', 'public','db_owner','db_accessadmin','db_securityadmin','db_ddladmin','db_backupoperator','db_datareader','db_datawriter','db_denydatareader','db_denydatawriter')
   
*/





