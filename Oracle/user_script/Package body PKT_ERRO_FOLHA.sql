-- Package body PKT_ERRO_FOLHA

CREATE OR REPLACE
PACKAGE BODY PKT_ERRO_FOLHA
IS
--

  -- Função que devolve 'S' no caso que a folha esteja fechada.
  -- A folha tem dois niveis de fechamento:
  --          4 - Fechamento parcial, so algums usuarios podem alterar a folha
  --          6 - Ninguém pode alterar a folha
  FUNCTION FUN_FOLHA_FECHADA
                    ( P_ANO       IN NUMBER,
                      P_MES       IN NUMBER,
                      P_VERSAO    IN NUMBER
                    )
     RETURN  VARCHAR2 IS
     --
     -- Declaração de Variaveis
     v_folha_fechada      VARCHAR2(1) := 'N';
     v_tipo_fechamento    CRONOGRAMAS_PAGAMENTOS.crp_epg_codigo%TYPE;
     v_permissao_usuario  VARCHAR2(1) := 'N';
  BEGIN
    --
    BEGIN
      --
      -- Verifica se a folha esta fechada
        SELECT MAX(crp_epg_codigo)
          INTO v_tipo_fechamento
          FROM cronogramas_pagamentos
         WHERE crp_epg_codigo in (4,6)  -- 4 = Fechamento Parcial, 6 = Fechamento Geral
           AND crp_data_realizacao IS NOT NULL -- Se esta preenchido então a folha esta fechada
           AND crp_sequencial = p_versao
           AND crp_mes_pagamento < 13
           AND crp_mes_pagamento = p_mes
           AND crp_ano_pagamento = p_ano
         GROUP BY crp_epg_codigo;
      --
      -- Verifico o tipo de fechamento
      IF v_tipo_fechamento = 4 THEN -- Fechamento Parcial
          -- Verifica Permissão usuario
          BEGIN
            SELECT 'S'
              INTO v_permissao_usuario
              FROM DUAL
             WHERE USER IN ('CTIS0205','I9608972', 'I9831285','CNBR');
           --
           EXCEPTION
             WHEN OTHERS THEN
               v_permissao_usuario := 'N';
          END;
          IF v_permissao_usuario = 'S' THEN
            v_folha_fechada := 'N';
          ELSE
            v_folha_fechada := 'S';
          END IF;
      ELSE -- v_tipo_fechamento = 6-Fechamento Geral
        v_folha_fechada := 'S';
      END IF;
      --
    EXCEPTION
      WHEN no_data_found THEN
        v_folha_fechada := 'N';
      WHEN OTHERS THEN
        v_folha_fechada := 'S';
    END;
    --

    RETURN v_folha_fechada;
  END; -- Function FUN_FOLHA_FECHADA
----------------
----------------

----------------------------------------------------------
----------------------------------------------------------
  -- Procedimento que carrega um registro na tabela LOG_ERRO_FOLHA_FECHADA, com
  -- a informação do registro que não se insirio, atualizo ou apaga, segum corresponda,
  -- na tabela de movimentacao por fazer referenca a uma folha já fechada
  PROCEDURE PRC_CARREGA_ERRO_FOLHA(
                        P_OPERACAO                      VARCHAR2,
                        P_MOV_ANO_REFERENCIA            MOVIMENTACAO.MOV_ANO_REFERENCIA%TYPE,
                        P_MOV_MES_REFERENCIA            MOVIMENTACAO.MOV_MES_REFERENCIA%TYPE,
                        P_MOV_VERSAO_PAGAMENTO          MOVIMENTACAO.MOV_VERSAO_PAGAMENTO%TYPE,
                        P_MOV_EMP_NUMERO_MATRICULA      MOVIMENTACAO.MOV_EMP_NUMERO_MATRICULA%TYPE,
                        P_MOV_RUB_CODIGO                MOVIMENTACAO.MOV_RUB_CODIGO%TYPE,
                        P_MOV_SEQUENCIAL                MOVIMENTACAO.MOV_SEQUENCIAL%TYPE,
                        P_MOV_PARCELA                   MOVIMENTACAO.MOV_PARCELA%TYPE,
                        P_MOV_PARCELA_ATUAL             MOVIMENTACAO.MOV_PARCELA_ATUAL%TYPE,
                        P_MOV_RUB_SEQ_PAGAMENTO         MOVIMENTACAO.MOV_RUB_SEQ_PAGAMENTO%TYPE,
                        P_MOV_EMP_DEP_CODIGO_PAGTO      MOVIMENTACAO.MOV_EMP_DEP_CODIGO_PAGTO%TYPE,
                        P_MOV_TIP_RUBRICA               MOVIMENTACAO.MOV_TIP_RUBRICA%TYPE,
                        P_MOV_IND_CALCULO               MOVIMENTACAO.MOV_IND_CALCULO%TYPE,
                        P_MOV_IND_EXCLUSIVO             MOVIMENTACAO.MOV_IND_EXCLUSIVO%TYPE,
                        P_MOV_FOR_CODIGO                MOVIMENTACAO.MOV_FOR_CODIGO%TYPE,
                        P_MOV_PARAMETRO                 MOVIMENTACAO.MOV_PARAMETRO%TYPE,
                        P_MOV_VALOR                     MOVIMENTACAO.MOV_VALOR%TYPE,
                        P_MOV_ANO_REF_DIFERENCA         MOVIMENTACAO.MOV_ANO_REF_DIFERENCA%TYPE,
                        P_MOV_MES_REF_DIFERENCA         MOVIMENTACAO.MOV_MES_REF_DIFERENCA%TYPE,
                        P_MOV_PEN_CODIGO                MOVIMENTACAO.MOV_PEN_CODIGO%TYPE,
                        P_MOV_PKT_CODIGO_PEDIDO         MOVIMENTACAO.MOV_PKT_CODIGO_PEDIDO%TYPE,
                        P_MOV_VALOR_INTEGRAL            MOVIMENTACAO.MOV_VALOR_INTEGRAL%TYPE,
                        P_MOV_FUN_CODIGO                MOVIMENTACAO.MOV_FUN_CODIGO%TYPE,
                        P_MOV_DIAS_PROPORCIONALIDADE    MOVIMENTACAO.MOV_DIAS_PROPORCIONALIDADE%TYPE,
                        P_MOV_NSA_CODIGO_NIVEL          MOVIMENTACAO.MOV_NSA_CODIGO_NIVEL%TYPE,
                        P_MOV_OEM_EMP_NUMERO_MATRICULA  MOVIMENTACAO.MOV_OEM_EMP_NUMERO_MATRICULA%TYPE,
                        P_MOV_OEM_OFU_CODIGO            MOVIMENTACAO.MOV_OEM_OFU_CODIGO%TYPE,
                        P_MOV_OEM_DATA_INICIO           MOVIMENTACAO.MOV_OEM_DATA_INICIO%TYPE,
                        P_MOV_DATA_CALCULO              MOVIMENTACAO.MOV_DATA_CALCULO%TYPE,
                        P_MOV_PEM_BEN_SIGLA             MOVIMENTACAO.MOV_PEM_BEN_SIGLA%TYPE,
                        P_MOV_TIPO_FUNCAO               MOVIMENTACAO.MOV_TIPO_FUNCAO%TYPE,
                        P_MOV_TIPO_PARAMETRO            MOVIMENTACAO.MOV_TIPO_PARAMETRO%TYPE,
                        P_MOV_IND_13                    MOVIMENTACAO.MOV_IND_13%TYPE,
                        P_MOV_IND_ARSAPREV              MOVIMENTACAO.MOV_IND_ARSAPREV%TYPE,
                        P_MOV_IND_LANCAMENTO_LIQ_NEGAT  MOVIMENTACAO.MOV_IND_LANCAMENTO_LIQ_NEGAT%TYPE,
                        P_MOV_NSA_CODIGO_PADRAO         MOVIMENTACAO.MOV_NSA_CODIGO_PADRAO%TYPE,
                        P_MOV_NSA_INDICADOR_NIVEL_ESCO  MOVIMENTACAO.MOV_NSA_INDICADOR_NIVEL_ESCOLA%TYPE,
                        P_MOV_FLG_FREQUENCIA            MOVIMENTACAO.MOV_FLG_FREQUENCIA%TYPE
                                    )
  IS
  --------------------------------
  pragma AUTONOMOUS_TRANSACTION;
  ---------------------------------
  v_usuario         VARCHAR2(60);
  v_leg_codigo      NUMBER(10);
  v_estacao_trabalho VARCHAR2(40) := 'Desconhecida';
  --
  Begin
    --
    BEGIN
      -- Incremento a sequencia de registros da tabela LOG_ERRO_FOLHA_FECHADA
      SELECT NVL(MAX(LEF_CODIGO),0) + 1
        INTO v_leg_codigo
        FROM LOG_ERRO_FOLHA_FECHADA;
      -- Pego o nome do usuario ligado
      SELECT USER
        INTO v_usuario
        FROM DUAL;
      --
      -- Faço o Insere na tebela de erros
      INSERT INTO LOG_ERRO_FOLHA_FECHADA
            ( LEF_CODIGO,
              DATA,
              USUARIO,
              OPERACAO,
              MOV_ANO_REFERENCIA,
              MOV_MES_REFERENCIA,
              MOV_VERSAO_PAGAMENTO,
              MOV_EMP_NUMERO_MATRICULA,
              MOV_RUB_CODIGO,
              MOV_SEQUENCIAL,
              MOV_PARCELA,
              MOV_PARCELA_ATUAL,
              MOV_RUB_SEQ_PAGAMENTO,
              MOV_EMP_DEP_CODIGO_PAGTO,
              MOV_TIP_RUBRICA,
              MOV_IND_CALCULO,
              MOV_IND_EXCLUSIVO,
              MOV_FOR_CODIGO,
              MOV_PARAMETRO,
              MOV_VALOR,
              MOV_ANO_REF_DIFERENCA,
              MOV_MES_REF_DIFERENCA,
              MOV_PEN_CODIGO,
              MOV_PKT_CODIGO_PEDIDO,
              MOV_VALOR_INTEGRAL,
              MOV_FUN_CODIGO,
              MOV_DIAS_PROPORCIONALIDADE,
              MOV_NSA_CODIGO_NIVEL,
              MOV_OEM_EMP_NUMERO_MATRICULA,
              MOV_OEM_OFU_CODIGO,
              MOV_OEM_DATA_INICIO,
              MOV_DATA_CALCULO,
              MOV_PEM_BEN_SIGLA,
              MOV_TIPO_FUNCAO,
              MOV_TIPO_PARAMETRO,
              MOV_IND_13,
              MOV_IND_ARSAPREV,
              MOV_IND_LANCAMENTO_LIQ_NEGAT,
              MOV_NSA_CODIGO_PADRAO,
              MOV_NSA_INDICADOR_NIVEL_ESCOLA,
              MOV_FLG_FREQUENCIA )
           VALUES
             (
              v_leg_codigo,
              SYSDATE,
              v_usuario,
              P_OPERACAO,
              P_MOV_ANO_REFERENCIA,
              P_MOV_MES_REFERENCIA,
              P_MOV_VERSAO_PAGAMENTO,
              P_MOV_EMP_NUMERO_MATRICULA,
              P_MOV_RUB_CODIGO,
              P_MOV_SEQUENCIAL,
              P_MOV_PARCELA,
              P_MOV_PARCELA_ATUAL,
              P_MOV_RUB_SEQ_PAGAMENTO,
              P_MOV_EMP_DEP_CODIGO_PAGTO,
              P_MOV_TIP_RUBRICA,
              P_MOV_IND_CALCULO,
              P_MOV_IND_EXCLUSIVO,
              P_MOV_FOR_CODIGO,
              P_MOV_PARAMETRO,
              P_MOV_VALOR,
              P_MOV_ANO_REF_DIFERENCA,
              P_MOV_MES_REF_DIFERENCA,
              P_MOV_PEN_CODIGO,
              P_MOV_PKT_CODIGO_PEDIDO,
              P_MOV_VALOR_INTEGRAL,
              P_MOV_FUN_CODIGO,
              P_MOV_DIAS_PROPORCIONALIDADE,
              P_MOV_NSA_CODIGO_NIVEL,
              P_MOV_OEM_EMP_NUMERO_MATRICULA,
              P_MOV_OEM_OFU_CODIGO,
              P_MOV_OEM_DATA_INICIO,
              P_MOV_DATA_CALCULO,
              P_MOV_PEM_BEN_SIGLA,
              P_MOV_TIPO_FUNCAO,
              P_MOV_TIPO_PARAMETRO,
              P_MOV_IND_13,
              P_MOV_IND_ARSAPREV,
              P_MOV_IND_LANCAMENTO_LIQ_NEGAT,
              P_MOV_NSA_CODIGO_PADRAO,
              P_MOV_NSA_INDICADOR_NIVEL_ESCO,
              P_MOV_FLG_FREQUENCIA
             );
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    --
    COMMIT;
  End; -- PROCEDURE PRC_CARREGA_ERRO_FOLHA COM TODO O REGISTRO A SER CARREGADO

END; -- Package Body PKT_ERRO_FOLHA
/
