create table #temp (
SPID  int,
Status    varchar(60),                     
Login   varchar(60),                                 
HostName varchar(60),  
BlkBy varchar(10),
DBName   varchar(50),   
Command   varchar(250),       
CPUTime varchar(150),
DiskIO varchar(150),
LastBatch  varchar(150),    
ProgramName  varchar(150),                                  
SPID2  int,
REQUESTID varchar(150))

set nocount on

insert into #temp
exec sp_who2

set nocount off

select * from #temp 
where	Command not in ('UNKNOWN TOKEN','TRACE QUEUE TASK','TRACE QUEUE TASK','BRKR TASK','CHECKPOINT','BRKR EVENT HNDLR','BRKR TASK','RESOURCE MONITOR','LOG WRITER','LAZY WRITER','LOCK MONITOR ','SIGNAL HANDLER','TASK MANAGER')
and		Login not in ('D_SEDE\admin-cluster')
order by BlkBy Desc, SPID

drop table #temp

--DBCC INPUTBUFFER (446)
--DBCC FREEPROCCACHE
--DBCC DROPCLEANBUFFERS
--kill 658
--SELECT * FROM sysprocesses where spid = 119