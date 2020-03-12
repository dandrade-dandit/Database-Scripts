create or replace function sisa3_owner.nextval_EQPTO_SEGURANCA(p_valor number) return number is
 v_COD_EQPTO_SEGURANCA TAB_EQPTO_SEGURANCA.COD_EQPTO_SEGURANCA%type;
begin
  if p_valor is null then
   /*select seq_EQPTO_SEGURANCA.nextval into v_COD_EQPTO_SEGURANCA from dual;*/
   
   select nvl(max(COD_EQPTO_SEGURANCA), 0) + 1 
   into v_COD_EQPTO_SEGURANCA
   from TAB_EQPTO_SEGURANCA;
   
   return(v_COD_EQPTO_SEGURANCA);
 end if;
 return(p_valor);
end;