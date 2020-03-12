column segment_name format A20
select segment_name, partition_name, segment_type, tablespace_name
from dba_segments
where segment_name = UPPER('&&TAB')
order by partition_name
/
