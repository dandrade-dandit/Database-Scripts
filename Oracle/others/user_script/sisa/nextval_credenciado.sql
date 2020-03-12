create or replace function nextval_credenciado(p_valor number) return number is
 v_seq_credenciado cad_credenciado.seq_credenciado%type;
begin
  if p_valor is null then
   /*select seq_credenciado.nextval into v_seq_credenciado from dual;*/
   
   select nvl(max(seq_credenciado), 0) + 1 
   into v_seq_credenciado
   from cad_credenciado;
   
   return(v_seq_credenciado);
 end if;
 return(p_valor);
end;