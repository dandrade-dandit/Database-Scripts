-- Start of DDL Script for Table IFRSRH.A_PROCEDIMENTOS_ODONTOLOGICOS
-- Generated 9-mar-2004 18:34:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE a_procedimentos_odontologicos
    (pod_ato_numero                 NUMBER(14) NOT NULL,
    pod_abo_codigo                 NUMBER(4) NOT NULL,
    pod_qtd_dentes                 NUMBER(2),
    pod_cancelado                  VARCHAR2(1) NOT NULL,
    pod_total_real                 NUMBER(12,2),
    pod_perito                     VARCHAR2(1),
    pod_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.A_PROCEDIMENTOS_ODONTOLOGICOS

-- Start of DDL Script for Table IFRSRH.ABATIMENTO_AVERBACAO
-- Generated 9-mar-2004 18:34:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE abatimento_averbacao
    (abt_codigo                     NUMBER(2) NOT NULL,
    abt_avb_codigo                 NUMBER(2) NOT NULL,
    abt_avb_emp_numero_matricula   NUMBER(7) NOT NULL,
    abt_data_inicio                DATE NOT NULL,
    abt_data_termino               DATE NOT NULL,
    abt_inc_promocao               VARCHAR2(1) NOT NULL,
    abt_inc_tempo_servico          VARCHAR2(1) NOT NULL,
    abt_inc_aposentadoria          VARCHAR2(1) NOT NULL,
    abt_documento                  VARCHAR2(15) NOT NULL,
    abt_texto                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ABATIMENTO_AVERBACAO

ALTER TABLE abatimento_averbacao
ADD CONSTRAINT abt_inc_aposentadoria_ck CHECK ( ABT_INC_APOSENTADORIA in ('S', 'N')                                              )
/
ALTER TABLE abatimento_averbacao
ADD CONSTRAINT abt_inc_promocao_ck CHECK ( ABT_INC_PROMOCAO in ('S', 'N')                                                   )
/
ALTER TABLE abatimento_averbacao
ADD CONSTRAINT abt_inc_tempo_servico_ck CHECK ( ABT_INC_TEMPO_SERVICO in ('S', 'N')                                              )
/
ALTER TABLE abatimento_averbacao
ADD CONSTRAINT abt_pk PRIMARY KEY (abt_codigo, abt_avb_codigo, 
  abt_avb_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for ABATIMENTO_AVERBACAO

CREATE TRIGGER tgr_abatimento_averbacao_01
AFTER INSERT  OR UPDATE  OR  DELETE 
ON abatimento_averbacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_dat_operacao                 DATE;
  v_tip_operacao                 VARCHAR2(1);
  v_cod_usuario                  VARCHAR2(30);
  v_abt_codigo                   NUMBER(2);
  v_abt_avb_codigo               NUMBER(2);
  v_abt_avb_emp_numero_matricula NUMBER(7);
  v_abt_data_inicio              DATE;
  v_abt_data_termino             DATE;
  v_abt_inc_promocao             VARCHAR2(1);
  v_abt_inc_tempo_servico        VARCHAR2(1);
  v_abt_inc_aposentadoria        VARCHAR2(1);
  v_abt_documento                VARCHAR2(15);
  v_abt_texto                    VARCHAR2(50);
BEGIN
  -- Carrego as variaveis que são independentes da operação
  v_dat_operacao := sysdate;
  v_cod_usuario  := user;
  -- Carrego as variaveis de acordo com a operação
  IF INSERTING THEN
    v_tip_operacao                  := 'I';
    v_abt_codigo                    := :NEW.abt_codigo;
    v_abt_avb_codigo                := :NEW.abt_avb_codigo;
    v_abt_avb_emp_numero_matricula  := :NEW.abt_avb_emp_numero_matricula;
    v_abt_data_inicio               := :NEW.abt_data_inicio;
    v_abt_data_termino              := :NEW.abt_data_termino;
    v_abt_inc_promocao              := :NEW.abt_inc_promocao;
    v_abt_inc_tempo_servico         := :NEW.abt_inc_tempo_servico;
    v_abt_inc_aposentadoria         := :NEW.abt_inc_aposentadoria;
    v_abt_documento                 := :NEW.abt_documento;
    v_abt_texto                     := :NEW.abt_texto;
  ELSIF UPDATING THEN
    v_tip_operacao                := 'U';
    v_abt_codigo                    := :OLD.abt_codigo;
    v_abt_avb_codigo                := :OLD.abt_avb_codigo;
    v_abt_avb_emp_numero_matricula  := :OLD.abt_avb_emp_numero_matricula;
    v_abt_data_inicio               := :OLD.abt_data_inicio;
    v_abt_data_termino              := :OLD.abt_data_termino;
    v_abt_inc_promocao              := :OLD.abt_inc_promocao;
    v_abt_inc_tempo_servico         := :OLD.abt_inc_tempo_servico;
    v_abt_inc_aposentadoria         := :OLD.abt_inc_aposentadoria;
    v_abt_documento                 := :OLD.abt_documento;
    v_abt_texto                     := :OLD.abt_texto;
  ELSIF DELETING THEN
    v_tip_operacao                := 'D';
    v_abt_codigo                    := :OLD.abt_codigo;
    v_abt_avb_codigo                := :OLD.abt_avb_codigo;
    v_abt_avb_emp_numero_matricula  := :OLD.abt_avb_emp_numero_matricula;
    v_abt_data_inicio               := :OLD.abt_data_inicio;
    v_abt_data_termino              := :OLD.abt_data_termino;
    v_abt_inc_promocao              := :OLD.abt_inc_promocao;
    v_abt_inc_tempo_servico         := :OLD.abt_inc_tempo_servico;
    v_abt_inc_aposentadoria         := :OLD.abt_inc_aposentadoria;
    v_abt_documento                 := :OLD.abt_documento;
    v_abt_texto                     := :OLD.abt_texto;
  END IF;
  -- Faço o Insert na tabela de LOG
  INSERT INTO LOG_ABATIMENTO_AVERBACAO
               (
                dat_operacao,
                tip_operacao,
                cod_usuario,
                abt_codigo,
                abt_avb_codigo,
                abt_avb_emp_numero_matricula,
                abt_data_inicio,
                abt_data_termino,
                abt_inc_promocao,
                abt_inc_tempo_servico,
                abt_inc_aposentadoria,
                abt_documento,
                abt_texto
               )
         VALUES
               (
                v_dat_operacao,
                v_tip_operacao,
                v_cod_usuario,
                v_abt_codigo,
                v_abt_avb_codigo,
                v_abt_avb_emp_numero_matricula,
                v_abt_data_inicio,
                v_abt_data_termino,
                v_abt_inc_promocao,
                v_abt_inc_tempo_servico,
                v_abt_inc_aposentadoria,
                v_abt_documento,
                v_abt_texto
               );
END;
/

-- End of DDL Script for Table IFRSRH.ABATIMENTO_AVERBACAO

-- Start of DDL Script for Table IFRSRH.ABO
-- Generated 9-mar-2004 18:34:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE abo
    (abo_codigo                     NUMBER(4) NOT NULL,
    abo_descricao                  VARCHAR2(250) NOT NULL,
    abo_coeficiente                NUMBER(12,2) NOT NULL,
    abo_esp_numero                 NUMBER(7) NOT NULL,
    esp_tipo                       NUMBER(1) NOT NULL,
    abo_pericia                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ABO

ALTER TABLE abo
ADD CONSTRAINT abo_pk PRIMARY KEY (abo_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ABO

-- Start of DDL Script for Table IFRSRH.ABO_LOCAL
-- Generated 9-mar-2004 18:34:53 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE abo_local
    (abl_codigo                     NUMBER(4) NOT NULL,
    abl_descricao                  VARCHAR2(2000) NOT NULL,
    abl_coeficiente                NUMBER(12,2) NOT NULL,
    abl_dep_codigo                 NUMBER(4),
    abl_cre_sequencial             NUMBER(5) NOT NULL,
    abl_pericia                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ABO_LOCAL

ALTER TABLE abo_local
ADD CONSTRAINT abo_local_pk PRIMARY KEY (abl_codigo, abl_cre_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ABO_LOCAL

-- Start of DDL Script for Table IFRSRH.ADICIONAL_13_FERIAS
-- Generated 9-mar-2004 18:35:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE adicional_13_ferias
    (a13f_ano                       NUMBER(4) NOT NULL,
    a13f_mes                       NUMBER(2) NOT NULL,
    a13f_cod_rubrica               NUMBER(4) NOT NULL,
    a13f_emp_numero_matricula      NUMBER(7) NOT NULL,
    a13f_perc_correcao_13          NUMBER(5,2) NOT NULL,
    a13f_perc_correcao_ferias      NUMBER(5,2) NOT NULL,
    a13f_qtd_horas                 NUMBER(18,3),
    a13f_valor                     NUMBER(11,2),
    cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_inclusao                   DATE NOT NULL,
    a13f_indica_incidencia         NUMBER(4),
    a13f_sequencial                NUMBER(2) DEFAULT 1
  NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ADICIONAL_13_FERIAS

ALTER TABLE adicional_13_ferias
ADD CONSTRAINT a13f_pk PRIMARY KEY (a13f_ano, a13f_mes, a13f_cod_rubrica, 
  a13f_emp_numero_matricula, a13f_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ADICIONAL_13_FERIAS

COMMENT ON COLUMN adicional_13_ferias.a13f_ano IS 'Ano de referência do lançamento para 13º'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_cod_rubrica IS 'Código da rubrica incidente para 13º'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_emp_numero_matricula IS 'Matrícula do empregado'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_indica_incidencia IS 'Identifica a qual incidência pertence a rubrica'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_mes IS 'Mês de referência do lançamento para 13º'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_perc_correcao_13 IS 'Percentual de correção para adicional de 13'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_perc_correcao_ferias IS 'Percentual de correção para adicional de férias'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_qtd_horas IS 'Quantidade de horas de rubricas de Freqüência'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_sequencial IS 'Número seqüencial do pagamento do 13º salário'
/
COMMENT ON COLUMN adicional_13_ferias.a13f_valor IS 'Valor da rubrica incidente ao 13º'
/
COMMENT ON COLUMN adicional_13_ferias.cod_usuario IS 'Código do usuário que efetuou a inclusão do lançamento'
/
COMMENT ON COLUMN adicional_13_ferias.dta_inclusao IS 'Data de inclusão do lançamento'
/

-- End of DDL Script for Table IFRSRH.ADICIONAL_13_FERIAS

-- Start of DDL Script for Table IFRSRH.AFASTAMENTOS
-- Generated 9-mar-2004 18:35:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE afastamentos
    (afa_codigo                     NUMBER(2) NOT NULL,
    afa_quantidade_minima_faltas   NUMBER(2),
    afa_quantidade_maxima_faltas   NUMBER(2),
    afa_quantidade_dias_ferias     NUMBER(2),
    afa_quantidade_abonos          NUMBER(2),
    afa_art130clt                  VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AFASTAMENTOS

ALTER TABLE afastamentos
ADD CONSTRAINT afa_pk PRIMARY KEY (afa_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AFASTAMENTOS

-- Start of DDL Script for Table IFRSRH.AGENDAS_MEDICAS
-- Generated 9-mar-2004 18:35:19 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE agendas_medicas
    (agm_cde_cre_sequencial         NUMBER(5) NOT NULL,
    agm_cde_esp_tipo               NUMBER(1) NOT NULL,
    agm_cde_esp_numero             NUMBER(7) NOT NULL,
    agm_sequencial                 NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AGENDAS_MEDICAS

ALTER TABLE agendas_medicas
ADD CONSTRAINT agm_pk PRIMARY KEY (agm_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AGENDAS_MEDICAS

-- Start of DDL Script for Table IFRSRH.AGENTES_NOCIVOS
-- Generated 9-mar-2004 18:35:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE agentes_nocivos
    (agn_codigo                     NUMBER(2) NOT NULL,
    agn_descricao                  VARCHAR2(200) NOT NULL,
    agn_tipo                       NUMBER(1) NOT NULL,
    agn_percentual_sat_inss        NUMBER(3,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AGENTES_NOCIVOS

ALTER TABLE agentes_nocivos
ADD CONSTRAINT agn_ck_1 CHECK ( AGN_TIPO IN (1,2)                                                                )
/
ALTER TABLE agentes_nocivos
ADD CONSTRAINT agn_pk PRIMARY KEY (agn_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AGENTES_NOCIVOS

-- Start of DDL Script for Table IFRSRH.AMB
-- Generated 9-mar-2004 18:35:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE amb
    (amb_codigo                     NUMBER(7) NOT NULL,
    amb_dv                         NUMBER(1) NOT NULL,
    amb_descricao                  VARCHAR2(400) NOT NULL,
    amb_coeficiente                NUMBER(8),
    amb_porte_anestesico           NUMBER(3),
    amb_auxiliar                   NUMBER(4),
    amb_filme                      NUMBER(5,4),
    amb_porte                      NUMBER(3),
    amb_esp_tipo                   NUMBER(1) NOT NULL,
    amb_esp_numero                 NUMBER(7) NOT NULL,
    amb_observacao                 VARCHAR2(2000),
    amb_qtd                        NUMBER(3),
    amb_sexo                       VARCHAR2(1),
    amb_participacao               NUMBER(5,2),
    amb_ind_pericia                VARCHAR2(1) NOT NULL,
    amb_qtd_periodo                NUMBER(2),
    amb_ind_inss                   VARCHAR2(1),
    amb_carga_lpm                  VARCHAR2(1),
    amb_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AMB

ALTER TABLE amb
ADD CONSTRAINT amb_cargalpm_ck CHECK ( AMB_CARGA_LPM IN ( 'S' , 'N' ))
/
ALTER TABLE amb
ADD CONSTRAINT amb_ind_pericia_ck CHECK ( AMB_IND_PERICIA IN ( 'S' , 'N' ) )
/
ALTER TABLE amb
ADD CONSTRAINT amb_pk PRIMARY KEY (amb_codigo, amb_dv)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE amb
ADD CONSTRAINT amb_status_internacao_ck CHECK (AMB_STATUS_INTERNACAO IN ('S','N'))
/

-- Comments for AMB

COMMENT ON COLUMN amb.amb_ind_pericia IS 'Indicador de perícia médica (S/N). ''S'' indica que o serviço médico deve ser feito com perícia de médicos cadastrados pela INFRAERO.'
/
COMMENT ON COLUMN amb.amb_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.AMB

-- Start of DDL Script for Table IFRSRH.AMB_LOCAL
-- Generated 9-mar-2004 18:35:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE amb_local
    (aml_codigo                     NUMBER(7) NOT NULL,
    aml_dv                         NUMBER(1) NOT NULL,
    aml_descricao                  VARCHAR2(250) NOT NULL,
    aml_coeficiente                NUMBER(8),
    aml_porte_anestesico           NUMBER(3),
    aml_auxiliar                   NUMBER(2),
    aml_filme                      NUMBER(5,4),
    aml_cre_sequencial             NUMBER(5) NOT NULL,
    aml_qtd                        NUMBER(3),
    aml_sexo                       VARCHAR2(1),
    aml_participacao               NUMBER(5,2),
    aml_ind_pericia                VARCHAR2(1) NOT NULL,
    aml_qtd_periodo                NUMBER(2),
    aml_ind_inss                   VARCHAR2(1),
    aml_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AMB_LOCAL

ALTER TABLE amb_local
ADD CONSTRAINT amb_local_pk PRIMARY KEY (aml_codigo, aml_cre_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE amb_local
ADD CONSTRAINT aml_ind_pericia_ck CHECK ( AML_IND_PERICIA IN ( 'S' , 'N' ) )
/
ALTER TABLE amb_local
ADD CONSTRAINT aml_status_internacao_ck CHECK (AML_STATUS_INTERNACAO IN ('S','N'))
/

-- Comments for AMB_LOCAL

COMMENT ON COLUMN amb_local.aml_ind_pericia IS 'Indicador de perícia médica (S/N). ''S'' indica que o serviço médico deve ser feito com perícia de médicos cadastrados pela INFRAERO.'
/
COMMENT ON COLUMN amb_local.aml_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.AMB_LOCAL

-- Start of DDL Script for Table IFRSRH.ANS
-- Generated 9-mar-2004 18:35:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ans
    (ans_dt_gera_arq                DATE NOT NULL,
    ans_cod_arq                    NUMBER(7) NOT NULL,
    ans_operacao                   NUMBER(1) NOT NULL,
    ans_beneficiario               VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ANS

ALTER TABLE ans
ADD CONSTRAINT ans_pk PRIMARY KEY (ans_dt_gera_arq, ans_cod_arq, ans_operacao, 
  ans_beneficiario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ANS

COMMENT ON COLUMN ans.ans_beneficiario IS 'Codigo do beneficiario'
/
COMMENT ON COLUMN ans.ans_cod_arq IS 'Codigo do arquivo'
/
COMMENT ON COLUMN ans.ans_dt_gera_arq IS 'Data geracao do arquivo'
/
COMMENT ON COLUMN ans.ans_operacao IS 'Operacao efetuada'
/

-- End of DDL Script for Table IFRSRH.ANS

-- Start of DDL Script for Table IFRSRH.ANUENIOS
-- Generated 9-mar-2004 18:35:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE anuenios
    (anu_quantidade_ano             NUMBER(2) NOT NULL,
    anu_percentual_1               NUMBER(4,2) NOT NULL,
    anu_percentual_2               NUMBER(4,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ANUENIOS

ALTER TABLE anuenios
ADD CONSTRAINT anu_pk PRIMARY KEY (anu_quantidade_ano)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ANUENIOS

COMMENT ON COLUMN anuenios.anu_percentual_1 IS 'Percentual de anuenios a que o empregado faz juz.'
/
COMMENT ON COLUMN anuenios.anu_percentual_2 IS 'Percentual de anuenios a que o empregado faz juz.'
/
COMMENT ON COLUMN anuenios.anu_quantidade_ano IS 'Quantidade de anuenios.'
/

-- End of DDL Script for Table IFRSRH.ANUENIOS

-- Start of DDL Script for Table IFRSRH.APROFOP
-- Generated 9-mar-2004 18:36:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE aprofop
    (ano_referencia                 NUMBER(4) NOT NULL,
    mes_referencia                 NUMBER(2) NOT NULL,
    seq_referencia                 NUMBER(2) NOT NULL,
    dep_lotacao                    NUMBER(4) NOT NULL,
    centro_custo                   NUMBER(10) NOT NULL,
    deb_cred                       CHAR(1) NOT NULL,
    conta                          VARCHAR2(20) NOT NULL,
    empregado                      NUMBER(7) NOT NULL,
    valor                          NUMBER(16,7) NOT NULL,
    usuario                        VARCHAR2(10) NOT NULL,
    dta_inicio                     DATE,
    dta_termino                    DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for APROFOP

ALTER TABLE aprofop
ADD CONSTRAINT aprofop_pk PRIMARY KEY (ano_referencia, mes_referencia, 
  seq_referencia, dep_lotacao, centro_custo, deb_cred, conta, empregado, valor)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for APROFOP

COMMENT ON COLUMN aprofop.ano_referencia IS 'Ano referencia da folha'
/
COMMENT ON COLUMN aprofop.centro_custo IS 'Centro de Custo'
/
COMMENT ON COLUMN aprofop.conta IS 'Conta Contabil'
/
COMMENT ON COLUMN aprofop.deb_cred IS 'Indicador de debito ou credito'
/
COMMENT ON COLUMN aprofop.dep_lotacao IS 'Dependencia de lotacao'
/
COMMENT ON COLUMN aprofop.dta_inicio IS 'Data e hora inicio da geracao'
/
COMMENT ON COLUMN aprofop.dta_termino IS 'Data e hora termino da geracao'
/
COMMENT ON COLUMN aprofop.empregado IS 'Matricula do empregado'
/
COMMENT ON COLUMN aprofop.mes_referencia IS 'Mes referencia da folha'
/
COMMENT ON COLUMN aprofop.seq_referencia IS 'Sequencial da folha'
/
COMMENT ON COLUMN aprofop.usuario IS 'Usuario que disparou a geracao'
/
COMMENT ON COLUMN aprofop.valor IS 'Valor'
/

-- End of DDL Script for Table IFRSRH.APROFOP

-- Start of DDL Script for Table IFRSRH.APROFOPENC
-- Generated 9-mar-2004 18:36:13 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE aprofopenc
    (ano_referencia                 NUMBER(4) NOT NULL,
    mes_referencia                 NUMBER(2) NOT NULL,
    seq_referencia                 NUMBER(2) NOT NULL,
    dependencia                    NUMBER(4) NOT NULL,
    conta_contabil                 VARCHAR2(20) NOT NULL,
    centro_custo                   NUMBER(10) NOT NULL,
    empregado                      NUMBER(7) NOT NULL,
    usuario                        VARCHAR2(10) NOT NULL,
    dta_inicio                     DATE,
    dta_termino                    DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for APROFOPENC

ALTER TABLE aprofopenc
ADD CONSTRAINT aprofopenc_pk PRIMARY KEY (ano_referencia, mes_referencia, 
  seq_referencia, dependencia, conta_contabil, centro_custo, empregado)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for APROFOPENC

COMMENT ON COLUMN aprofopenc.ano_referencia IS 'Ano referencia da folha'
/
COMMENT ON COLUMN aprofopenc.centro_custo IS 'CENTRO  de CUSTO'
/
COMMENT ON COLUMN aprofopenc.conta_contabil IS 'Conta Contabil'
/
COMMENT ON COLUMN aprofopenc.dependencia IS 'Dependencia de lotacao'
/
COMMENT ON COLUMN aprofopenc.dta_inicio IS 'Data e hora inicio da geracao'
/
COMMENT ON COLUMN aprofopenc.dta_termino IS 'Data e hora termino da geracao'
/
COMMENT ON COLUMN aprofopenc.empregado IS 'Matricula do empregado'
/
COMMENT ON COLUMN aprofopenc.mes_referencia IS 'mes  referencia da folha'
/
COMMENT ON COLUMN aprofopenc.seq_referencia IS 'Sequencial da folha'
/
COMMENT ON COLUMN aprofopenc.usuario IS 'Usuario que disparou a geracao'
/

-- End of DDL Script for Table IFRSRH.APROFOPENC

-- Start of DDL Script for Table IFRSRH.APROVADOR_VIAGEM
-- Generated 9-mar-2004 18:36:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE aprovador_viagem
    (avi_uor_codigo                 NUMBER(9) NOT NULL,
    avi_data_inicio                DATE NOT NULL,
    avi_emp_numero_matricula       NUMBER(7) NOT NULL,
    avi_data_termino               DATE,
    avi_data_inclusao              DATE,
    avi_documento_legal            VARCHAR2(100),
    avi_observacao                 VARCHAR2(200),
    avi_data_confirmacao           DATE,
    avi_uor_codigo_resp            NUMBER(9) NOT NULL,
    avi_emp_numero_matricula_resp  NUMBER(7) NOT NULL,
    avi_documento_termino          VARCHAR2(100),
    avi_principal                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for APROVADOR_VIAGEM

ALTER TABLE aprovador_viagem
ADD CONSTRAINT apv_pk PRIMARY KEY (avi_uor_codigo, avi_data_inicio, 
  avi_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.APROVADOR_VIAGEM

-- Start of DDL Script for Table IFRSRH.APROVADOR_VIAGEM_EMPREGADO
-- Generated 9-mar-2004 18:36:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE aprovador_viagem_empregado
    (ave_emp_numero_matricula       NUMBER(7) NOT NULL,
    ave_emp_nro_matricula_viajante NUMBER(7) NOT NULL,
    ave_data_inicio                DATE NOT NULL,
    ave_uor_codigo                 NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for APROVADOR_VIAGEM_EMPREGADO

ALTER TABLE aprovador_viagem_empregado
ADD CONSTRAINT aprovador_viagem_empregado_pk PRIMARY KEY (
  ave_emp_numero_matricula, ave_emp_nro_matricula_viajante, ave_data_inicio, 
  ave_uor_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for APROVADOR_VIAGEM_EMPREGADO

COMMENT ON COLUMN aprovador_viagem_empregado.ave_data_inicio IS 'Data Inicio Delegação'
/
COMMENT ON COLUMN aprovador_viagem_empregado.ave_emp_nro_matricula_viajante IS 'Matricula Empregado Viajante'
/
COMMENT ON COLUMN aprovador_viagem_empregado.ave_emp_numero_matricula IS 'Matricula Aprovador Viagem'
/
COMMENT ON COLUMN aprovador_viagem_empregado.ave_uor_codigo IS 'Código Unidade Organizacional do Empregado Viajante'
/

-- End of DDL Script for Table IFRSRH.APROVADOR_VIAGEM_EMPREGADO

-- Start of DDL Script for Table IFRSRH.APROVADOR_VIAGEM_TIPO
-- Generated 9-mar-2004 18:36:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE aprovador_viagem_tipo
    (avi_uor_codigo                 NUMBER(9) NOT NULL,
    avi_data_inicio                DATE NOT NULL,
    avi_ofu_codigo                 NUMBER(4) NOT NULL,
    avi_emp_numero_matricula       NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for APROVADOR_VIAGEM_TIPO

ALTER TABLE aprovador_viagem_tipo
ADD CONSTRAINT apvt_pk PRIMARY KEY (avi_uor_codigo, avi_data_inicio, 
  avi_ofu_codigo, avi_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.APROVADOR_VIAGEM_TIPO

-- Start of DDL Script for Table IFRSRH.AREAS_ATUACAO_CARGO
-- Generated 9-mar-2004 18:36:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE areas_atuacao_cargo
    (aac_atu_codigo                 NUMBER(3) NOT NULL,
    aac_car_codigo                 NUMBER(3) NOT NULL,
    aac_car_codigo_nivel           NUMBER(1) NOT NULL,
    aac_car_occ_codigo             NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AREAS_ATUACAO_CARGO

ALTER TABLE areas_atuacao_cargo
ADD CONSTRAINT aac_pk PRIMARY KEY (aac_atu_codigo, aac_car_codigo, 
  aac_car_codigo_nivel, aac_car_occ_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AREAS_ATUACAO_CARGO

-- Start of DDL Script for Table IFRSRH.AREAS_ATUACAO_UNID_ORGANIZ
-- Generated 9-mar-2004 18:36:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE areas_atuacao_unid_organiz
    (auo_atu_codigo                 NUMBER(3) NOT NULL,
    auo_uor_codigo                 NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AREAS_ATUACAO_UNID_ORGANIZ

ALTER TABLE areas_atuacao_unid_organiz
ADD CONSTRAINT auo_pk PRIMARY KEY (auo_atu_codigo, auo_uor_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AREAS_ATUACAO_UNID_ORGANIZ

-- Start of DDL Script for Table IFRSRH.AREAS_DE_ATUACAO
-- Generated 9-mar-2004 18:36:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE areas_de_atuacao
    (atu_codigo                     NUMBER(3) NOT NULL,
    atu_descricao                  VARCHAR2(50) NOT NULL,
    atu_tipo_atuacao               NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AREAS_DE_ATUACAO

ALTER TABLE areas_de_atuacao
ADD CONSTRAINT atu_ck_1 CHECK ( ATU_TIPO_ATUACAO IN (1,2)                                                        )
/
ALTER TABLE areas_de_atuacao
ADD CONSTRAINT atu_pk PRIMARY KEY (atu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE areas_de_atuacao
ADD CONSTRAINT atu_uk UNIQUE (atu_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AREAS_DE_ATUACAO

-- Start of DDL Script for Table IFRSRH.ARQUIVO_CREDITO_BANCARIO
-- Generated 9-mar-2004 18:37:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE arquivo_credito_bancario
    (acb_egt_crp_ano_pagamento      NUMBER(4) NOT NULL,
    acb_egt_crp_mes_pagamento      NUMBER(2) NOT NULL,
    acb_egt_crp_sequencial         NUMBER(2) NOT NULL,
    acb_sequencial                 NUMBER(2) NOT NULL,
    acb_emp_numero_matricula       NUMBER(7) NOT NULL,
    acb_aba_ban_codigo             NUMBER(3),
    acb_remuneracao_liquido        NUMBER(14,2),
    acb_aba_codigo                 VARCHAR2(7),
    acb_emp_conta_corrente         VARCHAR2(14),
    acb_emp_tipo_conta             VARCHAR2(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ARQUIVO_CREDITO_BANCARIO

ALTER TABLE arquivo_credito_bancario
ADD CONSTRAINT acb_pk PRIMARY KEY (acb_egt_crp_ano_pagamento, 
  acb_egt_crp_mes_pagamento, acb_egt_crp_sequencial, acb_sequencial, 
  acb_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ARQUIVO_CREDITO_BANCARIO

-- Start of DDL Script for Table IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS
-- Generated 9-mar-2004 18:37:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE arquivo_credito_bancario_pens
    (egt_crp_ano_pagamento          NUMBER(4) NOT NULL,
    egt_crp_mes_pagamento          NUMBER(2) NOT NULL,
    egt_crp_sequencial             NUMBER(2) NOT NULL,
    acp_sequencial                 NUMBER(2) NOT NULL,
    acp_pen_emp_numero_matricula   NUMBER(7) NOT NULL,
    acp_pen_codigo                 NUMBER(2) NOT NULL,
    dep_codigo                     NUMBER(4),
    aba_ban_codigo                 NUMBER(3),
    aba_codigo                     VARCHAR2(7),
    emp_conta_corrente             VARCHAR2(14),
    remuneracao_liquido            NUMBER(14,2),
    tipo_credito                   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ARQUIVO_CREDITO_BANCARIO_PENS

ALTER TABLE arquivo_credito_bancario_pens
ADD CONSTRAINT acp_ck_1 CHECK ( TIPO_CREDITO IN ('N','C') )
/
ALTER TABLE arquivo_credito_bancario_pens
ADD CONSTRAINT acp_pk PRIMARY KEY (egt_crp_ano_pagamento, egt_crp_mes_pagamento, 
  egt_crp_sequencial, acp_sequencial, acp_pen_emp_numero_matricula, 
  acp_pen_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ARQUIVO_CREDITO_BANCARIO_PENS

-- Start of DDL Script for Table IFRSRH.ASSINFRA_DEPENDENCIA
-- Generated 9-mar-2004 18:37:26 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE assinfra_dependencia
    (ade_cas_cnpj                   NUMBER(14) NOT NULL,
    ade_dep_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ASSINFRA_DEPENDENCIA

ALTER TABLE assinfra_dependencia
ADD CONSTRAINT ade_pk PRIMARY KEY (ade_cas_cnpj, ade_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ASSINFRA_DEPENDENCIA

-- Start of DDL Script for Table IFRSRH.ASSINFRA_MOVIMENTACAO
-- Generated 9-mar-2004 18:37:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE assinfra_movimentacao
    (amo_ade_cas_cnpj               NUMBER(14) NOT NULL,
    amo_ade_dep_codigo             NUMBER(4) NOT NULL,
    amo_versao                     NUMBER(2) NOT NULL,
    amo_mes_referencia             NUMBER(2) NOT NULL,
    amo_ano_referencia             NUMBER(4) NOT NULL,
    amo_valor                      NUMBER(11,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ASSINFRA_MOVIMENTACAO

ALTER TABLE assinfra_movimentacao
ADD CONSTRAINT amo_pk PRIMARY KEY (amo_mes_referencia, amo_ano_referencia, 
  amo_versao, amo_ade_cas_cnpj, amo_ade_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ASSINFRA_MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.ATIVIDADES
-- Generated 9-mar-2004 18:37:43 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE atividades
    (ati_codigo                     NUMBER(4) NOT NULL,
    ati_tipo_pccs                  VARCHAR2(1) NOT NULL,
    ati_descricao_sumaria          VARCHAR2(1500),
    ati_ct_custos_codigo           NUMBER(5),
    ati_ind_descricao_sumaria      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ATIVIDADES

ALTER TABLE atividades
ADD CONSTRAINT ati_pk PRIMARY KEY (ati_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ATIVIDADES

COMMENT ON COLUMN atividades.ati_ind_descricao_sumaria IS 'FLAG QUE IDENTIFICA A DESCRIÇÃO SUMÁRIA DA ATIVIDADE'
/

-- End of DDL Script for Table IFRSRH.ATIVIDADES

-- Start of DDL Script for Table IFRSRH.ATIVIDADES_CARGOS
-- Generated 9-mar-2004 18:37:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE atividades_cargos
    (aca_car_codigo                 NUMBER(3) NOT NULL,
    aca_car_codigo_nivel           NUMBER(1) NOT NULL,
    aca_car_occ_codigo             NUMBER(3) NOT NULL,
    aca_ati_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ATIVIDADES_CARGOS

ALTER TABLE atividades_cargos
ADD CONSTRAINT aca_pk PRIMARY KEY (aca_car_codigo, aca_car_codigo_nivel, 
  aca_car_occ_codigo, aca_ati_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for ATIVIDADES_CARGOS

CREATE TRIGGER log_atividades_cargos
AFTER INSERT  OR UPDATE OF 
  aca_ati_codigo,
  aca_car_codigo,
  aca_car_codigo_nivel,
  aca_car_occ_codigo
 OR  DELETE 
ON atividades_cargos
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF INSERTING THEN
     INSERT INTO LOG_ATIVIDADES_CARGOS (
                aca_car_codigo_nivel,
                aca_car_occ_codigo,
                aca_car_codigo,
                aca_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:new.aca_car_codigo_nivel,
                 :new.aca_car_occ_codigo,
                 :new.aca_car_codigo,
                 :new.aca_ati_codigo,
                  sysdate,
                  'I',
                  user
                );
  END IF;
  IF DELETING THEN
     INSERT INTO LOG_ATIVIDADES_CARGOS (
                aca_car_codigo_nivel,
                aca_car_occ_codigo,
                aca_car_codigo,
                aca_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:old.aca_car_codigo_nivel,
                 :old.aca_car_occ_codigo,
                 :old.aca_car_codigo,
                 :old.aca_ati_codigo,
                  sysdate,
                  'E',
                  user
                );
  END IF;
  IF UPDATING THEN
     INSERT INTO LOG_ATIVIDADES_CARGOS (
                aca_car_codigo_nivel,
                aca_car_occ_codigo,
                aca_car_codigo,
                aca_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
      VALUES
                (:old.aca_car_codigo_nivel,
                 :old.aca_car_occ_codigo,
                 :old.aca_car_codigo,
                 :old.aca_ati_codigo,
                  sysdate,
                  'A',
                  user
                );
  END IF;
END;
/

-- Comments for ATIVIDADES_CARGOS

COMMENT ON COLUMN atividades_cargos.aca_ati_codigo IS 'Código da Atividade'
/
COMMENT ON COLUMN atividades_cargos.aca_car_codigo IS 'Código do Cargo'
/
COMMENT ON COLUMN atividades_cargos.aca_car_codigo_nivel IS 'Código do Nível'
/
COMMENT ON COLUMN atividades_cargos.aca_car_occ_codigo IS 'Código da ocupação'
/

-- End of DDL Script for Table IFRSRH.ATIVIDADES_CARGOS

-- Start of DDL Script for Table IFRSRH.ATIVIDADES_EMPREGADOS
-- Generated 9-mar-2004 18:37:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE atividades_empregados
    (aem_ati_codigo                 NUMBER(4) NOT NULL,
    aem_emp_numero_matricula       NUMBER(7) NOT NULL,
    aem_data_inicio                DATE NOT NULL,
    aem_data_termino               DATE,
    aem_documento_inicio           VARCHAR2(30) NOT NULL,
    aem_documento_termino          VARCHAR2(30),
    aem_observacao                 VARCHAR2(300),
    aem_ind_ati_fun_car            VARCHAR2(1),
    aem_ind_ati_inerente           VARCHAR2(1),
    aem_data_confirma_nao_inerente DATE,
    aem_id_usuario_confirmacao     VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for ATIVIDADES_EMPREGADOS

CREATE INDEX aem_emp_fk_i ON atividades_empregados
  (
    aem_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX aem_ati_fk_i ON atividades_empregados
  (
    aem_ati_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for ATIVIDADES_EMPREGADOS

ALTER TABLE atividades_empregados
ADD CONSTRAINT aem_pk PRIMARY KEY (aem_emp_numero_matricula, aem_ati_codigo, 
  aem_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ATIVIDADES_EMPREGADOS

COMMENT ON COLUMN atividades_empregados.aem_ind_ati_fun_car IS 'Indicador de atividades de função de confiança ou cargo/ocupação/atuação'
/
COMMENT ON COLUMN atividades_empregados.aem_ind_ati_inerente IS 'Indicador de exclusividade de atividade inerente ao cargo ou função'
/

-- End of DDL Script for Table IFRSRH.ATIVIDADES_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.ATIVIDADES_FUNCOES
-- Generated 9-mar-2004 18:38:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE atividades_funcoes
    (atf_fun_codigo                 NUMBER(3) NOT NULL,
    atf_ati_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ATIVIDADES_FUNCOES

ALTER TABLE atividades_funcoes
ADD CONSTRAINT atf_codigo_pk PRIMARY KEY (atf_fun_codigo, atf_ati_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for ATIVIDADES_FUNCOES

CREATE TRIGGER log_atividades_funcoes
AFTER INSERT  OR UPDATE OF 
  atf_ati_codigo,
  atf_fun_codigo
 OR  DELETE 
ON atividades_funcoes
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF INSERTING THEN
     INSERT INTO LOG_ATIVIDADES_FUNCOES (
                atf_fun_codigo,
                atf_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:new.atf_fun_codigo,
                 :new.atf_ati_codigo,
                  sysdate,
                  'I',
                  user
                );
  END IF;
  IF DELETING THEN
     INSERT INTO LOG_ATIVIDADES_FUNCOES (
                atf_fun_codigo,
                atf_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:old.atf_fun_codigo,
                 :old.atf_ati_codigo,
                  sysdate,
                  'E',
                  user
                );
  END IF;
  IF UPDATING THEN
     INSERT INTO LOG_ATIVIDADES_FUNCOES (
                atf_fun_codigo,
                atf_ati_codigo,
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
      VALUES
                (:old.atf_fun_codigo,
                 :old.atf_ati_codigo,
                  sysdate,
                  'A',
                  user
                );
  END IF;
END;
/

-- End of DDL Script for Table IFRSRH.ATIVIDADES_FUNCOES

-- Start of DDL Script for Table IFRSRH.AUTORIZACOES_ESPECIAIS
-- Generated 9-mar-2004 18:38:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE autorizacoes_especiais
    (aes_numero_documento           VARCHAR2(25) NOT NULL,
    aes_dep_codigo                 NUMBER(4) NOT NULL,
    aes_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    aes_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    aes_data_autorizacao           DATE NOT NULL,
    aes_responsavel_autorizacao    VARCHAR2(70) NOT NULL,
    aes_valor_autorizado           NUMBER(12,2) NOT NULL,
    aes_calcular_participacao      VARCHAR2(1) NOT NULL,
    aes_observacao                 VARCHAR2(2000),
    aes_processo_encerrado         VARCHAR2(1),
    aes_dep_resp_incl              NUMBER(4),
    aes_emp_dep_codigo_fisico      NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AUTORIZACOES_ESPECIAIS

ALTER TABLE autorizacoes_especiais
ADD CONSTRAINT aes_pk PRIMARY KEY (aes_dep_codigo, aes_emb_emp_numero_matricula, 
  aes_emb_ben_sigla, aes_valor_autorizado)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.AUTORIZACOES_ESPECIAIS

-- Start of DDL Script for Table IFRSRH.AUTORIZACOES_ITENS_MEDICOS
-- Generated 9-mar-2004 18:38:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE autorizacoes_itens_medicos
    (aim_asm_senha                  NUMBER(13) NOT NULL,
    aim_cod_procedimento           NUMBER(7) NOT NULL,
    aim_dv_procedimento            NUMBER(1) NOT NULL,
    aim_quantidade                 NUMBER(2) NOT NULL,
    aim_valor_total                NUMBER(12,2) NOT NULL,
    aim_honor_valor_informado      NUMBER(12,2),
    aim_aux1_valor_informado       NUMBER(12,2),
    aim_aux2_valor_informado       NUMBER(12,2),
    aim_aux3_valor_informado       NUMBER(12,2),
    aim_anest_valor_informado      NUMBER(12,2),
    aim_tipo_acomodacao            VARCHAR2(1),
    aim_observacao                 VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AUTORIZACOES_ITENS_MEDICOS

ALTER TABLE autorizacoes_itens_medicos
ADD CONSTRAINT aim_pk PRIMARY KEY (aim_asm_senha, aim_cod_procedimento, 
  aim_dv_procedimento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE autorizacoes_itens_medicos
ADD CONSTRAINT aim_tipo_acomodacao_ck CHECK (AIM_TIPO_ACOMODACAO IN ('A','E'))
/

-- Comments for AUTORIZACOES_ITENS_MEDICOS

COMMENT ON TABLE autorizacoes_itens_medicos IS 'Tabela que contém os dados dos procedimentos relacionadas a uma guia de Autorizações de Serviços Médicos.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_anest_valor_informado IS 'Valor autorizado para faturamento do serviço do anestesista.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_asm_senha IS 'Campo formado pelo código da dependência + sequêncial de cinco dígitos + ano da autorização.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_aux1_valor_informado IS 'Valor autorizado para o faturamento do serviço do 1º Auxiliar.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_aux2_valor_informado IS 'Valor autorizado para o faturamento do serviço do 2º Axiliar.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_aux3_valor_informado IS 'Valor autorizado para o faturamento do serviço do 3º Auxiliar.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_cod_procedimento IS 'Código do procedimento médico.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_dv_procedimento IS 'Dígito verificador do código do procedimento médico.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_honor_valor_informado IS 'Valor autorizado para o faturamento do honorário médico.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_observacao IS 'Observação do item médico.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_quantidade IS 'Quantidade requisitada de procedimentos médicos.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_tipo_acomodacao IS 'Tipo da acomodação. ''A'' - Apartamento; ''E'' - Enfermaria.'
/
COMMENT ON COLUMN autorizacoes_itens_medicos.aim_valor_total IS 'Valor total do procedimento médico = (valor unitário * quantidade).'
/

-- End of DDL Script for Table IFRSRH.AUTORIZACOES_ITENS_MEDICOS

-- Start of DDL Script for Table IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS
-- Generated 9-mar-2004 18:38:39 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE autorizacoes_servicos_medicos
    (asm_senha                      NUMBER(13) NOT NULL,
    asm_emp_numero_matricula       NUMBER(7) NOT NULL,
    asm_cre_sequencial             NUMBER(5) NOT NULL,
    asm_pvi_sequencial             NUMBER(2),
    asm_dep_codigo                 NUMBER(4),
    asm_data_autorizacao           DATE,
    asm_emp_numero_matricula_resp  NUMBER(7),
    asm_pagamento                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AUTORIZACOES_SERVICOS_MEDICOS

ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT asm_pk PRIMARY KEY (asm_senha)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT ck_asm_pagamento CHECK (ASM_PAGAMENTO in ('S', 'N'))
/

-- Comments for AUTORIZACOES_SERVICOS_MEDICOS

COMMENT ON TABLE autorizacoes_servicos_medicos IS 'Tabela que armazena os dados da guia de Autorizações de Serviços Médicos.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_cre_sequencial IS 'Código sequêncial do credenciado a realizar o serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_data_autorizacao IS 'Data da autorização do serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_dep_codigo IS 'Código da dependência do responsável pela assinatura da autorização de serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_emp_numero_matricula IS 'Matrícula do empregado autorizado a realizar o serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_emp_numero_matricula_resp IS 'Matrícula do empregado que autorizou o serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_pagamento IS 'Quando igual a ''S'' indica que existe pagamento para a autorização do serviço médico e quando igual a ''N'' indica que não existe pagamento para a autorização do serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_pvi_sequencial IS 'Código sequêncial do dependente autorizado a realizar o serviço médico.'
/
COMMENT ON COLUMN autorizacoes_servicos_medicos.asm_senha IS 'Campo formado pelo código da dependência + sequêncial de cinco dígitos + ano da autorização.'
/

-- End of DDL Script for Table IFRSRH.AUTORIZACOES_SERVICOS_MEDICOS

-- Start of DDL Script for Table IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT
-- Generated 9-mar-2004 18:38:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE autorizacoes_tratamentos_odont
    (ato_numero                     NUMBER(14) NOT NULL,
    ato_data_guia                  DATE NOT NULL,
    ato_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    ato_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    ato_emb_ati_ct_custos          NUMBER(10) NOT NULL,
    ato_pvb_pvi_sequencial         NUMBER(2),
    ato_pvb_adesao                 DATE,
    ato_nome                       VARCHAR2(50) NOT NULL,
    ato_cre_sequencial             NUMBER(5),
    ato_cre_sequencial_perito      NUMBER(9),
    ato_data_autorizacao           DATE,
    ato_valor_autorizacao          NUMBER(12,2),
    ato_cancelado                  VARCHAR2(1) NOT NULL,
    ato_dep_codigo_credenciado     NUMBER(4),
    ato_pago                       CHAR(1),
    ato_numero_nota                NUMBER(6),
    ato_dep_resp_incl              NUMBER(4) NOT NULL,
    ato_tipo_perito                NUMBER(1),
    ato_perito_pago                VARCHAR2(1),
    ato_numero_nota_perito         NUMBER(6),
    ato_emp_dep_codigo_lotacao     NUMBER(4) NOT NULL,
    ato_obs_pericia                VARCHAR2(400),
    ato_valor_participacao         NUMBER(12,2),
    ato_mov_participacao           VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AUTORIZACOES_TRATAMENTOS_ODONT

ALTER TABLE autorizacoes_tratamentos_odont
ADD CONSTRAINT ato_pk PRIMARY KEY (ato_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for AUTORIZACOES_TRATAMENTOS_ODONT

COMMENT ON COLUMN autorizacoes_tratamentos_odont.ato_emp_dep_codigo_lotacao IS 'Dependencia de lotacao do empregado'
/
COMMENT ON COLUMN autorizacoes_tratamentos_odont.ato_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/
COMMENT ON COLUMN autorizacoes_tratamentos_odont.ato_perito_pago IS 'Informa se o perito foi pago ou nao'
/
COMMENT ON COLUMN autorizacoes_tratamentos_odont.ato_tipo_perito IS 'Tipo de credenciado (pessoa juridica ou fisica) relacionado ao perito'
/
COMMENT ON COLUMN autorizacoes_tratamentos_odont.ato_valor_participacao IS 'Valor da participacao a ser descontado'
/

-- End of DDL Script for Table IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT

-- Start of DDL Script for Table IFRSRH.AVERBACAO_TSERVICO
-- Generated 9-mar-2004 18:38:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE averbacao_tservico
    (avb_codigo                     NUMBER(2) NOT NULL,
    avb_emp_numero_matricula       NUMBER(7) NOT NULL,
    avb_codigo_empresa             NUMBER(1) NOT NULL,
    avb_data_inicio                DATE NOT NULL,
    avb_data_termino               DATE NOT NULL,
    avb_inc_promocao               VARCHAR2(1) NOT NULL,
    avb_inc_tempo_servico          VARCHAR2(1) NOT NULL,
    avb_inc_aposentadoria          VARCHAR2(1) NOT NULL,
    avb_documento                  VARCHAR2(15) NOT NULL,
    avb_texto                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for AVERBACAO_TSERVICO

ALTER TABLE averbacao_tservico
ADD CONSTRAINT avb_inc_aposentadoria_ck CHECK ( AVB_INC_APOSENTADORIA in ('S', 'N')                                              )
/
ALTER TABLE averbacao_tservico
ADD CONSTRAINT avb_inc_promocao_ck CHECK ( AVB_INC_PROMOCAO in ('S', 'N')                                                   )
/
ALTER TABLE averbacao_tservico
ADD CONSTRAINT avb_inc_tempo_servico_ck CHECK ( AVB_INC_TEMPO_SERVICO in ('S', 'N')                                              )
/
ALTER TABLE averbacao_tservico
ADD CONSTRAINT avb_pk PRIMARY KEY (avb_codigo, avb_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for AVERBACAO_TSERVICO

CREATE TRIGGER tgr_averbacao_t_servico_01
AFTER INSERT  OR UPDATE  OR  DELETE 
ON averbacao_tservico
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_dat_operacao               DATE;
  v_tip_operacao               VARCHAR2(1);
  v_cod_usuario                VARCHAR2(30);
  v_avb_codigo                 NUMBER(2);
  v_avb_emp_numero_matricula   NUMBER(7);
  v_avb_codigo_empresa         NUMBER(1);
  v_avb_data_inicio            DATE;
  v_avb_data_termino           DATE;
  v_avb_inc_promocao           VARCHAR2(1);
  v_avb_inc_tempo_servico      VARCHAR2(1);
  v_avb_inc_aposentadoria      VARCHAR2(1);
  v_avb_documento              VARCHAR2(15);
  v_avb_texto                  VARCHAR2(50);
BEGIN
  -- Carrego as variaveis que são independentes da operação
  v_dat_operacao := sysdate;
  v_cod_usuario  := user;
  -- Carrego as variaveis de acordo com a operação
  IF INSERTING THEN
    v_tip_operacao                := 'I';
    v_avb_codigo                  := :NEW.avb_codigo;
    v_avb_emp_numero_matricula    := :NEW.avb_emp_numero_matricula;
    v_avb_codigo_empresa          := :NEW.avb_codigo_empresa;
    v_avb_data_inicio             := :NEW.avb_data_inicio;
    v_avb_data_termino            := :NEW.avb_data_termino;
    v_avb_inc_promocao            := :NEW.avb_inc_promocao;
    v_avb_inc_tempo_servico       := :NEW.avb_inc_tempo_servico;
    v_avb_inc_aposentadoria       := :NEW.avb_inc_aposentadoria;
    v_avb_documento               := :NEW.avb_documento;
    v_avb_texto                   := :NEW.avb_texto;
  ELSIF UPDATING THEN
    v_tip_operacao                := 'U';
    v_avb_codigo                  := :OLD.avb_codigo;
    v_avb_emp_numero_matricula    := :OLD.avb_emp_numero_matricula;
    v_avb_codigo_empresa          := :OLD.avb_codigo_empresa;
    v_avb_data_inicio             := :OLD.avb_data_inicio;
    v_avb_data_termino            := :OLD.avb_data_termino;
    v_avb_inc_promocao            := :OLD.avb_inc_promocao;
    v_avb_inc_tempo_servico       := :OLD.avb_inc_tempo_servico;
    v_avb_inc_aposentadoria       := :OLD.avb_inc_aposentadoria;
    v_avb_documento               := :OLD.avb_documento;
    v_avb_texto                   := :OLD.avb_texto;
  ELSIF DELETING THEN
    v_tip_operacao                := 'D';
    v_avb_codigo                  := :OLD.avb_codigo;
    v_avb_emp_numero_matricula    := :OLD.avb_emp_numero_matricula;
    v_avb_codigo_empresa          := :OLD.avb_codigo_empresa;
    v_avb_data_inicio             := :OLD.avb_data_inicio;
    v_avb_data_termino            := :OLD.avb_data_termino;
    v_avb_inc_promocao            := :OLD.avb_inc_promocao;
    v_avb_inc_tempo_servico       := :OLD.avb_inc_tempo_servico;
    v_avb_inc_aposentadoria       := :OLD.avb_inc_aposentadoria;
    v_avb_documento               := :OLD.avb_documento;
    v_avb_texto                   := :OLD.avb_texto;
  END IF;
  -- Faço o Insert na tabela de LOG
  INSERT INTO LOG_AVERBACAO_TSERVICO
               (
                dat_operacao,
                tip_operacao,
                cod_usuario,
                avb_codigo,
                avb_emp_numero_matricula,
                avb_codigo_empresa,
                avb_data_inicio,
                avb_data_termino,
                avb_inc_promocao,
                avb_inc_tempo_servico,
                avb_inc_aposentadoria,
                avb_documento,
                avb_texto
               )
         VALUES
               (
                v_dat_operacao,
                v_tip_operacao,
                v_cod_usuario,
                v_avb_codigo,
                v_avb_emp_numero_matricula,
                v_avb_codigo_empresa,
                v_avb_data_inicio,
                v_avb_data_termino,
                v_avb_inc_promocao,
                v_avb_inc_tempo_servico,
                v_avb_inc_aposentadoria,
                v_avb_documento,
                v_avb_texto
               );
END;
/

-- End of DDL Script for Table IFRSRH.AVERBACAO_TSERVICO

-- Start of DDL Script for Table IFRSRH.BENEFICIARIOS
-- Generated 9-mar-2004 18:39:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE beneficiarios
    (bnf_sequencial                 NUMBER(10) NOT NULL,
    bnf_nome                       VARCHAR2(50) NOT NULL,
    bnf_numero_cpf                 NUMBER(11) NOT NULL,
    bnf_aba_ban_codigo             VARCHAR2(3) NOT NULL,
    bnf_aba_codigo                 VARCHAR2(7) NOT NULL,
    bnf_numero_conta_corrente      VARCHAR2(11) NOT NULL,
    bnf_emp_numero_matricula       NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for BENEFICIARIOS

CREATE INDEX bnf_aba_fk_i ON beneficiarios
  (
    bnf_aba_ban_codigo              ASC,
    bnf_aba_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for BENEFICIARIOS

ALTER TABLE beneficiarios
ADD CONSTRAINT bnf_pk PRIMARY KEY (bnf_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE beneficiarios
ADD CONSTRAINT bnf_uk UNIQUE (bnf_emp_numero_matricula, bnf_numero_cpf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.BENEFICIARIOS

-- Start of DDL Script for Table IFRSRH.BENEFICIARIOS_SEGUROS
-- Generated 9-mar-2004 18:39:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE beneficiarios_seguros
    (bsg_sequencial                 NUMBER(7) NOT NULL,
    bsg_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    bsg_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    bsg_pvi_emp_numero_matricula   NUMBER(7) NOT NULL,
    bsg_pvi_sequencial             NUMBER(2) NOT NULL,
    bsg_percentual_seguro_grupo    NUMBER(5,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for BENEFICIARIOS_SEGUROS

ALTER TABLE beneficiarios_seguros
ADD CONSTRAINT bsg_sequencial_pk PRIMARY KEY (bsg_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.BENEFICIARIOS_SEGUROS

-- Start of DDL Script for Table IFRSRH.BENEFICIOS
-- Generated 9-mar-2004 18:39:29 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE beneficios
    (ben_sigla                      VARCHAR2(3) NOT NULL,
    ben_nome                       VARCHAR2(50) NOT NULL,
    ben_participacao               VARCHAR2(1) NOT NULL,
    ben_descricao                  VARCHAR2(2000),
    ben_limite                     NUMBER(7,2),
    ben_idx_sigla                  VARCHAR2(6),
    ben_rub_codigo                 NUMBER(4),
    reembolso                      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for BENEFICIOS

CREATE INDEX ben_idx_fk_i ON beneficios
  (
    ben_idx_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ben_rub_fk_i ON beneficios
  (
    ben_rub_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for BENEFICIOS

ALTER TABLE beneficios
ADD CONSTRAINT ben_participacao_ck CHECK (  ben_participacao IN ( 'S' , 'N' )                                               )
/
ALTER TABLE beneficios
ADD CONSTRAINT ben_pk PRIMARY KEY (ben_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for BENEFICIOS

COMMENT ON COLUMN beneficios.ben_descricao IS 'Descric?o detalhada do Beneficio'
/
COMMENT ON COLUMN beneficios.ben_idx_sigla IS 'Sigla do indexador'
/
COMMENT ON COLUMN beneficios.ben_limite IS 'Valor limite ou maximo de ressarcimento para o beneficio'
/
COMMENT ON COLUMN beneficios.ben_nome IS 'Nome do Beneficio'
/
COMMENT ON COLUMN beneficios.ben_participacao IS 'Indica se incide participac?o do Empregado no beneficio'
/
COMMENT ON COLUMN beneficios.ben_rub_codigo IS 'Codigo identificador da rubrica.'
/
COMMENT ON COLUMN beneficios.ben_sigla IS 'Sigla do Beneficio'
/

-- End of DDL Script for Table IFRSRH.BENEFICIOS

-- Start of DDL Script for Table IFRSRH.BENEFICIOS_TEMP
-- Generated 9-mar-2004 18:39:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE beneficios_temp
    (ben_sigla                      VARCHAR2(3),
    data                           DATE,
    numero_conexao                 NUMBER(5),
    local                          VARCHAR2(10),
    ben_nome                       VARCHAR2(80))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.BENEFICIOS_TEMP

-- Start of DDL Script for Table IFRSRH.BENEFICIOS_TEMP2
-- Generated 9-mar-2004 18:39:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE beneficios_temp2
    (ben_sigla                      VARCHAR2(3),
    data                           DATE,
    numero_conexao                 NUMBER(5),
    local                          VARCHAR2(10),
    ben_nome                       VARCHAR2(80))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.BENEFICIOS_TEMP2

-- Start of DDL Script for Table IFRSRH.CADASTRO_ASSINFRA
-- Generated 9-mar-2004 18:39:52 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cadastro_assinfra
    (cas_cnpj                       NUMBER(14) NOT NULL,
    cas_codigo                     NUMBER(5),
    cas_nome                       VARCHAR2(50),
    cas_ban_codigo                 VARCHAR2(3),
    cas_aba_ban_codigo             VARCHAR2(7),
    cas_conta_corrente             VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CADASTRO_ASSINFRA

ALTER TABLE cadastro_assinfra
ADD CONSTRAINT cas_pk PRIMARY KEY (cas_cnpj)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CADASTRO_ASSINFRA

COMMENT ON COLUMN cadastro_assinfra.cas_conta_corrente IS 'CONTA CORRENTE DE DEPOSITO DOS RECOLHIMENTOS DA ASSINFRA'
/

-- End of DDL Script for Table IFRSRH.CADASTRO_ASSINFRA

-- Start of DDL Script for Table IFRSRH.CADASTROS
-- Generated 9-mar-2004 18:39:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cadastros
    (emp_numero_cpf                 NUMBER(11) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    emp_numero_matricula_ant       NUMBER(7),
    emp_numero_matricula_tasa      NUMBER(7),
    emp_numero_matricula_arsa      NUMBER(7),
    emp_numero_fre                 NUMBER(5),
    emp_nome                       VARCHAR2(60) NOT NULL,
    emp_nome_abreviado             VARCHAR2(40),
    emp_indicador_sexo             VARCHAR2(1) NOT NULL,
    emp_data_nascimento            DATE NOT NULL,
    emp_indicador_estado_civil     NUMBER(1) NOT NULL,
    emp_nacionalidade              NUMBER(1) NOT NULL,
    emp_endereco_logradouro        VARCHAR2(100) NOT NULL,
    emp_endereco_numero_cep        NUMBER(8) NOT NULL,
    emp_ramal_residencia           NUMBER(4),
    emp_endereco_bairro            VARCHAR2(30),
    emp_endereco_fone              NUMBER(8),
    emp_numero_celular             NUMBER(8),
    emp_ddd_residencia             NUMBER(4),
    emp_ddd_celular                NUMBER(4),
    emp_jtr_codigo                 NUMBER(1),
    emp_aba_ban_codigo_cta_pgto    VARCHAR2(3) NOT NULL,
    emp_aba_codigo_conta_pgto      VARCHAR2(7) NOT NULL,
    emp_nu_conta_corrente_pagto    VARCHAR2(14),
    emp_eso_codigo                 NUMBER(2) NOT NULL,
    emp_sfu_codigo                 NUMBER(1) NOT NULL,
    emp_htd_dep_codigo             NUMBER(4),
    emp_htd_htr_codigo             NUMBER(2),
    emp_htd_sequencial             NUMBER(2),
    emp_data_chegada_brasil        DATE,
    emp_nu_registro_estrangeiro    VARCHAR2(10),
    emp_in_classe_registro_estrang NUMBER(1),
    emp_data_registro_estrangeiro  DATE,
    emp_cidade_nasc_estrangeiro    VARCHAR2(50),
    emp_cidade_natural_estrang     VARCHAR2(30),
    emp_ufe_sigla_estrangeiro      VARCHAR2(2),
    emp_decreto_naturalizacao      VARCHAR2(240),
    emp_data_validade_rne          DATE,
    emp_numero_ctps_rne            NUMBER(9),
    emp_nu_serie_ctps_rne          NUMBER(5),
    emp_data_expedicao_ctps_rne    DATE,
    emp_data_validade_ctps_rne     DATE,
    emp_mun_codigo_natural         NUMBER(5),
    emp_ufe_sigla_natural          VARCHAR2(2),
    emp_mun_codigo_reside          NUMBER(5),
    emp_ufe_sigla_residente        VARCHAR2(2),
    emp_data_naturalizacao         DATE,
    emp_numero_pis_pasep           NUMBER(11) NOT NULL,
    emp_data_pis_pasep             DATE,
    emp_nu_carteira_identidade     VARCHAR2(15),
    emp_sigla_orgao_emitente_ci    VARCHAR2(10),
    emp_data_expedicao_ci          DATE,
    emp_ufe_sigla_ci               VARCHAR2(2),
    emp_nu_titulo_eleitor          NUMBER(12),
    emp_nu_zona_titulo_eleitor     VARCHAR2(5),
    emp_nu_secao_titulo_eleitor    VARCHAR2(5),
    emp_ufe_sigla_tit_eleitor      VARCHAR2(2),
    emp_nu_certificado_reservista  VARCHAR2(12),
    emp_nu_categoria_cr            VARCHAR2(10),
    emp_nu_regiao_militar_cr       VARCHAR2(10),
    emp_tipo_cr                    VARCHAR2(3),
    emp_ano_emissao_cr             NUMBER(4),
    emp_nu_livro_certidao_casam    VARCHAR2(10),
    emp_nu_folha_certidao_casam    VARCHAR2(6),
    emp_data_casamento             DATE,
    emp_numero_carteira_trabalho   NUMBER(9),
    emp_numero_serie_carteira_trab NUMBER(6),
    emp_dt_expedicao_carteira_trab DATE,
    emp_ufe_sigla_ctps             VARCHAR2(2),
    emp_data_opcao_fgts            DATE,
    emp_codigo_fgts                NUMBER(10),
    emp_numero_conta_fgts          NUMBER(8),
    emp_aba_ban_codigo_fgts        VARCHAR2(3),
    emp_aba_codigo_fgts            VARCHAR2(7),
    emp_nu_carteira_habilitacao    VARCHAR2(11),
    emp_in_categoria_habilitacao   VARCHAR2(2),
    emp_dt_validade_carteira_hab   DATE,
    emp_nu_habilitacao_lancha      NUMBER(10),
    emp_indicador_categoria_hab    VARCHAR2(1),
    emp_dt_validade_habilit_lancha DATE,
    emp_nu_carteira_orgao_classe   VARCHAR2(11),
    emp_ufe_sigla_reg_profis       VARCHAR2(2),
    emp_pai_codigo                 NUMBER(4),
    emp_oex_codigo_cedido          NUMBER(5),
    emp_oex_codigo_requisitado     NUMBER(5),
    emp_qlp_hcl_uor_codigo         NUMBER(9),
    emp_qlp_hcl_data_vigencia      DATE,
    emp_qlp_car_codigo             NUMBER(3),
    emp_qlp_car_codigo_nivel       NUMBER(1),
    emp_qlp_car_occ_codigo         NUMBER(3),
    emp_nsa_codigo_nivel           NUMBER(2),
    emp_nsa_codigo_padrao          VARCHAR2(4),
    emp_nsa_in_nivel_escolaridade  VARCHAR2(1),
    emp_qfu_fun_codigo             NUMBER(3),
    emp_qfu_hfl_uor_codigo         NUMBER(9),
    emp_qfu_hfl_data_vigencia      DATE,
    emp_tipo_remuneracao_funcao    VARCHAR2(2),
    emp_qfu_fun_codigo_acumula     NUMBER(3),
    emp_qfu_hfl_uor_cod_acum       NUMBER(9),
    emp_qfu_hfl_data_vigen_acum    DATE,
    emp_tipo_remuner_funcao_acumul VARCHAR2(2),
    emp_qfu_fun_codigo_substitui   NUMBER(3),
    emp_qfu_hfl_uor_cod_subst      NUMBER(9),
    emp_qfu_hfl_data_vigen_subst   DATE,
    emp_tipo_remuner_funcao_subst  VARCHAR2(2),
    emp_ocl_sigla                  VARCHAR2(6),
    emp_emp_nu_matricula_casado    NUMBER(7),
    emp_dep_codigo_lotacao         NUMBER(4),
    emp_dep_codigo_pagto           NUMBER(4),
    emp_dep_codigo_fisico          NUMBER(4),
    emp_uor_codigo_lotacao         NUMBER(9),
    emp_indicador_primeiro_emprego VARCHAR2(1),
    emp_ano_primeiro_emprego       NUMBER(4),
    emp_ufe_sigla_primeiro_emprego VARCHAR2(2),
    emp_status                     NUMBER(2),
    emp_codigo_rais                VARCHAR2(8),
    emp_tipo_conta                 VARCHAR2(3),
    emp_classe_hab_tecnologica     VARCHAR2(10),
    emp_numero_hab_tecnologica     VARCHAR2(10),
    emp_data_hab_tecnologica       DATE,
    emp_habilit_orgao_oper         NUMBER(5),
    emp_data_capacitacao_fisica    DATE,
    emp_indicador_depv             VARCHAR2(4),
    emp_numero_depv                NUMBER(5),
    emp_licenca_depv               NUMBER(5),
    emp_situacao_militar           NUMBER(1),
    emp_posto_graduacao_codigo     NUMBER(2),
    emp_quadro_arma_esp_codigo     NUMBER(2),
    emp_forca_armada_codigo        NUMBER(2),
    emp_data_admissao              DATE,
    emp_ati_ct_custos              NUMBER(10),
    emp_nome_pai                   VARCHAR2(50),
    emp_nome_mae                   VARCHAR2(50),
    emp_id_aposentadoria           NUMBER(1),
    emp_dt_aposentadoria           DATE,
    emp_dt_reserva_militar         DATE,
    emp_plano_arsaprev             NUMBER(1),
    emp_data_filiacao_arsaprev     DATE,
    emp_data_cancelamento_arsaprev DATE,
    emp_contrib_sindical_anual     VARCHAR2(1),
    emp_contrib_federativa         VARCHAR2(1),
    emp_adianta_13                 VARCHAR2(1),
    emp_cor_raca                   NUMBER(1) NOT NULL,
    emp_nome_guerra                VARCHAR2(30),
    emp_endereco_eletronico_mail   VARCHAR2(80),
    emp_uor_codigo_fisico          NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CADASTROS

CREATE INDEX ind_gera_avaliacao ON cadastros
  (
    emp_data_admissao               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_cadastros_02 ON cadastros
  (
    emp_sfu_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for CADASTROS

ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_1 CHECK ( EMP_NSA_IN_NIVEL_ESCOLARIDADE IN ('A','B','C')  )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_3 CHECK ( emp_in_classe_registro_estrang IN ( 1 , 2 )  )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_4 CHECK (  emp_tipo_remuneracao_funcao IN ('RG','FG','DI')                                 )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_5 CHECK ( emp_in_categoria_habilitacao IN ('E', 'B' , 'C' , 'D' , 'A1', 'A2','A3') )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_6 CHECK ( emp_indicador_categoria_hab IN ( 'A' , 'M' , 'C' )  )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ck_7 CHECK ( EMP_PLANO_ARSAPREV in (1,2,3) )
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_pk PRIMARY KEY (emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk1 UNIQUE (emp_numero_cpf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk2 UNIQUE (emp_dep_codigo_lotacao, emp_ati_ct_custos, 
  emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk3 UNIQUE (emp_numero_matricula_ant)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk4 UNIQUE (emp_status, emp_dep_codigo_pagto, 
  emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk5 UNIQUE (emp_uor_codigo_lotacao, emp_ati_ct_custos, 
  emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uk6 UNIQUE (emp_numero_pis_pasep)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for CADASTROS

CREATE TRIGGER trg_uor_fisica
BEFORE INSERT  OR UPDATE 
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  --
  -- Altero a UOR fisica para que tenha o mesmo valor que a uor da lotacao
  :NEW.EMP_UOR_CODIGO_FISICO := :NEW.EMP_UOR_CODIGO_LOTACAO;
  --
END; --End TRIGGER trg_uor_fisica
/
CREATE TRIGGER trg_log_cadastros
BEFORE UPDATE OF 
  emp_aba_ban_codigo_cta_pgto,
  emp_aba_ban_codigo_fgts,
  emp_aba_codigo_conta_pgto,
  emp_aba_codigo_fgts,
  emp_adianta_13,
  emp_ano_primeiro_emprego,
  emp_ati_ct_custos,
  emp_classe_hab_tecnologica,
  emp_codigo_fgts,
  emp_codigo_rais,
  emp_contrib_federativa,
  emp_contrib_sindical_anual,
  emp_cor_raca,
  emp_data_admissao,
  emp_data_cancelamento_arsaprev,
  emp_data_filiacao_arsaprev,
  emp_data_nascimento,
  emp_dep_codigo_fisico,
  emp_dep_codigo_lotacao,
  emp_dep_codigo_pagto,
  emp_dt_aposentadoria,
  emp_dt_validade_carteira_hab,
  emp_dt_validade_habilit_lancha,
  emp_endereco_bairro,
  emp_endereco_logradouro,
  emp_eso_codigo,
  emp_habilit_orgao_oper,
  emp_id_aposentadoria,
  emp_indicador_categoria_hab,
  emp_indicador_depv,
  emp_indicador_estado_civil,
  emp_indicador_primeiro_emprego,
  emp_indicador_sexo,
  emp_in_categoria_habilitacao,
  emp_in_classe_registro_estrang,
  emp_jtr_codigo,
  emp_licenca_depv,
  emp_nacionalidade,
  emp_nome,
  emp_nome_abreviado,
  emp_nsa_codigo_nivel,
  emp_nsa_codigo_padrao,
  emp_numero_carteira_trabalho,
  emp_numero_conta_fgts,
  emp_numero_cpf,
  emp_numero_ctps_rne,
  emp_numero_depv,
  emp_numero_fre,
  emp_numero_hab_tecnologica,
  emp_numero_matricula,
  emp_numero_matricula_ant,
  emp_numero_matricula_arsa,
  emp_numero_matricula_tasa,
  emp_numero_pis_pasep,
  emp_numero_serie_carteira_trab,
  emp_nu_carteira_habilitacao,
  emp_nu_carteira_identidade,
  emp_nu_carteira_orgao_classe,
  emp_nu_categoria_cr,
  emp_nu_certificado_reservista,
  emp_nu_conta_corrente_pagto,
  emp_nu_habilitacao_lancha,
  emp_nu_regiao_militar_cr,
  emp_nu_registro_estrangeiro,
  emp_nu_secao_titulo_eleitor,
  emp_nu_serie_ctps_rne,
  emp_nu_titulo_eleitor,
  emp_nu_zona_titulo_eleitor,
  emp_oex_codigo_cedido,
  emp_oex_codigo_requisitado,
  emp_pai_codigo,
  emp_plano_arsaprev,
  emp_qfu_fun_codigo,
  emp_qfu_fun_codigo_acumula,
  emp_qfu_fun_codigo_substitui,
  emp_qlp_car_codigo,
  emp_qlp_car_codigo_nivel,
  emp_qlp_car_occ_codigo,
  emp_sfu_codigo,
  emp_status,
  emp_tipo_conta,
  emp_tipo_cr,
  emp_tipo_remuneracao_funcao,
  emp_tipo_remuner_funcao_acumul,
  emp_tipo_remuner_funcao_subst,
  emp_ufe_sigla_reg_profis,
  emp_uor_codigo_lotacao
 OR  DELETE 
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_CADASTROS
             (
                EMP_NUMERO_CPF,
                EMP_NUMERO_MATRICULA,
                EMP_NUMERO_MATRICULA_ANT,
                EMP_NUMERO_MATRICULA_TASA,
                EMP_NUMERO_MATRICULA_ARSA,
                EMP_NUMERO_FRE,
                EMP_NOME,
                EMP_NOME_ABREVIADO,
                EMP_INDICADOR_SEXO,
                EMP_DATA_NASCIMENTO,
                EMP_INDICADOR_ESTADO_CIVIL,
                EMP_NACIONALIDADE,
                EMP_ENDERECO_LOGRADOURO,
                EMP_ENDERECO_BAIRRO,
                EMP_JTR_CODIGO,
                EMP_ABA_BAN_CODIGO_CTA_PGTO,
                EMP_ABA_CODIGO_CONTA_PGTO,
                EMP_NU_CONTA_CORRENTE_PAGTO,
                EMP_ESO_CODIGO,
                EMP_SFU_CODIGO,
                EMP_NU_REGISTRO_ESTRANGEIRO,
                EMP_IN_CLASSE_REGISTRO_ESTRANG,
                EMP_NUMERO_CTPS_RNE,
                EMP_NU_SERIE_CTPS_RNE,
                EMP_NUMERO_PIS_PASEP,
                EMP_NU_CARTEIRA_IDENTIDADE,
                EMP_NU_TITULO_ELEITOR,
                EMP_NU_ZONA_TITULO_ELEITOR,
                EMP_NU_SECAO_TITULO_ELEITOR,
                EMP_NU_CERTIFICADO_RESERVISTA,
                EMP_NU_CATEGORIA_CR,
                EMP_NU_REGIAO_MILITAR_CR,
                EMP_TIPO_CR,
                EMP_NUMERO_CARTEIRA_TRABALHO,
                EMP_NUMERO_SERIE_CARTEIRA_TRAB,
                EMP_CODIGO_FGTS,
                EMP_NUMERO_CONTA_FGTS,
                EMP_ABA_BAN_CODIGO_FGTS,
                EMP_ABA_CODIGO_FGTS,
                EMP_NU_CARTEIRA_HABILITACAO,
                EMP_IN_CATEGORIA_HABILITACAO,
                EMP_DT_VALIDADE_CARTEIRA_HAB,
                EMP_NU_HABILITACAO_LANCHA,
                EMP_INDICADOR_CATEGORIA_HAB,
                EMP_DT_VALIDADE_HABILIT_LANCHA,
                EMP_NU_CARTEIRA_ORGAO_CLASSE,
                EMP_UFE_SIGLA_REG_PROFIS,
                EMP_PAI_CODIGO,
                EMP_OEX_CODIGO_CEDIDO,
                EMP_OEX_CODIGO_REQUISITADO,
                EMP_QLP_CAR_CODIGO,
                EMP_QLP_CAR_CODIGO_NIVEL,
                EMP_QLP_CAR_OCC_CODIGO,
                EMP_NSA_CODIGO_NIVEL,
                EMP_NSA_CODIGO_PADRAO,
                EMP_QFU_FUN_CODIGO,
                EMP_TIPO_REMUNERACAO_FUNCAO,
                EMP_QFU_FUN_CODIGO_ACUMULA,
                EMP_TIPO_REMUNER_FUNCAO_ACUMUL,
                EMP_QFU_FUN_CODIGO_SUBSTITUI,
                EMP_TIPO_REMUNER_FUNCAO_SUBST,
                EMP_DEP_CODIGO_LOTACAO,
                EMP_DEP_CODIGO_PAGTO,
                EMP_DEP_CODIGO_FISICO,
                EMP_UOR_CODIGO_LOTACAO,
                EMP_INDICADOR_PRIMEIRO_EMPREGO,
                EMP_ANO_PRIMEIRO_EMPREGO,
                EMP_STATUS,
                EMP_CODIGO_RAIS,
                EMP_TIPO_CONTA,
                EMP_CLASSE_HAB_TECNOLOGICA,
                EMP_NUMERO_HAB_TECNOLOGICA,
                EMP_HABILIT_ORGAO_OPER,
                EMP_INDICADOR_DEPV,
                EMP_NUMERO_DEPV,
                EMP_LICENCA_DEPV,
                EMP_DATA_ADMISSAO,
                EMP_ATI_CT_CUSTOS,
                EMP_ID_APOSENTADORIA,
                EMP_DT_APOSENTADORIA,
                EMP_PLANO_ARSAPREV,
                EMP_DATA_FILIACAO_ARSAPREV,
                EMP_DATA_CANCELAMENTO_ARSAPREV,
                EMP_CONTRIB_SINDICAL_ANUAL,
                EMP_CONTRIB_FEDERATIVA,
                EMP_ADIANTA_13,
                EMP_COR_RACA,
                DTA_OPERACAO,
                TIP_OPERACAO,
                COD_USUARIO
             )
             VALUES
             (
                :OLD.EMP_NUMERO_CPF,
                :OLD.EMP_NUMERO_MATRICULA,
                :OLD.EMP_NUMERO_MATRICULA_ANT,
                :OLD.EMP_NUMERO_MATRICULA_TASA,
                :OLD.EMP_NUMERO_MATRICULA_ARSA,
                :OLD.EMP_NUMERO_FRE,
                :OLD.EMP_NOME,
                :OLD.EMP_NOME_ABREVIADO,
                :OLD.EMP_INDICADOR_SEXO,
                :OLD.EMP_DATA_NASCIMENTO,
                :OLD.EMP_INDICADOR_ESTADO_CIVIL,
                :OLD.EMP_NACIONALIDADE,
                :OLD.EMP_ENDERECO_LOGRADOURO,
                :OLD.EMP_ENDERECO_BAIRRO,
                :OLD.EMP_JTR_CODIGO,
                :OLD.EMP_ABA_BAN_CODIGO_CTA_PGTO,
                :OLD.EMP_ABA_CODIGO_CONTA_PGTO,
                :OLD.EMP_NU_CONTA_CORRENTE_PAGTO,
                :OLD.EMP_ESO_CODIGO,
                :OLD.EMP_SFU_CODIGO,
                :OLD.EMP_NU_REGISTRO_ESTRANGEIRO,
                :OLD.EMP_IN_CLASSE_REGISTRO_ESTRANG,
                :OLD.EMP_NUMERO_CTPS_RNE,
                :OLD.EMP_NU_SERIE_CTPS_RNE,
                :OLD.EMP_NUMERO_PIS_PASEP,
                :OLD.EMP_NU_CARTEIRA_IDENTIDADE,
                :OLD.EMP_NU_TITULO_ELEITOR,
                :OLD.EMP_NU_ZONA_TITULO_ELEITOR,
                :OLD.EMP_NU_SECAO_TITULO_ELEITOR,
                :OLD.EMP_NU_CERTIFICADO_RESERVISTA,
                :OLD.EMP_NU_CATEGORIA_CR,
                :OLD.EMP_NU_REGIAO_MILITAR_CR,
                :OLD.EMP_TIPO_CR,
                :OLD.EMP_NUMERO_CARTEIRA_TRABALHO,
                :OLD.EMP_NUMERO_SERIE_CARTEIRA_TRAB,
                :OLD.EMP_CODIGO_FGTS,
                :OLD.EMP_NUMERO_CONTA_FGTS,
                :OLD.EMP_ABA_BAN_CODIGO_FGTS,
                :OLD.EMP_ABA_CODIGO_FGTS,
                :OLD.EMP_NU_CARTEIRA_HABILITACAO,
                :OLD.EMP_IN_CATEGORIA_HABILITACAO,
                :OLD.EMP_DT_VALIDADE_CARTEIRA_HAB,
                :OLD.EMP_NU_HABILITACAO_LANCHA,
                :OLD.EMP_INDICADOR_CATEGORIA_HAB,
                :OLD.EMP_DT_VALIDADE_HABILIT_LANCHA,
                :OLD.EMP_NU_CARTEIRA_ORGAO_CLASSE,
                :OLD.EMP_UFE_SIGLA_REG_PROFIS,
                :OLD.EMP_PAI_CODIGO,
                :OLD.EMP_OEX_CODIGO_CEDIDO,
                :OLD.EMP_OEX_CODIGO_REQUISITADO,
                :OLD.EMP_QLP_CAR_CODIGO,
                :OLD.EMP_QLP_CAR_CODIGO_NIVEL,
                :OLD.EMP_QLP_CAR_OCC_CODIGO,
                :OLD.EMP_NSA_CODIGO_NIVEL,
                :OLD.EMP_NSA_CODIGO_PADRAO,
                :OLD.EMP_QFU_FUN_CODIGO,
                :OLD.EMP_TIPO_REMUNERACAO_FUNCAO,
                :OLD.EMP_QFU_FUN_CODIGO_ACUMULA,
                :OLD.EMP_TIPO_REMUNER_FUNCAO_ACUMUL,
                :OLD.EMP_QFU_FUN_CODIGO_SUBSTITUI,
                :OLD.EMP_TIPO_REMUNER_FUNCAO_SUBST,
                :OLD.EMP_DEP_CODIGO_LOTACAO,
                :OLD.EMP_DEP_CODIGO_PAGTO,
                :OLD.EMP_DEP_CODIGO_FISICO,
                :OLD.EMP_UOR_CODIGO_LOTACAO,
                :OLD.EMP_INDICADOR_PRIMEIRO_EMPREGO,
                :OLD.EMP_ANO_PRIMEIRO_EMPREGO,
                :OLD.EMP_STATUS,
                :OLD.EMP_CODIGO_RAIS,
                :OLD.EMP_TIPO_CONTA,
                :OLD.EMP_CLASSE_HAB_TECNOLOGICA,
                :OLD.EMP_NUMERO_HAB_TECNOLOGICA,
                :OLD.EMP_HABILIT_ORGAO_OPER,
                :OLD.EMP_INDICADOR_DEPV,
                :OLD.EMP_NUMERO_DEPV,
                :OLD.EMP_LICENCA_DEPV,
                :OLD.EMP_DATA_ADMISSAO,
                :OLD.EMP_ATI_CT_CUSTOS,
                :OLD.EMP_ID_APOSENTADORIA,
                :OLD.EMP_DT_APOSENTADORIA,
                :OLD.EMP_PLANO_ARSAPREV,
                :OLD.EMP_DATA_FILIACAO_ARSAPREV,
                :OLD.EMP_DATA_CANCELAMENTO_ARSAPREV,
                :OLD.EMP_CONTRIB_SINDICAL_ANUAL,
                :OLD.EMP_CONTRIB_FEDERATIVA,
                :OLD.EMP_ADIANTA_13,
                :OLD.EMP_COR_RACA,
                SYSDATE,    -- DTA_OPERACAO,
                v_operacao, -- TIP_OPERACAO,
                USER        -- COD_USUARIO
             );
--
END; --End TRIGGER TRG_LOG_CADASTROS
/
CREATE TRIGGER srh_ans_emp_emb
AFTER UPDATE OF 
  emp_data_nascimento,
  emp_endereco_bairro,
  emp_endereco_logradouro,
  emp_endereco_numero_cep,
  emp_indicador_sexo,
  emp_mun_codigo_reside,
  emp_nome,
  emp_nome_mae,
  emp_numero_cpf,
  emp_numero_pis_pasep,
  emp_ufe_sigla_residente
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin

update  empregados_beneficios
set     emb_oper_ans = 2
where   emb_emp_numero_matricula = :new.emp_numero_matricula
and  emb_ben_sigla = 'MED'
and     emb_data_exclusao is null;

if  sql%notfound
then null;
end if;

End;
/
CREATE TRIGGER srh_ans_pvb_alt
AFTER UPDATE OF 
  emp_endereco_bairro,
  emp_endereco_logradouro,
  emp_endereco_numero_cep,
  emp_mun_codigo_reside,
  emp_ufe_sigla_residente
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin

update pessoas_vinculadas_benef
set    pvb_oper_ans = 2
where  pvb_pvi_emp_numero_matricula = :new.emp_numero_matricula
       and emb_ben_sigla = 'MED'
       and data_exclusao is null;
if sql%notfound
then null;
end if;

End;
/
CREATE TRIGGER srh_atualiza_emp_categorias
AFTER UPDATE 
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
update  empregados_categorias
set     emc_quantidade = 0
where   emc_emb_emp_numero_matricula = :old.emp_numero_matricula
and 	emc_cat_dep_codigo = :old.emp_dep_codigo_lotacao;
End;
/
CREATE TRIGGER atualiza_dep_resp_incl
AFTER UPDATE OF 
  emp_dep_codigo_lotacao,
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( (NEW.EMP_DEP_CODIGO_LOTACAO <> OLD.EMP_DEP_CODIGO_LOTACAO) )
Begin
-- atualiza a tabela empregados_beneficios
update  empregados_beneficios
set     emb_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where   emb_emp_numero_matricula = :OLD.emp_numero_matricula;
-- atualiza a tabela vinculado_universitarios
update  vinculado_universitarios
set     viu_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where   viu_pvi_emp_numero_matricula = :OLD.emp_numero_matricula;
-- atualiza a tabela empregados_categorias
update 	empregados_categorias
set 	emc_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where 	emc_emb_emp_numero_matricula =  :OLD.emp_numero_matricula
and 	emc_cat_dep_codigo = :old.emp_dep_codigo_lotacao;
End;
/

-- Comments for CADASTROS

COMMENT ON COLUMN cadastros.emp_aba_ban_codigo_cta_pgto IS 'IDENTIFICADOR DO ESTABELECIMENTO BANCÁRIO QUE ATENDE  AOS EMPREGADOS DA INFRAERO'
/
COMMENT ON COLUMN cadastros.emp_aba_ban_codigo_fgts IS 'CÓDIGO DO BANCO DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_aba_codigo_conta_pgto IS 'IDENTIFICADOR DE UMA AGÊNCIA BANCÁRIA REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_aba_codigo_fgts IS 'CÓDIGO DA AGÊNCIA BANCÁRIA DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_adianta_13 IS 'ADIANTAMENTO DO 13º DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ano_emissao_cr IS 'ANO DE EMISSÃO DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ano_primeiro_emprego IS 'ANO DO PRIMEIRO EMPREGO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ati_ct_custos IS 'CÓDIGO IDENTIFICADOR  DO  CENTRO DE CUSTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_cidade_nasc_estrangeiro IS 'CIDADE DE NASCIMENTO DO EMPREGADO, CASO ELE SEJA ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_cidade_natural_estrang IS 'DESCRIÇÃO DA CIDADE DE NATURALIDADE ESTRANGEIRA DO EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_classe_hab_tecnologica IS 'CLASSE DE HABILITAÇÃO TECNOLÓGICA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_codigo_fgts IS 'CÓDIGO DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_codigo_rais IS 'CÓDIGO DA RAIS - RELAÇÃO ANUAL DE INFORMAÇÕES SOCIAIS DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_contrib_federativa IS 'FLAG QUE IDENTIFICA SE O EMPREGADO É OPTANTE PELA CONTRIBUIÇÃO FEDERATIVA(S/N)'
/
COMMENT ON COLUMN cadastros.emp_contrib_sindical_anual IS 'CONTRIBUIÇÃO SINDICAL ANUAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_cor_raca IS 'FLAG QUE IDENTIFICA A COR/RAÇA DO EMPREGADO (INDÍGENA =0, BRANCA=2, PRETA=4, AMARELA=6, PARDA=8)'
/
COMMENT ON COLUMN cadastros.emp_data_admissao IS 'DATA DE ADMISSÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_cancelamento_arsaprev IS 'DATA DE CANCELAMENTO DO EMPREGADO NO  PLANO ARSAPREV'
/
COMMENT ON COLUMN cadastros.emp_data_capacitacao_fisica IS 'DATA DA CAPACITAÇÃO FÍSICA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_casamento IS 'DATA DE CASAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_chegada_brasil IS 'DATA DE CHEGADA AO BRASIL, DO EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_data_expedicao_ci IS 'DATA DE EXPEDIÇÃO DA CARTEIRA DE IDENTIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_expedicao_ctps_rne IS 'DATA DE EXPEDIÇÃO DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_filiacao_arsaprev IS 'DATA DE FILIAÇÃO DO EMPREGADO  NO  PLANO ARSAPREV'
/
COMMENT ON COLUMN cadastros.emp_data_hab_tecnologica IS 'DATA DE HABILITAÇÃO TECNOLÓGICA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_nascimento IS 'DATA DE NASCIMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_naturalizacao IS 'DATA DE NATURALIZAÇÃO DO EMPREGADO, CASO TENHA NATURALIZADO-SE BRASILEIRO'
/
COMMENT ON COLUMN cadastros.emp_data_opcao_fgts IS 'DATA DE OPÇÃO DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_pis_pasep IS 'DATA DO PIS_PASEP'
/
COMMENT ON COLUMN cadastros.emp_data_registro_estrangeiro IS 'DATA DE CONCESSÃO DO REGISTRO DE EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_data_validade_ctps_rne IS 'DATA DE VALIDADE  DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_data_validade_rne IS 'DATA  DE VALIDADE DO REGISTRO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ddd_celular IS 'DESCRIÇÃO DO NÚMERO DO DDD -DISCAGEM DIRETA A DISTÂNCIA DO CELULAR  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ddd_residencia IS 'DESCRIÇÃO DO NÚMERO DO DDD - DISCAGEM DIRETA A DISTÂNCIA  RESIDENCIAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_decreto_naturalizacao IS 'DECRETO PARA NACIONALIDADE NATURALIZADO/BRAZILEIRO.'
/
COMMENT ON COLUMN cadastros.emp_dep_codigo_fisico IS 'CÓDIGO DA DEPENDÊNCIA FÍSICA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dep_codigo_lotacao IS 'CÓDIGO DA DEPENDÊNCIA DE LOTAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dep_codigo_pagto IS 'CÓDIGO DA DEPENDÊNCIA DE PAGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dt_aposentadoria IS 'DATA DE APOSENTADORIA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dt_expedicao_carteira_trab IS 'DATA DE EXPEDIÇÃO DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dt_reserva_militar IS 'DATA EM QUE O MILITAR ENTROU PARA RESERVA (APOSENTADORIA)'
/
COMMENT ON COLUMN cadastros.emp_dt_validade_carteira_hab IS 'DATA DE VALIDADE DA CARTEIRA DE HABILITAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_dt_validade_habilit_lancha IS 'DATA DE VALIDADE DA CARTEIRA DE HABILITAÇÃO DE LANCHA  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_emp_nu_matricula_casado IS 'NÚMERO DE MATRÍCULA DE CASAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_endereco_bairro IS 'DESCRIÇÃO DO ENDEREÇO DO BAIRRO RESIDENCIAL  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_endereco_eletronico_mail IS 'DESCRIÇÃO DO ENDEREÇO ELETRÔNICO (EMAIL) DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_endereco_fone IS 'DESCRIÇÃO DO NÚMERO DO TELEFONE RESIDENCIAL  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_endereco_logradouro IS 'DESCRIÇÃO DO ENDEREÇO RESIDENCIAL DO  EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_endereco_numero_cep IS 'DESCRIÇÃO DO CÓDIGO DE ENDEREÇAMENTO POSTAL DO ENDEREÇO RESIDENCIAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_eso_codigo IS 'SEQUENCIAL IDENTIFICADOR DE UM GRAU DE ESCOLARIDADE'
/
COMMENT ON COLUMN cadastros.emp_forca_armada_codigo IS 'CÓDIGO DE FORÇAS ARMADAS DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_habilit_orgao_oper IS 'HABILITAÇÃO DO ÓRGÃO OPERACIONAL DO DEPV'
/
COMMENT ON COLUMN cadastros.emp_htd_dep_codigo IS 'CÓDIGO IDENTIFICADOR  DA DEPENDÊNCIA SEGUNDO A ESTRUTURA ORGANIZACIONAL DA INFRAERO'
/
COMMENT ON COLUMN cadastros.emp_htd_htr_codigo IS 'CÓDIGO IDENTIFICADOR DO HORÁRIO DE TRABALHO'
/
COMMENT ON COLUMN cadastros.emp_htd_sequencial IS 'IDENTIFICADOR DO HORÁRIO DE TRABALHO'
/
COMMENT ON COLUMN cadastros.emp_id_aposentadoria IS 'IDENTIFICADOR DA APOSENTADORIA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_in_categoria_habilitacao IS 'INDICADOR DO TIPO DE CATEGORIA DA CARTEIRA DE HABILITAÇÃO  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_in_classe_registro_estrang IS 'CLASSE ATRIBUÍDA PELO MINISTÉRIO DA JUSTIÇA AO REGISTRO DO EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_indicador_categoria_hab IS 'INDICADOR DO TIPO DE CATEGORIA DA CARTEIRA DE HABILITAÇÃO DE LANCHA  DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_indicador_depv IS 'INDICADOR DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_indicador_estado_civil IS 'IDENTIFICADOR DO ESTADO CIVIL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_indicador_primeiro_emprego IS 'INDICADOR DO PRIMEIRO EMPREGO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_indicador_sexo IS 'INDICADOR DO SEXO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_jtr_codigo IS 'CÓDIGO IDENTIFICADOR DA JORNADA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_licenca_depv IS 'LICENÇA DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_mun_codigo_natural IS 'CÓDIGO MUNÍCIPIO DA NATURALIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_mun_codigo_reside IS 'CÓDIGO DO MUNICIPIO RESIDENCIAL DO EMPREGADO (CIDADE ONDE RESIDE O EMPREGADO)'
/
COMMENT ON COLUMN cadastros.emp_nacionalidade IS 'DESCRIÇÃO DA NACIONALIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nome IS 'DESCRIÇÃO DO NOME DO EMPREGADO COMPLETO'
/
COMMENT ON COLUMN cadastros.emp_nome_abreviado IS 'DESCRIÇÃO DO NOME DO EMPREGADO ABREVIADO'
/
COMMENT ON COLUMN cadastros.emp_nome_guerra IS 'DESCRIÇÃO DO NOME DE GUERRA (APELIDO) DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nome_mae IS 'DESCRIÇÃO DO NOME DA MÃE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nome_pai IS 'DESCRIÇÃO DO NOME DA PAI DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nsa_codigo_nivel IS 'CÓDIGO IDENTIFICADOR DO NÍVEL SALARIAL DO EMPREGADO (FUNÇÃO DESIGNADO)'
/
COMMENT ON COLUMN cadastros.emp_nsa_codigo_padrao IS 'CÓDIGO IDENTIFICADOR DO PADRÃO DO  NÍVEL SALARIAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nsa_in_nivel_escolaridade IS 'CÓDIDO IDENTIFICADOR DO NÍVEL DE ESCOLARIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_carteira_habilitacao IS 'NÚMERO DA CARTEIRA DE HABILITAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_carteira_identidade IS 'NÚMERO DA CARTEIRA DE IDENTIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_carteira_orgao_classe IS 'NÚMERO DA CARTEIRA REFERENTE AO ÓRGÃO DE CLASSE'
/
COMMENT ON COLUMN cadastros.emp_nu_categoria_cr IS 'NÚMERO DA CATEGORIA DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_certificado_reservista IS 'NÚMERO DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_conta_corrente_pagto IS 'IDENTIFICADOR DO NÚMERO DA CONTA CORRENTE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_folha_certidao_casam IS 'NÚMERO DA FOLHA DA CERTIDÃO DE CASAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_habilitacao_lancha IS 'NÚMERO DA CARTEIRA DE HABILITAÇÃO DE LANCHA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_livro_certidao_casam IS 'NÚMERO DO LIVRO DA CERTIDÃO DE CASAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_regiao_militar_cr IS 'NÚMERO DA REGIÃO MILITAR DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_registro_estrangeiro IS 'NÚMERO DE REGISTRO , SE EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_nu_secao_titulo_eleitor IS 'NÚMERO DA SEÇÃO DO TÍTULO ELEITORAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_serie_ctps_rne IS 'NÚMERO DE SÉRIE DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_titulo_eleitor IS 'NÚMERO DO TÍTULO DO ELEITOR DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_nu_zona_titulo_eleitor IS 'NÚMERO DA ZONA  ELEITORAL DO TÍTULO DE ELEITOR DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_carteira_trabalho IS 'NÚMERO DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_celular IS 'DESCRIÇÃO DO NÚMERO DO CELULAR DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_conta_fgts IS 'NÚMERO DA CONTA DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_cpf IS 'NÚMERO DE INSCRIÇÃO DO EMPREGADO NO CADASTRO DE PESSOAS FÍSICAS'
/
COMMENT ON COLUMN cadastros.emp_numero_ctps_rne IS 'NÚMERO DO REGISTRO DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_depv IS 'NÚMERO DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_fre IS 'NÚMERO DA FICHA DE REGISTRO DO EMPREGADO JUNTO AO MINISTÉRIO DO TRABALHO'
/
COMMENT ON COLUMN cadastros.emp_numero_hab_tecnologica IS 'NÚMERO DA HABILITAÇÃO TECNOLÓGICA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_numero_matricula IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DO EMPREGADO CONTRATADO ( ATIVO)'
/
COMMENT ON COLUMN cadastros.emp_numero_matricula_ant IS 'IDENTIFICADOR DO NÚMERO DE MATRÍCULA DE EMPREGADO DE CONTRATAÇÃO ANTERIOR'
/
COMMENT ON COLUMN cadastros.emp_numero_matricula_arsa IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DOS EMPREGADOS EX - ARSA'
/
COMMENT ON COLUMN cadastros.emp_numero_matricula_tasa IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DOS EMPREGADOS EX - TASA'
/
COMMENT ON COLUMN cadastros.emp_numero_pis_pasep IS 'NÚMERO DO PIS_PASEP'
/
COMMENT ON COLUMN cadastros.emp_numero_serie_carteira_trab IS 'NÚMERO DE SÉRIE DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ocl_sigla IS 'SIGLA DO ÓRGÃO DE CLASSE DA CATEGORIA PROFISSIONAL A QUAL PERTENCE O EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_oex_codigo_cedido IS 'CÓDIGO DO ÓRGÃO EXTERNO DE EMPREGADO CEDIDO'
/
COMMENT ON COLUMN cadastros.emp_oex_codigo_requisitado IS 'CÓDIGO DO ÓRGÃO EXTERNO DE EMPREGADO CEDIDO'
/
COMMENT ON COLUMN cadastros.emp_pai_codigo IS 'CÓDIGO IDENTIFICADOR DOS PAIS'
/
COMMENT ON COLUMN cadastros.emp_plano_arsaprev IS 'FLAG QUE IDENTIFICA O TIPO DE PLANO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_posto_graduacao_codigo IS 'CÓDIGO DO POSTO DE GRADUAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_qfu_fun_codigo IS 'CÓDIGO IDENTIFICADOR DO EMPREGADO  FUNÇÃO DESIGNADA'
/
COMMENT ON COLUMN cadastros.emp_qfu_fun_codigo_acumula IS 'CÓDIGO DA FUNÇÃO UTILIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_fun_codigo_substitui IS 'CÓDIGO DA FUNÇÃO UTILIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_data_vigen_acum IS 'DATA DE VIGÊNCIA  UTILIZADA NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_data_vigen_subst IS 'DATA DE VIGÊNCIA  UTILIZADA NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_data_vigencia IS 'DATA DE VIGÊNCIA  UTILIZADA NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO DESIGNADA)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_uor_cod_acum IS 'CÓDIGO DA UNIDADE ORGANIZACIONAL UTLIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_uor_cod_subst IS 'CÓDIGO DA UNIDADE ORGANIZACIONAL UTLIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_qfu_hfl_uor_codigo IS 'CÓDIGO DA UNIDADE ORGANIZACIONAL UTILIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO DESIGNADA)'
/
COMMENT ON COLUMN cadastros.emp_qlp_car_codigo IS 'CÓDIGO IDENTIFICADOR DO CARGO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_qlp_car_codigo_nivel IS 'CÓDIGO IDENTIFICADOR DO NÍVEL DO CARGO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_qlp_car_occ_codigo IS 'CÓDIGO IDENTIFICADOR DA OCUPAÇÃO/ATUAÇÃO DO CARGO'
/
COMMENT ON COLUMN cadastros.emp_qlp_hcl_data_vigencia IS 'DATA DE VIGÊNCIA DA LOTAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_qlp_hcl_uor_codigo IS 'CÓDIGO DO ÓRGÃO EXTERNO DE EMPREGADO REQUISITADO'
/
COMMENT ON COLUMN cadastros.emp_quadro_arma_esp_codigo IS 'CÓDIGO DO QUADRO DE FORÇAS ARMADAS ESPECIAIS DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ramal_residencia IS 'DESCRIÇÃO DO NÚMERO DO RAMAL DA RESIDÊNCIA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_sfu_codigo IS 'CÓDIGO IDENTIFICADOR DA SITUAÇÃO FUNCIONAL DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_sigla_orgao_emitente_ci IS 'SIGLA DO ORGÃO EMITENTE DA CARTEIRA DE IDENTIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_situacao_militar IS 'SITUAÇÃO MILITAR DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_status IS 'IDENTIFICADOR DO STATUS DO EMPREGADO ( SE ATIVO OU DESLIGADO)'
/
COMMENT ON COLUMN cadastros.emp_tipo_conta IS 'NÚMERO DA CONTA CORRENTE PARA DEPÓSITO  DO PAGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_tipo_cr IS 'IDENTIFICADOR DO TIPO DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_tipo_remuner_funcao_acumul IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_tipo_remuner_funcao_subst IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN cadastros.emp_tipo_remuneracao_funcao IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO DESIGNADA)'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_ci IS 'SIGLA DA UNIDADE FEDERATIVA DA CARTEIRA DE IDENTIDADE DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_ctps IS 'UNIDADE FEDERATIVA DA SIGLA DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_estrangeiro IS 'DESCRIÇÃO DA UNIDADE FEDERATIVA (SIGLA) DO EMPREGADO  ESTRANGEIRO'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_natural IS 'SIGLA DA UNIDADE FEDERATIVA DE NATURALIZAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_primeiro_emprego IS 'SIGLA DA UNIDADE  FEDERATIVA DO PRIMEIRO EMPREGO DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_reg_profis IS 'SIGLA DA UNIDADE FEDERATIVA  REFERENTE DO ÓRGÃO DE CLASSE.'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_residente IS 'SIGLA DA UNIDADE FEDERATIVA RESIDENTE DO EMPREGADO(SIGLA DA CIDADE ONDE RESIDE O EMPREGADO)'
/
COMMENT ON COLUMN cadastros.emp_ufe_sigla_tit_eleitor IS 'UNIDADE FEDERATIVA DA SIGLA DO TÍTULO DE ELEITOR DO EMPREGADO'
/
COMMENT ON COLUMN cadastros.emp_uor_codigo_fisico IS 'Código da Unidade Organizacional Física do empregado'
/
COMMENT ON COLUMN cadastros.emp_uor_codigo_lotacao IS 'CÓDIGO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL) DO EMPREGADO'
/

-- End of DDL Script for Table IFRSRH.CADASTROS

-- Start of DDL Script for Table IFRSRH.CADASTROS_TMP
-- Generated 9-mar-2004 18:41:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cadastros_tmp
    (emp_numero_cpf                 NUMBER(11) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    emp_numero_matricula_ant       NUMBER(7),
    emp_numero_matricula_tasa      NUMBER(7),
    emp_numero_matricula_arsa      NUMBER(7),
    emp_numero_fre                 NUMBER(5),
    emp_nome                       VARCHAR2(60) NOT NULL,
    emp_nome_abreviado             VARCHAR2(40),
    emp_indicador_sexo             VARCHAR2(1) NOT NULL,
    emp_data_nascimento            DATE NOT NULL,
    emp_indicador_estado_civil     NUMBER(1) NOT NULL,
    emp_nacionalidade              NUMBER(1) NOT NULL,
    emp_endereco_logradouro        VARCHAR2(50) NOT NULL,
    emp_endereco_numero_cep        NUMBER(8) NOT NULL,
    emp_ramal_residencia           NUMBER(4),
    emp_endereco_bairro            VARCHAR2(30),
    emp_endereco_fone              NUMBER(8),
    emp_numero_celular             NUMBER(8),
    emp_ddd_residencia             NUMBER(4),
    emp_ddd_celular                NUMBER(4),
    emp_jtr_codigo                 NUMBER(1),
    emp_aba_ban_codigo_cta_pgto    NUMBER(3) NOT NULL,
    emp_aba_codigo_conta_pgto      VARCHAR2(5) NOT NULL,
    emp_nu_conta_corrente_pagto    VARCHAR2(9),
    emp_eso_codigo                 NUMBER(2) NOT NULL,
    emp_sfu_codigo                 NUMBER(1) NOT NULL,
    emp_htd_dep_codigo             NUMBER(4),
    emp_htd_htr_codigo             NUMBER(2),
    emp_htd_sequencial             NUMBER(2),
    emp_data_chegada_brasil        DATE,
    emp_nu_registro_estrangeiro    VARCHAR2(10),
    emp_in_classe_registro_estrang NUMBER(1),
    emp_data_registro_estrangeiro  DATE,
    emp_cidade_nasc_estrangeiro    VARCHAR2(50),
    emp_cidade_natural_estrang     VARCHAR2(30),
    emp_ufe_sigla_estrangeiro      VARCHAR2(2),
    emp_decreto_naturalizacao      VARCHAR2(240),
    emp_data_validade_rne          DATE,
    emp_numero_ctps_rne            NUMBER(9),
    emp_nu_serie_ctps_rne          NUMBER(5),
    emp_data_expedicao_ctps_rne    DATE,
    emp_data_validade_ctps_rne     DATE,
    emp_mun_codigo_natural         NUMBER(5),
    emp_ufe_sigla_natural          VARCHAR2(2),
    emp_mun_codigo_reside          NUMBER(5),
    emp_ufe_sigla_residente        VARCHAR2(2),
    emp_data_naturalizacao         DATE,
    emp_numero_pis_pasep           NUMBER(11) NOT NULL,
    emp_data_pis_pasep             DATE,
    emp_nu_carteira_identidade     VARCHAR2(15),
    emp_sigla_orgao_emitente_ci    VARCHAR2(10),
    emp_data_expedicao_ci          DATE,
    emp_ufe_sigla_ci               VARCHAR2(2),
    emp_nu_titulo_eleitor          NUMBER(12),
    emp_nu_zona_titulo_eleitor     VARCHAR2(5),
    emp_nu_secao_titulo_eleitor    VARCHAR2(5),
    emp_ufe_sigla_tit_eleitor      VARCHAR2(2),
    emp_nu_certificado_reservista  VARCHAR2(12),
    emp_nu_categoria_cr            VARCHAR2(10),
    emp_nu_regiao_militar_cr       VARCHAR2(10),
    emp_tipo_cr                    VARCHAR2(3),
    emp_ano_emissao_cr             NUMBER(4),
    emp_nu_livro_certidao_casam    VARCHAR2(10),
    emp_nu_folha_certidao_casam    VARCHAR2(6),
    emp_data_casamento             DATE,
    emp_numero_carteira_trabalho   NUMBER(9),
    emp_numero_serie_carteira_trab NUMBER(5),
    emp_dt_expedicao_carteira_trab DATE,
    emp_ufe_sigla_ctps             VARCHAR2(2),
    emp_data_opcao_fgts            DATE,
    emp_codigo_fgts                NUMBER(10),
    emp_numero_conta_fgts          NUMBER(8),
    emp_aba_ban_codigo_fgts        NUMBER(3),
    emp_aba_codigo_fgts            VARCHAR2(5),
    emp_nu_carteira_habilitacao    VARCHAR2(10),
    emp_in_categoria_habilitacao   VARCHAR2(2),
    emp_dt_validade_carteira_hab   DATE,
    emp_nu_habilitacao_lancha      NUMBER(10),
    emp_indicador_categoria_hab    VARCHAR2(1),
    emp_dt_validade_habilit_lancha DATE,
    emp_nu_carteira_orgao_classe   VARCHAR2(11),
    emp_ufe_sigla_reg_profis       VARCHAR2(2),
    emp_pai_codigo                 NUMBER(4),
    emp_oex_codigo_cedido          NUMBER(5),
    emp_oex_codigo_requisitado     NUMBER(5),
    emp_qlp_hcl_uor_codigo         NUMBER(9),
    emp_qlp_hcl_data_vigencia      DATE,
    emp_qlp_car_codigo             NUMBER(3),
    emp_qlp_car_codigo_nivel       NUMBER(1),
    emp_qlp_car_occ_codigo         NUMBER(3),
    emp_nsa_codigo_nivel           NUMBER(2),
    emp_nsa_codigo_padrao          VARCHAR2(4),
    emp_nsa_in_nivel_escolaridade  VARCHAR2(1),
    emp_qfu_fun_codigo             NUMBER(3),
    emp_qfu_hfl_uor_codigo         NUMBER(9),
    emp_qfu_hfl_data_vigencia      DATE,
    emp_tipo_remuneracao_funcao    VARCHAR2(2),
    emp_qfu_fun_codigo_acumula     NUMBER(3),
    emp_qfu_hfl_uor_cod_acum       NUMBER(9),
    emp_qfu_hfl_data_vigen_acum    DATE,
    emp_tipo_remuner_funcao_acumul VARCHAR2(2),
    emp_qfu_fun_codigo_substitui   NUMBER(3),
    emp_qfu_hfl_uor_cod_subst      NUMBER(9),
    emp_qfu_hfl_data_vigen_subst   DATE,
    emp_tipo_remuner_funcao_subst  VARCHAR2(2),
    emp_ocl_sigla                  VARCHAR2(6),
    emp_emp_nu_matricula_casado    NUMBER(7),
    emp_dep_codigo_lotacao         NUMBER(4),
    emp_dep_codigo_pagto           NUMBER(4),
    emp_dep_codigo_fisico          NUMBER(4),
    emp_uor_codigo_lotacao         NUMBER(9),
    emp_indicador_primeiro_emprego VARCHAR2(1),
    emp_ano_primeiro_emprego       NUMBER(4),
    emp_ufe_sigla_primeiro_emprego VARCHAR2(2),
    emp_status                     NUMBER(2),
    emp_codigo_rais                VARCHAR2(8),
    emp_tipo_conta                 VARCHAR2(2),
    emp_classe_hab_tecnologica     VARCHAR2(10),
    emp_numero_hab_tecnologica     VARCHAR2(10),
    emp_data_hab_tecnologica       DATE,
    emp_habilit_orgao_oper         NUMBER(5),
    emp_data_capacitacao_fisica    DATE,
    emp_indicador_depv             VARCHAR2(4),
    emp_numero_depv                NUMBER(5),
    emp_licenca_depv               NUMBER(5),
    emp_situacao_militar           NUMBER(1),
    emp_posto_graduacao_codigo     NUMBER(2),
    emp_quadro_arma_esp_codigo     NUMBER(2),
    emp_forca_armada_codigo        NUMBER(2),
    emp_data_admissao              DATE,
    emp_ati_ct_custos              NUMBER(10),
    emp_nome_pai                   VARCHAR2(50),
    emp_nome_mae                   VARCHAR2(50),
    emp_id_aposentadoria           NUMBER(1),
    emp_dt_aposentadoria           DATE,
    emp_dt_reserva_militar         DATE,
    emp_plano_arsaprev             NUMBER(1),
    emp_data_filiacao_arsaprev     DATE,
    emp_data_cancelamento_arsaprev DATE,
    emp_contrib_sindical_anual     VARCHAR2(1),
    emp_contrib_federativa         VARCHAR2(1),
    emp_adianta_13                 VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CADASTROS_TMP

CREATE INDEX ind_cadas_tmp ON cadastros_tmp
  (
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.CADASTROS_TMP

-- Start of DDL Script for Table IFRSRH.CAGED
-- Generated 9-mar-2004 18:41:11 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE caged
    (cag_emp_numero_matricula       NUMBER(7) NOT NULL,
    cag_sequencial                 NUMBER(2) NOT NULL,
    cag_emp_indicador_sexo         VARCHAR2(1),
    cag_car_codigo_cbo             NUMBER(5),
    cag_emp_nome                   VARCHAR2(50),
    cag_emp_data_nascimento        DATE,
    cag_valor_remuneracao          NUMBER(10,2),
    cag_data_admissao              DATE,
    cag_tipo_movimento             NUMBER(2),
    cag_jtr_qt_horas_mensais       NUMBER(3),
    cag_emp_numero_ctps            NUMBER(9),
    cag_emp_numero_serie_ctps      NUMBER(5),
    cag_emp_ufe_sigla_ctps         VARCHAR2(2),
    cag_emp_eso_codigo             NUMBER(2),
    cag_emp_numero_pis_pasep       NUMBER(11),
    cag_dia_desligamento           NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CAGED

CREATE INDEX cag_tipo_movimento_i ON caged
  (
    cag_tipo_movimento              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for CAGED

ALTER TABLE caged
ADD CONSTRAINT cag_pk PRIMARY KEY (cag_emp_numero_matricula, cag_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CAGED

-- Start of DDL Script for Table IFRSRH.CARGOS
-- Generated 9-mar-2004 18:41:24 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cargos
    (car_codigo                     NUMBER(3) NOT NULL,
    car_codigo_nivel               NUMBER(1) NOT NULL,
    car_occ_codigo                 NUMBER(3) NOT NULL,
    car_nome                       VARCHAR2(50),
    car_sigla                      VARCHAR2(10) NOT NULL,
    car_quantidade                 NUMBER(5) NOT NULL,
    car_codigo_cbo                 VARCHAR2(6) NOT NULL,
    car_codigo_tcu                 NUMBER(6) NOT NULL,
    car_indicador_orgao_classe     VARCHAR2(1) NOT NULL,
    car_in_carteira_habilitacao    VARCHAR2(1) NOT NULL,
    car_in_habilitacao_lancha      VARCHAR2(1) NOT NULL,
    car_for_codigo                 NUMBER(3),
    car_jtr_codigo                 NUMBER(1) NOT NULL,
    car_eso_codigo                 NUMBER(2) NOT NULL,
    car_nsa_codigo_nivel_inicio    NUMBER(2) NOT NULL,
    car_nsa_codigo_padrao_inicio   VARCHAR2(4) NOT NULL,
    car_nsa_in_nivel_escola_inicio VARCHAR2(1) NOT NULL,
    car_nsa_codigo_nivel_final     NUMBER(2) NOT NULL,
    car_nsa_codigo_padrao_final    VARCHAR2(4) NOT NULL,
    car_nsa_in_nivel_escola_final  VARCHAR2(1) NOT NULL,
    car_in_certificado_hab_tecnol  VARCHAR2(1) NOT NULL,
    car_in_certificado_cap_fisica  VARCHAR2(1) NOT NULL,
    car_descricao_sumaria          VARCHAR2(1000),
    car_instrucao                  VARCHAR2(200),
    car_ocl_sigla                  VARCHAR2(6),
    car_data_criacao               DATE,
    car_documento_criacao          VARCHAR2(50),
    car_data_extincao              DATE,
    car_documento_extincao         VARCHAR2(50),
    car_in_certificado_depv        VARCHAR2(1) NOT NULL,
    car_nivel_estrategico_tatico   NUMBER(1),
    car_cbo_dta_inicio             DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CARGOS

ALTER TABLE cargos
ADD CONSTRAINT car_ck_1 CHECK ( car_nivel_estrategico_tatico in (1,2)                                            )
/
ALTER TABLE cargos
ADD CONSTRAINT car_pk PRIMARY KEY (car_codigo, car_codigo_nivel, car_occ_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CARGOS

-- Start of DDL Script for Table IFRSRH.CARGOS_CONFIANCA
-- Generated 9-mar-2004 18:41:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cargos_confianca
    (fun_codigo                     NUMBER(3) NOT NULL,
    fun_nome                       VARCHAR2(30) NOT NULL,
    fun_cfu_codigo                 NUMBER(2) NOT NULL,
    fun_jtr_codigo                 NUMBER(1) NOT NULL,
    fun_sigla                      VARCHAR2(10),
    fun_indicador_exclusivo_qcr    VARCHAR2(1),
    fun_descricao                  VARCHAR2(80),
    fun_data_criacao               DATE,
    fun_data_extincao              DATE,
    fun_documento_criacao          VARCHAR2(60),
    fun_documento_extincao         VARCHAR2(60),
    fun_quantidade                 NUMBER(5),
    fun_indicador_tipo_funcao      NUMBER(1),
    fun_nivel_estrategico_tatico   NUMBER(1),
    fun_posicao_trabalho           NUMBER(1) NOT NULL,
    fun_codigo_cbo                 VARCHAR2(6) NOT NULL,
    fun_cbo_dta_inicio             DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CARGOS_CONFIANCA

ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_ck_1 CHECK ( FUN_NIVEL_ESTRATEGICO_TATICO IN (1,2)                                            )
/
ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_ck_2 CHECK ( FUN_POSICAO_TRABALHO IN (0,1)                                                    )
/
ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_pk PRIMARY KEY (fun_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CARGOS_CONFIANCA

-- Start of DDL Script for Table IFRSRH.CARGOS_DEPENDENCIAS
-- Generated 9-mar-2004 18:41:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cargos_dependencias
    (cde_car_codigo                 NUMBER(3) NOT NULL,
    cde_dep_codigo                 NUMBER(4) NOT NULL,
    cde_car_codigo_nivel           NUMBER(1) NOT NULL,
    cde_car_occ_codigo             NUMBER(3) NOT NULL,
    cde_quantidade                 NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CARGOS_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.CARTEIRAS_IMPRESSAS_EMPREGADOS
-- Generated 9-mar-2004 18:41:44 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE carteiras_impressas_empregados
    (ci_emp_numero_matricula        NUMBER(7) NOT NULL,
    ci_emp_nome                    VARCHAR2(50) NOT NULL,
    ci_emp_data_nascimento         DATE NOT NULL,
    ci_emp_data_validade           VARCHAR2(7) NOT NULL,
    ci_emp_dependencia             NUMBER(8) NOT NULL,
    "CI_EMP_DATA_IMPRESSÃO"        DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CARTEIRAS_IMPRESSAS_EMPREGADOS

ALTER TABLE carteiras_impressas_empregados
ADD CONSTRAINT cie_pk PRIMARY KEY (ci_emp_numero_matricula, ci_emp_data_validade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CARTEIRAS_IMPRESSAS_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.CATEGORIAS_FUNCOES
-- Generated 9-mar-2004 18:41:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE categorias_funcoes
    (cfu_codigo                     NUMBER(2) NOT NULL,
    cfu_nome                       VARCHAR2(30) NOT NULL,
    cfu_vld_codigo                 NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CATEGORIAS_FUNCOES

ALTER TABLE categorias_funcoes
ADD CONSTRAINT cfu_pk PRIMARY KEY (cfu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CATEGORIAS_FUNCOES

-- Start of DDL Script for Table IFRSRH.CATEGORIAS_FUNCOES_VALOR
-- Generated 9-mar-2004 18:41:56 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE categorias_funcoes_valor
    (cfv_cfu_codigo                 NUMBER(2) NOT NULL,
    cfv_data_vigencia              DATE NOT NULL,
    cfv_valor_rg                   NUMBER(10,2),
    cfv_valor_fg                   NUMBER(10,2),
    cfv_valor_di                   NUMBER(10,2),
    cfv_percentual_participacao    NUMBER(4,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CATEGORIAS_FUNCOES_VALOR

ALTER TABLE categorias_funcoes_valor
ADD CONSTRAINT cfv_pk PRIMARY KEY (cfv_cfu_codigo, cfv_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CATEGORIAS_FUNCOES_VALOR

-- Start of DDL Script for Table IFRSRH.CATEGORIAS_TRANSPORTE
-- Generated 9-mar-2004 18:42:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE categorias_transporte
    (cat_dep_codigo                 NUMBER(4) NOT NULL,
    cat_sigla                      VARCHAR2(6) NOT NULL,
    cat_descricao                  VARCHAR2(250) NOT NULL,
    cat_valor                      NUMBER(6,2) NOT NULL,
    cat_dep_resp_incl              NUMBER(4) NOT NULL,
    cat_cbe_ben_sigla              VARCHAR2(3),
    cat_cbe_cre_sequencial         NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CATEGORIAS_TRANSPORTE

ALTER TABLE categorias_transporte
ADD CONSTRAINT cat_pk PRIMARY KEY (cat_dep_codigo, cat_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CATEGORIAS_TRANSPORTE

COMMENT ON COLUMN categorias_transporte.cat_cbe_ben_sigla IS 'Benefício ao qual a categoria de transporte está vinculada'
/
COMMENT ON COLUMN categorias_transporte.cat_cbe_cre_sequencial IS 'Credenciado ao qual a categoria de transporte está vinculada'
/

-- End of DDL Script for Table IFRSRH.CATEGORIAS_TRANSPORTE

-- Start of DDL Script for Table IFRSRH.CBO
-- Generated 9-mar-2004 18:42:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cbo
    (cbo_codigo                     VARCHAR2(6) NOT NULL,
    cbo_dta_inicio                 DATE NOT NULL,
    cbo_descricao                  VARCHAR2(250) NOT NULL,
    cbo_ano_identificador          NUMBER(4) NOT NULL,
    cbo_data_termino               DATE,
    cbo_cbo_codigo                 VARCHAR2(6),
    cbo_cbo_dta_inicio             DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CBO

ALTER TABLE cbo
ADD CONSTRAINT cbo_pk PRIMARY KEY (cbo_codigo, cbo_dta_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CBO

COMMENT ON COLUMN cbo.cbo_ano_identificador IS 'Ano identificador do tipo do CBO'
/
COMMENT ON COLUMN cbo.cbo_cbo_codigo IS 'Código do CBO anterior'
/
COMMENT ON COLUMN cbo.cbo_cbo_dta_inicio IS 'Data início da vigência do CBO anterior'
/
COMMENT ON COLUMN cbo.cbo_codigo IS 'Código do CBO'
/
COMMENT ON COLUMN cbo.cbo_descricao IS 'Descrição do CBO'
/
COMMENT ON COLUMN cbo.cbo_dta_inicio IS 'Data início da vigência do CBO'
/

-- End of DDL Script for Table IFRSRH.CBO

-- Start of DDL Script for Table IFRSRH.CID
-- Generated 9-mar-2004 18:42:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cid
    (cid_codigo                     VARCHAR2(5) NOT NULL,
    cid_descricao                  VARCHAR2(200) NOT NULL,
    cid_10_flg                     VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CID

ALTER TABLE cid
ADD CONSTRAINT cid_ck CHECK (  CID_10_FLG in ('S','N') )
/
ALTER TABLE cid
ADD CONSTRAINT cid_pk PRIMARY KEY (cid_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CID

-- Start of DDL Script for Table IFRSRH.COBERTURAS_SEGUROS
-- Generated 9-mar-2004 18:42:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE coberturas_seguros
    (csg_sequencial                 NUMBER(3) NOT NULL,
    csg_tpv_codigo                 NUMBER NOT NULL,
    csg_ipd_b                      NUMBER(2),
    csg_ipa_b                      NUMBER(2),
    csg_iea_b                      NUMBER(2),
    csg_mn_b                       NUMBER(2),
    csg_ipd_c                      NUMBER(2),
    csg_ipa_c                      NUMBER(2),
    csg_iea_c                      NUMBER(2),
    csg_mn_c                       NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for COBERTURAS_SEGUROS

ALTER TABLE coberturas_seguros
ADD CONSTRAINT cba_sequencial_pk PRIMARY KEY (csg_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.COBERTURAS_SEGUROS

-- Start of DDL Script for Table IFRSRH.COBRANCA_PSV
-- Generated 9-mar-2004 18:42:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cobranca_psv
    (csv_psv_sequencial             NUMBER(10) NOT NULL,
    csv_ano_referencia             NUMBER(4) NOT NULL,
    csv_mes_referencia             NUMBER(2) NOT NULL,
    csv_cre_sequencial             NUMBER(5),
    csv_numero                     NUMBER(10) NOT NULL,
    csv_psv_valor                  NUMBER(12,2),
    csv_psv_cod_plano              NUMBER(3),
    csv_emp_dep_fisico             NUMBER(4) NOT NULL,
    csv_emp_dep_lotacao            NUMBER(4) NOT NULL,
    csv_emp_ati_ct_custos          NUMBER(10),
    csv_ano_pagamento              NUMBER(4),
    csv_mes_pagamento              NUMBER(2),
    csv_desconto_folha             VARCHAR2(1),
    csv_psv_tipo_pagamento         VARCHAR2(1),
    csv_observacao                 VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for COBRANCA_PSV

ALTER TABLE cobranca_psv
ADD CONSTRAINT ck_csv_1 CHECK (CSV_DESCONTO_FOLHA IN ('S', 'N'))
/
ALTER TABLE cobranca_psv
ADD CONSTRAINT csv_pk PRIMARY KEY (csv_psv_sequencial, csv_ano_referencia, 
  csv_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.COBRANCA_PSV

-- Start of DDL Script for Table IFRSRH.CONCURSADOS_APROVADOS
-- Generated 9-mar-2004 18:42:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE concursados_aprovados
    (coa_con_nr_concurso            NUMBER(8) NOT NULL,
    coa_nr_inscricao               VARCHAR2(50) NOT NULL,
    coa_emp_numero_matricula       NUMBER(7),
    coa_nm_concursado              VARCHAR2(50),
    coa_nr_documento               VARCHAR2(50),
    coa_localidade                 VARCHAR2(50),
    coa_nm_cargo                   VARCHAR2(50),
    coa_nr_classificacao           NUMBER(4),
    coa_nr_ano_ato_cadastro_adm    NUMBER(4),
    coa_nr_ato_cadastro_adm        NUMBER(5),
    coa_nr_ato_admissao            VARCHAR2(6),
    coa_nr_ato_origem_vaga         VARCHAR2(6),
    coa_dt_public_ato_origem_vaga  DATE,
    coa_nr_ano_ato_cadastro_desl   NUMBER(4),
    coa_nr_ato_cadastro_desl       NUMBER(5),
    coa_dt_publicacao_ato_desl     DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONCURSADOS_APROVADOS

ALTER TABLE concursados_aprovados
ADD CONSTRAINT coa_pk PRIMARY KEY (coa_con_nr_concurso, coa_nr_inscricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CONCURSADOS_APROVADOS

COMMENT ON COLUMN concursados_aprovados.coa_con_nr_concurso IS 'NÚMERO DO CONCURSO 999.9/99.99 ONDE 999 - DEPENDÊNCIA; 9 - SEQÜÊNCIA NO ANO; 99 - ANO DO CONCURSO; 99 - NÚMERO SEQUÊNCIAL DO EDITAL DE PUBLICAÇÃO DO DIÁRIO OFICIAL'
/
COMMENT ON COLUMN concursados_aprovados.coa_dt_public_ato_origem_vaga IS 'DATA DA PUBLICAÇÃO DO ATO DE ORIGEM DA CRIAÇÃO DE VAGAS PARA O CARGO'
/
COMMENT ON COLUMN concursados_aprovados.coa_dt_publicacao_ato_desl IS 'DATA DA PUBLICAÇÃO DO ATO DO DESLIGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN concursados_aprovados.coa_emp_numero_matricula IS 'NÚMERO DA MATRÍCULA ATRIBUIDA AO CANDIDATO APROVADO E ADMITIDO PELA INFRAERO'
/
COMMENT ON COLUMN concursados_aprovados.coa_localidade IS 'LOCALIDADE DE REALIZAÇÃO DO CONCURSO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nm_cargo IS 'NOME DO CARGO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nm_concursado IS 'NOME DO CONCURSADO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ano_ato_cadastro_adm IS 'ANO DO ATO DE CADASTRAMENTO DA ADMISSÃO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ano_ato_cadastro_desl IS 'ANO DO ATO DE CADASTRAMENTO DO DESLIGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ato_admissao IS 'NÚMERO DO ATO DE ADMISSÃO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ato_cadastro_adm IS 'NÚMERO DO ATO DE CADASTRAMENTO DA ADMISSÃO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ato_cadastro_desl IS 'NÚMERO DO ATO DE CADASTRAMENTO DO DESLIGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_ato_origem_vaga IS 'NÚMERO DO ATO DE ORIGEM DA CRIAÇÃO DE VAGAS PARA O CARGO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_classificacao IS 'NÚMERO DE CLASSIFICAÇÃO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_documento IS 'NÚMERO DO DOCUMENTO'
/
COMMENT ON COLUMN concursados_aprovados.coa_nr_inscricao IS 'NÚMERO DE INSCRICAO DO CANDIDATO NO CONCURSO'
/

-- End of DDL Script for Table IFRSRH.CONCURSADOS_APROVADOS

-- Start of DDL Script for Table IFRSRH.CONCURSO_DOC_ORIGEM_VAGAS
-- Generated 9-mar-2004 18:42:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE concurso_doc_origem_vagas
    (cov_numero_documento           NUMBER(2) NOT NULL,
    cov_data_documento             DATE NOT NULL,
    cov_data_publicacao            DATE,
    cov_data_admissao              DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONCURSO_DOC_ORIGEM_VAGAS

ALTER TABLE concurso_doc_origem_vagas
ADD CONSTRAINT cov_pk PRIMARY KEY (cov_numero_documento, cov_data_documento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CONCURSO_DOC_ORIGEM_VAGAS

COMMENT ON TABLE concurso_doc_origem_vagas IS 'TABELA PARA ARMAZENAR OS DOCUMENTO QUE ORIGINAM AS VAGAS PARA O QUADRO DE EMPREGADOS DA INFRAERO E SUAS RESPECTIVAS DATAS.'
/
COMMENT ON COLUMN concurso_doc_origem_vagas.cov_data_documento IS 'DATA DE CRIAÇÃO DO DOCUMENTO DE ORIGEM DA VAGA.'
/
COMMENT ON COLUMN concurso_doc_origem_vagas.cov_data_publicacao IS 'DATA DA PUBLICAÇÃO DO DOCUMENTO DE ORIGEM DA VAGA.'
/
COMMENT ON COLUMN concurso_doc_origem_vagas.cov_numero_documento IS 'NÚMERO DO DOCUMENTO DE ORIGEM DA VAGA.'
/

-- End of DDL Script for Table IFRSRH.CONCURSO_DOC_ORIGEM_VAGAS

-- Start of DDL Script for Table IFRSRH.CONCURSOS
-- Generated 9-mar-2004 18:42:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE concursos
    (con_nr_concurso                NUMBER(8) NOT NULL,
    con_dt_edital_concurso         DATE,
    con_dt_homologacao_concurso    DATE,
    con_dt_validade_concurso       DATE,
    con_flg_preve_prorrogacao      VARCHAR2(1),
    con_flg_validade_prorrogada    VARCHAR2(1),
    con_ano_validade               NUMBER(4),
    con_mes_validade               NUMBER(2),
    con_dia_validade               NUMBER(2),
    con_flg_status_concurso        NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONCURSOS

ALTER TABLE concursos
ADD CONSTRAINT con_ck_1 CHECK ( CON_FLG_PREVE_PRORROGACAO IN ('S','N'))
/
ALTER TABLE concursos
ADD CONSTRAINT con_ck_2 CHECK ( CON_FLG_VALIDADE_PRORROGADA IN ('S','N'))
/
ALTER TABLE concursos
ADD CONSTRAINT con_ck_3 CHECK ( CON_FLG_STATUS_CONCURSO IN (1,2,3))
/
ALTER TABLE concursos
ADD CONSTRAINT con_pk PRIMARY KEY (con_nr_concurso)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CONCURSOS

COMMENT ON COLUMN concursos.con_ano_validade IS 'ANO DA VALIDADE'
/
COMMENT ON COLUMN concursos.con_dia_validade IS 'DIA DA VALIDADE'
/
COMMENT ON COLUMN concursos.con_dt_edital_concurso IS 'DATA DO EDITAL DE ABERTURA DO CONCURSO'
/
COMMENT ON COLUMN concursos.con_dt_homologacao_concurso IS 'DATA DA HOMOLOGAÇÃO DO CONCURSO'
/
COMMENT ON COLUMN concursos.con_dt_validade_concurso IS 'DATA DA VALIDADE DO CONCURSO'
/
COMMENT ON COLUMN concursos.con_flg_preve_prorrogacao IS 'FLAG PARA INDICAR SE O CONCURSO PREVE PRORROGAÇÃO: S - SIM E N - NÃO'
/
COMMENT ON COLUMN concursos.con_flg_status_concurso IS 'INDICADOR DO STATUS DO CONCURSO: 1 - CONCURSO VIGENTE,  2 - CONCURSO VENCIDO, 3 - CONCURSO SUSPENSO'
/
COMMENT ON COLUMN concursos.con_flg_validade_prorrogada IS 'FLAG PARA INDICAR SE A VALIDADE DO CONCURSO FOI PRORROGADA: S - SIM E N - NÃO'
/
COMMENT ON COLUMN concursos.con_mes_validade IS 'MES DA VALIDADE'
/
COMMENT ON COLUMN concursos.con_nr_concurso IS 'NÚMERO DO CONCURSO 999.9/99.99 ONDE 999 - DEPENDÊNCIA; 9 - SEQÜÊNCIA NO ANO; 99 - ANO DO CONCURSO; 99 - NÚMERO SEQUÊNCIAL DO EDITAL DE PUBLICAÇÃO DO DIÁRIO OFICIAL'
/

-- End of DDL Script for Table IFRSRH.CONCURSOS

-- Start of DDL Script for Table IFRSRH.CONSTANTES_LEGAIS
-- Generated 9-mar-2004 18:43:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE constantes_legais
    (col_codigo                     NUMBER(2) NOT NULL,
    col_denominacao                VARCHAR2(40) NOT NULL,
    col_valor                      NUMBER(17,4) NOT NULL,
    col_tipo                       NUMBER(1) NOT NULL,
    col_ano_referencia             NUMBER(4) NOT NULL,
    col_mes_referencia             NUMBER(2) NOT NULL,
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONSTANTES_LEGAIS

ALTER TABLE constantes_legais
ADD CONSTRAINT col_ck CHECK (col_tipo in (1,2))
/
ALTER TABLE constantes_legais
ADD CONSTRAINT col_pk PRIMARY KEY (col_codigo, col_ano_referencia, 
  col_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CONSTANTES_LEGAIS

COMMENT ON TABLE constantes_legais IS '- Retrofitted'
/
COMMENT ON COLUMN constantes_legais.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN constantes_legais.col_codigo IS 'Codigo identificador da constante legal'
/
COMMENT ON COLUMN constantes_legais.col_denominacao IS 'Denominacao da constante legal'
/
COMMENT ON COLUMN constantes_legais.col_tipo IS 'Identifica o tipo da constante legal, se valor em Real, ou se per'
/
COMMENT ON COLUMN constantes_legais.col_valor IS 'Valor da constante legal'
/
COMMENT ON COLUMN constantes_legais.dta_operacao IS 'Indica a data e hora da transação'
/

-- End of DDL Script for Table IFRSRH.CONSTANTES_LEGAIS

-- Start of DDL Script for Table IFRSRH.CONTROLE_OCORRENCIAS_RECEB_VAL
-- Generated 9-mar-2004 18:43:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE controle_ocorrencias_receb_val
    (ctl_orv_dep_codigo_fisico      NUMBER(4) NOT NULL,
    ctl_orv_emc_emb_ben_sigla      VARCHAR2(10) NOT NULL,
    ctl_orv_mes_processamento      NUMBER(2) NOT NULL,
    ctl_orv_ano_processamento      NUMBER(4) NOT NULL,
    ctl_orv_sequencial             NUMBER(4) NOT NULL,
    ctl_orv_quantidade             NUMBER(6),
    ctl_orv_data_hora_inicio       VARCHAR2(20),
    ctl_orv_data_hora_final        VARCHAR2(20),
    ctl_orv_concluido              NUMBER(2),
    ctl_ct_media_local             NUMBER(11,2),
    ctl_mct_media_nacional         NUMBER(11,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONTROLE_OCORRENCIAS_RECEB_VAL

ALTER TABLE controle_ocorrencias_receb_val
ADD CONSTRAINT ctl_orv_check_1 CHECK (CTL_ORV_CONCLUIDO in (0,1,2,3))
/
ALTER TABLE controle_ocorrencias_receb_val
ADD CONSTRAINT ctl_orv_pk PRIMARY KEY (ctl_orv_dep_codigo_fisico, 
  ctl_orv_emc_emb_ben_sigla, ctl_orv_mes_processamento, 
  ctl_orv_ano_processamento, ctl_orv_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CONTROLE_OCORRENCIAS_RECEB_VAL

-- Start of DDL Script for Table IFRSRH.CONTROLE_USUARIO_DEPENDENCIA
-- Generated 9-mar-2004 18:43:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE controle_usuario_dependencia
    (sgu_id_usuario                 VARCHAR2(10) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    flag_ind_dep_frequencia        VARCHAR2(1) NOT NULL,
    ssi_cd_sistema                 NUMBER(2) NOT NULL,
    in_dep_principal               VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONTROLE_USUARIO_DEPENDENCIA

ALTER TABLE controle_usuario_dependencia
ADD CONSTRAINT cud_pk PRIMARY KEY (sgu_id_usuario, ssi_cd_sistema, 
  dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE controle_usuario_dependencia
ADD CONSTRAINT cud_uk UNIQUE (sgu_id_usuario, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
DISABLE
/

-- Triggers for CONTROLE_USUARIO_DEPENDENCIA

CREATE TRIGGER log_usuario_dependencia
AFTER INSERT  OR UPDATE  OR  DELETE 
ON controle_usuario_dependencia
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare
   v_maquina      varchar2(64);
   v_programa     varchar2(64);
   v_sousuario    varchar2(15);
Begin
   select machine,program,osuser
     into v_maquina,v_programa,v_sousuario
     from oper_sessoes
    where audsid = userenv('SESSIONID');
   if inserting then
      insert into seg_log_usuario_dependencia (usuario,
                                               data_hora,
                                               acao,
                                               sgu_id_usuario,
                                               dep_cd_dependencia,
                                               maquina,
                                               programa,
                                               sousuario)
      values(user,
             sysdate,
             'I',
             :new.sgu_id_usuario,
             :new.dep_cd_dependencia,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if updating then
      insert into seg_log_usuario_dependencia (usuario,
                                               data_hora,
                                               acao,
                                               sgu_id_usuario,
                                               dep_cd_dependencia,
                                               maquina,
                                               programa,
                                               sousuario)
      values(user,
             sysdate,
             'U',
             :old.sgu_id_usuario,
             :old.dep_cd_dependencia,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if deleting then
      insert into seg_log_usuario_dependencia (usuario,
                                               data_hora,
                                               acao,
                                               sgu_id_usuario,
                                               dep_cd_dependencia,
                                               maquina,
                                               programa,
                                               sousuario)
      values(user,
             sysdate,
             'D',
             :old.sgu_id_usuario,
             :old.dep_cd_dependencia,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
End;
/
CREATE TRIGGER aft_idu_contr_usuario_depend
AFTER INSERT  OR UPDATE  OR  DELETE 
ON controle_usuario_dependencia
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_CONTROLE_USUARIO_DEPEND (
SGU_ID_USUARIO
,DEP_CD_DEPENDENCIA
,FLAG_IND_DEP_FREQUENCIA
,SSI_CD_SISTEMA
,IN_DEP_PRINCIPAL
,tp_geracao
,quem_gerou
)
values (
:new.SGU_ID_USUARIO
,:new.DEP_CD_DEPENDENCIA
,:new.FLAG_IND_DEP_FREQUENCIA
,:new.SSI_CD_SISTEMA
,:new.IN_DEP_PRINCIPAL
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_CONTROLE_USUARIO_DEPEND (
SGU_ID_USUARIO
,DEP_CD_DEPENDENCIA
,FLAG_IND_DEP_FREQUENCIA
,SSI_CD_SISTEMA
,IN_DEP_PRINCIPAL
,tp_geracao
,quem_gerou
)
values (
:old.SGU_ID_USUARIO
,:old.DEP_CD_DEPENDENCIA
,:old.FLAG_IND_DEP_FREQUENCIA
,:old.SSI_CD_SISTEMA
,:old.IN_DEP_PRINCIPAL
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_CONTROLE_USUARIO_DEPEND (
SGU_ID_USUARIO
,DEP_CD_DEPENDENCIA
,FLAG_IND_DEP_FREQUENCIA
,SSI_CD_SISTEMA
,IN_DEP_PRINCIPAL
,tp_geracao
,quem_gerou
)
values (
:old.SGU_ID_USUARIO
,:old.DEP_CD_DEPENDENCIA
,:old.FLAG_IND_DEP_FREQUENCIA
,:old.SSI_CD_SISTEMA
,:old.IN_DEP_PRINCIPAL
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRSRH.CONTROLE_USUARIO_DEPENDENCIA

-- Start of DDL Script for Table IFRSRH.CONTROLE_USUARIOS_FUNCOES
-- Generated 9-mar-2004 18:43:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE controle_usuarios_funcoes
    (sgu_id_usuario                 VARCHAR2(10) NOT NULL,
    fun_codigo                     NUMBER(3) NOT NULL,
    ss_cd_sistema                  NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONTROLE_USUARIOS_FUNCOES

ALTER TABLE controle_usuarios_funcoes
ADD CONSTRAINT cuf_uk UNIQUE (sgu_id_usuario, ss_cd_sistema, fun_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CONTROLE_USUARIOS_FUNCOES

-- Start of DDL Script for Table IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS
-- Generated 9-mar-2004 18:43:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE controle_usuarios_ocorrencias
    (sgu_id_usuario                 VARCHAR2(10) NOT NULL,
    ofu_codigo                     NUMBER(4) NOT NULL,
    ss_cd_sistema                  NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CONTROLE_USUARIOS_OCORRENCIAS

ALTER TABLE controle_usuarios_ocorrencias
ADD CONSTRAINT cuo_uk UNIQUE (sgu_id_usuario, ss_cd_sistema, ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CONTROLE_USUARIOS_OCORRENCIAS

-- Start of DDL Script for Table IFRSRH.CORPO_CLINICO
-- Generated 9-mar-2004 18:43:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE corpo_clinico
    (cc_cre_cod_seque               NUMBER(5) NOT NULL,
    cc_nome                        VARCHAR2(80) NOT NULL,
    cc_perito                      CHAR(1),
    cc_endereco                    VARCHAR2(50),
    cc_telefone                    NUMBER(14),
    cc_sequencial                  NUMBER(9) NOT NULL,
    cc_cbe_ben_sigla               VARCHAR2(3) NOT NULL,
    cc_nr_conselho                 VARCHAR2(12))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CORPO_CLINICO

ALTER TABLE corpo_clinico
ADD CONSTRAINT ccli_pk PRIMARY KEY (cc_cre_cod_seque, cc_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CORPO_CLINICO

-- Start of DDL Script for Table IFRSRH.CORPO_CLINICO_ESPECIALIDADES
-- Generated 9-mar-2004 18:43:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE corpo_clinico_especialidades
    (cce_cc_cre_cod_seque           NUMBER(5) NOT NULL,
    cce_esp_tipo                   NUMBER(1) NOT NULL,
    cce_esp_numero                 NUMBER(7) NOT NULL,
    cce_cc_sequencial              NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CORPO_CLINICO_ESPECIALIDADES

CREATE INDEX cce_ccli_fk ON corpo_clinico_especialidades
  (
    cce_cc_cre_cod_seque            ASC,
    cce_cc_sequencial               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX cce_cod_seque_fk ON corpo_clinico_especialidades
  (
    cce_esp_tipo                    ASC,
    cce_esp_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for CORPO_CLINICO_ESPECIALIDADES

ALTER TABLE corpo_clinico_especialidades
ADD CONSTRAINT corpo_clinico_especialid_pk PRIMARY KEY (cce_cc_cre_cod_seque, 
  cce_esp_tipo, cce_esp_numero, cce_cc_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CORPO_CLINICO_ESPECIALIDADES

-- Start of DDL Script for Table IFRSRH.CREDENC_INSS_OUTROS_RECOLHIM
-- Generated 9-mar-2004 18:44:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenc_inss_outros_recolhim
    (cor_cre_sequencial             NUMBER(5) NOT NULL,
    cor_dta_doc_fiscal             DATE NOT NULL,
    cor_num_doc_fiscal             VARCHAR2(30) NOT NULL,
    cor_cnpj_empresa               NUMBER(14) NOT NULL,
    cor_dta_inclusao               DATE NOT NULL,
    cor_dep_codigo                 NUMBER(4) NOT NULL,
    cor_razao_social_empresa       VARCHAR2(100) NOT NULL,
    cor_valor_inss_aut             NUMBER(15,2) NOT NULL,
    cor_dta_apresentacao           DATE NOT NULL,
    cor_ind_folha_beneficio        VARCHAR2(1),
    cor_ind_tip_operacao           VARCHAR2(1) NOT NULL,
    cor_user                       VARCHAR2(8) NOT NULL,
    cor_cor_cre_sequencial         NUMBER(5),
    cor_cor_dta_doc_fiscal         DATE,
    cor_cor_num_doc_fiscal         VARCHAR2(30),
    cor_cor_cnpj_empresa           NUMBER(14),
    cor_cor_dta_inclusao           DATE,
    cor_ind_tip_documento          NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CREDENC_INSS_OUTROS_RECOLHIM

ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_ind_tip_documento_ck CHECK (COR_IND_TIP_DOCUMENTO IN (1,2,3))
/
ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_ind_tip_operacao_ck CHECK (COR_IND_TIP_OPERACAO IN ( 'I' , 'A' , 'E' ))
/
ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_pk PRIMARY KEY (cor_cre_sequencial, cor_dta_doc_fiscal, 
  cor_num_doc_fiscal, cor_cnpj_empresa, cor_dta_inclusao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CREDENC_INSS_OUTROS_RECOLHIM

COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cnpj_empresa IS 'CNPJ DA EMPRESA ONDE O AUTÔNOMO RECOLHEU O INSS'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cor_cnpj_empresa IS 'AUTO-RELACIONAMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cor_cre_sequencial IS 'AUTO-RELACIONAMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cor_dta_doc_fiscal IS 'AUTO-RELACIONAMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cor_dta_inclusao IS 'AUTO-RELACIONAMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cor_num_doc_fiscal IS 'AUTO-RELACIONAMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_cre_sequencial IS 'CÓDIGO SEQUENCIAL DO CREDENCIADO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_dep_codigo IS 'DEPENDÊNCIA ONDE O DOCUMENTO COMPROBATÓRIO FOI APRESENTADO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_dta_apresentacao IS 'DATA EM QUE O AUTÔNOMO APRESENTOU O DOCUMENTO COMPROBATÓRIO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_dta_doc_fiscal IS 'DATA DO DOCUMENTO FISCAL'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_dta_inclusao IS 'DATA DE INCLUSÃO DO REGISTRO. DATA DO SISTEMA.'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_ind_folha_beneficio IS 'INFORMAR F OU B PARA INDICAR APLICAÇÃO DA FOLHA OU DO BENEFÍCIO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_ind_tip_documento IS 'Indicador do Tipo de Documento : 1=Contracheque, 2=RPA, 3=Declaração'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_ind_tip_operacao IS 'INDICA SE O REGISTRO É DE INCLUSÃO, ALTERAÇÃO OU EXCLUSÃO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_num_doc_fiscal IS 'NÚMERO DO DOCUMENTO FISCAL'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_razao_social_empresa IS 'RAZÃO SOCIAL DA EMPRESA ONDE O AUTÔNOMO RECOLHEU O INSS'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_user IS 'LOGIN DO USUÁRIO QUE REGISTROU O DOCUMENTO'
/
COMMENT ON COLUMN credenc_inss_outros_recolhim.cor_valor_inss_aut IS 'VALOR RECOLHIDO PELO AUTÔNOMO NA OUTRA EMPRESA'
/

-- End of DDL Script for Table IFRSRH.CREDENC_INSS_OUTROS_RECOLHIM

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS
-- Generated 9-mar-2004 18:44:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados
    (cre_sequencial                 NUMBER(5) NOT NULL,
    cre_tipo_pessoa                NUMBER(1) NOT NULL,
    cre_cgc_cpf                    NUMBER(17) NOT NULL,
    cre_dv                         NUMBER(2) NOT NULL,
    cre_nome                       VARCHAR2(150) NOT NULL,
    cre_nome_fantasia              VARCHAR2(150),
    cre_inscricao_estadual         NUMBER(14),
    cre_iss                        NUMBER(20),
    cre_inss                       NUMBER(20),
    cre_endereco                   VARCHAR2(150),
    cre_localidade                 VARCHAR2(30),
    cre_cidade                     VARCHAR2(30),
    cre_telefone                   NUMBER(10),
    cre_tesouraria                 NUMBER(7),
    cre_conta_corrente             VARCHAR2(15),
    cre_cre_sequencial             NUMBER(5),
    cre_aba_ban_codigo             VARCHAR2(3),
    cre_aba_codigo                 VARCHAR2(7),
    cre_ufe_sigla                  VARCHAR2(2),
    cre_fax                        NUMBER(10),
    cre_classe                     NUMBER(3),
    cre_ch                         NUMBER(12,6),
    cre_cho                        NUMBER(12,6),
    cre_tipo_tabela                VARCHAR2(40),
    cre_valor_ch                   NUMBER(6,2),
    cre_cpf                        NUMBER(9),
    cre_telefone2                  NUMBER(10),
    cre_telefone3                  NUMBER(10),
    cre_tipo                       NUMBER(2),
    cre_outros_enderecos           VARCHAR2(2000),
    cre_cep                        NUMBER(8),
    cre_nr_conselho                VARCHAR2(12),
    cre_ocl_sigla                  VARCHAR2(6),
    cre_perito                     VARCHAR2(1),
    cre_observacao                 VARCHAR2(2000),
    cre_dep_resp_incl              NUMBER(22) NOT NULL,
    cre_pis_pasep                  NUMBER(22))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CREDENCIADOS

CREATE INDEX cre_cre_fk_i ON credenciados
  (
    cre_cre_sequencial              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX cre_ufe_fk_i ON credenciados
  (
    cre_ufe_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX cre_aba_fk_i ON credenciados
  (
    cre_aba_ban_codigo              ASC,
    cre_aba_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for CREDENCIADOS

ALTER TABLE credenciados
ADD CONSTRAINT cre_pk PRIMARY KEY (cre_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_BENEFICIOS
-- Generated 9-mar-2004 18:44:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_beneficios
    (cbe_ben_sigla                  VARCHAR2(3) NOT NULL,
    cbe_cre_sequencial             NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CREDENCIADOS_BENEFICIOS

ALTER TABLE credenciados_beneficios
ADD CONSTRAINT cbe_pk PRIMARY KEY (cbe_ben_sigla, cbe_cre_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS_BENEFICIOS

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_CONTRATOS
-- Generated 9-mar-2004 18:44:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_contratos
    (cc_cbe_ben_sigla               VARCHAR2(3) NOT NULL,
    cc_cbe_cre_sequencial          NUMBER(5) NOT NULL,
    cc_mes                         NUMBER(2) NOT NULL,
    cc_ano                         NUMBER(4) NOT NULL,
    cc_contrato                    VARCHAR2(20) NOT NULL,
    cc_vigencia                    DATE,
    cc_taxa                        NUMBER(8,6),
    cc_aliquota_ir                 CHAR(1),
    cc_aliuota_iss                 NUMBER(5,3),
    cc_cr                          NUMBER(6),
    cc_status                      VARCHAR2(1),
    cc_indice_iss                  VARCHAR2(6),
    cc_sicaf                       VARCHAR2(1) NOT NULL,
    cc_tipo_tabela                 NUMBER(2) NOT NULL,
    cc_valor_ch                    NUMBER(7,3),
    cc_dep_codigo                  NUMBER(4) NOT NULL,
    cc_dep_resp_incl               NUMBER(4) NOT NULL,
    cc_irmp153                     VARCHAR2(1),
    cc_csll                        VARCHAR2(1),
    cc_cofins                      VARCHAR2(1),
    cc_pispasep                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CREDENCIADOS_CONTRATOS

ALTER TABLE credenciados_contratos
ADD CONSTRAINT cc_contrato_pk PRIMARY KEY (cc_cbe_ben_sigla, 
  cc_cbe_cre_sequencial, cc_mes, cc_ano, cc_contrato, cc_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_1 CHECK (                                cc_aliquota_ir IN ( 'S' , 'N' )                   )
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_2 CHECK (                                 cc_sicaf IN ( 'S' , 'N' )                        )
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_3 CHECK ( cc_irmp153 IN ( 'S' , 'N' ) )
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_4 CHECK ( cc_csll IN ( 'S' , 'N' ) )
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_5 CHECK ( cc_cofins IN ( 'S' , 'N' ) )
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT crecon_ck_6 CHECK ( cc_pispasep IN ( 'S' , 'N' ) )
/

-- Comments for CREDENCIADOS_CONTRATOS

COMMENT ON COLUMN credenciados_contratos.cc_cofins IS 'informa se o credenciado retém ou não a Contribuição para o financiamento da Seguridade Social de acordo com a MP 153/2003'
/
COMMENT ON COLUMN credenciados_contratos.cc_csll IS 'informa se o credenciado retém ou não a Contribuição Social sobre Lucro Líquido de acordo com a MP 153/2003'
/
COMMENT ON COLUMN credenciados_contratos.cc_irmp153 IS 'informa se o credenciado retém ou não o imposto de renda de acordo com a MP 153/2003'
/
COMMENT ON COLUMN credenciados_contratos.cc_pispasep IS 'informa se o credenciado retém ou não o PIS/PASEP de acordo com a MP 153/2003'
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS_CONTRATOS

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_DEPENDENCIAS
-- Generated 9-mar-2004 18:45:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_dependencias
    (cd_dep_codigo                  NUMBER(4) NOT NULL,
    cd_cre_sequencial              NUMBER(5) NOT NULL,
    cd_cbe_ben_sigla               VARCHAR2(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CREDENCIADOS_DEPENDENCIAS

ALTER TABLE credenciados_dependencias
ADD CONSTRAINT cd_pk PRIMARY KEY (cd_dep_codigo, cd_cre_sequencial, 
  cd_cbe_ben_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_ESPECIALIDADES
-- Generated 9-mar-2004 18:45:06 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_especialidades
    (cde_cre_sequencial             NUMBER(5) NOT NULL,
    cde_esp_tipo                   NUMBER(1) NOT NULL,
    cde_esp_numero                 NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CREDENCIADOS_ESPECIALIDADES

CREATE INDEX cde_esp_fk_i ON credenciados_especialidades
  (
    cde_esp_tipo                    ASC,
    cde_esp_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX cde_cre_fk_i ON credenciados_especialidades
  (
    cde_cre_sequencial              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for CREDENCIADOS_ESPECIALIDADES

ALTER TABLE credenciados_especialidades
ADD CONSTRAINT cde_pk PRIMARY KEY (cde_cre_sequencial, cde_esp_tipo, 
  cde_esp_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for CREDENCIADOS_ESPECIALIDADES

COMMENT ON COLUMN credenciados_especialidades.cde_cre_sequencial IS 'Numero identificador do Credenciado'
/
COMMENT ON COLUMN credenciados_especialidades.cde_esp_numero IS 'Numero da Especialidade'
/
COMMENT ON COLUMN credenciados_especialidades.cde_esp_tipo IS 'Tipo da Especialidade'
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS_ESPECIALIDADES

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_TIPO
-- Generated 9-mar-2004 18:45:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_tipo
    (crt_codigo                     NUMBER(2) NOT NULL,
    crt_descricao                  VARCHAR2(70) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CREDENCIADOS_TIPO

ALTER TABLE credenciados_tipo
ADD CONSTRAINT cti_pk PRIMARY KEY (crt_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.CREDENCIADOS_TIPO

-- Start of DDL Script for Table IFRSRH.CREDENCIADOS_TMP
-- Generated 9-mar-2004 18:45:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE credenciados_tmp
    (cre_sequencial                 NUMBER(5) NOT NULL,
    cre_tipo_pessoa                NUMBER(1) NOT NULL,
    cre_cgc_cpf                    NUMBER(17) NOT NULL,
    cre_dv                         NUMBER(2) NOT NULL,
    cre_nome                       VARCHAR2(150) NOT NULL,
    cre_nome_fantasia              VARCHAR2(150),
    cre_inscricao_estadual         NUMBER(14),
    cre_iss                        NUMBER(20),
    cre_inss                       NUMBER(20),
    cre_endereco                   VARCHAR2(150) NOT NULL,
    cre_localidade                 VARCHAR2(30) NOT NULL,
    cre_cidade                     VARCHAR2(30) NOT NULL,
    cre_telefone                   NUMBER(10) NOT NULL,
    cre_tesouraria                 NUMBER(7),
    cre_conta_corrente             VARCHAR2(15),
    cre_cre_sequencial             NUMBER(5),
    cre_aba_ban_codigo             NUMBER(3),
    cre_aba_codigo                 VARCHAR2(5),
    cre_ufe_sigla                  VARCHAR2(2) NOT NULL,
    cre_fax                        NUMBER(10),
    cre_classe                     NUMBER(3),
    cre_ch                         NUMBER(12,6),
    cre_cho                        NUMBER(12,6),
    cre_tipo_tabela                VARCHAR2(40),
    cre_valor_ch                   NUMBER(6,2),
    cre_cpf                        NUMBER(9),
    cre_telefone2                  NUMBER(10),
    cre_telefone3                  NUMBER(10),
    cre_tipo                       NUMBER(1),
    cre_outros_enderecos           VARCHAR2(2000),
    cre_cep                        NUMBER(8),
    cre_nr_conselho                VARCHAR2(12),
    cre_ocl_sigla                  VARCHAR2(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for CREDENCIADOS_TMP

CREATE INDEX ind_creden_tmp ON credenciados_tmp
  (
    cre_sequencial                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.CREDENCIADOS_TMP

-- Start of DDL Script for Table IFRSRH.CRONOGRAMAS_PAGAMENTOS
-- Generated 9-mar-2004 18:45:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE cronogramas_pagamentos
    (crp_dep_codigo                 NUMBER(4) NOT NULL,
    crp_epg_codigo                 NUMBER(3) NOT NULL,
    crp_ano_pagamento              NUMBER(4) NOT NULL,
    crp_mes_pagamento              NUMBER(2) NOT NULL,
    crp_sequencial                 NUMBER(2) NOT NULL,
    crp_data_prevista              DATE NOT NULL,
    crp_percentual_folha           NUMBER(3),
    crp_ind_13                     VARCHAR2(1),
    crp_data_realizacao            DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for CRONOGRAMAS_PAGAMENTOS

ALTER TABLE cronogramas_pagamentos
ADD CONSTRAINT crp_pk PRIMARY KEY (crp_dep_codigo, crp_epg_codigo, 
  crp_ano_pagamento, crp_mes_pagamento, crp_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for CRONOGRAMAS_PAGAMENTOS

CREATE TRIGGER log_cronogramas_pagamentos
AFTER UPDATE  OR  DELETE 
ON cronogramas_pagamentos
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
  v_crp_data_prevista               log_cronogramas_pagamentos.crp_data_prevista%type;
  v_crp_data_realizacao             log_cronogramas_pagamentos.crp_data_realizacao%type;

begin

  if deleting then
     insert into log_cronogramas_pagamentos (cod_usuario,dta_operacao,tip_operacao,
                 crp_dep_codigo,crp_epg_codigo,crp_ano_pagamento,crp_mes_pagamento,
                 crp_sequencial,crp_data_prevista,crp_data_realizacao)
     values     (user, sysdate,'E', :old.crp_dep_codigo, :old.crp_epg_codigo,
                 :old.crp_ano_pagamento, :old.crp_mes_pagamento,
                 :old.crp_sequencial, :old.crp_data_prevista, :old.crp_data_realizacao);
  end if;

  if updating then

     if :old.crp_data_prevista = :new.crp_data_prevista then
        v_crp_data_prevista := null;
     else
        v_crp_data_prevista := :new.crp_data_prevista;
     end if;

     if :old.crp_data_realizacao = :new.crp_data_realizacao then
        v_crp_data_realizacao := null;
     else
        v_crp_data_realizacao := :new.crp_data_realizacao;
     end if;

     insert into log_cronogramas_pagamentos (cod_usuario,dta_operacao,tip_operacao,
                 crp_dep_codigo,crp_epg_codigo,crp_ano_pagamento,crp_mes_pagamento,
                 crp_sequencial,crp_data_prevista,crp_data_realizacao)
     values     (user, sysdate,'A', :old.crp_dep_codigo, :old.crp_epg_codigo,
                 :old.crp_ano_pagamento, :old.crp_mes_pagamento,
                 :old.crp_sequencial, v_crp_data_prevista, v_crp_data_realizacao);
  end if;
end;
/

-- End of DDL Script for Table IFRSRH.CRONOGRAMAS_PAGAMENTOS

-- Start of DDL Script for Table IFRSRH.DATAPREV_ESPECIE
-- Generated 9-mar-2004 18:45:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_especie
    (des_cod_especie                NUMBER(2) NOT NULL,
    des_descricao_especie          VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_ESPECIE

ALTER TABLE dataprev_especie
ADD CONSTRAINT de_pk PRIMARY KEY (des_cod_especie)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_ESPECIE

-- Start of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO
-- Generated 9-mar-2004 18:45:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_reembolso
    (dar_ano_referencia             NUMBER(4) NOT NULL,
    dar_mes_referencia             NUMBER(2) NOT NULL,
    dar_emp_numero_matricula       NUMBER(7) NOT NULL,
    dar_cod_beneficio              NUMBER(10) NOT NULL,
    dar_dep_codigo                 NUMBER(4),
    dar_des_cod_especie            NUMBER(2),
    dar_cod_benef_sequencial       NUMBER(1) DEFAULT 1  NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_REEMBOLSO

ALTER TABLE dataprev_reembolso
ADD CONSTRAINT dree_pk PRIMARY KEY (dar_ano_referencia, dar_mes_referencia, 
  dar_emp_numero_matricula, dar_cod_beneficio, dar_cod_benef_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO

-- Start of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS
-- Generated 9-mar-2004 18:45:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_reembolso_rubricas
    (drr_ano_referencia             NUMBER(4) NOT NULL,
    drr_mes_referencia             NUMBER(2) NOT NULL,
    drr_emp_numero_matricula       NUMBER(7) NOT NULL,
    drr_dru_cod_rubrica            NUMBER(3) NOT NULL,
    drr_sequencial                 NUMBER(1) NOT NULL,
    drr_origem_credito             NUMBER(1) NOT NULL,
    drr_dt_ini_periodo             DATE NOT NULL,
    drr_dt_fim_periodo             DATE NOT NULL,
    drr_valor                      NUMBER(13,2) NOT NULL,
    drr_cod_beneficio              NUMBER(10) NOT NULL,
    drr_cod_benef_sequencial       NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_REEMBOLSO_RUBRICAS

ALTER TABLE dataprev_reembolso_rubricas
ADD CONSTRAINT drr_pk PRIMARY KEY (drr_ano_referencia, drr_mes_referencia, 
  drr_emp_numero_matricula, drr_dru_cod_rubrica, drr_sequencial, 
  drr_cod_beneficio, drr_cod_benef_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS

-- Start of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS_TE
-- Generated 9-mar-2004 18:46:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_reembolso_rubricas_te
    (drr_ano_referencia             NUMBER(4) NOT NULL,
    drr_mes_referencia             NUMBER(2) NOT NULL,
    drr_cod_beneficio              NUMBER(10) NOT NULL,
    drr_dru_cod_rubrica            NUMBER(3) NOT NULL,
    drr_sequencial                 NUMBER(1) NOT NULL,
    drr_origem_credito             NUMBER(1),
    drr_dt_ini_periodo             DATE,
    drr_dt_fim_periodo             DATE,
    drr_valor                      NUMBER(13,2),
    drr_emp_numero_matricula       NUMBER(7),
    drr_cod_benef_sequencial       NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_REEMBOLSO_RUBRICAS_TE

ALTER TABLE dataprev_reembolso_rubricas_te
ADD CONSTRAINT drrt_pk PRIMARY KEY (drr_ano_referencia, drr_mes_referencia, 
  drr_cod_beneficio, drr_dru_cod_rubrica, drr_sequencial, 
  drr_cod_benef_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_RUBRICAS_TE

-- Start of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_TEMP
-- Generated 9-mar-2004 18:46:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_reembolso_temp
    (dar_ano_referencia             NUMBER(4) NOT NULL,
    dar_mes_referencia             NUMBER(2) NOT NULL,
    dar_cod_beneficio              NUMBER(10) NOT NULL,
    dar_emp_numero_matricula       NUMBER(7),
    dar_nome                       VARCHAR2(30),
    dar_id_cent_empresa            NUMBER(6),
    dar_des_cod_especie            NUMBER(2),
    dar_cod_benef_sequencial       NUMBER(1) DEFAULT 1  NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_REEMBOLSO_TEMP

ALTER TABLE dataprev_reembolso_temp
ADD CONSTRAINT drt_pk PRIMARY KEY (dar_ano_referencia, dar_mes_referencia, 
  dar_cod_beneficio, dar_cod_benef_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_REEMBOLSO_TEMP

-- Start of DDL Script for Table IFRSRH.DATAPREV_RUBRICAS
-- Generated 9-mar-2004 18:46:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dataprev_rubricas
    (dru_cod_rubrica                NUMBER(3) NOT NULL,
    dru_descricao_rubrica          VARCHAR2(40) NOT NULL,
    dru_tipo_rubrica               VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DATAPREV_RUBRICAS

ALTER TABLE dataprev_rubricas
ADD CONSTRAINT dr_pk PRIMARY KEY (dru_cod_rubrica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DATAPREV_RUBRICAS

-- Start of DDL Script for Table IFRSRH.DEDUCAO_INSS_AUT_COOP
-- Generated 9-mar-2004 18:46:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE deducao_inss_aut_coop
    (dia_ano_deducao                NUMBER(4) NOT NULL,
    dia_mes_deducao                NUMBER(2) NOT NULL,
    dia_versao                     NUMBER(2) NOT NULL,
    dia_cre_sequencial             NUMBER(5) NOT NULL,
    dia_dep_codigo                 NUMBER(4) NOT NULL,
    dia_valor_deducao              NUMBER(15,2) NOT NULL,
    dia_motivo_deducao             VARCHAR2(2000) NOT NULL,
    dia_user                       VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DEDUCAO_INSS_AUT_COOP

ALTER TABLE deducao_inss_aut_coop
ADD CONSTRAINT dia_pk PRIMARY KEY (dia_ano_deducao, dia_mes_deducao, dia_versao, 
  dia_cre_sequencial, dia_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for DEDUCAO_INSS_AUT_COOP

COMMENT ON COLUMN deducao_inss_aut_coop.dia_cre_sequencial IS 'Código do credenciado'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_dep_codigo IS 'Dependência que está tendo valor deduzido'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_mes_deducao IS 'Mês da dedução'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_motivo_deducao IS 'Motivo da dedução'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_user IS 'Código de usuário'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_valor_deducao IS 'Valor da dedução'
/
COMMENT ON COLUMN deducao_inss_aut_coop.dia_versao IS 'Versão da dedução'
/

-- End of DDL Script for Table IFRSRH.DEDUCAO_INSS_AUT_COOP

-- Start of DDL Script for Table IFRSRH.DEDUCAO_INSS_EMPREGADOS
-- Generated 9-mar-2004 18:46:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE deducao_inss_empregados
    (die_ano_deducao                NUMBER(4) NOT NULL,
    die_mes_deducao                NUMBER(2) NOT NULL,
    die_versao                     NUMBER(2) NOT NULL,
    die_emp_numero_matricula       NUMBER(7) NOT NULL,
    die_dep_codigo                 NUMBER(4) NOT NULL,
    die_centro_custo               NUMBER(6) NOT NULL,
    die_valor_deducao              NUMBER(15,2) NOT NULL,
    die_motivo_deducao             VARCHAR2(2000) NOT NULL,
    die_user                       VARCHAR2(8) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DEDUCAO_INSS_EMPREGADOS

ALTER TABLE deducao_inss_empregados
ADD CONSTRAINT die_pk PRIMARY KEY (die_ano_deducao, die_mes_deducao, die_versao, 
  die_emp_numero_matricula, die_dep_codigo, die_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for DEDUCAO_INSS_EMPREGADOS

COMMENT ON COLUMN deducao_inss_empregados.die_ano_deducao IS 'Ano da dedução'
/
COMMENT ON COLUMN deducao_inss_empregados.die_centro_custo IS 'Centro de custo que está tendo valor deduzido'
/
COMMENT ON COLUMN deducao_inss_empregados.die_dep_codigo IS 'Dependência que está tendo valor deduzido'
/
COMMENT ON COLUMN deducao_inss_empregados.die_emp_numero_matricula IS 'Matrícula do empregado'
/
COMMENT ON COLUMN deducao_inss_empregados.die_mes_deducao IS 'Mês da dedução'
/
COMMENT ON COLUMN deducao_inss_empregados.die_motivo_deducao IS 'Motivo da dedução'
/
COMMENT ON COLUMN deducao_inss_empregados.die_user IS 'Código de usuário'
/
COMMENT ON COLUMN deducao_inss_empregados.die_valor_deducao IS 'Valor da dedução'
/
COMMENT ON COLUMN deducao_inss_empregados.die_versao IS 'Versão da dedução'
/

-- End of DDL Script for Table IFRSRH.DEDUCAO_INSS_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.DEMONSTRATIVO_CUSTO_BENEFICIO
-- Generated 9-mar-2004 18:46:39 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE demonstrativo_custo_beneficio
    (dcb_sigla                      VARCHAR2(4) NOT NULL,
    dcb_mes                        NUMBER(2) NOT NULL,
    dcb_ano                        NUMBER(4) NOT NULL,
    dcb_custo_liquido              NUMBER(15,2) NOT NULL,
    dcb_participacao               NUMBER(15,2) NOT NULL,
    dcb_sobras                     NUMBER(15,2),
    dcb_custo_emp                  NUMBER(15,2),
    dcb_custo_dep                  NUMBER(15,2),
    dcb_custo_apo                  NUMBER(15,2),
    dcb_custo_basico               NUMBER(15,2),
    dcb_custo_emp_bas              NUMBER(15,2),
    dcb_custo_comp                 NUMBER(15,2),
    dcb_dep_codigo                 NUMBER(4) NOT NULL,
    dcb_emp_numero_matricula       NUMBER(7) NOT NULL,
    dcb_centro_custo               NUMBER(6),
    dcb_data_atualizacao           DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DEMONSTRATIVO_CUSTO_BENEFICIO

ALTER TABLE demonstrativo_custo_beneficio
ADD CONSTRAINT dbc_sigmesanodep_pk PRIMARY KEY (dcb_sigla, dcb_mes, dcb_ano, 
  dcb_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for DEMONSTRATIVO_CUSTO_BENEFICIO

COMMENT ON COLUMN demonstrativo_custo_beneficio.dcb_centro_custo IS 'centro de custo do empregado'
/
COMMENT ON COLUMN demonstrativo_custo_beneficio.dcb_data_atualizacao IS 'data da última atualização'
/
COMMENT ON COLUMN demonstrativo_custo_beneficio.dcb_emp_numero_matricula IS 'matrícula do empregado'
/

-- End of DDL Script for Table IFRSRH.DEMONSTRATIVO_CUSTO_BENEFICIO

-- Start of DDL Script for Table IFRSRH.DEP_CONTROLE_ARQ_FREQ
-- Generated 9-mar-2004 18:46:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dep_controle_arq_freq
    (dep_codigo_resp_envio          NUMBER(4) NOT NULL,
    dep_codigo_arq_freq            NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for DEP_CONTROLE_ARQ_FREQ

COMMENT ON TABLE dep_controle_arq_freq IS 'Tabela para controle dos arquivos da freqüência'
/
COMMENT ON COLUMN dep_controle_arq_freq.dep_codigo_arq_freq IS 'Codigo da dependência que o arquivo de frequência se refere.'
/
COMMENT ON COLUMN dep_controle_arq_freq.dep_codigo_resp_envio IS 'Codigo da dependência responsavel pelo envio do arquivo da dependencia.'
/

-- End of DDL Script for Table IFRSRH.DEP_CONTROLE_ARQ_FREQ

-- Start of DDL Script for Table IFRSRH.DEPENDENTES_USU_PLANO_SAUDE
-- Generated 9-mar-2004 18:46:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE dependentes_usu_plano_saude
    (dus_cre_sequencial             NUMBER(5) NOT NULL,
    dus_emp_numero_matricula       NUMBER(7) NOT NULL,
    dus_ups_cod_usuario            NUMBER(8) NOT NULL,
    dus_cod_dependente             NUMBER(8) NOT NULL,
    dus_pvi_sequencial             NUMBER(2),
    dus_data_inicio                DATE NOT NULL,
    dus_data_termino               DATE,
    dus_ups_data_inicio            DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DEPENDENTES_USU_PLANO_SAUDE

ALTER TABLE dependentes_usu_plano_saude
ADD CONSTRAINT dus_pk PRIMARY KEY (dus_cre_sequencial, dus_emp_numero_matricula, 
  dus_ups_cod_usuario, dus_ups_data_inicio, dus_cod_dependente, dus_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for DEPENDENTES_USU_PLANO_SAUDE

COMMENT ON COLUMN dependentes_usu_plano_saude.dus_cod_dependente IS 'CÓDIGO IDENTIFICADOR DO DEPENDENTE USUÁRIO DO PLANO DE SAÚDE CHAVE TABELA USUARIOS_PLANOS_SAUDE'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_cre_sequencial IS 'CÓDIGO IDENTIFICADOR DO CREDENCIADOS CHAVE TABELA CREDENCIADOS'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_data_inicio IS 'DATA DA CRIAÇÃO DO REGISTRO. INÍCIO DO BENEFÍCIO UTILIZAÇÃO DO PLANO DE SAÚDE'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_data_termino IS 'DATA TÉRMINO DO BENEFÍCIO UTILIZAÇÃO DO PLANO DE SAÚDE'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_emp_numero_matricula IS 'MATRÍCULA ATRIBUÍDA AO EMPREGADO CHAVE TABELA CADASTROS'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_pvi_sequencial IS 'CÓDIGO IDENTIFICADOR DO TIPO DE VÍNCULO DO DEPENDENTE CHAVE TABELA PESSOAS_VINCULADAS'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_ups_cod_usuario IS 'CÓDIGO IDENTIFICADOR DO USUÁRIO TITULAR DO PLANO DE SAÚDE CHAVE TABELA USUARIOS_PLANOS_SAUDE'
/
COMMENT ON COLUMN dependentes_usu_plano_saude.dus_ups_data_inicio IS 'DATA DA CRIAÇÃO DO REGISTRO. INÍCIO DO BENEFÍCIO UTILIZAÇÃO DO PLANO DE SAÚDE'
/

-- End of DDL Script for Table IFRSRH.DEPENDENTES_USU_PLANO_SAUDE

-- Start of DDL Script for Table IFRSRH.DESPESAS_MEDICAS_HOSPITALARES
-- Generated 9-mar-2004 18:46:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE despesas_medicas_hospitalares
    (dmp_sequencial                 NUMBER(7) NOT NULL,
    dmp_gui_numero                 NUMBER(6) NOT NULL,
    dmp_gui_doc_numero             NUMBER(10) NOT NULL,
    dmp_gui_doc_cbe_ben_sigla      VARCHAR2(3) NOT NULL,
    dmp_gui_doc_cbe_cre_sequencial NUMBER(5) NOT NULL,
    dmp_vau_enq_numero             NUMBER(7),
    dmp_descricao                  VARCHAR2(250),
    dmp_valor_informado            NUMBER(12,2) NOT NULL,
    dmp_valor_glosa                NUMBER(12,2),
    dmp_valor_calculado            NUMBER(12,2),
    dmp_valor_participacao         NUMBER(12,2),
    dmp_valor_taxa                 NUMBER(12,2),
    dmp_mov_participacao           VARCHAR2(1),
    dmp_gui_doc_dep_codigo         NUMBER(4) NOT NULL,
    dmp_valor_excede               NUMBER(12,2),
    dmp_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DESPESAS_MEDICAS_HOSPITALARES

CREATE INDEX dmp_gui_fk ON despesas_medicas_hospitalares
  (
    dmp_gui_doc_numero              ASC,
    dmp_gui_doc_cbe_ben_sigla       ASC,
    dmp_gui_doc_cbe_cre_sequencial  ASC,
    dmp_gui_doc_dep_codigo          ASC,
    dmp_gui_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for DESPESAS_MEDICAS_HOSPITALARES

ALTER TABLE despesas_medicas_hospitalares
ADD CONSTRAINT dmp_pk PRIMARY KEY (dmp_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE despesas_medicas_hospitalares
ADD CONSTRAINT dmp_status_internacao_ck CHECK (dmp_status_internacao in('S','N'))
/

-- Comments for DESPESAS_MEDICAS_HOSPITALARES

COMMENT ON COLUMN despesas_medicas_hospitalares.dmp_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/
COMMENT ON COLUMN despesas_medicas_hospitalares.dmp_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.DESPESAS_MEDICAS_HOSPITALARES

-- Start of DDL Script for Table IFRSRH.DIVERSOS_MEDICAS_HOSPIT
-- Generated 9-mar-2004 18:47:11 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE diversos_medicas_hospit
    (dmo_sequencial                 NUMBER(7) NOT NULL,
    dmo_gui_numero                 NUMBER(6) NOT NULL,
    dmo_gui_doc_numero             NUMBER(10) NOT NULL,
    dmo_gui_doc_cbe_ben_sigla      VARCHAR2(3) NOT NULL,
    dmo_gui_doc_cbe_cre_sequencial NUMBER(5) NOT NULL,
    dmo_descricao                  VARCHAR2(2000) NOT NULL,
    dmo_valor_informado            NUMBER(12,2) NOT NULL,
    dmo_autorizacao                VARCHAR2(1),
    dmo_aes_numero_documento       VARCHAR2(25),
    dmo_valor_participacao         NUMBER(12,2),
    dmo_mov_participacao           VARCHAR2(1),
    dmo_gui_doc_dep_codigo         NUMBER(4) NOT NULL,
    dmo_valor_excede               NUMBER(12,2),
    dmo_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DIVERSOS_MEDICAS_HOSPIT

CREATE INDEX dmo_gui_fk ON diversos_medicas_hospit
  (
    dmo_gui_doc_numero              ASC,
    dmo_gui_doc_cbe_ben_sigla       ASC,
    dmo_gui_doc_cbe_cre_sequencial  ASC,
    dmo_gui_doc_dep_codigo          ASC,
    dmo_gui_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for DIVERSOS_MEDICAS_HOSPIT

ALTER TABLE diversos_medicas_hospit
ADD CONSTRAINT dmo_pk PRIMARY KEY (dmo_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE diversos_medicas_hospit
ADD CONSTRAINT dmo_status_internacao_ck CHECK (dmo_status_internacao in('S','N'))
/

-- Comments for DIVERSOS_MEDICAS_HOSPIT

COMMENT ON COLUMN diversos_medicas_hospit.dmo_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/
COMMENT ON COLUMN diversos_medicas_hospit.dmo_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.DIVERSOS_MEDICAS_HOSPIT

-- Start of DDL Script for Table IFRSRH.DOCUMENTACAO_CONTRATUAL
-- Generated 9-mar-2004 18:47:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE documentacao_contratual
    (dcn_cre_sequencial             NUMBER(5) NOT NULL,
    dcn_nome_documento             VARCHAR2(300),
    dcn_data_validade              DATE,
    dcn_data_sicaf                 DATE,
    dcn_sequencial                 NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DOCUMENTACAO_CONTRATUAL

ALTER TABLE documentacao_contratual
ADD CONSTRAINT dcn_pk PRIMARY KEY (dcn_cre_sequencial, dcn_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.DOCUMENTACAO_CONTRATUAL

-- Start of DDL Script for Table IFRSRH.DOCUMENTACAO_SINISTRO
-- Generated 9-mar-2004 18:47:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE documentacao_sinistro
    (dos_codigo_doc                 NUMBER(3) NOT NULL,
    dos_descricao                  VARCHAR2(300))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for DOCUMENTACAO_SINISTRO

ALTER TABLE documentacao_sinistro
ADD CONSTRAINT doc_sinistro_pk PRIMARY KEY (dos_codigo_doc)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for DOCUMENTACAO_SINISTRO

COMMENT ON COLUMN documentacao_sinistro.dos_codigo_doc IS 'código que identifica a documentação do sinistro'
/
COMMENT ON COLUMN documentacao_sinistro.dos_descricao IS 'descrição da documentação necessária para o processo de sinistro'
/

-- End of DDL Script for Table IFRSRH.DOCUMENTACAO_SINISTRO

-- Start of DDL Script for Table IFRSRH.DOCUMENTOS_COBRANCA
-- Generated 9-mar-2004 18:47:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE documentos_cobranca
    (doc_numero                     NUMBER(10) NOT NULL,
    doc_cbe_ben_sigla              VARCHAR2(3) NOT NULL,
    doc_cbe_cre_sequencial         NUMBER(5) NOT NULL,
    doc_data                       DATE,
    doc_data_pagamento             DATE,
    doc_valor                      NUMBER(12,2),
    doc_tipo                       NUMBER(1),
    doc_deducao                    NUMBER(12,2),
    doc_especificacao              VARCHAR2(2000),
    doc_modalidade                 NUMBER(1),
    doc_emb_emp_numero_matricula   NUMBER(7),
    doc_pvi_sequencial             NUMBER(2),
    doc_cct_codigo                 NUMBER(10),
    doc_dep_codigo                 NUMBER(4) NOT NULL,
    doc_emb_ben_sigla              VARCHAR2(3),
    doc_tot_faturamento            NUMBER(12,2),
    doc_tot_glosa                  NUMBER(12,2),
    doc_tot_irrf                   NUMBER(12,2),
    doc_tot_iss                    NUMBER(12,2),
    doc_especificacao_deducao      VARCHAR2(2000),
    doc_valor_liquido              NUMBER(12,2),
    doc_valor_participacao         NUMBER(12,2),
    doc_mes_pagamento              NUMBER(2),
    doc_ano_pagamento              NUMBER(4),
    doc_valor_diferenca            NUMBER(12,2),
    doc_valor_autorizado           NUMBER(12,2),
    doc_especificacao_diferenca    VARCHAR2(2000),
    doc_mes_vale                   VARCHAR2(2),
    doc_ano_vale                   VARCHAR2(4),
    doc_valor_taxa                 NUMBER(12,2),
    doc_processo_encerrado         VARCHAR2(1),
    doc_guias_emp                  NUMBER(8),
    doc_capital_seguro             NUMBER(12,2),
    doc_nr_doc_fiscal              VARCHAR2(15),
    doc_pvi_emp_numero_matricula   NUMBER(7),
    doc_dep_resp_incl              NUMBER(4) NOT NULL,
    doc_tipo_pedido                NUMBER(1),
    doc_ind_imposto                VARCHAR2(1),
    doc_numero_imp_acumul          NUMBER(10),
    doc_mov_participacao           VARCHAR2(1),
    doc_valor_inss                 NUMBER(12,2),
    doc_vl_base_inss               NUMBER(12,2),
    doc_qtd_depend_irrf            NUMBER(2),
    doc_valor_desc_irrf            NUMBER(12,2),
    doc_valor_ajuste               NUMBER(12,2),
    doc_data_criacao               DATE,
    doc_data_geracao_participacao  DATE,
    doc_interface_ps_mes           NUMBER(2),
    doc_interface_ps_ano           NUMBER(4),
    doc_interface_ps_seq           NUMBER(10),
    doc_inss_autonomo              NUMBER(16,2),
    doc_data_inss_autonomo         DATE,
    data_processo_encerrado        DATE,
    doc_valor_irmp153              NUMBER(12,2),
    doc_valor_csll                 NUMBER(12,2),
    doc_valor_pispasep             NUMBER(12,2),
    doc_valor_cofins               NUMBER(12,2),
    doc_ri_cod_receita             NUMBER(4),
    doc_ri_dat_inicio              DATE,
    doc_tipo_servico               NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for DOCUMENTOS_COBRANCA

CREATE INDEX idx_doc_cbe ON documentos_cobranca
  (
    doc_cbe_ben_sigla               ASC,
    doc_cbe_cre_sequencial          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_doc_emb ON documentos_cobranca
  (
    doc_emb_emp_numero_matricula    ASC,
    doc_cbe_ben_sigla               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_doc_pvb ON documentos_cobranca
  (
    doc_pvi_emp_numero_matricula    ASC,
    doc_pvi_sequencial              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for DOCUMENTOS_COBRANCA

ALTER TABLE documentos_cobranca
ADD CONSTRAINT doc2_pk PRIMARY KEY (doc_numero, doc_cbe_ben_sigla, 
  doc_cbe_cre_sequencial, doc_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doccob_ck_1 CHECK (DOC_TIPO IN (1,2,3,4,5,6))
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doccob_ck_2 CHECK (  DOC_MODALIDADE IN (1,2)                                                         )
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doccob_doc_tipo_servico_ck CHECK (DOC_TIPO_SERVICO IN (1,2,3,4,5))
/

-- Triggers for DOCUMENTOS_COBRANCA

CREATE TRIGGER log_audit_documentos_cobranca
AFTER INSERT  OR UPDATE OF 
  doc_ano_pagamento,
  doc_cbe_ben_sigla,
  doc_cbe_cre_sequencial,
  doc_data,
  doc_data_criacao,
  doc_data_geracao_participacao,
  doc_dep_codigo,
  doc_dep_resp_incl,
  doc_emb_emp_numero_matricula,
  doc_mes_pagamento,
  doc_nr_doc_fiscal,
  doc_numero,
  doc_processo_encerrado,
  doc_pvi_sequencial,
  doc_tipo,
  doc_tipo_pedido,
  doc_valor_participacao
 OR  DELETE 
ON documentos_cobranca
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin

  if inserting then

      insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
      (COD_USUARIO,
       DTA_OPERACAO,
       TIP_OPERACAO,
       DOC_NUMERO_NEW,
       DOC_CBE_BEN_SIGLA_NEW,
       DOC_CBE_CRE_SEQUENCIAL_NEW,
       DOC_DATA_NEW,
       DOC_TIPO_NEW,
       DOC_NUMERO_MATRICULA_NEW,
       DOC_PVI_SEQUENCIAL_NEW,
       DOC_DEP_CODIGO_NEW,
       DOC_VALOR_PARTICIPACAO_NEW,
       DOC_MES_PAGAMENTO_NEW,
       DOC_ANO_PAGAMENTO_NEW,
       DOC_PROCESSO_ENCERRADO_NEW,
       DOC_NR_DOC_FISCAL_NEW,
       DOC_DEP_RESP_INCL_NEW,
       DOC_TIPO_PEDIDO_NEW,
       DOC_DATA_CRIACAO_NEW,
       DOC_DATA_GERA_PARTICIPACAO_NEW)
       values  (user,
              to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
              'I',
              :NEW.DOC_NUMERO,
              :NEW.DOC_CBE_BEN_SIGLA,
              :NEW.DOC_CBE_CRE_SEQUENCIAL,
              :NEW.DOC_DATA,
              :NEW.DOC_TIPO,
              :NEW.DOC_EMB_EMP_NUMERO_MATRICULA,
              :NEW.DOC_PVI_SEQUENCIAL,
              :NEW.DOC_DEP_CODIGO,
              :NEW.DOC_VALOR_PARTICIPACAO,
              :NEW.DOC_MES_PAGAMENTO,
              :NEW.DOC_ANO_PAGAMENTO,
              :NEW.DOC_PROCESSO_ENCERRADO,
              :NEW.DOC_NR_DOC_FISCAL,
              :NEW.DOC_DEP_RESP_INCL,
              :NEW.DOC_TIPO_PEDIDO,
              :NEW.DOC_DATA_CRIACAO,
              :NEW.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;

  if deleting then

      insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
      (COD_USUARIO,
       DTA_OPERACAO,
       TIP_OPERACAO,
       DOC_NUMERO_OLD,
       DOC_CBE_BEN_SIGLA_OLD,
       DOC_CBE_CRE_SEQUENCIAL_OLD,
       DOC_DATA_OLD,
       DOC_TIPO_OLD,
       DOC_NUMERO_MATRICULA_OLD,
       DOC_PVI_SEQUENCIAL_OLD,
       DOC_DEP_CODIGO_OLD,
       DOC_VALOR_PARTICIPACAO_OLD,
       DOC_MES_PAGAMENTO_OLD,
       DOC_ANO_PAGAMENTO_OLD,
       DOC_PROCESSO_ENCERRADO_OLD,
       DOC_NR_DOC_FISCAL_OLD,
       DOC_DEP_RESP_INCL_OLD,
       DOC_TIPO_PEDIDO_OLD,
       DOC_DATA_CRIACAO_OLD,
       DOC_DTA_GERA_PARTICIPACAO_OLD)
       values  (user,
                to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
               'D',
               :OLD.DOC_NUMERO,
               :OLD.DOC_CBE_BEN_SIGLA,
               :OLD.DOC_CBE_CRE_SEQUENCIAL,
               :OLD.DOC_DATA,
               :OLD.DOC_TIPO,
               :OLD.DOC_EMB_EMP_NUMERO_MATRICULA,
               :OLD.DOC_PVI_SEQUENCIAL,
               :OLD.DOC_DEP_CODIGO,
               :OLD.DOC_VALOR_PARTICIPACAO,
               :OLD.DOC_MES_PAGAMENTO,
               :OLD.DOC_ANO_PAGAMENTO,
               :OLD.DOC_PROCESSO_ENCERRADO,
               :OLD.DOC_NR_DOC_FISCAL,
               :OLD.DOC_DEP_RESP_INCL,
               :OLD.DOC_TIPO_PEDIDO,
               :OLD.DOC_DATA_CRIACAO,
               :OLD.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;

  if updating then

     insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
     (COD_USUARIO,
      DTA_OPERACAO,
      TIP_OPERACAO,
      DOC_NUMERO_NEW,
      DOC_CBE_BEN_SIGLA_NEW,
      DOC_CBE_CRE_SEQUENCIAL_NEW,
      DOC_DATA_NEW,
      DOC_TIPO_NEW,
      DOC_NUMERO_MATRICULA_NEW,
      DOC_PVI_SEQUENCIAL_NEW,
      DOC_DEP_CODIGO_NEW,
      DOC_VALOR_PARTICIPACAO_NEW,
      DOC_MES_PAGAMENTO_NEW,
      DOC_ANO_PAGAMENTO_NEW,
      DOC_PROCESSO_ENCERRADO_NEW,
      DOC_NR_DOC_FISCAL_NEW,
      DOC_DEP_RESP_INCL_NEW,
      DOC_TIPO_PEDIDO_NEW,
      DOC_DATA_CRIACAO_NEW,
      DOC_DATA_GERA_PARTICIPACAO_NEW,
      DOC_NUMERO_OLD,
      DOC_CBE_BEN_SIGLA_OLD,
      DOC_CBE_CRE_SEQUENCIAL_OLD,
      DOC_DATA_OLD,
      DOC_TIPO_OLD,
      DOC_NUMERO_MATRICULA_OLD,
      DOC_PVI_SEQUENCIAL_OLD,
      DOC_DEP_CODIGO_OLD,
      DOC_VALOR_PARTICIPACAO_OLD,
      DOC_MES_PAGAMENTO_OLD,
      DOC_ANO_PAGAMENTO_OLD,
      DOC_PROCESSO_ENCERRADO_OLD,
      DOC_NR_DOC_FISCAL_OLD,
      DOC_DEP_RESP_INCL_OLD,
      DOC_TIPO_PEDIDO_OLD,
      DOC_DATA_CRIACAO_OLD,
      DOC_DTA_GERA_PARTICIPACAO_OLD)
      values  (user,
              to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
              'U',
              :OLD.DOC_NUMERO,
              :OLD.DOC_CBE_BEN_SIGLA,
              :OLD.DOC_CBE_CRE_SEQUENCIAL,
              :NEW.DOC_DATA,
              :NEW.DOC_TIPO,
              :NEW.DOC_EMB_EMP_NUMERO_MATRICULA,
              :NEW.DOC_PVI_SEQUENCIAL,
              :OLD.DOC_DEP_CODIGO,
              :NEW.DOC_VALOR_PARTICIPACAO,
              :NEW.DOC_MES_PAGAMENTO,
              :NEW.DOC_ANO_PAGAMENTO,
              :NEW.DOC_PROCESSO_ENCERRADO,
              :NEW.DOC_NR_DOC_FISCAL,
              :NEW.DOC_DEP_RESP_INCL,
              :NEW.DOC_TIPO_PEDIDO,
              :NEW.DOC_DATA_CRIACAO,
              :NEW.DOC_DATA_GERACAO_PARTICIPACAO,
              :OLD.DOC_NUMERO,
              :OLD.DOC_CBE_BEN_SIGLA,
              :OLD.DOC_CBE_CRE_SEQUENCIAL,
              :OLD.DOC_DATA,
              :OLD.DOC_TIPO,
              :OLD.DOC_EMB_EMP_NUMERO_MATRICULA,
              :OLD.DOC_PVI_SEQUENCIAL,
              :OLD.DOC_DEP_CODIGO,
              :OLD.DOC_VALOR_PARTICIPACAO,
              :OLD.DOC_MES_PAGAMENTO,
              :OLD.DOC_ANO_PAGAMENTO,
              :OLD.DOC_PROCESSO_ENCERRADO,
              :OLD.DOC_NR_DOC_FISCAL,
              :OLD.DOC_DEP_RESP_INCL,
              :OLD.DOC_TIPO_PEDIDO,
              :OLD.DOC_DATA_CRIACAO,
              :OLD.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;


end;
/

-- Comments for DOCUMENTOS_COBRANCA

COMMENT ON COLUMN documentos_cobranca.data_processo_encerrado IS 'data de encerramento do processo'
/
COMMENT ON COLUMN documentos_cobranca.doc_interface_ps_ano IS 'NÚMERO DO ANO de processamento do DOCUMENTO'
/
COMMENT ON COLUMN documentos_cobranca.doc_interface_ps_mes IS 'NÚMERO DO MÊS de processamento do DOCUMENTO'
/
COMMENT ON COLUMN documentos_cobranca.doc_interface_ps_seq IS 'NÚMERO DO SEQUENCIAL DO DOCUMENTO'
/
COMMENT ON COLUMN documentos_cobranca.doc_qtd_depend_irrf IS 'Quantidade de dependentes para dedução do imposto de renda'
/
COMMENT ON COLUMN documentos_cobranca.doc_ri_cod_receita IS 'Código da receita para os valores de acordo com a MP 153/2003'
/
COMMENT ON COLUMN documentos_cobranca.doc_ri_dat_inicio IS 'data inicial da vigência dos valores percentuais'
/
COMMENT ON COLUMN documentos_cobranca.doc_tipo_servico IS 'Tipo do enquadramento do servico: 1- outros serviços; 2-cooperados e associados; 3-subcontratado ou conveniado a coop ou asso; 4-coop ou asso sem descrição do serviço; 5: Serviço de nutrição, psicologia, fisioterapia e fonoaudiologia.'
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_ajuste IS 'Valor de ajuste do documento'
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_cofins IS 'valor da Contribuição para o financiamento da Seguridade Social'
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_csll IS 'valor da Contribuição Social sobre Lucro Líquido'
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_desc_irrf IS 'Valor da dedução dos dependentes para imposto de renda'
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_irmp153 IS 'valor do imposto de renda '
/
COMMENT ON COLUMN documentos_cobranca.doc_valor_pispasep IS 'valor do PIS/PASEP'
/

-- End of DDL Script for Table IFRSRH.DOCUMENTOS_COBRANCA

-- Start of DDL Script for Table IFRSRH.EFETIVO_INFRAERO
-- Generated 9-mar-2004 18:48:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE efetivo_infraero
    (ein_ano                        NUMBER(4) NOT NULL,
    ein_mes                        NUMBER(2) NOT NULL,
    ein_dep_codigo                 NUMBER(4) NOT NULL,
    ein_qtd_quadro                 NUMBER(4),
    ein_qtd_cedidos                NUMBER(4),
    ein_qtd_convenios              NUMBER(4),
    ein_qtd_requisitados           NUMBER(4),
    ein_qtd_contrato_suspenso      NUMBER(4),
    ein_qtd_ferias                 NUMBER(4),
    ein_qtd_licenca_gestante       NUMBER(4),
    ein_qtd_licenca_premio         NUMBER(4),
    ein_qtd_depv                   NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EFETIVO_INFRAERO

ALTER TABLE efetivo_infraero
ADD CONSTRAINT eib_pk PRIMARY KEY (ein_ano, ein_mes, ein_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EFETIVO_INFRAERO

COMMENT ON TABLE efetivo_infraero IS 'Tabela que contém o quantitativo de empregados em uma dependência num determinado mês/ano.'
/
COMMENT ON COLUMN efetivo_infraero.ein_ano IS 'Ano do efetivo.'
/
COMMENT ON COLUMN efetivo_infraero.ein_dep_codigo IS 'Código da dependência do efetivo.'
/
COMMENT ON COLUMN efetivo_infraero.ein_mes IS 'Mês do efetivo.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_cedidos IS 'Quantidade de empregados cedidos no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_contrato_suspenso IS 'Quantidade de empregados com o contrato suspenso no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_convenios IS 'Quantidade de empregados conveniados no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_depv IS 'Quantidade de empregados conveniados ao DEPV (Departamento de Proteção ao Vôo).'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_ferias IS 'Quantidade de empregados em férias no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_licenca_gestante IS 'Quantidade de empregados com licença gestante no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_licenca_premio IS 'Quantidade de empregados com licença prêmio no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_quadro IS 'Quantidade de empregados do quadro no mês.'
/
COMMENT ON COLUMN efetivo_infraero.ein_qtd_requisitados IS 'Quantidade de empregados requisitados no mês.'
/

-- End of DDL Script for Table IFRSRH.EFETIVO_INFRAERO

-- Start of DDL Script for Table IFRSRH.EMAIL_EMPREGADO
-- Generated 9-mar-2004 18:48:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE email_empregado
    (num_matricula                  NUMBER(7) NOT NULL,
    email                          VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMAIL_EMPREGADO

ALTER TABLE email_empregado
ADD CONSTRAINT email_empregado_pk PRIMARY KEY (num_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMAIL_EMPREGADO

-- Start of DDL Script for Table IFRSRH.EMISSAO_PROGRAMACOES_FERIAS
-- Generated 9-mar-2004 18:48:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emissao_programacoes_ferias
    (emp_numero_matricula           NUMBER(7),
    emp_numero_dias_direito_ferias NUMBER(2),
    emp_data_limite_gozo           DATE,
    emp_dt_usuario                 DATE,
    emp_id_usuario                 VARCHAR2(10),
    emp_inicio_periodo_aquisitivo  DATE,
    emp_termino_periodo_aquisitivo DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for EMISSAO_PROGRAMACOES_FERIAS

COMMENT ON COLUMN emissao_programacoes_ferias.emp_data_limite_gozo IS 'Máxima Data em que o empregado pode pegar ferias'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_dt_usuario IS 'Data em que foi feito o insere do registro'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_id_usuario IS 'Identificação do usuário que fez carga do registro'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_inicio_periodo_aquisitivo IS 'Data Inicio do Período Aquisitivo'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_numero_dias_direito_ferias IS 'Nro de dias de ferias que o empregado tem direito'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_numero_matricula IS 'Nro de Matricula do Empregado'
/
COMMENT ON COLUMN emissao_programacoes_ferias.emp_termino_periodo_aquisitivo IS 'Data Término do Período Aquisitivo'
/

-- End of DDL Script for Table IFRSRH.EMISSAO_PROGRAMACOES_FERIAS

-- Start of DDL Script for Table IFRSRH.EMISSOES_CARTEIRAS
-- Generated 9-mar-2004 18:48:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emissoes_carteiras
    (eca_sequencial                 NUMBER(2) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    emp_nome                       VARCHAR2(50),
    emp_data_nascimento            DATE,
    pvi_nome                       VARCHAR2(50),
    pvi_sequencial                 NUMBER(2),
    pvi_data_nascimento            DATE,
    dep_sigla                      VARCHAR2(10),
    uor_sigla                      VARCHAR2(10),
    usertemp                       VARCHAR2(30),
    sessiontemp                    NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMISSOES_CARTEIRAS

ALTER TABLE emissoes_carteiras
ADD CONSTRAINT eca_pk PRIMARY KEY (eca_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMISSOES_CARTEIRAS

-- Start of DDL Script for Table IFRSRH.EMP_ARSA
-- Generated 9-mar-2004 18:48:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emp_arsa
    (emp_cpf                        NUMBER(11),
    emp_nome                       VARCHAR2(60),
    emp_numero_matricula_arsa      NUMBER(7),
    emp_sexo                       VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMP_ARSA

-- Start of DDL Script for Table IFRSRH.EMP_CCT
-- Generated 9-mar-2004 18:48:36 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emp_cct
    (emp_matricula                  NUMBER(9),
    emp_centro_custo               NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMP_CCT

-- Start of DDL Script for Table IFRSRH.EMP_CONVERSAO2
-- Generated 9-mar-2004 18:48:37 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emp_conversao2
    (emp_numero_cpf                 NUMBER(11),
    emp_numero_matricula           NUMBER(7),
    emp_numero_matricula_ant       NUMBER(7),
    emp_numero_matricula_tasa      NUMBER(7),
    emp_numero_matricula_arsa      NUMBER(7),
    emp_numero_fre                 NUMBER(18),
    emp_nome                       VARCHAR2(60),
    emp_nome_abreviado             VARCHAR2(40),
    emp_indicador_sexo             VARCHAR2(1),
    emp_data_nascimento            DATE,
    emp_indicador_estado_civil     NUMBER(1),
    emp_nacionalidade              NUMBER(1),
    emp_endereco_logradouro        VARCHAR2(50),
    emp_endereco_numero_cep        NUMBER(8),
    emp_ramal_residencia           NUMBER(4),
    emp_endereco_bairro            VARCHAR2(30),
    emp_endereco_fone              NUMBER(8),
    emp_numero_celular             NUMBER(8),
    emp_ddd_residencia             NUMBER(4),
    emp_ddd_celular                NUMBER(4),
    emp_jtr_codigo                 NUMBER(1),
    emp_aba_ban_codigo_cta_pgto    VARCHAR2(3),
    emp_aba_codigo_conta_pgto      VARCHAR2(7),
    emp_nu_conta_corrente_pagto    VARCHAR2(9),
    emp_eso_codigo                 NUMBER(2),
    emp_sfu_codigo                 NUMBER(1),
    emp_htd_dep_codigo             NUMBER(4),
    emp_htd_htr_codigo             NUMBER(2),
    emp_htd_sequencial             NUMBER(2),
    emp_data_chegada_brasil        DATE,
    emp_nu_registro_estrangeiro    VARCHAR2(10),
    emp_in_classe_registro_estrang NUMBER(1),
    emp_data_registro_estrangeiro  DATE,
    emp_cidade_nasc_estrangeiro    VARCHAR2(50),
    emp_cidade_natural_estrang     VARCHAR2(30),
    emp_ufe_sigla_estrangeiro      VARCHAR2(2),
    emp_decreto_naturalizacao      VARCHAR2(240),
    emp_data_validade_rne          DATE,
    emp_numero_ctps_rne            NUMBER(9),
    emp_nu_serie_ctps_rne          NUMBER(5),
    emp_data_expedicao_ctps_rne    DATE,
    emp_data_validade_ctps_rne     DATE,
    emp_mun_codigo_natural         NUMBER(5),
    emp_ufe_sigla_natural          VARCHAR2(2),
    emp_mun_codigo_reside          NUMBER(5),
    emp_ufe_sigla_residente        VARCHAR2(2),
    emp_data_naturalizacao         DATE,
    emp_numero_pis_pasep           NUMBER(11),
    emp_data_pis_pasep             DATE,
    emp_nu_carteira_identidade     VARCHAR2(15),
    emp_sigla_orgao_emitente_ci    VARCHAR2(10),
    emp_data_expedicao_ci          DATE,
    emp_ufe_sigla_ci               VARCHAR2(2),
    emp_nu_titulo_eleitor          NUMBER(12),
    emp_nu_zona_titulo_eleitor     VARCHAR2(5),
    emp_nu_secao_titulo_eleitor    VARCHAR2(5),
    emp_ufe_sigla_tit_eleitor      VARCHAR2(2),
    emp_nu_certificado_reservista  VARCHAR2(12),
    emp_nu_categoria_cr            VARCHAR2(10),
    emp_nu_regiao_militar_cr       VARCHAR2(10),
    emp_tipo_cr                    VARCHAR2(3),
    emp_ano_emissao_cr             NUMBER(4),
    emp_nu_livro_certidao_casam    VARCHAR2(10),
    emp_nu_folha_certidao_casam    VARCHAR2(6),
    emp_data_casamento             DATE,
    emp_numero_carteira_trabalho   NUMBER(9),
    emp_numero_serie_carteira_trab NUMBER(5),
    emp_dt_expedicao_carteira_trab DATE,
    emp_ufe_sigla_ctps             VARCHAR2(2),
    emp_data_opcao_fgts            DATE,
    emp_codigo_fgts                NUMBER(10),
    emp_numero_conta_fgts          NUMBER(8),
    emp_aba_ban_codigo_fgts        VARCHAR2(3),
    emp_aba_codigo_fgts            VARCHAR2(7),
    emp_nu_carteira_habilitacao    VARCHAR2(10),
    emp_in_categoria_habilitacao   VARCHAR2(2),
    emp_dt_validade_carteira_hab   DATE,
    emp_nu_habilitacao_lancha      NUMBER(10),
    emp_indicador_categoria_hab    VARCHAR2(1),
    emp_dt_validade_habilit_lancha DATE,
    emp_nu_carteira_orgao_classe   VARCHAR2(11),
    emp_ufe_sigla_reg_profis       VARCHAR2(2),
    emp_pai_codigo                 NUMBER(4),
    emp_oex_codigo_cedido          NUMBER(5),
    emp_oex_codigo_requisitado     NUMBER(5),
    emp_qlp_hcl_uor_codigo         NUMBER(9),
    emp_qlp_hcl_data_vigencia      DATE,
    emp_qlp_car_codigo             NUMBER(3),
    emp_qlp_car_codigo_nivel       NUMBER(1),
    emp_qlp_car_occ_codigo         NUMBER(3),
    emp_nsa_codigo_nivel           NUMBER(2),
    emp_nsa_codigo_padrao          VARCHAR2(4),
    emp_nsa_in_nivel_escolaridade  VARCHAR2(1),
    emp_qfu_fun_codigo             NUMBER(3),
    emp_qfu_hfl_uor_codigo         NUMBER(9),
    emp_qfu_hfl_data_vigencia      DATE,
    emp_tipo_remuneracao_funcao    VARCHAR2(2),
    emp_qfu_fun_codigo_acumula     NUMBER(3),
    emp_qfu_hfl_uor_cod_acum       NUMBER(9),
    emp_qfu_hfl_data_vigen_acum    DATE,
    emp_tipo_remuner_funcao_acumul VARCHAR2(2),
    emp_qfu_fun_codigo_substitui   NUMBER(3),
    emp_qfu_hfl_uor_cod_subst      NUMBER(9),
    emp_qfu_hfl_data_vigen_subst   DATE,
    emp_tipo_remuner_funcao_subst  VARCHAR2(2),
    emp_ocl_sigla                  VARCHAR2(6),
    emp_emp_nu_matricula_casado    NUMBER(7),
    emp_dep_codigo_lotacao         NUMBER(4),
    emp_dep_codigo_pagto           NUMBER(4),
    emp_dep_codigo_fisico          NUMBER(4),
    emp_uor_codigo_lotacao         NUMBER(9),
    emp_indicador_primeiro_emprego VARCHAR2(1),
    emp_ano_primeiro_emprego       NUMBER(4),
    emp_ufe_sigla_primeiro_emprego VARCHAR2(2),
    emp_status                     NUMBER(2),
    emp_codigo_rais                VARCHAR2(8),
    emp_tipo_conta                 VARCHAR2(2),
    emp_classe_hab_tecnologica     VARCHAR2(10),
    emp_numero_hab_tecnologica     VARCHAR2(10),
    emp_data_hab_tecnologica       DATE,
    emp_habilit_orgao_oper         NUMBER(5),
    emp_data_capacitacao_fisica    DATE,
    emp_indicador_depv             VARCHAR2(4),
    emp_numero_depv                NUMBER(5),
    emp_licenca_depv               NUMBER(5),
    emp_situacao_militar           NUMBER(1),
    emp_posto_graduacao_codigo     NUMBER(2),
    emp_quadro_arma_esp_codigo     NUMBER(2),
    emp_forca_armada_codigo        NUMBER(2),
    emp_data_admissao              DATE,
    emp_ati_ct_custos              NUMBER(10),
    emp_nome_pai                   VARCHAR2(50),
    emp_nome_mae                   VARCHAR2(50),
    emp_id_aposentadoria           NUMBER(1),
    emp_dt_aposentadoria           DATE,
    emp_dt_reserva_militar         DATE,
    emp_plano_arsaprev             NUMBER(1),
    emp_data_filiacao_arsaprev     DATE,
    emp_data_cancelamento_arsaprev DATE,
    emp_contrib_sindical_anual     VARCHAR2(1),
    emp_contrib_federativa         VARCHAR2(1),
    emp_adianta_13                 VARCHAR2(1),
    emp_cor_raca                   NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMP_CONVERSAO2

-- Start of DDL Script for Table IFRSRH.EMP_COR_RACA
-- Generated 9-mar-2004 18:48:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emp_cor_raca
    (emp_numero_matricula           NUMBER(7),
    emp_cor_raca                   NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMP_COR_RACA

-- Start of DDL Script for Table IFRSRH.EMP_QUALIFICACAO_ACADEMICA
-- Generated 9-mar-2004 18:48:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emp_qualificacao_academica
    (eqa_cod_matricula              NUMBER(7) NOT NULL,
    eqa_qua_cod_qualif_academica   NUMBER(4) NOT NULL,
    eqa_data_inicio                DATE NOT NULL,
    eqa_data_termino               DATE NOT NULL,
    eqa_descr_especializacao       VARCHAR2(1000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMP_QUALIFICACAO_ACADEMICA

ALTER TABLE emp_qualificacao_academica
ADD CONSTRAINT eqa_pk PRIMARY KEY (eqa_cod_matricula, 
  eqa_qua_cod_qualif_academica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMP_QUALIFICACAO_ACADEMICA

-- Start of DDL Script for Table IFRSRH.EMPREGADO_FONE_COMERCIAL
-- Generated 9-mar-2004 18:48:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregado_fone_comercial
    (efc_emp_numero_matricula       NUMBER(7) NOT NULL,
    efc_uff_tipo                   NUMBER(1) NOT NULL,
    efc_uff_numero                 NUMBER(8) NOT NULL,
    efc_uff_voip_ddd               NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADO_FONE_COMERCIAL

ALTER TABLE empregado_fone_comercial
ADD CONSTRAINT efc_ck CHECK ( efc_uff_tipo in (1,2,3) )
/
ALTER TABLE empregado_fone_comercial
ADD CONSTRAINT efc_pk PRIMARY KEY (efc_emp_numero_matricula, efc_uff_tipo, 
  efc_uff_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EMPREGADO_FONE_COMERCIAL

COMMENT ON COLUMN empregado_fone_comercial.efc_emp_numero_matricula IS 'Número da matrícula do empregado.'
/
COMMENT ON COLUMN empregado_fone_comercial.efc_uff_numero IS 'Número do fone FAX do empregado.'
/
COMMENT ON COLUMN empregado_fone_comercial.efc_uff_tipo IS 'Tipo do Fax. (1 - Fone Direto, 2 - Fone Ramal ou 3 - FAX do empregado.'
/
COMMENT ON COLUMN empregado_fone_comercial.efc_uff_voip_ddd IS 'Número do DDD do fone FAX do empregado.'
/

-- End of DDL Script for Table IFRSRH.EMPREGADO_FONE_COMERCIAL

-- Start of DDL Script for Table IFRSRH.EMPREGADO_OCORRENCIA_INSS
-- Generated 9-mar-2004 18:49:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregado_ocorrencia_inss
    (eoi_emp_numero_matricula       NUMBER(7) NOT NULL,
    eoi_oia_agn_codigo             NUMBER(2) NOT NULL,
    eoi_oia_oin_codigo_padrao_nac  NUMBER(2) NOT NULL,
    eoi_data_inicio                DATE NOT NULL,
    eoi_data_inclusao              DATE NOT NULL,
    eoi_data_termino               DATE,
    eoi_observacao                 VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADO_OCORRENCIA_INSS

ALTER TABLE empregado_ocorrencia_inss
ADD CONSTRAINT eoi_pk PRIMARY KEY (eoi_emp_numero_matricula, eoi_oia_agn_codigo, 
  eoi_oia_oin_codigo_padrao_nac, eoi_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPREGADO_OCORRENCIA_INSS

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_ATUACAO_CARGO
-- Generated 9-mar-2004 18:49:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_atuacao_cargo
    (eac_emp_numero_matricula       NUMBER(7) NOT NULL,
    eac_aac_atu_codigo             NUMBER(3) NOT NULL,
    eac_aac_car_codigo             NUMBER(3) NOT NULL,
    eac_aac_car_codigo_nivel       NUMBER(1) NOT NULL,
    eac_aac_car_occ_codigo         NUMBER(3) NOT NULL,
    eac_data_mudanca               DATE NOT NULL,
    eac_documento_legal            VARCHAR2(30) NOT NULL,
    eac_observacao                 VARCHAR2(200) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADOS_ATUACAO_CARGO

ALTER TABLE empregados_atuacao_cargo
ADD CONSTRAINT eac_pk PRIMARY KEY (eac_emp_numero_matricula, eac_aac_atu_codigo, 
  eac_aac_car_codigo, eac_aac_car_codigo_nivel, eac_aac_car_occ_codigo, 
  eac_data_mudanca)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_ATUACAO_CARGO

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_BENEFICIOS
-- Generated 9-mar-2004 18:49:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_beneficios
    (emb_ben_sigla                  VARCHAR2(3) NOT NULL,
    emb_emp_numero_matricula       NUMBER(7) NOT NULL,
    emb_validade                   DATE,
    emb_opcao                      VARCHAR2(1),
    tipo                           NUMBER(1),
    data_adesao                    DATE,
    emb_data_exclusao              DATE,
    emb_dep_resp_incl              NUMBER(4) NOT NULL,
    emb_oper_ans                   NUMBER(1),
    emb_opcao_alim                 VARCHAR2(1),
    emb_opcao_ref                  VARCHAR2(1),
    emb_qtd_alim                   NUMBER(4),
    emb_qtd_ref                    NUMBER(4),
    emb_opcao_extra                VARCHAR2(1),
    emb_opcao_bonus                VARCHAR2(1),
    emb_opcao_cba                  VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EMPREGADOS_BENEFICIOS

CREATE INDEX emb_uk1 ON empregados_beneficios
  (
    emb_ben_sigla                   ASC,
    emb_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_emb_emp_fk ON empregados_beneficios
  (
    emb_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_emb_ben_fk ON empregados_beneficios
  (
    emb_ben_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_emb_dep_fk ON empregados_beneficios
  (
    emb_dep_resp_incl               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for EMPREGADOS_BENEFICIOS

ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_opcao_alim_ck CHECK (EMB_OPCAO_ALIM IN ('S','N'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_opcao_bonus_ck CHECK (EMB_OPCAO_BONUS IN ('A','R'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_opcao_cba_ck CHECK ( EMB_OPCAO_CBA  in('A','R'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_opcao_extra_ck CHECK (EMB_OPCAO_EXTRA IN ('A','R'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_opcao_ref_ck CHECK (EMB_OPCAO_REF IN ('S','N'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_pk PRIMARY KEY (emb_emp_numero_matricula, emb_ben_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emp_beneficios_chk_emb_opcao CHECK (EMB_OPCAO IN ('1','2'))
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT tipo_ck CHECK (  tipo IN ( 1 , 2 , 3 )                                                           )
/

-- Triggers for EMPREGADOS_BENEFICIOS

CREATE TRIGGER trg_log_empregados_beneficios
BEFORE UPDATE  OR  DELETE 
ON empregados_beneficios
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_EMPREGADOS_BENEFICIOS
             (EMB_BEN_SIGLA,
              EMB_EMP_NUMERO_MATRICULA,
              EMB_VALIDADE,
              EMB_OPCAO,
              TIPO,
              DATA_ADESAO,
              EMB_DATA_EXCLUSAO,
              EMB_DEP_RESP_INCL,
              EMB_OPER_ANS,
              EMB_OPCAO_ALIM,
              EMB_OPCAO_REF,
              EMB_QTD_ALIM,
              EMB_QTD_REF,
              EMB_OPCAO_EXTRA,
              EMB_OPCAO_BONUS,
              EMB_OPCAO_CBA,
              DTA_OPERACAO,
              TIP_OPERACAO,
              COD_USUARIO)
             VALUES
             (
              :OLD.EMB_BEN_SIGLA,
              :OLD.EMB_EMP_NUMERO_MATRICULA,
              :OLD.EMB_VALIDADE,
              :OLD.EMB_OPCAO,
              :OLD.TIPO,
              :OLD.DATA_ADESAO,
              :OLD.EMB_DATA_EXCLUSAO,
              :OLD.EMB_DEP_RESP_INCL,
              :OLD.EMB_OPER_ANS,
              :OLD.EMB_OPCAO_ALIM,
              :OLD.EMB_OPCAO_REF,
              :OLD.EMB_QTD_ALIM,
              :OLD.EMB_QTD_REF,
              :OLD.EMB_OPCAO_EXTRA,
              :OLD.EMB_OPCAO_BONUS,
              :OLD.EMB_OPCAO_CBA,
              SYSDATE,
              v_operacao,
              USER);
--
END; --End TRIGGER TRG_LOG_PROGRAMACOES_FERIAS
/
CREATE TRIGGER trg_aud_empregados_beneficios
BEFORE INSERT 
ON empregados_beneficios
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
BEGIN
  --
  :NEW.cod_usuario  := USER;
  :NEW.dta_operacao := SYSDATE;
  --
END; --End TRIGGER TRG_AUD_PROGRAMACOES_FERIAS
/

-- Comments for EMPREGADOS_BENEFICIOS

COMMENT ON COLUMN empregados_beneficios.cod_usuario IS 'Codigo do usuario responsanvel pela operacao'
/
COMMENT ON COLUMN empregados_beneficios.dta_operacao IS 'Data da operacao'
/
COMMENT ON COLUMN empregados_beneficios.emb_opcao_cba IS 'CAMPO PARA INFORMAR A OPÇÃO DO EMPREGADO PARA RECEBIMENTO DO VALOR DA CESTA BÁSICA'
/
COMMENT ON COLUMN empregados_beneficios.emb_oper_ans IS 'Registro da operacao efetuada'
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_BENEFICIOS

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_CATEGORIAS
-- Generated 9-mar-2004 18:49:46 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_categorias
    (emc_cat_sigla                  VARCHAR2(6) NOT NULL,
    emc_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    emc_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    emc_quantidade                 NUMBER(3),
    emc_cat_dep_codigo             NUMBER(4) NOT NULL,
    emc_dep_resp_incl              NUMBER(4) NOT NULL,
    emc_tipo_utilizacao            NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EMPREGADOS_CATEGORIAS

CREATE INDEX emc_cat_fk_i ON empregados_categorias
  (
    emc_cat_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX emc_emb_fk_i ON empregados_categorias
  (
    emc_emb_emp_numero_matricula    ASC,
    emc_emb_ben_sigla               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for EMPREGADOS_CATEGORIAS

ALTER TABLE empregados_categorias
ADD CONSTRAINT emc_pk PRIMARY KEY (emc_emb_emp_numero_matricula, 
  emc_cat_dep_codigo, emc_cat_sigla, emc_emb_ben_sigla, emc_tipo_utilizacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE empregados_categorias
ADD CONSTRAINT emc_tipo_utilizacao_ck CHECK (EMC_TIPO_UTILIZACAO IN (1,2,3,4,5))
/

-- Comments for EMPREGADOS_CATEGORIAS

COMMENT ON COLUMN empregados_categorias.emc_tipo_utilizacao IS 'Tipo de utilização da linha: 1- Ida/Volta, 2 - Ida, 3 - Volta, 4 - Hora Extra, 5 - Telecurso '
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_CATEGORIAS

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_FERIAS_13
-- Generated 9-mar-2004 18:50:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_ferias_13
    (efe_emp_numero_matricula       NUMBER(7) NOT NULL,
    efe_ano_referencia             NUMBER(4) NOT NULL,
    efe_mes_referencia             NUMBER(2) NOT NULL,
    efe_versao                     NUMBER(2) NOT NULL,
    efe_rg                         NUMBER(11,3),
    efe_fg                         NUMBER(11,3),
    efe_substituicao               NUMBER(11,3),
    efe_acumulacao                 NUMBER(11,3),
    efe_periculosidade             NUMBER(11,3),
    efe_insalubridade              NUMBER(11,3),
    efe_total_ferias               NUMBER(11,3),
    efe_total_13                   NUMBER(11,3),
    efe_transferencia              NUMBER(11,3),
    efe_salario_base               NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADOS_FERIAS_13

ALTER TABLE empregados_ferias_13
ADD CONSTRAINT efe_pk PRIMARY KEY (efe_emp_numero_matricula, efe_ano_referencia, 
  efe_mes_referencia, efe_versao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EMPREGADOS_FERIAS_13

COMMENT ON COLUMN empregados_ferias_13.efe_salario_base IS 'Valor do salario base do empregado'
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_FERIAS_13

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_FORMACOES
-- Generated 9-mar-2004 18:50:13 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_formacoes
    (emf_emp_numero_matricula       NUMBER(7) NOT NULL,
    emf_for_codigo                 NUMBER(3) NOT NULL,
    emf_principal                  NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADOS_FORMACOES

ALTER TABLE empregados_formacoes
ADD CONSTRAINT emf_pk PRIMARY KEY (emf_emp_numero_matricula, emf_for_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_FORMACOES

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_OPTANTES
-- Generated 9-mar-2004 18:50:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_optantes
    (emp_opt_matricula              NUMBER(7) NOT NULL,
    emp_opt_ano                    NUMBER(4) NOT NULL,
    emp_opt_valor                  NUMBER(13,2),
    emp_opt_sindicato              VARCHAR2(50),
    emp_opt_documento              VARCHAR2(30),
    emp_opt_dt_inclusao            DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADOS_OPTANTES

ALTER TABLE empregados_optantes
ADD CONSTRAINT emp_opt_pk PRIMARY KEY (emp_opt_matricula, emp_opt_ano)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EMPREGADOS_OPTANTES

COMMENT ON COLUMN empregados_optantes.emp_opt_ano IS 'Ano da opção do empregado por outro sindicato'
/
COMMENT ON COLUMN empregados_optantes.emp_opt_documento IS 'Documento gerador da opção de novo sindicato'
/
COMMENT ON COLUMN empregados_optantes.emp_opt_dt_inclusao IS 'Data da inclusão da opção para novo sindicato'
/
COMMENT ON COLUMN empregados_optantes.emp_opt_matricula IS 'Matrícula do empregado'
/
COMMENT ON COLUMN empregados_optantes.emp_opt_sindicato IS 'Nome do novo sindicato'
/
COMMENT ON COLUMN empregados_optantes.emp_opt_valor IS 'Valor pago ao novo sindicato'
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_OPTANTES

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_PAGAMENTOS
-- Generated 9-mar-2004 18:50:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_pagamentos
    (egt_crp_ano_pagamento          NUMBER(4) NOT NULL,
    egt_crp_mes_pagamento          NUMBER(2) NOT NULL,
    egt_crp_sequencial             NUMBER(2) NOT NULL,
    egt_emp_numero_matricula       NUMBER(7) NOT NULL,
    egt_dep_codigo                 NUMBER(4),
    egt_uor_codigo                 NUMBER(9),
    egt_valor_fg                   NUMBER(14,2),
    egt_valor_rg                   NUMBER(14,2),
    egt_dependentes_ir             NUMBER(2),
    egt_dependentes_sal_fam        NUMBER(2),
    egt_numero_mes_13              NUMBER(2),
    egt_numero_anuenios            NUMBER(2),
    egt_carga_horaria_mes          NUMBER(3),
    egt_base_fgts                  NUMBER(14,2),
    egt_base_inss                  NUMBER(14,2),
    egt_base_irrf                  NUMBER(14,2),
    egt_percentual_arsaprev        NUMBER(8,6),
    egt_plano_arsaprev             NUMBER(1),
    egt_base_arsaprev              NUMBER(14,2),
    egt_emp_qlp_car_codigo         NUMBER(3),
    egt_emp_qlp_car_codigo_nivel   NUMBER(1),
    egt_emp_qlp_car_occ_codigo     NUMBER(3),
    egt_emp_nsa_codigo_nivel       NUMBER(2),
    egt_emp_qfu_fun_codigo         NUMBER(3),
    egt_remuneracao_liquido        NUMBER(14,2),
    egt_hcc_cct_codigo             NUMBER(6),
    egt_faixa_inss                 NUMBER(6,2),
    egt_valor_margem_consignavel   NUMBER(14,2),
    egt_emp_nsa_in_nivel_escolarid VARCHAR2(1),
    egt_emp_nsa_codigo_padrao      VARCHAR2(4),
    egt_dep_codigo_fisico          NUMBER(4),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EMPREGADOS_PAGAMENTOS

CREATE INDEX egt_idx ON empregados_pagamentos
  (
    egt_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for EMPREGADOS_PAGAMENTOS

ALTER TABLE empregados_pagamentos
ADD CONSTRAINT egt_ck_1 CHECK (egt_plano_arsaprev in (1,2,3))
/
ALTER TABLE empregados_pagamentos
ADD CONSTRAINT egt_pk PRIMARY KEY (egt_crp_ano_pagamento, egt_crp_mes_pagamento, 
  egt_crp_sequencial, egt_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for EMPREGADOS_PAGAMENTOS

CREATE TRIGGER trg_log_empregados_pagamentos
BEFORE UPDATE  OR  DELETE 
ON empregados_pagamentos
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_EMPREGADOS_PAGAMENTOS
             (
              EGT_CRP_ANO_PAGAMENTO,
              EGT_CRP_MES_PAGAMENTO,
              EGT_CRP_SEQUENCIAL,
              EGT_EMP_NUMERO_MATRICULA,
              EGT_DEP_CODIGO,
              EGT_UOR_CODIGO,
              EGT_VALOR_FG,
              EGT_VALOR_RG,
              EGT_DEPENDENTES_IR,
              EGT_DEPENDENTES_SAL_FAM,
              EGT_NUMERO_MES_13,
              EGT_NUMERO_ANUENIOS,
              EGT_CARGA_HORARIA_MES,
              EGT_BASE_FGTS,
              EGT_BASE_INSS,
              EGT_BASE_IRRF,
              EGT_PERCENTUAL_ARSAPREV,
              EGT_PLANO_ARSAPREV,
              EGT_BASE_ARSAPREV,
              EGT_EMP_QLP_CAR_CODIGO,
              EGT_EMP_QLP_CAR_CODIGO_NIVEL,
              EGT_EMP_QLP_CAR_OCC_CODIGO,
              EGT_EMP_NSA_CODIGO_NIVEL,
              EGT_EMP_QFU_FUN_CODIGO,
              EGT_REMUNERACAO_LIQUIDO,
              EGT_HCC_CCT_CODIGO,
              EGT_FAIXA_INSS,
              EGT_VALOR_MARGEM_CONSIGNAVEL,
              EGT_EMP_NSA_IN_NIVEL_ESCOLARID,
              EGT_EMP_NSA_CODIGO_PADRAO,
              EGT_DEP_CODIGO_FISICO,
              DTA_OPERACAO,
              TIP_OPERACAO,
              COD_USUARIO
             )
             VALUES
             (
              :OLD.EGT_CRP_ANO_PAGAMENTO,
              :OLD.EGT_CRP_MES_PAGAMENTO,
              :OLD.EGT_CRP_SEQUENCIAL,
              :OLD.EGT_EMP_NUMERO_MATRICULA,
              :OLD.EGT_DEP_CODIGO,
              :OLD.EGT_UOR_CODIGO,
              :OLD.EGT_VALOR_FG,
              :OLD.EGT_VALOR_RG,
              :OLD.EGT_DEPENDENTES_IR,
              :OLD.EGT_DEPENDENTES_SAL_FAM,
              :OLD.EGT_NUMERO_MES_13,
              :OLD.EGT_NUMERO_ANUENIOS,
              :OLD.EGT_CARGA_HORARIA_MES,
              :OLD.EGT_BASE_FGTS,
              :OLD.EGT_BASE_INSS,
              :OLD.EGT_BASE_IRRF,
              :OLD.EGT_PERCENTUAL_ARSAPREV,
              :OLD.EGT_PLANO_ARSAPREV,
              :OLD.EGT_BASE_ARSAPREV,
              :OLD.EGT_EMP_QLP_CAR_CODIGO,
              :OLD.EGT_EMP_QLP_CAR_CODIGO_NIVEL,
              :OLD.EGT_EMP_QLP_CAR_OCC_CODIGO,
              :OLD.EGT_EMP_NSA_CODIGO_NIVEL,
              :OLD.EGT_EMP_QFU_FUN_CODIGO,
              :OLD.EGT_REMUNERACAO_LIQUIDO,
              :OLD.EGT_HCC_CCT_CODIGO,
              :OLD.EGT_FAIXA_INSS,
              :OLD.EGT_VALOR_MARGEM_CONSIGNAVEL,
              :OLD.EGT_EMP_NSA_IN_NIVEL_ESCOLARID,
              :OLD.EGT_EMP_NSA_CODIGO_PADRAO,
              :OLD.EGT_DEP_CODIGO_FISICO,
              SYSDATE,--:OLD.EMP_DTA_OPERACAO,
              v_operacao,--:OLD.EMP_TIP_OPERACAO,
              USER--:OLD.EMP_COD_USUARIO
             );
--
END; --End TRIGGER TRG_LOG_EMPREGADOS_PAGAMENTOS
/
CREATE TRIGGER trg_auditoria
BEFORE INSERT 
ON empregados_pagamentos
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
BEGIN
  --
  :NEW.cod_usuario  := USER;
  :NEW.dta_operacao := SYSDATE;
  --
END; --End TRIGGER TRG_AUDITORIA
/

-- Comments for EMPREGADOS_PAGAMENTOS

COMMENT ON COLUMN empregados_pagamentos.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN empregados_pagamentos.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN empregados_pagamentos.egt_base_arsaprev IS 'Informa a valor base de cálculo do fundo de pensão da Infraero'
/
COMMENT ON COLUMN empregados_pagamentos.egt_base_fgts IS 'Informa a valor base de cálculo de fgts do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_base_inss IS 'Informa a valor base de cálculo de inss do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_base_irrf IS 'Informa a valor base de cálculo de irrf do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_carga_horaria_mes IS 'Informa a carga horária de trabalho no mês do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_crp_ano_pagamento IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN empregados_pagamentos.egt_crp_mes_pagamento IS 'Indica o mês referente ao pagamento'
/
COMMENT ON COLUMN empregados_pagamentos.egt_crp_sequencial IS 'Indica a versão de pagamento dentro do mesmo mês'
/
COMMENT ON COLUMN empregados_pagamentos.egt_dep_codigo IS 'Informa o código da dependência de pagamento'
/
COMMENT ON COLUMN empregados_pagamentos.egt_dependentes_ir IS 'Informa a quantidade de dependentes para irrf do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_dependentes_sal_fam IS 'Informa a quantidade de dependentes para salário família do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_nsa_codigo_nivel IS 'Indica o nível salarial do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_nsa_codigo_padrao IS 'Indica código padrão salarial do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_nsa_in_nivel_escolarid IS 'Indica o nível de escolaridade do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_qfu_fun_codigo IS 'Indica o código da função do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_qlp_car_codigo IS 'Informa o código do cargo do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_qlp_car_codigo_nivel IS 'Informa o código do nível do cargo do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_emp_qlp_car_occ_codigo IS 'Informa a ocupação/atuação do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_faixa_inss IS 'Indica a faixa de desconto de inss que o empregado está enquadrado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_hcc_cct_codigo IS 'Indica o centro de custo do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_numero_anuenios IS 'Informa a quantidade de anuênios do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_numero_mes_13 IS 'Informa a quantidade de avos para o cálculo do 13º salário do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_percentual_arsaprev IS 'Informa o percentual de contribuição do fundo de pensão da Infraero'
/
COMMENT ON COLUMN empregados_pagamentos.egt_plano_arsaprev IS 'Informa o tipo do plano do fundo de pensão da Infraero'
/
COMMENT ON COLUMN empregados_pagamentos.egt_remuneracao_liquido IS 'Indica o valor líquido de remuneração do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_uor_codigo IS 'Informa o código da unidade organizacionao do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_valor_fg IS 'Informa o valor referente ao pagamento de FG no mês do empregado'
/
COMMENT ON COLUMN empregados_pagamentos.egt_valor_rg IS 'Informa o valor referente ao pagamento de RG no mês do empregado'
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_PAGAMENTOS

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_PARTICIPACAO_LUCROS
-- Generated 9-mar-2004 18:50:43 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_participacao_lucros
    (epl_data_geracao               DATE NOT NULL,
    epl_dep_codigo_lotacao         NUMBER(4) NOT NULL,
    epl_emp_numero_matricula       NUMBER(7) NOT NULL,
    epl_ident_51                   VARCHAR2(1),
    epl_ident_116                  VARCHAR2(1),
    epl_ident_115_120_122          VARCHAR2(1),
    epl_ident_37_187_188           VARCHAR2(1),
    epl_ident_65                   VARCHAR2(1),
    epl_ident_97                   VARCHAR2(1),
    epl_ident_32                   VARCHAR2(1),
    epl_qtde_dias_trab             NUMBER(3),
    epl_data_base                  DATE,
    epl_ident_juridico             VARCHAR2(1),
    epl_ident_sindicancia          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EMPREGADOS_PARTICIPACAO_LUCROS

CREATE INDEX idx_epl_01 ON empregados_participacao_lucros
  (
    epl_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for EMPREGADOS_PARTICIPACAO_LUCROS

ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_1 CHECK ( epl_ident_51 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_2 CHECK ( epl_ident_116 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_3 CHECK ( epl_ident_115_120_122 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_4 CHECK ( epl_ident_37_187_188 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_5 CHECK ( epl_ident_65 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_6 CHECK ( epl_ident_97 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_7 CHECK ( epl_ident_32 IN ('N','S')  )
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ck_epl_ident_jur CHECK (EPL_IDENT_JURIDICO in ('S','N'))
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_ident_sind_chk CHECK (epl_ident_sindicancia in ('S','N'))
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT epl_pk PRIMARY KEY (epl_data_geracao, epl_dep_codigo_lotacao, 
  epl_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_PARTICIPACAO_LUCROS

-- Start of DDL Script for Table IFRSRH.EMPREGADOS_PESSOAL_SEM_VINCULO
-- Generated 9-mar-2004 18:50:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE empregados_pessoal_sem_vinculo
    (epv_emp_numero_matricula       NUMBER(7) NOT NULL,
    epv_psv_sequencial             NUMBER(10) NOT NULL,
    epv_data_inicio                DATE,
    epv_data_termino               DATE,
    epv_rfi_sequencial             NUMBER(10),
    epv_dep_codigo_fisico          NUMBER(4),
    epv_tipo_pagamento             VARCHAR2(1),
    epv_data_cadastro              DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPREGADOS_PESSOAL_SEM_VINCULO

ALTER TABLE empregados_pessoal_sem_vinculo
ADD CONSTRAINT epv_pk PRIMARY KEY (epv_emp_numero_matricula, epv_psv_sequencial, 
  epv_data_cadastro)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPREGADOS_PESSOAL_SEM_VINCULO

-- Start of DDL Script for Table IFRSRH.EMPRESTIMO_CONSIG_BANCO_REAL
-- Generated 9-mar-2004 18:51:06 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emprestimo_consig_banco_real
    (cod_registro                   NUMBER(2) NOT NULL,
    mat_emp                        NUMBER(12) NOT NULL,
    dat_movimento                  DATE NOT NULL,
    valor_total_debito             NUMBER(17,2) NOT NULL,
    situacao                       NUMBER(2) NOT NULL,
    nome_empregado                 VARCHAR2(30) NOT NULL,
    cod_empresa                    NUMBER(5) NOT NULL,
    num_sequencial_registro        NUMBER(6) NOT NULL,
    dat_leitura_arquivo            DATE NOT NULL,
    ind_status_empregado           NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for EMPRESTIMO_CONSIG_BANCO_REAL

COMMENT ON COLUMN emprestimo_consig_banco_real.cod_empresa IS 'Codigo que indentifica empresa cadastrada no banco real fixo = 00825'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.cod_registro IS 'Armazena código do Registro, Informado pelo B. real. Cod Fixo = 41'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.dat_leitura_arquivo IS 'Data na qual o arquivo foi processado'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.dat_movimento IS 'data da movimentação proximo vencimento'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.ind_status_empregado IS 'Indicará se o empregado está ativo, afastado ou desligado na data de processamento do arquivo'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.mat_emp IS 'Matricula do empregado'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.nome_empregado IS 'Nome do empregado'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.num_sequencial_registro IS 'identifica numero o seq do registro'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.situacao IS 'Situação do emprestimo. Consignado = 1 , não consignado = 2'
/
COMMENT ON COLUMN emprestimo_consig_banco_real.valor_total_debito IS 'Valor a ser debitado parcela + Cpmf'
/

-- End of DDL Script for Table IFRSRH.EMPRESTIMO_CONSIG_BANCO_REAL

-- Start of DDL Script for Table IFRSRH.EMPRESTIMOS_INFRAPREV
-- Generated 9-mar-2004 18:51:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE emprestimos_infraprev
    (ano_referencia                 NUMBER(4) NOT NULL,
    mes_referencia                 NUMBER(2) NOT NULL,
    num_matricula_empregado        NUMBER(7) NOT NULL,
    mutuario                       NUMBER(12) NOT NULL,
    num_contrato                   NUMBER(4) NOT NULL,
    periodo                        NUMBER(3) NOT NULL,
    dt_cobranca                    DATE NOT NULL,
    tp_folha                       NUMBER(1) NOT NULL,
    tp_operacao                    NUMBER(1) NOT NULL,
    val_credito                    NUMBER(17,2) NOT NULL,
    val_debito                     NUMBER(17,2) NOT NULL,
    participante                   NUMBER(7) NOT NULL,
    titular                        NUMBER(6) NOT NULL,
    patrocinadora                  NUMBER(3) NOT NULL,
    local                          NUMBER(3) NOT NULL,
    num_periodos                   NUMBER(3) NOT NULL,
    num_prestacoes                 NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EMPRESTIMOS_INFRAPREV

ALTER TABLE emprestimos_infraprev
ADD CONSTRAINT emprestimos_infraprev_pk PRIMARY KEY (ano_referencia, 
  mes_referencia, num_matricula_empregado)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EMPRESTIMOS_INFRAPREV

-- Start of DDL Script for Table IFRSRH.ENQUADRAMENTOS
-- Generated 9-mar-2004 18:51:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE enquadramentos
    (enq_numero                     NUMBER(6) NOT NULL,
    enq_descricao                  VARCHAR2(250) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ENQUADRAMENTOS

ALTER TABLE enquadramentos
ADD CONSTRAINT enq_pk PRIMARY KEY (enq_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ENQUADRAMENTOS

-- Start of DDL Script for Table IFRSRH.ERROS_PLANO_SAUDE
-- Generated 9-mar-2004 18:51:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE erros_plano_saude
    (eps_codigo_erro                NUMBER(3) NOT NULL,
    eps_descricao_erro             VARCHAR2(150),
    eps_ind_aviso                  VARCHAR2(1),
    esp_descricao_rotina           VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ERROS_PLANO_SAUDE

ALTER TABLE erros_plano_saude
ADD CONSTRAINT eps_pk PRIMARY KEY (eps_codigo_erro)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ERROS_PLANO_SAUDE

-- Start of DDL Script for Table IFRSRH.ESCOLARIDADES
-- Generated 9-mar-2004 18:51:30 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE escolaridades
    (eso_codigo                     NUMBER(2) NOT NULL,
    eso_nome                       VARCHAR2(50) NOT NULL,
    eso_indicador_nivel            VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ESCOLARIDADES

ALTER TABLE escolaridades
ADD CONSTRAINT eso_indicador_nivel_ck CHECK (ESO_INDICADOR_NIVEL IN ('A','B'))
/
ALTER TABLE escolaridades
ADD CONSTRAINT eso_pk PRIMARY KEY (eso_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE escolaridades
ADD CONSTRAINT eso_uk UNIQUE (eso_nome)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for ESCOLARIDADES

COMMENT ON COLUMN escolaridades.eso_codigo IS 'Sequencial identificador de um grau de escolaridade.'
/
COMMENT ON COLUMN escolaridades.eso_indicador_nivel IS 'Indica se a escolaridade e de nivel medio ou superior.'
/
COMMENT ON COLUMN escolaridades.eso_nome IS 'Denominac?o da escolaridade.'
/

-- End of DDL Script for Table IFRSRH.ESCOLARIDADES

-- Start of DDL Script for Table IFRSRH.ESPECIALIDADES
-- Generated 9-mar-2004 18:51:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE especialidades
    (esp_tipo                       NUMBER(1) NOT NULL,
    esp_numero                     NUMBER(7) NOT NULL,
    esp_descricao                  VARCHAR2(250) NOT NULL,
    esp_dv                         NUMBER(1),
    obs                            VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ESPECIALIDADES

ALTER TABLE especialidades
ADD CONSTRAINT esp_pk PRIMARY KEY (esp_tipo, esp_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE especialidades
ADD CONSTRAINT esp_tipo_ck CHECK ( esp_tipo IN ( 1 , 2 )  )
/

-- Comments for ESPECIALIDADES

COMMENT ON COLUMN especialidades.esp_descricao IS 'Descric?o da Especialidade'
/
COMMENT ON COLUMN especialidades.esp_numero IS 'Numero da Especialidade'
/
COMMENT ON COLUMN especialidades.esp_tipo IS 'Tipo da Especialidade'
/

-- End of DDL Script for Table IFRSRH.ESPECIALIDADES

-- Start of DDL Script for Table IFRSRH.ESPECIFICACAO_CID
-- Generated 9-mar-2004 18:51:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE especificacao_cid
    (esc_cid_codigo                 VARCHAR2(5) NOT NULL,
    esc_eid_codigo                 VARCHAR2(3) NOT NULL,
    esc_descricao                  VARCHAR2(80) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ESPECIFICACAO_CID

ALTER TABLE especificacao_cid
ADD CONSTRAINT esc_pk PRIMARY KEY (esc_cid_codigo, esc_eid_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ESPECIFICACAO_CID

-- Start of DDL Script for Table IFRSRH.ESPELHO_EMPREGADOS
-- Generated 9-mar-2004 18:51:56 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE espelho_empregados
    (eem_emp_numero_matricula       NUMBER(7),
    eem_emp_jtr_codigo             NUMBER(1),
    eem_emp_aba_ban_codigo_ct_pgt  VARCHAR2(3),
    eem_emp_aba_codigo_conta_pgto  VARCHAR2(7),
    eem_emp_nu_conta_corrente_pagt VARCHAR2(14),
    eem_emp_tipo_conta             VARCHAR2(3),
    eem_emp_sfu_codigo             NUMBER(1),
    eem_emp_htd_dep_codigo         NUMBER(4),
    eem_emp_htd_htr_codigo         NUMBER(2),
    eem_emp_htd_sequencial         NUMBER(2),
    eem_emp_qlp_hcl_uor_codigo     NUMBER(9),
    eem_emp_qlp_hcl_data_vigencia  DATE,
    eem_emp_qlp_car_codigo         NUMBER(3),
    eem_emp_qlp_car_codigo_nivel   NUMBER(1),
    eem_emp_qlp_car_occ_codigo     NUMBER(3),
    eem_emp_nsa_codigo_nivel       NUMBER(2),
    eem_emp_nsa_codigo_padrao      VARCHAR2(4),
    eem_emp_nsa_in_nivel_escol     VARCHAR2(1),
    eem_emp_dep_codigo_lotacao     NUMBER(4),
    eem_emp_dep_codigo_pagto       NUMBER(4),
    eem_emp_dep_codigo_fisico      NUMBER(4),
    eem_emp_uor_codigo_lotacao     NUMBER(9),
    eem_emp_ati_ct_custos          NUMBER(10),
    eem_emp_plano_arsaprev         NUMBER(1),
    eem_emp_data_filiacao_arsaprev DATE,
    eem_emp_data_cancel_arsaprev   DATE,
    eem_emp_contrib_sindical_anual VARCHAR2(1),
    eem_emp_contrib_federativa     VARCHAR2(1),
    eem_emp_adianta_13             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ESPELHO_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.EVENTOS_EXCECAO_INFRAPREV
-- Generated 9-mar-2004 18:51:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE eventos_excecao_infraprev
    (eei_cod_empregador             NUMBER(2) NOT NULL,
    eei_cod_local                  NUMBER(4) NOT NULL,
    eei_emp_numero_matricula       NUMBER(7) NOT NULL,
    eei_ind_plano                  NUMBER(1) NOT NULL,
    eei_data                       DATE NOT NULL,
    eei_data_evento                DATE,
    eei_cod_evento                 NUMBER(5) NOT NULL,
    eei_valor_evento               NUMBER(10,2),
    eei_flg_desconto_folha         VARCHAR2(1) DEFAULT 'N'  NOT NULL,
    eei_rub_codigo                 NUMBER(4),
    eei_tip_rubrica                VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EVENTOS_EXCECAO_INFRAPREV

ALTER TABLE eventos_excecao_infraprev
ADD CONSTRAINT eei_flg_desc_folha_ck CHECK (EEI_FLG_DESCONTO_FOLHA IN ('S','N'))
/
ALTER TABLE eventos_excecao_infraprev
ADD CONSTRAINT eei_pk PRIMARY KEY (eei_emp_numero_matricula, eei_ind_plano, 
  eei_data, eei_cod_evento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EVENTOS_EXCECAO_INFRAPREV

COMMENT ON TABLE eventos_excecao_infraprev IS 'Contem os dados de excecao recebidos da INFRAPREV pela INFRAERO para lancamento dos descontos pertinentes.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_cod_empregador IS 'Empregador no qual está cadastrado o participante.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_cod_evento IS 'Código de identificação da operação cadastrada.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_cod_local IS 'Local no qual está cadastrado o participante'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_data IS 'Mês de processamento.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_data_evento IS 'Mês de referência do desconto ou da devolução.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_emp_numero_matricula IS 'Matrícula do participante na INFRAERO.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_flg_desconto_folha IS 'Se igual a ''S'' indica que o desconto relativo a esse registro já foi lançado na Folha de Pagamento.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_ind_plano IS 'Plano no qual está cadastrado o participante.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_rub_codigo IS 'Código da rubrica associada ao evento.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_tip_rubrica IS 'Indica o tipo de rubrica associada ao evento. D - diferença, N - normal, E - extorno, R - recibo.'
/
COMMENT ON COLUMN eventos_excecao_infraprev.eei_valor_evento IS 'Valor a ser ajustado na devida operação indicada pelo campo EEI_COD_EVENTO.'
/

-- End of DDL Script for Table IFRSRH.EVENTOS_EXCECAO_INFRAPREV

-- Start of DDL Script for Table IFRSRH.EVENTOS_PAGAMENTOS
-- Generated 9-mar-2004 18:52:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE eventos_pagamentos
    (epg_codigo                     NUMBER(3) NOT NULL,
    epg_descricao                  VARCHAR2(40) NOT NULL,
    epg_codigo_dhf                 VARCHAR2(8),
    epg_epg_codigo                 NUMBER(3),
    epg_epg_codigo_pre_2           NUMBER(3),
    epg_tipo_cronograma            CHAR(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for EVENTOS_PAGAMENTOS

CREATE INDEX epg_epg_fk_i ON eventos_pagamentos
  (
    epg_epg_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX epg_epg_pre_requisito_2_fk_i ON eventos_pagamentos
  (
    epg_epg_codigo_pre_2            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for EVENTOS_PAGAMENTOS

ALTER TABLE eventos_pagamentos
ADD CONSTRAINT epg_pk PRIMARY KEY (epg_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for EVENTOS_PAGAMENTOS

COMMENT ON COLUMN eventos_pagamentos.epg_tipo_cronograma IS 'Indica se o evento é de pagamentto (P) ou informativo(I)'
/

-- End of DDL Script for Table IFRSRH.EVENTOS_PAGAMENTOS

-- Start of DDL Script for Table IFRSRH.EXAMES_COMPLEMENTARES
-- Generated 9-mar-2004 18:52:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE exames_complementares
    (exc_cre_sequencial             NUMBER(5) NOT NULL,
    exc_codigo_procedimento        NUMBER(7) NOT NULL,
    exc_tabela                     VARCHAR2(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EXAMES_COMPLEMENTARES

-- Start of DDL Script for Table IFRSRH.EXAMES_OBRIGATORIOS
-- Generated 9-mar-2004 18:52:24 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE exames_obrigatorios
    (exo_emp_numero_matricula       NUMBER(7) NOT NULL,
    exo_tipo_exame                 NUMBER(1) NOT NULL,
    exo_data                       DATE NOT NULL,
    exo_documento                  VARCHAR2(30) NOT NULL,
    exo_observacao                 VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for EXAMES_OBRIGATORIOS

ALTER TABLE exames_obrigatorios
ADD CONSTRAINT exo_ck_1 CHECK (  EXO_TIPO_EXAME IN (1,2,3,4)                                                     )
/
ALTER TABLE exames_obrigatorios
ADD CONSTRAINT exo_pk PRIMARY KEY (exo_emp_numero_matricula, exo_tipo_exame, 
  exo_data)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EXAMES_OBRIGATORIOS

-- Start of DDL Script for Table IFRSRH.EXCEPTIONS
-- Generated 9-mar-2004 18:52:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE exceptions
    (row_id                         ROWID,
    owner                          VARCHAR2(30),
    table_name                     VARCHAR2(30),
    constraint                     VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.EXCEPTIONS

-- Start of DDL Script for Table IFRSRH.FAIXA_ARSAPREV
-- Generated 9-mar-2004 18:52:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE faixa_arsaprev
    (ars_mes                        NUMBER(2) NOT NULL,
    ars_ano                        NUMBER(4) NOT NULL,
    ars_plano                      NUMBER(1) NOT NULL,
    ars_faixa                      NUMBER(1) NOT NULL,
    ars_valor                      NUMBER(11,2) NOT NULL,
    ars_percentual                 NUMBER(8,6) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FAIXA_ARSAPREV

ALTER TABLE faixa_arsaprev
ADD CONSTRAINT ars_ck_1 CHECK (ars_plano in (1,2))
/
ALTER TABLE faixa_arsaprev
ADD CONSTRAINT ars_pk PRIMARY KEY (ars_mes, ars_ano, ars_plano, ars_faixa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FAIXA_ARSAPREV

-- Start of DDL Script for Table IFRSRH.FAIXAS_INSS
-- Generated 9/3/2004 18:52:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE faixas_inss
    (fai_faixa                      NUMBER(2) NOT NULL,
    fai_lim_superior               NUMBER(12,2) NOT NULL,
    fai_per_desc_empr              NUMBER(6,2) NOT NULL,
    fai_ano_referencia             NUMBER(4) NOT NULL,
    fai_mes_referencia             NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FAIXAS_INSS

ALTER TABLE faixas_inss
ADD CONSTRAINT fai_pk PRIMARY KEY (fai_faixa, fai_ano_referencia, 
  fai_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FAIXAS_INSS

-- Start of DDL Script for Table IFRSRH.FALTAS_USUARIOS_LINHAS
-- Generated 9/3/2004 18:52:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE faltas_usuarios_linhas
    (ful_ult_emb_emp_numero_matricu NUMBER(7) NOT NULL,
    ful_ult_emb_ben_sigla          VARCHAR2(3) NOT NULL,
    ful_ult_ltf_numero             NUMBER(5) NOT NULL,
    ful_ult_ltf_dep_codigo         NUMBER(4) NOT NULL,
    ful_data                       DATE NOT NULL,
    ful_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FALTAS_USUARIOS_LINHAS

ALTER TABLE faltas_usuarios_linhas
ADD CONSTRAINT ful_pk PRIMARY KEY (ful_ult_emb_emp_numero_matricu, 
  ful_ult_emb_ben_sigla, ful_ult_ltf_numero, ful_ult_ltf_dep_codigo, ful_data)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FALTAS_USUARIOS_LINHAS

-- Start of DDL Script for Table IFRSRH.FINASA
-- Generated 9/3/2004 18:52:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE finasa
    (fin_mes                        NUMBER(2),
    fin_ano                        NUMBER(4),
    fin_emp_numero_matricula       NUMBER(7),
    fin_apolice                    VARCHAR2(1),
    fin_centro_custos              NUMBER(6),
    fin_valor_cota_parte_empresa   NUMBER(8,2),
    fin_situacao_funcional         NUMBER(1),
    fin_tipo_registro              NUMBER(1),
    fin_emp_dep_codigo_lotacao     NUMBER(4),
    fin_capital_vg                 NUMBER(11),
    fin_salario                    NUMBER(8,2),
    fin_premio_ind_basica          NUMBER(8,2),
    fin_premio_ind_complementar    NUMBER(8,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FINASA

ALTER TABLE finasa
ADD CONSTRAINT fin_ano_ck CHECK ( FIN_ANO IS NOT NULL                                                              )
/
ALTER TABLE finasa
ADD CONSTRAINT fin_apolice_ck CHECK ( FIN_APOLICE IS NOT NULL                                                          )
/
ALTER TABLE finasa
ADD CONSTRAINT fin_emp_numero_matricula_ck CHECK ( FIN_EMP_NUMERO_MATRICULA IS NOT NULL                                             )
/
ALTER TABLE finasa
ADD CONSTRAINT fin_mes_ck CHECK ( FIN_MES IS NOT NULL                                                              )
/

-- End of DDL Script for Table IFRSRH.FINASA

-- Start of DDL Script for Table IFRSRH.FISCAIS_LINHAS_TRANSPORTES
-- Generated 9/3/2004 18:53:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE fiscais_linhas_transportes
    (flt_emp_numero_matricula       NUMBER(7) NOT NULL,
    flt_data_inclusao              DATE NOT NULL,
    flt_data_exclusao              DATE,
    flt_numero_ato                 VARCHAR2(15) NOT NULL,
    flt_data_ato                   DATE NOT NULL,
    flt_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FISCAIS_LINHAS_TRANSPORTES

ALTER TABLE fiscais_linhas_transportes
ADD CONSTRAINT flt_pk PRIMARY KEY (flt_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE fiscais_linhas_transportes
ADD CONSTRAINT flt_uk UNIQUE (flt_numero_ato)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FISCAIS_LINHAS_TRANSPORTES

-- Start of DDL Script for Table IFRSRH.FISCALIZACOES_LINHAS_EMPREG
-- Generated 9/3/2004 18:53:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE fiscalizacoes_linhas_empreg
    (fle_flr_numero_ato             VARCHAR2(15) NOT NULL,
    fle_emp_numero_matricula       NUMBER(7) NOT NULL,
    fle_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FISCALIZACOES_LINHAS_EMPREG

ALTER TABLE fiscalizacoes_linhas_empreg
ADD CONSTRAINT fle_pk PRIMARY KEY (fle_flr_numero_ato, fle_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FISCALIZACOES_LINHAS_EMPREG

-- Start of DDL Script for Table IFRSRH.FISCALIZACOES_LINHAS_TRANSP
-- Generated 9/3/2004 18:53:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE fiscalizacoes_linhas_transp
    (flr_numero_ato                 VARCHAR2(15) NOT NULL,
    flr_data_ato                   DATE NOT NULL,
    flr_ltf_numero                 NUMBER(5) NOT NULL,
    flr_ltf_dep_codigo             NUMBER(4) NOT NULL,
    flr_data_fiscalizacao          DATE NOT NULL,
    flr_problemas                  VARCHAR2(2000),
    flr_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FISCALIZACOES_LINHAS_TRANSP

ALTER TABLE fiscalizacoes_linhas_transp
ADD CONSTRAINT flr_pk PRIMARY KEY (flr_numero_ato)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FISCALIZACOES_LINHAS_TRANSP

-- Start of DDL Script for Table IFRSRH.FITA_TCU
-- Generated 9/3/2004 18:53:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE fita_tcu
    (tcu_tipo_reg                   NUMBER(1) NOT NULL,
    tcu_numero_controle            VARCHAR2(7) NOT NULL,
    tcu_ano_controle               NUMBER(4) NOT NULL,
    tcu_seq_controle               NUMBER(5) NOT NULL,
    tcu_emp_nome                   VARCHAR2(60) NOT NULL,
    tcu_emp_numero_cpf             NUMBER(11) NOT NULL,
    tcu_emp_data_admissao          DATE,
    tcu_data_efetivo_exercicio     DATE,
    tcu_car_codigo_tcu             VARCHAR2(4),
    tcu_data_venc_contrato         VARCHAR2(6),
    tcu_provto                     NUMBER(1),
    tcu_motivo_vaga                NUMBER(1),
    tcu_base_legal_vaga            VARCHAR2(30),
    tcu_edi_data_concurso          DATE,
    tcu_edi_data_homologacao       DATE,
    tcu_con_data_fim_validade      DATE,
    tcu_can_classificacao          NUMBER(4),
    tcu_data_desligamento          DATE,
    tcu_motivo_desligamento        NUMBER(1),
    tcu_parecer_contr_inter        VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FITA_TCU

-- Start of DDL Script for Table IFRSRH.FORCAS_ARMADAS
-- Generated 9/3/2004 18:53:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE forcas_armadas
    (far_codigo                     NUMBER(2) NOT NULL,
    far_descricao                  VARCHAR2(15) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORCAS_ARMADAS

ALTER TABLE forcas_armadas
ADD CONSTRAINT far_codigo_pk PRIMARY KEY (far_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORCAS_ARMADAS

-- Start of DDL Script for Table IFRSRH.FORMACOES_ESPEC_CARGO
-- Generated 9/3/2004 18:53:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formacoes_espec_cargo
    (fec_car_codigo                 NUMBER(3) NOT NULL,
    fec_car_codigo_nivel           NUMBER(1) NOT NULL,
    fec_car_occ_codigo             NUMBER(3) NOT NULL,
    fec_fes_codigo                 NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMACOES_ESPEC_CARGO

ALTER TABLE formacoes_espec_cargo
ADD CONSTRAINT fec_pk PRIMARY KEY (fec_car_codigo, fec_car_codigo_nivel, 
  fec_car_occ_codigo, fec_fes_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORMACOES_ESPEC_CARGO

-- Start of DDL Script for Table IFRSRH.FORMACOES_ESPEC_EMPREGADO
-- Generated 9/3/2004 18:53:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formacoes_espec_empregado
    (fee_fes_codigo                 NUMBER(3) NOT NULL,
    fee_emp_numero_matricula       NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMACOES_ESPEC_EMPREGADO

ALTER TABLE formacoes_espec_empregado
ADD CONSTRAINT fee_pk PRIMARY KEY (fee_fes_codigo, fee_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORMACOES_ESPEC_EMPREGADO

-- Start of DDL Script for Table IFRSRH.FORMACOES_ESPECIALIZADAS
-- Generated 9/3/2004 18:53:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formacoes_especializadas
    (fes_codigo                     NUMBER(3) NOT NULL,
    fes_descricao                  VARCHAR2(110) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMACOES_ESPECIALIZADAS

ALTER TABLE formacoes_especializadas
ADD CONSTRAINT fes_pk PRIMARY KEY (fes_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for FORMACOES_ESPECIALIZADAS

COMMENT ON COLUMN formacoes_especializadas.fes_codigo IS 'Código da Formação Profissional'
/
COMMENT ON COLUMN formacoes_especializadas.fes_descricao IS 'Descricao da Formacao'
/

-- End of DDL Script for Table IFRSRH.FORMACOES_ESPECIALIZADAS

-- Start of DDL Script for Table IFRSRH.FORMACOES_PROF_CARGO
-- Generated 9/3/2004 18:54:04 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formacoes_prof_cargo
    (fpc_car_codigo                 NUMBER(3) NOT NULL,
    fpc_for_codigo                 NUMBER(3) NOT NULL,
    fpc_car_codigo_nivel           NUMBER(1) NOT NULL,
    fpc_car_occ_codigo             NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORMACOES_PROF_CARGO

-- Start of DDL Script for Table IFRSRH.FORMACOES_PROFISSIONAIS
-- Generated 9/3/2004 18:54:06 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formacoes_profissionais
    (for_codigo                     NUMBER(3) NOT NULL,
    for_descricao                  VARCHAR2(80) NOT NULL,
    for_nivel_escolar              VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMACOES_PROFISSIONAIS

ALTER TABLE formacoes_profissionais
ADD CONSTRAINT for_pk PRIMARY KEY (for_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE formacoes_profissionais
ADD CONSTRAINT for_uk UNIQUE (for_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for FORMACOES_PROFISSIONAIS

COMMENT ON COLUMN formacoes_profissionais.for_codigo IS 'Codigo que identifica uma Formac?o.'
/
COMMENT ON COLUMN formacoes_profissionais.for_descricao IS 'Descric?o da Formac?o.'
/
COMMENT ON COLUMN formacoes_profissionais.for_nivel_escolar IS 'Nível Escolar'
/

-- End of DDL Script for Table IFRSRH.FORMACOES_PROFISSIONAIS

-- Start of DDL Script for Table IFRSRH.FORMULAS
-- Generated 9/3/2004 18:54:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formulas
    (for_codigo                     NUMBER(3) NOT NULL,
    for_formula                    VARCHAR2(400) NOT NULL,
    for_formula_invertida          VARCHAR2(400),
    for_descricao                  VARCHAR2(240),
    for_tipo_parametro             CHAR(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMULAS

ALTER TABLE formulas
ADD CONSTRAINT form_pk PRIMARY KEY (for_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORMULAS

-- Start of DDL Script for Table IFRSRH.FORMULAS_RUBRICAS
-- Generated 9/3/2004 18:54:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE formulas_rubricas
    (fru_rub_codigo                 NUMBER(4) NOT NULL,
    fru_ano_inicio                 NUMBER(4) NOT NULL,
    fru_mes_inicio                 NUMBER(2) NOT NULL,
    fru_ano_termino                NUMBER(4),
    fru_mes_termino                NUMBER(2),
    fru_for_codigo                 NUMBER(3),
    fru_valor_inferior             NUMBER(11,2),
    fru_valor_superior             NUMBER(11,2),
    fru_frequencia_inferior        NUMBER(7,3),
    fru_frequencia_superior        NUMBER(7,3),
    fru_comentario                 VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for FORMULAS_RUBRICAS

ALTER TABLE formulas_rubricas
ADD CONSTRAINT fru_pk PRIMARY KEY (fru_rub_codigo, fru_ano_inicio, 
  fru_mes_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.FORMULAS_RUBRICAS

-- Start of DDL Script for Table IFRSRH.GRH_HST_DIRF
-- Generated 9/3/2004 18:54:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE grh_hst_dirf
    (ghd_dat_ano                    NUMBER(4) NOT NULL,
    ghd_num_cpf                    NUMBER(14) NOT NULL,
    ghd_num_sequencial             NUMBER(8),
    ghd_tip_registro               NUMBER(1),
    ghd_num_cnpj                   NUMBER(14),
    ghd_cod_retencao               NUMBER(4),
    ghd_cod_ident_esp_ben          NUMBER(1),
    ghd_val_rend_jan               NUMBER(15),
    ghd_val_ded_jan                NUMBER(15),
    ghd_val_ir_jan                 NUMBER(15),
    ghd_val_rend_fev               NUMBER(15),
    ghd_val_ded_fev                NUMBER(15),
    ghd_val_ir_fev                 NUMBER(15),
    ghd_val_rend_mar               NUMBER(15),
    ghd_val_ded_mar                NUMBER(15),
    ghd_val_ir_mar                 NUMBER(15),
    ghd_val_rend_abr               NUMBER(15),
    ghd_val_ded_abr                NUMBER(15),
    ghd_val_ir_abr                 NUMBER(15),
    ghd_val_rend_mai               NUMBER(15),
    ghd_val_ded_mai                NUMBER(15),
    ghd_val_ir_mai                 NUMBER(15),
    ghd_val_rend_jun               NUMBER(15),
    ghd_val_ded_jun                NUMBER(15),
    ghd_val_ir_jun                 NUMBER(15),
    ghd_val_rend_jul               NUMBER(15),
    ghd_val_ded_jul                NUMBER(15),
    ghd_val_ir_jul                 NUMBER(15),
    ghd_val_rend_ago               NUMBER(15),
    ghd_val_ded_ago                NUMBER(15),
    ghd_val_ir_ago                 NUMBER(15),
    ghd_val_rend_set               NUMBER(15),
    ghd_val_ded_set                NUMBER(15),
    ghd_val_ir_set                 NUMBER(15),
    ghd_val_rend_out               NUMBER(15),
    ghd_val_ded_out                NUMBER(15),
    ghd_val_ir_out                 NUMBER(15),
    ghd_val_rend_nov               NUMBER(15),
    ghd_val_ded_nov                NUMBER(15),
    ghd_val_ir_nov                 NUMBER(15),
    ghd_val_rend_dez               NUMBER(15),
    ghd_val_ded_dez                NUMBER(15),
    ghd_val_ir_dez                 NUMBER(15),
    ghd_val_rend_13                NUMBER(15),
    ghd_val_ded_13                 NUMBER(15),
    ghd_val_ir_13                  NUMBER(15),
    ghd_nom_beneficiario           VARCHAR2(60))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GRH_HST_DIRF

CREATE INDEX idx_cpf ON grh_hst_dirf
  (
    ghd_num_cpf                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for GRH_HST_DIRF

ALTER TABLE grh_hst_dirf
ADD CONSTRAINT grh_hst_dirf_pk PRIMARY KEY (ghd_dat_ano, ghd_num_cpf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.GRH_HST_DIRF

-- Start of DDL Script for Table IFRSRH.GRUPOS_DEPENDENCIAS
-- Generated 9/3/2004 18:54:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE grupos_dependencias
    (gdp_codigo                     NUMBER(2) NOT NULL,
    gdp_descricao                  VARCHAR2(15) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for GRUPOS_DEPENDENCIAS

ALTER TABLE grupos_dependencias
ADD CONSTRAINT gdp_codigo_pk PRIMARY KEY (gdp_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.GRUPOS_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.GRUPOS_OCORRENCIAS_FUNCIONAIS
-- Generated 9/3/2004 18:54:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE grupos_ocorrencias_funcionais
    (gof_codigo                     NUMBER(2) NOT NULL,
    gof_descricao                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for GRUPOS_OCORRENCIAS_FUNCIONAIS

ALTER TABLE grupos_ocorrencias_funcionais
ADD CONSTRAINT gof_codigo_pk PRIMARY KEY (gof_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE grupos_ocorrencias_funcionais
ADD CONSTRAINT gof_descricao_nn CHECK ( GOF_DESCRICAO IS NOT NULL                                                        )
/

-- Comments for GRUPOS_OCORRENCIAS_FUNCIONAIS

COMMENT ON COLUMN grupos_ocorrencias_funcionais.gof_codigo IS 'CÓDIGO SEQUENCIAL DO GRUPO DE OCORRÊNCIAS FUNCIONAIS'
/
COMMENT ON COLUMN grupos_ocorrencias_funcionais.gof_descricao IS 'DESCRIÇÃO DO GRUPO DE OCORRÊNCIAS FUNCIONAIS'
/

-- End of DDL Script for Table IFRSRH.GRUPOS_OCORRENCIAS_FUNCIONAIS

-- Start of DDL Script for Table IFRSRH.GRUPOS_RUBRICAS
-- Generated 9/3/2004 18:55:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE grupos_rubricas
    (gru_codigo                     NUMBER(2) NOT NULL,
    gru_descricao                  VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for GRUPOS_RUBRICAS

ALTER TABLE grupos_rubricas
ADD CONSTRAINT gru_codigo_pk PRIMARY KEY (gru_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for GRUPOS_RUBRICAS

COMMENT ON COLUMN grupos_rubricas.gru_codigo IS 'Código do grupo da rubrica'
/
COMMENT ON COLUMN grupos_rubricas.gru_descricao IS 'Nome do grupo da rubrica'
/

-- End of DDL Script for Table IFRSRH.GRUPOS_RUBRICAS

-- Start of DDL Script for Table IFRSRH.GUIAS
-- Generated 9/3/2004 18:55:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE guias
    (gui_numero                     NUMBER(6) NOT NULL,
    gui_doc_numero                 NUMBER(10) NOT NULL,
    gui_doc_cbe_ben_sigla          VARCHAR2(3) NOT NULL,
    gui_doc_cbe_cre_sequencial     NUMBER(5) NOT NULL,
    gui_data                       DATE NOT NULL,
    gui_valor                      NUMBER(12,2),
    gui_valor_excedente            NUMBER(12,2),
    gui_valor_glosa                NUMBER(12,2),
    gui_autorizada                 VARCHAR2(1) NOT NULL,
    gui_emissao                    DATE,
    gui_emp_numero_matricula       NUMBER(7),
    gui_pvi_sequencial             NUMBER(2),
    gui_cre_sequencial             NUMBER(5),
    gui_tipo_exame                 NUMBER(1),
    gui_cct_codigo                 NUMBER(10) NOT NULL,
    gui_dep_codigo                 NUMBER(4) NOT NULL,
    gui_pvb_adesao                 DATE,
    gui_cre_crm                    VARCHAR2(12),
    gui_cre_cro                    NUMBER(6),
    gui_cre_nome                   VARCHAR2(80),
    gui_crm_esp_tipo               NUMBER(1),
    gui_crm_esp_numero             NUMBER(7),
    gui_valor_participacao         NUMBER(12,2),
    gui_data_pgto_aposentado       DATE,
    gui_nro_recibo_aposentado      NUMBER(10),
    gui_emp_dep_codigo_lotacao     NUMBER(4) NOT NULL,
    gui_valor_excede               NUMBER(12,2),
    gui_mov_participacao           VARCHAR2(1),
    gui_doc_dep_codigo             NUMBER(4) NOT NULL,
    gui_asm_senha                  NUMBER(13))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GUIAS

CREATE INDEX gui_lot_fk ON guias
  (
    gui_emp_dep_codigo_lotacao      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX gui_doc_fk ON guias
  (
    gui_doc_numero                  ASC,
    gui_doc_cbe_ben_sigla           ASC,
    gui_doc_cbe_cre_sequencial      ASC,
    gui_doc_dep_codigo              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX gui_emp_numero_matricula_01_ix ON guias
  (
    gui_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX gui_data_01_ix ON guias
  (
    gui_data                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for GUIAS

ALTER TABLE guias
ADD CONSTRAINT guias_ck_1 CHECK (GUI_TIPO_EXAME IN (1,2,3,4,5,6,7))
/
ALTER TABLE guias
ADD CONSTRAINT gui_pk PRIMARY KEY (gui_doc_numero, gui_doc_cbe_ben_sigla, 
  gui_doc_cbe_cre_sequencial, gui_doc_dep_codigo, gui_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for GUIAS

COMMENT ON COLUMN guias.gui_asm_senha IS 'Senha referente a Autorização feita ao benefício'
/
COMMENT ON COLUMN guias.gui_doc_dep_codigo IS 'Dependecia detentora do documento de cobranca'
/
COMMENT ON COLUMN guias.gui_emp_dep_codigo_lotacao IS 'Dependencia de lotacao do empregado'
/
COMMENT ON COLUMN guias.gui_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/

-- End of DDL Script for Table IFRSRH.GUIAS

-- Start of DDL Script for Table IFRSRH.GUIAS_PROCEDIMENTOS
-- Generated 9/3/2004 18:55:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE guias_procedimentos
    (gpr_gui_numero                 NUMBER(6) NOT NULL,
    gpr_gui_doc_numero             NUMBER(10) NOT NULL,
    gpr_gui_doc_cbe_ben_sigla      VARCHAR2(3) NOT NULL,
    gpr_gui_doc_cbe_cre_sequencial NUMBER(5) NOT NULL,
    gpr_sequencial                 NUMBER(7) NOT NULL,
    gpr_amb_codigo                 NUMBER(7),
    gpr_amb_dv                     NUMBER(1),
    gpr_abo_codigo                 NUMBER(4),
    gpr_valor                      NUMBER(12,2) NOT NULL,
    gpr_valor_excedente            NUMBER(12,2),
    grp_valor_calculado            NUMBER(12,2),
    gpr_trinta                     VARCHAR2(1),
    gpr_trinta_especificacao       VARCHAR2(100),
    gpr_limite_consulta            VARCHAR2(1),
    gpr_qtd                        NUMBER(2),
    gpr_tipo_acomodacao            VARCHAR2(1),
    gpr_valor_trinta               NUMBER(12,2),
    gpr_obs_trinta                 VARCHAR2(500),
    gpr_valor_taxa                 NUMBER(12,2),
    gpr_valor_participacao         NUMBER(12,2),
    gpr_valor_excede               NUMBER(12,2),
    gpr_mov_participacao           VARCHAR2(1),
    gpr_ind_pericia                VARCHAR2(1),
    gpr_qtd_periodo                NUMBER(2),
    gpr_ind_inss                   VARCHAR2(1),
    gpr_gui_doc_dep_codigo         NUMBER(4) NOT NULL,
    gpr_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for GUIAS_PROCEDIMENTOS

CREATE INDEX gpr_gui_fk ON guias_procedimentos
  (
    gpr_gui_doc_numero              ASC,
    gpr_gui_doc_cbe_ben_sigla       ASC,
    gpr_gui_doc_cbe_cre_sequencial  ASC,
    gpr_gui_doc_dep_codigo          ASC,
    gpr_gui_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for GUIAS_PROCEDIMENTOS

ALTER TABLE guias_procedimentos
ADD CONSTRAINT gpr_pk PRIMARY KEY (gpr_gui_doc_numero, gpr_gui_doc_cbe_ben_sigla, 
  gpr_gui_doc_cbe_cre_sequencial, gpr_gui_doc_dep_codigo, gpr_gui_numero, 
  gpr_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE guias_procedimentos
ADD CONSTRAINT gpr_status_internacao_ck CHECK (gpr_status_internacao in('S','N'))
/

-- Comments for GUIAS_PROCEDIMENTOS

COMMENT ON COLUMN guias_procedimentos.gpr_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/
COMMENT ON COLUMN guias_procedimentos.gpr_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.GUIAS_PROCEDIMENTOS

-- Start of DDL Script for Table IFRSRH.HIERARQUIA_AGENDA
-- Generated 9/3/2004 18:55:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE hierarquia_agenda
    (uor_codigo                     NUMBER(9),
    uor_nome                       VARCHAR2(100),
    emp_qfu_fun_codigo             NUMBER(3),
    fun_nome                       VARCHAR2(60),
    emp_nome                       VARCHAR2(60),
    ordem                          NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for HIERARQUIA_AGENDA

COMMENT ON TABLE hierarquia_agenda IS 'Esta tabela armazena os empregados com sua hierarquia na Empresa.'
/
COMMENT ON COLUMN hierarquia_agenda.emp_nome IS 'Nome do Empregado'
/
COMMENT ON COLUMN hierarquia_agenda.emp_qfu_fun_codigo IS 'Código da Função do Empregado'
/
COMMENT ON COLUMN hierarquia_agenda.fun_nome IS 'Nome da Função do Empregado'
/
COMMENT ON COLUMN hierarquia_agenda.ordem IS 'Hierarquia da Função na INFRAERO'
/
COMMENT ON COLUMN hierarquia_agenda.uor_codigo IS 'Código da Unidade Organizacional'
/
COMMENT ON COLUMN hierarquia_agenda.uor_nome IS 'Nome da Unidade Organizacional'
/

-- End of DDL Script for Table IFRSRH.HIERARQUIA_AGENDA

-- Start of DDL Script for Table IFRSRH.HIST_DETALHE_DEV_ANS
-- Generated 9/3/2004 18:55:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE hist_detalhe_dev_ans
    (hdd_hda_dt_carga_arq           DATE NOT NULL,
    hdd_hda_cod_usuario            VARCHAR2(10) NOT NULL,
    hdd_hda_nome_arquivo           VARCHAR2(30) NOT NULL,
    hdd_ind_tipo_reg               NUMBER(1) NOT NULL,
    hdd_sequencial                 NUMBER(7) NOT NULL,
    hdd_ind_erro_atualizacao       NUMBER(1),
    hdd_codigo_beneficiario        VARCHAR2(30),
    hdd_ind_erro_oper_detalhe      NUMBER(1),
    hdd_ind_erro_num_reg           NUMBER(1),
    hdd_ind_erro_data_adesao       NUMBER(1),
    hdd_ind_erro_data_cancel       NUMBER(1),
    hdd_ind_erro_pis_pasep         NUMBER(1),
    hdd_ind_erro_data_nasc         NUMBER(1),
    hdd_ind_erro_nome_benef        NUMBER(1),
    hdd_ind_erro_nome_mae          NUMBER(1),
    hdd_ind_erro_sexo              NUMBER(1),
    hdd_ind_erro_cpf               NUMBER(1),
    hdd_ind_erro_logradouro        NUMBER(1),
    hdd_ind_erro_num_endereco      NUMBER(1),
    hdd_ind_erro_comp_end          NUMBER(1),
    hdd_ind_erro_bairro            NUMBER(1),
    hdd_ind_erro_municipio         NUMBER(1),
    hdd_ind_erro_uf_endereco       NUMBER(1),
    hdd_ind_erro_cep               NUMBER(1),
    hdd_ind_erro_seg_assist        NUMBER(1),
    hdd_ind_erro_abrangencia       NUMBER(1),
    hdd_ind_erro_tp_contrato       NUMBER(1),
    hdd_ind_erro_tit_vinc          NUMBER(1),
    hdd_ind_erro_exc_benef         NUMBER(1),
    hdd_ind_erro_exis_co_part      NUMBER(1),
    hdd_ind_erro_exis_cob_par      NUMBER(1),
    hdd_ind_erro_itens_rol         NUMBER(1),
    hdd_ind_erro_dt_term_cob       NUMBER(1),
    hdd_ind_erro_proc_exc          NUMBER(1),
    hda_reservado                  VARCHAR2(52),
    hda_branco                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HIST_DETALHE_DEV_ANS

ALTER TABLE hist_detalhe_dev_ans
ADD CONSTRAINT hdd_pk PRIMARY KEY (hdd_hda_dt_carga_arq, hdd_hda_cod_usuario, 
  hdd_hda_nome_arquivo, hdd_ind_tipo_reg, hdd_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HIST_DETALHE_DEV_ANS

COMMENT ON COLUMN hist_detalhe_dev_ans.hda_branco IS 'EM BRANCO - PODE SER UTILIZADO PARA ALGUMA INFORMAÇÃO ADICIONAL (DIFERENTE DO ESPAÇO RESERVADO)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hda_reservado IS 'RESERVADO PARA ALGUMA OBSERVAÇÃO (VERIFICAR TIPO DE REGISTRO: 0 - INFORMAÇÃO DE HEADER ; 9 - INFORMAÇÃO DE TRAILLER)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_codigo_beneficiario IS 'CÓDIGO DO BENEFÍCIO (MATRÍCULA OU MATRÍCULA E SEQUENCIAL DEPENDENTE)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_hda_cod_usuario IS 'CÓDIGO DO USUÁRIO QUE EFETUOU A CARGA'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_hda_dt_carga_arq IS 'DATA DA CARGA DO ARQUIVO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_hda_nome_arquivo IS 'NOME DO ARQUIVO RECEBIDO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_abrangencia IS 'INDICADOR DE ERRO NA ABRANGÊNCIA GEOGRÁFICA DO PLANO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_atualizacao IS 'INDICADOR DE ERRO NA ATUALIZAÇÃO DO ARQUIVO (QUANDO O SEQUENCIAL DA TABELA MÃE FOR MAIOR QUE 1)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_bairro IS 'INDICADOR DE ERRO NO BAIRRO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_cep IS 'INDICADOR DE ERRO NO CEP DO ENDEREÇO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_comp_end IS 'INDICADOR DE ERRO NO COMPLEMENTO DO ENDEREÇO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_cpf IS 'INDICADOR DE ERRO NO NÚMERO DO CPF DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_data_adesao IS 'INDICADOR DE ERRO NA DATA DE ADESÃO DO PAMI'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_data_cancel IS 'INDICADOR DE ERRO NA DATA DE CANCELAMENTO DO PAMI'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_data_nasc IS 'INDICADOR DE ERRO NA DATA DE NASCIMENTO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_dt_term_cob IS 'INDICADOR DE ERRO NA DATA DE TERMINO DA COBERTURA PARCIAL TEMPORÁRIA'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_exc_benef IS 'INDICADOR DE ERRO NA EXCLUSÃO DO BENEFICIÁRIO DA CARTEIRA DA OPERADORA'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_exis_co_part IS 'INDICADOR DE ERRO NA EXISTENCIA DE CO-PARTICIPACAO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_exis_cob_par IS 'INDICADOR DE ERRO NA COBERTURA DO PARCIAL TEMPORÁRIA'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_itens_rol IS 'INDICADOR DE ERRO NOS ITENS DO ROLS DE PROCEDIMENTOS'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_logradouro IS 'INDICADOR DE ERRO NO ENDEREÇO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_municipio IS 'INDICADOR DE ERRO NO MUNICÍPIO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_nome_benef IS 'INDICADOR DE ERRO NO NOME DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_nome_mae IS 'INDICADOR DE ERRO NO NOME DA MÃE DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_num_endereco IS 'INDICADOR DE ERRO NO NÚMERO DO ENDEREÇO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_num_reg IS 'INDICADOR DE ERRO NO NÚMERO DO REGISTRO NO PLANO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_oper_detalhe IS 'INDICADOR DE ERRO NO TIPO DE OPERAÇÃO NO DETALHE'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_pis_pasep IS 'INDICADOR DE ERRO NO NÚMERO DO PIS/PASEP'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_proc_exc IS 'INDICADOR DE ERRO NOS ITENS DE PROCEDIMENTOS QUE SÃO EXCLUÍDOS DA COBERTURA DO PLANO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_seg_assist IS 'INDICADOR DE ERRO NO SEGMENTO ASSISTENCIAL DE COBERTURA DO PLANO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_sexo IS 'INDICADOR DE ERRO NO SEXO DO BENEFÍCIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_tit_vinc IS 'INDICADOR DE ERRO NO TIPO DE VÍNCULO (TITULAR OU VINCULADO)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_tp_contrato IS 'INDICADOR DE ERRO NO TIPO DE CONTRATAÇÃO DO PLANO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_erro_uf_endereco IS 'INDICADOR DE ERRO NA UF DO ENDEREÇO DO BENEFICIÁRIO'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_ind_tipo_reg IS 'TIPO DE REGISTRO (EX.: 0 - HEADER; 9 - TRAILLER)'
/
COMMENT ON COLUMN hist_detalhe_dev_ans.hdd_sequencial IS 'SEQUENCIAL ENVIADO NO ARQUIVO (INCREMENTAL)'
/

-- End of DDL Script for Table IFRSRH.HIST_DETALHE_DEV_ANS

-- Start of DDL Script for Table IFRSRH.HIST_PERICUL_INSALUB
-- Generated 9/3/2004 18:55:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE hist_pericul_insalub
    (hpi_emp_numero_matricula       NUMBER(7) NOT NULL,
    hpi_data_inicio                DATE NOT NULL,
    hpi_ind_pericul_insalub        VARCHAR2(1) NOT NULL,
    hpi_percentual                 NUMBER(2) NOT NULL,
    hpi_data_termino               DATE,
    hpi_data_inclusao              DATE NOT NULL,
    hpi_documento_inicio           VARCHAR2(30) NOT NULL,
    hpi_documento_termino          VARCHAR2(30),
    hpi_resumo                     VARCHAR2(200),
    hpi_data_cancelamento          DATE,
    hpi_documento_cancelamento     VARCHAR2(30),
    hpi_observacao                 VARCHAR2(200),
    hpi_data_autorizacao_sede      DATE,
    hpi_data_autorizacao_sr        DATE,
    hpi_cod_resp_autorizacao_sede  VARCHAR2(10),
    hpi_cod_resp_autorizacao_sr    VARCHAR2(10),
    hpi_data_retirada_movim        DATE,
    hpi_cod_resp_retirada_movim    VARCHAR2(10),
    hpi_motivo_retirada_movim      VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HIST_PERICUL_INSALUB

ALTER TABLE hist_pericul_insalub
ADD CONSTRAINT hpi_ck_1 CHECK (  HPI_IND_PERICUL_INSALUB in ('P','I')                                            )
/
ALTER TABLE hist_pericul_insalub
ADD CONSTRAINT hpi_pk PRIMARY KEY (hpi_emp_numero_matricula, hpi_data_inicio, 
  hpi_ind_pericul_insalub)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HIST_PERICUL_INSALUB

COMMENT ON COLUMN hist_pericul_insalub.hpi_cod_resp_autorizacao_sede IS 'Código do usuário do banco de dados do empregado da SEDE responsável pela autorização da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN hist_pericul_insalub.hpi_cod_resp_autorizacao_sr IS 'Código do usuário do banco de dados do empregado da SR (Superintendência Regional) responsável pela autorização da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN hist_pericul_insalub.hpi_data_autorizacao_sede IS 'Data em que a periculosidade ou insalubridade foi autorizada pela SEDE.'
/
COMMENT ON COLUMN hist_pericul_insalub.hpi_data_autorizacao_sr IS 'Data em que a periculosidade ou insalubridade foi autorizada pela SR (Superintendência Regional).'
/

-- End of DDL Script for Table IFRSRH.HIST_PERICUL_INSALUB

-- Start of DDL Script for Table IFRSRH.HISTORICO_ANS
-- Generated 9/3/2004 18:56:04 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_ans
    (han_ans_dt_gera_arq            DATE NOT NULL,
    han_ans_cod_arq                NUMBER(7) NOT NULL,
    han_ans_operacao               NUMBER(1) NOT NULL,
    han_ans_beneficiario           VARCHAR2(30) NOT NULL,
    han_emp_numero_matricula       NUMBER(7) NOT NULL,
    han_pvi_sequencial             NUMBER(4),
    han_emb_data_adesao            DATE NOT NULL,
    han_emb_data_exclusao          DATE,
    han_nome_arquivo               VARCHAR2(30) NOT NULL,
    han_cod_usuario_geracao        VARCHAR2(10) NOT NULL,
    han_emp_status                 NUMBER(2),
    han_emp_dep_codigo_fisico      NUMBER(4),
    han_flag_enviado_ans           VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_ANS

ALTER TABLE historico_ans
ADD CONSTRAINT han_ck_01 CHECK (HAN_FLAG_ENVIADO_ANS IN ('S','N'))
/
ALTER TABLE historico_ans
ADD CONSTRAINT historico_ans_pk PRIMARY KEY (han_ans_dt_gera_arq, 
  han_ans_cod_arq, han_ans_operacao, han_ans_beneficiario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HISTORICO_ANS

COMMENT ON TABLE historico_ans IS 'TABELA PARA GUARDAR DADOS ENVIADOS PARA ANS PARA EFEITO DE HISTÓRICO'
/
COMMENT ON COLUMN historico_ans.han_ans_beneficiario IS 'IDENTIFICAÇÃO DO BENEFICIÁRIO FORMADO PELA MATRÍCULA OU MATRÍCULA E CÓDIGO DO DEPENDENTE'
/
COMMENT ON COLUMN historico_ans.han_ans_cod_arq IS 'CÓDIGO SEQUENCIAL DO ARQUVIO ANS GERADO'
/
COMMENT ON COLUMN historico_ans.han_ans_dt_gera_arq IS 'DATA DE GERAÇÃO DO ARQUIVO ANS'
/
COMMENT ON COLUMN historico_ans.han_ans_operacao IS 'TIPO DE OPERAÇÃO ANS (1 - INCLUSÃO; 2 - REINCLUSÃO; 3 - EXCLUSÃO)'
/
COMMENT ON COLUMN historico_ans.han_cod_usuario_geracao IS 'CÓDIGO DO USUÁRIO LOGADO NO SISTEMA QUE GEROU O ARQUIVO'
/
COMMENT ON COLUMN historico_ans.han_emb_data_adesao IS 'DATA DE ADESÃO AO BENEFÍCIO MED'
/
COMMENT ON COLUMN historico_ans.han_emb_data_exclusao IS 'DATA DE BLOQUEIO DO BENEFÍCIO MED'
/
COMMENT ON COLUMN historico_ans.han_emp_dep_codigo_fisico IS 'DEPENDÊNCIA FÍSICA DO EMPREGADO'
/
COMMENT ON COLUMN historico_ans.han_emp_numero_matricula IS 'MATRÍCULA DO EMPREGADO'
/
COMMENT ON COLUMN historico_ans.han_emp_status IS 'STATUS DO EMPREGADO (0 - AFASTADO; 1 - ATIVO; 2 - DESLIGADO)'
/
COMMENT ON COLUMN historico_ans.han_flag_enviado_ans IS 'INDICAÇÃO DE ARQUIVO ENVIADO PARA A ANS VIA INTERNET'
/
COMMENT ON COLUMN historico_ans.han_nome_arquivo IS 'NOME DO ARQUIVO GERADO E ENVIADO À ANS'
/
COMMENT ON COLUMN historico_ans.han_pvi_sequencial IS 'CÓDIGO DO DEPENDENTE'
/

-- End of DDL Script for Table IFRSRH.HISTORICO_ANS

-- Start of DDL Script for Table IFRSRH.HISTORICO_CARGOS_DEPENDENCIAS
-- Generated 9/3/2004 18:56:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_cargos_dependencias
    (hcd_dep_codigo                 NUMBER(4) NOT NULL,
    hcd_data_vigencia              DATE NOT NULL,
    hcd_documento_legal            VARCHAR2(50) NOT NULL,
    qcd_quant_aprov_total          NUMBER(5),
    qcd_quant_existente_total      NUMBER(5),
    qcd_quant_disp_total           NUMBER(5),
    qcd_quant_ideal_aprov_total    NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_CARGOS_DEPENDENCIAS

ALTER TABLE historico_cargos_dependencias
ADD CONSTRAINT hcd_pk PRIMARY KEY (hcd_dep_codigo, hcd_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICO_CARGOS_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.HISTORICO_CARGOS_LOTACAO
-- Generated 9/3/2004 18:56:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_cargos_lotacao
    (icl_hcd_dep_codigo             NUMBER(4) NOT NULL,
    icl_hcd_data_vigencia          DATE NOT NULL,
    icl_uor_codigo                 NUMBER(9) NOT NULL,
    icl_data_vigencia              DATE NOT NULL,
    icl_documento_legal            VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_CARGOS_LOTACAO

ALTER TABLE historico_cargos_lotacao
ADD CONSTRAINT icl_pk PRIMARY KEY (icl_uor_codigo, icl_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICO_CARGOS_LOTACAO

-- Start of DDL Script for Table IFRSRH.HISTORICO_DEVOLUCAO_ANS
-- Generated 9/3/2004 18:56:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_devolucao_ans
    (hda_dt_carga_arq               DATE NOT NULL,
    hda_cod_usuario                VARCHAR2(10) NOT NULL,
    hda_nome_arquivo               VARCHAR2(30) NOT NULL,
    hda_flag_corrigido             VARCHAR2(1),
    hda_data_geracao               NUMBER(8),
    hda_codigo_operadora           NUMBER(6),
    hda_cnpj_operadora             NUMBER(14),
    hda_seq_arq_enviado            NUMBER(7),
    hda_flag_erro                  NUMBER(1),
    hda_flag_erro_seq              NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_DEVOLUCAO_ANS

ALTER TABLE historico_devolucao_ans
ADD CONSTRAINT hda_pk PRIMARY KEY (hda_dt_carga_arq, hda_cod_usuario, 
  hda_nome_arquivo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HISTORICO_DEVOLUCAO_ANS

COMMENT ON COLUMN historico_devolucao_ans.hda_cnpj_operadora IS 'CNPJ DA OPERADORA'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_cod_usuario IS 'USUÁRIO QUE EFETUOU A CARGA'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_codigo_operadora IS 'CÓDIGO DA OPERADORA (EX.: 40089-1 - INFRAERO)'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_data_geracao IS 'DATA DE GERAÇÃO DO ARQUIVO QUE FOI ENVIADO'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_dt_carga_arq IS 'DATA DA CARGA DO ARQUIVO NA TABELA'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_flag_corrigido IS 'INDICAÇÃO SE INFORMAÇÃO DESTE ARQUIVO JÁ FOI CORRIGIDA PARA ENVIAR NOVAMENTE'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_flag_erro IS 'INDICADOR DE ERRO NO HEADER OU TRAILLER (SE TIPO DE REGISTRO 0 - HEADER; 9 - TRAILLER)'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_flag_erro_seq IS 'INDICADOR DE ERRO NO SEQUENCIAL DO ARQUIVO'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_nome_arquivo IS 'NOME DO ARQUIVO ENVIADO COM EXTENSÃO(.DVL)'
/
COMMENT ON COLUMN historico_devolucao_ans.hda_seq_arq_enviado IS 'SEQUENCIAL DO ARQUIVO ENVIADO'
/

-- End of DDL Script for Table IFRSRH.HISTORICO_DEVOLUCAO_ANS

-- Start of DDL Script for Table IFRSRH.HISTORICO_EMPREGADOS_BENEF
-- Generated 9/3/2004 18:56:39 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_empregados_benef
    (heb_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    heb_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    heb_data_adesao                DATE NOT NULL,
    heb_emb_validade               DATE,
    heb_emb_opcao                  VARCHAR2(1),
    heb_tipo                       NUMBER(1),
    heb_emb_data_exclusao          DATE,
    heb_documento                  VARCHAR2(300),
    heb_emb_opcao_alim             VARCHAR2(1),
    heb_emb_opcao_ref              VARCHAR2(1),
    heb_emb_qtd_alim               NUMBER(4),
    heb_emb_qtd_ref                NUMBER(4),
    heb_emb_opcao_extra            VARCHAR2(1),
    heb_emb_opcao_bonus            VARCHAR2(1),
    heb_emb_opcao_cba              VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_EMPREGADOS_BENEF

ALTER TABLE historico_empregados_benef
ADD CONSTRAINT heb_emb_opcao_bonus_ck CHECK (HEB_EMB_OPCAO_BONUS IN ('A','R'))
/
ALTER TABLE historico_empregados_benef
ADD CONSTRAINT heb_emb_opcao_cba_ck CHECK (HEB_EMB_OPCAO_CBA in('A','R'))
/
ALTER TABLE historico_empregados_benef
ADD CONSTRAINT heb_emb_opcao_extra_ck CHECK (HEB_EMB_OPCAO_EXTRA IN ('A','R'))
/
ALTER TABLE historico_empregados_benef
ADD CONSTRAINT heb_pk PRIMARY KEY (heb_emb_ben_sigla, 
  heb_emb_emp_numero_matricula, heb_data_adesao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HISTORICO_EMPREGADOS_BENEF

COMMENT ON COLUMN historico_empregados_benef.heb_emb_opcao_cba IS 'CAMPO PARA INFORMAR A OPÇÃO DO EMPREGADO PARA RECEBIMENTO DO VALOR DA CESTA BÁSICA'
/

-- End of DDL Script for Table IFRSRH.HISTORICO_EMPREGADOS_BENEF

-- Start of DDL Script for Table IFRSRH.HISTORICO_GERACAO_TCU
-- Generated 9/3/2004 18:56:46 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_geracao_tcu
    (hgt_dt_referencia_geracao      DATE NOT NULL,
    hgt_emp_numero_matricula       NUMBER(7),
    hgt_dt_geracao                 DATE,
    hgt_flg_tipo_geracao           VARCHAR2(1) NOT NULL,
    hgt_flg_movimento_fechado      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_GERACAO_TCU

ALTER TABLE historico_geracao_tcu
ADD CONSTRAINT hgt_ck_1 CHECK ( HGT_FLG_TIPO_GERACAO IN ('A','D'))
/
ALTER TABLE historico_geracao_tcu
ADD CONSTRAINT hgt_ck_2 CHECK ( HGT_FLG_MOVIMENTO_FECHADO IN ('S','N'))
/
ALTER TABLE historico_geracao_tcu
ADD CONSTRAINT hgt_pk PRIMARY KEY (hgt_dt_referencia_geracao, 
  hgt_flg_tipo_geracao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HISTORICO_GERACAO_TCU

COMMENT ON COLUMN historico_geracao_tcu.hgt_dt_geracao IS 'DATA DA GERAÇÃO DO ARQUIVO'
/
COMMENT ON COLUMN historico_geracao_tcu.hgt_dt_referencia_geracao IS 'MES E ANO DE REFERENCIA DOS DADOS'
/
COMMENT ON COLUMN historico_geracao_tcu.hgt_emp_numero_matricula IS 'MATRICULA DO EMPREGADO QUE GEROU O ARQUIVO'
/
COMMENT ON COLUMN historico_geracao_tcu.hgt_flg_movimento_fechado IS 'INDICA SE O MOVIMENTO ESTÁ FECHADO OU ABERTO PERMITINDO REENVIO DE ALTERAÇÕES'
/
COMMENT ON COLUMN historico_geracao_tcu.hgt_flg_tipo_geracao IS 'INDICADOR DO TIPO DE ARQUIVO (A) PARA ADMISSÃO E (D) PARA DESLIGAMENTO'
/

-- End of DDL Script for Table IFRSRH.HISTORICO_GERACAO_TCU

-- Start of DDL Script for Table IFRSRH.HISTORICO_MOVIMENTACAO
-- Generated 9/3/2004 18:56:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_movimentacao
    (mov_ano_referencia             NUMBER(4) NOT NULL,
    mov_mes_referencia             NUMBER(2) NOT NULL,
    mov_versao_pagamento           NUMBER(2) NOT NULL,
    mov_emp_numero_matricula       NUMBER(7) NOT NULL,
    mov_rub_codigo                 NUMBER(4) NOT NULL,
    mov_sequencial                 NUMBER(2) NOT NULL,
    mov_parcela                    NUMBER(3) NOT NULL,
    mov_parcela_atual              NUMBER(3) NOT NULL,
    mov_rub_seq_pagamento          NUMBER(3) NOT NULL,
    mov_emp_dep_codigo_pagto       NUMBER(4) NOT NULL,
    mov_tip_rubrica                VARCHAR2(1) NOT NULL,
    mov_ind_calculo                VARCHAR2(1) NOT NULL,
    mov_ind_exclusivo              VARCHAR2(1) NOT NULL,
    mov_for_codigo                 NUMBER(3),
    mov_parametro                  NUMBER(14,6),
    mov_valor                      NUMBER(11,2),
    mov_ano_ref_diferenca          NUMBER(4),
    mov_mes_ref_diferenca          NUMBER(2),
    mov_pen_codigo                 NUMBER(2),
    mov_pkt_codigo_pedido          NUMBER,
    mov_valor_integral             NUMBER(11,2),
    mov_fun_codigo                 NUMBER(3),
    mov_dias_proporcionalidade     NUMBER(3),
    mov_nsa_codigo_nivel           NUMBER(2),
    mov_oem_emp_numero_matricula   NUMBER(7),
    mov_oem_ofu_codigo             NUMBER(4),
    mov_oem_data_inicio            DATE,
    mov_data_calculo               DATE,
    mov_pem_ben_sigla              VARCHAR2(3),
    mov_tipo_funcao                VARCHAR2(2),
    mov_tipo_parametro             VARCHAR2(1),
    mov_ind_13                     VARCHAR2(1),
    mov_ind_arsaprev               VARCHAR2(1),
    mov_ind_lancamento_liq_negat   VARCHAR2(1),
    mov_nsa_codigo_padrao          VARCHAR2(4),
    mov_nsa_indicador_nivel_escola VARCHAR2(1),
    mov_flg_frequencia             VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for HISTORICO_MOVIMENTACAO

CREATE INDEX hst_mov_dep_ix ON historico_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX hst_mov_emp_idx ON historico_movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX historico_movimentacao_ind1 ON historico_movimentacao
  (
    mov_oem_emp_numero_matricula    ASC,
    mov_oem_ofu_codigo              ASC,
    mov_oem_data_inicio             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX mov_pkt_cod_pedido_ix ON historico_movimentacao
  (
    mov_pkt_codigo_pedido           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for HISTORICO_MOVIMENTACAO

ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_hst_mov_ck_1 CHECK ( mov_tipo_parametro in ('H','D','V','P','Q') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_2 CHECK ( mov_tip_rubrica in ('N','D','E','R') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_3 CHECK ( mov_ind_arsaprev in ('S','N','I') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_4 CHECK ( mov_tipo_funcao in ('FG','RG','DI') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_5 CHECK ( mov_ind_exclusivo in ('S','N') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_6 CHECK ( mov_ind_13 in ('S','N') )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_ck_7 CHECK ( mov_ind_calculo IN ( 'S' , 'N' ) )
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_pk PRIMARY KEY (mov_ano_referencia, mov_mes_referencia, 
  mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo, 
  mov_tip_rubrica, mov_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for HISTORICO_MOVIMENTACAO

COMMENT ON COLUMN historico_movimentacao.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN historico_movimentacao.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN historico_movimentacao.mov_ano_ref_diferenca IS 'Indica o ano referenca à rubrida de diferença ou extorno, lançada na HISTORICO_MOVIMENTACAO do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_ano_referencia IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN historico_movimentacao.mov_data_calculo IS 'Informa a data que foi efetuado o cálculo'
/
COMMENT ON COLUMN historico_movimentacao.mov_dias_proporcionalidade IS 'Indica a quantidade de dias que obedecerá a proporcionalidade do cálculo'
/
COMMENT ON COLUMN historico_movimentacao.mov_emp_dep_codigo_pagto IS 'Indica o código da dependência de pagamento do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_flg_frequencia IS 'Indica se a rubrica é relativa à frequência'
/
COMMENT ON COLUMN historico_movimentacao.mov_for_codigo IS 'Indica o código da formula de calculo da rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_fun_codigo IS 'Indica o código da função do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_ind_13 IS 'Indicador que será utilizado somente no cálculo do 13º, marca as rubricas que foram utilizadas e devem ser retiradas após o cálculo'
/
COMMENT ON COLUMN historico_movimentacao.mov_ind_arsaprev IS 'Indica se a rubrica é relativa ao fundo de pensão da Infraero'
/
COMMENT ON COLUMN historico_movimentacao.mov_ind_calculo IS 'Indica se a rubrica já foi calculada, N - não, S - sim'
/
COMMENT ON COLUMN historico_movimentacao.mov_ind_exclusivo IS 'Indica se a rubrica é lançada exclusivamente pelo sistema'
/
COMMENT ON COLUMN historico_movimentacao.mov_ind_lancamento_liq_negat IS 'Indica se a rubrica é candidata a ser migrada para um próximo mês, após cálculo de dependência e antes do cálculo final'
/
COMMENT ON COLUMN historico_movimentacao.mov_mes_ref_diferenca IS 'Indica o mês referenca à rubrida de diferença ou extorno, lançada na HISTORICO_MOVIMENTACAO do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_mes_referencia IS 'Indica o mês referente ao pagamento'
/
COMMENT ON COLUMN historico_movimentacao.mov_nsa_codigo_nivel IS 'Indica o nível salarial do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_nsa_codigo_padrao IS 'Indica código padrão salarial do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_nsa_indicador_nivel_escola IS 'Indica o nível de escolaridade do empregado'
/
COMMENT ON COLUMN historico_movimentacao.mov_oem_data_inicio IS 'Informa a data início da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_oem_emp_numero_matricula IS 'Informa a matricula do empregado na ocorrência que deu origem à rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_oem_ofu_codigo IS 'Informa o código da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_parametro IS 'Indica o valor do parametro que será ultilizado no cálculo da rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_parcela IS 'Indica a quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN historico_movimentacao.mov_parcela_atual IS 'Indica a parcela atual da quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN historico_movimentacao.mov_pem_ben_sigla IS 'Informa a sigla do tipo de benefício'
/
COMMENT ON COLUMN historico_movimentacao.mov_pen_codigo IS 'Indica o código do pedido de ticket no benefício'
/
COMMENT ON COLUMN historico_movimentacao.mov_rub_codigo IS 'Indica o código de provento ou desconto (rubrica)'
/
COMMENT ON COLUMN historico_movimentacao.mov_rub_seq_pagamento IS 'Indica a sequência de cálculo da rubrica'
/
COMMENT ON COLUMN historico_movimentacao.mov_sequencial IS 'Indica o sequencial da rubrica no mesmo mês'
/
COMMENT ON COLUMN historico_movimentacao.mov_tip_rubrica IS 'Indica o tipo de rubrica, D - diferença, N - normal, E - extorno, R - recibo '
/
COMMENT ON COLUMN historico_movimentacao.mov_tipo_funcao IS 'Indica a sigla da função do empregado, FG, DG, DI'
/
COMMENT ON COLUMN historico_movimentacao.mov_tipo_parametro IS 'Indica o tipo do parametro, H - horas, D - dias, V - valor, P - percentual, Q - quantidade'
/
COMMENT ON COLUMN historico_movimentacao.mov_valor IS 'Indica o valor final da rubrica, utilizando o mov_dias_proporcionalidade'
/
COMMENT ON COLUMN historico_movimentacao.mov_valor_integral IS 'Valor integral da rubrica, valor base para aplicar a proporcionalidade dos cálculos'
/
COMMENT ON COLUMN historico_movimentacao.mov_versao_pagamento IS 'Indica a versão de pagamento dentro do mesmo mês'
/

-- End of DDL Script for Table IFRSRH.HISTORICO_MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.HISTORICO_NIVEIS_SALARIAIS
-- Generated 9/3/2004 18:57:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historico_niveis_salariais
    (hns_nsa_codigo_nivel           NUMBER(2) NOT NULL,
    hns_nsa_codigo_padrao          VARCHAR2(4) NOT NULL,
    hns_nsa_indicador_nivel_escola VARCHAR2(1) NOT NULL,
    hns_data_vigencia              DATE NOT NULL,
    hns_valor_remuneracao          NUMBER(18,2) NOT NULL,
    hns_percentual_participacao    NUMBER(4,2),
    hns_diploma_legal              VARCHAR2(50),
    hns_texto                      VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICO_NIVEIS_SALARIAIS

ALTER TABLE historico_niveis_salariais
ADD CONSTRAINT hns_pk PRIMARY KEY (hns_nsa_codigo_nivel, hns_nsa_codigo_padrao, 
  hns_nsa_indicador_nivel_escola, hns_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICO_NIVEIS_SALARIAIS

-- Start of DDL Script for Table IFRSRH.HISTORICOS_FUNCOES_DEPENDENCIA
-- Generated 9/3/2004 18:57:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historicos_funcoes_dependencia
    (hfd_dep_codigo                 NUMBER(4) NOT NULL,
    hfd_data_vigencia              DATE NOT NULL,
    hfd_documento_legal            VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICOS_FUNCOES_DEPENDENCIA

ALTER TABLE historicos_funcoes_dependencia
ADD CONSTRAINT hfd_pk PRIMARY KEY (hfd_dep_codigo, hfd_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICOS_FUNCOES_DEPENDENCIA

-- Start of DDL Script for Table IFRSRH.HISTORICOS_FUNCOES_LOTACOES
-- Generated 9/3/2004 18:57:38 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historicos_funcoes_lotacoes
    (hfl_uor_codigo                 NUMBER(9) NOT NULL,
    hfl_data_vigencia              DATE NOT NULL,
    hfl_hfd_dep_codigo             NUMBER(4) NOT NULL,
    hfl_hfd_data_vigencia          DATE NOT NULL,
    hfl_documento_legal            VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICOS_FUNCOES_LOTACOES

ALTER TABLE historicos_funcoes_lotacoes
ADD CONSTRAINT hfl_pk PRIMARY KEY (hfl_uor_codigo, hfl_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICOS_FUNCOES_LOTACOES

-- Start of DDL Script for Table IFRSRH.HISTORICOS_PROCESSOS_SINISTROS
-- Generated 9/3/2004 18:57:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE historicos_processos_sinistros
    (hps_sequencial                 NUMBER(7) NOT NULL,
    hps_sin_sequencial             NUMBER(7) NOT NULL,
    hps_emb_emp_numero_matricula   NUMBER(7),
    hps_emb_ben_sigla              VARCHAR2(3),
    hps_bsg_sequencial             NUMBER(7),
    hps_valor_indenizar            NUMBER(15,2),
    hps_valor_indenizado           NUMBER(15,2),
    hpc_valor_correcao             NUMBER(15,2),
    hpc_valor_liquido              NUMBER(15,2),
    hps_numero_cheque              VARCHAR2(20),
    hps_status                     VARCHAR2(1),
    hps_percentual                 NUMBER(5,2),
    hps_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HISTORICOS_PROCESSOS_SINISTROS

ALTER TABLE historicos_processos_sinistros
ADD CONSTRAINT hps_pk PRIMARY KEY (hps_sequencial, hps_sin_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HISTORICOS_PROCESSOS_SINISTROS

-- Start of DDL Script for Table IFRSRH.HONORARIOS_MEDICOS
-- Generated 9/3/2004 18:57:54 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE honorarios_medicos
    (hnm_sequencial                 NUMBER(7) NOT NULL,
    hnm_gpr_gui_numero             NUMBER(6) NOT NULL,
    hnm_gpr_gui_doc_numero         NUMBER(10) NOT NULL,
    hnm_gpr_gui_doc_cbe_ben_sigla  VARCHAR2(3) NOT NULL,
    hnm_gpr_gui_doc_cbe_cre_seq    NUMBER(5) NOT NULL,
    hnm_gpr_sequencial             NUMBER(7) NOT NULL,
    hnm_tipo_acomodacao            VARCHAR2(1) NOT NULL,
    hnm_qtd_visita                 NUMBER(3),
    hnm_honor_valor_informado      NUMBER(12,2),
    hnm_honor_valor_glosa          NUMBER(12,2),
    hnm_honor_valor_calculado      NUMBER(12,2),
    hnm_cro_crm                    NUMBER(6),
    hnm_aux1_valor_informado       NUMBER(12,2),
    hnm_aux1_valor_glosa           NUMBER(12,2),
    hnm_aux1_valor_calculado       NUMBER(12,2),
    hnm_aux2_valor_informado       NUMBER(12,2),
    hnm_aux2_valor_glosa           NUMBER(12,2),
    hnm_aux2_valor_calculado       NUMBER(12,2),
    hnm_aux3_valor_informado       NUMBER(12,2),
    hnm_aux3_valor_glosa           NUMBER(12,2),
    hnm_aux3_valor_calculado       NUMBER(12,2),
    hnm_anest_valor_informado      NUMBER(12,2),
    hnm_anest_valor_glosa          NUMBER(12,2),
    hnm_anest_valor_calculado      NUMBER(12,2),
    hnm_honor_valor_taxa           NUMBER(12,2),
    hnm_aux1_valor_taxa            NUMBER(12,2),
    hnm_aux2_valor_taxa            NUMBER(12,2),
    hnm_aux3_valor_taxa            NUMBER(12,2),
    hnm_anest_valor_taxa           NUMBER(12,2),
    hnm_gpr_gui_doc_dep_codigo     NUMBER(4) NOT NULL,
    hnm_data_internacao            DATE,
    hnm_data_alta                  DATE,
    hnm_ind_obito_emp              VARCHAR2(1),
    hnm_ind_obito_dependente       VARCHAR2(1),
    hnm_recem_nascido              NUMBER(1),
    hnm_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HONORARIOS_MEDICOS

ALTER TABLE honorarios_medicos
ADD CONSTRAINT hnm_pk PRIMARY KEY (hnm_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE honorarios_medicos
ADD CONSTRAINT hnm_status_internacao_ck CHECK (hnm_status_internacao in('S','N'))
/

-- Comments for HONORARIOS_MEDICOS

COMMENT ON COLUMN honorarios_medicos.hnm_anest_valor_taxa IS 'Valor da taxa sobre o honorario do anestesista'
/
COMMENT ON COLUMN honorarios_medicos.hnm_aux1_valor_taxa IS 'Valor da taxa sobre o honorario do primeiro auxiliar'
/
COMMENT ON COLUMN honorarios_medicos.hnm_aux2_valor_taxa IS 'Valor da taxa sobre o honorario do segundo auxiliar'
/
COMMENT ON COLUMN honorarios_medicos.hnm_aux3_valor_taxa IS 'Valor da taxa sobre o  honorario do terceiro auxiliar'
/
COMMENT ON COLUMN honorarios_medicos.hnm_data_alta IS 'DATA DA ALTA'
/
COMMENT ON COLUMN honorarios_medicos.hnm_data_internacao IS 'DATA DA INTERNACAO'
/
COMMENT ON COLUMN honorarios_medicos.hnm_honor_valor_taxa IS 'Valor da taxa sobre o honorario medico'
/
COMMENT ON COLUMN honorarios_medicos.hnm_ind_obito_dependente IS 'INDICA SE O DEPENDENTE FALECEU '
/
COMMENT ON COLUMN honorarios_medicos.hnm_ind_obito_emp IS 'INDICA SE O EMPREGADO FALECEU'
/
COMMENT ON COLUMN honorarios_medicos.hnm_recem_nascido IS 'INFORMAÇÃO DA CONDIÇÃO DE NASCIMENTO DO RECEM-NASCIDO'
/
COMMENT ON COLUMN honorarios_medicos.hnm_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.HONORARIOS_MEDICOS

-- Start of DDL Script for Table IFRSRH.HORARIOS_FREQUENCIA
-- Generated 9/3/2004 18:58:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE horarios_frequencia
    (hfr_dep_codigo                 NUMBER(4) NOT NULL,
    hfr_cod_horario                NUMBER(3) NOT NULL,
    hfr_turno_trabalho             VARCHAR2(1) NOT NULL,
    hfr_jornada_mensal             NUMBER(3),
    hfr_jornada_diaria             NUMBER(1),
    hfr_tipo_intervalo             VARCHAR2(1),
    hfr_horario_entrada            VARCHAR2(5),
    hfr_inicio_intervalo           VARCHAR2(5),
    hfr_termino_intervalo          VARCHAR2(5),
    hfr_horario_saida              VARCHAR2(5),
    hfr_gera_hor_ext_aut_int       VARCHAR2(1),
    hfr_comput_hor_ext_maior_144   VARCHAR2(1),
    hfr_hora_reduzida              VARCHAR2(5),
    hfr_hora_reduzida_trabalhada   VARCHAR2(1),
    hfr_hora_reduzida_ad_noturno   VARCHAR2(5),
    hfr_hor_red_hor_ext_noturna    VARCHAR2(5),
    hfr_acordo_especifico          VARCHAR2(1),
    hfr_aco_espec_hor_ext_diurna   VARCHAR2(5),
    hfr_aco_espec_hor_ext_noturna  VARCHAR2(5),
    hfr_tipo_acordo_especifico     VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HORARIOS_FREQUENCIA

ALTER TABLE horarios_frequencia
ADD CONSTRAINT hfr_dct_pk PRIMARY KEY (hfr_dep_codigo, hfr_cod_horario, 
  hfr_turno_trabalho)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HORARIOS_FREQUENCIA

-- Start of DDL Script for Table IFRSRH.HORARIOS_TRABALHO_DEP
-- Generated 9/3/2004 18:58:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE horarios_trabalho_dep
    (htd_dep_codigo                 NUMBER(4) NOT NULL,
    htd_htr_codigo                 NUMBER(2) NOT NULL,
    htd_tipo                       NUMBER(1),
    htd_sequencial                 NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for HORARIOS_TRABALHO_DEP

CREATE INDEX htd_dep_fk_i ON horarios_trabalho_dep
  (
    htd_dep_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX htd_htr_fk_i ON horarios_trabalho_dep
  (
    htd_htr_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for HORARIOS_TRABALHO_DEP

ALTER TABLE horarios_trabalho_dep
ADD CONSTRAINT htd_pk PRIMARY KEY (htd_dep_codigo, htd_htr_codigo, 
  htd_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE horarios_trabalho_dep
ADD CONSTRAINT htd_tipo_ck CHECK ( HTD_TIPO IN (1,2,3,4,NULL)                                                       )
/

-- End of DDL Script for Table IFRSRH.HORARIOS_TRABALHO_DEP

-- Start of DDL Script for Table IFRSRH.HORARIOS_TRABALHOS
-- Generated 9/3/2004 18:58:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE horarios_trabalhos
    (htr_codigo                     NUMBER(2) NOT NULL,
    htr_hora_inicio                VARCHAR2(5) NOT NULL,
    htr_hora_termino               VARCHAR2(5) NOT NULL,
    htr_hora_inicio_intervalo      VARCHAR2(5),
    htr_hora_termino_intervalo     VARCHAR2(5),
    htr_sigla                      VARCHAR2(10),
    htr_duracao_intervalo          VARCHAR2(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HORARIOS_TRABALHOS

ALTER TABLE horarios_trabalhos
ADD CONSTRAINT htr_pk PRIMARY KEY (htr_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE horarios_trabalhos
ADD CONSTRAINT htr_uk UNIQUE (htr_hora_inicio, htr_hora_termino, 
  htr_hora_inicio_intervalo, htr_hora_termino_intervalo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HORARIOS_TRABALHOS

-- Start of DDL Script for Table IFRSRH.HST_DEPENDENCIA_EMPREGADO
-- Generated 9/3/2004 18:58:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE hst_dependencia_empregado
    (hde_emp_numero_matricula       NUMBER(7) NOT NULL,
    hde_ano_referencia             NUMBER(4) NOT NULL,
    hde_mes_referencia             NUMBER(2) NOT NULL,
    hde_dep_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for HST_DEPENDENCIA_EMPREGADO

ALTER TABLE hst_dependencia_empregado
ADD CONSTRAINT hst_dep_emp_pk PRIMARY KEY (hde_emp_numero_matricula, 
  hde_ano_referencia, hde_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.HST_DEPENDENCIA_EMPREGADO

-- Start of DDL Script for Table IFRSRH.IMPOSTOS_RENDAS
-- Generated 9/3/2004 18:58:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE impostos_rendas
    (imr_faixa                      NUMBER(1) NOT NULL,
    imr_renda_maxima               NUMBER(12,2) NOT NULL,
    imr_valor_a_deduzir            NUMBER(11,2) NOT NULL,
    imr_aliquota                   NUMBER(5,2),
    imr_ano_referencia             NUMBER(4) NOT NULL,
    imr_mes_referencia             NUMBER(2) NOT NULL,
    imr_vlr_deducao_dep            NUMBER(11,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IMPOSTOS_RENDAS

ALTER TABLE impostos_rendas
ADD CONSTRAINT imr_pk PRIMARY KEY (imr_faixa, imr_ano_referencia, 
  imr_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IMPOSTOS_RENDAS

COMMENT ON TABLE impostos_rendas IS '- Retrofitted'
/

-- End of DDL Script for Table IFRSRH.IMPOSTOS_RENDAS

-- Start of DDL Script for Table IFRSRH.INCIDENCIAS_RUBRICAS
-- Generated 9/3/2004 18:58:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE incidencias_rubricas
    (iru_rub_codigo                 NUMBER(4) NOT NULL,
    iru_rub_codigo_incide          NUMBER(4) NOT NULL,
    data_inicio                    DATE NOT NULL,
    data_termino                   DATE,
    iru_tip_normal                 VARCHAR2(1),
    iru_tip_diferenca              VARCHAR2(1),
    iru_tip_estorno_dev            VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for INCIDENCIAS_RUBRICAS

ALTER TABLE incidencias_rubricas
ADD CONSTRAINT iru_pk PRIMARY KEY (iru_rub_codigo, iru_rub_codigo_incide, 
  data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for INCIDENCIAS_RUBRICAS

COMMENT ON COLUMN incidencias_rubricas.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN incidencias_rubricas.dta_operacao IS 'Indica a data e hora da transação'
/

-- End of DDL Script for Table IFRSRH.INCIDENCIAS_RUBRICAS

-- Start of DDL Script for Table IFRSRH.INDENIZACOES
-- Generated 9/3/2004 18:59:04 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE indenizacoes
    (idn_sequencial                 NUMBER(3) NOT NULL,
    idn_discriminacao              VARCHAR2(100) NOT NULL,
    idn_percentual                 NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for INDENIZACOES

ALTER TABLE indenizacoes
ADD CONSTRAINT idn_sequencial_pk PRIMARY KEY (idn_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.INDENIZACOES

-- Start of DDL Script for Table IFRSRH.INDEXADORES
-- Generated 9/3/2004 18:59:11 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE indexadores
    (idx_sigla                      VARCHAR2(6) NOT NULL,
    idx_nome                       VARCHAR2(70) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for INDEXADORES

ALTER TABLE indexadores
ADD CONSTRAINT idx_pk PRIMARY KEY (idx_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for INDEXADORES

COMMENT ON COLUMN indexadores.idx_nome IS 'Nome do indexador'
/
COMMENT ON COLUMN indexadores.idx_sigla IS 'Sigla do indexador'
/

-- End of DDL Script for Table IFRSRH.INDEXADORES

-- Start of DDL Script for Table IFRSRH.INDICE_ABSENTEISMO
-- Generated 9/3/2004 18:59:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE indice_absenteismo
    (iab_ano                        NUMBER(4) NOT NULL,
    iab_mes                        NUMBER(2) NOT NULL,
    iab_ofu_codigo                 NUMBER(4) NOT NULL,
    iab_dep_codigo                 NUMBER(4) NOT NULL,
    iab_qtd_dias_ocorrencia        NUMBER(7,1),
    iab_qtd_dias_comp              NUMBER(7))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for INDICE_ABSENTEISMO

ALTER TABLE indice_absenteismo
ADD CONSTRAINT iab_pk PRIMARY KEY (iab_ano, iab_mes, iab_ofu_codigo, 
  iab_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for INDICE_ABSENTEISMO

COMMENT ON TABLE indice_absenteismo IS 'Tabela que contém a quantidade de dias que os empregados tiveram uma ocorrência funcional, sendo a quantidade relacionada a uma "Dependência / Mês / Ano ".'
/
COMMENT ON COLUMN indice_absenteismo.iab_ano IS 'Ano do índice de absenteísmo.'
/
COMMENT ON COLUMN indice_absenteismo.iab_dep_codigo IS 'Código da dependência do índice de absenteísmo.'
/
COMMENT ON COLUMN indice_absenteismo.iab_mes IS 'Mês do índice de absenteísmo.'
/
COMMENT ON COLUMN indice_absenteismo.iab_ofu_codigo IS 'Código da ocorrência funcional de absenteísmo.'
/
COMMENT ON COLUMN indice_absenteismo.iab_qtd_dias_ocorrencia IS 'Quantidade de dias que os empregados tiveram a ocorrência funcional.'
/

-- End of DDL Script for Table IFRSRH.INDICE_ABSENTEISMO

-- Start of DDL Script for Table IFRSRH.INDICES
-- Generated 9/3/2004 18:59:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE indices
    (ind_seq_ind                    NUMBER(10) NOT NULL,
    ind_data_inicio                DATE NOT NULL,
    ind_valor                      NUMBER(12,6) NOT NULL,
    ind_valor2                     NUMBER(12,6),
    ind_data_fim                   DATE,
    ind_fae_ano_ini                NUMBER(3),
    ind_fae_mes_ini                NUMBER(2),
    ind_fae_dia_ini                NUMBER(2),
    ind_fae_ano_fim                NUMBER(3),
    ind_fae_mes_fim                NUMBER(2),
    ind_fae_dia_fim                NUMBER(2),
    ind_observacao                 VARCHAR2(50),
    ind_ben_sigla                  VARCHAR2(3),
    ind_cre_sequencial             NUMBER(5),
    ind_idx_sigla                  VARCHAR2(6) NOT NULL,
    ind_in_participacao            VARCHAR2(1),
    ind_valor_fl                   NUMBER(7,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for INDICES

CREATE INDEX ind_ben_fk_i ON indices
  (
    ind_ben_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ind_cre_fk_i ON indices
  (
    ind_cre_sequencial              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ind_idx_fk_i ON indices
  (
    ind_idx_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for INDICES

ALTER TABLE indices
ADD CONSTRAINT ind_in_participacao_ck CHECK ( ind_in_participacao IN ( 'S' , 'N' )  )
/
ALTER TABLE indices
ADD CONSTRAINT ind_pk PRIMARY KEY (ind_seq_ind)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for INDICES

COMMENT ON COLUMN indices.ind_ben_sigla IS 'Sigla do Beneficio'
/
COMMENT ON COLUMN indices.ind_cre_sequencial IS 'Numero identificador do Credenciado'
/
COMMENT ON COLUMN indices.ind_data_fim IS 'Data final do indice'
/
COMMENT ON COLUMN indices.ind_data_inicio IS 'Data inicio do indice'
/
COMMENT ON COLUMN indices.ind_fae_ano_fim IS 'Qtd. anos da faixa etaria final'
/
COMMENT ON COLUMN indices.ind_fae_ano_ini IS 'Qtd. anos da faixa etaria inicial'
/
COMMENT ON COLUMN indices.ind_fae_dia_fim IS 'Qtd. dias da faixa etaria final'
/
COMMENT ON COLUMN indices.ind_fae_dia_ini IS 'Qtd. de dias da faixa etaria inicial'
/
COMMENT ON COLUMN indices.ind_fae_mes_fim IS 'Qtd. meses da faixa etaria final'
/
COMMENT ON COLUMN indices.ind_fae_mes_ini IS 'Qtd. de meses  da faixa etaria inicial'
/
COMMENT ON COLUMN indices.ind_idx_sigla IS 'Sigla do indexador'
/
COMMENT ON COLUMN indices.ind_observacao IS 'Fonte informadora da alterac?o'
/
COMMENT ON COLUMN indices.ind_valor IS 'Valor do indice'
/

-- End of DDL Script for Table IFRSRH.INDICES

-- Start of DDL Script for Table IFRSRH.INTERFACE_ERROS_PLANO_SAUDE
-- Generated 9/3/2004 18:59:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE interface_erros_plano_saude
    (iep_nome_arquivo               VARCHAR2(3),
    iep_doc_numero                 NUMBER(10),
    iep_doc_cbe_cre_seq            NUMBER(5),
    iep_doc_dep_codigo             NUMBER(5),
    iep_gui_numero                 NUMBER(6),
    iep_gpr_sequencial             NUMBER(7),
    iep_hnm_sequencial             NUMBER(7),
    iep_tdm_sequencial             NUMBER(7),
    iep_dmo_sequencial             NUMBER(7),
    iep_eps_codigo_erro            NUMBER(3),
    iep_int_sequencial             NUMBER(7),
    iep_descricao                  VARCHAR2(250),
    iep_valor                      NUMBER(12,2),
    iep_qtde                       NUMBER(2),
    iep_doc_numero_infraero        NUMBER(11),
    tmp_gui_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for INTERFACE_ERROS_PLANO_SAUDE

COMMENT ON COLUMN interface_erros_plano_saude.tmp_gui_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.INTERFACE_ERROS_PLANO_SAUDE

-- Start of DDL Script for Table IFRSRH.INTERNACAO
-- Generated 9/3/2004 18:59:56 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE internacao
    (int_gui_doc_numero             NUMBER(10) NOT NULL,
    int_gui_doc_cbe_ben_sigla      VARCHAR2(3) NOT NULL,
    int_gui_doc_cbe_cre_sequencial NUMBER(5) NOT NULL,
    int_gui_doc_dep_codigo         NUMBER(4) NOT NULL,
    int_gui_numero                 NUMBER(6) NOT NULL,
    int_sequencial                 NUMBER(7) NOT NULL,
    int_amb_codigo                 NUMBER(7),
    int_amb_dv                     NUMBER(1),
    int_data_internacao            DATE,
    int_data_alta                  DATE,
    int_ind_obito                  VARCHAR2(1),
    int_recem_nascido              NUMBER(1),
    int_ind_ambulatorio            VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for INTERNACAO

ALTER TABLE internacao
ADD CONSTRAINT interna_pk PRIMARY KEY (int_gui_doc_numero, 
  int_gui_doc_cbe_ben_sigla, int_gui_doc_cbe_cre_sequencial, 
  int_gui_doc_dep_codigo, int_gui_numero, int_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for INTERNACAO

COMMENT ON COLUMN internacao.int_amb_codigo IS 'CÓDIGO DO SERVIÇO'
/
COMMENT ON COLUMN internacao.int_amb_dv IS 'DIGITO VERIFICADOR DO CODIGO DO SERVIÇO'
/
COMMENT ON COLUMN internacao.int_data_alta IS 'DATA DA ALTA'
/
COMMENT ON COLUMN internacao.int_data_internacao IS 'DATA DA INTERNACAO'
/
COMMENT ON COLUMN internacao.int_gui_doc_cbe_ben_sigla IS 'SIGLA DO BENEFICIO'
/
COMMENT ON COLUMN internacao.int_gui_doc_cbe_cre_sequencial IS 'CÓDIGO DO CREDENCIADO'
/
COMMENT ON COLUMN internacao.int_gui_doc_dep_codigo IS 'CÓDIGO DA DEPENDENCIA DO DOCUMENTO'
/
COMMENT ON COLUMN internacao.int_gui_doc_numero IS 'NÚMERO DO DOCUMENTO DE COBRANCA'
/
COMMENT ON COLUMN internacao.int_gui_numero IS 'NÚMERO DA GUIA CORRESPONDENTE'
/
COMMENT ON COLUMN internacao.int_ind_ambulatorio IS 'INDICA SE O ATENDIMENTO FOI FEITO NO AMBULATÓRIO'
/
COMMENT ON COLUMN internacao.int_ind_obito IS 'INDICA SE O EMPREGADO/DEPENDENTE  FALECEU'
/
COMMENT ON COLUMN internacao.int_recem_nascido IS 'INFORMAÇÃO DA CONDIÇÃO DE NASCIMENTO DO RECEM-NASCIDO'
/
COMMENT ON COLUMN internacao.int_sequencial IS 'CÓDIGO IDENTIFICADOR DO REGISTRO'
/

-- End of DDL Script for Table IFRSRH.INTERNACAO

-- Start of DDL Script for Table IFRSRH.ITINERARIOS_LINHAS_TRANSPORTES
-- Generated 9/3/2004 19:00:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE itinerarios_linhas_transportes
    (ili_ltf_numero                 NUMBER(5) NOT NULL,
    ili_ltf_dep_codigo             NUMBER(4) NOT NULL,
    ili_sequencial                 NUMBER(7) NOT NULL,
    ili_logradouro                 VARCHAR2(100) NOT NULL,
    ili_horario                    DATE,
    ili_sentido                    VARCHAR2(1),
    ili_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ITINERARIOS_LINHAS_TRANSPORTES

ALTER TABLE itinerarios_linhas_transportes
ADD CONSTRAINT ili_pk PRIMARY KEY (ili_ltf_numero, ili_ltf_dep_codigo, 
  ili_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ITINERARIOS_LINHAS_TRANSPORTES

-- Start of DDL Script for Table IFRSRH.JORNADAS_TRABALHO
-- Generated 9/3/2004 19:00:11 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE jornadas_trabalho
    (jtr_codigo                     NUMBER(1) NOT NULL,
    jtr_quantidade_horas_semanais  DATE,
    jtr_sigla                      VARCHAR2(10),
    jtr_quantidade_horas_mensais   NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for JORNADAS_TRABALHO

ALTER TABLE jornadas_trabalho
ADD CONSTRAINT jtr_codigo_ck CHECK (  jtr_codigo IN ( 4 , 6 , 8 )                                                     )
/
ALTER TABLE jornadas_trabalho
ADD CONSTRAINT jtr_pk PRIMARY KEY (jtr_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.JORNADAS_TRABALHO

-- Start of DDL Script for Table IFRSRH.LICENCA_PREMIO
-- Generated 9/3/2004 19:00:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE licenca_premio
    (lpr_emp_numero_matricula       NUMBER(7) NOT NULL,
    lpr_dt_inicio_periodo_aquis    DATE NOT NULL,
    lpr_dt_termino_periodo_aquis   DATE NOT NULL,
    lpr_data_inicio_1              DATE NOT NULL,
    lpr_data_termino_1             DATE NOT NULL,
    lpr_data_inicio_2              DATE,
    lpr_data_termino_2             DATE,
    lpr_numero_dias_gozo_1         NUMBER(2) NOT NULL,
    lpr_numero_dias_gozo_2         NUMBER(2),
    lpr_documento_1                VARCHAR2(200) NOT NULL,
    lpr_documento_2                VARCHAR2(200),
    lpr_observacao_1               VARCHAR2(200),
    lpr_observacao_2               VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LICENCA_PREMIO

ALTER TABLE licenca_premio
ADD CONSTRAINT lpr_pk PRIMARY KEY (lpr_emp_numero_matricula, 
  lpr_dt_inicio_periodo_aquis)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LICENCA_PREMIO

-- Start of DDL Script for Table IFRSRH.LINHAS_TRANSPORTES_FRETADOS
-- Generated 9/3/2004 19:00:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE linhas_transportes_fretados
    (ltf_numero                     NUMBER(5) NOT NULL,
    ltf_dep_codigo                 NUMBER(4) NOT NULL,
    ltf_tipo                       VARCHAR2(1),
    ltf_itinerario                 VARCHAR2(50) NOT NULL,
    ltf_klm_ida                    NUMBER(6,2) NOT NULL,
    ltf_klm_volta                  NUMBER(6,2) NOT NULL,
    ltf_numero_vagas               NUMBER(3) NOT NULL,
    ltf_flt_emp_numero_matricula   NUMBER(7),
    ltf_numero_faltas              NUMBER(2) NOT NULL,
    ltf_numero_placa               VARCHAR2(8) NOT NULL,
    ltf_marca_modelo               VARCHAR2(25) NOT NULL,
    ltf_ano_fabricacao             VARCHAR2(4) NOT NULL,
    ltf_cre_sequencial             NUMBER(5) NOT NULL,
    ltf_motorista                  VARCHAR2(50),
    ltf_numero_vagas_maxima        NUMBER(3) NOT NULL,
    ltf_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LINHAS_TRANSPORTES_FRETADOS

ALTER TABLE linhas_transportes_fretados
ADD CONSTRAINT ltf_pk PRIMARY KEY (ltf_numero, ltf_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LINHAS_TRANSPORTES_FRETADOS

-- Start of DDL Script for Table IFRSRH.LISTAS_ESPERAS_TRANSPORTES
-- Generated 9/3/2004 19:00:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE listas_esperas_transportes
    (let_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    let_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    let_ltf_numero                 NUMBER(5) NOT NULL,
    let_ltf_dep_codigo             NUMBER(5) NOT NULL,
    let_data_inclusao              DATE NOT NULL,
    let_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LISTAS_ESPERAS_TRANSPORTES

ALTER TABLE listas_esperas_transportes
ADD CONSTRAINT let_pk PRIMARY KEY (let_emb_emp_numero_matricula, 
  let_emb_ben_sigla, let_ltf_numero, let_ltf_dep_codigo, let_data_inclusao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LISTAS_ESPERAS_TRANSPORTES

-- Start of DDL Script for Table IFRSRH.LOCAL_ATENDIMENTO
-- Generated 9/3/2004 19:00:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE local_atendimento
    (loa_cre_sequencial             NUMBER(5) NOT NULL,
    loa_codigo                     NUMBER(3) NOT NULL,
    loa_cidade                     VARCHAR2(50),
    loa_ufe                        VARCHAR2(2),
    loa_dep_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LOCAL_ATENDIMENTO

ALTER TABLE local_atendimento
ADD CONSTRAINT loa_pk PRIMARY KEY (loa_cre_sequencial, loa_codigo, 
  loa_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOCAL_ATENDIMENTO

-- Start of DDL Script for Table IFRSRH.LOG_ABATIMENTO_AVERBACAO
-- Generated 9/3/2004 19:00:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_abatimento_averbacao
    (dat_operacao                   DATE NOT NULL,
    tip_operacao                   VARCHAR2(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL,
    abt_codigo                     NUMBER(2) NOT NULL,
    abt_avb_codigo                 NUMBER(2) NOT NULL,
    abt_avb_emp_numero_matricula   NUMBER(7) NOT NULL,
    abt_data_inicio                DATE NOT NULL,
    abt_data_termino               DATE NOT NULL,
    abt_inc_promocao               VARCHAR2(1) NOT NULL,
    abt_inc_tempo_servico          VARCHAR2(1) NOT NULL,
    abt_inc_aposentadoria          VARCHAR2(1) NOT NULL,
    abt_documento                  VARCHAR2(15) NOT NULL,
    abt_texto                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_ABATIMENTO_AVERBACAO

-- Start of DDL Script for Table IFRSRH.LOG_ATIVIDADES_FUNCOES
-- Generated 9/3/2004 19:00:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_atividades_funcoes
    (atf_fun_codigo                 NUMBER(3) NOT NULL,
    atf_ati_codigo                 NUMBER(4) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LOG_ATIVIDADES_FUNCOES

ALTER TABLE log_atividades_funcoes
ADD CONSTRAINT log_atf_pk PRIMARY KEY (dta_operacao, atf_fun_codigo, 
  atf_ati_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_ATIVIDADES_FUNCOES

-- Start of DDL Script for Table IFRSRH.LOG_AUDIT_DOCUMENTOS_COBRANCA
-- Generated 9/3/2004 19:00:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_audit_documentos_cobranca
    (cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    doc_numero_new                 NUMBER(10),
    doc_cbe_ben_sigla_new          VARCHAR2(3),
    doc_cbe_cre_sequencial_new     NUMBER(5),
    doc_data_new                   DATE,
    doc_tipo_new                   NUMBER(1),
    doc_numero_matricula_new       NUMBER(7),
    doc_pvi_sequencial_new         NUMBER(2),
    doc_dep_codigo_new             NUMBER(4),
    doc_valor_participacao_new     NUMBER(12,2),
    doc_mes_pagamento_new          NUMBER(2),
    doc_ano_pagamento_new          NUMBER(4),
    doc_processo_encerrado_new     VARCHAR2(1),
    doc_nr_doc_fiscal_new          VARCHAR2(15),
    doc_dep_resp_incl_new          NUMBER(4),
    doc_tipo_pedido_new            NUMBER(1),
    doc_sistema_new                VARCHAR2(20),
    doc_data_criacao_new           DATE,
    doc_data_gera_participacao_new DATE,
    doc_numero_old                 NUMBER(10),
    doc_cbe_ben_sigla_old          VARCHAR2(3),
    doc_cbe_cre_sequencial_old     NUMBER(5),
    doc_data_old                   DATE,
    doc_tipo_old                   NUMBER(1),
    doc_numero_matricula_old       NUMBER(7),
    doc_pvi_sequencial_old         NUMBER(2),
    doc_dep_codigo_old             NUMBER(4),
    doc_valor_participacao_old     NUMBER(12,2),
    doc_mes_pagamento_old          NUMBER(2),
    doc_ano_pagamento_old          NUMBER(4),
    doc_processo_encerrado_old     VARCHAR2(1),
    doc_nr_doc_fiscal_old          VARCHAR2(15),
    doc_dep_resp_incl_old          NUMBER(4),
    doc_tipo_pedido_old            NUMBER(1),
    doc_sistema_old                VARCHAR2(20),
    doc_data_criacao_old           DATE,
    doc_dta_gera_participacao_old  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOG_AUDIT_DOCUMENTOS_COBRANCA

CREATE INDEX la_doc_cob_idx ON log_audit_documentos_cobranca
  (
    dta_operacao                    ASC,
    cod_usuario                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Comments for LOG_AUDIT_DOCUMENTOS_COBRANCA

COMMENT ON COLUMN log_audit_documentos_cobranca.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_ano_pagamento_new IS 'Indica o ano da folha em que caiu as participacoes'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_cbe_ben_sigla_new IS 'Indica a qual beneficio pertence o faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_cbe_cre_sequencial_new IS 'Indica a qual credenciados pertence o faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_data_criacao_new IS 'Indica a data de criação do faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_data_new IS 'Indica a qual beneficio pertence o faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_dep_codigo_new IS 'Indica de qual dependencia é o faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_dep_resp_incl_new IS 'Indica a dependencia do responsavel pela inclusao'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_mes_pagamento_new IS 'Indica o mes da folha em que caiu as participacoes'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_nr_doc_fiscal_new IS 'Indica o número do Doc. Fiscal'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_numero_new IS 'Indica o numero do Faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_processo_encerrado_new IS 'Indica se o processo esta ou não encerrado'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_pvi_sequencial_new IS 'Indica o dependente  para qual o pedido foi feito individual'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_sistema_new IS 'Indica qual sistema efetuou a operacao'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_tipo_new IS 'Indica a data da emissão dom Documento Fiscal'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_tipo_pedido_new IS 'Indica o tipo do faturamento'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.doc_valor_participacao_new IS 'Indica o valor da participacao'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN log_audit_documentos_cobranca.tip_operacao IS 'Indica o tipo da transação I - inclusão, E - exclusão, A - Alteração'
/

-- End of DDL Script for Table IFRSRH.LOG_AUDIT_DOCUMENTOS_COBRANCA

-- Start of DDL Script for Table IFRSRH.LOG_AVERBACAO_TSERVICO
-- Generated 9/3/2004 19:01:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_averbacao_tservico
    (dat_operacao                   DATE NOT NULL,
    tip_operacao                   VARCHAR2(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL,
    avb_codigo                     NUMBER(2) NOT NULL,
    avb_emp_numero_matricula       NUMBER(7) NOT NULL,
    avb_codigo_empresa             NUMBER(1) NOT NULL,
    avb_data_inicio                DATE NOT NULL,
    avb_data_termino               DATE NOT NULL,
    avb_inc_promocao               VARCHAR2(1) NOT NULL,
    avb_inc_tempo_servico          VARCHAR2(1) NOT NULL,
    avb_inc_aposentadoria          VARCHAR2(1) NOT NULL,
    avb_documento                  VARCHAR2(15) NOT NULL,
    avb_texto                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_AVERBACAO_TSERVICO

-- Start of DDL Script for Table IFRSRH.LOG_CADASTROS
-- Generated 9/3/2004 19:01:07 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_cadastros
    (emp_numero_cpf                 NUMBER(11) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    emp_numero_matricula_ant       NUMBER(7),
    emp_numero_matricula_tasa      NUMBER(7),
    emp_numero_matricula_arsa      NUMBER(7),
    emp_numero_fre                 NUMBER(5),
    emp_nome                       VARCHAR2(60) NOT NULL,
    emp_nome_abreviado             VARCHAR2(40),
    emp_indicador_sexo             VARCHAR2(1) NOT NULL,
    emp_data_nascimento            DATE NOT NULL,
    emp_indicador_estado_civil     NUMBER(1) NOT NULL,
    emp_nacionalidade              NUMBER(1) NOT NULL,
    emp_endereco_logradouro        VARCHAR2(100) NOT NULL,
    emp_endereco_bairro            VARCHAR2(30),
    emp_jtr_codigo                 NUMBER(1),
    emp_aba_ban_codigo_cta_pgto    VARCHAR2(3) NOT NULL,
    emp_aba_codigo_conta_pgto      VARCHAR2(7) NOT NULL,
    emp_nu_conta_corrente_pagto    VARCHAR2(14),
    emp_eso_codigo                 NUMBER(2) NOT NULL,
    emp_sfu_codigo                 NUMBER(1) NOT NULL,
    emp_nu_registro_estrangeiro    VARCHAR2(10),
    emp_in_classe_registro_estrang NUMBER(1),
    emp_numero_ctps_rne            NUMBER(9),
    emp_nu_serie_ctps_rne          NUMBER(5),
    emp_numero_pis_pasep           NUMBER(11) NOT NULL,
    emp_nu_carteira_identidade     VARCHAR2(15),
    emp_nu_titulo_eleitor          NUMBER(12),
    emp_nu_zona_titulo_eleitor     VARCHAR2(5),
    emp_nu_secao_titulo_eleitor    VARCHAR2(5),
    emp_nu_certificado_reservista  VARCHAR2(12),
    emp_nu_categoria_cr            VARCHAR2(10),
    emp_nu_regiao_militar_cr       VARCHAR2(10),
    emp_tipo_cr                    VARCHAR2(3),
    emp_numero_carteira_trabalho   NUMBER(9),
    emp_numero_serie_carteira_trab NUMBER(6),
    emp_codigo_fgts                NUMBER(10),
    emp_numero_conta_fgts          NUMBER(8),
    emp_aba_ban_codigo_fgts        VARCHAR2(3),
    emp_aba_codigo_fgts            VARCHAR2(7),
    emp_nu_carteira_habilitacao    VARCHAR2(11),
    emp_in_categoria_habilitacao   VARCHAR2(2),
    emp_dt_validade_carteira_hab   DATE,
    emp_nu_habilitacao_lancha      NUMBER(10),
    emp_indicador_categoria_hab    VARCHAR2(1),
    emp_dt_validade_habilit_lancha DATE,
    emp_nu_carteira_orgao_classe   VARCHAR2(11),
    emp_ufe_sigla_reg_profis       VARCHAR2(2),
    emp_pai_codigo                 NUMBER(4),
    emp_oex_codigo_cedido          NUMBER(5),
    emp_oex_codigo_requisitado     NUMBER(5),
    emp_qlp_car_codigo             NUMBER(3),
    emp_qlp_car_codigo_nivel       NUMBER(1),
    emp_qlp_car_occ_codigo         NUMBER(3),
    emp_nsa_codigo_nivel           NUMBER(2),
    emp_nsa_codigo_padrao          VARCHAR2(4),
    emp_qfu_fun_codigo             NUMBER(3),
    emp_tipo_remuneracao_funcao    VARCHAR2(2),
    emp_qfu_fun_codigo_acumula     NUMBER(3),
    emp_tipo_remuner_funcao_acumul VARCHAR2(2),
    emp_qfu_fun_codigo_substitui   NUMBER(3),
    emp_tipo_remuner_funcao_subst  VARCHAR2(2),
    emp_dep_codigo_lotacao         NUMBER(4),
    emp_dep_codigo_pagto           NUMBER(4),
    emp_dep_codigo_fisico          NUMBER(4),
    emp_uor_codigo_lotacao         NUMBER(9),
    emp_indicador_primeiro_emprego VARCHAR2(1),
    emp_ano_primeiro_emprego       NUMBER(4),
    emp_status                     NUMBER(2),
    emp_codigo_rais                VARCHAR2(8),
    emp_tipo_conta                 VARCHAR2(3),
    emp_classe_hab_tecnologica     VARCHAR2(10),
    emp_numero_hab_tecnologica     VARCHAR2(10),
    emp_habilit_orgao_oper         NUMBER(5),
    emp_indicador_depv             VARCHAR2(4),
    emp_numero_depv                NUMBER(5),
    emp_licenca_depv               NUMBER(5),
    emp_data_admissao              DATE,
    emp_ati_ct_custos              NUMBER(10),
    emp_id_aposentadoria           NUMBER(1),
    emp_dt_aposentadoria           DATE,
    emp_plano_arsaprev             NUMBER(1),
    emp_data_filiacao_arsaprev     DATE,
    emp_data_cancelamento_arsaprev DATE,
    emp_contrib_sindical_anual     VARCHAR2(1),
    emp_contrib_federativa         VARCHAR2(1),
    emp_adianta_13                 VARCHAR2(1),
    emp_cor_raca                   NUMBER(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for LOG_CADASTROS

COMMENT ON COLUMN log_cadastros.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN log_cadastros.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN log_cadastros.emp_aba_ban_codigo_cta_pgto IS 'IDENTIFICADOR DO ESTABELECIMENTO BANCÁRIO QUE ATENDE  AOS EMPREGADOS DA INFRAERO'
/
COMMENT ON COLUMN log_cadastros.emp_aba_ban_codigo_fgts IS 'CÓDIGO DO BANCO DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_aba_codigo_conta_pgto IS 'IDENTIFICADOR DE UMA AGÊNCIA BANCÁRIA REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_aba_codigo_fgts IS 'CÓDIGO DA AGÊNCIA BANCÁRIA DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_adianta_13 IS 'ADIANTAMENTO DO 13º DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_ano_primeiro_emprego IS 'ANO DO PRIMEIRO EMPREGO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_ati_ct_custos IS 'CÓDIGO IDENTIFICADOR  DO  CENTRO DE CUSTO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_classe_hab_tecnologica IS 'CLASSE DE HABILITAÇÃO TECNOLÓGICA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_codigo_fgts IS 'CÓDIGO DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_codigo_rais IS 'CÓDIGO DA RAIS - RELAÇÃO ANUAL DE INFORMAÇÕES SOCIAIS DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_contrib_federativa IS 'FLAG QUE IDENTIFICA SE O EMPREGADO É OPTANTE PELA CONTRIBUIÇÃO FEDERATIVA(S/N)'
/
COMMENT ON COLUMN log_cadastros.emp_contrib_sindical_anual IS 'CONTRIBUIÇÃO SINDICAL ANUAL DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_cor_raca IS 'FLAG QUE IDENTIFICA A COR/RAÇA DO EMPREGADO (INDÍGENA =0, BRANCA=2, PRETA=4, AMARELA=6, PARDA=8)'
/
COMMENT ON COLUMN log_cadastros.emp_data_admissao IS 'DATA DE ADMISSÃO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_data_cancelamento_arsaprev IS 'DATA DE CANCELAMENTO DO EMPREGADO NO  PLANO ARSAPREV'
/
COMMENT ON COLUMN log_cadastros.emp_data_filiacao_arsaprev IS 'DATA DE FILIAÇÃO DO EMPREGADO  NO  PLANO ARSAPREV'
/
COMMENT ON COLUMN log_cadastros.emp_data_nascimento IS 'DATA DE NASCIMENTO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dep_codigo_fisico IS 'CÓDIGO DA DEPENDÊNCIA FÍSICA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dep_codigo_lotacao IS 'CÓDIGO DA DEPENDÊNCIA DE LOTAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dep_codigo_pagto IS 'CÓDIGO DA DEPENDÊNCIA DE PAGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dt_aposentadoria IS 'DATA DE APOSENTADORIA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dt_validade_carteira_hab IS 'DATA DE VALIDADE DA CARTEIRA DE HABILITAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_dt_validade_habilit_lancha IS 'DATA DE VALIDADE DA CARTEIRA DE HABILITAÇÃO DE LANCHA  DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_endereco_bairro IS 'DESCRIÇÃO DO ENDEREÇO DO BAIRRO RESIDENCIAL  DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_endereco_logradouro IS 'DESCRIÇÃO DO ENDEREÇO RESIDENCIAL DO  EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_eso_codigo IS 'SEQUENCIAL IDENTIFICADOR DE UM GRAU DE ESCOLARIDADE'
/
COMMENT ON COLUMN log_cadastros.emp_habilit_orgao_oper IS 'HABILITAÇÃO DO ÓRGÃO OPERACIONAL DO DEPV'
/
COMMENT ON COLUMN log_cadastros.emp_id_aposentadoria IS 'IDENTIFICADOR DA APOSENTADORIA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_in_categoria_habilitacao IS 'INDICADOR DO TIPO DE CATEGORIA DA CARTEIRA DE HABILITAÇÃO  DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_in_classe_registro_estrang IS 'CLASSE ATRIBUÍDA PELO MINISTÉRIO DA JUSTIÇA AO REGISTRO DO EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN log_cadastros.emp_indicador_categoria_hab IS 'INDICADOR DO TIPO DE CATEGORIA DA CARTEIRA DE HABILITAÇÃO DE LANCHA  DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_indicador_depv IS 'INDICADOR DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_indicador_estado_civil IS 'IDENTIFICADOR DO ESTADO CIVIL DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_indicador_primeiro_emprego IS 'INDICADOR DO PRIMEIRO EMPREGO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_indicador_sexo IS 'INDICADOR DO SEXO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_jtr_codigo IS 'CÓDIGO IDENTIFICADOR DA JORNADA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_licenca_depv IS 'LICENÇA DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nacionalidade IS 'DESCRIÇÃO DA NACIONALIDADE DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nome IS 'DESCRIÇÃO DO NOME DO EMPREGADO COMPLETO'
/
COMMENT ON COLUMN log_cadastros.emp_nome_abreviado IS 'DESCRIÇÃO DO NOME DO EMPREGADO ABREVIADO'
/
COMMENT ON COLUMN log_cadastros.emp_nsa_codigo_nivel IS 'CÓDIGO IDENTIFICADOR DO NÍVEL SALARIAL DO EMPREGADO (FUNÇÃO DESIGNADO)'
/
COMMENT ON COLUMN log_cadastros.emp_nsa_codigo_padrao IS 'CÓDIGO IDENTIFICADOR DO PADRÃO DO  NÍVEL SALARIAL DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_carteira_habilitacao IS 'NÚMERO DA CARTEIRA DE HABILITAÇÃO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_carteira_identidade IS 'NÚMERO DA CARTEIRA DE IDENTIDADE DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_carteira_orgao_classe IS 'NÚMERO DA CARTEIRA REFERENTE AO ÓRGÃO DE CLASSE'
/
COMMENT ON COLUMN log_cadastros.emp_nu_categoria_cr IS 'NÚMERO DA CATEGORIA DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_certificado_reservista IS 'NÚMERO DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_conta_corrente_pagto IS 'IDENTIFICADOR DO NÚMERO DA CONTA CORRENTE DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_habilitacao_lancha IS 'NÚMERO DA CARTEIRA DE HABILITAÇÃO DE LANCHA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_regiao_militar_cr IS 'NÚMERO DA REGIÃO MILITAR DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_registro_estrangeiro IS 'NÚMERO DE REGISTRO , SE EMPREGADO ESTRANGEIRO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_secao_titulo_eleitor IS 'NÚMERO DA SEÇÃO DO TÍTULO ELEITORAL DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_serie_ctps_rne IS 'NÚMERO DE SÉRIE DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_titulo_eleitor IS 'NÚMERO DO TÍTULO DO ELEITOR DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_nu_zona_titulo_eleitor IS 'NÚMERO DA ZONA  ELEITORAL DO TÍTULO DE ELEITOR DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_carteira_trabalho IS 'NÚMERO DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_conta_fgts IS 'NÚMERO DA CONTA DO FUNDO DE GARANTIA DO TEMPO DE SERVIÇO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_cpf IS 'NÚMERO DE INSCRIÇÃO DO EMPREGADO NO CADASTRO DE PESSOAS FÍSICAS'
/
COMMENT ON COLUMN log_cadastros.emp_numero_ctps_rne IS 'NÚMERO DO REGISTRO DA CARTEIRA DE TRABALHO DE NATURALIZAÇÃO ESTRANGEIRA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_depv IS 'NÚMERO DO DEPARTAMENTO DE PROTEÇÃO AO VÔO REFERENTE AO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_fre IS 'NÚMERO DA FICHA DE REGISTRO DO EMPREGADO JUNTO AO MINISTÉRIO DO TRABALHO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_hab_tecnologica IS 'NÚMERO DA HABILITAÇÃO TECNOLÓGICA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_numero_matricula IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DO EMPREGADO CONTRATADO ( ATIVO)'
/
COMMENT ON COLUMN log_cadastros.emp_numero_matricula_ant IS 'IDENTIFICADOR DO NÚMERO DE MATRÍCULA DE EMPREGADO DE CONTRATAÇÃO ANTERIOR'
/
COMMENT ON COLUMN log_cadastros.emp_numero_matricula_arsa IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DOS EMPREGADOS EX - ARSA'
/
COMMENT ON COLUMN log_cadastros.emp_numero_matricula_tasa IS 'IDENTIFICADOR DO NÚMERO DA MATRÍCULA DOS EMPREGADOS EX - TASA'
/
COMMENT ON COLUMN log_cadastros.emp_numero_pis_pasep IS 'NÚMERO DO PIS_PASEP'
/
COMMENT ON COLUMN log_cadastros.emp_numero_serie_carteira_trab IS 'NÚMERO DE SÉRIE DA CARTEIRA DE TRABALHO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_oex_codigo_cedido IS 'CÓDIGO DO ÓRGÃO EXTERNO DE EMPREGADO CEDIDO'
/
COMMENT ON COLUMN log_cadastros.emp_oex_codigo_requisitado IS 'CÓDIGO DO ÓRGÃO EXTERNO DE EMPREGADO CEDIDO'
/
COMMENT ON COLUMN log_cadastros.emp_pai_codigo IS 'CÓDIGO IDENTIFICADOR DOS PAIS'
/
COMMENT ON COLUMN log_cadastros.emp_plano_arsaprev IS 'FLAG QUE IDENTIFICA O TIPO DE PLANO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_qfu_fun_codigo IS 'CÓDIGO IDENTIFICADOR DO EMPREGADO  FUNÇÃO DESIGNADA'
/
COMMENT ON COLUMN log_cadastros.emp_qfu_fun_codigo_acumula IS 'CÓDIGO DA FUNÇÃO UTILIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN log_cadastros.emp_qfu_fun_codigo_substitui IS 'CÓDIGO DA FUNÇÃO UTILIZADO NA CHAVE ESTRANGEIRA COM A TABELA QUADRO_FUNCOES (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN log_cadastros.emp_qlp_car_codigo IS 'CÓDIGO IDENTIFICADOR DO CARGO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_qlp_car_codigo_nivel IS 'CÓDIGO IDENTIFICADOR DO NÍVEL DO CARGO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_qlp_car_occ_codigo IS 'CÓDIGO IDENTIFICADOR DA OCUPAÇÃO/ATUAÇÃO DO CARGO'
/
COMMENT ON COLUMN log_cadastros.emp_sfu_codigo IS 'CÓDIGO IDENTIFICADOR DA SITUAÇÃO FUNCIONAL DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_status IS 'IDENTIFICADOR DO STATUS DO EMPREGADO ( SE ATIVO OU DESLIGADO)'
/
COMMENT ON COLUMN log_cadastros.emp_tipo_conta IS 'NÚMERO DA CONTA CORRENTE PARA DEPÓSITO  DO PAGAMENTO DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_tipo_cr IS 'IDENTIFICADOR DO TIPO DO CERTIFICADO DE RESERVISTA DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.emp_tipo_remuner_funcao_acumul IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO ACUMULAÇÃO)'
/
COMMENT ON COLUMN log_cadastros.emp_tipo_remuner_funcao_subst IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO SUBSTITUIÇÃO)'
/
COMMENT ON COLUMN log_cadastros.emp_tipo_remuneracao_funcao IS 'TIPO DE REMUNERAÇÃO DO EMPREGADO (FUNÇÃO DESIGNADA)'
/
COMMENT ON COLUMN log_cadastros.emp_ufe_sigla_reg_profis IS 'SIGLA DA UNIDADE FEDERATIVA  REFERENTE DO ÓRGÃO DE CLASSE.'
/
COMMENT ON COLUMN log_cadastros.emp_uor_codigo_lotacao IS 'CÓDIGO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL) DO EMPREGADO'
/
COMMENT ON COLUMN log_cadastros.tip_operacao IS 'Indica o tipo da transação U - Update, D - Delete'
/

-- End of DDL Script for Table IFRSRH.LOG_CADASTROS

-- Start of DDL Script for Table IFRSRH.LOG_CONTROLE_USUARIO_DEPEND
-- Generated 9/3/2004 19:01:11 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_controle_usuario_depend
    (sgu_id_usuario                 VARCHAR2(10) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    flag_ind_dep_frequencia        VARCHAR2(1) NOT NULL,
    ssi_cd_sistema                 NUMBER(2) NOT NULL,
    in_dep_principal               VARCHAR2(1) NOT NULL,
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_CONTROLE_USUARIO_DEPEND

-- Start of DDL Script for Table IFRSRH.LOG_CRONOGRAMAS_PAGAMENTOS
-- Generated 9/3/2004 19:01:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_cronogramas_pagamentos
    (cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    crp_dep_codigo                 NUMBER(4),
    crp_epg_codigo                 NUMBER(3),
    crp_ano_pagamento              NUMBER(4),
    crp_mes_pagamento              NUMBER(2),
    crp_sequencial                 NUMBER(2),
    crp_data_prevista              DATE,
    crp_data_realizacao            DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_CRONOGRAMAS_PAGAMENTOS

-- Start of DDL Script for Table IFRSRH.LOG_EMPREGADOS_BENEFICIOS
-- Generated 9/3/2004 19:01:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_empregados_beneficios
    (emb_ben_sigla                  VARCHAR2(3) NOT NULL,
    emb_emp_numero_matricula       NUMBER(7) NOT NULL,
    emb_validade                   DATE,
    emb_opcao                      VARCHAR2(1),
    tipo                           NUMBER(1),
    data_adesao                    DATE,
    emb_data_exclusao              DATE,
    emb_dep_resp_incl              NUMBER(4) NOT NULL,
    emb_oper_ans                   NUMBER(1),
    emb_opcao_alim                 VARCHAR2(1),
    emb_opcao_ref                  VARCHAR2(1),
    emb_qtd_alim                   NUMBER(4),
    emb_qtd_ref                    NUMBER(4),
    emb_opcao_extra                VARCHAR2(1),
    emb_opcao_bonus                VARCHAR2(1),
    emb_opcao_cba                  VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    tip_operacao                   VARCHAR2(1),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOG_EMPREGADOS_BENEFICIOS

CREATE INDEX log_emb_uk1 ON log_empregados_beneficios
  (
    emb_ben_sigla                   ASC,
    emb_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Comments for LOG_EMPREGADOS_BENEFICIOS

COMMENT ON COLUMN log_empregados_beneficios.cod_usuario IS 'Código do usuário responsável pela operação'
/
COMMENT ON COLUMN log_empregados_beneficios.data_adesao IS 'Data de adesão ao benefício'
/
COMMENT ON COLUMN log_empregados_beneficios.dta_operacao IS 'Data da operação'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_ben_sigla IS 'Sigla do benefício'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_data_exclusao IS 'Data de exclusão do benefício'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_dep_resp_incl IS 'Dependência do responsável pela inclusão'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_emp_numero_matricula IS 'Matrícula do empregado'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao IS 'Opção de tíquete - 1 (Alimentação);2(Refeição)'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao_alim IS 'Opção de Alimentação - Valores possíveis: S -Sim; N-Não'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao_bonus IS 'Opção de Bônus - Valores possíveis: A-Alimentação; R-Refeição'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao_cba IS 'Opção de Cesta Básica - Valores possíveis: A-Alimentação; R-Refeição'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao_extra IS 'Opção de Hora Extra - Valores possíveis: A-Alimentação; R-Refeição'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_opcao_ref IS 'Opção de Refeição - Valores possíveis: S -Sim; N-Não'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_oper_ans IS 'Operador ANS - 1(Inclusão);2(Alteração);3(Exclusão)'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_qtd_alim IS 'Quantidade de vale alimentação'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_qtd_ref IS 'Quantidade de vale refeição'
/
COMMENT ON COLUMN log_empregados_beneficios.emb_validade IS 'Validade do benefício'
/
COMMENT ON COLUMN log_empregados_beneficios.tip_operacao IS 'Tipo da operação - Valores possíveis: U - Update; D - Delete'
/
COMMENT ON COLUMN log_empregados_beneficios.tipo IS 'Tipo de benefício'
/

-- End of DDL Script for Table IFRSRH.LOG_EMPREGADOS_BENEFICIOS

-- Start of DDL Script for Table IFRSRH.LOG_EMPREGADOS_PAGAMENTOS
-- Generated 9/3/2004 19:01:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_empregados_pagamentos
    (egt_crp_ano_pagamento          NUMBER(4) NOT NULL,
    egt_crp_mes_pagamento          NUMBER(2) NOT NULL,
    egt_crp_sequencial             NUMBER(2) NOT NULL,
    egt_emp_numero_matricula       NUMBER(7) NOT NULL,
    egt_dep_codigo                 NUMBER(4),
    egt_uor_codigo                 NUMBER(9),
    egt_valor_fg                   NUMBER(14,2),
    egt_valor_rg                   NUMBER(14,2),
    egt_dependentes_ir             NUMBER(2),
    egt_dependentes_sal_fam        NUMBER(2),
    egt_numero_mes_13              NUMBER(2),
    egt_numero_anuenios            NUMBER(2),
    egt_carga_horaria_mes          NUMBER(3),
    egt_base_fgts                  NUMBER(14,2),
    egt_base_inss                  NUMBER(14,2),
    egt_base_irrf                  NUMBER(14,2),
    egt_percentual_arsaprev        NUMBER(8,6),
    egt_plano_arsaprev             NUMBER(1),
    egt_base_arsaprev              NUMBER(14,2),
    egt_emp_qlp_car_codigo         NUMBER(3),
    egt_emp_qlp_car_codigo_nivel   NUMBER(1),
    egt_emp_qlp_car_occ_codigo     NUMBER(3),
    egt_emp_nsa_codigo_nivel       NUMBER(2),
    egt_emp_qfu_fun_codigo         NUMBER(3),
    egt_remuneracao_liquido        NUMBER(14,2),
    egt_hcc_cct_codigo             NUMBER(6),
    egt_faixa_inss                 NUMBER(6,2),
    egt_valor_margem_consignavel   NUMBER(14,2),
    egt_emp_nsa_in_nivel_escolarid VARCHAR2(1),
    egt_emp_nsa_codigo_padrao      VARCHAR2(4),
    egt_dep_codigo_fisico          NUMBER(4),
    cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for LOG_EMPREGADOS_PAGAMENTOS

COMMENT ON COLUMN log_empregados_pagamentos.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN log_empregados_pagamentos.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_base_arsaprev IS 'Informa a valor base de cálculo do fundo de pensão da Infraero'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_base_fgts IS 'Informa a valor base de cálculo de fgts do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_base_inss IS 'Informa a valor base de cálculo de inss do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_base_irrf IS 'Informa a valor base de cálculo de irrf do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_carga_horaria_mes IS 'Informa a carga horária de trabalho no mês do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_crp_ano_pagamento IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_crp_mes_pagamento IS 'Indica o mês referente ao pagamento'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_crp_sequencial IS 'Indica a versão de pagamento dentro do mesmo mês'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_dep_codigo IS 'Informa o código da dependência de pagamento'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_dependentes_ir IS 'Informa a quantidade de dependentes para irrf do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_dependentes_sal_fam IS 'Informa a quantidade de dependentes para salário família do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_nsa_codigo_nivel IS 'Indica o nível salarial do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_nsa_codigo_padrao IS 'Indica código padrão salarial do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_nsa_in_nivel_escolarid IS 'Indica o nível de escolaridade do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_qfu_fun_codigo IS 'Indica o código da função do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_qlp_car_codigo IS 'Informa o código do cargo do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_qlp_car_codigo_nivel IS 'Informa o código do nível do cargo do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_emp_qlp_car_occ_codigo IS 'Informa a ocupação/atuação do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_faixa_inss IS 'Indica a faixa de desconto de inss que o empregado está enquadrado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_hcc_cct_codigo IS 'Indica o centro de custo do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_numero_anuenios IS 'Informa a quantidade de anuênios do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_numero_mes_13 IS 'Informa a quantidade de avos para o cálculo do 13º salário do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_percentual_arsaprev IS 'Informa o percentual de contribuição do fundo de pensão da Infraero'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_plano_arsaprev IS 'Informa o tipo do plano do fundo de pensão da Infraero'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_remuneracao_liquido IS 'Indica o valor líquido de remuneração do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_uor_codigo IS 'Informa o código da unidade organizacionao do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_valor_fg IS 'Informa o valor referente ao pagamento de FG no mês do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.egt_valor_rg IS 'Informa o valor referente ao pagamento de RG no mês do empregado'
/
COMMENT ON COLUMN log_empregados_pagamentos.tip_operacao IS 'Indica o tipo da transação U - Update, D - Delete'
/

-- End of DDL Script for Table IFRSRH.LOG_EMPREGADOS_PAGAMENTOS

-- Start of DDL Script for Table IFRSRH.LOG_ERRO_FOLHA_FECHADA
-- Generated 9/3/2004 19:01:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_erro_folha_fechada
    (lef_codigo                     NUMBER(10) NOT NULL,
    data                           DATE,
    usuario                        VARCHAR2(60),
    operacao                       VARCHAR2(1),
    mov_ano_referencia             NUMBER(4),
    mov_mes_referencia             NUMBER(2),
    mov_versao_pagamento           NUMBER(2),
    mov_emp_numero_matricula       NUMBER(7),
    mov_rub_codigo                 NUMBER(4),
    mov_sequencial                 NUMBER(2),
    mov_tip_rubrica                VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LOG_ERRO_FOLHA_FECHADA

ALTER TABLE log_erro_folha_fechada
ADD CONSTRAINT pk_lef PRIMARY KEY (lef_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_ERRO_FOLHA_FECHADA

-- Start of DDL Script for Table IFRSRH.LOG_FOLHA
-- Generated 9/3/2004 19:01:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_folha
    (log_mes_referencia             NUMBER(2) NOT NULL,
    log_ano_referencia             NUMBER(4) NOT NULL,
    log_versao_pagamento           NUMBER(2) NOT NULL,
    log_rub_codigo                 NUMBER(4),
    log_emp_numero_matricula       NUMBER(7),
    log_mensagem                   VARCHAR2(300) NOT NULL,
    log_tipo_auditoria             NUMBER(2) NOT NULL,
    log_data_erro                  DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.LOG_FOLHA

-- Start of DDL Script for Table IFRSRH.LOG_MOVIMENTACAO
-- Generated 9/3/2004 19:01:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_movimentacao
    (cod_usuario                    VARCHAR2(30) NOT NULL,
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    mov_ano_referencia             NUMBER(4),
    mov_mes_referencia             NUMBER(2),
    mov_versao_pagamento           NUMBER(2),
    mov_emp_numero_matricula       NUMBER(7),
    mov_rub_codigo                 NUMBER(4),
    mov_sequencial                 NUMBER(2),
    mov_parcela                    NUMBER(3),
    mov_parcela_atual              NUMBER(3),
    mov_emp_dep_codigo_pagto       NUMBER(4),
    mov_tip_rubrica                VARCHAR2(1),
    mov_for_codigo                 NUMBER(3),
    mov_parametro                  NUMBER(14,6),
    mov_valor                      NUMBER(11,2),
    mov_ano_ref_diferenca          NUMBER(4),
    mov_mes_ref_diferenca          NUMBER(2),
    mov_pen_codigo                 NUMBER(2),
    mov_pkt_codigo_pedido          NUMBER,
    mov_dias_proporcionalidade     NUMBER(3),
    mov_tipo_parametro             VARCHAR2(1),
    mov_rub_seq_pagamento          NUMBER(3),
    mov_ind_calculo                VARCHAR2(1),
    mov_ind_exclusivo              VARCHAR2(1),
    mov_valor_integral             NUMBER(11,2),
    mov_fun_codigo                 NUMBER(3),
    mov_nsa_codigo_nivel           VARCHAR2(2),
    mov_oem_emp_numero_matricula   NUMBER(7),
    mov_oem_ofu_codigo             NUMBER(4),
    mov_oem_data_inicio            DATE,
    mov_data_calculo               DATE,
    mov_pem_ben_sigla              VARCHAR2(3),
    mov_tipo_funcao                VARCHAR2(2),
    mov_ind_13                     VARCHAR2(1),
    mov_ind_arsaprev               VARCHAR2(1),
    mov_ind_lancamento_liq_negat   VARCHAR2(1),
    mov_nsa_codigo_padrao          VARCHAR2(4),
    mov_nsa_indicador_nivel_escola VARCHAR2(1),
    mov_flg_frequencia             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOG_MOVIMENTACAO

CREATE INDEX lmv_amverts_ix ON log_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_numero_matricula        ASC,
    mov_rub_codigo                  ASC,
    mov_tip_rubrica                 ASC,
    mov_sequencial                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Comments for LOG_MOVIMENTACAO

COMMENT ON COLUMN log_movimentacao.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN log_movimentacao.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN log_movimentacao.mov_ano_ref_diferenca IS 'Indica o ano referenca à rubrida de diferença ou extorno, lançada na movimentacao do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_ano_referencia IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN log_movimentacao.mov_data_calculo IS 'Informa a data que foi efetuado o cálculo'
/
COMMENT ON COLUMN log_movimentacao.mov_dias_proporcionalidade IS 'Indica a quantidade de dias que obedecerá a proporcionalidade do cálculo'
/
COMMENT ON COLUMN log_movimentacao.mov_emp_dep_codigo_pagto IS 'Indica o código da dependência de pagamento do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_flg_frequencia IS '''Indica se a rubrica é relativa à frequência'
/
COMMENT ON COLUMN log_movimentacao.mov_for_codigo IS 'Indica o código da formula de calculo da rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_fun_codigo IS 'Indica o código da função do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_ind_13 IS 'Indicador que será utilizado somente no cálculo do 13º, marca as rubricas que foram utilizadas e devem ser retiradas após o cálculo'
/
COMMENT ON COLUMN log_movimentacao.mov_ind_arsaprev IS 'Indica se a rubrica é relativa ao fundo de pensão da Infraero'
/
COMMENT ON COLUMN log_movimentacao.mov_ind_calculo IS 'Informa a data que foi efetuado o cálculo'
/
COMMENT ON COLUMN log_movimentacao.mov_ind_exclusivo IS 'Indica se a rubrica é lançada exclusivamente pelo sistema'
/
COMMENT ON COLUMN log_movimentacao.mov_ind_lancamento_liq_negat IS 'Indica se a rubrica é candidata a ser migrada para um próximo mês, após cálculo de dependência e antes do cálculo final'
/
COMMENT ON COLUMN log_movimentacao.mov_mes_ref_diferenca IS 'Indica o mês referenca à rubrida de diferença ou extorno, lançada na movimentacao do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_mes_referencia IS 'Indica o mês referente ao pagamento'
/
COMMENT ON COLUMN log_movimentacao.mov_nsa_codigo_nivel IS 'Indica o nível salarial do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_nsa_codigo_padrao IS 'Indica código padrão salarial do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_nsa_indicador_nivel_escola IS 'Indica o nível de escolaridade do empregado'
/
COMMENT ON COLUMN log_movimentacao.mov_oem_data_inicio IS 'Informa a data início da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_oem_emp_numero_matricula IS 'Informa a matricula do empregado na ocorrência que deu origem à rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_oem_ofu_codigo IS 'Informa o código da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_parametro IS 'Indica o valor do parametro que será ultilizado no cálculo da rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_parcela IS 'Indica a quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN log_movimentacao.mov_parcela_atual IS 'Indica a parcela atual da quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN log_movimentacao.mov_pem_ben_sigla IS 'Informa a sigla do tipo de benefício'
/
COMMENT ON COLUMN log_movimentacao.mov_pen_codigo IS 'Indica o código do pedido de ticket no benefício'
/
COMMENT ON COLUMN log_movimentacao.mov_pkt_codigo_pedido IS 'Informa o código do pedido do benefício'
/
COMMENT ON COLUMN log_movimentacao.mov_rub_codigo IS 'Indica o código de provento ou desconto (rubrica)'
/
COMMENT ON COLUMN log_movimentacao.mov_rub_seq_pagamento IS 'Indica a sequência de cálculo da rubrica'
/
COMMENT ON COLUMN log_movimentacao.mov_sequencial IS 'Indica o sequencial da rubrica no mesmo mês'
/
COMMENT ON COLUMN log_movimentacao.mov_tip_rubrica IS 'Indica o tipo de rubrica, D - diferença, N - normal, E - extorno, R - recibo '
/
COMMENT ON COLUMN log_movimentacao.mov_tipo_funcao IS 'Indica a sigla da função do empregado, FG, DG, DI'
/
COMMENT ON COLUMN log_movimentacao.mov_tipo_parametro IS 'Indica o tipo do parametro, H - horas, D - dias, V - valor, P - percentual, Q - quantidade'
/
COMMENT ON COLUMN log_movimentacao.mov_valor IS 'Indica o valor final da rubrica, utilizando o mov_dias_proporcionalidade'
/
COMMENT ON COLUMN log_movimentacao.mov_valor_integral IS 'Valor integral da rubrica, valor base para aplicar a proporcionalidade dos cálculos'
/
COMMENT ON COLUMN log_movimentacao.mov_versao_pagamento IS 'Indica a versão de pagamento dentro do mesmo mês'
/
COMMENT ON COLUMN log_movimentacao.tip_operacao IS 'Indica o tipo da transação I - inclusão, E - exclusão, A - Alteração'
/

-- End of DDL Script for Table IFRSRH.LOG_MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.LOG_OCORRENCIAS_EMPREGADOS
-- Generated 9/3/2004 19:01:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_ocorrencias_empregados
    (oem_emp_numero_matricula       NUMBER(7) NOT NULL,
    oem_ofu_codigo                 NUMBER(4) NOT NULL,
    oem_data_inicio                DATE NOT NULL,
    oem_data_inclusao              DATE,
    oem_data_termino               DATE,
    oem_texto                      VARCHAR2(200),
    oem_diploma_legal              VARCHAR2(200),
    oem_oem_emp_numero_matricula   NUMBER(7),
    oem_oem_ofu_codigo             NUMBER(3),
    oem_oem_data_inicio            DATE,
    oem_emp_numero_matricula_subst NUMBER(7),
    oem_uor_codigo                 NUMBER(9),
    oem_oex_codigo_cedido          NUMBER(5),
    oem_oex_codigo_requisitado     NUMBER(5),
    oem_data_cancel_interrupcao    DATE,
    oem_motivo_cancel_interrupcao  VARCHAR2(100),
    oem_indicador_cancelamento     VARCHAR2(1),
    oem_dep_codigo                 NUMBER(4),
    oem_indicador_onus             VARCHAR2(1),
    oem_diploma_legal_termino      VARCHAR2(200),
    oem_pfe_emp_num_matr_program   NUMBER(7),
    oem_pfe_sequencial_program     NUMBER(2),
    oem_pfe_emp_num_matr_confirm1  NUMBER(7),
    oem_pfe_sequencial_confirm1    NUMBER(2),
    oem_pfe_emp_num_matr_confirm2  NUMBER(7),
    oem_pfe_sequencial_confirm2    NUMBER(2),
    oem_fun_codigo                 NUMBER(3),
    oem_fun_codigo_substitui       NUMBER(3),
    oem_fun_codigo_acumula         NUMBER(3),
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL,
    oem_mov_parametro              NUMBER(11,3),
    oem_car_codigo                 NUMBER(3),
    oem_car_codigo_nivel           NUMBER(1),
    oem_car_occ_codigo             NUMBER(3),
    oem_emp_nsa_codigo_nivel       NUMBER(2),
    oem_emp_nsa_codigo_padrao      VARCHAR2(4),
    oem_emp_nsa_in_nivel_escol     VARCHAR2(1),
    oem_tipo_remuneracao_funcao    VARCHAR2(2),
    oem_cct_codigo                 NUMBER(6),
    oem_valor                      NUMBER(11,3),
    oem_esc_cid_codigo             VARCHAR2(5),
    oem_esc_eid_codigo             VARCHAR2(3),
    oem_tipo_expediente            NUMBER(1),
    oem_cod_horario_empregado      NUMBER(3),
    oem_turno_trabalho_empregado   VARCHAR2(1),
    oem_dep_codigo_origem          NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for LOG_OCORRENCIAS_EMPREGADOS

CREATE INDEX locoremp_ind2 ON log_ocorrencias_empregados
  (
    oem_emp_numero_matricula        ASC,
    oem_ofu_codigo                  ASC,
    oem_data_inicio                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX log_oco_dt_incl1 ON log_ocorrencias_empregados
  (
    oem_data_inclusao               ASC,
    oem_ofu_codigo                  ASC,
    oem_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.LOG_OCORRENCIAS_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.LOG_OCORRENCIAS_FREQUENCIA_EMP
-- Generated 9/3/2004 19:01:52 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_ocorrencias_frequencia_emp
    (ofe_emp_numero_matricula       NUMBER(7) NOT NULL,
    ofe_ofu_codigo                 NUMBER(4) NOT NULL,
    ofe_data_inicio                DATE NOT NULL,
    ofe_data_inclusao              DATE NOT NULL,
    ofe_data_termino               DATE,
    ofe_texto                      VARCHAR2(200),
    ofe_diploma_legal              VARCHAR2(100),
    ofe_diploma_legal_termino      VARCHAR2(100),
    ofe_ofe_emp_numero_matricula   NUMBER(7),
    ofe_ofe_ofu_codigo             NUMBER(3),
    ofe_ofe_data_inicio            DATE,
    ofe_dep_codigo                 NUMBER(4),
    ofe_mov_parametro              NUMBER(11,3),
    ofe_tipo_expediente            NUMBER(1),
    ofe_cod_horario_empregado      NUMBER(3),
    ofe_turno_trabalho_empregado   VARCHAR2(1),
    ofe_uor_codigo                 NUMBER(9),
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   CHAR(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for LOG_OCORRENCIAS_FREQUENCIA_EMP

COMMENT ON COLUMN log_ocorrencias_frequencia_emp.cod_usuario IS 'Usuário que fez a operação'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.dta_operacao IS 'Data em que foi feito o Update ou o Delete do Registro'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_cod_horario_empregado IS 'Código de Carga Horária do Empregado'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_data_inclusao IS 'Data de Inclusão da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_data_inicio IS 'Data de Inicio da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_data_termino IS 'Data de Término da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_dep_codigo IS 'Código da Dependência do empregado'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_diploma_legal IS 'Documento Legal da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_diploma_legal_termino IS 'Documento Legal de término da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_emp_numero_matricula IS 'Matricula do Empregado'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_mov_parametro IS 'Quantidade dependente do Código da Ocorrencia'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_ofe_data_inicio IS 'Data de Inicio da Ocorrência Funcional da qual Depende'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_ofe_emp_numero_matricula IS 'Matrícula de referencia'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_ofe_ofu_codigo IS 'Código da Ocorrência Funcional da qual Depende'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_ofu_codigo IS 'Código de Ocorrência Funcional'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_texto IS 'Texto explicativo da Ocorrência'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_tipo_expediente IS 'Código de Tipo de Expediente'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_turno_trabalho_empregado IS 'Turno de Trabalho do Empregado'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.ofe_uor_codigo IS 'Unidade Organizacional do Empregado'
/
COMMENT ON COLUMN log_ocorrencias_frequencia_emp.tip_operacao IS 'Se a operação foi Delete ''D'' ou Update ''U'''
/

-- End of DDL Script for Table IFRSRH.LOG_OCORRENCIAS_FREQUENCIA_EMP

-- Start of DDL Script for Table IFRSRH.LOG_PROGRAMACOES_FERIAS
-- Generated 9/3/2004 19:01:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE log_programacoes_ferias
    (pfe_emp_numero_matricula       NUMBER(7) NOT NULL,
    pfe_sequencial                 NUMBER(2) NOT NULL,
    pfe_data_inicio_1              DATE NOT NULL,
    pfe_data_termino_1             DATE NOT NULL,
    pfe_indicador_13_salario_1     VARCHAR2(1) NOT NULL,
    pfe_in_adiantamento_ferias_1   VARCHAR2(1) NOT NULL,
    pfe_in_abono_pecuniario_1      VARCHAR2(1) NOT NULL,
    pfe_indicador_13_salario_2     VARCHAR2(1) NOT NULL,
    pfe_in_adiantamento_ferias_2   VARCHAR2(1) NOT NULL,
    pfe_in_abono_pecuniario_2      VARCHAR2(1) NOT NULL,
    pfe_dt_inicio_periodo_aquis    DATE NOT NULL,
    pfe_dt_termino_periodo_aquis   DATE NOT NULL,
    pfe_numero_prazo_desconto_1    NUMBER(2),
    pfe_numero_prazo_desconto_2    NUMBER(2),
    pfe_data_inicio_2              DATE,
    pfe_data_termino_2             DATE,
    pfe_numero_dias_gozo_1         NUMBER(2),
    pfe_numero_dias_gozo_2         NUMBER(2),
    pfe_documento_1                VARCHAR2(200),
    pfe_documento_2                VARCHAR2(200),
    pfe_data_ini_abono_pecuniario  DATE,
    pfe_data_fim_abono_pecuniario  DATE,
    pfe_mov_ano_ref_inicio_1       NUMBER(4),
    pfe_mov_mes_ref_inicio_1       NUMBER(2),
    pfe_mov_ano_ref_inicio_2       NUMBER(4),
    pfe_mov_mes_ref_inicio_2       NUMBER(2),
    pfe_mov_oem_data_inicio_1      DATE,
    pfe_mov_oem_data_inicio_2      DATE,
    dat_operacao                   DATE NOT NULL,
    tip_operacao                   VARCHAR2(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for LOG_PROGRAMACOES_FERIAS

COMMENT ON COLUMN log_programacoes_ferias.cod_usuario IS 'Matrícula do Usuário que carregou o registro'
/
COMMENT ON COLUMN log_programacoes_ferias.dat_operacao IS 'Data em que foi carregado o registro'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_fim_abono_pecuniario IS 'Data Término do período de abono pecuniário'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_ini_abono_pecuniario IS 'Data Inicio do período de abono pecuniário'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_inicio_1 IS 'Data inicio primeiro período de ferias  '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_inicio_2 IS 'Data inicio segundo período de ferias '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_termino_1 IS 'Data termino primeiro período de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_data_termino_2 IS 'Data termino segundo período de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_documento_1 IS 'Texto informativo ao respeito do primeiro período de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_documento_2 IS 'Texto informativo ao respeito do segundo período de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_dt_inicio_periodo_aquis IS 'Data Inicio do período aquisitivo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_dt_termino_periodo_aquis IS 'Data Término do período aquisitivo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_emp_numero_matricula IS 'Matricula do empregado'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_in_abono_pecuniario_1 IS 'Indica se o empregado escolho vender dias de ferias. valores(''S'',''N'')'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_in_abono_pecuniario_2 IS 'Indica se o empregado escolho vender dias de ferias para o segundo periodo.Valores (''S'',''N'')'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_in_adiantamento_ferias_1 IS 'Indica se o empregado escolho adiantamento de ferias.Valores(''S'',''N'') '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_in_adiantamento_ferias_2 IS 'Indica se o empregado escolho adiantamento de ferias para o segundo periodo.Valores(''S'',''N'') '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_indicador_13_salario_1 IS 'Indica se o empregado escolho adiantamento de 13 salario, valores(''S'',''N'') '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_indicador_13_salario_2 IS 'Indica se o empregado escolho adiantamento de 13 salario para o segundo periodo, valores(''S'',''N'')'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_ano_ref_inicio_1 IS 'Ano em que foi feito o pagamento na folha para o primeiro periodo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_ano_ref_inicio_2 IS 'Ano em que foi feito o pagamento na folha para o segundo periodo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_mes_ref_inicio_1 IS 'Mês em que foi feito o pagamento na folha para o primeiro periodo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_mes_ref_inicio_2 IS 'Mês em que foi feito o pagamento na folha para o segundo periodo '
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_oem_data_inicio_1 IS 'Data de nexo com a folha de pagamento para o primeiro periodo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_mov_oem_data_inicio_2 IS 'Data de nexo com a folha de pagamento para o segundo periodo'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_numero_dias_gozo_1 IS 'Quantidade de dias de gozo de ferias para o primeiro periodo de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_numero_dias_gozo_2 IS 'Quantidade de dias de gozo de ferias para o segundo periodo de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_numero_prazo_desconto_1 IS 'Identifica a quantidade pela qual será parcelado o pagamento para o primeiro periodo de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_numero_prazo_desconto_2 IS 'Identifica a quantidade pela qual será parcelado o pagamento para o segundo periodo de ferias'
/
COMMENT ON COLUMN log_programacoes_ferias.pfe_sequencial IS 'Nro de registro carregado por matricula'
/
COMMENT ON COLUMN log_programacoes_ferias.tip_operacao IS 'Tipo de Operação que Origino a cargo do registro (''U'',Update, ''D'', Delete)'
/

-- End of DDL Script for Table IFRSRH.LOG_PROGRAMACOES_FERIAS

-- Start of DDL Script for Table IFRSRH.LPM
-- Generated 9/3/2004 19:01:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE lpm
    (lpm_codigo                     NUMBER(7) NOT NULL,
    lpm_dv                         NUMBER(1) NOT NULL,
    lpm_descricao                  VARCHAR2(250) NOT NULL,
    lpm_auxiliar                   NUMBER(2),
    lpm_porte_anestesico           NUMBER(15,2),
    lpm_honorarios                 NUMBER(12,2),
    lpm_filme                      NUMBER(5,4),
    lpm_esp_tipo                   NUMBER(1) NOT NULL,
    lpm_esp_numero                 NUMBER(7) NOT NULL,
    lpm_observacao                 VARCHAR2(2000),
    lpm_qtd                        NUMBER(3),
    lpm_sexo                       VARCHAR2(1),
    lpm_participacao               NUMBER(5,2),
    lpm_ind_pericia                VARCHAR2(1) NOT NULL,
    lpm_qtd_periodo                NUMBER(2),
    lpm_ind_inss                   VARCHAR2(1),
    lpm_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LPM

ALTER TABLE lpm
ADD CONSTRAINT lpm_ind_pericia_ck CHECK ( LPM_IND_PERICIA IN ( 'S' , 'N' ) )
/
ALTER TABLE lpm
ADD CONSTRAINT lpm_pk PRIMARY KEY (lpm_codigo, lpm_dv, lpm_esp_tipo, 
  lpm_esp_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE lpm
ADD CONSTRAINT lpm_status_internacao_ck CHECK (LPM_STATUS_INTERNACAO IN ('S','N'))
/

-- Comments for LPM

COMMENT ON COLUMN lpm.lpm_ind_pericia IS 'Indicador de perícia médica (S/N). ''S'' indica que o serviço médico deve ser feito com perícia de médicos cadastrados pela INFRAERO.'
/
COMMENT ON COLUMN lpm.lpm_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.LPM

-- Start of DDL Script for Table IFRSRH.LPM_LOCAL
-- Generated 9/3/2004 19:02:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE lpm_local
    (lpl_codigo                     NUMBER(7) NOT NULL,
    lpl_dv                         NUMBER(1) NOT NULL,
    lpl_descricao                  VARCHAR2(250) NOT NULL,
    lpl_coeficiente                NUMBER(12,2),
    lpl_porte_anestesico           NUMBER(12,2),
    lpl_auxiliar                   NUMBER(2),
    lpl_filme                      NUMBER(5,4),
    lpl_cre_sequencial             NUMBER(5) NOT NULL,
    lpl_qtd                        NUMBER(3),
    lpl_sexo                       VARCHAR2(1),
    lpl_participacao               NUMBER(5,2),
    lpl_ind_pericia                VARCHAR2(1) NOT NULL,
    lpl_qtd_periodo                NUMBER(2),
    lpl_ind_inss                   VARCHAR2(1),
    lpl_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for LPM_LOCAL

ALTER TABLE lpm_local
ADD CONSTRAINT lpl_ind_pericia_ck CHECK ( LPL_IND_PERICIA IN ( 'S' , 'N' ) )
/
ALTER TABLE lpm_local
ADD CONSTRAINT lpl_status_internacao_ck CHECK (LPL_STATUS_INTERNACAO IN ('S','N'))
/
ALTER TABLE lpm_local
ADD CONSTRAINT lpm_local_pk PRIMARY KEY (lpl_codigo, lpl_cre_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for LPM_LOCAL

COMMENT ON COLUMN lpm_local.lpl_ind_pericia IS 'Indicador de perícia médica (S/N). ''S'' indica que o serviço médico deve ser feito com perícia de médicos cadastrados pela INFRAERO.'
/
COMMENT ON COLUMN lpm_local.lpl_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.LPM_LOCAL

-- Start of DDL Script for Table IFRSRH.MEDIAS_CATEGORIAS_TRANSPORTES
-- Generated 9/3/2004 19:02:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE medias_categorias_transportes
    (mct_dep_codigo                 NUMBER(4) NOT NULL,
    mct_mesano_referencia          DATE NOT NULL,
    mct_media_local                NUMBER(6,2) NOT NULL,
    mct_media_nacional             NUMBER(6,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for MEDIAS_CATEGORIAS_TRANSPORTES

ALTER TABLE medias_categorias_transportes
ADD CONSTRAINT mct_pk PRIMARY KEY (mct_dep_codigo, mct_mesano_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.MEDIAS_CATEGORIAS_TRANSPORTES

-- Start of DDL Script for Table IFRSRH.MENSAGENS_CONTRACHEQUES
-- Generated 9/3/2004 19:02:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE mensagens_contracheques
    (mec_codigo                     NUMBER(3) NOT NULL,
    mec_mes                        NUMBER(2) NOT NULL,
    mec_ano                        NUMBER(4) NOT NULL,
    mec_descricao                  VARCHAR2(180) NOT NULL,
    mec_dep_codigo                 NUMBER(4) NOT NULL,
    mec_mensagem_geral             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for MENSAGENS_CONTRACHEQUES

ALTER TABLE mensagens_contracheques
ADD CONSTRAINT mec_pk PRIMARY KEY (mec_ano, mec_mes, mec_codigo, mec_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for MENSAGENS_CONTRACHEQUES

COMMENT ON COLUMN mensagens_contracheques.mec_mensagem_geral IS 'Indica se a mensagem é para todas as dependências (S - Sim) ou (N - Nao)'
/

-- End of DDL Script for Table IFRSRH.MENSAGENS_CONTRACHEQUES

-- Start of DDL Script for Table IFRSRH.MOV_SOMA_MENSAL
-- Generated 9/3/2004 19:02:29 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE mov_soma_mensal
    (mov_emp_numero_matricula       NUMBER(7) NOT NULL,
    mov_mes_referencia             NUMBER(2) NOT NULL,
    mov_ano_referencia             NUMBER(4) NOT NULL,
    mov_rub_codigo                 NUMBER(4) NOT NULL,
    mov_tip_rubrica                VARCHAR2(1) NOT NULL,
    soma                           NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.MOV_SOMA_MENSAL

-- Start of DDL Script for Table IFRSRH.MOVIMENTACAO
-- Generated 9/3/2004 19:02:31 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE movimentacao
    (mov_ano_referencia             NUMBER(4) NOT NULL,
    mov_mes_referencia             NUMBER(2) NOT NULL,
    mov_versao_pagamento           NUMBER(2) NOT NULL,
    mov_emp_numero_matricula       NUMBER(7) NOT NULL,
    mov_rub_codigo                 NUMBER(4) NOT NULL,
    mov_sequencial                 NUMBER(2) NOT NULL,
    mov_parcela                    NUMBER(3) NOT NULL,
    mov_parcela_atual              NUMBER(3) NOT NULL,
    mov_rub_seq_pagamento          NUMBER(3) NOT NULL,
    mov_emp_dep_codigo_pagto       NUMBER(4) NOT NULL,
    mov_tip_rubrica                VARCHAR2(1) NOT NULL,
    mov_ind_calculo                VARCHAR2(1) NOT NULL,
    mov_ind_exclusivo              VARCHAR2(1) NOT NULL,
    mov_for_codigo                 NUMBER(3),
    mov_parametro                  NUMBER(14,6),
    mov_valor                      NUMBER(11,2),
    mov_ano_ref_diferenca          NUMBER(4),
    mov_mes_ref_diferenca          NUMBER(2),
    mov_pen_codigo                 NUMBER(2),
    mov_pkt_codigo_pedido          NUMBER,
    mov_valor_integral             NUMBER(11,2),
    mov_fun_codigo                 NUMBER(3),
    mov_dias_proporcionalidade     NUMBER(3),
    mov_nsa_codigo_nivel           NUMBER(2),
    mov_oem_emp_numero_matricula   NUMBER(7),
    mov_oem_ofu_codigo             NUMBER(4),
    mov_oem_data_inicio            DATE,
    mov_data_calculo               DATE,
    mov_pem_ben_sigla              VARCHAR2(3),
    mov_tipo_funcao                VARCHAR2(2),
    mov_tipo_parametro             VARCHAR2(1),
    mov_ind_13                     VARCHAR2(1),
    mov_ind_arsaprev               VARCHAR2(1),
    mov_ind_lancamento_liq_negat   VARCHAR2(1),
    mov_nsa_codigo_padrao          VARCHAR2(4),
    mov_nsa_indicador_nivel_escola VARCHAR2(1),
    mov_flg_frequencia             VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for MOVIMENTACAO

CREATE INDEX mov_dep_ix ON movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX mov_emp_idx ON movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX movimentacao_ind1 ON movimentacao
  (
    mov_oem_emp_numero_matricula    ASC,
    mov_oem_ofu_codigo              ASC,
    mov_oem_data_inicio             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX mov_pkt_codigo_pedido_ix ON movimentacao
  (
    mov_pkt_codigo_pedido           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for MOVIMENTACAO

ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_1 CHECK ( mov_tipo_parametro in ('H','D','V','P','Q') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_2 CHECK ( mov_tip_rubrica in ('N','D','E','R') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_3 CHECK ( mov_ind_arsaprev in ('S','N','I') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_4 CHECK ( mov_tipo_funcao in ('FG','RG','DI') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_5 CHECK ( mov_ind_exclusivo in ('S','N') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_6 CHECK ( mov_ind_13 in ('S','N') )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_ck_7 CHECK ( mov_ind_calculo IN ( 'S' , 'N' ) )
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_pk PRIMARY KEY (mov_ano_referencia, mov_mes_referencia, 
  mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo, 
  mov_tip_rubrica, mov_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for MOVIMENTACAO

CREATE TRIGGER trg_folha_fechada
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON movimentacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
DECLARE
 v_folha_fechada    VARCHAR2(1) := 'N';
 v_update           VARCHAR2(3);
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
  ELSIF UPDATING THEN
    v_update := 'OLD';
    v_folha_fechada := PKT_ERRO_FOLHA.FUN_FOLHA_FECHADA(:OLD.MOV_ANO_REFERENCIA,
                                                        :OLD.MOV_MES_REFERENCIA,
                                                        :OLD.MOV_VERSAO_PAGAMENTO
                                                         );
    IF v_folha_fechada != 'S' THEN
      v_update := 'NEW';
      v_folha_fechada := PKT_ERRO_FOLHA.FUN_FOLHA_FECHADA(:NEW.MOV_ANO_REFERENCIA,
                                                          :NEW.MOV_MES_REFERENCIA,
                                                          :NEW.MOV_VERSAO_PAGAMENTO
                                                          );
    END IF;
  ELSIF DELETING THEN
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
    ELSIF UPDATING THEN  -- O erro foi por update
        -- Carrego o numero de Erro
        v_num_erro := -20020;
        -- Carrega a operacao que deu erro
        v_operacao := 'U';
        IF v_update = 'OLD' THEN
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
        ELSE -- UPDATE = 'NEW'
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
        END IF;
        --
    ELSIF DELETING THEN
      -- Carrego o numero de Erro
      v_num_erro := -20030;
      -- Carrega a operacao que deu erro
      v_operacao := 'D';
      --
      -- Se o erro foi gerado por um deleting
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
CREATE TRIGGER log_movimentacao
AFTER UPDATE  OR  DELETE 
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
  if deleting then
     insert into log_movimentacao
                   (cod_usuario,
                    dta_operacao,
                    tip_operacao,
                    mov_ano_referencia,
                    mov_mes_referencia,
                    mov_versao_pagamento,
                    mov_emp_numero_matricula,
                    mov_rub_codigo,
                    mov_sequencial,
                    mov_parcela,
                    mov_parcela_atual,
                    mov_emp_dep_codigo_pagto,
                    mov_tip_rubrica,
                    mov_for_codigo,
                    mov_parametro,
                    mov_valor,
                    mov_ano_ref_diferenca,
                    mov_mes_ref_diferenca,
                    mov_pen_codigo,
                    mov_pkt_codigo_pedido,
                    mov_dias_proporcionalidade,
                    mov_tipo_parametro,
                    mov_rub_seq_pagamento,
                    mov_ind_calculo,
                    mov_ind_exclusivo,
                    mov_valor_integral,
                    mov_fun_codigo,
                    mov_nsa_codigo_nivel,
                    mov_oem_emp_numero_matricula,
                    mov_oem_ofu_codigo,
                    mov_oem_data_inicio,
                    mov_data_calculo,
                    mov_pem_ben_sigla,
                    mov_tipo_funcao,
                    mov_ind_13,
                    mov_ind_arsaprev,
                    mov_ind_lancamento_liq_negat,
                    mov_nsa_codigo_padrao,
                    mov_nsa_indicador_nivel_escola,
                    mov_flg_frequencia)
            values (user,
                    sysdate,
                    'E',
                    :old.mov_ano_referencia,
                    :old.mov_mes_referencia,
                    :old.mov_versao_pagamento,
                    :old.mov_emp_numero_matricula,
                    :old.mov_rub_codigo,
                    :old.mov_sequencial,
                    :old.mov_parcela,
                    :old.mov_parcela_atual,
                    :old.mov_emp_dep_codigo_pagto,
                    :old.mov_tip_rubrica,
                    :old.mov_for_codigo,
                    :old.mov_parametro,
                    :old.mov_valor,
                    :old.mov_ano_ref_diferenca,
                    :old.mov_mes_ref_diferenca,
                    :old.mov_pen_codigo,
                    :old.mov_pkt_codigo_pedido,
                    :old.mov_dias_proporcionalidade,
                    :old.mov_tipo_parametro,
                    :old.mov_rub_seq_pagamento,
                    :old.mov_ind_calculo,
                    :old.mov_ind_exclusivo,
                    :old.mov_valor_integral,
                    :old.mov_fun_codigo,
                    :old.mov_nsa_codigo_nivel,
                    :old.mov_oem_emp_numero_matricula,
                    :old.mov_oem_ofu_codigo,
                    :old.mov_oem_data_inicio,
                    :old.mov_data_calculo,
                    :old.mov_pem_ben_sigla,
                    :old.mov_tipo_funcao,
                    :old.mov_ind_13,
                    :old.mov_ind_arsaprev,
                    :old.mov_ind_lancamento_liq_negat,
                    :old.mov_nsa_codigo_padrao,
                    :old.mov_nsa_indicador_nivel_escola,
                    :old.mov_flg_frequencia
                 );
  end if;
  if updating then
     insert into log_movimentacao
                   (cod_usuario,
                    dta_operacao,
                    tip_operacao,
                    mov_ano_referencia,
                    mov_mes_referencia,
                    mov_versao_pagamento,
                    mov_emp_numero_matricula,
                    mov_rub_codigo,
                    mov_sequencial,
                    mov_parcela,
                    mov_parcela_atual,
                    mov_emp_dep_codigo_pagto,
                    mov_tip_rubrica,
                    mov_for_codigo,
                    mov_parametro,
                    mov_valor,
                    mov_ano_ref_diferenca,
                    mov_mes_ref_diferenca,
                    mov_pen_codigo,
                    mov_pkt_codigo_pedido,
                    mov_dias_proporcionalidade,
                    mov_tipo_parametro,
                    mov_rub_seq_pagamento,
                    mov_ind_calculo,
                    mov_ind_exclusivo,
                    mov_valor_integral,
                    mov_fun_codigo,
                    mov_nsa_codigo_nivel,
                    mov_oem_emp_numero_matricula,
                    mov_oem_ofu_codigo,
                    mov_oem_data_inicio,
                    mov_data_calculo,
                    mov_pem_ben_sigla,
                    mov_tipo_funcao,
                    mov_ind_13,
                    mov_ind_arsaprev,
                    mov_ind_lancamento_liq_negat,
                    mov_nsa_codigo_padrao,
                    mov_nsa_indicador_nivel_escola,
                    mov_flg_frequencia)
            values (user,
                    sysdate,
                    'A',
                    :old.mov_ano_referencia,
                    :old.mov_mes_referencia,
                    :old.mov_versao_pagamento,
                    :old.mov_emp_numero_matricula,
                    :old.mov_rub_codigo,
                    :old.mov_sequencial,
                    :old.mov_parcela,
                    :old.mov_parcela_atual,
                    :old.mov_emp_dep_codigo_pagto,
                    :old.mov_tip_rubrica,
                    :old.mov_for_codigo,
                    :old.mov_parametro,
                    :old.mov_valor,
                    :old.mov_ano_ref_diferenca,
                    :old.mov_mes_ref_diferenca,
                    :old.mov_pen_codigo,
                    :old.mov_pkt_codigo_pedido,
                    :old.mov_dias_proporcionalidade,
                    :old.mov_tipo_parametro,
                    :old.mov_rub_seq_pagamento,
                    :old.mov_ind_calculo,
                    :old.mov_ind_exclusivo,
                    :old.mov_valor_integral,
                    :old.mov_fun_codigo,
                    :old.mov_nsa_codigo_nivel,
                    :old.mov_oem_emp_numero_matricula,
                    :old.mov_oem_ofu_codigo,
                    :old.mov_oem_data_inicio,
                    :old.mov_data_calculo,
                    :old.mov_pem_ben_sigla,
                    :old.mov_tipo_funcao,
                    :old.mov_ind_13,
                    :old.mov_ind_arsaprev,
                    :old.mov_ind_lancamento_liq_negat,
                    :old.mov_nsa_codigo_padrao,
                    :old.mov_nsa_indicador_nivel_escola,
                    :old.mov_flg_frequencia);
  end if;
end;
/
CREATE TRIGGER trg_auditoria_mov
BEFORE INSERT 
ON movimentacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
BEGIN
  --
  :NEW.cod_usuario  := USER;
  :NEW.dta_operacao := SYSDATE;
  --
END; --End TRIGGER TRG_AUDITORIA
/
CREATE TRIGGER srh_altera_formula_movim
BEFORE INSERT  OR UPDATE OF 
  mov_for_codigo,
ON movimentacao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
begin
if :new.mov_for_codigo is null then
   begin
   --------------------Verifica se existe formula para a rubrica que está sendo inserida---
      select fru_for_codigo
      into   :new.mov_for_codigo
      from   IFRSRH.formulas_rubricas
      where  fru_rub_codigo = :new.mov_rub_codigo and
             TO_NUMBER(LPAD(TO_CHAR(FRU_ANO_INICIO),4,'0') || LPAD(TO_CHAR(FRU_MES_INICIO),2,'0')) =
             (select max(TO_NUMBER(LPAD(TO_CHAR(FRU_ANO_INICIO),4,'0') || LPAD(TO_CHAR(FRU_MES_INICIO),2,'0')))
              from   IFRSRH.formulas_rubricas
              where  fru_rub_codigo = :new.mov_rub_codigo);
  exception
    when no_data_found then
         null;
    when others then
         RAISE_APPLICATION_ERROR
         (-20002, 'Erro [Others] na seleção da tabela Movimentação: Erro - ' ||SQLERRM);
  end;
end if;
end;
/

-- Comments for MOVIMENTACAO

COMMENT ON COLUMN movimentacao.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN movimentacao.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN movimentacao.mov_ano_ref_diferenca IS 'Indica o ano referenca à rubrida de diferença ou extorno, lançada na movimentacao do empregado'
/
COMMENT ON COLUMN movimentacao.mov_ano_referencia IS 'Indica o ano referente ao pagamento'
/
COMMENT ON COLUMN movimentacao.mov_data_calculo IS 'Informa a data que foi efetuado o cálculo'
/
COMMENT ON COLUMN movimentacao.mov_dias_proporcionalidade IS 'Indica a quantidade de dias que obedecerá a proporcionalidade do cálculo'
/
COMMENT ON COLUMN movimentacao.mov_emp_dep_codigo_pagto IS 'Indica o código da dependência de pagamento do empregado'
/
COMMENT ON COLUMN movimentacao.mov_emp_numero_matricula IS 'Informa a matricula do empregado'
/
COMMENT ON COLUMN movimentacao.mov_flg_frequencia IS 'Indica se a rubrica é relativa à frequência'
/
COMMENT ON COLUMN movimentacao.mov_for_codigo IS 'Indica o código da formula de calculo da rubrica'
/
COMMENT ON COLUMN movimentacao.mov_fun_codigo IS 'Indica o código da função do empregado'
/
COMMENT ON COLUMN movimentacao.mov_ind_13 IS 'Indicador que será utilizado somente no cálculo do 13º, marca as rubricas que foram utilizadas e devem ser retiradas após o cálculo'
/
COMMENT ON COLUMN movimentacao.mov_ind_arsaprev IS 'Indica se a rubrica é relativa ao fundo de pensão da Infraero'
/
COMMENT ON COLUMN movimentacao.mov_ind_calculo IS 'Indica se a rubrica já foi calculada, N - não, S - sim'
/
COMMENT ON COLUMN movimentacao.mov_ind_exclusivo IS 'Indica se a rubrica é lançada exclusivamente pelo sistema'
/
COMMENT ON COLUMN movimentacao.mov_ind_lancamento_liq_negat IS 'Indica se a rubrica é candidata a ser migrada para um próximo mês, após cálculo de dependência e antes do cálculo final'
/
COMMENT ON COLUMN movimentacao.mov_mes_ref_diferenca IS 'Indica o mês referenca à rubrida de diferença ou extorno, lançada na movimentacao do empregado'
/
COMMENT ON COLUMN movimentacao.mov_mes_referencia IS 'Indica o mês referente ao pagamento'
/
COMMENT ON COLUMN movimentacao.mov_nsa_codigo_nivel IS 'Indica o nível salarial do empregado'
/
COMMENT ON COLUMN movimentacao.mov_nsa_codigo_padrao IS 'Indica código padrão salarial do empregado'
/
COMMENT ON COLUMN movimentacao.mov_nsa_indicador_nivel_escola IS 'Indica o nível de escolaridade do empregado'
/
COMMENT ON COLUMN movimentacao.mov_oem_data_inicio IS 'Informa a data início da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN movimentacao.mov_oem_emp_numero_matricula IS 'Informa a matricula do empregado na ocorrência que deu origem à rubrica'
/
COMMENT ON COLUMN movimentacao.mov_oem_ofu_codigo IS 'Informa o código da ocorrência funcional que deu origem à rubrica'
/
COMMENT ON COLUMN movimentacao.mov_parametro IS 'Indica o valor do parametro que será ultilizado no cálculo da rubrica'
/
COMMENT ON COLUMN movimentacao.mov_parcela IS 'Indica a quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN movimentacao.mov_parcela_atual IS 'Indica a parcela atual da quantidade de parcelas da rubrica, 999 indica rubrica permanente'
/
COMMENT ON COLUMN movimentacao.mov_pem_ben_sigla IS 'Informa a sigla do tipo de benefício'
/
COMMENT ON COLUMN movimentacao.mov_pen_codigo IS 'Indica o código do pedido de ticket no benefício'
/
COMMENT ON COLUMN movimentacao.mov_rub_codigo IS 'Indica o código de provento ou desconto (rubrica)'
/
COMMENT ON COLUMN movimentacao.mov_rub_seq_pagamento IS 'Indica a sequência de cálculo da rubrica'
/
COMMENT ON COLUMN movimentacao.mov_sequencial IS 'Indica o sequencial da rubrica no mesmo mês'
/
COMMENT ON COLUMN movimentacao.mov_tip_rubrica IS 'Indica o tipo de rubrica, D - diferença, N - normal, E - extorno, R - recibo '
/
COMMENT ON COLUMN movimentacao.mov_tipo_funcao IS 'Indica a sigla da função do empregado, FG, DG, DI'
/
COMMENT ON COLUMN movimentacao.mov_tipo_parametro IS 'Indica o tipo do parametro, H - horas, D - dias, V - valor, P - percentual, Q - quantidade'
/
COMMENT ON COLUMN movimentacao.mov_valor IS 'Indica o valor final da rubrica, utilizando o mov_dias_proporcionalidade'
/
COMMENT ON COLUMN movimentacao.mov_valor_integral IS 'Valor integral da rubrica, valor base para aplicar a proporcionalidade dos cálculos'
/
COMMENT ON COLUMN movimentacao.mov_versao_pagamento IS 'Indica a versão de pagamento dentro do mesmo mês'
/

-- End of DDL Script for Table IFRSRH.MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT
-- Generated 9/3/2004 19:03:07 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE movimentacao_autonomo_cooperat
    (mac_ano_referencia             NUMBER(4) NOT NULL,
    mac_mes_referencia             NUMBER(2) NOT NULL,
    mac_cre_sequencial             NUMBER(5) NOT NULL,
    mac_dta_pagto                  DATE NOT NULL,
    mac_cbo_codigo                 VARCHAR2(6),
    mac_valor                      NUMBER(11,2) NOT NULL,
    mac_fretes                     VARCHAR2(1) NOT NULL,
    mac_ano_doc                    NUMBER(4),
    mac_num_doc                    NUMBER(6),
    mac_cbo_dta_inicio             DATE,
    mac_dep_codigo                 NUMBER(4),
    mac_inss_autonomo              NUMBER(16,2),
    mac_dta_movimentacao           DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for MOVIMENTACAO_AUTONOMO_COOPERAT

ALTER TABLE movimentacao_autonomo_cooperat
ADD CONSTRAINT mac_fretes_ck CHECK (MAC_FRETES IN ( 'S' , 'N' ))
/
ALTER TABLE movimentacao_autonomo_cooperat
ADD CONSTRAINT mac_pk PRIMARY KEY (mac_ano_referencia, mac_mes_referencia, 
  mac_cre_sequencial, mac_dta_pagto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for MOVIMENTACAO_AUTONOMO_COOPERAT

COMMENT ON COLUMN movimentacao_autonomo_cooperat.mac_dep_codigo IS 'Dependência responsável pelo pagamento'
/

-- End of DDL Script for Table IFRSRH.MOVIMENTACAO_AUTONOMO_COOPERAT

-- Start of DDL Script for Table IFRSRH.NIVEIS_SALARIAIS
-- Generated 9/3/2004 19:03:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE niveis_salariais
    (nsa_codigo_nivel               NUMBER(2) NOT NULL,
    nsa_codigo_padrao              VARCHAR2(4) NOT NULL,
    nsa_indicador_nivel_escola     VARCHAR2(1) NOT NULL,
    nsa_vld_codigo                 NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for NIVEIS_SALARIAIS

ALTER TABLE niveis_salariais
ADD CONSTRAINT nsa_pk PRIMARY KEY (nsa_codigo_nivel, nsa_codigo_padrao, 
  nsa_indicador_nivel_escola)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.NIVEIS_SALARIAIS

-- Start of DDL Script for Table IFRSRH.OCORRENCIA_VIAGEM_CENTRO_CUSTO
-- Generated 9/3/2004 19:03:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencia_viagem_centro_custo
    (ovc_ove_oem_emp_num_matricula  NUMBER(7) NOT NULL,
    ovc_ove_oem_ofu_codigo         NUMBER(4) NOT NULL,
    ovc_ove_oem_data_inicio        DATE NOT NULL,
    ovc_ove_codigo_trecho          NUMBER(2) NOT NULL,
    ovc_cct_codigo                 NUMBER(5) NOT NULL,
    ovc_valor_passagem             NUMBER(12,2),
    ovc_valor_diaria               NUMBER(12,2),
    ovc_qtd_dias                   NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIA_VIAGEM_CENTRO_CUSTO

ALTER TABLE ocorrencia_viagem_centro_custo
ADD CONSTRAINT ovc_pk PRIMARY KEY (ovc_ove_oem_emp_num_matricula, 
  ovc_ove_oem_ofu_codigo, ovc_ove_oem_data_inicio, ovc_ove_codigo_trecho, 
  ovc_cct_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIA_VIAGEM_CENTRO_CUSTO

COMMENT ON TABLE ocorrencia_viagem_centro_custo IS 'ARMAZENARÁ OS CENTROS DE CUSTO DO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_cct_codigo IS 'CÓDIGO DO CENTRO DE CUSTO DO TRECHO DA OCORRÊNCIA DE VIAGEM'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_ove_codigo_trecho IS 'NÚMERO DO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_ove_oem_data_inicio IS 'DATA DE INÍCIO DA OCORRÊNCIA FUNCIONAL'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_ove_oem_emp_num_matricula IS 'NÚMERO DA MATRÍCULA DO EMPREGADO NA INFRAERO'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_ove_oem_ofu_codigo IS 'NÚMERO DA OCORRÊNCIA FUNCIONAL'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_qtd_dias IS 'QUANTIDADE DE DIÁRIA(S) CUSTEADA PELO CENTRO DE CUSTO NO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_valor_diaria IS 'VALOR DA DIÁRIA CUSTEADA PELO CENTRO DE CUSTO NO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/
COMMENT ON COLUMN ocorrencia_viagem_centro_custo.ovc_valor_passagem IS 'VALOR DA PASSAGEM CUSTEADA PELO CENTRO DE CUSTO NO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIA_VIAGEM_CENTRO_CUSTO

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_EMPREGADOS
-- Generated 9/3/2004 19:03:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_empregados
    (oem_emp_numero_matricula       NUMBER(7) NOT NULL,
    oem_ofu_codigo                 NUMBER(4) NOT NULL,
    oem_data_inicio                DATE NOT NULL,
    oem_data_inclusao              DATE NOT NULL,
    oem_data_termino               DATE,
    oem_texto                      VARCHAR2(200),
    oem_diploma_legal              VARCHAR2(200),
    oem_oem_emp_numero_matricula   NUMBER(7),
    oem_oem_ofu_codigo             NUMBER(3),
    oem_oem_data_inicio            DATE,
    oem_emp_numero_matricula_subst NUMBER(7),
    oem_uor_codigo                 NUMBER(9),
    oem_oex_codigo_cedido          NUMBER(5),
    oem_oex_codigo_requisitado     NUMBER(5),
    oem_data_cancel_interrupcao    DATE,
    oem_motivo_cancel_interrupcao  VARCHAR2(100),
    oem_indicador_cancelamento     VARCHAR2(1),
    oem_dep_codigo                 NUMBER(4),
    oem_indicador_onus             VARCHAR2(1),
    oem_diploma_legal_termino      VARCHAR2(200),
    oem_pfe_emp_num_matr_program   NUMBER(7),
    oem_pfe_sequencial_program     NUMBER(2),
    oem_pfe_emp_num_matr_confirm1  NUMBER(7),
    oem_pfe_sequencial_confirm1    NUMBER(2),
    oem_pfe_emp_num_matr_confirm2  NUMBER(7),
    oem_pfe_sequencial_confirm2    NUMBER(2),
    oem_fun_codigo                 NUMBER(3),
    oem_fun_codigo_substitui       NUMBER(3),
    oem_fun_codigo_acumula         NUMBER(3),
    oem_dep_codigo_origem          NUMBER(4),
    oem_mov_parametro              NUMBER(11,3),
    oem_car_codigo                 NUMBER(3),
    oem_car_codigo_nivel           NUMBER(1),
    oem_car_occ_codigo             NUMBER(3),
    oem_emp_nsa_codigo_nivel       NUMBER(2),
    oem_emp_nsa_codigo_padrao      VARCHAR2(4),
    oem_emp_nsa_in_nivel_escol     VARCHAR2(1),
    oem_tipo_remuneracao_funcao    VARCHAR2(2),
    oem_cct_codigo                 NUMBER(6),
    oem_valor                      NUMBER(11,3),
    oem_esc_cid_codigo             VARCHAR2(5),
    oem_esc_eid_codigo             VARCHAR2(3),
    oem_tipo_expediente            NUMBER(1),
    oem_cod_horario_empregado      NUMBER(3),
    oem_turno_trabalho_empregado   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for OCORRENCIAS_EMPREGADOS

CREATE INDEX oem_ofu_fk_i ON ocorrencias_empregados
  (
    oem_ofu_codigo                  ASC
  )
  PCTFREE     3
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX oei ON ocorrencias_empregados
  (
    oem_uor_codigo                  ASC,
    oem_ofu_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX oem_emp_substituir_fk_i ON ocorrencias_empregados
  (
    oem_emp_numero_matricula_subst  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX oem_oem_fk_i ON ocorrencias_empregados
  (
    oem_oem_emp_numero_matricula    ASC,
    oem_oem_ofu_codigo              ASC,
    oem_oem_data_inicio             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for OCORRENCIAS_EMPREGADOS

ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_ck_1 CHECK (  oem_turno_trabalho_empregado in ('A','B','C','D','F','N') )
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_pk PRIMARY KEY (oem_emp_numero_matricula, oem_ofu_codigo, 
  oem_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for OCORRENCIAS_EMPREGADOS

CREATE TRIGGER log_ocorrencias_empregados
AFTER INSERT  OR UPDATE OF 
  oem_car_codigo,
  oem_car_codigo_nivel,
  oem_car_occ_codigo,
  oem_cct_codigo,
  oem_cod_horario_empregado,
  oem_data_cancel_interrupcao,
  oem_data_inclusao,
  oem_data_inicio,
  oem_data_termino,
  oem_dep_codigo,
  oem_dep_codigo_origem,
  oem_diploma_legal,
  oem_diploma_legal_termino,
  oem_emp_nsa_codigo_nivel,
  oem_emp_nsa_codigo_padrao,
  oem_emp_nsa_in_nivel_escol,
  oem_emp_numero_matricula,
  oem_emp_numero_matricula_subst,
  oem_esc_cid_codigo,
  oem_esc_eid_codigo,
  oem_fun_codigo,
  oem_fun_codigo_acumula,
  oem_fun_codigo_substitui,
  oem_indicador_cancelamento,
  oem_indicador_onus,
  oem_motivo_cancel_interrupcao,
  oem_mov_parametro,
  oem_oem_data_inicio,
  oem_oem_emp_numero_matricula,
  oem_oem_ofu_codigo,
  oem_oex_codigo_cedido,
  oem_oex_codigo_requisitado,
  oem_ofu_codigo,
  oem_pfe_emp_num_matr_confirm1,
  oem_pfe_emp_num_matr_confirm2,
  oem_pfe_emp_num_matr_program,
  oem_pfe_sequencial_confirm1,
  oem_pfe_sequencial_confirm2,
  oem_pfe_sequencial_program,
  oem_texto,
  oem_tipo_expediente,
  oem_tipo_remuneracao_funcao,
  oem_turno_trabalho_empregado,
  oem_uor_codigo,
  oem_valor
 OR  DELETE 
ON ocorrencias_empregados
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  n_oem_data_inclusao                 log_ocorrencias_empregados.oem_data_inclusao%TYPE;
  n_oem_data_termino                  log_ocorrencias_empregados.oem_data_termino%TYPE;
  n_oem_texto                         log_ocorrencias_empregados.oem_texto%TYPE;
  n_oem_diploma_legal                 log_ocorrencias_empregados.oem_diploma_legal%TYPE;
  n_oem_oem_emp_numero_matricula      log_ocorrencias_empregados.oem_oem_emp_numero_matricula%TYPE;
  n_oem_oem_ofu_codigo                log_ocorrencias_empregados.oem_oem_ofu_codigo%TYPE;
  n_oem_oem_data_inicio               log_ocorrencias_empregados.oem_oem_data_inicio%TYPE;
  n_oem_emp_numero_matricula_sub      log_ocorrencias_empregados.oem_emp_numero_matricula_subst%TYPE;
  n_oem_uor_codigo                    log_ocorrencias_empregados.oem_uor_codigo%TYPE;
  n_oem_oex_codigo_cedido             log_ocorrencias_empregados.oem_oex_codigo_cedido%TYPE;
  n_oem_oex_codigo_requisitado        log_ocorrencias_empregados.oem_oex_codigo_requisitado%TYPE;
  n_oem_data_cancel_interrupcao       log_ocorrencias_empregados.oem_data_cancel_interrupcao%TYPE;
  n_oem_motivo_cancel_interrup        log_ocorrencias_empregados.oem_motivo_cancel_interrupcao %TYPE;
  n_oem_indicador_cancelamento        log_ocorrencias_empregados.oem_indicador_cancelamento%TYPE;
  n_oem_dep_codigo                    log_ocorrencias_empregados.oem_dep_codigo%TYPE;
  n_oem_indicador_onus                log_ocorrencias_empregados.oem_indicador_onus%TYPE;
  n_oem_diploma_legal_termino         log_ocorrencias_empregados.oem_diploma_legal_termino%TYPE;
  n_oem_pfe_emp_num_matr_program      log_ocorrencias_empregados.oem_pfe_emp_num_matr_program%TYPE;
  n_oem_pfe_sequencial_program        log_ocorrencias_empregados.oem_pfe_sequencial_program%TYPE;
  n_oem_pfe_emp_num_matr_confir1      log_ocorrencias_empregados.oem_pfe_emp_num_matr_confirm1%TYPE;
  n_oem_pfe_sequencial_confirm1       log_ocorrencias_empregados.oem_pfe_sequencial_confirm1%TYPE;
  n_oem_pfe_emp_num_matr_confir2      log_ocorrencias_empregados.oem_pfe_emp_num_matr_confirm2%TYPE;
  n_oem_pfe_sequencial_confirm2       log_ocorrencias_empregados.oem_pfe_sequencial_confirm2%TYPE;
  n_oem_fun_codigo                    log_ocorrencias_empregados.oem_fun_codigo%TYPE;
  n_oem_fun_codigo_substitui          log_ocorrencias_empregados.oem_fun_codigo_substitui%TYPE;
  n_oem_fun_codigo_acumula            log_ocorrencias_empregados.oem_fun_codigo_acumula%TYPE;
  n_OEM_DEP_CODIGO_ORIGEM	      log_ocorrencias_empregados.OEM_DEP_CODIGO_ORIGEM%TYPE;
  n_OEM_MOV_PARAMETRO                 log_ocorrencias_empregados.OEM_MOV_PARAMETRO%TYPE;
  n_OEM_CAR_CODIGO                    log_ocorrencias_empregados.OEM_CAR_CODIGO%TYPE;
  n_OEM_CAR_CODIGO_NIVEL              log_ocorrencias_empregados.OEM_CAR_CODIGO_NIVEL%TYPE;
  n_OEM_CAR_OCC_CODIGO                log_ocorrencias_empregados.OEM_CAR_OCC_CODIGO%TYPE;
  n_OEM_EMP_NSA_CODIGO_NIVEL          log_ocorrencias_empregados.OEM_EMP_NSA_CODIGO_NIVEL%TYPE;
  n_OEM_EMP_NSA_CODIGO_PADRAO         log_ocorrencias_empregados.OEM_EMP_NSA_CODIGO_PADRAO%TYPE;
  n_OEM_EMP_NSA_IN_NIVEL_ESCOL        log_ocorrencias_empregados.OEM_EMP_NSA_IN_NIVEL_ESCOL%TYPE;
  n_OEM_TIPO_REMUNERACAO_FUNCAO       log_ocorrencias_empregados.OEM_TIPO_REMUNERACAO_FUNCAO%TYPE;
  n_OEM_CCT_CODIGO                    log_ocorrencias_empregados.OEM_CCT_CODIGO%TYPE;
  n_OEM_VALOR                         log_ocorrencias_empregados.OEM_VALOR%TYPE;
  n_OEM_ESC_CID_CODIGO                log_ocorrencias_empregados.OEM_ESC_CID_CODIGO%TYPE;
  n_OEM_ESC_EID_CODIGO                log_ocorrencias_empregados.OEM_ESC_EID_CODIGO%TYPE;
  n_OEM_TIPO_EXPEDIENTE               log_ocorrencias_empregados.OEM_TIPO_EXPEDIENTE%TYPE;
  n_OEM_COD_HORARIO_EMPREGADO         log_ocorrencias_empregados.OEM_COD_HORARIO_EMPREGADO%TYPE;
  n_OEM_TURNO_TRABALHO_EMPREGADO      log_ocorrencias_empregados.OEM_TURNO_TRABALHO_EMPREGADO%TYPE;
BEGIN
  IF INSERTING THEN
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
     		OEM_DEP_CODIGO_ORIGEM,
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
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:new.oem_emp_numero_matricula,
                 :new.oem_ofu_codigo,
                 :new.oem_data_inicio,
                 :new.oem_data_inclusao,
                 :new.oem_data_termino,
                 :new.oem_texto,
                 :new.oem_diploma_legal,
                 :new.oem_oem_emp_numero_matricula,
                 :new.oem_oem_ofu_codigo,
                 :new.oem_oem_data_inicio,
                 :new.oem_emp_numero_matricula_subst,
                 :new.oem_uor_codigo,
                 :new.oem_oex_codigo_cedido,
                 :new.oem_oex_codigo_requisitado,
                 :new.oem_data_cancel_interrupcao,
                 :new.oem_motivo_cancel_interrupcao,
                 :new.oem_indicador_cancelamento,
                 :new.oem_dep_codigo,
                 :new.oem_indicador_onus,
                 :new.oem_diploma_legal_termino,
                 :new.oem_pfe_emp_num_matr_program,
                 :new.oem_pfe_sequencial_program,
                 :new.oem_pfe_emp_num_matr_confirm1,
                 :new.oem_pfe_sequencial_confirm1,
                 :new.oem_pfe_emp_num_matr_confirm2,
                 :new.oem_pfe_sequencial_confirm2,
                 :new.oem_fun_codigo,
                 :new.oem_fun_codigo_substitui,
                 :new.oem_fun_codigo_acumula,
     		 :new.OEM_DEP_CODIGO_ORIGEM,
                 :new.OEM_MOV_PARAMETRO,
     		 :new.OEM_CAR_CODIGO,
     		 :new.OEM_CAR_CODIGO_NIVEL,
     		 :new.OEM_CAR_OCC_CODIGO,
     		 :new.OEM_EMP_NSA_CODIGO_NIVEL,
     		 :new.OEM_EMP_NSA_CODIGO_PADRAO,
     		 :new.OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		 :new.OEM_TIPO_REMUNERACAO_FUNCAO,
     		 :new.OEM_CCT_CODIGO,
     		 :new.OEM_VALOR,
     		 :new.OEM_ESC_CID_CODIGO,
     		 :new.OEM_ESC_EID_CODIGO,
     		 :new.OEM_TIPO_EXPEDIENTE,
     		 :new.OEM_COD_HORARIO_EMPREGADO,
     		 :new.OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'I',
                 user
                );
  END IF;
  IF DELETING THEN
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
    		OEM_DEP_CODIGO_ORIGEM,
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
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
     VALUES
                (:old.oem_emp_numero_matricula,
                 :old.oem_ofu_codigo,
                 :old.oem_data_inicio,
                 :old.oem_data_inclusao,
                 :old.oem_data_termino,
                 :old.oem_texto,
                 :old.oem_diploma_legal,
                 :old.oem_oem_emp_numero_matricula,
                 :old.oem_oem_ofu_codigo,
                 :old.oem_oem_data_inicio,
                 :old.oem_emp_numero_matricula_subst,
                 :old.oem_uor_codigo,
                 :old.oem_oex_codigo_cedido,
                 :old.oem_oex_codigo_requisitado,
                 :old.oem_data_cancel_interrupcao,
                 :old.oem_motivo_cancel_interrupcao,
                 :old.oem_indicador_cancelamento,
                 :old.oem_dep_codigo,
                 :old.oem_indicador_onus,
                 :old.oem_diploma_legal_termino,
                 :old.oem_pfe_emp_num_matr_program,
                 :old.oem_pfe_sequencial_program,
                 :old.oem_pfe_emp_num_matr_confirm1,
                 :old.oem_pfe_sequencial_confirm1,
                 :old.oem_pfe_emp_num_matr_confirm2,
                 :old.oem_pfe_sequencial_confirm2,
                 :old.oem_fun_codigo,
                 :old.oem_fun_codigo_substitui,
                 :old.oem_fun_codigo_acumula,
     		 :old.OEM_DEP_CODIGO_ORIGEM,
                 :old.OEM_MOV_PARAMETRO,
     		 :old.OEM_CAR_CODIGO,
     		 :old.OEM_CAR_CODIGO_NIVEL,
     		 :old.OEM_CAR_OCC_CODIGO,
     		 :old.OEM_EMP_NSA_CODIGO_NIVEL,
     		 :old.OEM_EMP_NSA_CODIGO_PADRAO,
     		 :old.OEM_EMP_NSA_IN_NIVEL_ESCOL,
     		 :old.OEM_TIPO_REMUNERACAO_FUNCAO,
     		 :old.OEM_CCT_CODIGO,
     		 :old.OEM_VALOR,
     		 :old.OEM_ESC_CID_CODIGO,
     		 :old.OEM_ESC_EID_CODIGO,
     		 :old.OEM_TIPO_EXPEDIENTE,
     		 :old.OEM_COD_HORARIO_EMPREGADO,
     		 :old.OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'E',
                 user
                );
  END IF;
  IF UPDATING THEN
     IF :old.oem_data_inclusao = :new.oem_data_inclusao THEN
        n_oem_data_inclusao := null;
     ELSE
        n_oem_data_inclusao := :new.oem_data_inclusao;
     END IF;
     /* Modif 15/01/2003*/
     -- IF :old.oem_data_termino = :new.oem_data_termino THEN
     --    n_oem_data_termino := null;
     -- ELSE
     /* Agora se carrega sempre com o valor de :new.oem_data_termino */
     n_oem_data_termino := :new.oem_data_termino;
     -- END IF;
     /* fim modif*/
     IF :old.oem_texto = :new.oem_texto THEN
        n_oem_texto := null;
     ELSE
        n_oem_texto := :new.oem_texto;
     END IF;
     IF :old.oem_diploma_legal = :new.oem_diploma_legal THEN
        n_oem_diploma_legal := null;
     ELSE
        n_oem_diploma_legal:= :new.oem_diploma_legal;
     END IF;
     IF :old.oem_oem_emp_numero_matricula = :new.oem_oem_emp_numero_matricula THEN
        n_oem_oem_emp_numero_matricula := null;
     ELSE
        n_oem_oem_emp_numero_matricula := :new.oem_oem_emp_numero_matricula;
     END IF;
     IF :old.oem_oem_ofu_codigo = :new.oem_oem_ofu_codigo THEN
        n_oem_oem_ofu_codigo := null;
     ELSE
        n_oem_oem_ofu_codigo := :new.oem_oem_ofu_codigo;
     END IF;
     IF :old.oem_oem_data_inicio = :new.oem_oem_data_inicio THEN
        n_oem_oem_data_inicio := null;
     ELSE
        n_oem_oem_data_inicio := :new.oem_oem_data_inicio;
     END IF;
     IF :old.oem_emp_numero_matricula_subst = :new.oem_emp_numero_matricula_subst THEN
        n_oem_emp_numero_matricula_sub := null;
     ELSE
        n_oem_emp_numero_matricula_sub := :new.oem_emp_numero_matricula_subst;
     END IF;
     IF :old.oem_uor_codigo = :new.oem_uor_codigo THEN
        n_oem_uor_codigo := null;
     ELSE
        n_oem_uor_codigo := :new.oem_uor_codigo;
     END IF;
     IF :old.oem_oex_codigo_cedido = :new.oem_oex_codigo_cedido THEN
        n_oem_oex_codigo_cedido := null;
     ELSE
        n_oem_oex_codigo_cedido := :new.oem_oex_codigo_cedido;
     END IF;
     IF :old.oem_oex_codigo_requisitado = :new.oem_oex_codigo_requisitado THEN
        n_oem_oex_codigo_requisitado := null;
     ELSE
        n_oem_oex_codigo_requisitado := :new.oem_oex_codigo_requisitado;
     END IF;
     IF :old.oem_data_cancel_interrupcao = :new.oem_data_cancel_interrupcao THEN
        n_oem_data_cancel_interrupcao := null;
     ELSE
        n_oem_data_cancel_interrupcao := :new.oem_data_cancel_interrupcao;
     END IF;
     IF :old.oem_motivo_cancel_interrupcao = :new.oem_motivo_cancel_interrupcao THEN
        n_oem_motivo_cancel_interrup := null;
     ELSE
        n_oem_motivo_cancel_interrup := :new.oem_motivo_cancel_interrupcao;
     END IF;
     IF :old.oem_indicador_cancelamento = :new.oem_indicador_cancelamento THEN
        n_oem_indicador_cancelamento := null;
     ELSE
        n_oem_indicador_cancelamento := :new.oem_indicador_cancelamento;
     END IF;
     /* modif 15/01/2003 */
     -- IF :old.oem_dep_codigo = :new.oem_dep_codigo THEN
     --    n_oem_dep_codigo := null;
     -- ELSE
     /* Agora se carrega sempre com o valor de :new.oem_dep_codigo */
     n_oem_dep_codigo := :new.oem_dep_codigo;
     -- END IF;
     /* fim modif */
     IF :old.oem_indicador_onus = :new.oem_indicador_onus THEN
        n_oem_indicador_onus := null;
     ELSE
        n_oem_indicador_onus := :new.oem_indicador_onus;
     END IF;
     IF :old.oem_diploma_legal_termino = :new.oem_diploma_legal_termino THEN
        n_oem_diploma_legal_termino := null;
     ELSE
        n_oem_diploma_legal_termino := :new.oem_diploma_legal_termino;
     END IF;
     IF :old.oem_pfe_emp_num_matr_program = :new.oem_pfe_emp_num_matr_program THEN
        n_oem_pfe_emp_num_matr_program := null;
     ELSE
        n_oem_pfe_emp_num_matr_program := :new.oem_pfe_emp_num_matr_program;
     END IF;
     IF :old.oem_pfe_sequencial_program = :new.oem_pfe_sequencial_program THEN
        n_oem_pfe_sequencial_program := null;
     ELSE
        n_oem_pfe_sequencial_program := :new.oem_pfe_sequencial_program;
     END IF;
     IF :old.oem_pfe_emp_num_matr_confirm1 = :new.oem_pfe_emp_num_matr_confirm1 THEN
        n_oem_pfe_emp_num_matr_confir1 := null;
     ELSE
        n_oem_pfe_emp_num_matr_confir1 := :new.oem_pfe_emp_num_matr_confirm1;
     END IF;
     IF :old.oem_pfe_sequencial_confirm1 = :new.oem_pfe_sequencial_confirm1 THEN
        n_oem_pfe_sequencial_confirm1 := null;
     ELSE
        n_oem_pfe_sequencial_confirm1 := :new.oem_pfe_sequencial_confirm1;
     END IF;
     IF :old.oem_pfe_emp_num_matr_confirm2 = :new.oem_pfe_emp_num_matr_confirm2 THEN
        n_oem_pfe_emp_num_matr_confir2 := null;
     ELSE
        n_oem_pfe_emp_num_matr_confir2 := :new.oem_pfe_emp_num_matr_confirm2;
     END IF;
     IF :old.oem_pfe_sequencial_confirm2 = :new.oem_pfe_sequencial_confirm2 THEN
        n_oem_pfe_sequencial_confirm2 := null;
     ELSE
        n_oem_pfe_sequencial_confirm2 := :new.oem_pfe_sequencial_confirm2;
     END IF;
     IF :old.oem_fun_codigo = :new.oem_fun_codigo THEN
        n_oem_fun_codigo := null;
     ELSE
        n_oem_fun_codigo := :new.oem_fun_codigo;
     END IF;
     IF :old.oem_fun_codigo_substitui = :new.oem_fun_codigo_substitui THEN
        n_oem_fun_codigo_substitui := null;
     ELSE
        n_oem_fun_codigo_substitui := :new.oem_fun_codigo_substitui;
     END IF;
     IF :old.oem_fun_codigo_acumula = :new.oem_fun_codigo_acumula THEN
        n_oem_fun_codigo_acumula := null;
     ELSE
        n_oem_fun_codigo_acumula := :new.oem_fun_codigo_acumula;
     END IF;
     IF :old.OEM_DEP_CODIGO_ORIGEM = :new.OEM_DEP_CODIGO_ORIGEM THEN
        n_OEM_DEP_CODIGO_ORIGEM := null;
     ELSE
        n_OEM_DEP_CODIGO_ORIGEM := :new.OEM_DEP_CODIGO_ORIGEM;
     END IF;
     IF :old.OEM_MOV_PARAMETRO = :new.OEM_MOV_PARAMETRO THEN
        n_OEM_MOV_PARAMETRO := null;
     ELSE
        n_OEM_MOV_PARAMETRO := :new.OEM_MOV_PARAMETRO;
     END IF;
     IF :old.OEM_CAR_CODIGO = :new.OEM_CAR_CODIGO THEN
        n_OEM_CAR_CODIGO := null;
     ELSE
        n_OEM_CAR_CODIGO := :new.OEM_CAR_CODIGO;
     END IF;
     IF  :old.OEM_CAR_CODIGO_NIVEL = :new.OEM_CAR_CODIGO_NIVEL THEN
        n_OEM_CAR_CODIGO_NIVEL := null;
     ELSE
        n_OEM_CAR_CODIGO_NIVEL := :new.OEM_CAR_CODIGO_NIVEL;
     END IF;
     IF  :old.OEM_CAR_OCC_CODIGO = :new.OEM_CAR_OCC_CODIGO THEN
        n_OEM_CAR_OCC_CODIGO := null;
     ELSE
        n_OEM_CAR_OCC_CODIGO := :new.OEM_CAR_OCC_CODIGO;
     END IF;
     IF  :old.OEM_EMP_NSA_CODIGO_NIVEL = :new.OEM_EMP_NSA_CODIGO_NIVEL THEN
        n_OEM_EMP_NSA_CODIGO_NIVEL := null;
     ELSE
        n_OEM_EMP_NSA_CODIGO_NIVEL := :new.OEM_EMP_NSA_CODIGO_NIVEL;
     END IF;
     IF  :old.OEM_EMP_NSA_CODIGO_PADRAO = :new.OEM_EMP_NSA_CODIGO_PADRAO THEN
        n_OEM_EMP_NSA_CODIGO_PADRAO := null;
     ELSE
        n_OEM_EMP_NSA_CODIGO_PADRAO := :new.OEM_EMP_NSA_CODIGO_PADRAO;
     END IF;
     IF  :old.OEM_EMP_NSA_IN_NIVEL_ESCOL = :new.OEM_EMP_NSA_IN_NIVEL_ESCOL THEN
        n_OEM_EMP_NSA_IN_NIVEL_ESCOL := null;
     ELSE
        n_OEM_EMP_NSA_IN_NIVEL_ESCOL := :new.OEM_EMP_NSA_IN_NIVEL_ESCOL;
     END IF;
     IF  :old.OEM_TIPO_REMUNERACAO_FUNCAO = :new.OEM_TIPO_REMUNERACAO_FUNCAO THEN
        n_OEM_TIPO_REMUNERACAO_FUNCAO := null;
     ELSE
        n_OEM_TIPO_REMUNERACAO_FUNCAO := :new.OEM_TIPO_REMUNERACAO_FUNCAO;
     END IF;
     IF  :old.OEM_CCT_CODIGO = :new.OEM_CCT_CODIGO THEN
        n_OEM_CCT_CODIGO := null;
     ELSE
        n_OEM_CCT_CODIGO := :new.OEM_CCT_CODIGO;
     END IF;
     IF  :old.OEM_VALOR = :new.OEM_VALOR THEN
        n_OEM_VALOR := null;
     ELSE
        n_OEM_VALOR := :new.OEM_VALOR;
     END IF;
     IF  :old.OEM_ESC_CID_CODIGO = :new.OEM_ESC_CID_CODIGO THEN
        n_OEM_ESC_CID_CODIGO := null;
     ELSE
        n_OEM_ESC_CID_CODIGO := :new.OEM_ESC_CID_CODIGO;
     END IF;
     IF  :old.OEM_ESC_EID_CODIGO = :new.OEM_ESC_EID_CODIGO THEN
        n_OEM_ESC_EID_CODIGO := null;
     ELSE
        n_OEM_ESC_EID_CODIGO := :new.OEM_ESC_EID_CODIGO;
     END IF;
     IF  :old.OEM_TIPO_EXPEDIENTE = :new.OEM_TIPO_EXPEDIENTE THEN
        n_OEM_TIPO_EXPEDIENTE := null;
     ELSE
        n_OEM_TIPO_EXPEDIENTE := :new.OEM_TIPO_EXPEDIENTE;
     END IF;
     IF  :old.OEM_COD_HORARIO_EMPREGADO = :new.OEM_COD_HORARIO_EMPREGADO THEN
        n_OEM_COD_HORARIO_EMPREGADO := null;
     ELSE
        n_OEM_COD_HORARIO_EMPREGADO := :new.OEM_COD_HORARIO_EMPREGADO;
     END IF;
     IF  :old.OEM_TURNO_TRABALHO_EMPREGADO = :new.OEM_TURNO_TRABALHO_EMPREGADO THEN
        n_OEM_TURNO_TRABALHO_EMPREGADO := null;
     ELSE
        n_OEM_TURNO_TRABALHO_EMPREGADO := :new.OEM_TURNO_TRABALHO_EMPREGADO;
     END IF;
     INSERT INTO LOG_OCORRENCIAS_EMPREGADOS (
                oem_emp_numero_matricula,
                oem_ofu_codigo,
                oem_data_inicio,
                oem_data_inclusao,
                oem_data_termino,
                oem_texto,
                oem_diploma_legal,
                oem_oem_emp_numero_matricula,
                oem_oem_ofu_codigo,
                oem_oem_data_inicio,
                oem_emp_numero_matricula_subst,
                oem_uor_codigo,
                oem_oex_codigo_cedido,
                oem_oex_codigo_requisitado,
                oem_data_cancel_interrupcao,
                oem_motivo_cancel_interrupcao,
                oem_indicador_cancelamento,
                oem_dep_codigo,
                oem_indicador_onus,
                oem_diploma_legal_termino,
                oem_pfe_emp_num_matr_program,
                oem_pfe_sequencial_program,
                oem_pfe_emp_num_matr_confirm1,
                oem_pfe_sequencial_confirm1,
                oem_pfe_emp_num_matr_confirm2,
                oem_pfe_sequencial_confirm2,
                oem_fun_codigo,
                oem_fun_codigo_substitui,
                oem_fun_codigo_acumula,
	        OEM_DEP_CODIGO_ORIGEM,
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
                dta_operacao,
                tip_operacao,
                cod_usuario
                )
      VALUES
                (:old.oem_emp_numero_matricula,
                 :old.oem_ofu_codigo,
                 :old.oem_data_inicio,
                 n_oem_data_inclusao,
                 n_oem_data_termino,
                 n_oem_texto,
                 n_oem_diploma_legal,
                 n_oem_oem_emp_numero_matricula,
                 n_oem_oem_ofu_codigo,
                 n_oem_oem_data_inicio,
                 n_oem_emp_numero_matricula_sub,
                 n_oem_uor_codigo,
                 n_oem_oex_codigo_cedido,
                 n_oem_oex_codigo_requisitado,
                 n_oem_data_cancel_interrupcao,
                 n_oem_motivo_cancel_interrup,
                 n_oem_indicador_cancelamento,
                 n_oem_dep_codigo,
                 n_oem_indicador_onus,
                 n_oem_diploma_legal_termino,
                 n_oem_pfe_emp_num_matr_program,
                 n_oem_pfe_sequencial_program,
                 n_oem_pfe_emp_num_matr_confir1,
                 n_oem_pfe_sequencial_confirm1,
                 n_oem_pfe_emp_num_matr_confir2,
                 n_oem_pfe_sequencial_confirm2,
                 n_oem_fun_codigo,
                 n_oem_fun_codigo_substitui,
                 n_oem_fun_codigo_acumula,
  	         n_OEM_DEP_CODIGO_ORIGEM,
		 n_OEM_MOV_PARAMETRO,
	         n_OEM_CAR_CODIGO,
	         n_OEM_CAR_CODIGO_NIVEL,
	         n_OEM_CAR_OCC_CODIGO,
	         n_OEM_EMP_NSA_CODIGO_NIVEL,
	         n_OEM_EMP_NSA_CODIGO_PADRAO,
	         n_OEM_EMP_NSA_IN_NIVEL_ESCOL,
	         n_OEM_TIPO_REMUNERACAO_FUNCAO,
	         n_OEM_CCT_CODIGO,
     		 n_OEM_VALOR,
     		 n_OEM_ESC_CID_CODIGO,
     		 n_OEM_ESC_EID_CODIGO,
     		 n_OEM_TIPO_EXPEDIENTE,
     		 n_OEM_COD_HORARIO_EMPREGADO,
     		 n_OEM_TURNO_TRABALHO_EMPREGADO,
                 sysdate,
                 'A',
                 user
                );
  END IF;
END;
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_EMPREGADOS_TEMP
-- Generated 9/3/2004 19:04:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_empregados_temp
    (oem_emp_numero_matricula       NUMBER(7) NOT NULL,
    oem_ofu_codigo                 NUMBER(4) NOT NULL,
    oem_data_inicio                DATE NOT NULL,
    oem_data_inclusao              DATE NOT NULL,
    oem_data_termino               DATE,
    oem_texto                      VARCHAR2(200),
    oem_diploma_legal              VARCHAR2(100),
    oem_oem_emp_numero_matricula   NUMBER(7),
    oem_oem_ofu_codigo             NUMBER(3),
    oem_oem_data_inicio            DATE,
    oem_emp_numero_matricula_subst NUMBER(7),
    oem_uor_codigo                 NUMBER(9),
    oem_oex_codigo_cedido          NUMBER(5),
    oem_oex_codigo_requisitado     NUMBER(5),
    oem_data_cancel_interrupcao    DATE,
    oem_motivo_cancel_interrupcao  VARCHAR2(100),
    oem_indicador_cancelamento     VARCHAR2(1),
    oem_dep_codigo                 NUMBER(4),
    oem_indicador_onus             VARCHAR2(1),
    oem_diploma_legal_termino      VARCHAR2(100),
    oem_pfe_emp_num_matr_program   NUMBER(7),
    oem_pfe_sequencial_program     NUMBER(2),
    oem_pfe_emp_num_matr_confirm1  NUMBER(7),
    oem_pfe_sequencial_confirm1    NUMBER(2),
    oem_pfe_emp_num_matr_confirm2  NUMBER(7),
    oem_pfe_sequencial_confirm2    NUMBER(2),
    oem_fun_codigo                 NUMBER(3),
    oem_fun_codigo_substitui       NUMBER(3),
    oem_fun_codigo_acumula         NUMBER(3),
    oem_dep_codigo_origem          NUMBER(4),
    oem_mov_parametro              NUMBER(11,3),
    oem_car_codigo                 NUMBER(3),
    oem_car_codigo_nivel           NUMBER(1),
    oem_car_occ_codigo             NUMBER(3),
    oem_emp_nsa_codigo_nivel       NUMBER(2),
    oem_emp_nsa_codigo_padrao      VARCHAR2(4),
    oem_emp_nsa_in_nivel_escol     VARCHAR2(1),
    oem_tipo_remuneracao_funcao    VARCHAR2(2),
    oem_cct_codigo                 NUMBER(6),
    oem_valor                      NUMBER(11,3),
    oem_esc_cid_codigo             VARCHAR2(5),
    oem_esc_eid_codigo             VARCHAR2(3),
    oem_tipo_expediente            NUMBER(1),
    oem_cod_horario_empregado      NUMBER(3),
    oem_turno_trabalho_empregado   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_EMPREGADOS_TEMP

ALTER TABLE ocorrencias_empregados_temp
ADD CONSTRAINT oem_temp_pk PRIMARY KEY (oem_emp_numero_matricula, oem_ofu_codigo, 
  oem_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_EMPREGADOS_TEMP

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_FREQUENCIA_EMP
-- Generated 9/3/2004 19:04:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_frequencia_emp
    (ofe_emp_numero_matricula       NUMBER(7) NOT NULL,
    ofe_ofu_codigo                 NUMBER(4) NOT NULL,
    ofe_data_inicio                DATE NOT NULL,
    ofe_data_inclusao              DATE NOT NULL,
    ofe_data_termino               DATE,
    ofe_texto                      VARCHAR2(200),
    ofe_diploma_legal              VARCHAR2(100),
    ofe_diploma_legal_termino      VARCHAR2(100),
    ofe_ofe_emp_numero_matricula   NUMBER(7),
    ofe_ofe_ofu_codigo             NUMBER(3),
    ofe_ofe_data_inicio            DATE,
    ofe_dep_codigo                 NUMBER(4),
    ofe_mov_parametro              NUMBER(11,3),
    ofe_tipo_expediente            NUMBER(1),
    ofe_cod_horario_empregado      NUMBER(3),
    ofe_turno_trabalho_empregado   VARCHAR2(1),
    ofe_uor_codigo                 NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for OCORRENCIAS_FREQUENCIA_EMP

CREATE INDEX ind_ofe_2 ON ocorrencias_frequencia_emp
  (
    ofe_ofu_codigo                  ASC,
    ofe_data_inicio                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ofe_ofe_fk ON ocorrencias_frequencia_emp
  (
    ofe_ofe_emp_numero_matricula    ASC,
    ofe_ofe_ofu_codigo              ASC,
    ofe_ofe_data_inicio             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ofe_dep_fk ON ocorrencias_frequencia_emp
  (
    ofe_dep_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for OCORRENCIAS_FREQUENCIA_EMP

ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ck_1 CHECK (  ofe_turno_trabalho_empregado in ('A','B','C','D','F','N') )
/
ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_pk PRIMARY KEY (ofe_emp_numero_matricula, ofe_ofu_codigo, 
  ofe_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for OCORRENCIAS_FREQUENCIA_EMP

CREATE TRIGGER trg_log_oco_frequencia_emp
BEFORE UPDATE  OR  DELETE 
ON ocorrencias_frequencia_emp
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_OCORRENCIAS_FREQUENCIA_EMP
           (
            OFE_EMP_NUMERO_MATRICULA,
            OFE_OFU_CODIGO,
            OFE_DATA_INICIO,
            OFE_DATA_INCLUSAO,
            OFE_DATA_TERMINO,
            OFE_TEXTO,
            OFE_DIPLOMA_LEGAL,
            OFE_DIPLOMA_LEGAL_TERMINO,
            OFE_OFE_EMP_NUMERO_MATRICULA,
            OFE_OFE_OFU_CODIGO,
            OFE_OFE_DATA_INICIO,
            OFE_DEP_CODIGO,
            OFE_MOV_PARAMETRO,
            OFE_TIPO_EXPEDIENTE,
            OFE_COD_HORARIO_EMPREGADO,
            OFE_TURNO_TRABALHO_EMPREGADO,
            OFE_UOR_CODIGO,
            DTA_OPERACAO,
            TIP_OPERACAO,
            COD_USUARIO
           )
           VALUES
           (
            :OLD.OFE_EMP_NUMERO_MATRICULA,
            :OLD.OFE_OFU_CODIGO,
            :OLD.OFE_DATA_INICIO,
            :OLD.OFE_DATA_INCLUSAO,
            :OLD.OFE_DATA_TERMINO,
            :OLD.OFE_TEXTO,
            :OLD.OFE_DIPLOMA_LEGAL,
            :OLD.OFE_DIPLOMA_LEGAL_TERMINO,
            :OLD.OFE_OFE_EMP_NUMERO_MATRICULA,
            :OLD.OFE_OFE_OFU_CODIGO,
            :OLD.OFE_OFE_DATA_INICIO,
            :OLD.OFE_DEP_CODIGO,
            :OLD.OFE_MOV_PARAMETRO,
            :OLD.OFE_TIPO_EXPEDIENTE,
            :OLD.OFE_COD_HORARIO_EMPREGADO,
            :OLD.OFE_TURNO_TRABALHO_EMPREGADO,
            :OLD.OFE_UOR_CODIGO,
            SYSDATE,--:OLD.DTA_OPERACAO,
            v_operacao,--:OLD.TIP_OPERACAO,
            USER--:OLD.COD_USUARIO
            );
--
END; --End TRIGGER TRG_LOG_OCO_FREQUENCIA_EMP
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_FREQUENCIA_EMP

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_INSS
-- Generated 9/3/2004 19:04:38 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_inss
    (oin_codigo_padrao_nacional     NUMBER(2) NOT NULL,
    oin_descricao                  VARCHAR2(200),
    oin_percentual_folha           NUMBER(7,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_INSS

ALTER TABLE ocorrencias_inss
ADD CONSTRAINT oin_pk PRIMARY KEY (oin_codigo_padrao_nacional)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_INSS

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_INSS_AGNOCIVOS
-- Generated 9/3/2004 19:04:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_inss_agnocivos
    (oia_agn_codigo                 NUMBER(2) NOT NULL,
    oia_oin_codigo_padrao_nacional NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_INSS_AGNOCIVOS

ALTER TABLE ocorrencias_inss_agnocivos
ADD CONSTRAINT oia_pk PRIMARY KEY (oia_agn_codigo, 
  oia_oin_codigo_padrao_nacional)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_INSS_AGNOCIVOS

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP
-- Generated 9/3/2004 19:04:52 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_pis_pasep
    (nome_arquivo                   VARCHAR2(20) NOT NULL,
    codido_ocorrencia              NUMBER(3) NOT NULL,
    tipo_ocorrencia                CHAR(1) NOT NULL,
    descricao_ocorrencia           VARCHAR2(200),
    posicao_ocorrencia             NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_PIS_PASEP

ALTER TABLE ocorrencias_pis_pasep
ADD CONSTRAINT opp_pk PRIMARY KEY (nome_arquivo, codido_ocorrencia, 
  tipo_ocorrencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_PIS_PASEP

COMMENT ON COLUMN ocorrencias_pis_pasep.codido_ocorrencia IS 'Código da ocorrência fornecido pelo Banco do Brasil.'
/
COMMENT ON COLUMN ocorrencias_pis_pasep.descricao_ocorrencia IS 'Descrição da ocorrência fornecido pelo Banco do Brasil.'
/
COMMENT ON COLUMN ocorrencias_pis_pasep.nome_arquivo IS 'Nome do arquivo fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep.posicao_ocorrencia IS 'Posição do código da ocorrência no arquivo enviado pelo BB.'
/
COMMENT ON COLUMN ocorrencias_pis_pasep.tipo_ocorrencia IS 'Tipo da ocorrência fornecido pelo Banco do Brasil. Ex: Se ocorrência de header, detalhe, trailler, etc'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP_ARQUIVO
-- Generated 9/3/2004 19:04:59 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_pis_pasep_arquivo
    (data_processamento             DATE NOT NULL,
    sequencial_arquivo             NUMBER(6) NOT NULL,
    nome_arquivo_pis_pasep         VARCHAR2(20) NOT NULL,
    oco_nome_arquivo               VARCHAR2(20),
    oco_codigo_ocorrencia          NUMBER(3),
    oco_tipo_ocorrencia            CHAR(1),
    sequencial_arquivo_banco       NUMBER(6),
    indicador_processamento        NUMBER(1),
    nr_ultima_remessa              NUMBER(6),
    nr_remessa                     NUMBER(6),
    forma_repasse                  NUMBER(1),
    data_lancamento_credito        DATE,
    data_lancamento_debito         DATE,
    agencia_lancamento             NUMBER(4),
    conta_corrente_lancamento      NUMBER(11),
    codigo_conta_tesouro_nacional  NUMBER(14),
    data_cadastro                  DATE,
    qtdade_reg_verificados         NUMBER(6),
    qtdade_reg_validos             NUMBER(6),
    qtdade_participantes_arq900    NUMBER(6),
    qtdade_partic_pagos            NUMBER(6),
    qtdade_partic_rejeitados       NUMBER(6),
    valor_lancamento               NUMBER(11,2),
    qtdade_reg_verificada_arq900   NUMBER(6),
    qtdade_cancel_aceitos          NUMBER(6),
    qtdade_cancel_rejeitados       NUMBER(6),
    qtdade_reg_tipo2               NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_PIS_PASEP_ARQUIVO

ALTER TABLE ocorrencias_pis_pasep_arquivo
ADD CONSTRAINT oppa_pk PRIMARY KEY (data_processamento, sequencial_arquivo, 
  nome_arquivo_pis_pasep)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_PIS_PASEP_ARQUIVO

COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.agencia_lancamento IS 'Agência de lançamento do débito'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.codigo_conta_tesouro_nacional IS 'Soma dos registros rejeitados nos dois processamentos (prévio e definitivo)'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.conta_corrente_lancamento IS 'Conta corrente do lançamento do débito'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.data_cadastro IS 'Soma dos valores individuais dos registros'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.data_lancamento_credito IS 'Data do lançamento do crédito'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.data_lancamento_debito IS 'Data do lançamento do débito'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.data_processamento IS 'Data do processamento fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.forma_repasse IS 'Código da forma escolhida para repasse do crédito'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.indicador_processamento IS 'Campo que indica se o arquivo foi recusado ou processado com sucesso'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.nome_arquivo_pis_pasep IS 'Nome do arquivo fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.nr_remessa IS 'Número da remessa do arquivo 900'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.nr_ultima_remessa IS 'Indica o número da última remessa processada com sucesso'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.oco_codigo_ocorrencia IS 'Código da ocorrência fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.oco_nome_arquivo IS 'Nome do arquivo fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.oco_tipo_ocorrencia IS 'Tipo da ocorrência fornecido pelo Banco do Brasil.Ex: Se ocorrência de header, detalhe, trailler, etc'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.qtdade_partic_pagos IS 'Quantidade de registros tipo2 válidos'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.qtdade_participantes_arq900 IS 'Soma dos registros rejeitados nos dois processamentos (prévio e definitivo)'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.qtdade_reg_validos IS 'Quantidade de registros aceitos no processamento definitivo'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.qtdade_reg_verificados IS 'Quantidade de participantes enviados para processamento'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.sequencial_arquivo IS 'Sequencial do arquivo fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_arquivo.sequencial_arquivo_banco IS 'Número de referência do arquivo no sistema FPS do banco.'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP_ARQUIVO

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP_EMP
-- Generated 9/3/2004 19:05:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_pis_pasep_emp
    (matricula                      NUMBER(7) NOT NULL,
    data_processamento             DATE NOT NULL,
    sequencial_arquivo             NUMBER(6) NOT NULL,
    sequencial_emp                 NUMBER(6) NOT NULL,
    oco_nome_arquivo               VARCHAR2(20),
    oco_codigo_ocorrencia          NUMBER(3),
    oco_tipo_ocorrencia            CHAR(1),
    nr_pis_ativa                   NUMBER(11),
    nr_original_remanescente       NUMBER(11),
    nome_empregado_pasep           VARCHAR2(100),
    indicador_processamento        NUMBER(1),
    valor                          NUMBER(9,2),
    cnpj_ent_pagadora              NUMBER(14),
    data_pagamento                 DATE,
    data_cadastro                  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_PIS_PASEP_EMP

ALTER TABLE ocorrencias_pis_pasep_emp
ADD CONSTRAINT oppe_pk PRIMARY KEY (matricula, data_processamento, 
  sequencial_arquivo, sequencial_emp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_PIS_PASEP_EMP

COMMENT ON COLUMN ocorrencias_pis_pasep_emp.cnpj_ent_pagadora IS 'CNPJ da entidade que fez o pagamento do PIS, no caso do empregado já tenha sido pago'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.data_cadastro IS 'Data do cadastro do arquivo na base Gestorh'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.data_pagamento IS 'Data em que o pagamento foi efetuado, caso o empregado já tenha sido pago por outra entidade'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.data_processamento IS 'Data do processamento fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.indicador_processamento IS 'Indicador de processamento fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.matricula IS 'Matricula do empregado'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.nome_empregado_pasep IS 'Nome do empregado cadastrado no PASEP'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.nr_original_remanescente IS 'Número do PIS original ou remanescente'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.nr_pis_ativa IS 'Número do PIS ativo'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.oco_codigo_ocorrencia IS 'Código da ocorrência fornecido pelo Banco do Brasil.'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.oco_nome_arquivo IS 'Data do processamento fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.oco_tipo_ocorrencia IS 'Tipo da ocorrência fornecido pelo Banco do Brasil.Ex: Se ocorrência de header, detalhe, trailler, etc'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.sequencial_arquivo IS 'Sequencial do arquivo fornecido pelo Banco do Brasil'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.sequencial_emp IS 'Sequencial do empregado na tabela'
/
COMMENT ON COLUMN ocorrencias_pis_pasep_emp.valor IS 'Valor que o empregado faz jus'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_PIS_PASEP_EMP

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_TICKETS
-- Generated 9/3/2004 19:05:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_receb_tickets
    (ort_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    ort_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    ort_mes                        NUMBER(2) NOT NULL,
    ort_ano                        NUMBER(4) NOT NULL,
    ort_tipo_pedido                NUMBER(3) NOT NULL,
    ort_dep_codigo                 NUMBER(4) NOT NULL,
    ort_data                       DATE NOT NULL,
    ort_quantidade                 NUMBER(3),
    ort_qtd_bloco                  NUMBER(3),
    ort_valor                      NUMBER(5,2),
    ort_quantidade_avul            NUMBER(3),
    ort_obs                        VARCHAR2(400),
    ort_codigo_pedido              NUMBER NOT NULL,
    ort_cancelado                  VARCHAR2(1),
    ort_mes_mapa                   NUMBER(2) NOT NULL,
    ort_ano_mapa                   NUMBER(4) NOT NULL,
    ort_data_cancelamento          DATE,
    ort_uor_codigo                 NUMBER(9) NOT NULL,
    ort_cd_custos                  NUMBER(10) NOT NULL,
    ort_pago                       VARCHAR2(1),
    ort_numero_nota                NUMBER(6),
    ort_participacao               NUMBER(12,2),
    ort_dep_codigo_fisico          NUMBER(4),
    ort_mes_pagamento              NUMBER(2) NOT NULL,
    ort_ano_pagamento              NUMBER(4) NOT NULL,
    ort_emb_opcao                  VARCHAR2(1),
    ort_devolucao                  NUMBER(3),
    ort_data_geracao_participacao  DATE,
    ort_emb_opcao_alim             VARCHAR2(1),
    ort_emb_opcao_ref              VARCHAR2(1),
    ort_emb_qtd_alim               NUMBER(4),
    ort_emb_qtd_ref                NUMBER(4),
    ort_qtd_bloco_alim             NUMBER(3),
    ort_qtd_avulso_alim            NUMBER(3),
    ort_qtd_bloco_ref              NUMBER(3),
    ort_qtd_avulso_ref             NUMBER(3),
    ort_devol_alim                 NUMBER(3),
    ort_devol_ref                  NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_RECEB_TICKETS

ALTER TABLE ocorrencias_receb_tickets
ADD CONSTRAINT ort_pk PRIMARY KEY (ort_mes, ort_ano, ort_tipo_pedido, 
  ort_emb_emp_numero_matricula, ort_codigo_pedido, ort_data)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_RECEB_TICKETS

COMMENT ON COLUMN ocorrencias_receb_tickets.ort_emb_opcao IS 'Opcao do empregado no pami'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_TICKETS

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_VALES
-- Generated 9/3/2004 19:05:24 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_receb_vales
    (orv_emc_emb_emp_numero_matricu NUMBER(7) NOT NULL,
    orv_emc_emb_ben_sigla          VARCHAR2(3) NOT NULL,
    orv_emc_cat_sigla              VARCHAR2(6) NOT NULL,
    orv_sequencial                 NUMBER(4) NOT NULL,
    orv_mes                        NUMBER(2) NOT NULL,
    orv_ano                        NUMBER(4) NOT NULL,
    orv_quantidade                 NUMBER(3) NOT NULL,
    orv_data                       DATE NOT NULL,
    orv_valor                      NUMBER(6,2),
    orv_cancelado                  VARCHAR2(1),
    orv_data_cancelamento          DATE,
    orv_obs                        VARCHAR2(1000),
    orv_mes_mapa                   NUMBER(2) NOT NULL,
    orv_ano_mapa                   NUMBER(4) NOT NULL,
    orv_dep_codigo_fisico          NUMBER(4) NOT NULL,
    orv_uor_codigo                 NUMBER(9) NOT NULL,
    orv_cd_custos                  NUMBER(10) NOT NULL,
    orv_quantidade_bolsista        NUMBER(4),
    orv_pago                       VARCHAR2(1),
    orv_participacao               NUMBER(12,2),
    orv_codigo_pedido              NUMBER,
    orv_dep_codigo_lotacao         NUMBER(4) NOT NULL,
    orv_mes_pagamento              NUMBER(2) NOT NULL,
    orv_ano_pagamento              NUMBER(4) NOT NULL,
    orv_doc_numero                 NUMBER(6),
    orv_tipo_pedido                VARCHAR2(1) NOT NULL,
    orv_data_geracao_participacao  DATE,
    orv_emc_tipo_utilizacao        NUMBER(1),
    orv_cat_cbe_cre_sequencial     NUMBER(5),
    orv_devolucao                  NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_RECEB_VALES

ALTER TABLE ocorrencias_receb_vales
ADD CONSTRAINT orv_pk PRIMARY KEY (orv_dep_codigo_fisico, orv_emc_cat_sigla, 
  orv_emc_emb_emp_numero_matricu, orv_emc_emb_ben_sigla, orv_sequencial, orv_mes, 
  orv_ano)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_RECEB_VALES

COMMENT ON COLUMN ocorrencias_receb_vales.orv_ano IS 'Ano Corrente'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_cat_cbe_cre_sequencial IS 'Código do credenciado vinculado a categoria de transporte da ocorrência'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_data IS 'Data de recebimento do Vale'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_devolucao IS 'Quantidade devolvida de vale transporte'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_emc_cat_sigla IS 'Indica a categoria do transporte'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_emc_emb_ben_sigla IS 'Sigla do Beneficio'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_emc_emb_emp_numero_matricu IS 'Matricula unica atribuida ao empregado pelo sistema.'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_mes IS 'Mes da Ocorrencia'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_quantidade IS 'Quantidade de Vales recebidos'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_sequencial IS 'Numero sequencial da Ocorrencia no mes'
/
COMMENT ON COLUMN ocorrencias_receb_vales.orv_valor IS 'Valor unitario do transporte'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_VALES

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_VALES_TMP2
-- Generated 9/3/2004 19:05:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_receb_vales_tmp2
    (orv_emc_emb_emp_numero_matricu NUMBER(7) NOT NULL,
    orv_emc_emb_ben_sigla          VARCHAR2(3) NOT NULL,
    orv_emc_cat_sigla              VARCHAR2(6) NOT NULL,
    orv_sequencial                 NUMBER(2) NOT NULL,
    orv_mes                        NUMBER(2) NOT NULL,
    orv_ano                        NUMBER(4) NOT NULL,
    orv_quantidade                 NUMBER(3) NOT NULL,
    orv_data                       DATE NOT NULL,
    orv_valor                      NUMBER(6,2),
    orv_cancelado                  VARCHAR2(1),
    orv_data_cancelamento          DATE,
    orv_obs                        VARCHAR2(200),
    orv_mes_mapa                   NUMBER(2) NOT NULL,
    orv_ano_mapa                   NUMBER(4) NOT NULL,
    orv_dep_codigo                 NUMBER(4) NOT NULL,
    orv_uor_codigo                 NUMBER(9) NOT NULL,
    orv_cd_custos                  NUMBER(10) NOT NULL,
    orv_quantidade_bolsista        NUMBER(4),
    orv_pago                       VARCHAR2(1),
    orv_participacao               NUMBER(12,2),
    orv_codigo_pedido              NUMBER,
    orv_dep_codigo_fisico          NUMBER(4),
    orv_mes_pagamento              NUMBER(2) NOT NULL,
    orv_ano_pagamento              NUMBER(4) NOT NULL,
    orv_doc_numero                 NUMBER(6),
    orv_tipo_pedido                VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_RECEB_VALES_TMP2

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_SITUACOES_FUNC
-- Generated 9/3/2004 19:05:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_situacoes_func
    (osf_sfu_codigo                 NUMBER(1) NOT NULL,
    osf_ofu_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for OCORRENCIAS_SITUACOES_FUNC

CREATE INDEX osf_ofu_fk_i ON ocorrencias_situacoes_func
  (
    osf_ofu_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX osf_sfu_fk_i ON ocorrencias_situacoes_func
  (
    osf_sfu_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for OCORRENCIAS_SITUACOES_FUNC

ALTER TABLE ocorrencias_situacoes_func
ADD CONSTRAINT osf_pk PRIMARY KEY (osf_sfu_codigo, osf_ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ocorrencias_situacoes_func
ADD CONSTRAINT osf_sfu_codigo_ck CHECK (  osf_sfu_codigo IN ( 2 , 3 , 4 , 1 )                                             )
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_SITUACOES_FUNC

-- Start of DDL Script for Table IFRSRH.OCORRENCIAS_VIAGENS_EMPREGADOS
-- Generated 9/3/2004 19:05:54 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocorrencias_viagens_empregados
    (ove_oem_emp_numero_matricula   NUMBER(7) NOT NULL,
    ove_oem_ofu_codigo             NUMBER(4) NOT NULL,
    ove_oem_data_inicio            DATE NOT NULL,
    ove_codigo_trecho              NUMBER(2) NOT NULL,
    ove_data_inicio                DATE NOT NULL,
    ove_data_termino               DATE NOT NULL,
    ove_descricao                  VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCORRENCIAS_VIAGENS_EMPREGADOS

ALTER TABLE ocorrencias_viagens_empregados
ADD CONSTRAINT ove_pk PRIMARY KEY (ove_oem_emp_numero_matricula, 
  ove_oem_ofu_codigo, ove_oem_data_inicio, ove_codigo_trecho)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCORRENCIAS_VIAGENS_EMPREGADOS

COMMENT ON TABLE ocorrencias_viagens_empregados IS 'Armazenará as informações dos trechos referentes à ocorrência de viagem do empregado'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_codigo_trecho IS 'NÚMERO DO TRECHO DA OCORRÊNCIA DE VIAGEM DO EMPREGADO'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_data_inicio IS 'DATA DE INÍCIO DO TRECHO'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_data_termino IS 'DATA DE TÉRMINO DO TRECHO'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_descricao IS 'DESCRIÇÃO DO TRECHO'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_oem_data_inicio IS 'DATA DE INÍCIO DA OCORRÊNCIA FUNCIONAL'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_oem_emp_numero_matricula IS 'NÚMERO DA MATRÍCULA DO EMPREGADO NA INFRAERO'
/
COMMENT ON COLUMN ocorrencias_viagens_empregados.ove_oem_ofu_codigo IS 'NÚMERO DA OCORRÊNCIA FUNCIONAL'
/

-- End of DDL Script for Table IFRSRH.OCORRENCIAS_VIAGENS_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.OCUPACOES_CARGO
-- Generated 9/3/2004 19:06:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE ocupacoes_cargo
    (occ_codigo                     NUMBER(3) NOT NULL,
    occ_descricao                  VARCHAR2(50),
    occ_data_inicio                DATE NOT NULL,
    occ_documento_inicio           VARCHAR2(30) NOT NULL,
    occ_data_termino               DATE,
    occ_documento_termino          VARCHAR2(30),
    occ_flag_area_ocupacao         VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OCUPACOES_CARGO

ALTER TABLE ocupacoes_cargo
ADD CONSTRAINT occ_pk PRIMARY KEY (occ_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for OCUPACOES_CARGO

COMMENT ON TABLE ocupacoes_cargo IS 'SRHCAD - '
/

-- End of DDL Script for Table IFRSRH.OCUPACOES_CARGO

-- Start of DDL Script for Table IFRSRH.OPERANDOS
-- Generated 9/3/2004 19:06:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE operandos
    (ope_sigla                      VARCHAR2(10) NOT NULL,
    ope_descricao                  VARCHAR2(50) NOT NULL,
    ope_comentario                 VARCHAR2(1000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for OPERANDOS

ALTER TABLE operandos
ADD CONSTRAINT ope_pk PRIMARY KEY (ope_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.OPERANDOS

-- Start of DDL Script for Table IFRSRH.ORGAOS_CLASSES
-- Generated 9/3/2004 19:06:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE orgaos_classes
    (ocl_sigla                      VARCHAR2(6) NOT NULL,
    ocl_descricao                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for ORGAOS_CLASSES

ALTER TABLE orgaos_classes
ADD CONSTRAINT ocl_pk PRIMARY KEY (ocl_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE orgaos_classes
ADD CONSTRAINT ocl_uk UNIQUE (ocl_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.ORGAOS_CLASSES

-- Start of DDL Script for Table IFRSRH.PAGAMENTO_CALCULADO_2110
-- Generated 9/3/2004 19:06:29 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pagamento_calculado_2110
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    mat                            NUMBER(9),
    cod_prov_desc                  NUMBER(4),
    prazo                          NUMBER(4),
    frequencia                     NUMBER(15,6),
    valor                          NUMBER(20,2),
    rubrica                        VARCHAR2(1),
    cod_dep                        NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PAGAMENTO_CALCULADO_2110

CREATE INDEX pgc_2110 ON pagamento_calculado_2110
  (
    ano                             ASC,
    mes                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.PAGAMENTO_CALCULADO_2110

-- Start of DDL Script for Table IFRSRH.PAGAMENTO_CALCULADO_FINAL
-- Generated 9/3/2004 19:06:36 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pagamento_calculado_final
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    mat                            NUMBER(9),
    tipo_pagamento                 VARCHAR2(1),
    cod_prov_desc                  NUMBER(4),
    prazo                          NUMBER(4),
    frequencia                     NUMBER(15,6),
    valor                          NUMBER(20,2),
    rubrica                        VARCHAR2(1),
    cod_dep                        NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PAGAMENTO_CALCULADO_FINAL

CREATE INDEX pcf ON pagamento_calculado_final
  (
    ano                             ASC,
    mes                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.PAGAMENTO_CALCULADO_FINAL

-- Start of DDL Script for Table IFRSRH.PAGAMENTO_TEMP
-- Generated 9/3/2004 19:06:43 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pagamento_temp
    (tmp_sequencia                  NUMBER,
    tmp_dep_codigo                 NUMBER(4),
    dep_sigla                      VARCHAR2(10),
    dep_nome                       VARCHAR2(60))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PAGAMENTO_TEMP

-- Start of DDL Script for Table IFRSRH.PAGAMENTOS_ESPECIAIS
-- Generated 9/3/2004 19:06:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pagamentos_especiais
    (pge_sequencial                 NUMBER(6) NOT NULL,
    pge_aes_emb_emp_numero_matric  NUMBER(7) NOT NULL,
    pge_aes_emb_ben_sigla          VARCHAR2(3) NOT NULL,
    pge_aes_valor_autorizado       NUMBER(12,2) NOT NULL,
    pge_dep_codigo                 NUMBER(4) NOT NULL,
    pge_cgc_empresa                NUMBER(17) NOT NULL,
    pge_dv_empresa                 NUMBER(2) NOT NULL,
    pge_nome_empresa               VARCHAR2(70) NOT NULL,
    pge_telefone_empresa           NUMBER(10),
    pge_conta_corrente             NUMBER(10),
    pge_agencia                    VARCHAR2(7),
    pge_banco                      NUMBER(3),
    pge_documento_fiscal           NUMBER(1) NOT NULL,
    pge_aes_numero_documento       VARCHAR2(25) NOT NULL,
    pge_data_pagamento             DATE NOT NULL,
    pge_data_lancamento            DATE NOT NULL,
    pge_tipo_pessoa                VARCHAR2(1) NOT NULL,
    pge_participacao               VARCHAR2(1),
    pge_valor_participacao         NUMBER(12,2),
    pge_processo_encerrado         VARCHAR2(1),
    pge_mes_pagamento              NUMBER(2) NOT NULL,
    pge_ano_pagamento              NUMBER(4) NOT NULL,
    pge_observacao                 VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PAGAMENTOS_ESPECIAIS

ALTER TABLE pagamentos_especiais
ADD CONSTRAINT pge_sequencial_pk PRIMARY KEY (pge_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PAGAMENTOS_ESPECIAIS

-- Start of DDL Script for Table IFRSRH.PARAMETROS_FUNCOES
-- Generated 9/3/2004 19:07:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE parametros_funcoes
    (cd_perfil                      NUMBER(2) NOT NULL,
    fun_codigo                     NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PARAMETROS_FUNCOES

ALTER TABLE parametros_funcoes
ADD CONSTRAINT prm_uk UNIQUE (cd_perfil, fun_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PARAMETROS_FUNCOES

-- Start of DDL Script for Table IFRSRH.PARAMETROS_OCORRENCIAS_FUNC
-- Generated 9/3/2004 19:07:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE parametros_ocorrencias_func
    (cd_perfil                      NUMBER(2) NOT NULL,
    ofu_codigo                     NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PARAMETROS_OCORRENCIAS_FUNC

ALTER TABLE parametros_ocorrencias_func
ADD CONSTRAINT pof_uk UNIQUE (cd_perfil, ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PARAMETROS_OCORRENCIAS_FUNC

-- Start of DDL Script for Table IFRSRH.PEDIDOS_COBRANCAS
-- Generated 9/3/2004 19:07:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pedidos_cobrancas
    (pco_doc_numero                 NUMBER(10) NOT NULL,
    pco_doc_cbe_ben_sigla          VARCHAR2(3) NOT NULL,
    pco_doc_cbe_cre_sequencial     NUMBER(5) NOT NULL,
    pco_valor                      NUMBER(12,2) NOT NULL,
    pco_numero_pedido              NUMBER NOT NULL,
    pco_doc_dep_codigo             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PEDIDOS_COBRANCAS

ALTER TABLE pedidos_cobrancas
ADD CONSTRAINT pco_pk PRIMARY KEY (pco_doc_numero, pco_doc_cbe_ben_sigla, 
  pco_doc_cbe_cre_sequencial, pco_doc_dep_codigo, pco_numero_pedido)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PEDIDOS_COBRANCAS

-- Start of DDL Script for Table IFRSRH.PEDIDOS_TICKETS
-- Generated 9/3/2004 19:07:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pedidos_tickets
    (pkt_mes                        NUMBER(2),
    pkt_ano                        NUMBER(4),
    pkt_tipo_pedido                NUMBER(1),
    pkt_matricula                  NUMBER(7),
    pkt_dependencia                NUMBER(4) NOT NULL,
    pkt_aeroportos                 VARCHAR2(1),
    pkt_credenciados               NUMBER(5),
    pkt_data_entrega               DATE,
    pkt_data_execucao              DATE,
    pkt_qtd_bloco                  NUMBER(3),
    pkt_valor_ticket               NUMBER(5,2),
    pkt_codigo_ref                 VARCHAR2(25),
    pkt_qtd_emp_ref                NUMBER(5),
    pkt_qtd_bloco_ref              NUMBER(5),
    pkt_qtd_avulso_ref             NUMBER(5),
    pkt_total_ticref               NUMBER(5),
    pkt_valor_ticref               NUMBER(12,2),
    pkt_codigo_ali                 VARCHAR2(25),
    pkt_qtd_emp_ali                NUMBER(5),
    pkt_qtd_bloco_ali              NUMBER(5),
    pkt_qtd_avulso_ali             NUMBER(5),
    pkt_total_ticali               NUMBER(5),
    pkt_valor_ticali               NUMBER(12,2),
    pkt_valor_total                NUMBER(12,2),
    pkt_codigo_pedido              NUMBER NOT NULL,
    pkt_mes_mapa                   NUMBER(2),
    pkt_ano_mapa                   NUMBER(4),
    pkt_dep_resp_incl              NUMBER(4) NOT NULL,
    pkt_ind_ref_pago               VARCHAR2(1),
    pkt_ind_ali_pago               VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PEDIDOS_TICKETS

ALTER TABLE pedidos_tickets
ADD CONSTRAINT pkt_pk PRIMARY KEY (pkt_codigo_pedido, pkt_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for PEDIDOS_TICKETS

COMMENT ON COLUMN pedidos_tickets.pkt_ind_ali_pago IS 'Indicador de pagamento da fatura de vale alimentação.'
/
COMMENT ON COLUMN pedidos_tickets.pkt_ind_ref_pago IS 'Indicador de pagamento da fatura de vale refeição.'
/

-- End of DDL Script for Table IFRSRH.PEDIDOS_TICKETS

-- Start of DDL Script for Table IFRSRH.PENSIONISTAS
-- Generated 9/3/2004 19:07:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pensionistas
    (pen_emp_numero_matricula       NUMBER(7) NOT NULL,
    pen_codigo                     NUMBER(2) NOT NULL,
    pen_nome                       VARCHAR2(50) NOT NULL,
    pen_data_nascimento            DATE,
    pen_sexo                       VARCHAR2(1) NOT NULL,
    pen_endereco_logradouro        VARCHAR2(50),
    pen_endereco_bairro            VARCHAR2(30),
    pen_endereco_cidade            VARCHAR2(30),
    pen_endereco_uf                VARCHAR2(2),
    pen_endereco_cep               NUMBER(8),
    pen_endereco_fone              NUMBER(12),
    pen_nu_carteira_identidade     VARCHAR2(15),
    pen_orgao_emitente_ci          VARCHAR2(10),
    pen_data_expedicao_ci          DATE,
    pen_numero_cpf                 NUMBER(11),
    pen_data_inicio_desc           DATE NOT NULL,
    pen_data_fim_desc              DATE,
    pen_tipo_recebimento           NUMBER(1) NOT NULL,
    pen_banco_recebimento          NUMBER(3),
    pen_agencia_banco_recebim      VARCHAR2(7),
    pen_conta_corrente_receb       VARCHAR2(14),
    pen_documento_legal            VARCHAR2(50) NOT NULL,
    pen_ind_13_salario             VARCHAR2(1),
    pen_ind_suplementar            VARCHAR2(1),
    pen_comentario                 VARCHAR2(100),
    pen_ramal_residencia           NUMBER(4),
    pen_ddd_residencia             NUMBER(4),
    pen_for_codigo                 NUMBER(3),
    pen_ind_ferias                 VARCHAR2(1),
    pen_for_codigo_ferias          NUMBER(3),
    pen_for_codigo_13              NUMBER(3),
    pen_tipo_pensao                VARCHAR2(1),
    pen_mov_parametro              NUMBER(11,3),
    pen_mov_parametro_ferias       NUMBER(11,3),
    pen_mov_parametro_13           NUMBER(11,3),
    pen_valor_desc_ticket          NUMBER(15,2),
    pen_tipo_desc_ticket           VARCHAR2(1),
    pen_opcao_ticket               VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PENSIONISTAS

ALTER TABLE pensionistas
ADD CONSTRAINT pen_ck_1 CHECK (  pen_ind_13_salario      in ('S','N')                                            )
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_ck_2 CHECK (  pen_ind_suplementar     in ('S','N')                                            )
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_opcao_ticket_ck CHECK (PEN_OPCAO_TICKET IN ('A','R'))
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_pk PRIMARY KEY (pen_emp_numero_matricula, pen_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_tipo_desc_ticket_ck CHECK (PEN_TIPO_DESC_TICKET IN ('P','V'))
/

-- End of DDL Script for Table IFRSRH.PENSIONISTAS

-- Start of DDL Script for Table IFRSRH.PERICUL_INSALUB_AGNOCIVOS
-- Generated 9/3/2004 19:07:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pericul_insalub_agnocivos
    (pia_agn_codigo                 NUMBER(2) NOT NULL,
    pia_hpi_emp_numero_matricula   NUMBER(7) NOT NULL,
    pia_hpi_data_inicio            DATE NOT NULL,
    pia_hpi_ind_pericul_insalub    VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PERICUL_INSALUB_AGNOCIVOS

ALTER TABLE pericul_insalub_agnocivos
ADD CONSTRAINT pia_pk PRIMARY KEY (pia_agn_codigo, pia_hpi_emp_numero_matricula, 
  pia_hpi_data_inicio, pia_hpi_ind_pericul_insalub)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PERICUL_INSALUB_AGNOCIVOS

-- Start of DDL Script for Table IFRSRH.PERICUL_INSALUB_NAO_AUTORIZADA
-- Generated 9/3/2004 19:07:43 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pericul_insalub_nao_autorizada
    (pin_emp_numero_matricula       NUMBER(7) NOT NULL,
    pin_percentual                 NUMBER(2) NOT NULL,
    pin_data_inicio                DATE NOT NULL,
    pin_data_nao_autorizacao       DATE NOT NULL,
    pin_data_inclusao              DATE NOT NULL,
    pin_ind_pericul_insalub        VARCHAR2(1) NOT NULL,
    pin_ind_nao_autor_sede_sr      VARCHAR2(1) NOT NULL,
    pin_cod_resp_nao_autorizacao   VARCHAR2(10) NOT NULL,
    pin_documento_inicio           VARCHAR2(30) NOT NULL,
    pin_motivo_nao_autorizacao     VARCHAR2(200) NOT NULL,
    pin_data_termino               DATE,
    pin_data_cancelamento          DATE,
    pin_documento_termino          VARCHAR2(30),
    pin_documento_cancelamento     VARCHAR2(30),
    pin_resumo                     VARCHAR2(200),
    pin_observacao                 VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PERICUL_INSALUB_NAO_AUTORIZADA

ALTER TABLE pericul_insalub_nao_autorizada
ADD CONSTRAINT pin_ck_1 CHECK ( PIN_IND_PERICUL_INSALUB in ('P','I') )
/
ALTER TABLE pericul_insalub_nao_autorizada
ADD CONSTRAINT pin_ck_2 CHECK ( PIN_IND_NAO_AUTOR_SEDE_SR in ('S','R') )
/
ALTER TABLE pericul_insalub_nao_autorizada
ADD CONSTRAINT pin_pk PRIMARY KEY (pin_emp_numero_matricula, pin_data_inicio, 
  pin_ind_pericul_insalub, pin_data_nao_autorizacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for PERICUL_INSALUB_NAO_AUTORIZADA

COMMENT ON TABLE pericul_insalub_nao_autorizada IS 'Tabela que armazena os dados de pedidos de periculosidade ou insalubridade não autorizados.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_cod_resp_nao_autorizacao IS 'Código do usuário do banco de dados do empregado que não autorizou a periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_data_cancelamento IS 'Data de cancelamento da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_data_inicio IS 'Data de início da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_data_nao_autorizacao IS 'Data em que o pedido de periculosidade ou insalubridade não foi autorizado.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_data_termino IS 'Data de término da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_documento_cancelamento IS 'Documento de cancelamento da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_documento_inicio IS 'Documento de início da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_documento_termino IS 'Documento de término da periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_emp_numero_matricula IS 'Matrícula do empregado que teve o pedido de periculosidade ou insalubridade negado.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_ind_nao_autor_sede_sr IS 'Indica quem foi que não autorizou a periculosidade ou insalubridade requerida. (''S'' - SEDE; ''R'' - REGIONAL)'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_ind_pericul_insalub IS 'Indicador de periculosidade ou insalubridade. (''I'' - Insalubridade; ''P'' - Periculosidade)'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_motivo_nao_autorizacao IS 'Motivo da não autorização da periculosidade ou insalubridade pedida pelo empregado.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_observacao IS 'Observação referente a periculosidade ou insalubridade do empregado.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_percentual IS 'Percentual de periculosidade ou insalubridade.'
/
COMMENT ON COLUMN pericul_insalub_nao_autorizada.pin_resumo IS 'Resumo da periculosidade ou insalubridade do empregado.'
/

-- End of DDL Script for Table IFRSRH.PERICUL_INSALUB_NAO_AUTORIZADA

-- Start of DDL Script for Table IFRSRH.PESSOAL_SEM_VINCULO
-- Generated 9/3/2004 19:07:50 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pessoal_sem_vinculo
    (psv_sequencial                 NUMBER(10) NOT NULL,
    psv_nome_usuario               VARCHAR2(60) NOT NULL,
    psv_vip_cod_vinculo            NUMBER(2),
    psv_loa_codigo                 NUMBER(3),
    psv_nome_pai                   VARCHAR2(60),
    psv_nome_mae                   VARCHAR2(60),
    psv_data_nascimento            DATE,
    psv_estado_civil               VARCHAR2(1),
    psv_pla_cod_plano              NUMBER(3),
    psv_sexo                       VARCHAR2(1),
    psv_cre_sequencial             NUMBER(5),
    psv_tipo_pagamento             VARCHAR2(1),
    psv_numero_cpf                 NUMBER(11),
    psv_numero_identidade          VARCHAR2(15),
    psv_orgao_expedidor_ci         VARCHAR2(10),
    psv_data_expedicao             DATE,
    psv_ufe_sigla_ci               VARCHAR2(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PESSOAL_SEM_VINCULO

ALTER TABLE pessoal_sem_vinculo
ADD CONSTRAINT psv_pk PRIMARY KEY (psv_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PESSOAL_SEM_VINCULO

-- Start of DDL Script for Table IFRSRH.PESSOAS_VINCULADAS
-- Generated 9/3/2004 19:07:56 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pessoas_vinculadas
    (pvi_emp_numero_matricula       NUMBER(7) NOT NULL,
    pvi_sequencial                 NUMBER(2) NOT NULL,
    pvi_tpv_codigo                 NUMBER(2) NOT NULL,
    pvi_nome                       VARCHAR2(50) NOT NULL,
    pvi_data_nascimento            DATE NOT NULL,
    pvi_indicador_salario_familia  VARCHAR2(1) NOT NULL,
    pvi_indicador_imposto_de_renda VARCHAR2(1) NOT NULL,
    pvi_percentual_participacao_sc NUMBER(6,3),
    pvi_sexo                       VARCHAR2(1),
    pvi_cpf                        NUMBER(11),
    pvi_data_adesao_sf             DATE,
    pvi_data_adesao_ir             DATE,
    pvi_data_cartao_vacina         DATE,
    pvi_cidade_naturalidade        VARCHAR2(30),
    pvi_ufe_sigla_naturalidade     VARCHAR2(2),
    pvi_nome_cartorio              VARCHAR2(50),
    pvi_numero_livro               VARCHAR2(10),
    pvi_numero_folha               VARCHAR2(6),
    pvi_numero_registro            VARCHAR2(15),
    pvi_mun_codigo_naturalidade    NUMBER(5),
    pvi_percentual_seguro_grupo    NUMBER(5,2),
    pvi_data_inclusao              DATE,
    pvi_data_baixa_sf              DATE,
    pvi_data_baixa_ir              DATE,
    pvi_ramal_residencia           NUMBER(4),
    pvi_dat_exclusao               DATE,
    pvi_dsc_exclusao               VARCHAR2(500),
    pvi_dsc_doc_exclusao           VARCHAR2(50),
    pvi_pai_codigo                 NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PESSOAS_VINCULADAS

ALTER TABLE pessoas_vinculadas
ADD CONSTRAINT pvi_pk PRIMARY KEY (pvi_emp_numero_matricula, pvi_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for PESSOAS_VINCULADAS

CREATE TRIGGER srh_ans_pvi_alt
AFTER UPDATE 
ON pessoas_vinculadas
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
update  pessoas_vinculadas_benef
set     pvb_oper_ans = 2
where   pvb_pvi_emp_numero_matricula = :new.pvi_emp_numero_matricula
and     pvb_pvi_sequencial = :new.pvi_sequencial
and     emb_ben_sigla = 'MED'
and     data_exclusao is null;

if      sql%notfound
then    null;
end if;

End;
/

-- Comments for PESSOAS_VINCULADAS

COMMENT ON COLUMN pessoas_vinculadas.pvi_pai_codigo IS 'Referencia para identificar o dependente estrangeiro'
/

-- End of DDL Script for Table IFRSRH.PESSOAS_VINCULADAS

-- Start of DDL Script for Table IFRSRH.PESSOAS_VINCULADAS_BENEF
-- Generated 9/3/2004 19:08:06 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pessoas_vinculadas_benef
    (pvb_pvi_emp_numero_matricula   NUMBER(7) NOT NULL,
    pvb_pvi_sequencial             NUMBER(2) NOT NULL,
    emb_ben_sigla                  VARCHAR2(3) NOT NULL,
    pvb_adesao                     DATE NOT NULL,
    pvb_participacao               NUMBER(3),
    tva                            CHAR(1),
    data_exclusao                  DATE,
    pvb_usuario                    VARCHAR2(30),
    pvb_oper_ans                   NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PESSOAS_VINCULADAS_BENEF

CREATE INDEX pvb_emb_fk_i ON pessoas_vinculadas_benef
  (
    pvb_pvi_emp_numero_matricula    ASC,
    emb_ben_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for PESSOAS_VINCULADAS_BENEF

ALTER TABLE pessoas_vinculadas_benef
ADD CONSTRAINT pvb_pk PRIMARY KEY (pvb_pvi_emp_numero_matricula, 
  pvb_pvi_sequencial, emb_ben_sigla, pvb_adesao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for PESSOAS_VINCULADAS_BENEF

COMMENT ON COLUMN pessoas_vinculadas_benef.pvb_oper_ans IS 'Registro da operacao efetuada'
/

-- End of DDL Script for Table IFRSRH.PESSOAS_VINCULADAS_BENEF

-- Start of DDL Script for Table IFRSRH.PLANOS_MEDICOS
-- Generated 9/3/2004 19:08:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE planos_medicos
    (pla_cre_sequencial             NUMBER(5) NOT NULL,
    pla_cod_plano                  NUMBER(4) NOT NULL,
    pla_data_inicio                DATE NOT NULL,
    pla_descricao                  VARCHAR2(60),
    pla_valor_mensalidade          NUMBER(10,2),
    pla_reajuste                   NUMBER(6,2),
    pla_data_reajuste              DATE,
    pla_desconto                   NUMBER(3),
    "PLA_OBSERVAÇÃO"               VARCHAR2(200),
    pla_faixa_etaria_inicial       NUMBER(3),
    pla_faixa_etaria_final         NUMBER(3),
    pla_data_termino               DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PLANOS_MEDICOS

ALTER TABLE planos_medicos
ADD CONSTRAINT pla_pk PRIMARY KEY (pla_cre_sequencial, pla_cod_plano, 
  pla_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PLANOS_MEDICOS

-- Start of DDL Script for Table IFRSRH.PORTES_ANESTESICOS
-- Generated 9/3/2004 19:08:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE portes_anestesicos
    (porte                          NUMBER(3) NOT NULL,
    honorarios                     NUMBER(4) NOT NULL,
    honorarios_lpm                 NUMBER(15,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PORTES_ANESTESICOS

ALTER TABLE portes_anestesicos
ADD CONSTRAINT porte_pk PRIMARY KEY (porte)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PORTES_ANESTESICOS

-- Start of DDL Script for Table IFRSRH.POSICAO_EMPREGADO_PAGAMENTO
-- Generated 9/3/2004 19:08:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE posicao_empregado_pagamento
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    matricula                      NUMBER(9),
    cod_dependencia                NUMBER(4),
    cod_lotacao                    NUMBER(9),
    nivel                          NUMBER(4),
    padrao                         NUMBER(4),
    ind_medio_profissional         VARCHAR2(1),
    cod_afastamento                NUMBER(4),
    cod_funcao                     NUMBER(4),
    cod_cargo                      NUMBER(4),
    tipo_gratificacao              VARCHAR2(2),
    num_depend_sal_familia         NUMBER(4),
    num_depend_irrf                NUMBER(4),
    num_anuenios                   NUMBER(4),
    cod_categoria                  NUMBER(4),
    flag_selecionado               NUMBER(4),
    flag_status                    VARCHAR2(1),
    data_pagto_rescisao            DATE,
    flag_fgts_retido               VARCHAR2(1),
    cod_contratacao                NUMBER(4),
    cod_situacao_funcional         NUMBER(4),
    cod_dependencia_lotacao        NUMBER(4),
    cod_centro_custos              NUMBER(9),
    cod_nivel_enquadramento        NUMBER(4),
    cod_ocupacao_atuacao           NUMBER(4),
    categoria_pccs                 VARCHAR2(1),
    padrao_pccs                    NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for POSICAO_EMPREGADO_PAGAMENTO

CREATE INDEX pep ON posicao_empregado_pagamento
  (
    matricula                       ASC,
    ano                             ASC,
    mes                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.POSICAO_EMPREGADO_PAGAMENTO

-- Start of DDL Script for Table IFRSRH.POSTO_GRADUACAO
-- Generated 9/3/2004 19:08:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE posto_graduacao
    (pgr_codigo                     NUMBER(2) NOT NULL,
    pgr_descricao                  VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for POSTO_GRADUACAO

ALTER TABLE posto_graduacao
ADD CONSTRAINT pgr_codigo_pk PRIMARY KEY (pgr_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for POSTO_GRADUACAO

COMMENT ON COLUMN posto_graduacao.pgr_codigo IS 'Código identificador do posto/graduaçao do empregado militar'
/
COMMENT ON COLUMN posto_graduacao.pgr_descricao IS 'Descrição/nome do posto/graduação do empregado militar'
/

-- End of DDL Script for Table IFRSRH.POSTO_GRADUACAO

-- Start of DDL Script for Table IFRSRH.PRE_REQUISITO_FUNCAO
-- Generated 9/3/2004 19:08:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pre_requisito_funcao
    (prf_fun_codigo                 NUMBER(3) NOT NULL,
    prf_prr_codigo                 NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PRE_REQUISITO_FUNCAO

ALTER TABLE pre_requisito_funcao
ADD CONSTRAINT prf_pk PRIMARY KEY (prf_fun_codigo, prf_prr_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for PRE_REQUISITO_FUNCAO

COMMENT ON COLUMN pre_requisito_funcao.prf_fun_codigo IS 'Código do pré-requisito para a função'
/

-- End of DDL Script for Table IFRSRH.PRE_REQUISITO_FUNCAO

-- Start of DDL Script for Table IFRSRH.PRE_REQUISITOS
-- Generated 9/3/2004 19:08:56 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE pre_requisitos
    (prr_codigo                     NUMBER(2) NOT NULL,
    prr_descricao                  VARCHAR2(600) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PRE_REQUISITOS

ALTER TABLE pre_requisitos
ADD CONSTRAINT prr_pk PRIMARY KEY (prr_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for PRE_REQUISITOS

COMMENT ON COLUMN pre_requisitos.prr_codigo IS 'Código do Pré-requisito'
/
COMMENT ON COLUMN pre_requisitos.prr_descricao IS 'Descrição do pré_requisito'
/

-- End of DDL Script for Table IFRSRH.PRE_REQUISITOS

-- Start of DDL Script for Table IFRSRH.PREMIO_SEGURO
-- Generated 9/3/2004 19:09:01 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE premio_seguro
    (prs_mes                        NUMBER(2) NOT NULL,
    prs_ano                        NUMBER(4) NOT NULL,
    prs_emp_numero_matricula       NUMBER(7) NOT NULL,
    prs_apolice                    VARCHAR2(1) NOT NULL,
    prs_centro_custos              NUMBER(6),
    prs_valor_cota_parte_empresa   NUMBER(8,2),
    prs_situacao_funcional         NUMBER(1),
    prs_tipo_registro              NUMBER(1),
    prs_emp_dep_codigo_lotacao     NUMBER(4),
    prs_capital_vg                 NUMBER(8,2),
    prs_salario                    NUMBER(8,2),
    prs_premio_ind_basica          NUMBER(8,2),
    prs_premio_ind_complementar    NUMBER(8,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PREMIO_SEGURO

ALTER TABLE premio_seguro
ADD CONSTRAINT prs_pk PRIMARY KEY (prs_ano, prs_mes, prs_emp_numero_matricula, 
  prs_apolice)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PREMIO_SEGURO

-- Start of DDL Script for Table IFRSRH.PREVISAO_PAGAMENTO
-- Generated 9/3/2004 19:09:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE previsao_pagamento
    (ppa_ano_pagamento              NUMBER(4) NOT NULL,
    ppa_mes_pagamento              NUMBER(2) NOT NULL,
    ppa_data_prevista              DATE NOT NULL,
    ppa_data_pagamento             DATE,
    ppa_dias_uteis                 NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PREVISAO_PAGAMENTO

ALTER TABLE previsao_pagamento
ADD CONSTRAINT ppa_pk PRIMARY KEY (ppa_ano_pagamento, ppa_mes_pagamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PREVISAO_PAGAMENTO

-- Start of DDL Script for Table IFRSRH.PROCEDIMENTOS_ODONTOLOGICOS
-- Generated 9/3/2004 19:09:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE procedimentos_odontologicos
    (pod_ato_numero                 NUMBER(14) NOT NULL,
    pod_abo_codigo                 NUMBER(4) NOT NULL,
    pod_qtd_dentes                 NUMBER(2),
    pod_cancelado                  VARCHAR2(1) NOT NULL,
    pod_total_real                 NUMBER(12,2),
    pod_perito                     VARCHAR2(1),
    pod_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PROCEDIMENTOS_ODONTOLOGICOS

ALTER TABLE procedimentos_odontologicos
ADD CONSTRAINT pod_pk PRIMARY KEY (pod_ato_numero, pod_abo_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PROCEDIMENTOS_ODONTOLOGICOS

-- Start of DDL Script for Table IFRSRH.PROGRAMACOES_FERIAS
-- Generated 9/3/2004 19:09:24 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE programacoes_ferias
    (pfe_emp_numero_matricula       NUMBER(7) NOT NULL,
    pfe_sequencial                 NUMBER(2) NOT NULL,
    pfe_data_inicio_1              DATE NOT NULL,
    pfe_data_termino_1             DATE NOT NULL,
    pfe_indicador_13_salario_1     VARCHAR2(1) NOT NULL,
    pfe_in_adiantamento_ferias_1   VARCHAR2(1) NOT NULL,
    pfe_in_abono_pecuniario_1      VARCHAR2(1) NOT NULL,
    pfe_indicador_13_salario_2     VARCHAR2(1) NOT NULL,
    pfe_in_adiantamento_ferias_2   VARCHAR2(1) NOT NULL,
    pfe_in_abono_pecuniario_2      VARCHAR2(1) NOT NULL,
    pfe_dt_inicio_periodo_aquis    DATE NOT NULL,
    pfe_dt_termino_periodo_aquis   DATE NOT NULL,
    pfe_numero_prazo_desconto_1    NUMBER(2),
    pfe_numero_prazo_desconto_2    NUMBER(2),
    pfe_data_inicio_2              DATE,
    pfe_data_termino_2             DATE,
    pfe_numero_dias_gozo_1         NUMBER(2),
    pfe_numero_dias_gozo_2         NUMBER(2),
    pfe_documento_1                VARCHAR2(200),
    pfe_documento_2                VARCHAR2(200),
    pfe_data_ini_abono_pecuniario  DATE,
    pfe_data_fim_abono_pecuniario  DATE,
    pfe_mov_ano_ref_inicio_1       NUMBER(4),
    pfe_mov_mes_ref_inicio_1       NUMBER(2),
    pfe_mov_ano_ref_inicio_2       NUMBER(4),
    pfe_mov_mes_ref_inicio_2       NUMBER(2),
    pfe_mov_oem_data_inicio_1      DATE,
    pfe_mov_oem_data_inicio_2      DATE,
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PROGRAMACOES_FERIAS

ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_1_ck CHECK ( PFE_INDICADOR_13_SALARIO_1 IN ('S','N')                                          )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_2_ck CHECK ( PFE_INDICADOR_13_SALARIO_2 IN ('S','N')                                          )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_1_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_1 IN ('S','N')                                           )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_2_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_2 IN ('S','N')                                           )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_1_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_1 IN ('S','N')                                        )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_2_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_2 IN ('S','N')                                        )
/
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_pk PRIMARY KEY (pfe_emp_numero_matricula, pfe_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for PROGRAMACOES_FERIAS

CREATE TRIGGER trg_log_programacoes_ferias
BEFORE UPDATE  OR  DELETE 
ON programacoes_ferias
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  v_operacao         VARCHAR2(1);
BEGIN
  --
  -- Pego o tipo de operação
  IF UPDATING THEN
    v_operacao := 'U';
  ELSIF DELETING THEN
    v_operacao := 'D';
  END IF;
  --
  INSERT INTO LOG_PROGRAMACOES_FERIAS
             (
                PFE_EMP_NUMERO_MATRICULA,
                PFE_SEQUENCIAL,
                PFE_DATA_INICIO_1,
                PFE_DATA_TERMINO_1,
                PFE_INDICADOR_13_SALARIO_1,
                PFE_IN_ADIANTAMENTO_FERIAS_1,
                PFE_IN_ABONO_PECUNIARIO_1,
                PFE_INDICADOR_13_SALARIO_2,
                PFE_IN_ADIANTAMENTO_FERIAS_2,
                PFE_IN_ABONO_PECUNIARIO_2,
                PFE_DT_INICIO_PERIODO_AQUIS,
                PFE_DT_TERMINO_PERIODO_AQUIS,
                PFE_NUMERO_PRAZO_DESCONTO_1,
                PFE_NUMERO_PRAZO_DESCONTO_2,
                PFE_DATA_INICIO_2,
                PFE_DATA_TERMINO_2,
                PFE_NUMERO_DIAS_GOZO_1,
                PFE_NUMERO_DIAS_GOZO_2,
                PFE_DOCUMENTO_1,
                PFE_DOCUMENTO_2,
                PFE_DATA_INI_ABONO_PECUNIARIO,
                PFE_DATA_FIM_ABONO_PECUNIARIO,
                PFE_MOV_ANO_REF_INICIO_1,
                PFE_MOV_MES_REF_INICIO_1,
                PFE_MOV_ANO_REF_INICIO_2,
                PFE_MOV_MES_REF_INICIO_2,
                PFE_MOV_OEM_DATA_INICIO_1,
                PFE_MOV_OEM_DATA_INICIO_2,
                DAT_OPERACAO,
                TIP_OPERACAO,
                COD_USUARIO
             )
             VALUES
             (
                :OLD.PFE_EMP_NUMERO_MATRICULA,
                :OLD.PFE_SEQUENCIAL,
                :OLD.PFE_DATA_INICIO_1,
                :OLD.PFE_DATA_TERMINO_1,
                :OLD.PFE_INDICADOR_13_SALARIO_1,
                :OLD.PFE_IN_ADIANTAMENTO_FERIAS_1,
                :OLD.PFE_IN_ABONO_PECUNIARIO_1,
                :OLD.PFE_INDICADOR_13_SALARIO_2,
                :OLD.PFE_IN_ADIANTAMENTO_FERIAS_2,
                :OLD.PFE_IN_ABONO_PECUNIARIO_2,
                :OLD.PFE_DT_INICIO_PERIODO_AQUIS,
                :OLD.PFE_DT_TERMINO_PERIODO_AQUIS,
                :OLD.PFE_NUMERO_PRAZO_DESCONTO_1,
                :OLD.PFE_NUMERO_PRAZO_DESCONTO_2,
                :OLD.PFE_DATA_INICIO_2,
                :OLD.PFE_DATA_TERMINO_2,
                :OLD.PFE_NUMERO_DIAS_GOZO_1,
                :OLD.PFE_NUMERO_DIAS_GOZO_2,
                :OLD.PFE_DOCUMENTO_1,
                :OLD.PFE_DOCUMENTO_2,
                :OLD.PFE_DATA_INI_ABONO_PECUNIARIO,
                :OLD.PFE_DATA_FIM_ABONO_PECUNIARIO,
                :OLD.PFE_MOV_ANO_REF_INICIO_1,
                :OLD.PFE_MOV_MES_REF_INICIO_1,
                :OLD.PFE_MOV_ANO_REF_INICIO_2,
                :OLD.PFE_MOV_MES_REF_INICIO_2,
                :OLD.PFE_MOV_OEM_DATA_INICIO_1,
                :OLD.PFE_MOV_OEM_DATA_INICIO_2,
                SYSDATE,--:OLD.EMP_DTA_OPERACAO,
                v_operacao,--:OLD.EMP_TIP_OPERACAO,
                USER--:OLD.EMP_COD_USUARIO
             );
--
END; --End TRIGGER TRG_LOG_PROGRAMACOES_FERIAS
/
CREATE TRIGGER trg_aud_programacoes_ferias
BEFORE INSERT 
ON programacoes_ferias
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
BEGIN
  --
  :NEW.cod_usuario  := USER;
  :NEW.dta_operacao := SYSDATE;
  --
END; --End TRIGGER TRG_AUD_PROGRAMACOES_FERIAS
/

-- Comments for PROGRAMACOES_FERIAS

COMMENT ON COLUMN programacoes_ferias.cod_usuario IS 'Matrícula do Usuário que carregou o registro'
/
COMMENT ON COLUMN programacoes_ferias.dta_operacao IS 'Data em que foi carregado o registro'
/
COMMENT ON COLUMN programacoes_ferias.pfe_mov_oem_data_inicio_1 IS 'Data de inicio das férias que consta na folha de pagamento Periodo 1'
/
COMMENT ON COLUMN programacoes_ferias.pfe_mov_oem_data_inicio_2 IS 'Data de inicio das férias que consta na folha de pagamento Periodo 2'
/

-- End of DDL Script for Table IFRSRH.PROGRAMACOES_FERIAS

-- Start of DDL Script for Table IFRSRH.PROJECAO_MOVIMENTO_PAGAMENTO
-- Generated 9/3/2004 19:09:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE projecao_movimento_pagamento
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    matricula                      NUMBER(9),
    cod_prov_desc                  NUMBER(4),
    tipo_movimento                 VARCHAR2(1),
    prazo                          NUMBER(4),
    frequencia                     NUMBER(15,6),
    valor                          NUMBER(20,2),
    cod_dependencia                NUMBER(4),
    ano_lancamento                 NUMBER(4),
    mes_lancamento                 NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for PROJECAO_MOVIMENTO_PAGAMENTO

CREATE INDEX pmp ON projecao_movimento_pagamento
  (
    ano                             ASC,
    mes                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.PROJECAO_MOVIMENTO_PAGAMENTO

-- Start of DDL Script for Table IFRSRH.PROVISIONAMENTO
-- Generated 9/3/2004 19:09:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE provisionamento
    (ano                            NUMBER(4) NOT NULL,
    mes                            NUMBER(2) NOT NULL,
    seq                            NUMBER(2) NOT NULL,
    dep_codigo                     NUMBER(4) NOT NULL,
    custo                          NUMBER(6) NOT NULL,
    conta                          VARCHAR2(9) NOT NULL,
    matricula                      NUMBER(7) NOT NULL,
    tipo_prov                      NUMBER(1) NOT NULL,
    dt_inicio_pa                   DATE,
    dt_inicio_ferias               DATE,
    dt_termino_ferias              DATE,
    meses_pa                       NUMBER(2),
    meses_baixa                    NUMBER(2),
    meses_provisao                 NUMBER(2),
    remuneracao_atual              NUMBER(14,2),
    remuneracao_anterior           NUMBER(14,2),
    provisao_atual                 NUMBER(14,2),
    provisao_anterior              NUMBER(14,2),
    encargos_atual                 NUMBER(14,2),
    encargos_anterior              NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PROVISIONAMENTO

ALTER TABLE provisionamento
ADD CONSTRAINT provisionamento_pk PRIMARY KEY (ano, mes, seq, dep_codigo, custo, 
  conta, matricula, tipo_prov)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.PROVISIONAMENTO

-- Start of DDL Script for Table IFRSRH.PROVISOES_EMPREGADOS
-- Generated 9/3/2004 19:09:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE provisoes_empregados
    (ano_referencia                 NUMBER(4) NOT NULL,
    mes_referencia                 NUMBER(2) NOT NULL,
    num_versao                     NUMBER(2) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    tipo_provisao                  NUMBER(1) NOT NULL,
    val_provisao                   NUMBER(11,2) NOT NULL,
    val_encargos_infraprev         NUMBER(11,2),
    val_encargos_fgts              NUMBER(11,2),
    val_encargos_sal_educ          NUMBER(11,2),
    val_encargos_seg_ac_trab       NUMBER(11,2),
    val_encargos_inss              NUMBER(11,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for PROVISOES_EMPREGADOS

ALTER TABLE provisoes_empregados
ADD CONSTRAINT provisoes_empregados_pk PRIMARY KEY (ano_referencia, 
  mes_referencia, num_versao, emp_numero_matricula, tipo_provisao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE provisoes_empregados
ADD CONSTRAINT prov_empreg_chk_tp_provisao CHECK ( TIPO_PROVISAO IN (1,2)                                                           )
/

-- End of DDL Script for Table IFRSRH.PROVISOES_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.QCD_AREA_ATUACAO
-- Generated 9/3/2004 19:09:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE qcd_area_atuacao
    (qda_atu_codigo                 NUMBER(3) NOT NULL,
    qda_qcd_hcd_dep_codigo         NUMBER(4) NOT NULL,
    qda_qcd_hcd_data_vigencia      DATE NOT NULL,
    qda_qcd_car_codigo             NUMBER(3) NOT NULL,
    qda_qcd_car_codigo_nivel       NUMBER(1) NOT NULL,
    qda_qcd_car_occ_codigo         NUMBER(3) NOT NULL,
    qda_quantidade_aprovada        NUMBER(5) NOT NULL,
    qda_quantidade_ideal_aprovada  NUMBER(5) NOT NULL,
    qda_quantidade_existente       NUMBER(5),
    qda_disponibilidade            NUMBER(5),
    qda_data_vigencia              DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QCD_AREA_ATUACAO

ALTER TABLE qcd_area_atuacao
ADD CONSTRAINT qda_pk PRIMARY KEY (qda_atu_codigo, qda_qcd_hcd_dep_codigo, 
  qda_qcd_hcd_data_vigencia, qda_qcd_car_codigo, qda_qcd_car_codigo_nivel, 
  qda_qcd_car_occ_codigo, qda_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QCD_AREA_ATUACAO

-- Start of DDL Script for Table IFRSRH.QLP_AREA_ATUACAO
-- Generated 9/3/2004 19:10:04 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE qlp_area_atuacao
    (qla_atu_codigo                 NUMBER(3) NOT NULL,
    qla_qlp_icl_uor_codigo         NUMBER(9) NOT NULL,
    qla_qlp_icl_data_vigencia      DATE NOT NULL,
    qla_qlp_car_codigo             NUMBER(3) NOT NULL,
    qla_qlp_car_codigo_nivel       NUMBER(1) NOT NULL,
    qla_qlp_car_occ_codigo         NUMBER(3) NOT NULL,
    qla_quantidade_aprovada        NUMBER(5) NOT NULL,
    qla_quantidade_ideal_aprovada  NUMBER(5) NOT NULL,
    qla_data_vigencia              DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QLP_AREA_ATUACAO

ALTER TABLE qlp_area_atuacao
ADD CONSTRAINT qla_pk PRIMARY KEY (qla_atu_codigo, qla_qlp_icl_uor_codigo, 
  qla_qlp_icl_data_vigencia, qla_qlp_car_codigo, qla_qlp_car_codigo_nivel, 
  qla_qlp_car_occ_codigo, qla_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QLP_AREA_ATUACAO

-- Start of DDL Script for Table IFRSRH.QLP_TEMP
-- Generated 9/3/2004 19:10:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE qlp_temp
    (qlp_uor_codigo                 NUMBER(9) NOT NULL,
    qlp_car_codigo                 NUMBER(3) NOT NULL,
    qlp_car_codigo_nivel           NUMBER(1) NOT NULL,
    qlp_car_occ_codigo             NUMBER(3) NOT NULL,
    qlp_data_vigencia              DATE NOT NULL,
    qlp_quantidade_vagas_previstas NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QLP_TEMP

-- Start of DDL Script for Table IFRSRH.QUADRO_ARMA_ESPEC
-- Generated 9/3/2004 19:10:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadro_arma_espec
    (qae_codigo                     NUMBER(2) NOT NULL,
    qae_descricao                  VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QUADRO_ARMA_ESPEC

ALTER TABLE quadro_arma_espec
ADD CONSTRAINT qae_codigo_pk PRIMARY KEY (qae_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for QUADRO_ARMA_ESPEC

COMMENT ON COLUMN quadro_arma_espec.qae_codigo IS 'Cod. identific. quadro/arma/especialidade do empregado militar'
/
COMMENT ON COLUMN quadro_arma_espec.qae_descricao IS 'Descrição/nome do quadro/arma/especialidade do empregado militar'
/

-- End of DDL Script for Table IFRSRH.QUADRO_ARMA_ESPEC

-- Start of DDL Script for Table IFRSRH.QUADRO_CARGOS_DEPENDENCIAS
-- Generated 9/3/2004 19:10:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadro_cargos_dependencias
    (qcd_hcd_dep_codigo             NUMBER(4) NOT NULL,
    qcd_hcd_data_vigencia          DATE NOT NULL,
    qcd_car_codigo                 NUMBER(3) NOT NULL,
    qcd_car_codigo_nivel           NUMBER(1) NOT NULL,
    qcd_car_occ_codigo             NUMBER(3) NOT NULL,
    qcd_quantidade_aprovada        NUMBER(5) NOT NULL,
    qcd_quantidade_ideal_aprovada  NUMBER(5) NOT NULL,
    qcd_quantidade_existente       NUMBER(5),
    qcd_disponibilidade            NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QUADRO_CARGOS_DEPENDENCIAS

ALTER TABLE quadro_cargos_dependencias
ADD CONSTRAINT qcd_pk PRIMARY KEY (qcd_hcd_dep_codigo, qcd_hcd_data_vigencia, 
  qcd_car_codigo, qcd_car_codigo_nivel, qcd_car_occ_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QUADRO_CARGOS_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.QUADRO_FUNCOES
-- Generated 9/3/2004 19:10:29 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadro_funcoes
    (qfu_fun_codigo                 NUMBER(3) NOT NULL,
    qfu_hfl_uor_codigo             NUMBER(9) NOT NULL,
    qfu_hfl_data_vigencia          DATE NOT NULL,
    qfu_exclusivo_qcr              VARCHAR2(1) DEFAULT ('N')
,
    qfu_aprovado_geral             NUMBER(5) NOT NULL,
    qfu_contrato_especial_aprovado NUMBER(5) NOT NULL,
    qfu_cargo_funcao_aprovado      NUMBER(5) NOT NULL,
    qfu_sem_contrato_aprovado      NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QUADRO_FUNCOES

ALTER TABLE quadro_funcoes
ADD CONSTRAINT qfu_pk PRIMARY KEY (qfu_fun_codigo, qfu_hfl_uor_codigo, 
  qfu_hfl_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QUADRO_FUNCOES

-- Start of DDL Script for Table IFRSRH.QUADROS_FUNCOES_DEPENDENCIAS
-- Generated 9/3/2004 19:10:38 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadros_funcoes_dependencias
    (qfd_hfd_dep_codigo             NUMBER(4) NOT NULL,
    qfd_hfd_data_vigencia          DATE NOT NULL,
    qfd_fun_codigo                 NUMBER(3) NOT NULL,
    qfd_aprovado_geral             NUMBER(5) NOT NULL,
    qfd_contrato_especial_aprovado NUMBER(5) NOT NULL,
    qfd_cargo_funcao_aprovado      NUMBER(5) NOT NULL,
    qfd_sem_contrato_aprovado      NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QUADROS_FUNCOES_DEPENDENCIAS

ALTER TABLE quadros_funcoes_dependencias
ADD CONSTRAINT qfd_pk PRIMARY KEY (qfd_hfd_dep_codigo, qfd_hfd_data_vigencia, 
  qfd_fun_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QUADROS_FUNCOES_DEPENDENCIAS

-- Start of DDL Script for Table IFRSRH.QUADROS_LOTACAO
-- Generated 9/3/2004 19:10:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadros_lotacao
    (qlp_uor_codigo                 NUMBER(9) NOT NULL,
    qlp_car_codigo                 NUMBER(3) NOT NULL,
    qlp_car_codigo_nivel           NUMBER(1) NOT NULL,
    qlp_car_occ_codigo             NUMBER(3) NOT NULL,
    qlp_data_vigencia              DATE NOT NULL,
    qlp_quantidade_vagas_previstas NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QUADROS_LOTACAO

-- Start of DDL Script for Table IFRSRH.QUADROS_LOTACAO_PESSOAL
-- Generated 9/3/2004 19:10:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE quadros_lotacao_pessoal
    (qlp_icl_uor_codigo             NUMBER(9) NOT NULL,
    qlp_icl_data_vigencia          DATE NOT NULL,
    qlp_car_codigo                 NUMBER(3) NOT NULL,
    qlp_car_codigo_nivel           NUMBER(1) NOT NULL,
    qlp_car_occ_codigo             NUMBER(3) NOT NULL,
    qlp_quantidade_aprovada        NUMBER(5) NOT NULL,
    qlp_quantidade_ideal_aprovada  NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for QUADROS_LOTACAO_PESSOAL

ALTER TABLE quadros_lotacao_pessoal
ADD CONSTRAINT qlp_pk PRIMARY KEY (qlp_icl_uor_codigo, qlp_icl_data_vigencia, 
  qlp_car_codigo, qlp_car_codigo_nivel, qlp_car_occ_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.QUADROS_LOTACAO_PESSOAL

-- Start of DDL Script for Table IFRSRH.REAJUSTE_PERCENTUAL_13_FERIAS
-- Generated 9/3/2004 19:10:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reajuste_percentual_13_ferias
    (rdf_ano_referencia             NUMBER(4) NOT NULL,
    rdf_mes_referencia             NUMBER(2) NOT NULL,
    rdf_gru_codigo                 NUMBER(2) NOT NULL,
    rdf_perc_reajuste              NUMBER(5,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for REAJUSTE_PERCENTUAL_13_FERIAS

ALTER TABLE reajuste_percentual_13_ferias
ADD CONSTRAINT rdf_pk PRIMARY KEY (rdf_ano_referencia, rdf_mes_referencia, 
  rdf_gru_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for REAJUSTE_PERCENTUAL_13_FERIAS

COMMENT ON COLUMN reajuste_percentual_13_ferias.rdf_ano_referencia IS 'Ano de referência do reajuste'
/
COMMENT ON COLUMN reajuste_percentual_13_ferias.rdf_gru_codigo IS 'Código do Grupo que receberá reajuste'
/
COMMENT ON COLUMN reajuste_percentual_13_ferias.rdf_mes_referencia IS 'Mês de referência do reajuste'
/
COMMENT ON COLUMN reajuste_percentual_13_ferias.rdf_perc_reajuste IS 'Percentual de reajuste'
/

-- End of DDL Script for Table IFRSRH.REAJUSTE_PERCENTUAL_13_FERIAS

-- Start of DDL Script for Table IFRSRH.REEMBOLSOS
-- Generated 9/3/2004 19:11:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reembolsos
    (ree_sequencial                 NUMBER(7) NOT NULL,
    ree_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    ree_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    ree_mes                        NUMBER(2) NOT NULL,
    ree_ano                        NUMBER(4) NOT NULL,
    ree_data                       DATE NOT NULL,
    ree_valor_informado            NUMBER(12,2) NOT NULL,
    ree_valor_deducao              NUMBER(12,2),
    ree_valor_autorizado           NUMBER(12,2),
    ree_emp_dep_codigo_lotacao     NUMBER(4) NOT NULL,
    ree_emp_ati_ct_custos          NUMBER(10) NOT NULL,
    ree_pvb_pvi_sequencial         NUMBER(2),
    ree_pvb_adesao                 DATE,
    ree_valor_participacao         NUMBER(12,2),
    ree_valor_liquido              NUMBER(12,2),
    ree_observacao                 VARCHAR2(2000),
    ree_ano_pagamento              NUMBER(4) NOT NULL,
    ree_mes_pagamento              NUMBER(2) NOT NULL,
    ree_autorizacao                VARCHAR2(1),
    ree_tipo                       VARCHAR2(1) NOT NULL,
    ree_numero_recibo              NUMBER(7),
    ree_dep_resp_incl              NUMBER(4) NOT NULL,
    ree_emp_dep_codigo_fisico      NUMBER(4) NOT NULL,
    doc_data_geracao_participacao  DATE,
    ree_valor_reembolso            NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REEMBOLSOS

CREATE INDEX idx_ree_emb_fk ON reembolsos
  (
    ree_emb_emp_numero_matricula    ASC,
    ree_emb_ben_sigla               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_ree_dpf_fk ON reembolsos
  (
    ree_emp_dep_codigo_fisico       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX idx_ree_pvb_fk ON reembolsos
  (
    ree_emb_emp_numero_matricula    ASC,
    ree_pvb_pvi_sequencial          ASC,
    ree_emb_ben_sigla               ASC,
    ree_pvb_adesao                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for REEMBOLSOS

ALTER TABLE reembolsos
ADD CONSTRAINT ree_pk PRIMARY KEY (ree_sequencial, ree_emb_emp_numero_matricula, 
  ree_mes, ree_ano, ree_tipo, ree_emb_ben_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for REEMBOLSOS

COMMENT ON COLUMN reembolsos.ree_valor_reembolso IS 'Valor do reembolso a pagar'
/

-- End of DDL Script for Table IFRSRH.REEMBOLSOS

-- Start of DDL Script for Table IFRSRH.REEMBOLSOS_AUXILIOS_CRECHES
-- Generated 9/3/2004 19:11:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reembolsos_auxilios_creches
    (rac_sequencial                 NUMBER(4) NOT NULL,
    rac_ano_incial                 NUMBER(2) NOT NULL,
    rac_mes_inicial                NUMBER(2) NOT NULL,
    rac_dia_inicial                NUMBER(3) NOT NULL,
    rac_ano_final                  NUMBER(2) NOT NULL,
    rac_mes_final                  NUMBER(2) NOT NULL,
    rac_dia_final                  NUMBER(3) NOT NULL,
    rac_valor                      NUMBER(7,2) NOT NULL,
    rac_diferenca                  NUMBER(12,2),
    rac_participacao               VARCHAR2(1) NOT NULL,
    data_inicio                    DATE NOT NULL,
    data_fim                       DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for REEMBOLSOS_AUXILIOS_CRECHES

ALTER TABLE reembolsos_auxilios_creches
ADD CONSTRAINT rac_pk PRIMARY KEY (rac_sequencial, data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.REEMBOLSOS_AUXILIOS_CRECHES

-- Start of DDL Script for Table IFRSRH.REFER_AUXILIO_ALIMENTACAO
-- Generated 9/3/2004 19:11:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE refer_auxilio_alimentacao
    (raa_falta                      NUMBER(2) NOT NULL,
    raa_quantidade                 NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for REFER_AUXILIO_ALIMENTACAO

ALTER TABLE refer_auxilio_alimentacao
ADD CONSTRAINT raa_pk PRIMARY KEY (raa_falta, raa_quantidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.REFER_AUXILIO_ALIMENTACAO

-- Start of DDL Script for Table IFRSRH.REG_ERRO_MIGRACAO_FOLHA_RDB
-- Generated 9/3/2004 19:11:38 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_erro_migracao_folha_rdb
    (rem_ano_referencia             NUMBER(4) NOT NULL,
    rem_mes_referencia             NUMBER(2) NOT NULL,
    rem_versao_pagamento           NUMBER(2) NOT NULL,
    rem_emp_numero_matricula       NUMBER(7),
    rem_rub_codigo                 NUMBER(4),
    rem_mensagem                   VARCHAR2(300) NOT NULL,
    rem_tipo_auditoria             NUMBER(2) NOT NULL,
    rem_data_erro                  DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_ERRO_MIGRACAO_FOLHA_RDB

CREATE INDEX reg_erro_migracao_folha_rdb_ix ON reg_erro_migracao_folha_rdb
  (
    rem_ano_referencia              ASC,
    rem_mes_referencia              ASC,
    rem_versao_pagamento            ASC,
    rem_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_ERRO_MIGRACAO_FOLHA_RDB

-- Start of DDL Script for Table IFRSRH.REG_PAGAMENTO_CALCULADO_2110
-- Generated 9/3/2004 19:11:45 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_pagamento_calculado_2110
    (arq_ano                        NUMBER(4),
    arq_mes                        NUMBER(4),
    arq_mat                        NUMBER(9),
    arq_cod_prov_desc              NUMBER(4),
    arq_prazo                      NUMBER(4),
    arq_frequencia                 NUMBER(9,6),
    arq_valor                      NUMBER(18,2),
    arq_rubrica                    VARCHAR2(1),
    arq_cod_dep                    NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_PAGAMENTO_CALCULADO_2110

CREATE INDEX reg_pag_calculado_2110_ix ON reg_pagamento_calculado_2110
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_PAGAMENTO_CALCULADO_2110

-- Start of DDL Script for Table IFRSRH.REG_PAGAMENTO_CALCULADO_FINAL
-- Generated 9/3/2004 19:11:53 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_pagamento_calculado_final
    (arq_ano                        NUMBER(4),
    arq_mes                        NUMBER(4),
    arq_mat                        NUMBER(9),
    arq_tipo_pagamento             VARCHAR2(1),
    arq_cod_prov_desc              NUMBER(4),
    arq_prazo                      NUMBER(4),
    arq_frequencia                 NUMBER(9,6),
    arq_valor                      NUMBER(18,2),
    arq_rubrica                    VARCHAR2(1),
    arq_cod_dep                    NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_PAGAMENTO_CALCULADO_FINAL

CREATE INDEX reg_pagto_calculado_final_ix ON reg_pagamento_calculado_final
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_PAGAMENTO_CALCULADO_FINAL

-- Start of DDL Script for Table IFRSRH.REG_POSICAO_EMP_PAGAMENTO
-- Generated 9/3/2004 19:12:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_posicao_emp_pagamento
    (arq_ano                        NUMBER(4),
    arq_mes                        NUMBER(4),
    arq_matricula                  NUMBER(9),
    arq_cod_dependencia            NUMBER(4),
    arq_cod_lotacao                NUMBER(9),
    arq_nivel                      NUMBER(4),
    arq_padrao                     NUMBER(4),
    arq_ind_medio_profissional     VARCHAR2(1),
    arq_cod_afastamento            NUMBER(4),
    arq_cod_funcao                 NUMBER(4),
    arq_cod_cargo                  NUMBER(4),
    arq_tipo_gratificacao          VARCHAR2(2),
    arq_num_depend_sal_familia     NUMBER(4),
    arq_num_depend_irrf            NUMBER(4),
    arq_num_anuenios               NUMBER(4),
    arq_cod_categoria              NUMBER(4),
    arq_flag_selecionado           NUMBER(4),
    arq_flag_status                VARCHAR2(1),
    arq_data_pagto_rescisao        NUMBER(6),
    arq_flag_fgts_retido           VARCHAR2(1),
    arq_cod_contratacao            NUMBER(4),
    arq_cod_situacao_funcional     NUMBER(4),
    arq_cod_dependencia_lotacao    NUMBER(4),
    arq_cod_centro_custos          NUMBER(9),
    arq_cod_nivel_enquadramento    NUMBER(4),
    arq_cod_ocupacao_atuacao       NUMBER(4),
    arq_categoria_pccs             VARCHAR2(1),
    arq_padrao_pccs                NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_POSICAO_EMP_PAGAMENTO

CREATE INDEX reg_posicao_emp_pagamento_ix ON reg_posicao_emp_pagamento
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_matricula                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_POSICAO_EMP_PAGAMENTO

-- Start of DDL Script for Table IFRSRH.REG_REMUNERACAO_2110
-- Generated 9/3/2004 19:12:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_remuneracao_2110
    (arq_ano                        NUMBER(4),
    arq_mes                        NUMBER(4),
    arq_mat                        NUMBER(9),
    arq_adiant_13_ate_mes          NUMBER(18,2),
    arq_base_cal_inps              NUMBER(18,2),
    arq_taxa_inps                  NUMBER(9,4),
    arq_r_inps_mes                 NUMBER(18,2),
    arq_base_cal_irrf              NUMBER(18,2),
    arq_r_aliquota_irrf_mes        NUMBER(9,2),
    arq_r_irrf_mes                 NUMBER(18,2),
    arq_base_cal_fgts_mes          NUMBER(18,2),
    arq_taxa_fgts                  NUMBER(9,2),
    arq_r_fgts_mes                 NUMBER(18,2),
    arq_taxa_sindical              NUMBER(9,2),
    arq_r_sindical_mes             NUMBER(18,2),
    arq_r_variavel_mes             NUMBER(18,2),
    arq_val_adiant_ferias          NUMBER(18,2),
    arq_proventos_mes              NUMBER(18,2),
    arq_proventos_ate_mes          NUMBER(18,2),
    arq_descontos_mes              NUMBER(18,2),
    arq_inps_13_sal                NUMBER(18,2),
    arq_cod_dep                    NUMBER(4),
    arq_base_cal_arsa              NUMBER(18,2),
    arq_deducao_dependentes        NUMBER(18,2),
    arq_r_fgts_13s                 NUMBER(18,2),
    arq_base_cal_aerus             NUMBER(18,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_REMUNERACAO_2110

CREATE INDEX reg_remuneracao_2110_ix ON reg_remuneracao_2110
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_REMUNERACAO_2110

-- Start of DDL Script for Table IFRSRH.REG_REMUNERACAO_FINAL
-- Generated 9/3/2004 19:12:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_remuneracao_final
    (arq_ano                        NUMBER(4),
    arq_mes                        NUMBER(4),
    arq_mat                        NUMBER(9),
    arq_tipo_pagamento             VARCHAR2(1),
    arq_adiant_13_ate_mes          NUMBER(18,2),
    arq_base_cal_inps              NUMBER(18,2),
    arq_taxa_inps                  NUMBER(9,4),
    arq_r_inps_mes                 NUMBER(18,2),
    arq_base_cal_irrf              NUMBER(18,2),
    arq_r_aliquota_irrf_mes        NUMBER(9,2),
    arq_r_irrf_mes                 NUMBER(18,2),
    arq_base_cal_fgts_mes          NUMBER(18,2),
    arq_taxa_fgts                  NUMBER(9,2),
    arq_r_fgts_mes                 NUMBER(18,2),
    arq_taxa_sindical              NUMBER(9,2),
    arq_r_sindical_mes             NUMBER(18,2),
    arq_r_variavel_mes             NUMBER(18,2),
    arq_val_adiant_ferias          NUMBER(18,2),
    arq_proventos_mes              NUMBER(18,2),
    arq_proventos_ate_mes          NUMBER(18,2),
    arq_descontos_mes              NUMBER(18,2),
    arq_inps_13_sal                NUMBER(18,2),
    arq_cod_dep                    NUMBER(4),
    arq_base_cal_arsa              NUMBER(18,2),
    arq_deducao_dependentes        NUMBER(18,2),
    arq_r_fgts_13s                 NUMBER(18,2),
    arq_data_pagamento             NUMBER(6),
    arq_base_cal_aerus             NUMBER(18,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REG_REMUNERACAO_FINAL

CREATE INDEX reg_remuneracao_final_ix ON reg_remuneracao_final
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REG_REMUNERACAO_FINAL

-- Start of DDL Script for Table IFRSRH.REG_TEMP_FGTS
-- Generated 9/3/2004 19:12:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE reg_temp_fgts
    (arq_matricula                  NUMBER(7),
    saldo_fgts                     NUMBER(9,2),
    fgts_40_porcento               NUMBER(8,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.REG_TEMP_FGTS

-- Start of DDL Script for Table IFRSRH.REMUNERACAO_2110
-- Generated 9/3/2004 19:12:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE remuneracao_2110
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    mat                            NUMBER(9),
    adiant_13_ate_mes              NUMBER(20,2),
    base_cal_inps                  NUMBER(20,2),
    taxa_inps                      NUMBER(13,4),
    r_inps_mes                     NUMBER(20,2),
    base_cal_irrf                  NUMBER(20,2),
    r_aliquota_irrf_mes            NUMBER(11,2),
    r_irrf_mes                     NUMBER(20,2),
    base_cal_fgts_mes              NUMBER(20,2),
    taxa_fgts                      NUMBER(11,2),
    r_fgts_mes                     NUMBER(20,2),
    taxa_sindical                  NUMBER(11,2),
    r_sindical_mes                 NUMBER(20,2),
    r_variavel_mes                 NUMBER(20,2),
    val_adiant_ferias              NUMBER(20,2),
    proventos_mes                  NUMBER(20,2),
    proventos_ate_mes              NUMBER(20,2),
    descontos_mes                  NUMBER(20,2),
    inps_13_sal                    NUMBER(20,2),
    cod_dep                        NUMBER(4),
    base_cal_arsa                  NUMBER(20,2),
    deducao_dependentes            NUMBER(20,2),
    r_fgts_13s                     NUMBER(20,2),
    base_cal_aerus                 NUMBER(20,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REMUNERACAO_2110

CREATE INDEX rem_2110_idx ON remuneracao_2110
  (
    ano                             ASC,
    mes                             ASC,
    mat                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REMUNERACAO_2110

-- Start of DDL Script for Table IFRSRH.REMUNERACAO_FINAL
-- Generated 9/3/2004 19:12:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE remuneracao_final
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    mat                            NUMBER(9),
    tipo_pagamento                 VARCHAR2(1),
    adiant_13_ate_mes              NUMBER(20,2),
    base_cal_inps                  NUMBER(20,2),
    taxa_inps                      NUMBER(13,4),
    r_inps_mes                     NUMBER(20,2),
    base_cal_irrf                  NUMBER(20,2),
    r_aliquota_irrf_mes            NUMBER(11,2),
    r_irrf_mes                     NUMBER(20,2),
    base_cal_fgts_mes              NUMBER(20,2),
    taxa_fgts                      NUMBER(11,2),
    r_fgts_mes                     NUMBER(20,2),
    taxa_sindical                  NUMBER(11,2),
    r_sindical_mes                 NUMBER(20,2),
    r_variavel_mes                 NUMBER(20,2),
    val_adiant_ferias              NUMBER(20,2),
    proventos_mes                  NUMBER(20,2),
    proventos_ate_mes              NUMBER(20,2),
    descontos_mes                  NUMBER(20,2),
    inps_13_sal                    NUMBER(20,2),
    cod_dep                        NUMBER(4),
    base_cal_arsa                  NUMBER(20,2),
    deducao_dependentes            NUMBER(20,2),
    r_fgts_13s                     NUMBER(20,2),
    data_pagamento                 DATE,
    base_cal_aerus                 NUMBER(20,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for REMUNERACAO_FINAL

CREATE INDEX rem_fin_idx ON remuneracao_final
  (
    ano                             ASC,
    mes                             ASC,
    mat                             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.REMUNERACAO_FINAL

-- Start of DDL Script for Table IFRSRH.RESP_FINANCEIRO_PSV
-- Generated 9/3/2004 19:12:39 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resp_financeiro_psv
    (rfp_ano_referencia             NUMBER(4) NOT NULL,
    "RFP_MÊS_REFERENCIA"           NUMBER(2) NOT NULL,
    rfp_psv_sequencial             NUMBER(10) NOT NULL,
    rfp_rfi_sequencial             NUMBER(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESP_FINANCEIRO_PSV

ALTER TABLE resp_financeiro_psv
ADD CONSTRAINT rfp_pk PRIMARY KEY (rfp_ano_referencia, "RFP_MÊS_REFERENCIA", 
  rfp_psv_sequencial, rfp_rfi_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESP_FINANCEIRO_PSV

-- Start of DDL Script for Table IFRSRH.RESPONSAVEL_FINANCEIRO
-- Generated 9/3/2004 19:12:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE responsavel_financeiro
    (rfi_sequencial                 NUMBER(10) NOT NULL,
    rfi_numero_cpf                 NUMBER(11),
    rfi_numero_identidade          VARCHAR2(15),
    rfi_orgao_expedidor_ci         VARCHAR2(10),
    rfi_data_expedicao             DATE,
    rfi_ufe_sigla_ci               VARCHAR2(2),
    rfi_nome                       VARCHAR2(60),
    rfi_endereco                   VARCHAR2(50),
    rfi_bairro                     VARCHAR2(20),
    rfi_cep                        NUMBER(8),
    rfi_cidade                     VARCHAR2(30),
    rfi_ufe_sigla                  VARCHAR2(2),
    rfi_fone_comercial             NUMBER(12),
    rfi_fone_residencia            NUMBER(12),
    rfi_fone_celular               NUMBER(12))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESPONSAVEL_FINANCEIRO

ALTER TABLE responsavel_financeiro
ADD CONSTRAINT rfi_pk PRIMARY KEY (rfi_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESPONSAVEL_FINANCEIRO

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INFRAPREV
-- Generated 9/3/2004 19:12:54 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_infraprev
    (rin_ano_referencia             NUMBER(4) NOT NULL,
    rin_mes_referencia             NUMBER(2) NOT NULL,
    rin_versao_pagto               NUMBER(1) NOT NULL,
    rin_plano_infraprev            NUMBER(1) NOT NULL,
    rin_emp_numero_matricula       NUMBER(7) NOT NULL,
    rin_base_calc_infraprev        NUMBER(16,2),
    rin_cont_patroc                NUMBER(16,2),
    rin_cont_partic                NUMBER(16,2),
    rin_joia_infraprev             NUMBER(16,2),
    rin_cont_basica_particip_cd    NUMBER(16,2),
    rin_cont_vol_particip_cd       NUMBER(16,2),
    rin_cont_especial_particip_cd  NUMBER(16,2),
    rin_cont_especif_particip_cd   NUMBER(16,2),
    rin_cont_ext_particip_cd       NUMBER(16,2),
    rin_cont_princ_patroc_cd       NUMBER(16,2),
    rin_cont_var_patroc_cd         NUMBER(16,2),
    rin_cont_especial_patroc_cd    NUMBER(16,2),
    rin_cont_especif_patroc_cd     NUMBER(16,2),
    rin_cont_ext_patroc_cd         NUMBER(16,2),
    rin_emprestimos                NUMBER(16,2),
    rin_cont_amort_particip        NUMBER(6,3),
    rin_cont_amort_patroc          NUMBER(6,3),
    rin_deducoes                   NUMBER(16,2),
    rin_atualizacao_monetaria      NUMBER(5,2),
    rin_multa_juros                NUMBER(5,2),
    val_per_juros                  NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESUMO_ENCARGOS_INFRAPREV

ALTER TABLE resumo_encargos_infraprev
ADD CONSTRAINT rin_ck_1 CHECK (rin_plano_infraprev in (1,2,3))
/
ALTER TABLE resumo_encargos_infraprev
ADD CONSTRAINT rin_pk PRIMARY KEY (rin_ano_referencia, rin_mes_referencia, 
  rin_versao_pagto, rin_emp_numero_matricula, rin_plano_infraprev)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INFRAPREV

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS
-- Generated 9/3/2004 19:13:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_inss
    (rei_ano_referencia             NUMBER(4) NOT NULL,
    rei_mes_referencia             NUMBER(2) NOT NULL,
    rei_versao_pagto               NUMBER(1) NOT NULL,
    rei_emp_numero_matricula       NUMBER(7) NOT NULL,
    rei_base_calc_inss             NUMBER(16,2),
    rei_fpas                       NUMBER(5,2),
    rei_sat                        NUMBER(5,2),
    rei_incra                      NUMBER(5,2),
    rei_fundo_aeroviario           NUMBER(5,2),
    rei_salario_familia            NUMBER(16,2),
    rei_salario_maternidade        NUMBER(16,2),
    rei_faixa_inss                 NUMBER(5,2),
    rei_valor_faixa_inss           NUMBER(16,2),
    rei_dias_gozo_ferias           NUMBER(2),
    rei_atualizacao_monetaria      NUMBER(5,2),
    rei_multa_juros                NUMBER(5,2),
    val_per_juros                  NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESUMO_ENCARGOS_INSS

ALTER TABLE resumo_encargos_inss
ADD CONSTRAINT rei_pk PRIMARY KEY (rei_ano_referencia, rei_mes_referencia, 
  rei_versao_pagto, rei_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO
-- Generated 9/3/2004 19:13:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_inss_autonomo
    (rea_ano_referencia             NUMBER(4) NOT NULL,
    rea_mes_referencia             NUMBER(2) NOT NULL,
    rea_versao_pagto               NUMBER(1) NOT NULL,
    rea_dep_codigo                 NUMBER(4) NOT NULL,
    rea_cre_sequencial             NUMBER(5) NOT NULL,
    rea_base_calc_autonomo         NUMBER(16,2),
    rea_inss_autonomo              NUMBER(16,2),
    rea_perc_inss                  NUMBER(5,2),
    rea_perc_fretes                NUMBER(5,2),
    rea_atualizacao_monetaria      NUMBER(5,2),
    rea_multa_juros                NUMBER(5,2),
    rea_val_per_juros              NUMBER(5,2),
    rea_inss_patronal              NUMBER(16,2),
    rea_ind_aut_coop               VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESUMO_ENCARGOS_INSS_AUTONOMO

ALTER TABLE resumo_encargos_inss_autonomo
ADD CONSTRAINT rea_ck_1 CHECK (REA_IND_AUT_COOP IN ('A','AM','C','CM','CT'))
/
ALTER TABLE resumo_encargos_inss_autonomo
ADD CONSTRAINT rea_pk PRIMARY KEY (rea_ano_referencia, rea_mes_referencia, 
  rea_versao_pagto, rea_dep_codigo, rea_cre_sequencial, rea_ind_aut_coop)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for RESUMO_ENCARGOS_INSS_AUTONOMO

COMMENT ON COLUMN resumo_encargos_inss_autonomo.rea_ind_aut_coop IS 'INDICADOR DO TIPO DE AUTÔNOMO/COOPERATIVA'
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS_AUTONOMO

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS_TEMP
-- Generated 9/3/2004 19:13:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_inss_temp
    (rei_mes_referencia             NUMBER(2) NOT NULL,
    rei_ano_referencia             NUMBER(4) NOT NULL,
    rei_versao_pagto               NUMBER(1) NOT NULL,
    rei_emp_numero_matricula       NUMBER(7) NOT NULL,
    rei_base_calc_inss             NUMBER(16,2),
    rei_base_calc_autonomos        NUMBER(16,2),
    rei_fpas                       NUMBER(5,2),
    rei_sat                        NUMBER(5,2),
    rei_incra                      NUMBER(5,2),
    rei_fundo_aeroviario           NUMBER(5,2),
    rei_salario_familia            NUMBER(16,2),
    rei_salario_maternidade        NUMBER(16,2),
    rei_atualizacao_monetaria      NUMBER(5,2),
    rei_multa_juros                NUMBER(5,2),
    val_per_juros                  NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_INSS_TEMP

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_IRRF
-- Generated 9/3/2004 19:13:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_irrf
    (rir_ano_referencia             NUMBER(4) NOT NULL,
    rir_mes_referencia             NUMBER(2) NOT NULL,
    rir_versao_pagto               NUMBER(1) NOT NULL,
    rir_emp_numero_matricula       NUMBER(7) NOT NULL,
    rir_base_calc_irrf             NUMBER(16,2),
    rir_valor_irrf                 NUMBER(16,2),
    rir_atualizacao_monetaria      NUMBER(5,2),
    rir_multa_juros                NUMBER(5,2),
    val_per_juros                  NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESUMO_ENCARGOS_IRRF

ALTER TABLE resumo_encargos_irrf
ADD CONSTRAINT rir_pk PRIMARY KEY (rir_ano_referencia, rir_mes_referencia, 
  rir_versao_pagto, rir_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_IRRF

-- Start of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_SAL_EDUCACAO
-- Generated 9/3/2004 19:13:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE resumo_encargos_sal_educacao
    (rse_ano_referencia             NUMBER(4) NOT NULL,
    rse_mes_referencia             NUMBER(2) NOT NULL,
    rse_versao_pagto               NUMBER(1) NOT NULL,
    rse_emp_numero_matricula       NUMBER(7) NOT NULL,
    rse_base_calc_sal_educacao     NUMBER(16,2),
    rse_percent_sal_educacao       NUMBER(5,2),
    rse_deducoes_sme               NUMBER(16,2),
    rse_compensacao                NUMBER(16,2),
    rse_atualizacao_monetaria      NUMBER(5,2),
    rse_multa_juros                NUMBER(5,2),
    val_per_juros                  NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RESUMO_ENCARGOS_SAL_EDUCACAO

ALTER TABLE resumo_encargos_sal_educacao
ADD CONSTRAINT rse_pk PRIMARY KEY (rse_ano_referencia, rse_mes_referencia, 
  rse_versao_pagto, rse_emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RESUMO_ENCARGOS_SAL_EDUCACAO

-- Start of DDL Script for Table IFRSRH.RETENCAO_IMPOSTOS
-- Generated 9/3/2004 19:13:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE retencao_impostos
    (ri_cod_receita                 NUMBER(4) NOT NULL,
    ri_tax_ir                      NUMBER(5,3) NOT NULL,
    ri_tax_csll                    NUMBER(5,3) NOT NULL,
    ri_tax_cofins                  NUMBER(5,3) NOT NULL,
    ri_tax_pispasep                NUMBER(5,3) NOT NULL,
    ri_dat_inicio                  DATE NOT NULL,
    ri_dat_termino                 DATE,
    ri_descricao                   VARCHAR2(1000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RETENCAO_IMPOSTOS

ALTER TABLE retencao_impostos
ADD CONSTRAINT retencao_pk PRIMARY KEY (ri_cod_receita, ri_dat_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for RETENCAO_IMPOSTOS

COMMENT ON COLUMN retencao_impostos.ri_cod_receita IS 'Código da receita para os valores percentuais a serem retidos de acordo com a MP 153/2003'
/
COMMENT ON COLUMN retencao_impostos.ri_dat_inicio IS 'data inicial da vigência dos valores percentuais'
/
COMMENT ON COLUMN retencao_impostos.ri_dat_termino IS 'data final da vigência dos valores percentuais'
/
COMMENT ON COLUMN retencao_impostos.ri_descricao IS 'Observações do Beneficio que utilizará o código da receita pra os calculos dos impostos'
/
COMMENT ON COLUMN retencao_impostos.ri_tax_cofins IS 'valor percentual da Contribuição para o financiamento da Seguridade Social'
/
COMMENT ON COLUMN retencao_impostos.ri_tax_csll IS 'valor percentual da Contribuição Social sobre Lucro Líquido'
/
COMMENT ON COLUMN retencao_impostos.ri_tax_ir IS 'valor percentual do imposto de renda '
/
COMMENT ON COLUMN retencao_impostos.ri_tax_pispasep IS 'valor percentual do PIS/PASEP'
/

-- End of DDL Script for Table IFRSRH.RETENCAO_IMPOSTOS

-- Start of DDL Script for Table IFRSRH.RUBRICA_TEMP
-- Generated 9/3/2004 19:13:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE rubrica_temp
    (num_sequencia                  NUMBER NOT NULL,
    cod_rubrica                    NUMBER(4) NOT NULL,
    rub_denominacao                VARCHAR2(50),
    rub_cco_codigo                 VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RUBRICA_TEMP

ALTER TABLE rubrica_temp
ADD CONSTRAINT rubrica_temp_pk PRIMARY KEY (num_sequencia, cod_rubrica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RUBRICA_TEMP

-- Start of DDL Script for Table IFRSRH.RUBRICAS
-- Generated 9/3/2004 19:13:46 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE rubricas
    (rub_codigo                     NUMBER(4) NOT NULL,
    rub_denominacao                VARCHAR2(50) NOT NULL,
    rub_indic_exclu_rubrica        VARCHAR2(1) NOT NULL,
    rub_indic_rubr_ativa           VARCHAR2(1) NOT NULL,
    rub_indic_exclusiva            VARCHAR2(1) NOT NULL,
    rub_indic_formula              VARCHAR2(1) NOT NULL,
    rub_indic_formula_valor        VARCHAR2(1) NOT NULL,
    rub_tipo_rubrica               VARCHAR2(1) NOT NULL,
    rub_seq_pagamento              NUMBER(3) NOT NULL,
    rub_seq_exclu_rubrica          NUMBER(4),
    rub_cco_codigo                 VARCHAR2(20),
    rub_observacao                 VARCHAR2(300),
    rub_mes_criacao                NUMBER(2) NOT NULL,
    rub_ano_criacao                NUMBER(4) NOT NULL,
    rub_mes_extincao               NUMBER(2),
    rub_ano_extincao               NUMBER(4),
    rub_indic_proporcional         VARCHAR2(1) NOT NULL,
    rub_tipo_parametro             VARCHAR2(1),
    rub_indic_beneficio            VARCHAR2(1),
    cod_usuario                    VARCHAR2(30),
    dta_operacao                   DATE,
    rub_indic_fixo_variavel        VARCHAR2(1),
    rub_indic_rub_adicional        NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RUBRICAS

ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_3 CHECK (    RUB_TIPO_RUBRICA IN ('D','R') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_4 CHECK (    RUB_INDIC_EXCLUSIVA IN ('S','N') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_5 CHECK (    RUB_INDIC_FORMULA IN ('S','N') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_6 CHECK (    RUB_INDIC_FORMULA_VALOR IN ('S','N') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_7 CHECK (     RUB_TIPO_RUBRICA IN ('D','R') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_8 CHECK (     RUB_INDIC_PROPORCIONAL IN ('S','N') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_ck_9 CHECK (  rub_tipo_parametro in ('H','D','V','P') )
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_indic_fixo_var_ck CHECK (rub_indic_fixo_variavel IN ('F','V','C','N'))
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_pk PRIMARY KEY (rub_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for RUBRICAS

COMMENT ON COLUMN rubricas.cod_usuario IS 'Indica o usuário que efetuou a transação'
/
COMMENT ON COLUMN rubricas.dta_operacao IS 'Indica a data e hora da transação'
/
COMMENT ON COLUMN rubricas.rub_indic_fixo_variavel IS 'Flag que indica se a rubrica é do tipo fixo, variável ou cheia'
/
COMMENT ON COLUMN rubricas.rub_indic_rub_adicional IS 'Flag que indica se a rubrica trata-se de freqüência ou outro tipo.'
/

-- End of DDL Script for Table IFRSRH.RUBRICAS

-- Start of DDL Script for Table IFRSRH.RUBRICAS_ANTERIORES
-- Generated 9/3/2004 19:13:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE rubricas_anteriores
    (rua_rub_codigo                 NUMBER(4) NOT NULL,
    rua_codigo_anterior            NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for RUBRICAS_ANTERIORES

ALTER TABLE rubricas_anteriores
ADD CONSTRAINT rua_pk PRIMARY KEY (rua_rub_codigo, rua_codigo_anterior)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.RUBRICAS_ANTERIORES

-- Start of DDL Script for Table IFRSRH.SALARIO_FAMILIA
-- Generated 9/3/2004 19:14:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE salario_familia
    (saf_ano_referencia             NUMBER(4) NOT NULL,
    saf_mes_referencia             NUMBER(2) NOT NULL,
    saf_faixa                      NUMBER(1) NOT NULL,
    saf_renda_maxima               NUMBER(11,2) NOT NULL,
    saf_valor                      NUMBER(11,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SALARIO_FAMILIA

ALTER TABLE salario_familia
ADD CONSTRAINT saf_pk PRIMARY KEY (saf_ano_referencia, saf_mes_referencia, 
  saf_faixa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SALARIO_FAMILIA

-- Start of DDL Script for Table IFRSRH.SALDO_COBRANCA_APOSENTADO
-- Generated 9/3/2004 19:14:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE saldo_cobranca_aposentado
    (sca_emp_numero_matricula       NUMBER(7) NOT NULL,
    sca_mes_referencia             NUMBER(2) NOT NULL,
    sca_ano_referencia             NUMBER(4) NOT NULL,
    sca_sequencial                 NUMBER(3) NOT NULL,
    sca_saldo_devedor              NUMBER(15,2) NOT NULL,
    sca_valor_base_calculo         NUMBER(15,2),
    sca_valor_desconto             NUMBER(15,2),
    sca_mes_desconto               NUMBER(2),
    sca_ano_desconto               NUMBER(4),
    sca_cod_infraprev              NUMBER(12),
    sca_dep_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SALDO_COBRANCA_APOSENTADO

ALTER TABLE saldo_cobranca_aposentado
ADD CONSTRAINT sca_pk PRIMARY KEY (sca_emp_numero_matricula, sca_mes_referencia, 
  sca_ano_referencia, sca_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SALDO_COBRANCA_APOSENTADO

-- Start of DDL Script for Table IFRSRH.SIAD_ATRIBUICAO_CONCEITOS
-- Generated 9/3/2004 19:14:16 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_atribuicao_conceitos
    (codigo_conceito                VARCHAR2(1) NOT NULL,
    codigo_fator                   NUMBER(2) NOT NULL,
    ano_formulario                 NUMBER(4) NOT NULL,
    codigo_formulario              VARCHAR2(4) NOT NULL,
    ano_avaliacao_final            NUMBER(4) NOT NULL,
    ano_avaliador                  NUMBER(4) NOT NULL,
    matricula_avaliador            NUMBER(7) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_ATRIBUICAO_CONCEITOS

CREATE INDEX atrib_conc_conceitos_fk_i ON siad_atribuicao_conceitos
  (
    codigo_conceito                 ASC,
    codigo_formulario               ASC,
    ano_formulario                  ASC,
    codigo_fator                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX atrib_conc_avaliacao_fk_i ON siad_atribuicao_conceitos
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_ATRIBUICAO_CONCEITOS

ALTER TABLE siad_atribuicao_conceitos
ADD CONSTRAINT atrib_conc_pk PRIMARY KEY (codigo_conceito, codigo_fator, 
  ano_formulario, codigo_formulario, ano_avaliador, ano_avaliacao_final, 
  matricula_avaliador, emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_ATRIBUICAO_CONCEITOS

-- Start of DDL Script for Table IFRSRH.SIAD_AVALIACAO
-- Generated 9/3/2004 19:14:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_avaliacao
    (ano_avaliacao_final            NUMBER(4) NOT NULL,
    ano_avaliador                  NUMBER(4) NOT NULL,
    matricula_avaliador            NUMBER(7) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    pontuacao                      NUMBER(3),
    data_preenchimento             DATE,
    avaliador_externo              VARCHAR2(50),
    tipo_avaliador                 VARCHAR2(2),
    outros_treinamentos            VARCHAR2(50),
    outras_causas                  VARCHAR2(50),
    observacoes                    VARCHAR2(100),
    potencial                      VARCHAR2(200),
    acao_empresa                   VARCHAR2(100),
    acao_chefia                    VARCHAR2(100),
    acao_empregado                 VARCHAR2(100),
    codigo_motivo                  NUMBER(3),
    ano_formulario                 NUMBER(4) NOT NULL,
    codigo_formulario              VARCHAR2(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_AVALIACAO

CREATE INDEX avaliacao_formulario_fk_i ON siad_avaliacao
  (
    ano_formulario                  ASC,
    codigo_formulario               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX avaliacao_mot_nav_fk_i ON siad_avaliacao
  (
    codigo_motivo                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX avaliacao_avaliador_fk_i ON siad_avaliacao
  (
    ano_avaliador                   ASC,
    matricula_avaliador             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX avaliacao_av_final_fk_i ON siad_avaliacao
  (
    emp_numero_matricula            ASC,
    ano_avaliacao_final             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_AVALIACAO

ALTER TABLE siad_avaliacao
ADD CONSTRAINT avaliacao_pk PRIMARY KEY (ano_avaliador, ano_avaliacao_final, 
  matricula_avaliador, emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE siad_avaliacao
ADD CONSTRAINT tipo_avaliador_ck CHECK (  tipo_avaliador BETWEEN 'CH' AND 'CH'   OR tipo_avaliador BETWEEN 'SU' AND 'SU'  )
/

-- End of DDL Script for Table IFRSRH.SIAD_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_AVALIACAO_FINAL
-- Generated 9/3/2004 19:15:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_avaliacao_final
    (emp_numero_matricula           NUMBER(7) NOT NULL,
    ano_avaliacao_final            NUMBER(4) NOT NULL,
    tipo_escala                    VARCHAR2(1) NOT NULL,
    ano_escala                     NUMBER(4) NOT NULL,
    codigo_classificacao           VARCHAR2(2),
    pontuacao_final                NUMBER(5,2),
    lotacao                        NUMBER(9),
    dependencia_avaliacao          NUMBER(4),
    centro_negocios_avaliacao      NUMBER(4),
    funcao_avaliado                NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_AVALIACAO_FINAL

CREATE INDEX av_final_cadastros_fk_i ON siad_avaliacao_final
  (
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_AVALIACAO_FINAL

ALTER TABLE siad_avaliacao_final
ADD CONSTRAINT av_final_pk PRIMARY KEY (emp_numero_matricula, 
  ano_avaliacao_final)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE siad_avaliacao_final
ADD CONSTRAINT tipo_escala_ck CHECK (  tipo_escala BETWEEN 'C' AND 'C'   OR tipo_escala BETWEEN 'F' AND 'F'            )
/

-- End of DDL Script for Table IFRSRH.SIAD_AVALIACAO_FINAL

-- Start of DDL Script for Table IFRSRH.SIAD_AVALIACAO_FOCOS
-- Generated 9/3/2004 19:15:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_avaliacao_focos
    (ano_avaliacao_final            NUMBER(4) NOT NULL,
    ano_avaliador                  NUMBER(4) NOT NULL,
    matricula_avaliador            NUMBER(7) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    ano_focos                      NUMBER(4) NOT NULL,
    codigo_focos                   NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_AVALIACAO_FOCOS

CREATE INDEX aval_focos_avaliacao_fk_i ON siad_avaliacao_focos
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX aval_focos_focos_aten_fk_i ON siad_avaliacao_focos
  (
    ano_focos                       ASC,
    codigo_focos                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_AVALIACAO_FOCOS

ALTER TABLE siad_avaliacao_focos
ADD CONSTRAINT aval_focos_pk PRIMARY KEY (ano_avaliador, ano_avaliacao_final, 
  matricula_avaliador, emp_numero_matricula, ano_focos, codigo_focos)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_AVALIACAO_FOCOS

-- Start of DDL Script for Table IFRSRH.SIAD_AVALIACAO_TREINAMENTO
-- Generated 9/3/2004 19:15:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_avaliacao_treinamento
    (ano_treinamento                NUMBER(4) NOT NULL,
    codigo_treinamento             NUMBER(2) NOT NULL,
    ano_avaliacao_final            NUMBER(4) NOT NULL,
    ano_avaliador                  NUMBER(4) NOT NULL,
    matricula_avaliador            NUMBER(7) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_AVALIACAO_TREINAMENTO

CREATE INDEX aval_trein_avaliacao_fk_i ON siad_avaliacao_treinamento
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX aval_trein_treino_fk_i ON siad_avaliacao_treinamento
  (
    ano_treinamento                 ASC,
    codigo_treinamento              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_AVALIACAO_TREINAMENTO

ALTER TABLE siad_avaliacao_treinamento
ADD CONSTRAINT aval_trein_pk PRIMARY KEY (ano_treinamento, codigo_treinamento, 
  ano_avaliador, ano_avaliacao_final, matricula_avaliador, emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_AVALIACAO_TREINAMENTO

-- Start of DDL Script for Table IFRSRH.SIAD_AVALIADOR
-- Generated 9/3/2004 19:15:44 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_avaliador
    (ano_avaliador                  NUMBER(4) NOT NULL,
    matricula_avaliador            NUMBER(7) NOT NULL,
    senha                          VARCHAR2(6) NOT NULL,
    perfil_acesso                  NUMBER(2) NOT NULL,
    lotacao_avaliador              NUMBER(9),
    dependencia_avaliador          NUMBER(4),
    centro_negocios_avaliador      NUMBER(4),
    funcao_avaliador               NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_AVALIADOR

ALTER TABLE siad_avaliador
ADD CONSTRAINT avaliador_pk PRIMARY KEY (ano_avaliador, matricula_avaliador)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_AVALIADOR

-- Start of DDL Script for Table IFRSRH.SIAD_CHEFE
-- Generated 9/3/2004 19:15:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_chefe
    (oem_emp_numero_matricula       NUMBER(7) NOT NULL,
    oem_uor_codigo                 NUMBER(9) NOT NULL,
    oem_data_inicio                DATE NOT NULL,
    oem_data_termino               DATE,
    oem_fun_codigo                 NUMBER(3),
    oem_ofu_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_CHEFE

ALTER TABLE siad_chefe
ADD CONSTRAINT chefe_pk PRIMARY KEY (oem_uor_codigo, oem_data_inicio, 
  oem_emp_numero_matricula, oem_ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_CHEFE

-- Start of DDL Script for Table IFRSRH.SIAD_COMISSAO_AVALIACAO
-- Generated 9/3/2004 19:15:57 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_comissao_avaliacao
    (dep_codigo                     NUMBER(4) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    ano_comissao                   NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_COMISSAO_AVALIACAO

CREATE INDEX comissao_cadastros_fk_i ON siad_comissao_avaliacao
  (
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX comissao_depend_fk_i ON siad_comissao_avaliacao
  (
    dep_codigo                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_COMISSAO_AVALIACAO

ALTER TABLE siad_comissao_avaliacao
ADD CONSTRAINT comissao_pk PRIMARY KEY (ano_comissao, dep_codigo, 
  emp_numero_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_COMISSAO_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_COMPOSICAO_GRUPO
-- Generated 9/3/2004 19:16:13 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_composicao_grupo
    (ano_grupo_avaliacao            NUMBER(4) NOT NULL,
    codigo_grupo                   VARCHAR2(10) NOT NULL,
    uor_codigo                     NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SIAD_COMPOSICAO_GRUPO

CREATE INDEX comp_grupo_grupo_aval_fk_i ON siad_composicao_grupo
  (
    ano_grupo_avaliacao             ASC,
    codigo_grupo                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SIAD_COMPOSICAO_GRUPO

ALTER TABLE siad_composicao_grupo
ADD CONSTRAINT comp_grupo_pk PRIMARY KEY (ano_grupo_avaliacao, codigo_grupo, 
  uor_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_COMPOSICAO_GRUPO

-- Start of DDL Script for Table IFRSRH.SIAD_CONCEITOS_AVALIACAO
-- Generated 9/3/2004 19:16:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_conceitos_avaliacao
    (codigo_fator                   NUMBER(2) NOT NULL,
    ano_formulario                 NUMBER(4) NOT NULL,
    codigo_formulario              VARCHAR2(4) NOT NULL,
    codigo_conceito                VARCHAR2(1) NOT NULL,
    descricao_conceito             VARCHAR2(130) NOT NULL,
    grau_conceito                  NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_CONCEITOS_AVALIACAO

ALTER TABLE siad_conceitos_avaliacao
ADD CONSTRAINT conceitos_pk PRIMARY KEY (codigo_conceito, codigo_formulario, 
  ano_formulario, codigo_fator)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_CONCEITOS_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_CRONOGRAMA
-- Generated 9/3/2004 19:16:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_cronograma
    (ano_cronograma                 NUMBER(4) NOT NULL,
    item                           NUMBER(2) NOT NULL,
    descricao                      VARCHAR2(200) NOT NULL,
    data_inicio                    DATE NOT NULL,
    data_termino                   DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_CRONOGRAMA

ALTER TABLE siad_cronograma
ADD CONSTRAINT cronog_pk PRIMARY KEY (ano_cronograma, item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_CRONOGRAMA

-- Start of DDL Script for Table IFRSRH.SIAD_ESCALA_PONTUACAO
-- Generated 9/3/2004 19:16:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_escala_pontuacao
    (ano_escala                     NUMBER(4) NOT NULL,
    tipo_escala                    VARCHAR2(1) NOT NULL,
    codigo_classificacao           VARCHAR2(2) NOT NULL,
    pontuacao_inicial              NUMBER(5,2) NOT NULL,
    pontuacao_final                NUMBER(5,2) NOT NULL,
    classificacao                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_ESCALA_PONTUACAO

ALTER TABLE siad_escala_pontuacao
ADD CONSTRAINT escala_pk PRIMARY KEY (ano_escala, tipo_escala, 
  codigo_classificacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_ESCALA_PONTUACAO

-- Start of DDL Script for Table IFRSRH.SIAD_FATORES_AVALIATIVOS
-- Generated 9/3/2004 19:16:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_fatores_avaliativos
    (codigo_formulario              VARCHAR2(4) NOT NULL,
    ano_formulario                 NUMBER(4) NOT NULL,
    codigo_fator                   NUMBER(2) NOT NULL,
    descricao_fator                VARCHAR2(150) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_FATORES_AVALIATIVOS

ALTER TABLE siad_fatores_avaliativos
ADD CONSTRAINT fatores_pk PRIMARY KEY (ano_formulario, codigo_formulario, 
  codigo_fator)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_FATORES_AVALIATIVOS

-- Start of DDL Script for Table IFRSRH.SIAD_FOCOS_ATENCAO
-- Generated 9/3/2004 19:16:52 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_focos_atencao
    (ano_focos                      NUMBER(4) NOT NULL,
    codigo_focos                   NUMBER(2) NOT NULL,
    descricao_focos                VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_FOCOS_ATENCAO

ALTER TABLE siad_focos_atencao
ADD CONSTRAINT focos_aten_pk PRIMARY KEY (ano_focos, codigo_focos)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_FOCOS_ATENCAO

-- Start of DDL Script for Table IFRSRH.SIAD_FORMULARIO_AVALIACAO
-- Generated 9/3/2004 19:17:00 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_formulario_avaliacao
    (ano_formulario                 NUMBER(4) NOT NULL,
    codigo_formulario              VARCHAR2(4) NOT NULL,
    nome_formulario                VARCHAR2(70) NOT NULL,
    indicador_probatorio           VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_FORMULARIO_AVALIACAO

ALTER TABLE siad_formulario_avaliacao
ADD CONSTRAINT formulario_pk PRIMARY KEY (ano_formulario, codigo_formulario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_FORMULARIO_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_GRUPO_AVALIACAO
-- Generated 9/3/2004 19:17:06 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_grupo_avaliacao
    (ano_grupo_avaliacao            NUMBER(4) NOT NULL,
    codigo_grupo                   VARCHAR2(10) NOT NULL,
    nome_grupo_avaliacao           VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_GRUPO_AVALIACAO

ALTER TABLE siad_grupo_avaliacao
ADD CONSTRAINT grupo_aval_pk PRIMARY KEY (ano_grupo_avaliacao, codigo_grupo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_GRUPO_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_MOTIVO_NAO_AVALIACAO
-- Generated 9/3/2004 19:17:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_motivo_nao_avaliacao
    (codigo_motivo                  NUMBER(3) NOT NULL,
    descricao_motivo               VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_MOTIVO_NAO_AVALIACAO

ALTER TABLE siad_motivo_nao_avaliacao
ADD CONSTRAINT mot_nav_pk PRIMARY KEY (codigo_motivo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_MOTIVO_NAO_AVALIACAO

-- Start of DDL Script for Table IFRSRH.SIAD_NAO_AVALIADO
-- Generated 9/3/2004 19:17:19 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_nao_avaliado
    (ano_avaliacao                  NUMBER(4) NOT NULL,
    matricula                      NUMBER(7) NOT NULL,
    lotacao                        NUMBER(9),
    motivo                         VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_NAO_AVALIADO

ALTER TABLE siad_nao_avaliado
ADD CONSTRAINT sna_mat_pk PRIMARY KEY (ano_avaliacao, matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SIAD_NAO_AVALIADO

COMMENT ON TABLE siad_nao_avaliado IS 'SRH - SIAD'
/

-- End of DDL Script for Table IFRSRH.SIAD_NAO_AVALIADO

-- Start of DDL Script for Table IFRSRH.SIAD_TREINAMENTO
-- Generated 9/3/2004 19:17:25 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE siad_treinamento
    (ano_treinamento                NUMBER(4) NOT NULL,
    codigo_treinamento             NUMBER(2) NOT NULL,
    descricao                      VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SIAD_TREINAMENTO

ALTER TABLE siad_treinamento
ADD CONSTRAINT treino_pk PRIMARY KEY (ano_treinamento, codigo_treinamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SIAD_TREINAMENTO

-- Start of DDL Script for Table IFRSRH.SINISTROS
-- Generated 9/3/2004 19:17:32 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE sinistros
    (sin_sequencial                 NUMBER(7) NOT NULL,
    sin_emp_dep                    VARCHAR2(1) NOT NULL,
    sin_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    sin_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    sin_pvb_pvi_emp_numero_matric  NUMBER(7),
    sin_pvb_pvi_sequencial         NUMBER(2),
    sin_pvb_emb_ben_sigla          VARCHAR2(3),
    sin_pvb_adesao                 DATE,
    sin_basico                     VARCHAR2(1),
    sin_complementar               VARCHAR2(1),
    sin_data_sinistro              DATE NOT NULL,
    sin_salario_base               NUMBER(15,2) NOT NULL,
    sin_capital_basico             NUMBER(15,2),
    sin_capital_complementar       NUMBER(15,2),
    sin_andamento                  VARCHAR2(2000),
    sin_processo_encerrado         VARCHAR2(1),
    sin_tipo_sinistro              VARCHAR2(5) NOT NULL,
    data_sinistro                  DATE,
    sin_dep_resp_incl              NUMBER(4) NOT NULL,
    sin_data_andamento             DATE,
    sin_processo_segurado          NUMBER(15),
    sin_dt_termino_proc            DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SINISTROS

ALTER TABLE sinistros
ADD CONSTRAINT sin_pk PRIMARY KEY (sin_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SINISTROS

COMMENT ON COLUMN sinistros.sin_dt_termino_proc IS 'Data de término do processo de sinistro'
/
COMMENT ON COLUMN sinistros.sin_processo_segurado IS 'Número do processo do segurado no sinistro'
/

-- End of DDL Script for Table IFRSRH.SINISTROS

-- Start of DDL Script for Table IFRSRH.SITUACOES_FUNCIONAIS
-- Generated 9/3/2004 19:17:39 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE situacoes_funcionais
    (sfu_codigo                     NUMBER(1) NOT NULL,
    sfu_indicador_cargo            VARCHAR2(1) NOT NULL,
    sfu_indicador_funcao           VARCHAR2(1) NOT NULL,
    sfu_descricao                  VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SITUACOES_FUNCIONAIS

ALTER TABLE situacoes_funcionais
ADD CONSTRAINT sfu_codigo_ck CHECK ( sfu_codigo IN ( 2 , 3 , 4 , 1 )  )
/
ALTER TABLE situacoes_funcionais
ADD CONSTRAINT sfu_indicador_cargo_ck CHECK ( sfu_indicador_cargo IN ( 'S' , 'N' , 'O' )  )
/
ALTER TABLE situacoes_funcionais
ADD CONSTRAINT sfu_indicador_funcao_ck CHECK ( sfu_indicador_funcao IN ( 'S' , 'N' , 'O' )  )
/
ALTER TABLE situacoes_funcionais
ADD CONSTRAINT sfu_pk PRIMARY KEY (sfu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SITUACOES_FUNCIONAIS

COMMENT ON TABLE situacoes_funcionais IS 'SRHCAD - Situacao do funcionario '
/
COMMENT ON COLUMN situacoes_funcionais.sfu_codigo IS 'Codigo que identifica a situacao funcional.'
/
COMMENT ON COLUMN situacoes_funcionais.sfu_descricao IS 'Descricao da situacao funcional'
/
COMMENT ON COLUMN situacoes_funcionais.sfu_indicador_cargo IS 'Indicador da obrigatoriedade de ocupacao de cargo pelo empregado.'
/
COMMENT ON COLUMN situacoes_funcionais.sfu_indicador_funcao IS 'Indica se o empregado ou nao-empregado deve ocupar funcao.'
/

-- End of DDL Script for Table IFRSRH.SITUACOES_FUNCIONAIS

-- Start of DDL Script for Table IFRSRH.SPF_EMPREGADO_IND_INSUFICIENCI
-- Generated 9/3/2004 19:17:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_empregado_ind_insuficienci
    (ano_indicacao_ins              NUMBER(4) NOT NULL,
    cod_local_indicacao_ins        NUMBER(9) NOT NULL,
    indicador_local_ins            VARCHAR2(2) NOT NULL,
    matricula_emp_indicado_ins     NUMBER(7) NOT NULL,
    lotacao_emp_indicado_ins       NUMBER(9),
    dependencia_emp_indicado_ins   NUMBER(4),
    centro_negocio_emp_indicado_in NUMBER(4),
    ind_selecionado_ins            VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SPF_EMPREGADO_IND_INSUFICIENCI

ALTER TABLE spf_empregado_ind_insuficienci
ADD CONSTRAINT eii_empins_pk PRIMARY KEY (ano_indicacao_ins, 
  cod_local_indicacao_ins, indicador_local_ins, matricula_emp_indicado_ins)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SPF_EMPREGADO_IND_INSUFICIENCI

COMMENT ON TABLE spf_empregado_ind_insuficienci IS 'SPF - Progressao Funcional'
/

-- End of DDL Script for Table IFRSRH.SPF_EMPREGADO_IND_INSUFICIENCI

-- Start of DDL Script for Table IFRSRH.SPF_EMPREGADO_IND_PROMOCAO
-- Generated 9/3/2004 19:17:54 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_empregado_ind_promocao
    (ano_indicacao_prom             NUMBER(4) NOT NULL,
    cod_local_indicacao_prom       NUMBER(9) NOT NULL,
    indicador_local_prom           VARCHAR2(2) NOT NULL,
    matricula_emp_indicado_prom    NUMBER(7) NOT NULL,
    lotacao_emp_indicado_prom      NUMBER(9),
    dependencia_emp_indicado_prom  NUMBER(4),
    centro_negocio_emp_indicado_pr NUMBER(4),
    ind_selecionado_prom           VARCHAR2(1),
    ind_promocao                   VARCHAR2(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SPF_EMPREGADO_IND_PROMOCAO

ALTER TABLE spf_empregado_ind_promocao
ADD CONSTRAINT eip_indpro_pk PRIMARY KEY (ano_indicacao_prom, 
  cod_local_indicacao_prom, indicador_local_prom, matricula_emp_indicado_prom)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SPF_EMPREGADO_IND_PROMOCAO

COMMENT ON TABLE spf_empregado_ind_promocao IS 'SPF - Progressao Funcional'
/

-- End of DDL Script for Table IFRSRH.SPF_EMPREGADO_IND_PROMOCAO

-- Start of DDL Script for Table IFRSRH.SPF_EMPREGADO_NAO_PROMOVIDO
-- Generated 9/3/2004 19:18:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_empregado_nao_promovido
    (motn_prom_cod_motivo_nao_promo VARCHAR2(5) NOT NULL,
    motn_prom_tipo_promocao        VARCHAR2(1) NOT NULL,
    cadastros_emp_numero_matricula NUMBER(7) NOT NULL,
    motn_prom_ano_promocao         NUMBER(4) NOT NULL,
    flg_impedimento_adicional      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPF_EMPREGADO_NAO_PROMOVIDO

CREATE INDEX emp_npromv_cadastros_fk_i ON spf_empregado_nao_promovido
  (
    cadastros_emp_numero_matricula  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX emp_npromv_motn_prom_fk_i ON spf_empregado_nao_promovido
  (
    motn_prom_ano_promocao          ASC,
    motn_prom_cod_motivo_nao_promo  ASC,
    motn_prom_tipo_promocao         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SPF_EMPREGADO_NAO_PROMOVIDO

ALTER TABLE spf_empregado_nao_promovido
ADD CONSTRAINT emp_npromv_pk PRIMARY KEY (motn_prom_cod_motivo_nao_promo, 
  motn_prom_tipo_promocao, cadastros_emp_numero_matricula, 
  motn_prom_ano_promocao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_EMPREGADO_NAO_PROMOVIDO

-- Start of DDL Script for Table IFRSRH.SPF_EMPREGADO_NAO_PROMOVIDO_2
-- Generated 9/3/2004 19:18:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_empregado_nao_promovido_2
    (motn_prom_cod_motivo_nao_promo VARCHAR2(5),
    motn_prom_tipo_promocao        VARCHAR2(1),
    cadastros_emp_numero_matricula NUMBER(7),
    motn_prom_ano_promocao         NUMBER(4),
    flg_impedimento_adicional      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_EMPREGADO_NAO_PROMOVIDO_2

-- Start of DDL Script for Table IFRSRH.SPF_EMPREGADO_PROMOVIDO
-- Generated 9/3/2004 19:18:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_empregado_promovido
    (promocao_tipos_ocor_ofu_codigo NUMBER(4) NOT NULL,
    cadastros_emp_numero_matricula NUMBER(7) NOT NULL,
    promocao_ano_promocao          NUMBER(4) NOT NULL,
    niveis_sal_nsa_codigo_nivel    NUMBER(2) NOT NULL,
    niveis_sal_nsa_codigo_padrao   VARCHAR2(4) NOT NULL,
    niveis_sal_nsa_indicador_nivel VARCHAR2(1) NOT NULL,
    cargos_car_codigo              NUMBER(3) NOT NULL,
    cargos_car_codigo_nivel        NUMBER(1) NOT NULL,
    cargos_ocucargo_occ_codigo     NUMBER(3) NOT NULL,
    car_codigo_anterior            NUMBER(3) NOT NULL,
    car_codigo_nivel_anterior      NUMBER(1) NOT NULL,
    car_occ_codigo_anterior        NUMBER(3) NOT NULL,
    nsa_codigo_nivel_anterior      NUMBER(2) NOT NULL,
    nsa_codigo_padrao_anterior     VARCHAR2(4) NOT NULL,
    nsa_indicador_nivel_escola_ant VARCHAR2(1) NOT NULL,
    dat_inclusao                   DATE NOT NULL,
    dat_termino                    DATE,
    flg_atualizacao_cadastro       VARCHAR2(1),
    flg_promocao_adicional         VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPF_EMPREGADO_PROMOVIDO

CREATE INDEX emp_prom_cadastros_fk_i ON spf_empregado_promovido
  (
    cadastros_emp_numero_matricula  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX emp_prom_cargos_fk_i ON spf_empregado_promovido
  (
    cargos_ocucargo_occ_codigo      ASC,
    cargos_car_codigo               ASC,
    cargos_car_codigo_nivel         ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX emp_prom_niveis_sal_fk_i ON spf_empregado_promovido
  (
    niveis_sal_nsa_codigo_nivel     ASC,
    niveis_sal_nsa_codigo_padrao    ASC,
    niveis_sal_nsa_indicador_nivel  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX emp_prom_promocao_fk_i ON spf_empregado_promovido
  (
    promocao_ano_promocao           ASC,
    promocao_tipos_ocor_ofu_codigo  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SPF_EMPREGADO_PROMOVIDO

ALTER TABLE spf_empregado_promovido
ADD CONSTRAINT emp_prom_pk PRIMARY KEY (promocao_tipos_ocor_ofu_codigo, 
  cadastros_emp_numero_matricula, promocao_ano_promocao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_EMPREGADO_PROMOVIDO

-- Start of DDL Script for Table IFRSRH.SPF_FAIXA_PROMOVIDA
-- Generated 9/3/2004 19:18:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_faixa_promovida
    (promocao_tipos_ocor_ofu_codigo NUMBER(4) NOT NULL,
    promocao_ano_promocao          NUMBER(4) NOT NULL,
    tipo_escala_pontuacao          VARCHAR2(1) NOT NULL,
    pontuacao_inicial              NUMBER(5,2) NOT NULL,
    pontuacao_final                NUMBER(5,2) NOT NULL,
    qtd_padroes                    NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPF_FAIXA_PROMOVIDA

CREATE INDEX faixa_promocao_fk_i ON spf_faixa_promovida
  (
    promocao_ano_promocao           ASC,
    promocao_tipos_ocor_ofu_codigo  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SPF_FAIXA_PROMOVIDA

ALTER TABLE spf_faixa_promovida
ADD CONSTRAINT faixa_pk PRIMARY KEY (promocao_tipos_ocor_ofu_codigo, 
  promocao_ano_promocao, tipo_escala_pontuacao, pontuacao_inicial, 
  pontuacao_final)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_FAIXA_PROMOVIDA

-- Start of DDL Script for Table IFRSRH.SPF_LOCAL_INDICACAO
-- Generated 9/3/2004 19:19:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_local_indicacao
    (ano_indicacao                  NUMBER(4) NOT NULL,
    cod_local_indicacao            NUMBER(9) NOT NULL,
    indicador_local                VARCHAR2(2) NOT NULL,
    percentual_ind_promocao        NUMBER(5,2),
    numero_limite_promocao         NUMBER(5),
    numero_ind_promocao            NUMBER(5),
    matricula_ind_promocao         NUMBER(7),
    nome_ind_externo_promocao      VARCHAR2(100),
    percentual_ind_insuficiencia   NUMBER(5,2),
    numero_limite_insuficiencia    NUMBER(5),
    numero_ind_insuficiencia       NUMBER(5),
    matricula_ind_insuficiencia    NUMBER(7),
    nome_ind_externo_insuficiencia VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SPF_LOCAL_INDICACAO

ALTER TABLE spf_local_indicacao
ADD CONSTRAINT spf_locind_pk PRIMARY KEY (ano_indicacao, cod_local_indicacao, 
  indicador_local)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_LOCAL_INDICACAO

-- Start of DDL Script for Table IFRSRH.SPF_MOTIVO_NAO_PROMOCAO
-- Generated 9/3/2004 19:19:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_motivo_nao_promocao
    (ano_promocao                   NUMBER(4) NOT NULL,
    cod_motivo_nao_promocao        VARCHAR2(5) NOT NULL,
    tipo_promocao                  VARCHAR2(1) NOT NULL,
    dsc_motivo_nao_promocao        VARCHAR2(300))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SPF_MOTIVO_NAO_PROMOCAO

ALTER TABLE spf_motivo_nao_promocao
ADD CONSTRAINT motn_prom_pk PRIMARY KEY (ano_promocao, cod_motivo_nao_promocao, 
  tipo_promocao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_MOTIVO_NAO_PROMOCAO

-- Start of DDL Script for Table IFRSRH.SPF_PROCESSO_JUDICIAL
-- Generated 9/3/2004 19:19:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_processo_judicial
    (tip_proc_tipo_processo_judicia NUMBER(2) NOT NULL,
    cadastros_emp_numero_matricula NUMBER(7) NOT NULL,
    data_inicio_impedimento        DATE NOT NULL,
    data_termino_impedimento       DATE,
    ind_impetracao                 CHAR(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPF_PROCESSO_JUDICIAL

CREATE INDEX processos_cadastros_fk_i ON spf_processo_judicial
  (
    cadastros_emp_numero_matricula  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX processos_tip_proc_fk_i ON spf_processo_judicial
  (
    tip_proc_tipo_processo_judicia  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SPF_PROCESSO_JUDICIAL

ALTER TABLE spf_processo_judicial
ADD CONSTRAINT processos_pk PRIMARY KEY (tip_proc_tipo_processo_judicia, 
  cadastros_emp_numero_matricula, data_inicio_impedimento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_PROCESSO_JUDICIAL

-- Start of DDL Script for Table IFRSRH.SPF_PROMOCAO
-- Generated 9/3/2004 19:19:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_promocao
    (tipos_ocor_ofu_codigo          NUMBER(4) NOT NULL,
    ano_promocao                   NUMBER(4) NOT NULL,
    dat_efetivacao_promocao        DATE,
    num_ato_administrativo         VARCHAR2(30),
    dat_ato_administrativo         DATE,
    tex_promocao                   VARCHAR2(200) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SPF_PROMOCAO

CREATE INDEX promocao_tipos_ocor_fk_i ON spf_promocao
  (
    tipos_ocor_ofu_codigo           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for SPF_PROMOCAO

ALTER TABLE spf_promocao
ADD CONSTRAINT promocao_pk PRIMARY KEY (tipos_ocor_ofu_codigo, ano_promocao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for SPF_PROMOCAO

COMMENT ON COLUMN spf_promocao.num_ato_administrativo IS 'Número do Ato Administrativo que oficializa uma promoção de empregado'
/

-- End of DDL Script for Table IFRSRH.SPF_PROMOCAO

-- Start of DDL Script for Table IFRSRH.SPF_TIPO_PROCESSO_JUDICIAL
-- Generated 9/3/2004 19:19:47 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE spf_tipo_processo_judicial
    (tipo_processo_judicial         NUMBER(2) NOT NULL,
    dsc_tipo_processo_judicial     VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for SPF_TIPO_PROCESSO_JUDICIAL

ALTER TABLE spf_tipo_processo_judicial
ADD CONSTRAINT tip_proc_pk PRIMARY KEY (tipo_processo_judicial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.SPF_TIPO_PROCESSO_JUDICIAL

-- Start of DDL Script for Table IFRSRH.SRH_REF_CODES
-- Generated 9/3/2004 19:19:53 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE srh_ref_codes
    (rv_low_value                   VARCHAR2(240) NOT NULL,
    rv_high_value                  VARCHAR2(240),
    rv_abbreviation                VARCHAR2(240),
    rv_domain                      VARCHAR2(100) NOT NULL,
    rv_meaning                     VARCHAR2(240),
    rv_type                        VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for SRH_REF_CODES

CREATE INDEX x_srh_ref_codes_1 ON srh_ref_codes
  (
    rv_domain                       ASC,
    rv_low_value                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.SRH_REF_CODES

-- Start of DDL Script for Table IFRSRH.TAB_AUXILIAR
-- Generated 9/3/2004 19:19:59 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_auxiliar
    (col_unica                      VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TAB_AUXILIAR

-- Start of DDL Script for Table IFRSRH.TAB_CESTA_BASICA
-- Generated 9/3/2004 19:20:01 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_cesta_basica
    (tcb_nsa_codigo_nivel           NUMBER(2) NOT NULL,
    tcb_nsa_codigo_padrao          VARCHAR2(4) NOT NULL,
    tcb_nsa_ind_nivel_escola       VARCHAR2(1) NOT NULL,
    tcb_dt_ini_vigencia            DATE NOT NULL,
    tcb_dt_fim_vigencia            DATE,
    tcb_valor                      NUMBER(12,2) NOT NULL,
    tcb_valor_diferenca            NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TAB_CESTA_BASICA

ALTER TABLE tab_cesta_basica
ADD CONSTRAINT tab_cesta_basica_pk PRIMARY KEY (tcb_nsa_codigo_nivel, 
  tcb_nsa_codigo_padrao, tcb_nsa_ind_nivel_escola, tcb_dt_ini_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TAB_CESTA_BASICA

-- Start of DDL Script for Table IFRSRH.TAB_DESPESA_MEDICAMENTOS
-- Generated 9/3/2004 19:20:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_despesa_medicamentos
    (tdm_sequencial                 NUMBER(7) NOT NULL,
    tdm_gui_numero                 NUMBER(6) NOT NULL,
    tdm_gui_doc_numero             NUMBER(10) NOT NULL,
    tdm_gui_doc_cbe_ben_sigla      VARCHAR2(3) NOT NULL,
    tdm_gui_doc_cbe_cre_sequencial NUMBER(5) NOT NULL,
    tdm_descricao                  VARCHAR2(250) NOT NULL,
    tdm_valor                      NUMBER(12,2) NOT NULL,
    tdm_valor_participacao         NUMBER(12,2),
    tdm_mov_participacao           VARCHAR2(1),
    tdm_gui_doc_dep_codigo         NUMBER(4) NOT NULL,
    tdm_valor_excede               NUMBER(12,2),
    tdm_status_internacao          VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TAB_DESPESA_MEDICAMENTOS

CREATE INDEX tdm_gui_fk ON tab_despesa_medicamentos
  (
    tdm_gui_doc_cbe_cre_sequencial  ASC,
    tdm_gui_doc_numero              ASC,
    tdm_gui_doc_cbe_ben_sigla       ASC,
    tdm_gui_doc_dep_codigo          ASC,
    tdm_gui_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for TAB_DESPESA_MEDICAMENTOS

ALTER TABLE tab_despesa_medicamentos
ADD CONSTRAINT tdm_pk PRIMARY KEY (tdm_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TAB_DESPESA_MEDICAMENTOS

COMMENT ON COLUMN tab_despesa_medicamentos.tdm_mov_participacao IS 'Indica se a participacao foi lancada na folha de pagamento'
/
COMMENT ON COLUMN tab_despesa_medicamentos.tdm_status_internacao IS 'FLAG PARA IDENTIFICAR OS PROCEDIMENTOS QUE PODERÃO TER INTERNAÇÕES CLÍNICAS OU CIRÚRGICAS'
/

-- End of DDL Script for Table IFRSRH.TAB_DESPESA_MEDICAMENTOS

-- Start of DDL Script for Table IFRSRH.TAB_IRRF_2110
-- Generated 9/3/2004 19:20:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_irrf_2110
    (ano                            NUMBER(4),
    mes                            NUMBER(4),
    nro_faixa                      NUMBER(4),
    val_lim_sup                    NUMBER(20,2),
    aliquota                       NUMBER(13,4),
    deducao_dep                    NUMBER(20,2),
    deducao                        NUMBER(20,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TAB_IRRF_2110

-- Start of DDL Script for Table IFRSRH.TAB_MSG_CONTRACHEQUE_EMPREGADO
-- Generated 9/3/2004 19:20:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_msg_contracheque_empregado
    (mce_emp_numero_matricula       NUMBER(7),
    mce_mensagem                   VARCHAR2(1000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TAB_MSG_CONTRACHEQUE_EMPREGADO

COMMENT ON COLUMN tab_msg_contracheque_empregado.mce_emp_numero_matricula IS 'Matrícula do Empregado'
/
COMMENT ON COLUMN tab_msg_contracheque_empregado.mce_mensagem IS 'Observação impressa no contra-cheque'
/

-- End of DDL Script for Table IFRSRH.TAB_MSG_CONTRACHEQUE_EMPREGADO

-- Start of DDL Script for Table IFRSRH.TAB_PARAMETROS
-- Generated 9/3/2004 19:20:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_parametros
    (cod_grupo                      NUMBER(4) NOT NULL,
    desc_grupo                     VARCHAR2(150) NOT NULL,
    cod_assunto                    NUMBER(4) NOT NULL,
    desc_assunto                   VARCHAR2(250) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    2
  MAXTRANS    255
/

-- Constraints for TAB_PARAMETROS

ALTER TABLE tab_parametros
ADD CONSTRAINT pk_tab_parametros PRIMARY KEY (cod_grupo, cod_assunto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TAB_PARAMETROS

COMMENT ON COLUMN tab_parametros.cod_assunto IS 'Codigo de Assunto, que sera o codigo da referencia'
/
COMMENT ON COLUMN tab_parametros.cod_grupo IS 'Codigo de Grupo, que identificara o grupo dentro do qual se encontra a referencia'
/
COMMENT ON COLUMN tab_parametros.desc_assunto IS 'Descricao de Assunto, que sera a descricao da referencia'
/
COMMENT ON COLUMN tab_parametros.desc_grupo IS 'Descricao do Grupo, onde se dara o nome do grupo'
/

-- End of DDL Script for Table IFRSRH.TAB_PARAMETROS

-- Start of DDL Script for Table IFRSRH.TAB_PARAMETROS_DETALHES
-- Generated 9/3/2004 19:20:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_parametros_detalhes
    (valor                          VARCHAR2(255) NOT NULL,
    data_inicio                    DATE NOT NULL,
    cod_grupo                      NUMBER(4) NOT NULL,
    cod_assunto                    NUMBER(4) NOT NULL,
    data_termino                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    2
  MAXTRANS    255
/

-- Indexes for TAB_PARAMETROS_DETALHES

CREATE INDEX relationship_1_fk ON tab_parametros_detalhes
  (
    cod_grupo                       ASC,
    cod_assunto                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for TAB_PARAMETROS_DETALHES

ALTER TABLE tab_parametros_detalhes
ADD CONSTRAINT pk_tab_parametros_detalhes PRIMARY KEY (data_inicio, cod_grupo, 
  cod_assunto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TAB_PARAMETROS_DETALHES

COMMENT ON COLUMN tab_parametros_detalhes.cod_assunto IS 'Codigo de Assunto, que sera o codigo da referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.cod_grupo IS 'Codigo de Grupo, que identificara o grupo dentro do qual se encontra a referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.data_inicio IS 'Valor, que teria a referencia que estamos precisando '
/
COMMENT ON COLUMN tab_parametros_detalhes.data_termino IS 'Data de Termino do valor da referencia'
/
COMMENT ON COLUMN tab_parametros_detalhes.valor IS 'Valor, que teria a referencia que estamos precisando '
/

-- End of DDL Script for Table IFRSRH.TAB_PARAMETROS_DETALHES

-- Start of DDL Script for Table IFRSRH.TAB_PARTICIPACAO_BENEFICIO
-- Generated 9/3/2004 19:20:37 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_participacao_beneficio
    (tpb_sequencial                 NUMBER(12) NOT NULL,
    tpb_tpb_sequencial             NUMBER(12) NOT NULL,
    tpb_emp_numero_matricula       NUMBER(7) NOT NULL,
    tpb_pvi_sequencial             NUMBER(2),
    tpb_dep_codigo_fisico          NUMBER(4) NOT NULL,
    tpb_dep_codigo_lotacao         NUMBER(4) NOT NULL,
    tpb_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    tpb_rub_codigo                 NUMBER(4),
    tpb_mes_folha                  NUMBER(2) NOT NULL,
    tpb_ano_folha                  NUMBER(4) NOT NULL,
    tpb_mes_pagto                  NUMBER(2),
    tpb_ano_pagto                  NUMBER(4),
    tpb_cct_codigo                 NUMBER(5),
    tpb_valor_internacao           NUMBER(15,2),
    tpb_valor_eletivo              NUMBER(15,2),
    tpb_valor_empresa              NUMBER(15,2),
    tpb_valor_empregado            NUMBER(15,2),
    tpb_valor_excedente            NUMBER(15,2),
    tpb_valor_outros               NUMBER(15,2),
    tpb_data_geracao               DATE NOT NULL,
    tpb_parcela                    NUMBER(3) NOT NULL,
    tpb_parcela_atual              NUMBER(3) NOT NULL,
    tpb_data_mov                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TAB_PARTICIPACAO_BENEFICIO

COMMENT ON COLUMN tab_participacao_beneficio.tpb_data_mov IS 'Data de atualização do registro na movimentação'
/
COMMENT ON COLUMN tab_participacao_beneficio.tpb_parcela IS 'CAMPO PARA INFORMAR A PARCELA ATUAL QUE ESTÁ SENDO LANÇADA NA FOLHA'
/

-- End of DDL Script for Table IFRSRH.TAB_PARTICIPACAO_BENEFICIO

-- Start of DDL Script for Table IFRSRH.TAB_QUALIFICACAO_ACADEMICA
-- Generated 9/3/2004 19:20:41 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tab_qualificacao_academica
    (qua_cod_qualif_academica       NUMBER(4) NOT NULL,
    qua_descr_qualif_academica     VARCHAR2(100))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TAB_QUALIFICACAO_ACADEMICA

ALTER TABLE tab_qualificacao_academica
ADD CONSTRAINT quac_pk PRIMARY KEY (qua_cod_qualif_academica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TAB_QUALIFICACAO_ACADEMICA

-- Start of DDL Script for Table IFRSRH.TEMP_INCIDENCIAS_RUBRICAS
-- Generated 9/3/2004 19:20:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE temp_incidencias_rubricas
    (tir_rub_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TEMP_INCIDENCIAS_RUBRICAS

-- Start of DDL Script for Table IFRSRH.TEMP_MOVIMENTACAO
-- Generated 9/3/2004 19:20:49 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE temp_movimentacao
    (mov_ano_referencia             NUMBER(4) NOT NULL,
    mov_mes_referencia             NUMBER(2) NOT NULL,
    mov_versao_pagamento           NUMBER(2) NOT NULL,
    mov_emp_numero_matricula       NUMBER(7) NOT NULL,
    mov_rub_codigo                 NUMBER(4) NOT NULL,
    mov_sequencial                 NUMBER(2) NOT NULL,
    mov_for_codigo                 NUMBER(3),
    mov_parcela                    NUMBER(3) NOT NULL,
    mov_parcela_atual              NUMBER(3) NOT NULL,
    mov_tipo_parametro             VARCHAR2(1),
    mov_parametro                  NUMBER(14,6),
    mov_valor                      NUMBER(11,2),
    mov_tip_rubrica                VARCHAR2(1) NOT NULL,
    mov_mes_ref_diferenca          NUMBER(2),
    mov_ano_ref_diferenca          NUMBER(4),
    mov_pen_codigo                 NUMBER(2),
    mov_ind_calculo                CHAR(1) NOT NULL,
    mov_pem_ben_sigla              VARCHAR2(3),
    mov_rub_seq_pagamento          NUMBER(3) NOT NULL,
    mov_ind_arsaprev               VARCHAR2(1),
    mov_fun_codigo                 NUMBER(3),
    mov_tipo_funcao                VARCHAR2(2),
    mov_pkt_codigo_pedido          NUMBER,
    mov_valor_integral             NUMBER(11,2),
    mov_ind_exclusivo              VARCHAR2(1) NOT NULL,
    mov_dias_proporcionalidade     NUMBER(2),
    mov_ind_abertura               VARCHAR2(1) NOT NULL,
    mov_nsa_codigo_nivel           NUMBER(2),
    mov_nsa_codigo_padrao          VARCHAR2(4),
    mov_nsa_indicador_nivel_escola VARCHAR2(1),
    mov_ind_lancamento_liq_negat   VARCHAR2(1),
    mov_flg_frequencia             VARCHAR2(1),
    mov_data_credito               DATE,
    mov_data_calculo               DATE,
    mov_emp_dep_codigo_pagto       NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TEMP_MOVIMENTACAO

CREATE INDEX temp_mov_dep_ix ON temp_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX temp_mov_emp_idx ON temp_movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for TEMP_MOVIMENTACAO

ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_1 CHECK ( mov_tipo_parametro in ('H','D','V','P','Q') )
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_2 CHECK (  mov_tip_rubrica in ('N','D','E','R') )
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_3 CHECK ( MOV_IND_ARSAPREV in ('S','N','I')  )
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_4 CHECK (mov_tipo_funcao in ('FG','RG','DI'))
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_5 CHECK (mov_ind_exclusivo in ('S','N'))
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_6 CHECK (mov_ind_abertura in ('S','N'))
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_ck_7 CHECK ( mov_ind_calculo IN ( 'S' , 'N' )  )
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_pk PRIMARY KEY (mov_ano_referencia, mov_mes_referencia, 
  mov_versao_pagamento, mov_emp_numero_matricula, mov_rub_codigo, 
  mov_tip_rubrica, mov_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TEMP_MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.TEMP_PROGRAMACOES_FERIAS
-- Generated 9/3/2004 19:21:07 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE temp_programacoes_ferias
    (emp_numero_matricula           NUMBER(7),
    emp_inicio_periodo_aquisitivo  DATE,
    emp_termino_periodo_aquisitivo DATE,
    emp_numero_dias_direito_ferias NUMBER(2),
    emp_data_limite_gozo           DATE,
    emp_id_usuario                 VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TEMP_PROGRAMACOES_FERIAS

-- Start of DDL Script for Table IFRSRH.TEMP_UNIDADES_ORGANIZACIONAIS
-- Generated 9/3/2004 19:21:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE temp_unidades_organizacionais
    (uor_codigo_de                  NUMBER(9) NOT NULL,
    uor_codigo_para                NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TEMP_UNIDADES_ORGANIZACIONAIS

ALTER TABLE temp_unidades_organizacionais
ADD CONSTRAINT tuo_pk PRIMARY KEY (uor_codigo_de)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TEMP_UNIDADES_ORGANIZACIONAIS

-- Start of DDL Script for Table IFRSRH.TIPO_SINISTRO
-- Generated 9/3/2004 19:21:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipo_sinistro
    (tis_codigo_tipo                NUMBER(3) NOT NULL,
    tis_sigla                      VARCHAR2(4),
    tis_descricao                  VARCHAR2(70))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPO_SINISTRO

ALTER TABLE tipo_sinistro
ADD CONSTRAINT tp_sinistro_pk PRIMARY KEY (tis_codigo_tipo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TIPO_SINISTRO

COMMENT ON COLUMN tipo_sinistro.tis_codigo_tipo IS 'código que identifica o tipo do sinstro'
/
COMMENT ON COLUMN tipo_sinistro.tis_descricao IS 'descrição do tipo de sinistro'
/
COMMENT ON COLUMN tipo_sinistro.tis_sigla IS 'sigla que identifica o tipo de sinistro'
/

-- End of DDL Script for Table IFRSRH.TIPO_SINISTRO

-- Start of DDL Script for Table IFRSRH.TIPO_SINISTRO_DOC
-- Generated 9/3/2004 19:21:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipo_sinistro_doc
    (tsd_dos_codigo_doc             NUMBER(3) NOT NULL,
    tsd_tis_codigo_tipo            NUMBER(3) NOT NULL,
    tsd_ind_obrigatorio            VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPO_SINISTRO_DOC

ALTER TABLE tipo_sinistro_doc
ADD CONSTRAINT tp_sinistro_doc_pk PRIMARY KEY (tsd_dos_codigo_doc, 
  tsd_tis_codigo_tipo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TIPO_SINISTRO_DOC

COMMENT ON COLUMN tipo_sinistro_doc.tsd_dos_codigo_doc IS 'código que identifica a documentação do sinistro'
/
COMMENT ON COLUMN tipo_sinistro_doc.tsd_ind_obrigatorio IS 'flag indicando se a documentação é obrigatória ou não dentro do processo para o tipo de sinistro especificado (Valores Possíveis: S - Sim; N - Não)'
/
COMMENT ON COLUMN tipo_sinistro_doc.tsd_tis_codigo_tipo IS 'código que identifica o tipo do sinstro'
/

-- End of DDL Script for Table IFRSRH.TIPO_SINISTRO_DOC

-- Start of DDL Script for Table IFRSRH.TIPO_VINCULOS
-- Generated 9/3/2004 19:21:30 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipo_vinculos
    (tpv_codigo                     NUMBER(2) NOT NULL,
    tpv_nome                       VARCHAR2(80),
    enquadramento                  VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPO_VINCULOS

ALTER TABLE tipo_vinculos
ADD CONSTRAINT tpv_codigo_pk PRIMARY KEY (tpv_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TIPO_VINCULOS

-- Start of DDL Script for Table IFRSRH.TIPOS_CREDENCIADOS
-- Generated 9/3/2004 19:21:35 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipos_credenciados
    (tpc_codigo                     NUMBER(2) NOT NULL,
    tpc_descricao_tipo             VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPOS_CREDENCIADOS

ALTER TABLE tipos_credenciados
ADD CONSTRAINT tpc_pk PRIMARY KEY (tpc_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for TIPOS_CREDENCIADOS

COMMENT ON TABLE tipos_credenciados IS 'Tabela para receber os tipos de credenciados '
/
COMMENT ON COLUMN tipos_credenciados.tpc_codigo IS 'Código do tipo'
/
COMMENT ON COLUMN tipos_credenciados.tpc_descricao_tipo IS 'Nome da descrição do tipo'
/

-- End of DDL Script for Table IFRSRH.TIPOS_CREDENCIADOS

-- Start of DDL Script for Table IFRSRH.TIPOS_OCORRENCIAS
-- Generated 9/3/2004 19:21:42 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipos_ocorrencias
    (ofu_codigo                     NUMBER(4) NOT NULL,
    ofu_descricao                  VARCHAR2(60) NOT NULL,
    ofu_sigla                      VARCHAR2(10),
    ofu_indicador_tipo             NUMBER(2) NOT NULL,
    ofu_in_ocorrencia_paralela     VARCHAR2(1),
    ofu_indicador_prazo_maximo     NUMBER(3),
    ofu_indicador_sexo             VARCHAR2(1),
    ofu_indicador_aposentadoria    VARCHAR2(1),
    ofu_indicador_estabilidade     VARCHAR2(1),
    ofu_indicador_orgao            VARCHAR2(1),
    ofu_in_assist_medica_odont     VARCHAR2(1),
    ofu_indicador_vale_alimentacao VARCHAR2(1),
    ofu_indicador_vale_transporte  VARCHAR2(1),
    ofu_indicador_folha_pagamento  VARCHAR2(1),
    ofu_in_privativo_sistema       VARCHAR2(1),
    ofu_indicador_ferias           VARCHAR2(1),
    ofu_indicador_anuenio          VARCHAR2(1),
    ofu_indicador_licenca_premio   VARCHAR2(1),
    ofu_in_avaliacao_desempenho    VARCHAR2(1),
    ofu_ofu_codigo                 NUMBER(4),
    ofu_indicador_matricula        VARCHAR2(1),
    ofu_in_meses_indicador         NUMBER(3),
    ofu_in_meses_estabilidade      NUMBER(3),
    ofu_codigo_caged               NUMBER(2),
    ofu_indicador_onus             VARCHAR2(1),
    ofu_indicador_cargo_funcao     VARCHAR2(1),
    ofu_in_assist_odont            VARCHAR2(1),
    ofu_indicador_promocao         VARCHAR2(1),
    ofu_status                     NUMBER(1),
    ofu_codigo_caged_saida         NUMBER(2),
    ofu_indicador_frequencia       VARCHAR2(1),
    ofu_indicador_rct              VARCHAR2(1),
    ofu_indicador_demonstra_freq   VARCHAR2(1),
    ofu_ind_substituicao           VARCHAR2(1),
    ofu_in_afastamento_viagem      VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPOS_OCORRENCIAS

ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indicador_sexo_ck CHECK ( ofu_indicador_sexo IN ( 'M' , 'F' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_anuenio_ck CHECK ( ofu_indicador_anuenio IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_aposentadoria_ck CHECK ( ofu_indicador_aposentadoria IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_estabilidade_ck CHECK ( ofu_indicador_estabilidade IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_ferias_ck CHECK ( ofu_indicador_ferias IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_folha_pag_ck CHECK ( ofu_indicador_folha_pagamento IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_licenca_premio_ck CHECK ( ofu_indicador_licenca_premio IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_orgao_ck CHECK ( ofu_indicador_orgao IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_vale_alim_ck CHECK ( ofu_indicador_vale_alimentacao IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indic_vale_transp_ck CHECK ( ofu_indicador_vale_transporte IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_in_assist_med_odont_ck CHECK ( ofu_in_assist_medica_odont IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_in_aval_desemp_ck CHECK ( ofu_in_avaliacao_desempenho IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_in_ocor_paralela_ck CHECK ( ofu_in_ocorrencia_paralela IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_in_priv_sistema_ck CHECK ( ofu_in_privativo_sistema IN ( 'S' , 'N' )  )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_pk PRIMARY KEY (ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_status_ck CHECK ( OFU_STATUS IN (0,1)                                                              )
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_uk UNIQUE (ofu_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for TIPOS_OCORRENCIAS

CREATE TRIGGER trg_ofu_01
BEFORE UPDATE  OR  DELETE 
ON tipos_ocorrencias
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
   if updating then
      update controle_usuarios_ocorrencias
      set ofu_codigo = :new.ofu_codigo
      where ofu_codigo = :old.ofu_codigo;
   elsif deleting then
      delete controle_usuarios_ocorrencias
      where ofu_codigo = :old.ofu_codigo;
   end if;
end;
/
CREATE TRIGGER trg_ofu_02
BEFORE INSERT 
ON tipos_ocorrencias
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
   insert into controle_usuarios_ocorrencias
               (sgu_id_usuario,ofu_codigo)
          values(user, :new.ofu_codigo);
end;
/

-- Comments for TIPOS_OCORRENCIAS

COMMENT ON COLUMN tipos_ocorrencias.ofu_codigo IS 'Codigo identificador da ocorrencia funcional.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_codigo_caged IS 'CODIGO DE CONTROLE DO CAGED'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_codigo_caged_saida IS 'Indica o codigo de saida do CAGED PARA OCORRENCIA'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_descricao IS 'Descrição da ocorrência funcional'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_afastamento_viagem IS 'FLAG QUE INDICA SE A OCORRENCIA TEM OU NAO TRATAMENTO NO SISTEMA DE VIAGEM'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_assist_medica_odont IS 'Indica se a ocorrencia funcional incide na Assistencia Medica/Odo'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_assist_odont IS 'INDICA SE A OCORRÊNCIA INCIDE NA ASSISTÊNCIA ODONTOLÓGICA'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_avaliacao_desempenho IS 'Indica se ocorrencia func. incide na avaliac?o de desempenho do e'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_meses_estabilidade IS 'INDICA OS MESES DE ESTABILIDADE PROPORCIONADOS PELA OCORRÊNCIA'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_ocorrencia_paralela IS 'Caracteriza se a ocorrencia funcional pode acontecer em paralelo'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_in_privativo_sistema IS 'Indica se a ocorrencia funcional e privativa do sistema'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_anuenio IS 'Indica se ocorrencia func. incide no calculo do anuenio do empreg'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_aposentadoria IS 'Indica se ocorrencia func. incide no calculo do tempo de servico'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_cargo_funcao IS 'INDICA SE A OCORRÊNCIA INCIDE PARA NO CARGO E/OU FUNCAO'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_estabilidade IS 'Indica se ocorrencia funcional justifica a estabilidade de empreg'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_ferias IS 'Indica se ocorrencia func. incide no calculo das ferias do empreg'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_folha_pagamento IS 'Indica se a ocorrencia funcional incide na folha de pagamento'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_frequencia IS 'Indica que a ocorrencia tem tratamento para mod. frequencia'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_licenca_premio IS 'Indica se ocorrencia func. incide no calculo da licenca premio do'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_matricula IS 'Indica se a Ocor. Func. necessita que informe a matricula do empregado.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_onus IS 'INDICA SE A OCORRÊNCIA GERA ONUS PARA EMPRESA'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_orgao IS 'Indica se a ocorrencia funcional necessita que o org?o seja informado.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_prazo_maximo IS 'Indica qual o prazo maximo da ocorrencia funcional.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_promocao IS 'INDICA SE A OCORRÊNCIA INCIDE PARA PROMOÇÃO'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_sexo IS 'Indica sobre qual o sexo a ocorrencia funcional incide.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_tipo IS 'Caracteriza o tipo de ocorrencia funcional.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_vale_alimentacao IS 'Indica se a ocorrencia funcional incide no vale alimentac?o'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_indicador_vale_transporte IS 'Indica se a ocorrencia funcional incide no vale transporte'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_ofu_codigo IS 'Codigo identificador da ocorrencia funcional.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_sigla IS 'Sigla associada a ocorrencia funcional.'
/
COMMENT ON COLUMN tipos_ocorrencias.ofu_status IS 'INDICA O STATUS DO EMPREGADO SE NORMAL OU AFASTADO'
/

-- End of DDL Script for Table IFRSRH.TIPOS_OCORRENCIAS

-- Start of DDL Script for Table IFRSRH.TIPOS_OCORRENCIAS_RUBRICAS
-- Generated 9/3/2004 19:22:01 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipos_ocorrencias_rubricas
    (tor_ofu_codigo                 NUMBER(4) NOT NULL,
    tor_rub_codigo                 NUMBER(4) NOT NULL,
    tor_dat_inicio_vigencia        DATE NOT NULL,
    tor_dat_termino_vigencia       DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPOS_OCORRENCIAS_RUBRICAS

ALTER TABLE tipos_ocorrencias_rubricas
ADD CONSTRAINT tor_pk PRIMARY KEY (tor_ofu_codigo, tor_rub_codigo, 
  tor_dat_inicio_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TIPOS_OCORRENCIAS_RUBRICAS

-- Start of DDL Script for Table IFRSRH.TIPOS_VINCULOS_BENEFICIOS
-- Generated 9/3/2004 19:22:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tipos_vinculos_beneficios
    (ben_cod_vinculo                NUMBER(2) NOT NULL,
    ben_sigla_beneficio            VARCHAR2(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TIPOS_VINCULOS_BENEFICIOS

ALTER TABLE tipos_vinculos_beneficios
ADD CONSTRAINT ben_cod_vinculo_beneficio PRIMARY KEY (ben_cod_vinculo, 
  ben_sigla_beneficio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TIPOS_VINCULOS_BENEFICIOS

-- Start of DDL Script for Table IFRSRH.TMP_ABSENTEISMO
-- Generated 9/3/2004 19:22:17 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_absenteismo
    (usuario                        VARCHAR2(30),
    dep_lot_epoca                  VARCHAR2(10),
    dep_lot_atual                  VARCHAR2(10),
    dep_fis_atual                  VARCHAR2(10),
    matricula                      NUMBER(7),
    nome                           VARCHAR2(60),
    sexo                           VARCHAR2(1),
    ocorrencia                     NUMBER(4),
    "DESCRIÇÃO"                    VARCHAR2(50),
    data_inicio                    DATE,
    data_termino                   DATE,
    uor_epoca                      VARCHAR2(10),
    subord                         VARCHAR2(10),
    tipo_exp                       NUMBER(1),
    cid_codigo                     VARCHAR2(5),
    especificacao_cid              VARCHAR2(3),
    data_nascimento                DATE,
    nro_identidade                 VARCHAR2(15),
    data_expedicao_ci              DATE,
    ofu_codigo                     NUMBER(4),
    sigla_cargo_atual              VARCHAR2(10),
    descricao_ocupacao_atual       VARCHAR2(50),
    descricao_funcao_atual         VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_ABSENTEISMO

-- Start of DDL Script for Table IFRSRH.TMP_APROFOP
-- Generated 9/3/2004 19:22:18 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_aprofop
    (tmp_apfop_chave                VARCHAR2(20),
    dep_lotacao                    NUMBER(4),
    centro_custo                   NUMBER(10),
    deb_cred                       CHAR(1),
    conta                          VARCHAR2(20),
    empregado                      NUMBER(7),
    valor                          NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_APROFOP

-- Start of DDL Script for Table IFRSRH.TMP_APROFOPENC
-- Generated 9/3/2004 19:22:20 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_aprofopenc
    (tmp_apfopenc_chave             VARCHAR2(20),
    dependencia                    NUMBER(4),
    conta_contabil                 VARCHAR2(20),
    centro_custo                   NUMBER(10),
    empregado                      NUMBER(7),
    valor_empregado                NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_APROFOPENC

-- Start of DDL Script for Table IFRSRH.TMP_CADASTROS
-- Generated 9/3/2004 19:22:22 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_cadastros
    (tmp_numero_matricula           NUMBER(10),
    tmp_endereco_eletronico_mail   VARCHAR2(80),
    mat_exists                     VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_CADASTROS

-- Start of DDL Script for Table IFRSRH.TMP_CONCURSO_RDB
-- Generated 9/3/2004 19:22:23 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_concurso_rdb
    (tcr_matricula                  NUMBER(7) NOT NULL,
    tcr_data_edital                DATE,
    tcr_classificacao              NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TMP_CONCURSO_RDB

ALTER TABLE tmp_concurso_rdb
ADD CONSTRAINT tcr_pk PRIMARY KEY (tcr_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_CONCURSO_RDB

-- Start of DDL Script for Table IFRSRH.TMP_CONTABILIDADE_RELATORIOS
-- Generated 9/3/2004 19:22:30 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_contabilidade_relatorios
    (cod_oco                        NUMBER(4),
    dependencia                    NUMBER(4),
    empregado                      NUMBER(7),
    rubrica                        NUMBER(4),
    tipo_rubrica                   VARCHAR2(1),
    rub_descricao                  VARCHAR2(50),
    centro_custo                   NUMBER(10),
    deb_cred                       CHAR(1),
    conta_contabil                 VARCHAR2(20),
    valor                          NUMBER,
    nr_sequencia                   NUMBER)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TMP_CONTABILIDADE_RELATORIOS

CREATE INDEX oco_emp_idx ON tmp_contabilidade_relatorios
  (
    cod_oco                         ASC,
    empregado                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX dep_emp_idx ON tmp_contabilidade_relatorios
  (
    dependencia                     ASC,
    empregado                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.TMP_CONTABILIDADE_RELATORIOS

-- Start of DDL Script for Table IFRSRH.TMP_CONTRACHEQUE_EMP
-- Generated 9/3/2004 19:22:40 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_contracheque_emp
    (sequencia                      NUMBER NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    contador                       NUMBER(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TMP_CONTRACHEQUE_EMP

CREATE UNIQUE INDEX tmp_contracheque_emp_ind ON tmp_contracheque_emp
  (
    sequencia                       ASC,
    emp_numero_matricula            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for TMP_CONTRACHEQUE_EMP

ALTER TABLE tmp_contracheque_emp
ADD CONSTRAINT tmp_contracheque_emp_pk PRIMARY KEY (emp_numero_matricula, 
  sequencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_CONTRACHEQUE_EMP

-- Start of DDL Script for Table IFRSRH.TMP_DEMONSTRA_PA
-- Generated 9/3/2004 19:22:46 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_demonstra_pa
    (tmp_chave                      VARCHAR2(20) NOT NULL,
    ano                            NUMBER(4) NOT NULL,
    mes                            NUMBER(2) NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    dt_reintegracao                DATE,
    dt_inicio_pa                   DATE,
    dt_inicio_ferias               DATE,
    dt_termino_ferias              DATE,
    meses_pa                       NUMBER(3),
    meses_baixa                    NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_DEMONSTRA_PA

-- Start of DDL Script for Table IFRSRH.TMP_DEMONSTRATIVO_FREQUENCIA
-- Generated 9/3/2004 19:22:48 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_demonstrativo_frequencia
    (tdf_dep_codigo                 NUMBER(4) NOT NULL,
    tdf_dep_sigla                  VARCHAR2(10) NOT NULL,
    tdf_dep_nome                   VARCHAR2(60) NOT NULL,
    tdf_emp_numero_matricula       NUMBER(7) NOT NULL,
    tdf_emp_nome                   VARCHAR2(60) NOT NULL,
    tdf_dat_ocorrencia             DATE NOT NULL,
    tdf_ofu_codigo                 NUMBER(4) NOT NULL,
    tdf_ofu_descricao              VARCHAR2(50) NOT NULL,
    tdf_cod_horario_empregado      NUMBER(3),
    tdf_turno_trabalho_empregado   VARCHAR2(1),
    tdf_primeiro_expediente        VARCHAR2(1),
    tdf_segundo_expediente         VARCHAR2(1),
    tdf_terceiro_expediente        VARCHAR2(1),
    tdf_mov_parametro              NUMBER(11,3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TMP_DEMONSTRATIVO_FREQUENCIA

ALTER TABLE tmp_demonstrativo_frequencia
ADD CONSTRAINT tdf_pk PRIMARY KEY (tdf_dep_codigo, tdf_emp_numero_matricula, 
  tdf_dat_ocorrencia, tdf_ofu_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_DEMONSTRATIVO_FREQUENCIA

-- Start of DDL Script for Table IFRSRH.TMP_DEPENDENCIA_EMPREGADO
-- Generated 9/3/2004 19:22:55 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_dependencia_empregado
    (tde_emp_numero_matricula       NUMBER(7) NOT NULL,
    tde_ano_referencia             NUMBER(4) NOT NULL,
    tde_mes_referencia             NUMBER(2) NOT NULL,
    tde_dep_codigo                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TMP_DEPENDENCIA_EMPREGADO

ALTER TABLE tmp_dependencia_empregado
ADD CONSTRAINT tde_pk PRIMARY KEY (tde_emp_numero_matricula, tde_ano_referencia, 
  tde_mes_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_DEPENDENCIA_EMPREGADO

-- Start of DDL Script for Table IFRSRH.TMP_DIVERSOS_MEDICAS_HOSPIT
-- Generated 9/3/2004 19:23:02 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_diversos_medicas_hospit
    (tmp_dmo_sequencial_unimed      NUMBER(7),
    tmp_dmo_gui_doc_numero_unimed  NUMBER(10),
    tmp_dmo_gui_doc_cbe_cre_seq    NUMBER(5),
    tmp_dmo_gui_doc_dep_codigo     NUMBER(4),
    tmp_dmo_gui_numero_unimed      NUMBER(6),
    tmp_dmo_descricao              VARCHAR2(2000),
    tmp_dmo_valor                  NUMBER(12,2),
    tmp_dmh_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_DIVERSOS_MEDICAS_HOSPIT

COMMENT ON COLUMN tmp_diversos_medicas_hospit.tmp_dmh_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_DIVERSOS_MEDICAS_HOSPIT

-- Start of DDL Script for Table IFRSRH.TMP_DOCUMENTOS_COBRANCA
-- Generated 9/3/2004 19:23:03 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_documentos_cobranca
    (tmp_doc_numero_unimed          NUMBER(10),
    tmp_doc_cbe_cre_sequencial     NUMBER(5),
    tmp_doc_dep_codigo             NUMBER(4),
    tmp_doc_data                   DATE,
    tmp_doc_data_pagamento         DATE,
    tmp_doc_valor                  NUMBER(12,2),
    tmp_doc_tipo                   NUMBER(1),
    tmp_doc_nr_doc_fiscal          VARCHAR2(15),
    tmp_doc_guias_emp              NUMBER(8),
    tmp_doc_interface_ps_mes       NUMBER(2),
    tmp_doc_interface_ps_ano       NUMBER(4),
    tmp_doc_interface_ps_seq       NUMBER(10),
    tmp_doc_interface_rotina       NUMBER(2),
    tmp_doc_interface_valida       VARCHAR2(3),
    tmp_doc_indentificacao         VARCHAR2(10),
    tmp_doc_numero_infraero        NUMBER(11),
    tmp_doc_guias_emp_total        NUMBER(8),
    tmp_gpr_valor_total            NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_DOCUMENTOS_COBRANCA

-- Start of DDL Script for Table IFRSRH.TMP_EMPREGADOS
-- Generated 9/3/2004 19:23:05 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_empregados
    (sequencia                      NUMBER NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    contador                       NUMBER(10),
    cd_dep_codigo                  NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.TMP_FOLHA_EMPREGADOS
-- Generated 9/3/2004 19:23:07 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_folha_empregados
    (sequencia                      NUMBER NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL,
    contador                       NUMBER(10),
    data_frequencia                DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_FOLHA_EMPREGADOS

COMMENT ON COLUMN tmp_folha_empregados.data_frequencia IS 'Data que corresponde a frequência.'
/

-- End of DDL Script for Table IFRSRH.TMP_FOLHA_EMPREGADOS

-- Start of DDL Script for Table IFRSRH.TMP_GUIAS
-- Generated 9/3/2004 19:23:08 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_guias
    (tmp_gui_doc_numero_unimed      NUMBER(10),
    tmp_gui_doc_cbe_cre_seq        NUMBER(5),
    tmp_gui_doc_dep_codigo         NUMBER(4),
    tmp_gui_numero_unimed          NUMBER(10),
    tmp_gui_data                   DATE,
    tmp_gui_emp_numero_matricula   NUMBER(7),
    tmp_gui_pvi_sequencial         NUMBER(2),
    tmp_gui_tipo_exame             NUMBER(1),
    tmp_lote_unimed                NUMBER(10),
    tmp_nota_unimed                NUMBER(10),
    tmp_gui_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_GUIAS

COMMENT ON COLUMN tmp_guias.tmp_gui_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_GUIAS

-- Start of DDL Script for Table IFRSRH.TMP_GUIAS_MANUT
-- Generated 9/3/2004 19:23:09 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_guias_manut
    (tmp_gui_doc_numero_unimed      NUMBER(10),
    tmp_gui_doc_cbe_cre_seq        NUMBER(5),
    tmp_gui_doc_dep_codigo         NUMBER(4),
    tmp_gui_numero_unimed          NUMBER(10),
    tmp_gui_data                   DATE,
    tmp_gui_emp_numero_matricula   NUMBER(7),
    tmp_gui_pvi_sequencial         NUMBER(2),
    tmp_gui_tipo_exame             NUMBER(1),
    tmp_lote_unimed                NUMBER,
    tmp_nota_unimed                NUMBER,
    tmp_gui_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_GUIAS_MANUT

-- Start of DDL Script for Table IFRSRH.TMP_GUIAS_PROCEDIMENTOS
-- Generated 9/3/2004 19:23:10 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_guias_procedimentos
    (tmp_gpr_gui_doc_numero_unimed  NUMBER(6),
    tmp_gpr_gui_doc_cbe_cre_seq    NUMBER(5),
    tmp_gpr_gui_doc_dep_codigo     NUMBER(4),
    tmp_gpr_gui_numero_unimed      NUMBER(6),
    tmp_gpr_sequencial_unimed      NUMBER(7),
    tmp_gpr_amb_codigo             NUMBER(7),
    tmp_gpr_amb_dv                 NUMBER(1),
    tmp_gpr_valor                  NUMBER(12,2),
    tmp_gpr_trinta                 VARCHAR2(1),
    tmp_gpr_qtd                    NUMBER(2),
    tmp_gpr_tipo_acomodacao        VARCHAR2(1),
    tmp_gpr_valor_calculado        NUMBER(12,2),
    tmp_gpr_valor_taxa             NUMBER(12,2),
    tmp_gpr_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_GUIAS_PROCEDIMENTOS

COMMENT ON COLUMN tmp_guias_procedimentos.tmp_gpr_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_GUIAS_PROCEDIMENTOS

-- Start of DDL Script for Table IFRSRH.TMP_HONORARIOS_MEDICOS
-- Generated 9/3/2004 19:23:12 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_honorarios_medicos
    (tmp_hnm_sequencial_unimed      NUMBER(7),
    tmp_hnm_gpr_gui_doc_nro_uni    NUMBER(10),
    tmp_hnm_gpr_gui_doc_cre_seq    NUMBER(5),
    tmp_hnm_gpr_gui_doc_dep_codigo NUMBER(4),
    tmp_hnm_gpr_gui_numero_unimed  NUMBER(10),
    tmp_hnm_gpr_sequencial_unimed  NUMBER(7),
    tmp_hnm_tipo_acomodacao        VARCHAR2(1),
    tmp_hnm_honor_valor_informado  NUMBER(12,2),
    tmp_hnm_aux1_valor_informado   NUMBER(12,2),
    tmp_hnm_aux2_valor_informado   NUMBER(12,2),
    tmp_hnm_aux3_valor_informado   NUMBER(12,2),
    tmp_hnm_anest_valor_informado  NUMBER(12,2),
    tmp_hnm_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_HONORARIOS_MEDICOS

COMMENT ON COLUMN tmp_honorarios_medicos.tmp_hnm_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_HONORARIOS_MEDICOS

-- Start of DDL Script for Table IFRSRH.TMP_INTERNACAO
-- Generated 9/3/2004 19:23:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_internacao
    (tmp_int_gui_doc_numero_unimed  NUMBER(10),
    tmp_int_gui_doc_cbe_cre_seq    NUMBER(5),
    tmp_int_gui_doc_dep_codigo     NUMBER(4),
    tmp_int_gui_numero_unimed      NUMBER(6),
    tmp_int_sequencial_unimed      NUMBER(7),
    tmp_int_amb_codigo             NUMBER(7),
    tmp_int_amb_dv                 NUMBER(1),
    tmp_int_data_internacao        DATE,
    tmp_int_data_alta              DATE,
    tmp_int_ind_obito              VARCHAR2(1),
    tmp_int_recem_nascido          NUMBER(1),
    tmp_int_ind_ambulatorio        VARCHAR2(1),
    tmp_int_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_INTERNACAO

COMMENT ON COLUMN tmp_internacao.tmp_int_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_INTERNACAO

-- Start of DDL Script for Table IFRSRH.TMP_OCO_FREQUENCIA_EMP
-- Generated 9/3/2004 19:23:15 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_oco_frequencia_emp
    (tmp_emp_numero_matricula       NUMBER(7) NOT NULL,
    tmp_oem_ofu_codigo             NUMBER(4) NOT NULL,
    tmp_oem_data_inicio            DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for TMP_OCO_FREQUENCIA_EMP

CREATE INDEX idx_tmp_oco_freq ON tmp_oco_frequencia_emp
  (
    tmp_emp_numero_matricula        ASC,
    tmp_oem_ofu_codigo              ASC,
    tmp_oem_data_inicio             ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.TMP_OCO_FREQUENCIA_EMP

-- Start of DDL Script for Table IFRSRH.TMP_PROVISIONAMENTO
-- Generated 9/3/2004 19:23:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_provisionamento
    (tmp_chave_prov                 VARCHAR2(20) NOT NULL,
    ano                            NUMBER(4) NOT NULL,
    mes                            NUMBER(2) NOT NULL,
    seq                            NUMBER(2) NOT NULL,
    dep_codigo                     NUMBER(4) NOT NULL,
    custo                          NUMBER(6) NOT NULL,
    conta                          VARCHAR2(9) NOT NULL,
    matricula                      NUMBER(7) NOT NULL,
    tipo_prov                      NUMBER(1) NOT NULL,
    dt_inicio_pa                   DATE,
    dt_inicio_ferias               DATE,
    dt_termino_ferias              DATE,
    meses_pa                       NUMBER(2),
    meses_baixa                    NUMBER(2),
    meses_provisao                 NUMBER(2),
    remuneracao_atual              NUMBER(14,2),
    remuneracao_anterior           NUMBER(14,2),
    provisao_atual                 NUMBER(14,2),
    provisao_anterior              NUMBER(14,2),
    encargos_atual                 NUMBER(14,2),
    encargos_anterior              NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for TMP_PROVISIONAMENTO

ALTER TABLE tmp_provisionamento
ADD CONSTRAINT tmp_provisionamento_pk PRIMARY KEY (tmp_chave_prov, ano, mes, seq, 
  dep_codigo, custo, conta, matricula, tipo_prov)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_PROVISIONAMENTO

-- Start of DDL Script for Table IFRSRH.TMP_SALARIOS_CONTRIBUICOES
-- Generated 9/3/2004 19:23:27 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_salarios_contribuicoes
    (sequencia                      NUMBER(7) NOT NULL,
    data                           DATE NOT NULL,
    emp_numero_matricula           NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_SALARIOS_CONTRIBUICOES

COMMENT ON TABLE tmp_salarios_contribuicoes IS 'Gestorh - modulo de folha de pagamento'
/

-- End of DDL Script for Table IFRSRH.TMP_SALARIOS_CONTRIBUICOES

-- Start of DDL Script for Table IFRSRH.TMP_TAB_DESPESA_MEDICAMENTOS
-- Generated 9/3/2004 19:23:29 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_tab_despesa_medicamentos
    (tmp_tdm_sequencial_unimed      NUMBER(7),
    tmp_tdm_gui_doc_numero_unimed  NUMBER(10),
    tmp_tdm_gui_doc_cbe_cre_seq    NUMBER(5),
    tmp_tdm_gui_numero_unimed      NUMBER(6),
    tmp_tdm_descricao              VARCHAR2(250),
    tmp_tdm_valor                  NUMBER(12,2),
    tmp_tdm_gui_doc_dep_codigo     NUMBER(4),
    tmp_tdm_nr_doc_fiscal          VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_TAB_DESPESA_MEDICAMENTOS

COMMENT ON COLUMN tmp_tab_despesa_medicamentos.tmp_tdm_nr_doc_fiscal IS 'RECEBE O NUMERO DO DOCUMENTO FISCAL'
/

-- End of DDL Script for Table IFRSRH.TMP_TAB_DESPESA_MEDICAMENTOS

-- Start of DDL Script for Table IFRSRH.TMP_VALOR_INCENTIVO
-- Generated 9/3/2004 19:23:30 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_valor_incentivo
    (cod_regional                   NUMBER(8),
    nome_dependencia               VARCHAR2(255),
    sigla                          VARCHAR2(4),
    matricula                      NUMBER(8) NOT NULL,
    nome                           VARCHAR2(255),
    sigla_lota                     VARCHAR2(10),
    descr_lota                     VARCHAR2(30),
    descr_ocupacao_atuacao         VARCHAR2(255),
    sigla_cargo                    VARCHAR2(255),
    tipo_grati                     VARCHAR2(255),
    descr_funcao                   VARCHAR2(255),
    data_admis                     DATE,
    anos_inc                       NUMBER(8),
    anos                           NUMBER(4),
    meses                          NUMBER(4),
    dias                           NUMBER(4),
    remuneracao                    NUMBER(10,2),
    incentivo                      NUMBER(10,2),
    rct_bruta                      NUMBER(10,2),
    vale_alimen                    NUMBER(6,2),
    seg_vida                       NUMBER(10,2),
    total_fgts                     NUMBER(10,2),
    aposentado                     NUMBER(4),
    data_anotacao                  DATE,
    data_inscricao                 DATE,
    data_deferimento               DATE,
    ind_deferimento                VARCHAR2(1),
    doc_cadastro_reserva           VARCHAR2(600),
    ind_cadastro_reserva           VARCHAR2(1),
    saldo                          NUMBER(10,2),
    classificacao_cad_reserva      NUMBER(4),
    nr_edital_cad_reserva          VARCHAR2(15),
    data_edital_cad_reserva        DATE,
    data_dou_cad_reserva           DATE,
    cargo_cad_reserva              VARCHAR2(115),
    classificacao_cad_reserva2     NUMBER(4),
    nr_edital_cad_reserva2         VARCHAR2(15),
    data_edital_cad_reserva2       DATE,
    cargo_cad_reserva2             VARCHAR2(115),
    classificacao_cad_reserva3     NUMBER(4),
    nr_edital_cad_reserva3         VARCHAR2(15),
    data_edital_cad_reserva3       DATE,
    cargo_cad_reserva3             VARCHAR2(115),
    data_desistencia               DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TMP_VALOR_INCENTIVO

-- Start of DDL Script for Table IFRSRH.TMP_VIAGEM
-- Generated 9/3/2004 19:23:33 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE tmp_viagem
    (usuario                        VARCHAR2(30),
    dep_lot_epoca                  VARCHAR2(10),
    dep_lot_atual                  VARCHAR2(10),
    matricula                      NUMBER(7),
    nome                           VARCHAR2(60),
    sexo                           VARCHAR2(1),
    ocorrencia                     NUMBER(4),
    descricao                      VARCHAR2(50),
    data_inicio                    DATE,
    data_termino                   DATE,
    uor_epoca                      VARCHAR2(10),
    uor_subord_epoca               VARCHAR2(10),
    ofu_codigo                     NUMBER(4),
    sigla_cargo_atual              VARCHAR2(10),
    descricao_ocupacao_atual       VARCHAR2(50),
    sigla_cargo_epoca              VARCHAR2(10),
    descricao_ocupacao_epoca       VARCHAR2(50),
    descricao_funcao_atual         VARCHAR2(30),
    codigo_funcao_epoca            NUMBER(3),
    descricao_funcao_epoca         VARCHAR2(30),
    texto                          VARCHAR2(200),
    valor_passagem                 NUMBER(11,3),
    valor_diaria                   NUMBER(11,3),
    cod_dep_lot_epoca              NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for TMP_VIAGEM

COMMENT ON COLUMN tmp_viagem.cod_dep_lot_epoca IS 'Codigo da dependência de lotação da época'
/
COMMENT ON COLUMN tmp_viagem.codigo_funcao_epoca IS 'codigo da funcao da epoca'
/
COMMENT ON COLUMN tmp_viagem.data_inicio IS 'data de inicio da ocorrencia'
/
COMMENT ON COLUMN tmp_viagem.data_termino IS 'data de termino da ocorrencia'
/
COMMENT ON COLUMN tmp_viagem.dep_lot_atual IS 'dependencia de lotacap atual'
/
COMMENT ON COLUMN tmp_viagem.dep_lot_epoca IS 'dependencia de lotacao da epoca'
/
COMMENT ON COLUMN tmp_viagem.descricao IS 'descricao da ocorrencia'
/
COMMENT ON COLUMN tmp_viagem.descricao_funcao_atual IS 'descricao da funcao atual'
/
COMMENT ON COLUMN tmp_viagem.descricao_funcao_epoca IS 'descricao funcao da epoca'
/
COMMENT ON COLUMN tmp_viagem.descricao_ocupacao_atual IS 'descricao da ocupacao atual'
/
COMMENT ON COLUMN tmp_viagem.descricao_ocupacao_epoca IS 'descricao da ocupacao da epoca'
/
COMMENT ON COLUMN tmp_viagem.matricula IS 'numero de matricula'
/
COMMENT ON COLUMN tmp_viagem.nome IS 'nome do empregado'
/
COMMENT ON COLUMN tmp_viagem.ocorrencia IS 'numero da ocorrencia'
/
COMMENT ON COLUMN tmp_viagem.ofu_codigo IS 'codigo da ocorrencia funcional'
/
COMMENT ON COLUMN tmp_viagem.sexo IS 'sexo do empregado'
/
COMMENT ON COLUMN tmp_viagem.sigla_cargo_atual IS 'sigla do cargo atual'
/
COMMENT ON COLUMN tmp_viagem.sigla_cargo_epoca IS 'sigla do cargo da epoca'
/
COMMENT ON COLUMN tmp_viagem.texto IS 'descrição do motivo da viagem'
/
COMMENT ON COLUMN tmp_viagem.uor_epoca IS 'UOR da epoca'
/
COMMENT ON COLUMN tmp_viagem.uor_subord_epoca IS 'UOR subordinada da epoca'
/
COMMENT ON COLUMN tmp_viagem.usuario IS 'usuario que insere o registro'
/
COMMENT ON COLUMN tmp_viagem.valor_diaria IS 'valor da diaria da viagem'
/
COMMENT ON COLUMN tmp_viagem.valor_passagem IS 'preço da passagem da viagem'
/

-- End of DDL Script for Table IFRSRH.TMP_VIAGEM

-- Start of DDL Script for Table IFRSRH.TRACE_MOVIMENTACAO
-- Generated 9/3/2004 19:23:34 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE trace_movimentacao
    (timestamp                      DATE,
    sql_undo                       VARCHAR2(4000),
    sql_redo                       VARCHAR2(4000),
    row_id                         VARCHAR2(19),
    table_space                    VARCHAR2(32),
    seg_owner                      VARCHAR2(32),
    seg_name                       VARCHAR2(32),
    seg_type_name                  VARCHAR2(32),
    session#                       NUMBER,
    serial#                        NUMBER,
    username                       VARCHAR2(32),
    operation                      VARCHAR2(32),
    info                           VARCHAR2(32),
    status                         NUMBER,
    host                           VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.TRACE_MOVIMENTACAO

-- Start of DDL Script for Table IFRSRH.UOR_FONE_FAX
-- Generated 9/3/2004 19:23:36 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE uor_fone_fax
    (uff_uor_codigo                 NUMBER(9) NOT NULL,
    uff_tipo                       NUMBER(1) NOT NULL,
    uff_numero                     NUMBER(8) NOT NULL,
    uff_voip_ddd                   NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for UOR_FONE_FAX

ALTER TABLE uor_fone_fax
ADD CONSTRAINT uff_ck CHECK ( uff_tipo in (1,2,3) )
/
ALTER TABLE uor_fone_fax
ADD CONSTRAINT uff_pk PRIMARY KEY (uff_uor_codigo, uff_tipo, uff_numero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for UOR_FONE_FAX

COMMENT ON COLUMN uor_fone_fax.uff_numero IS 'Número do fone FAX.'
/
COMMENT ON COLUMN uor_fone_fax.uff_tipo IS 'Tipo do Fax. (1 - Fone Direto, 2 - Fone Ramal ou 3 - FAX.'
/
COMMENT ON COLUMN uor_fone_fax.uff_uor_codigo IS 'Número da UOR relacionada.'
/
COMMENT ON COLUMN uor_fone_fax.uff_voip_ddd IS 'Número do DDD do fone FAX.'
/

-- End of DDL Script for Table IFRSRH.UOR_FONE_FAX

-- Start of DDL Script for Table IFRSRH.USUARIOS_LINHAS_TRANSPORTES
-- Generated 9/3/2004 19:23:43 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE usuarios_linhas_transportes
    (ult_emb_emp_numero_matricula   NUMBER(7) NOT NULL,
    ult_emb_ben_sigla              VARCHAR2(3) NOT NULL,
    ult_ltf_numero                 NUMBER(5) NOT NULL,
    ult_ltf_dep_codigo             NUMBER(5) NOT NULL,
    ult_data_inclusao              DATE NOT NULL,
    ult_data_exclusao              DATE,
    ult_dep_resp_incl              NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for USUARIOS_LINHAS_TRANSPORTES

ALTER TABLE usuarios_linhas_transportes
ADD CONSTRAINT ult_pk PRIMARY KEY (ult_emb_emp_numero_matricula, 
  ult_emb_ben_sigla, ult_ltf_numero, ult_ltf_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.USUARIOS_LINHAS_TRANSPORTES

-- Start of DDL Script for Table IFRSRH.USUARIOS_PLANOS_SAUDE
-- Generated 9/3/2004 19:23:51 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE usuarios_planos_saude
    (ups_cre_sequencial             NUMBER(5) NOT NULL,
    ups_emp_numero_matricula       NUMBER(7) NOT NULL,
    ups_cod_usuario                NUMBER(8) NOT NULL,
    ups_data_inicio                DATE NOT NULL,
    ups_data_termino               DATE,
    ups_dep_codigo                 NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for USUARIOS_PLANOS_SAUDE

ALTER TABLE usuarios_planos_saude
ADD CONSTRAINT ups_pk PRIMARY KEY (ups_cre_sequencial, ups_emp_numero_matricula, 
  ups_cod_usuario, ups_data_inicio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for USUARIOS_PLANOS_SAUDE

COMMENT ON COLUMN usuarios_planos_saude.ups_cod_usuario IS 'CÓDIGO IDENTIFICADOR DO USUÁRIO TITULAR DO PLANO DE SAÚDE COMPÕE CHAVE TABELA'
/
COMMENT ON COLUMN usuarios_planos_saude.ups_cre_sequencial IS 'CÓDIGO IDENTIFICADOR DO CREDENCIADOS CHAVE TABELA CREDENCIADOS'
/
COMMENT ON COLUMN usuarios_planos_saude.ups_data_inicio IS 'DATA DA CRIAÇÃO DO REGISTRO. INÍCIO DO BENEFÍCIO UTILIZAÇÃO DO PLANO DE SAÚDE'
/
COMMENT ON COLUMN usuarios_planos_saude.ups_data_termino IS 'DATA TÉRMINO DO BENEFÍCIO UTILIZAÇÃO DO PLANO DE SAÚDE'
/
COMMENT ON COLUMN usuarios_planos_saude.ups_dep_codigo IS 'DEPENDENCIA FISICA DO EMPREGADO'
/
COMMENT ON COLUMN usuarios_planos_saude.ups_emp_numero_matricula IS 'MATRÍCULA ATRIBUÍDA AO EMPREGADO CHAVE TABELA CADASTROS'
/

-- End of DDL Script for Table IFRSRH.USUARIOS_PLANOS_SAUDE

-- Start of DDL Script for Table IFRSRH.VALOR_INCENTIVO
-- Generated 9/3/2004 19:23:58 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE valor_incentivo
    (cod_regional                   NUMBER(8),
    nome_dependencia               VARCHAR2(255),
    sigla                          VARCHAR2(4),
    matricula                      NUMBER(8) NOT NULL,
    nome                           VARCHAR2(255),
    sigla_lota                     VARCHAR2(10),
    descr_lota                     VARCHAR2(30),
    descr_ocupacao_atuacao         VARCHAR2(255),
    sigla_cargo                    VARCHAR2(255),
    tipo_grati                     VARCHAR2(255),
    descr_funcao                   VARCHAR2(255),
    data_admis                     DATE,
    anos_inc                       NUMBER(8),
    anos                           NUMBER(4),
    meses                          NUMBER(4),
    dias                           NUMBER(4),
    remuneracao                    NUMBER(10,2),
    incentivo                      NUMBER(10,2),
    rct_bruta                      NUMBER(10,2),
    vale_alimen                    NUMBER(6,2),
    seg_vida                       NUMBER(10,2),
    total_fgts                     NUMBER(10,2),
    aposentado                     NUMBER(4),
    data_anotacao                  DATE,
    data_inscricao                 DATE,
    data_deferimento               DATE,
    ind_deferimento                VARCHAR2(1),
    doc_cadastro_reserva           VARCHAR2(600),
    ind_cadastro_reserva           VARCHAR2(1),
    saldo                          NUMBER(10,2),
    classificacao_cad_reserva      NUMBER(4),
    nr_edital_cad_reserva          VARCHAR2(15),
    data_edital_cad_reserva        DATE,
    data_dou_cad_reserva           DATE,
    cargo_cad_reserva              VARCHAR2(115),
    classificacao_cad_reserva2     NUMBER(4),
    nr_edital_cad_reserva2         VARCHAR2(15),
    data_edital_cad_reserva2       DATE,
    cargo_cad_reserva2             VARCHAR2(115),
    classificacao_cad_reserva3     NUMBER(4),
    nr_edital_cad_reserva3         VARCHAR2(15),
    data_edital_cad_reserva3       DATE,
    cargo_cad_reserva3             VARCHAR2(115),
    data_desistencia               DATE,
    dep_do_desligamento            NUMBER(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for VALOR_INCENTIVO

ALTER TABLE valor_incentivo
ADD CONSTRAINT ind_cadastro_reserva_ck CHECK (IND_CADASTRO_RESERVA IN ('S','N'))
/
ALTER TABLE valor_incentivo
ADD CONSTRAINT ind_deferimento_ck CHECK (IND_DEFERIMENTO IN ('D','I'))
/
ALTER TABLE valor_incentivo
ADD CONSTRAINT vli_pk PRIMARY KEY (matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for VALOR_INCENTIVO

COMMENT ON COLUMN valor_incentivo.data_deferimento IS 'Data do deferimento ou indeferimento da inscrição do empregado no PDIN.'
/
COMMENT ON COLUMN valor_incentivo.data_inscricao IS 'Data da inscrição do empregado no PDIN.'
/
COMMENT ON COLUMN valor_incentivo.doc_cadastro_reserva IS 'Texto contendo as informações encontradas no cadastro de reserva.'
/
COMMENT ON COLUMN valor_incentivo.ind_cadastro_reserva IS 'Campo que indica se o empregado se encontra "S" ou não "N" no cadastro de reserva da INFRAERO.'
/
COMMENT ON COLUMN valor_incentivo.ind_deferimento IS 'Campo que indica se a inscrição foi deferida "D" ou indeferida "I".'
/

-- End of DDL Script for Table IFRSRH.VALOR_INCENTIVO

-- Start of DDL Script for Table IFRSRH.VALORES_AUTORIZADOS
-- Generated 9/3/2004 19:24:04 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE valores_autorizados
    (vau_enq_numero                 NUMBER(6) NOT NULL,
    vau_amb_codigo                 NUMBER(7),
    vau_amb_dv                     NUMBER(1),
    vau_descricao                  VARCHAR2(250) NOT NULL,
    vau_valor                      NUMBER(8,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for VALORES_AUTORIZADOS

CREATE INDEX vau_amb_fk_i ON valores_autorizados
  (
    vau_amb_codigo                  ASC,
    vau_amb_dv                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX vau_enq_fk_i ON valores_autorizados
  (
    vau_enq_numero                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRSRH.VALORES_AUTORIZADOS

-- Start of DDL Script for Table IFRSRH.VALORES_DIARIA
-- Generated 9/3/2004 19:24:14 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE valores_diaria
    (vld_codigo                     NUMBER(2) NOT NULL,
    vld_data_vigencia              DATE NOT NULL,
    vld_diaria                     NUMBER(9,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for VALORES_DIARIA

ALTER TABLE valores_diaria
ADD CONSTRAINT vld_pk PRIMARY KEY (vld_codigo, vld_data_vigencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.VALORES_DIARIA

-- Start of DDL Script for Table IFRSRH.VERSAO_OBJETOS
-- Generated 9/3/2004 19:24:21 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE versao_objetos
    (ver_cd_sistema                 NUMBER(2) NOT NULL,
    ver_objeto                     VARCHAR2(30) NOT NULL,
    ver_data_hora                  VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for VERSAO_OBJETOS

ALTER TABLE versao_objetos
ADD CONSTRAINT vo_pk PRIMARY KEY (ver_cd_sistema, ver_objeto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.VERSAO_OBJETOS

-- Start of DDL Script for Table IFRSRH.VINCULADO_UNIVERSITARIOS
-- Generated 9/3/2004 19:24:28 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE vinculado_universitarios
    (viu_pvi_sequencial             NUMBER(2) NOT NULL,
    viu_pvi_emp_numero_matricula   NUMBER(7) NOT NULL,
    viu_data_entrega_declaracao    DATE NOT NULL,
    viu_cgc_universidade           NUMBER(14),
    viu_universidade_nome          VARCHAR2(80) NOT NULL,
    viu_semestre                   VARCHAR2(8) NOT NULL,
    viu_ano_referencia             NUMBER(4) NOT NULL,
    viu_dep_resp_incl              NUMBER(4) NOT NULL,
    viu_tipo_ensino                NUMBER(2),
    viu_freq_pri_sem               VARCHAR2(1),
    viu_freq_seg_sem               VARCHAR2(1),
    viu_tipo_curso                 VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for VINCULADO_UNIVERSITARIOS

ALTER TABLE vinculado_universitarios
ADD CONSTRAINT viu_ck_1 CHECK ( viu_semestre in ('PRIMEIRO','SEGUNDO')                                           )
/
ALTER TABLE vinculado_universitarios
ADD CONSTRAINT viu_matricula_sequencial_pk PRIMARY KEY (
  viu_data_entrega_declaracao, viu_pvi_emp_numero_matricula, viu_pvi_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for VINCULADO_UNIVERSITARIOS

COMMENT ON COLUMN vinculado_universitarios.viu_freq_pri_sem IS 'Indicador de frequencia no primeiro semestre do curso'
/
COMMENT ON COLUMN vinculado_universitarios.viu_freq_seg_sem IS 'Indicador de frequencia no segundo semestre do curso'
/
COMMENT ON COLUMN vinculado_universitarios.viu_tipo_curso IS 'Identificador do tipo de curso. Valores possíveis: A - Anual; S - Semestral'
/
COMMENT ON COLUMN vinculado_universitarios.viu_tipo_ensino IS 'Tipo de Ensino. Valores Possíveis:1 - Ensino Superior; 2 - Ensino Médio; 3 - Ensino Fundamental'
/

-- End of DDL Script for Table IFRSRH.VINCULADO_UNIVERSITARIOS

-- Start of DDL Script for Table IFRSRH.VINCULO_PRESTADORA
-- Generated 9/3/2004 19:24:36 from SYSMAN@MAQUINA4.WORLD

CREATE TABLE vinculo_prestadora
    (vip_cre_sequencial             NUMBER(5) NOT NULL,
    vip_cod_vinculo                NUMBER(2) NOT NULL,
    vip_cod_descricao              VARCHAR2(60))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for VINCULO_PRESTADORA

ALTER TABLE vinculo_prestadora
ADD CONSTRAINT vip_pk PRIMARY KEY (vip_cre_sequencial, vip_cod_vinculo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRSRH.VINCULO_PRESTADORA

-- Foreign Key
ALTER TABLE abatimento_averbacao
ADD CONSTRAINT abt_avb_fk FOREIGN KEY (abt_avb_codigo, 
  abt_avb_emp_numero_matricula)
REFERENCES averbacao_tservico (avb_codigo,avb_emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE abo
ADD CONSTRAINT abo_esp_tipo_fk FOREIGN KEY (esp_tipo, abo_esp_numero)
REFERENCES especialidades (esp_tipo,esp_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE abo_local
ADD CONSTRAINT abl_cre_sequencial_fk FOREIGN KEY (abl_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE abo_local
ADD CONSTRAINT abl_dep_codigo_fk FOREIGN KEY (abl_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE agendas_medicas
ADD CONSTRAINT agm_cde_fk FOREIGN KEY (agm_cde_cre_sequencial, agm_cde_esp_tipo, 
  agm_cde_esp_numero)
REFERENCES credenciados_especialidades (cde_cre_sequencial,cde_esp_tipo,cde_esp_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE amb
ADD CONSTRAINT amb_esp_tipo_fk FOREIGN KEY (amb_esp_tipo, amb_esp_numero)
REFERENCES especialidades (esp_tipo,esp_numero) ON DELETE SET NULL
/
ALTER TABLE amb
ADD CONSTRAINT porte_anestesico_fk FOREIGN KEY (amb_porte)
REFERENCES portes_anestesicos (porte) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE amb_local
ADD CONSTRAINT aml_cre_sequencial_fk FOREIGN KEY (aml_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE amb_local
ADD CONSTRAINT aml_porte_fk FOREIGN KEY (aml_porte_anestesico)
REFERENCES portes_anestesicos (porte) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE aprofop
ADD CONSTRAINT dep_lotacao_fk FOREIGN KEY (dep_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE aprofop
ADD CONSTRAINT empregado_fk FOREIGN KEY (empregado)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE aprofopenc
ADD CONSTRAINT aprofopenc1_fk FOREIGN KEY (empregado)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE aprofopenc
ADD CONSTRAINT aprofopenc_fk FOREIGN KEY (dependencia)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE aprovador_viagem
ADD CONSTRAINT avi_emp_fk FOREIGN KEY (avi_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE aprovador_viagem
ADD CONSTRAINT avi_emp_resp_fk FOREIGN KEY (avi_emp_numero_matricula_resp)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE aprovador_viagem
ADD CONSTRAINT avi_uor_fk FOREIGN KEY (avi_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
ALTER TABLE aprovador_viagem
ADD CONSTRAINT avi_uor_resp_fk FOREIGN KEY (avi_uor_codigo_resp)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE aprovador_viagem_tipo
ADD CONSTRAINT apv_apvt_fk FOREIGN KEY (avi_uor_codigo, avi_data_inicio, 
  avi_emp_numero_matricula)
REFERENCES aprovador_viagem (avi_uor_codigo,avi_data_inicio,avi_emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE areas_atuacao_cargo
ADD CONSTRAINT aac_atu_fk FOREIGN KEY (aac_atu_codigo)
REFERENCES areas_de_atuacao (atu_codigo) ON DELETE SET NULL
/
ALTER TABLE areas_atuacao_cargo
ADD CONSTRAINT aac_car_fk FOREIGN KEY (aac_car_codigo, aac_car_codigo_nivel, 
  aac_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE areas_atuacao_unid_organiz
ADD CONSTRAINT auo_atu_fk FOREIGN KEY (auo_atu_codigo)
REFERENCES areas_de_atuacao (atu_codigo) ON DELETE SET NULL
/
ALTER TABLE areas_atuacao_unid_organiz
ADD CONSTRAINT auo_uor_fk FOREIGN KEY (auo_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE arquivo_credito_bancario
ADD CONSTRAINT acb_egt_fk FOREIGN KEY (acb_egt_crp_ano_pagamento, 
  acb_egt_crp_mes_pagamento, acb_egt_crp_sequencial, acb_emp_numero_matricula)
REFERENCES empregados_pagamentos (egt_crp_ano_pagamento,egt_crp_mes_pagamento,egt_crp_sequencial,egt_emp_numero_matricula) ON DELETE SET NULL
DISABLE
/
-- Foreign Key
ALTER TABLE arquivo_credito_bancario_pens
ADD CONSTRAINT acp_dep_fk FOREIGN KEY (dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE arquivo_credito_bancario_pens
ADD CONSTRAINT acp_egt_fk FOREIGN KEY (egt_crp_ano_pagamento, 
  egt_crp_mes_pagamento, egt_crp_sequencial, acp_pen_emp_numero_matricula)
REFERENCES empregados_pagamentos (egt_crp_ano_pagamento,egt_crp_mes_pagamento,egt_crp_sequencial,egt_emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE arquivo_credito_bancario_pens
ADD CONSTRAINT acp_pen_fk FOREIGN KEY (acp_pen_emp_numero_matricula, 
  acp_pen_codigo)
REFERENCES pensionistas (pen_emp_numero_matricula,pen_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE assinfra_dependencia
ADD CONSTRAINT ade_cas_fk FOREIGN KEY (ade_cas_cnpj)
REFERENCES cadastro_assinfra (cas_cnpj) ON DELETE SET NULL
/
ALTER TABLE assinfra_dependencia
ADD CONSTRAINT ade_dep_fk FOREIGN KEY (ade_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE assinfra_movimentacao
ADD CONSTRAINT amo_ade_cas_fk FOREIGN KEY (amo_ade_cas_cnpj, amo_ade_dep_codigo)
REFERENCES assinfra_dependencia (ade_cas_cnpj,ade_dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE atividades
ADD CONSTRAINT ati_cc2_fk FOREIGN KEY (ati_ct_custos_codigo)
REFERENCES centro_custo (cd_centro_custo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE atividades_cargos
ADD CONSTRAINT aca_ati_fk FOREIGN KEY (aca_ati_codigo)
REFERENCES atividades (ati_codigo) ON DELETE SET NULL
/
ALTER TABLE atividades_cargos
ADD CONSTRAINT aca_car_fk FOREIGN KEY (aca_car_codigo, aca_car_codigo_nivel, 
  aca_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE atividades_empregados
ADD CONSTRAINT aem_ati_fk FOREIGN KEY (aem_ati_codigo)
REFERENCES atividades (ati_codigo) ON DELETE SET NULL
/
ALTER TABLE atividades_empregados
ADD CONSTRAINT aem_emp_fk FOREIGN KEY (aem_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE atividades_funcoes
ADD CONSTRAINT atf_ati_codigo_fk FOREIGN KEY (atf_ati_codigo)
REFERENCES atividades (ati_codigo) ON DELETE SET NULL
/
ALTER TABLE atividades_funcoes
ADD CONSTRAINT atf_fun_codigo_fk FOREIGN KEY (atf_fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE autorizacoes_especiais
ADD CONSTRAINT aes_dep_3_fk FOREIGN KEY (aes_emp_dep_codigo_fisico)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_especiais
ADD CONSTRAINT aes_dep_fk FOREIGN KEY (aes_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_especiais
ADD CONSTRAINT aes_dpr_fk FOREIGN KEY (aes_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_especiais
ADD CONSTRAINT aes_emb_fk FOREIGN KEY (aes_emb_emp_numero_matricula, 
  aes_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE autorizacoes_itens_medicos
ADD CONSTRAINT aim_asm_fk FOREIGN KEY (aim_asm_senha)
REFERENCES autorizacoes_servicos_medicos (asm_senha) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT asm_cre_fk FOREIGN KEY (asm_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT asm_dep_fk FOREIGN KEY (asm_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT asm_emp_fk FOREIGN KEY (asm_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_servicos_medicos
ADD CONSTRAINT asm_emp_resp_fk FOREIGN KEY (asm_emp_numero_matricula_resp)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE autorizacoes_tratamentos_odont
ADD CONSTRAINT ato_emb_fk FOREIGN KEY (ato_emb_emp_numero_matricula, 
  ato_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_tratamentos_odont
ADD CONSTRAINT ato_fk_dep FOREIGN KEY (ato_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_tratamentos_odont
ADD CONSTRAINT ato_lot_fk FOREIGN KEY (ato_emp_dep_codigo_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE autorizacoes_tratamentos_odont
ADD CONSTRAINT ato_pvb_fk FOREIGN KEY (ato_emb_emp_numero_matricula, 
  ato_pvb_pvi_sequencial, ato_emb_ben_sigla, ato_pvb_adesao)
REFERENCES pessoas_vinculadas_benef (pvb_pvi_emp_numero_matricula,pvb_pvi_sequencial,emb_ben_sigla,pvb_adesao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE averbacao_tservico
ADD CONSTRAINT avb_emp_fk FOREIGN KEY (avb_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE beneficiarios
ADD CONSTRAINT bnf_aba_fk FOREIGN KEY (bnf_aba_ban_codigo, bnf_aba_codigo)
REFERENCES agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE beneficiarios
ADD CONSTRAINT bnf_emp_fk FOREIGN KEY (bnf_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE beneficiarios_seguros
ADD CONSTRAINT bsg_emp_ben_fk FOREIGN KEY (bsg_emb_emp_numero_matricula, 
  bsg_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE beneficiarios_seguros
ADD CONSTRAINT bsg_pvi_fk FOREIGN KEY (bsg_pvi_emp_numero_matricula, 
  bsg_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE beneficios
ADD CONSTRAINT ben_idx_fk FOREIGN KEY (ben_idx_sigla)
REFERENCES indexadores (idx_sigla) ON DELETE SET NULL
/
ALTER TABLE beneficios
ADD CONSTRAINT ben_rub_fk FOREIGN KEY (ben_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cadastros
ADD CONSTRAINT emp_aba_conta_fgts_fk FOREIGN KEY (emp_aba_ban_codigo_fgts, 
  emp_aba_codigo_fgts)
REFERENCES agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_aba_conta_pgto_fk FOREIGN KEY (emp_aba_ban_codigo_cta_pgto, 
  emp_aba_codigo_conta_pgto)
REFERENCES agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_eso_fk FOREIGN KEY (emp_eso_codigo)
REFERENCES escolaridades (eso_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_forca_armada_codigo_fk FOREIGN KEY (emp_forca_armada_codigo)
REFERENCES forcas_armadas (far_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_funcao_fk FOREIGN KEY (emp_qfu_fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_htd_fk FOREIGN KEY (emp_htd_dep_codigo, emp_htd_htr_codigo, 
  emp_htd_sequencial)
REFERENCES horarios_trabalho_dep (htd_dep_codigo,htd_htr_codigo,htd_sequencial) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_jtr_fk FOREIGN KEY (emp_jtr_codigo)
REFERENCES jornadas_trabalho (jtr_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_mun_natural_fk FOREIGN KEY (emp_mun_codigo_natural, 
  emp_ufe_sigla_natural)
REFERENCES municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_mun_reside_fk FOREIGN KEY (emp_mun_codigo_reside, 
  emp_ufe_sigla_residente)
REFERENCES municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_nsa_fk FOREIGN KEY (emp_nsa_codigo_nivel, 
  emp_nsa_codigo_padrao, emp_nsa_in_nivel_escolaridade)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ocl_fk FOREIGN KEY (emp_ocl_sigla)
REFERENCES orgaos_classes (ocl_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_pai_fk FOREIGN KEY (emp_pai_codigo)
REFERENCES paises (pai_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_posto_graduacao_codigo_fk FOREIGN KEY (
  emp_posto_graduacao_codigo)
REFERENCES posto_graduacao (pgr_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_qfu_estar_substituindo_fk FOREIGN KEY (
  emp_qfu_fun_codigo_substitui, emp_qfu_hfl_uor_cod_subst, 
  emp_qfu_hfl_data_vigen_subst)
REFERENCES quadro_funcoes (qfu_fun_codigo,qfu_hfl_uor_codigo,qfu_hfl_data_vigencia) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_qfu_fk FOREIGN KEY (emp_qfu_fun_codigo, 
  emp_qfu_hfl_uor_codigo, emp_qfu_hfl_data_vigencia)
REFERENCES quadro_funcoes (qfu_fun_codigo,qfu_hfl_uor_codigo,qfu_hfl_data_vigencia) ON DELETE SET NULL
DISABLE
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_qlp_fk FOREIGN KEY (emp_qlp_hcl_uor_codigo, 
  emp_qlp_hcl_data_vigencia, emp_qlp_car_codigo, emp_qlp_car_codigo_nivel, 
  emp_qlp_car_occ_codigo)
REFERENCES quadros_lotacao_pessoal (qlp_icl_uor_codigo,qlp_icl_data_vigencia,qlp_car_codigo,qlp_car_codigo_nivel,qlp_car_occ_codigo) ON DELETE SET NULL
DISABLE
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_quadro_arma_esp_codigo_fk FOREIGN KEY (
  emp_quadro_arma_esp_codigo)
REFERENCES quadro_arma_espec (qae_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_sfu_fk FOREIGN KEY (emp_sfu_codigo)
REFERENCES situacoes_funcionais (sfu_codigo) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_ci_fk FOREIGN KEY (emp_ufe_sigla_ci)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_ctps_fk FOREIGN KEY (emp_ufe_sigla_ctps)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_estrang_reg_fk FOREIGN KEY (emp_ufe_sigla_estrangeiro)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_primeiro_emprego_fk FOREIGN KEY (
  emp_ufe_sigla_primeiro_emprego)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_reg_profis_fk FOREIGN KEY (emp_ufe_sigla_reg_profis)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_ufe_tit_eleitoral_fk FOREIGN KEY (emp_ufe_sigla_tit_eleitor)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE cadastros
ADD CONSTRAINT emp_uor1_fk FOREIGN KEY (emp_uor_codigo_lotacao)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cargos
ADD CONSTRAINT car_cbo_pk FOREIGN KEY (car_codigo_cbo, car_cbo_dta_inicio)
REFERENCES cbo (cbo_codigo,cbo_dta_inicio) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_eso_fk FOREIGN KEY (car_eso_codigo)
REFERENCES escolaridades (eso_codigo) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_jtr_fk FOREIGN KEY (car_jtr_codigo)
REFERENCES jornadas_trabalho (jtr_codigo) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_nsa_finalizado_fk FOREIGN KEY (car_nsa_codigo_nivel_final, 
  car_nsa_codigo_padrao_final, car_nsa_in_nivel_escola_final)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_nsa_iniciado_fk FOREIGN KEY (car_nsa_codigo_nivel_inicio, 
  car_nsa_codigo_padrao_inicio, car_nsa_in_nivel_escola_inicio)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_occ_fk FOREIGN KEY (car_occ_codigo)
REFERENCES ocupacoes_cargo (occ_codigo) ON DELETE SET NULL
/
ALTER TABLE cargos
ADD CONSTRAINT car_ocl_fk FOREIGN KEY (car_ocl_sigla)
REFERENCES orgaos_classes (ocl_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_cbo_fk FOREIGN KEY (fun_codigo_cbo, fun_cbo_dta_inicio)
REFERENCES cbo (cbo_codigo,cbo_dta_inicio) ON DELETE SET NULL
/
ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_cfu_fk FOREIGN KEY (fun_cfu_codigo)
REFERENCES categorias_funcoes (cfu_codigo) ON DELETE SET NULL
/
ALTER TABLE cargos_confianca
ADD CONSTRAINT fun_jtr_fk FOREIGN KEY (fun_jtr_codigo)
REFERENCES jornadas_trabalho (jtr_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cargos_dependencias
ADD CONSTRAINT cde_car_fk FOREIGN KEY (cde_car_codigo, cde_car_codigo_nivel, 
  cde_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE cargos_dependencias
ADD CONSTRAINT cde_dep_fk FOREIGN KEY (cde_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE categorias_funcoes_valor
ADD CONSTRAINT cfv_cfu_fk FOREIGN KEY (cfv_cfu_codigo)
REFERENCES categorias_funcoes (cfu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE categorias_transporte
ADD CONSTRAINT cat_cbe_fk FOREIGN KEY (cat_cbe_ben_sigla, cat_cbe_cre_sequencial)
REFERENCES credenciados_beneficios (cbe_ben_sigla,cbe_cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE categorias_transporte
ADD CONSTRAINT cat_dep_fk FOREIGN KEY (cat_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE categorias_transporte
ADD CONSTRAINT cat_resp_fk FOREIGN KEY (cat_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cbo
ADD CONSTRAINT cbo_cbo_fk FOREIGN KEY (cbo_cbo_codigo, cbo_cbo_dta_inicio)
REFERENCES cbo (cbo_codigo,cbo_dta_inicio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE coberturas_seguros
ADD CONSTRAINT cba_tpv_codigo_fk FOREIGN KEY (csg_tpv_codigo)
REFERENCES tipo_vinculos (tpv_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cobranca_psv
ADD CONSTRAINT csv_cre_fk FOREIGN KEY (csv_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE cobranca_psv
ADD CONSTRAINT csv_psv_fk FOREIGN KEY (csv_psv_sequencial)
REFERENCES pessoal_sem_vinculo (psv_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE concursados_aprovados
ADD CONSTRAINT coa_emp_fk FOREIGN KEY (coa_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE concursados_aprovados
ADD CONSTRAINT fk_coa_con FOREIGN KEY (coa_con_nr_concurso)
REFERENCES concursos (con_nr_concurso) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE controle_usuario_dependencia
ADD CONSTRAINT cud_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE controle_usuario_dependencia
ADD CONSTRAINT cud_ss_fk FOREIGN KEY (ssi_cd_sistema)
REFERENCES seg_sistema (cd_sistema) ON DELETE SET NULL
/
ALTER TABLE controle_usuario_dependencia
ADD CONSTRAINT cud_su_fk FOREIGN KEY (sgu_id_usuario)
REFERENCES seg_usuario (id_usuario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE controle_usuarios_funcoes
ADD CONSTRAINT cuf_fun_fk FOREIGN KEY (fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
ALTER TABLE controle_usuarios_funcoes
ADD CONSTRAINT fk_cuf_ss FOREIGN KEY (ss_cd_sistema)
REFERENCES seg_sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE controle_usuarios_ocorrencias
ADD CONSTRAINT cuo_ofu_fk FOREIGN KEY (ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
ALTER TABLE controle_usuarios_ocorrencias
ADD CONSTRAINT fk_cuo_ss FOREIGN KEY (ss_cd_sistema)
REFERENCES seg_sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE corpo_clinico
ADD CONSTRAINT cc_cbe_fk FOREIGN KEY (cc_cbe_ben_sigla, cc_cre_cod_seque)
REFERENCES credenciados_beneficios (cbe_ben_sigla,cbe_cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE corpo_clinico
ADD CONSTRAINT cc_cre_cod_seque_fk FOREIGN KEY (cc_cre_cod_seque)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE corpo_clinico_especialidades
ADD CONSTRAINT cce_ccli_fk FOREIGN KEY (cce_cc_cre_cod_seque, cce_cc_sequencial)
REFERENCES corpo_clinico (cc_cre_cod_seque,cc_sequencial) ON DELETE SET NULL
/
ALTER TABLE corpo_clinico_especialidades
ADD CONSTRAINT cce_cod_seque_fk FOREIGN KEY (cce_esp_tipo, cce_esp_numero)
REFERENCES especialidades (esp_tipo,esp_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_cor_fk FOREIGN KEY (cor_cor_cre_sequencial, 
  cor_cor_dta_doc_fiscal, cor_cor_num_doc_fiscal, cor_cor_cnpj_empresa, 
  cor_cor_dta_inclusao)
REFERENCES credenc_inss_outros_recolhim (cor_cre_sequencial,cor_dta_doc_fiscal,cor_num_doc_fiscal,cor_cnpj_empresa,cor_dta_inclusao) ON DELETE SET NULL
/
ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_cre_fk FOREIGN KEY (cor_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE credenc_inss_outros_recolhim
ADD CONSTRAINT cor_dep_fk FOREIGN KEY (cor_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenciados
ADD CONSTRAINT cre_aba_fk FOREIGN KEY (cre_aba_ban_codigo, cre_aba_codigo)
REFERENCES agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE credenciados
ADD CONSTRAINT cre_cre_fk FOREIGN KEY (cre_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE credenciados
ADD CONSTRAINT cre_dep_fk FOREIGN KEY (cre_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE credenciados
ADD CONSTRAINT cre_ocl_fk FOREIGN KEY (cre_ocl_sigla)
REFERENCES orgaos_classes (ocl_sigla) ON DELETE SET NULL
/
ALTER TABLE credenciados
ADD CONSTRAINT cre_ufe_fk FOREIGN KEY (cre_ufe_sigla)
REFERENCES unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenciados_beneficios
ADD CONSTRAINT cbe_ben_sigla_fk FOREIGN KEY (cbe_ben_sigla)
REFERENCES beneficios (ben_sigla) ON DELETE SET NULL
/
ALTER TABLE credenciados_beneficios
ADD CONSTRAINT cbe_cre_sequencial_fk FOREIGN KEY (cbe_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenciados_contratos
ADD CONSTRAINT cc_cbe_ben_sigla_fk FOREIGN KEY (cc_cbe_ben_sigla, 
  cc_cbe_cre_sequencial)
REFERENCES credenciados_beneficios (cbe_ben_sigla,cbe_cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE credenciados_contratos
ADD CONSTRAINT cc_dep_fk FOREIGN KEY (cc_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenciados_dependencias
ADD CONSTRAINT cd_cbe_fk FOREIGN KEY (cd_cbe_ben_sigla, cd_cre_sequencial)
REFERENCES credenciados_beneficios (cbe_ben_sigla,cbe_cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE credenciados_dependencias
ADD CONSTRAINT cd_dep_fk FOREIGN KEY (cd_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE credenciados_especialidades
ADD CONSTRAINT cde_cre_fk FOREIGN KEY (cde_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE credenciados_especialidades
ADD CONSTRAINT cde_esp_fk FOREIGN KEY (cde_esp_tipo, cde_esp_numero)
REFERENCES especialidades (esp_tipo,esp_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE cronogramas_pagamentos
ADD CONSTRAINT crp_dep_fk FOREIGN KEY (crp_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE cronogramas_pagamentos
ADD CONSTRAINT crp_epg_fk FOREIGN KEY (crp_epg_codigo)
REFERENCES eventos_pagamentos (epg_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE dataprev_reembolso
ADD CONSTRAINT dree_cad_fk FOREIGN KEY (dar_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE dataprev_reembolso
ADD CONSTRAINT dree_dep_fk FOREIGN KEY (dar_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE dataprev_reembolso
ADD CONSTRAINT dree_de_fk FOREIGN KEY (dar_des_cod_especie)
REFERENCES dataprev_especie (des_cod_especie) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE dataprev_reembolso_rubricas
ADD CONSTRAINT drr_dr_fk FOREIGN KEY (drr_ano_referencia, drr_mes_referencia, 
  drr_emp_numero_matricula, drr_cod_beneficio, drr_cod_benef_sequencial)
REFERENCES dataprev_reembolso (dar_ano_referencia,dar_mes_referencia,dar_emp_numero_matricula,dar_cod_beneficio,dar_cod_benef_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE deducao_inss_aut_coop
ADD CONSTRAINT dia_cre_fk FOREIGN KEY (dia_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE deducao_inss_aut_coop
ADD CONSTRAINT dia_dep_fk FOREIGN KEY (dia_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE deducao_inss_empregados
ADD CONSTRAINT die_cad_fk FOREIGN KEY (die_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE deducao_inss_empregados
ADD CONSTRAINT die_dep_fk FOREIGN KEY (die_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE demonstrativo_custo_beneficio
ADD CONSTRAINT dcb_dep_fk FOREIGN KEY (dcb_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE dep_controle_arq_freq
ADD CONSTRAINT dep_arq_dep_arq_freq_fk FOREIGN KEY (dep_codigo_arq_freq)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE dep_controle_arq_freq
ADD CONSTRAINT dep_arq_resp_envio_fk FOREIGN KEY (dep_codigo_resp_envio)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE dependentes_usu_plano_saude
ADD CONSTRAINT dus_cre_fk FOREIGN KEY (dus_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE dependentes_usu_plano_saude
ADD CONSTRAINT dus_emp_fk FOREIGN KEY (dus_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE dependentes_usu_plano_saude
ADD CONSTRAINT dus_pvi_fk FOREIGN KEY (dus_emp_numero_matricula, 
  dus_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
ALTER TABLE dependentes_usu_plano_saude
ADD CONSTRAINT dus_ups_fk FOREIGN KEY (dus_cre_sequencial, 
  dus_emp_numero_matricula, dus_ups_cod_usuario, dus_ups_data_inicio)
REFERENCES usuarios_planos_saude (ups_cre_sequencial,ups_emp_numero_matricula,ups_cod_usuario,ups_data_inicio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE despesas_medicas_hospitalares
ADD CONSTRAINT dmp_gui_fk FOREIGN KEY (dmp_gui_doc_numero, 
  dmp_gui_doc_cbe_ben_sigla, dmp_gui_doc_cbe_cre_sequencial, 
  dmp_gui_doc_dep_codigo, dmp_gui_numero)
REFERENCES guias (gui_doc_numero,gui_doc_cbe_ben_sigla,gui_doc_cbe_cre_sequencial,gui_doc_dep_codigo,gui_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE diversos_medicas_hospit
ADD CONSTRAINT dmo_gui_fk FOREIGN KEY (dmo_gui_doc_numero, 
  dmo_gui_doc_cbe_ben_sigla, dmo_gui_doc_cbe_cre_sequencial, 
  dmo_gui_doc_dep_codigo, dmo_gui_numero)
REFERENCES guias (gui_doc_numero,gui_doc_cbe_ben_sigla,gui_doc_cbe_cre_sequencial,gui_doc_dep_codigo,gui_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE documentacao_contratual
ADD CONSTRAINT dcn_cre_fk FOREIGN KEY (dcn_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doc_cbe_fk FOREIGN KEY (doc_cbe_ben_sigla, doc_cbe_cre_sequencial)
REFERENCES credenciados_beneficios (cbe_ben_sigla,cbe_cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doc_emb_fk FOREIGN KEY (doc_emb_emp_numero_matricula, 
  doc_cbe_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doc_pvb_fk FOREIGN KEY (doc_pvi_emp_numero_matricula, 
  doc_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
ALTER TABLE documentos_cobranca
ADD CONSTRAINT doc_ri_fk FOREIGN KEY (doc_ri_cod_receita, doc_ri_dat_inicio)
REFERENCES retencao_impostos (ri_cod_receita,ri_dat_inicio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE efetivo_infraero
ADD CONSTRAINT ein_dep_fk FOREIGN KEY (ein_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE emp_qualificacao_academica
ADD CONSTRAINT eqa_emp_fk FOREIGN KEY (eqa_cod_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE emp_qualificacao_academica
ADD CONSTRAINT eqa_qua_fk FOREIGN KEY (eqa_qua_cod_qualif_academica)
REFERENCES tab_qualificacao_academica (qua_cod_qualif_academica) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregado_fone_comercial
ADD CONSTRAINT efc_fk FOREIGN KEY (efc_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregado_ocorrencia_inss
ADD CONSTRAINT eoi_cad_fk FOREIGN KEY (eoi_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE empregado_ocorrencia_inss
ADD CONSTRAINT eoi_oia_fk FOREIGN KEY (eoi_oia_agn_codigo, 
  eoi_oia_oin_codigo_padrao_nac)
REFERENCES ocorrencias_inss_agnocivos (oia_agn_codigo,oia_oin_codigo_padrao_nacional) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_atuacao_cargo
ADD CONSTRAINT eac_car_fk FOREIGN KEY (eac_aac_car_codigo, 
  eac_aac_car_codigo_nivel, eac_aac_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE empregados_atuacao_cargo
ADD CONSTRAINT eac_emp_fk FOREIGN KEY (eac_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE empregados_atuacao_cargo
ADD CONSTRAINT eac_occ_fk FOREIGN KEY (eac_aac_atu_codigo)
REFERENCES ocupacoes_cargo (occ_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_ben_fk FOREIGN KEY (emb_ben_sigla)
REFERENCES beneficios (ben_sigla) ON DELETE SET NULL
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_dep_fk FOREIGN KEY (emb_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE empregados_beneficios
ADD CONSTRAINT emb_emp_fk FOREIGN KEY (emb_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_categorias
ADD CONSTRAINT emc_cat_fk FOREIGN KEY (emc_cat_dep_codigo, emc_cat_sigla)
REFERENCES categorias_transporte (cat_dep_codigo,cat_sigla) ON DELETE SET NULL
/
ALTER TABLE empregados_categorias
ADD CONSTRAINT emc_dep_fk FOREIGN KEY (emc_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE empregados_categorias
ADD CONSTRAINT emc_emb_fk FOREIGN KEY (emc_emb_emp_numero_matricula, 
  emc_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_ferias_13
ADD CONSTRAINT efe_emp_fk FOREIGN KEY (efe_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_formacoes
ADD CONSTRAINT emf_emp_fk FOREIGN KEY (emf_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE empregados_formacoes
ADD CONSTRAINT emf_forp_fk FOREIGN KEY (emf_for_codigo)
REFERENCES formacoes_profissionais (for_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_optantes
ADD CONSTRAINT emp_opt_fk FOREIGN KEY (emp_opt_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_pagamentos
ADD CONSTRAINT egt_dep_fk FOREIGN KEY (egt_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE empregados_pagamentos
ADD CONSTRAINT egt_uor_fk FOREIGN KEY (egt_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT dep_fk FOREIGN KEY (epl_dep_codigo_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE empregados_participacao_lucros
ADD CONSTRAINT emp_fk FOREIGN KEY (epl_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE empregados_pessoal_sem_vinculo
ADD CONSTRAINT epv_emp_fk FOREIGN KEY (epv_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE empregados_pessoal_sem_vinculo
ADD CONSTRAINT epv_psv_fk FOREIGN KEY (epv_psv_sequencial)
REFERENCES pessoal_sem_vinculo (psv_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE emprestimos_infraprev
ADD CONSTRAINT emprest_infrap_val_cadastros FOREIGN KEY (num_matricula_empregado)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE especificacao_cid
ADD CONSTRAINT esc_cid_fk FOREIGN KEY (esc_cid_codigo)
REFERENCES cid (cid_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE eventos_excecao_infraprev
ADD CONSTRAINT emp_numero_matricula_fk FOREIGN KEY (eei_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE eventos_pagamentos
ADD CONSTRAINT epg_epg_fk FOREIGN KEY (epg_epg_codigo)
REFERENCES eventos_pagamentos (epg_codigo) ON DELETE SET NULL
/
ALTER TABLE eventos_pagamentos
ADD CONSTRAINT epg_epg_pre_requisito_2_fk FOREIGN KEY (epg_epg_codigo_pre_2)
REFERENCES eventos_pagamentos (epg_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE exames_complementares
ADD CONSTRAINT exc_cre_fk FOREIGN KEY (exc_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE exames_obrigatorios
ADD CONSTRAINT exo_emp_fk FOREIGN KEY (exo_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE faltas_usuarios_linhas
ADD CONSTRAINT fal_usu_lin_val_dependen FOREIGN KEY (ful_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE faltas_usuarios_linhas
ADD CONSTRAINT ful_ult_fk FOREIGN KEY (ful_ult_emb_emp_numero_matricu, 
  ful_ult_emb_ben_sigla, ful_ult_ltf_numero, ful_ult_ltf_dep_codigo)
REFERENCES usuarios_linhas_transportes (ult_emb_emp_numero_matricula,ult_emb_ben_sigla,ult_ltf_numero,ult_ltf_dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE finasa
ADD CONSTRAINT finasa_val_centro_custo FOREIGN KEY (fin_centro_custos)
REFERENCES centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE finasa
ADD CONSTRAINT finasa_val_dependencias FOREIGN KEY (fin_emp_dep_codigo_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE fiscais_linhas_transportes
ADD CONSTRAINT fisc_lin_tran_val_dependen FOREIGN KEY (flt_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE fiscais_linhas_transportes
ADD CONSTRAINT flt_emp_fk FOREIGN KEY (flt_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE fiscalizacoes_linhas_empreg
ADD CONSTRAINT fisc_lin_empr_val_dependen FOREIGN KEY (fle_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE fiscalizacoes_linhas_empreg
ADD CONSTRAINT fle_emp_fk FOREIGN KEY (fle_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE fiscalizacoes_linhas_empreg
ADD CONSTRAINT fle_flr_fk FOREIGN KEY (fle_flr_numero_ato)
REFERENCES fiscalizacoes_linhas_transp (flr_numero_ato) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE fiscalizacoes_linhas_transp
ADD CONSTRAINT fisc_lin_trans_val_dependen FOREIGN KEY (flr_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE fiscalizacoes_linhas_transp
ADD CONSTRAINT flr_ltf_fk FOREIGN KEY (flr_ltf_numero, flr_ltf_dep_codigo)
REFERENCES linhas_transportes_fretados (ltf_numero,ltf_dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE formacoes_espec_cargo
ADD CONSTRAINT fec_car_fk FOREIGN KEY (fec_car_codigo, fec_car_codigo_nivel, 
  fec_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE formacoes_espec_cargo
ADD CONSTRAINT fec_fes_fk FOREIGN KEY (fec_fes_codigo)
REFERENCES formacoes_especializadas (fes_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE formacoes_espec_empregado
ADD CONSTRAINT fee_emp_fk FOREIGN KEY (fee_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE formacoes_espec_empregado
ADD CONSTRAINT fee_fes_fk FOREIGN KEY (fee_fes_codigo)
REFERENCES formacoes_especializadas (fes_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE formacoes_prof_cargo
ADD CONSTRAINT fpc_car_fk FOREIGN KEY (fpc_car_codigo, fpc_car_codigo_nivel, 
  fpc_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE formacoes_prof_cargo
ADD CONSTRAINT fpc_for_fk FOREIGN KEY (fpc_for_codigo)
REFERENCES formacoes_profissionais (for_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE formulas_rubricas
ADD CONSTRAINT fru_form_fk FOREIGN KEY (fru_for_codigo)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE formulas_rubricas
ADD CONSTRAINT fru_rub_fk FOREIGN KEY (fru_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE guias
ADD CONSTRAINT fk_gui_asm FOREIGN KEY (gui_asm_senha)
REFERENCES autorizacoes_servicos_medicos (asm_senha) ON DELETE SET NULL
DEFERRABLE INITIALLY DEFERRED 
/
ALTER TABLE guias
ADD CONSTRAINT gui_doc_fk FOREIGN KEY (gui_doc_numero, gui_doc_cbe_ben_sigla, 
  gui_doc_cbe_cre_sequencial, gui_doc_dep_codigo)
REFERENCES documentos_cobranca (doc_numero,doc_cbe_ben_sigla,doc_cbe_cre_sequencial,doc_dep_codigo) ON DELETE SET NULL
/
ALTER TABLE guias
ADD CONSTRAINT gui_emb_fk FOREIGN KEY (gui_emp_numero_matricula, 
  gui_doc_cbe_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE guias
ADD CONSTRAINT gui_lot_fk FOREIGN KEY (gui_emp_dep_codigo_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE guias
ADD CONSTRAINT gui_pvb_fk FOREIGN KEY (gui_emp_numero_matricula, 
  gui_pvi_sequencial, gui_doc_cbe_ben_sigla, gui_pvb_adesao)
REFERENCES pessoas_vinculadas_benef (pvb_pvi_emp_numero_matricula,pvb_pvi_sequencial,emb_ben_sigla,pvb_adesao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE guias_procedimentos
ADD CONSTRAINT gpr_abo_fk FOREIGN KEY (gpr_abo_codigo)
REFERENCES abo (abo_codigo) ON DELETE SET NULL
/
ALTER TABLE guias_procedimentos
ADD CONSTRAINT gpr_gui_fk FOREIGN KEY (gpr_gui_doc_numero, 
  gpr_gui_doc_cbe_ben_sigla, gpr_gui_doc_cbe_cre_sequencial, 
  gpr_gui_doc_dep_codigo, gpr_gui_numero)
REFERENCES guias (gui_doc_numero,gui_doc_cbe_ben_sigla,gui_doc_cbe_cre_sequencial,gui_doc_dep_codigo,gui_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE hist_detalhe_dev_ans
ADD CONSTRAINT hdd_hda_pk FOREIGN KEY (hdd_hda_dt_carga_arq, hdd_hda_cod_usuario, 
  hdd_hda_nome_arquivo)
REFERENCES historico_devolucao_ans (hda_dt_carga_arq,hda_cod_usuario,hda_nome_arquivo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE hist_pericul_insalub
ADD CONSTRAINT hpi_emp_fk FOREIGN KEY (hpi_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_ans
ADD CONSTRAINT han_pvi_fk FOREIGN KEY (han_emp_numero_matricula, 
  han_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
ALTER TABLE historico_ans
ADD CONSTRAINT han_usu_fk FOREIGN KEY (han_cod_usuario_geracao)
REFERENCES seg_usuario (id_usuario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_cargos_dependencias
ADD CONSTRAINT hcd_dep_fk FOREIGN KEY (hcd_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_cargos_lotacao
ADD CONSTRAINT icl_hcd_fk FOREIGN KEY (icl_hcd_dep_codigo, icl_hcd_data_vigencia)
REFERENCES historico_cargos_dependencias (hcd_dep_codigo,hcd_data_vigencia) ON DELETE SET NULL
/
ALTER TABLE historico_cargos_lotacao
ADD CONSTRAINT icl_uor_fk FOREIGN KEY (icl_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_geracao_tcu
ADD CONSTRAINT hgt_emp_fk FOREIGN KEY (hgt_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_emp_fk FOREIGN KEY (mov_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_form_fk FOREIGN KEY (mov_for_codigo)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_oem_fk FOREIGN KEY (mov_oem_emp_numero_matricula, 
  mov_oem_ofu_codigo, mov_oem_data_inicio)
REFERENCES ocorrencias_empregados (oem_emp_numero_matricula,oem_ofu_codigo,oem_data_inicio) ON DELETE SET NULL
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula, 
  mov_pen_codigo)
REFERENCES pensionistas (pen_emp_numero_matricula,pen_codigo) ON DELETE SET NULL
/
ALTER TABLE historico_movimentacao
ADD CONSTRAINT hst_mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historico_niveis_salariais
ADD CONSTRAINT hns_nsa_fk FOREIGN KEY (hns_nsa_codigo_nivel, 
  hns_nsa_codigo_padrao, hns_nsa_indicador_nivel_escola)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historicos_funcoes_dependencia
ADD CONSTRAINT hfd_fk FOREIGN KEY (hfd_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historicos_funcoes_lotacoes
ADD CONSTRAINT hfl_hfd_fk FOREIGN KEY (hfl_hfd_dep_codigo, hfl_hfd_data_vigencia)
REFERENCES historicos_funcoes_dependencia (hfd_dep_codigo,hfd_data_vigencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE historicos_processos_sinistros
ADD CONSTRAINT hps_bsg_fk FOREIGN KEY (hps_bsg_sequencial)
REFERENCES beneficiarios_seguros (bsg_sequencial) ON DELETE SET NULL
/
ALTER TABLE historicos_processos_sinistros
ADD CONSTRAINT hps_dep_resp_fk FOREIGN KEY (hps_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE historicos_processos_sinistros
ADD CONSTRAINT hps_emb_fk FOREIGN KEY (hps_emb_emp_numero_matricula, 
  hps_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE historicos_processos_sinistros
ADD CONSTRAINT hps_sin_fk FOREIGN KEY (hps_sin_sequencial)
REFERENCES sinistros (sin_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE honorarios_medicos
ADD CONSTRAINT hnm_gpr_fk FOREIGN KEY (hnm_gpr_gui_doc_numero, 
  hnm_gpr_gui_doc_cbe_ben_sigla, hnm_gpr_gui_doc_cbe_cre_seq, 
  hnm_gpr_gui_doc_dep_codigo, hnm_gpr_gui_numero, hnm_gpr_sequencial)
REFERENCES guias_procedimentos (gpr_gui_doc_numero,gpr_gui_doc_cbe_ben_sigla,gpr_gui_doc_cbe_cre_sequencial,gpr_gui_doc_dep_codigo,gpr_gui_numero,gpr_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE horarios_frequencia
ADD CONSTRAINT hf_dep_fk FOREIGN KEY (hfr_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE horarios_trabalho_dep
ADD CONSTRAINT htd_dep_fk FOREIGN KEY (htd_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE horarios_trabalho_dep
ADD CONSTRAINT htd_htr_fk FOREIGN KEY (htd_htr_codigo)
REFERENCES horarios_trabalhos (htr_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE incidencias_rubricas
ADD CONSTRAINT iru_rub2_fk FOREIGN KEY (iru_rub_codigo_incide)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
ALTER TABLE incidencias_rubricas
ADD CONSTRAINT iru_rub_fk FOREIGN KEY (iru_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE indice_absenteismo
ADD CONSTRAINT iab_dep_fk FOREIGN KEY (iab_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE indice_absenteismo
ADD CONSTRAINT iab_ofu_fk FOREIGN KEY (iab_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE indices
ADD CONSTRAINT ind_ben_fk FOREIGN KEY (ind_ben_sigla)
REFERENCES beneficios (ben_sigla) ON DELETE SET NULL
/
ALTER TABLE indices
ADD CONSTRAINT ind_cre_fk FOREIGN KEY (ind_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE indices
ADD CONSTRAINT ind_idx_fk FOREIGN KEY (ind_idx_sigla)
REFERENCES indexadores (idx_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE internacao
ADD CONSTRAINT interna_gui_fk FOREIGN KEY (int_gui_doc_numero, 
  int_gui_doc_cbe_ben_sigla, int_gui_doc_cbe_cre_sequencial, 
  int_gui_doc_dep_codigo, int_gui_numero)
REFERENCES guias (gui_doc_numero,gui_doc_cbe_ben_sigla,gui_doc_cbe_cre_sequencial,gui_doc_dep_codigo,gui_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE itinerarios_linhas_transportes
ADD CONSTRAINT ili_ltf_fk FOREIGN KEY (ili_ltf_numero, ili_ltf_dep_codigo)
REFERENCES linhas_transportes_fretados (ltf_numero,ltf_dep_codigo) ON DELETE SET NULL
/
ALTER TABLE itinerarios_linhas_transportes
ADD CONSTRAINT itin_lin_trans_val_dependen FOREIGN KEY (ili_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE licenca_premio
ADD CONSTRAINT lpr_emp_fk FOREIGN KEY (lpr_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE linhas_transportes_fretados
ADD CONSTRAINT lin_trans_fret_val_dependen FOREIGN KEY (ltf_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE linhas_transportes_fretados
ADD CONSTRAINT ltf_cre_fk FOREIGN KEY (ltf_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE linhas_transportes_fretados
ADD CONSTRAINT ltf_dep_fk FOREIGN KEY (ltf_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE linhas_transportes_fretados
ADD CONSTRAINT ltf_flt_fk FOREIGN KEY (ltf_flt_emp_numero_matricula)
REFERENCES fiscais_linhas_transportes (flt_emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE listas_esperas_transportes
ADD CONSTRAINT let_emb_fk FOREIGN KEY (let_emb_emp_numero_matricula, 
  let_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE listas_esperas_transportes
ADD CONSTRAINT let_ltf_fk FOREIGN KEY (let_ltf_numero, let_ltf_dep_codigo)
REFERENCES linhas_transportes_fretados (ltf_numero,ltf_dep_codigo) ON DELETE SET NULL
/
ALTER TABLE listas_esperas_transportes
ADD CONSTRAINT lis_esper_trans_val_dependen FOREIGN KEY (let_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE local_atendimento
ADD CONSTRAINT loa_cre_fk FOREIGN KEY (loa_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE local_atendimento
ADD CONSTRAINT loa_dep_fk FOREIGN KEY (loa_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE lpm
ADD CONSTRAINT lpm_esp_tipo_fk FOREIGN KEY (lpm_esp_tipo, lpm_esp_numero)
REFERENCES especialidades (esp_tipo,esp_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE lpm_local
ADD CONSTRAINT lpl_cre_sequencial_fk FOREIGN KEY (lpl_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE medias_categorias_transportes
ADD CONSTRAINT mct_dep_fk FOREIGN KEY (mct_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE mensagens_contracheques
ADD CONSTRAINT mec_dep_fk FOREIGN KEY (mec_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE movimentacao
ADD CONSTRAINT mov_emp_fk FOREIGN KEY (mov_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_form_fk FOREIGN KEY (mov_for_codigo)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_oem_fk FOREIGN KEY (mov_oem_emp_numero_matricula, 
  mov_oem_ofu_codigo, mov_oem_data_inicio)
REFERENCES ocorrencias_empregados (oem_emp_numero_matricula,oem_ofu_codigo,oem_data_inicio) ON DELETE SET NULL
DISABLE
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula, mov_pen_codigo)
REFERENCES pensionistas (pen_emp_numero_matricula,pen_codigo) ON DELETE SET NULL
DISABLE
/
ALTER TABLE movimentacao
ADD CONSTRAINT mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE movimentacao_autonomo_cooperat
ADD CONSTRAINT mac_cbo_fk FOREIGN KEY (mac_cbo_codigo, mac_cbo_dta_inicio)
REFERENCES cbo (cbo_codigo,cbo_dta_inicio) ON DELETE SET NULL
/
ALTER TABLE movimentacao_autonomo_cooperat
ADD CONSTRAINT mac_cre_fk FOREIGN KEY (mac_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE movimentacao_autonomo_cooperat
ADD CONSTRAINT mac_dep_fk FOREIGN KEY (mac_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencia_viagem_centro_custo
ADD CONSTRAINT ovc_cc2_fk FOREIGN KEY (ovc_cct_codigo)
REFERENCES centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ocorrencia_viagem_centro_custo
ADD CONSTRAINT ovc_ove_fk FOREIGN KEY (ovc_ove_oem_emp_num_matricula, 
  ovc_ove_oem_ofu_codigo, ovc_ove_oem_data_inicio, ovc_ove_codigo_trecho)
REFERENCES ocorrencias_viagens_empregados (ove_oem_emp_numero_matricula,ove_oem_ofu_codigo,ove_oem_data_inicio,ove_codigo_trecho) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_dep_fk FOREIGN KEY (oem_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_emp_fk FOREIGN KEY (oem_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_emp_substituir_fk FOREIGN KEY (oem_emp_numero_matricula_subst)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_oem_fk FOREIGN KEY (oem_oem_emp_numero_matricula, 
  oem_oem_ofu_codigo, oem_oem_data_inicio)
REFERENCES ocorrencias_empregados (oem_emp_numero_matricula,oem_ofu_codigo,oem_data_inicio) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_ofu_fk FOREIGN KEY (oem_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm1_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm1, 
  oem_pfe_sequencial_confirm1)
REFERENCES programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial) ON DELETE SET NULL
DISABLE
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm2_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm2, 
  oem_pfe_sequencial_confirm2)
REFERENCES programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial) ON DELETE SET NULL
DISABLE
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_pfe_program_fk FOREIGN KEY (oem_pfe_emp_num_matr_program, 
  oem_pfe_sequencial_program)
REFERENCES programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial) ON DELETE SET NULL
DISABLE
/
ALTER TABLE ocorrencias_empregados
ADD CONSTRAINT oem_uor_fk FOREIGN KEY (oem_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_dep_fk FOREIGN KEY (ofe_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_emp_fk FOREIGN KEY (ofe_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ofe_fk FOREIGN KEY (ofe_ofe_emp_numero_matricula, 
  ofe_ofe_ofu_codigo, ofe_ofe_data_inicio)
REFERENCES ocorrencias_frequencia_emp (ofe_emp_numero_matricula,ofe_ofu_codigo,ofe_data_inicio) ON DELETE SET NULL
DISABLE
/
ALTER TABLE ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ofu_fk FOREIGN KEY (ofe_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_inss_agnocivos
ADD CONSTRAINT oia_agn_fk FOREIGN KEY (oia_agn_codigo)
REFERENCES agentes_nocivos (agn_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_inss_agnocivos
ADD CONSTRAINT oia_oin_fk FOREIGN KEY (oia_oin_codigo_padrao_nacional)
REFERENCES ocorrencias_inss (oin_codigo_padrao_nacional) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_pis_pasep_arquivo
ADD CONSTRAINT oppa_opp_fk FOREIGN KEY (oco_nome_arquivo, oco_codigo_ocorrencia, 
  oco_tipo_ocorrencia)
REFERENCES ocorrencias_pis_pasep (nome_arquivo,codido_ocorrencia,tipo_ocorrencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_pis_pasep_emp
ADD CONSTRAINT oppe_opp_fk FOREIGN KEY (oco_nome_arquivo, oco_codigo_ocorrencia, 
  oco_tipo_ocorrencia)
REFERENCES ocorrencias_pis_pasep (nome_arquivo,codido_ocorrencia,tipo_ocorrencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_receb_tickets
ADD CONSTRAINT ort_dep_fk FOREIGN KEY (ort_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_receb_tickets
ADD CONSTRAINT ort_emb_fk FOREIGN KEY (ort_emb_emp_numero_matricula, 
  ort_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_receb_tickets
ADD CONSTRAINT ort_uor_fk FOREIGN KEY (ort_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_receb_vales
ADD CONSTRAINT orv_dep_fk FOREIGN KEY (orv_dep_codigo_fisico)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_receb_vales
ADD CONSTRAINT orv_uor_fk FOREIGN KEY (orv_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_situacoes_func
ADD CONSTRAINT osf_ofu_fk FOREIGN KEY (osf_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
ALTER TABLE ocorrencias_situacoes_func
ADD CONSTRAINT osf_sfu_fk FOREIGN KEY (osf_sfu_codigo)
REFERENCES situacoes_funcionais (sfu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ocorrencias_viagens_empregados
ADD CONSTRAINT ove_oem_fk FOREIGN KEY (ove_oem_emp_numero_matricula, 
  ove_oem_ofu_codigo, ove_oem_data_inicio)
REFERENCES ocorrencias_empregados (oem_emp_numero_matricula,oem_ofu_codigo,oem_data_inicio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pagamentos_especiais
ADD CONSTRAINT pge_aes_fk FOREIGN KEY (pge_dep_codigo, 
  pge_aes_emb_emp_numero_matric, pge_aes_emb_ben_sigla, pge_aes_valor_autorizado)
REFERENCES autorizacoes_especiais (aes_dep_codigo,aes_emb_emp_numero_matricula,aes_emb_ben_sigla,aes_valor_autorizado) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE parametros_funcoes
ADD CONSTRAINT prm_fun_fk FOREIGN KEY (fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE parametros_ocorrencias_func
ADD CONSTRAINT pof_ofu_fk FOREIGN KEY (ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pedidos_cobrancas
ADD CONSTRAINT pco_doc_fk FOREIGN KEY (pco_doc_numero, pco_doc_cbe_ben_sigla, 
  pco_doc_cbe_cre_sequencial, pco_doc_dep_codigo)
REFERENCES documentos_cobranca (doc_numero,doc_cbe_ben_sigla,doc_cbe_cre_sequencial,doc_dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pedidos_tickets
ADD CONSTRAINT pkt_dep_fk FOREIGN KEY (pkt_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pensionistas
ADD CONSTRAINT pen_emp_matr_fk FOREIGN KEY (pen_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_for_13_fk FOREIGN KEY (pen_for_codigo_13)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_for_ferias_fk FOREIGN KEY (pen_for_codigo_ferias)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE pensionistas
ADD CONSTRAINT pen_for_fk FOREIGN KEY (pen_for_codigo)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pericul_insalub_agnocivos
ADD CONSTRAINT pia_agn_fk FOREIGN KEY (pia_agn_codigo)
REFERENCES agentes_nocivos (agn_codigo) ON DELETE SET NULL
/
ALTER TABLE pericul_insalub_agnocivos
ADD CONSTRAINT pia_hpi_fk FOREIGN KEY (pia_hpi_emp_numero_matricula, 
  pia_hpi_data_inicio, pia_hpi_ind_pericul_insalub)
REFERENCES hist_pericul_insalub (hpi_emp_numero_matricula,hpi_data_inicio,hpi_ind_pericul_insalub) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pericul_insalub_nao_autorizada
ADD CONSTRAINT pin_emp_fk FOREIGN KEY (pin_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pessoas_vinculadas
ADD CONSTRAINT pvi_emp_fk FOREIGN KEY (pvi_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE pessoas_vinculadas
ADD CONSTRAINT pvi_mun_fk FOREIGN KEY (pvi_mun_codigo_naturalidade, 
  pvi_ufe_sigla_naturalidade)
REFERENCES municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE pessoas_vinculadas
ADD CONSTRAINT pvi_pai_codigo_fk FOREIGN KEY (pvi_pai_codigo)
REFERENCES paises (pai_codigo) ON DELETE SET NULL
/
ALTER TABLE pessoas_vinculadas
ADD CONSTRAINT pvi_tpv_fk FOREIGN KEY (pvi_tpv_codigo)
REFERENCES tipo_vinculos (tpv_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pessoas_vinculadas_benef
ADD CONSTRAINT pvb_ben_fk FOREIGN KEY (emb_ben_sigla)
REFERENCES beneficios (ben_sigla) ON DELETE SET NULL
/
ALTER TABLE pessoas_vinculadas_benef
ADD CONSTRAINT pvb_pvi_fk FOREIGN KEY (pvb_pvi_emp_numero_matricula, 
  pvb_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE planos_medicos
ADD CONSTRAINT pla_cre_fk FOREIGN KEY (pla_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE pre_requisito_funcao
ADD CONSTRAINT prf_fun_fk FOREIGN KEY (prf_fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
ALTER TABLE pre_requisito_funcao
ADD CONSTRAINT prf_prr_fk FOREIGN KEY (prf_prr_codigo)
REFERENCES pre_requisitos (prr_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE procedimentos_odontologicos
ADD CONSTRAINT pod_ato_fk FOREIGN KEY (pod_ato_numero)
REFERENCES autorizacoes_tratamentos_odont (ato_numero) ON DELETE SET NULL
/
ALTER TABLE procedimentos_odontologicos
ADD CONSTRAINT proced_odont_val_dependen FOREIGN KEY (pod_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE programacoes_ferias
ADD CONSTRAINT pfe_emp_fk FOREIGN KEY (pfe_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE provisoes_empregados
ADD CONSTRAINT prov_empreg_val_cadastros FOREIGN KEY (emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE qcd_area_atuacao
ADD CONSTRAINT qda_atu_fk FOREIGN KEY (qda_atu_codigo)
REFERENCES areas_de_atuacao (atu_codigo) ON DELETE SET NULL
/
ALTER TABLE qcd_area_atuacao
ADD CONSTRAINT qda_qcd_fk FOREIGN KEY (qda_qcd_hcd_dep_codigo, 
  qda_qcd_hcd_data_vigencia, qda_qcd_car_codigo, qda_qcd_car_codigo_nivel, 
  qda_qcd_car_occ_codigo)
REFERENCES quadro_cargos_dependencias (qcd_hcd_dep_codigo,qcd_hcd_data_vigencia,qcd_car_codigo,qcd_car_codigo_nivel,qcd_car_occ_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE qlp_area_atuacao
ADD CONSTRAINT qlp_atu_fk FOREIGN KEY (qla_atu_codigo)
REFERENCES areas_de_atuacao (atu_codigo) ON DELETE SET NULL
/
ALTER TABLE qlp_area_atuacao
ADD CONSTRAINT qlp_qlp_fk FOREIGN KEY (qla_qlp_icl_uor_codigo, 
  qla_qlp_icl_data_vigencia, qla_qlp_car_codigo, qla_qlp_car_codigo_nivel, 
  qla_qlp_car_occ_codigo)
REFERENCES quadros_lotacao_pessoal (qlp_icl_uor_codigo,qlp_icl_data_vigencia,qlp_car_codigo,qlp_car_codigo_nivel,qlp_car_occ_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE quadro_cargos_dependencias
ADD CONSTRAINT qcd_car_fk FOREIGN KEY (qcd_car_codigo, qcd_car_codigo_nivel, 
  qcd_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE quadro_cargos_dependencias
ADD CONSTRAINT qcd_hcd_fk FOREIGN KEY (qcd_hcd_dep_codigo, qcd_hcd_data_vigencia)
REFERENCES historico_cargos_dependencias (hcd_dep_codigo,hcd_data_vigencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE quadro_funcoes
ADD CONSTRAINT qfu_fun_fk FOREIGN KEY (qfu_fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
ALTER TABLE quadro_funcoes
ADD CONSTRAINT qfu_hfl_fk FOREIGN KEY (qfu_hfl_uor_codigo, qfu_hfl_data_vigencia)
REFERENCES historicos_funcoes_lotacoes (hfl_uor_codigo,hfl_data_vigencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE quadros_funcoes_dependencias
ADD CONSTRAINT qfd_fun_fk FOREIGN KEY (qfd_fun_codigo)
REFERENCES cargos_confianca (fun_codigo) ON DELETE SET NULL
/
ALTER TABLE quadros_funcoes_dependencias
ADD CONSTRAINT qfd_hfd_fk FOREIGN KEY (qfd_hfd_dep_codigo, qfd_hfd_data_vigencia)
REFERENCES historicos_funcoes_dependencia (hfd_dep_codigo,hfd_data_vigencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE quadros_lotacao_pessoal
ADD CONSTRAINT qlp_car_fk FOREIGN KEY (qlp_car_codigo, qlp_car_codigo_nivel, 
  qlp_car_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE quadros_lotacao_pessoal
ADD CONSTRAINT qlp_icl_fk FOREIGN KEY (qlp_icl_uor_codigo, qlp_icl_data_vigencia)
REFERENCES historico_cargos_lotacao (icl_uor_codigo,icl_data_vigencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE reajuste_percentual_13_ferias
ADD CONSTRAINT rdf_gru_fk FOREIGN KEY (rdf_gru_codigo)
REFERENCES grupos_rubricas (gru_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE reembolsos
ADD CONSTRAINT reembolsos_fk_dependencias FOREIGN KEY (ree_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE reembolsos
ADD CONSTRAINT ree_dpf_fk FOREIGN KEY (ree_emp_dep_codigo_fisico)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE reembolsos
ADD CONSTRAINT ree_emb_fk FOREIGN KEY (ree_emb_emp_numero_matricula, 
  ree_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE reembolsos
ADD CONSTRAINT ree_pvb_fk FOREIGN KEY (ree_emb_emp_numero_matricula, 
  ree_pvb_pvi_sequencial, ree_emb_ben_sigla, ree_pvb_adesao)
REFERENCES pessoas_vinculadas_benef (pvb_pvi_emp_numero_matricula,pvb_pvi_sequencial,emb_ben_sigla,pvb_adesao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resp_financeiro_psv
ADD CONSTRAINT rfp_psv_fk FOREIGN KEY (rfp_psv_sequencial)
REFERENCES pessoal_sem_vinculo (psv_sequencial) ON DELETE SET NULL
/
ALTER TABLE resp_financeiro_psv
ADD CONSTRAINT rfp_rfi_fk FOREIGN KEY (rfp_rfi_sequencial)
REFERENCES responsavel_financeiro (rfi_sequencial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resumo_encargos_infraprev
ADD CONSTRAINT rin_cad_fk FOREIGN KEY (rin_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resumo_encargos_inss
ADD CONSTRAINT rei_emp_fk FOREIGN KEY (rei_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resumo_encargos_inss_autonomo
ADD CONSTRAINT rea_cre_fk FOREIGN KEY (rea_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE resumo_encargos_inss_autonomo
ADD CONSTRAINT reia_dep_fk FOREIGN KEY (rea_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resumo_encargos_irrf
ADD CONSTRAINT rir_cad_fk FOREIGN KEY (rir_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE resumo_encargos_sal_educacao
ADD CONSTRAINT rse_cad_fk FOREIGN KEY (rse_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE rubricas
ADD CONSTRAINT rub_cc1_fk FOREIGN KEY (rub_cco_codigo)
REFERENCES conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE rubricas
ADD CONSTRAINT rub_indic_rub_adic_fk FOREIGN KEY (rub_indic_rub_adicional)
REFERENCES grupos_rubricas (gru_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE rubricas_anteriores
ADD CONSTRAINT rua_rub_fk FOREIGN KEY (rua_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE saldo_cobranca_aposentado
ADD CONSTRAINT sca_dep_fk FOREIGN KEY (sca_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE saldo_cobranca_aposentado
ADD CONSTRAINT sca_emp_fk FOREIGN KEY (sca_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_atribuicao_conceitos
ADD CONSTRAINT atrib_conc_avaliacao_fk FOREIGN KEY (ano_avaliador, 
  ano_avaliacao_final, matricula_avaliador, emp_numero_matricula)
REFERENCES siad_avaliacao (ano_avaliador,ano_avaliacao_final,matricula_avaliador,emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE siad_atribuicao_conceitos
ADD CONSTRAINT atrib_conc_conceitos_fk FOREIGN KEY (codigo_conceito, 
  codigo_formulario, ano_formulario, codigo_fator)
REFERENCES siad_conceitos_avaliacao (codigo_conceito,codigo_formulario,ano_formulario,codigo_fator) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_avaliacao
ADD CONSTRAINT avaliacao_avaliador_fk FOREIGN KEY (ano_avaliador, 
  matricula_avaliador)
REFERENCES siad_avaliador (ano_avaliador,matricula_avaliador) ON DELETE SET NULL
/
ALTER TABLE siad_avaliacao
ADD CONSTRAINT avaliacao_av_final_fk FOREIGN KEY (emp_numero_matricula, 
  ano_avaliacao_final)
REFERENCES siad_avaliacao_final (emp_numero_matricula,ano_avaliacao_final) ON DELETE SET NULL
/
ALTER TABLE siad_avaliacao
ADD CONSTRAINT avaliacao_formulario_fk FOREIGN KEY (ano_formulario, 
  codigo_formulario)
REFERENCES siad_formulario_avaliacao (ano_formulario,codigo_formulario) ON DELETE SET NULL
/
ALTER TABLE siad_avaliacao
ADD CONSTRAINT avaliacao_mot_nav_fk FOREIGN KEY (codigo_motivo)
REFERENCES siad_motivo_nao_avaliacao (codigo_motivo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_avaliacao_final
ADD CONSTRAINT av_final_escala_fk FOREIGN KEY (ano_escala, tipo_escala, 
  codigo_classificacao)
REFERENCES siad_escala_pontuacao (ano_escala,tipo_escala,codigo_classificacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_avaliacao_focos
ADD CONSTRAINT aval_focos_avaliacao_fk FOREIGN KEY (ano_avaliador, 
  ano_avaliacao_final, matricula_avaliador, emp_numero_matricula)
REFERENCES siad_avaliacao (ano_avaliador,ano_avaliacao_final,matricula_avaliador,emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE siad_avaliacao_focos
ADD CONSTRAINT aval_focos_focos_aten_fk FOREIGN KEY (ano_focos, codigo_focos)
REFERENCES siad_focos_atencao (ano_focos,codigo_focos) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_avaliacao_treinamento
ADD CONSTRAINT aval_trein_avaliacao_fk FOREIGN KEY (ano_avaliador, 
  ano_avaliacao_final, matricula_avaliador, emp_numero_matricula)
REFERENCES siad_avaliacao (ano_avaliador,ano_avaliacao_final,matricula_avaliador,emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE siad_avaliacao_treinamento
ADD CONSTRAINT aval_trein_treino_fk FOREIGN KEY (ano_treinamento, 
  codigo_treinamento)
REFERENCES siad_treinamento (ano_treinamento,codigo_treinamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_composicao_grupo
ADD CONSTRAINT comp_grupo_grupo_aval_fk FOREIGN KEY (ano_grupo_avaliacao, 
  codigo_grupo)
REFERENCES siad_grupo_avaliacao (ano_grupo_avaliacao,codigo_grupo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_conceitos_avaliacao
ADD CONSTRAINT conceitos_fatores_fk FOREIGN KEY (ano_formulario, 
  codigo_formulario, codigo_fator)
REFERENCES siad_fatores_avaliativos (ano_formulario,codigo_formulario,codigo_fator) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE siad_fatores_avaliativos
ADD CONSTRAINT fatores_formulario_fk FOREIGN KEY (ano_formulario, 
  codigo_formulario)
REFERENCES siad_formulario_avaliacao (ano_formulario,codigo_formulario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE sinistros
ADD CONSTRAINT sin_dep_res_fk FOREIGN KEY (sin_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE sinistros
ADD CONSTRAINT sin_emb_fk FOREIGN KEY (sin_emb_emp_numero_matricula, 
  sin_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE sinistros
ADD CONSTRAINT sin_pvb_fk FOREIGN KEY (sin_pvb_pvi_emp_numero_matric, 
  sin_pvb_pvi_sequencial, sin_pvb_emb_ben_sigla, sin_pvb_adesao)
REFERENCES pessoas_vinculadas_benef (pvb_pvi_emp_numero_matricula,pvb_pvi_sequencial,emb_ben_sigla,pvb_adesao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_empregado_ind_insuficienci
ADD CONSTRAINT eii_cadast_fk FOREIGN KEY (matricula_emp_indicado_ins)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_ind_insuficienci
ADD CONSTRAINT eii_indloc_fk FOREIGN KEY (ano_indicacao_ins, 
  cod_local_indicacao_ins, indicador_local_ins)
REFERENCES spf_local_indicacao (ano_indicacao,cod_local_indicacao,indicador_local) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_empregado_ind_promocao
ADD CONSTRAINT eip_cadatr_fk FOREIGN KEY (matricula_emp_indicado_prom)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_ind_promocao
ADD CONSTRAINT eip_indlocal_fk FOREIGN KEY (ano_indicacao_prom, 
  cod_local_indicacao_prom, indicador_local_prom)
REFERENCES spf_local_indicacao (ano_indicacao,cod_local_indicacao,indicador_local) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_empregado_nao_promovido
ADD CONSTRAINT emp_npromv_cadastros_fk FOREIGN KEY (
  cadastros_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_nao_promovido
ADD CONSTRAINT emp_npromv_motn_prom_fk FOREIGN KEY (motn_prom_ano_promocao, 
  motn_prom_cod_motivo_nao_promo, motn_prom_tipo_promocao)
REFERENCES spf_motivo_nao_promocao (ano_promocao,cod_motivo_nao_promocao,tipo_promocao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_empregado_promovido
ADD CONSTRAINT emp_prom_cadastros_fk FOREIGN KEY (cadastros_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_promovido
ADD CONSTRAINT emp_prom_cargos_fk FOREIGN KEY (cargos_car_codigo, 
  cargos_car_codigo_nivel, cargos_ocucargo_occ_codigo)
REFERENCES cargos (car_codigo,car_codigo_nivel,car_occ_codigo) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_promovido
ADD CONSTRAINT emp_prom_niveis_sal_fk FOREIGN KEY (niveis_sal_nsa_codigo_nivel, 
  niveis_sal_nsa_codigo_padrao, niveis_sal_nsa_indicador_nivel)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
ALTER TABLE spf_empregado_promovido
ADD CONSTRAINT emp_prom_promocao_fk FOREIGN KEY (promocao_tipos_ocor_ofu_codigo, 
  promocao_ano_promocao)
REFERENCES spf_promocao (tipos_ocor_ofu_codigo,ano_promocao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_faixa_promovida
ADD CONSTRAINT faixa_promocao_fk FOREIGN KEY (promocao_tipos_ocor_ofu_codigo, 
  promocao_ano_promocao)
REFERENCES spf_promocao (tipos_ocor_ofu_codigo,ano_promocao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_processo_judicial
ADD CONSTRAINT processos_cadastros_fk FOREIGN KEY (
  cadastros_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE spf_processo_judicial
ADD CONSTRAINT processos_tip_proc_fk FOREIGN KEY (tip_proc_tipo_processo_judicia)
REFERENCES spf_tipo_processo_judicial (tipo_processo_judicial) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE spf_promocao
ADD CONSTRAINT promocao_tipos_ocor_fk FOREIGN KEY (tipos_ocor_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tab_cesta_basica
ADD CONSTRAINT tab_cesta_basica_niveis_sal_fk FOREIGN KEY (tcb_nsa_codigo_nivel, 
  tcb_nsa_codigo_padrao, tcb_nsa_ind_nivel_escola)
REFERENCES niveis_salariais (nsa_codigo_nivel,nsa_codigo_padrao,nsa_indicador_nivel_escola) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tab_despesa_medicamentos
ADD CONSTRAINT tdm_gui_fk FOREIGN KEY (tdm_gui_doc_numero, 
  tdm_gui_doc_cbe_ben_sigla, tdm_gui_doc_cbe_cre_sequencial, 
  tdm_gui_doc_dep_codigo, tdm_gui_numero)
REFERENCES guias (gui_doc_numero,gui_doc_cbe_ben_sigla,gui_doc_cbe_cre_sequencial,gui_doc_dep_codigo,gui_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tab_parametros_detalhes
ADD CONSTRAINT fk_tab_para_relations_tab_para FOREIGN KEY (cod_grupo, 
  cod_assunto)
REFERENCES tab_parametros (cod_grupo,cod_assunto) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_cadastros_fk FOREIGN KEY (tpb_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_cc_fk FOREIGN KEY (tpb_cct_codigo)
REFERENCES centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_dep_fisica_fk FOREIGN KEY (tpb_dep_codigo_fisico)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_dep_lotacao_fk FOREIGN KEY (tpb_dep_codigo_lotacao)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_emp_benef_fk FOREIGN KEY (tpb_emp_numero_matricula, 
  tpb_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_pvi_fk FOREIGN KEY (tpb_emp_numero_matricula, 
  tpb_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
ALTER TABLE tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_rubricas_fk FOREIGN KEY (tpb_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_emp_fk FOREIGN KEY (mov_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_form_fk FOREIGN KEY (mov_for_codigo)
REFERENCES formulas (for_codigo) ON DELETE SET NULL
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula, 
  mov_pen_codigo)
REFERENCES pensionistas (pen_emp_numero_matricula,pen_codigo) ON DELETE SET NULL
/
ALTER TABLE temp_movimentacao
ADD CONSTRAINT temp_mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tipo_sinistro_doc
ADD CONSTRAINT tp_sdoc_sinistro1_fk FOREIGN KEY (tsd_dos_codigo_doc)
REFERENCES documentacao_sinistro (dos_codigo_doc) ON DELETE SET NULL
/
ALTER TABLE tipo_sinistro_doc
ADD CONSTRAINT tp_tipo_sinistro1_fk FOREIGN KEY (tsd_tis_codigo_tipo)
REFERENCES tipo_sinistro (tis_codigo_tipo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_indicador_tipo_fk FOREIGN KEY (ofu_indicador_tipo)
REFERENCES grupos_ocorrencias_funcionais (gof_codigo) ON DELETE SET NULL
/
ALTER TABLE tipos_ocorrencias
ADD CONSTRAINT ofu_ofu_fk FOREIGN KEY (ofu_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tipos_ocorrencias_rubricas
ADD CONSTRAINT tor_ofu_fk FOREIGN KEY (tor_ofu_codigo)
REFERENCES tipos_ocorrencias (ofu_codigo) ON DELETE SET NULL
/
ALTER TABLE tipos_ocorrencias_rubricas
ADD CONSTRAINT tor_rub_fk FOREIGN KEY (tor_rub_codigo)
REFERENCES rubricas (rub_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tipos_vinculos_beneficios
ADD CONSTRAINT ben_cod_vinculo_fk FOREIGN KEY (ben_cod_vinculo)
REFERENCES tipo_vinculos (tpv_codigo) ON DELETE SET NULL
/
ALTER TABLE tipos_vinculos_beneficios
ADD CONSTRAINT ben_sigla_beneficio_fk FOREIGN KEY (ben_sigla_beneficio)
REFERENCES beneficios (ben_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE tmp_dependencia_empregado
ADD CONSTRAINT tde_emp_fk FOREIGN KEY (tde_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE uor_fone_fax
ADD CONSTRAINT uff_uor_fk FOREIGN KEY (uff_uor_codigo)
REFERENCES unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE usuarios_linhas_transportes
ADD CONSTRAINT ult_emb_fk FOREIGN KEY (ult_emb_emp_numero_matricula, 
  ult_emb_ben_sigla)
REFERENCES empregados_beneficios (emb_emp_numero_matricula,emb_ben_sigla) ON DELETE SET NULL
/
ALTER TABLE usuarios_linhas_transportes
ADD CONSTRAINT ult_ltf_fk FOREIGN KEY (ult_ltf_numero, ult_ltf_dep_codigo)
REFERENCES linhas_transportes_fretados (ltf_numero,ltf_dep_codigo) ON DELETE SET NULL
/
ALTER TABLE usuarios_linhas_transportes
ADD CONSTRAINT usu_lin_trans_val_dependen FOREIGN KEY (ult_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE usuarios_planos_saude
ADD CONSTRAINT ups_cre_fk FOREIGN KEY (ups_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
ALTER TABLE usuarios_planos_saude
ADD CONSTRAINT ups_dep_fk FOREIGN KEY (ups_dep_codigo)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE usuarios_planos_saude
ADD CONSTRAINT ups_emp_fk FOREIGN KEY (ups_emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE valores_autorizados
ADD CONSTRAINT vau_amb_fk FOREIGN KEY (vau_amb_codigo, vau_amb_dv)
REFERENCES amb (amb_codigo,amb_dv) ON DELETE SET NULL
/
ALTER TABLE valores_autorizados
ADD CONSTRAINT vau_enq_fk FOREIGN KEY (vau_enq_numero)
REFERENCES enquadramentos (enq_numero) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE versao_objetos
ADD CONSTRAINT vo_ss_fk FOREIGN KEY (ver_cd_sistema)
REFERENCES seg_sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE vinculado_universitarios
ADD CONSTRAINT pessoas_vinc_mat_seq_fk FOREIGN KEY (viu_pvi_emp_numero_matricula, 
  viu_pvi_sequencial)
REFERENCES pessoas_vinculadas (pvi_emp_numero_matricula,pvi_sequencial) ON DELETE SET NULL
/
ALTER TABLE vinculado_universitarios
ADD CONSTRAINT viu_dep_fk FOREIGN KEY (viu_dep_resp_incl)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE vinculo_prestadora
ADD CONSTRAINT vip_cre_fk FOREIGN KEY (vip_cre_sequencial)
REFERENCES credenciados (cre_sequencial) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)
