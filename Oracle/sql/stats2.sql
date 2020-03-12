SET ECHO off  
REM NAME:   TFSDBSTA.SQL  
REM USAGE:"@path/tfsdbsta"  
REM ------------------------------------------------------------------------  
REM REQUIREMENTS:  
REM    SELECT on V$ tables  
REM ------------------------------------------------------------------------  
REM PURPOSE:  
REM    This is a script which was compiled from seven single-stat  
REM    scripts.  The output is fairly cryptic, but it is fast, and   
REM    the resulting report is compact.  For a more comprehensive  
REM    statistics report, look into MSTAT: PRE-1019592.6 or RSTAT:   
REM PRE-1020046.6.  
REM ------------------------------------------------------------------------  
REM EXAMPLE:  
REM      
REM          PINS    RELOADS  miss rate COMMENTS  
REM    ---------- ---------- ---------- ------------------------  REM38327        172 .448769797 okay  
REM  
REM          GETS  GETMISSES  miss rate COMMENTS  
REM    ---------- ---------- ---------- ------------------------  
REM   92511       4378  4.7324102 okay  
REM  
REM      PHYSICAL    LOGICAL   hit rate COMMENTS  
REM    ---------- ---------- ---------- ------------------------  
REM     350260    2198046 84.0649377 okay  
REM  
REM        memory        disk       rows COMMENTS  
REM    ---------- ----------- ---------- -----------------------  
REM          2342           7     119892 okay  
REM   
REM    enqueue waits per transaction  per logon COMMENTS  
REM    ------------- --------------- ---------- -------------------------  
REM                4      .040816327 .020833333 okay  
REM  
REM    DBWR checkpoints per transaction  per logon COMMENTS  
REM    ---------------- --------------- ---------- ----------------------  
REM                  98         1 .510416667 okay  
REM  
REM    redo log space requests per transaction  per logon COMMENTS  
REM    ----------------------- --------------- ---------- ---------------  
REM                         12       .12244898      .0625 okay  
REM   
REM ------------------------------------------------------------------------  
REM DISCLAIMER:  
REM    This script is provided for educational purposes only. It is NOT   
REM    supported by Oracle World Wide Technical Support.  
REM    The script has been tested and appears to work as intended.  
REM    You should always run new scripts on a test instance initially.  
REM ------------------------------------------------------------------------  
REM Main text of script follows:    
set echo off  
set verify off  
set feedback off    
def p=sum(pins)  
def r=sum(reloads)  
def m=&r/&p*100    
spool tfsdbsta.lst    
select &p pins,&r reloads, &m "miss rate",  	
decode(sign(&m-1),1,'increase shared_pool_size','okay') comments  
from v$librarycache  
/  
prompt  
prompt    
def g=sum(gets)  
def m=sum(getmisses)  
def mi=&m/&g*100  
select &g gets,&m getmisses, &mi "miss rate",  	
decode(sign(&mi-10),1,'increase shared_pool_size','okay') comments  
from v$rowcache  
/  
prompt  
prompt    
def p=sum(decode(statistic#,39,value,0))  
def l=sum(decode(statistic#,37,value,38,value,0))  
def h=(1-(&p/&l))*100  
select &p physical, &l logical, &h "hit rate",         
decode(sign(&h-70),-1,'increase db_block_buffer',                
decode(sign(&h-95),1,'decrease db_block_buffer','okay')) comments  
from v$sysstat  
/  
undef h  
prompt  
prompt    
col disk format 99,999,999,999  
def m=sum(decode(statistic#,121,value,0))  
def d=sum(decode(statistic#,122,value,0))  
def r=sum(decode(statistic#,123,value,0))  
select &m "memory",  	
&d "disk",   	
&r "rows",  	
decode(sign(&d-&m),1,'increase sort_area_size','okay') comments  
from v$sysstat  
/  
prompt  
prompt    
def t=sum(decode(statistic#,4,value,0))  
def l=sum(decode(statistic#,0,value,0))  
def e=sum(decode(statistic#,23,value,0))  
select  &e "enqueue waits",          
&e/&t "per transaction",          
&e/&l "per logon" ,          
decode(sign((&e/&t)-1),1,'increase enqueue_resources ','okay') comments  
from v$sysstat  
/  
prompt  
prompt    
def t=sum(decode(statistic#,4,value,0))  
def l=sum(decode(statistic#,0,value,0))  
def e=sum(decode(statistic#,58,value,0))  
select  &e "DBWR checkpoints",          
&e/&t "per transaction",      
&e/&l "per logon" ,          
decode(sign((&e/&t)-1),1,'increase log_checkpoint_interval ','okay')   comments  
from v$sysstat  
/  
prompt  
prompt    
def t=sum(decode(statistic#,4,value,0))  
def l=sum(decode(statistic#,0,value,0))  
def e=sum(decode(statistic#,83,value,0))  
select  &e "redo log space requests",          
&e/&t "per transaction",          
&e/&l "per logon" ,          
decode(sign((&e/&t)-1),1,'increase log_buffer ','okay') comments  
from v$sysstat  
/      
