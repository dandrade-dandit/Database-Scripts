select INSTANCE_NUM, SEGMENT_NAME, STATUS
from dba_rollback_segs
order by INSTANCE_NUM, SEGMENT_NAME
/
