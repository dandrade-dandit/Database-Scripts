create or replace function nextval_evento(p_valor number) return number is
 v_seq_evento cad_evento.seq_evento%type;
begin
  if p_valor is null then
   /*select seq_evento.nextval into v_seq_evento from dual;*/
   
   select nvl(max(seq_evento), 0) + 1 
   into v_seq_evento
   from cad_evento;
   
   return(v_seq_evento);
 end if;
 return(p_valor);
end;