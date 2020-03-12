declare @date datetime
declare @nome varchar(255)

set @date = dateadd( mi, 4, getdate())
set @nome = 'C:\MSSQL7\BACKUP\teste_log.BAK'

BACKUP LOG teste TO DISK = @nome with expiredate = @date, name='BACKUP da Teste'

