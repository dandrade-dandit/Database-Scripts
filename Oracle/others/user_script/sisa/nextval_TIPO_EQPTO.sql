create or replace function sisa3_owner.nextval_TIPO_EQPTO(p_valor number) return number is
 v_COD_TIPO_EQPTO CAD_TIPO_EQPTO.COD_TIPO_EQPTO%type;
begin
  if p_valor is null then
   /*select seq_TIPO_EQPTO.nextval into v_COD_TIPO_EQPTO from dual;*/
   
   select nvl(max(COD_TIPO_EQPTO), 0) + 1 
   into v_COD_TIPO_EQPTO
   from CAD_TIPO_EQPTO;
   
   return(v_COD_TIPO_EQPTO);
 end if;
 return(p_valor);
end;