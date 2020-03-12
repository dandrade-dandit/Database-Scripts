create or replace function sisa3_owner.nextval_FABRICANTE(p_valor number) return number is
 v_COD_FABRICANTE CAD_FABRICANTE.COD_FABRICANTE%type;
begin
  if p_valor is null then
   /*select seq_FABRICANTE.nextval into v_COD_FABRICANTE from dual;*/
   
   select nvl(max(COD_FABRICANTE), 0) + 1 
   into v_COD_FABRICANTE
   from CAD_FABRICANTE;
   
   return(v_COD_FABRICANTE);
 end if;
 return(p_valor);
end;