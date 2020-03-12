create or replace function nextval_tipo_ocorrencia_sisa(p_valor number) return number is
 v_seq_tipo_ocorrencia tab_tipo_ocorrencia_sisa.seq_tipo_ocorrencia%type;
begin
  if p_valor is null then
   /*select seq_tipo_ocorrencia_sisa.nextval into v_seq_tipo_ocorrencia from dual;*/
   
   select nvl(max(seq_tipo_ocorrencia), 0) + 1 
   into v_seq_tipo_ocorrencia
   from tab_tipo_ocorrencia_sisa;
   
   return(v_seq_tipo_ocorrencia);
 end if;
 return(p_valor);
end;