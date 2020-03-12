-- Which Queries are taking the most time/cpu to execute
SELECT TOP 20
    total_worker_time, total_elapsed_time,
    total_worker_time/execution_count AS avg_cpu_cost, execution_count,
    (SELECT DB_NAME(dbid) + ISNULL('..' + OBJECT_NAME(objectid), '')
        FROM sys.dm_exec_sql_text([sql_handle])) AS query_database,
    (SELECT SUBSTRING(est.[text], statement_start_offset/2 + 1,
        (CASE WHEN statement_end_offset = -1
            THEN LEN(CONVERT(nvarchar(max), est.[text])) * 2
            ELSE statement_end_offset
            END - statement_start_offset) / 2
        )
        FROM sys.dm_exec_sql_text([sql_handle]) AS est) AS query_text,
    total_logical_reads/execution_count AS avg_logical_reads,
    total_logical_writes/execution_count AS avg_logical_writes,
    last_worker_time, min_worker_time, max_worker_time,
    last_elapsed_time, min_elapsed_time, max_elapsed_time,
    plan_generation_num, qp.query_plan
FROM sys.dm_exec_query_stats
    OUTER APPLY sys.dm_exec_query_plan([plan_handle]) AS qp
WHERE [dbid] >= 5 AND DB_NAME(dbid) IS NOT NULL
  AND (total_worker_time/execution_count) > 100
--ORDER BY avg_cpu_cost DESC;
--ORDER BY execution_count DESC;
ORDER BY total_worker_time DESC;

--***************************************************************************************************
SELECT TOP 20
    total_logical_reads/execution_count AS avg_logical_reads,
    total_logical_writes/execution_count AS avg_logical_writes,
    total_worker_time/execution_count AS avg_cpu_cost, execution_count,
    total_worker_time, total_logical_reads, total_logical_writes, 
    (SELECT DB_NAME(dbid) + ISNULL('..' + OBJECT_NAME(objectid), '')
        FROM sys.dm_exec_sql_text([sql_handle])) AS query_database,
    (SELECT SUBSTRING(est.[text], statement_start_offset/2 + 1,
        (CASE WHEN statement_end_offset = -1
            THEN LEN(CONVERT(nvarchar(max), est.[text])) * 2
            ELSE statement_end_offset
            END - statement_start_offset
        ) / 2)
        FROM sys.dm_exec_sql_text(sql_handle) AS est) AS query_text,
    last_logical_reads, min_logical_reads, max_logical_reads,
    last_logical_writes, min_logical_writes, max_logical_writes,
    total_physical_reads, last_physical_reads, min_physical_reads, max_physical_reads,
    (total_logical_reads + (total_logical_writes * 5))/execution_count AS io_weighting,
    plan_generation_num, qp.query_plan
FROM sys.dm_exec_query_stats
    OUTER APPLY sys.dm_exec_query_plan([plan_handle]) AS qp
WHERE [dbid] >= 5 AND DB_NAME(dbid) IS NOT NULL
  and (total_worker_time/execution_count) > 100
ORDER BY io_weighting DESC;
--ORDER BY avg_logical_reads DESC;
--ORDER BY avg_logical_writes DESC;
--ORDER BY avg_cpu_cost DESC;

--*******************************************************************************************************


SELECT TOP 10 SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset
WHEN -1 THEN DATALENGTH(qt.TEXT)
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1),
qs.execution_count,
qs.total_logical_reads, qs.last_logical_reads,
qs.total_logical_writes, qs.last_logical_writes,
qs.total_worker_time,
qs.last_worker_time,
qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_S,
qs.last_execution_time,
qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY qs.total_logical_reads DESC -- logical reads
-- ORDER BY qs.total_logical_writes DESC -- logical writes
-- ORDER BY qs.total_worker_time DESC -- CPU time


--*****************************************************************************************************
-- SQL Server 2008 and R2 Memory Related Queries
-- Glenn Berry 
-- October 2010
-- http://glennberrysqlperformance.spaces.live.com/
-- Twitter: GlennAlanBerry

-- Instance Level queries

-- Good basic information about memory amounts and state (SQL 2008 and 2008 R2)
SELECT total_physical_memory_kb, available_physical_memory_kb, 
       total_page_file_kb, available_page_file_kb, 
       system_memory_state_desc
FROM sys.dm_os_sys_memory;

-- You want to see "Available physical memory is high"


-- SQL Server Process Address space info (SQL 2008 and 2008 R2)
--(shows whether locked pages is enabled, among other things)
SELECT physical_memory_in_use_kb,locked_page_allocations_kb, 
       page_fault_count, memory_utilization_percentage, 
       available_commit_limit_kb, process_physical_memory_low, 
       process_virtual_memory_low
FROM sys.dm_os_process_memory;

-- You want to see 0 for process_physical_memory_low
-- You want to see 0 for process_virtual_memory_low


-- Page Life Expectancy (PLE) value for default instance (SQL 2005, 2008 and 2008 R2)
SELECT cntr_value AS [Page Life Expectancy]
FROM sys.dm_os_performance_counters
WHERE OBJECT_NAME = N'SQLServer:Buffer Manager' -- Modify this if you have named instances
AND counter_name = N'Page life expectancy';

-- PLE is a good measurement of memory pressure.
-- Higher PLE is better. Below 300 is generally bad.
-- Watch the trend, not the absolute value.


-- Get total buffer usage by database for current instance (SQL 2005, 2008 and 2008 R2)
-- Note: This is a fairly expensive query
SELECT DB_NAME(database_id) AS [Database Name],
COUNT(*) * 8/1024.0 AS [Cached Size (MB)]
FROM sys.dm_os_buffer_descriptors
WHERE database_id > 4 -- system databases
AND database_id <> 32767 -- ResourceDB
GROUP BY DB_NAME(database_id)
ORDER BY [Cached Size (MB)] DESC;

-- Helps determine which databases are using the most memory on an instance


-- Memory Clerk Usage for instance
-- Look for high value for CACHESTORE_SQLCP (Ad-hoc query plans)
-- (SQL 2005, 2008 and 2008 R2)
SELECT TOP(20) [type], [name], SUM(single_pages_kb) AS [SPA Mem, Kb] 
FROM sys.dm_os_memory_clerks 
GROUP BY [type], [name]  
ORDER BY SUM(single_pages_kb) DESC;

-- CACHESTORE_SQLCP  SQL Plans         These are cached SQL statements or batches that aren't in 
--                                     stored procedures, functions and triggers
-- CACHESTORE_OBJCP  Object Plans      These are compiled plans for stored procedures, 
--                                     functions and triggers
-- CACHESTORE_PHDR   Algebrizer Trees  An algebrizer tree is the parsed SQL text that 
--                                     resolves the table and column names


-- Find single-use, ad-hoc queries that are bloating the plan cache
SELECT TOP(100) [text], cp.size_in_bytes
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_sql_text(plan_handle) 
WHERE cp.cacheobjtype = N'Compiled Plan' 
AND cp.objtype = N'Adhoc' 
AND cp.usecounts = 1
ORDER BY cp.size_in_bytes DESC;

-- Gives you the text and size of single-use ad-hoc queries that waste space in the plan cache
-- Enabling 'optimize for ad hoc workloads' for the instance can help (SQL Server 2008 and 2008 R2 only)
-- Enabling forced parameterization for the database can help, but test first!


-- Database level queries (switch to your database)
--USE YourDatabaseName;
--GO

-- Breaks down buffers used by current database by object (table, index) in the buffer cache
-- (SQL 2008 and 2008 R2) Note: This is a fairly expensive query
SELECT OBJECT_NAME(p.[object_id]) AS [ObjectName], 
p.index_id, COUNT(*)/128 AS [Buffer size(MB)],  COUNT(*) AS [BufferCount], 
p.data_compression_desc AS [CompressionType]
FROM sys.allocation_units AS a
INNER JOIN sys.dm_os_buffer_descriptors AS b
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p
ON a.container_id = p.hobt_id
WHERE b.database_id = CONVERT(int,DB_ID())
AND p.[object_id] > 100
GROUP BY p.[object_id], p.index_id, p.data_compression_desc
ORDER BY [BufferCount] DESC;


-- Top Cached SPs By Total Logical Reads (SQL 2008 and 2008 R2). Logical reads relate to memory pressure
SELECT TOP(25) p.name AS [SP Name], qs.total_logical_reads AS [TotalLogicalReads], 
qs.total_logical_reads/qs.execution_count AS [AvgLogicalReads],qs.execution_count, 
ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second], 
qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count 
AS [avg_elapsed_time], qs.cached_time
FROM sys.procedures AS p
INNER JOIN sys.dm_exec_procedure_stats AS qs
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY qs.total_logical_reads DESC;

-- This helps you find the most expensive cached stored procedures from a memory perspective
-- You should look at this if you see signs of memory pressureR

--*************************************************************************************************

-- SQL Server 2005 Emergency Diagnostic and Performance Queries
-- Glenn Berry 3-17-2008
      

-- Step 1 - Check Task Manager. Are all CPUs above 90-95% for an extended period of time?
-- If yes, run HIGH CPU queries below:

-- Step 2 - Check Performance Monitor
-- SQL Server Buffer Manager: Buffer Cache Hit Ratio and Page Life Expectancy
-- SQL Server Memory Manager: Memory Grants Pending and Memory Grants Pending
-- Physical Disk: Avg disk sec/Read and Avg disk sec/Write

-- Step 3 - Check for locking, blocking and missing indexes
-- Run the BLOCKING queries below: 

-- Step 4 - Is the transaction log full?
-- Run the TRANSACTION LOG FULL queries below:

-- Step 5 - Check for IO Problems
-- Run the IO ISSUES queries below



    -- HIGH CPU *******
    -- Get the most CPU intensive queries
    SET NOCOUNT ON;

    DECLARE @SpID smallint
    DECLARE spID_Cursor CURSOR
    FAST_FORWARD FOR
    
    SELECT TOP 25 spid
    FROM master..sysprocesses
    WHERE status = 'runnable'
    AND spid > 50   -- Eliminate system SPIDs
    AND spid <> @@SPID
    ORDER BY CPU DESC

    OPEN spID_Cursor

    FETCH NEXT FROM spID_Cursor
    INTO @spID
        WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT 'Spid #:' + STR(@spID)
            EXEC ('DBCC INPUTBUFFER (' + @spID + ')')

               FETCH NEXT FROM spID_Cursor
            INTO @spID
        END

    -- Close and deallocate the cursor
    CLOSE spID_Cursor;
    DEALLOCATE spID_Cursor;


      -- HIGH CPU *******
      -- Isolate top waits for server instance
      WITH Waits AS
      (
        SELECT
            wait_type,
            wait_time_ms / 1000. AS wait_time_s,
            100. * wait_time_ms / SUM(wait_time_ms) OVER() AS pct,
            ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS rn
        FROM sys.dm_os_wait_stats
        WHERE wait_type NOT LIKE '%SLEEP%'
      );
      SELECT
        W1.wait_type, 
        CAST(W1.wait_time_s AS DECIMAL(12, 2)) AS wait_time_s,
        CAST(W1.pct AS DECIMAL(12, 2)) AS pct,
        CAST(SUM(W2.pct) AS DECIMAL(12, 2)) AS running_pct
      FROM Waits AS W1
      INNER JOIN Waits AS W2
      ON W2.rn <= W1.rn
      GROUP BY W1.rn, W1.wait_type, W1.wait_time_s, W1.pct
      HAVING SUM(W2.pct) - W1.pct < 90 -- percentage threshold
      ORDER BY W1.rn;

      -- HIGH CPU *******
      -- Total waits are wait_time_ms (high signal waits indicates CPU pressure)
      SELECT '%signal (cpu) waits' = CAST(100.0 * SUM(signal_wait_time_ms) / SUM (wait_time_ms) AS NUMERIC(20,2)),
           '%resource waits'= CAST(100.0 * SUM(wait_time_ms - signal_wait_time_ms) / SUM (wait_time_ms) AS NUMERIC(20,2))
      FROM sys.dm_os_wait_stats;

      -- HIGH CPU *******
      -- Check SQL Server Schedulers to see if they are waiting on CPU (runnable tasks above 10 is very bad)
      SELECT scheduler_id, current_tasks_count, runnable_tasks_count
      FROM sys.dm_os_schedulers
      WHERE scheduler_id < 255

      -- HIGH CPU *******
      --  Who is running what at this instant 
      SELECT st.text AS [Command text], login_time, [host_name], 
      [program_name], sys.dm_exec_requests.session_id, client_net_address,
      sys.dm_exec_requests.status, command, db_name(database_id) AS DatabaseName
      FROM sys.dm_exec_requests 
      INNER JOIN sys.dm_exec_connections 
      ON sys.dm_exec_requests.session_id = sys.dm_exec_connections.session_id
      INNER JOIN sys.dm_exec_sessions 
      ON sys.dm_exec_sessions.session_id = sys.dm_exec_requests.session_id
      CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
      WHERE sys.dm_exec_requests.session_id >= 51
      AND sys.dm_exec_requests.session_id <> @@spid
      ORDER BY sys.dm_exec_requests.status

      -- HIGH CPU *******
      -- Get a snapshot of current activity
      SELECT LTRIM (st.text) AS 'Command Text',[host_name], der.session_id AS 'SPID',
      der.status, db_name(database_id) AS DatabaseName, ISNULL(der.wait_type, 'None')AS 'Wait Type', der.logical_reads 
      FROM sys.dm_exec_requests AS der
      INNER JOIN sys.dm_exec_connections AS dexc
      ON der.session_id = dexc.session_id
      INNER JOIN sys.dm_exec_sessions AS dexs
      ON dexs.session_id = der.session_id
      CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
      WHERE der.session_id >= 51
      AND der.session_id <> @@spid
      ORDER BY der.status

      -- BLOCKING ************
      -- Detect blocking
      SELECT blocked_query.session_id AS blocked_session_id,
      blocking_query.session_id AS blocking_session_id,
      sql_text.text AS blocked_text, sql_btext.text AS blocking_text, waits.wait_type AS blocking_resource
      FROM sys.dm_exec_requests AS blocked_query
      INNER JOIN sys.dm_exec_requests AS blocking_query 
      ON blocked_query.blocking_session_id = blocking_query.session_id
      CROSS APPLY
      (SELECT * FROM sys.dm_exec_sql_text(blocking_query.sql_handle)
      ) sql_btext
      CROSS APPLY
      (SELECT * FROM sys.dm_exec_sql_text(blocked_query.sql_handle)
      ) sql_text
      INNER JOIN sys.dm_os_waiting_tasks AS waits 
      ON waits.session_id = blocking_query.session_id

      -- BLOCKING ************
      -- Index Contention
      SELECT dbid=database_id, objectname=object_name(s.object_id),
      indexname=i.name, i.index_id, row_lock_count, row_lock_wait_count,
      [block %]= CAST (100.0 * row_lock_wait_count / (1 + row_lock_count) AS NUMERIC(15,2)),
      row_lock_wait_in_ms,
      [avg row lock waits in ms]= CAST (1.0 * row_lock_wait_in_ms / (1 + row_lock_wait_count) AS NUMERIC(15,2))
      FROM sys.dm_db_index_operational_stats (db_id(), NULL, NULL, NULL) AS s
      INNER JOIN sys.indexes AS i
      ON i.object_id = s.object_id
      WHERE objectproperty(s.object_id,'IsUserTable') = 1
      AND i.index_id = s.index_id
      ORDER BY row_lock_wait_count DESC

      -- TRANSACTION LOG FULL *****
      -- Find the log reuse description for the transaction log
      SELECT name, database_id, log_reuse_wait_desc 
      FROM sys.databases

      -- TRANSACTION LOG FULL *****
      -- Individual File Size query
      SELECT name AS 'File Name' , physical_name AS 'Physical Name', size/128 AS 'Total Size in MB',
      size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS 'Available Space In MB'--, *
      FROM sys.database_files;

      -- IO ISSUES *****************
      -- Analyze DB IO, ranked by IO Stall %
      WITH DBIO AS
      (
        SELECT
            DB_NAME(IVFS.database_id) AS db,
            CASE WHEN MF.type = 1 THEN 'log' ELSE 'data' END AS file_type,
            SUM(IVFS.num_of_bytes_read + IVFS.num_of_bytes_written) AS io,
            SUM(IVFS.io_stall) AS io_stall
        FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS IVFS
            JOIN sys.master_files AS MF
              ON IVFS.database_id = MF.database_id
              AND IVFS.file_id = MF.file_id
        GROUP BY DB_NAME(IVFS.database_id), MF.type
      )
      SELECT db, file_type, 
        CAST(1. * io / (1024 * 1024) AS DECIMAL(12, 2)) AS io_mb,
        CAST(io_stall / 1000. AS DECIMAL(12, 2)) AS io_stall_s,
        CAST(100. * io_stall / SUM(io_stall) OVER()
               AS DECIMAL(10, 2)) AS io_stall_pct,
        ROW_NUMBER() OVER(ORDER BY io_stall DESC) AS rn
      FROM DBIO
      ORDER BY io_stall DESC;

      -- HIGH CPU ************
      -- Get Top 100 executed SP's ordered by execution count
      SELECT TOP 100 qt.text AS 'SP Name', qs.execution_count AS 'Execution Count',  
      qs.execution_count/DATEDIFF(Second, qs.creation_time, GetDate()) AS 'Calls/Second',
      qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
      qs.total_worker_time AS 'TotalWorkerTime',
      qs.total_elapsed_time/qs.execution_count AS 'AvgElapsedTime',
      qs.max_logical_reads, qs.max_logical_writes, qs.total_physical_reads, 
      DATEDIFF(Minute, qs.creation_time, GetDate()) AS 'Age in Cache'
      FROM sys.dm_exec_query_stats AS qs
      CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
      WHERE qt.dbid = db_id() -- Filter by current database
      ORDER BY qs.execution_count DESC

      -- HIGH CPU *************
      -- Get Top 20 executed SP's ordered by total worker time (CPU pressure)
      SELECT TOP 20 qt.text AS 'SP Name', qs.total_worker_time AS 'TotalWorkerTime', 
      qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
      qs.execution_count AS 'Execution Count', 
      ISNULL(qs.execution_count/DATEDIFF(Second, qs.creation_time, GetDate()), 0) AS 'Calls/Second',
      ISNULL(qs.total_elapsed_time/qs.execution_count, 0) AS 'AvgElapsedTime', 
      qs.max_logical_reads, qs.max_logical_writes, 
      DATEDIFF(Minute, qs.creation_time, GetDate()) AS 'Age in Cache'
      FROM sys.dm_exec_query_stats AS qs
      CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
      WHERE qt.dbid = db_id() -- Filter by current database
      ORDER BY qs.total_worker_time DESC
      