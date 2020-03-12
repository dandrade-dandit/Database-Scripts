create or replace function sisa_onwer.nextval_equipamento_envolvido(p_valor number) return number is
 v_cod_equipamento tab_equipamento_envolvido.cod_equipamento%type;
begin
  if p_valor is null then
   /*select seq_equipamento_envolvido.nextval into v_cod_equipamento from dual;*/
   
   select nvl(max(cod_equipamento), 0) + 1 
   into v_cod_equipamento
   from tab_equipamento_envolvido;
   
   return(v_cod_equipamento);
 end if;
 return(p_valor);
end;