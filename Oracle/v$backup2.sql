select t.name, b.status, b.change#, b.time
from v$backup b, v$tablespace t, v$datafile d
where b.file# = d.file#
and d.ts# = t.ts#
order by b.file#
/
