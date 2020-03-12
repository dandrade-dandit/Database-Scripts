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
  
cursor c2
is 
   select DISTINCT s.name, s.owner 
     from dba_source S
    where S.owner= '&dono' 
      and S.type = 'FUNCTION'
    order by S.name,S.line;
    
    
cursor c3
is 
   select DISTINCT s.name, s.owner 
      from dba_source S
     where S.type = 'PACKAGE' and
         S.owner= '&dono' 
  order by S.name,S.line;
  
  
cursor c4
is 
   select DISTINCT s.name, s.owner 
     from dba_source S
    where S.owner= '&dono' and 
          S.type = 'PACKAGE BODY' 
     order by S.name,S.line;
 
cursor c5
is 
   select  DISTINCT s.name, s.owner
     from  dba_source S
    where  S.owner= '&dono'  and 
           S.type = 'PROCEDURE'
  order by S.name,S.line; 


cursor c6
is
  select DISTINCT t.trigger_name, T.owner
    from dba_triggers T
   where T.table_owner='&dono'
 order by T.trigger_name;
 
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

FOR x IN c2 LOOP
  
  v_txt := 'set termout off;' || CHR(10) ;
	v_txt := v_txt || 'set echo off;' || CHR(10) ;
	v_txt := v_txt || 'set pagesize 1000;' || CHR(10) ;
	v_txt := v_txt || 'col s_path new_value f_path;' || CHR(10) ;
	v_txt := v_txt || 'col name format a150 wrapped;' || CHR(10) ;

  v_txt := v_txt || 'select ''' || x.owner || '\func' || CHR(92)  || x.name || '.sql'' AS s_path from dual;' || CHR(10) ;
	v_txt := v_txt || 'spool d:\scripts' || CHR(92) || CHR(38) || 'f_path;' || CHR(10) ;
  v_txt := v_txt || 'set termout on;' || CHR(10) ;

 	v_txt := v_txt || 'select ''--### owner ' || x.owner || ''' from dual;' || CHR(10) ;
  v_txt := v_txt || 'select S.name ';
  v_txt := v_txt || '  from dba_source S '|| CHR(10);
  v_txt := v_txt || ' where S.owner=  ''' || x.owner || ''' and s._name = ''' || x.name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

FOR x IN c3 LOOP
  
  v_txt := 'set termout off;' || CHR(10) ;
	v_txt := v_txt || 'set echo off;' || CHR(10) ;
	v_txt := v_txt || 'set pagesize 1000;' || CHR(10) ;
	v_txt := v_txt || 'col s_path new_value f_path;' || CHR(10) ;
	v_txt := v_txt || 'col name format a150 wrapped;' || CHR(10) ;

  v_txt := v_txt || 'select ''' || x.owner || '\pkg' || CHR(92)  || x.name || '.sql'' AS s_path from dual;' || CHR(10) ;
	v_txt := v_txt || 'spool d:\scripts' || CHR(92) || CHR(38) || 'f_path;' || CHR(10) ;
  v_txt := v_txt || 'set termout on;' || CHR(10) ;

 	v_txt := v_txt || 'select ''--### owner ' || x.owner || ''' from dual;' || CHR(10) ;
  v_txt := v_txt || 'select S.name ';
  v_txt := v_txt || '  from dba_source S '|| CHR(10);
  v_txt := v_txt || ' where S.owner=  ''' || x.owner || ''' and s._name = ''' || x.name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

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
  v_txt := v_txt || 'select S.name ';
  v_txt := v_txt || '  from dba_source S '|| CHR(10);
  v_txt := v_txt || ' where S.owner=  ''' || x.owner || ''' and s._name = ''' || x.name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

FOR x IN c5 LOOP
  
  v_txt := 'set termout off;' || CHR(10) ;
	v_txt := v_txt || 'set echo off;' || CHR(10) ;
	v_txt := v_txt || 'set pagesize 1000;' || CHR(10) ;
	v_txt := v_txt || 'col s_path new_value f_path;' || CHR(10) ;
	v_txt := v_txt || 'col name format a150 wrapped;' || CHR(10) ;

  v_txt := v_txt || 'select ''' || x.owner || '\proc' || CHR(92)  || x.name || '.sql'' AS s_path from dual;' || CHR(10) ;
	v_txt := v_txt || 'spool d:\scripts' || CHR(92) || CHR(38) || 'f_path;' || CHR(10) ;
  v_txt := v_txt || 'set termout on;' || CHR(10) ;

 	v_txt := v_txt || 'select ''--### owner ' || x.owner || ''' from dual;' || CHR(10) ;
  v_txt := v_txt || 'select S.name ';
  v_txt := v_txt || '  from dba_source S '|| CHR(10);
  v_txt := v_txt || ' where S.owner=  ''' || x.owner || ''' and s._name = ''' || x.name|| ''' ;'|| CHR(10);
  v_txt := v_txt || 'select ''/'' from dual;'|| CHR(10);
  v_txt := v_txt || 'spool off; ' || CHR(10) || CHR(13);

  DBMS_OUTPUT.PUT_LINE (v_txt);

END LOOP;

END;
/

