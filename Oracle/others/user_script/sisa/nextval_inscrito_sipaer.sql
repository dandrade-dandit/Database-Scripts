create or replace function nextval_inscrito_sipaer(p_valor number) return number is
 v_seq_inscrito_sipaer cad_inscrito_sipaer.seq_inscrito_sipaer%type;
begin
  if p_valor is null then
   /*select seq_inscrito_sipaer.nextval into v_seq_inscrito_sipaer from dual;*/
   
   select nvl(max(seq_inscrito_sipaer), 0) + 1 
   into v_seq_inscrito_sipaer
   from cad_inscrito_sipaer;
   
   return(v_seq_inscrito_sipaer);
 end if;
 return(p_valor);
end;