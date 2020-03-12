col "Datafile Name" format a10

select 	t.NAME "Tablespace Name"
,	d.file# "Datafile #"
,	b.STATUS "Status"
,	b.CHANGE# "SCN Number"
,	To_Char(b.TIME, 'DD/MM/YYYY HH24:MI:SS') "Execution Date/Time"
from 	v$backup b
,	v$datafile d
,	v$tablespace t
where	b.FILE# = d.FILE#
and	d.TS# = t.TS#
order by
	t.NAME, b.time
/
