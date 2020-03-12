--   Valida no SRH, verifica se conta já existe verfica outros perfis e
--   atribui perfil.
--

 set echo off
 set heading off
 set verify off
 SET FEEDBACK OFF
 SET SERVEROUTPUT ON SIZE 100000

 ACCEPT conta PROMPT 'DIGITE A CONTA: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT perfil PROMPT 'DIGITE O PERFIL: '
 set echo on
 ACCEPT OK
 set echo off
 ACCEPT senha PROMPT 'DESEJA SENHA PADRÃO (S OU N): '
 set echo on
 ACCEPT OK
 set echo off

Declare
 var varchar2(4);
 cnt number;
 cursor_name INTEGER;
 ret INTEGER;

begin
   select substr('&perfil',1,3)||'%'
   into var from dual;
   select count(1)
   into cnt
   from ifrsrh.cadastros A
   where A.emp_numero_matricula = to_number('&conta') and
         A.emp_status <> 2;
   if cnt = 1 then
        select count(1)
        into cnt
        from dba_users A
        where A.username = 'I&conta';
        if cnt = 1 then
             select count(1)
             into cnt
             from dba_role_privs A
             where A.granted_role like var and
                   A.grantee = 'I&conta';
             if cnt = 0 then
                  cursor_name := DBMS_SQL.OPEN_CURSOR;
                  DBMS_SQL.PARSE(cursor_name, 'grant &perfil to I&conta', DBMS_SQL.NATIVE);
                  ret := DBMS_SQL.EXECUTE(cursor_name);
                  DBMS_SQL.CLOSE_CURSOR(cursor_name);
             else
                  dbms_output.put_line ('Conta possui outro perfil para o sistema');
             end if;
        else
             dbms_output.put_line ('Conta ainda não foi criada no BD');
        end if;
   else
        dbms_output.put_line ('Empregado não existe no IFRSRH.CADASTROS');
   end if;
end;
/
