alter table DATAPREV_REEMBOLSO_TEMP
add DAR_COD_BENEF_SEQUENCIAL  number(01) default 1 not null
/

ALTER TABLE DATAPREV_REEMBOLSO_TEMP
DROP PRIMARY KEY
/

ALTER TABLE DATAPREV_REEMBOLSO_TEMP
ADD CONSTRAINT DRT_PK PRIMARY KEY(DAR_ANO_REFERENCIA,DAR_MES_REFERENCIA,DAR_COD_BENEFICIO, DAR_COD_BENEF_SEQUENCIAL)
/

alter table DATAPREV_REEMBOLSO_RUBRICAS_TE
add DRR_EMP_NUMERO_MATRICULA         number(07)
/

alter table DATAPREV_REEMBOLSO_RUBRICAS_TE
add DRR_COD_BENEF_SEQUENCIAL           number(01)
/

ALTER TABLE DATAPREV_REEMBOLSO_RUBRICAS
ADD DRR_COD_BENEFICIO                         number(10)
/

ALTER TABLE DATAPREV_REEMBOLSO_RUBRICAS
ADD DRR_COD_BENEF_SEQUENCIAL        number(01)
/

ALTER TABLE DATAPREV_REEMBOLSO
ADD DAR_COD_BENEF_SEQUENCIAL number(01)  default 1 not null
/

ALTER TABLE dataprev_reembolso_rubricas
Drop CONSTRAINT drr_dr_fk
/

ALTER TABLE DATAPREV_REEMBOLSO
DROP PRIMARY KEY
/

alter TABLE DATAPREV_REEMBOLSO
add constraint DREE_PK primary key (dar_ano_referencia, dar_mes_referencia, 
  dar_emp_numero_matricula,DAR_COD_BENEFICIO,DAR_COD_BENEF_SEQUENCIAL)
/

ALTER TABLE dataprev_reembolso_rubricas
ADD CONSTRAINT drr_dr_fk FOREIGN KEY (drr_ano_referencia, drr_mes_referencia, 
  drr_emp_numero_matricula,drr_cod_beneficio,drr_cod_benef_sequencial)
REFERENCES dataprev_reembolso (dar_ano_referencia,dar_mes_referencia,dar_emp_numero_matricula,
DAR_COD_BENEFICIO,DAR_COD_BENEF_SEQUENCIAL) ON DELETE SET NULL
/
