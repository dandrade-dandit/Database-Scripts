REM Display the contention in rollback segments. 

ttitle center 'DISPLAY THE CONTENTION IN ROLLBACK SEGMENTS' skip 2
column "Ratio" format 99.99999 
select name, waits, gets, waits/gets "Ratio" 
from v$rollstat a, v$rollname b 
where a.usn = b.usn;
