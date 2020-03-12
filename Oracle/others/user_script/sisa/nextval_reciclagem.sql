create or replace function nextval_reciclagem(p_valor number) return number is
 v_seq_reciclagem cad_reciclagem.seq_reciclagem%type;
begin
  if p_valor is null then
   /*select seq_reciclagem.nextval into v_seq_reciclagem from dual;*/
   
   select nvl(max(seq_reciclagem), 0) + 1 
   into v_seq_reciclagem
   from cad_reciclagem;
   
   return(v_seq_reciclagem);
 end if;
 return(p_valor);
end;