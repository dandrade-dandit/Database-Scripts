EXEC sp_detach_db 'pubs', 'true'
go
EXEC master..xp_cmdshell 'erase /Q  \\loreno26\temp\*.*'
go
EXEC master..xp_cmdshell 'copy  d:\mssql7\data\pubs.mdf \\loreno26\temp\'
go
EXEC master..xp_cmdshell 'copy  d:\mssql7\data\pubs_log.ldf \\loreno26\temp\'
go
EXEC sp_attach_db @dbname = N'pubs', 
	@filename1 = N'd:\mssql7\data\pubs.mdf', 
	@filename2 = N'd:\mssql7\data\pubs_log.ldf'
