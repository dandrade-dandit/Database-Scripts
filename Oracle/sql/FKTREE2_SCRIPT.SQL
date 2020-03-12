/* fktree2.sql */
/* Lista todas integridades referenciais envolvidas */
/* na tabela passada como parametro.                */
/* &1 = nome da tabela (pode ser em minusculas)     */

set verify off

col col2 noprint
col col3 noprint

select 'ALTER TABLE ' || a.owner || '.' || a.table_name || ' DISABLE CONSTRAINT  ' ||  a.constraint_name || ' ;' 
from user_constraints a,
     all_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and a.table_name = upper('&1')
union
select 'ALTER TABLE ' || a.owner || '.' || a.table_name || ' DISABLE CONSTRAINT  ' || a.constraint_name || ' ;'
from all_constraints a,
     user_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and b.table_name = upper('&1')
/