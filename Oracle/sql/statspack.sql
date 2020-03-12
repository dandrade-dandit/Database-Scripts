select * from STATS$SNAPSHOT
where SNAP_TIME > '04/01/05';

conn perfstat/perfstat

@?/rdbms/admin/statsrep.sql
@?/rdbms/admin/spreport.sql
 
 
/u01/staspack_sebu05.txt


sqlplus perfstat/perfstat

exec statspack.snap;

select instance_number, name,snap_id,snap_level,to_char(snap_time,'DD.MM.YYYY:HH24:MI:SS')
 "Date/Time" from stats$snapshot,v$database
 order by 1,3;

rem Enter the Lower and Upper Snapshot ID
@?/rdbms/admin/sppurge;


rem Create the Report

sqlplus perfstat/perfstat

@?/rdbms/admin/spreport.sql



STATSPACK has two types of collection options, level and threshold. The level parameter controls the type of data collected 
from Oracle, while the threshold parameter acts as a filter for the collection of SQL statements into the stats$sql_summary table.

SQL> SELECT * FROM stats$level_description ORDER BY snap_level;

Level 0    This level captures general statistics, including rollback segment, row cache, SGA, system events, background events, 
				     session events, system statistics, wait statistics, lock statistics, and Latch information. 
Level 5    This level includes capturing high resource usage SQL Statements, along with all data captured by lower levels. 
Level 6    This level includes capturing SQL plan and SQL plan usage information for high resource usage SQL Statements, along 
				     with all data captured by lower levels. 
Level 7    This level captures segment level statistics, including logical and physical reads, row lock, itl and buffer busy waits, 
				     along with all data captured by lower levels. 
Level 10   This level includes capturing Child Latch statistics, along with all data captured by lower levels. 

You can change the default level of a snapshot with the statspack.snap function. The i_modify_parameter => 'true' changes the level 
permanent for all snapshots in the future.

SQL> exec statspack.snap(i_snap_level => 5, i_modify_parameter => 'true');
