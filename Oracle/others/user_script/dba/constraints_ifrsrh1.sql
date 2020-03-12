-- Start of DDL Script for Constraint IFRSRH.PFE_PK
-- Generated 18/5/2004 11:58:10 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_pk PRIMARY KEY (pfe_emp_numero_matricula, pfe_sequencial)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.PROVISIONAMENTO_PK
-- Generated 18/5/2004 11:58:11 from IFRAD@homolog1

ALTER TABLE ifrsrh2.provisionamento
ADD CONSTRAINT provisionamento_pk PRIMARY KEY (ano, mes, seq, dep_codigo, custo, 
  conta, matricula, tipo_prov)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.PROVISOES_EMPREGADOS_PK
-- Generated 18/5/2004 11:58:11 from IFRAD@homolog1

ALTER TABLE ifrsrh2.provisoes_empregados
ADD CONSTRAINT provisoes_empregados_pk PRIMARY KEY (ano_referencia, 
  mes_referencia, num_versao, emp_numero_matricula, tipo_provisao)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QAE_CODIGO_PK
-- Generated 18/5/2004 11:58:12 from IFRAD@homolog1

ALTER TABLE ifrsrh2.quadro_arma_espec
ADD CONSTRAINT qae_codigo_pk PRIMARY KEY (qae_codigo)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QCD_PK
-- Generated 18/5/2004 11:58:12 from IFRAD@homolog1

ALTER TABLE ifrsrh2.quadro_cargos_dependencias
ADD CONSTRAINT qcd_pk PRIMARY KEY (qcd_hcd_dep_codigo, qcd_hcd_data_vigencia, 
  qcd_car_codigo, qcd_car_codigo_nivel, qcd_car_occ_codigo)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QDA_PK
-- Generated 18/5/2004 11:58:13 from IFRAD@homolog1

ALTER TABLE ifrsrh2.qcd_area_atuacao
ADD CONSTRAINT qda_pk PRIMARY KEY (qda_atu_codigo, qda_qcd_hcd_dep_codigo, 
  qda_qcd_hcd_data_vigencia, qda_qcd_car_codigo, qda_qcd_car_codigo_nivel, 
  qda_qcd_car_occ_codigo, qda_data_vigencia)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QFD_PK
-- Generated 18/5/2004 11:58:13 from IFRAD@homolog1

ALTER TABLE ifrsrh2.quadros_funcoes_dependencias
ADD CONSTRAINT qfd_pk PRIMARY KEY (qfd_hfd_dep_codigo, qfd_hfd_data_vigencia, 
  qfd_fun_codigo)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QFU_PK
-- Generated 18/5/2004 11:58:13 from IFRAD@homolog1

ALTER TABLE ifrsrh2.quadro_funcoes
ADD CONSTRAINT qfu_pk PRIMARY KEY (qfu_fun_codigo, qfu_hfl_uor_codigo, 
  qfu_hfl_data_vigencia)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QLA_PK
-- Generated 18/5/2004 11:58:14 from IFRAD@homolog1

ALTER TABLE ifrsrh2.qlp_area_atuacao
ADD CONSTRAINT qla_pk PRIMARY KEY (qla_atu_codigo, qla_qlp_icl_uor_codigo, 
  qla_qlp_icl_data_vigencia, qla_qlp_car_codigo, qla_qlp_car_codigo_nivel, 
  qla_qlp_car_occ_codigo, qla_data_vigencia)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.QLP_PK
-- Generated 18/5/2004 11:58:14 from IFRAD@homolog1

ALTER TABLE ifrsrh2.quadros_lotacao_pessoal
ADD CONSTRAINT qlp_pk PRIMARY KEY (qlp_icl_uor_codigo, qlp_icl_data_vigencia, 
  qlp_car_codigo, qlp_car_codigo_nivel, qlp_car_occ_codigo)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.RAA_PK
-- Generated 18/5/2004 11:58:15 from IFRAD@homolog1

ALTER TABLE ifrsrh2.refer_auxilio_alimentacao
ADD CONSTRAINT raa_pk PRIMARY KEY (raa_falta, raa_quantidade)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.RDF_PK
-- Generated 18/5/2004 11:58:15 from IFRAD@homolog1

ALTER TABLE ifrsrh2.reajuste_percentual_13_ferias
ADD CONSTRAINT rdf_pk PRIMARY KEY (rdf_ano_referencia, rdf_mes_referencia, 
  rdf_gru_codigo)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.REE_PK
-- Generated 18/5/2004 11:58:16 from IFRAD@homolog1

ALTER TABLE ifrsrh2.reembolsos
ADD CONSTRAINT ree_pk PRIMARY KEY (ree_sequencial, ree_emb_emp_numero_matricula, 
  ree_mes, ree_ano, ree_tipo, ree_emb_ben_sigla)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.REF_PK
-- Generated 18/5/2004 11:58:16 from IFRAD@homolog1

ALTER TABLE ifrsrh2.resumo_encargos_fgts
ADD CONSTRAINT ref_pk PRIMARY KEY (ref_ano_referencia, ref_mes_referencia, 
  ref_versao_pagto, ref_emp_numero_matricula)
USING INDEX
  TABLESPACE  tsd_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.REI_PK
-- Generated 18/5/2004 11:58:17 from IFRAD@homolog1

ALTER TABLE ifrsrh2.resumo_encargos_inss
ADD CONSTRAINT rei_pk PRIMARY KEY (rei_ano_referencia, rei_mes_referencia, 
  rei_versao_pagto, rei_emp_numero_matricula)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.RFI_PK
-- Generated 18/5/2004 11:58:17 from IFRAD@homolog1

ALTER TABLE ifrsrh2.responsavel_financeiro
ADD CONSTRAINT rfi_pk PRIMARY KEY (rfi_sequencial)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.RFP_PK
-- Generated 18/5/2004 11:58:18 from IFRAD@homolog1

ALTER TABLE ifrsrh2.resp_financeiro_psv
ADD CONSTRAINT rfp_pk PRIMARY KEY (rfp_ano_referencia, "RFP_MÊS_REFERENCIA", 
  rfp_psv_sequencial, rfp_rfi_sequencial)
USING INDEX
  TABLESPACE  tsi_pessoal
/

-- Start of DDL Script for Constraint IFRSRH.RUB_CC1_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.rubricas
ADD CONSTRAINT rub_cc1_fk FOREIGN KEY (rub_cco_codigo)
REFERENCES IFRDBA2.conta_contabil (nr_conta)
/
-- Start of DDL Script for Constraint ifrsrh2.SCA_DEP_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.saldo_cobranca_aposentado
ADD CONSTRAINT sca_dep_fk FOREIGN KEY (sca_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.SIN_DEP_RES_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.sinistros
ADD CONSTRAINT sin_dep_res_fk FOREIGN KEY (sin_dep_resp_incl)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TAB_PART_BEN_CC_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_cc_fk FOREIGN KEY (tpb_cct_codigo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo)
/
-- Start of DDL Script for Constraint ifrsrh2.TAB_PART_BEN_DEP_FISICA_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_dep_fisica_fk FOREIGN KEY (tpb_dep_codigo_fisico)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TAB_PART_BEN_DEP_LOTACAO_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_dep_lotacao_fk FOREIGN KEY (tpb_dep_codigo_lotacao)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TAB_PART_BEN_RUBRICAS_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tab_participacao_beneficio
ADD CONSTRAINT tab_part_ben_rubricas_fk FOREIGN KEY (tpb_rub_codigo)
REFERENCES ifrsrh2.rubricas (rub_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TDC_DEP_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tab_doc_cobranca
ADD CONSTRAINT tdc_dep_fk FOREIGN KEY (tdc_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TEMP_MOV_RUB_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.temp_movimentacao
ADD CONSTRAINT temp_mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES ifrsrh2.rubricas (rub_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.TOR_RUB_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.tipos_ocorrencias_rubricas
ADD CONSTRAINT tor_rub_fk FOREIGN KEY (tor_rub_codigo)
REFERENCES ifrsrh2.rubricas (rub_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.UFF_UOR_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.uor_fone_fax
ADD CONSTRAINT uff_uor_fk FOREIGN KEY (uff_uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.UPS_DEP_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.usuarios_planos_saude
ADD CONSTRAINT ups_dep_fk FOREIGN KEY (ups_dep_codigo)
REFERENCES IFRdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.VIU_DEP_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.vinculado_universitarios
ADD CONSTRAINT viu_dep_fk FOREIGN KEY (viu_dep_resp_incl)
REFERENCES IFRdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.VO_SS_FK
-- Generated 18/5/2004 11:54:35 from IFRAD@homolog1

ALTER TABLE ifrsrh2.versao_objetos
ADD CONSTRAINT vo_ss_fk FOREIGN KEY (ver_cd_sistema)
REFERENCES IFRDBA2.seg_sistema (cd_sistema)
ENABLE NOVALIDATE
/
-- End of DDL script for Foreign Key(s)
