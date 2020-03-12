/* fktree2.sql */
/* Lista todas integridades referenciais envolvidas */
/* na tabela passada como parametro.                */
/* &1 = nome da tabela (pode ser em minusculas)     */

set verify off

col col2 noprint
col col3 noprint

select a.table_name || ' ref pk de  ' || 
       b.table_name || ' ( ' || a.constraint_name || ' ) ' col1,
       2 col2,
       b.table_name col3
from user_constraints a,
     all_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and a.table_name = upper('&1')
union
select b.table_name || ' e'' ref por ' || 
       a.table_name || ' ( ' || a.constraint_name || ' ) ' col1,
       1 col2,
       a.table_name col3
from all_constraints a,
     user_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and b.table_name = upper('&1')
order by 2 desc, 3 asc
/
