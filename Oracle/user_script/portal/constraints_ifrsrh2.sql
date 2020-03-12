-- Start of DDL Script for Constraint IFRSRH.PFE_IN_ABONO_PECUN_1_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_1_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_1 IN ('S','N')                                           )
/

-- Start of DDL Script for Constraint ifrsrh2.PFE_IN_ABONO_PECUN_2_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_2_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_2 IN ('S','N')                                           )
/

-- Start of DDL Script for Constraint ifrsrh2.PFE_IN_ADIANT_FERIAS_1_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_1_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_1 IN ('S','N')                                        )
/

-- Start of DDL Script for Constraint ifrsrh2.PFE_IN_ADIANT_FERIAS_2_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_2_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_2 IN ('S','N')                                        )
/

-- Start of DDL Script for Constraint ifrsrh2.PFE_INDIC_13_SALARIO_1_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_1_ck CHECK ( PFE_INDICADOR_13_SALARIO_1 IN ('S','N')                                          )
/

-- Start of DDL Script for Constraint ifrsrh2.PFE_INDIC_13_SALARIO_2_CK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_2_ck CHECK ( PFE_INDICADOR_13_SALARIO_2 IN ('S','N')                                          )
/

-- Start of DDL Script for Constraint ifrsrh2.PROV_EMPREG_CHK_TP_PROVISAO
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.provisoes_empregados
ADD CONSTRAINT prov_empreg_chk_tp_provisao CHECK ( TIPO_PROVISAO IN (1,2)                                                           )
/



-- Start of DDL Script for Constraint ifrsrh2.RAC_PK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.reembolsos_auxilios_creches
ADD CONSTRAINT rac_pk PRIMARY KEY (rac_sequencial, data_inicio)
USING INDEX
  TABLESPACE  tsi_pessoal
/


-- Start of DDL Script for Constraint ifrsrh2.AES_DEP_FK
-- Generated 19-mai-2004 9:45:50 from IFRAD@homolog1

ALTER TABLE ifrsrh2.autorizacoes_especiais
ADD CONSTRAINT aes_dep_fk FOREIGN KEY (aes_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.CC_DEP_FK
-- Generated 19-mai-2004 9:45:50 from IFRAD@homolog1

ALTER TABLE ifrsrh2.credenciados_contratos
ADD CONSTRAINT cc_dep_fk FOREIGN KEY (cc_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.DOC_RI_FK
-- Generated 19-mai-2004 9:45:50 from IFRAD@homolog1

ALTER TABLE ifrsrh2.documentos_cobranca
ADD CONSTRAINT doc_ri_fk FOREIGN KEY (doc_ri_cod_receita, doc_ri_dat_inicio)
REFERENCES ifrsrh2.retencao_impostos (ri_cod_receita,ri_dat_inicio)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_QLP_FK
-- Generated 19-mai-2004 9:45:50 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_qlp_fk FOREIGN KEY (emp_qlp_hcl_uor_codigo, 
  emp_qlp_hcl_data_vigencia, emp_qlp_car_codigo, emp_qlp_car_codigo_nivel, 
  emp_qlp_car_occ_codigo)
REFERENCES ifrsrh2.quadros_lotacao_pessoal (qlp_icl_uor_codigo,qlp_icl_data_vigencia,qlp_car_codigo,qlp_car_codigo_nivel,qlp_car_occ_codigo)
DISABLE NOVALIDATE
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_QUADRO_ARMA_ESP_CODIGO_FK
-- Generated 19-mai-2004 9:45:50 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_quadro_arma_esp_codigo_fk FOREIGN KEY (
  emp_quadro_arma_esp_codigo)
REFERENCES ifrsrh2.quadro_arma_espec (qae_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_TVE_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_tve_fk FOREIGN KEY (emp_tve_cod_visto_estrang)
REFERENCES ifrsrh2.tipo_visto_estrangeiro (tve_cod_visto_estrang)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UFE_CTPS_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_ctps_fk FOREIGN KEY (emp_ufe_sigla_ctps)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UFE_ESTRANG_REG_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_estrang_reg_fk FOREIGN KEY (emp_ufe_sigla_estrangeiro)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UFE_PRIMEIRO_EMPREGO_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_primeiro_emprego_fk FOREIGN KEY (
  emp_ufe_sigla_primeiro_emprego)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UFE_REG_PROFIS_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_reg_profis_fk FOREIGN KEY (emp_ufe_sigla_reg_profis)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UFE_TIT_ELEITORAL_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_tit_eleitoral_fk FOREIGN KEY (emp_ufe_sigla_tit_eleitor)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/
-- Start of DDL Script for Constraint ifrsrh2.EMP_UOR1_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_uor1_fk FOREIGN KEY (emp_uor_codigo_lotacao)
REFERENCES ifrdba2.unidades_organizacionais (uor_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.HST_MOV_PEN_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.historico_movimentacao
ADD CONSTRAINT hst_mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula, 
  mov_pen_codigo)
REFERENCES ifrsrh2.pensionistas (pen_emp_numero_matricula,pen_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.IAB_DEP_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.indice_absenteismo
ADD CONSTRAINT iab_dep_fk FOREIGN KEY (iab_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.MOV_RUB_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.movimentacao
ADD CONSTRAINT mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES ifrsrh2.rubricas (rub_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.OEM_DEP_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_dep_fk FOREIGN KEY (oem_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.OEM_PFE_CONFIRM1_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm1_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm1, 
  oem_pfe_sequencial_confirm1)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/
-- Start of DDL Script for Constraint ifrsrh2.OEM_PFE_CONFIRM2_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm2_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm2, 
  oem_pfe_sequencial_confirm2)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/
-- Start of DDL Script for Constraint ifrsrh2.OEM_PFE_PROGRAM_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_program_fk FOREIGN KEY (oem_pfe_emp_num_matr_program, 
  oem_pfe_sequencial_program)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/
-- Start of DDL Script for Constraint ifrsrh2.OEM_UOR_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_uor_fk FOREIGN KEY (oem_uor_codigo)
REFERENCES ifrdba2.unidades_organizacionais (uor_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.OFE_DEP_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.ocorrencias_frequencia_emp
ADD CONSTRAINT ofe_dep_fk FOREIGN KEY (ofe_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.PVI_MUN_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.pessoas_vinculadas
ADD CONSTRAINT pvi_mun_fk FOREIGN KEY (pvi_mun_codigo_naturalidade, 
  pvi_ufe_sigla_naturalidade)
REFERENCES ifrdba2.municipios (mun_codigo,mun_ufe_sigla)
ENABLE NOVALIDATE
/
-- Start of DDL Script for Constraint ifrsrh2.PVI_PAI_CODIGO_FK
-- Generated 19-mai-2004 9:45:51 from IFRAD@homolog1

ALTER TABLE ifrsrh2.pessoas_vinculadas
ADD CONSTRAINT pvi_pai_codigo_fk FOREIGN KEY (pvi_pai_codigo)
REFERENCES ifrdba2.paises (pai_codigo)
/
-- Start of DDL Script for Constraint ifrsrh2.USU_LIN_TRANS_VAL_DEPENDEN
-- Generated 19-mai-2004 9:45:52 from IFRAD@homolog1

ALTER TABLE ifrsrh2.usuarios_linhas_transportes
ADD CONSTRAINT usu_lin_trans_val_dependen FOREIGN KEY (ult_dep_resp_incl)
REFERENCES ifrdba2.dependencias (dep_codigo)
/
-- End of DDL script for Foreign Key(s)
