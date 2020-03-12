 rem |   Gera relatório (SHOW_&aplic.sql) com as informações de uma
 rem |       aplicacao informado
 rem |
 rem | parametros: nome da aplicacao
 rem |

-- parametrização necessaria
 set line 132
 set pause "click <enter>....."
 set pause off
 set heading off
 set echo off
 set verify off
 SET FEEDBACK OFF
 SET PAGESIZE 1000

 ACCEPT dono PROMPT 'DIGITE O NOME DA APLICAÇÃO: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT dblink PROMPT 'DIGITE O NOME DO DB-LINK (C/ @): '
 set echo on
 ACCEPT OK
 set echo off
 
 SET SERVEROUTPUT ON SIZE 1000000

 spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\DESC_&dono..tmp

DECLARE
 my_ow       all_tables.owner%type;
 my_apl      varchar2(20);
 my_tab      all_tables.table_name%type;

 cursor c1 is
   select owner,tabela,aplicacao
   from  tabelas&dblink A
   where A.aplicacao like '&dono' and (A.tipo='TABELA' or A.tipo='VIEW')
   order by A.tabela;

BEGIN 
  OPEN C1;
  dbms_output.put_line ('set echo on;');
  LOOP
    FETCH C1 inTO my_ow, my_tab, my_apl;
       EXIT WHEN C1%NOTFOUND;
        dbms_output.put_line ('-----------------------');
        dbms_output.put_line ('Desc '||my_ow||'.'||my_tab||';');
  end loop;
  close c1;
end;
/
spool off;

spool C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\DESC_&dono..txt;
begin
  dbms_output.put_line ('*****************************************************************************************');
  dbms_output.put_line ('** Describe: ');
end;
/

@C:\Sistemas\Sql\Infraero\Oracle\Scripts\script_ronei\DESC_&dono..tmp
set echo off;
spool off;