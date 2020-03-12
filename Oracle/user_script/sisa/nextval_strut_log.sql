create or replace function nextval_strut_log(p_valor number) return number is
 v_seq_strut_log tab_strut_log.seq_strut_log%type;
begin
  if p_valor is null then
   /*select seq_strut_log.nextval into v_seq_strut_log from dual;*/

   select nvl(max(seq_strut_log), 0) + 1 
   into v_seq_strut_log
   from tab_strut_log;
   
   return(v_seq_strut_log);
 end if;
 return(p_valor);
end;