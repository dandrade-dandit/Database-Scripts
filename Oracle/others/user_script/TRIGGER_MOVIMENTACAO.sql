CREATE OR REPLACE TRIGGER trg_folha_fechada
BEFORE INSERT  OR DELETE  OR UPDATE
ON movimentacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
DECLARE
 v_folha_fechada    VARCHAR2(1) := 'N';
 v_mes              VARCHAR2(2);
 v_ano              VARCHAR2(4);
 v_versao           VARCHAR2(4);
 v_operacao         VARCHAR2(1);
 v_num_erro         NUMBER(6);
BEGIN
  -- Verifica se a folha esta fechada
  --
  IF INSERTING THEN
    v_folha_fechada := PKT_ERRO_FOLHA.FUN_FOLHA_FECHADA(:NEW.MOV_ANO_REFERENCIA,
                                                        :NEW.MOV_MES_REFERENCIA,
                                                        :NEW.MOV_VERSAO_PAGAMENTO
                                                        );
  ELSIF UPDATING OR DELETING THEN
    v_folha_fechada := PKT_ERRO_FOLHA.FUN_FOLHA_FECHADA(:OLD.MOV_ANO_REFERENCIA,
                                                        :OLD.MOV_MES_REFERENCIA,
                                                        :OLD.MOV_VERSAO_PAGAMENTO
                                                         );
  END IF;
  --
  IF v_folha_fechada = 'S' THEN
    IF INSERTING THEN
      -- Carrego o numero de Erro
      v_num_erro := -20010;
      -- Carrega a operacao que deu erro
      v_operacao := 'I';
      -- Se o erro foi gerado por um insert
      PKT_ERRO_FOLHA.PRC_CARREGA_ERRO_FOLHA(v_operacao,
                                            :NEW.MOV_ANO_REFERENCIA,
                                            :NEW.MOV_MES_REFERENCIA,
                                            :NEW.MOV_VERSAO_PAGAMENTO,
                                            :NEW.MOV_EMP_NUMERO_MATRICULA,
                                            :NEW.MOV_RUB_CODIGO,
                                            :NEW.MOV_SEQUENCIAL,
                                            :NEW.MOV_TIP_RUBRICA
                                            );
      -- Transformo a char as informações a ser mostradas no mensagem de erro
      v_mes     := LPAD(TO_CHAR(:NEW.MOV_MES_REFERENCIA),2,'0');
      v_ano     := TO_CHAR(:NEW.MOV_ANO_REFERENCIA);
      v_versao  := TO_CHAR(:NEW.MOV_VERSAO_PAGAMENTO);
      --
    ELSE -- O erro foi por update or delete
      IF UPDATING THEN
        -- Carrego o numero de Erro
        v_num_erro := -20020;
        -- Carrega a operacao que deu erro
        v_operacao := 'U';
      ELSIF DELETING THEN
        -- Carrego o numero de Erro
        v_num_erro := -20030;
        -- Carrega a operacao que deu erro
        v_operacao := 'D';
      END IF;
      --
      -- Se o erro foi gerado por um deleting or updating
      PKT_ERRO_FOLHA.PRC_CARREGA_ERRO_FOLHA(v_operacao,
                                            :OLD.MOV_ANO_REFERENCIA,
                                            :OLD.MOV_MES_REFERENCIA,
                                            :OLD.MOV_VERSAO_PAGAMENTO,
                                            :OLD.MOV_EMP_NUMERO_MATRICULA,
                                            :OLD.MOV_RUB_CODIGO,
                                            :OLD.MOV_SEQUENCIAL,
                                            :OLD.MOV_TIP_RUBRICA
                                            );
      -- Transformo a char as informações a ser mostradas no mensagem de erro
      v_mes     := LPAD(TO_CHAR(:OLD.MOV_MES_REFERENCIA),2,'0');
      v_ano     := TO_CHAR(:OLD.MOV_ANO_REFERENCIA);
      v_versao  := TO_CHAR(:OLD.MOV_VERSAO_PAGAMENTO);
      --
    END IF;
    --
    RAISE_APPLICATION_ERROR
                (v_num_erro, v_operacao||' - OPERAÇÃO CANCELADA !!! '||CHR(013)||
                  'Folha encerrada para Mês/Ano:'||v_mes||'/'||v_ano||
                  ' e Versão :'||v_versao||CHR(013) );
END IF; -- DE v_folha_fechada = 'S'
--
END;
/

