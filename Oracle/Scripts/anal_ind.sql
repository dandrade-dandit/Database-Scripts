 rem |   Gera relatório (anal_ind.lis) com as informações da
 rem |       analise dos indices do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_ind.lis

 select 'alter system set timed_statistics = TRUE' 
 from dual
/
 select 'analyze index '||index_name||' validate structure;'
 from dba_indexes
 where owner <> 'SYS'
/
 select 'alter system set timed_statistics = FALSE' 
 from dual
/
 spool off

@c:\ronei\scripts\analy2.txt

 host del c:\ronei\scripts\analy2.txt
 spool c:\ronei\scripts\anal_ind.lis

 select name,lf_rows,lf_rows_len,del_lf_rows,del_lf_rows_len
 from index_stats
/
 spool off