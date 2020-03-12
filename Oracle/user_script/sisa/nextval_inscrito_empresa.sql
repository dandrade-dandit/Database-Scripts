create or replace function sisa1_owner.nextval_inscrito_empresa(p_valor number) return number is
 v_seq_inscrito cad_inscrito_empresa.seq_inscrito%type;
begin
  if p_valor is null then
   /*select seq_inscrito_empresa.nextval into v_seq_inscrito from dual;*/
   
   select nvl(max(seq_inscrito), 0) + 1 
   into v_seq_inscrito
   from cad_inscrito_empresa;
   
   return(v_seq_inscrito);
 end if;
 return(p_valor);
end;