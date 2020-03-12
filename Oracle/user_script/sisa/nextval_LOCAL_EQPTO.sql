create or replace function sisa3_owner.nextval_LOCAL_EQPTO(p_valor number) return number is
 v_COD_LOCAL_EQPTO CAD_LOCAL_EQPTO.COD_LOCAL_EQPTO%type;
begin
  if p_valor is null then
   /*select seq_LOCAL_EQPTO.nextval into v_COD_LOCAL_EQPTO from dual;*/
   
   select nvl(max(COD_LOCAL_EQPTO), 0) + 1 
   into v_COD_LOCAL_EQPTO
   from CAD_LOCAL_EQPTO;
   
   return(v_COD_LOCAL_EQPTO);
 end if;
 return(p_valor);
end;