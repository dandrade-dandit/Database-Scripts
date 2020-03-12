-- 	usr_backup_db
--
--      ****Exemplo de Uso: O diretorio pode ter até 100 caracteres e tanto a letra inicial e final podem ter até 4 caracteres****
--
--	execute usr_backup_db	@dir_backup  	= 'D:\MSSQL7\BACKUP\',	@letra_inicial  = 'A',	@letra_final    = 'pub'
--
--
use master
go

-----------------------------------------------------------------------------------------------
print 'procedure usr_backup_db	Versao:18/12/2001 16:00'
-----------------------------------------------------------------------------------------------
if exists (select * from sysobjects where id = object_id('usr_backup_db') and sysstat & 0xf = 4)
	drop procedure usr_backup_db
go
CREATE procedure usr_backup_db
	@dir_backup varchar(100) = 'D:\MSSQL7\BACKUP\'
,	@letra_inicial varchar(4) = 'A'
,	@letra_final varchar(4) = 'Z'
as
Set nocount on
declare @cmd_backup varchar(2000)

DECLARE cursor_backup_db CURSOR FOR
select 'BACKUP DATABASE [' + ltrim(convert(varchar(256), name)) + '] TO  DISK = N''' + @dir_backup + ltrim(convert(varchar(256), name)) + '_FULL.BAK'' WITH  INIT ,  NOUNLOAD ,  NAME = N''' + ltrim(convert(varchar(256), name)) + ' full backup'',  NOSKIP ,  STATS = 10,  NOFORMAT ' as Db
from sysdatabases
where name not in ('tempdb', 'model')
and   	name in (
		select 	name
		from 	sysdatabases
		where 	substring(upper(name), 1, len(@letra_inicial)) >= @letra_inicial
                and 	substring(upper(name), 1, len(@letra_final)) <= @letra_final)
OPEN cursor_backup_db

WHILE (1=1)BEGIN
	FETCH NEXT FROM cursor_backup_db 
	INTO @cmd_backup
	
	if (@@FETCH_STATUS = -1) break	
	
	--select @cmd_backup
	execute (@cmd_backup)
End
CLOSE cursor_backup_db
DEALLOCATE cursor_backup_db
go