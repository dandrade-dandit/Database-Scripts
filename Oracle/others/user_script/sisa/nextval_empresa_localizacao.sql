create or replace function nextval_empresa_localizacao(p_valor number) return number is
 v_seq_empresa_local cad_empresa_localizacao.seq_empresa_local%type;
begin
  if p_valor is null then
   /*select seq_empresa_localizacao.nextval into v_seq_empresa_local from dual;*/
   
   select nvl(max(seq_empresa_local), 0) + 1 
   into v_seq_empresa_local
   from cad_empresa_localizacao;
   
   return(v_seq_empresa_local);
 end if;
 return(p_valor);
end;