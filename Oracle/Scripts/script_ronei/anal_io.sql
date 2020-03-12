 rem |   Gera relatório (anal_io.lis) com as informações da
 rem |       analise de I-O´s do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_io.lis

 select 'Executar anal_tab.txt ************'
 from dual
/

 select 'Executar anal_ind.txt ************'
 from dual
/

 select 'Info. Seg. Rollback ************'
 from dual
/

select ((sum(pct_free) / 100) * (sum(blocks) - sum(empty_blocks))) "Tot. Seg. Rollback"
 from dba_tables
 where owner <> 'SYS'
/

 select (((sum(pct_free) / 100) * (sum(blocks) - sum(empty_blocks))) * 2 ) "Tot. Redo Log"
 from dba_tables
 where owner <> 'SYS'
/

 select * 
 from v$waitstat
/

 select * 
 from v$rollstat
/ 

 spool off