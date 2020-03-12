create or replace procedure sales_chk
authid current_user is
ipchk string(30);
begin
  select sys_context('USERENV','IP_ADDRESS')
  into ipchk from dual;
  if substr(ipchk,1,5) != '10.1.' then 
      return; 
  end if;
  dbms_session.set_role('SALESUSER');
end;
/
