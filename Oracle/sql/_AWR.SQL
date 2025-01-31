--AWR REPORT

@?/rdbms/admin/awrrpt.sql
@?/rdbms/admin/awrrpti.sql

@$ORACLE_HOME/rdbms/admin/awrrpt.sql
@$ORACLE_HOME/rdbms/admin/awrrpti.sql

--
SELECT 
output 
FROM TABLE (dbms_workload_repository.awr_report_text (37933856,1,2900,2911 ));


SELECT
output 
FROM TABLE(dbms_workload_repository.awr_report_text ( ));

--
Snapshots

BEGIN
DBMS_WORKLOAD_REPOSITORY.modify_snapshot_settings(
retention => 43200, -- Minutes (= 30 Days). Current value retained if NULL.
interval => 30); -- Minutes. Current value retained if NULL.
END;
/

Extra snapshots can be taken and existing snapshots can be removed, as shown below

EXEC DBMS_WORKLOAD_REPOSITORY.create_snapshot;

BEGIN
DBMS_WORKLOAD_REPOSITORY.drop_snapshot_range (
low_snap_id => 22, 
high_snap_id => 32);
END;
/

Baselines

BEGIN
DBMS_WORKLOAD_REPOSITORY.create_baseline (
start_snap_id => 210, 
end_snap_id => 220,
baseline_name => 'batch baseline');
END;
/

BEGIN
DBMS_WORKLOAD_REPOSITORY.drop_baseline (
baseline_name => 'batch baseline',
cascade => FALSE); -- Deletes associated snapshots if TRUE.
END;
/

Workload Repository Reports
@$ORACLE_HOME/rdbms/admin/awrrpt.sql
@$ORACLE_HOME/rdbms/admin/awrrpti.sql


--
How to create AWR report manually
29
10
2009
Oracle database 10g

If you do not have Oracle Enterprise Manager tool installed then you can create the AWR reports manually using the following commands:

1. Creating Snapshot
BEGIN
DBMS_WORKLOAD_REPOSITORY.CREATE_SNAPSHOT ();
END;
/

The list of the snapshot Ids along with database Ids is availabe in the view DBA_HIST_SNAPSHOT.

2. Dropping a Range of Snapshots.
Refer to the DBA_HIST_SNAPSHOT view column SNAP_ID to view available snapshots. To delete contain SNAP_ID from from 102 to 122,

BEGIN
DBMS_WORKLOAD_REPOSITORY.DROP_SNAPSHOT_RANGE (low_snap_id => 102, high_snap_id => 122, dbid => 8187786345);
END;
/

3. Modifying Snapshot Settings
If you want to modify the retention period as 43200 minutes (30 days), the interval between each snapshot is specified as 30 minutes, and the number of Top SQL to flush for each SQL criteria as 100 then use following:

BEGIN
DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS( retention => 43200,
interval => 30, topnsql => 100, dbid => 7123356265);
END;
/
The dbid is optional.

4. Extract the AWR Data
The awrextr.sql script extracts the AWR data for a range of snapshots from the database into a Data Pump export file. Once created, this dump file can be transported to another system where the extracted data can be loaded. To run the awrextr.sql script, you need to be connected to the database as the SYS user.

To extract AWR data at the SQL prompt, enter:

SQL> @$ORACLE_HOME/rdbms/admin/awrextr.sql

5. Load the AWR Data
Once the export dump file is transported to the target system, you can load the extracted AWR data using the awrload.sql script. The awrload.sql script will first create a staging schema where the snapshot data is transferred from the Data Pump file into the database. The data is then transferred from the staging schema into the appropriate AWR tables. To run the awrload.sql script, you need to be connected to the database as the SYS user.

To load AWR data at the SQL prompt, enter:

SQL> @$ORACLE_HOME/rdbms/admin/awrload.sql

6. Generate AWR Reports
The awrrpt.sql SQL script generates an HTML or text report that displays statistics for a range of snapshot Ids.
To generate an HTML or text report for a range of snapshot Ids, run the awrrpt.sql script at the SQL prompt:

SQL> @$ORACLE_HOME/rdbms/admin/awrrpt.sql

First, you need to specify whether you want an HTML or a text report.

Enter value for report_type: text

Specify the number of days for which you want to list snapshot Ids.

Enter value for num_days: 2

After the list displays, you are prompted for the beginning and ending snapshot Id for the workload repository report.

Enter value for begin_snap: 95
Enter value for end_snap: 97

Next, accept the default report name or enter a report name. The default name is accepted in the following example:

Enter value for report_name:
Using the report name awrrpt_1_95_97

The workload repository report is generated.

awrrpt.sql
The awrrpt.sql SQL script generates an HTML or text report that displays statistics for a range of snapshot Ids.

awrrpti.sql
The awrrpti.sql SQL script generates an HTML or text report that displays statistics for a range of snapshot Ids on a specified database and instance.

awrsqrpt.sql
The awrsqrpt.sql SQL script generates an HTML or text report that displays statistics of a particular SQL statement for a range of snapshot Ids. Run this report to inspect or debug the performance of a SQL statement.

awrsqrpi.sql
The awrsqrpi.sql SQL script generates an HTML or text report that displays statistics of a particular SQL statement for a range of snapshot Ids on a specified database and instance. Run this report to inspect or debug the performance of a SQL statement on a specific database and instance.

awrddrpt.sql
The awrddrpt.sql SQL script generates an HTML or text report that compares detailed performance attributes and configuration settings between two selected time periods.

awrddrpi.sql
The awrddrpi.sql SQL script generates an HTML or text report that compares detailed performance attributes and configuration settings between two selected time periods on a specific database and instance.

Best Luck 