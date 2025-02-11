CREATE OR REPLACE TRIGGER log_movimentacao
AFTER INSERT  OR UPDATE  OR  DELETE 
ON movimentacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN (user <> 'SRH_SFP')
declare
  v_mov_parcela                     log_movimentacao.mov_parcela%type;
  v_mov_parcela_atual               log_movimentacao.mov_parcela_atual%type;
  v_mov_emp_dep_codigo_pagto        log_movimentacao.mov_emp_dep_codigo_pagto%type;
  v_mov_tip_rubrica                 log_movimentacao.mov_tip_rubrica%type;
  v_mov_for_codigo                  log_movimentacao.mov_for_codigo%type;
  v_mov_parametro                   log_movimentacao.mov_parametro%type;
  v_mov_valor                       log_movimentacao.mov_valor%type;
  v_mov_ano_ref_diferenca           log_movimentacao.mov_ano_ref_diferenca%type;
  v_mov_mes_ref_diferenca           log_movimentacao.mov_mes_ref_diferenca%type;
  v_mov_pen_codigo                  log_movimentacao.mov_pen_codigo%type;
  v_mov_pkt_codigo_pedido           log_movimentacao.mov_pkt_codigo_pedido%type;
  v_mov_dias_proporcionalidade      log_movimentacao.mov_dias_proporcionalidade%type;
  v_mov_tipo_parametro              log_movimentacao.mov_tipo_parametro%type;
begin
  if inserting then
     insert into log_movimentacao (cod_usuario,dta_operacao,tip_operacao,mov_ano_referencia,
                 mov_mes_referencia,mov_versao_pagamento,mov_emp_numero_matricula,
                 mov_rub_codigo,mov_sequencial,mov_parcela,mov_parcela_atual,
                 mov_emp_dep_codigo_pagto,mov_tip_rubrica,mov_for_codigo,mov_parametro,
                 mov_valor,mov_ano_ref_diferenca,mov_mes_ref_diferenca,mov_pen_codigo,
                 mov_pkt_codigo_pedido,mov_dias_proporcionalidade,mov_tipo_parametro)
     values     (user, to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                 'I', :new.mov_ano_referencia, :new.mov_mes_referencia,
                 :new.mov_versao_pagamento, :new.mov_emp_numero_matricula,
                 :new.mov_rub_codigo, :new.mov_sequencial, :new.mov_parcela,
                 :new.mov_parcela_atual, :new.mov_emp_dep_codigo_pagto,
                 :new.mov_tip_rubrica, :new.mov_for_codigo, :new.mov_parametro,
                 :new.mov_valor, :new.mov_ano_ref_diferenca, :new.mov_mes_ref_diferenca,
                 :new.mov_pen_codigo, :new.mov_pkt_codigo_pedido,
                 :new.mov_dias_proporcionalidade, :new.mov_tipo_parametro);
  end if;
  if deleting then
     insert into log_movimentacao (cod_usuario,dta_operacao,tip_operacao,mov_ano_referencia,
                 mov_mes_referencia,mov_versao_pagamento,mov_emp_numero_matricula,
                 mov_rub_codigo,mov_sequencial,mov_parcela,mov_parcela_atual,
                 mov_emp_dep_codigo_pagto,mov_tip_rubrica,mov_for_codigo,mov_parametro,
                 mov_valor,mov_ano_ref_diferenca,mov_mes_ref_diferenca,mov_pen_codigo,
                 mov_pkt_codigo_pedido,mov_dias_proporcionalidade,mov_tipo_parametro)
     values     (user, to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                 'E', :old.mov_ano_referencia, :old.mov_mes_referencia,
                 :old.mov_versao_pagamento, :old.mov_emp_numero_matricula,
                 :old.mov_rub_codigo, :old.mov_sequencial, :old.mov_parcela,
                 :old.mov_parcela_atual, :old.mov_emp_dep_codigo_pagto,
                 :old.mov_tip_rubrica, :old.mov_for_codigo, :old.mov_parametro,
                 :old.mov_valor, :old.mov_ano_ref_diferenca, :old.mov_mes_ref_diferenca,
                 :old.mov_pen_codigo, :old.mov_pkt_codigo_pedido,
                 :old.mov_dias_proporcionalidade, :old.mov_tipo_parametro);
  end if;
  if updating then
     if :old.mov_parcela = :new.mov_parcela then
        v_mov_parcela := null;
     else
        v_mov_parcela := :old.mov_parcela;
     end if;
     if :old.mov_parcela_atual = :new.mov_parcela_atual then
        v_mov_parcela_atual := null;
     else
        v_mov_parcela_atual := :old.mov_parcela_atual;
     end if;
     if :old.mov_emp_dep_codigo_pagto = :new.mov_emp_dep_codigo_pagto then
        v_mov_emp_dep_codigo_pagto := null;
     else
        v_mov_emp_dep_codigo_pagto := :old.mov_emp_dep_codigo_pagto;
     end if;
     if :old.mov_tip_rubrica = :new.mov_tip_rubrica then
        v_mov_tip_rubrica := null;
     else
        v_mov_tip_rubrica := :old.mov_tip_rubrica;
     end if;
     if :old.mov_for_codigo = :new.mov_for_codigo then
        v_mov_for_codigo := null;
     else
        v_mov_for_codigo := :old.mov_for_codigo;
     end if;
     if :old.mov_parametro = :new.mov_parametro then
        v_mov_parametro := null;
     else
        v_mov_parametro := :old.mov_parametro;
     end if;
     if :old.mov_valor = :new.mov_valor then
        v_mov_valor := null;
     else
        v_mov_valor := :old.mov_valor;
     end if;
     if :old.mov_ano_ref_diferenca = :new.mov_ano_ref_diferenca then
        v_mov_ano_ref_diferenca := null;
     else
        v_mov_ano_ref_diferenca := :old.mov_ano_ref_diferenca;
     end if;
     if :old.mov_mes_ref_diferenca = :new.mov_mes_ref_diferenca then
        v_mov_mes_ref_diferenca := null;
     else
        v_mov_mes_ref_diferenca := :old.mov_mes_ref_diferenca;
     end if;
     if :old.mov_pen_codigo = :new.mov_pen_codigo then
        v_mov_pen_codigo := null;
     else
        v_mov_pen_codigo := :old.mov_pen_codigo;
     end if;
     if :old.mov_pkt_codigo_pedido = :new.mov_pkt_codigo_pedido then
        v_mov_pkt_codigo_pedido := null;
     else
        v_mov_pkt_codigo_pedido := :old.mov_pkt_codigo_pedido;
     end if;
     if :old.mov_dias_proporcionalidade = :new.mov_dias_proporcionalidade then
        v_mov_dias_proporcionalidade := null;
     else
        v_mov_dias_proporcionalidade := :old.mov_dias_proporcionalidade;
     end if;
     if :old.mov_tipo_parametro = :new.mov_tipo_parametro then
        v_mov_tipo_parametro := null;
     else
        v_mov_tipo_parametro := :old.mov_tipo_parametro;
     end if;
     insert into log_movimentacao (cod_usuario,dta_operacao,tip_operacao,mov_ano_referencia,
                 mov_mes_referencia,mov_versao_pagamento,mov_emp_numero_matricula,
                 mov_rub_codigo,mov_sequencial,mov_parcela,mov_parcela_atual,
                 mov_emp_dep_codigo_pagto,mov_tip_rubrica,mov_for_codigo,mov_parametro,
                 mov_valor,mov_ano_ref_diferenca,mov_mes_ref_diferenca,mov_pen_codigo,
                 mov_pkt_codigo_pedido,mov_dias_proporcionalidade,mov_tipo_parametro)
     values     (user, to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                 'A', :old.mov_ano_referencia, :old.mov_mes_referencia,
                 :old.mov_versao_pagamento, :old.mov_emp_numero_matricula,
                 :old.mov_rub_codigo, :old.mov_sequencial, v_mov_parcela,
                 v_mov_parcela_atual, v_mov_emp_dep_codigo_pagto,
                 v_mov_tip_rubrica, v_mov_for_codigo, v_mov_parametro,
                 v_mov_valor, v_mov_ano_ref_diferenca, v_mov_mes_ref_diferenca,
                 v_mov_pen_codigo, v_mov_pkt_codigo_pedido,
                 v_mov_dias_proporcionalidade, v_mov_tipo_parametro);
  end if;
end;
/
