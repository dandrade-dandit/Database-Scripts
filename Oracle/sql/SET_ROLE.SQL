grant RH_PERFIL_99 to denis;
alter user denis default role all except RH_PERFIL_99;
select * from dba_role_privs where grantee = 'DENIS';
exec dbms_session.set_role('RH_PERFIL_99');



--CRIA A ROLE
CREATE ROLE RTESTE;

--EXECUTA GRANT PARA UMA TABELA
GRANT SELECT ON CADASTROS TO RTESTE;

--CRIA O USUARIO
CREATE USER TESTE IDENTIFIED BY TESTE;

--GRANTS PARA O USUARIO
GRANT CREATE SESSION, RTESTE TO TESTE;

--RETIRA TODAS AS ROLES DEFAULT OU SOMENTE A QUE VC QUER...
ALTER USER TESTE DEFAULT ROLE NONE;

--CONECTA COM O USUARIO
CONN TESTE/TESTE@BANCO

--EXECUTA UM DESC
DESC CADASTROS

-- EXECUTA O COMANDO QUE HABILITA A ROLE EM TEMPO DE EXECU��O
EXEC DBMS_SESSION.SET_ROLE('RTESTE');

--EXECUTA UM DESC NOVAMENTE
DESC CADASTROS
