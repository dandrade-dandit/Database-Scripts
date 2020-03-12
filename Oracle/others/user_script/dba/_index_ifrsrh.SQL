-- Start of DDL Script for Index IFRSRH.A13F_PK
-- Generated 12-mai-2004 21:42:48 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX a13f_pk ON adicional_13_ferias
  (
    a13f_ano                        ASC,
    a13f_mes                        ASC,
    a13f_cod_rubrica                ASC,
    a13f_emp_numero_matricula       ASC,
    a13f_sequencial                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.A13F_PK

-- Start of DDL Script for Index IFRSRH.AAC_PK
-- Generated 12-mai-2004 21:42:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aac_pk ON areas_atuacao_cargo
  (
    aac_atu_codigo                  ASC,
    aac_car_codigo                  ASC,
    aac_car_codigo_nivel            ASC,
    aac_car_occ_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.AAC_PK

-- Start of DDL Script for Index IFRSRH.ABO_LOCAL_PK
-- Generated 12-mai-2004 21:42:50 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX abo_local_pk ON abo_local
  (
    abl_codigo                      ASC,
    abl_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.ABO_LOCAL_PK

-- Start of DDL Script for Index IFRSRH.ABO_PK
-- Generated 12-mai-2004 21:42:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX abo_pk ON abo
  (
    abo_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ABO_PK

-- Start of DDL Script for Index IFRSRH.ABT_PK
-- Generated 12-mai-2004 21:42:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX abt_pk ON abatimento_averbacao
  (
    abt_codigo                      ASC,
    abt_avb_codigo                  ASC,
    abt_avb_emp_numero_matricula    ASC
  )
/


-- End of DDL Script for Index IFRSRH.ABT_PK

-- Start of DDL Script for Index IFRSRH.ACA_PK
-- Generated 12-mai-2004 21:42:53 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aca_pk ON atividades_cargos
  (
    aca_car_codigo                  ASC,
    aca_car_codigo_nivel            ASC,
    aca_car_occ_codigo              ASC,
    aca_ati_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ACA_PK

-- Start of DDL Script for Index IFRSRH.ACB_PK
-- Generated 12-mai-2004 21:42:54 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX acb_pk ON arquivo_credito_bancario
  (
    acb_egt_crp_ano_pagamento       ASC,
    acb_egt_crp_mes_pagamento       ASC,
    acb_egt_crp_sequencial          ASC,
    acb_sequencial                  ASC,
    acb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.ACB_PK

-- Start of DDL Script for Index IFRSRH.ACP_PK
-- Generated 12-mai-2004 21:42:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX acp_pk ON arquivo_credito_bancario_pens
  (
    egt_crp_ano_pagamento           ASC,
    egt_crp_mes_pagamento           ASC,
    egt_crp_sequencial              ASC,
    acp_sequencial                  ASC,
    acp_pen_emp_numero_matricula    ASC,
    acp_pen_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ACP_PK

-- Start of DDL Script for Index IFRSRH.ADE_PK
-- Generated 12-mai-2004 21:42:56 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ade_pk ON assinfra_dependencia
  (
    ade_cas_cnpj                    ASC,
    ade_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ADE_PK

-- Start of DDL Script for Index IFRSRH.AEC_PK
-- Generated 12-mai-2004 21:42:57 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aec_pk ON emprestimos_consignados
  (
    aec_ano_referencia              ASC,
    aec_mes_referencia              ASC,
    aec_emp_numero_matricula        ASC,
    aec_rub_codigo                  ASC,
    aec_num_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.AEC_PK

-- Start of DDL Script for Index IFRSRH.AEM_ATI_FK_I
-- Generated 12-mai-2004 21:42:58 from IFRSRH@PRODSEDE

CREATE INDEX aem_ati_fk_i ON atividades_empregados
  (
    aem_ati_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.AEM_ATI_FK_I

-- Start of DDL Script for Index IFRSRH.AEM_EMP_FK_I
-- Generated 12-mai-2004 21:42:59 from IFRSRH@PRODSEDE

CREATE INDEX aem_emp_fk_i ON atividades_empregados
  (
    aem_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.AEM_EMP_FK_I

-- Start of DDL Script for Index IFRSRH.AEM_PK
-- Generated 12-mai-2004 21:43:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aem_pk ON atividades_empregados
  (
    aem_emp_numero_matricula        ASC,
    aem_ati_codigo                  ASC,
    aem_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.AEM_PK

-- Start of DDL Script for Index IFRSRH.AES_PK
-- Generated 12-mai-2004 21:43:01 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aes_pk ON autorizacoes_especiais
  (
    aes_dep_codigo                  ASC,
    aes_emb_emp_numero_matricula    ASC,
    aes_emb_ben_sigla               ASC,
    aes_valor_autorizado            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AES_PK

-- Start of DDL Script for Index IFRSRH.AFA_PK
-- Generated 12-mai-2004 21:43:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX afa_pk ON afastamentos
  (
    afa_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.AFA_PK

-- Start of DDL Script for Index IFRSRH.AGM_PK
-- Generated 12-mai-2004 21:43:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX agm_pk ON agendas_medicas
  (
    agm_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.AGM_PK

-- Start of DDL Script for Index IFRSRH.AGN_PK
-- Generated 12-mai-2004 21:43:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX agn_pk ON agentes_nocivos
  (
    agn_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.AGN_PK

-- Start of DDL Script for Index IFRSRH.AIM_PK
-- Generated 12-mai-2004 21:43:05 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aim_pk ON autorizacoes_itens_medicos
  (
    aim_asm_senha                   ASC,
    aim_cod_procedimento            ASC,
    aim_dv_procedimento             ASC
  )
/


-- End of DDL Script for Index IFRSRH.AIM_PK

-- Start of DDL Script for Index IFRSRH.AMB_LOCAL_PK
-- Generated 12-mai-2004 21:43:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX amb_local_pk ON amb_local
  (
    aml_codigo                      ASC,
    aml_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.AMB_LOCAL_PK

-- Start of DDL Script for Index IFRSRH.AMB_PK
-- Generated 12-mai-2004 21:43:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX amb_pk ON amb
  (
    amb_codigo                      ASC,
    amb_dv                          ASC
  )
/


-- End of DDL Script for Index IFRSRH.AMB_PK

-- Start of DDL Script for Index IFRSRH.AMO_PK
-- Generated 12-mai-2004 21:43:07 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX amo_pk ON assinfra_movimentacao
  (
    amo_mes_referencia              ASC,
    amo_ano_referencia              ASC,
    amo_versao                      ASC,
    amo_ade_cas_cnpj                ASC,
    amo_ade_dep_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.AMO_PK

-- Start of DDL Script for Index IFRSRH.ANS_PK
-- Generated 12-mai-2004 21:43:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ans_pk ON ans
  (
    ans_dt_gera_arq                 ASC,
    ans_cod_arq                     ASC,
    ans_operacao                    ASC,
    ans_beneficiario                ASC
  )
/


-- End of DDL Script for Index IFRSRH.ANS_PK

-- Start of DDL Script for Index IFRSRH.ANU_PK
-- Generated 12-mai-2004 21:43:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX anu_pk ON anuenios
  (
    anu_quantidade_ano              ASC
  )
/


-- End of DDL Script for Index IFRSRH.ANU_PK

-- Start of DDL Script for Index IFRSRH.APROFOP_PK
-- Generated 12-mai-2004 21:43:10 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aprofop_pk ON aprofop
  (
    ano_referencia                  ASC,
    mes_referencia                  ASC,
    seq_referencia                  ASC,
    dep_lotacao                     ASC,
    centro_custo                    ASC,
    deb_cred                        ASC,
    conta                           ASC,
    empregado                       ASC,
    valor                           ASC
  )
/


-- End of DDL Script for Index IFRSRH.APROFOP_PK

-- Start of DDL Script for Index IFRSRH.APROFOPENC_PK
-- Generated 12-mai-2004 21:43:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aprofopenc_pk ON aprofopenc
  (
    ano_referencia                  ASC,
    mes_referencia                  ASC,
    seq_referencia                  ASC,
    dependencia                     ASC,
    conta_contabil                  ASC,
    centro_custo                    ASC,
    empregado                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.APROFOPENC_PK

-- Start of DDL Script for Index IFRSRH.APROVADOR_VIAGEM_EMPREGADO_PK
-- Generated 12-mai-2004 21:43:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aprovador_viagem_empregado_pk ON aprovador_viagem_empregado
  (
    ave_emp_numero_matricula        ASC,
    ave_emp_nro_matricula_viajante  ASC,
    ave_data_inicio                 ASC,
    ave_uor_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.APROVADOR_VIAGEM_EMPREGADO_PK

-- Start of DDL Script for Index IFRSRH.APV_PK
-- Generated 12-mai-2004 21:43:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX apv_pk ON aprovador_viagem
  (
    avi_uor_codigo                  ASC,
    avi_data_inicio                 ASC,
    avi_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.APV_PK

-- Start of DDL Script for Index IFRSRH.APVT_PK
-- Generated 12-mai-2004 21:43:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX apvt_pk ON aprovador_viagem_tipo
  (
    avi_uor_codigo                  ASC,
    avi_data_inicio                 ASC,
    avi_ofu_codigo                  ASC,
    avi_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.APVT_PK

-- Start of DDL Script for Index IFRSRH.ARS_PK
-- Generated 12-mai-2004 21:43:15 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ars_pk ON faixa_arsaprev
  (
    ars_mes                         ASC,
    ars_ano                         ASC,
    ars_plano                       ASC,
    ars_faixa                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.ARS_PK

-- Start of DDL Script for Index IFRSRH.ASM_PK
-- Generated 12-mai-2004 21:43:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX asm_pk ON autorizacoes_servicos_medicos
  (
    asm_senha                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.ASM_PK

-- Start of DDL Script for Index IFRSRH.ATF_CODIGO_PK
-- Generated 12-mai-2004 21:43:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX atf_codigo_pk ON atividades_funcoes
  (
    atf_fun_codigo                  ASC,
    atf_ati_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATF_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.ATI_PK
-- Generated 12-mai-2004 21:43:19 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ati_pk ON atividades
  (
    ati_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATI_PK

-- Start of DDL Script for Index IFRSRH.ATO_EMB_FK
-- Generated 12-mai-2004 21:43:21 from IFRSRH@PRODSEDE

CREATE INDEX ato_emb_fk ON autorizacoes_tratamentos_odont
  (
    ato_emb_emp_numero_matricula    ASC,
    ato_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATO_EMB_FK

-- Start of DDL Script for Index IFRSRH.ATO_PK
-- Generated 12-mai-2004 21:43:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ato_pk ON autorizacoes_tratamentos_odont
  (
    ato_numero                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATO_PK

-- Start of DDL Script for Index IFRSRH.ATRIB_CONC_AVALIACAO_FK_I
-- Generated 12-mai-2004 21:43:25 from IFRSRH@PRODSEDE

CREATE INDEX atrib_conc_avaliacao_fk_i ON siad_atribuicao_conceitos
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATRIB_CONC_AVALIACAO_FK_I

-- Start of DDL Script for Index IFRSRH.ATRIB_CONC_CONCEITOS_FK_I
-- Generated 12-mai-2004 21:43:26 from IFRSRH@PRODSEDE

CREATE INDEX atrib_conc_conceitos_fk_i ON siad_atribuicao_conceitos
  (
    codigo_conceito                 ASC,
    codigo_formulario               ASC,
    ano_formulario                  ASC,
    codigo_fator                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATRIB_CONC_CONCEITOS_FK_I

-- Start of DDL Script for Index IFRSRH.ATRIB_CONC_PK
-- Generated 12-mai-2004 21:43:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX atrib_conc_pk ON siad_atribuicao_conceitos
  (
    codigo_conceito                 ASC,
    codigo_fator                    ASC,
    ano_formulario                  ASC,
    codigo_formulario               ASC,
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATRIB_CONC_PK

-- Start of DDL Script for Index IFRSRH.ATU_PK
-- Generated 12-mai-2004 21:43:28 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX atu_pk ON areas_de_atuacao
  (
    atu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATU_PK

-- Start of DDL Script for Index IFRSRH.ATU_UK
-- Generated 12-mai-2004 21:43:31 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX atu_uk ON areas_de_atuacao
  (
    atu_descricao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.ATU_UK

-- Start of DDL Script for Index IFRSRH.AUO_PK
-- Generated 12-mai-2004 21:43:32 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX auo_pk ON areas_atuacao_unid_organiz
  (
    auo_atu_codigo                  ASC,
    auo_uor_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.AUO_PK

-- Start of DDL Script for Index IFRSRH.AV_FINAL_CADASTROS_FK_I
-- Generated 12-mai-2004 21:43:34 from IFRSRH@PRODSEDE

CREATE INDEX av_final_cadastros_fk_i ON siad_avaliacao_final
  (
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AV_FINAL_CADASTROS_FK_I

-- Start of DDL Script for Index IFRSRH.AV_FINAL_PK
-- Generated 12-mai-2004 21:43:35 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX av_final_pk ON siad_avaliacao_final
  (
    emp_numero_matricula            ASC,
    ano_avaliacao_final             ASC
  )
/


-- End of DDL Script for Index IFRSRH.AV_FINAL_PK

-- Start of DDL Script for Index IFRSRH.AVAL_FOCOS_AVALIACAO_FK_I
-- Generated 12-mai-2004 21:43:37 from IFRSRH@PRODSEDE

CREATE INDEX aval_focos_avaliacao_fk_i ON siad_avaliacao_focos
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_FOCOS_AVALIACAO_FK_I

-- Start of DDL Script for Index IFRSRH.AVAL_FOCOS_FOCOS_ATEN_FK_I
-- Generated 12-mai-2004 21:43:38 from IFRSRH@PRODSEDE

CREATE INDEX aval_focos_focos_aten_fk_i ON siad_avaliacao_focos
  (
    ano_focos                       ASC,
    codigo_focos                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_FOCOS_FOCOS_ATEN_FK_I

-- Start of DDL Script for Index IFRSRH.AVAL_FOCOS_PK
-- Generated 12-mai-2004 21:43:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aval_focos_pk ON siad_avaliacao_focos
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC,
    ano_focos                       ASC,
    codigo_focos                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_FOCOS_PK

-- Start of DDL Script for Index IFRSRH.AVAL_TREIN_AVALIACAO_FK_I
-- Generated 12-mai-2004 21:43:40 from IFRSRH@PRODSEDE

CREATE INDEX aval_trein_avaliacao_fk_i ON siad_avaliacao_treinamento
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_TREIN_AVALIACAO_FK_I

-- Start of DDL Script for Index IFRSRH.AVAL_TREIN_PK
-- Generated 12-mai-2004 21:43:41 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX aval_trein_pk ON siad_avaliacao_treinamento
  (
    ano_treinamento                 ASC,
    codigo_treinamento              ASC,
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_TREIN_PK

-- Start of DDL Script for Index IFRSRH.AVAL_TREIN_TREINO_FK_I
-- Generated 12-mai-2004 21:43:43 from IFRSRH@PRODSEDE

CREATE INDEX aval_trein_treino_fk_i ON siad_avaliacao_treinamento
  (
    ano_treinamento                 ASC,
    codigo_treinamento              ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVAL_TREIN_TREINO_FK_I

-- Start of DDL Script for Index IFRSRH.AVALIACAO_AV_FINAL_FK_I
-- Generated 12-mai-2004 21:43:44 from IFRSRH@PRODSEDE

CREATE INDEX avaliacao_av_final_fk_i ON siad_avaliacao
  (
    emp_numero_matricula            ASC,
    ano_avaliacao_final             ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIACAO_AV_FINAL_FK_I

-- Start of DDL Script for Index IFRSRH.AVALIACAO_AVALIADOR_FK_I
-- Generated 12-mai-2004 21:43:45 from IFRSRH@PRODSEDE

CREATE INDEX avaliacao_avaliador_fk_i ON siad_avaliacao
  (
    ano_avaliador                   ASC,
    matricula_avaliador             ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIACAO_AVALIADOR_FK_I

-- Start of DDL Script for Index IFRSRH.AVALIACAO_FORMULARIO_FK_I
-- Generated 12-mai-2004 21:43:46 from IFRSRH@PRODSEDE

CREATE INDEX avaliacao_formulario_fk_i ON siad_avaliacao
  (
    ano_formulario                  ASC,
    codigo_formulario               ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIACAO_FORMULARIO_FK_I

-- Start of DDL Script for Index IFRSRH.AVALIACAO_MOT_NAV_FK_I
-- Generated 12-mai-2004 21:43:47 from IFRSRH@PRODSEDE

CREATE INDEX avaliacao_mot_nav_fk_i ON siad_avaliacao
  (
    codigo_motivo                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIACAO_MOT_NAV_FK_I

-- Start of DDL Script for Index IFRSRH.AVALIACAO_PK
-- Generated 12-mai-2004 21:43:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX avaliacao_pk ON siad_avaliacao
  (
    ano_avaliador                   ASC,
    ano_avaliacao_final             ASC,
    matricula_avaliador             ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIACAO_PK

-- Start of DDL Script for Index IFRSRH.AVALIADOR_PK
-- Generated 12-mai-2004 21:43:50 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX avaliador_pk ON siad_avaliador
  (
    ano_avaliador                   ASC,
    matricula_avaliador             ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVALIADOR_PK

-- Start of DDL Script for Index IFRSRH.AVB_PK
-- Generated 12-mai-2004 21:43:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX avb_pk ON averbacao_tservico
  (
    avb_codigo                      ASC,
    avb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.AVB_PK

-- Start of DDL Script for Index IFRSRH.BEN_COD_VINCULO_BENEFICIO
-- Generated 12-mai-2004 21:43:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ben_cod_vinculo_beneficio ON tipos_vinculos_beneficios
  (
    ben_cod_vinculo                 ASC,
    ben_sigla_beneficio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.BEN_COD_VINCULO_BENEFICIO

-- Start of DDL Script for Index IFRSRH.BEN_IDX_FK_I
-- Generated 12-mai-2004 21:43:53 from IFRSRH@PRODSEDE

CREATE INDEX ben_idx_fk_i ON beneficios
  (
    ben_idx_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.BEN_IDX_FK_I

-- Start of DDL Script for Index IFRSRH.BEN_PK
-- Generated 12-mai-2004 21:43:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ben_pk ON beneficios
  (
    ben_sigla                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.BEN_PK

-- Start of DDL Script for Index IFRSRH.BEN_RUB_FK_I
-- Generated 12-mai-2004 21:43:56 from IFRSRH@PRODSEDE

CREATE INDEX ben_rub_fk_i ON beneficios
  (
    ben_rub_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.BEN_RUB_FK_I

-- Start of DDL Script for Index IFRSRH.BNF_ABA_FK_I
-- Generated 12-mai-2004 21:43:57 from IFRSRH@PRODSEDE

CREATE INDEX bnf_aba_fk_i ON beneficiarios
  (
    bnf_aba_ban_codigo              ASC,
    bnf_aba_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.BNF_ABA_FK_I

-- Start of DDL Script for Index IFRSRH.BNF_PK
-- Generated 12-mai-2004 21:43:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX bnf_pk ON beneficiarios
  (
    bnf_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.BNF_PK

-- Start of DDL Script for Index IFRSRH.BNF_UK
-- Generated 12-mai-2004 21:44:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX bnf_uk ON beneficiarios
  (
    bnf_emp_numero_matricula        ASC,
    bnf_numero_cpf                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.BNF_UK

-- Start of DDL Script for Index IFRSRH.BSG_EMP_BEN_FK
-- Generated 12-mai-2004 21:44:01 from IFRSRH@PRODSEDE

CREATE INDEX bsg_emp_ben_fk ON beneficiarios_seguros
  (
    bsg_emb_emp_numero_matricula    ASC,
    bsg_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.BSG_EMP_BEN_FK

-- Start of DDL Script for Index IFRSRH.BSG_SEQUENCIAL_PK
-- Generated 12-mai-2004 21:44:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX bsg_sequencial_pk ON beneficiarios_seguros
  (
    bsg_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.BSG_SEQUENCIAL_PK

-- Start of DDL Script for Index IFRSRH.CAG_PK
-- Generated 12-mai-2004 21:44:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cag_pk ON caged
  (
    cag_emp_numero_matricula        ASC,
    cag_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CAG_PK

-- Start of DDL Script for Index IFRSRH.CAG_TIPO_MOVIMENTO_I
-- Generated 12-mai-2004 21:44:04 from IFRSRH@PRODSEDE

CREATE INDEX cag_tipo_movimento_i ON caged
  (
    cag_tipo_movimento              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CAG_TIPO_MOVIMENTO_I

-- Start of DDL Script for Index IFRSRH.CAR_PK
-- Generated 12-mai-2004 21:44:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX car_pk ON cargos
  (
    car_codigo                      ASC,
    car_codigo_nivel                ASC,
    car_occ_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CAR_PK

-- Start of DDL Script for Index IFRSRH.CAS_PK
-- Generated 12-mai-2004 21:44:07 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cas_pk ON cadastro_assinfra
  (
    cas_cnpj                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.CAS_PK

-- Start of DDL Script for Index IFRSRH.CAT_PK
-- Generated 12-mai-2004 21:44:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cat_pk ON categorias_transporte
  (
    cat_dep_codigo                  ASC,
    cat_sigla                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.CAT_PK

-- Start of DDL Script for Index IFRSRH.CBA_SEQUENCIAL_PK
-- Generated 12-mai-2004 21:44:10 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cba_sequencial_pk ON coberturas_seguros
  (
    csg_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CBA_SEQUENCIAL_PK

-- Start of DDL Script for Index IFRSRH.CBE_PK
-- Generated 12-mai-2004 21:44:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cbe_pk ON credenciados_beneficios
  (
    cbe_ben_sigla                   ASC,
    cbe_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CBE_PK

-- Start of DDL Script for Index IFRSRH.CBO_PK
-- Generated 12-mai-2004 21:44:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cbo_pk ON cbo
  (
    cbo_codigo                      ASC,
    cbo_dta_inicio                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CBO_PK

-- Start of DDL Script for Index IFRSRH.CC_CONTRATO_PK
-- Generated 12-mai-2004 21:44:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cc_contrato_pk ON credenciados_contratos
  (
    cc_cbe_ben_sigla                ASC,
    cc_cbe_cre_sequencial           ASC,
    cc_mes                          ASC,
    cc_ano                          ASC,
    cc_contrato                     ASC,
    cc_dep_codigo                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.CC_CONTRATO_PK

-- Start of DDL Script for Index IFRSRH.CCE_CCLI_FK
-- Generated 12-mai-2004 21:44:17 from IFRSRH@PRODSEDE

CREATE INDEX cce_ccli_fk ON corpo_clinico_especialidades
  (
    cce_cc_cre_cod_seque            ASC,
    cce_cc_sequencial               ASC
  )
/


-- End of DDL Script for Index IFRSRH.CCE_CCLI_FK

-- Start of DDL Script for Index IFRSRH.CCE_COD_SEQUE_FK
-- Generated 12-mai-2004 21:44:19 from IFRSRH@PRODSEDE

CREATE INDEX cce_cod_seque_fk ON corpo_clinico_especialidades
  (
    cce_esp_tipo                    ASC,
    cce_esp_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CCE_COD_SEQUE_FK

-- Start of DDL Script for Index IFRSRH.CCLI_PK
-- Generated 12-mai-2004 21:44:20 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ccli_pk ON corpo_clinico
  (
    cc_cre_cod_seque                ASC,
    cc_sequencial                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.CCLI_PK

-- Start of DDL Script for Index IFRSRH.CD_PK
-- Generated 12-mai-2004 21:44:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cd_pk ON credenciados_dependencias
  (
    cd_dep_codigo                   ASC,
    cd_cre_sequencial               ASC,
    cd_cbe_ben_sigla                ASC
  )
/


-- End of DDL Script for Index IFRSRH.CD_PK

-- Start of DDL Script for Index IFRSRH.CDE_CRE_FK_I
-- Generated 12-mai-2004 21:44:22 from IFRSRH@PRODSEDE

CREATE INDEX cde_cre_fk_i ON credenciados_especialidades
  (
    cde_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CDE_CRE_FK_I

-- Start of DDL Script for Index IFRSRH.CDE_ESP_FK_I
-- Generated 12-mai-2004 21:44:23 from IFRSRH@PRODSEDE

CREATE INDEX cde_esp_fk_i ON credenciados_especialidades
  (
    cde_esp_tipo                    ASC,
    cde_esp_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CDE_ESP_FK_I

-- Start of DDL Script for Index IFRSRH.CDE_PK
-- Generated 12-mai-2004 21:44:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cde_pk ON credenciados_especialidades
  (
    cde_cre_sequencial              ASC,
    cde_esp_tipo                    ASC,
    cde_esp_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CDE_PK

-- Start of DDL Script for Index IFRSRH.CFA_PK
-- Generated 12-mai-2004 21:44:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cfa_pk ON ctrl_fun_atividades_empregados
  (
    cfa_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CFA_PK

-- Start of DDL Script for Index IFRSRH.CFU_PK
-- Generated 12-mai-2004 21:44:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cfu_pk ON categorias_funcoes
  (
    cfu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.CFU_PK

-- Start of DDL Script for Index IFRSRH.CFV_PK
-- Generated 12-mai-2004 21:44:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cfv_pk ON categorias_funcoes_valor
  (
    cfv_cfu_codigo                  ASC,
    cfv_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.CFV_PK

-- Start of DDL Script for Index IFRSRH.CHEFE_PK
-- Generated 12-mai-2004 21:44:28 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX chefe_pk ON siad_chefe
  (
    oem_uor_codigo                  ASC,
    oem_data_inicio                 ASC,
    oem_emp_numero_matricula        ASC,
    oem_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CHEFE_PK

-- Start of DDL Script for Index IFRSRH.CID_PK
-- Generated 12-mai-2004 21:44:29 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cid_pk ON cid
  (
    cid_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.CID_PK

-- Start of DDL Script for Index IFRSRH.CIE_PK
-- Generated 12-mai-2004 21:44:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cie_pk ON carteiras_impressas_empregados
  (
    ci_emp_numero_matricula         ASC,
    ci_emp_data_validade            ASC
  )
/


-- End of DDL Script for Index IFRSRH.CIE_PK

-- Start of DDL Script for Index IFRSRH.COA_PK
-- Generated 12-mai-2004 21:44:31 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX coa_pk ON concursados_aprovados
  (
    coa_con_nr_concurso             ASC,
    coa_nr_inscricao                ASC
  )
/


-- End of DDL Script for Index IFRSRH.COA_PK

-- Start of DDL Script for Index IFRSRH.COL_PK
-- Generated 12-mai-2004 21:44:32 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX col_pk ON constantes_legais
  (
    col_codigo                      ASC,
    col_ano_referencia              ASC,
    col_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.COL_PK

-- Start of DDL Script for Index IFRSRH.COMISSAO_CADASTROS_FK_I
-- Generated 12-mai-2004 21:44:33 from IFRSRH@PRODSEDE

CREATE INDEX comissao_cadastros_fk_i ON siad_comissao_avaliacao
  (
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.COMISSAO_CADASTROS_FK_I

-- Start of DDL Script for Index IFRSRH.COMISSAO_DEPEND_FK_I
-- Generated 12-mai-2004 21:44:34 from IFRSRH@PRODSEDE

CREATE INDEX comissao_depend_fk_i ON siad_comissao_avaliacao
  (
    dep_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.COMISSAO_DEPEND_FK_I

-- Start of DDL Script for Index IFRSRH.COMISSAO_PK
-- Generated 12-mai-2004 21:44:35 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX comissao_pk ON siad_comissao_avaliacao
  (
    ano_comissao                    ASC,
    dep_codigo                      ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.COMISSAO_PK

-- Start of DDL Script for Index IFRSRH.COMP_GRUPO_GRUPO_AVAL_FK_I
-- Generated 12-mai-2004 21:44:35 from IFRSRH@PRODSEDE

CREATE INDEX comp_grupo_grupo_aval_fk_i ON siad_composicao_grupo
  (
    ano_grupo_avaliacao             ASC,
    codigo_grupo                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.COMP_GRUPO_GRUPO_AVAL_FK_I

-- Start of DDL Script for Index IFRSRH.COMP_GRUPO_PK
-- Generated 12-mai-2004 21:44:36 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX comp_grupo_pk ON siad_composicao_grupo
  (
    ano_grupo_avaliacao             ASC,
    codigo_grupo                    ASC,
    uor_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.COMP_GRUPO_PK

-- Start of DDL Script for Index IFRSRH.CON_PK
-- Generated 12-mai-2004 21:44:37 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX con_pk ON concursos
  (
    con_nr_concurso                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.CON_PK

-- Start of DDL Script for Index IFRSRH.CONCEITOS_PK
-- Generated 12-mai-2004 21:44:38 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX conceitos_pk ON siad_conceitos_avaliacao
  (
    codigo_conceito                 ASC,
    codigo_formulario               ASC,
    ano_formulario                  ASC,
    codigo_fator                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.CONCEITOS_PK

-- Start of DDL Script for Index IFRSRH.COR_PK
-- Generated 12-mai-2004 21:44:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cor_pk ON credenc_inss_outros_recolhim
  (
    cor_cre_sequencial              ASC,
    cor_dta_doc_fiscal              ASC,
    cor_num_doc_fiscal              ASC,
    cor_cnpj_empresa                ASC,
    cor_dta_inclusao                ASC
  )
/


-- End of DDL Script for Index IFRSRH.COR_PK

-- Start of DDL Script for Index IFRSRH.CORPO_CLINICO_ESPECIALID_PK
-- Generated 12-mai-2004 21:44:40 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX corpo_clinico_especialid_pk ON corpo_clinico_especialidades
  (
    cce_cc_cre_cod_seque            ASC,
    cce_esp_tipo                    ASC,
    cce_esp_numero                  ASC,
    cce_cc_sequencial               ASC
  )
/


-- End of DDL Script for Index IFRSRH.CORPO_CLINICO_ESPECIALID_PK

-- Start of DDL Script for Index IFRSRH.COV_PK
-- Generated 12-mai-2004 21:44:41 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cov_pk ON concurso_doc_origem_vagas
  (
    cov_numero_documento            ASC,
    cov_data_documento              ASC
  )
/


-- End of DDL Script for Index IFRSRH.COV_PK

-- Start of DDL Script for Index IFRSRH.CRE_ABA_FK_I
-- Generated 12-mai-2004 21:44:42 from IFRSRH@PRODSEDE

CREATE INDEX cre_aba_fk_i ON credenciados
  (
    cre_aba_ban_codigo              ASC,
    cre_aba_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRE_ABA_FK_I

-- Start of DDL Script for Index IFRSRH.CRE_CRE_FK_I
-- Generated 12-mai-2004 21:44:43 from IFRSRH@PRODSEDE

CREATE INDEX cre_cre_fk_i ON credenciados
  (
    cre_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRE_CRE_FK_I

-- Start of DDL Script for Index IFRSRH.CRE_PK
-- Generated 12-mai-2004 21:44:44 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cre_pk ON credenciados
  (
    cre_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRE_PK

-- Start of DDL Script for Index IFRSRH.CRE_UFE_FK_I
-- Generated 12-mai-2004 21:44:45 from IFRSRH@PRODSEDE

CREATE INDEX cre_ufe_fk_i ON credenciados
  (
    cre_ufe_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRE_UFE_FK_I

-- Start of DDL Script for Index IFRSRH.CRONOG_PK
-- Generated 12-mai-2004 21:44:46 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cronog_pk ON siad_cronograma
  (
    ano_cronograma                  ASC,
    item                            ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRONOG_PK

-- Start of DDL Script for Index IFRSRH.CRP_PK
-- Generated 12-mai-2004 21:44:47 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX crp_pk ON cronogramas_pagamentos
  (
    crp_dep_codigo                  ASC,
    crp_epg_codigo                  ASC,
    crp_ano_pagamento               ASC,
    crp_mes_pagamento               ASC,
    crp_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.CRP_PK

-- Start of DDL Script for Index IFRSRH.CSV_PK
-- Generated 12-mai-2004 21:44:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX csv_pk ON cobranca_psv
  (
    csv_psv_sequencial              ASC,
    csv_ano_referencia              ASC,
    csv_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CSV_PK

-- Start of DDL Script for Index IFRSRH.CTI_PK
-- Generated 12-mai-2004 21:44:50 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cti_pk ON credenciados_tipo
  (
    crt_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.CTI_PK

-- Start of DDL Script for Index IFRSRH.CTL_ORV_PK
-- Generated 12-mai-2004 21:44:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ctl_orv_pk ON controle_ocorrencias_receb_val
  (
    ctl_orv_dep_codigo_fisico       ASC,
    ctl_orv_emc_emb_ben_sigla       ASC,
    ctl_orv_mes_processamento       ASC,
    ctl_orv_ano_processamento       ASC,
    ctl_orv_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CTL_ORV_PK

-- Start of DDL Script for Index IFRSRH.CUD_PK
-- Generated 12-mai-2004 21:44:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cud_pk ON controle_usuario_dependencia
  (
    sgu_id_usuario                  ASC,
    ssi_cd_sistema                  ASC,
    dep_cd_dependencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.CUD_PK

-- Start of DDL Script for Index IFRSRH.CUF_UK
-- Generated 12-mai-2004 21:44:54 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cuf_uk ON controle_usuarios_funcoes
  (
    sgu_id_usuario                  ASC,
    ss_cd_sistema                   ASC,
    fun_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.CUF_UK

-- Start of DDL Script for Index IFRSRH.CUO_UK
-- Generated 12-mai-2004 21:44:56 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX cuo_uk ON controle_usuarios_ocorrencias
  (
    sgu_id_usuario                  ASC,
    ss_cd_sistema                   ASC,
    ofu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.CUO_UK

-- Start of DDL Script for Index IFRSRH.DBC_SIGMESANODEP_PK
-- Generated 12-mai-2004 21:44:57 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dbc_sigmesanodep_pk ON demonstrativo_custo_beneficio
  (
    dcb_sigla                       ASC,
    dcb_mes                         ASC,
    dcb_ano                         ASC,
    dcb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.DBC_SIGMESANODEP_PK

-- Start of DDL Script for Index IFRSRH.DCN_PK
-- Generated 12-mai-2004 21:44:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dcn_pk ON documentacao_contratual
  (
    dcn_cre_sequencial              ASC,
    dcn_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DCN_PK

-- Start of DDL Script for Index IFRSRH.DE_PK
-- Generated 12-mai-2004 21:44:59 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX de_pk ON dataprev_especie
  (
    des_cod_especie                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.DE_PK

-- Start of DDL Script for Index IFRSRH.DEF_PK
-- Generated 12-mai-2004 21:45:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX def_pk ON deficiencia
  (
    def_cod_deficiencia             ASC,
    def_tdef_cod_tipo_deficiencia   ASC
  )
/


-- End of DDL Script for Index IFRSRH.DEF_PK

-- Start of DDL Script for Index IFRSRH.DEP_EMP_IDX
-- Generated 12-mai-2004 21:45:02 from IFRSRH@PRODSEDE

CREATE INDEX dep_emp_idx ON tmp_contabilidade_relatorios
  (
    dependencia                     ASC,
    empregado                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.DEP_EMP_IDX

-- Start of DDL Script for Index IFRSRH.DIA_PK
-- Generated 12-mai-2004 21:45:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dia_pk ON deducao_inss_aut_coop
  (
    dia_ano_deducao                 ASC,
    dia_mes_deducao                 ASC,
    dia_versao                      ASC,
    dia_cre_sequencial              ASC,
    dia_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DIA_PK

-- Start of DDL Script for Index IFRSRH.DIE_PK
-- Generated 12-mai-2004 21:45:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX die_pk ON deducao_inss_empregados
  (
    die_ano_deducao                 ASC,
    die_mes_deducao                 ASC,
    die_versao                      ASC,
    die_emp_numero_matricula        ASC,
    die_dep_codigo                  ASC,
    die_centro_custo                ASC
  )
/


-- End of DDL Script for Index IFRSRH.DIE_PK

-- Start of DDL Script for Index IFRSRH.DMO_GUI_FK
-- Generated 12-mai-2004 21:45:05 from IFRSRH@PRODSEDE

CREATE INDEX dmo_gui_fk ON diversos_medicas_hospit
  (
    dmo_gui_doc_numero              ASC,
    dmo_gui_doc_cbe_ben_sigla       ASC,
    dmo_gui_doc_cbe_cre_sequencial  ASC,
    dmo_gui_doc_dep_codigo          ASC,
    dmo_gui_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DMO_GUI_FK

-- Start of DDL Script for Index IFRSRH.DMO_PK
-- Generated 12-mai-2004 21:45:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dmo_pk ON diversos_medicas_hospit
  (
    dmo_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DMO_PK

-- Start of DDL Script for Index IFRSRH.DMP_GUI_FK
-- Generated 12-mai-2004 21:45:07 from IFRSRH@PRODSEDE

CREATE INDEX dmp_gui_fk ON despesas_medicas_hospitalares
  (
    dmp_gui_doc_numero              ASC,
    dmp_gui_doc_cbe_ben_sigla       ASC,
    dmp_gui_doc_cbe_cre_sequencial  ASC,
    dmp_gui_doc_dep_codigo          ASC,
    dmp_gui_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DMP_GUI_FK

-- Start of DDL Script for Index IFRSRH.DMP_PK
-- Generated 12-mai-2004 21:45:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dmp_pk ON despesas_medicas_hospitalares
  (
    dmp_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DMP_PK

-- Start of DDL Script for Index IFRSRH.DOC_SINISTRO_PK
-- Generated 12-mai-2004 21:45:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX doc_sinistro_pk ON documentacao_sinistro
  (
    dos_codigo_doc                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DOC_SINISTRO_PK

-- Start of DDL Script for Index IFRSRH.DOC2_PK
-- Generated 12-mai-2004 21:45:10 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX doc2_pk ON documentos_cobranca
  (
    doc_numero                      ASC,
    doc_cbe_ben_sigla               ASC,
    doc_cbe_cre_sequencial          ASC,
    doc_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.DOC2_PK

-- Start of DDL Script for Index IFRSRH.DR_PK
-- Generated 12-mai-2004 21:45:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dr_pk ON dataprev_rubricas
  (
    dru_cod_rubrica                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.DR_PK

-- Start of DDL Script for Index IFRSRH.DREE_PK
-- Generated 12-mai-2004 21:45:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dree_pk ON dataprev_reembolso
  (
    dar_ano_referencia              ASC,
    dar_mes_referencia              ASC,
    dar_emp_numero_matricula        ASC,
    dar_cod_beneficio               ASC,
    dar_cod_benef_sequencial        ASC
  )
/


-- End of DDL Script for Index IFRSRH.DREE_PK

-- Start of DDL Script for Index IFRSRH.DRR_PK
-- Generated 12-mai-2004 21:45:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX drr_pk ON dataprev_reembolso_rubricas
  (
    drr_ano_referencia              ASC,
    drr_mes_referencia              ASC,
    drr_emp_numero_matricula        ASC,
    drr_dru_cod_rubrica             ASC,
    drr_sequencial                  ASC,
    drr_cod_beneficio               ASC,
    drr_cod_benef_sequencial        ASC
  )
/


-- End of DDL Script for Index IFRSRH.DRR_PK

-- Start of DDL Script for Index IFRSRH.DRRT_PK
-- Generated 12-mai-2004 21:45:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX drrt_pk ON dataprev_reembolso_rubricas_te
  (
    drr_ano_referencia              ASC,
    drr_mes_referencia              ASC,
    drr_cod_beneficio               ASC,
    drr_dru_cod_rubrica             ASC,
    drr_sequencial                  ASC,
    drr_cod_benef_sequencial        ASC
  )
/


-- End of DDL Script for Index IFRSRH.DRRT_PK

-- Start of DDL Script for Index IFRSRH.DRT_PK
-- Generated 12-mai-2004 21:45:15 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX drt_pk ON dataprev_reembolso_temp
  (
    dar_ano_referencia              ASC,
    dar_mes_referencia              ASC,
    dar_cod_beneficio               ASC,
    dar_cod_benef_sequencial        ASC
  )
/


-- End of DDL Script for Index IFRSRH.DRT_PK

-- Start of DDL Script for Index IFRSRH.DUS_PK
-- Generated 12-mai-2004 21:45:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX dus_pk ON dependentes_usu_plano_saude
  (
    dus_cre_sequencial              ASC,
    dus_emp_numero_matricula        ASC,
    dus_ups_cod_usuario             ASC,
    dus_ups_data_inicio             ASC,
    dus_cod_dependente              ASC,
    dus_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.DUS_PK

-- Start of DDL Script for Index IFRSRH.EAC_PK
-- Generated 12-mai-2004 21:45:17 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eac_pk ON empregados_atuacao_cargo
  (
    eac_emp_numero_matricula        ASC,
    eac_aac_atu_codigo              ASC,
    eac_aac_car_codigo              ASC,
    eac_aac_car_codigo_nivel        ASC,
    eac_aac_car_occ_codigo          ASC,
    eac_data_mudanca                ASC
  )
/


-- End of DDL Script for Index IFRSRH.EAC_PK

-- Start of DDL Script for Index IFRSRH.ECA_PK
-- Generated 12-mai-2004 21:45:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eca_pk ON emissoes_carteiras
  (
    eca_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ECA_PK

-- Start of DDL Script for Index IFRSRH.EEI_PK
-- Generated 12-mai-2004 21:45:19 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eei_pk ON eventos_excecao_infraprev
  (
    eei_emp_numero_matricula        ASC,
    eei_ind_plano                   ASC,
    eei_data                        ASC,
    eei_cod_evento                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EEI_PK

-- Start of DDL Script for Index IFRSRH.EFC_PK
-- Generated 12-mai-2004 21:45:20 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX efc_pk ON empregado_fone_comercial
  (
    efc_emp_numero_matricula        ASC,
    efc_uff_tipo                    ASC,
    efc_uff_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EFC_PK

-- Start of DDL Script for Index IFRSRH.EFE_PK
-- Generated 12-mai-2004 21:45:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX efe_pk ON empregados_ferias_13
  (
    efe_emp_numero_matricula        ASC,
    efe_ano_referencia              ASC,
    efe_mes_referencia              ASC,
    efe_versao                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.EFE_PK

-- Start of DDL Script for Index IFRSRH.EGT_IDX
-- Generated 12-mai-2004 21:45:22 from IFRSRH@PRODSEDE

CREATE INDEX egt_idx ON empregados_pagamentos
  (
    egt_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EGT_IDX

-- Start of DDL Script for Index IFRSRH.EGT_PK
-- Generated 12-mai-2004 21:45:23 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX egt_pk ON empregados_pagamentos
  (
    egt_crp_ano_pagamento           ASC,
    egt_crp_mes_pagamento           ASC,
    egt_crp_sequencial              ASC,
    egt_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EGT_PK

-- Start of DDL Script for Index IFRSRH.EIB_PK
-- Generated 12-mai-2004 21:45:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eib_pk ON efetivo_infraero
  (
    ein_ano                         ASC,
    ein_mes                         ASC,
    ein_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EIB_PK

-- Start of DDL Script for Index IFRSRH.EII_EMPINS_PK
-- Generated 12-mai-2004 21:45:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eii_empins_pk ON spf_empregado_ind_insuficienci
  (
    ano_indicacao_ins               ASC,
    cod_local_indicacao_ins         ASC,
    indicador_local_ins             ASC,
    matricula_emp_indicado_ins      ASC
  )
/


-- End of DDL Script for Index IFRSRH.EII_EMPINS_PK

-- Start of DDL Script for Index IFRSRH.EIP_INDPRO_PK
-- Generated 12-mai-2004 21:45:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eip_indpro_pk ON spf_empregado_ind_promocao
  (
    ano_indicacao_prom              ASC,
    cod_local_indicacao_prom        ASC,
    indicador_local_prom            ASC,
    matricula_emp_indicado_prom     ASC
  )
/


-- End of DDL Script for Index IFRSRH.EIP_INDPRO_PK

-- Start of DDL Script for Index IFRSRH.EMAIL_EMPREGADO_PK
-- Generated 12-mai-2004 21:45:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX email_empregado_pk ON email_empregado
  (
    num_matricula                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMAIL_EMPREGADO_PK

-- Start of DDL Script for Index IFRSRH.EMB_UK1
-- Generated 12-mai-2004 21:45:27 from IFRSRH@PRODSEDE

CREATE INDEX emb_uk1 ON empregados_beneficios
  (
    emb_ben_sigla                   ASC,
    emb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMB_UK1

-- Start of DDL Script for Index IFRSRH.EMC_CAT_FK_I
-- Generated 12-mai-2004 21:45:28 from IFRSRH@PRODSEDE

CREATE INDEX emc_cat_fk_i ON empregados_categorias
  (
    emc_cat_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMC_CAT_FK_I

-- Start of DDL Script for Index IFRSRH.EMC_EMB_FK_I
-- Generated 12-mai-2004 21:45:29 from IFRSRH@PRODSEDE

CREATE INDEX emc_emb_fk_i ON empregados_categorias
  (
    emc_emb_emp_numero_matricula    ASC,
    emc_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMC_EMB_FK_I

-- Start of DDL Script for Index IFRSRH.EMC_PK
-- Generated 12-mai-2004 21:45:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emc_pk ON empregados_categorias
  (
    emc_emb_emp_numero_matricula    ASC,
    emc_cat_dep_codigo              ASC,
    emc_cat_sigla                   ASC,
    emc_emb_ben_sigla               ASC,
    emc_tipo_utilizacao             ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMC_PK

-- Start of DDL Script for Index IFRSRH.EMF_PK
-- Generated 12-mai-2004 21:45:31 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emf_pk ON empregados_formacoes
  (
    emf_emp_numero_matricula        ASC,
    emf_for_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMF_PK

-- Start of DDL Script for Index IFRSRH.EMP_01_IX
-- Generated 12-mai-2004 21:45:33 from IFRSRH@PRODSEDE

CREATE INDEX emp_01_ix ON cadastros
  (
    emp_numero_cpf                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_01_IX

-- Start of DDL Script for Index IFRSRH.EMP_CPF_UK
-- Generated 12-mai-2004 21:45:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_cpf_uk ON cadastros
  (
    emp_numero_matricula            ASC,
    emp_numero_cpf                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_CPF_UK

-- Start of DDL Script for Index IFRSRH.EMP_NPROMV_CADASTROS_FK_I
-- Generated 12-mai-2004 21:45:36 from IFRSRH@PRODSEDE

CREATE INDEX emp_npromv_cadastros_fk_i ON spf_empregado_nao_promovido
  (
    cadastros_emp_numero_matricula  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_NPROMV_CADASTROS_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_NPROMV_MOTN_PROM_FK_I
-- Generated 12-mai-2004 21:45:37 from IFRSRH@PRODSEDE

CREATE INDEX emp_npromv_motn_prom_fk_i ON spf_empregado_nao_promovido
  (
    motn_prom_ano_promocao          ASC,
    motn_prom_cod_motivo_nao_promo  ASC,
    motn_prom_tipo_promocao         ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_NPROMV_MOTN_PROM_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_NPROMV_PK
-- Generated 12-mai-2004 21:45:38 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_npromv_pk ON spf_empregado_nao_promovido
  (
    motn_prom_cod_motivo_nao_promo  ASC,
    motn_prom_tipo_promocao         ASC,
    cadastros_emp_numero_matricula  ASC,
    motn_prom_ano_promocao          ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_NPROMV_PK

-- Start of DDL Script for Index IFRSRH.EMP_OPT_PK
-- Generated 12-mai-2004 21:45:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_opt_pk ON empregados_optantes
  (
    emp_opt_matricula               ASC,
    emp_opt_ano                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_OPT_PK

-- Start of DDL Script for Index IFRSRH.EMP_PIS_PASEP_UK
-- Generated 12-mai-2004 21:45:40 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_pis_pasep_uk ON cadastros
  (
    emp_numero_matricula            ASC,
    emp_numero_pis_pasep            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PIS_PASEP_UK

-- Start of DDL Script for Index IFRSRH.EMP_PK
-- Generated 12-mai-2004 21:45:41 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_pk ON cadastros
  (
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PK

-- Start of DDL Script for Index IFRSRH.EMP_PROM_CADASTROS_FK_I
-- Generated 12-mai-2004 21:45:42 from IFRSRH@PRODSEDE

CREATE INDEX emp_prom_cadastros_fk_i ON spf_empregado_promovido
  (
    cadastros_emp_numero_matricula  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PROM_CADASTROS_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_PROM_CARGOS_FK_I
-- Generated 12-mai-2004 21:45:43 from IFRSRH@PRODSEDE

CREATE INDEX emp_prom_cargos_fk_i ON spf_empregado_promovido
  (
    cargos_ocucargo_occ_codigo      ASC,
    cargos_car_codigo               ASC,
    cargos_car_codigo_nivel         ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PROM_CARGOS_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_PROM_NIVEIS_SAL_FK_I
-- Generated 12-mai-2004 21:45:44 from IFRSRH@PRODSEDE

CREATE INDEX emp_prom_niveis_sal_fk_i ON spf_empregado_promovido
  (
    niveis_sal_nsa_codigo_nivel     ASC,
    niveis_sal_nsa_codigo_padrao    ASC,
    niveis_sal_nsa_indicador_nivel  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PROM_NIVEIS_SAL_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_PROM_PK
-- Generated 12-mai-2004 21:45:45 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_prom_pk ON spf_empregado_promovido
  (
    promocao_tipos_ocor_ofu_codigo  ASC,
    cadastros_emp_numero_matricula  ASC,
    promocao_ano_promocao           ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PROM_PK

-- Start of DDL Script for Index IFRSRH.EMP_PROM_PROMOCAO_FK_I
-- Generated 12-mai-2004 21:45:46 from IFRSRH@PRODSEDE

CREATE INDEX emp_prom_promocao_fk_i ON spf_empregado_promovido
  (
    promocao_ano_promocao           ASC,
    promocao_tipos_ocor_ofu_codigo  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_PROM_PROMOCAO_FK_I

-- Start of DDL Script for Index IFRSRH.EMP_UK2
-- Generated 12-mai-2004 21:45:47 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_uk2 ON cadastros
  (
    emp_dep_codigo_lotacao          ASC,
    emp_ati_ct_custos               ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_UK2

-- Start of DDL Script for Index IFRSRH.EMP_UK3
-- Generated 12-mai-2004 21:45:48 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_uk3 ON cadastros
  (
    emp_numero_matricula_ant        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_UK3

-- Start of DDL Script for Index IFRSRH.EMP_UK4
-- Generated 12-mai-2004 21:45:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_uk4 ON cadastros
  (
    emp_status                      ASC,
    emp_dep_codigo_pagto            ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_UK4

-- Start of DDL Script for Index IFRSRH.EMP_UK5
-- Generated 12-mai-2004 21:45:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emp_uk5 ON cadastros
  (
    emp_uor_codigo_lotacao          ASC,
    emp_ati_ct_custos               ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMP_UK5

-- Start of DDL Script for Index IFRSRH.EMPRESTIMOS_INFRAPREV_PK
-- Generated 12-mai-2004 21:45:50 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX emprestimos_infraprev_pk ON emprestimos_infraprev
  (
    ano_referencia                  ASC,
    mes_referencia                  ASC,
    num_matricula_empregado         ASC
  )
/


-- End of DDL Script for Index IFRSRH.EMPRESTIMOS_INFRAPREV_PK

-- Start of DDL Script for Index IFRSRH.ENQ_PK
-- Generated 12-mai-2004 21:45:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX enq_pk ON enquadramentos
  (
    enq_numero                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ENQ_PK

-- Start of DDL Script for Index IFRSRH.EOI_PK
-- Generated 12-mai-2004 21:45:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eoi_pk ON empregado_ocorrencia_inss
  (
    eoi_emp_numero_matricula        ASC,
    eoi_oia_agn_codigo              ASC,
    eoi_oia_oin_codigo_padrao_nac   ASC,
    eoi_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.EOI_PK

-- Start of DDL Script for Index IFRSRH.EPG_EPG_FK_I
-- Generated 12-mai-2004 21:45:53 from IFRSRH@PRODSEDE

CREATE INDEX epg_epg_fk_i ON eventos_pagamentos
  (
    epg_epg_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPG_EPG_FK_I

-- Start of DDL Script for Index IFRSRH.EPG_EPG_PRE_REQUISITO_2_FK_I
-- Generated 12-mai-2004 21:45:54 from IFRSRH@PRODSEDE

CREATE INDEX epg_epg_pre_requisito_2_fk_i ON eventos_pagamentos
  (
    epg_epg_codigo_pre_2            ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPG_EPG_PRE_REQUISITO_2_FK_I

-- Start of DDL Script for Index IFRSRH.EPG_PK
-- Generated 12-mai-2004 21:45:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX epg_pk ON eventos_pagamentos
  (
    epg_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPG_PK

-- Start of DDL Script for Index IFRSRH.EPL_PK
-- Generated 12-mai-2004 21:45:56 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX epl_pk ON empregados_participacao_lucros
  (
    epl_data_geracao                ASC,
    epl_dep_codigo_lotacao          ASC,
    epl_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPL_PK

-- Start of DDL Script for Index IFRSRH.EPS_PK
-- Generated 12-mai-2004 21:45:57 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eps_pk ON erros_plano_saude
  (
    eps_codigo_erro                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPS_PK

-- Start of DDL Script for Index IFRSRH.EPV_PK
-- Generated 12-mai-2004 21:45:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX epv_pk ON empregados_pessoal_sem_vinculo
  (
    epv_emp_numero_matricula        ASC,
    epv_psv_sequencial              ASC,
    epv_data_cadastro               ASC
  )
/


-- End of DDL Script for Index IFRSRH.EPV_PK

-- Start of DDL Script for Index IFRSRH.EQA_PK
-- Generated 12-mai-2004 21:46:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eqa_pk ON emp_qualificacao_academica
  (
    eqa_cod_matricula               ASC,
    eqa_qua_cod_qualif_academica    ASC
  )
/


-- End of DDL Script for Index IFRSRH.EQA_PK

-- Start of DDL Script for Index IFRSRH.ESC_PK
-- Generated 12-mai-2004 21:46:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX esc_pk ON especificacao_cid
  (
    esc_cid_codigo                  ASC,
    esc_eid_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ESC_PK

-- Start of DDL Script for Index IFRSRH.ESCALA_PK
-- Generated 12-mai-2004 21:46:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX escala_pk ON siad_escala_pontuacao
  (
    ano_escala                      ASC,
    tipo_escala                     ASC,
    codigo_classificacao            ASC
  )
/


-- End of DDL Script for Index IFRSRH.ESCALA_PK

-- Start of DDL Script for Index IFRSRH.ESO_PK
-- Generated 12-mai-2004 21:46:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eso_pk ON escolaridades
  (
    eso_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ESO_PK

-- Start of DDL Script for Index IFRSRH.ESO_UK
-- Generated 12-mai-2004 21:46:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX eso_uk ON escolaridades
  (
    eso_nome                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.ESO_UK

-- Start of DDL Script for Index IFRSRH.ESP_PK
-- Generated 12-mai-2004 21:46:07 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX esp_pk ON especialidades
  (
    esp_tipo                        ASC,
    esp_numero                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.ESP_PK

-- Start of DDL Script for Index IFRSRH.EXO_PK
-- Generated 12-mai-2004 21:46:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX exo_pk ON exames_obrigatorios
  (
    exo_emp_numero_matricula        ASC,
    exo_tipo_exame                  ASC,
    exo_data                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.EXO_PK

-- Start of DDL Script for Index IFRSRH.FAI_PK
-- Generated 12-mai-2004 21:46:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fai_pk ON faixas_inss
  (
    fai_faixa                       ASC,
    fai_ano_referencia              ASC,
    fai_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.FAI_PK

-- Start of DDL Script for Index IFRSRH.FAIXA_PK
-- Generated 12-mai-2004 21:46:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX faixa_pk ON spf_faixa_promovida
  (
    promocao_tipos_ocor_ofu_codigo  ASC,
    promocao_ano_promocao           ASC,
    tipo_escala_pontuacao           ASC,
    pontuacao_inicial               ASC,
    pontuacao_final                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.FAIXA_PK

-- Start of DDL Script for Index IFRSRH.FAIXA_PROMOCAO_FK_I
-- Generated 12-mai-2004 21:46:13 from IFRSRH@PRODSEDE

CREATE INDEX faixa_promocao_fk_i ON spf_faixa_promovida
  (
    promocao_ano_promocao           ASC,
    promocao_tipos_ocor_ofu_codigo  ASC
  )
/


-- End of DDL Script for Index IFRSRH.FAIXA_PROMOCAO_FK_I

-- Start of DDL Script for Index IFRSRH.FAR_CODIGO_PK
-- Generated 12-mai-2004 21:46:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX far_codigo_pk ON forcas_armadas
  (
    far_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.FAR_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.FATORES_PK
-- Generated 12-mai-2004 21:46:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fatores_pk ON siad_fatores_avaliativos
  (
    ano_formulario                  ASC,
    codigo_formulario               ASC,
    codigo_fator                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.FATORES_PK

-- Start of DDL Script for Index IFRSRH.FEC_PK
-- Generated 12-mai-2004 21:46:17 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fec_pk ON formacoes_espec_cargo
  (
    fec_car_codigo                  ASC,
    fec_car_codigo_nivel            ASC,
    fec_car_occ_codigo              ASC,
    fec_fes_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.FEC_PK

-- Start of DDL Script for Index IFRSRH.FEE_PK
-- Generated 12-mai-2004 21:46:20 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fee_pk ON formacoes_espec_empregado
  (
    fee_fes_codigo                  ASC,
    fee_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.FEE_PK

-- Start of DDL Script for Index IFRSRH.FES_PK
-- Generated 12-mai-2004 21:46:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fes_pk ON formacoes_especializadas
  (
    fes_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.FES_PK

-- Start of DDL Script for Index IFRSRH.FK_GUI_ASM
-- Generated 12-mai-2004 21:46:24 from IFRSRH@PRODSEDE

CREATE INDEX fk_gui_asm ON guias
  (
    gui_asm_senha                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.FK_GUI_ASM

-- Start of DDL Script for Index IFRSRH.FLE_PK
-- Generated 12-mai-2004 21:46:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fle_pk ON fiscalizacoes_linhas_empreg
  (
    fle_flr_numero_ato              ASC,
    fle_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.FLE_PK

-- Start of DDL Script for Index IFRSRH.FLR_PK
-- Generated 12-mai-2004 21:46:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX flr_pk ON fiscalizacoes_linhas_transp
  (
    flr_numero_ato                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.FLR_PK

-- Start of DDL Script for Index IFRSRH.FLT_PK
-- Generated 12-mai-2004 21:46:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX flt_pk ON fiscais_linhas_transportes
  (
    flt_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.FLT_PK

-- Start of DDL Script for Index IFRSRH.FLT_UK
-- Generated 12-mai-2004 21:46:32 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX flt_uk ON fiscais_linhas_transportes
  (
    flt_numero_ato                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.FLT_UK

-- Start of DDL Script for Index IFRSRH.FOCOS_ATEN_PK
-- Generated 12-mai-2004 21:46:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX focos_aten_pk ON siad_focos_atencao
  (
    ano_focos                       ASC,
    codigo_focos                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.FOCOS_ATEN_PK

-- Start of DDL Script for Index IFRSRH.FOR_PK
-- Generated 12-mai-2004 21:46:37 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX for_pk ON formacoes_profissionais
  (
    for_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.FOR_PK

-- Start of DDL Script for Index IFRSRH.FOR_UK
-- Generated 12-mai-2004 21:46:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX for_uk ON formacoes_profissionais
  (
    for_descricao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.FOR_UK

-- Start of DDL Script for Index IFRSRH.FORM_PK
-- Generated 12-mai-2004 21:46:41 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX form_pk ON formulas
  (
    for_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.FORM_PK

-- Start of DDL Script for Index IFRSRH.FORMULARIO_PK
-- Generated 12-mai-2004 21:46:42 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX formulario_pk ON siad_formulario_avaliacao
  (
    ano_formulario                  ASC,
    codigo_formulario               ASC
  )
/


-- End of DDL Script for Index IFRSRH.FORMULARIO_PK

-- Start of DDL Script for Index IFRSRH.FRU_PK
-- Generated 12-mai-2004 21:46:45 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fru_pk ON formulas_rubricas
  (
    fru_rub_codigo                  ASC,
    fru_ano_inicio                  ASC,
    fru_mes_inicio                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.FRU_PK

-- Start of DDL Script for Index IFRSRH.FUL_PK
-- Generated 12-mai-2004 21:46:46 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ful_pk ON faltas_usuarios_linhas
  (
    ful_ult_emb_emp_numero_matricu  ASC,
    ful_ult_emb_ben_sigla           ASC,
    ful_ult_ltf_numero              ASC,
    ful_ult_ltf_dep_codigo          ASC,
    ful_data                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.FUL_PK

-- Start of DDL Script for Index IFRSRH.FUN_PK
-- Generated 12-mai-2004 21:46:47 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX fun_pk ON cargos_confianca
  (
    fun_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.FUN_PK

-- Start of DDL Script for Index IFRSRH.GDP_CODIGO_PK
-- Generated 12-mai-2004 21:46:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX gdp_codigo_pk ON grupos_dependencias
  (
    gdp_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.GDP_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.GOF_CODIGO_PK
-- Generated 12-mai-2004 21:46:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX gof_codigo_pk ON grupos_ocorrencias_funcionais
  (
    gof_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.GOF_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.GPR_ABO_FK
-- Generated 12-mai-2004 21:46:52 from IFRSRH@PRODSEDE

CREATE INDEX gpr_abo_fk ON guias_procedimentos
  (
    gpr_abo_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.GPR_ABO_FK

-- Start of DDL Script for Index IFRSRH.GPR_GUI_FK
-- Generated 12-mai-2004 21:46:54 from IFRSRH@PRODSEDE

CREATE INDEX gpr_gui_fk ON guias_procedimentos
  (
    gpr_gui_doc_numero              ASC,
    gpr_gui_doc_cbe_ben_sigla       ASC,
    gpr_gui_doc_cbe_cre_sequencial  ASC,
    gpr_gui_doc_dep_codigo          ASC,
    gpr_gui_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.GPR_GUI_FK

-- Start of DDL Script for Index IFRSRH.GPR_PK
-- Generated 12-mai-2004 21:46:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX gpr_pk ON guias_procedimentos
  (
    gpr_gui_doc_numero              ASC,
    gpr_gui_doc_cbe_ben_sigla       ASC,
    gpr_gui_doc_cbe_cre_sequencial  ASC,
    gpr_gui_doc_dep_codigo          ASC,
    gpr_gui_numero                  ASC,
    gpr_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.GPR_PK

-- Start of DDL Script for Index IFRSRH.GRH_HST_DIRF_PK
-- Generated 12-mai-2004 21:46:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX grh_hst_dirf_pk ON grh_hst_dirf
  (
    ghd_dat_ano                     ASC,
    ghd_num_cpf                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.GRH_HST_DIRF_PK

-- Start of DDL Script for Index IFRSRH.GRU_CODIGO_PK
-- Generated 12-mai-2004 21:47:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX gru_codigo_pk ON grupos_rubricas
  (
    gru_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.GRU_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.GRUPO_AVAL_PK
-- Generated 12-mai-2004 21:47:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX grupo_aval_pk ON siad_grupo_avaliacao
  (
    ano_grupo_avaliacao             ASC,
    codigo_grupo                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.GRUPO_AVAL_PK

-- Start of DDL Script for Index IFRSRH.GUI_DATA_01_IX
-- Generated 12-mai-2004 21:47:05 from IFRSRH@PRODSEDE

CREATE INDEX gui_data_01_ix ON guias
  (
    gui_data                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_DATA_01_IX

-- Start of DDL Script for Index IFRSRH.GUI_DOC_FK
-- Generated 12-mai-2004 21:47:06 from IFRSRH@PRODSEDE

CREATE INDEX gui_doc_fk ON guias
  (
    gui_doc_numero                  ASC,
    gui_doc_cbe_ben_sigla           ASC,
    gui_doc_cbe_cre_sequencial      ASC,
    gui_doc_dep_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_DOC_FK

-- Start of DDL Script for Index IFRSRH.GUI_EMP_NUMERO_MATRICULA_01_IX
-- Generated 12-mai-2004 21:47:08 from IFRSRH@PRODSEDE

CREATE INDEX gui_emp_numero_matricula_01_ix ON guias
  (
    gui_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_EMP_NUMERO_MATRICULA_01_IX

-- Start of DDL Script for Index IFRSRH.GUI_LOT_FK
-- Generated 12-mai-2004 21:47:09 from IFRSRH@PRODSEDE

CREATE INDEX gui_lot_fk ON guias
  (
    gui_emp_dep_codigo_lotacao      ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_LOT_FK

-- Start of DDL Script for Index IFRSRH.GUI_PK
-- Generated 12-mai-2004 21:47:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX gui_pk ON guias
  (
    gui_doc_numero                  ASC,
    gui_doc_cbe_ben_sigla           ASC,
    gui_doc_cbe_cre_sequencial      ASC,
    gui_doc_dep_codigo              ASC,
    gui_numero                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_PK

-- Start of DDL Script for Index IFRSRH.GUI_PVB_FK
-- Generated 12-mai-2004 21:47:12 from IFRSRH@PRODSEDE

CREATE INDEX gui_pvb_fk ON guias
  (
    gui_emp_numero_matricula        ASC,
    gui_pvi_sequencial              ASC,
    gui_doc_cbe_ben_sigla           ASC,
    gui_pvb_adesao                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.GUI_PVB_FK

-- Start of DDL Script for Index IFRSRH.HCD_PK
-- Generated 12-mai-2004 21:47:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hcd_pk ON historico_cargos_dependencias
  (
    hcd_dep_codigo                  ASC,
    hcd_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.HCD_PK

-- Start of DDL Script for Index IFRSRH.HDA_PK
-- Generated 12-mai-2004 21:47:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hda_pk ON historico_devolucao_ans
  (
    hda_dt_carga_arq                ASC,
    hda_cod_usuario                 ASC,
    hda_nome_arquivo                ASC
  )
/


-- End of DDL Script for Index IFRSRH.HDA_PK

-- Start of DDL Script for Index IFRSRH.HDD_PK
-- Generated 12-mai-2004 21:47:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hdd_pk ON hist_detalhe_dev_ans
  (
    hdd_hda_dt_carga_arq            ASC,
    hdd_hda_cod_usuario             ASC,
    hdd_hda_nome_arquivo            ASC,
    hdd_ind_tipo_reg                ASC,
    hdd_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HDD_PK

-- Start of DDL Script for Index IFRSRH.HEB_PK
-- Generated 12-mai-2004 21:47:17 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX heb_pk ON historico_empregados_benef
  (
    heb_emb_ben_sigla               ASC,
    heb_emb_emp_numero_matricula    ASC,
    heb_data_adesao                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.HEB_PK

-- Start of DDL Script for Index IFRSRH.HFD_PK
-- Generated 12-mai-2004 21:47:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hfd_pk ON historicos_funcoes_dependencia
  (
    hfd_dep_codigo                  ASC,
    hfd_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.HFD_PK

-- Start of DDL Script for Index IFRSRH.HFL_PK
-- Generated 12-mai-2004 21:47:19 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hfl_pk ON historicos_funcoes_lotacoes
  (
    hfl_uor_codigo                  ASC,
    hfl_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.HFL_PK

-- Start of DDL Script for Index IFRSRH.HFR_DCT_PK
-- Generated 12-mai-2004 21:47:20 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hfr_dct_pk ON horarios_frequencia
  (
    hfr_dep_codigo                  ASC,
    hfr_cod_horario                 ASC,
    hfr_turno_trabalho              ASC
  )
/


-- End of DDL Script for Index IFRSRH.HFR_DCT_PK

-- Start of DDL Script for Index IFRSRH.HGT_PK
-- Generated 12-mai-2004 21:47:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hgt_pk ON historico_geracao_tcu
  (
    hgt_dt_referencia_geracao       ASC,
    hgt_flg_tipo_geracao            ASC
  )
/


-- End of DDL Script for Index IFRSRH.HGT_PK

-- Start of DDL Script for Index IFRSRH.HISTORICO_ANS_PK
-- Generated 12-mai-2004 21:47:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX historico_ans_pk ON historico_ans
  (
    han_ans_dt_gera_arq             ASC,
    han_ans_cod_arq                 ASC,
    han_ans_operacao                ASC,
    han_ans_beneficiario            ASC
  )
/


-- End of DDL Script for Index IFRSRH.HISTORICO_ANS_PK

-- Start of DDL Script for Index IFRSRH.HISTORICO_MOVIMENTACAO_IND1
-- Generated 12-mai-2004 21:47:23 from IFRSRH@PRODSEDE

CREATE INDEX historico_movimentacao_ind1 ON historico_movimentacao
  (
    mov_oem_emp_numero_matricula    ASC,
    mov_oem_ofu_codigo              ASC,
    mov_oem_data_inicio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.HISTORICO_MOVIMENTACAO_IND1

-- Start of DDL Script for Index IFRSRH.HNM_PK
-- Generated 12-mai-2004 21:47:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hnm_pk ON honorarios_medicos
  (
    hnm_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HNM_PK

-- Start of DDL Script for Index IFRSRH.HNS_PK
-- Generated 12-mai-2004 21:47:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hns_pk ON historico_niveis_salariais
  (
    hns_nsa_codigo_nivel            ASC,
    hns_nsa_codigo_padrao           ASC,
    hns_nsa_indicador_nivel_escola  ASC,
    hns_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.HNS_PK

-- Start of DDL Script for Index IFRSRH.HPI_PK
-- Generated 12-mai-2004 21:47:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hpi_pk ON hist_pericul_insalub
  (
    hpi_emp_numero_matricula        ASC,
    hpi_data_inicio                 ASC,
    hpi_ind_pericul_insalub         ASC
  )
/


-- End of DDL Script for Index IFRSRH.HPI_PK

-- Start of DDL Script for Index IFRSRH.HPS_PK
-- Generated 12-mai-2004 21:47:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hps_pk ON historicos_processos_sinistros
  (
    hps_sequencial                  ASC,
    hps_sin_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.HPS_PK

-- Start of DDL Script for Index IFRSRH.HST_DEP_EMP_PK
-- Generated 12-mai-2004 21:47:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hst_dep_emp_pk ON hst_dependencia_empregado
  (
    hde_emp_numero_matricula        ASC,
    hde_ano_referencia              ASC,
    hde_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.HST_DEP_EMP_PK

-- Start of DDL Script for Index IFRSRH.HST_MOV_DEP_IX
-- Generated 12-mai-2004 21:47:28 from IFRSRH@PRODSEDE

CREATE INDEX hst_mov_dep_ix ON historico_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.HST_MOV_DEP_IX

-- Start of DDL Script for Index IFRSRH.HST_MOV_EMP_IDX
-- Generated 12-mai-2004 21:47:29 from IFRSRH@PRODSEDE

CREATE INDEX hst_mov_emp_idx ON historico_movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.HST_MOV_EMP_IDX

-- Start of DDL Script for Index IFRSRH.HST_MOV_PK
-- Generated 12-mai-2004 21:47:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX hst_mov_pk ON historico_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_numero_matricula        ASC,
    mov_rub_codigo                  ASC,
    mov_tip_rubrica                 ASC,
    mov_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HST_MOV_PK

-- Start of DDL Script for Index IFRSRH.HTD_DEP_FK_I
-- Generated 12-mai-2004 21:47:31 from IFRSRH@PRODSEDE

CREATE INDEX htd_dep_fk_i ON horarios_trabalho_dep
  (
    htd_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HTD_DEP_FK_I

-- Start of DDL Script for Index IFRSRH.HTD_HTR_FK_I
-- Generated 12-mai-2004 21:47:32 from IFRSRH@PRODSEDE

CREATE INDEX htd_htr_fk_i ON horarios_trabalho_dep
  (
    htd_htr_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HTD_HTR_FK_I

-- Start of DDL Script for Index IFRSRH.HTD_PK
-- Generated 12-mai-2004 21:47:33 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX htd_pk ON horarios_trabalho_dep
  (
    htd_dep_codigo                  ASC,
    htd_htr_codigo                  ASC,
    htd_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.HTD_PK

-- Start of DDL Script for Index IFRSRH.HTR_PK
-- Generated 12-mai-2004 21:47:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX htr_pk ON horarios_trabalhos
  (
    htr_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.HTR_PK

-- Start of DDL Script for Index IFRSRH.HTR_UK
-- Generated 12-mai-2004 21:47:35 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX htr_uk ON horarios_trabalhos
  (
    htr_hora_inicio                 ASC,
    htr_hora_termino                ASC,
    htr_hora_inicio_intervalo       ASC,
    htr_hora_termino_intervalo      ASC
  )
/


-- End of DDL Script for Index IFRSRH.HTR_UK

-- Start of DDL Script for Index IFRSRH.IAB_PK
-- Generated 12-mai-2004 21:47:36 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX iab_pk ON indice_absenteismo
  (
    iab_ano                         ASC,
    iab_mes                         ASC,
    iab_ofu_codigo                  ASC,
    iab_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.IAB_PK

-- Start of DDL Script for Index IFRSRH.ICL_PK
-- Generated 12-mai-2004 21:47:37 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX icl_pk ON historico_cargos_lotacao
  (
    icl_uor_codigo                  ASC,
    icl_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.ICL_PK

-- Start of DDL Script for Index IFRSRH.IDN_SEQUENCIAL_PK
-- Generated 12-mai-2004 21:47:38 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX idn_sequencial_pk ON indenizacoes
  (
    idn_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDN_SEQUENCIAL_PK

-- Start of DDL Script for Index IFRSRH.IDX_CADASTROS_02
-- Generated 12-mai-2004 21:47:38 from IFRSRH@PRODSEDE

CREATE INDEX idx_cadastros_02 ON cadastros
  (
    emp_sfu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_CADASTROS_02

-- Start of DDL Script for Index IFRSRH.IDX_CPF
-- Generated 12-mai-2004 21:47:39 from IFRSRH@PRODSEDE

CREATE INDEX idx_cpf ON grh_hst_dirf
  (
    ghd_num_cpf                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_CPF

-- Start of DDL Script for Index IFRSRH.IDX_DOC_CBE
-- Generated 12-mai-2004 21:47:40 from IFRSRH@PRODSEDE

CREATE INDEX idx_doc_cbe ON documentos_cobranca
  (
    doc_cbe_ben_sigla               ASC,
    doc_cbe_cre_sequencial          ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_DOC_CBE

-- Start of DDL Script for Index IFRSRH.IDX_DOC_EMB
-- Generated 12-mai-2004 21:47:41 from IFRSRH@PRODSEDE

CREATE INDEX idx_doc_emb ON documentos_cobranca
  (
    doc_emb_emp_numero_matricula    ASC,
    doc_cbe_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_DOC_EMB

-- Start of DDL Script for Index IFRSRH.IDX_DOC_PVB
-- Generated 12-mai-2004 21:47:42 from IFRSRH@PRODSEDE

CREATE INDEX idx_doc_pvb ON documentos_cobranca
  (
    doc_pvi_emp_numero_matricula    ASC,
    doc_pvi_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_DOC_PVB

-- Start of DDL Script for Index IFRSRH.IDX_EMB_BEN_FK
-- Generated 12-mai-2004 21:47:43 from IFRSRH@PRODSEDE

CREATE INDEX idx_emb_ben_fk ON empregados_beneficios
  (
    emb_ben_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_EMB_BEN_FK

-- Start of DDL Script for Index IFRSRH.IDX_EMB_DEP_FK
-- Generated 12-mai-2004 21:47:44 from IFRSRH@PRODSEDE

CREATE INDEX idx_emb_dep_fk ON empregados_beneficios
  (
    emb_dep_resp_incl               ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_EMB_DEP_FK

-- Start of DDL Script for Index IFRSRH.IDX_EMB_EMP_FK
-- Generated 12-mai-2004 21:47:45 from IFRSRH@PRODSEDE

CREATE INDEX idx_emb_emp_fk ON empregados_beneficios
  (
    emb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_EMB_EMP_FK

-- Start of DDL Script for Index IFRSRH.IDX_EPL_01
-- Generated 12-mai-2004 21:47:46 from IFRSRH@PRODSEDE

CREATE INDEX idx_epl_01 ON empregados_participacao_lucros
  (
    epl_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_EPL_01

-- Start of DDL Script for Index IFRSRH.IDX_PK
-- Generated 12-mai-2004 21:47:47 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX idx_pk ON indexadores
  (
    idx_sigla                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_PK

-- Start of DDL Script for Index IFRSRH.IDX_REE_DPF_FK
-- Generated 12-mai-2004 21:47:48 from IFRSRH@PRODSEDE

CREATE INDEX idx_ree_dpf_fk ON reembolsos
  (
    ree_emp_dep_codigo_fisico       ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_REE_DPF_FK

-- Start of DDL Script for Index IFRSRH.IDX_REE_EMB_FK
-- Generated 12-mai-2004 21:47:48 from IFRSRH@PRODSEDE

CREATE INDEX idx_ree_emb_fk ON reembolsos
  (
    ree_emb_emp_numero_matricula    ASC,
    ree_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_REE_EMB_FK

-- Start of DDL Script for Index IFRSRH.IDX_REE_PVB_FK
-- Generated 12-mai-2004 21:47:49 from IFRSRH@PRODSEDE

CREATE INDEX idx_ree_pvb_fk ON reembolsos
  (
    ree_emb_emp_numero_matricula    ASC,
    ree_pvb_pvi_sequencial          ASC,
    ree_emb_ben_sigla               ASC,
    ree_pvb_adesao                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_REE_PVB_FK

-- Start of DDL Script for Index IFRSRH.IDX_TMP_OCO_FREQ
-- Generated 12-mai-2004 21:47:50 from IFRSRH@PRODSEDE

CREATE INDEX idx_tmp_oco_freq ON tmp_oco_frequencia_emp
  (
    tmp_emp_numero_matricula        ASC,
    tmp_oem_ofu_codigo              ASC,
    tmp_oem_data_inicio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.IDX_TMP_OCO_FREQ

-- Start of DDL Script for Index IFRSRH.ILI_PK
-- Generated 12-mai-2004 21:47:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ili_pk ON itinerarios_linhas_transportes
  (
    ili_ltf_numero                  ASC,
    ili_ltf_dep_codigo              ASC,
    ili_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ILI_PK

-- Start of DDL Script for Index IFRSRH.IMR_PK
-- Generated 12-mai-2004 21:47:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX imr_pk ON impostos_rendas
  (
    imr_faixa                       ASC,
    imr_ano_referencia              ASC,
    imr_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.IMR_PK

-- Start of DDL Script for Index IFRSRH.IND_BEN_FK_I
-- Generated 12-mai-2004 21:47:53 from IFRSRH@PRODSEDE

CREATE INDEX ind_ben_fk_i ON indices
  (
    ind_ben_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_BEN_FK_I

-- Start of DDL Script for Index IFRSRH.IND_CADAS_TMP
-- Generated 12-mai-2004 21:47:54 from IFRSRH@PRODSEDE

CREATE INDEX ind_cadas_tmp ON cadastros_tmp
  (
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_CADAS_TMP

-- Start of DDL Script for Index IFRSRH.IND_CRE_FK_I
-- Generated 12-mai-2004 21:47:55 from IFRSRH@PRODSEDE

CREATE INDEX ind_cre_fk_i ON indices
  (
    ind_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_CRE_FK_I

-- Start of DDL Script for Index IFRSRH.IND_CREDEN_TMP
-- Generated 12-mai-2004 21:47:56 from IFRSRH@PRODSEDE

CREATE INDEX ind_creden_tmp ON credenciados_tmp
  (
    cre_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_CREDEN_TMP

-- Start of DDL Script for Index IFRSRH.IND_GERA_AVALIACAO
-- Generated 12-mai-2004 21:47:57 from IFRSRH@PRODSEDE

CREATE INDEX ind_gera_avaliacao ON cadastros
  (
    emp_data_admissao               ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_GERA_AVALIACAO

-- Start of DDL Script for Index IFRSRH.IND_IDX_FK_I
-- Generated 12-mai-2004 21:47:58 from IFRSRH@PRODSEDE

CREATE INDEX ind_idx_fk_i ON indices
  (
    ind_idx_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_IDX_FK_I

-- Start of DDL Script for Index IFRSRH.IND_OFE_2
-- Generated 12-mai-2004 21:47:59 from IFRSRH@PRODSEDE

CREATE INDEX ind_ofe_2 ON ocorrencias_frequencia_emp
  (
    ofe_ofu_codigo                  ASC,
    ofe_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_OFE_2

-- Start of DDL Script for Index IFRSRH.IND_PK
-- Generated 12-mai-2004 21:47:59 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ind_pk ON indices
  (
    ind_seq_ind                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.IND_PK

-- Start of DDL Script for Index IFRSRH.INTERNA_PK
-- Generated 12-mai-2004 21:48:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX interna_pk ON internacao
  (
    int_gui_doc_numero              ASC,
    int_gui_doc_cbe_ben_sigla       ASC,
    int_gui_doc_cbe_cre_sequencial  ASC,
    int_gui_doc_dep_codigo          ASC,
    int_gui_numero                  ASC,
    int_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.INTERNA_PK

-- Start of DDL Script for Index IFRSRH.IRU_PK
-- Generated 12-mai-2004 21:48:01 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX iru_pk ON incidencias_rubricas
  (
    iru_rub_codigo                  ASC,
    iru_rub_codigo_incide           ASC,
    data_inicio                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.IRU_PK

-- Start of DDL Script for Index IFRSRH.JTR_PK
-- Generated 12-mai-2004 21:48:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX jtr_pk ON jornadas_trabalho
  (
    jtr_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.JTR_PK

-- Start of DDL Script for Index IFRSRH.LA_DOC_COB_IDX
-- Generated 12-mai-2004 21:48:03 from IFRSRH@PRODSEDE

CREATE INDEX la_doc_cob_idx ON log_audit_documentos_cobranca
  (
    dta_operacao                    ASC,
    cod_usuario                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.LA_DOC_COB_IDX

-- Start of DDL Script for Index IFRSRH.LET_PK
-- Generated 12-mai-2004 21:48:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX let_pk ON listas_esperas_transportes
  (
    let_emb_emp_numero_matricula    ASC,
    let_emb_ben_sigla               ASC,
    let_ltf_numero                  ASC,
    let_ltf_dep_codigo              ASC,
    let_data_inclusao               ASC
  )
/


-- End of DDL Script for Index IFRSRH.LET_PK

-- Start of DDL Script for Index IFRSRH.LMV_AMVERTS_IX
-- Generated 12-mai-2004 21:48:05 from IFRSRH@PRODSEDE

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
/


-- End of DDL Script for Index IFRSRH.LMV_AMVERTS_IX

-- Start of DDL Script for Index IFRSRH.LOA_PK
-- Generated 12-mai-2004 21:48:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX loa_pk ON local_atendimento
  (
    loa_cre_sequencial              ASC,
    loa_codigo                      ASC,
    loa_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.LOA_PK

-- Start of DDL Script for Index IFRSRH.LOCOREMP_IND2
-- Generated 12-mai-2004 21:48:07 from IFRSRH@PRODSEDE

CREATE INDEX locoremp_ind2 ON log_ocorrencias_empregados
  (
    oem_emp_numero_matricula        ASC,
    oem_ofu_codigo                  ASC,
    oem_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.LOCOREMP_IND2

-- Start of DDL Script for Index IFRSRH.LOG_ATF_PK
-- Generated 12-mai-2004 21:48:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX log_atf_pk ON log_atividades_funcoes
  (
    dta_operacao                    ASC,
    atf_fun_codigo                  ASC,
    atf_ati_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.LOG_ATF_PK

-- Start of DDL Script for Index IFRSRH.LOG_EMB_UK1
-- Generated 12-mai-2004 21:48:09 from IFRSRH@PRODSEDE

CREATE INDEX log_emb_uk1 ON log_empregados_beneficios
  (
    emb_ben_sigla                   ASC,
    emb_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.LOG_EMB_UK1

-- Start of DDL Script for Index IFRSRH.LOG_OCO_DT_INCL1
-- Generated 12-mai-2004 21:48:10 from IFRSRH@PRODSEDE

CREATE INDEX log_oco_dt_incl1 ON log_ocorrencias_empregados
  (
    oem_data_inclusao               ASC,
    oem_ofu_codigo                  ASC,
    oem_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.LOG_OCO_DT_INCL1

-- Start of DDL Script for Index IFRSRH.LPM_LOCAL_PK
-- Generated 12-mai-2004 21:48:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX lpm_local_pk ON lpm_local
  (
    lpl_codigo                      ASC,
    lpl_cre_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.LPM_LOCAL_PK

-- Start of DDL Script for Index IFRSRH.LPM_PK
-- Generated 12-mai-2004 21:48:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX lpm_pk ON lpm
  (
    lpm_codigo                      ASC,
    lpm_dv                          ASC,
    lpm_esp_tipo                    ASC,
    lpm_esp_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.LPM_PK

-- Start of DDL Script for Index IFRSRH.LPR_PK
-- Generated 12-mai-2004 21:48:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX lpr_pk ON licenca_premio
  (
    lpr_emp_numero_matricula        ASC,
    lpr_dt_inicio_periodo_aquis     ASC
  )
/


-- End of DDL Script for Index IFRSRH.LPR_PK

-- Start of DDL Script for Index IFRSRH.LTF_PK
-- Generated 12-mai-2004 21:48:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ltf_pk ON linhas_transportes_fretados
  (
    ltf_numero                      ASC,
    ltf_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.LTF_PK

-- Start of DDL Script for Index IFRSRH.MAC_PK
-- Generated 12-mai-2004 21:48:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX mac_pk ON movimentacao_autonomo_cooperat
  (
    mac_ano_referencia              ASC,
    mac_mes_referencia              ASC,
    mac_cre_sequencial              ASC,
    mac_dta_pagto                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.MAC_PK

-- Start of DDL Script for Index IFRSRH.MCT_PK
-- Generated 12-mai-2004 21:48:15 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX mct_pk ON medias_categorias_transportes
  (
    mct_dep_codigo                  ASC,
    mct_mesano_referencia           ASC
  )
/


-- End of DDL Script for Index IFRSRH.MCT_PK

-- Start of DDL Script for Index IFRSRH.MEC_PK
-- Generated 12-mai-2004 21:48:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX mec_pk ON mensagens_contracheques
  (
    mec_ano                         ASC,
    mec_mes                         ASC,
    mec_codigo                      ASC,
    mec_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.MEC_PK

-- Start of DDL Script for Index IFRSRH.MOT_NAV_PK
-- Generated 12-mai-2004 21:48:17 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX mot_nav_pk ON siad_motivo_nao_avaliacao
  (
    codigo_motivo                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOT_NAV_PK

-- Start of DDL Script for Index IFRSRH.MOTN_PROM_PK
-- Generated 12-mai-2004 21:48:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX motn_prom_pk ON spf_motivo_nao_promocao
  (
    ano_promocao                    ASC,
    cod_motivo_nao_promocao         ASC,
    tipo_promocao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOTN_PROM_PK

-- Start of DDL Script for Index IFRSRH.MOV_DEP_IX
-- Generated 12-mai-2004 21:48:19 from IFRSRH@PRODSEDE

CREATE INDEX mov_dep_ix ON movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_DEP_IX

-- Start of DDL Script for Index IFRSRH.MOV_EMP_IDX
-- Generated 12-mai-2004 21:48:20 from IFRSRH@PRODSEDE

CREATE INDEX mov_emp_idx ON movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_EMP_IDX

-- Start of DDL Script for Index IFRSRH.MOV_PEN_FK
-- Generated 12-mai-2004 21:48:21 from IFRSRH@PRODSEDE

CREATE INDEX mov_pen_fk ON movimentacao
  (
    mov_emp_numero_matricula        ASC,
    mov_pen_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_PEN_FK

-- Start of DDL Script for Index IFRSRH.MOV_PK
-- Generated 12-mai-2004 21:48:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX mov_pk ON movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_numero_matricula        ASC,
    mov_rub_codigo                  ASC,
    mov_tip_rubrica                 ASC,
    mov_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_PK

-- Start of DDL Script for Index IFRSRH.MOV_PKT_COD_PEDIDO_IX
-- Generated 12-mai-2004 21:48:23 from IFRSRH@PRODSEDE

CREATE INDEX mov_pkt_cod_pedido_ix ON historico_movimentacao
  (
    mov_pkt_codigo_pedido           ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_PKT_COD_PEDIDO_IX

-- Start of DDL Script for Index IFRSRH.MOV_PKT_CODIGO_PEDIDO_IX
-- Generated 12-mai-2004 21:48:24 from IFRSRH@PRODSEDE

CREATE INDEX mov_pkt_codigo_pedido_ix ON movimentacao
  (
    mov_pkt_codigo_pedido           ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOV_PKT_CODIGO_PEDIDO_IX

-- Start of DDL Script for Index IFRSRH.MOVIMENTACAO_IND1
-- Generated 12-mai-2004 21:48:24 from IFRSRH@PRODSEDE

CREATE INDEX movimentacao_ind1 ON movimentacao
  (
    mov_oem_emp_numero_matricula    ASC,
    mov_oem_ofu_codigo              ASC,
    mov_oem_data_inicio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.MOVIMENTACAO_IND1

-- Start of DDL Script for Index IFRSRH.NSA_PK
-- Generated 12-mai-2004 21:48:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX nsa_pk ON niveis_salariais
  (
    nsa_codigo_nivel                ASC,
    nsa_codigo_padrao               ASC,
    nsa_indicador_nivel_escola      ASC
  )
/


-- End of DDL Script for Index IFRSRH.NSA_PK

-- Start of DDL Script for Index IFRSRH.OCC_PK
-- Generated 12/5/2004 21:48:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX occ_pk ON ocupacoes_cargo
  (
    occ_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.OCC_PK

-- Start of DDL Script for Index IFRSRH.OCL_PK
-- Generated 12/5/2004 21:48:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ocl_pk ON orgaos_classes
  (
    ocl_sigla                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.OCL_PK

-- Start of DDL Script for Index IFRSRH.OCL_UK
-- Generated 12/5/2004 21:48:28 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ocl_uk ON orgaos_classes
  (
    ocl_descricao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.OCL_UK

-- Start of DDL Script for Index IFRSRH.OCO_EMP_IDX
-- Generated 12/5/2004 21:48:29 from IFRSRH@PRODSEDE

CREATE INDEX oco_emp_idx ON tmp_contabilidade_relatorios
  (
    cod_oco                         ASC,
    empregado                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.OCO_EMP_IDX

-- Start of DDL Script for Index IFRSRH.OEI
-- Generated 12/5/2004 21:48:30 from IFRSRH@PRODSEDE

CREATE INDEX oei ON ocorrencias_empregados
  (
    oem_uor_codigo                  ASC,
    oem_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEI

-- Start of DDL Script for Index IFRSRH.OEM_DEP_FK
-- Generated 12/5/2004 21:48:31 from IFRSRH@PRODSEDE

CREATE INDEX oem_dep_fk ON ocorrencias_empregados
  (
    oem_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_DEP_FK

-- Start of DDL Script for Index IFRSRH.OEM_EMP_SUBSTITUIR_FK_I
-- Generated 12/5/2004 21:48:32 from IFRSRH@PRODSEDE

CREATE INDEX oem_emp_substituir_fk_i ON ocorrencias_empregados
  (
    oem_emp_numero_matricula_subst  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_EMP_SUBSTITUIR_FK_I

-- Start of DDL Script for Index IFRSRH.OEM_OEM_FK_I
-- Generated 12/5/2004 21:48:33 from IFRSRH@PRODSEDE

CREATE INDEX oem_oem_fk_i ON ocorrencias_empregados
  (
    oem_oem_emp_numero_matricula    ASC,
    oem_oem_ofu_codigo              ASC,
    oem_oem_data_inicio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_OEM_FK_I

-- Start of DDL Script for Index IFRSRH.OEM_OFU_FK_I
-- Generated 12/5/2004 21:48:33 from IFRSRH@PRODSEDE

CREATE INDEX oem_ofu_fk_i ON ocorrencias_empregados
  (
    oem_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_OFU_FK_I

-- Start of DDL Script for Index IFRSRH.OEM_PK
-- Generated 12/5/2004 21:48:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oem_pk ON ocorrencias_empregados
  (
    oem_emp_numero_matricula        ASC,
    oem_ofu_codigo                  ASC,
    oem_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_PK

-- Start of DDL Script for Index IFRSRH.OEM_TEMP_PK
-- Generated 12/5/2004 21:48:36 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oem_temp_pk ON ocorrencias_empregados_temp
  (
    oem_emp_numero_matricula        ASC,
    oem_ofu_codigo                  ASC,
    oem_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.OEM_TEMP_PK

-- Start of DDL Script for Index IFRSRH.OFE_DEP_FK
-- Generated 12/5/2004 21:48:37 from IFRSRH@PRODSEDE

CREATE INDEX ofe_dep_fk ON ocorrencias_frequencia_emp
  (
    ofe_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OFE_DEP_FK

-- Start of DDL Script for Index IFRSRH.OFE_OFE_FK
-- Generated 12/5/2004 21:48:38 from IFRSRH@PRODSEDE

CREATE INDEX ofe_ofe_fk ON ocorrencias_frequencia_emp
  (
    ofe_ofe_emp_numero_matricula    ASC,
    ofe_ofe_ofu_codigo              ASC,
    ofe_ofe_data_inicio             ASC
  )
/


-- End of DDL Script for Index IFRSRH.OFE_OFE_FK

-- Start of DDL Script for Index IFRSRH.OFE_PK
-- Generated 12/5/2004 21:48:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ofe_pk ON ocorrencias_frequencia_emp
  (
    ofe_emp_numero_matricula        ASC,
    ofe_ofu_codigo                  ASC,
    ofe_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.OFE_PK

-- Start of DDL Script for Index IFRSRH.OFU_PK
-- Generated 12/5/2004 21:48:40 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ofu_pk ON tipos_ocorrencias
  (
    ofu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.OFU_PK

-- Start of DDL Script for Index IFRSRH.OFU_UK
-- Generated 12/5/2004 21:48:41 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ofu_uk ON tipos_ocorrencias
  (
    ofu_descricao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.OFU_UK

-- Start of DDL Script for Index IFRSRH.OIA_PK
-- Generated 12/5/2004 21:48:42 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oia_pk ON ocorrencias_inss_agnocivos
  (
    oia_agn_codigo                  ASC,
    oia_oin_codigo_padrao_nacional  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OIA_PK

-- Start of DDL Script for Index IFRSRH.OIN_PK
-- Generated 12/5/2004 21:48:43 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oin_pk ON ocorrencias_inss
  (
    oin_codigo_padrao_nacional      ASC
  )
/


-- End of DDL Script for Index IFRSRH.OIN_PK

-- Start of DDL Script for Index IFRSRH.OPE_PK
-- Generated 12/5/2004 21:48:44 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ope_pk ON operandos
  (
    ope_sigla                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.OPE_PK

-- Start of DDL Script for Index IFRSRH.OPP_PK
-- Generated 12/5/2004 21:48:44 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX opp_pk ON ocorrencias_pis_pasep
  (
    nome_arquivo                    ASC,
    codido_ocorrencia               ASC,
    tipo_ocorrencia                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.OPP_PK

-- Start of DDL Script for Index IFRSRH.OPPA_PK
-- Generated 12/5/2004 21:48:45 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oppa_pk ON ocorrencias_pis_pasep_arquivo
  (
    data_processamento              ASC,
    sequencial_arquivo              ASC,
    nome_arquivo_pis_pasep          ASC
  )
/


-- End of DDL Script for Index IFRSRH.OPPA_PK

-- Start of DDL Script for Index IFRSRH.OPPE_PK
-- Generated 12/5/2004 21:48:46 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX oppe_pk ON ocorrencias_pis_pasep_emp
  (
    matricula                       ASC,
    data_processamento              ASC,
    sequencial_arquivo              ASC,
    sequencial_emp                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OPPE_PK

-- Start of DDL Script for Index IFRSRH.ORT_DEP_FK
-- Generated 12/5/2004 21:48:47 from IFRSRH@PRODSEDE

CREATE INDEX ort_dep_fk ON ocorrencias_receb_tickets
  (
    ort_dep_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ORT_DEP_FK

-- Start of DDL Script for Index IFRSRH.ORT_EMB_FK
-- Generated 12/5/2004 21:48:48 from IFRSRH@PRODSEDE

CREATE INDEX ort_emb_fk ON ocorrencias_receb_tickets
  (
    ort_emb_emp_numero_matricula    ASC,
    ort_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.ORT_EMB_FK

-- Start of DDL Script for Index IFRSRH.ORT_PK
-- Generated 12/5/2004 21:48:49 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ort_pk ON ocorrencias_receb_tickets
  (
    ort_mes                         ASC,
    ort_ano                         ASC,
    ort_tipo_pedido                 ASC,
    ort_emb_emp_numero_matricula    ASC,
    ort_codigo_pedido               ASC,
    ort_data                        ASC
  )
/


-- End of DDL Script for Index IFRSRH.ORT_PK

-- Start of DDL Script for Index IFRSRH.ORT_UOR_FK
-- Generated 12/5/2004 21:48:50 from IFRSRH@PRODSEDE

CREATE INDEX ort_uor_fk ON ocorrencias_receb_tickets
  (
    ort_uor_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.ORT_UOR_FK

-- Start of DDL Script for Index IFRSRH.ORV_PK
-- Generated 12/5/2004 21:48:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX orv_pk ON ocorrencias_receb_vales
  (
    orv_dep_codigo_fisico           ASC,
    orv_emc_cat_sigla               ASC,
    orv_emc_emb_emp_numero_matricu  ASC,
    orv_emc_emb_ben_sigla           ASC,
    orv_sequencial                  ASC,
    orv_mes                         ASC,
    orv_ano                         ASC
  )
/


-- End of DDL Script for Index IFRSRH.ORV_PK

-- Start of DDL Script for Index IFRSRH.OSF_OFU_FK_I
-- Generated 12/5/2004 21:48:52 from IFRSRH@PRODSEDE

CREATE INDEX osf_ofu_fk_i ON ocorrencias_situacoes_func
  (
    osf_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OSF_OFU_FK_I

-- Start of DDL Script for Index IFRSRH.OSF_PK
-- Generated 12/5/2004 21:48:53 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX osf_pk ON ocorrencias_situacoes_func
  (
    osf_sfu_codigo                  ASC,
    osf_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OSF_PK

-- Start of DDL Script for Index IFRSRH.OSF_SFU_FK_I
-- Generated 12/5/2004 21:48:54 from IFRSRH@PRODSEDE

CREATE INDEX osf_sfu_fk_i ON ocorrencias_situacoes_func
  (
    osf_sfu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OSF_SFU_FK_I

-- Start of DDL Script for Index IFRSRH.OVC_PK
-- Generated 12/5/2004 21:48:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ovc_pk ON ocorrencia_viagem_centro_custo
  (
    ovc_ove_oem_emp_num_matricula   ASC,
    ovc_ove_oem_ofu_codigo          ASC,
    ovc_ove_oem_data_inicio         ASC,
    ovc_ove_codigo_trecho           ASC,
    ovc_cct_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.OVC_PK

-- Start of DDL Script for Index IFRSRH.OVE_PK
-- Generated 12/5/2004 21:48:56 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ove_pk ON ocorrencias_viagens_empregados
  (
    ove_oem_emp_numero_matricula    ASC,
    ove_oem_ofu_codigo              ASC,
    ove_oem_data_inicio             ASC,
    ove_codigo_trecho               ASC
  )
/


-- End of DDL Script for Index IFRSRH.OVE_PK

-- Start of DDL Script for Index IFRSRH.PCF
-- Generated 12/5/2004 21:48:57 from IFRSRH@PRODSEDE

CREATE INDEX pcf ON pagamento_calculado_final
  (
    ano                             ASC,
    mes                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.PCF

-- Start of DDL Script for Index IFRSRH.PCO_PK
-- Generated 12/5/2004 21:48:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pco_pk ON pedidos_cobrancas
  (
    pco_doc_numero                  ASC,
    pco_doc_cbe_ben_sigla           ASC,
    pco_doc_cbe_cre_sequencial      ASC,
    pco_doc_dep_codigo              ASC,
    pco_numero_pedido               ASC
  )
/


-- End of DDL Script for Index IFRSRH.PCO_PK

-- Start of DDL Script for Index IFRSRH.PEN_PK
-- Generated 12/5/2004 21:48:59 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pen_pk ON pensionistas
  (
    pen_emp_numero_matricula        ASC,
    pen_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PEN_PK

-- Start of DDL Script for Index IFRSRH.PEP
-- Generated 12/5/2004 21:48:59 from IFRSRH@PRODSEDE

CREATE INDEX pep ON posicao_empregado_pagamento
  (
    matricula                       ASC,
    ano                             ASC,
    mes                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.PEP

-- Start of DDL Script for Index IFRSRH.PFE_PK
-- Generated 12/5/2004 21:49:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pfe_pk ON programacoes_ferias
  (
    pfe_emp_numero_matricula        ASC,
    pfe_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PFE_PK

-- Start of DDL Script for Index IFRSRH.PGC_2110
-- Generated 12/5/2004 21:49:01 from IFRSRH@PRODSEDE

CREATE INDEX pgc_2110 ON pagamento_calculado_2110
  (
    ano                             ASC,
    mes                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.PGC_2110

-- Start of DDL Script for Index IFRSRH.PGE_SEQUENCIAL_PK
-- Generated 12/5/2004 21:49:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pge_sequencial_pk ON pagamentos_especiais
  (
    pge_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PGE_SEQUENCIAL_PK

-- Start of DDL Script for Index IFRSRH.PGR_CODIGO_PK
-- Generated 12/5/2004 21:49:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pgr_codigo_pk ON posto_graduacao
  (
    pgr_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PGR_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.PIA_PK
-- Generated 12/5/2004 21:49:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pia_pk ON pericul_insalub_agnocivos
  (
    pia_agn_codigo                  ASC,
    pia_hpi_emp_numero_matricula    ASC,
    pia_hpi_data_inicio             ASC,
    pia_hpi_ind_pericul_insalub     ASC
  )
/


-- End of DDL Script for Index IFRSRH.PIA_PK

-- Start of DDL Script for Index IFRSRH.PIN_PK
-- Generated 12/5/2004 21:49:05 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pin_pk ON pericul_insalub_nao_autorizada
  (
    pin_emp_numero_matricula        ASC,
    pin_data_inicio                 ASC,
    pin_ind_pericul_insalub         ASC,
    pin_data_nao_autorizacao        ASC
  )
/


-- End of DDL Script for Index IFRSRH.PIN_PK

-- Start of DDL Script for Index IFRSRH.PK_LEF
-- Generated 12/5/2004 21:49:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pk_lef ON log_erro_folha_fechada
  (
    lef_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PK_LEF

-- Start of DDL Script for Index IFRSRH.PK_TAB_PARAMETROS
-- Generated 12/5/2004 21:49:07 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pk_tab_parametros ON tab_parametros
  (
    cod_grupo                       ASC,
    cod_assunto                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.PK_TAB_PARAMETROS

-- Start of DDL Script for Index IFRSRH.PK_TAB_PARAMETROS_DETALHES
-- Generated 12/5/2004 21:49:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pk_tab_parametros_detalhes ON tab_parametros_detalhes
  (
    data_inicio                     ASC,
    cod_grupo                       ASC,
    cod_assunto                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.PK_TAB_PARAMETROS_DETALHES

-- Start of DDL Script for Index IFRSRH.PKT_PK
-- Generated 12/5/2004 21:49:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pkt_pk ON pedidos_tickets
  (
    pkt_codigo_pedido               ASC,
    pkt_dependencia                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.PKT_PK

-- Start of DDL Script for Index IFRSRH.PLA_PK
-- Generated 12/5/2004 21:49:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pla_pk ON planos_medicos
  (
    pla_cre_sequencial              ASC,
    pla_cod_plano                   ASC,
    pla_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.PLA_PK

-- Start of DDL Script for Index IFRSRH.PMP
-- Generated 12/5/2004 21:49:10 from IFRSRH@PRODSEDE

CREATE INDEX pmp ON projecao_movimento_pagamento
  (
    ano                             ASC,
    mes                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.PMP

-- Start of DDL Script for Index IFRSRH.POD_PK
-- Generated 12/5/2004 21:49:11 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pod_pk ON procedimentos_odontologicos
  (
    pod_ato_numero                  ASC,
    pod_abo_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.POD_PK

-- Start of DDL Script for Index IFRSRH.POF_UK
-- Generated 12/5/2004 21:49:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pof_uk ON parametros_ocorrencias_func
  (
    cd_perfil                       ASC,
    ofu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.POF_UK

-- Start of DDL Script for Index IFRSRH.PORTE_PK
-- Generated 12/5/2004 21:49:13 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX porte_pk ON portes_anestesicos
  (
    porte                           ASC
  )
/


-- End of DDL Script for Index IFRSRH.PORTE_PK

-- Start of DDL Script for Index IFRSRH.PPA_PK
-- Generated 12/5/2004 21:49:14 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ppa_pk ON previsao_pagamento
  (
    ppa_ano_pagamento               ASC,
    ppa_mes_pagamento               ASC
  )
/


-- End of DDL Script for Index IFRSRH.PPA_PK

-- Start of DDL Script for Index IFRSRH.PRF_PK
-- Generated 12/5/2004 21:49:15 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX prf_pk ON pre_requisito_funcao
  (
    prf_fun_codigo                  ASC,
    prf_prr_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PRF_PK

-- Start of DDL Script for Index IFRSRH.PRM_UK
-- Generated 12/5/2004 21:49:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX prm_uk ON parametros_funcoes
  (
    cd_perfil                       ASC,
    fun_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PRM_UK

-- Start of DDL Script for Index IFRSRH.PROCESSOS_CADASTROS_FK_I
-- Generated 12/5/2004 21:49:17 from IFRSRH@PRODSEDE

CREATE INDEX processos_cadastros_fk_i ON spf_processo_judicial
  (
    cadastros_emp_numero_matricula  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROCESSOS_CADASTROS_FK_I

-- Start of DDL Script for Index IFRSRH.PROCESSOS_PK
-- Generated 12/5/2004 21:49:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX processos_pk ON spf_processo_judicial
  (
    tip_proc_tipo_processo_judicia  ASC,
    cadastros_emp_numero_matricula  ASC,
    data_inicio_impedimento         ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROCESSOS_PK

-- Start of DDL Script for Index IFRSRH.PROCESSOS_TIP_PROC_FK_I
-- Generated 12/5/2004 21:49:18 from IFRSRH@PRODSEDE

CREATE INDEX processos_tip_proc_fk_i ON spf_processo_judicial
  (
    tip_proc_tipo_processo_judicia  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROCESSOS_TIP_PROC_FK_I

-- Start of DDL Script for Index IFRSRH.PROMOCAO_PK
-- Generated 12/5/2004 21:49:19 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX promocao_pk ON spf_promocao
  (
    tipos_ocor_ofu_codigo           ASC,
    ano_promocao                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROMOCAO_PK

-- Start of DDL Script for Index IFRSRH.PROMOCAO_TIPOS_OCOR_FK_I
-- Generated 12/5/2004 21:49:20 from IFRSRH@PRODSEDE

CREATE INDEX promocao_tipos_ocor_fk_i ON spf_promocao
  (
    tipos_ocor_ofu_codigo           ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROMOCAO_TIPOS_OCOR_FK_I

-- Start of DDL Script for Index IFRSRH.PROVISIONAMENTO_PK
-- Generated 12/5/2004 21:49:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX provisionamento_pk ON provisionamento
  (
    ano                             ASC,
    mes                             ASC,
    seq                             ASC,
    dep_codigo                      ASC,
    custo                           ASC,
    conta                           ASC,
    matricula                       ASC,
    tipo_prov                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROVISIONAMENTO_PK

-- Start of DDL Script for Index IFRSRH.PROVISOES_EMPREGADOS_PK
-- Generated 12/5/2004 21:49:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX provisoes_empregados_pk ON provisoes_empregados
  (
    ano_referencia                  ASC,
    mes_referencia                  ASC,
    num_versao                      ASC,
    emp_numero_matricula            ASC,
    tipo_provisao                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.PROVISOES_EMPREGADOS_PK

-- Start of DDL Script for Index IFRSRH.PRR_PK
-- Generated 12/5/2004 21:49:23 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX prr_pk ON pre_requisitos
  (
    prr_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PRR_PK

-- Start of DDL Script for Index IFRSRH.PRS_PK
-- Generated 12/5/2004 21:49:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX prs_pk ON premio_seguro
  (
    prs_ano                         ASC,
    prs_mes                         ASC,
    prs_emp_numero_matricula        ASC,
    prs_apolice                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.PRS_PK

-- Start of DDL Script for Index IFRSRH.PSV_PK
-- Generated 12/5/2004 21:49:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX psv_pk ON pessoal_sem_vinculo
  (
    psv_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PSV_PK

-- Start of DDL Script for Index IFRSRH.PVB_EMB_FK_I
-- Generated 12/5/2004 21:49:26 from IFRSRH@PRODSEDE

CREATE INDEX pvb_emb_fk_i ON pessoas_vinculadas_benef
  (
    pvb_pvi_emp_numero_matricula    ASC,
    emb_ben_sigla                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.PVB_EMB_FK_I

-- Start of DDL Script for Index IFRSRH.PVB_PK
-- Generated 12/5/2004 21:49:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pvb_pk ON pessoas_vinculadas_benef
  (
    pvb_pvi_emp_numero_matricula    ASC,
    pvb_pvi_sequencial              ASC,
    emb_ben_sigla                   ASC,
    pvb_adesao                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.PVB_PK

-- Start of DDL Script for Index IFRSRH.PVI_PK
-- Generated 12/5/2004 21:49:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX pvi_pk ON pessoas_vinculadas
  (
    pvi_emp_numero_matricula        ASC,
    pvi_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.PVI_PK

-- Start of DDL Script for Index IFRSRH.QAE_CODIGO_PK
-- Generated 12/5/2004 21:49:28 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qae_codigo_pk ON quadro_arma_espec
  (
    qae_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.QAE_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.QCD_PK
-- Generated 12/5/2004 21:49:29 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qcd_pk ON quadro_cargos_dependencias
  (
    qcd_hcd_dep_codigo              ASC,
    qcd_hcd_data_vigencia           ASC,
    qcd_car_codigo                  ASC,
    qcd_car_codigo_nivel            ASC,
    qcd_car_occ_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.QCD_PK

-- Start of DDL Script for Index IFRSRH.QDA_PK
-- Generated 12/5/2004 21:49:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qda_pk ON qcd_area_atuacao
  (
    qda_atu_codigo                  ASC,
    qda_qcd_hcd_dep_codigo          ASC,
    qda_qcd_hcd_data_vigencia       ASC,
    qda_qcd_car_codigo              ASC,
    qda_qcd_car_codigo_nivel        ASC,
    qda_qcd_car_occ_codigo          ASC,
    qda_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.QDA_PK

-- Start of DDL Script for Index IFRSRH.QFD_PK
-- Generated 12/5/2004 21:49:31 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qfd_pk ON quadros_funcoes_dependencias
  (
    qfd_hfd_dep_codigo              ASC,
    qfd_hfd_data_vigencia           ASC,
    qfd_fun_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.QFD_PK

-- Start of DDL Script for Index IFRSRH.QFU_PK
-- Generated 12/5/2004 21:49:32 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qfu_pk ON quadro_funcoes
  (
    qfu_fun_codigo                  ASC,
    qfu_hfl_uor_codigo              ASC,
    qfu_hfl_data_vigencia           ASC
  )
/


-- End of DDL Script for Index IFRSRH.QFU_PK

-- Start of DDL Script for Index IFRSRH.QLA_PK
-- Generated 12/5/2004 21:49:33 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qla_pk ON qlp_area_atuacao
  (
    qla_atu_codigo                  ASC,
    qla_qlp_icl_uor_codigo          ASC,
    qla_qlp_icl_data_vigencia       ASC,
    qla_qlp_car_codigo              ASC,
    qla_qlp_car_codigo_nivel        ASC,
    qla_qlp_car_occ_codigo          ASC,
    qla_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.QLA_PK

-- Start of DDL Script for Index IFRSRH.QLP_PK
-- Generated 12/5/2004 21:49:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX qlp_pk ON quadros_lotacao_pessoal
  (
    qlp_icl_uor_codigo              ASC,
    qlp_icl_data_vigencia           ASC,
    qlp_car_codigo                  ASC,
    qlp_car_codigo_nivel            ASC,
    qlp_car_occ_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.QLP_PK

-- Start of DDL Script for Index IFRSRH.QUAC_PK
-- Generated 12/5/2004 21:49:35 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX quac_pk ON tab_qualificacao_academica
  (
    qua_cod_qualif_academica        ASC
  )
/


-- End of DDL Script for Index IFRSRH.QUAC_PK

-- Start of DDL Script for Index IFRSRH.RAA_PK
-- Generated 12/5/2004 21:49:36 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX raa_pk ON refer_auxilio_alimentacao
  (
    raa_falta                       ASC,
    raa_quantidade                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.RAA_PK

-- Start of DDL Script for Index IFRSRH.RAC_PK
-- Generated 12/5/2004 21:49:36 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rac_pk ON reembolsos_auxilios_creches
  (
    rac_sequencial                  ASC,
    data_inicio                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.RAC_PK

-- Start of DDL Script for Index IFRSRH.RDF_PK
-- Generated 12/5/2004 21:49:37 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rdf_pk ON reajuste_percentual_13_ferias
  (
    rdf_ano_referencia              ASC,
    rdf_mes_referencia              ASC,
    rdf_gru_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.RDF_PK

-- Start of DDL Script for Index IFRSRH.REA_PK
-- Generated 12/5/2004 21:49:38 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rea_pk ON resumo_encargos_inss_autonomo
  (
    rea_ano_referencia              ASC,
    rea_mes_referencia              ASC,
    rea_versao_pagto                ASC,
    rea_dep_codigo                  ASC,
    rea_cre_sequencial              ASC,
    rea_ind_aut_coop                ASC
  )
/


-- End of DDL Script for Index IFRSRH.REA_PK

-- Start of DDL Script for Index IFRSRH.REE_PK
-- Generated 12/5/2004 21:49:39 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ree_pk ON reembolsos
  (
    ree_sequencial                  ASC,
    ree_emb_emp_numero_matricula    ASC,
    ree_mes                         ASC,
    ree_ano                         ASC,
    ree_tipo                        ASC,
    ree_emb_ben_sigla               ASC
  )
/


-- End of DDL Script for Index IFRSRH.REE_PK

-- Start of DDL Script for Index IFRSRH.REF_PK
-- Generated 12/5/2004 21:49:40 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ref_pk ON resumo_encargos_fgts
  (
    ref_ano_referencia              ASC,
    ref_mes_referencia              ASC,
    ref_versao_pagto                ASC,
    ref_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.REF_PK

-- Start of DDL Script for Index IFRSRH.REG_ERRO_MIGRACAO_FOLHA_RDB_IX
-- Generated 12/5/2004 21:49:41 from IFRSRH@PRODSEDE

CREATE INDEX reg_erro_migracao_folha_rdb_ix ON reg_erro_migracao_folha_rdb
  (
    rem_ano_referencia              ASC,
    rem_mes_referencia              ASC,
    rem_versao_pagamento            ASC,
    rem_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_ERRO_MIGRACAO_FOLHA_RDB_IX

-- Start of DDL Script for Index IFRSRH.REG_PAG_CALCULADO_2110_IX
-- Generated 12/5/2004 21:49:42 from IFRSRH@PRODSEDE

CREATE INDEX reg_pag_calculado_2110_ix ON reg_pagamento_calculado_2110
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_PAG_CALCULADO_2110_IX

-- Start of DDL Script for Index IFRSRH.REG_PAGTO_CALCULADO_FINAL_IX
-- Generated 12/5/2004 21:49:43 from IFRSRH@PRODSEDE

CREATE INDEX reg_pagto_calculado_final_ix ON reg_pagamento_calculado_final
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_PAGTO_CALCULADO_FINAL_IX

-- Start of DDL Script for Index IFRSRH.REG_POSICAO_EMP_PAGAMENTO_IX
-- Generated 12/5/2004 21:49:44 from IFRSRH@PRODSEDE

CREATE INDEX reg_posicao_emp_pagamento_ix ON reg_posicao_emp_pagamento
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_matricula                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_POSICAO_EMP_PAGAMENTO_IX

-- Start of DDL Script for Index IFRSRH.REG_REMUNERACAO_2110_IX
-- Generated 12/5/2004 21:49:45 from IFRSRH@PRODSEDE

CREATE INDEX reg_remuneracao_2110_ix ON reg_remuneracao_2110
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_REMUNERACAO_2110_IX

-- Start of DDL Script for Index IFRSRH.REG_REMUNERACAO_FINAL_IX
-- Generated 12/5/2004 21:49:46 from IFRSRH@PRODSEDE

CREATE INDEX reg_remuneracao_final_ix ON reg_remuneracao_final
  (
    arq_ano                         ASC,
    arq_mes                         ASC,
    arq_mat                         ASC
  )
/


-- End of DDL Script for Index IFRSRH.REG_REMUNERACAO_FINAL_IX

-- Start of DDL Script for Index IFRSRH.REI_PK
-- Generated 12/5/2004 21:49:47 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rei_pk ON resumo_encargos_inss
  (
    rei_ano_referencia              ASC,
    rei_mes_referencia              ASC,
    rei_versao_pagto                ASC,
    rei_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.REI_PK

-- Start of DDL Script for Index IFRSRH.RELATIONSHIP_1_FK
-- Generated 12/5/2004 21:49:47 from IFRSRH@PRODSEDE

CREATE INDEX relationship_1_fk ON tab_parametros_detalhes
  (
    cod_grupo                       ASC,
    cod_assunto                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.RELATIONSHIP_1_FK

-- Start of DDL Script for Index IFRSRH.REM_2110_IDX
-- Generated 12/5/2004 21:49:48 from IFRSRH@PRODSEDE

CREATE INDEX rem_2110_idx ON remuneracao_2110
  (
    ano                             ASC,
    mes                             ASC,
    mat                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.REM_2110_IDX

-- Start of DDL Script for Index IFRSRH.REM_FIN_IDX
-- Generated 12/5/2004 21:49:49 from IFRSRH@PRODSEDE

CREATE INDEX rem_fin_idx ON remuneracao_final
  (
    ano                             ASC,
    mes                             ASC,
    mat                             ASC
  )
/


-- End of DDL Script for Index IFRSRH.REM_FIN_IDX

-- Start of DDL Script for Index IFRSRH.RETENCAO_PK
-- Generated 12/5/2004 21:49:50 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX retencao_pk ON retencao_impostos
  (
    ri_cod_receita                  ASC,
    ri_dat_inicio                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.RETENCAO_PK

-- Start of DDL Script for Index IFRSRH.RFI_PK
-- Generated 12/5/2004 21:49:51 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rfi_pk ON responsavel_financeiro
  (
    rfi_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.RFI_PK

-- Start of DDL Script for Index IFRSRH.RFP_PK
-- Generated 12/5/2004 21:49:52 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rfp_pk ON resp_financeiro_psv
  (
    rfp_ano_referencia              ASC,
    "RFP_MÊS_REFERENCIA"            ASC,
    rfp_psv_sequencial              ASC,
    rfp_rfi_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.RFP_PK

-- Start of DDL Script for Index IFRSRH.RIN_PK
-- Generated 12/5/2004 21:49:53 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rin_pk ON resumo_encargos_infraprev
  (
    rin_ano_referencia              ASC,
    rin_mes_referencia              ASC,
    rin_versao_pagto                ASC,
    rin_emp_numero_matricula        ASC,
    rin_plano_infraprev             ASC
  )
/


-- End of DDL Script for Index IFRSRH.RIN_PK

-- Start of DDL Script for Index IFRSRH.RIR_PK
-- Generated 12/5/2004 21:49:54 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rir_pk ON resumo_encargos_irrf
  (
    rir_ano_referencia              ASC,
    rir_mes_referencia              ASC,
    rir_versao_pagto                ASC,
    rir_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.RIR_PK

-- Start of DDL Script for Index IFRSRH.RSE_PK
-- Generated 12/5/2004 21:49:55 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rse_pk ON resumo_encargos_sal_educacao
  (
    rse_ano_referencia              ASC,
    rse_mes_referencia              ASC,
    rse_versao_pagto                ASC,
    rse_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.RSE_PK

-- Start of DDL Script for Index IFRSRH.RUA_PK
-- Generated 12/5/2004 21:49:56 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rua_pk ON rubricas_anteriores
  (
    rua_rub_codigo                  ASC,
    rua_codigo_anterior             ASC
  )
/


-- End of DDL Script for Index IFRSRH.RUA_PK

-- Start of DDL Script for Index IFRSRH.RUB_PK
-- Generated 12/5/2004 21:49:57 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rub_pk ON rubricas
  (
    rub_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.RUB_PK

-- Start of DDL Script for Index IFRSRH.RUBRICA_TEMP_PK
-- Generated 12/5/2004 21:49:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX rubrica_temp_pk ON rubrica_temp
  (
    num_sequencia                   ASC,
    cod_rubrica                     ASC
  )
/


-- End of DDL Script for Index IFRSRH.RUBRICA_TEMP_PK

-- Start of DDL Script for Index IFRSRH.SAF_PK
-- Generated 12/5/2004 21:49:58 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX saf_pk ON salario_familia
  (
    saf_ano_referencia              ASC,
    saf_mes_referencia              ASC,
    saf_faixa                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.SAF_PK

-- Start of DDL Script for Index IFRSRH.SCA_PK
-- Generated 12/5/2004 21:49:59 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX sca_pk ON saldo_cobranca_aposentado
  (
    sca_emp_numero_matricula        ASC,
    sca_mes_referencia              ASC,
    sca_ano_referencia              ASC,
    sca_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.SCA_PK

-- Start of DDL Script for Index IFRSRH.SFU_PK
-- Generated 12/5/2004 21:50:00 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX sfu_pk ON situacoes_funcionais
  (
    sfu_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.SFU_PK

-- Start of DDL Script for Index IFRSRH.SIN_PK
-- Generated 12/5/2004 21:50:01 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX sin_pk ON sinistros
  (
    sin_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.SIN_PK

-- Start of DDL Script for Index IFRSRH.SNA_MAT_PK
-- Generated 12/5/2004 21:50:02 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX sna_mat_pk ON siad_nao_avaliado
  (
    ano_avaliacao                   ASC,
    matricula                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.SNA_MAT_PK

-- Start of DDL Script for Index IFRSRH.SPF_LOCIND_PK
-- Generated 12/5/2004 21:50:03 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX spf_locind_pk ON spf_local_indicacao
  (
    ano_indicacao                   ASC,
    cod_local_indicacao             ASC,
    indicador_local                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.SPF_LOCIND_PK

-- Start of DDL Script for Index IFRSRH.TAB_CESTA_BASICA_PK
-- Generated 12/5/2004 21:50:04 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tab_cesta_basica_pk ON tab_cesta_basica
  (
    tcb_nsa_codigo_nivel            ASC,
    tcb_nsa_codigo_padrao           ASC,
    tcb_nsa_ind_nivel_escola        ASC,
    tcb_dt_ini_vigencia             ASC
  )
/


-- End of DDL Script for Index IFRSRH.TAB_CESTA_BASICA_PK

-- Start of DDL Script for Index IFRSRH.TAC_SEQ_AUTORIZADOR_IX
-- Generated 12/5/2004 21:50:05 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tac_seq_autorizador_ix ON tab_autorizador_certificador
  (
    tac_id_usuario                  ASC,
    tac_tipo_autorizador            ASC,
    tac_dt_inicio                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.TAC_SEQ_AUTORIZADOR_IX

-- Start of DDL Script for Index IFRSRH.TAC_SEQ_AUTORIZADOR_PK
-- Generated 12/5/2004 21:50:06 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tac_seq_autorizador_pk ON tab_autorizador_certificador
  (
    tac_seq_autorizador             ASC
  )
/


-- End of DDL Script for Index IFRSRH.TAC_SEQ_AUTORIZADOR_PK

-- Start of DDL Script for Index IFRSRH.TCR_PK
-- Generated 12/5/2004 21:50:07 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tcr_pk ON tmp_concurso_rdb
  (
    tcr_matricula                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.TCR_PK

-- Start of DDL Script for Index IFRSRH.TDC_SEQ_COBRANCA_PK
-- Generated 12/5/2004 21:50:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tdc_seq_cobranca_pk ON tab_doc_cobranca
  (
    tdc_seq_cobranca                ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDC_SEQ_COBRANCA_PK

-- Start of DDL Script for Index IFRSRH.TDE_PK
-- Generated 12/5/2004 21:50:08 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tde_pk ON tmp_dependencia_empregado
  (
    tde_emp_numero_matricula        ASC,
    tde_ano_referencia              ASC,
    tde_mes_referencia              ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDE_PK

-- Start of DDL Script for Index IFRSRH.TDEF_PK
-- Generated 12/5/2004 21:50:09 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tdef_pk ON tipo_deficiencia
  (
    tdef_cod_tipo_deficiencia       ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDEF_PK

-- Start of DDL Script for Index IFRSRH.TDF_PK
-- Generated 12/5/2004 21:50:10 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tdf_pk ON tmp_demonstrativo_frequencia
  (
    tdf_dep_codigo                  ASC,
    tdf_emp_numero_matricula        ASC,
    tdf_dat_ocorrencia              ASC,
    tdf_ofu_codigo                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDF_PK

-- Start of DDL Script for Index IFRSRH.TDM_GUI_FK
-- Generated 12/5/2004 21:50:11 from IFRSRH@PRODSEDE

CREATE INDEX tdm_gui_fk ON tab_despesa_medicamentos
  (
    tdm_gui_doc_cbe_cre_sequencial  ASC,
    tdm_gui_doc_numero              ASC,
    tdm_gui_doc_cbe_ben_sigla       ASC,
    tdm_gui_doc_dep_codigo          ASC,
    tdm_gui_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDM_GUI_FK

-- Start of DDL Script for Index IFRSRH.TDM_PK
-- Generated 12/5/2004 21:50:12 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tdm_pk ON tab_despesa_medicamentos
  (
    tdm_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.TDM_PK

-- Start of DDL Script for Index IFRSRH.TEMP_MOV_DEP_IX
-- Generated 12/5/2004 21:50:13 from IFRSRH@PRODSEDE

CREATE INDEX temp_mov_dep_ix ON temp_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_dep_codigo_pagto        ASC,
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.TEMP_MOV_DEP_IX

-- Start of DDL Script for Index IFRSRH.TEMP_MOV_EMP_IDX
-- Generated 12/5/2004 21:50:14 from IFRSRH@PRODSEDE

CREATE INDEX temp_mov_emp_idx ON temp_movimentacao
  (
    mov_emp_numero_matricula        ASC
  )
/


-- End of DDL Script for Index IFRSRH.TEMP_MOV_EMP_IDX

-- Start of DDL Script for Index IFRSRH.TEMP_MOV_PK
-- Generated 12/5/2004 21:50:15 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX temp_mov_pk ON temp_movimentacao
  (
    mov_ano_referencia              ASC,
    mov_mes_referencia              ASC,
    mov_versao_pagamento            ASC,
    mov_emp_numero_matricula        ASC,
    mov_rub_codigo                  ASC,
    mov_tip_rubrica                 ASC,
    mov_sequencial                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.TEMP_MOV_PK

-- Start of DDL Script for Index IFRSRH.TIP_PROC_PK
-- Generated 12/5/2004 21:50:16 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tip_proc_pk ON spf_tipo_processo_judicial
  (
    tipo_processo_judicial          ASC
  )
/


-- End of DDL Script for Index IFRSRH.TIP_PROC_PK

-- Start of DDL Script for Index IFRSRH.TMP_CONTRACHEQUE_EMP_IND
-- Generated 12/5/2004 21:50:17 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tmp_contracheque_emp_ind ON tmp_contracheque_emp
  (
    sequencia                       ASC,
    emp_numero_matricula            ASC
  )
/


-- End of DDL Script for Index IFRSRH.TMP_CONTRACHEQUE_EMP_IND

-- Start of DDL Script for Index IFRSRH.TMP_PROVISIONAMENTO_PK
-- Generated 12/5/2004 21:50:18 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tmp_provisionamento_pk ON tmp_provisionamento
  (
    tmp_chave_prov                  ASC,
    ano                             ASC,
    mes                             ASC,
    seq                             ASC,
    dep_codigo                      ASC,
    custo                           ASC,
    conta                           ASC,
    matricula                       ASC,
    tipo_prov                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.TMP_PROVISIONAMENTO_PK

-- Start of DDL Script for Index IFRSRH.TOR_PK
-- Generated 12/5/2004 21:50:19 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tor_pk ON tipos_ocorrencias_rubricas
  (
    tor_ofu_codigo                  ASC,
    tor_rub_codigo                  ASC,
    tor_dat_inicio_vigencia         ASC
  )
/


-- End of DDL Script for Index IFRSRH.TOR_PK

-- Start of DDL Script for Index IFRSRH.TP_SINISTRO_DOC_PK
-- Generated 12/5/2004 21:50:20 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tp_sinistro_doc_pk ON tipo_sinistro_doc
  (
    tsd_dos_codigo_doc              ASC,
    tsd_tis_codigo_tipo             ASC
  )
/


-- End of DDL Script for Index IFRSRH.TP_SINISTRO_DOC_PK

-- Start of DDL Script for Index IFRSRH.TP_SINISTRO_PK
-- Generated 12/5/2004 21:50:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tp_sinistro_pk ON tipo_sinistro
  (
    tis_codigo_tipo                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.TP_SINISTRO_PK

-- Start of DDL Script for Index IFRSRH.TPC_PK
-- Generated 12/5/2004 21:50:21 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tpc_pk ON tipos_credenciados
  (
    tpc_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.TPC_PK

-- Start of DDL Script for Index IFRSRH.TPV_CODIGO_PK
-- Generated 12/5/2004 21:50:22 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tpv_codigo_pk ON tipo_vinculos
  (
    tpv_codigo                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.TPV_CODIGO_PK

-- Start of DDL Script for Index IFRSRH.TREINO_PK
-- Generated 12/5/2004 21:50:23 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX treino_pk ON siad_treinamento
  (
    ano_treinamento                 ASC,
    codigo_treinamento              ASC
  )
/


-- End of DDL Script for Index IFRSRH.TREINO_PK

-- Start of DDL Script for Index IFRSRH.TUO_PK
-- Generated 12/5/2004 21:50:24 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tuo_pk ON temp_unidades_organizacionais
  (
    uor_codigo_de                   ASC
  )
/


-- End of DDL Script for Index IFRSRH.TUO_PK

-- Start of DDL Script for Index IFRSRH.TVE_PK
-- Generated 12/5/2004 21:50:25 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX tve_pk ON tipo_visto_estrangeiro
  (
    tve_cod_visto_estrang           ASC
  )
/


-- End of DDL Script for Index IFRSRH.TVE_PK

-- Start of DDL Script for Index IFRSRH.UFF_PK
-- Generated 12/5/2004 21:50:26 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX uff_pk ON uor_fone_fax
  (
    uff_uor_codigo                  ASC,
    uff_tipo                        ASC,
    uff_numero                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.UFF_PK

-- Start of DDL Script for Index IFRSRH.ULT_PK
-- Generated 12/5/2004 21:50:27 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ult_pk ON usuarios_linhas_transportes
  (
    ult_emb_emp_numero_matricula    ASC,
    ult_emb_ben_sigla               ASC,
    ult_ltf_numero                  ASC,
    ult_ltf_dep_codigo              ASC
  )
/


-- End of DDL Script for Index IFRSRH.ULT_PK

-- Start of DDL Script for Index IFRSRH.UPS_PK
-- Generated 12/5/2004 21:50:28 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX ups_pk ON usuarios_planos_saude
  (
    ups_cre_sequencial              ASC,
    ups_emp_numero_matricula        ASC,
    ups_cod_usuario                 ASC,
    ups_data_inicio                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.UPS_PK

-- Start of DDL Script for Index IFRSRH.VAU_AMB_FK_I
-- Generated 12/5/2004 21:50:29 from IFRSRH@PRODSEDE

CREATE INDEX vau_amb_fk_i ON valores_autorizados
  (
    vau_amb_codigo                  ASC,
    vau_amb_dv                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.VAU_AMB_FK_I

-- Start of DDL Script for Index IFRSRH.VAU_ENQ_FK_I
-- Generated 12/5/2004 21:50:30 from IFRSRH@PRODSEDE

CREATE INDEX vau_enq_fk_i ON valores_autorizados
  (
    vau_enq_numero                  ASC
  )
/


-- End of DDL Script for Index IFRSRH.VAU_ENQ_FK_I

-- Start of DDL Script for Index IFRSRH.VIP_PK
-- Generated 12/5/2004 21:50:30 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX vip_pk ON vinculo_prestadora
  (
    vip_cre_sequencial              ASC,
    vip_cod_vinculo                 ASC
  )
/


-- End of DDL Script for Index IFRSRH.VIP_PK

-- Start of DDL Script for Index IFRSRH.VIU_MATRICULA_SEQUENCIAL_PK
-- Generated 12/5/2004 21:50:31 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX viu_matricula_sequencial_pk ON vinculado_universitarios
  (
    viu_data_entrega_declaracao     ASC,
    viu_pvi_emp_numero_matricula    ASC,
    viu_pvi_sequencial              ASC
  )
/


-- End of DDL Script for Index IFRSRH.VIU_MATRICULA_SEQUENCIAL_PK

-- Start of DDL Script for Index IFRSRH.VLD_PK
-- Generated 12/5/2004 21:50:32 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX vld_pk ON valores_diaria
  (
    vld_codigo                      ASC,
    vld_data_vigencia               ASC
  )
/


-- End of DDL Script for Index IFRSRH.VLD_PK

-- Start of DDL Script for Index IFRSRH.VLI_PK
-- Generated 12/5/2004 21:50:33 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX vli_pk ON valor_incentivo
  (
    matricula                       ASC
  )
/


-- End of DDL Script for Index IFRSRH.VLI_PK

-- Start of DDL Script for Index IFRSRH.VO_PK
-- Generated 12/5/2004 21:50:34 from IFRSRH@PRODSEDE

CREATE UNIQUE INDEX vo_pk ON versao_objetos
  (
    ver_cd_sistema                  ASC,
    ver_objeto                      ASC
  )
/


-- End of DDL Script for Index IFRSRH.VO_PK

-- Start of DDL Script for Index IFRSRH.X_SRH_REF_CODES_1
-- Generated 12/5/2004 21:50:35 from IFRSRH@PRODSEDE

CREATE INDEX x_srh_ref_codes_1 ON srh_ref_codes
  (
    rv_domain                       ASC,
    rv_low_value                    ASC
  )
/


-- End of DDL Script for Index IFRSRH.X_SRH_REF_CODES_1
