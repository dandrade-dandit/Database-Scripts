REM This should be near 0. If the Ratio is larger than 1% then increase the SHARED_POOL_SIZE. 

ttitle center 'CALCULATE PINS' skip 2
column libcache format 99.99 heading 'Percentage' jus cen
select sum(pins) "Total Pins", sum(reloads) "Total Reloads",
sum(reloads)/sum(pins) *100 libcache
from v$librarycache
/