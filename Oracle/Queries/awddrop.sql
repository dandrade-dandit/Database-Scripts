select Min(SNAP_ID) from dba_hist_snapshot
/
select Max(SNAP_ID) from dba_hist_snapshot
/

EXECUTE DBMS_WORKLOAD_REPOSITORY.DROP_SNAPSHOT_RANGE(5117,5250);
