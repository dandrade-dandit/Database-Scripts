create or replace function sca_owner.nextval_menu(p_valor number) return number is
 v_seq_menu cad_menu.seq_menu%type;
begin
  if p_valor is null then
   /*select seq_menu.nextval into v_seq_menu from dual;*/

   select nvl(max(seq_menu), 0) + 1 
   into v_seq_menu
   from cad_menu;

   return(v_seq_menu);
 end if;
 return(p_valor);
end;