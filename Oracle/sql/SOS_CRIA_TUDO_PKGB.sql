 rem |   Gera relatório (sos_cria_&aplic.sql) com as informações de uma
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


ACCEPT dono PROMPT 'DIGITE O NOME DO OWNER: '
set echo on
ACCEPT OK
set echo off;

SET SERVEROUTPUT ON SIZE 1000000

set arraysize 1;
set maxdata 60000;
set long 32767;
  
declare
   v_txt varchar2(2000);
 
cursor c4
is 
   select DISTINCT s.name, s.owner 
     from dba_source S
    where S.owner= '&dono' and 
          S.type = 'PACKAGE BODY' 
     order by S.name;

begin

FOR x IN c4 LOOP
  
  v_txt := 'set termout off;' || CHR(10) ;
	v_txt := v_txt || 'set echo off;' || CHR(10) ;
	v_txt := v_txt || 'set pagesize 1000;' || CHR(10) ;
	v_txt := v_txt || 'col s_path new_value f_path;' || CHR(10) ;
	v_txt := v_txt || 'col name format a150 wrapped;' || CHR(10) ;

  v_txt := v_txt || 'select ''' || x.owner || '\pkg_body' || CHR(92)  || x.name || '.sql'' AS s_path from dual;' || CHR(10) ;
	v_txt := v_txt || 'spool d:\scripts' || CHR(92) || CHR(38) || 'f_path;' || CHR(10) ;
  v_txt := v_txt || 'set termout on;' || CHR(10) ;

 	v_txt := v_txt || 'select ''--### owner ' || x.owner || ''' from dual;' || CHR(10) ;
 	v_txt := v_txt || 'select ''CREATE OR REPLACE '' from dual;' || CHR(10) ;
  v_txt := v_txt || 'select S.TEXT AS NAME ';
  v_txt := v_txt || '  from dba_source S '|| CHR(10);
  v_txt := v_txt || ' where S.owner=  ''' || x.owner || ''' and S.type = ''PACKAGE BODY'' AND s.name = ''' || x.name|| '''  order by s.line;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

END;
/

