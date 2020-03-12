create or replace function sca_owner.nextval_sistema(p_valor number) return number is
 v_seq_sistema cad_sistema.seq_sistema%type;
begin
  if p_valor is null then
   /*select seq_sistema.nextval into v_seq_sistema from dual;*/

   select nvl(max(seq_sistema), 0) + 1 
   into v_seq_sistema
   from cad_sistema;

   return(v_seq_sistema);
 end if;
 return(p_valor);
end;