create or replace function nextval_ocor_seg(p_valor number) return number is
 v_seq_ocor_seg cad_ocor_seg.seq_ocor_seg%type;
begin
  if p_valor is null then
   /*select seq_ocor_seg.nextval into v_seq_ocor_seg from dual;*/
   
   select nvl(max(seq_ocor_seg), 0) + 1 
   into v_seq_ocor_seg
   from cad_ocor_seg;
   
   return(v_seq_ocor_seg);
 end if;
 return(p_valor);
end;