use master
go
sp_addlogin @loginame = 'SITIA',@passwd = 'vydvnyt9b7ak0oiip2nechtb0x_9qd',@defdb = 'BDO',@deflanguage = 'Português'
go
exec sp_grantdbaccess N'SITIA', N'SITIA'
go
exec sp_addrolemember N'db_owner', N'SITIA'
go
use BDO
go
exec sp_revokedbaccess N'SITIA'
go
exec sp_grantdbaccess N'SITIA', N'SITIA'
go
exec sp_addrolemember N'db_owner', N'SITIA'
go
