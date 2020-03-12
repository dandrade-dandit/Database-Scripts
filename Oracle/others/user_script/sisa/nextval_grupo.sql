create or replace function sca_owner.nextval_grupo(p_valor number) return number is
 v_seq_grupo cad_grupo.seq_grupo%type;
begin
  if p_valor is null then
   /*select seq_grupo.nextval into v_seq_grupo from dual;*/
   
   select nvl(max(seq_grupo), 0) + 1 
   into v_seq_grupo
   from cad_grupo; 
    
   return(v_seq_grupo);
 end if;
 return(p_valor);
end;