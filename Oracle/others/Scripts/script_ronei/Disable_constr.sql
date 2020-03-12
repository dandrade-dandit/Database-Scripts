 rem |   Gera relatório (disable_&tabe.sql) com as informações de uma
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
 
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\disable_&tabe..sql
 select 'ALTER TABLE '||A.owner||'.'||A.table_name||' DISABLE CONSTRAINT '||A.constraint_name||';'
 from all_constraints A, all_constraints B
 where B.owner = '&dono' and B.table_name = '&tabe' and B.constraint_type='P' and
       A.r_owner=B.owner and A.r_constraint_name=B.constraint_name
 order by A.table_name
/
 spool off
/