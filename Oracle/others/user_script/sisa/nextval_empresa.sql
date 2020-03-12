create or replace function nextval_empresa(p_valor number) return number is
 v_seq_empresa cad_empresa.seq_empresa%type;
begin
  if p_valor is null then
   /*select seq_empresa.nextval into v_seq_empresa from dual;*/
   
   select nvl(max(seq_empresa), 0) + 1 
   into v_seq_empresa
   from cad_empresa;
   
   return(v_seq_empresa);
 end if;
 return(p_valor);
end;