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
