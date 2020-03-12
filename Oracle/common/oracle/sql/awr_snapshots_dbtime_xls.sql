-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : awr_snapshots_dbtime_xls.sql                                    |
-- | CLASS    : Automatic Workload Repository                                   |
-- | PURPOSE  : Provide a list of all AWR snapshots and the total database time |
-- |            (DB Time) consumed within its interval. The output from this    |
-- |            script can be used when loading the data into MS Excel.         |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE   32767
SET PAGESIZE   50000
SET TRIMSPOOL  ON
SET HEAD       OFF
SET TERMOUT    OFF
SET FEEDBACK   OFF
SET VERIFY     OFF
SET TIMING     OFF
SET ECHO       OFF

DEFINE fileName=awr_snapshots_dbtime_xls

COLUMN dbname NEW_VALUE _dbname NOPRINT
SELECT name dbname FROM v$database;

COLUMN spool_time NEW_VALUE _spool_time NOPRINT
SELECT TO_CHAR(SYSDATE,'YYYYMMDD') spool_time FROM dual;

SPOOL &FileName._&_dbname._&_spool_time..txt

SELECT 
     'Instance Name'          || chr(9)
  || 'Instance Startup Time'  || chr(9)
  || 'Begin Interval Time'    || chr(9)
  || 'End Interval Time'      || chr(9)
  || 'Elapsed Time (min)'     || chr(9)
  || 'DB Time (min)'          || chr(9)
  || '% DB Time'
FROM  dual;

SELECT
     i.instance_name                                                                   || chr(9)
  || TO_CHAR(s.startup_time, 'mm/dd/yyyy HH24:MI:SS')                                  || chr(9)
  || TO_CHAR(s.begin_interval_time, 'mm/dd/yyyy HH24:MI:SS')                           || chr(9)
  || TO_CHAR(s.end_interval_time, 'mm/dd/yyyy HH24:MI:SS')                             || chr(9)
  || ROUND(EXTRACT(DAY FROM  s.end_interval_time - s.begin_interval_time) * 1440 +
           EXTRACT(HOUR FROM s.end_interval_time - s.begin_interval_time) * 60 +
           EXTRACT(MINUTE FROM s.end_interval_time - s.begin_interval_time) +
           EXTRACT(SECOND FROM s.end_interval_time - s.begin_interval_time) / 60, 2)   || chr(9)
  || ROUND((e.value - b.value)/1000000/60, 2)                                          || chr(9)
  || ROUND(((((e.value - b.value)/1000000/60) / (EXTRACT(DAY FROM  s.end_interval_time - s.begin_interval_time) * 1440 +
                                                 EXTRACT(HOUR FROM s.end_interval_time - s.begin_interval_time) * 60 +
                                                 EXTRACT(MINUTE FROM s.end_interval_time - s.begin_interval_time) +
                                                 EXTRACT(SECOND FROM s.end_interval_time - s.begin_interval_time) / 60) ) * 100), 2) instance_db_time
FROM
    dba_hist_snapshot       s
  , gv$instance             i
  , dba_hist_sys_time_model e
  , dba_hist_sys_time_model b
WHERE
      i.instance_number = s.instance_number
  AND e.snap_id         = s.snap_id
  AND b.snap_id         = s.snap_id - 1
  AND e.stat_id         = b.stat_id
  AND e.instance_number = b.instance_number
  AND e.instance_number = s.instance_number
  AND e.stat_name       = 'DB time'
ORDER BY
    i.instance_name
  , s.snap_id;

SPOOL OFF

EXIT
