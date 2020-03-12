select table_name,owner from dba_TABLES
WHERE TABLE_NAME LIKE '%&1%'
/
