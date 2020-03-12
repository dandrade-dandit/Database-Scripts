-- Start of DDL Script for Table IFR_RH_RSP.CAD_DUVIDA_FREQUENTE
-- Generated 15-fev-2005 10:52:07 from IFR_RH_RSP@INFRAERO

CREATE TABLE cad_duvida_frequente
    (seq_duvida_frequente           NUMBER(4,0) NOT NULL,
    seq_assunto_duvida_frequente   NUMBER(3,0) NOT NULL,
    dsc_titulo                     VARCHAR2(100) NOT NULL,
    dsc_duvida_frequente           VARCHAR2(1000) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON cad_duvida_frequente TO usr_srhrsp
/
GRANT INSERT ON cad_duvida_frequente TO usr_srhrsp
/
GRANT SELECT ON cad_duvida_frequente TO usr_srhrsp
/
GRANT UPDATE ON cad_duvida_frequente TO usr_srhrsp
/


-- Constraints for CAD_DUVIDA_FREQUENTE

ALTER TABLE cad_duvida_frequente
ADD CONSTRAINT dfq_pk PRIMARY KEY (seq_duvida_frequente)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Triggers for CAD_DUVIDA_FREQUENTE

CREATE OR REPLACE TRIGGER trg_dfq_i_b
 BEFORE
  INSERT
 ON cad_duvida_frequente
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val CAD_DUVIDA_FREQUENTE.SEQ_DUVIDA_FREQUENTE%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_CAD_DUVIDA_FREQUENTE.nextval
     Into   seq_val
     From   Dual;

	:NOVA.SEQ_DUVIDA_FREQUENTE := seq_val;

end;
/

-- Comments for CAD_DUVIDA_FREQUENTE

COMMENT ON COLUMN cad_duvida_frequente.dsc_duvida_frequente IS 'Descrição do assunto referente ao título da dúvida frequente'
/
COMMENT ON COLUMN cad_duvida_frequente.dsc_titulo IS 'Descrição de título de dúvida frequente'
/
COMMENT ON COLUMN cad_duvida_frequente.seq_assunto_duvida_frequente IS 'Código identificador único da tabela de Assunto de dúvida frequente vinda por FK'
/
COMMENT ON COLUMN cad_duvida_frequente.seq_duvida_frequente IS 'Código identificador único da tabela de dúvidas frequentes'
/

-- End of DDL Script for Table IFR_RH_RSP.CAD_DUVIDA_FREQUENTE

-- Start of DDL Script for Table IFR_RH_RSP.CAD_ENCAMINHAMENTO
-- Generated 15-fev-2005 10:52:07 from IFR_RH_RSP@INFRAERO

CREATE TABLE cad_encaminhamento
    (seq_encaminhamento             NUMBER(6,0) NOT NULL,
    num_protocolo                  NUMBER(6,0) NOT NULL,
    ano_protocolo                  NUMBER(4,0) NOT NULL,
    dat_encaminhamento             DATE NOT NULL,
    dsc_observacao                 VARCHAR2(300) NOT NULL,
    dat_resposta                   DATE,
    dsc_resposta                   VARCHAR2(1000),
    emp_numero_matricula           NUMBER(7,0) NOT NULL,
    flg_restrito                   VARCHAR2(1) NOT NULL,
    tip_status                     VARCHAR2(1) NOT NULL,
    end_email                      VARCHAR2(50) NOT NULL,
    dsc_user_insert                VARCHAR2(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON cad_encaminhamento TO usr_srhrsp
/
GRANT INSERT ON cad_encaminhamento TO usr_srhrsp
/
GRANT SELECT ON cad_encaminhamento TO usr_srhrsp
/
GRANT UPDATE ON cad_encaminhamento TO usr_srhrsp
/


-- Constraints for CAD_ENCAMINHAMENTO

ALTER TABLE cad_encaminhamento
ADD CONSTRAINT enc_flg_restrito_ck CHECK (FLG_RESTRITO in ('S','N')
)
/
ALTER TABLE cad_encaminhamento
ADD CONSTRAINT enc_pk PRIMARY KEY (seq_encaminhamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/
ALTER TABLE cad_encaminhamento
ADD CONSTRAINT enc_tip_status_ck CHECK (TIP_STATUS in ('P','F')
)
/

-- Triggers for CAD_ENCAMINHAMENTO

CREATE OR REPLACE TRIGGER trg_cen_i_b
 BEFORE
  INSERT
 ON cad_encaminhamento
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val CAD_ENCAMINHAMENTO.SEQ_ENCAMINHAMENTO%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_CAD_ENCAMINHAMENTO.nextval
     Into   seq_val
     From   Dual;

	:NOVA.SEQ_ENCAMINHAMENTO := seq_val;

end;
/

-- Comments for CAD_ENCAMINHAMENTO

COMMENT ON COLUMN cad_encaminhamento.ano_protocolo IS 'Parte do código identificador único da tabela de solicitações advindo por FK'
/
COMMENT ON COLUMN cad_encaminhamento.dat_encaminhamento IS 'Data de cadastro do encaminhamento da solicitação do DARH2 para seu destino'
/
COMMENT ON COLUMN cad_encaminhamento.dat_resposta IS 'Data de cadastro da resposta do encaminhamento da solicitação para o DARH2'
/
COMMENT ON COLUMN cad_encaminhamento.dsc_observacao IS 'Observação relativa ao encaminhamento da solicitação do DARH2 para seu destino'
/
COMMENT ON COLUMN cad_encaminhamento.dsc_resposta IS 'Descrição da resposta do encaminhamento da solicitação dada ao DARH2'
/
COMMENT ON COLUMN cad_encaminhamento.emp_numero_matricula IS 'Indicador do número da matrícula do empregado de DESTINO do encaminhamento advindo da tabela IFRSHR.CADASTROS por FK'
/
COMMENT ON COLUMN cad_encaminhamento.end_email IS 'Endereço de email específico para o Destino do encaminhamento, que tem como valor inicial o email padrão do usuário na tabela IFRSHR.CADASTROS'
/
COMMENT ON COLUMN cad_encaminhamento.flg_restrito IS 'Flag indicador de encaminhamento restrito (S) ou não restrito (N)'
/
COMMENT ON COLUMN cad_encaminhamento.num_protocolo IS 'Parte do código identificador único da tabela de solicitações advindo por FK'
/
COMMENT ON COLUMN cad_encaminhamento.seq_encaminhamento IS 'Código identificador único da tabela de encamnlhamentos de solicitações'
/
COMMENT ON COLUMN cad_encaminhamento.tip_status IS 'Valor de status do encaminhamento de uma solicitação: P-Pendente e F-Finalizado'
/

-- End of DDL Script for Table IFR_RH_RSP.CAD_ENCAMINHAMENTO

-- Start of DDL Script for Table IFR_RH_RSP.CAD_SOLICITACAO
-- Generated 15-fev-2005 10:52:07 from IFR_RH_RSP@INFRAERO

CREATE TABLE cad_solicitacao
    (num_protocolo                  NUMBER(6,0) NOT NULL,
    ano_protocolo                  NUMBER(4,0) NOT NULL,
    emp_numero_matricula           NUMBER(7,0),
    dat_solicitacao                DATE NOT NULL,
    seq_origem_solicitacao         NUMBER(2,0) NOT NULL,
    seq_tipo_solicitacao           NUMBER(2,0) NOT NULL,
    seq_assunto_solicitacao        NUMBER(2,0),
    tip_status                     VARCHAR2(1) NOT NULL,
    flg_anonima                    VARCHAR2(1) NOT NULL,
    dsc_solicitacao                VARCHAR2(1000) NOT NULL,
    end_email                      VARCHAR2(50),
    dat_resposta                   DATE,
    dsc_resposta                   VARCHAR2(1000),
    num_matricula_atend            NUMBER(7,0),
    dsc_user_insert                VARCHAR2(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON cad_solicitacao TO usr_srhrsp
/
GRANT INSERT ON cad_solicitacao TO usr_srhrsp
/
GRANT SELECT ON cad_solicitacao TO usr_srhrsp
/
GRANT UPDATE ON cad_solicitacao TO usr_srhrsp
/


-- Constraints for CAD_SOLICITACAO

ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_flg_anonima_ck CHECK (FLG_ANONIMA in ('S','N')
)
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_pk PRIMARY KEY (num_protocolo, ano_protocolo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_tip_status_ck CHECK (TIP_STATUS in ('A','T','E','R','F')
)
/

-- Comments for CAD_SOLICITACAO

COMMENT ON COLUMN cad_solicitacao.ano_protocolo IS 'Número amigável ao usuário que com o campo NUM_PROTOCOLO forma um identificador único da tabela de solicitações(número sequencial / Ano)'
/
COMMENT ON COLUMN cad_solicitacao.dat_resposta IS 'Data do cadastro da resposta da solicitação no sistema DARH Responde'
/
COMMENT ON COLUMN cad_solicitacao.dat_solicitacao IS 'Data do cadastro da solicitação no sistema DARH Responde'
/
COMMENT ON COLUMN cad_solicitacao.dsc_resposta IS 'Descrição relativa a resposta da solicitação cadastrada no sistema DARH Responde'
/
COMMENT ON COLUMN cad_solicitacao.dsc_solicitacao IS 'Descrição relativa a solicitação cadastrada no sistema DARH Responde'
/
COMMENT ON COLUMN cad_solicitacao.emp_numero_matricula IS 'Indicador do número da matrícula do empregado contratado(ATIVO) advindo da tabela IFRSHR.CADASTROS por FK'
/
COMMENT ON COLUMN cad_solicitacao.end_email IS 'Endereço de email específico para a Solicitação que tem como valor inicial o email padrão do usuário na tabela IFRSHR.CADASTROS'
/
COMMENT ON COLUMN cad_solicitacao.flg_anonima IS 'Flag indicador de solicitação anônima(S) ou não anônima(N)'
/
COMMENT ON COLUMN cad_solicitacao.num_matricula_atend IS 'Número da matrícula do funcionário responsável pelo atendimento da solicitação em questão - FK da tabela IFRSHR.CADASTROS'
/
COMMENT ON COLUMN cad_solicitacao.num_protocolo IS 'Número amigável ao usuário que com o campo ANO_PROTOCOLO forma um identificador único da tabela de solicitações(número sequencial / Ano)'
/
COMMENT ON COLUMN cad_solicitacao.seq_assunto_solicitacao IS 'Código identificador único da tabela de Assuntos de Solicitações advindo por fk'
/
COMMENT ON COLUMN cad_solicitacao.seq_origem_solicitacao IS 'Código identificador único da tabela de Origem de Solicitações advindo por fk'
/
COMMENT ON COLUMN cad_solicitacao.seq_tipo_solicitacao IS 'Código identificador único da tabela de Tipos de Solicitações advindo por fk'
/
COMMENT ON COLUMN cad_solicitacao.tip_status IS 'Valor de status da solicitação'
/

-- End of DDL Script for Table IFR_RH_RSP.CAD_SOLICITACAO

-- Start of DDL Script for Table IFR_RH_RSP.TAB_ASSUNTO_DUVIDA_FREQUENTE
-- Generated 15-fev-2005 10:52:08 from IFR_RH_RSP@INFRAERO

CREATE TABLE tab_assunto_duvida_frequente
    (seq_assunto_duvida_frequente   NUMBER(3,0) NOT NULL,
    dsc_assunto_duvida_frequente   VARCHAR2(100) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON tab_assunto_duvida_frequente TO usr_srhrsp
/
GRANT INSERT ON tab_assunto_duvida_frequente TO usr_srhrsp
/
GRANT SELECT ON tab_assunto_duvida_frequente TO usr_srhrsp
/
GRANT UPDATE ON tab_assunto_duvida_frequente TO usr_srhrsp
/


-- Constraints for TAB_ASSUNTO_DUVIDA_FREQUENTE

ALTER TABLE tab_assunto_duvida_frequente
ADD CONSTRAINT adf_pk PRIMARY KEY (seq_assunto_duvida_frequente)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Triggers for TAB_ASSUNTO_DUVIDA_FREQUENTE

CREATE OR REPLACE TRIGGER trg_adf_i_b
 BEFORE
  INSERT
 ON tab_assunto_duvida_frequente
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val TAB_ASSUNTO_DUVIDA_FREQUENTE.SEQ_ASSUNTO_DUVIDA_FREQUENTE%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_TAB_ASSUNTO_DFQ.nextval
     Into   seq_val
     From   Dual;

	:NOVA.SEQ_ASSUNTO_DUVIDA_FREQUENTE := Seq_val;

end;
/

-- Comments for TAB_ASSUNTO_DUVIDA_FREQUENTE

COMMENT ON COLUMN tab_assunto_duvida_frequente.dsc_assunto_duvida_frequente IS 'Descrição do assunto de dúvidas frequentes'
/
COMMENT ON COLUMN tab_assunto_duvida_frequente.seq_assunto_duvida_frequente IS 'Código identificador único da tabela de assuntos de dúvidas frequentes'
/

-- End of DDL Script for Table IFR_RH_RSP.TAB_ASSUNTO_DUVIDA_FREQUENTE

-- Start of DDL Script for Table IFR_RH_RSP.TAB_ASSUNTO_SOLICITACAO
-- Generated 15-fev-2005 10:52:08 from IFR_RH_RSP@INFRAERO

CREATE TABLE tab_assunto_solicitacao
    (seq_assunto_solicitacao        NUMBER(2,0) NOT NULL,
    dsc_assunto_solicitacao        VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON tab_assunto_solicitacao TO usr_srhrsp
/
GRANT INSERT ON tab_assunto_solicitacao TO usr_srhrsp
/
GRANT SELECT ON tab_assunto_solicitacao TO usr_srhrsp
/
GRANT UPDATE ON tab_assunto_solicitacao TO usr_srhrsp
/

-- Constraints for TAB_ASSUNTO_SOLICITACAO

ALTER TABLE tab_assunto_solicitacao
ADD CONSTRAINT aso_pk PRIMARY KEY (seq_assunto_solicitacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Triggers for TAB_ASSUNTO_SOLICITACAO

CREATE OR REPLACE TRIGGER trg_aso_i_b
 BEFORE
  INSERT
 ON tab_assunto_solicitacao
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val TAB_ASSUNTO_SOLICITACAO.SEQ_ASSUNTO_SOLICITACAO%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_TAB_ASSUNTO_SOLICITACAO.nextval
     Into   seq_val
     From   Dual;

:NOVA.SEQ_ASSUNTO_SOLICITACAO := seq_val;

end;
/

-- Comments for TAB_ASSUNTO_SOLICITACAO

COMMENT ON COLUMN tab_assunto_solicitacao.dsc_assunto_solicitacao IS 'Descrição dos assuntos de solicitações'
/
COMMENT ON COLUMN tab_assunto_solicitacao.seq_assunto_solicitacao IS 'Código identificador único da tabela de assuntos de solicitações'
/

-- End of DDL Script for Table IFR_RH_RSP.TAB_ASSUNTO_SOLICITACAO

-- Start of DDL Script for Table IFR_RH_RSP.TAB_ORIGEM_SOLICITACAO
-- Generated 15-fev-2005 10:52:08 from IFR_RH_RSP@INFRAERO

CREATE TABLE tab_origem_solicitacao
    (seq_origem_solicitacao         NUMBER(2,0) NOT NULL,
    dsc_origem_solicitacao         VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON tab_origem_solicitacao TO usr_srhrsp
/
GRANT INSERT ON tab_origem_solicitacao TO usr_srhrsp
/
GRANT SELECT ON tab_origem_solicitacao TO usr_srhrsp
/
GRANT UPDATE ON tab_origem_solicitacao TO usr_srhrsp
/

-- Constraints for TAB_ORIGEM_SOLICITACAO

ALTER TABLE tab_origem_solicitacao
ADD CONSTRAINT oso_pk PRIMARY KEY (seq_origem_solicitacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Triggers for TAB_ORIGEM_SOLICITACAO

CREATE OR REPLACE TRIGGER trg_oso_i_b
 BEFORE
  INSERT
 ON tab_origem_solicitacao
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val TAB_ORIGEM_SOLICITACAO.SEQ_ORIGEM_SOLICITACAO%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_TAB_ORIGEM_SOLICITACAO.nextval
     Into   seq_val
     From   Dual;

	:NOVA.SEQ_ORIGEM_SOLICITACAO := seq_val;

end;
/

-- Comments for TAB_ORIGEM_SOLICITACAO

COMMENT ON COLUMN tab_origem_solicitacao.dsc_origem_solicitacao IS 'Descrição das origens de solicitações'
/
COMMENT ON COLUMN tab_origem_solicitacao.seq_origem_solicitacao IS 'Código identificador único da tabela de origens de solicitações'
/

-- End of DDL Script for Table IFR_RH_RSP.TAB_ORIGEM_SOLICITACAO

-- Start of DDL Script for Table IFR_RH_RSP.TAB_TIPO_SOLICITACAO
-- Generated 15-fev-2005 10:52:08 from IFR_RH_RSP@INFRAERO

CREATE TABLE tab_tipo_solicitacao
    (seq_tipo_solicitacao           NUMBER(2,0) NOT NULL,
    dsc_tipo_solicitacao           VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Grants for Table
GRANT DELETE ON tab_tipo_solicitacao TO usr_srhrsp
/
GRANT INSERT ON tab_tipo_solicitacao TO usr_srhrsp
/
GRANT SELECT ON tab_tipo_solicitacao TO usr_srhrsp
/
GRANT UPDATE ON tab_tipo_solicitacao TO usr_srhrsp
/


-- Constraints for TAB_TIPO_SOLICITACAO

ALTER TABLE tab_tipo_solicitacao
ADD CONSTRAINT tso_pk PRIMARY KEY (seq_tipo_solicitacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal
  STORAGE   (
    INITIAL     65536
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

-- Triggers for TAB_TIPO_SOLICITACAO

CREATE OR REPLACE TRIGGER trg_tso_i_b
 BEFORE
  INSERT
 ON tab_tipo_solicitacao
REFERENCING NEW AS NOVA OLD AS OLD
 FOR EACH ROW
declare
    seq_val TAB_TIPO_SOLICITACAO.SEQ_TIPO_SOLICITACAO%TYPE;
begin

    Select  IFR_RH_RSP.SEQ_TAB_TIPO_SOLICITACAO.nextval
     Into   seq_val
     From   Dual;

:NOVA.SEQ_TIPO_SOLICITACAO := seq_val;

end;
/

-- Comments for TAB_TIPO_SOLICITACAO

COMMENT ON COLUMN tab_tipo_solicitacao.dsc_tipo_solicitacao IS 'Descrição do tipo de solicitação'
/
COMMENT ON COLUMN tab_tipo_solicitacao.seq_tipo_solicitacao IS 'Código identificador único da tabela de tipos de solicitações'
/

-- End of DDL Script for Table IFR_RH_RSP.TAB_TIPO_SOLICITACAO

-- Foreign Key
ALTER TABLE cad_duvida_frequente
ADD CONSTRAINT dfq_adf_fk FOREIGN KEY (seq_assunto_duvida_frequente)
REFERENCES tab_assunto_duvida_frequente (seq_assunto_duvida_frequente)
/
-- Foreign Key
ALTER TABLE cad_encaminhamento
ADD CONSTRAINT enc_sol_pk FOREIGN KEY (num_protocolo, ano_protocolo)
REFERENCES cad_solicitacao (num_protocolo,ano_protocolo)
/
ALTER TABLE cad_encaminhamento
ADD CONSTRAINT enc_cad FOREIGN KEY (emp_numero_matricula)
REFERENCES pessoal.cadastros (emp_numero_matricula)
/
-- Foreign Key
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_aso_fk FOREIGN KEY (seq_assunto_solicitacao)
REFERENCES tab_assunto_solicitacao (seq_assunto_solicitacao)
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_cad FOREIGN KEY (emp_numero_matricula)
REFERENCES cadastros (emp_numero_matricula)
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_cad_2 FOREIGN KEY (num_matricula_atend)
REFERENCES cadastros (emp_numero_matricula)
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_oso_fk FOREIGN KEY (seq_origem_solicitacao)
REFERENCES tab_origem_solicitacao (seq_origem_solicitacao)
/
ALTER TABLE cad_solicitacao
ADD CONSTRAINT sol_tso_fk FOREIGN KEY (seq_tipo_solicitacao)
REFERENCES tab_tipo_solicitacao (seq_tipo_solicitacao)
/
-- End of DDL script for Foreign Key(s)


-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_CAD_DUVIDA_FREQUENTE
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_cad_duvida_frequente
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_cad_duvida_frequente TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_CAD_DUVIDA_FREQUENTE

-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_CAD_ENCAMINHAMENTO
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_cad_encaminhamento
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_cad_encaminhamento TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_CAD_ENCAMINHAMENTO

-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ASSUNTO_DFQ
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_tab_assunto_dfq
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_tab_assunto_dfq TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ASSUNTO_DFQ

-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ASSUNTO_SOLICITACAO
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_tab_assunto_solicitacao
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_tab_assunto_solicitacao TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ASSUNTO_SOLICITACAO

-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ORIGEM_SOLICITACAO
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_tab_origem_solicitacao
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_tab_origem_solicitacao TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_ORIGEM_SOLICITACAO

-- Start of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_TIPO_SOLICITACAO
-- Generated 15-fev-2005 10:52:25 from IFR_RH_RSP@INFRAERO

CREATE SEQUENCE seq_tab_tipo_solicitacao
  INCREMENT BY 1
  START WITH 1
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  NOCYCLE
  NOORDER
  NOCACHE
/

-- Grants for Sequence
GRANT SELECT ON seq_tab_tipo_solicitacao TO usr_srhrsp
/

-- End of DDL Script for Sequence IFR_RH_RSP.SEQ_TAB_TIPO_SOLICITACAO



-- Start of DDL Script for Procedure IFR_RH_RSP.ENVIA_EMAIL
-- Generated 15-fev-2005 10:53:00 from IFR_RH_RSP@INFRAERO

CREATE OR REPLACE 
PROCEDURE envia_email (
   remetente      IN   VARCHAR2,
   destinatario   IN   VARCHAR2,
   assunto        IN   VARCHAR2,
   mensagem       IN   VARCHAR2
)
AS
   servidor       VARCHAR2 (100)      := 'ios.com.br';
   conexao_smtp   UTL_SMTP.connection;
BEGIN
   conexao_smtp := UTL_SMTP.open_connection (servidor); --  Abre conexão com o servidor SMTP
   UTL_SMTP.helo (conexao_smtp, servidor);              --  Executa o primeiro "HandShake"
   UTL_SMTP.mail (conexao_smtp, remetente);             --  Define o Remetente
   UTL_SMTP.rcpt (conexao_smtp, destinatario);          --  Define o destinatario
   UTL_SMTP.open_data (conexao_smtp);                   --  Abre a conexão para passagem de dados 
                                                        --      de cabeçalho e do corpo do email
   UTL_SMTP.write_data (conexao_smtp, 'From:' || remetente);    --  Envia o cabeçalho - Remetente
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'To:' || destinatario);   --  Envia o cabeçalho - Destinatário
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'Subject:' || assunto);   --  Envia o cabeçalho - Assunto
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || mensagem);    --  Envia o corpo do email, isto é, a 
                                                                    --  mensagem propriamente dita.
   UTL_SMTP.close_data (conexao_smtp);                  --  Fecha a conexão de dados com o servidor SMTP
   UTL_SMTP.quit (conexao_smtp);                        --  Finaliza a conexão do o servidor SMTP
EXCEPTION
   WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error
   THEN
      UTL_SMTP.quit (conexao_smtp);
      raise_application_error
                        (-20000,
                            'Failed tosend mail due to the following error: '
                         || SQLERRM
                        );
   WHEN OTHERS
   THEN
      raise_application_error (-20001,
                               'The following error has occured: ' || SQLERRM
                              );
END;
/

-- Grants for Procedure
GRANT EXECUTE ON envia_email TO usr_srhrsp
/


-- End of DDL Script for Procedure IFR_RH_RSP.ENVIA_EMAIL


