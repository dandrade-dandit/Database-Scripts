create or replace function sisa3_owner.nextval_EQPTO(p_valor number) return number is
 v_COD_EQPTO CAD_EQPTO.COD_EQPTO%type;
begin
  if p_valor is null then
   /*select seq_EQPTO.nextval into v_COD_EQPTO from dual;*/
   
   select nvl(max(COD_EQPTO), 0) + 1 
   into v_COD_EQPTO
   from CAD_EQPTO;
   
   return(v_COD_EQPTO);
 end if;
 return(p_valor);
end;