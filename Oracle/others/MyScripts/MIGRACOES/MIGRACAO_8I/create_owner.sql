SELECT 'CREATE USER '|| USERNAME ||' IDENTIFIED BY VALUES '''|| PASSWORD || ''';'
FROM DBA_USERS WHERE USERNAME IN (
'IFRCLIM','IFRSELO','IFRSRH','IFRMAXIMO','MAXIMO','IFRCOB','IFRDBA2',
'IFR_DESENV','IFRHUMANUS','IFRSGP','OPERACAO','BDCLIM_USU','MONIT',
'DISCOVERER','WEBSYS','OAS_PUBLIC')
/

DROP USER OAS_PUBLIC CASCADE;
DROP USER WEBSYS CASCADE;
DROP USER DISCOVERER CASCADE;
DROP USER MONIT CASCADE;
DROP USER BDCLIM_USU CASCADE;
DROP USER OPERACAO CASCADE;
DROP USER IFRSGP CASCADE;
DROP USER IFRHUMANUS CASCADE;
DROP USER IFR_DESENV CASCADE;
DROP USER IFRDBA2 CASCADE;
DROP USER IFRCOB CASCADE;
DROP USER MAXIMO CASCADE;
DROP USER IFRMAXIMO CASCADE;
DROP USER IFRSRH CASCADE;
DROP USER IFRSELO CASCADE;
DROP USER IFRCLIM CASCADE;
DROP USER SYSMAN CASCADE;

CREATE USER SYSMAN identified BY sysman
DEFAULT TABLESPACE system
TEMPORARY TABLESPACE system
/

GRANT DBA TO SYSMAN;

CREATE USER OAS_PUBLIC IDENTIFIED BY VALUES '881F98E2D1056815';
CREATE USER WEBSYS IDENTIFIED BY VALUES 'A6860F1C641AA6AF';
CREATE USER DISCOVERER IDENTIFIED BY VALUES '0050561D161A097E';
CREATE USER MONIT IDENTIFIED BY VALUES 'ED5E959AB9F54A1F';
CREATE USER BDCLIM_USU IDENTIFIED BY VALUES '3718F774942E1138';
CREATE USER OPERACAO IDENTIFIED BY VALUES '9510E749314E8098';
CREATE USER IFRSGP IDENTIFIED BY VALUES 'EED9D42F2BA86CE6';
CREATE USER IFRHUMANUS IDENTIFIED BY VALUES '8F637CC4AFE51013';
CREATE USER IFR_DESENV IDENTIFIED BY VALUES 'A0D2BCC35530ECE0';
CREATE USER IFRDBA2 IDENTIFIED BY VALUES '99C1FFE26C7C1589';
CREATE USER IFRCOB IDENTIFIED BY VALUES '9714E8EC6844C2FF';
CREATE USER MAXIMO IDENTIFIED BY VALUES 'F6C8EAF20205C8A7';
CREATE USER IFRMAXIMO IDENTIFIED BY VALUES '700A7716A0E89DF5';
CREATE USER IFRSRH IDENTIFIED BY VALUES 'FACD85D07C0D9729';
CREATE USER IFRSELO IDENTIFIED BY VALUES '426AC39C9B0EE7D3';
CREATE USER IFRCLIM IDENTIFIED BY VALUES '5C66B40CD9E1094D';

alter user ifrclim
default tablespace tsd_bdclim
temporary tablespace temp
quota unlimited on tsd_bdclim
/

alter user ifrclim
quota unlimited on ts_indice
/

grant resource, connect to ifrclim
/

alter user ifrselo
default tablespace tsd_selo
temporary tablespace temp
quota unlimited on tsd_selo
/

alter user ifrselo
quota unlimited on ts_indice
/

grant resource, connect to ifrselo
/

alter user ifrsrh
default tablespace tsd_pessoal
temporary tablespace temp
quota unlimited on tsd_pessoal
/

alter user ifrsrh
quota unlimited on ts_indice
/

grant resource, connect to ifrsrh
/

alter user ifrmaximo
default tablespace tsd_maximo
temporary tablespace temp
quota unlimited on tsd_maximo
/

alter user ifrmaximo
quota unlimited on ts_indice
/

grant resource, connect to ifrmaximo
/


alter user maximo
default tablespace tsd_maximo
temporary tablespace temp
quota unlimited on tsd_maximo
/

alter user maximo
quota unlimited on ts_indice
/

grant resource, connect to maximo
/

alter user ifrcob
default tablespace tsd_finan
temporary tablespace temp
quota unlimited on tsd_finan
/

alter user ifrcob
quota unlimited on ts_indice
/

grant resource, connect to ifrcob
/


alter user ifrdba2
default tablespace tsd_finan
temporary tablespace temp
quota unlimited on tsd_finan
/

alter user ifrdba2
quota unlimited on ts_indice
/

grant resource, connect to ifrdba2
/


alter user ifr_desenv 
default tablespace tsd_finan
temporary tablespace temp
quota unlimited on tsd_finan
/

alter user ifr_desenv
quota unlimited on ts_indice
/

grant resource, connect to ifr_desenv
/

alter user ifrhumanus
default tablespace tsd_pessoal
temporary tablespace temp
quota unlimited on tsd_pessoal
/

alter user ifrhumanus
quota unlimited on ts_indice
/

grant resource, connect to ifrhumanus
/

alter user ifrsgp
default tablespace tsd_finan
temporary tablespace temp
quota unlimited on tsd_finan
/

alter user ifrsgp
quota unlimited on ts_indice
/

grant resource, connect to ifrsgp
/

alter user operacao
default tablespace tools
temporary tablespace temp
quota unlimited on tools
/

alter user operacao
quota unlimited on ts_indice
/

grant resource, connect to operacao
/


alter user bdclim_usu
default tablespace tsd_bdclim
temporary tablespace temp
quota unlimited on tsd_bdclim
/

alter user bdclim_usu
quota unlimited on ts_indice
/

grant resource, connect to bdclim_usu
/


alter user monit
default tablespace tools
temporary tablespace temp
quota unlimited on tools
/

alter user monit
quota unlimited on ts_indice
/

grant resource, connect to monit
/

alter user discoverer
default tablespace tools
temporary tablespace temp
quota unlimited on tools
/

alter user discoverer
quota unlimited on ts_indice
/

grant resource, connect to discoverer
/


alter user websys 
default tablespace system
temporary tablespace system
quota unlimited on system
/

alter user oas_public
default tablespace system
temporary tablespace system
quota unlimited on system
/


SPO D:\USERS.SQL
select 'DROP USER ' || USERNAME || ' CASCADE;' 
from dba_users
where DEFAULT_TABLESPACE != 'SYSTEM'
AND USERNAME NOT IN (
'IFRCLIM','IFRSELO','IFRSRH','IFRMAXIMO','MAXIMO','IFRCOB','IFRDBA2',
'IFR_DESENV','IFRHUMANUS','IFRSGP','OPERACAO','BDCLIM_USU','MONIT',
'DISCOVERER','WEBSYS','OAS_PUBLIC')
/

SPO OFF

SPO D:\CREATE_USERS.SQL
select 'CREATE USER ' || USERNAME || ' IDENTIFIED BY ''' || PASSWORD || ''' DEFAULT TABLESPACE TOOLS TEMPORARY ;' 
from dba_users
where DEFAULT_TABLESPACE != 'SYSTEM'
AND USERNAME NOT IN (
'IFRCLIM','IFRSELO','IFRSRH','IFRMAXIMO','MAXIMO','IFRCOB','IFRDBA2',
'IFR_DESENV','IFRHUMANUS','IFRSGP','OPERACAO','BDCLIM_USU','MONIT',
'DISCOVERER','WEBSYS','OAS_PUBLIC')
/

SPO OFF
