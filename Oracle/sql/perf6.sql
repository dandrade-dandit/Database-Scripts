REM Display IO by file.

ttitle center 'Display IO by file' skip 2
column bytes format 999,999,999,990 heading 'Total bytes'
select 
substr(a.file#,1,2) "#", 
substr(a.name,1,50) "Name", 
a.status, 
a.bytes, 
b.phyrds, 
b.phywrts 
from v$datafile a, v$filestat b 
where a.file# = b.file#;
