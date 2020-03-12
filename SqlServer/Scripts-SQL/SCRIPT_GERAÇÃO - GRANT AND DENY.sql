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
WHERE	name not in ('tempdb', 'model', 'msdb')

OPEN _databases
FETCH
NEXT
FROM _databases
INTO
@DatabaseName
WHILE @@FETCH_STATUS = 0
BEGIN

	PRINT 'Use ' + @DatabaseName

	SET @sql = 'Use ' + @DatabaseName + CHAR(13) 

	SET @sql = @sql + 'DECLARE @UserName varchar(100) ' + CHAR(13) 
	SET @sql = @sql + ',		@DatabaseName varchar(100) ' + CHAR(13) 
	SET @sql = @sql + ',		@errStatement [varchar](8000) ' + CHAR(13) 
	SET @sql = @sql + ',		@msgStatement [varchar](8000) ' + CHAR(13) 
	SET @sql = @sql + ',		@DatabaseUserID [smallint] ' + CHAR(13) 
	SET @sql = @sql + ',		@RoleName [varchar](8000) ' + CHAR(13) 
	SET @sql = @sql + ',		@ObjectID [int] ' + CHAR(13) 
	SET @sql = @sql + ',		@ObjectName [varchar](261) ' + CHAR(13) 

	SET @sql = @sql + 'DECLARE _users ' + CHAR(13) 
	SET @sql = @sql + 'CURSOR ' + CHAR(13) 
	SET @sql = @sql + 'LOCAL ' + CHAR(13) 
	SET @sql = @sql + 'FORWARD_ONLY ' + CHAR(13) 
	SET @sql = @sql + 'READ_ONLY ' + CHAR(13) 
	SET @sql = @sql + 'FOR ' + CHAR(13) 
	SET @sql = @sql + 'SELECT name ' + CHAR(13) 
	SET @sql = @sql + 'FROM	sysusers ' + CHAR(13) 
	SET @sql = @sql + 'WHERE	name not in (''guest'',''dbo'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'',''Backup$Operators'') ' + CHAR(13) 

	SET @sql = @sql + 'OPEN _users ' + CHAR(13) 
	SET @sql = @sql + 'FETCH ' + CHAR(13) 
	SET @sql = @sql + 'NEXT ' + CHAR(13) 
	SET @sql = @sql + 'FROM _users ' + CHAR(13) 
	SET @sql = @sql + 'INTO ' + CHAR(13) 
	SET @sql = @sql + '@UserName ' + CHAR(13) 
	SET @sql = @sql + 'WHILE @@FETCH_STATUS = 0 ' + CHAR(13) 
	SET @sql = @sql + 'BEGIN ' + CHAR(13) 

	SET @sql = @sql + 'DECLARE @DatabaseUserName [sysname] ' + CHAR(13) 
	SET @sql = @sql + 'SET @DatabaseUserName = @UserName ' + CHAR(13) 

	SET @sql = @sql + 'SELECT @DatabaseUserID = UserID ' + CHAR(13) 
	SET @sql = @sql + 'FROM ( ' + CHAR(13) 
	SET @sql = @sql + '	SELECT ' + CHAR(13) 
	SET @sql = @sql + '		 UserID = [sysusers].[uid] ' + CHAR(13) 
	SET @sql = @sql + '	FROM [dbo].[sysusers] ' + CHAR(13) 
	SET @sql = @sql + '		INNER JOIN [master].[dbo].[syslogins] ' + CHAR(13) 
	SET @sql = @sql + '		ON [sysusers].[sid] = [master].[dbo].[syslogins].[sid] ' + CHAR(13) 
	SET @sql = @sql + '	WHERE [sysusers].[name] = @DatabaseUserName ' + CHAR(13) 
	SET @sql = @sql + '	UNION ' + CHAR(13) 
	SET @sql = @sql + '	SELECT ' + CHAR(13) 
	SET @sql = @sql + '		UserID = [uid] ' + CHAR(13) 
	SET @sql = @sql + '	FROM [dbo].[sysusers] ' + CHAR(13) 
	SET @sql = @sql + '	WHERE ' + CHAR(13) 
	SET @sql = @sql + '		[name] = @DatabaseUserName ' + CHAR(13) 
	SET @sql = @sql + '	AND ([issqlrole] = 1 OR [isapprole] = 1) ' + CHAR(13) 
	SET @sql = @sql + '	AND [name] NOT IN (''INFORMATION_SCHEMA'',''db_owner'',''db_accessadmin'',''db_securityadmin'',''db_ddladmin'',''db_backupoperator'',''db_datareader'',''db_datawriter'',''db_denydatareader'',''db_denydatawriter'') ' + CHAR(13) 
	SET @sql = @sql + ' ) as Tab_UserID ' + CHAR(13) 


	SET @sql = @sql + 'DECLARE _sysobjects ' + CHAR(13) 
	SET @sql = @sql + 'CURSOR ' + CHAR(13) 
	SET @sql = @sql + 'LOCAL ' + CHAR(13) 
	SET @sql = @sql + 'FORWARD_ONLY ' + CHAR(13) 
	SET @sql = @sql + 'READ_ONLY ' + CHAR(13) 
	SET @sql = @sql + 'FOR ' + CHAR(13) 
	SET @sql = @sql + 'SELECT ' + CHAR(13) 
	SET @sql = @sql + 'DISTINCT([sysobjects].[id]), ' + CHAR(13) 
	SET @sql = @sql + '''[''+' + 'USER_NAME([sysobjects].[uid])' + '+''].[''+' + '[sysobjects].[name]' + '+'']''' + CHAR(13) 
	SET @sql = @sql + 'FROM [dbo].[sysprotects] ' + CHAR(13) 
	SET @sql = @sql + 'INNER JOIN [dbo].[sysobjects] ' + CHAR(13) 
	SET @sql = @sql + 'ON [sysprotects].[id] = [sysobjects].[id] ' + CHAR(13) 
	SET @sql = @sql + 'WHERE [sysprotects].[uid] = @DatabaseUserID ' + CHAR(13) 

	SET @sql = @sql + 'OPEN _sysobjects ' + CHAR(13) 

	SET @sql = @sql + 'FETCH ' + CHAR(13) 
	SET @sql = @sql + 'NEXT ' + CHAR(13) 
	SET @sql = @sql + 'FROM _sysobjects ' + CHAR(13) 
	SET @sql = @sql + 'INTO ' + CHAR(13) 
	SET @sql = @sql + '@ObjectID, ' + CHAR(13) 
	SET @sql = @sql + '@ObjectName ' + CHAR(13) 

	SET @sql = @sql + 'WHILE @@FETCH_STATUS = 0 ' + CHAR(13) 
	SET @sql = @sql + 'BEGIN ' + CHAR(13) 

	--GRANT
	SET @sql = @sql + 'SET @msgStatement = '''' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 193 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''SELECT,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 195 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''INSERT,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 197 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''UPDATE,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 196 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''DELETE,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 224 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''EXECUTE,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 26 AND [protecttype] = 205) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = @msgStatement + ''REFERENCES,'' ' + CHAR(13) 
	SET @sql = @sql + 'IF LEN(@msgStatement) > 0 ' + CHAR(13) 
	SET @sql = @sql + 'BEGIN ' + CHAR(13) 
	SET @sql = @sql + '	IF RIGHT(@msgStatement, 1) = '','' ' + CHAR(13) 
	SET @sql = @sql + '		SET @msgStatement = LEFT(@msgStatement, LEN(@msgStatement) - 1) ' + CHAR(13) 
	SET @sql = @sql + '	SET @msgStatement = ''GRANT'' + CHAR(13) + ' + CHAR(13) 
	SET @sql = @sql + '	CHAR(9) + @msgStatement + CHAR(13) + ' + CHAR(13) 
	SET @sql = @sql + '	CHAR(9) + ''ON '' + @ObjectName + CHAR(13) +  ' + CHAR(13) 
	SET @sql = @sql + '	CHAR(9) + ''TO '' + @DatabaseUserName + '';'' ' + CHAR(13) 
	SET @sql = @sql + '	PRINT @msgStatement	 ' + CHAR(13) 
	SET @sql = @sql + 'END ' + CHAR(13) 
	

	--DENY
	SET @sql2 = 'SET @msgStatement = '''' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 193 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''SELECT,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 195 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''INSERT,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 197 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''UPDATE,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 196 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''DELETE,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 224 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''EXECUTE,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF EXISTS(SELECT * FROM [dbo].[sysprotects] WHERE [id] = @ObjectID AND [uid] = @DatabaseUserID AND [action] = 26 AND [protecttype] = 206) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = @msgStatement + ''REFERENCES,'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'IF LEN(@msgStatement) > 0 ' + CHAR(13) 
	SET @sql2 = @sql2 + 'BEGIN ' + CHAR(13) 
	SET @sql2 = @sql2 + '	IF RIGHT(@msgStatement, 1) = '','' ' + CHAR(13) 
	SET @sql2 = @sql2 + '		SET @msgStatement = LEFT(@msgStatement, LEN(@msgStatement) - 1) ' + CHAR(13) 
	SET @sql2 = @sql2 + '	SET @msgStatement = ''DENY'' + CHAR(13) + ' + CHAR(13) 
	SET @sql2 = @sql2 + '	CHAR(9) + @msgStatement + CHAR(13) + ' + CHAR(13) 
	SET @sql2 = @sql2 + '	CHAR(9) + ''ON '' + @ObjectName + CHAR(13) + ' + CHAR(13) 
	SET @sql2 = @sql2 + '	CHAR(9) + ''TO '' + @DatabaseUserName + '';'' ' + CHAR(13) 
	SET @sql2 = @sql2 + 'PRINT @msgStatement	 ' + CHAR(13) 
	SET @sql2 = @sql2 + 'END ' + CHAR(13) 
	
	SET @sql2 = @sql2 + 'FETCH ' + CHAR(13) 
	SET @sql2 = @sql2 + 'NEXT ' + CHAR(13) 
	SET @sql2 = @sql2 + 'FROM _sysobjects ' + CHAR(13) 
	SET @sql2 = @sql2 + 'INTO ' + CHAR(13) 
	SET @sql2 = @sql2 + '@ObjectID, ' + CHAR(13) 
	SET @sql2 = @sql2 + '@ObjectName ' + CHAR(13) 
	SET @sql2 = @sql2 + 'END ' + CHAR(13) 
	SET @sql2 = @sql2 + 'CLOSE _sysobjects ' + CHAR(13) 
	SET @sql2 = @sql2 + 'DEALLOCATE _sysobjects ' + CHAR(13) 
	SET @sql2 = @sql2 + 'FETCH ' + CHAR(13) 
	SET @sql2 = @sql2 + 'NEXT ' + CHAR(13) 
	SET @sql2 = @sql2 + 'FROM _users ' + CHAR(13) 
	SET @sql2 = @sql2 + 'INTO ' + CHAR(13) 
	SET @sql2 = @sql2 + '@UserName ' + CHAR(13) 
	SET @sql2 = @sql2 + 'END ' + CHAR(13) 
	SET @sql2 = @sql2 + 'CLOSE _users ' + CHAR(13) 
	SET @sql2 = @sql2 + 'DEALLOCATE _users ' + CHAR(13) 

	SET @sql2 = @sql2 + 'PRINT ''--********************************************************************************************'' + CHAR(13)	 ' + Char(13) 

    EXECUTE (@sql + @sql2)
	--PRINT @sql + @sql2

FETCH
NEXT
FROM _databases
INTO
@DatabaseName
END
CLOSE _databases
DEALLOCATE _databases