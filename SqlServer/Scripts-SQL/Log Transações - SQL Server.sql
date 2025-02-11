set nocount on

declare @table table (
spid int,
dbname varchar(100),
usuario varchar(100),
cmd varchar(100),
blocked int,
tempo int,
status varchar(100),
cpu int,
physical_io int,
net_library  varchar(100),
program_name  varchar(1000),
lastwaittype  varchar(1000),
waitresource  varchar(100) )

insert into @table
exec GEACrrcv..gsp_who2

insert into IFRCORP..tab_log_trans
select	usuario, u.sec_group_id, 1 as qtd, getdate() date
from	@table
   ,    [DBSwact].[dbo].[user_master_1] u
where	usuario != 'sa'
  and   usuario not like 'D_SEDE%'
  and   usuario = u.user_id

/*

create table IFRCORP..tab_log_trans (
 usuario varchar(100),
 grupo varchar(100),
 qtd int,
 data datetime)
 
 select * 
 from IFRCORP..tab_log_trans
 
 */