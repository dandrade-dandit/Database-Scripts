Select 'ALTER ' || OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ' COMPILE;'
FROM dba_objects
WHERE OBJECT_TYPE IN ('PROCEDURE', 'FUNCTION', 'PACKAGE', 'TRIGGER', 'VIEW')
and status = 'INVALID'
and OBJECT_NAME not like '%$%'
/

Select 'ALTER PACKAGE ' || OWNER || '.' || OBJECT_NAME || ' COMPILE BODY;' 
FROM dba_objects
WHERE OBJECT_TYPE IN ('PACKAGE BODY')
and status = 'INVALID'
/