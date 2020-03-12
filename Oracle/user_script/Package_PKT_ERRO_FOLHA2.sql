-- Package PKT_ERRO_FOLHA
CREATE OR REPLACE
PACKAGE PKT_ERRO_FOLHA AS
   --
   -- Função que devolve 'S' no caso que a folha esteja fechada.
   -- A folha tem dois niveis de fechamento:
   --          4 - Fechamento parcial, so algums usuarios podem alterar a folha
   --          6 - Ninguém pode alterar a folha
   FUNCTION FUN_FOLHA_FECHADA
                    ( P_ANO     IN NUMBER,
                      P_MES     IN NUMBER,
                      P_VERSAO  IN NUMBER
                    )
            RETURN  VARCHAR2;
   --------------------------------------------------------
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
                        P_MOV_TIP_RUBRICA               MOVIMENTACAO.MOV_TIP_RUBRICA%TYPE
                                    );
   --------------------------------------------------------
END PKT_ERRO_FOLHA;
/
-- End of DDL script for PKT_ERRO_FOLHA

------------------------------------------


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
             WHERE USER IN ('CTIS0205','CTIS0227','I9608972', 'I9831285','CNBR');
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
                        P_MOV_TIP_RUBRICA               MOVIMENTACAO.MOV_TIP_RUBRICA%TYPE
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
              MOV_TIP_RUBRICA
              )
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
              P_MOV_TIP_RUBRICA
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

-- End of DDL script for PKT_ERRO_FOLHA
