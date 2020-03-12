create or replace function nextval_insc_sipaer_empresa(p_valor number) return number is
 v_seq_inscrito_sipaer cad_insc_sipaer_empresa.seq_inscrito_sipaer%type;
begin
  if p_valor is null then
   /*select seq_insc_sipaer_empresa.nextval into v_seq_inscrito_sipaer from dual;*/
   
   select nvl(max(seq_inscrito_sipaer), 0) + 1 
   into v_seq_inscrito_sipaer
   from cad_insc_sipaer_empresa;
   
   return(v_seq_inscrito_sipaer);
 end if;
 return(p_valor);
end;