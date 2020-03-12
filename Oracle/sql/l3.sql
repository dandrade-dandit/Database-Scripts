REM  
REM ------------------------------------------------------------------------ 
REM DISCLAIMER: 
REM    This script is provided for educational purposes only. It is NOT  
REM    supported by Oracle World Wide Technical Support. 
REM    The script has been tested and appears to work as intended. 
REM    You should always run new scripts on a test instance initially. 
REM ------------------------------------------------------------------------ 
REM Main text of script follows: 

set linesize 80  
set pagesize 66  
column lmode heading 'Lock|Held' format a4  
column request heading 'Lock|Req.' format a4  
column username  format a10  heading 'Username'
column tab format a30 heading 'Table Name'  
column LAddr heading 'ID1 - ID2' format a16  
column Lockt heading 'Lock|Type' format a4  
select 	nvl(S.USERNAME,'Internal') username,  
      	decode(command,0,'None',decode(l.id2,0,U1.NAME||'.'||substr(T1.NAME,1,20), 'Rollback Segment')) tab,  
      	decode(L.LMODE,1,'NoLk', 2,' RS ', 3,' RX ',  4,'  S ', 5,' SRX', 6,'  X ','NONE') lmode,  
      	decode(L.REQUEST,1,'NoLk', 2,' RSh ', 3,' RX ', 4,'  S ', 5,' SRX', 6,'  X ','NONE') request,  
      	l.id1||'-'||l.id2 Laddr, 
      	l.type Lockt  
from    V$LOCK L, V$SESSION S, SYS.USER$ U1, SYS.OBJ$ T1  
where   L.SID = S.SID 
and     T1.OBJ# = decode(L.ID2,0,L.ID1,1)   
and    	U1.USER# = T1.OWNER# 
and  	S.TYPE != 'BACKGROUND'  
order by 1,2,5  
/ 
