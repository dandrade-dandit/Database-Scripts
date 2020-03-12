 rem |   Gera relatório (anal_cont.lis) com as informações da
 rem |       analise das contenções do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_cont.lis

 select 'Info. Redo ***********************'
 from dual
/

 select * 
 from v$logfile
/ 

 select * 
 from v$system_event 
 where event like '%log%'
/

 select * 
 from v$latch
 where name like '%redo%'
/

 spool off