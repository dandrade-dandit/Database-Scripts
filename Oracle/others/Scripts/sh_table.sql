 rem |   Gera relatório (sh_&tabe.lis) com as informações de uma
 rem |       tabela/owner informado
 rem |
 rem | parametros: nome da tabela e nome do owner
 rem |

 
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 ACCEPT tabe PROMPT 'DIGITE O NOME DA TABELA: '
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
 spool c:\ronei\scripts\&tabe._sh.lis

 select '       *****  Comentario da &dono/&tabe' from dual
/

 select comments
 from all_tab_comments
 where owner = '&dono' and table_name = '&tabe'
/

 select '       *****  Tablespace da &dono/&tabe' from dual
/
 select tablespace_name
 from all_tables
 where owner = '&dono' and table_name = '&tabe'
/

 select '       *****  Privilegios de acesso da &dono/&tabe' from dual
/
 break on grantee skip 1
 select grantee,grantor,privilege,grantable
 from all_tab_privs
 where table_schema = '&dono' and table_name = '&tabe'
/

 select '       *****  Sinonimos da &dono/&tabe' from dual
/
 break on owner skip 1
 select owner,synonym_name
 from all_synonyms
 where table_owner = '&dono' and table_name = '&tabe'
/ 

 select '       *****  Replicacao da &dono/&tabe' from dual
/
 select name,query
 from all_snapshots
 where owner = '&dono' and table_name = '&tabe'
/

 select '       *****  Colunas da &dono/&tabe' from dual
/
 desc &dono..&tabe
/

 select '       *****  Triggers da &dono/&tabe' from dual
/
 select trigger_name,trigger_type,triggering_event,description
 from all_triggers
 where table_owner = '&dono' and table_name = '&tabe'
/
 select trigger_name,trigger_body
 from all_triggers
 where table_owner = '&dono' and table_name = '&tabe'
/
 select '       *****  Constraints da &dono/&tabe' from dual
/
 select constraint_name,constraint_type,r_owner,r_constraint_name,
        search_condition
 from all_constraints
 where owner = '&dono' and table_name = '&tabe'
/
 select '       *****  Colunas das constraints da &dono/&tabe' from dual
/
 break on constraint_name skip 1
 select A.constraint_name,A.column_name
 from all_cons_columns A, all_constraints B
 where B.owner = '&dono' and B.table_name = '&tabe' and
       A.owner = '&dono' and A.table_name = '&tabe' and
       A.constraint_name = B.constraint_name
 order by A.owner,A.constraint_name,A.position
/
 select '       *****  Indices da &dono/&tabe' from dual
/
 break on owner skip 1
 select owner,index_name,tablespace_name,uniqueness
 from all_indexes
 where table_owner = '&dono' and table_name = '&tabe'
/
 select '       *****  Colunas dos indices da &dono/&tabe' from dual
/

 break on index_name skip 1
 select A.index_name,A.column_name
 from all_ind_columns A, all_indexes B
 where B.table_owner = '&dono' and B.table_name = '&tabe' and
       A.table_owner = '&dono' and A.table_name = '&tabe' and
       A.index_name = B.index_name
 order by A.table_owner,A.index_name,A.column_position
/

 spool off