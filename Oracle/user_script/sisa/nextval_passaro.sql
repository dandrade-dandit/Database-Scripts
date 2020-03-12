create or replace function nextval_passaro(p_valor number) return number is
 v_cod_passaro cad_passaro.cod_passaro%type;
begin
  if p_valor is null then
   /*select seq_passaro.nextval into v_cod_passaro from dual;*/
   
   select nvl(max(cod_passaro), 0) + 1 
   into v_cod_passaro
   from cad_passaro;
   
   return(v_cod_passaro);
 end if;
 return(p_valor);
end;