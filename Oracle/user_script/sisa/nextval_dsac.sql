create or replace function nextval_dsac(p_valor number) return number is
 v_seq_dsac cad_dsac.seq_dsac%type;
begin
  if p_valor is null then
   /*select seq_dsac.nextval into v_seq_dsac from dual;*/

   select nvl(max(seq_dsac), 0) + 1 
   into v_seq_dsac
   from cad_dsac;

   return(v_seq_dsac);
 end if;
 return(p_valor);
end;