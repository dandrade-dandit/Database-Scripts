 rem |   Gera relatório (anal_desig.lis) com as informações da
 rem |       analise da estrutura do database conectado
 rem |
 rem | parametros: 
 rem |

 set pause off
 set heading off
 set echo off
 set verify off

 spool q:\scripts\anal_desig.lis

 select * 
 from v$datafile
/

 select * 
 from v$filestat
/

 select * 
 from v$logfile
/

 select * 
 from v$controlfile
/

 select owner,tablespace_name,table_name,
        pct_free,pct_used,ini_trans,max_trans,initial_extent,next_extent,min_extents,max_extents,pct_increase
 from dba_tables
 where owner <> 'SYS'
 order by owner,tablespace_name,table_name
/
 select owner,tablespace_name,index_name,
        pct_free,ini_trans,max_trans,initial_extent,next_extent,min_extents,max_extents,pct_increase
 from dba_indexes
 where owner <> 'SYS'
 order by owner,tablespace_name,index_name
/
 select owner,tablespace_name,cluster_name,
        pct_free,pct_used,key_size,ini_trans,max_trans,initial_extent,next_extent,min_extents,max_extents,pct_increase
 from dba_tables
 where owner <> 'SYS'
 order by owner,tablespace_name,cluster_name
/

 spool off