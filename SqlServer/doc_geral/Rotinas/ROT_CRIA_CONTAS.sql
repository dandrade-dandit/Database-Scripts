use master
go
sp_addlogin @loginame = 'user_stms'
,@passwd = 'sgtc'
,@defdb = 'integracao'
,@deflanguage = 'Português'
go
sp_addlogin @loginame = 'SITIA'
,@passwd = 'vydvnyt9b7ak0oiip2nechtb0x_9qd'
,@defdb = 'BDO'
,@deflanguage = 'Português'
go
exec sp_grantdbaccess N'SITIA', N'SITIA'
go
exec sp_addrolemember N'db_owner', N'SITIA'
go
--exec sp_addsrvrolemember N'SITIA', sysadmin
go
use BDO
go
exec sp_revokedbaccess N'user_stms'
go
exec sp_grantdbaccess N'user_stms', N'user_stms'
go
exec sp_revokedbaccess N'SITIA'
go
exec sp_grantdbaccess N'SITIA', N'SITIA'
go
exec sp_addrolemember N'db_owner', N'SITIA'
go
grant select on T_CHG to user_stms
go
grant select on T_COM to user_stms
go
grant select on T_PAR to user_stms
go
grant select,insert,update,delete on T_MCH to user_stms
go
grant select,insert,update,delete on T_MPA to user_stms
go
use integracao
go
exec sp_revokedbaccess N'user_stms'
go
exec sp_revokedbaccess N'SITIA'
go
exec sp_grantdbaccess N'user_stms', N'user_stms'
go
exec sp_addrolemember N'db_owner', N'user_stms'
go
exec sp_grantdbaccess N'SITIA', N'SITIA'
go

