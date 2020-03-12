1) Desistalar versão anterior se nunca tiver usado (é o nosso caso);
2) Entrar no SQL Plus como SYS;
3) Executar @apxremov.sql no diretório do apex baixado;
4) Sair do SQL Plus;
5) Entrar no SQL Plus como SYS;
6) Executar @apexins.sql SYSAUX SYSAUX TEMP /i/;
7) Sair do SQL Plus;
8) Descobrir o diretório acima do diretório do apex baixado;
9) Entrar no SQL Plus como SYS;
10) Executar @apxldimg /oracle/app/oracle
11) Executar @apex_epg_config.sql
12) Executar @apxconf.sql e incluir senha temporaria tipo Dan123#
13) Executar alter user anonymous account unlock;
14) Sair do SQL Plus;
15) Entrar no browser e digitar http://192.168.0.13:8585/apex
16) Trocar a senha para Oracle123#. Usuário: Admin. Workspace: internal
17) Endereço na Infraero: http://oraclei.dsv.infraero.gov.br:8585/apex - Usuário: Admin - Senha:Infraer0# - Workspace: internal


--************************************************************************************************************
--INSTALAÇÃO DO ORACLE APEX 5 NO SERVIDOR DE DSV(oraclei.dsv.infraero.gov.br) - ORACLE DA INFRAERO
--************************************************************************************************************

1) Copiar apex_5.0.3.zip para pasta /u01/app/oracle
2) Executar unizip apex_5.0.3.zip e depois cd apex
3) Desistalar versão anterior se nunca tiver usado (é o nosso caso);
4) Entrar no SQL Plus como SYS;
5) Executar: @apxremov.sql no diretório do apex baixado;
6) Sair do SQL Plus;
7) Entrar no SQL Plus como SYS;
8) Executar: @apexins.sql SYSAUX SYSAUX TEMP /i/;
9) Sair do SQL Plus;
10) Descobrir o diretório acima do diretório do apex baixado executando pwd e retirando a pasta apex(/u01/app/oracle);
11) Entrar no SQL Plus como SYS;
12) Executar: @apxldimg /u01/app/oracle
13) Executar: @apex_epg_config.sql
14) Executar: @apxconf.sql e incluir a senha do usuário admin: Infraer0#
15) Executar: alter user anonymous account unlock;
16) Sair do SQL Plus;
17) Endereço na Infraero: http://oraclei.dsv.infraero.gov.br:8585/apex - Usuário: Admin - Senha:Infraer0# - Workspace: internal
18) Não apagar nenhum objeto(tablespace, usuário, tabela, diretório no SO) com contenha a palavra 'apex'.


--******************************************************************************************
--CRIAR OBJETOS NO DSV
--******************************************************************************************
--DROP USER IFRSADA;

CREATE USER IFRAPEX_DOSA IDENTIFIED BY infraero;

ALTER USER IFRAPEX_DOSA QUOTA UNLIMITED ON TSD_APEX;

ALTER USER IFRAPEX_DOSA DEFAULT TABLESPACE TSD_APEX;

GRANT RESOURCE, CONNECT TO IFRAPEX_DOSA;


/*
SELECT * FROM DBA_DATA_FILES;

CREATE TABLESPACE TSD_APEX DATAFILE '/u01/app/oracle/oradata/desenv/tsd_apex01.dbf' SIZE 1G
EXTENT MANAGEMENT LOCAL AUTOALLOCATE;S
*/


--*****************************************************************************************************************
-- PASSOS PARA ATUALIZAR O ORACLE APEX.
--*****************************************************************************************************************
1)
SELECT DBMS_XDB.GETHTTPPORT FROM DUAL;

2)
EXEC DBMS_XDB.SETHTTPPORT(0);
COMMIT;

3)
@apxpatch.sql

4)
@apxldimg.sql /u01/app/oracle/apex/patch/patch

5)
EXEC DBMS_XDB.SETHTTPPORT(8585);
COMMIT;

6)
SELECT DBMS_XDB.GETHTTPPORT FROM DUAL;