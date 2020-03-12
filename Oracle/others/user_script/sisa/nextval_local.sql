create or replace function nextval_local(p_valor number) return number is
 v_seq_local cad_local.seq_local%type;
begin
  if p_valor is null then
   /*select seq_local.nextval into v_seq_local from dual;*/

   select nvl(max(seq_local), 0) + 1 
   into v_seq_local
   from cad_local;

   return(v_seq_local);
 end if;
 return(p_valor);
end;