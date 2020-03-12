create or replace function nextval_class_relper(p_valor number) return number is
 v_seq_class_relper tab_class_relper.seq_class_relper%type;
begin
  if p_valor is null then
   /*select seq_class_relper.nextval into v_seq_class_relper from dual;*/
   
   select nvl(max(seq_class_relper), 0) + 1 
   into v_seq_class_relper
   from tab_class_relper;

   return(v_seq_class_relper);
 end if;
 return(p_valor);
end;