ACCEPT towner CHAR PROMPT 'ENTRE COM O ONWER: '
ACCEPT tname CHAR PROMPT 'ENTRE COM A TABELA: '

set verify off

REM def towner=&1  
REM def tname=&2

rem *******************************************************************  
rem * Goal: Analyze table to gather statistics
rem *******************************************************************  
rem Specifically we are looking for:  
rem - blocks ABOVE the hwm, i.e. empty blocks (dba_tables.blocks)  
rem - average row length (dba_tables.blocks) 
   
REM analyze
REM table &towner..&tname compute statistics  
REM /  

col val1 new_value blks_w_rows noprint  
col val2 new_value blks_above noprint  

select blocks val1,    
empty_blocks val2  
from   dba_tables  
where  owner = upper('&towner') and  
   table_name = upper('&tname')  
/  

rem *******************************************************************  
rem * Goal: Get the number of blocks allocated to the segment  
rem *******************************************************************
rem Specifically we are looking for:  
rem - allocated blocks dba_segments.blocks    

col val1 new_value alloc_blocks noprint  

select blocks val1  
from   dba_segments  
where owner        = upper('&towner') and        
      segment_name = upper('&tname')  
/    

rem *******************************************************************  
rem * Goal: Calculate the HWM  
rem *******************************************************************  
rem Specifically we are looking for:  
rem HWM = dba_segments.blocks - dba_tables.empty_blocks - 1  
rem HWM = allocated blocks - blocks above the hwn - 1

col val1 new_value hwm noprint  

select &alloc_blocks-&blks_above-1 val1   
from dual  
/    

rem *******************************************************************
rem * Goal: Get the Number of Fragmented Rows or Chained Frows (cr)  
rem *******************************************************************

col val1 new_value cr noprint  

select chain_cnt val1   
from dba_tables  
where owner        = upper('&towner')
and        table_name   = upper('&tname')  
/    

rem ***********************************************************
rem * Goal :  Determine the Segment Fragmentation (sf)  
rem ***********************************************************

col val1 new_val sf noprint  

select count(*) val1  
from   dba_extents  
where  owner        = upper('&towner')
and         segment_name = upper('&tname')  
/  

rem *********************************************************** 
rem ***********************************************************  
rem * Load the TFRAG table with the just gathered information.
rem ***********************************************************  
rem ***********************************************************
rem *  
rem * Create the tfrag table if it does not exist.  
rem *  drop table tfrag;

rem create table tfrag 
rem (   owner			char(30),
rem     name			char(30),
rem     hwm				number,
rem     blks_w_rows			number,
rem     avg_row_size		number,
rem     possible_bytes_per_block	number,
rem     no_frag_rows		number,
rem     no_extents			number  )  
rem /  

rem create unique index tfrag_u1 
rem on tfrag (owner,name)  
rem /  

rem *  
rem * Delete and insert the new stats.  
rem *  

delete   
from tfrag  
where owner='&towner' and
      name='&tname'  
/  

insert into tfrag values   ('&towner','&tname',&hwm,&blks_w_rows,0,0,&cr,&sf)
/  

commit;    

set verify on