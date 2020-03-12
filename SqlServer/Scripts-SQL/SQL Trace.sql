select * from master..sysprocesses where spid = 299

select * from master..sysprocesses where blocked > 0
order by blocked,spid

--kill 127

GEACrrcv..gsp_who2

select * from master..sysprocesses where waitresource like '%2:'

select	'kill ' + convert(varchar(4),spid) --,*
from	master..sysprocesses
where	status = 'suspended'
and		cmd not in ('LOG WRITER','CHECKPOINT ')
and     blocked <> 0

dbcc inputbuffer(299)


DBCC sqlperf ('sys.dm_os_wait_stats',clear)

--EXECUTE SQLSSII.GEACufcx.dbo.usp_val_enviar_sp '01001', 'RE0001-AO/2009/0001', '00', '367899925', '', 'NF 1176.', '20090603', 0, 'I9583274', '1', '', '', 'ONLINE'
--EXECUTE SQLSSII.GEACufcx.dbo.usp_val_enviar_sp '14016', 'MS0029-PS/2009/0016', '00', '327059490', '001', '1489', '20090716', 0, 'I4806311', '1', '', '', 'ONLINE'

--EXECUTE SQLSSII.DBSwact.dbo.psp_browse_usmm'9610109%',1,0,''

dbcc inputbuffer(269)

--PAG: 6:1:536670
--KEY: 6:72057594061586432 (010086470766)
--TAB: 74:631725353:2


--PAG: 6:1:975166
--PAG: 6:1:883161
--PAG: 6:1:947679
--PAG: 6:1:1033600
--PAG: 6:1:883161
--PAG: 6:1:380898

--PAG: 6:1:985423
--6:1:814001

select * from sys.databases where database_id = 6
select * from DBSwact..sysfiles where fileid = 1
select * from DBSwact..

--kill 174


xp_readerrorlog

use DBSwact
use GEACufcx
go

dbcc traceon(3604, -1)

6:1:
-PAG
dbcc page (6, 1, 814001, 3)

select object_name(926626344)

--TAB or Object
select object_name(631725353)

select count(1) from conf_sol_p_appvl_trk_comnt_u

--KEY
SELECT o.name as obj_name, i.name as idx_name
FROM sys.partitions p 
JOIN sys.objects o ON p.object_id = o.object_id 
JOIN sys.indexes i ON p.object_id = i.object_id 
AND p.index_id = i.index_id 
WHERE p.hobt_id = 72057594061586432 

select p.[object_id], p.[index_id], a.total_pages 
from sys.partitions p join sys.allocation_units a on p.partition_id=a.container_id
where a.container_id=72057594055098368

select object_name(325576198)

----------

select count(1) from message_queue_1 nolock




select DB_NAME(108)

select object_name(631725353)


--REORGANIZE NOS INDCIES
select 'ALTER INDEX [' + i.name + '] ON [' + o.name +'] REORGANIZE WITH ( LOB_COMPACTION = ON )' , i.*
from	sys.indexes i
,		sys.objects o
where	i.object_id = o.object_id
and		i.index_id>0
and		i.object_id>1000
and		o.type = 'U'
order by  o.name


DBCC TRACEON (3604)
DECLARE @dbid int, @objectid int
SELECT @dbid = DB_ID('master')
SELECT @objectid = object_id('sysdatabases')
DBCC TAB (@dbid,@objectid)


--CPU Bottlenecks
select  
    scheduler_id, 
    current_tasks_count, 
    runnable_tasks_count 
from  
    sys.dm_os_schedulers 
where  
    scheduler_id < 255

select top 50  
    sum(qs.total_worker_time) as total_cpu_time,  
    sum(qs.execution_count) as total_execution_count, 
    count(*) as  number_of_statements,  
    qs.plan_handle  
from  
    sys.dm_exec_query_stats qs 
group by qs.plan_handle 
order by sum(qs.total_worker_time) desc



--Inefficient query plans are usually detected comparatively. An inefficient query plan may cause increased CPU consumption. 
--The query against sys.dm_exec_query_stats is an efficient way to determine which query is using the most cumulative CPU. 

select  
    highest_cpu_queries.plan_handle,  
    highest_cpu_queries.total_worker_time, 
    q.dbid, 
    q.objectid, 
    q.number, 
    q.encrypted, 
    q.[text] 
from  
    (select top 50  
        qs.plan_handle,  
        qs.total_worker_time 
    from  
        sys.dm_exec_query_stats qs 
    order by qs.total_worker_time desc) as highest_cpu_queries 
    cross apply sys.dm_exec_sql_text(plan_handle) as q 
order by highest_cpu_queries.total_worker_time desc



--From a running server, you can determine whether any active requests are running in parallel for a given session by using the following query.

select  
    r.session_id, 
    r.request_id, 
    max(isnull(exec_context_id, 0)) as number_of_workers, 
    r.sql_handle, 
    r.statement_start_offset, 
    r.statement_end_offset, 
    r.plan_handle 
from  
    sys.dm_exec_requests r 
    join sys.dm_os_tasks t on r.session_id = t.session_id 
    join sys.dm_exec_sessions s on r.session_id = s.session_id 
where  
    s.is_user_process = 0x1 
group by  
    r.session_id, r.request_id,  
    r.sql_handle, r.plan_handle,  
    r.statement_start_offset, r.statement_end_offset 
having max(isnull(exec_context_id, 0)) > 0


-- 
-- Find query plans that may run in parallel 
-- 
select  
    p.*,  
    q.*, 
    cp.plan_handle 
from  
    sys.dm_exec_cached_plans cp 
    cross apply sys.dm_exec_query_plan(cp.plan_handle) p 
    cross apply sys.dm_exec_sql_text(cp.plan_handle) as q 
where  
    cp.cacheobjtype = 'Compiled Plan' and 
    p.query_plan.value('declare namespace  p="http://schemas.microsoft.com/sqlserver/2004/07/showplan";   max(//p:RelOp/@Parallel)', 'float') > 0

--Note: Some parts of the code snippet presented in the following table have been displayed in multiple lines only for better readability. These should be entered in a single line.

select  
    qs.sql_handle,  
    qs.statement_start_offset,  
    qs.statement_end_offset,  
    q.dbid, 
    q.objectid, 
    q.number, 
    q.encrypted, 
    q.text 
from  
    sys.dm_exec_query_stats qs 
    cross apply sys.dm_exec_sql_text(qs.plan_handle) as q 
where  
    qs.total_worker_time > qs.total_elapsed_time 

--SQL Trace 
--Look for the following signs of parallel queries,  
--which could be either statements or batches that have 
--CPU time greater than the duration. 

select  
    EventClass,  
    TextData  
from  
    ::fn_trace_gettable('c:\temp\high_cpu_trace.trc', 
default) 
where  
    EventClass in (10, 12)    

-- RPC:Completed,  
--SQL:BatchCompleted 
--    and CPU > Duration/1000    -- CPU is in  
--milliseconds, Duration in microseconds Or can be  
--Showplans (un-encoded) that have Parallelism operators] in them 

select  
    EventClass,  
    TextData  
from  
    ::fn_trace_gettable('c:\temp\high_cpu_trace.trc', 
default) 
where  
    TextData LIKE '%Parallelism%'


--********************************
SET NOCOUNT ON
declare @dbid int,
@fileid int,
@pageid	int,
@spid	int,
@sql	varchar(128)

--set your spid of interest here:
set @spid = 272

select 
@dbid = substring(waitresource, 1, charindex (':', waitresource) - 1),
@fileid = substring(waitresource, 
charindex( ':', waitresource) + 1, 
charindex(':', waitresource, charindex(':', waitresource) + 1) - charindex(':',waitresource) - 1
),
@pageid = substring(waitresource,
charindex(':', waitresource, charindex(':', waitresource, charindex(':', waitresource) + 1)) + 1,
len(waitresource) - (charindex(':', waitresource, charindex(':', waitresource, charindex(':', waitresource) + 1)) + 1)
)
from master..sysprocesses
where spid = @spid
and waitresource like '%:%:%'

set @sql = 'dbcc page (' + convert(varchar,@dbid) + ',' + convert(varchar,@fileid) + ',' + convert(varchar,@pageid) + ') with no_infomsgs, tableresults'

if exists (select 1 from tempdb..sysobjects where xtype = 'U' and name like '#pageinfo%')
drop table #pageinfo
create table #pageinfo (
ParentObject varchar(128),
Object varchar(128),
Field	 varchar(128),
Value	 varchar(128) )

dbcc traceon (3604) with no_infomsgs
insert into #pageinfo (ParentObject, Object, Field, Value)
exec (@sql)

select object_name(Value) as 'waitresource object name'
from #pageinfo
where Field = 'm_objId'

dbcc traceoff (3604) with no_infomsgs
--********************************


--PROCURAR FRAGMENTAÇÃO DE ÍNDICES
--SQL 2005
SELECT
    object_id AS objectid,
    index_id AS indexid,
    partition_number AS partitionnum,
    avg_fragmentation_in_percent AS fragmentation,
    page_count as PageCnt
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')
WHERE avg_fragmentation_in_percent > 10.0 AND index_id > 0 and index_type_desc in ('CLUSTERED INDEX', 'NONCLUSTERED INDEX');



select	
           'ALTER INDEX [' + i.name + '] ON [' + object_name(f.objectid) +'] REORGANIZE WITH ( LOB_COMPACTION = ON )' ,
           'ALTER INDEX [' + i.name + '] ON [' + object_name(f.objectid) +'] REBUILD WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, SORT_IN_TEMPDB = OFF, ONLINE = OFF )'
from	sys.indexes i,
(SELECT
    object_id AS objectid,
    index_id AS indexid,
    partition_number AS partitionnum,
    avg_fragmentation_in_percent AS fragmentation,
    page_count as PageCnt
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')
WHERE avg_fragmentation_in_percent > 10.0 AND index_id > 0 and index_type_desc in ('CLUSTERED INDEX', 'NONCLUSTERED INDEX')) as f
where	i.object_id = f.objectid
and		i.index_id = f.indexid

--SQL 2000
DBCC Showcontig WITH ALL_INDEXES


kill 396


select * from sysfiles



xp_cmdshell 'dir t:\MSSQL\DATA'

SELECT 
    name AS FileName, 
    size*1.0/128 AS FileSizeinMB,
    CASE max_size 
        WHEN 0 THEN 'Autogrowth is off.'
        WHEN -1 THEN 'Autogrowth is on.'
        ELSE 'Log file will grow to a maximum size of 2 TB.'
    END,
    growth AS 'GrowthValue',
    'GrowthIncrement' = 
        CASE
            WHEN growth = 0 THEN 'Size is fixed and will not grow.'
            WHEN growth > 0 AND is_percent_growth = 0 
                THEN 'Growth value is in 8-KB pages.'
            ELSE 'Growth value is a percentage.'
        END
FROM tempdb.sys.database_files;
GO


SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage;


SELECT SUM(version_store_reserved_page_count) AS [version store pages used],
(SUM(version_store_reserved_page_count)*1.0/128) AS [version store space in MB]
FROM sys.dm_db_file_space_usage;


use master
go
alter database tempdb modify file (name=templog, size=20000mb)

--Note that until SQL Server is restarted (when TempDB is created fresh) the above changes will not show the new values in the Database Properties or the Shrink File GUI. However, you can verify the changes immediately by running:
select db_name(database_id)dbname, [name] logical_filename, [size]*8/1024 size_mb
from master.sys.master_files
where db_name(database_id) = 'tempdb'

---**************************************************************

SELECT		
			substring(Database_Name,1,20) as Database_Name, DB_Size,DB_Log_Size,DB_Space_Available, Reserved, Unused
FROM		INFRAERO..tb_usr_space_used 
WHERE		User_datetime > getdate() -1 
AND			DB_Size <= 40000
ORDER 
   BY		DB_Size asc 


---**************************************************************
DECLARE @TXT1 VARCHAR(2000)
,		@DBNAME VARCHAR(20)

DECLARE C_DBNAME CURSOR FOR
SELECT		substring(Database_Name,1,20)
FROM		INFRAERO..tb_usr_space_used 
WHERE		User_datetime > getdate() -1 
AND			DB_Size <= 40000
ORDER 
   BY		DB_Size asc

OPEN C_DBNAME
FETCH NEXT FROM C_DBNAME 
INTO @DBNAME

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @TXT1 = 'use ' + @DBNAME + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'PRINT ''INICIO REINDEX DATABASE -> "' + @DBNAME + '" EM ' + CONVERT(VARCHAR(10), GETDATE(), 103) + ' - ' + CONVERT(VARCHAR(8), GETDATE(), 108) + '''' + + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'DECLARE @TXT_REINDEX VARCHAR(255) ' + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'DECLARE C_REINDEX CURSOR FOR ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + ' select ''ALTER INDEX ALL ON '' + name + ''  REBUILD WITH (FILLFACTOR = 70); '' ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'from sys.tables  where schema_id=1 ' + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'OPEN C_REINDEX ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'FETCH NEXT FROM C_REINDEX  ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'INTO @TXT_REINDEX ' + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'WHILE @@FETCH_STATUS = 0 ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'BEGIN ' + char(13) + char(10)
		
	SELECT @TXT1 = @TXT1 + '	execute (@TXT_REINDEX) ' + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + '	FETCH NEXT FROM C_REINDEX  ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + '	INTO @TXT_REINDEX ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'END ' + char(13) + char(10)

	SELECT @TXT1 = @TXT1 + 'CLOSE C_REINDEX ' + char(13) + char(10)
	SELECT @TXT1 = @TXT1 + 'DEALLOCATE C_REINDEX ' + char(13) + char(10)
	
	SELECT @TXT1 = @TXT1 + 'PRINT ''FIM REINDEX DATABASE -> "' + @DBNAME + '" EM ' + CONVERT(VARCHAR(10), GETDATE(), 103) + ' - ' + CONVERT(VARCHAR(8), GETDATE(), 108) + '''' + char(13) + char(10)

	execute (@TXT1)

	FETCH NEXT FROM C_DBNAME 
	INTO @DBNAME
END

CLOSE C_DBNAME
DEALLOCATE C_DBNAME



---**************************************************************
use DBSwact

PRINT 'INICIO REINDEX DATABASE -> EM ' + CONVERT(VARCHAR(10), GETDATE(), 103) + ' - ' + CONVERT(VARCHAR(8), GETDATE(), 108) + ''
DECLARE @TXT_REINDEX VARCHAR(255) 

DECLARE C_REINDEX CURSOR FOR 
select 'ALTER INDEX ALL ON ' + name + '  REBUILD WITH (FILLFACTOR = 70); '
from sys.tables 

OPEN C_REINDEX 
FETCH NEXT FROM C_REINDEX  
INTO @TXT_REINDEX 

WHILE @@FETCH_STATUS = 0 
BEGIN 
		
	execute (@TXT_REINDEX) 

	FETCH NEXT FROM C_REINDEX  
	INTO @TXT_REINDEX 
END 

CLOSE C_REINDEX 
DEALLOCATE C_REINDEX 
PRINT 'FIM REINDEX DATABASE -> EM ' + CONVERT(VARCHAR(10), GETDATE(), 103) + ' - ' + CONVERT(VARCHAR(8), GETDATE(), 108) + ''


-------LIMPA TABELAS DE MENSAGENS

BEGIN TRAN 

PRINT 'CRIA TABELA TEMPORARIA'
SELECT TOP 100000 server_name,
		seq_nbr
INTO    MSG#
from	DBSwact.dbo.message_queue_1 (NOLOCK)
where (activity_id in ('pam0120','pst0130') and create_time < dateadd(dd,-2,getdate())) -- TODOS INFORMACIONALES, DATABASE ADMIN., con mas de 7 DIAS
or (create_time < dateadd(mm,-1,getdate()))                             -- TODOS con mas de 1 MESES
or (create_time < dateadd(dd,-2,getdate()) and msg_status = 3)          -- TODOS FINALIZADOS con mas de 7 DIAS

PRINT 'DELETA TABELA message_queue_1'
--SELECT	COUNT(1)--MQ.*)
DELETE MQ
  FROM	DBSwact.dbo.message_queue_1 AS MQ
     ,  MSG# MSG
 WHERE  MQ.server_name = MSG.server_name
   AND  MQ.seq_nbr = MSG.seq_nbr

PRINT 'DROP TABELA TEMPORARIA'
DROP TABLE MSG#

COMMIT TRAN
--ROLLBACK TRAN


SELECT COUNT(1) from	DBSwact.dbo.message_queue_1 (NOLOCK)
where (activity_id in ('pam0120','pst0130') and create_time < dateadd(dd,-2,getdate())) -- TODOS INFORMACIONALES, DATABASE ADMIN., con mas de 7 DIAS
or (create_time < dateadd(mm,-1,getdate()))                             -- TODOS con mas de 1 MESES
or (create_time < dateadd(dd,-2,getdate()) and msg_status = 3)          -- TODOS FINALIZADOS con mas de 7 DIAS

