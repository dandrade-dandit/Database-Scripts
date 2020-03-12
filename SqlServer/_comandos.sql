sp_MStablechecks N'dbo.t'

sp_MShelpcolumns N'dbo.t', null, 'id', 1

sp_MShelpindex N'dbo.t', null, 1

sp_MStablerefs N'dbo.t', N'actualtables', N'both', null

EXECUTE sp_MStablespace N'dbo.t'

DBCC USEROPTIONS


DECLARE @v sql_variant 
SET @v = N'ana é brutona'
EXECUTE sp_updateextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N't', N'column', N'campoa'

DBCC LockObjectSchema(@objname)