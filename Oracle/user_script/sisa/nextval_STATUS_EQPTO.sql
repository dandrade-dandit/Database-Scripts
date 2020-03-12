create or replace function sisa3_owner.nextval_STATUS_EQPTO(p_valor number) return number is
 v_COD_STATUS_EQPTO CAD_STATUS_EQPTO.COD_STATUS_EQPTO%type;
begin
  if p_valor is null then
   /*select seq_STATUS_EQPTO.nextval into v_COD_STATUS_EQPTO from dual;*/
   
   select nvl(max(COD_STATUS_EQPTO), 0) + 1 
   into v_COD_STATUS_EQPTO
   from CAD_STATUS_EQPTO;
   
   return(v_COD_STATUS_EQPTO);
 end if;
 return(p_valor);
end;