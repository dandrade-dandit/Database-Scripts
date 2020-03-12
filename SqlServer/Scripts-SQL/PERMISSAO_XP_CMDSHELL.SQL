-- Set database to master.
USE master
GO
EXEC sp_grantdbaccess 'AR_SISTEMA'
GO
GRANT exec ON xp_cmdshell TO AR_SISTEMA
GO


