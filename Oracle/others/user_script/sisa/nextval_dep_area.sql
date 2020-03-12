create or replace function nextval_dep_area(p_valor number) return number is
 v_seq_dep_area cad_dep_area.seq_dep_area%type;
begin
  if p_valor is null then
   /*select seq_dep_area.nextval into v_seq_dep_area from dual;*/

   select nvl(max(seq_dep_area), 0) + 1 
   into v_seq_dep_area
   from cad_dep_area;

   return(v_seq_dep_area);
 end if;
 return(p_valor);
end;