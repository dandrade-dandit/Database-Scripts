
select CONCAT(CONCAT('INSERT INTO IFRBANCO.CADASTROS_TERCEIROS VALUES (''', username), ''', NULL, NULL, NULL, NULL);') 
from dba_users
where (username like 'C%'
or username like 'E%'
or username like 'S%'
or username like 'T%'
or username like 'O%'
or username like 'V%'
or username like 'M%'
or username like 'G%')
AND username NOT LIKE 'OAS%'
ORDER BY 1
/


select username from dba_users
where (username like 'C%'
or username like 'E%'
or username like 'S%'
or username like 'T%'
or username like 'O%'
or username like 'V%'
or username like 'M%'
or username like 'G%')
AND username NOT LIKE 'OAS%'
ORDER BY 1
/

select username from dba_users
where username not like 'C%' and username not like 'E%' and username not like 'I%'
/

--UPDATE CADASTROS_TERCEIROS SET NOME = 'USUARIO DO MAXIMO'
,	AREA = 'ENGENHARIA'
,	STATUS = 1
,	SISTEMA = 'MAXIMO'
WHERE USUARIO LIKE 'ERF%'
or USUARIO LIKE 'ES%'
or USUARIO LIKE 'MAX%';


SELECT * FROM CADASTROS_TERCEIROS
WHERE STATUS IS NULL;


--DELETE CADASTROS_TERCEIROS
WHERE USUARIO LIKE 'CTXS%'
or USUARIO LIKE 'SST%'
or USUARIO LIKE 'OPERA%';

--UPDATE CADASTROS_TERCEIROS SET NOME = 'USUARIO DO TRACKIT NA REGIONAL SRBR'
,	AREA = 'SRBR'
,	STATUS = 1
,	SISTEMA = 'TRACKIT'
WHERE USUARIO LIKE 'CONNE%'


UPDATE IFRBANCO.CADASTRO_TERCEIROS SET 
	NOME = 'FRANCISCO FERREIRA'
,	AREA = 'DARH'
,	STATUS = 1
,	SISTEMA = 'GESTORH - BENEFÍCIO'
WHERE USUARIO = 'CTIS0207'
/