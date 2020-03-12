col towner	heading 'Owner'			format a8 		trunc 
col tname	heading 'Table Name'		format a40 		trunc 
col exts	heading 'Exts'			format 99999 		trunc 
col omega1	heading 'Omega1'		format 000000.999999999999	trunc 
col chains	heading 'Chains'		format 9999,990 	trunc   

ttitle -   center  'Table Fragmentation Characteristics'   skip 2   

select 	owner towner,         
	name tname,
	no_extents exts,    
	(hwm - blks_w_rows)/(hwm + 0.0001) omega1,
        no_frag_rows chains  
from   tfrag  
order by 1,2  
/   