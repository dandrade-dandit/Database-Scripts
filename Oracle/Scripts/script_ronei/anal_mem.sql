 rem |   Gera relatório (anal_mem.lis) com as informações da
 rem |       analise da memoria do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_mem.lis

 select 'INFO. SHARED POOL........................................'
 FROM DUAL
/

 select *
 from v$librarycache
/

 select sum(sharable_mem) 
 from v$db_object_cache
/

 select sum(sharable_mem)
 from v$sqlarea
 where executions > 5
/

 select (sum(getmisses) / sum(get))
 from v$rowcache
/

 select sum(value)||' bytes' "Total max memory"
 from v$sesstat, v$statname
 where v$sesstat.statistic# = v$statname.statistic#
/ 

 select count(*) num_of_waiters
 from v$session_wait w, v$latch l
 where w.wait_time = 0 and
 w.event = 'latch free' and
 w.p2 = l.latch# and
 l.name like 'library%'
/

 select 'INFO. BUFFER CACHE........................................'
 FROM DUAL
/

 select (1 - (A.VALUE / (B.VALUE + C.VALUE))) 
 from V$SYSSTAT A,V$SYSSTAT B,V$SYSSTAT C 
 where A.NAME='physical reads' and B.name='consistent gets' and 
       C.name='db block gets'
/
 spool off