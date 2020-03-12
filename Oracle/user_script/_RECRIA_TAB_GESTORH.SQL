--DROP DAS TRIGGERS, INDICES E CONSTRAINTS ANTIGAS.
DROP TRIGGER ifrsrh2.trg_aud_oco_frequencia_emp
/

DROP TRIGGER ifrsrh2.trg_log_oco_frequencia_emp
/

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
DROP primary key 
/

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
DROP CONSTRAINT ofe_dep_fk
/

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
DROP CONSTRAINT ofe_ofu_fk
/

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
DROP CONSTRAINT ofe_ofe_fk
/

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
DROP CONSTRAINT ofe_emp_fk
/

DROP INDEX ifrsrh2.ind_ofe_2
/

DROP INDEX ifrsrh2.ofe_dep_fk
/

DROP INDEX ifrsrh2.ofe_ofe_fk
/

--ALTERAÇÃO DO NOME DA TABELAS.
alter table ifrsrh2.ocorrencias_frequencia_emp rename to HST_OCORRENCIAS_FREQ_EMP
/

--RECRIAÇÃO DA TABELAS E OBJETOS RELACIONADOS.
CREATE TABLE ifrsrh2.ocorrencias_frequencia_emp
    (ofe_emp_numero_matricula       NUMBER(7,0) NOT NULL,
    ofe_ofu_codigo                 NUMBER(4,0) NOT NULL,
    ofe_data_inicio                DATE NOT NULL,
    ofe_data_inclusao              DATE NOT NULL,
    ofe_data_termino               DATE,
    ofe_texto                      VARCHAR2(200),
    ofe_diploma_legal              VARCHAR2(100),
    ofe_diploma_legal_termino      VARCHAR2(100),
    ofe_ofe_emp_numero_matricula   NUMBER(7,0),
    ofe_ofe_ofu_codigo             NUMBER(3,0),
    ofe_ofe_data_inicio            DATE,
    ofe_dep_codigo                 NUMBER(4,0),
    ofe_mov_parametro              NUMBER(11,3),
    ofe_tipo_expediente            NUMBER(1,0),
    ofe_cod_horario_empregado      NUMBER(3,0),
    ofe_turno_trabalho_empregado   VARCHAR2(1),
    ofe_uor_codigo                 NUMBER(9,0),
    cod_usuario                    VARCHAR2(30)
  ,
  CONSTRAINT OFE_PK
  PRIMARY KEY (ofe_emp_numero_matricula, ofe_ofu_codigo, ofe_data_inicio)
  USING INDEX
  PCTFREE     20
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
  )
  PCTFREE     20
  PCTUSED     40
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_pessoal2
/

-- Grants for Table
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_02
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_02
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_02
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_02
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO rh_perfil_99
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO rh_perfil_99
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO rh_perfil_99
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO rh_perfil_99
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_18
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_18
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_18
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_18
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_17
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_17
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_17
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_17
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_01
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_01
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_01
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_01
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_03
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_03
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_03
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_03
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_04
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_05
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_06
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_06
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_06
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_06
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_10
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_09
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_14
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_07
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_08
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_99
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_99
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_99
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_99
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO siad_srh
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_ben_13
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_21
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_cad_22
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_consulta
/
GRANT DELETE ON ifrsrh2.ocorrencias_frequencia_emp TO usr_srh_db
/
GRANT INSERT ON ifrsrh2.ocorrencias_frequencia_emp TO usr_srh_db
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO usr_srh_db
/
GRANT UPDATE ON ifrsrh2.ocorrencias_frequencia_emp TO usr_srh_db
/
GRANT SELECT ON ifrsrh2.ocorrencias_frequencia_emp TO srh_dac_consulta
/



-- Indexes for IFRSRH2.OCORRENCIAS_FREQUENCIA_EMP

CREATE INDEX ifrsrh2.ind_ofeh_temp ON ifrsrh2.ocorrencias_freq_emp_hist
  (
    ofe_data_inicio                 ASC
  )
  PCTFREE     20
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
/

CREATE INDEX ifrsrh2.ofe_dep_fk ON ifrsrh2.ocorrencias_frequencia_emp
  (
    ofe_dep_codigo                  ASC
  )
  PCTFREE     20
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
/

CREATE INDEX ifrsrh2.ofe_ofe_fk ON ifrsrh2.ocorrencias_frequencia_emp
  (
    ofe_ofe_emp_numero_matricula    ASC,
    ofe_ofe_ofu_codigo              ASC,
    ofe_ofe_data_inicio             ASC
  )
  PCTFREE     20
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_indice
/



-- Constraints for IFRSRH2.OCORRENCIAS_FREQUENCIA_EMP


ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ck_1 CHECK (  ofe_turno_trabalho_empregado in ('A','B','C','D','F','N') )
/

-- Triggers for IFRSRH2.OCORRENCIAS_FREQUENCIA_EMP

CREATE OR REPLACE TRIGGER ifrsrh2.trg_aud_oco_frequencia_emp
 BEFORE
  INSERT
 ON ifrsrh2.ocorrencias_frequencia_emp
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
WHEN ( user <> 'SRH_SFP')
BEGIN
  --
  :NEW.cod_usuario  := USER;
  --
END; --End TRIGGER TRG_AUD_OCO_FREQUENCIA_EMP
/

CREATE OR REPLACE TRIGGER ifrsrh2.trg_log_oco_frequencia_emp
 BEFORE
  DELETE OR UPDATE
 ON ifrsrh2.ocorrencias_frequencia_emp
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


-- End of DDL Script for Table IFRSRH2.OCORRENCIAS_FREQUENCIA_EMP

-- Foreign Key
ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_dep_fk FOREIGN KEY (ofe_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ofu_fk FOREIGN KEY (ofe_ofu_codigo)
REFERENCES IFRSRH2.tipos_ocorrencias (ofu_codigo)
/
ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_ofe_fk FOREIGN KEY (ofe_ofe_emp_numero_matricula, 
  ofe_ofe_ofu_codigo, ofe_ofe_data_inicio)
REFERENCES IFRSRH2.ocorrencias_frequencia_emp (ofe_emp_numero_matricula,ofe_ofu_codigo,ofe_data_inicio)
/
ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_emp_fk FOREIGN KEY (ofe_emp_numero_matricula)
REFERENCES IFRSRH2.cadastros (emp_numero_matricula)
/
-- End of DDL script for Foreign Key(s)

--Carga dos Dados
insert into ocorrencias_frequencia_emp
select *
from ifrsrh2.ocorrencias_freq_emp_hist
where ofe_data_inicio between to_date('01/10/2004', 'DD/MM/YYYY') and to_date('15/10/2004', 'DD/MM/YYYY')
/

commit
/

insert into ocorrencias_frequencia_emp
select *
from ifrsrh2.ocorrencias_freq_emp_hist
where ofe_data_inicio between to_date('16/10/2004', 'DD/MM/YYYY') and to_date('31/10/2004', 'DD/MM/YYYY')
/

commit
/

insert into ocorrencias_frequencia_emp
select *
from ifrsrh2.ocorrencias_freq_emp_hist
where ofe_data_inicio between to_date('01/11/2004', 'DD/MM/YYYY') and to_date('15/11/2004', 'DD/MM/YYYY')
/

commit
/

insert into ocorrencias_frequencia_emp
select *
from ifrsrh2.ocorrencias_freq_emp_hist
where ofe_data_inicio > to_date('15/10/2004', 'DD/MM/YYYY')
/

commit
/

--Inclui Pk na historico

ALTER TABLE ifrsrh2.HST_OCORRENCIAS_FREQ_EMP
ADD CONSTRAINT HOFE_PK
  PRIMARY KEY (ofe_emp_numero_matricula, ofe_ofu_codigo, ofe_data_inicio)
/
