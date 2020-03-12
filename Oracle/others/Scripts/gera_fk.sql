 rem |   Gera relatório (gera_fk_&tabe.lis) com as informações de uma
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
 SET FEEDBACK OFF
 SET PAGESIZE 1000
 ACCEPT tabe PROMPT 'DIGITE O NOME DA TABELA: '
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
 spool q:\scripts\gera_fk_&tabe..sql
 select 'ALTER TABLE '||A.owner||'.'||A.table_name,
 'add constraint '||A.constraint_name||' foreign key ('||C.column_name||')',
 'references '||B.table_name||' ('||D.column_name||');'
 from all_constraints A, all_constraints B, all_cons_columns C, all_cons_columns D
 where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='P' and
       D.owner = B.owner and D.constraint_name=B.constraint_name and
       A.r_owner=B.owner and A.r_constraint_name=B.constraint_name and
       C.owner=A.owner and C.constraint_name=A.constraint_name
 order by A.table_name
/
 spool off
/