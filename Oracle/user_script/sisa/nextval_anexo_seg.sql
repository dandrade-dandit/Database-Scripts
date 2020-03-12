create or replace function nextval_anexo_seg(p_valor number) return number is
 v_seq_anexo_seg cad_anexo_seg.seq_anexo_seg%type;
begin
  if p_valor is null then
   /*select seq_anexo_seg.nextval into v_seq_anexo_seg from dual;*/
   
   select nvl(max(seq_anexo_seg), 0) + 1 
   into v_seq_anexo_seg
   from cad_anexo_seg;
   
   return(v_seq_anexo_seg);
 end if;
 return(p_valor);
end;