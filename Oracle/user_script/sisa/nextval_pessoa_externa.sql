create or replace function nextval_pessoa_externa(p_valor number) return number is
 v_seq_pessoa_externa cad_pessoa_externa.seq_pessoa_externa%type;
begin
  if p_valor is null then
   /*select seq_pessoa_externa.nextval into v_seq_pessoa_externa from dual;*/
   
   select nvl(max(seq_pessoa_externa), 0) + 1 
   into v_seq_pessoa_externa
   from cad_pessoa_externa;
   
   return(v_seq_pessoa_externa);
 end if;
 return(p_valor);
end;