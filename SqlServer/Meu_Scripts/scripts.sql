soluçao para recompile:
1) usar sp_executesql
2)dividir todas as procedures que criam tabelas/índices em 2,
ficando a primeira parte com os comandos agrupados de criação de tabelas e índices,
e a segunda parte somente com DML.Assim somente parte do código será recompilado

alter database mane add filegroup data2
alter database mane add filegroup data3
ALTER DATABASE mane
ADD FILE 
( NAME = TESTE_DATA3,
FILENAME = 'c:\arquivos de programas\microsoft sql server\mssql\data\teste_data3.ndf',
SIZE = 1MB,  MAXSIZE = 2MB , FILEGROWTH = 1MB   )                                                                                                                                          
TO FILEGROUP data3
select * from sysfilegroups
select * from sysfiles

select name from sysindexes where groupid = 3

declare @cont bigint
select @cont = 1
while @cont < 1999
begin
insert into x values (@cont, 'a') 
select @cont = @cont + 1
end
select count(*) from y truncate table Y 
create table x (col1 int, col2 char(1)) on data2
create table y (col1 int, col2 char(1)) on data3
alter database xy set online
backup database mane to disk = 'e:\mane.bak'
backup log mane to disk = 'e:\mane_log.bak'
backup log xy to disk = 'e:\xy_ult.bak' with no_truncate

use master
go
exec sp_addumpdevice 'disk', 'Testebacklog', 'e:\sqlserver\log\teste_log.bak'
backup log teste to testebacklog

select groupname, name from sysfilegroups a, sysindexes b
where a.groupid = b.groupid and name = 'y'
backup log xy to disk = 'e:\teste_log.bak'
restore database xy  filegroup = 'PRIMARY'
from disk = 'e:\teste.bak' with norecovery
restore database xy  filegroup = 'data2'
from disk = 'e:\teste.bak' with norecovery
restore database xy  filegroup = 'data3'
from disk = 'e:\xy.bak' with norecovery
restore log xy from disk = 'e:\xy_log.bak' with norecovery
restore log xy from disk = 'e:\teste_log_ult.bak' with recovery
alter database xy modify file (
name =  'teste_log',
size = 10mb)

restore database xy with recovery
backup log  xy with truncate_only
restore database xy  
from disk = 'e:\xy.bak' 