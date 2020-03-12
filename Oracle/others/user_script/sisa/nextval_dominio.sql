create or replace function SCA_OWNER.nextval_dominio(p_valor number) return number is
 v_seq_dominio tab_dominio.seq_dominio%type;
begin
  if p_valor is null then
   /*select seq_dominio.nextval into v_seq_dominio from dual;*/
   
   select nvl(max(seq_dominio), 0) + 1 
   into v_seq_dominio
   from tab_dominio;

   return(v_seq_dominio);
 end if;
 return(p_valor);
end;