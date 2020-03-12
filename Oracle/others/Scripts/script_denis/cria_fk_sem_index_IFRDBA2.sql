set feedback on
set verify on
set echo on
--*******************************************************
-- TAB(ACOMP_SITUACAO_BEM_PATRIM): 3652344  TAB REF(SITUACAO_BEM_PATRIMONIAL): 216
create index IDX_ASBP_SBP_ANT_FK on IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM
(SBP_CD_SITUACAO_ANTERIOR)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ACOMP_SITUACAO_BEM_PATRIM): 3652344  TAB REF(SITUACAO_BEM_PATRIMONIAL): 216
create index IDX_ASBP_SBP_ATU_FK on IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM
(SBP_CD_SITUACAO_ATUAL)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(AGENCIAINF): 292448  TAB REF(DEPENDENCIAS): 42120
create index IDX_AGB_DEP_FK on IFRDBA2.AGENCIAINF
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(AGENCIAINF): 292448  TAB REF(MUNICIPIOS): 101764
create index IDX_AGB_MUN_FK on IFRDBA2.AGENCIAINF
(COD_MUNICIPIO,SG_UF)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(AUX_EVENT_SIMBEP): 2603800  TAB REF(TAB_TPEVE_SIMBEP): 1380
create index IDX_FK02_EVENTOMOV on IFRDBA2.AUX_EVENT_SIMBEP
(TPEVE_COD_PK)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(AUX_EVENT_SIMBEP): 2603800  TAB REF(TAB_ARFUN_SIMBEP): 1664
create index IDX_FK03_EVENTOMOV on IFRDBA2.AUX_EVENT_SIMBEP
(EVE_AREA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BAIXA_BEM_PATRIMONIAL): 6274320  TAB REF(BEM_PATRIMONIAL): 51087924
create index IDX_BDBP_BP_FK on IFRDBA2.BAIXA_BEM_PATRIMONIAL
(BP_NR_BEM,BP_IN_UNIAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BAIXA_BEM_PATRIMONIAL): 6274320  TAB REF(TIPO_BAIXA_BEM_PATRIMONIAL): 187
create index IDX_BDBP_TBBP_FK on IFRDBA2.BAIXA_BEM_PATRIMONIAL
(TBBP_CD_TIPO_BAIXA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(AREA_ATENDIDA): 121320
create index IDX_BP_AAT_FK on IFRDBA2.BEM_PATRIMONIAL
(AAT_DEP_CD_DEPENDENCIA,AAT_ID_AREA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(CONTA_PATRIMONIAL_DEPENDENCIA): 118624
create index IDX_BP_CP1_FK on IFRDBA2.BEM_PATRIMONIAL
(CP1_CP_NR_CONTA,AAT_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(ESTADO_CONSERVACAO): 105
create index IDX_BP_EC_FK on IFRDBA2.BEM_PATRIMONIAL
(EC_CD_ESTADO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(FORMA_AQUISICAO): 420
create index IDX_BP_FC_FK on IFRDBA2.BEM_PATRIMONIAL
(FC_CD_FORMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(GRUPO_PATRIMONIAL): 67716
create index IDX_BP_GP_FK on IFRDBA2.BEM_PATRIMONIAL
(GP_CD_GRUPO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(BEM_PATRIMONIAL): 51087924  TAB REF(SITUACAO_BEM_PATRIMONIAL): 216
create index IDX_BP_SBP_FK on IFRDBA2.BEM_PATRIMONIAL
(SBP_CD_SITUACAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(CUSTODIA): 769160  TAB REF(CENTRO_CUSTO): 16416
create index IDX_CTD_CEC_FK on IFRDBA2.CUSTODIA
(CC2_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(CUSTODIA): 769160  TAB REF(CUSTODIA): 769160
create index IDX_CTD_CTD_FK on IFRDBA2.CUSTODIA
(DEP_CD_DEPENDENCIA,NU_OPERACAO_ENDOSSADA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(CUSTODIA): 769160  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_CTD_UOR_FK on IFRDBA2.CUSTODIA
(UOR_CODIGO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(CUSTODIA): 769160  TAB REF(USUARIO_TESOURARIA): 380
create index IDX_CTD_UST_FK on IFRDBA2.CUSTODIA
(DEP_CD_DEPENDENCIA,NR_CGC_CPF_USUARIO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(CUSTODIA): 769160  TAB REF(TAB_CORRETORA_VALORES): 0
create index IDX_CUSTOD_VAL_TB_CORRET_VALOR on IFRDBA2.CUSTODIA
(COD_CORRETORA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(DETALHE_ADICAO_EXCLUSAO_FA): 179304  TAB REF(FORMA_AQUISICAO): 420
create index IDX_DAEFA_FC_FK on IFRDBA2.DETALHE_ADICAO_EXCLUSAO_FA
(FC_CD_FORMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(DETALHE_ADICAO_PO): 1021152  TAB REF(PROGRAMA_ORCAMENTARIO): 216
create index IDX_DAPO_PO_FK on IFRDBA2.DETALHE_ADICAO_PO
(PO_CD_PROGRAMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(DETALHE_DEPREC_REMUN): 11732256  TAB REF(CENTRO_CUSTO): 16416
create index IDX_DDR_CC2_FK on IFRDBA2.DETALHE_DEPREC_REMUN
(CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(DOCUMENTOS_PROCESSO): 807840  TAB REF(TIPO_DOCUMENTO_LICITACAO): 48848
create index IDX_DOP_TDL_FK on IFRDBA2.DOCUMENTOS_PROCESSO
(PL_DEP_CD_DEPENDENCIA,TDL_CD_DOCUMENTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(ALMOXARIFADOS): 20580
create index IDX_EE_ALM1_FK on IFRDBA2.ENTRADA_ESTOQUE
(TI_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(ALMOXARIFADOS): 20580
create index IDX_EE_ALM2_FK on IFRDBA2.ENTRADA_ESTOQUE
(SMS_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(CENTRO_CUSTO): 16416
create index IDX_EE_CC2_FK on IFRDBA2.ENTRADA_ESTOQUE
(CC_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(FORNECEDOR): 7335468
create index IDX_EE_FOR_FK on IFRDBA2.ENTRADA_ESTOQUE
(FOR_NR_CGC_CPF)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(MOEDA): 132
create index IDX_EE_MOE_FK on IFRDBA2.ENTRADA_ESTOQUE
(MOE_CD_MOEDA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(NATUREZA_MOVIMENTACAO): 828
create index IDX_EE_NM_FK on IFRDBA2.ENTRADA_ESTOQUE
(NM_CD_NATUREZA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ENTRADA_ESTOQUE): 8171912  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_EE_UOR_FK on IFRDBA2.ENTRADA_ESTOQUE
(UO_CD_UNID_ORGAN)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(EVENTO_DO_PROCESSO): 12517824  TAB REF(PROCESSO_LICITATORIO): 10303904
create index IDX_EVP_PL_FK on IFRDBA2.EVENTO_DO_PROCESSO
(PL_AA_PROCESSO,PL_SQ_PROCESSO,PL_DEP_CD_DEPENDENCIA,PL_MDL_CD_MODALIDADE)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(EVENTO_DO_PROCESSO): 12517824  TAB REF(PREVISAO_PROCESSO): 4352
create index IDX_EVP_PPR_FK on IFRDBA2.EVENTO_DO_PROCESSO
(PPR_CD_EVENTO,PL_MDL_CD_MODALIDADE,PPRO_TP_AVALIACAO_LICITACAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(HISTORICO_CENTRO_CUSTOS): 535420  TAB REF(CENTRO_CUSTO): 16416
create index IDX_HCC_CCT_FK on IFRDBA2.HISTORICO_CENTRO_CUSTOS
(HCC_CCT_CODIGO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(INCIDENCIA_CENTRO_CUSTO): 6355500  TAB REF(INCIDENCIA_CENTRO_CUSTO_DEP): 36608
create index IDX_ICC_CC2_FK on IFRDBA2.INCIDENCIA_CENTRO_CUSTO
(ICCD_CC_CD_CENTRO_CUSTO,ICCD_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_DA_TRANSFERENCIA): 2120820  TAB REF(ITEM_POR_DEPENDENCIA): 11150400
create index IDX_IDT_IPD_FK on IFRDBA2.ITEM_DA_TRANSFERENCIA
(IPD_DEP_CD_DEPENDENCIA,IPD_IG_CI_CD_CLASSE,IPD_IG_CD_ITEM)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_GENERICO): 32032584  TAB REF(AQUISICAO_MATERIAL): 144
create index IDX_IG_AM_FK on IFRDBA2.ITEM_GENERICO
(AM_CD_AQUISICAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_GENERICO): 32032584  TAB REF(CLASSE_ITEM): 119808
create index IDX_IG_CI_FK on IFRDBA2.ITEM_GENERICO
(CI_CD_CLASSE)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_GENERICO): 32032584  TAB REF(TIPO_MATERIAL_FORNECIMENTO): 175
create index IDX_IG_TMF_FK on IFRDBA2.ITEM_GENERICO
(TMF_CD_TIPO_MATERIAL_FORNECIME)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_GENERICO): 32032584  TAB REF(UNIDADE_ITEM): 468
create index IDX_IG_UIE_FK on IFRDBA2.ITEM_GENERICO
(UI_CD_UNIDADE_ESTOCA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_GENERICO): 32032584  TAB REF(UNIDADE_ITEM): 468
create index IDX_IG_UIF_FK on IFRDBA2.ITEM_GENERICO
(UI_CD_UNIDADE_FORNECE)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_INEDITO): 970944  TAB REF(CONTA_CONTABIL): 489000
create index IDX_II_CC1_FK on IFRDBA2.ITEM_INEDITO
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_INEDITO): 970944  TAB REF(CENTRO_CUSTO): 16416
create index IDX_II_CC2_FK on IFRDBA2.ITEM_INEDITO
(CD_CENTRO_CUSTO_GESTOR)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_INEDITO): 970944  TAB REF(ALMOXARIFADOS): 20580
create index IDX_II_DEP_FK on IFRDBA2.ITEM_INEDITO
(DEP_CD_DEPENDENCIA_COMPRA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_INEDITO): 970944  TAB REF(ORDEM_SERVICO): 35348128
create index IDX_II_OS_FK on IFRDBA2.ITEM_INEDITO
(OS_AA_ORDEM_SERVICO,OS_NR_ORDEM_SERVICO,OS_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_INEDITO): 970944  TAB REF(UNIDADE_ITEM): 468
create index IDX_II_UI_FK on IFRDBA2.ITEM_INEDITO
(UI_CD_UNIDADE)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_POR_DEPENDENCIA): 11150400  TAB REF(CLASSIFICACAO_ABC): 1008
create index IDX_IPD_ABC_FK on IFRDBA2.ITEM_POR_DEPENDENCIA
(DEP_CD_DEPENDENCIA,ABC_CD_CLASSIFICACAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_LICITACAO): 32125200  TAB REF(REQUISICOES_COMPRAS_DO_LOTE): 5751424
create index IDX_IPL_RCL_FK on IFRDBA2.ITEM_PROPOSTA_LICITACAO
(RCL_LRC_SQ_LOTE,RCL_RCI_DEP_CD_DEPENDENCIA,RCL_RCI_AA_REQUISICAO_COMPRA,RCL_RCI_NR_REQUISICAO_COMPRA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_LICITACAO): 32125200  TAB REF(SMS_OUTRA_DEPENDENCIA): 432
create index IDX_IPL_SOD_FK on IFRDBA2.ITEM_PROPOSTA_LICITACAO
(SOD_AA_SMS,SOD_NR_SMS,SOD_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(CONTA_CONTABIL): 489000
create index IDX_IPR_CC1_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IPR_CC2_2_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(CC2_CD_CENTRO_CUSTO_GERD)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IPR_CC2_3_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(CC2_CD_CENTRO_CUSTO_GEST)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(CATALOGO_FINANCEIRO): 31500
create index IDX_IPR_CF_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(CF_NR_ITEM)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(DEPENDENCIAS): 42120
create index IDX_IPR_DEP_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(DEPENDENCIAS): 42120
create index IDX_IPR_DEP_2_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(DEP_CD_DEPENDENCIA_GEST)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(FORNECEDOR): 7335468
create index IDX_IPR_FOR_2_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(FF_NR_CGC_CPF)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(PROGRAMA_ORCAMENTARIO): 216
create index IDX_IPR_PO_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(PO_CD_PROGRAMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORCAMENTARIA): 3440528  TAB REF(PROJETO): 510
create index IDX_IPR_PRJ_FK on IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
(PRJ_CD_PROJETO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IPOS_CC_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(CC2_CD_CENTRO_CUSTO_GEST)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(DEPENDENCIAS): 42120
create index IDX_IPOS_DEP_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(DEP_CD_DEPENDENCIA_GEST)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IPS_CC2_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(CC2_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IPS_CC2_GERD_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(CC2_CD_CENTRO_CUSTO_GERD)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(CATALOGO_FINANCEIRO): 31500
create index IDX_IPS_CF_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(CF_NR_ITEM)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(DEPENDENCIAS): 42120
create index IDX_IPS_DEP_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(DEPENDENCIAS): 42120
create index IDX_IPS_DEP_GERD_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(DEP_CD_DEPENDENCIA_GERD)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(FORNECEDOR): 7335468
create index IDX_IPS_FOR_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(FF_NR_CGC_CPF)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(GRUPO_PATRIMONIAL): 67716
create index IDX_IPS_GP_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(GP_CD_GRUPO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(PROGRAMA_ORCAMENTARIO): 216
create index IDX_IPS_PO_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(PO_CD_PROGRAMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_PROPOSTA_ORC_SIMULADA): 930970992  TAB REF(PROJETO): 510
create index IDX_IPS_PRJ_FK on IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
(PRJ_CD_PROJETO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_REQUISICAO): 73022960  TAB REF(APLICACAO_ITEM_REQUISICAO): 464
create index IDX_IR_APL_FK on IFRDBA2.ITEM_REQUISICAO
(APL_CD_APLICACAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_REQUISICAO): 73022960  TAB REF(CONTA_CONTABIL): 489000
create index IDX_IR_CC1_FK on IFRDBA2.ITEM_REQUISICAO
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_REQUISICAO): 73022960  TAB REF(CENTRO_CUSTO): 16416
create index IDX_IR_CC2_FK on IFRDBA2.ITEM_REQUISICAO
(CD_CENTRO_CUSTO_GESTOR)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ITEM_REQUISICAO): 73022960  TAB REF(ALMOXARIFADOS): 20580
create index IDX_IR_DEP_FK on IFRDBA2.ITEM_REQUISICAO
(DEP_CD_DEPENDENCIA_COMPRA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(ALMOXARIFADOS): 20580
create index IDX_LCM_ALM1_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_DEPENDENCIA_CREDITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(ALMOXARIFADOS): 20580
create index IDX_LCM_ALM2_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_DEPENDENCIA_DEBITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(CONTA_CONTABIL): 489000
create index IDX_LCM_CCO1_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_CONTA_CONTABIL_CREDITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(CONTA_CONTABIL): 489000
create index IDX_LCM_CCO2_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_CONTA_CONTABIL_DEBITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(CENTRO_CUSTO): 16416
create index IDX_LCM_CC1_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_CENTRO_CUSTO_CREDITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(CENTRO_CUSTO): 16416
create index IDX_LCM_CC2_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_CENTRO_CUSTO_DEBITO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(APLICACAO_ITEM_REQUISICAO): 464
create index IDX_LCM_LCM_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_APLICACAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LANCAMENTO_CONTABIL_MATERIAL): 85775872  TAB REF(NATUREZA_MOVIMENTACAO): 828
create index IDX_LCM_NM_FK on IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
(CD_NATUREZA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LOTE_ESTOQUE): 15910296  TAB REF(CONDICAO_ARMAZENAMENTO): 90
create index IDX_LE_CA_FK on IFRDBA2.LOTE_ESTOQUE
(CA_CD_CONDICAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(LOTE_REQUISICOES_COMPRAS): 2956512  TAB REF(ALMOXARIFADOS): 20580
create index IDX_LRC_DEP_FK on IFRDBA2.LOTE_REQUISICOES_COMPRAS
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(MEMBRO_COMISSAO_LICITACAO): 410404  TAB REF(COMISSAO_LICITACAO): 53952
create index IDX_MCL_CL_FK on IFRDBA2.MEMBRO_COMISSAO_LICITACAO
(CL_PL_AA_PROCESSO,CL_PL_SQ_PROCESSO,CL_PL_DEP_CD_DEPENDENCIA_DETEN,CL_PL_MDL_CD_MODALIDADE,CL_TP_COMISSAO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(MEMBRO_COMISSAO_LICITACAO): 410404  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_MCL_UO_FK on IFRDBA2.MEMBRO_COMISSAO_LICITACAO
(UO_CD_UNID_ORGAN)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(ORC_CONSOL_ANA_CONTA): 154320  TAB REF(CONTA_CONTABIL): 489000
create index IDX_OCAC_CC1_FK on IFRDBA2.ORC_CONSOL_ANA_CONTA
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PARTICIPANTE_DE_LICITACAO): 6490224  TAB REF(MOEDA): 132
create index IDX_PDL_MOE_FK on IFRDBA2.PARTICIPANTE_DE_LICITACAO
(MOE_CD_MOEDA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROCESSO_LICITATORIO): 10303904  TAB REF(COMISSAO_PERMANENTE_LICITACAO): 792
create index IDX_PL_CPL_FK on IFRDBA2.PROCESSO_LICITATORIO
(CPL_DEP_CD_DEPENDENCIA,CPL_SQ_COMISSAO_PERM)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROCESSO_LICITATORIO): 10303904  TAB REF(ALMOXARIFADOS): 20580
create index IDX_PL_DEP_BEN_FK on IFRDBA2.PROCESSO_LICITATORIO
(DEP_CD_DEPENDENCIA_BENEF)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROCESSO_LICITATORIO): 10303904  TAB REF(ALMOXARIFADOS): 20580
create index IDX_PL_DEP_DT_FK on IFRDBA2.PROCESSO_LICITATORIO
(DEP_CD_DEPENDENCIA_DETENT)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROCESSO_LICITATORIO): 10303904  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_PL_UO_FK on IFRDBA2.PROCESSO_LICITATORIO
(UO_CD_UNID_ORGAN)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROJECAO_RECEITA_SIMULADA): 5708664  TAB REF(CONTA_CONTABIL): 489000
create index IDX_PRS_CC1_FK on IFRDBA2.PROJECAO_RECEITA_SIMULADA
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROJECAO_RECEITA_SIMULADA): 5708664  TAB REF(DEPENDENCIAS): 42120
create index IDX_PRS_DEP_FK on IFRDBA2.PROJECAO_RECEITA_SIMULADA
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(PROJECAO_RECEITA_SIMULADA): 5708664  TAB REF(TIPO_AJUSTE_REGIME_CAIXA): 936
create index IDX_PRS_TAR_FK on IFRDBA2.PROJECAO_RECEITA_SIMULADA
(TAR_CD_REGIME)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(REQUISICAO_COMPRA_ITEM): 32563440  TAB REF(CENTRO_CUSTO): 16416
create index IDX_RCI_CC_FK on IFRDBA2.REQUISICAO_COMPRA_ITEM
(CC_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(REQUISICAO_COMPRA_ITEM): 32563440  TAB REF(CONTA_CONTABIL): 489000
create index IDX_RCI_CC1_FK on IFRDBA2.REQUISICAO_COMPRA_ITEM
(CC1_NR_CONTA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(REQUISICAO_COMPRA_ITEM): 32563440  TAB REF(CENTRO_CUSTO): 16416
create index IDX_RCI_CC2_FK on IFRDBA2.REQUISICAO_COMPRA_ITEM
(CD_CENTRO_CUSTO_GESTOR)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(REQUISICAO_COMPRA_ITEM): 32563440  TAB REF(ALMOXARIFADOS): 20580
create index IDX_RCI_DEP_COM_FK on IFRDBA2.REQUISICAO_COMPRA_ITEM
(DEP_CD_DEPENDENCIA_COMPRA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SAIDA_ESTOQUE): 36114672  TAB REF(ALMOXARIFADOS): 20580
create index IDX_SE_ALM1_FK on IFRDBA2.SAIDA_ESTOQUE
(TI_DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SAIDA_ESTOQUE): 36114672  TAB REF(CENTRO_CUSTO): 16416
create index IDX_SE_CC2_FK on IFRDBA2.SAIDA_ESTOQUE
(CC_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SAIDA_ESTOQUE): 36114672  TAB REF(MOEDA): 132
create index IDX_SE_MOE_FK on IFRDBA2.SAIDA_ESTOQUE
(MOE_CD_MOEDA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SAIDA_ESTOQUE): 36114672  TAB REF(NATUREZA_MOVIMENTACAO): 828
create index IDX_SE_NM_FK on IFRDBA2.SAIDA_ESTOQUE
(NM_CD_NATUREZA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SAIDA_ESTOQUE): 36114672  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_SE_UOR_FK on IFRDBA2.SAIDA_ESTOQUE
(UO_CD_UNID_ORGAN)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO): 405576  TAB REF(CENTRO_CUSTO): 16416
create index IDX_SU_FK_CC2 on IFRDBA2.SEG_USUARIO
(CC2_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO): 405576  TAB REF(DEPENDENCIAS): 42120
create index IDX_SU_FK_DEP on IFRDBA2.SEG_USUARIO
(DEP_CD_DEPENDENCIA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO_CENTRO_CUSTO): 338400  TAB REF(CENTRO_CUSTO): 16416
create index IDX_SUCC_CC2_FK on IFRDBA2.SEG_USUARIO_CENTRO_CUSTO
(CC2_CD_CENTRO_CUSTO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO_CENTRO_CUSTO): 338400  TAB REF(SEG_SISTEMA): 931
create index IDX_SUCC_SS_FK on IFRDBA2.SEG_USUARIO_CENTRO_CUSTO
(SS_CD_SISTEMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO_SISTEMA): 306880  TAB REF(SEG_GRUPO_USUARIO): 7068
create index IDX_SUS_FK_SGU on IFRDBA2.SEG_USUARIO_SISTEMA
(SGU_CD_GRUPO,SS_CD_SISTEMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SEG_USUARIO_SISTEMA): 306880  TAB REF(SEG_SISTEMA): 931
create index IDX_SUS_FK_SS on IFRDBA2.SEG_USUARIO_SISTEMA
(SS_CD_SISTEMA)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SMS): 17912356  TAB REF(PARTICIPANTE_DE_LICITACAO): 6490224
create index IDX_SMS_PDL_FK on IFRDBA2.SMS
(PDL_FOR_DEP_CD_DEPENDENCIA,PDL_FOR_NR_CGC_CPF,PDL_LRC_SQ_LOTE)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(SMS): 17912356  TAB REF(UNIDADES_ORGANIZACIONAIS): 876380
create index IDX_SMS_UOR_FK on IFRDBA2.SMS
(UO_CD_UNID_ORGAN_DESTINO)
Tablespace TSD_INDICE;
--*******************************************************
-- TAB(VALOR_CARAC_BEM_PATRIMONIAL): 42321788  TAB REF(CARAC_GRUPO_PATRIMONIAL): 55608
create index IDX_VCBP_CGP_FK on IFRDBA2.VALOR_CARAC_BEM_PATRIMONIAL
(CGP_GP_CD_GRUPO,CGP_CP1_CD_CARACTERISTICA)
Tablespace TSD_INDICE;
