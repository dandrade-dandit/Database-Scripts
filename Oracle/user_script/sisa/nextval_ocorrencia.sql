create or replace function nextval_ocorrencia(p_valor number) return number is
 v_seq_ocorrencia cad_ocorrencia.seq_ocorrencia%type;
begin
  if p_valor is null then
   /*select seq_ocorrencia.nextval into v_seq_ocorrencia from dual;*/
   
   select nvl(max(seq_ocorrencia), 0) + 1 
   into v_seq_ocorrencia
   from cad_ocorrencia;
   
   return(v_seq_ocorrencia);
 end if;
 return(p_valor);
end;