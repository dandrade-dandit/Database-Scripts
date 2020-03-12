CREATE or replace function FUN_INTERVALO_ANOS (p_anos NUMBER)
    RETURN NUMBER IS
  v_intervalo NUMBER(1);
BEGIN
  IF 0 <= p_anos and p_anos <= 25 THEN
    v_intervalo := 1;
  ELSIF 25 < p_anos and p_anos <= 35 THEN
    v_intervalo := 2;
  ELSIF 35 < p_anos and p_anos <= 45 THEN
    v_intervalo := 3;
  ELSIF p_anos > 45 THEN
    v_intervalo := 4;
  ELSE
    v_intervalo := 0; -- O Indica Erro
  END IF;
  --
  RETURN v_intervalo;
END;
/

CREATE or replace function FUN_INTERVALO_ANUENIOS (p_anuenios NUMBER)
    RETURN NUMBER IS
  v_intervalo NUMBER(1);
BEGIN
  IF 0 <= p_anuenios and p_anuenios < 5 THEN
    v_intervalo := 1;
  ELSIF 5 <= p_anuenios and p_anuenios <= 13 THEN
    v_intervalo := 2;
  ELSIF p_anuenios > 13 THEN
    v_intervalo := 3;
  ELSE
    v_intervalo := 0; -- O Indica Erro
  END IF;
  --
  RETURN v_intervalo;
END;
/

GRANT EXECUTE ON FUN_INTERVALO_ANOS TO rh_perfil_99
/
GRANT EXECUTE ON FUN_INTERVALO_ANUENIOS TO rh_perfil_99
/


create public synonym FUN_INTERVALO_ANOS for ifrsrh.FUN_INTERVALO_ANOS
/

create public synonym FUN_INTERVALO_ANUENIOS for ifrsrh.FUN_INTERVALO_ANUENIOS
/

insert into ifrbanco.tabelas values ('SRHSFP','FUN_INTERVALO_ANOS','IFRSRH','FUNCAO')
/
insert into ifrbanco.tabelas values ('SRHSFP','FUN_INTERVALO_ANUENIOS','IFRSRH','FUNCAO')
/
