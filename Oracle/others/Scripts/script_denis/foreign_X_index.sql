 rem |   Gera relatório (foreign_X_index.lis) com as informações das
 rem |       constraints foreign_key e indices de um owner
 rem |
 rem | parametros:nome do owner
 rem |

 
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_denis\foreign_X_index.lis

 select '       *****  Constraints do owner &dono' from dual
/
 break on table_name skip 1
 select A.table_name,A.constraint_name,A.column_name
 from all_cons_columns A, all_constraints B
 where B.owner = '&dono' and A.owner = '&dono' and 
       B.table_name = A.table_name and 
       A.constraint_name = B.constraint_name and
       B.constraint_type = 'R' 
 order by A.table_name,A.constraint_name,A.position
/
 select '       *****  Indices do owner &dono' from dual
/
 break on table_name,index_name skip 1
 select A.table_name,A.index_name,A.column_name
 from all_ind_columns A, all_indexes B
 where B.table_owner = '&dono' and A.table_owner = '&dono' and
       A.table_name = B.table_name and
       A.index_name = B.index_name
 order by A.table_name,A.index_name,A.column_position
/

 spool off