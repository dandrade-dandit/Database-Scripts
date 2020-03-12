col onwer for a15
col OBJECT_NAME for a40
COL OBJECT_TYPE FOR a15

undef tab
accept tab char prompt 'Entre com a tabela: '

Select OWNER, OBJECT_NAME, OBJECT_TYPE
From dba_objects
where OBJECT_NAME like upper('%&tab%')
/

SELECT 'DESC '|| OWNER||'.'||OBJECT_NAME
From dba_objects
where OBJECT_NAME like upper('%&tab%')
AND OBJECT_TYPE = 'TABLE'
/