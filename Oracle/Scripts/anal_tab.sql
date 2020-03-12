 rem |   Gera relatório (anal_tab.lis) com as informações da
 rem |       analise das tabelas do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_tab.lis

 select 'alter system set timed_statistics = TRUE' 
 from dual
/
 select 'analyze table '||table_name||' compute statistics;'
 from dba_tables
 where owner <> 'SYS'
/
 select 'alter system set timed_statistics = FALSE' 
 from dual
/
 spool off

@c:\ronei\scripts\analy2.txt

 host del c:\ronei\scripts\analy2.txt
 spool c:\ronei\scripts\anal_tab.lis

 select 'chain_cnt / num_rows <= 0,1 (ideal)'
 from dual
/

 select table_name,num_rows,blocks,empty_blocks,avg_space,chain_cnt,avg_row_len
 from dba_tables
 where owner <> 'SYS'
/
 spool off