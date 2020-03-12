--Connectar como System e criar as contas abaixo:
--

create user CORRENTISTA identified by vpttrmyodys
default tablespace &&TSD_CORRENTISTA
temporary tablespace temp;

grant connect, resource to CORRENTISTA_ATU;

create user TECASIG_WEB identified by yrvsdohern
default tablespace &&TSD_CORRENTISTA
temporary tablespace temp;

grant create session to TECASIG_WEB;

create role CORRENTISTA_ADM;

grant CORRENTISTA_ADM to TECASIG_WEB;

grant ROLE_DCLC to TECASIG_WEB;

create user CORRENTISTA_ATU identified by vpttrmyodyssyi
default tablespace &&TSD_CORRENTISTA
temporary tablespace temp;

grant create session to CORRENTISTA_ATU;
grant create database link to CORRENTISTA_ATU;

