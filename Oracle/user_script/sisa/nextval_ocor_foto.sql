create or replace function sisa1_owner.nextval_ocor_foto(p_valor number) return number is
 v_cod_foto cad_ocor_foto.cod_foto%type;
begin
  if p_valor is null then
   /*select seq_ocor_foto.nextval into v_cod_foto from dual;*/
   
   select nvl(max(cod_foto), 0) + 1 
   into v_cod_foto
   from cad_ocor_foto;
   
   return(v_cod_foto);
 end if;
 return(p_valor);
end;