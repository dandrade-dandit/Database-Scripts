create or replace function sisa3_owner.nextval_MODELO_EQPTO(p_valor number) return number is
 v_COD_MODELO_EQPTO CAD_MODELO_EQPTO.COD_MODELO_EQPTO%type;
begin
  if p_valor is null then
   /*select seq_MODELO_EQPTO.nextval into v_COD_MODELO_EQPTO from dual;*/
   
   select nvl(max(COD_MODELO_EQPTO), 0) + 1 
   into v_COD_MODELO_EQPTO
   from CAD_MODELO_EQPTO;
   
   return(v_COD_MODELO_EQPTO);
 end if;
 return(p_valor);
end;