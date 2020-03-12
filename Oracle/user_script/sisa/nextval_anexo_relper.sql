create or replace function nextval_anexo_relper(p_valor number) return number is
 v_seq_anexo_relper cad_anexo_relper.seq_anexo_relper%type;
begin
  if p_valor is null then
   /*select seq_anexo_relper.nextval into v_seq_anexo_relper from dual;*/
   
   select nvl(max(seq_anexo_relper), 0) + 1 
   into v_seq_anexo_relper
   from cad_anexo_relper;
   
   return(v_seq_anexo_relper);
 end if;
 return(p_valor);
end;