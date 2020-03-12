 rem |   Gera relatório (foreign_sem_index.lis) com as constrainsts
 rem |       foreign_key que não possuem indices associados 
 rem |
 rem | parametros: nome do owner
 rem |

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\foreig_sem_index.lis
 
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
 
/
 select A.constraint_name,A.table_name,A.column_name
 from all_cons_columns A, all_constraints B
 where B.owner = '&dono' and A.owner = '&dono' and 
       B.table_name = A.table_name and 
       A.constraint_name = B.constraint_name and
       B.constraint_type = 'R' and
       not exists   (select *
            from all_ind_columns C
            where C.table_owner = A.owner and
                  C.table_name = A.table_name and
                  C.column_position = A.position and
                  C.column_name = A.column_name)
 order by A.table_name,A.constraint_name,A.position
/

 spool off