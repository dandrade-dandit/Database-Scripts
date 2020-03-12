col event form A50 
col Prev form 999 
col Curr form 999 
col Tot form 999 
select event,sum(decode(wait_Time,0,0,1))
"Prev", sum(decode(wait_Time,0,1,0)) "Curr",count(*) "Tot" 
from v$session_Wait
group by event order by 4 
/ 


col event form A45 
select event,total_waits waits       
,total_timeouts timeouts       
,time_waited total_time  
from v$system_event  
order by 4 
/ 


col event form A45 
select event,total_waits waits       
,total_timeouts timeouts       
,time_waited total_time   
from v$session_event  
where sid = &sidnumber
order by 4 
/ 
