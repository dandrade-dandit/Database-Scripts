create or replace function nextval_relper(p_valor number) return number is
 v_seq_relper cad_relper.seq_relper%type;
begin
  if p_valor is null then
   /*select seq_relper.nextval into v_seq_relper from dual;*/
   
   select nvl(max(seq_relper), 0) + 1 
   into v_seq_relper
   from cad_relper;
   
   return(v_seq_relper);
 end if;
 return(p_valor);
end;