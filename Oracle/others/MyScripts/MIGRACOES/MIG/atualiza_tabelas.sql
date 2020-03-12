set heading off
SET FEEDBACK OFF

--SCRIPT QUE VERIFICA OS OBJETOS CADASTRADOS EM TABELAS E NAO EXISTEM NO DBA_OBJECTS

SPO mig\delete_from_tabelas.tmp;

SELECT 'DELETE FROM TABELAS WHERE OWNER=''' || OWNER || ''' AND TABELA=''' || TABELA || ''' AND TIPO=''' || TIPO ||''';' FROM IFRBANCO.TABELAS
MINUS
SELECT 'DELETE FROM TABELAS WHERE OWNER=''' || OWNER || ''' AND TABELA=''' || OBJECT_NAME || ''' AND TIPO=''' || OBJECT_TYPE ||''';'  FROM DBA_OBJECTS;

SPO OFF;

-- Verifica objetos que existem na dba_objects e não estão cadastrados

spo mig\insert_into_tabelas.tmp;

select 'insert into tabelas values (''SISTEMA DE AGENDA'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRAGENDA'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRAGENDA');
  

select 'insert into tabelas values (''SIPRECO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRBDE'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')   
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRBDE');
 
 
 select 'insert into tabelas values (''SIPRECO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRBDE_VIEWS'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRBDE_VIEWS');
 
 
select 'insert into tabelas values (''SISXXX'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRDBA2'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRDBA2');
 
 
 select 'insert into tabelas values (''SRHXXX'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRSRH'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRSRH');
 
 
 select 'insert into tabelas values (''SRHXXX'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRSRH2'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRSRH2');

  select 'insert into tabelas values (''HUMANUS'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRHUMANUS'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRHUMANUS');
  
 
  select 'insert into tabelas values (''MAXIMO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRMAXIMO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRMAXIMO');
 
 
  select 'insert into tabelas values (''SISELO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRSELO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRSELO');
 
 
  select 'insert into tabelas values (''GER DE PAVIMENTACAO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRSGP'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRSGP');
 
 
  select 'insert into tabelas values (''SEGUROS'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRVGA'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRVGA');
 
 
  select 'insert into tabelas values (''INTEGRACAO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'INTEGRACAO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'INTEGRACAO');
 
 
  select 'insert into tabelas values (''SST'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'SST'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'SST');
 
 
 select 'insert into tabelas values (''SST'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'SST_VIEWS'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'SST_VIEWS');
 
 
 select 'insert into tabelas values (''AUDIOMETRIA'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'SST_AUDIO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'SST_AUDIO');

 select 'insert into tabelas values (''SICOF'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRSICOF'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRSICOF');
 

select 'insert into tabelas values (''HELP DESK'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'HELPDESK'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'HELPDESK');
  
  
select 'insert into tabelas values (''BANCO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFRBANCO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFRBANCO');
  

select 'insert into tabelas values (''DESENVOLVIMENTO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'IFR_DESENV'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW') 
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'IFR_DESENV');  
  
  
select 'insert into tabelas values (''MONIT'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'MONIT'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'MONIT');
  
  
select 'insert into tabelas values (''OPERACAO'',''' || object_name || ''',''' || owner || ''',''' || object_type|| ''');' from dba_objects
  where owner = 'OPERACAO'
  and object_type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','SEQUENCE','TABLE','VIEW')  
  and object_name not in (
select tabela from ifrbanco.tabelas
  where owner = 'OPERACAO');    
 
 spo off;

set heading on
SET FEEDBACK on
 
 conn ifrbanco/jaguar@prodsede;
 
 @mig\delete_from_tabelas.tmp;

 @mig\insert_into_tabelas.tmp;
 
 commit;
 
 