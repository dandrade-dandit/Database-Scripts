create or replace function nextval_medida_adotada(p_valor number) return number is
 v_seq_medida cad_medida_adotada.seq_medida%type;
begin
  if p_valor is null then
   /*select seq_medida_adotada.nextval into v_seq_medida from dual;*/

   select nvl(max(seq_medida), 0) + 1 
   into v_seq_medida
   from cad_medida_adotada;

   return(v_seq_medida);
 end if;
 return(p_valor);
end;