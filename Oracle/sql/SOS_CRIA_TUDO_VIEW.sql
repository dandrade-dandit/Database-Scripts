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

cursor c1
is
  select DISTINCT V.view_name, v.owner
    from dba_views V
   where V.owner =  '&dono' 
   order by V.view_name;
  
 
begin
	
FOR x IN c1 LOOP
  
  v_txt := 'set termout off;' || CHR(10) ;
	v_txt := v_txt || 'set echo off;' || CHR(10) ;
	v_txt := v_txt || 'set pagesize 1000;' || CHR(10) ;
	v_txt := v_txt || 'col s_path new_value f_path;' || CHR(10) ;
	v_txt := v_txt || 'col text format a150 wrapped;' || CHR(10) ;

  v_txt := v_txt || 'select ''' || x.owner || '\views' || CHR(92)  || x.view_name || '.sql'' AS s_path from dual;' || CHR(10) ;
	v_txt := v_txt || 'spool d:\scripts' || CHR(92) || CHR(38) || 'f_path;' || CHR(10) ;
  v_txt := v_txt || 'set termout on;' || CHR(10) ;

 	v_txt := v_txt || 'select ''--### owner ' || x.owner || ''' from dual;' || CHR(10) ;
	v_txt := v_txt || 'select ''CREATE OR REPLACE ''|| V.owner || ''.'' ||V.view_name || ''  IS'' ';
  v_txt := v_txt || '  from dba_views V '|| CHR(10);
  v_txt := v_txt || ' where V.owner =  ''' || x.owner || ''' and v.view_name = ''' || x.view_name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select V.text ';
  v_txt := v_txt || '  from dba_views V '|| CHR(10);
  v_txt := v_txt || ' where V.owner =  ''' || x.owner || ''' and v.view_name = ''' || x.view_name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

END;
/

