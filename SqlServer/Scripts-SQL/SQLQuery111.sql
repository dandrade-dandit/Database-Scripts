--kill 491

--xp_cmdshell 'dir r:\'

dbcc inputbuffer(460)

sp_who2 590

select * from sys.sysprocesses where spid = 590

select * from sys.dm_exec_requests where session_id = 590
