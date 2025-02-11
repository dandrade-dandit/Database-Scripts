-- Trigger log_ocorrencias_empregados
-- Trigger criado para controlar as opera��es de delete e update
-- feitas na tabela de OCORRENCIAS_EMPREGADOS
CREATE OR REPLACE TRIGGER log_ocorrencias_empregados
BEFORE DELETE OR UPDATE
ON ocorrencias_empregados
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de opera��o
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_OCORRENCIAS_EMPREGADOS
         (
          OEM_EMP_NUMERO_MATRICULA,
          OEM_OFU_CODIGO,
          OEM_DATA_INICIO,
          OEM_DATA_INCLUSAO,
          OEM_COD_USUARIO,
          OEM_DATA_TERMINO,
          OEM_TEXTO,
          OEM_DIPLOMA_LEGAL,
          OEM_OEM_EMP_NUMERO_MATRICULA,
          OEM_OEM_OFU_CODIGO,
          OEM_OEM_DATA_INICIO,
          OEM_EMP_NUMERO_MATRICULA_SUBST,
          OEM_UOR_CODIGO,
          OEM_OEX_CODIGO_CEDIDO,
          OEM_OEX_CODIGO_REQUISITADO,
          OEM_DATA_CANCEL_INTERRUPCAO,
          OEM_MOTIVO_CANCEL_INTERRUPCAO,
          OEM_INDICADOR_CANCELAMENTO,
          OEM_DEP_CODIGO,
          OEM_INDICADOR_ONUS,
          OEM_DIPLOMA_LEGAL_TERMINO,
          OEM_PFE_EMP_NUM_MATR_PROGRAM,
          OEM_PFE_SEQUENCIAL_PROGRAM,
          OEM_PFE_EMP_NUM_MATR_CONFIRM1,
          OEM_PFE_SEQUENCIAL_CONFIRM1,
          OEM_PFE_EMP_NUM_MATR_CONFIRM2,
          OEM_PFE_SEQUENCIAL_CONFIRM2,
          OEM_FUN_CODIGO,
          OEM_FUN_CODIGO_SUBSTITUI,
          OEM_FUN_CODIGO_ACUMULA,
          OEM_MOV_PARAMETRO,
          OEM_CAR_CODIGO,
          OEM_CAR_CODIGO_NIVEL,
          OEM_CAR_OCC_CODIGO,
          OEM_EMP_NSA_CODIGO_NIVEL,
          OEM_EMP_NSA_CODIGO_PADRAO,
          OEM_EMP_NSA_IN_NIVEL_ESCOL,
          OEM_TIPO_REMUNERACAO_FUNCAO,
          OEM_CCT_CODIGO,
          OEM_VALOR,
          OEM_ESC_CID_CODIGO,
          OEM_ESC_EID_CODIGO,
          OEM_TIPO_EXPEDIENTE,
          OEM_COD_HORARIO_EMPREGADO,
          OEM_TURNO_TRABALHO_EMPREGADO,
          OEM_DEP_CODIGO_ORIGEM,
          DTA_OPERACAO,
          TIP_OPERACAO,
          COD_USUARIO
         )
         VALUES
         (
          :OLD.OEM_EMP_NUMERO_MATRICULA,
          :OLD.OEM_OFU_CODIGO,
          :OLD.OEM_DATA_INICIO,
          :OLD.OEM_DATA_INCLUSAO,
          :OLD.OEM_COD_USUARIO,
          :OLD.OEM_DATA_TERMINO,
          :OLD.OEM_TEXTO,
          :OLD.OEM_DIPLOMA_LEGAL,
          :OLD.OEM_OEM_EMP_NUMERO_MATRICULA,
          :OLD.OEM_OEM_OFU_CODIGO,
          :OLD.OEM_OEM_DATA_INICIO,
          :OLD.OEM_EMP_NUMERO_MATRICULA_SUBST,
          :OLD.OEM_UOR_CODIGO,
          :OLD.OEM_OEX_CODIGO_CEDIDO,
          :OLD.OEM_OEX_CODIGO_REQUISITADO,
          :OLD.OEM_DATA_CANCEL_INTERRUPCAO,
          :OLD.OEM_MOTIVO_CANCEL_INTERRUPCAO,
          :OLD.OEM_INDICADOR_CANCELAMENTO,
          :OLD.OEM_DEP_CODIGO,
          :OLD.OEM_INDICADOR_ONUS,
          :OLD.OEM_DIPLOMA_LEGAL_TERMINO,
          :OLD.OEM_PFE_EMP_NUM_MATR_PROGRAM,
          :OLD.OEM_PFE_SEQUENCIAL_PROGRAM,
          :OLD.OEM_PFE_EMP_NUM_MATR_CONFIRM1,
          :OLD.OEM_PFE_SEQUENCIAL_CONFIRM1,
          :OLD.OEM_PFE_EMP_NUM_MATR_CONFIRM2,
          :OLD.OEM_PFE_SEQUENCIAL_CONFIRM2,
          :OLD.OEM_FUN_CODIGO,
          :OLD.OEM_FUN_CODIGO_SUBSTITUI,
          :OLD.OEM_FUN_CODIGO_ACUMULA,
          :OLD.OEM_MOV_PARAMETRO,
          :OLD.OEM_CAR_CODIGO,
          :OLD.OEM_CAR_CODIGO_NIVEL,
          :OLD.OEM_CAR_OCC_CODIGO,
          :OLD.OEM_EMP_NSA_CODIGO_NIVEL,
          :OLD.OEM_EMP_NSA_CODIGO_PADRAO,
          :OLD.OEM_EMP_NSA_IN_NIVEL_ESCOL,
          :OLD.OEM_TIPO_REMUNERACAO_FUNCAO,
          :OLD.OEM_CCT_CODIGO,
          :OLD.OEM_VALOR,
          :OLD.OEM_ESC_CID_CODIGO,
          :OLD.OEM_ESC_EID_CODIGO,
          :OLD.OEM_TIPO_EXPEDIENTE,
          :OLD.OEM_COD_HORARIO_EMPREGADO,
          :OLD.OEM_TURNO_TRABALHO_EMPREGADO,
          :OLD.OEM_DEP_CODIGO_ORIGEM,
          SYSDATE,--:OLD.DTA_OPERACAO,
          v_operacao,--:OLD.TIP_OPERACAO,
          USER--:OLD.COD_USUARIO
          );
--
END;
/

-- End of DDL Script for Trigger LOG_OCORRENCIAS_EMPREGADOS
