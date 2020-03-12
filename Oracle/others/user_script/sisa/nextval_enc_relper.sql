create or replace function nextval_enc_relper(p_valor number) return number is
 v_seq_enc_relper cad_enc_relper.seq_enc_relper%type;
begin
  if p_valor is null then
   /*select seq_enc_relper.nextval into v_seq_enc_relper from dual;*/
   
   select nvl(max(seq_enc_relper), 0) + 1 
   into v_seq_enc_relper
   from cad_enc_relper;
   
   return(v_seq_enc_relper);
 end if;
 return(p_valor);
end;