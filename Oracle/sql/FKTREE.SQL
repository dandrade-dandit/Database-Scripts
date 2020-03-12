select a.table_name || ' ref pk de  ' || 
       b.table_name || ' ( ' || a.constraint_name || ' ) ' col1,
       'ALTER TABLE ' || a.owner || '.' || a.table_name || ' DISABLE CONSTRAINT ' || a.constraint_name || ';' col2,
       'ALTER TABLE ' || a.owner || '.' || a.table_name || ' ENABLE NOVALIDATE CONSTRAINT ' || a.constraint_name || ';' col3,
       2 col2,
       b.table_name col3
from dba_constraints a,
     dba_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and a.table_name = upper('UNIDADES_ORGANIZACIONAIS')
  and a.owner = 'IFRDBA2'
union
select b.table_name || ' e'' ref por ' || 
       a.table_name || ' ( ' || a.constraint_name || ' ) ' col1,
       'ALTER TABLE ' || a.owner || '.' || a.table_name || ' DISABLE CONSTRAINT ' || a.constraint_name || ';' col2,
       'ALTER TABLE ' || a.owner || '.' || a.table_name || ' ENABLE NOVALIDATE CONSTRAINT ' || a.constraint_name || ';' col3,
       1 col2,
       a.table_name col3
from dba_constraints a,
     dba_constraints b
where a.r_owner = b.owner
  and a.r_constraint_name = b.constraint_name
  and a.constraint_type = 'R'
  and b.constraint_type = 'P'
  and b.table_name = upper('UNIDADES_ORGANIZACIONAIS')
  and b.owner = 'IFRDBA2'
order by 2 desc, 3 asc
/
