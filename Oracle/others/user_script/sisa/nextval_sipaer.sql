create or replace function nextval_sipaer(p_valor number) return number is
 v_seq_sipaer cad_sipaer.seq_sipaer%type;
begin
  if p_valor is null then
   /*select seq_sipaer.nextval into v_seq_sipaer from dual;*/
   
   select nvl(max(seq_sipaer), 0) + 1 
   into v_seq_sipaer
   from cad_sipaer;
   
   return(v_seq_sipaer);
 end if;
 return(p_valor);
end;