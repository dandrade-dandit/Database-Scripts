create or replace function nextval_area(p_valor number) return number is
 v_seq_area tab_area.seq_area%type;
begin
  if p_valor is null then
   /*select seq_area.nextval into v_seq_area from dual;*/
   
   select nvl(max(seq_area), 0) + 1 
   into v_seq_area
   from tab_area;

   return(v_seq_area);
 end if;
 return(p_valor);
end;