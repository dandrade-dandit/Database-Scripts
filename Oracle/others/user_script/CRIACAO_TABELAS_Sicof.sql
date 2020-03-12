
CREATE TABLE ifrdba2.movimento_operacional
 (
  dep_cd_dependencia         NUMBER(4) NOT NULL,
  vsp_cd_nivel_versao        VARCHAR2(2) NOT NULL,
  vsp_cd_versao              VARCHAR2(2) NOT NULL,
  vsp_nr_ano                 NUMBER(4) NOT NULL,
  nr_seq                     VARCHAR2(21) NOT NULL,
  cc1_nr_conta               VARCHAR2(20) NOT NULL,
  val_jan                    NUMBER(14,2),
  val_fev                    NUMBER(14,2),
  val_mar                    NUMBER(14,2),
  val_abr                    NUMBER(14,2),
  val_mai                    NUMBER(14,2),
  val_jun                    NUMBER(14,2),
  val_jul                    NUMBER(14,2),
  val_ago                    NUMBER(14,2),
  val_set                    NUMBER(14,2),
  val_out                    NUMBER(14,2),
  val_nov                    NUMBER(14,2),
  val_dez                    NUMBER(14,2),
  val_jan1                   NUMBER(14,2),
  val_fev1                   NUMBER(14,2),
  val_mar1                   NUMBER(14,2),
  val_abr1                   NUMBER(14,2),
  val_mai1                   NUMBER(14,2),
  val_jun1                   NUMBER(14,2),
  val_jul1                   NUMBER(14,2),
  val_ago1                   NUMBER(14,2),
  val_set1                   NUMBER(14,2),
  val_out1                   NUMBER(14,2),
  val_nov1                   NUMBER(14,2),
  val_dez1                   NUMBER(14,2),
  val_jan2                   NUMBER(14,2),
  val_fev2                   NUMBER(14,2),
  val_mar2                   NUMBER(14,2),
  val_abr2                   NUMBER(14,2),
  val_mai2                   NUMBER(14,2),
  val_jun2                   NUMBER(14,2),
  val_jul2                   NUMBER(14,2),
  val_ago2                   NUMBER(14,2),
  val_set2                   NUMBER(14,2),
  val_out2                   NUMBER(14,2),
  val_nov2                   NUMBER(14,2),
  val_dez2                   NUMBER(14,2),
  val_jan3                   NUMBER(14,2),
  val_fev3                   NUMBER(14,2),
  val_mar3                   NUMBER(14,2),
  val_abr3                   NUMBER(14,2),
  val_mai3                   NUMBER(14,2),
  val_jun3                   NUMBER(14,2),
  val_jul3                   NUMBER(14,2),
  val_ago3                   NUMBER(14,2),
  val_set3                   NUMBER(14,2),
  val_out3                   NUMBER(14,2),
  val_nov3                   NUMBER(14,2),
  val_dez3                   NUMBER(14,2),
  val_jan4                   NUMBER(14,2),
  val_fev4                   NUMBER(14,2),
  val_mar4                   NUMBER(14,2),
  val_abr4                   NUMBER(14,2),
  val_mai4                   NUMBER(14,2),
  val_jun4                   NUMBER(14,2),
  val_jul4                   NUMBER(14,2),
  val_ago4                   NUMBER(14,2),
  val_set4                   NUMBER(14,2),
  val_out4                   NUMBER(14,2),
  val_nov4                   NUMBER(14,2),
  val_dez4                   NUMBER(14,2)
 )
/

ALTER TABLE ifrdba2.movimento_operacional
 ADD CONSTRAINT mop_pk PRIMARY KEY (dep_cd_dependencia,vsp_cd_nivel_versao,vsp_cd_versao,
 vsp_nr_ano,nr_seq)
 USING INDEX
 TABLESPACE TS_INDICE
/

ALTER TABLE ifrdba2.movimento_operacional
 ADD CONSTRAINT mop_cc1_fk FOREIGN KEY (cc1_nr_conta)
      REFERENCES ifrdba2.conta_contabil(nr_conta) 
/

ALTER TABLE ifrdba2.movimento_operacional
 ADD CONSTRAINT mop_dep_fk FOREIGN KEY (dep_cd_dependencia)
      REFERENCES ifrdba2.dependencias(dep_codigo) 
/


GRANT DELETE,INSERT,SELECT,UPDATE ON movimento_operacional TO orc_emp_dfot1;
GRANT DELETE,INSERT,SELECT,UPDATE ON movimento_operacional TO orc_ger_geral;
GRANT DELETE,INSERT,SELECT,UPDATE ON movimento_operacional TO orc_ger_orc;
GRANT DELETE,INSERT,SELECT,UPDATE ON movimento_operacional TO orc_ger_orc_sede;
GRANT DELETE,INSERT,SELECT,UPDATE ON movimento_operacional TO orc_ger_usr;
GRANT SELECT ON movimento_operacional TO orc_sup;
GRANT SELECT ON movimento_operacional TO orc_usr;
GRANT SELECT ON movimento_operacional TO orc_dfot2;


CREATE PUBLIC SYNONYM movimento_operacional FOR IFRDBA2.movimento_operacional
/

INSERT INTO TABELAS VALUES('SOFORC','movimento_operacional','IFRDBA2','TABELA')
/
