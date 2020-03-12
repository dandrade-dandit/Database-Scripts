--------------------------------------------
-- PROCEDURE TRUNCA AS TABELAS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_TRUNCA_TABELAS IS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.CADASTROS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.DEPENDENCIAS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.CRONOGRAMAS_PAGAMENTOS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.EVENTO_FOLHA';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.IMPOSTOS_RENDAS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.EMPREGADOS_FERIAS_13';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.FAIXAS_INSS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.SALARIO_FAMILIA';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.FORMULAS_RUBRICAS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.ADICIONAL_13_FERIAS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.MOVIMENTACAO';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.CONSTANTES_LEGAIS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.FAIXA_ARSAPREV';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.FUNCOES';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.EMPREGADOS_PAGAMENTOS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.PROGRAMACOES_FERIAS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.HISTORICO_NIVEIS_SALARIAIS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.OCORRENCIAS_EMPREGADOS';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE IFRSRH_FOLHA.PREVISAO_PAGAMENTO';
END;
/

show error

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE CADASTROS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_CADASTROS_FOLHA
IS
CURSOR C_ARQ IS
   SELECT   EMP_NUMERO_MATRICULA,
            EMP_SFU_CODIGO,   
            EMP_DATA_ADMISSAO,
            EMP_STATUS, 
            EMP_NSA_CODIGO_NIVEL,   
            EMP_NSA_CODIGO_PADRAO,
            EMP_NSA_IN_NIVEL_ESCOLARIDADE,
            EMP_QFU_FUN_CODIGO,  
            EMP_TIPO_REMUNERACAO_FUNCAO  
     FROM   IFRSRH.CADASTROS A
     WHERE  EMP_STATUS <> 2;
   
v_cont      number       := 0;
BEGIN
  
   FOR R_ARQ IN C_ARQ LOOP
           begin
             INSERT INTO IFRSRH_FOLHA.CADASTROS
                       (EMP_NUMERO_MATRICULA,
                        EMP_SFU_CODIGO,   
                        EMP_DATA_ADMISSAO,
                        EMP_STATUS, 
                        EMP_NSA_CODIGO_NIVEL,   
                        EMP_NSA_CODIGO_PADRAO,
                        EMP_NSA_IN_NIVEL_ESCOLARIDADE,
                        EMP_QFU_FUN_CODIGO,  
                        EMP_TIPO_REMUNERACAO_FUNCAO )
                      VALUES
                       (R_ARQ.EMP_NUMERO_MATRICULA,
                        R_ARQ.EMP_SFU_CODIGO,   
                        R_ARQ.EMP_DATA_ADMISSAO,
                        R_ARQ.EMP_STATUS, 
                        R_ARQ.EMP_NSA_CODIGO_NIVEL,   
                        R_ARQ.EMP_NSA_CODIGO_PADRAO,
                        R_ARQ.EMP_NSA_IN_NIVEL_ESCOLARIDADE,
                        R_ARQ.EMP_QFU_FUN_CODIGO,  
                        R_ARQ.EMP_TIPO_REMUNERACAO_FUNCAO );
           exception
              when OTHERS then
                 Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont := v_cont + 1;
           IF v_cont   = 100 THEN
              v_cont  := 0;
              commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE DEPENDENCIAS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_DEPENDENCIAS_FOLHA
IS
CURSOR C_ARQ IS
   SELECT  DEP_CODIGO, DEP_SIGLA
   FROM    IFRDBA2.DEPENDENCIAS A
   WHERE   DEP_DATA_EXTINCAO IS NULL
   AND     DEP_CODIGO < 900;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
             INSERT INTO IFRSRH_FOLHA.DEPENDENCIAS
                       (DEP_CODIGO
                       ,DEP_SIGLA
                      )
                      VALUES
                       (R_ARQ.DEP_CODIGO
                       ,R_ARQ.DEP_SIGLA
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/
--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE MOVIMENTACAO
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_MOVIMENTACAO_FOLHA (PMES NUMBER, PANO NUMBER, PVERSAO NUMBER, PMATRICULA NUMBER)
IS
CURSOR C_ARQ IS
   SELECT  A.* 
   FROM    IFRSRH.MOVIMENTACAO A
   WHERE   MOV_ANO_REFERENCIA = PANO
   AND     MOV_MES_REFERENCIA = PMES
   AND     MOV_VERSAO_PAGAMENTO = PVERSAO
   AND     MOV_EMP_NUMERO_MATRICULA = PMATRICULA;
   
v_cont      number       := 0;
BEGIN
   
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.MOVIMENTACAO
                       (COD_USUARIO
                       ,DTA_OPERACAO
                       ,MOV_ANO_REF_DIFERENCA
                       ,MOV_ANO_REFERENCIA
                       ,MOV_CTRL_TXT_FREQ
                       ,MOV_DATA_CALCULO
                       ,MOV_DIAS_PROPORCIONALIDADE
                       ,MOV_EMP_DEP_CODIGO_PAGTO
                       ,MOV_EMP_NUMERO_MATRICULA
                       ,MOV_FLG_FREQUENCIA
                       ,MOV_FOR_CODIGO
                       ,MOV_FUN_CODIGO
                       ,MOV_IND_ARSAPREV
                       ,MOV_IND_CALCULO
                       ,MOV_IND_EXCLUSIVO
                       ,MOV_IND_LANCAMENTO_LIQ_NEGAT
                       ,MOV_IND_13
                       ,MOV_MES_REF_DIFERENCA
                       ,MOV_MES_REFERENCIA
                       ,MOV_NSA_CODIGO_NIVEL
                       ,MOV_NSA_CODIGO_PADRAO
                       ,MOV_NSA_INDICADOR_NIVEL_ESCOLA
                       ,MOV_OEM_DATA_INICIO
                       ,MOV_OEM_EMP_NUMERO_MATRICULA
                       ,MOV_OEM_OFU_CODIGO
                       ,MOV_PARAMETRO
                       ,MOV_PARCELA
                       ,MOV_PARCELA_ATUAL
                       ,MOV_PEM_BEN_SIGLA
                       ,MOV_PEN_CODIGO
                       ,MOV_PKT_CODIGO_PEDIDO
                       ,MOV_RUB_CODIGO
                       ,MOV_RUB_SEQ_PAGAMENTO
                       ,MOV_SEQUENCIAL
                       ,MOV_TIPO_FUNCAO
                       ,MOV_TIPO_PARAMETRO
                       ,MOV_TIP_RUBRICA
                       ,MOV_VALOR
                       ,MOV_VALOR_INTEGRAL
                       ,MOV_VERSAO_PAGAMENTO
                       ,MOV_VERSAO_REF_DIFERENCA
                      )
                      VALUES
                       (R_ARQ.COD_USUARIO
                       ,R_ARQ.DTA_OPERACAO
                       ,R_ARQ.MOV_ANO_REF_DIFERENCA
                       ,R_ARQ.MOV_ANO_REFERENCIA
                       ,R_ARQ.MOV_CTRL_TXT_FREQ
                       ,R_ARQ.MOV_DATA_CALCULO
                       ,R_ARQ.MOV_DIAS_PROPORCIONALIDADE
                       ,R_ARQ.MOV_EMP_DEP_CODIGO_PAGTO
                       ,R_ARQ.MOV_EMP_NUMERO_MATRICULA
                       ,R_ARQ.MOV_FLG_FREQUENCIA
                       ,R_ARQ.MOV_FOR_CODIGO
                       ,R_ARQ.MOV_FUN_CODIGO
                       ,R_ARQ.MOV_IND_ARSAPREV
                       ,R_ARQ.MOV_IND_CALCULO
                       ,R_ARQ.MOV_IND_EXCLUSIVO
                       ,R_ARQ.MOV_IND_LANCAMENTO_LIQ_NEGAT
                       ,R_ARQ.MOV_IND_13
                       ,R_ARQ.MOV_MES_REF_DIFERENCA
                       ,R_ARQ.MOV_MES_REFERENCIA
                       ,R_ARQ.MOV_NSA_CODIGO_NIVEL
                       ,R_ARQ.MOV_NSA_CODIGO_PADRAO
                       ,R_ARQ.MOV_NSA_INDICADOR_NIVEL_ESCOLA
                       ,R_ARQ.MOV_OEM_DATA_INICIO
                       ,R_ARQ.MOV_OEM_EMP_NUMERO_MATRICULA
                       ,R_ARQ.MOV_OEM_OFU_CODIGO
                       ,R_ARQ.MOV_PARAMETRO
                       ,R_ARQ.MOV_PARCELA
                       ,R_ARQ.MOV_PARCELA_ATUAL
                       ,R_ARQ.MOV_PEM_BEN_SIGLA
                       ,R_ARQ.MOV_PEN_CODIGO
                       ,R_ARQ.MOV_PKT_CODIGO_PEDIDO
                       ,R_ARQ.MOV_RUB_CODIGO
                       ,R_ARQ.MOV_RUB_SEQ_PAGAMENTO
                       ,R_ARQ.MOV_SEQUENCIAL
                       ,R_ARQ.MOV_TIPO_FUNCAO
                       ,R_ARQ.MOV_TIPO_PARAMETRO
                       ,R_ARQ.MOV_TIP_RUBRICA
                       ,R_ARQ.MOV_VALOR
                       ,R_ARQ.MOV_VALOR_INTEGRAL
                       ,R_ARQ.MOV_VERSAO_PAGAMENTO
                       ,R_ARQ.MOV_VERSAO_REF_DIFERENCA
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/
--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE EMPREGADOS_PAGAMENTOS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_EMPREGADOS_PGTO_FOLHA (PMES NUMBER, PANO NUMBER, PVERSAO NUMBER, PMATRICULA NUMBER)
IS
CURSOR C_ARQ IS
   SELECT  A.* 
   FROM    IFRSRH.EMPREGADOS_PAGAMENTOS A
   WHERE   EGT_CRP_ANO_PAGAMENTO = PANO
   AND     EGT_CRP_MES_PAGAMENTO = PMES
   AND     EGT_CRP_SEQUENCIAL = PVERSAO
   AND     EGT_EMP_NUMERO_MATRICULA = PMATRICULA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.EMPREGADOS_PAGAMENTOS
                       (COD_USUARIO
                       ,DTA_OPERACAO
                       ,EGT_BASE_ARSAPREV
                       ,EGT_BASE_FGTS
                       ,EGT_BASE_FGTS_SEM_13
                       ,EGT_BASE_FGTS_13
                       ,EGT_BASE_INSS
                       ,EGT_BASE_IRRF
                       ,EGT_BASE_IRRF_FERIAS
                       ,EGT_BASE_IRRF_13
                       ,EGT_CARGA_HORARIA_MES
                       ,EGT_CRP_ANO_PAGAMENTO
                       ,EGT_CRP_MES_PAGAMENTO
                       ,EGT_CRP_SEQUENCIAL
                       ,EGT_DEP_CODIGO
                       ,EGT_DEP_CODIGO_FISICO
                       ,EGT_DEPENDENTES_IR
                       ,EGT_DEPENDENTES_SAL_FAM
                       ,EGT_EMP_NSA_CODIGO_NIVEL
                       ,EGT_EMP_NSA_CODIGO_PADRAO
                       ,EGT_EMP_NSA_IN_NIVEL_ESCOLARID
                       ,EGT_EMP_NUMERO_MATRICULA
                       ,EGT_EMP_QFU_FUN_CODIGO
                       ,EGT_EMP_QLP_CAR_CODIGO
                       ,EGT_EMP_QLP_CAR_CODIGO_NIVEL
                       ,EGT_EMP_QLP_CAR_OCC_CODIGO
                       ,EGT_FAIXA_INSS
                       ,EGT_HCC_CCT_CODIGO
                       ,EGT_NUMERO_ANUENIOS
                       ,EGT_NUMERO_MES_13
                       ,EGT_PERCENTUAL_ARSAPREV
                       ,EGT_PLANO_ARSAPREV
                       ,EGT_REMUNERACAO_LIQUIDO
                       ,EGT_UOR_CODIGO
                       ,EGT_VALOR_FG
                       ,EGT_VALOR_MARGEM_CONSIGNAVEL
                       ,EGT_VALOR_RG
                      )
                      VALUES
                       (R_ARQ.COD_USUARIO
                       ,R_ARQ.DTA_OPERACAO
                       ,R_ARQ.EGT_BASE_ARSAPREV
                       ,R_ARQ.EGT_BASE_FGTS
                       ,R_ARQ.EGT_BASE_FGTS_SEM_13
                       ,R_ARQ.EGT_BASE_FGTS_13
                       ,R_ARQ.EGT_BASE_INSS
                       ,R_ARQ.EGT_BASE_IRRF
                       ,R_ARQ.EGT_BASE_IRRF_FERIAS
                       ,R_ARQ.EGT_BASE_IRRF_13
                       ,R_ARQ.EGT_CARGA_HORARIA_MES
                       ,R_ARQ.EGT_CRP_ANO_PAGAMENTO
                       ,R_ARQ.EGT_CRP_MES_PAGAMENTO
                       ,R_ARQ.EGT_CRP_SEQUENCIAL
                       ,R_ARQ.EGT_DEP_CODIGO
                       ,R_ARQ.EGT_DEP_CODIGO_FISICO
                       ,R_ARQ.EGT_DEPENDENTES_IR
                       ,R_ARQ.EGT_DEPENDENTES_SAL_FAM
                       ,R_ARQ.EGT_EMP_NSA_CODIGO_NIVEL
                       ,R_ARQ.EGT_EMP_NSA_CODIGO_PADRAO
                       ,R_ARQ.EGT_EMP_NSA_IN_NIVEL_ESCOLARID
                       ,R_ARQ.EGT_EMP_NUMERO_MATRICULA
                       ,R_ARQ.EGT_EMP_QFU_FUN_CODIGO
                       ,R_ARQ.EGT_EMP_QLP_CAR_CODIGO
                       ,R_ARQ.EGT_EMP_QLP_CAR_CODIGO_NIVEL
                       ,R_ARQ.EGT_EMP_QLP_CAR_OCC_CODIGO
                       ,R_ARQ.EGT_FAIXA_INSS
                       ,R_ARQ.EGT_HCC_CCT_CODIGO
                       ,R_ARQ.EGT_NUMERO_ANUENIOS
                       ,R_ARQ.EGT_NUMERO_MES_13
                       ,R_ARQ.EGT_PERCENTUAL_ARSAPREV
                       ,R_ARQ.EGT_PLANO_ARSAPREV
                       ,R_ARQ.EGT_REMUNERACAO_LIQUIDO
                       ,R_ARQ.EGT_UOR_CODIGO
                       ,R_ARQ.EGT_VALOR_FG
                       ,R_ARQ.EGT_VALOR_MARGEM_CONSIGNAVEL
                       ,R_ARQ.EGT_VALOR_RG
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/
--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE FAIXAS_INSS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_FAIXAS_INSS_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
    SELECT A.*
    FROM   IFRSRH.FAIXAS_INSS A, (SELECT MAX(TO_DATE(TO_CHAR(FAI_MES_REFERENCIA)||'/'||
                                    TO_CHAR(FAI_ANO_REFERENCIA),'MM/YYYY')) DATA
                         FROM   IFRSRH.FAIXAS_INSS
                         WHERE  TO_NUMBER(TO_CHAR(FAI_ANO_REFERENCIA)||
                                     LPAD(TO_CHAR(FAI_MES_REFERENCIA),2,'0')) <=
                                TO_NUMBER(TO_CHAR(PANO)||
                                     LPAD(TO_CHAR(PMES),2,'0'))) TABLE_DATA
    WHERE  TO_DATE(TO_CHAR(FAI_MES_REFERENCIA)||'/'||
           TO_CHAR(FAI_ANO_REFERENCIA),'MM/YYYY') = TABLE_DATA.DATA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.FAIXAS_INSS
                       (FAI_ANO_REFERENCIA
                       ,FAI_FAIXA
                       ,FAI_LIM_SUPERIOR
                       ,FAI_MES_REFERENCIA
                       ,FAI_PER_DESC_EMPR
                      )
                      VALUES
                       (R_ARQ.FAI_ANO_REFERENCIA
                       ,R_ARQ.FAI_FAIXA
                       ,R_ARQ.FAI_LIM_SUPERIOR
                       ,R_ARQ.FAI_MES_REFERENCIA
                       ,R_ARQ.FAI_PER_DESC_EMPR
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE SALARIO_FAMILIA
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_SALARIO_FAMILIA_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
    SELECT A.*
    FROM   IFRSRH.SALARIO_FAMILIA A, (SELECT MAX(TO_DATE(TO_CHAR(SAF_MES_REFERENCIA)||'/'||
                                                TO_CHAR(SAF_ANO_REFERENCIA),'MM/YYYY')) DATA
                             FROM   IFRSRH.SALARIO_FAMILIA
                             WHERE  TO_NUMBER(TO_CHAR(SAF_ANO_REFERENCIA)||
                                         LPAD(TO_CHAR(SAF_MES_REFERENCIA),2,'0')) <=
                                    TO_NUMBER(TO_CHAR(PANO)||
                                         LPAD(TO_CHAR(PMES),2,'0'))) TABLE_DATA
    WHERE  TO_DATE(TO_CHAR(SAF_MES_REFERENCIA)||'/'||
                   TO_CHAR(SAF_ANO_REFERENCIA),'MM/YYYY') = TABLE_DATA.DATA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.SALARIO_FAMILIA
                       (SAF_ANO_REFERENCIA
                       ,SAF_FAIXA
                       ,SAF_MES_REFERENCIA
                       ,SAF_RENDA_MAXIMA
                       ,SAF_VALOR
                      )
                      VALUES
                       (R_ARQ.SAF_ANO_REFERENCIA
                       ,R_ARQ.SAF_FAIXA
                       ,R_ARQ.SAF_MES_REFERENCIA
                       ,R_ARQ.SAF_RENDA_MAXIMA
                       ,R_ARQ.SAF_VALOR
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE FAIXA_ARSAPREV
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_FAIXA_ARSAPREV_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
    SELECT A.*
    FROM   IFRSRH.FAIXA_ARSAPREV A, (SELECT MAX(TO_DATE(TO_CHAR(ARS_MES)||'/'||
                                               TO_CHAR(ARS_ANO),'MM/YYYY')) DATA
                            FROM   IFRSRH.FAIXA_ARSAPREV
                            WHERE  TO_NUMBER(TO_CHAR(ARS_ANO)||
                                        LPAD(TO_CHAR(ARS_MES),2,'0')) <=
                                   TO_NUMBER(TO_CHAR(PANO)||
                                        LPAD(TO_CHAR(PMES),2,'0'))) TABLE_DATA
    WHERE  TO_DATE(TO_CHAR(ARS_MES)||'/'||TO_CHAR(ARS_ANO),'MM/YYYY') = TABLE_DATA.DATA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.FAIXA_ARSAPREV
                       (ARS_ANO
                       ,ARS_FAIXA
                       ,ARS_MES
                       ,ARS_PERCENTUAL
                       ,ARS_PLANO
                       ,ARS_VALOR
                      )
                      VALUES
                       (R_ARQ.ARS_ANO
                       ,R_ARQ.ARS_FAIXA
                       ,R_ARQ.ARS_MES
                       ,R_ARQ.ARS_PERCENTUAL
                       ,R_ARQ.ARS_PLANO
                       ,R_ARQ.ARS_VALOR
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE IMPOSTOS_RENDAS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_IMP_RENDAS_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
    SELECT A.*
    FROM   IFRSRH.IMPOSTOS_RENDAS A, (SELECT MAX(TO_DATE(TO_CHAR(IMR_MES_REFERENCIA)||'/'||
                                                TO_CHAR(IMR_ANO_REFERENCIA),'MM/YYYY')) DATA
                             FROM   IFRSRH.IMPOSTOS_RENDAS
                             WHERE  TO_NUMBER(TO_CHAR(IMR_ANO_REFERENCIA)||
                                         LPAD(TO_CHAR(IMR_MES_REFERENCIA),2,'0')) <=
                                    TO_NUMBER(TO_CHAR(PANO)||
                                         LPAD(TO_CHAR(PMES),2,'0'))) TABLE_DATA
    WHERE  TO_DATE(TO_CHAR(IMR_MES_REFERENCIA)||'/'||
                   TO_CHAR(IMR_ANO_REFERENCIA),'MM/YYYY') = TABLE_DATA.DATA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.IMPOSTOS_RENDAS
                       (IMR_ALIQUOTA
                       ,IMR_ANO_REFERENCIA
                       ,IMR_FAIXA
                       ,IMR_MES_REFERENCIA
                       ,IMR_RENDA_MAXIMA
                       ,IMR_VALOR_A_DEDUZIR
                       ,IMR_VLR_DEDUCAO_DEP
                      )
                      VALUES
                       (R_ARQ.IMR_ALIQUOTA
                       ,R_ARQ.IMR_ANO_REFERENCIA
                       ,R_ARQ.IMR_FAIXA
                       ,R_ARQ.IMR_MES_REFERENCIA
                       ,R_ARQ.IMR_RENDA_MAXIMA
                       ,R_ARQ.IMR_VALOR_A_DEDUZIR
                       ,R_ARQ.IMR_VLR_DEDUCAO_DEP
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE CONSTANTES_LEGAIS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_CONST_LEGAIS_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
     SELECT A.*
     FROM   IFRSRH.CONSTANTES_LEGAIS A,
           (SELECT MAX(TO_DATE(TO_CHAR(COL_MES_REFERENCIA)||'/'||
                               TO_CHAR(COL_ANO_REFERENCIA),'MM/YYYY')) DATA
            FROM   IFRSRH.CONSTANTES_LEGAIS
            WHERE  TO_NUMBER(LPAD(TO_CHAR(COL_ANO_REFERENCIA),4,'0')||
                             LPAD(TO_CHAR(COL_MES_REFERENCIA),2,'0')) <=
                   TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||
                             LPAD(TO_CHAR(PMES),2,'0'))) TABLE_DATA
     WHERE  TO_DATE(TO_CHAR(COL_MES_REFERENCIA)||'/'||
            TO_CHAR(COL_ANO_REFERENCIA),'MM/YYYY') = TABLE_DATA.DATA;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
     begin
       INSERT INTO IFRSRH_FOLHA.CONSTANTES_LEGAIS
                       (COD_USUARIO
                       ,COL_ANO_REFERENCIA
                       ,COL_CODIGO
                       ,COL_DENOMINACAO
                       ,COL_MES_REFERENCIA
                       ,COL_TIPO
                       ,COL_VALOR
                       ,DTA_OPERACAO
                      )
                      VALUES
                       (R_ARQ.COD_USUARIO
                       ,R_ARQ.COL_ANO_REFERENCIA
                       ,R_ARQ.COL_CODIGO
                       ,R_ARQ.COL_DENOMINACAO
                       ,R_ARQ.COL_MES_REFERENCIA
                       ,R_ARQ.COL_TIPO
                       ,R_ARQ.COL_VALOR
                       ,R_ARQ.DTA_OPERACAO
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE CONSTANTES_LEGAIS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_PREV_PAGTO_FOLHA (PMES NUMBER, PANO NUMBER)
IS

CURSOR C_ARQ IS
   SELECT  A.* 
   FROM    IFRSRH.PREVISAO_PAGAMENTO A
   WHERE   PPA_ANO_PAGAMENTO IN ( PANO, (DECODE(PMES,1,PANO-1,PANO)))
   AND     PPA_MES_PAGAMENTO IN ( PMES, (DECODE(PMES,1,12,PMES-1)));
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.PREVISAO_PAGAMENTO
                       (PPA_ANO_PAGAMENTO
                       ,PPA_DATA_PAGAMENTO
                       ,PPA_DATA_PREVISTA
                       ,PPA_DIAS_UTEIS
                       ,PPA_MES_PAGAMENTO
                      )
                      VALUES
                       (R_ARQ.PPA_ANO_PAGAMENTO
                       ,R_ARQ.PPA_DATA_PAGAMENTO
                       ,R_ARQ.PPA_DATA_PREVISTA
                       ,R_ARQ.PPA_DIAS_UTEIS
                       ,R_ARQ.PPA_MES_PAGAMENTO
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE HISTORICO_NIVEIS_SALARIAIS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_HIST_NIV_SAL_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
       SELECT HNS.HNS_DATA_VIGENCIA,HNS.HNS_NSA_CODIGO_NIVEL,HNS.HNS_NSA_CODIGO_PADRAO,
              HNS.HNS_NSA_INDICADOR_NIVEL_ESCOLA, HNS.HNS_VALOR_REMUNERACAO 
       FROM   IFRSRH.HISTORICO_NIVEIS_SALARIAIS HNS
       WHERE  HNS.HNS_DATA_VIGENCIA =
   	         (SELECT MAX(HNS.HNS_DATA_VIGENCIA)
              FROM   HISTORICO_NIVEIS_SALARIAIS HNS
              WHERE  TO_NUMBER(TO_CHAR(HNS.HNS_DATA_VIGENCIA,'YYYYMM')) <=
                     TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||
                               LPAD(TO_CHAR(PMES),2,'0')));   
  
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.HISTORICO_NIVEIS_SALARIAIS
                       (HNS_DATA_VIGENCIA
                       ,HNS_NSA_CODIGO_NIVEL
                       ,HNS_NSA_CODIGO_PADRAO
                       ,HNS_NSA_INDICADOR_NIVEL_ESCOLA
                       ,HNS_VALOR_REMUNERACAO
                      )
                      VALUES
                       (R_ARQ.HNS_DATA_VIGENCIA
                       ,R_ARQ.HNS_NSA_CODIGO_NIVEL
                       ,R_ARQ.HNS_NSA_CODIGO_PADRAO
                       ,R_ARQ.HNS_NSA_INDICADOR_NIVEL_ESCOLA
                       ,R_ARQ.HNS_VALOR_REMUNERACAO
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE CRONOGRAMAS_PAGAMENTOS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_CRON_PAGTO_FOLHA (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
   SELECT  A.* 
   FROM    IFRSRH.CRONOGRAMAS_PAGAMENTOS A
   WHERE   CRP_ANO_PAGAMENTO = PANO
   AND     CRP_MES_PAGAMENTO = PMES;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.CRONOGRAMAS_PAGAMENTOS
                       (CRP_ANO_PAGAMENTO
                       ,CRP_DATA_PREVISTA
                       ,CRP_DATA_REALIZACAO
                       ,CRP_DEP_CODIGO
                       ,CRP_EPG_CODIGO
                       ,CRP_IND_13
                       ,CRP_MES_PAGAMENTO
                       ,CRP_PERCENTUAL_FOLHA
                       ,CRP_SEQUENCIAL
                      )
                      VALUES
                       (R_ARQ.CRP_ANO_PAGAMENTO
                       ,R_ARQ.CRP_DATA_PREVISTA
                       ,R_ARQ.CRP_DATA_REALIZACAO
                       ,R_ARQ.CRP_DEP_CODIGO
                       ,R_ARQ.CRP_EPG_CODIGO
                       ,R_ARQ.CRP_IND_13
                       ,R_ARQ.CRP_MES_PAGAMENTO
                       ,R_ARQ.CRP_PERCENTUAL_FOLHA
                       ,R_ARQ.CRP_SEQUENCIAL
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE EMPREGADOS_FERIAS_13
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_EMP_FERIAS_13_FOLHA (PMES NUMBER, PANO NUMBER, PMATRICULA NUMBER)
IS
CURSOR C_ARQ IS
   SELECT  EFE_EMP_NUMERO_MATRICULA,EFE_ANO_REFERENCIA,EFE_MES_REFERENCIA, 
           EFE_VERSAO,EFE_RG,EFE_FG,EFE_PERICULOSIDADE,EFE_INSALUBRIDADE, 
           EFE_TOTAL_FERIAS,EFE_TOTAL_13 
   FROM    IFRSRH.EMPREGADOS_FERIAS_13 A
   WHERE   EFE_ANO_REFERENCIA = PANO
   AND     EFE_EMP_NUMERO_MATRICULA = PMATRICULA;

   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.EMPREGADOS_FERIAS_13
                       (EFE_ANO_REFERENCIA
                       ,EFE_EMP_NUMERO_MATRICULA
                       ,EFE_FG
                       ,EFE_INSALUBRIDADE
                       ,EFE_MES_REFERENCIA
                       ,EFE_PERICULOSIDADE
                       ,EFE_RG
                       ,EFE_TOTAL_FERIAS
                       ,EFE_TOTAL_13
                       ,EFE_VERSAO
                      )
                      VALUES
                       (R_ARQ.EFE_ANO_REFERENCIA
                       ,R_ARQ.EFE_EMP_NUMERO_MATRICULA
                       ,R_ARQ.EFE_FG
                       ,R_ARQ.EFE_INSALUBRIDADE
                       ,R_ARQ.EFE_MES_REFERENCIA
                       ,R_ARQ.EFE_PERICULOSIDADE
                       ,R_ARQ.EFE_RG
                       ,R_ARQ.EFE_TOTAL_FERIAS
                       ,R_ARQ.EFE_TOTAL_13
                       ,R_ARQ.EFE_VERSAO
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/


--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE OCORRENCIAS_EMPREGADOS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_OCO_EMP_FOLHA (PMES NUMBER, PANO NUMBER, PVERSAO NUMBER, PMATRICULA NUMBER)
IS

CURSOR C_ARQ IS
   SELECT  OEM_EMP_NUMERO_MATRICULA,OEM_OFU_CODIGO,
           OEM_DATA_INICIO, OEM_DATA_TERMINO
   FROM    IFRSRH.OCORRENCIAS_EMPREGADOS A
   WHERE   OEM_OFU_CODIGO IN (74,270)
   AND     OEM_EMP_NUMERO_MATRICULA = PMATRICULA
   AND   ((OEM_DATA_INICIO = (SELECT MAX(OEM_DATA_INICIO)
                                FROM IFRSRH.OCORRENCIAS_EMPREGADOS T2
                               WHERE T2.OEM_EMP_NUMERO_MATRICULA = A.OEM_EMP_NUMERO_MATRICULA
                                 AND T2.OEM_OFU_CODIGO = A.OEM_OFU_CODIGO
                                 AND T2.OEM_DATA_INICIO < LAST_DAY(TO_DATE('01' || '/' || TO_CHAR(PMES)|| '/' || TO_CHAR(PANO),'DD/MM/YYYY'))))
 		   OR (OEM_MOV_PARAMETRO = TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||LPAD(TO_CHAR(PMES),2,'0'))));

CURSOR C_PFE (PMATRICULA NUMBER, PDATAINICIO DATE, PDATATERMINO DATE) IS
   SELECT PFE_DATA_INICIO_1,
          PFE_DATA_INICIO_2,
          PFE_DATA_TERMINO_1,
          PFE_DATA_TERMINO_2,
          PFE_SEQUENCIAL,
          PFE_DT_INICIO_PERIODO_AQUIS,
          PFE_DT_TERMINO_PERIODO_AQUIS,
          PFE_DATA_INI_ABONO_PECUNIARIO,
          PFE_DATA_FIM_ABONO_PECUNIARIO
     FROM IFRSRH.PROGRAMACOES_FERIAS
    WHERE PFE_EMP_NUMERO_MATRICULA = PMATRICULA
      AND ((PDATAINICIO  = PFE_DATA_INICIO_1  AND PDATATERMINO = PFE_DATA_TERMINO_1)
       OR  (PDATAINICIO  = PFE_DATA_INICIO_2  AND PDATATERMINO = PFE_DATA_TERMINO_2)
       OR  (PDATAINICIO  = PFE_DATA_INICIO_1  AND PDATATERMINO = PFE_DATA_INI_ABONO_PECUNIARIO-1)
       OR  (PDATAINICIO  = PFE_DATA_INICIO_2  AND PDATATERMINO = PFE_DATA_INI_ABONO_PECUNIARIO-1)
       OR  (PDATATERMINO = PFE_DATA_TERMINO_1 AND PDATAINICIO  = PFE_DATA_FIM_ABONO_PECUNIARIO+1)
       OR  (PDATATERMINO = PFE_DATA_TERMINO_2 AND PDATAINICIO  = PFE_DATA_FIM_ABONO_PECUNIARIO+1));

CURSOR C_EXISTE_1350 (PANO NUMBER, PMES NUMBER, PVERSAO NUMBER, PMATRICULA NUMBER) IS
   SELECT 'X'
   FROM   IFRSRH.MOVIMENTACAO
   WHERE  MOV_ANO_REFERENCIA       = PANO
   AND    MOV_MES_REFERENCIA       = PMES
   AND    MOV_VERSAO_PAGAMENTO     = PVERSAO
   AND    MOV_EMP_NUMERO_MATRICULA = PMATRICULA
   AND    MOV_RUB_CODIGO           = 1350
   AND    MOV_TIP_RUBRICA          = 'N';
   
R_EXISTE_1350 C_EXISTE_1350%ROWTYPE;

CURSOR C_VALADICFER (P_MATRICULA   IN NUMBER,
                     P_DATA_INICIO IN DATE) IS
    SELECT (PFE.PFE_DATA_TERMINO_1 - PFE.PFE_DATA_INICIO_1) + 1 DIAS_DIREITO,
           PFE.PFE_DT_INICIO_PERIODO_AQUIS INICIO_PA,
           PFE.PFE_DT_TERMINO_PERIODO_AQUIS TERMINO_PA
    FROM   IFRSRH.PROGRAMACOES_FERIAS PFE,
           IFRSRH.OCORRENCIAS_EMPREGADOS OEM
    WHERE  PFE.PFE_EMP_NUMERO_MATRICULA = P_MATRICULA
    AND    PFE.PFE_EMP_NUMERO_MATRICULA = OEM.OEM_EMP_NUMERO_MATRICULA
    AND    OEM.OEM_DATA_INICIO          = P_DATA_INICIO
    AND    OEM.OEM_DATA_INICIO          = PFE.PFE_DATA_INICIO_1
    AND    OEM.OEM_OFU_CODIGO           = 270
    UNION
    SELECT (PFE.PFE_DATA_TERMINO_2 - PFE.PFE_DATA_INICIO_2) + 1 DIAS_DIREITO,
           PFE.PFE_DT_INICIO_PERIODO_AQUIS INICIO_PA,
           PFE.PFE_DT_TERMINO_PERIODO_AQUIS TERMINO_PA
    FROM   IFRSRH.PROGRAMACOES_FERIAS PFE,
           IFRSRH.OCORRENCIAS_EMPREGADOS OEM
    WHERE  PFE.PFE_EMP_NUMERO_MATRICULA = P_MATRICULA
    AND    PFE.PFE_EMP_NUMERO_MATRICULA = OEM.OEM_EMP_NUMERO_MATRICULA
    AND    OEM.OEM_DATA_INICIO          = P_DATA_INICIO
    AND    OEM.OEM_DATA_INICIO          = PFE.PFE_DATA_INICIO_2
    AND    OEM.OEM_OFU_CODIGO           = 270;
      
CURSOR C_MOV (PMATRICULA NUMBER, PMESINICIO NUMBER, PANOINICIO NUMBER, PMESFIM NUMBER, PANOFIM NUMBER) IS
    SELECT MOV.*
      FROM IFRSRH.MOVIMENTACAO MOV, IFRSRH.RUBRICAS
     WHERE TO_NUMBER(LPAD(TO_CHAR(MOV_ANO_REFERENCIA), 4, '0') || LPAD(TO_CHAR(MOV_MES_REFERENCIA), 2, '0')) >=
           TO_NUMBER(LPAD(TO_CHAR(PANOINICIO), 4, '0') || LPAD(TO_CHAR(PMESINICIO), 2, '0'))
       AND TO_NUMBER(LPAD(TO_CHAR(MOV_ANO_REFERENCIA), 4, '0') || LPAD(TO_CHAR(MOV_MES_REFERENCIA), 2, '0')) <
           TO_NUMBER(LPAD(TO_CHAR(PANOFIM), 4, '0') || LPAD(TO_CHAR(PMESFIM), 2, '0'))
       AND MOV.MOV_VERSAO_PAGAMENTO      = 1
       AND MOV.MOV_EMP_NUMERO_MATRICULA = PMATRICULA
       AND (MOV.MOV_IND_LANCAMENTO_LIQ_NEGAT = 'N' OR MOV.MOV_IND_LANCAMENTO_LIQ_NEGAT IS NULL)
       AND  MOV.MOV_RUB_CODIGO           = RUB_CODIGO
       AND  LTRIM(RTRIM(NVL(MOV.COD_USUARIO, 'A'))) <> 'REAJUSTE'
       AND  MOV.MOV_RUB_CODIGO IN (SELECT IRU_RUB_CODIGO_INCIDE
                                   FROM   IFRSRH.INCIDENCIAS_RUBRICAS
                                   WHERE  IRU_RUB_CODIGO IN (SELECT IRU_RUB_CODIGO_INCIDE
                                                             FROM   IFRSRH.INCIDENCIAS_RUBRICAS
                                                             WHERE  IRU_RUB_CODIGO IN (1350))
                                   AND  ((MOV.MOV_TIP_RUBRICA = 'N' AND IRU_TIP_NORMAL      = 'S') OR
                                         (MOV.MOV_TIP_RUBRICA = 'D' AND IRU_TIP_DIFERENCA   = 'S') OR
                                         (MOV.MOV_TIP_RUBRICA = 'E' AND IRU_TIP_ESTORNO_DEV = 'S'))
                                   AND   (DATA_TERMINO IS NULL OR
                                          DATA_TERMINO >= TO_DATE('01'||'/'||TO_CHAR(PMESINICIO)||'/'||TO_CHAR(PANOINICIO),'DD/MM/YYYY')));
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
     begin
       INSERT INTO IFRSRH_FOLHA.OCORRENCIAS_EMPREGADOS
                  (OEM_EMP_NUMERO_MATRICULA
                  ,OEM_OFU_CODIGO
                  ,OEM_DATA_INICIO
                  ,OEM_DATA_TERMINO
                   )
       VALUES
                  (R_ARQ.OEM_EMP_NUMERO_MATRICULA
                  ,R_ARQ.OEM_OFU_CODIGO
                  ,R_ARQ.OEM_DATA_INICIO
                  ,R_ARQ.OEM_DATA_TERMINO
                   );
     exception
       when OTHERS then
         Raise_Application_Error(-20000,'Erro ao inserir registro',true);
     end;
     v_cont      := v_cont + 1;
     IF v_cont   = 100 THEN
        v_cont  := 0;
        commit;
     END IF;
     --
     -- CARGA DE PROGRAMAÇÃO DE FÉRIAS
     --
     FOR R_PFE IN C_PFE (R_ARQ.OEM_EMP_NUMERO_MATRICULA, R_ARQ.OEM_DATA_INICIO, R_ARQ.OEM_DATA_TERMINO) LOOP
	   begin
	     INSERT INTO IFRSRH_FOLHA.PROGRAMACOES_FERIAS
	               (PFE_EMP_NUMERO_MATRICULA
					,PFE_SEQUENCIAL
					,PFE_DT_INICIO_PERIODO_AQUIS
					,PFE_DT_TERMINO_PERIODO_AQUIS
					,PFE_DATA_INICIO_1
					,PFE_DATA_TERMINO_1
					,PFE_DATA_INICIO_2
					,PFE_DATA_TERMINO_2
					,PFE_DATA_INI_ABONO_PECUNIARIO
					,PFE_DATA_FIM_ABONO_PECUNIARIO
	              )
	              VALUES
	               (R_ARQ.OEM_EMP_NUMERO_MATRICULA
	               ,R_PFE.PFE_SEQUENCIAL
	               ,R_PFE.PFE_DT_INICIO_PERIODO_AQUIS
	               ,R_PFE.PFE_DT_TERMINO_PERIODO_AQUIS
	               ,R_PFE.PFE_DATA_INICIO_1
	               ,R_PFE.PFE_DATA_TERMINO_1
	               ,R_PFE.PFE_DATA_INICIO_2
	               ,R_PFE.PFE_DATA_TERMINO_2
	               ,R_PFE.PFE_DATA_INI_ABONO_PECUNIARIO
	               ,R_PFE.PFE_DATA_FIM_ABONO_PECUNIARIO
	           );
	   exception
	     when OTHERS then
	       Raise_Application_Error(-20000,'Erro ao inserir registro',true);
	   end;
	   commit;
	   --
	   -- CARGA DE ADICIONAL_13_FERIAS
	   --
	   OPEN C_EXISTE_1350(PANO, PMES, PVERSAO, R_ARQ.OEM_EMP_NUMERO_MATRICULA);
	   FETCH C_EXISTE_1350 INTO R_EXISTE_1350;
	   IF C_EXISTE_1350%FOUND THEN
		   FOR R_VALADICFER IN C_VALADICFER (R_ARQ.OEM_EMP_NUMERO_MATRICULA, R_ARQ.OEM_DATA_INICIO) LOOP    
	         IF R_VALADICFER.TERMINO_PA = LAST_DAY(R_VALADICFER.TERMINO_PA) 
			    AND MONTHS_BETWEEN(R_VALADICFER.TERMINO_PA + 1, R_VALADICFER.INICIO_PA) >= 12 THEN
	              R_VALADICFER.TERMINO_PA := ADD_MONTHS(R_VALADICFER.TERMINO_PA, 1);
	         END IF;
		     FOR R_MOV IN C_MOV (R_ARQ.OEM_EMP_NUMERO_MATRICULA,
			                     TO_NUMBER(TO_CHAR(R_VALADICFER.INICIO_PA,'MM')),
								 TO_NUMBER(TO_CHAR(R_VALADICFER.INICIO_PA,'YYYY')),
	                             TO_NUMBER(TO_CHAR(R_VALADICFER.TERMINO_PA,'MM')),
	                             TO_NUMBER(TO_CHAR(R_VALADICFER.TERMINO_PA,'YYYY'))) LOOP
	           begin
	             INSERT INTO IFRSRH_FOLHA.MOVIMENTACAO
	                       (COD_USUARIO
	                       ,DTA_OPERACAO
	                       ,MOV_ANO_REF_DIFERENCA
	                       ,MOV_ANO_REFERENCIA
	                       ,MOV_CTRL_TXT_FREQ
	                       ,MOV_DATA_CALCULO
	                       ,MOV_DIAS_PROPORCIONALIDADE
	                       ,MOV_EMP_DEP_CODIGO_PAGTO
	                       ,MOV_EMP_NUMERO_MATRICULA
	                       ,MOV_FLG_FREQUENCIA
	                       ,MOV_FOR_CODIGO
	                       ,MOV_FUN_CODIGO
	                       ,MOV_IND_ARSAPREV
	                       ,MOV_IND_CALCULO
	                       ,MOV_IND_EXCLUSIVO
	                       ,MOV_IND_LANCAMENTO_LIQ_NEGAT
	                       ,MOV_IND_13
	                       ,MOV_MES_REF_DIFERENCA
	                       ,MOV_MES_REFERENCIA
	                       ,MOV_NSA_CODIGO_NIVEL
	                       ,MOV_NSA_CODIGO_PADRAO
	                       ,MOV_NSA_INDICADOR_NIVEL_ESCOLA
	                       ,MOV_OEM_DATA_INICIO
	                       ,MOV_OEM_EMP_NUMERO_MATRICULA
	                       ,MOV_OEM_OFU_CODIGO
	                       ,MOV_PARAMETRO
	                       ,MOV_PARCELA
	                       ,MOV_PARCELA_ATUAL
	                       ,MOV_PEM_BEN_SIGLA
	                       ,MOV_PEN_CODIGO
	                       ,MOV_PKT_CODIGO_PEDIDO
	                       ,MOV_RUB_CODIGO
	                       ,MOV_RUB_SEQ_PAGAMENTO
	                       ,MOV_SEQUENCIAL
	                       ,MOV_TIPO_FUNCAO
	                       ,MOV_TIPO_PARAMETRO
	                       ,MOV_TIP_RUBRICA
	                       ,MOV_VALOR
	                       ,MOV_VALOR_INTEGRAL
	                       ,MOV_VERSAO_PAGAMENTO
	                       ,MOV_VERSAO_REF_DIFERENCA
	                      )
	                      VALUES
	                       (R_MOV.COD_USUARIO
	                       ,R_MOV.DTA_OPERACAO
	                       ,R_MOV.MOV_ANO_REF_DIFERENCA
	                       ,R_MOV.MOV_ANO_REFERENCIA
	                       ,R_MOV.MOV_CTRL_TXT_FREQ
	                       ,R_MOV.MOV_DATA_CALCULO
	                       ,R_MOV.MOV_DIAS_PROPORCIONALIDADE
	                       ,R_MOV.MOV_EMP_DEP_CODIGO_PAGTO
	                       ,R_MOV.MOV_EMP_NUMERO_MATRICULA
	                       ,R_MOV.MOV_FLG_FREQUENCIA
	                       ,R_MOV.MOV_FOR_CODIGO
	                       ,R_MOV.MOV_FUN_CODIGO
	                       ,R_MOV.MOV_IND_ARSAPREV
	                       ,R_MOV.MOV_IND_CALCULO
	                       ,R_MOV.MOV_IND_EXCLUSIVO
	                       ,R_MOV.MOV_IND_LANCAMENTO_LIQ_NEGAT
	                       ,R_MOV.MOV_IND_13
	                       ,R_MOV.MOV_MES_REF_DIFERENCA
	                       ,R_MOV.MOV_MES_REFERENCIA
	                       ,R_MOV.MOV_NSA_CODIGO_NIVEL
	                       ,R_MOV.MOV_NSA_CODIGO_PADRAO
	                       ,R_MOV.MOV_NSA_INDICADOR_NIVEL_ESCOLA
	                       ,R_MOV.MOV_OEM_DATA_INICIO
	                       ,R_MOV.MOV_OEM_EMP_NUMERO_MATRICULA
	                       ,R_MOV.MOV_OEM_OFU_CODIGO
	                       ,R_MOV.MOV_PARAMETRO
	                       ,R_MOV.MOV_PARCELA
	                       ,R_MOV.MOV_PARCELA_ATUAL
	                       ,R_MOV.MOV_PEM_BEN_SIGLA
	                       ,R_MOV.MOV_PEN_CODIGO
	                       ,R_MOV.MOV_PKT_CODIGO_PEDIDO
	                       ,R_MOV.MOV_RUB_CODIGO
	                       ,R_MOV.MOV_RUB_SEQ_PAGAMENTO
	                       ,R_MOV.MOV_SEQUENCIAL
	                       ,R_MOV.MOV_TIPO_FUNCAO
	                       ,R_MOV.MOV_TIPO_PARAMETRO
	                       ,R_MOV.MOV_TIP_RUBRICA
	                       ,R_MOV.MOV_VALOR
	                       ,R_MOV.MOV_VALOR_INTEGRAL
	                       ,R_MOV.MOV_VERSAO_PAGAMENTO
	                       ,R_MOV.MOV_VERSAO_REF_DIFERENCA
	                   );
	           exception
	             when OTHERS then
	               Raise_Application_Error(-20000,'Erro ao inserir registro',true);
	           end;
	           commit;
	           
		       END LOOP;
	        --
	        -- FIM DA CARGA ADICIONAL_13_FERIAS
	        --
          END LOOP;
          --
	      -- FIM DA CARGA DE PROGRAMAÇÃO DE FÉRIAS
	      --
	 END IF; -- FIM DA CONDIÇÃO SE EXISTE A 1350
   END LOOP;
   commit;
   --
   -- FIM DA CARGA DE PROGRAMAÇÃO DE FÉRIAS
   --

   END LOOP;
   commit;
   
END;
/

show error

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE FORMULAS_RUBRICAS
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_FORM_RUB_FOLHA (PANO NUMBER, PMES NUMBER)
IS
CURSOR C_ARQ IS
   SELECT  A.FRU_RUB_CODIGO, A.FRU_FOR_CODIGO, B.FOR_FORMULA 
     FROM  IFRSRH.FORMULAS_RUBRICAS A, IFRSRH.FORMULAS B
    WHERE  A.FRU_FOR_CODIGO = B.FOR_CODIGO
      AND  TO_DATE(TO_CHAR(A.FRU_MES_INICIO)||'/'||
           TO_CHAR(A.FRU_ANO_INICIO),'MM/YYYY') IN
         (SELECT MAX(TO_DATE(TO_CHAR(FRU1.FRU_MES_INICIO)||'/'||
                             TO_CHAR(FRU1.FRU_ANO_INICIO),'MM/YYYY'))
          FROM   IFRSRH.FORMULAS_RUBRICAS FRU1
          WHERE  FRU1.FRU_RUB_CODIGO = A.FRU_RUB_CODIGO
          AND    TO_NUMBER(LPAD(TO_CHAR(FRU1.FRU_ANO_INICIO),4,'0')||
                           LPAD(TO_CHAR(FRU1.FRU_MES_INICIO),2,'0')) <=
                 TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||
                           LPAD(TO_CHAR(PMES),2,'0')))
      AND  A.FRU_MES_TERMINO IS NULL
      AND  A.FRU_ANO_TERMINO IS NULL;
   
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.FORMULAS_RUBRICAS
                       (FRU_RUB_CODIGO
                       ,FRU_FOR_CODIGO
                       ,FOR_FORMULA
                      )
                      VALUES
                       (R_ARQ.FRU_RUB_CODIGO
                       ,R_ARQ.FRU_FOR_CODIGO
                       ,R_ARQ.FOR_FORMULA
                   );
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/

--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE FUNCOES
--------------------------------------------
CREATE OR REPLACE PROCEDURE IFRSRH_FOLHA.PRC_FUNCOES_FOLHA (PANO NUMBER, PMES NUMBER)
IS
CURSOR C_ARQ IS
       SELECT FUN.FUN_CODIGO, CFV.CFV_VALOR_RG, CFV.CFV_VALOR_FG, CFV.CFV_VALOR_DI
       FROM   IFRSRH.CARGOS_CONFIANCA FUN, IFRSRH.CATEGORIAS_FUNCOES_VALOR CFV
       WHERE  FUN.FUN_CFU_CODIGO = CFV.CFV_CFU_CODIGO
       AND    CFV.CFV_DATA_VIGENCIA IN
             (SELECT MAX(CFV1.CFV_DATA_VIGENCIA)
              FROM   IFRSRH.CATEGORIAS_FUNCOES_VALOR CFV1
              WHERE  CFV1.CFV_CFU_CODIGO = CFV.CFV_CFU_CODIGO
              AND    TO_NUMBER(TO_CHAR(CFV1.CFV_DATA_VIGENCIA,'YYYYMM')) <=
                     TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||
                               LPAD(TO_CHAR(PMES),2,'0')));
                               
v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.FUNCOES
                       (FUN_CODIGO
                        ,CFV_VALOR_RG 
                        ,CFV_VALOR_FG                
                        ,CFV_VALOR_DI )
                      VALUES
                        (R_ARQ.FUN_CODIGO
                        ,R_ARQ.CFV_VALOR_RG 
                        ,R_ARQ.CFV_VALOR_FG                
                        ,R_ARQ.CFV_VALOR_DI);
           exception
                   when OTHERS then
                           Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
/
--------------------------------------------
-- PROCEDURE QUE POPULA A TABELA DE ADICIONAL_13_FERIAS
--------------------------------------------


--------------------------------------------
-- PRIVILÉGIOS PARA EXECUTAR AS PROCEDURES
--------------------------------------------     
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_CADASTROS_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_DEPENDENCIAS_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_MOVIMENTACAO_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_EMPREGADOS_PGTO_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_FAIXAS_INSS_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_SALARIO_FAMILIA_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_FAIXA_ARSAPREV_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_IMP_RENDAS_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_CONST_LEGAIS_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_PREV_PAGTO_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_HIST_NIV_SAL_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_CRON_PAGTO_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_EMP_FERIAS_13_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_OCO_EMP_FOLHA TO CNBR, I9980851;
GRANT EXECUTE ON IFRSRH_FOLHA.PRC_FUNCOES_FOLHA TO CNBR, I9980851;
                               
