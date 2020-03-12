REM Calculate buffer cache hit ratio in the database. Make sure it is more than 80 for an oltp environment and 99 is the best value. 

ttitle center 'CALCULATE BUFFER CACHE HIT RATIO' skip 2
column "logical_reads" format 999,999,999,999,999 
column "phys_reads" format 999,999,999,999 
column "phy_writes" format 999,999,999,999 
select a.value + b.value "logical_reads", 
c.value "phys_reads",
round(100 * ((a.value+b.value)-c.value) / 
(a.value+b.value)) 
"BUFFER HIT RATIO" 
from v$sysstat a, v$sysstat b, v$sysstat c
where 
a.statistic# = 38 
and 
b.statistic# = 39 
and 
c.statistic# = 40;
