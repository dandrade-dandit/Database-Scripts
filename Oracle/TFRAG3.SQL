col towner	format a70  
col tname	format a70  
col exts	format 999  
col omega1	format 90.9999  
col chains	format 99,990  
col rpb		format 999  
col hwm		format 9,999,999  
col bwr		format 9,999,999  
 ttitle -   center  'Detailed Table Fragmentation Characteristics'  skip 2    
 
set heading off    

select  'Table Owner         : '||owner		towner,         
	'Name                : '||name		tname,
        'Extents             : '||no_extents		exts,
        'High water mark     : '||hwm			hwm,
        'Blocks with rows    : '||blks_w_rows		bwr,         
        'Block frag:Omega1   : '||ROUND((hwm - blks_w_rows)/(hwm + 0.0001), 4) omega1,         
        'Migrated rows       : '||no_frag_rows		chains  
from   tfrag
order by 1,2  

/    

set heading on   