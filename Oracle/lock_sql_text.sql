set pagesize 60 
set linesize 132 
select s.username username,  
       s.sid sid,   
       s.lockwait,  
       t.sql_text SQL 
from   v$sqltext t,  
       v$session s
where  t.address=s.sql_address  
and    t.hash_value=s.sql_hash_value  
and    s.sid = 2464
/ 

