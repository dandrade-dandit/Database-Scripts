create or replace function nextval_anexo_ocor(p_valor number) return number is
 v_seq_anexo_ocor cad_anexo_ocor.seq_anexo_ocor%type;
begin
  if p_valor is null then
   /*select seq_anexo_ocor.nextval into v_seq_anexo_ocor from dual;*/
   
   select nvl(max(seq_anexo_ocor), 0) + 1 
   into v_seq_anexo_ocor
   from cad_anexo_ocor;
   
   return(v_seq_anexo_ocor);
 end if;
 return(p_valor);
end;