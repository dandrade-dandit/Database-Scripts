/* listpk.sql */
/* Lista primary key so' da tabela passada como parametro */

set verify off
set feedb off

col constraint_name head "PK" format a10
col position head "Pos" format 999
col column_name format a40

select a.table_name,
       a.constraint_name,
       b.position,
       b.column_name
from   user_constraints a, 
       user_cons_columns b
where a.constraint_type = 'P'
and   a.owner = b.owner
and   a.constraint_name = b.constraint_name
and   a.table_name = b.table_name
and   a.table_name = upper('&1')
order by a.table_name,a.constraint_name,b.position
/

set feedb on
