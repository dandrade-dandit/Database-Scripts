create or replace function nextval_anexo_evento(p_valor number) return number is
 v_seq_anexo_evento cad_anexo_evento.seq_anexo_evento%type;
begin
  if p_valor is null then
   /*select seq_anexo_evento.nextval into v_seq_anexo_evento from dual;*/
   
   select nvl(max(seq_anexo_evento), 0) + 1 
   into v_seq_anexo_evento
   from cad_anexo_evento;
   
   return(v_seq_anexo_evento);
 end if;
 return(p_valor);
end;