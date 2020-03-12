create or replace function nextval_problema_apurado(p_valor number) return number is
 v_seq_problema cad_problema_apurado.seq_problema%type;
begin
  if p_valor is null then
   /*select seq_problema_apurado.nextval into v_seq_problema from dual;*/
   
   select nvl(max(seq_problema), 0) + 1 
   into v_seq_problema
   from cad_problema_apurado;
   
   return(v_seq_problema);
 end if;
 return(p_valor);
end;