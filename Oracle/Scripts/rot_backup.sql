 rem |   Gera relatório (sos_cria_&aplic.sql) com as informações de uma
 rem |       aplicacao informado
 rem |
 rem | parametros: nome da aplicacao
 rem |

-- parametrização necessaria
 set line 132
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK OFF
 SET PAGESIZE 1000

 SET SERVEROUTPUT ON SIZE 100000

 spool c:\ronei\scripts\rot_backup.log
-- comando para criacao do bd

 select 'CREATE DATABASE '||NAME from V$DATABASE;
 select 'CONTROLFILE REUSE' from dual;
 select 'LOGFILE' from dual;

DECLARE
 virg       varchar2(1);
 logfile    varchar2(257);
 grupo      number(1);

 cursor c1 is
   select distinct(A.group#)
   from v$logfile A 
   order by A.group#;
 cursor c2 is
          select B.member 
          from v$logfile B
          where B.group#=grupo;
BEGIN 
 OPEN C1;
 LOOP
    FETCH C1 inTO grupo ;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put (virg); 
        dbms_output.put ('GROUP '||grupo||' (');
        begin
          open c2;
          virg := ' '; 
          loop
             fetch c2 into logfile;
             exit when c2%notfound;
             dbms_output.put (virg); 
             dbms_output.put (''''||logfile||'''');
             virg := ','; 
          end loop;
          close c2;
        end;
        dbms_output.put_line (') SIZE 30M');
 END LOOP;
 CLOSE C1;
 END;
/
select 'MAXLOGFILES 16 ' from dual;
select 'MAXLOGMEMBERS 2 ' from dual;
select 'MAXDATAFILES 300 ' from dual;
select 'MAXINSTANCES 4 ' from dual;
select 'MAXLOGHISTORY 100' from dual;
select LOG_MODE from V$DATABASE;
select 'CHARACTER SET '||VALUE from NLS_DATABASE_PARAMETERS
where parameter='NLS_CHARACTERSET';
select 'DATAFILE ' from dual;
select ''''||name||''' AUTOEXTEND OFF' from V$DATAFILE;

spool off 
