create or replace function nextval_encaminhamento_relos(p_valor number) return number is
 v_seq_encaminhamento cad_encaminhamento_relos.seq_encaminhamento%type;
begin
  if p_valor is null then
   /*select seq_encaminhamento_relos.nextval into v_seq_encaminhamento from dual;*/
   
   select nvl(max(seq_encaminhamento), 0) + 1 
   into v_seq_encaminhamento
   from cad_encaminhamento_relos;
   
   return(v_seq_encaminhamento);
 end if;
 return(p_valor);
end;