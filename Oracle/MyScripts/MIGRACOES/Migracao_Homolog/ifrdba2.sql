-- Start of DDL Script for Table IFRDBA2.ACESSO_SPSC
-- Generated 9-mar-2004 18:47:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.acesso_spsc
    (cd_centro_custo                NUMBER(5) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ACESSO_SPSC

ALTER TABLE ifrdba2.acesso_spsc
ADD CONSTRAINT as_pk PRIMARY KEY (cd_centro_custo, dep_cd_dependencia, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ACESSO_SPSC

-- Start of DDL Script for Table IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM
-- Generated 9-mar-2004 18:47:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.acomp_situacao_bem_patrim
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    dt_inicial_situacao            DATE NOT NULL,
    sbp_cd_situacao_anterior       NUMBER(2) NOT NULL,
    sbp_cd_situacao_atual          NUMBER(2) NOT NULL,
    dt_final_situacao              DATE,
    no_usuario                     VARCHAR2(30) NOT NULL,
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM

ALTER TABLE ifrdba2.acomp_situacao_bem_patrim
ADD CONSTRAINT asbp_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, dt_inicial_situacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM

CREATE TRIGGER ifrdba2.trg_asbp01
BEFORE INSERT 
ON ifrdba2.acomp_situacao_bem_patrim
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
CURSOR pega_bem(NrBem IN NUMBER, InUniao IN NUMBER)
   IS
   -- pega o codigo da dependencia que esta manipulando o
   -- bem patrimonial
   SELECT bp.aat_dep_cd_dependencia
     FROM bem_patrimonial bp
    WHERE bp.nr_bem = NrBem
      AND bp.in_uniao = InUniao;
CURSOR pega_dep(CdDependencia IN NUMBER)
   IS
   -- obtem o codigo da dependencia a qual esta dependencia
   -- esta subordinada
   SELECT dp.dep_dep_codigo
   FROM dependencias dp
WHERE
   dp.dep_codigo = CdDependencia;
WkCdDep NUMBER;
WkCdCdDep NUMBER;
BEGIN
   OPEN pega_bem(:new.bp_nr_bem, :new.bp_in_uniao);
   FETCH pega_bem INTO WkCdDep;
   -- Obs. via foreign key entre acomp_situacao_bem_patrim e
   -- bem patrimonial, é garantido que haverá um valor para
   -- o bem patrimonial, portanto, não é necessário a validação
   CLOSE pega_bem;
   OPEN pega_dep(WkCdDep);
   FETCH pega_dep INTO WkCdCdDep;
   -- Obs. via foreign key entre bem_patrimonial e
   -- dependencias, é garantido que haverá um valor para
   -- a dependencia, portanto não é necessário a validação
   CLOSE pega_dep;
   :new.cd_centro_negocio := WkCdCdDep;
   :new.dep_cd_dependencia := WkCdDep;
END;
/

-- End of DDL Script for Table IFRDBA2.ACOMP_SITUACAO_BEM_PATRIM

-- Start of DDL Script for Table IFRDBA2.AGENCIAINF
-- Generated 9-mar-2004 18:47:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.agenciainf
    (cd_agencia                     VARCHAR2(7) NOT NULL,
    no_agencia                     VARCHAR2(30) NOT NULL,
    ban_cd_banco                   VARCHAR2(3) NOT NULL,
    dep_cd_dependencia             NUMBER(4),
    sig_agencia                    VARCHAR2(10),
    ds_endereco                    VARCHAR2(50),
    bairro                         VARCHAR2(30),
    cod_municipio                  NUMBER(5),
    nu_cep                         NUMBER(8),
    sg_uf                          VARCHAR2(2) NOT NULL,
    nu_telefone                    VARCHAR2(20),
    nu_ramal                       NUMBER(4),
    fax                            VARCHAR2(20),
    no_gerente                     VARCHAR2(30),
    nu_cgc                         VARCHAR2(14),
    cd_banco_central               VARCHAR2(5),
    flg_fgts                       NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AGENCIAINF

ALTER TABLE ifrdba2.agenciainf
ADD CONSTRAINT agb_fgts_ck CHECK ( FLG_FGTS IN (0,1)  )
/
ALTER TABLE ifrdba2.agenciainf
ADD CONSTRAINT agb_pk PRIMARY KEY (ban_cd_banco, cd_agencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AGENCIAINF

-- Start of DDL Script for Table IFRDBA2.AGRUPAMENTO_CONTABIL
-- Generated 9-mar-2004 18:47:44 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.agrupamento_contabil
    (cod_agrupamento                NUMBER(4) NOT NULL,
    dsc_agrupamento                VARCHAR2(50) NOT NULL,
    ind_tipo                       NUMBER(1) NOT NULL,
    cod_agrup_relac                NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AGRUPAMENTO_CONTABIL

ALTER TABLE ifrdba2.agrupamento_contabil
ADD CONSTRAINT ac_ind_tipo_ck CHECK (IND_TIPO IN (1,2,3))
/
ALTER TABLE ifrdba2.agrupamento_contabil
ADD CONSTRAINT ac_pk PRIMARY KEY (cod_agrupamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AGRUPAMENTO_CONTABIL

-- Start of DDL Script for Table IFRDBA2.AGRUPAMENTO_RECEITA
-- Generated 9-mar-2004 18:47:48 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.agrupamento_receita
    (cod_agrupamento                NUMBER(4) NOT NULL,
    dsc_agrupamento                VARCHAR2(50) NOT NULL,
    ind_tipo                       NUMBER(1) NOT NULL,
    cod_agrup_relac                NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AGRUPAMENTO_RECEITA

ALTER TABLE ifrdba2.agrupamento_receita
ADD CONSTRAINT ck_agrup_rec CHECK (IND_TIPO IN (1, 2, 3))
/
ALTER TABLE ifrdba2.agrupamento_receita
ADD CONSTRAINT pk_agrup_rec PRIMARY KEY (cod_agrupamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AGRUPAMENTO_RECEITA

-- Start of DDL Script for Table IFRDBA2.AJUSTE_ITEM_COMPROMISSO_ORC
-- Generated 9-mar-2004 18:47:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ajuste_item_compromisso_orc
    (nr_ano_compromisso             NUMBER(4) NOT NULL,
    dep_cd_dependencia_compr       NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_compromisso                 NUMBER(6) NOT NULL,
    nr_seq_comp                    NUMBER(3) NOT NULL,
    seq_ajuste                     NUMBER(5) NOT NULL,
    su_id_usuario                  VARCHAR2(10) NOT NULL,
    dt_ajuste                      DATE NOT NULL,
    tp_ajuste                      VARCHAR2(1) NOT NULL,
    qt_ajuste                      NUMBER(6),
    vl_ajuste                      NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AJUSTE_ITEM_COMPROMISSO_ORC

ALTER TABLE ifrdba2.ajuste_item_compromisso_orc
ADD CONSTRAINT aico_ck_1 CHECK (  TP_AJUSTE IN ('C','A','E')                                                      )
/
ALTER TABLE ifrdba2.ajuste_item_compromisso_orc
ADD CONSTRAINT aico_pk PRIMARY KEY (nr_ano_compromisso, dep_cd_dependencia_compr, 
  cc2_cd_centro_custo, nr_compromisso, nr_seq_comp, seq_ajuste)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AJUSTE_ITEM_COMPROMISSO_ORC

-- Start of DDL Script for Table IFRDBA2.AJUSTE_ITEM_PRE_COMP_ORC
-- Generated 9-mar-2004 18:47:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ajuste_item_pre_comp_orc
    (nr_ano_pre_compromisso         NUMBER(4) NOT NULL,
    dep_cd_dependencia_pcompr      NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_pre_compromisso             NUMBER(6) NOT NULL,
    nr_seq_pcomp                   NUMBER(3) NOT NULL,
    nr_seq_ajuste                  NUMBER(5) NOT NULL,
    su_id_usuario                  VARCHAR2(10) NOT NULL,
    dt_ajuste                      DATE NOT NULL,
    tp_ajuste                      VARCHAR2(1) NOT NULL,
    qt_ajuste                      NUMBER(6),
    vl_ajuste                      NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AJUSTE_ITEM_PRE_COMP_ORC

ALTER TABLE ifrdba2.ajuste_item_pre_comp_orc
ADD CONSTRAINT aipc_ck_1 CHECK (  TP_AJUSTE IN ('C','A','E')                                                      )
/
ALTER TABLE ifrdba2.ajuste_item_pre_comp_orc
ADD CONSTRAINT aipc_pk PRIMARY KEY (nr_ano_pre_compromisso, 
  dep_cd_dependencia_pcompr, cc2_cd_centro_custo, nr_pre_compromisso, 
  nr_seq_pcomp, nr_seq_ajuste)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AJUSTE_ITEM_PRE_COMP_ORC

-- Start of DDL Script for Table IFRDBA2.ALMOXARIFADOS
-- Generated 9-mar-2004 18:48:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.almoxarifados
    (cd_dependencia                 NUMBER(4) NOT NULL,
    sg_almoxarifado                VARCHAR2(10) NOT NULL,
    no_almoxarifado                VARCHAR2(60) NOT NULL,
    in_almoxarifado                NUMBER(2) NOT NULL,
    dep_vinculacao                 NUMBER(4),
    nr_cnpj                        VARCHAR2(14),
    ds_endereco                    VARCHAR2(50),
    ds_bairro                      VARCHAR2(30),
    no_municipio                   VARCHAR2(30),
    nr_cep                         NUMBER(8),
    nr_telefone1                   NUMBER(11),
    nr_telefone2                   NUMBER(11),
    nr_fax                         NUMBER(11),
    dep_material_adm               NUMBER(4),
    dep_material_tecnico           NUMBER(4),
    dep_compra                     NUMBER(4),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ALMOXARIFADOS

ALTER TABLE ifrdba2.almoxarifados
ADD CONSTRAINT alm_pk PRIMARY KEY (cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ALMOXARIFADOS

-- Start of DDL Script for Table IFRDBA2.APLICACAO
-- Generated 9-mar-2004 18:48:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aplicacao
    (dt_referencia                  DATE NOT NULL,
    no_atendente                   VARCHAR2(30),
    nr_aplicacao                   NUMBER(8) NOT NULL,
    vl_aplicacao                   NUMBER(14,2) NOT NULL,
    vl_apropriado                  NUMBER(14,2),
    qt_cotas                       NUMBER(14,4),
    sd_cotas                       NUMBER(14,4),
    dt_vencimento                  DATE,
    dt_recompra                    DATE,
    evc_nr_evento                  NUMBER(3) NOT NULL,
    lat_nr_lancamento              NUMBER(38) NOT NULL,
    dt_ultima_apr                  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.APLICACAO

ALTER TABLE ifrdba2.aplicacao
ADD CONSTRAINT apl_pk PRIMARY KEY (nr_aplicacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.APLICACAO

-- Start of DDL Script for Table IFRDBA2.APLICACAO_ITEM_REQUISICAO
-- Generated 9-mar-2004 18:48:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aplicacao_item_requisicao
    (cd_aplicacao                   CHAR(3) NOT NULL,
    ds_aplicacao                   VARCHAR2(35) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.APLICACAO_ITEM_REQUISICAO

ALTER TABLE ifrdba2.aplicacao_item_requisicao
ADD CONSTRAINT air_pk PRIMARY KEY (cd_aplicacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.APLICACAO_ITEM_REQUISICAO

COMMENT ON TABLE ifrdba2.aplicacao_item_requisicao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.APLICACAO_ITEM_REQUISICAO

-- Start of DDL Script for Table IFRDBA2.AQUISICAO_MATERIAL
-- Generated 9-mar-2004 18:48:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aquisicao_material
    (cd_aquisicao                   VARCHAR2(2) NOT NULL,
    ds_aquisicao                   VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AQUISICAO_MATERIAL

ALTER TABLE ifrdba2.aquisicao_material
ADD CONSTRAINT am_pk PRIMARY KEY (cd_aquisicao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.AQUISICAO_MATERIAL

COMMENT ON TABLE ifrdba2.aquisicao_material IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.AQUISICAO_MATERIAL

-- Start of DDL Script for Table IFRDBA2.AREA
-- Generated 9-mar-2004 18:48:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.area
    (cd_area                        NUMBER(3) NOT NULL,
    ds_area                        VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AREA

ALTER TABLE ifrdba2.area
ADD CONSTRAINT ar2_pk PRIMARY KEY (cd_area)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.AREA

COMMENT ON TABLE ifrdba2.area IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.AREA

-- Start of DDL Script for Table IFRDBA2.AREA_ATENDIDA
-- Generated 9-mar-2004 18:48:25 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.area_atendida
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    id_area                        NUMBER(7) NOT NULL,
    no_area                        VARCHAR2(100) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AREA_ATENDIDA

ALTER TABLE ifrdba2.area_atendida
ADD CONSTRAINT pk_areaatendida PRIMARY KEY (dep_cd_dependencia, id_area)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AREA_ATENDIDA

-- Start of DDL Script for Table IFRDBA2.AREA_ATIVIDADES
-- Generated 9-mar-2004 18:48:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.area_atividades
    (aat_codigo                     NUMBER(3) NOT NULL,
    aat_descricao                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AREA_ATIVIDADES

ALTER TABLE ifrdba2.area_atividades
ADD CONSTRAINT aat_pk PRIMARY KEY (aat_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.area_atividades
ADD CONSTRAINT aat_uk UNIQUE (aat_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.AREA_ATIVIDADES

COMMENT ON TABLE ifrdba2.area_atividades IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.AREA_ATIVIDADES

-- Start of DDL Script for Table IFRDBA2.AREA_LIMITE_MODALIDADE
-- Generated 9-mar-2004 18:48:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.area_limite_modalidade
    (ar2_cd_area                    NUMBER(3) NOT NULL,
    mdl_cd_modalidade              NUMBER(2) NOT NULL,
    tp_licitacao                   VARCHAR2(1) NOT NULL,
    vl_minimo                      NUMBER(13,2),
    vl_maximo                      NUMBER(13,2),
    prazo_minimo                   NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AREA_LIMITE_MODALIDADE

ALTER TABLE ifrdba2.area_limite_modalidade
ADD CONSTRAINT arlm_pk PRIMARY KEY (tp_licitacao, mdl_cd_modalidade, ar2_cd_area)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.AREA_LIMITE_MODALIDADE

COMMENT ON TABLE ifrdba2.area_limite_modalidade IS 'Tabela derivada do Relacionamento entre AREA e MODALIDADE- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.AREA_LIMITE_MODALIDADE

-- Start of DDL Script for Table IFRDBA2.ATA_LICITACAO
-- Generated 9-mar-2004 18:48:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ata_licitacao
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia_detent   NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    tp_cd_padrao_hab               VARCHAR2(10) NOT NULL,
    tp_cd_padrao_jul_hab           VARCHAR2(10),
    tp_cd_padrao_pro               VARCHAR2(10),
    tp_cd_padrao_jul_pro           VARCHAR2(10),
    no_arq_ata_abertura            VARCHAR2(8),
    no_arq_ata_habilitacao         VARCHAR2(8),
    no_arq_ata_jul_habilitacao     VARCHAR2(8),
    no_arq_ata_jul_proposta        VARCHAR2(8),
    tp_cd_padrao_pro_tecn          VARCHAR2(10),
    tp_cd_padrao_par_tecn          VARCHAR2(10),
    no_arq_ata_abert_prop_tecn     VARCHAR2(8),
    no_arq_ata_parecer_tecn        VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ATA_LICITACAO

CREATE INDEX ifrdba2.al_tph_fk_i ON ifrdba2.ata_licitacao
  (
    tp_cd_padrao_hab                ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.al_tpjh_fk_i ON ifrdba2.ata_licitacao
  (
    tp_cd_padrao_jul_hab            ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.al_tpjp_fk_i ON ifrdba2.ata_licitacao
  (
    tp_cd_padrao_jul_pro            ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.al_tpp_fk_i ON ifrdba2.ata_licitacao
  (
    tp_cd_padrao_pro                ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ATA_LICITACAO

ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ATA_LICITACAO

COMMENT ON TABLE ifrdba2.ata_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ATA_LICITACAO

-- Start of DDL Script for Table IFRDBA2.ATAERO_POUSO_PERMANENCIA
-- Generated 9-mar-2004 18:48:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ataero_pouso_permanencia
    (dt_fat_ataero                  DATE NOT NULL,
    sd_fat_ataero                  NUMBER(14,2) NOT NULL,
    vl_fat_ataero                  NUMBER(14,2),
    nr_mes_ano                     VARCHAR2(7))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ATAERO_POUSO_PERMANENCIA

ALTER TABLE ifrdba2.ataero_pouso_permanencia
ADD CONSTRAINT app_pk PRIMARY KEY (dt_fat_ataero)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ATAERO_POUSO_PERMANENCIA

-- Start of DDL Script for Table IFRDBA2.ATAERO_TEMP
-- Generated 9-mar-2004 18:48:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ataero_temp
    (cd_dependencia                 NUMBER(4),
    dt_ataero                      DATE,
    vl_ataero                      NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ATAERO_TEMP

-- Start of DDL Script for Table IFRDBA2.ATO_ADMINISTRATIVO
-- Generated 9-mar-2004 18:48:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ato_administrativo
    (nr_ato                         VARCHAR2(25),
    dt_ato                         DATE,
    ds_objeto                      VARCHAR2(500),
    no_arquivo_ato                 VARCHAR2(16) NOT NULL,
    tp_ato_adm                     NUMBER(1),
    cl_pl_aa_processo              NUMBER(4),
    cl_pl_sq_processo              NUMBER(4),
    cl_pl_dep_cd_dependencia       NUMBER(4),
    cl_pl_mdl_cd_modalidade        NUMBER(2),
    cl_tp_comissao                 NUMBER(1),
    cpl_dep_cd_dependencia         NUMBER(4),
    cpl_sq_comissao                NUMBER(6),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    sq_ato                         NUMBER(6) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ATO_ADMINISTRATIVO

ALTER TABLE ifrdba2.ato_administrativo
ADD CONSTRAINT aa_pk PRIMARY KEY (dep_cd_dependencia, sq_ato)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ATO_ADMINISTRATIVO

-- Start of DDL Script for Table IFRDBA2.AUX_ACAO_SIMBEP
-- Generated 9-mar-2004 18:49:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_acao_simbep
    (tpeve_cod_pk                   NUMBER(2) NOT NULL,
    acao_seq_pk                    NUMBER(6) NOT NULL,
    acao_tipo                      VARCHAR2(10) NOT NULL,
    acao_destin                    VARCHAR2(10) NOT NULL,
    acao_assunto                   VARCHAR2(100) NOT NULL,
    acao_mensagem                  VARCHAR2(2000) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_ACAO_SIMBEP

ALTER TABLE ifrdba2.aux_acao_simbep
ADD CONSTRAINT pk_acao_simbep PRIMARY KEY (tpeve_cod_pk, acao_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AUX_ACAO_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_COENV_SIMBEP
-- Generated 9-mar-2004 18:49:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_coenv_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    com_dthrreg_pk                 DATE NOT NULL,
    com_seq_pk                     NUMBER(6) NOT NULL,
    com_dthrenv                    DATE NOT NULL,
    com_tipcom                     NUMBER(1),
    com_endcom                     VARCHAR2(50),
    com_assunto                    VARCHAR2(100),
    com_mensagem                   VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_COENV_SIMBEP

ALTER TABLE ifrdba2.aux_coenv_simbep
ADD CONSTRAINT pk_coenv_simbep PRIMARY KEY (mov_cod_pk, com_dthrreg_pk, 
  com_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.AUX_COENV_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_aux_coenv_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.aux_coenv_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_AUX_COENV_SIMBEP (
MOV_COD_PK
,COM_DTHRREG_PK
,COM_SEQ_PK
,COM_DTHRENV
,COM_TIPCOM
,COM_ENDCOM
,COM_ASSUNTO
,COM_MENSAGEM
,tp_geracao
,quem_gerou
)
values (
:new.MOV_COD_PK
,:new.COM_DTHRREG_PK
,:new.COM_SEQ_PK
,:new.COM_DTHRENV
,:new.COM_TIPCOM
,:new.COM_ENDCOM
,:new.COM_ASSUNTO
,:new.COM_MENSAGEM
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_AUX_COENV_SIMBEP (
MOV_COD_PK
,COM_DTHRREG_PK
,COM_SEQ_PK
,COM_DTHRENV
,COM_TIPCOM
,COM_ENDCOM
,COM_ASSUNTO
,COM_MENSAGEM
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.COM_DTHRREG_PK
,:old.COM_SEQ_PK
,:old.COM_DTHRENV
,:old.COM_TIPCOM
,:old.COM_ENDCOM
,:old.COM_ASSUNTO
,:old.COM_MENSAGEM
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_AUX_COENV_SIMBEP (
MOV_COD_PK
,COM_DTHRREG_PK
,COM_SEQ_PK
,COM_DTHRENV
,COM_TIPCOM
,COM_ENDCOM
,COM_ASSUNTO
,COM_MENSAGEM
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.COM_DTHRREG_PK
,:old.COM_SEQ_PK
,:old.COM_DTHRENV
,:old.COM_TIPCOM
,:old.COM_ENDCOM
,:old.COM_ASSUNTO
,:old.COM_MENSAGEM
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.AUX_COENV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_COMOV_SIMBEP
-- Generated 9-mar-2004 18:49:13 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_comov_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    com_dthreg_pk                  DATE NOT NULL,
    com_seq_pk                     NUMBER(6) NOT NULL,
    com_tipcom                     NUMBER(1),
    com_datsai                     DATE,
    com_codequip                   NUMBER(7),
    com_destarea                   VARCHAR2(50),
    com_execoper                   VARCHAR2(50),
    com_destdeten                  VARCHAR2(50),
    com_origdeten                  VARCHAR2(50),
    com_dscequip                   VARCHAR2(150),
    com_endcom                     VARCHAR2(50),
    com_assunto                    VARCHAR2(100),
    com_mensagem                   VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_COMOV_SIMBEP

ALTER TABLE ifrdba2.aux_comov_simbep
ADD CONSTRAINT pk_comov_simbep PRIMARY KEY (mov_cod_pk, com_dthreg_pk, 
  com_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.AUX_COMOV_SIMBEP

CREATE TRIGGER ifrdba2.tr01_aux_comov_simbep
BEFORE  DELETE 
ON ifrdba2.aux_comov_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  INSERT
  INTO AUX_COENV_SIMBEP
      (
       MOV_COD_PK,
       COM_DTHRREG_PK,
       COM_SEQ_PK,
       COM_DTHRENV,
       COM_TIPCOM,
       COM_ENDCOM,
       COM_ASSUNTO,
       COM_MENSAGEM
      )
  VALUES
      (
       :OLD.MOV_COD_PK,
       :OLD.COM_DTHREG_PK,
       :OLD.COM_SEQ_PK ,
       SYSDATE,
       :OLD.COM_TIPCOM,
       :OLD.COM_ENDCOM,
       :OLD.COM_ASSUNTO,
       :OLD.COM_MENSAGEM
      );
END TR01_AUX_COMOV_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.AUX_COMOV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_EQMOV_SIMBEP
-- Generated 9-mar-2004 18:49:19 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_eqmov_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    eqmov_seq_pk                   NUMBER(6) NOT NULL,
    eqmov_tipo                     NUMBER(1) NOT NULL,
    eqmov_codeqp_ak                VARCHAR2(20) NOT NULL,
    eqmov_ntb_aceite               VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.AUX_EQMOV_SIMBEP

CREATE UNIQUE INDEX ifrdba2.ix_equip_mov01 ON ifrdba2.aux_eqmov_simbep
  (
    mov_cod_pk                      ASC,
    eqmov_codeqp_ak                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.AUX_EQMOV_SIMBEP

ALTER TABLE ifrdba2.aux_eqmov_simbep
ADD CONSTRAINT pk_eqmov_simbep PRIMARY KEY (mov_cod_pk, eqmov_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.AUX_EQMOV_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_aux_eqmov_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.aux_eqmov_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_AUX_EQMOV_SIMBEP (
MOV_COD_PK
,EQMOV_SEQ_PK
,EQMOV_TIPO
,EQMOV_CODEQP_AK
,EQMOV_NTB_ACEITE
,tp_geracao
,quem_gerou
)
values (
:new.MOV_COD_PK
,:new.EQMOV_SEQ_PK
,:new.EQMOV_TIPO
,:new.EQMOV_CODEQP_AK
,:new.EQMOV_NTB_ACEITE
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_AUX_EQMOV_SIMBEP (
MOV_COD_PK
,EQMOV_SEQ_PK
,EQMOV_TIPO
,EQMOV_CODEQP_AK
,EQMOV_NTB_ACEITE
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.EQMOV_SEQ_PK
,:old.EQMOV_TIPO
,:old.EQMOV_CODEQP_AK
,:old.EQMOV_NTB_ACEITE
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_AUX_EQMOV_SIMBEP (
MOV_COD_PK
,EQMOV_SEQ_PK
,EQMOV_TIPO
,EQMOV_CODEQP_AK
,EQMOV_NTB_ACEITE
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.EQMOV_SEQ_PK
,:old.EQMOV_TIPO
,:old.EQMOV_CODEQP_AK
,:old.EQMOV_NTB_ACEITE
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.AUX_EQMOV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_EVENT_SIMBEP
-- Generated 9-mar-2004 18:49:26 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_event_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    eve_seq_pk                     NUMBER(6) NOT NULL,
    tpeve_cod_pk                   NUMBER(2) NOT NULL,
    eve_dthr                       DATE NOT NULL,
    eve_area                       NUMBER(6),
    eve_coletor                    VARCHAR2(1),
    oper_cracha_pk                 VARCHAR2(20),
    eve_codequip                   VARCHAR2(20),
    eve_resporig                   VARCHAR2(20),
    eve_respdest                   VARCHAR2(20),
    eve_execut                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_EVENT_SIMBEP

ALTER TABLE ifrdba2.aux_event_simbep
ADD CONSTRAINT pk_event_simbep PRIMARY KEY (mov_cod_pk, eve_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.AUX_EVENT_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_aux_event_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.aux_event_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_AUX_EVENT_SIMBEP (
MOV_COD_PK
,EVE_SEQ_PK
,TPEVE_COD_PK
,EVE_DTHR
,EVE_AREA
,EVE_COLETOR
,OPER_CRACHA_PK
,EVE_CODEQUIP
,EVE_RESPORIG
,EVE_RESPDEST
,EVE_EXECUT
,tp_geracao
,quem_gerou
)
values (
:new.MOV_COD_PK
,:new.EVE_SEQ_PK
,:new.TPEVE_COD_PK
,:new.EVE_DTHR
,:new.EVE_AREA
,:new.EVE_COLETOR
,:new.OPER_CRACHA_PK
,:new.EVE_CODEQUIP
,:new.EVE_RESPORIG
,:new.EVE_RESPDEST
,:new.EVE_EXECUT
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_AUX_EVENT_SIMBEP (
MOV_COD_PK
,EVE_SEQ_PK
,TPEVE_COD_PK
,EVE_DTHR
,EVE_AREA
,EVE_COLETOR
,OPER_CRACHA_PK
,EVE_CODEQUIP
,EVE_RESPORIG
,EVE_RESPDEST
,EVE_EXECUT
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.EVE_SEQ_PK
,:old.TPEVE_COD_PK
,:old.EVE_DTHR
,:old.EVE_AREA
,:old.EVE_COLETOR
,:old.OPER_CRACHA_PK
,:old.EVE_CODEQUIP
,:old.EVE_RESPORIG
,:old.EVE_RESPDEST
,:old.EVE_EXECUT
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_AUX_EVENT_SIMBEP (
MOV_COD_PK
,EVE_SEQ_PK
,TPEVE_COD_PK
,EVE_DTHR
,EVE_AREA
,EVE_COLETOR
,OPER_CRACHA_PK
,EVE_CODEQUIP
,EVE_RESPORIG
,EVE_RESPDEST
,EVE_EXECUT
,tp_geracao
,quem_gerou
)
values (
:old.MOV_COD_PK
,:old.EVE_SEQ_PK
,:old.TPEVE_COD_PK
,:old.EVE_DTHR
,:old.EVE_AREA
,:old.EVE_COLETOR
,:old.OPER_CRACHA_PK
,:old.EVE_CODEQUIP
,:old.EVE_RESPORIG
,:old.EVE_RESPDEST
,:old.EVE_EXECUT
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.AUX_EVENT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_EXMOV_SIMBEP
-- Generated 9-mar-2004 18:49:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_exmov_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    exmov_seq_pk                   NUMBER(6) NOT NULL,
    oper_cracha_pk                 VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_EXMOV_SIMBEP

ALTER TABLE ifrdba2.aux_exmov_simbep
ADD CONSTRAINT pk_exmov_simbep PRIMARY KEY (mov_cod_pk, exmov_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.AUX_EXMOV_SIMBEP

CREATE TRIGGER ifrdba2.tr01_aux_exmov_simbep
BEFORE INSERT 
ON ifrdba2.aux_exmov_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    VALOR1 NUMBER(7);
    VALOR2 NUMBER(7);
BEGIN
  SELECT COUNT(*) INTO VALOR1 FROM TAB_OPERA_SIMBEP
      WHERE UPPER(OPER_CRACHA_PK) = UPPER(:NEW.OPER_CRACHA_PK);

  IF VALOR1 = 0 THEN
      SELECT COUNT(*) INTO VALOR2 FROM TAB_VISIT_SIMBEP
          WHERE UPPER(VISI_CRACHA_PK) = UPPER(:NEW.OPER_CRACHA_PK);
      IF VALOR2 = 0 THEN
         RAISE_APPLICATION_ERROR(-20000, 'EXECUTANTE INVALIDO');
      END IF;
  END IF;

END TR01_AUX_EXMOV_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.AUX_EXMOV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.AUX_ITEM_PROPOSTA_ORC_SIMULADA
-- Generated 9-mar-2004 18:49:38 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_item_proposta_orc_simulada
    (vsp_cd_nivel_versao            VARCHAR2(2) NOT NULL,
    vsp_cd_versao                  VARCHAR2(2) NOT NULL,
    vsp_nr_ano                     NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    cc2_cd_centro_custo_gerd       NUMBER(5) NOT NULL,
    dep_cd_dependencia_gerd        NUMBER(4) NOT NULL,
    po_cd_programa                 NUMBER(3) NOT NULL,
    prj_cd_projeto                 VARCHAR2(4) NOT NULL,
    in_centralizado                NUMBER(1) NOT NULL,
    cd_prioridade                  NUMBER(1) NOT NULL,
    vl_unitario_item               NUMBER(10,2),
    nr_contrato                    VARCHAR2(20),
    dt_inicio_contrato             DATE,
    dt_termino_contrato            DATE,
    ds_justificativa               VARCHAR2(240),
    ds_item                        VARCHAR2(60),
    cf_nr_item                     NUMBER(5),
    ff_tp_pessoa                   NUMBER(1),
    ff_nr_cgc_cpf                  VARCHAR2(14),
    no_fornecedor                  VARCHAR2(60),
    vl_unitario_item_dolar         NUMBER(10,2),
    in_considera_log               VARCHAR2(1),
    dep_cd_dependencia_gest        NUMBER(4),
    cc2_cd_centro_custo_gest       NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AUX_ITEM_PROPOSTA_ORC_SIMULADA

-- Start of DDL Script for Table IFRDBA2.AUX_RESPD_SIMBEP
-- Generated 9-mar-2004 18:49:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.aux_respd_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    eve_seq_pk                     NUMBER(6) NOT NULL,
    resp_mensagem                  VARCHAR2(2000),
    resp_senha                     VARCHAR2(10),
    resp_assinatura                LONG)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.AUX_RESPD_SIMBEP

ALTER TABLE ifrdba2.aux_respd_simbep
ADD CONSTRAINT pk_respd_simbep PRIMARY KEY (mov_cod_pk, eve_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.AUX_RESPD_SIMBEP

-- Start of DDL Script for Table IFRDBA2.BAIXA_BEM_PATRIMONIAL
-- Generated 9-mar-2004 18:49:44 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.baixa_bem_patrimonial
    (dt_baixa                       DATE NOT NULL,
    bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    tbbp_cd_tipo_baixa             NUMBER(2) NOT NULL,
    in_baixa_total                 NUMBER(1) NOT NULL,
    nr_processo                    VARCHAR2(20) NOT NULL,
    pc_baixa_bem                   NUMBER(5,2),
    qt_bens_baixados               NUMBER(5),
    no_usuario                     VARCHAR2(30),
    in_baixa_efetivada             NUMBER(1),
    st_bem_anterior                NUMBER(2) NOT NULL,
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.BAIXA_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.baixa_bem_patrimonial
ADD CONSTRAINT bdbp_pk PRIMARY KEY (dt_baixa, bp_nr_bem, bp_in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.BAIXA_BEM_PATRIMONIAL

CREATE TRIGGER ifrdba2.trg_bdbp01
BEFORE INSERT 
ON ifrdba2.baixa_bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
CURSOR pega_bem(NrBem IN NUMBER, InUniao IN NUMBER)
   IS
   -- pega o codigo da dependencia que esta manipulando o
   -- bem patrimonial
   SELECT bp.aat_dep_cd_dependencia
   FROM bem_patrimonial bp
WHERE
   bp.nr_bem = NrBem
   AND bp.in_uniao = InUniao;
CURSOR pega_dep(CdDependencia IN NUMBER)
   IS
   -- obtem o codigo da dependencia a qual esta dependencia
   -- esta subordinada
   SELECT dp.dep_dep_codigo
   FROM dependencias dp
WHERE
   dp.dep_codigo = CdDependencia;
WkCdDep NUMBER;
WkCdCdDep NUMBER;
BEGIN
   OPEN pega_bem(:new.bp_nr_bem, :new.bp_in_uniao);
   FETCH pega_bem INTO WkCdDep;
   -- Obs. via foreign key entre baixa_bem_patrimonial e
   -- bem patrimonial, é garantido que haverá um valor para
   -- o bem patrimonial, portanto, não é necessário a validação
   CLOSE pega_bem;
   OPEN pega_dep(WkCdDep);
   FETCH pega_dep INTO WkCdCdDep;
   -- Obs. via foreign key entre bem_patrimonial e
   -- dependencias, é garantido que haverá um valor para
   -- a dependencia, portanto não é necessário a validação
   CLOSE pega_dep;
   :new.cd_centro_negocio := WkCdCdDep;
   :new.dep_cd_dependencia := WkCdDep;
END;
/

-- End of DDL Script for Table IFRDBA2.BAIXA_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.BALANCETE_MENSAL_ALMOXARIFADO
-- Generated 9-mar-2004 18:49:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.balancete_mensal_almoxarifado
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    aa_balancete                   NUMBER(4) NOT NULL,
    mm_balancete                   NUMBER(2) NOT NULL,
    dt_balancete                   DATE NOT NULL,
    vl_e_ai_mc_aquisicao           NUMBER(17,5),
    vl_e_ai_bc_aquisicao           NUMBER(17,5),
    vl_e_ai_bp_aquisicao           NUMBER(17,5),
    vl_e_au_bp_aquisicao           NUMBER(17,5),
    vl_e_ai_mc_transferencia       NUMBER(17,5),
    vl_e_ai_bc_transferencia       NUMBER(17,5),
    vl_e_ai_bp_transferencia       NUMBER(17,5),
    vl_e_au_bp_transferencia       NUMBER(17,5),
    vl_e_ai_mc_outras              NUMBER(17,5),
    vl_e_ai_bc_outras              NUMBER(17,5),
    vl_e_ai_bp_outras              NUMBER(17,5),
    vl_e_au_bp_outras              NUMBER(17,5),
    vl_s_ai_mc_distribuicao        NUMBER(17,5),
    vl_s_ai_bc_distribuicao        NUMBER(17,5),
    vl_s_ai_bp_distribuicao        NUMBER(17,5),
    vl_s_au_bp_distribuicao        NUMBER(17,5),
    vl_s_ai_mc_transferencia       NUMBER(17,5),
    vl_s_ai_bc_transferencia       NUMBER(17,5),
    vl_s_ai_bp_transferencia       NUMBER(17,5),
    vl_s_au_bp_transferencia       NUMBER(17,5),
    vl_s_ai_mc_outras              NUMBER(17,5),
    vl_s_ai_bc_outras              NUMBER(17,5),
    vl_s_ai_bp_outras              NUMBER(17,5),
    vl_s_au_bp_outras              NUMBER(17,5),
    sd_anterior_ai_mc              NUMBER(17,5),
    sd_anterior_ai_bc              NUMBER(17,5),
    sd_anterior_ai_bp              NUMBER(17,5),
    sd_anterior_au_bp              NUMBER(17,5),
    doc_nem_emitidos               VARCHAR2(25),
    doc_nfm_emitidos               VARCHAR2(25),
    doc_nem_cancelados             VARCHAR2(500),
    doc_nfm_cancelados             VARCHAR2(500),
    ds_observacao                  VARCHAR2(500),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.BALANCETE_MENSAL_ALMOXARIFADO

ALTER TABLE ifrdba2.balancete_mensal_almoxarifado
ADD CONSTRAINT bma_pk PRIMARY KEY (dep_cd_dependencia, aa_balancete, 
  mm_balancete)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.BALANCETE_MENSAL_ALMOXARIFADO

COMMENT ON TABLE ifrdba2.balancete_mensal_almoxarifado IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.BALANCETE_MENSAL_ALMOXARIFADO

-- Start of DDL Script for Table IFRDBA2.BANCO_FORMA_PAGTO
-- Generated 9-mar-2004 18:49:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.banco_forma_pagto
    (ban_cd_banco                   VARCHAR2(3) NOT NULL,
    fpg_cd_forma_pgto              VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.BANCO_FORMA_PAGTO

ALTER TABLE ifrdba2.banco_forma_pagto
ADD CONSTRAINT bfp_pk PRIMARY KEY (ban_cd_banco, fpg_cd_forma_pgto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.BANCO_FORMA_PAGTO

-- Start of DDL Script for Table IFRDBA2.BANCOINF
-- Generated 9-mar-2004 18:50:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.bancoinf
    (cd_banco                       VARCHAR2(3) NOT NULL,
    no_banco                       VARCHAR2(40) NOT NULL,
    sig_banco                      VARCHAR2(10) NOT NULL,
    flg_pagto                      NUMBER(1),
    nu_seq_arquivo                 NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.BANCOINF

ALTER TABLE ifrdba2.bancoinf
ADD CONSTRAINT ban_pk PRIMARY KEY (cd_banco)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.bancoinf
ADD CONSTRAINT ban_sigla_uk UNIQUE (sig_banco)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.BANCOINF

-- Start of DDL Script for Table IFRDBA2.BEM_PATRIMONIAL
-- Generated 9-mar-2004 18:50:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.bem_patrimonial
    (nr_bem                         NUMBER(7) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    bp_nr_bem                      NUMBER(7),
    bp_in_uniao                    NUMBER(1),
    cp1_cp_nr_conta                NUMBER(5),
    emp_nr_mat_det_anterior        NUMBER(7),
    emp_nr_mat_det_atual           NUMBER(7),
    fc_cd_forma                    NUMBER(2),
    gp_cd_grupo                    NUMBER(4),
    aat_dep_cd_dependencia         NUMBER(4) NOT NULL,
    aat_id_area                    NUMBER(7) NOT NULL,
    or_cd_origem                   NUMBER(2),
    po_cd_programa                 NUMBER(3),
    sbp_cd_situacao                NUMBER(2),
    dt_imobilizacao                DATE,
    dt_reversao                    DATE,
    dt_ult_calculo                 DATE,
    st_bem                         NUMBER(2),
    ma_deprec_total                NUMBER(6),
    nr_imobilizacao                VARCHAR2(10),
    nr_meses_vida_util             NUMBER(3),
    nr_meses_depreciado            NUMBER(3),
    nr_processo_imobilizacao       VARCHAR2(10),
    nr_tombo_maer                  VARCHAR2(20),
    qt_bem                         NUMBER(5),
    tx_depreciacao                 NUMBER(8,4),
    vl_orig_moeda_nac              NUMBER(17,2),
    vl_quota_deprec_mr             NUMBER(12,4),
    vl_quota_residual_mr           NUMBER(12,4),
    in_diferenca_ipc_btn           NUMBER(1) NOT NULL,
    vl_orig_moeda_rel              NUMBER(17,4),
    nr_bem_ant                     CHAR(10),
    ma_inicio_deprec               NUMBER(6),
    ec_cd_estado                   NUMBER(2),
    in_spv                         NUMBER(1),
    no_usuario                     VARCHAR2(30) NOT NULL,
    ma_inclusao                    NUMBER(6) NOT NULL,
    ig_dep_cd_dependencia          NUMBER(4),
    ig_ci_cd_classe                VARCHAR2(4),
    ig_cd_item                     VARCHAR2(7),
    in_imovel                      NUMBER(1),
    in_seguro                      NUMBER(1),
    emp_cd_dependencia             NUMBER(4),
    in_ajuste                      NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.BEM_PATRIMONIAL

CREATE INDEX ifrdba2.bp_bem_unia_fk ON ifrdba2.bem_patrimonial
  (
    bp_nr_bem                       ASC,
    bp_in_uniao                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.bp_bem_ant_fk ON ifrdba2.bem_patrimonial
  (
    nr_bem_ant                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.bp_emp_atu_ix ON ifrdba2.bem_patrimonial
  (
    emp_nr_mat_det_atual            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.BEM_PATRIMONIAL

ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_pk PRIMARY KEY (nr_bem, in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.BEM_PATRIMONIAL

CREATE TRIGGER ifrdba2.trg_bp
AFTER UPDATE OF 
  aat_dep_cd_dependencia,
ON ifrdba2.bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
   cursor cn_cursor is select dep_cd_dependencia
                from   dependencia
                where  cd_dependencia = :NEW.aat_dep_cd_dependencia;
   cn number(4);
Begin
   open  cn_cursor;
   fetch cn_cursor into cn;
   close cn_cursor;
   UPDATE ACOMP_SITUACAO_BEM_PATRIM
   SET DEP_CD_DEPENDENCIA = :NEW.AAT_DEP_CD_DEPENDENCIA,
       CD_CENTRO_NEGOCIO  = CN
   WHERE BP_NR_BEM   = :NEW.NR_BEM
     AND BP_IN_UNIAO = :NEW.IN_UNIAO;
   UPDATE BAIXA_BEM_PATRIMONIAL
   SET DEP_CD_DEPENDENCIA = :NEW.AAT_DEP_CD_DEPENDENCIA,
       CD_CENTRO_NEGOCIO  = CN
   WHERE BP_NR_BEM   = :NEW.NR_BEM
     AND BP_IN_UNIAO = :NEW.IN_UNIAO;
   UPDATE IMOB_ANDAMENTO_TRANSF
   SET DEP_CD_DEPENDENCIA = :NEW.AAT_DEP_CD_DEPENDENCIA,
       CD_CENTRO_NEGOCIO  = CN
   WHERE BP_NR_BEM   = :NEW.NR_BEM
     AND BP_IN_UNIAO = :NEW.IN_UNIAO;
   UPDATE SIT_MENSAL_BEM_PATRIMONIAL
   SET DEP_CD_DEPENDENCIA = :NEW.AAT_DEP_CD_DEPENDENCIA,
       CD_CENTRO_NEGOCIO  = CN
   WHERE BP_NR_BEM   = :NEW.NR_BEM
     AND BP_IN_UNIAO = :NEW.IN_UNIAO;
   UPDATE VALOR_CARAC_BEM_PATRIMONIAL
   SET DEP_CD_DEPENDENCIA = :NEW.AAT_DEP_CD_DEPENDENCIA,
       CD_CENTRO_NEGOCIO  = CN
   WHERE BP_NR_BEM   = :NEW.NR_BEM
     AND BP_IN_UNIAO = :NEW.IN_UNIAO;
End;
/

-- End of DDL Script for Table IFRDBA2.BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.BEM_PATRIMONIAL_TEMP
-- Generated 9-mar-2004 18:50:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.bem_patrimonial_temp
    (nr_bem                         NUMBER(7) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    bpt_nr_bem                     NUMBER(7),
    bpt_in_uniao                   NUMBER(1),
    cp_nr_conta                    NUMBER(5),
    dep_cd_dependencia             NUMBER(4),
    aat_id_area                    NUMBER(7),
    gp_cd_grupo                    NUMBER(4),
    st_bem                         NUMBER(2),
    qt_bem                         NUMBER(5),
    sbp_cd_situacao                NUMBER(2),
    dt_bem                         DATE,
    vl_moeda_nac                   NUMBER(17,2),
    vl_moeda_rel                   NUMBER(17,4),
    tx_depreciacao                 NUMBER(8,4),
    fc_cd_forma                    NUMBER(2),
    po_cd_programa                 NUMBER(2),
    ec_cd_estado                   NUMBER(2),
    pc_bem                         NUMBER(5,2),
    vl_quota_deprec_mr             NUMBER(10,4),
    vl_quota_residual_mr           NUMBER(10,4),
    nr_mat_detentor                NUMBER(7),
    ds_mensagem                    VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.BEM_PATRIMONIAL_TEMP

ALTER TABLE ifrdba2.bem_patrimonial_temp
ADD CONSTRAINT bpt_pk PRIMARY KEY (nr_bem, in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.BEM_PATRIMONIAL_TEMP

-- Start of DDL Script for Table IFRDBA2.BP_ORFAO
-- Generated 9-mar-2004 18:50:25 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.bp_orfao
    (nr_bem                         NUMBER(7) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    bp_nr_bem                      NUMBER(7),
    bp_in_uniao                    NUMBER(1),
    cp1_cp_nr_conta                NUMBER(5),
    emp_nr_mat_det_anterior        NUMBER(7),
    emp_nr_mat_det_atual           NUMBER(7),
    fc_cd_forma                    NUMBER(2),
    gp_cd_grupo                    NUMBER(4),
    aat_dep_cd_dependencia         NUMBER(4) NOT NULL,
    aat_id_area                    NUMBER(7) NOT NULL,
    or_cd_origem                   NUMBER(2),
    po_cd_programa                 NUMBER(3),
    sbp_cd_situacao                NUMBER(2),
    dt_imobilizacao                DATE,
    dt_reversao                    DATE,
    dt_ult_calculo                 DATE,
    st_bem                         NUMBER(2),
    ma_deprec_total                NUMBER(6),
    nr_imobilizacao                VARCHAR2(10),
    nr_meses_vida_util             NUMBER(3),
    nr_meses_depreciado            NUMBER(3),
    nr_processo_imobilizacao       VARCHAR2(10),
    nr_tombo_maer                  VARCHAR2(20),
    qt_bem                         NUMBER(5),
    tx_depreciacao                 NUMBER(8,4),
    vl_orig_moeda_nac              NUMBER(17,2),
    vl_quota_deprec_mr             NUMBER(10,4),
    vl_quota_residual_mr           NUMBER(10,4),
    in_diferenca_ipc_btn           NUMBER(1) NOT NULL,
    vl_orig_moeda_rel              NUMBER(17,4),
    nr_bem_ant                     CHAR(10),
    ma_inicio_deprec               NUMBER(6),
    ec_cd_estado                   NUMBER(2),
    in_spv                         NUMBER(1),
    no_usuario                     VARCHAR2(30) NOT NULL,
    ma_inclusao                    NUMBER(6) NOT NULL,
    ig_dep_cd_dependencia          NUMBER(4),
    ig_ci_cd_classe                VARCHAR2(4),
    ig_cd_item                     VARCHAR2(7))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.BP_ORFAO

-- Start of DDL Script for Table IFRDBA2.CARAC_GRUPO_PATRIMONIAL
-- Generated 9-mar-2004 18:50:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.carac_grupo_patrimonial
    (gp_cd_grupo                    NUMBER(4) NOT NULL,
    cp1_cd_caracteristica          NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CARAC_GRUPO_PATRIMONIAL

ALTER TABLE ifrdba2.carac_grupo_patrimonial
ADD CONSTRAINT cgp_pk PRIMARY KEY (gp_cd_grupo, cp1_cd_caracteristica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CARAC_GRUPO_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.CARAC_MAT_ITEM_GENERICO
-- Generated 9-mar-2004 18:50:30 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.carac_mat_item_generico
    (ig_ci_cd_classe                VARCHAR2(4) NOT NULL,
    ig_cd_item                     VARCHAR2(7) NOT NULL,
    cma_cd_caracteristica          NUMBER(4) NOT NULL,
    vl_carac_item_gener            VARCHAR2(50),
    ig_dep_cd_dependencia          NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CARAC_MAT_ITEM_GENERICO

CREATE INDEX ifrdba2.indcaracmatitem ON ifrdba2.carac_mat_item_generico
  (
    ig_dep_cd_dependencia           ASC,
    ig_ci_cd_classe                 ASC,
    ig_cd_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CARAC_MAT_ITEM_GENERICO

ALTER TABLE ifrdba2.carac_mat_item_generico
ADD CONSTRAINT cmig_pk PRIMARY KEY (cma_cd_caracteristica, ig_dep_cd_dependencia, 
  ig_ci_cd_classe, ig_cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CARAC_MAT_ITEM_GENERICO

COMMENT ON TABLE ifrdba2.carac_mat_item_generico IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CARAC_MAT_ITEM_GENERICO

-- Start of DDL Script for Table IFRDBA2.CARACTERISTICA_MATERIAL
-- Generated 9-mar-2004 18:50:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.caracteristica_material
    (cd_caracteristica              NUMBER(4) NOT NULL,
    ds_caracteristica              VARCHAR2(35) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CARACTERISTICA_MATERIAL

ALTER TABLE ifrdba2.caracteristica_material
ADD CONSTRAINT cma_pk PRIMARY KEY (cd_caracteristica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CARACTERISTICA_MATERIAL

COMMENT ON TABLE ifrdba2.caracteristica_material IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CARACTERISTICA_MATERIAL

-- Start of DDL Script for Table IFRDBA2.CARACTERISTICA_PATRIMONIAL
-- Generated 9-mar-2004 18:50:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.caracteristica_patrimonial
    (cd_caracteristica              NUMBER(4) NOT NULL,
    ds_validacao                   VARCHAR2(100),
    in_preenchimento               NUMBER(1),
    no_caracteristica              VARCHAR2(20),
    tm_caracteristica              NUMBER(2),
    tp_caracteristica              NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CARACTERISTICA_PATRIMONIAL

ALTER TABLE ifrdba2.caracteristica_patrimonial
ADD CONSTRAINT cp1_pk PRIMARY KEY (cd_caracteristica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CARACTERISTICA_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.CATALOGO_FINANCEIRO
-- Generated 9-mar-2004 18:50:42 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.catalogo_financeiro
    (nr_item                        NUMBER(5) NOT NULL,
    ds_item                        VARCHAR2(60) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CATALOGO_FINANCEIRO

CREATE INDEX ifrdba2.cf_cc1_fk_i ON ifrdba2.catalogo_financeiro
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CATALOGO_FINANCEIRO

ALTER TABLE ifrdba2.catalogo_financeiro
ADD CONSTRAINT cf_pk PRIMARY KEY (nr_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CATALOGO_FINANCEIRO

-- Start of DDL Script for Table IFRDBA2.CENTRO_CUSTO
-- Generated 9-mar-2004 18:50:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.centro_custo
    (cd_centro_custo                NUMBER(5) NOT NULL,
    ds_centro_custo                VARCHAR2(50),
    cd_cnds                        NUMBER(2),
    cd_gnd                         VARCHAR2(2),
    cd_centro_custo_chave          VARCHAR2(5),
    in_gestor                      CHAR(1),
    sg_centro_custo                VARCHAR2(10),
    dv_centro_custo                NUMBER(1),
    data_criacao                   DATE NOT NULL,
    data_extincao                  DATE,
    tipo_conta                     VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CENTRO_CUSTO

ALTER TABLE ifrdba2.centro_custo
ADD CONSTRAINT cc2_pk PRIMARY KEY (cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CENTRO_CUSTO

-- Start of DDL Script for Table IFRDBA2.CENTRO_CUSTO_POR_DEP
-- Generated 9-mar-2004 18:50:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.centro_custo_por_dep
    (ccd_cct_codigo                 NUMBER(5) NOT NULL,
    ccd_dep_codigo                 NUMBER(4) NOT NULL,
    ccd_tipo_centro_custo          VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CENTRO_CUSTO_POR_DEP

ALTER TABLE ifrdba2.centro_custo_por_dep
ADD CONSTRAINT ccd_pk PRIMARY KEY (ccd_cct_codigo, ccd_dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CENTRO_CUSTO_POR_DEP

COMMENT ON TABLE ifrdba2.centro_custo_por_dep IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CENTRO_CUSTO_POR_DEP

-- Start of DDL Script for Table IFRDBA2.CENTRO_CUSTO_SMART
-- Generated 9-mar-2004 18:50:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.centro_custo_smart
    (cd_centro_custo                NUMBER(5) NOT NULL,
    ds_centro_custo                VARCHAR2(50),
    cd_cnds                        NUMBER(2),
    cd_gnd                         VARCHAR2(2),
    cd_centro_custo_chave          VARCHAR2(5),
    in_gestor                      CHAR(1),
    sg_centro_custo                VARCHAR2(10),
    dv_centro_custo                NUMBER(1),
    data_criacao                   DATE,
    data_extincao                  DATE,
    tipo_conta                     VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CENTRO_CUSTO_SMART

ALTER TABLE ifrdba2.centro_custo_smart
ADD CONSTRAINT ccs2_pk PRIMARY KEY (cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CENTRO_CUSTO_SMART

-- Start of DDL Script for Table IFRDBA2.CENTRO_CUSTO_UOR
-- Generated 9-mar-2004 18:50:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.centro_custo_uor
    (ccu_ccd_cct_codigo             NUMBER(5) NOT NULL,
    ccu_ccd_dep_codigo             NUMBER(4) NOT NULL,
    ccu_uor_codigo                 NUMBER(9) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CENTRO_CUSTO_UOR

ALTER TABLE ifrdba2.centro_custo_uor
ADD CONSTRAINT ccu_pk PRIMARY KEY (ccu_ccd_cct_codigo, ccu_ccd_dep_codigo, 
  ccu_uor_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CENTRO_CUSTO_UOR

COMMENT ON TABLE ifrdba2.centro_custo_uor IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CENTRO_CUSTO_UOR

-- Start of DDL Script for Table IFRDBA2.CLASSE_ITEM
-- Generated 9-mar-2004 18:51:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.classe_item
    (cd_classe                      VARCHAR2(4) NOT NULL,
    ds_classe                      VARCHAR2(65) NOT NULL,
    cd_conta_contabil              VARCHAR2(20),
    ds_abrange                     VARCHAR2(2000),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CLASSE_ITEM

ALTER TABLE ifrdba2.classe_item
ADD CONSTRAINT ci_pk PRIMARY KEY (cd_classe)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CLASSE_ITEM

COMMENT ON TABLE ifrdba2.classe_item IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CLASSE_ITEM

-- Start of DDL Script for Table IFRDBA2.CLASSIFICACAO_ABC
-- Generated 9-mar-2004 18:51:05 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.classificacao_abc
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    cd_classificacao               VARCHAR2(6) NOT NULL,
    vl_fator_est_seguranca         NUMBER(10,2),
    vl_fator_lote_compra           NUMBER(10,2),
    vl_intervalo_aquisicao         NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CLASSIFICACAO_ABC

ALTER TABLE ifrdba2.classificacao_abc
ADD CONSTRAINT abc_pk PRIMARY KEY (dep_cd_dependencia, cd_classificacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CLASSIFICACAO_ABC

-- Start of DDL Script for Table IFRDBA2.CLASSIFICACAO_CONTABIL_FIN
-- Generated 9-mar-2004 18:51:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.classificacao_contabil_fin
    (pag_nr_lancamento              NUMBER(38) NOT NULL,
    nr_seq                         NUMBER(3) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20),
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_valor                       NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CLASSIFICACAO_CONTABIL_FIN

ALTER TABLE ifrdba2.classificacao_contabil_fin
ADD CONSTRAINT clc_pk PRIMARY KEY (pag_nr_lancamento, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CLASSIFICACAO_CONTABIL_FIN

-- Start of DDL Script for Table IFRDBA2.COMBINACAO_CHAVE
-- Generated 9-mar-2004 18:51:13 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.combinacao_chave
    (dep_cd_dependencia             VARCHAR2(3) NOT NULL,
    cc1_nr_conta                   VARCHAR2(8) NOT NULL,
    po_cd_programa                 VARCHAR2(6),
    prj_cd_projeto                 VARCHAR2(6),
    cc2_cd_centro_custo            VARCHAR2(6) NOT NULL,
    data_criacao                   DATE NOT NULL,
    data_exclusao                  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COMBINACAO_CHAVE

-- Start of DDL Script for Table IFRDBA2.COMBINACAO_EVENTO
-- Generated 9-mar-2004 18:51:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.combinacao_evento
    (evc_nr_evento1                 NUMBER(3) NOT NULL,
    evc_nr_evento2                 NUMBER(3) NOT NULL,
    in_exercicio                   VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COMBINACAO_EVENTO

ALTER TABLE ifrdba2.combinacao_evento
ADD CONSTRAINT ce_ck_1 CHECK (       IN_EXERCICIO IN ('S','N')       )
/
ALTER TABLE ifrdba2.combinacao_evento
ADD CONSTRAINT ce_pk PRIMARY KEY (evc_nr_evento1, evc_nr_evento2)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COMBINACAO_EVENTO

-- Start of DDL Script for Table IFRDBA2.COMISSAO_LICITACAO
-- Generated 9-mar-2004 18:51:19 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.comissao_licitacao
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia_detent   NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    dt_comissao                    DATE NOT NULL,
    tp_comissao                    NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COMISSAO_LICITACAO

ALTER TABLE ifrdba2.comissao_licitacao
ADD CONSTRAINT cl_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade, tp_comissao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.COMISSAO_LICITACAO

COMMENT ON TABLE ifrdba2.comissao_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.COMISSAO_LICITACAO

-- Start of DDL Script for Table IFRDBA2.COMISSAO_PERMANENTE_LICITACAO
-- Generated 9-mar-2004 18:51:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.comissao_permanente_licitacao
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    sq_comissao                    NUMBER(6) NOT NULL,
    dt_inicio                      DATE NOT NULL,
    dt_final                       DATE NOT NULL,
    tp_comissao                    VARCHAR2(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COMISSAO_PERMANENTE_LICITACAO

ALTER TABLE ifrdba2.comissao_permanente_licitacao
ADD CONSTRAINT cpl_pk PRIMARY KEY (dep_cd_dependencia, sq_comissao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.COMISSAO_PERMANENTE_LICITACAO

COMMENT ON TABLE ifrdba2.comissao_permanente_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.COMISSAO_PERMANENTE_LICITACAO

-- Start of DDL Script for Table IFRDBA2.COMISSAO_VISTORIA
-- Generated 9-mar-2004 18:51:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.comissao_vistoria
    (aa_nr_ato                      NUMBER(7) NOT NULL,
    aa_dt_ato                      DATE NOT NULL,
    dos_nr_of_oficializa_dossie    NUMBER(7) NOT NULL,
    edi_ic_cd_instalacao           NUMBER(10) NOT NULL,
    aa_vistoria                    NUMBER(4) NOT NULL,
    dt_vistoria                    DATE NOT NULL,
    nr_vistoria                    NUMBER(7) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.COMISSAO_VISTORIA

CREATE INDEX ifrdba2.cv_aa_fk_i ON ifrdba2.comissao_vistoria
  (
    aa_nr_ato                       ASC,
    aa_dt_ato                       ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cv_dos_fk_i ON ifrdba2.comissao_vistoria
  (
    dos_nr_of_oficializa_dossie     ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cv_edi_fk_i ON ifrdba2.comissao_vistoria
  (
    edi_ic_cd_instalacao            ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.COMISSAO_VISTORIA

ALTER TABLE ifrdba2.comissao_vistoria
ADD CONSTRAINT cv_pk PRIMARY KEY (aa_nr_ato, aa_dt_ato, 
  dos_nr_of_oficializa_dossie)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.COMISSAO_VISTORIA

COMMENT ON TABLE ifrdba2.comissao_vistoria IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.COMISSAO_VISTORIA

-- Start of DDL Script for Table IFRDBA2.COMPROMISSO_ORCAMENTARIO
-- Generated 9-mar-2004 18:51:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.compromisso_orcamentario
    (nr_ano_compromisso             NUMBER(4) NOT NULL,
    dep_cd_dependencia_compr       NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_compromisso                 NUMBER(6) NOT NULL,
    dt_informacao_compromisso      DATE NOT NULL,
    dt_referencia_comp             DATE NOT NULL,
    dt_memo                        DATE NOT NULL,
    su_id_usuario                  VARCHAR2(10) NOT NULL,
    dep_cd_dependencia_efetuou     NUMBER(4) NOT NULL,
    ds_compromisso                 VARCHAR2(300),
    cc1_nr_conta                   VARCHAR2(20),
    nr_cgc_cpf                     VARCHAR2(14),
    nr_matricula                   NUMBER(7),
    ind_empreg_fornec              VARCHAR2(1),
    flg_interface                  CHAR(1),
    dat_geracao_interface          DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COMPROMISSO_ORCAMENTARIO

ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT comprom_orc_chk_flg_interface CHECK ( flg_interface in ('P','F')                                                       )
/
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_ck_1 CHECK ( ind_empreg_fornec in ('F','E')                                                   )
/
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_pk PRIMARY KEY (nr_ano_compromisso, dep_cd_dependencia_compr, 
  cc2_cd_centro_custo, nr_compromisso)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COMPROMISSO_ORCAMENTARIO

-- Start of DDL Script for Table IFRDBA2.COMPROMISSO_ORCAMENTARIO_TEMP
-- Generated 9-mar-2004 18:51:41 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.compromisso_orcamentario_temp
    (num_compromisso_temp           NUMBER(6) NOT NULL,
    num_ano_compromisso            NUMBER(4),
    cod_dependencia_compr          NUMBER(4),
    cod_centro_custo               NUMBER(5),
    dat_informacao_compromisso     DATE,
    dat_referencia_comp            DATE,
    dat_memo                       DATE,
    cod_id_usuario                 VARCHAR2(10),
    cod_dependencia_efetuou        NUMBER(4),
    des_compromisso                VARCHAR2(300),
    num_conta                      VARCHAR2(20),
    num_cgc_cpf                    VARCHAR2(14),
    flg_empreg_fornec              VARCHAR2(1) NOT NULL,
    flg_interface                  VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COMPROMISSO_ORCAMENTARIO_TEMP

ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_emp_ck CHECK (  FLG_EMPREG_FORNEC IN ('E','F')                                                  )
/
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_int_ck CHECK (  FLG_INTERFACE IN ('F','P','C','O')                                              )
/
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_num_pk PRIMARY KEY (num_compromisso_temp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COMPROMISSO_ORCAMENTARIO_TEMP

-- Start of DDL Script for Table IFRDBA2.CONDICAO_ARMAZENAMENTO
-- Generated 9-mar-2004 18:51:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.condicao_armazenamento
    (cd_condicao                    NUMBER(2) NOT NULL,
    ds_condicao                    VARCHAR2(35) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONDICAO_ARMAZENAMENTO

ALTER TABLE ifrdba2.condicao_armazenamento
ADD CONSTRAINT ca_pk PRIMARY KEY (cd_condicao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CONDICAO_ARMAZENAMENTO

COMMENT ON TABLE ifrdba2.condicao_armazenamento IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CONDICAO_ARMAZENAMENTO

-- Start of DDL Script for Table IFRDBA2.CONTA_CONTABIL
-- Generated 9-mar-2004 18:51:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_contabil
    (nr_conta                       VARCHAR2(20) NOT NULL,
    no_conta                       VARCHAR2(50) NOT NULL,
    tdr_cd_despesa_receita         VARCHAR2(5),
    tp_despesa_receita             VARCHAR2(1),
    nr_conta_chave                 VARCHAR2(8),
    or_cd_origem                   NUMBER(2),
    in_receita                     NUMBER(1),
    in_dimensionamento             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CONTA_CONTABIL

CREATE INDEX ifrdba2.cc1_or_fk_i ON ifrdba2.conta_contabil
  (
    or_cd_origem                    ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cc1_tdr_fk_i ON ifrdba2.conta_contabil
  (
    tdr_cd_despesa_receita          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CONTA_CONTABIL

ALTER TABLE ifrdba2.conta_contabil
ADD CONSTRAINT cc1_pk PRIMARY KEY (nr_conta)
USING INDEX
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CONTABIL

-- Start of DDL Script for Table IFRDBA2.CONTA_CONTABIL_SMART
-- Generated 9-mar-2004 18:51:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_contabil_smart
    (nr_conta                       VARCHAR2(20) NOT NULL,
    no_conta                       VARCHAR2(50),
    tdr_cd_despesa_receita         VARCHAR2(5),
    tp_despesa_receita             VARCHAR2(1),
    nr_conta_chave                 VARCHAR2(8),
    or_cd_origem                   NUMBER(2),
    in_receita                     NUMBER(1),
    in_dimensionamento             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_CONTABIL_SMART

ALTER TABLE ifrdba2.conta_contabil_smart
ADD CONSTRAINT ccs1_pk PRIMARY KEY (nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.conta_contabil_smart
ADD CONSTRAINT ccs_chk_in_dimension CHECK (IN_DIMENSIONAMENTO is null or ( IN_DIMENSIONAMENTO in ('Q','V') ))
/

-- End of DDL Script for Table IFRDBA2.CONTA_CONTABIL_SMART

-- Start of DDL Script for Table IFRDBA2.CONTA_CORRENTE
-- Generated 9-mar-2004 18:52:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_corrente
    (ban_cd_banco                   VARCHAR2(3) NOT NULL,
    age_cd_agencia                 VARCHAR2(7) NOT NULL,
    tcc_tp_conta_corrente          VARCHAR2(1) NOT NULL,
    nr_conta_corrente              VARCHAR2(12) NOT NULL,
    age_dep_cd_dependencia         NUMBER(4) NOT NULL,
    evc_nr_evento                  NUMBER(3),
    cc1_nr_conta                   VARCHAR2(20),
    dv_conta_corrente              VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CONTA_CORRENTE

CREATE INDEX ifrdba2.cc_age_fk_i ON ifrdba2.conta_corrente
  (
    age_cd_agencia                  ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cc_ban_fk_i ON ifrdba2.conta_corrente
  (
    ban_cd_banco                    ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cc_cc1_fk_i ON ifrdba2.conta_corrente
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cc_dep_fk_i ON ifrdba2.conta_corrente
  (
    age_dep_cd_dependencia          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cc_tcc_fk_i ON ifrdba2.conta_corrente
  (
    tcc_tp_conta_corrente           ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CONTA_CORRENTE

ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_pk PRIMARY KEY (age_dep_cd_dependencia, ban_cd_banco, 
  tcc_tp_conta_corrente)
USING INDEX
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CORRENTE

-- Start of DDL Script for Table IFRDBA2.CONTA_CORRENTE_FORNECEDOR
-- Generated 9-mar-2004 18:52:17 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_corrente_fornecedor
    (for_nr_cgc_cpf                 VARCHAR2(14) NOT NULL,
    ban_cd_banco                   VARCHAR2(3) NOT NULL,
    age_cd_agencia                 VARCHAR2(7) NOT NULL,
    nr_conta_corrente              VARCHAR2(12) NOT NULL,
    in_opb                         NUMBER(1) NOT NULL,
    in_propria_praca               VARCHAR2(1) NOT NULL,
    det_cd_demonstra_tarifacao     NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_CORRENTE_FORNECEDOR

ALTER TABLE ifrdba2.conta_corrente_fornecedor
ADD CONSTRAINT ccf_opb_ck CHECK ( IN_OPB IN (1,2)  )
/
ALTER TABLE ifrdba2.conta_corrente_fornecedor
ADD CONSTRAINT ccf_pk PRIMARY KEY (for_nr_cgc_cpf, ban_cd_banco, age_cd_agencia, 
  nr_conta_corrente)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CORRENTE_FORNECEDOR

-- Start of DDL Script for Table IFRDBA2.CONTA_CORRENTE_FORNECEDOR_TEMP
-- Generated 9-mar-2004 18:52:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_corrente_fornecedor_temp
    (ff_dep_cd_dependencia          NUMBER(4) NOT NULL,
    ff_nr_cgc_cpf                  VARCHAR2(14) NOT NULL,
    ban_cd_banco                   VARCHAR2(3) NOT NULL,
    age_cd_agencia                 VARCHAR2(7) NOT NULL,
    nr_conta_corrente              VARCHAR2(12) NOT NULL,
    dv_conta_corrente              VARCHAR2(2) NOT NULL,
    in_opb                         NUMBER(1) NOT NULL,
    no_agencia                     VARCHAR2(30) NOT NULL,
    in_propria_praca               VARCHAR2(1) NOT NULL,
    det_cd_demonstra_tarifacao     NUMBER(3) NOT NULL,
    ff_tp_pessoa                   NUMBER(1) NOT NULL,
    dv_agencia                     VARCHAR2(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CORRENTE_FORNECEDOR_TEMP

-- Start of DDL Script for Table IFRDBA2.CONTA_CREDITAR
-- Generated 9-mar-2004 18:52:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_creditar
    (evc_nr_evento                  NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_CREDITAR

ALTER TABLE ifrdba2.conta_creditar
ADD CONSTRAINT ccr_pk PRIMARY KEY (evc_nr_evento, cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CREDITAR

-- Start of DDL Script for Table IFRDBA2.CONTA_CREDITAR_SP
-- Generated 9-mar-2004 18:52:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_creditar_sp
    (clc_pag_nr_lancamento          NUMBER(38) NOT NULL,
    clc_nr_seq                     NUMBER(3) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    nr_valor                       NUMBER(14,2) NOT NULL,
    lat_nr_seq                     NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_CREDITAR_SP

ALTER TABLE ifrdba2.conta_creditar_sp
ADD CONSTRAINT ccs_pk PRIMARY KEY (clc_pag_nr_lancamento, clc_nr_seq, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_CREDITAR_SP

-- Start of DDL Script for Table IFRDBA2.CONTA_GRUPO
-- Generated 9-mar-2004 18:52:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_grupo
    (cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    gp_cd_grupo                    NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_GRUPO

ALTER TABLE ifrdba2.conta_grupo
ADD CONSTRAINT conta_grupo_pk PRIMARY KEY (cc1_nr_conta, gp_cd_grupo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_GRUPO

-- Start of DDL Script for Table IFRDBA2.CONTA_IMPRESSAO
-- Generated 9-mar-2004 18:52:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_impressao
    (sq_impressao                   NUMBER(4),
    tp_conta                       CHAR(1),
    cd_conta                       NUMBER(4),
    nm_conta                       VARCHAR2(40),
    in_identacao                   NUMBER(1),
    in_negrito                     NUMBER(1),
    vl_substr_inicio               NUMBER(2),
    vl_substr_fim                  NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_IMPRESSAO

-- Start of DDL Script for Table IFRDBA2.CONTA_PATRIMONIAL
-- Generated 9-mar-2004 18:52:38 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_patrimonial
    (nr_conta                       NUMBER(5) NOT NULL,
    nr_nivel                       NUMBER(1) NOT NULL,
    in_anal_sint                   NUMBER(1) NOT NULL,
    ds_conta                       VARCHAR2(40) NOT NULL,
    tp_natureza_conta              CHAR(1) NOT NULL,
    in_imob_andam                  NUMBER(1) NOT NULL,
    cp_nr_conta                    NUMBER(5),
    cc1_nr_conta_bem_inf           VARCHAR2(20),
    cc1_nr_conta_bem_uniao         VARCHAR2(20),
    cc1_nr_conta_dp_bem_inf        VARCHAR2(20),
    cc1_nr_conta_dp_bem_uniao      VARCHAR2(20),
    tx_depreciacao_conta           NUMBER(5,2),
    cc1_nr_conta_cm_bem_inf        VARCHAR2(20),
    cc1_nr_conta_cm_bem_uniao      VARCHAR2(20),
    cc1_nr_conta_desp_dp_inf       VARCHAR2(20),
    cc1_nr_conta_desp_dp_uniao     VARCHAR2(20),
    cc1_nr_conta_rem_inf           VARCHAR2(20),
    cc1_nr_conta_rem_uniao         VARCHAR2(20),
    cspv_nr_conta_spv_dp           NUMBER(6),
    cspv_nr_conta_spv_rem          NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_PATRIMONIAL

ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_pk PRIMARY KEY (nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.CONTA_PATRIMONIAL_DEPENDENCIA
-- Generated 9-mar-2004 18:52:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_patrimonial_dependencia
    (cp_nr_conta                    NUMBER(5) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_PATRIMONIAL_DEPENDENCIA

ALTER TABLE ifrdba2.conta_patrimonial_dependencia
ADD CONSTRAINT cp1 PRIMARY KEY (cp_nr_conta, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_PATRIMONIAL_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.CONTA_SPV
-- Generated 9-mar-2004 18:52:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conta_spv
    (nr_conta_spv                   NUMBER(6) NOT NULL,
    ds_conta_spv                   VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.CONTA_SPV

ALTER TABLE ifrdba2.conta_spv
ADD CONSTRAINT conta_spv_pk PRIMARY KEY (nr_conta_spv)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.conta_spv
ADD CONSTRAINT conta_spv_uk UNIQUE (ds_conta_spv)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.CONTA_SPV

-- Start of DDL Script for Table IFRDBA2.CONVERSAO_UNIDADE
-- Generated 9-mar-2004 18:52:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.conversao_unidade
    (ui_cd_unidade_converte         VARCHAR2(4) NOT NULL,
    ui_cd_unidade_convertida       VARCHAR2(4) NOT NULL,
    vl_conversao                   NUMBER(8,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CONVERSAO_UNIDADE

CREATE INDEX ifrdba2.cu_uia_fk_i ON ifrdba2.conversao_unidade
  (
    ui_cd_unidade_convertida        ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.cu_uie_fk_i ON ifrdba2.conversao_unidade
  (
    ui_cd_unidade_converte          ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CONVERSAO_UNIDADE

ALTER TABLE ifrdba2.conversao_unidade
ADD CONSTRAINT cu_pk PRIMARY KEY (ui_cd_unidade_converte, 
  ui_cd_unidade_convertida)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.CONVERSAO_UNIDADE

COMMENT ON TABLE ifrdba2.conversao_unidade IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.CONVERSAO_UNIDADE

-- Start of DDL Script for Table IFRDBA2.COTACAO_ANUAL_REFERENCIA
-- Generated 9-mar-2004 18:53:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.cotacao_anual_referencia
    (nr_ano                         NUMBER(4) NOT NULL,
    dt_cotacao_dolar_prop          DATE NOT NULL,
    vl_cotacao                     NUMBER(14,6) NOT NULL,
    dt_cotacao_dolar_prop1         DATE,
    vl_cotacao1                    NUMBER(14,6),
    dt_cotacao_dolar_prop2         DATE,
    vl_cotacao2                    NUMBER(14,6),
    dt_cotacao_dolar_prop3         DATE,
    vl_cotacao3                    NUMBER(14,6),
    dt_cotacao_dolar_prop4         DATE,
    vl_cotacao4                    NUMBER(14,6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COTACAO_ANUAL_REFERENCIA

ALTER TABLE ifrdba2.cotacao_anual_referencia
ADD CONSTRAINT car_pk PRIMARY KEY (nr_ano)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COTACAO_ANUAL_REFERENCIA

-- Start of DDL Script for Table IFRDBA2.COTACAO_MOEDA
-- Generated 9-mar-2004 18:53:05 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.cotacao_moeda
    (moe_cd_moeda                   NUMBER(3) NOT NULL,
    dt_cotacao                     DATE NOT NULL,
    vl_cotacao                     NUMBER(15,4) NOT NULL,
    val_cotacao                    NUMBER(21,10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.COTACAO_MOEDA

ALTER TABLE ifrdba2.cotacao_moeda
ADD CONSTRAINT cmo_pk PRIMARY KEY (moe_cd_moeda, dt_cotacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.COTACAO_MOEDA

-- Start of DDL Script for Table IFRDBA2.CUSTODIA
-- Generated 9-mar-2004 18:53:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.custodia
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    tp_operacao                    VARCHAR2(1) NOT NULL,
    nu_operacao                    NUMBER(5) NOT NULL,
    no_depositante                 VARCHAR2(40) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5),
    dt_operacao                    DATE NOT NULL,
    dt_vencimento                  DATE,
    dt_devolucao                   DATE,
    vl_custodia                    NUMBER(14,2) NOT NULL,
    nu_documento                   VARCHAR2(20) NOT NULL,
    nu_edital                      VARCHAR2(20),
    oca_cd_origem_caucao           VARCHAR2(3) NOT NULL,
    ds_observacao                  VARCHAR2(50),
    st_custodia                    VARCHAR2(1) NOT NULL,
    nu_contrato                    VARCHAR2(20),
    tga_cd_tp_garantia             VARCHAR2(3) NOT NULL,
    ban_cd_banco                   VARCHAR2(3),
    seg_cd_seguradora              VARCHAR2(3),
    vl_correcao                    NUMBER(14,2),
    vl_devolucao                   NUMBER(14,2),
    ds_endereco                    VARCHAR2(50),
    no_cidade                      VARCHAR2(30),
    sg_uf                          VARCHAR2(2),
    nu_cep                         NUMBER(8),
    evc_nr_evento_rcb              NUMBER(5) NOT NULL,
    eti_cd_especie_titulo          VARCHAR2(3),
    evc_nr_evento_apr              NUMBER(5),
    nr_cgc_cpf                     VARCHAR2(14),
    dt_ultima_apr                  DATE,
    cod_corretora                  VARCHAR2(3),
    nu_operacao_endossada          NUMBER(5),
    uor_codigo                     NUMBER(9),
    nr_cgc_cpf_usuario             VARCHAR2(14),
    nr_conta_corrente              VARCHAR2(12),
    nr_agencia                     VARCHAR2(7))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.CUSTODIA

CREATE INDEX ifrdba2.ctd1_evc_fk_i ON ifrdba2.custodia
  (
    evc_nr_evento_apr               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_ban_fk_i ON ifrdba2.custodia
  (
    ban_cd_banco                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_dep_fk_i ON ifrdba2.custodia
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_eti_fk_i ON ifrdba2.custodia
  (
    eti_cd_especie_titulo           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_evc_fk_i ON ifrdba2.custodia
  (
    evc_nr_evento_rcb               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_oca_fk_i ON ifrdba2.custodia
  (
    oca_cd_origem_caucao            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_seg_fk_i ON ifrdba2.custodia
  (
    seg_cd_seguradora               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ctd_tga_fk_i ON ifrdba2.custodia
  (
    tga_cd_tp_garantia              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.CUSTODIA

ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_pk PRIMARY KEY (dep_cd_dependencia, nu_operacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.CUSTODIA

CREATE TRIGGER ifrdba2.trg_log_custodia
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.custodia
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
	IF INSERTING THEN
	INSERT INTO LOG_CUSTODIA
	VALUES
	(
		  :NEW.dep_cd_dependencia,
		  :NEW.tp_operacao,
		  :NEW.nu_operacao,
		  :NEW.no_depositante,
		  :NEW.cc2_cd_centro_custo,
		  :NEW.dt_operacao,
		  :NEW.dt_vencimento,
		  :NEW.dt_devolucao,
		  :NEW.vl_custodia,
		  :NEW.nu_documento,
		  :NEW.nu_edital,
		  :NEW.oca_cd_origem_caucao,
		  :NEW.ds_observacao,
		  :NEW.st_custodia,
		  :NEW.nu_contrato,
		  :NEW.tga_cd_tp_garantia,
		  :NEW.ban_cd_banco,
		  :NEW.seg_cd_seguradora,
		  :NEW.vl_correcao,
		  :NEW.vl_devolucao,
		  :NEW.ds_endereco,
		  :NEW.no_cidade,
		  :NEW.sg_uf,
		  :NEW.nu_cep,
		  :NEW.evc_nr_evento_rcb,
		  :NEW.eti_cd_especie_titulo,
		  :NEW.evc_nr_evento_apr,
		  :NEW.nr_cgc_cpf,
		  :NEW.dt_ultima_apr,
		  :NEW.cod_corretora,
		  SYSDATE,
		  'I',
		  USER,
		  :NEW.nu_operacao_endossada,
		  :NEW.uor_codigo
	);
END IF;
IF DELETING THEN
	INSERT INTO LOG_CUSTODIA
	VALUES
	(
		  :OLD.dep_cd_dependencia,
		  :OLD.tp_operacao,
		  :OLD.nu_operacao,
		  :OLD.no_depositante,
		  :OLD.cc2_cd_centro_custo,
		  :OLD.dt_operacao,
		  :OLD.dt_vencimento,
		  :OLD.dt_devolucao,
		  :OLD.vl_custodia,
		  :OLD.nu_documento,
		  :OLD.nu_edital,
		  :OLD.oca_cd_origem_caucao,
		  :OLD.ds_observacao,
		  :OLD.st_custodia,
		  :OLD.nu_contrato,
		  :OLD.tga_cd_tp_garantia,
		  :OLD.ban_cd_banco,
		  :OLD.seg_cd_seguradora,
		  :OLD.vl_correcao,
		  :OLD.vl_devolucao,
		  :OLD.ds_endereco,
		  :OLD.no_cidade,
		  :OLD.sg_uf,
		  :OLD.nu_cep,
		  :OLD.evc_nr_evento_rcb,
		  :OLD.eti_cd_especie_titulo,
		  :OLD.evc_nr_evento_apr,
		  :OLD.nr_cgc_cpf,
		  :OLD.dt_ultima_apr,
		  :OLD.cod_corretora,
		  SYSDATE,
		  'E',
		  USER,
		  :NEW.nu_operacao_endossada,
		  :NEW.uor_codigo
	);
END IF;
IF UPDATING THEN
	INSERT INTO LOG_CUSTODIA
	VALUES
	(
		  :OLD.dep_cd_dependencia,
		  :OLD.tp_operacao,
		  :OLD.nu_operacao,
		  :OLD.no_depositante,
		  :OLD.cc2_cd_centro_custo,
		  :OLD.dt_operacao,
		  :OLD.dt_vencimento,
		  :OLD.dt_devolucao,
		  :OLD.vl_custodia,
		  :OLD.nu_documento,
		  :OLD.nu_edital,
		  :OLD.oca_cd_origem_caucao,
		  :OLD.ds_observacao,
		  :OLD.st_custodia,
		  :OLD.nu_contrato,
		  :OLD.tga_cd_tp_garantia,
		  :OLD.ban_cd_banco,
		  :OLD.seg_cd_seguradora,
		  :OLD.vl_correcao,
		  :OLD.vl_devolucao,
		  :OLD.ds_endereco,
		  :OLD.no_cidade,
		  :OLD.sg_uf,
		  :OLD.nu_cep,
		  :OLD.evc_nr_evento_rcb,
		  :OLD.eti_cd_especie_titulo,
		  :OLD.evc_nr_evento_apr,
		  :OLD.nr_cgc_cpf,
		  :OLD.dt_ultima_apr,
		  :OLD.cod_corretora,
		  SYSDATE,
		  'A',
		  USER,
		  :NEW.nu_operacao_endossada,
		  :NEW.uor_codigo
	);
END IF;
END;
/

-- End of DDL Script for Table IFRDBA2.CUSTODIA

-- Start of DDL Script for Table IFRDBA2.DATA_CONTROLE
-- Generated 9-mar-2004 18:53:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.data_controle
    (aa_referencia                  NUMBER(4) NOT NULL,
    mm_referencia                  NUMBER(2) NOT NULL,
    dt_fechamento_contabil         DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DATA_CONTROLE

ALTER TABLE ifrdba2.data_controle
ADD CONSTRAINT dco_pk PRIMARY KEY (aa_referencia, mm_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DATA_CONTROLE

-- Start of DDL Script for Table IFRDBA2.DATA_CORRECAO_CAMBIAL
-- Generated 9-mar-2004 18:53:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.data_correcao_cambial
    (aa_referencia                  NUMBER(4) NOT NULL,
    mm_referencia                  NUMBER(2) NOT NULL,
    dt_correcao_cambial            DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DATA_CORRECAO_CAMBIAL

-- Start of DDL Script for Table IFRDBA2.DEBITO_CREDITO
-- Generated 9-mar-2004 18:53:37 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.debito_credito
    (lac_dep_cd_dependencia         NUMBER(4) NOT NULL,
    lac_nr_seq                     NUMBER(4) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    in_debito_credito              VARCHAR2(1) NOT NULL,
    vl_lancamento_contabil         NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEBITO_CREDITO

ALTER TABLE ifrdba2.debito_credito
ADD CONSTRAINT dc_ck_1 CHECK ( in_debito_credito in ('D','C') )
/
ALTER TABLE ifrdba2.debito_credito
ADD CONSTRAINT dc_pk PRIMARY KEY (lac_dep_cd_dependencia, lac_nr_seq, 
  cc1_nr_conta, in_debito_credito)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DEBITO_CREDITO

-- Start of DDL Script for Table IFRDBA2.DEDUCAO_ACRESCIMO
-- Generated 9-mar-2004 18:53:42 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.deducao_acrescimo
    (lat_nr_lancamento              NUMBER(38) NOT NULL,
    tda_cd_deducao_acrescimo       VARCHAR2(3) NOT NULL,
    vl_ded_acres                   NUMBER(14,2),
    ds_historico                   VARCHAR2(40),
    nr_seq                         NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEDUCAO_ACRESCIMO

ALTER TABLE ifrdba2.deducao_acrescimo
ADD CONSTRAINT dea_pk PRIMARY KEY (lat_nr_lancamento, tda_cd_deducao_acrescimo, 
  nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DEDUCAO_ACRESCIMO

-- Start of DDL Script for Table IFRDBA2.DEDUCAO_ACRESCIMO_DEP
-- Generated 9-mar-2004 18:53:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.deducao_acrescimo_dep
    (dea_lat_nr_lancamento          NUMBER(38) NOT NULL,
    dea_tda_cd_deducao_acrescimo   VARCHAR2(3) NOT NULL,
    dea_nr_seq                     NUMBER(3) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    vl_ded_acres_dep               NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEDUCAO_ACRESCIMO_DEP

ALTER TABLE ifrdba2.deducao_acrescimo_dep
ADD CONSTRAINT dad_pk PRIMARY KEY (dea_lat_nr_lancamento, 
  dea_tda_cd_deducao_acrescimo, dea_nr_seq, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DEDUCAO_ACRESCIMO_DEP

-- Start of DDL Script for Table IFRDBA2.DEMONSTRA_FORMA_PAGTO
-- Generated 9-mar-2004 18:53:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.demonstra_forma_pagto
    (cd_demonstra_forma             VARCHAR2(3) NOT NULL,
    ds_demonstra_forma             VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEMONSTRA_FORMA_PAGTO

ALTER TABLE ifrdba2.demonstra_forma_pagto
ADD CONSTRAINT dfp_pk PRIMARY KEY (cd_demonstra_forma)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DEMONSTRA_FORMA_PAGTO

-- Start of DDL Script for Table IFRDBA2.DEMONSTRA_TARIFACAO
-- Generated 9-mar-2004 18:53:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.demonstra_tarifacao
    (cd_demonstra_tarifacao         NUMBER(3) NOT NULL,
    ds_demonstra_tarifacao         VARCHAR2(30) NOT NULL,
    tab_cd_tarifa_bancaria         NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEMONSTRA_TARIFACAO

ALTER TABLE ifrdba2.demonstra_tarifacao
ADD CONSTRAINT det_pk PRIMARY KEY (cd_demonstra_tarifacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DEMONSTRA_TARIFACAO

-- Start of DDL Script for Table IFRDBA2.DEPENDENCIAS
-- Generated 9-mar-2004 18:53:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.dependencias
    (dep_codigo                     NUMBER(4) NOT NULL,
    dep_tipo                       NUMBER(2) NOT NULL,
    dep_nome                       VARCHAR2(60) NOT NULL,
    dep_sigla                      VARCHAR2(10) NOT NULL,
    dep_endereco_logradouro        VARCHAR2(50),
    dep_endereco_bairro            VARCHAR2(30),
    dep_endereco_municipio         VARCHAR2(30),
    dep_ufe_sigla                  VARCHAR2(2),
    dep_endereco_cep               NUMBER(8),
    dep_numero_telefone_1          NUMBER(11),
    dep_numero_telefone_2          NUMBER(11),
    dep_numero_fax                 NUMBER(11),
    dep_numero_cgc                 VARCHAR2(14),
    dep_aba_ban_codigo             NUMBER(3),
    dep_aba_codigo                 VARCHAR2(7),
    dep_dep_codigo                 NUMBER(4),
    dep_codigo_ugd                 VARCHAR2(4),
    dep_rge_codigo                 VARCHAR2(2),
    cd_dependencia_chave           VARCHAR2(3),
    dep_in_categoria_aeroporto     VARCHAR2(3),
    dep_data_criacao               DATE NOT NULL,
    dep_ds_documento_criacao       VARCHAR2(50),
    dep_data_extincao              DATE,
    dep_ds_documento_extincao      VARCHAR2(50),
    dep_msg_cntchque               VARCHAR2(180),
    dep_dep_codigo_vincula_pgto    NUMBER(4),
    dep_mun_codigo                 NUMBER(5),
    dep_grupos_dependencias        NUMBER(2),
    in_opb_automatica              VARCHAR2(1),
    dep_sigla_anterior             VARCHAR2(10) NOT NULL,
    dep_ind_recolh_sal_educacao    VARCHAR2(1),
    dep_ind_orcamento              VARCHAR2(1),
    dep_adm_material               NUMBER(4),
    dep_comar                      VARCHAR2(4),
    dep_denominacao_completa       VARCHAR2(150),
    dep_denominacao_abreviada      VARCHAR2(60),
    dep_id_cent_empresa            NUMBER(6),
    dep_ie                         VARCHAR2(20),
    dep_horaria_administrativo     VARCHAR2(20),
    dep_fuso_horario_brasilia      VARCHAR2(4),
    dep_dt_absorcao_infraero       DATE,
    dep_tel_achados_perdidos       NUMBER(8),
    dep_tel_balcao_informacao      NUMBER(8),
    dep_tel_comunicacao_social     NUMBER(8),
    dep_numero_telefone_ddd        NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.DEPENDENCIAS

CREATE INDEX ifrdba2.dep_extincao_ix ON ifrdba2.dependencias
  (
    dep_data_extincao               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.dep_aba_fk_i ON ifrdba2.dependencias
  (
    dep_aba_ban_codigo              ASC,
    dep_aba_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.dep_dep_fk_i ON ifrdba2.dependencias
  (
    dep_dep_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.dep_mun_fk_i ON ifrdba2.dependencias
  (
    dep_ufe_sigla                   ASC,
    dep_mun_codigo                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.dep_ufe_fk_i ON ifrdba2.dependencias
  (
    dep_ufe_sigla                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.DEPENDENCIAS

ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_ck_10 CHECK (       dep_ind_recolh_sal_educacao in ('S','N')       )
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_ck_11 CHECK (dep_ind_orcamento in ('S','N'))
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_opb_ck CHECK (                                       IN_OPB_AUTOMATICA in ('S','N')                                                                       )
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_pk PRIMARY KEY (dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_uk UNIQUE (dep_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.DEPENDENCIAS

COMMENT ON COLUMN ifrdba2.dependencias.dep_comar IS 'COMAR da Regiao da Dependencia'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_dt_absorcao_infraero IS 'DATA DE ABSORCAO DO AEROPORTO PELA INFRAERO'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_fuso_horario_brasilia IS 'FUSO HORARIO DA DEPENDECIA EM RELACAO A BRASILIA'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_horaria_administrativo IS 'HORÁRIO ADMINISTRATIVO DA DEPENDENCIA'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_ie IS 'INSCRICAO ESTADUAL DA DEPENDENCIA'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_numero_telefone_ddd IS 'codigo DDD do telefone da dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_tel_achados_perdidos IS 'TELEFONE DE ACHADOS E PERDIDOS DA DEPENDECIA'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_tel_balcao_informacao IS 'TELEFONE DO BALCAO DE INFORMACOES DA DEPENDENCIA'
/
COMMENT ON COLUMN ifrdba2.dependencias.dep_tel_comunicacao_social IS 'TELEFONE DE COMUNICACAO SOCIAL DA DEPENDENCIA'
/

-- End of DDL Script for Table IFRDBA2.DEPENDENCIAS

-- Start of DDL Script for Table IFRDBA2.DEPENDENCIAS_SMART
-- Generated 9-mar-2004 18:54:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.dependencias_smart
    (dep_codigo                     NUMBER(4) NOT NULL,
    dep_tipo                       NUMBER(2),
    dep_nome                       VARCHAR2(60),
    dep_sigla                      VARCHAR2(10),
    dep_endereco_logradouro        VARCHAR2(50),
    dep_endereco_bairro            VARCHAR2(30),
    dep_endereco_municipio         VARCHAR2(30),
    dep_ufe_sigla                  VARCHAR2(2),
    dep_endereco_cep               NUMBER(8),
    dep_numero_telefone_1          NUMBER(11),
    dep_numero_telefone_2          NUMBER(11),
    dep_numero_fax                 NUMBER(11),
    dep_numero_cgc                 VARCHAR2(14),
    dep_aba_ban_codigo             NUMBER(3),
    dep_aba_codigo                 VARCHAR2(7),
    dep_dep_codigo                 NUMBER(4),
    dep_codigo_ugd                 VARCHAR2(4),
    dep_rge_codigo                 VARCHAR2(2),
    cd_dependencia_chave           VARCHAR2(3),
    dep_in_categoria_aeroporto     VARCHAR2(3),
    dep_data_criacao               DATE,
    dep_ds_documento_criacao       VARCHAR2(50),
    dep_data_extincao              DATE,
    dep_ds_documento_extincao      VARCHAR2(50),
    dep_msg_cntchque               VARCHAR2(180),
    dep_dep_codigo_vincula_pgto    NUMBER(4),
    dep_mun_codigo                 NUMBER(5),
    dep_grupos_dependencias        NUMBER(2),
    in_opb_automatica              VARCHAR2(1),
    dep_sigla_anterior             VARCHAR2(10),
    dep_ind_recolh_sal_educacao    VARCHAR2(1),
    dep_ind_orcamento              VARCHAR2(1),
    dep_adm_material               NUMBER(4),
    dep_comar                      VARCHAR2(4),
    dep_denominacao_completa       VARCHAR2(150),
    dep_denominacao_abreviada      VARCHAR2(60),
    dep_id_cent_empresa            NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DEPENDENCIAS_SMART

ALTER TABLE ifrdba2.dependencias_smart
ADD CONSTRAINT deps_ck_10 CHECK (DEP_IND_RECOLH_SAL_EDUCACAO is null or ( DEP_IND_RECOLH_SAL_EDUCACAO in ('S','N') ))
/
ALTER TABLE ifrdba2.dependencias_smart
ADD CONSTRAINT deps_ck_11 CHECK (DEP_IND_ORCAMENTO is null or ( DEP_IND_ORCAMENTO in ('S','N') ))
/
ALTER TABLE ifrdba2.dependencias_smart
ADD CONSTRAINT deps_opb_ck CHECK (IN_OPB_AUTOMATICA is null or ( IN_OPB_AUTOMATICA in ('S','N') ))
/
ALTER TABLE ifrdba2.dependencias_smart
ADD CONSTRAINT deps_pk PRIMARY KEY (dep_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.DEPENDENCIAS_SMART

COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_aba_ban_codigo IS 'Código do Banco'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_aba_codigo IS 'Código da Agência Bancária'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_adm_material IS 'Dependencia de Administracao do Material'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_codigo IS 'Código da Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_codigo_ugd IS 'Código identificador da Unidade Geradora de Despesa'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_comar IS 'COMAR da Regiao da Dependencia'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_data_criacao IS 'Data de Criação da Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_data_extincao IS 'Data de Extinção da Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_dep_codigo IS 'Identificador de subordinacao (auto-relacionamento)'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_dep_codigo_vincula_pgto IS 'Identificador dependencia pagamento (auto-relaciomento)'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_ds_documento_criacao IS 'Documento de Criação'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_ds_documento_extincao IS 'Documento de Extinção'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_endereco_bairro IS 'Bairro'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_endereco_cep IS 'Código de Endereçamento Postal'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_endereco_logradouro IS 'Logradouro'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_endereco_municipio IS 'Município'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_grupos_dependencias IS 'Código do Grupo de Dependências'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_msg_cntchque IS 'MSG PARA CONTRA-CHEQUE'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_mun_codigo IS 'Código do Município'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_nome IS 'Nome da Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_numero_cgc IS 'Código de Pessoa Jurídica'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_numero_fax IS 'Número do FAX'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_numero_telefone_1 IS 'Número do telefone'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_numero_telefone_2 IS 'Número do telefone'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_sigla IS 'Sigla da Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_tipo IS 'Tipo de Dependência'
/
COMMENT ON COLUMN ifrdba2.dependencias_smart.dep_ufe_sigla IS 'Sigla da Unidade da Federação'
/

-- End of DDL Script for Table IFRDBA2.DEPENDENCIAS_SMART

-- Start of DDL Script for Table IFRDBA2.DERIVADO_IMOB_TRANSF
-- Generated 9-mar-2004 18:54:18 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.derivado_imob_transf
    (iat_bp_nr_bem                  NUMBER(7) NOT NULL,
    iat_bp_in_uniao                NUMBER(1) NOT NULL,
    iat_dt_transf                  DATE NOT NULL,
    bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    cp_nr_conta                    NUMBER(5) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    pc_destino                     NUMBER(5,2) NOT NULL,
    qt_destino                     NUMBER(5),
    in_bem_principal               NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DERIVADO_IMOB_TRANSF

ALTER TABLE ifrdba2.derivado_imob_transf
ADD CONSTRAINT dit_pk PRIMARY KEY (iat_bp_nr_bem, iat_bp_in_uniao, iat_dt_transf, 
  bp_nr_bem, bp_in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DERIVADO_IMOB_TRANSF

-- Start of DDL Script for Table IFRDBA2.DESPESAS_ORCAMENTO
-- Generated 9-mar-2004 18:54:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.despesas_orcamento
    (nro_ano                        NUMBER(4) NOT NULL,
    cod_dependencia                NUMBER(4) NOT NULL,
    nro_item                       NUMBER(5) NOT NULL,
    cod_centro_custo               NUMBER(5) NOT NULL,
    cod_programa                   NUMBER(3),
    cod_projeto                    VARCHAR2(4) NOT NULL,
    nro_conta                      VARCHAR2(20) NOT NULL,
    ind_dimensionamento            VARCHAR2(1) NOT NULL,
    cod_dependencia_gestor_prev    NUMBER(4) NOT NULL,
    cod_centro_custo_gestor_prev   NUMBER(5) NOT NULL,
    cod_prioridade                 NUMBER(1) NOT NULL,
    cod_dependencia_gestor_def     NUMBER(4) NOT NULL,
    cod_centro_custo_gestor_def    NUMBER(5) NOT NULL,
    des_justificativa              VARCHAR2(240),
    cod_grupo                      NUMBER(5),
    des_item                       VARCHAR2(60),
    nro_contrato                   VARCHAR2(20),
    dat_inicio_contrato            DATE,
    dat_termino_contrato           DATE,
    nom_fornecedor                 VARCHAR2(60),
    val_unitario                   NUMBER(10,2),
    qtd_jan                        NUMBER(7),
    qtd_fev                        NUMBER(7),
    qtd_mar                        NUMBER(7),
    qtd_abr                        NUMBER(7),
    qtd_mai                        NUMBER(7),
    qtd_jun                        NUMBER(7),
    qtd_jul                        NUMBER(7),
    qtd_ago                        NUMBER(7),
    qtd_set                        NUMBER(7),
    qtd_out                        NUMBER(7),
    qtd_nov                        NUMBER(7),
    qtd_dez                        NUMBER(7),
    val_unitario1                  NUMBER(10,2),
    qtd_jan1                       NUMBER(7),
    qtd_fev1                       NUMBER(7),
    qtd_mar1                       NUMBER(7),
    qtd_abr1                       NUMBER(7),
    qtd_mai1                       NUMBER(7),
    qtd_jun1                       NUMBER(7),
    qtd_jul1                       NUMBER(7),
    qtd_ago1                       NUMBER(7),
    qtd_set1                       NUMBER(7),
    qtd_out1                       NUMBER(7),
    qtd_nov1                       NUMBER(7),
    qtd_dez1                       NUMBER(7),
    val_unitario2                  NUMBER(10,2),
    qtd_jan2                       NUMBER(7),
    qtd_fev2                       NUMBER(7),
    qtd_mar2                       NUMBER(7),
    qtd_abr2                       NUMBER(7),
    qtd_mai2                       NUMBER(7),
    qtd_jun2                       NUMBER(7),
    qtd_jul2                       NUMBER(7),
    qtd_ago2                       NUMBER(7),
    qtd_set2                       NUMBER(7),
    qtd_out2                       NUMBER(7),
    qtd_nov2                       NUMBER(7),
    qtd_dez2                       NUMBER(7),
    val_unitario3                  NUMBER(10,2),
    qtd_jan3                       NUMBER(7),
    qtd_fev3                       NUMBER(7),
    qtd_mar3                       NUMBER(7),
    qtd_abr3                       NUMBER(7),
    qtd_mai3                       NUMBER(7),
    qtd_jun3                       NUMBER(7),
    qtd_jul3                       NUMBER(7),
    qtd_ago3                       NUMBER(7),
    qtd_set3                       NUMBER(7),
    qtd_out3                       NUMBER(7),
    qtd_nov3                       NUMBER(7),
    qtd_dez3                       NUMBER(7),
    val_unitario4                  NUMBER(10,2),
    qtd_jan4                       NUMBER(7),
    qtd_fev4                       NUMBER(7),
    qtd_mar4                       NUMBER(7),
    qtd_abr4                       NUMBER(7),
    qtd_mai4                       NUMBER(7),
    qtd_jun4                       NUMBER(7),
    qtd_jul4                       NUMBER(7),
    qtd_ago4                       NUMBER(7),
    qtd_set4                       NUMBER(7),
    qtd_out4                       NUMBER(7),
    qtd_nov4                       NUMBER(7),
    qtd_dez4                       NUMBER(7),
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2),
    val_jan1                       NUMBER(14,2),
    val_fev1                       NUMBER(14,2),
    val_mar1                       NUMBER(14,2),
    val_abr1                       NUMBER(14,2),
    val_mai1                       NUMBER(14,2),
    val_jun1                       NUMBER(14,2),
    val_jul1                       NUMBER(14,2),
    val_ago1                       NUMBER(14,2),
    val_set1                       NUMBER(14,2),
    val_out1                       NUMBER(14,2),
    val_nov1                       NUMBER(14,2),
    val_dez1                       NUMBER(14,2),
    val_jan2                       NUMBER(14,2),
    val_fev2                       NUMBER(14,2),
    val_mar2                       NUMBER(14,2),
    val_abr2                       NUMBER(14,2),
    val_mai2                       NUMBER(14,2),
    val_jun2                       NUMBER(14,2),
    val_jul2                       NUMBER(14,2),
    val_ago2                       NUMBER(14,2),
    val_set2                       NUMBER(14,2),
    val_out2                       NUMBER(14,2),
    val_nov2                       NUMBER(14,2),
    val_dez2                       NUMBER(14,2),
    val_jan3                       NUMBER(14,2),
    val_fev3                       NUMBER(14,2),
    val_mar3                       NUMBER(14,2),
    val_abr3                       NUMBER(14,2),
    val_mai3                       NUMBER(14,2),
    val_jun3                       NUMBER(14,2),
    val_jul3                       NUMBER(14,2),
    val_ago3                       NUMBER(14,2),
    val_set3                       NUMBER(14,2),
    val_out3                       NUMBER(14,2),
    val_nov3                       NUMBER(14,2),
    val_dez3                       NUMBER(14,2),
    val_jan4                       NUMBER(14,2),
    val_fev4                       NUMBER(14,2),
    val_mar4                       NUMBER(14,2),
    val_abr4                       NUMBER(14,2),
    val_mai4                       NUMBER(14,2),
    val_jun4                       NUMBER(14,2),
    val_jul4                       NUMBER(14,2),
    val_ago4                       NUMBER(14,2),
    val_set4                       NUMBER(14,2),
    val_out4                       NUMBER(14,2),
    val_nov4                       NUMBER(14,2),
    val_dez4                       NUMBER(14,2),
    ind_centralizado               NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DESPESAS_ORCAMENTO

ALTER TABLE ifrdba2.despesas_orcamento
ADD CONSTRAINT deo_pk PRIMARY KEY (nro_ano, cod_dependencia, nro_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DESPESAS_ORCAMENTO

-- Start of DDL Script for Table IFRDBA2.DET_ADICAO_EXCL_FA_CH_CONTABIL
-- Generated 9-mar-2004 18:54:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.det_adicao_excl_fa_ch_contabil
    (smcp_cp1_cp_nr_conta           NUMBER(5) NOT NULL,
    smcp_cp1_dep_cd_dependencia    NUMBER(4) NOT NULL,
    smcp_ma_situacao               NUMBER(6) NOT NULL,
    smcp_in_uniao                  NUMBER(1) NOT NULL,
    fc_cd_forma                    NUMBER(2) NOT NULL,
    tp_detalhe                     CHAR(1) NOT NULL,
    chave_contabil                 CHAR(20) NOT NULL,
    vl_bem_mo                      NUMBER(17,2),
    vl_bem_mr                      NUMBER(17,4),
    cd_centro_custo                NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DET_ADICAO_EXCL_FA_CH_CONTABIL

ALTER TABLE ifrdba2.det_adicao_excl_fa_ch_contabil
ADD CONSTRAINT det_adic_exc_fa_cc_pk PRIMARY KEY (smcp_cp1_cp_nr_conta, 
  smcp_cp1_dep_cd_dependencia, smcp_ma_situacao, smcp_in_uniao, fc_cd_forma, 
  tp_detalhe, chave_contabil, cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.DET_ADICAO_EXCL_FA_CH_CONTABIL

COMMENT ON TABLE ifrdba2.det_adicao_excl_fa_ch_contabil IS 'SIPAT - '
/

-- End of DDL Script for Table IFRDBA2.DET_ADICAO_EXCL_FA_CH_CONTABIL

-- Start of DDL Script for Table IFRDBA2.DETALHE_ADICAO_EXCLUSAO_FA
-- Generated 9-mar-2004 18:54:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.detalhe_adicao_exclusao_fa
    (smcp_cp1_cp_nr_conta           NUMBER(5) NOT NULL,
    smcp_cp1_dep_cd_dependencia    NUMBER(4) NOT NULL,
    smcp_ma_situacao               NUMBER(6) NOT NULL,
    smcp_in_uniao                  NUMBER(1) NOT NULL,
    fc_cd_forma                    NUMBER(2) NOT NULL,
    tp_detalhe                     CHAR(1) NOT NULL,
    vl_bem_mo                      NUMBER(17,2),
    vl_bem_mr                      NUMBER(17,4),
    vl_bem_dp_mo_ea                NUMBER(17,2),
    vl_bem_dp_mr_ea                NUMBER(17,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DETALHE_ADICAO_EXCLUSAO_FA

ALTER TABLE ifrdba2.detalhe_adicao_exclusao_fa
ADD CONSTRAINT daefa_pk PRIMARY KEY (smcp_cp1_cp_nr_conta, 
  smcp_cp1_dep_cd_dependencia, smcp_ma_situacao, smcp_in_uniao, fc_cd_forma, 
  tp_detalhe)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DETALHE_ADICAO_EXCLUSAO_FA

-- Start of DDL Script for Table IFRDBA2.DETALHE_ADICAO_PO
-- Generated 9-mar-2004 18:54:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.detalhe_adicao_po
    (smcp_cp1_cp_nr_conta           NUMBER(5) NOT NULL,
    smcp_cp1_dep_cd_dependencia    NUMBER(4) NOT NULL,
    smcp_ma_situacao               NUMBER(6) NOT NULL,
    smcp_in_uniao                  NUMBER(1) NOT NULL,
    po_cd_programa                 NUMBER(3) NOT NULL,
    vl_bem_mo                      NUMBER(17,2),
    vl_bem_mr                      NUMBER(17,4),
    cd_centro_custo                NUMBER(5) NOT NULL,
    tp_detalhe                     VARCHAR2(1) NOT NULL,
    vl_bem_dp_mo_ea                NUMBER(17,2),
    vl_bem_dp_mr_ea                NUMBER(17,4),
    vl_exc_cm_dp_mo                NUMBER(17,2),
    vl_exc_cm_dp_mo_ea             NUMBER(17,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DETALHE_ADICAO_PO

ALTER TABLE ifrdba2.detalhe_adicao_po
ADD CONSTRAINT dapo_pk PRIMARY KEY (smcp_cp1_cp_nr_conta, 
  smcp_cp1_dep_cd_dependencia, smcp_ma_situacao, smcp_in_uniao, po_cd_programa, 
  cd_centro_custo, tp_detalhe)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DETALHE_ADICAO_PO

-- Start of DDL Script for Table IFRDBA2.DETALHE_DEPREC_REMUN
-- Generated 9-mar-2004 18:54:41 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.detalhe_deprec_remun
    (cp1_dep_cd_dependencia         NUMBER(4) NOT NULL,
    cp1_cp_nr_conta                NUMBER(5) NOT NULL,
    cd_centro_custo                NUMBER(5) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    vl_adi_dp_mo                   NUMBER(17,2),
    vl_adi_dp_mr                   NUMBER(17,4),
    vl_remun_mo                    NUMBER(17,2),
    vl_remun_mr                    NUMBER(17,2),
    vl_cm_dp_mo                    NUMBER(17,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DETALHE_DEPREC_REMUN

ALTER TABLE ifrdba2.detalhe_deprec_remun
ADD CONSTRAINT ddr_pk PRIMARY KEY (cp1_dep_cd_dependencia, cp1_cp_nr_conta, 
  cd_centro_custo, ma_situacao, in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DETALHE_DEPREC_REMUN

-- Start of DDL Script for Table IFRDBA2.DETALHE_DEPREC_REMUN_TEMP
-- Generated 9-mar-2004 18:54:45 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.detalhe_deprec_remun_temp
    (cp1_dep_cd_dependencia         NUMBER(4) NOT NULL,
    cp1_cp_nr_conta                NUMBER(5) NOT NULL,
    cd_centro_custo                NUMBER(5) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    vl_adi_dp_mo                   NUMBER(17,2),
    vl_adi_dp_mr                   NUMBER(17,4),
    vl_remun_mo                    NUMBER(17,2),
    vl_remun_mr                    NUMBER(17,2),
    vl_cm_dp_mo                    NUMBER(17,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DETALHE_DEPREC_REMUN_TEMP

-- Start of DDL Script for Table IFRDBA2.DETALHE_ESTRUTURA
-- Generated 9-mar-2004 18:54:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.detalhe_estrutura
    (eci_cd_estrutura               NUMBER(3) NOT NULL,
    cd_detalhe                     NUMBER(4) NOT NULL,
    nr_nivel                       NUMBER(2) NOT NULL,
    dep_cd_dependencia             NUMBER(4),
    de_eci_cd_estrutura            NUMBER(3),
    de_cd_detalhe                  NUMBER(4),
    de_nr_nivel                    NUMBER(2),
    no_detalhe                     VARCHAR2(30) NOT NULL,
    in_ultimo_nivel                NUMBER(1) NOT NULL,
    vl_chave_0                     NUMBER(1),
    vl_chave_1                     NUMBER(1),
    vl_chave_2                     NUMBER(1),
    vl_chave_3                     NUMBER(1),
    vl_chave_4                     NUMBER(1),
    vl_chave_5                     NUMBER(1),
    vl_chave_6                     NUMBER(1),
    vl_chave_7                     NUMBER(1),
    vl_chave_8                     NUMBER(1),
    vl_chave_9                     NUMBER(1),
    no_usuario                     VARCHAR2(12))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DETALHE_ESTRUTURA

ALTER TABLE ifrdba2.detalhe_estrutura
ADD CONSTRAINT de_pk PRIMARY KEY (eci_cd_estrutura, cd_detalhe, nr_nivel)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DETALHE_ESTRUTURA

-- Start of DDL Script for Table IFRDBA2.DIVULGACAO_LICITACAO
-- Generated 9-mar-2004 18:54:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.divulgacao_licitacao
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia          NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    nu_oficio                      NUMBER(3) NOT NULL,
    aa_oficio                      NUMBER(4) NOT NULL,
    no_local_licitacao             VARCHAR2(80),
    end_local_licitacao            VARCHAR2(100),
    no_cidade_licitacao            VARCHAR2(25),
    horario_venda_manha            VARCHAR2(13),
    horario_venda_tarde            VARCHAR2(13),
    no_local_pagto                 VARCHAR2(240),
    no_local_informacao            VARCHAR2(80),
    tx_informacao                  VARCHAR2(50),
    no_responsavel                 VARCHAR2(60),
    no_arquivo_divulgacao          VARCHAR2(8),
    dt_divulgacao                  DATE,
    in_sicaf                       NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DIVULGACAO_LICITACAO

ALTER TABLE ifrdba2.divulgacao_licitacao
ADD CONSTRAINT dvl_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia, pl_mdl_cd_modalidade, nu_oficio, aa_oficio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.DIVULGACAO_LICITACAO

COMMENT ON TABLE ifrdba2.divulgacao_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.DIVULGACAO_LICITACAO

-- Start of DDL Script for Table IFRDBA2.DOCUMENTO_FISCAL
-- Generated 9-mar-2004 18:54:55 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.documento_fiscal
    (lat_nr_lancamento              NUMBER(38) NOT NULL,
    tdc_tp_documento               NUMBER(2) NOT NULL,
    nr_documento_fiscal            VARCHAR2(10) NOT NULL,
    dt_documento_fiscal            DATE NOT NULL,
    vl_documento_fiscal            NUMBER(15,2) NOT NULL,
    dt_vencimento                  DATE NOT NULL,
    ds_historico                   VARCHAR2(120))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DOCUMENTO_FISCAL

ALTER TABLE ifrdba2.documento_fiscal
ADD CONSTRAINT dfi_pk PRIMARY KEY (lat_nr_lancamento, tdc_tp_documento, 
  nr_documento_fiscal)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.DOCUMENTO_FISCAL

-- Start of DDL Script for Table IFRDBA2.DOCUMENTOS_PROCESSO
-- Generated 9-mar-2004 18:54:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.documentos_processo
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia          NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    sq_documento                   NUMBER(3) NOT NULL,
    dt_producao_documento          DATE,
    no_arquivo_doc_processo        VARCHAR2(16) NOT NULL,
    in_destino                     NUMBER(1),
    tx_observacao                  VARCHAR2(200),
    tdl_cd_documento               NUMBER(3) NOT NULL,
    uor_cd_unid_org_destino        NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.DOCUMENTOS_PROCESSO

ALTER TABLE ifrdba2.documentos_processo
ADD CONSTRAINT dop_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia, pl_mdl_cd_modalidade, sq_documento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.DOCUMENTOS_PROCESSO

COMMENT ON TABLE ifrdba2.documentos_processo IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.DOCUMENTOS_PROCESSO

-- Start of DDL Script for Table IFRDBA2.EDITAL_LICITACAO
-- Generated 9-mar-2004 18:55:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.edital_licitacao
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia_detent   NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    tp_cd_padrao                   VARCHAR2(10) NOT NULL,
    dt_licitacao                   DATE,
    hr_licitacao                   VARCHAR2(5),
    no_arquivo_edital              VARCHAR2(16),
    pz_entrega                     NUMBER(5),
    pz_pagamento                   NUMBER(5),
    vl_edital                      NUMBER(13,2),
    no_arquivo_minuta              VARCHAR2(16) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.EDITAL_LICITACAO

CREATE INDEX ifrdba2.el_tp_fk_i ON ifrdba2.edital_licitacao
  (
    tp_cd_padrao                    ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.EDITAL_LICITACAO

ALTER TABLE ifrdba2.edital_licitacao
ADD CONSTRAINT el_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.EDITAL_LICITACAO

COMMENT ON TABLE ifrdba2.edital_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.EDITAL_LICITACAO

-- Start of DDL Script for Table IFRDBA2.EMAIL_PESSOAL_INFRAERO
-- Generated 9-mar-2004 18:55:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.email_pessoal_infraero
    (num_identificacao              NUMBER(10),
    email                          VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.EMAIL_PESSOAL_INFRAERO

-- Start of DDL Script for Table IFRDBA2.ENTRADA_ESTOQUE
-- Generated 9-mar-2004 18:55:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.entrada_estoque
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    aa_entrada                     NUMBER(4) NOT NULL,
    nr_entrada                     NUMBER(5) NOT NULL,
    dt_entrada                     DATE NOT NULL,
    nm_cd_natureza                 CHAR(4) NOT NULL,
    in_sms_sod                     NUMBER(1),
    in_estorno                     NUMBER(1),
    moe_cd_moeda                   NUMBER(3),
    ti_dep_cd_dependencia          NUMBER(4),
    ti_aa_solicitacao              NUMBER(4),
    sms_aa_sms                     NUMBER(4),
    sms_dep_cd_dependencia         NUMBER(4),
    cc_cd_centro_custo             NUMBER(5),
    ti_nr_solicitacao              NUMBER(6),
    sms_nr_sms                     NUMBER(8),
    uo_cd_unid_organ               NUMBER(9),
    dt_documento                   DATE,
    cd_aplicacao                   VARCHAR2(3),
    for_nr_cgc_cpf                 VARCHAR2(14),
    ds_usuario                     VARCHAR2(50),
    nr_documento                   VARCHAR2(50),
    ds_origem                      VARCHAR2(60),
    ds_observacao                  VARCHAR2(500),
    dt_estorno                     DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ENTRADA_ESTOQUE

ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_pk PRIMARY KEY (dep_cd_dependencia, aa_entrada, nr_entrada)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ENTRADA_ESTOQUE

-- Start of DDL Script for Table IFRDBA2.ESPECIE_TITULO
-- Generated 9-mar-2004 18:55:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.especie_titulo
    (cd_especie_titulo              VARCHAR2(3) NOT NULL,
    no_especie_titulo              VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ESPECIE_TITULO

ALTER TABLE ifrdba2.especie_titulo
ADD CONSTRAINT eti_pk PRIMARY KEY (cd_especie_titulo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ESPECIE_TITULO

-- Start of DDL Script for Table IFRDBA2.ESTADO_CONSERVACAO
-- Generated 9-mar-2004 18:55:18 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.estado_conservacao
    (cd_estado                      NUMBER(2) NOT NULL,
    ds_estado                      VARCHAR2(30) NOT NULL,
    pc_depreciacao                 NUMBER(5,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ESTADO_CONSERVACAO

ALTER TABLE ifrdba2.estado_conservacao
ADD CONSTRAINT ec_pk PRIMARY KEY (cd_estado)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ESTADO_CONSERVACAO

-- Start of DDL Script for Table IFRDBA2.ESTRUTURA_CONSOLIDACAO_INFO
-- Generated 9-mar-2004 18:55:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.estrutura_consolidacao_info
    (cd_estrutura                   NUMBER(3) NOT NULL,
    no_estrutura                   VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ESTRUTURA_CONSOLIDACAO_INFO

ALTER TABLE ifrdba2.estrutura_consolidacao_info
ADD CONSTRAINT eci_pk PRIMARY KEY (cd_estrutura)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ESTRUTURA_CONSOLIDACAO_INFO

-- Start of DDL Script for Table IFRDBA2.ESTRUTURA_MARGEM_OPERACIONAL
-- Generated 9-mar-2004 18:55:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.estrutura_margem_operacional
    (nro_conta_contabil             VARCHAR2(20) NOT NULL,
    cod_agrupamento                NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ESTRUTURA_MARGEM_OPERACIONAL

CREATE INDEX ifrdba2.e_m_o_codagrup_idx ON ifrdba2.estrutura_margem_operacional
  (
    cod_agrupamento                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ESTRUTURA_MARGEM_OPERACIONAL

ALTER TABLE ifrdba2.estrutura_margem_operacional
ADD CONSTRAINT emo_pk PRIMARY KEY (nro_conta_contabil)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ESTRUTURA_MARGEM_OPERACIONAL

-- Start of DDL Script for Table IFRDBA2.ESTRUTURA_RECEITA
-- Generated 9-mar-2004 18:55:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.estrutura_receita
    (nro_conta_contabil             VARCHAR2(20) NOT NULL,
    cod_agrupamento                NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ESTRUTURA_RECEITA

ALTER TABLE ifrdba2.estrutura_receita
ADD CONSTRAINT pk_estrut_rec PRIMARY KEY (nro_conta_contabil, cod_agrupamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ESTRUTURA_RECEITA

-- Start of DDL Script for Table IFRDBA2.EVENTO_CONTABIL
-- Generated 9-mar-2004 18:55:33 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.evento_contabil
    (nr_evento                      NUMBER(5) NOT NULL,
    ds_evento                      VARCHAR2(50) NOT NULL,
    tp_evento                      NUMBER(2) NOT NULL,
    nr_sd_padrao                   VARCHAR2(20),
    nr_sc_padrao                   VARCHAR2(20),
    nr_sd_passagem                 VARCHAR2(20),
    nr_sc_passagem                 VARCHAR2(20),
    nr_sd_corresp                  VARCHAR2(20),
    nr_sc_corresp                  VARCHAR2(20),
    nr_dd_padrao                   VARCHAR2(20),
    nr_dc_padrao                   VARCHAR2(20),
    nr_dd_passagem                 VARCHAR2(20),
    nr_dc_passagem                 VARCHAR2(20),
    nr_dd_corresp                  VARCHAR2(20),
    nr_dc_corresp                  VARCHAR2(20),
    in_apropriacao                 CHAR(1),
    mev_cd_modelo                  NUMBER(3) NOT NULL,
    flg_filtro                     CHAR(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.EVENTO_CONTABIL

CREATE INDEX ifrdba2.evc_mev_fk_i ON ifrdba2.evento_contabil
  (
    mev_cd_modelo                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.evc_tev_fk_i ON ifrdba2.evento_contabil
  (
    tp_evento                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.EVENTO_CONTABIL

ALTER TABLE ifrdba2.evento_contabil
ADD CONSTRAINT evc_filtro_ck CHECK (FLG_FILTRO IN ('C','O'))
/
ALTER TABLE ifrdba2.evento_contabil
ADD CONSTRAINT evc_pk PRIMARY KEY (nr_evento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.EVENTO_CONTABIL

-- Start of DDL Script for Table IFRDBA2.EVENTO_DO_PROCESSO
-- Generated 9-mar-2004 18:55:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.evento_do_processo
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia          NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    ppr_cd_evento                  VARCHAR2(6) NOT NULL,
    dt_prazo                       DATE,
    sg_destino                     VARCHAR2(10),
    dt_conclusao                   DATE,
    tx_historico                   VARCHAR2(2000),
    in_est_concluido               VARCHAR2(1),
    ppro_tp_avaliacao_licitacao    NUMBER(2) NOT NULL,
    sq_evento                      NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.EVENTO_DO_PROCESSO

ALTER TABLE ifrdba2.evento_do_processo
ADD CONSTRAINT evp_pk PRIMARY KEY (ppr_cd_evento, pl_mdl_cd_modalidade, 
  pl_dep_cd_dependencia, pl_sq_processo, pl_aa_processo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.EVENTO_DO_PROCESSO

COMMENT ON TABLE ifrdba2.evento_do_processo IS 'Cronograma e histórico do processo- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.EVENTO_DO_PROCESSO

-- Start of DDL Script for Table IFRDBA2.EVENTO_GESTOR
-- Generated 9-mar-2004 18:55:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.evento_gestor
    (evc_nr_evento                  NUMBER(3) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.EVENTO_GESTOR

ALTER TABLE ifrdba2.evento_gestor
ADD CONSTRAINT evg_pk PRIMARY KEY (evc_nr_evento, cc2_cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.EVENTO_GESTOR

-- Start of DDL Script for Table IFRDBA2.EVENTO_LICITATORIO
-- Generated 9-mar-2004 18:55:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.evento_licitatorio
    (cd_evento                      VARCHAR2(6) NOT NULL,
    ds_evento                      VARCHAR2(60) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.EVENTO_LICITATORIO

ALTER TABLE ifrdba2.evento_licitatorio
ADD CONSTRAINT evl_pk PRIMARY KEY (cd_evento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.EVENTO_LICITATORIO

COMMENT ON TABLE ifrdba2.evento_licitatorio IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.EVENTO_LICITATORIO

-- Start of DDL Script for Table IFRDBA2.EXCLUSAO_BEM_PATRIMONIAL
-- Generated 9-mar-2004 18:55:52 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.exclusao_bem_patrimonial
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    dt_exclusao                    DATE NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    cp_nr_conta                    NUMBER(5) NOT NULL,
    no_usuario                     VARCHAR2(30) NOT NULL,
    in_exclusao_efetivada          NUMBER(1),
    vl_orig_moeda_nac              NUMBER(17,2),
    vl_orig_moeda_rel              NUMBER(17,4),
    vl_cm_bem_mo                   NUMBER(17,2),
    vl_dp_acum_mo                  NUMBER(17,2),
    vl_dp_acum_mr                  NUMBER(17,4),
    vl_cm_dp_acum_mo               NUMBER(17,2),
    ds_motivo_exclusao             VARCHAR2(100),
    dt_imobilizacao                DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.EXCLUSAO_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.exclusao_bem_patrimonial
ADD CONSTRAINT ebp_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, dt_exclusao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.EXCLUSAO_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.FABRICANTE
-- Generated 9-mar-2004 18:55:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fabricante
    (cd_fabricante                  NUMBER(4) NOT NULL,
    ds_fabricante                  VARCHAR2(70) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FABRICANTE

ALTER TABLE ifrdba2.fabricante
ADD CONSTRAINT fab_pk PRIMARY KEY (cd_fabricante, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.FABRICANTE

COMMENT ON TABLE ifrdba2.fabricante IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.FABRICANTE

-- Start of DDL Script for Table IFRDBA2.FATOR_PREVISAO
-- Generated 9-mar-2004 18:56:00 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fator_previsao
    (ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    qt_estoque_maximo              NUMBER(12,2) NOT NULL,
    qt_estoque_seguranca           NUMBER(12,2) NOT NULL,
    qt_lote_compra                 NUMBER(12,2) NOT NULL,
    qt_ponto_reposicao             NUMBER(12,2) NOT NULL,
    qt_tempo_ressuprimento         NUMBER(5) NOT NULL,
    in_critico_iso                 NUMBER(1),
    ano_calculo                    NUMBER(4) NOT NULL,
    mes_calculo                    NUMBER(2) NOT NULL,
    dt_calculo                     DATE,
    qt_demanda                     NUMBER(12,2) NOT NULL,
    vl_demanda                     NUMBER(17,5) NOT NULL,
    moe_cd_moeda                   NUMBER(3) NOT NULL,
    qt_cmm                         NUMBER(12,2) NOT NULL,
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FATOR_PREVISAO

ALTER TABLE ifrdba2.fator_previsao
ADD CONSTRAINT fp_pk PRIMARY KEY (ipd_dep_cd_dependencia, ipd_ig_ci_cd_classe, 
  ipd_ig_cd_item, ano_calculo, mes_calculo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.FATOR_PREVISAO

COMMENT ON TABLE ifrdba2.fator_previsao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.FATOR_PREVISAO

-- Start of DDL Script for Table IFRDBA2.FERIADO
-- Generated 9-mar-2004 18:56:04 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.feriado
    (dt_feriado                     DATE NOT NULL,
    no_feriado                     VARCHAR2(35),
    st_feriado                     VARCHAR2(1) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.FERIADO

CREATE INDEX ifrdba2.fer_dep_fk_i ON ifrdba2.feriado
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.FERIADO

ALTER TABLE ifrdba2.feriado
ADD CONSTRAINT fer_pk PRIMARY KEY (dt_feriado, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.feriado
ADD CHECK ( DT_FERIADO IS NOT NULL                                                           )
/
ALTER TABLE ifrdba2.feriado
ADD CHECK ( ST_FERIADO IS NOT NULL                                                           )
/
ALTER TABLE ifrdba2.feriado
ADD CHECK ( DEP_CD_DEPENDENCIA IS NOT NULL                                                   )
/

-- End of DDL Script for Table IFRDBA2.FERIADO

-- Start of DDL Script for Table IFRDBA2.FLUXO_CAIXA
-- Generated 9-mar-2004 18:56:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fluxo_caixa
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    tdr_cd_despesa_receita         VARCHAR2(5) NOT NULL,
    dt_referencia                  DATE NOT NULL,
    vl_disp_atual                  NUMBER(14,2),
    vl_disp_desejavel              NUMBER(14,2),
    vl_disp_orc                    NUMBER(14,2),
    vl_disp_orc_desejavel          NUMBER(14,2),
    vl_orcado                      NUMBER(14,2),
    vl_realizado                   NUMBER(14,2),
    vl_disp_atual_tes              NUMBER(14,2),
    vl_disp_atual_bco              NUMBER(14,2),
    vl_disp_atual_apl              NUMBER(14,2),
    vl_disp_atual_ffc              NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FLUXO_CAIXA

ALTER TABLE ifrdba2.fluxo_caixa
ADD CONSTRAINT flx_pk PRIMARY KEY (dep_cd_dependencia, dt_referencia, 
  tdr_cd_despesa_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.FLUXO_CAIXA

-- Start of DDL Script for Table IFRDBA2.FLUXO_CAIXA_TEMP
-- Generated 9-mar-2004 18:56:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fluxo_caixa_temp
    (dt_fluxo                       DATE,
    tdr_fluxo                      VARCHAR2(5),
    vl_realizado                   NUMBER(14,2),
    vl_orcado                      NUMBER(14,2),
    vl_media                       NUMBER(14,2),
    in_ent_sai                     VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FLUXO_CAIXA_TEMP

ALTER TABLE ifrdba2.fluxo_caixa_temp
ADD CONSTRAINT fct_ck_1 CHECK (       IN_ENT_SAI IN ('S','E')       )
/

-- End of DDL Script for Table IFRDBA2.FLUXO_CAIXA_TEMP

-- Start of DDL Script for Table IFRDBA2.FORMA_AQUISICAO
-- Generated 9-mar-2004 18:56:17 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.forma_aquisicao
    (cd_forma                       NUMBER(2) NOT NULL,
    no_forma                       VARCHAR2(20) NOT NULL,
    cc1_nr_conta_infraero          VARCHAR2(20),
    cc1_nr_conta_uniao             VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FORMA_AQUISICAO

ALTER TABLE ifrdba2.forma_aquisicao
ADD CONSTRAINT fc_pk PRIMARY KEY (cd_forma)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.FORMA_AQUISICAO

-- Start of DDL Script for Table IFRDBA2.FORMA_DE_PAGAMENTO
-- Generated 9-mar-2004 18:56:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.forma_de_pagamento
    (cd_forma_pgto                  VARCHAR2(2) NOT NULL,
    ds_forma_pgto                  VARCHAR2(35),
    ds_abreviacao                  VARCHAR2(10),
    dfg_cd_demonstra_forma         VARCHAR2(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.FORMA_DE_PAGAMENTO

ALTER TABLE ifrdba2.forma_de_pagamento
ADD CONSTRAINT fpg_pk PRIMARY KEY (cd_forma_pgto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.FORMA_DE_PAGAMENTO

-- Start of DDL Script for Table IFRDBA2.FORNECEDOR
-- Generated 9-mar-2004 18:56:25 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fornecedor
    (nr_cgc_cpf                     VARCHAR2(14) NOT NULL,
    tp_pessoa                      NUMBER(1) NOT NULL,
    no_fornecedor                  VARCHAR2(60) NOT NULL,
    dt_cadastro                    DATE NOT NULL,
    no_razao_social                VARCHAR2(60),
    ds_endereco                    VARCHAR2(120),
    ds_bairro                      VARCHAR2(30),
    ds_cidade                      VARCHAR2(30),
    sg_uf                          VARCHAR2(2),
    ds_pais                        VARCHAR2(30),
    nr_cep                         NUMBER(8),
    in_estrangeiro                 NUMBER(1),
    nr_ddd1                        VARCHAR2(4),
    nr_telefone1                   VARCHAR2(10),
    nr_ramal1                      VARCHAR2(4),
    nr_ddd2                        VARCHAR2(4),
    nr_telefone2                   VARCHAR2(10),
    nr_ramal2                      VARCHAR2(4),
    nr_fax                         VARCHAR2(50),
    no_contato                     VARCHAR2(80),
    nr_registro_comercial          VARCHAR2(50),
    vl_pontuacao                   NUMBER(3),
    moe_cd_moeda                   NUMBER(3),
    pf_nr_carteira_id              VARCHAR2(15),
    pf_dt_emissao_da_car           DATE,
    pf_no_orgao_emissor            VARCHAR2(15),
    pf_uf_orgao_emissao            VARCHAR2(2),
    pf_nr_registro_conselho        VARCHAR2(10),
    pf_sg_conselho                 VARCHAR2(10),
    pj_cd_cff                      VARCHAR2(10),
    pj_in_solvencia                NUMBER(1),
    pj_nr_insc_est                 VARCHAR2(15),
    pj_nr_insc_mun                 VARCHAR2(15),
    pj_vl_capital_social           NUMBER(13,2),
    pj_ma_exerc_cap_social         NUMBER(6),
    in_fabricante                  NUMBER(1),
    in_impedimento                 NUMBER(1),
    dep_cd_dependencia_impedimento NUMBER(4),
    for_nr_cgc_cpf_matriz          VARCHAR2(14),
    ds_observacao                  VARCHAR2(500),
    no_email                       VARCHAR2(80),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.FORNECEDOR

CREATE INDEX ifrdba2.for_dep_fk_i ON ifrdba2.fornecedor
  (
    dep_cd_dependencia_impedimento  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.for_for_fk_i ON ifrdba2.fornecedor
  (
    for_nr_cgc_cpf_matriz           ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.for_moe_fk_i ON ifrdba2.fornecedor
  (
    moe_cd_moeda                    ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.FORNECEDOR

ALTER TABLE ifrdba2.fornecedor
ADD CONSTRAINT for_pk PRIMARY KEY (nr_cgc_cpf)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.FORNECEDOR

COMMENT ON TABLE ifrdba2.fornecedor IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.FORNECEDOR

-- Start of DDL Script for Table IFRDBA2.FORNECEDOR_DEPENDENCIA
-- Generated 9-mar-2004 18:56:33 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.fornecedor_dependencia
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    for_nr_cgc_cpf                 VARCHAR2(14) NOT NULL,
    dep_cd_dependencia_cn          NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.FORNECEDOR_DEPENDENCIA

CREATE INDEX ifrdba2.ford_dep2_fk_i ON ifrdba2.fornecedor_dependencia
  (
    dep_cd_dependencia_cn           ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ford_for_fk_i ON ifrdba2.fornecedor_dependencia
  (
    for_nr_cgc_cpf                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.FORNECEDOR_DEPENDENCIA

ALTER TABLE ifrdba2.fornecedor_dependencia
ADD CONSTRAINT ford_pk PRIMARY KEY (dep_cd_dependencia, for_nr_cgc_cpf)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.FORNECEDOR_DEPENDENCIA

COMMENT ON TABLE ifrdba2.fornecedor_dependencia IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.FORNECEDOR_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.GRUPO_PATRIMONIAL
-- Generated 9-mar-2004 18:56:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.grupo_patrimonial
    (cd_grupo                       NUMBER(4) NOT NULL,
    ds_grupo                       VARCHAR2(40) NOT NULL,
    cp_nr_conta                    NUMBER(5) NOT NULL,
    in_inativo                     NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.GRUPO_PATRIMONIAL

ALTER TABLE ifrdba2.grupo_patrimonial
ADD CONSTRAINT gp_pk PRIMARY KEY (cd_grupo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.GRUPO_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.HIST_CANCEL_LANCTES
-- Generated 9-mar-2004 18:56:45 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hist_cancel_lanctes
    (lat_nr_lancamento              NUMBER(38) NOT NULL,
    dt_cancel_obch                 DATE NOT NULL,
    lat_dt_efetivacao              DATE NOT NULL,
    pag_nr_opb                     NUMBER(7),
    pag_nr_opb2                    NUMBER(7),
    cd_usuario                     VARCHAR2(10) NOT NULL,
    ds_motivo                      VARCHAR2(120) NOT NULL,
    dfi_nr_cheque                  VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HIST_CANCEL_LANCTES

ALTER TABLE ifrdba2.hist_cancel_lanctes
ADD CONSTRAINT hcl_pk PRIMARY KEY (lat_nr_lancamento, dt_cancel_obch)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HIST_CANCEL_LANCTES

-- Start of DDL Script for Table IFRDBA2.HISTORICO_CENTRO_CUSTOS
-- Generated 9-mar-2004 18:56:49 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.historico_centro_custos
    (hcc_emp_numero_matricula       NUMBER(7) NOT NULL,
    hcc_cct_codigo                 NUMBER(10),
    hcc_data                       DATE NOT NULL,
    hcc_observacao                 VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HISTORICO_CENTRO_CUSTOS

ALTER TABLE ifrdba2.historico_centro_custos
ADD CONSTRAINT hcc_pk PRIMARY KEY (hcc_emp_numero_matricula, hcc_data)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.HISTORICO_CENTRO_CUSTOS

COMMENT ON TABLE ifrdba2.historico_centro_custos IS '- Retrofitted'
/
COMMENT ON COLUMN ifrdba2.historico_centro_custos.hcc_cct_codigo IS 'Codigo de Centro de Custo'
/
COMMENT ON COLUMN ifrdba2.historico_centro_custos.hcc_data IS 'Data de Alteração de Centro de Custo'
/
COMMENT ON COLUMN ifrdba2.historico_centro_custos.hcc_emp_numero_matricula IS 'Numero de Matricula'
/
COMMENT ON COLUMN ifrdba2.historico_centro_custos.hcc_observacao IS 'Observações'
/

-- End of DDL Script for Table IFRDBA2.HISTORICO_CENTRO_CUSTOS

-- Start of DDL Script for Table IFRDBA2.HISTORICO_DEPENDENCIAS
-- Generated 9-mar-2004 18:56:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.historico_dependencias
    (hde_dep_codigo                 NUMBER(4) NOT NULL,
    hde_data_criacao               DATE NOT NULL,
    hde_tipo                       NUMBER(2) NOT NULL,
    hde_nome                       VARCHAR2(60) NOT NULL,
    hde_sigla                      VARCHAR2(10) NOT NULL,
    hde_aeo_codigo_icao            DATE,
    hde_endereco_logradouro        VARCHAR2(50),
    hde_endereco_bairro            VARCHAR2(30),
    hde_endereco_municipio         VARCHAR2(30),
    hde_ufe_sigla                  VARCHAR2(2),
    hde_endereco_cep               NUMBER(8),
    hde_numero_telefone_1          NUMBER(11),
    hde_numero_telefone_2          NUMBER(11),
    hde_numero_fax                 NUMBER(11),
    hde_numero_cgc                 NUMBER(14),
    hde_aba_ban_codigo             NUMBER(3),
    hde_aba_codigo                 NUMBER(7),
    hde_hde_dep_codigo             NUMBER(4),
    hde_in_categoria_aeroporto     VARCHAR2(3),
    hde_ds_documento_criacao       VARCHAR2(50),
    hde_data_extincao              DATE,
    hde_ds_documento_extincao      VARCHAR2(50),
    hde_msg_cntchque               VARCHAR2(180),
    hde_dep_codigo_vincula_pgto    NUMBER(4),
    hde_numero_ugd                 VARCHAR2(4),
    hde_mun_codigo                 NUMBER(5),
    hde_grupos_dependencias        NUMBER(2),
    hde_adm_material               NUMBER(4),
    hde_in_opb_automatica          VARCHAR2(1),
    hde_sigla_anterior             VARCHAR2(10),
    hde_ind_recolh_sal_educacao    VARCHAR2(1),
    hde_ind_orcamento              VARCHAR2(1),
    hde_comar                      VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HISTORICO_DEPENDENCIAS

ALTER TABLE ifrdba2.historico_dependencias
ADD CONSTRAINT hde_pk PRIMARY KEY (hde_dep_codigo, hde_data_criacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.HISTORICO_DEPENDENCIAS

COMMENT ON TABLE ifrdba2.historico_dependencias IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.HISTORICO_DEPENDENCIAS

-- Start of DDL Script for Table IFRDBA2.HISTORICO_FORNECEDOR
-- Generated 9-mar-2004 18:56:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.historico_fornecedor
    (for_nr_cgc_cpf                 VARCHAR2(14) NOT NULL,
    cd_historico                   NUMBER(4) NOT NULL,
    pnl_cd_penalidade              NUMBER(2),
    at_administrativo              VARCHAR2(25),
    nt_publicacao                  VARCHAR2(100),
    dt_inicial                     DATE,
    dt_final                       DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HISTORICO_FORNECEDOR

ALTER TABLE ifrdba2.historico_fornecedor
ADD CONSTRAINT tab_hf_pk PRIMARY KEY (for_nr_cgc_cpf, cd_historico)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HISTORICO_FORNECEDOR

-- Start of DDL Script for Table IFRDBA2.HISTORICO_HORA_LIMITE_SP
-- Generated 9-mar-2004 18:57:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.historico_hora_limite_sp
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    dt_inicial                     DATE NOT NULL,
    dt_final                       DATE NOT NULL,
    cd_usuario                     VARCHAR2(10) NOT NULL,
    ds_motivo                      VARCHAR2(80) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HISTORICO_HORA_LIMITE_SP

ALTER TABLE ifrdba2.historico_hora_limite_sp
ADD CONSTRAINT hhl_pk PRIMARY KEY (dep_cd_dependencia, cc2_cd_centro_custo, 
  dt_inicial, dt_final)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HISTORICO_HORA_LIMITE_SP

-- Start of DDL Script for Table IFRDBA2.HISTORICO_UNID_ORGANIZ
-- Generated 9-mar-2004 18:57:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.historico_unid_organiz
    (huo_uor_codigo                 NUMBER(9) NOT NULL,
    huo_data_criacao               DATE NOT NULL,
    huo_nome                       VARCHAR2(60) NOT NULL,
    huo_sigla                      VARCHAR2(10) NOT NULL,
    huo_codigo_lotacao_anterior    NUMBER(9),
    huo_dep_codigo                 NUMBER(4) NOT NULL,
    huo_huo_uor_codigo             NUMBER(9),
    huo_sequencia_estrutura        VARCHAR2(10) NOT NULL,
    huo_ds_documento_criacao       VARCHAR2(50),
    huo_data_extincao              DATE,
    huo_ds_documento_extincao      VARCHAR2(50),
    huo_dep_codigo_vincula_pgto    NUMBER(4),
    huo_nome_abreviado             VARCHAR2(40),
    huo_tipo_unidad_org            NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HISTORICO_UNID_ORGANIZ

ALTER TABLE ifrdba2.historico_unid_organiz
ADD CONSTRAINT huo_pk PRIMARY KEY (huo_uor_codigo, huo_data_criacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.HISTORICO_UNID_ORGANIZ

COMMENT ON TABLE ifrdba2.historico_unid_organiz IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.HISTORICO_UNID_ORGANIZ

-- Start of DDL Script for Table IFRDBA2.HORA_LIMITE_SP
-- Generated 9-mar-2004 18:57:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hora_limite_sp
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    hr_limite_sp                   DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HORA_LIMITE_SP

ALTER TABLE ifrdba2.hora_limite_sp
ADD CONSTRAINT hls_pk PRIMARY KEY (dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HORA_LIMITE_SP

-- Start of DDL Script for Table IFRDBA2.HST_ACESS_SIMBEP
-- Generated 9-mar-2004 18:57:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hst_acess_simbep
    (oper_cracha_pk                 VARCHAR2(20) NOT NULL,
    logac_dthron                   DATE NOT NULL,
    area_cod_pk                    NUMBER(6),
    palm_serie_pk                  VARCHAR2(30),
    logac_dthroff                  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HST_ACESS_SIMBEP

ALTER TABLE ifrdba2.hst_acess_simbep
ADD CONSTRAINT pk_hacess_simbep PRIMARY KEY (oper_cracha_pk, logac_dthron)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HST_ACESS_SIMBEP

-- Start of DDL Script for Table IFRDBA2.HST_EQTER_SIMBEP
-- Generated 9-mar-2004 18:57:19 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hst_eqter_simbep
    (heqt_cod_pk                    VARCHAR2(20) NOT NULL,
    heqt_usu                       VARCHAR2(20),
    heqt_dthrent                   DATE NOT NULL,
    heqt_dthrsai                   DATE,
    heqt_forn                      NUMBER(6),
    heqt_nf                        VARCHAR2(10),
    heqt_cracha                    VARCHAR2(20),
    heqt_dsc                       VARCHAR2(150),
    heqt_numserie                  VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HST_EQTER_SIMBEP

ALTER TABLE ifrdba2.hst_eqter_simbep
ADD CONSTRAINT pk_heqt_simbep PRIMARY KEY (heqt_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.HST_EQTER_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_hst_eqter_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.hst_eqter_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_HST_EQTER_SIMBEP (
HEQT_COD_PK
,HEQT_USU
,HEQT_DTHRENT
,HEQT_DTHRSAI
,HEQT_FORN
,HEQT_NF
,HEQT_CRACHA
,HEQT_DSC
,HEQT_NUMSERIE
,tp_geracao
,quem_gerou
)
values (
:new.HEQT_COD_PK
,:new.HEQT_USU
,:new.HEQT_DTHRENT
,:new.HEQT_DTHRSAI
,:new.HEQT_FORN
,:new.HEQT_NF
,:new.HEQT_CRACHA
,:new.HEQT_DSC
,:new.HEQT_NUMSERIE
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_HST_EQTER_SIMBEP (
HEQT_COD_PK
,HEQT_USU
,HEQT_DTHRENT
,HEQT_DTHRSAI
,HEQT_FORN
,HEQT_NF
,HEQT_CRACHA
,HEQT_DSC
,HEQT_NUMSERIE
,tp_geracao
,quem_gerou
)
values (
:old.HEQT_COD_PK
,:old.HEQT_USU
,:old.HEQT_DTHRENT
,:old.HEQT_DTHRSAI
,:old.HEQT_FORN
,:old.HEQT_NF
,:old.HEQT_CRACHA
,:old.HEQT_DSC
,:old.HEQT_NUMSERIE
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_HST_EQTER_SIMBEP (
HEQT_COD_PK
,HEQT_USU
,HEQT_DTHRENT
,HEQT_DTHRSAI
,HEQT_FORN
,HEQT_NF
,HEQT_CRACHA
,HEQT_DSC
,HEQT_NUMSERIE
,tp_geracao
,quem_gerou
)
values (
:old.HEQT_COD_PK
,:old.HEQT_USU
,:old.HEQT_DTHRENT
,:old.HEQT_DTHRSAI
,:old.HEQT_FORN
,:old.HEQT_NF
,:old.HEQT_CRACHA
,:old.HEQT_DSC
,:old.HEQT_NUMSERIE
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.HST_EQTER_SIMBEP

-- Start of DDL Script for Table IFRDBA2.HST_FORNE_SIMBEP
-- Generated 9-mar-2004 18:57:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hst_forne_simbep
    (hforn_cod_pk                   NUMBER(6) NOT NULL,
    hforn_cgc                      VARCHAR2(20) NOT NULL,
    hforn_nom                      VARCHAR2(50) NOT NULL,
    hdata_exclusao                 DATE NOT NULL,
    hforn_cep                      VARCHAR2(9),
    hforn_est                      VARCHAR2(2),
    hforn_tel                      VARCHAR2(20),
    hforn_cid                      VARCHAR2(50),
    hforn_end                      VARCHAR2(50),
    hforn_prodesc                  VARCHAR2(50),
    hforn_email                    VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HST_FORNE_SIMBEP

ALTER TABLE ifrdba2.hst_forne_simbep
ADD CONSTRAINT pk_hforne_simbep PRIMARY KEY (hforn_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.HST_FORNE_SIMBEP

-- Start of DDL Script for Table IFRDBA2.HST_RECEX_SIMBEP
-- Generated 9-mar-2004 18:57:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hst_recex_simbep
    (hext_cracha                    VARCHAR2(20) NOT NULL,
    hext_matr                      NUMBER(7) NOT NULL,
    hext_est                       VARCHAR2(2) NOT NULL,
    hext_cid                       VARCHAR2(30) NOT NULL,
    hext_cep                       VARCHAR2(9) NOT NULL,
    hext_rg                        VARCHAR2(20) NOT NULL,
    hext_end                       VARCHAR2(50) NOT NULL,
    hext_nom                       VARCHAR2(50) NOT NULL,
    hext_tel                       VARCHAR2(20),
    hext_email                     VARCHAR2(50),
    hext_dtexcl                    DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HST_RECEX_SIMBEP

ALTER TABLE ifrdba2.hst_recex_simbep
ADD CONSTRAINT pk_hstrec_simbep PRIMARY KEY (hext_cracha)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.HST_RECEX_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_hst_recex_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.hst_recex_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_HST_RECEX_SIMBEP (
HEXT_CRACHA
,HEXT_MATR
,HEXT_EST
,HEXT_CID
,HEXT_CEP
,HEXT_RG
,HEXT_END
,HEXT_NOM
,HEXT_TEL
,HEXT_EMAIL
,HEXT_DTEXCL
,tp_geracao
,quem_gerou
)
values (
:new.HEXT_CRACHA
,:new.HEXT_MATR
,:new.HEXT_EST
,:new.HEXT_CID
,:new.HEXT_CEP
,:new.HEXT_RG
,:new.HEXT_END
,:new.HEXT_NOM
,:new.HEXT_TEL
,:new.HEXT_EMAIL
,:new.HEXT_DTEXCL
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_HST_RECEX_SIMBEP (
HEXT_CRACHA
,HEXT_MATR
,HEXT_EST
,HEXT_CID
,HEXT_CEP
,HEXT_RG
,HEXT_END
,HEXT_NOM
,HEXT_TEL
,HEXT_EMAIL
,HEXT_DTEXCL
,tp_geracao
,quem_gerou
)
values (
:old.HEXT_CRACHA
,:old.HEXT_MATR
,:old.HEXT_EST
,:old.HEXT_CID
,:old.HEXT_CEP
,:old.HEXT_RG
,:old.HEXT_END
,:old.HEXT_NOM
,:old.HEXT_TEL
,:old.HEXT_EMAIL
,:old.HEXT_DTEXCL
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_HST_RECEX_SIMBEP (
HEXT_CRACHA
,HEXT_MATR
,HEXT_EST
,HEXT_CID
,HEXT_CEP
,HEXT_RG
,HEXT_END
,HEXT_NOM
,HEXT_TEL
,HEXT_EMAIL
,HEXT_DTEXCL
,tp_geracao
,quem_gerou
)
values (
:old.HEXT_CRACHA
,:old.HEXT_MATR
,:old.HEXT_EST
,:old.HEXT_CID
,:old.HEXT_CEP
,:old.HEXT_RG
,:old.HEXT_END
,:old.HEXT_NOM
,:old.HEXT_TEL
,:old.HEXT_EMAIL
,:old.HEXT_DTEXCL
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.HST_RECEX_SIMBEP

-- Start of DDL Script for Table IFRDBA2.HST_VISIT_SIMBEP
-- Generated 9-mar-2004 18:57:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.hst_visit_simbep
    (hvis_cracha_pk                 VARCHAR2(20) NOT NULL,
    hvis_seq_pk                    NUMBER(6) NOT NULL,
    hvis_dthrentra                 DATE NOT NULL,
    hvis_dthrsaida                 DATE NOT NULL,
    hvis_forn                      NUMBER(6),
    hvis_rg                        VARCHAR2(15),
    hvis_cpf                       VARCHAR2(15),
    hvis_doc                       VARCHAR2(30),
    hvis_cod                       NUMBER(7) NOT NULL,
    hvis_nome                      VARCHAR2(50) NOT NULL,
    hvis_usu                       VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.HST_VISIT_SIMBEP

ALTER TABLE ifrdba2.hst_visit_simbep
ADD CONSTRAINT pk_hvis_simbep PRIMARY KEY (hvis_cracha_pk, hvis_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.HST_VISIT_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_hst_visit_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.hst_visit_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_HST_VISIT_SIMBEP (
HVIS_CRACHA_PK
,HVIS_SEQ_PK
,HVIS_DTHRENTRA
,HVIS_DTHRSAIDA
,HVIS_FORN
,HVIS_RG
,HVIS_CPF
,HVIS_DOC
,HVIS_COD
,HVIS_NOME
,HVIS_USU
,tp_geracao
,quem_gerou
)
values (
:new.HVIS_CRACHA_PK
,:new.HVIS_SEQ_PK
,:new.HVIS_DTHRENTRA
,:new.HVIS_DTHRSAIDA
,:new.HVIS_FORN
,:new.HVIS_RG
,:new.HVIS_CPF
,:new.HVIS_DOC
,:new.HVIS_COD
,:new.HVIS_NOME
,:new.HVIS_USU
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_HST_VISIT_SIMBEP (
HVIS_CRACHA_PK
,HVIS_SEQ_PK
,HVIS_DTHRENTRA
,HVIS_DTHRSAIDA
,HVIS_FORN
,HVIS_RG
,HVIS_CPF
,HVIS_DOC
,HVIS_COD
,HVIS_NOME
,HVIS_USU
,tp_geracao
,quem_gerou
)
values (
:old.HVIS_CRACHA_PK
,:old.HVIS_SEQ_PK
,:old.HVIS_DTHRENTRA
,:old.HVIS_DTHRSAIDA
,:old.HVIS_FORN
,:old.HVIS_RG
,:old.HVIS_CPF
,:old.HVIS_DOC
,:old.HVIS_COD
,:old.HVIS_NOME
,:old.HVIS_USU
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_HST_VISIT_SIMBEP (
HVIS_CRACHA_PK
,HVIS_SEQ_PK
,HVIS_DTHRENTRA
,HVIS_DTHRSAIDA
,HVIS_FORN
,HVIS_RG
,HVIS_CPF
,HVIS_DOC
,HVIS_COD
,HVIS_NOME
,HVIS_USU
,tp_geracao
,quem_gerou
)
values (
:old.HVIS_CRACHA_PK
,:old.HVIS_SEQ_PK
,:old.HVIS_DTHRENTRA
,:old.HVIS_DTHRSAIDA
,:old.HVIS_FORN
,:old.HVIS_RG
,:old.HVIS_CPF
,:old.HVIS_DOC
,:old.HVIS_COD
,:old.HVIS_NOME
,:old.HVIS_USU
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.HST_VISIT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.IMOB_ANDAMENTO_TRANSF
-- Generated 9-mar-2004 18:57:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.imob_andamento_transf
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    dt_transf                      DATE NOT NULL,
    pc_origem                      NUMBER(5,2) NOT NULL,
    in_efetivacao                  NUMBER(1) NOT NULL,
    no_usuario                     VARCHAR2(30) NOT NULL,
    in_imob_transf                 CHAR(1) NOT NULL,
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.IMOB_ANDAMENTO_TRANSF

ALTER TABLE ifrdba2.imob_andamento_transf
ADD CONSTRAINT iat_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, dt_transf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.IMOB_ANDAMENTO_TRANSF

CREATE TRIGGER ifrdba2.trg_iat01
BEFORE INSERT 
ON ifrdba2.imob_andamento_transf
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
CURSOR pega_bem(NrBem IN NUMBER, InUniao IN NUMBER)
   IS
   -- pega o codigo da dependencia que esta manipulando o
   -- bem patrimonial
   SELECT bp.aat_dep_cd_dependencia
   FROM bem_patrimonial bp
WHERE
   bp.nr_bem = NrBem
   AND bp.in_uniao = InUniao;
CURSOR pega_dep(CdDependencia IN NUMBER)
   IS
   -- obtem o codigo da dependencia a qual esta dependencia
   -- esta subordinada
   SELECT dp.dep_dep_codigo
   FROM dependencias dp
WHERE
   dp.dep_codigo = CdDependencia;
WkCdDep NUMBER;
WkCdCdDep NUMBER;
BEGIN
   OPEN pega_bem(:new.bp_nr_bem, :new.bp_in_uniao);
   FETCH pega_bem INTO WkCdDep;
   -- Obs. via foreign key entre imob_andamento_transf e
   -- bem patrimonial, é garantido que haverá um valor para
   -- o bem patrimonial, portanto, não é necessário a validação
   CLOSE pega_bem;
   OPEN pega_dep(WkCdDep);
   FETCH pega_dep INTO WkCdCdDep;
   -- Obs. via foreign key entre bem_patrimonial e
   -- dependencias, é garantido que haverá um valor para
   -- a dependencia, portanto não é necessário a validação
   CLOSE pega_dep;
   :new.cd_centro_negocio := WkCdCdDep;
   :new.dep_cd_dependencia := WkCdDep;
END;
/

-- End of DDL Script for Table IFRDBA2.IMOB_ANDAMENTO_TRANSF

-- Start of DDL Script for Table IFRDBA2.INCIDENCIA_CENTRO_CUSTO
-- Generated 9-mar-2004 18:57:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.incidencia_centro_custo
    (bp_in_uniao                    NUMBER(1) NOT NULL,
    bp_nr_bem                      NUMBER(7) NOT NULL,
    iccd_cc_cd_centro_custo        NUMBER(5) NOT NULL,
    iccd_dep_cd_dependencia        NUMBER(4) NOT NULL,
    pc_incidencia_custo            NUMBER(5,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INCIDENCIA_CENTRO_CUSTO

ALTER TABLE ifrdba2.incidencia_centro_custo
ADD CONSTRAINT icc_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, 
  iccd_cc_cd_centro_custo, iccd_dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.INCIDENCIA_CENTRO_CUSTO

-- Start of DDL Script for Table IFRDBA2.INCIDENCIA_CENTRO_CUSTO_DEP
-- Generated 9-mar-2004 18:57:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.incidencia_centro_custo_dep
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc_cd_centro_custo             NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INCIDENCIA_CENTRO_CUSTO_DEP

ALTER TABLE ifrdba2.incidencia_centro_custo_dep
ADD CONSTRAINT iccd_pk PRIMARY KEY (cc_cd_centro_custo, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.INCIDENCIA_CENTRO_CUSTO_DEP

-- Start of DDL Script for Table IFRDBA2.INDICES_FIN_VALORES
-- Generated 9-mar-2004 18:57:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.indices_fin_valores
    (cod_indice                     NUMBER(3) NOT NULL,
    dat_cotacao                    DATE NOT NULL,
    val_cotacao                    NUMBER(21,10) NOT NULL,
    dat_prazo                      DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INDICES_FIN_VALORES

ALTER TABLE ifrdba2.indices_fin_valores
ADD CONSTRAINT ifv_cod_pk PRIMARY KEY (cod_indice, dat_cotacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.INDICES_FIN_VALORES

COMMENT ON TABLE ifrdba2.indices_fin_valores IS 'SICOF - Tabela Corporativa '
/

-- End of DDL Script for Table IFRDBA2.INDICES_FIN_VALORES

-- Start of DDL Script for Table IFRDBA2.INDICES_FINANCEIROS
-- Generated 9-mar-2004 18:57:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.indices_financeiros
    (cod_indice                     NUMBER(3) NOT NULL,
    nom_indice                     VARCHAR2(40) NOT NULL,
    sig_indice                     VARCHAR2(10) NOT NULL,
    tip_periodicidade              VARCHAR2(1) NOT NULL,
    nom_fonte_consulta             VARCHAR2(30),
    dat_base                       DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INDICES_FINANCEIROS

ALTER TABLE ifrdba2.indices_financeiros
ADD CONSTRAINT ifi_cod_pk PRIMARY KEY (cod_indice)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.indices_financeiros
ADD CONSTRAINT ifi_per_ck CHECK (TIP_PERIODICIDADE IN ('A','M','D'))
/

-- Comments for IFRDBA2.INDICES_FINANCEIROS

COMMENT ON TABLE ifrdba2.indices_financeiros IS 'SICOF - Tabela Corporativa '
/

-- End of DDL Script for Table IFRDBA2.INDICES_FINANCEIROS

-- Start of DDL Script for Table IFRDBA2.INICIALIZA_FINALIZA_ORC
-- Generated 9-mar-2004 18:57:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.inicializa_finaliza_orc
    (in_inic_final                  CHAR(1) NOT NULL,
    in_ano_mes                     CHAR(1) NOT NULL,
    in_perfil                      VARCHAR2(2) NOT NULL,
    dt_inic_final                  DATE NOT NULL,
    nr_ano_ref                     NUMBER(4) NOT NULL,
    nr_mes_ref                     NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INICIALIZA_FINALIZA_ORC

ALTER TABLE ifrdba2.inicializa_finaliza_orc
ADD CONSTRAINT ifof_ck_1 CHECK (in_inic_final in ('I','F','D','T'))
/
ALTER TABLE ifrdba2.inicializa_finaliza_orc
ADD CONSTRAINT ifof_ck_2 CHECK (in_ano_mes in ('A','M'))
/
ALTER TABLE ifrdba2.inicializa_finaliza_orc
ADD CONSTRAINT ifof_ck_3 CHECK (in_perfil in ('DD','D','G','GG'))
/
ALTER TABLE ifrdba2.inicializa_finaliza_orc
ADD CONSTRAINT ifof_ck_4 CHECK (to_char(dt_inic_final,'hh24miss')='000000')
/
ALTER TABLE ifrdba2.inicializa_finaliza_orc
ADD CONSTRAINT ifof_pk PRIMARY KEY (in_inic_final, in_ano_mes, in_perfil, 
  dt_inic_final)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.INICIALIZA_FINALIZA_ORC

-- Start of DDL Script for Table IFRDBA2.INTERFACE_SPV
-- Generated 9-mar-2004 18:57:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.interface_spv
    (dep_cd_ugd                     VARCHAR2(4) NOT NULL,
    cc2_cd_gnd                     VARCHAR2(2) NOT NULL,
    cc2_cd_cnds                    NUMBER(2) NOT NULL,
    nr_lote_fita                   NUMBER(3) NOT NULL,
    cp_nr_conta                    NUMBER(5) NOT NULL,
    cspv_nr_conta_spv_dp           NUMBER(6),
    cspv_nr_conta_spv_rem          NUMBER(6),
    smbp_vl_dp_mes_mo              NUMBER(17,2),
    vl_rem_bem_mo                  NUMBER(17,2),
    pc_ma_processamento            NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INTERFACE_SPV

ALTER TABLE ifrdba2.interface_spv
ADD CONSTRAINT is_pk PRIMARY KEY (dep_cd_ugd, cc2_cd_gnd, cc2_cd_cnds, 
  nr_lote_fita, cp_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.INTERFACE_SPV

-- Start of DDL Script for Table IFRDBA2.INVENTARIO
-- Generated 9-mar-2004 18:58:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.inventario
    (ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    in_propriedade                 NUMBER(1) NOT NULL,
    qt_estoque_atual               NUMBER(12,2) NOT NULL,
    vl_unitario                    NUMBER(17,5),
    dt_inventario                  DATE NOT NULL,
    aa_inventario                  NUMBER(4),
    mm_inventario                  NUMBER(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.INVENTARIO

ALTER TABLE ifrdba2.inventario
ADD CONSTRAINT inv_pk PRIMARY KEY (ipd_dep_cd_dependencia, ipd_ig_ci_cd_classe, 
  ipd_ig_cd_item, in_propriedade, dt_inventario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.INVENTARIO

-- Start of DDL Script for Table IFRDBA2.ITEM_COMPROMISSO_ORC_TEMP
-- Generated 9-mar-2004 18:58:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_compromisso_orc_temp
    (num_compromisso_temp           NUMBER(6) NOT NULL,
    num_seq_comp_temp              NUMBER(3) NOT NULL,
    num_ano_compromisso            NUMBER(4),
    cod_dependencia_compr          NUMBER(4),
    cod_centro_custo               NUMBER(5),
    num_ano                        NUMBER(4),
    cod_dependencia                NUMBER(4),
    num_item                       NUMBER(5),
    dat_previsao_compromisso       DATE,
    dat_emissao_fedf               DATE,
    qtd_compromisso                NUMBER(6),
    vlr_compromisso                NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_COMPROMISSO_ORC_TEMP

ALTER TABLE ifrdba2.item_compromisso_orc_temp
ADD CONSTRAINT iot_nsq_pk PRIMARY KEY (num_compromisso_temp, num_seq_comp_temp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_COMPROMISSO_ORC_TEMP

-- Start of DDL Script for Table IFRDBA2.ITEM_COMPROMISSO_ORCAMENTARIO
-- Generated 9-mar-2004 18:58:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_compromisso_orcamentario
    (nr_ano_compromisso             NUMBER(4) NOT NULL,
    dep_cd_dependencia_compr       NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_compromisso                 NUMBER(6) NOT NULL,
    nr_seq_comp                    NUMBER(3) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    dt_previsao_compromisso        DATE NOT NULL,
    cc2_cd_centro_custo_2          NUMBER(5),
    dt_emissao_fedf                DATE,
    qt_compromisso                 NUMBER(6),
    vl_compromisso                 NUMBER(14,2),
    nr_ano_pre_compromisso         NUMBER(4),
    dep_cd_dependencia_pcompr      NUMBER(4),
    nr_pre_compromisso             NUMBER(6),
    nr_seq_pcomp                   NUMBER(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_COMPROMISSO_ORCAMENTARIO

ALTER TABLE ifrdba2.item_compromisso_orcamentario
ADD CONSTRAINT ico_pk PRIMARY KEY (nr_ano_compromisso, dep_cd_dependencia_compr, 
  cc2_cd_centro_custo, nr_compromisso, nr_seq_comp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_COMPROMISSO_ORCAMENTARIO

-- Start of DDL Script for Table IFRDBA2.ITEM_DA_TRANSFERENCIA
-- Generated 9-mar-2004 18:58:16 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_da_transferencia
    (ti_dep_cd_dependencia_orig     NUMBER(4) NOT NULL,
    ti_aa_solicitacao              NUMBER(4) NOT NULL,
    ti_nr_solicitacao              NUMBER(6) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    qt_solicitada                  NUMBER(12,2) NOT NULL,
    qt_atendida                    NUMBER(12,2),
    qt_recebida                    NUMBER(12,2),
    vl_unitario                    NUMBER(17,5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_DA_TRANSFERENCIA

ALTER TABLE ifrdba2.item_da_transferencia
ADD CONSTRAINT idt_pk PRIMARY KEY (ti_dep_cd_dependencia_orig, ti_aa_solicitacao, 
  ti_nr_solicitacao, ipd_dep_cd_dependencia, ipd_ig_ci_cd_classe, ipd_ig_cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_DA_TRANSFERENCIA

COMMENT ON TABLE ifrdba2.item_da_transferencia IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_DA_TRANSFERENCIA

-- Start of DDL Script for Table IFRDBA2.ITEM_DO_SISTEMA
-- Generated 9-mar-2004 18:58:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_do_sistema
    (sis_cd_sistema                 NUMBER(5) NOT NULL,
    ig_ci_cd_classe                VARCHAR2(4) NOT NULL,
    ig_cd_item                     VARCHAR2(7) NOT NULL,
    ig_dep_cd_dependencia          NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_DO_SISTEMA

CREATE INDEX ifrdba2.ids_ig_fk ON ifrdba2.item_do_sistema
  (
    ig_dep_cd_dependencia           ASC,
    ig_ci_cd_classe                 ASC,
    ig_cd_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_DO_SISTEMA

ALTER TABLE ifrdba2.item_do_sistema
ADD CONSTRAINT ids_pk PRIMARY KEY (sis_cd_sistema, ig_dep_cd_dependencia, 
  ig_ci_cd_classe, ig_cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_DO_SISTEMA

COMMENT ON TABLE ifrdba2.item_do_sistema IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_DO_SISTEMA

-- Start of DDL Script for Table IFRDBA2.ITEM_ENTRADA_ESTOQUE
-- Generated 9-mar-2004 18:58:26 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_entrada_estoque
    (ee_dep_cd_dependencia          NUMBER(4) NOT NULL,
    ee_aa_entrada                  NUMBER(4) NOT NULL,
    ee_nr_entrada                  NUMBER(5) NOT NULL,
    sq_item                        NUMBER(3) NOT NULL,
    in_propriedade                 NUMBER(1) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    qt_item                        NUMBER(12,2) NOT NULL,
    vl_unitario                    NUMBER(15,5) NOT NULL,
    vl_total                       NUMBER(15,2) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    nr_lote                        NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_ENTRADA_ESTOQUE

CREATE INDEX ifrdba2.item_entrada_estoque_ind1 ON ifrdba2.item_entrada_estoque
  (
    ipd_dep_cd_dependencia          ASC,
    ipd_ig_ci_cd_classe             ASC,
    ipd_ig_cd_item                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_ENTRADA_ESTOQUE

ALTER TABLE ifrdba2.item_entrada_estoque
ADD CONSTRAINT iee_pk PRIMARY KEY (ee_dep_cd_dependencia, ee_aa_entrada, 
  ee_nr_entrada, sq_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_ENTRADA_ESTOQUE

-- Start of DDL Script for Table IFRDBA2.ITEM_GENERICO
-- Generated 9-mar-2004 18:58:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_generico
    (ci_cd_classe                   VARCHAR2(4) NOT NULL,
    cd_item                        VARCHAR2(7) NOT NULL,
    ds_padrao                      VARCHAR2(60) NOT NULL,
    nr_nsn                         VARCHAR2(13),
    in_material_tecnico            NUMBER(1),
    in_compra_centralizada         NUMBER(1),
    st_categoria                   VARCHAR2(1),
    ds_complementar                VARCHAR2(2000),
    tmf_cd_tipo_material_fornecime NUMBER(6),
    ui_cd_unidade_fornece          VARCHAR2(4),
    ui_cd_unidade_estoca           VARCHAR2(4),
    ig_ci_cd_classe                VARCHAR2(4),
    ig_cd_item                     VARCHAR2(7),
    origem_material                CHAR(1),
    am_cd_aquisicao                VARCHAR2(2),
    in_envio                       NUMBER(1),
    in_adequacao                   VARCHAR2(1),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    ig_dep_cd_dependencia          NUMBER(4),
    dep_cd_dep_nacional            NUMBER(4),
    ci_cd_clas_nacional            VARCHAR2(4),
    cd_item_nacional               VARCHAR2(7),
    in_inativo                     NUMBER(1),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_GENERICO

CREATE INDEX ifrdba2.dep_item_generico ON ifrdba2.item_generico
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ig_ig_fk ON ifrdba2.item_generico
  (
    ig_dep_cd_dependencia           ASC,
    ig_ci_cd_classe                 ASC,
    ig_cd_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ig_ig2_fk ON ifrdba2.item_generico
  (
    dep_cd_dep_nacional             ASC,
    ci_cd_clas_nacional             ASC,
    cd_item_nacional                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_GENERICO

ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_ck_02 CHECK (       IN_ADEQUACAO IN ('S','N')       )
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_pk PRIMARY KEY (dep_cd_dependencia, ci_cd_classe, cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_GENERICO

COMMENT ON TABLE ifrdba2.item_generico IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_GENERICO

-- Start of DDL Script for Table IFRDBA2.ITEM_GENERICO_SUBSTITUIDO
-- Generated 9-mar-2004 18:58:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_generico_substituido
    (ig_dep_cd_depend_1             NUMBER(4) NOT NULL,
    ig_ci_cd_classe_1              VARCHAR2(4) NOT NULL,
    ig_cd_item_1                   VARCHAR2(7) NOT NULL,
    ig_dep_cd_depend_2             NUMBER(4) NOT NULL,
    ig_ci_cd_classe_2              VARCHAR2(4) NOT NULL,
    ig_cd_item_2                   VARCHAR2(7) NOT NULL,
    ds_restricao_uso               VARCHAR2(200),
    dt_substituicao                DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_GENERICO_SUBSTITUIDO

ALTER TABLE ifrdba2.item_generico_substituido
ADD CONSTRAINT igs_pk PRIMARY KEY (ig_dep_cd_depend_1, ig_ci_cd_classe_1, 
  ig_cd_item_1, ig_dep_cd_depend_2, ig_ci_cd_classe_2, ig_cd_item_2)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_GENERICO_SUBSTITUIDO

COMMENT ON TABLE ifrdba2.item_generico_substituido IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_GENERICO_SUBSTITUIDO

-- Start of DDL Script for Table IFRDBA2.ITEM_INEDITO
-- Generated 9-mar-2004 18:58:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_inedito
    (os_dep_cd_dependencia          NUMBER(4) NOT NULL,
    os_aa_ordem_servico            NUMBER(4) NOT NULL,
    os_nr_ordem_servico            NUMBER(6) NOT NULL,
    sq_item                        NUMBER(2) NOT NULL,
    ds_item                        VARCHAR2(60) NOT NULL,
    cd_aplicacao                   CHAR(3),
    cd_orcamentario                VARCHAR2(30),
    cd_estocavel                   NUMBER(1),
    qt_prazo_dias                  NUMBER(4),
    qt_aplicar                     NUMBER(12,2),
    qt_estocar                     NUMBER(12,2),
    qt_comprar                     NUMBER(12,2),
    vl_previsto                    NUMBER(17,5),
    ds_complementar                VARCHAR2(2000),
    ui_cd_unidade                  VARCHAR2(4),
    dep_cd_dependencia_compra      NUMBER(4),
    cc1_nr_conta                   VARCHAR2(20),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_centro_custo_gestor         NUMBER(5),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_INEDITO

ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_pk PRIMARY KEY (os_dep_cd_dependencia, os_aa_ordem_servico, 
  os_nr_ordem_servico, sq_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ITEM_INEDITO

CREATE TRIGGER ifrdba2.trg_ii
BEFORE  DELETE 
ON ifrdba2.item_inedito
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  LOG_DS_USUARIO VARCHAR2(50);
 BEGIN
  SELECT USER||' - '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
  INTO LOG_DS_USUARIO
  FROM DUAL;
  INSERT INTO LOG_ITEM_INEDITO
   (OS_DEP_CD_DEPENDENCIA,
    OS_AA_ORDEM_SERVICO,
    OS_NR_ORDEM_SERVICO,
    SQ_ITEM,
    DS_ITEM,
    CD_APLICACAO,
    CD_ORCAMENTARIO,
    CD_ESTOCAVEL,
    QT_PRAZO_DIAS,
    QT_APLICAR,
    QT_ESTOCAR,
    QT_COMPRAR,
    VL_PREVISTO,
    DS_COMPLEMENTAR,
    UI_CD_UNIDADE,
    DEP_CD_DEPENDENCIA_COMPRA,
    CC1_NR_CONTA,
    CD_PROGRAMA,
    CD_PROJETO,
    CD_CENTRO_CUSTO_GESTOR,
    DS_USUARIO)
  VALUES
   (:OLD.OS_DEP_CD_DEPENDENCIA,
    :OLD.OS_AA_ORDEM_SERVICO,
    :OLD.OS_NR_ORDEM_SERVICO,
    :OLD.SQ_ITEM,
    :OLD.DS_ITEM,
    :OLD.CD_APLICACAO,
    :OLD.CD_ORCAMENTARIO,
    :OLD.CD_ESTOCAVEL,
    :OLD.QT_PRAZO_DIAS,
    :OLD.QT_APLICAR,
    :OLD.QT_ESTOCAR,
    :OLD.QT_COMPRAR,
    :OLD.VL_PREVISTO,
    :OLD.DS_COMPLEMENTAR,
    :OLD.UI_CD_UNIDADE,
    :OLD.DEP_CD_DEPENDENCIA_COMPRA,
    :OLD.CC1_NR_CONTA,
    :OLD.CD_PROGRAMA,
    :OLD.CD_PROJETO,
    :OLD.CD_CENTRO_CUSTO_GESTOR,
    LOG_DS_USUARIO);
 END;
/

-- Comments for IFRDBA2.ITEM_INEDITO

COMMENT ON TABLE ifrdba2.item_inedito IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_INEDITO

-- Start of DDL Script for Table IFRDBA2.ITEM_MENSAL_COMPROMISSO_ORC
-- Generated 9-mar-2004 18:58:55 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_mensal_compromisso_orc
    (ico_co_nr_ano                  NUMBER(4) NOT NULL,
    ico_co_dep_cd_dependencia      NUMBER(4) NOT NULL,
    ico_co_nr_compromisso          NUMBER(6) NOT NULL,
    ico_nr_seq_comp                NUMBER(3) NOT NULL,
    mm_compromisso                 NUMBER(2) NOT NULL,
    qt_compromisso                 NUMBER(6),
    vl_compromisso                 NUMBER(14,2) NOT NULL,
    vl_compromisso_dolar           NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_MENSAL_COMPROMISSO_ORC

ALTER TABLE ifrdba2.item_mensal_compromisso_orc
ADD CONSTRAINT imco_pk PRIMARY KEY (ico_co_nr_ano, ico_co_dep_cd_dependencia, 
  ico_co_nr_compromisso, ico_nr_seq_comp, mm_compromisso)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_MENSAL_COMPROMISSO_ORC

-- Start of DDL Script for Table IFRDBA2.ITEM_MENSAL_PRE_COMP_ORC
-- Generated 9-mar-2004 18:58:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_mensal_pre_comp_orc
    (ipc_pc_nr_ano                  NUMBER(4) NOT NULL,
    ipc_pc_dep_cd_dependencia      NUMBER(4) NOT NULL,
    ipc_pc_nr_pre_compromisso      NUMBER(6) NOT NULL,
    ipc_nr_seq_pcomp               NUMBER(3) NOT NULL,
    mm_pre_comp                    NUMBER(2) NOT NULL,
    qt_pre_comp                    NUMBER(6),
    vl_pre_comp                    NUMBER(14,2) NOT NULL,
    vl_pre_comp_dolar              NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_MENSAL_PRE_COMP_ORC

ALTER TABLE ifrdba2.item_mensal_pre_comp_orc
ADD CONSTRAINT impco_pk PRIMARY KEY (ipc_pc_nr_ano, ipc_pc_dep_cd_dependencia, 
  ipc_pc_nr_pre_compromisso, ipc_nr_seq_pcomp, mm_pre_comp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_MENSAL_PRE_COMP_ORC

-- Start of DDL Script for Table IFRDBA2.ITEM_MENSAL_PROP_ORC_SIM
-- Generated 9-mar-2004 18:59:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_mensal_prop_orc_sim
    (ips_vsp_cd_nivel_versao        VARCHAR2(2) NOT NULL,
    ips_vsp_cd_versao              VARCHAR2(2) NOT NULL,
    ips_vsp_nr_ano                 NUMBER(4) NOT NULL,
    ips_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ips_nr_item                    NUMBER(5) NOT NULL,
    mm_item                        NUMBER(2) NOT NULL,
    vl_programado                  NUMBER(14,2) NOT NULL,
    qt_programado                  NUMBER(6),
    vl_programado_dolar            NUMBER(14,2),
    in_escolhida                   NUMBER(2),
    in_replicacao                  VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_MENSAL_PROP_ORC_SIM

ALTER TABLE ifrdba2.item_mensal_prop_orc_sim
ADD CONSTRAINT ims_pk PRIMARY KEY (ips_vsp_cd_nivel_versao, ips_vsp_cd_versao, 
  ips_vsp_nr_ano, ips_dep_cd_dependencia, ips_nr_item, mm_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ITEM_MENSAL_PROP_ORC_SIM

CREATE TRIGGER ifrdba2.ims_trg_01
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.item_mensal_prop_orc_sim
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
BEGIN
  declare
     TipoOperacao char := 'E';
  begin
     if    :new.vl_programado <> :old.vl_programado then
     if    inserting or updating then
           if inserting
           then
              TipoOperacao := 'I';
           else
              TipoOperacao := 'A';
           end if;
           insert into log_item_mensal_prop_orc_sim
              (CD_NIVEL_VERSAO,   CD_VERSAO,
        NR_ANO,           CD_DEPENDENCIA,
          NR_ITEM,    MM_ITEM,
        VL_PROGRAMADO,   QT_PROGRAMADO,
        VL_PROGRAMADO_DOLAR,   CD_USUARIO,
               DT_MANUTENCAO,   TP_MANUTENCAO)
            values
              (:new.IPS_VSP_CD_NIVEL_VERSAO,  :new.IPS_VSP_CD_VERSAO,
        :new.IPS_VSP_NR_ANO,  :new.IPS_DEP_CD_DEPENDENCIA,
        :new.IPS_NR_ITEM,   :new.MM_ITEM,
               :new.VL_PROGRAMADO,  :new.QT_PROGRAMADO,
        :new.VL_PROGRAMADO_DOLAR,  USER,
        sysdate,           TipoOperacao);
     elsif deleting then
           insert into log_item_mensal_prop_orc_sim
              ( CD_NIVEL_VERSAO,   CD_VERSAO,
         NR_ANO,           CD_DEPENDENCIA,
           NR_ITEM,    MM_ITEM,
         VL_PROGRAMADO,   QT_PROGRAMADO,
         VL_PROGRAMADO_DOLAR,   CD_USUARIO,
                DT_MANUTENCAO,   TP_MANUTENCAO)
            values
              (:old.IPS_VSP_CD_NIVEL_VERSAO,  :old.IPS_VSP_CD_VERSAO,
        :old.IPS_VSP_NR_ANO,  :old.IPS_DEP_CD_DEPENDENCIA,
        :old.IPS_NR_ITEM,   :old.MM_ITEM,
               :old.VL_PROGRAMADO,  :old.QT_PROGRAMADO,
        :old.VL_PROGRAMADO_DOLAR,  USER,
        sysdate,           TipoOperacao);
     end if;
     end if;
  end ims_trg_01;
END;
/

-- End of DDL Script for Table IFRDBA2.ITEM_MENSAL_PROP_ORC_SIM

-- Start of DDL Script for Table IFRDBA2.ITEM_MOVIMENTACAO_CREDITO
-- Generated 9-mar-2004 18:59:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_movimentacao_credito
    (nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia_efetuou     NUMBER(4) NOT NULL,
    nr_movimentacao                NUMBER(6) NOT NULL,
    mm_origem                      NUMBER(2) NOT NULL,
    qt_movimentacao                NUMBER(6),
    vl_movimentacao                NUMBER(14,2) NOT NULL,
    vl_movimentacao_dolar          NUMBER(14,2) NOT NULL,
    qt_programado_pcomp            NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_MOVIMENTACAO_CREDITO

ALTER TABLE ifrdba2.item_movimentacao_credito
ADD CONSTRAINT imc_pk PRIMARY KEY (nr_ano, dep_cd_dependencia_efetuou, 
  nr_movimentacao, mm_origem)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_MOVIMENTACAO_CREDITO

-- Start of DDL Script for Table IFRDBA2.ITEM_POR_DEPENDENCIA
-- Generated 9-mar-2004 18:59:12 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_por_dependencia
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    ig_ci_cd_classe                VARCHAR2(4) NOT NULL,
    ig_cd_item                     VARCHAR2(7) NOT NULL,
    dt_valor_previsto              DATE,
    in_origem                      NUMBER(1),
    qt_vida_util_dias              NUMBER(4),
    vl_previsto                    NUMBER(17,5),
    abc_cd_classificacao           VARCHAR2(6),
    in_custo_atualizado            NUMBER(1),
    cd_estocavel                   NUMBER(1),
    cd_ressuprimento               NUMBER(1),
    cd_orcamentario                VARCHAR2(30),
    qt_tle                         NUMBER(5),
    in_critico_iso                 NUMBER(1),
    ds_usuario                     VARCHAR2(50),
    qt_estoque_iso                 NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_POR_DEPENDENCIA

ALTER TABLE ifrdba2.item_por_dependencia
ADD CONSTRAINT ipd_pk PRIMARY KEY (dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_POR_DEPENDENCIA

COMMENT ON TABLE ifrdba2.item_por_dependencia IS 'SISMAT - Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_POR_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.ITEM_PRE_COMPROMISSO_ORCAMENTA
-- Generated 9-mar-2004 18:59:16 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_pre_compromisso_orcamenta
    (nr_ano_pre_compromisso         NUMBER(4) NOT NULL,
    dep_cd_dependencia_pcompr      NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_pre_compromisso             NUMBER(6) NOT NULL,
    nr_seq_pcomp                   NUMBER(3) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    dt_previsao_pre_compromisso    DATE NOT NULL,
    qt_pre_compromisso             NUMBER(6),
    vl_pre_compromisso             NUMBER(14,2),
    qt_compromissado               NUMBER(6),
    vl_compromissado               NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_PRE_COMPROMISSO_ORCAMENTA

ALTER TABLE ifrdba2.item_pre_compromisso_orcamenta
ADD CONSTRAINT ipc_pk PRIMARY KEY (nr_ano_pre_compromisso, 
  dep_cd_dependencia_pcompr, cc2_cd_centro_custo, nr_pre_compromisso, 
  nr_seq_pcomp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_PRE_COMPROMISSO_ORCAMENTA

-- Start of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_LICITACAO
-- Generated 9-mar-2004 18:59:22 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_proposta_licitacao
    (pdl_for_nr_cgc_cpf             VARCHAR2(14) NOT NULL,
    pdl_lrc_sq_lote                NUMBER(8) NOT NULL,
    pdl_for_dep_cd_dependencia     NUMBER(4) NOT NULL,
    rcl_lrc_sq_lote                NUMBER(8) NOT NULL,
    rcl_rci_dep_cd_dependencia     NUMBER(4) NOT NULL,
    rcl_rci_aa_requisicao_compra   NUMBER(4) NOT NULL,
    rcl_rci_nr_requisicao_compra   NUMBER(6) NOT NULL,
    sq_item                        NUMBER(3),
    nr_classificacao               NUMBER(3),
    ds_justificativa_menor_preco   VARCHAR2(200),
    dt_entrega_prevista            DATE,
    in_desclassificacao            NUMBER(1),
    in_ganhador                    NUMBER(1),
    in_situacao                    NUMBER(1),
    pc_sobre_preco_atual           NUMBER(10,2),
    qt_recebida                    NUMBER(12,2),
    vl_unitario_proposta           NUMBER(17,5) NOT NULL,
    sms_aa_sms                     NUMBER(4),
    sms_nr_sms                     NUMBER(8),
    sms_dep_cd_dependencia         NUMBER(4),
    qt_ofertada                    NUMBER(12,2) NOT NULL,
    tx_observacao_sms              VARCHAR2(1500),
    pz_previsto_entrega            NUMBER(5),
    in_cotado                      NUMBER(1),
    in_destino_sms_gerada          NUMBER(1),
    sod_aa_sms                     NUMBER(4),
    sod_nr_sms                     NUMBER(8),
    sod_dep_cd_dependencia         NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_PROPOSTA_LICITACAO

CREATE INDEX ifrdba2.it_prop_lic ON ifrdba2.item_proposta_licitacao
  (
    rcl_rci_dep_cd_dependencia      ASC,
    rcl_rci_aa_requisicao_compra    ASC,
    rcl_rci_nr_requisicao_compra    ASC,
    in_situacao                     ASC,
    in_ganhador                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.item_proposta_licitacao_ind ON ifrdba2.item_proposta_licitacao
  (
    in_desclassificacao             ASC,
    in_cotado                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ipl_sms_fk ON ifrdba2.item_proposta_licitacao
  (
    sms_aa_sms                      ASC,
    sms_nr_sms                      ASC,
    sms_dep_cd_dependencia          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_PROPOSTA_LICITACAO

ALTER TABLE ifrdba2.item_proposta_licitacao
ADD CONSTRAINT ipl_pk PRIMARY KEY (pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote, rcl_lrc_sq_lote, 
  rcl_rci_dep_cd_dependencia, rcl_rci_aa_requisicao_compra, 
  rcl_rci_nr_requisicao_compra)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_PROPOSTA_LICITACAO

COMMENT ON TABLE ifrdba2.item_proposta_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_LICITACAO

-- Start of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA
-- Generated 9-mar-2004 18:59:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_proposta_orc_simulada
    (vsp_cd_nivel_versao            VARCHAR2(2) NOT NULL,
    vsp_cd_versao                  VARCHAR2(2) NOT NULL,
    vsp_nr_ano                     NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    cc2_cd_centro_custo_gerd       NUMBER(5) NOT NULL,
    dep_cd_dependencia_gerd        NUMBER(4) NOT NULL,
    po_cd_programa                 NUMBER(3),
    prj_cd_projeto                 VARCHAR2(4) NOT NULL,
    in_centralizado                NUMBER(1) NOT NULL,
    cd_prioridade                  NUMBER(1) NOT NULL,
    vl_unitario_item               NUMBER(10,2),
    nr_contrato                    VARCHAR2(20),
    dt_inicio_contrato             DATE,
    dt_termino_contrato            DATE,
    ds_justificativa               VARCHAR2(240),
    ds_item                        VARCHAR2(60),
    cf_nr_item                     NUMBER(5),
    ff_tp_pessoa                   NUMBER(1),
    ff_nr_cgc_cpf                  VARCHAR2(14),
    no_fornecedor                  VARCHAR2(60),
    vl_unitario_item_dolar         NUMBER(10,2),
    in_considera_log               VARCHAR2(1),
    in_escolhida                   NUMBER(2),
    in_replicacao                  VARCHAR2(1),
    dep_cd_dependencia_gest        NUMBER(4) NOT NULL,
    cc2_cd_centro_custo_gest       NUMBER(5) NOT NULL,
    gp_cd_grupo                    NUMBER(4),
    qtd_jan                        NUMBER(7),
    val_jan                        NUMBER(14,2),
    qtd_fev                        NUMBER(7),
    val_fev                        NUMBER(14,2),
    qtd_mar                        NUMBER(7),
    val_mar                        NUMBER(14,2),
    qtd_abr                        NUMBER(7),
    val_abr                        NUMBER(14,2),
    qtd_mai                        NUMBER(7),
    val_mai                        NUMBER(14,2),
    qtd_jun                        NUMBER(7),
    val_jun                        NUMBER(14,2),
    qtd_jul                        NUMBER(7),
    val_jul                        NUMBER(14,2),
    qtd_ago                        NUMBER(7),
    val_ago                        NUMBER(14,2),
    qtd_set                        NUMBER(7),
    val_set                        NUMBER(14,2),
    qtd_out                        NUMBER(7),
    val_out                        NUMBER(14,2),
    qtd_nov                        NUMBER(7),
    val_nov                        NUMBER(14,2),
    qtd_dez                        NUMBER(7),
    val_dez                        NUMBER(14,2),
    qtd_jan1                       NUMBER(7),
    val_jan1                       NUMBER(14,2),
    qtd_fev1                       NUMBER(7),
    val_fev1                       NUMBER(14,2),
    qtd_mar1                       NUMBER(7),
    val_mar1                       NUMBER(14,2),
    qtd_abr1                       NUMBER(7),
    val_abr1                       NUMBER(14,2),
    qtd_mai1                       NUMBER(7),
    val_mai1                       NUMBER(14,2),
    qtd_jun1                       NUMBER(7),
    val_jun1                       NUMBER(14,2),
    qtd_jul1                       NUMBER(7),
    val_jul1                       NUMBER(14,2),
    qtd_ago1                       NUMBER(7),
    val_ago1                       NUMBER(14,2),
    qtd_set1                       NUMBER(7),
    val_set1                       NUMBER(14,2),
    qtd_out1                       NUMBER(7),
    val_out1                       NUMBER(14,2),
    qtd_nov1                       NUMBER(7),
    val_nov1                       NUMBER(14,2),
    qtd_dez1                       NUMBER(7),
    val_dez1                       NUMBER(14,2),
    qtd_jan2                       NUMBER(7),
    val_jan2                       NUMBER(14,2),
    qtd_fev2                       NUMBER(7),
    val_fev2                       NUMBER(14,2),
    qtd_mar2                       NUMBER(7),
    val_mar2                       NUMBER(14,2),
    qtd_abr2                       NUMBER(7),
    val_abr2                       NUMBER(14,2),
    qtd_mai2                       NUMBER(7),
    val_mai2                       NUMBER(14,2),
    qtd_jun2                       NUMBER(7),
    val_jun2                       NUMBER(14,2),
    qtd_jul2                       NUMBER(7),
    val_jul2                       NUMBER(14,2),
    qtd_ago2                       NUMBER(7),
    val_ago2                       NUMBER(14,2),
    qtd_set2                       NUMBER(7),
    val_set2                       NUMBER(14,2),
    qtd_out2                       NUMBER(7),
    val_out2                       NUMBER(14,2),
    qtd_nov2                       NUMBER(7),
    val_nov2                       NUMBER(14,2),
    qtd_dez2                       NUMBER(7),
    val_dez2                       NUMBER(14,2),
    qtd_jan3                       NUMBER(7),
    val_jan3                       NUMBER(14,2),
    qtd_fev3                       NUMBER(7),
    val_fev3                       NUMBER(14,2),
    qtd_mar3                       NUMBER(7),
    val_mar3                       NUMBER(14,2),
    qtd_abr3                       NUMBER(7),
    val_abr3                       NUMBER(14,2),
    qtd_mai3                       NUMBER(7),
    val_mai3                       NUMBER(14,2),
    qtd_jun3                       NUMBER(7),
    val_jun3                       NUMBER(14,2),
    qtd_jul3                       NUMBER(7),
    val_jul3                       NUMBER(14,2),
    qtd_ago3                       NUMBER(7),
    val_ago3                       NUMBER(14,2),
    qtd_set3                       NUMBER(7),
    val_set3                       NUMBER(14,2),
    qtd_out3                       NUMBER(7),
    val_out3                       NUMBER(14,2),
    qtd_nov3                       NUMBER(7),
    val_nov3                       NUMBER(14,2),
    qtd_dez3                       NUMBER(7),
    val_dez3                       NUMBER(14,2),
    qtd_jan4                       NUMBER(7),
    val_jan4                       NUMBER(14,2),
    qtd_fev4                       NUMBER(7),
    val_fev4                       NUMBER(14,2),
    qtd_mar4                       NUMBER(7),
    val_mar4                       NUMBER(14,2),
    qtd_abr4                       NUMBER(7),
    val_abr4                       NUMBER(14,2),
    qtd_mai4                       NUMBER(7),
    val_mai4                       NUMBER(14,2),
    qtd_jun4                       NUMBER(7),
    val_jun4                       NUMBER(14,2),
    qtd_jul4                       NUMBER(7),
    val_jul4                       NUMBER(14,2),
    qtd_ago4                       NUMBER(7),
    val_ago4                       NUMBER(14,2),
    qtd_set4                       NUMBER(7),
    val_set4                       NUMBER(14,2),
    qtd_out4                       NUMBER(7),
    val_out4                       NUMBER(14,2),
    qtd_nov4                       NUMBER(7),
    val_nov4                       NUMBER(14,2),
    qtd_dez4                       NUMBER(7),
    val_dez4                       NUMBER(14,2),
    qtd_jan5                       NUMBER(7),
    val_jan5                       NUMBER(14,2),
    qtd_fev5                       NUMBER(7),
    val_fev5                       NUMBER(14,2),
    qtd_mar5                       NUMBER(7),
    val_mar5                       NUMBER(14,2),
    qtd_abr5                       NUMBER(7),
    val_abr5                       NUMBER(14,2),
    qtd_mai5                       NUMBER(7),
    val_mai5                       NUMBER(14,2),
    qtd_jun5                       NUMBER(7),
    val_jun5                       NUMBER(14,2),
    qtd_jul5                       NUMBER(7),
    val_jul5                       NUMBER(14,2),
    qtd_ago5                       NUMBER(7),
    val_ago5                       NUMBER(14,2),
    qtd_set5                       NUMBER(7),
    val_set5                       NUMBER(14,2),
    qtd_out5                       NUMBER(7),
    val_out5                       NUMBER(14,2),
    qtd_nov5                       NUMBER(7),
    val_nov5                       NUMBER(14,2),
    qtd_dez5                       NUMBER(7),
    val_dez5                       NUMBER(14,2),
    vl_unitario_item1              NUMBER(10,2),
    vl_unitario_item2              NUMBER(10,2),
    vl_unitario_item3              NUMBER(10,2),
    vl_unitario_item4              NUMBER(10,2),
    in_dimensionamento             VARCHAR2(1) NOT NULL,
    ind_contrato                   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA

CREATE INDEX ifrdba2.i_p_o_s_cc1_nr_conta ON ifrdba2.item_proposta_orc_simulada
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA

ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_pk PRIMARY KEY (vsp_nr_ano, vsp_cd_nivel_versao, 
  vsp_cd_versao, dep_cd_dependencia, nr_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA

CREATE TRIGGER ifrdba2.ips_trg_01
BEFORE INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.item_proposta_orc_simulada
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Declare
    rLOG    LOG_ITENS_PROPOSTAS_ORCAMENTOS%RowType;
  Begin
    IF INSERTING THEN
      Insert Into LOG_ITENS_PROPOSTAS_ORCAMENTOS
        (
         COD_USUARIO,
         DAT_MANUTENCAO,
         TIP_MANUTENCAO,
         NR_ANO,
         CD_DEPENDENCIA,
         CD_NIVEL_VERSAO,
         CD_VERSAO,
         CD_DEPENDENCIA_SOLI,
         NR_ITEM,
         NR_CONTA,
         CD_CENTRO_CUSTO,
         CD_PROGRAMA,
         CD_PROJETO,
         CD_DEPENDENCIA_GERD,
         CD_CENTRO_CUSTO_GERD,
         IN_CENTRALIZADO,
         CD_DEPENDENCIA_GEST,
         CD_CENTRO_CUSTO_GEST,
         CD_PRIORIDADE,
         CD_GRUPO,
         DS_ITEM,
         NR_CONTRATO,
         DT_INICIO_CONTRATO,
         DT_TERMINO_CONTRATO,
         NO_FORNECEDOR,
         DS_JUSTIFICATIVA,
         IN_DIMENSIONAMENTO,
         VAL_UNITARIO,
         QTD_JAN,
         QTD_FEV,
         QTD_MAR,
         QTD_ABR,
         QTD_MAI,
         QTD_JUN,
         QTD_JUL,
         QTD_AGO,
         QTD_SET,
         QTD_OUT,
         QTD_NOV,
         QTD_DEZ,
         VAL_UNITARIO1,
         QTD_JAN1,
         QTD_FEV1,
         QTD_MAR1,
         QTD_ABR1,
         QTD_MAI1,
         QTD_JUN1,
         QTD_JUL1,
         QTD_AGO1,
         QTD_SET1,
         QTD_OUT1,
         QTD_NOV1,
         QTD_DEZ1,
         VAL_UNITARIO2,
         QTD_JAN2,
         QTD_FEV2,
         QTD_MAR2,
         QTD_ABR2,
         QTD_MAI2,
         QTD_JUN2,
         QTD_JUL2,
         QTD_AGO2,
         QTD_SET2,
         QTD_OUT2,
         QTD_NOV2,
         QTD_DEZ2,
         VAL_UNITARIO3,
         QTD_JAN3,
         QTD_FEV3,
         QTD_MAR3,
         QTD_ABR3,
         QTD_MAI3,
         QTD_JUN3,
         QTD_JUL3,
         QTD_AGO3,
         QTD_SET3,
         QTD_OUT3,
         QTD_NOV3,
         QTD_DEZ3,
         VAL_UNITARIO4,
         QTD_JAN4,
         QTD_FEV4,
         QTD_MAR4,
         QTD_ABR4,
         QTD_MAI4,
         QTD_JUN4,
         QTD_JUL4,
         QTD_AGO4,
         QTD_SET4,
         QTD_OUT4,
         QTD_NOV4,
         QTD_DEZ4,
         VAL_JAN,
         VAL_FEV,
         VAL_MAR,
         VAL_ABR,
         VAL_MAI,
         VAL_JUN,
         VAL_JUL,
         VAL_AGO,
         VAL_SET,
         VAL_OUT,
         VAL_NOV,
         VAL_DEZ,
         VAL_JAN1,
         VAL_FEV1,
         VAL_MAR1,
         VAL_ABR1,
         VAL_MAI1,
         VAL_JUN1,
         VAL_JUL1,
         VAL_AGO1,
         VAL_SET1,
         VAL_OUT1,
         VAL_NOV1,
         VAL_DEZ1,
         VAL_JAN2,
         VAL_FEV2,
         VAL_MAR2,
         VAL_ABR2,
         VAL_MAI2,
         VAL_JUN2,
         VAL_JUL2,
         VAL_AGO2,
         VAL_SET2,
         VAL_OUT2,
         VAL_NOV2,
         VAL_DEZ2,
         VAL_JAN3,
         VAL_FEV3,
         VAL_MAR3,
         VAL_ABR3,
         VAL_MAI3,
         VAL_JUN3,
         VAL_JUL3,
         VAL_AGO3,
         VAL_SET3,
         VAL_OUT3,
         VAL_NOV3,
         VAL_DEZ3,
         VAL_JAN4,
         VAL_FEV4,
         VAL_MAR4,
         VAL_ABR4,
         VAL_MAI4,
         VAL_JUN4,
         VAL_JUL4,
         VAL_AGO4,
         VAL_SET4,
         VAL_OUT4,
         VAL_NOV4,
         VAL_DEZ4
        )
        Values
          (
           USER,
           SYSDATE,
           'I',
           :New.VSP_NR_ANO,
           0,
           :New.VSP_CD_NIVEL_VERSAO,
           :New.VSP_CD_VERSAO,
           :New.DEP_CD_DEPENDENCIA,
           :New.NR_ITEM,
           :New.CC1_NR_CONTA,
           :New.CC2_CD_CENTRO_CUSTO,
           :New.PO_CD_PROGRAMA,
           :New.PRJ_CD_PROJETO,
           :New.DEP_CD_DEPENDENCIA_GERD,
           :New.CC2_CD_CENTRO_CUSTO_GERD,
           :New.IN_CENTRALIZADO,
           :New.DEP_CD_DEPENDENCIA_GEST,
           :New.CC2_CD_CENTRO_CUSTO_GEST,
           :New.CD_PRIORIDADE,
           :New.GP_CD_GRUPO,
           :New.DS_ITEM,
           :New.NR_CONTRATO,
           :New.DT_INICIO_CONTRATO,
           :New.DT_TERMINO_CONTRATO,
           :New.NO_FORNECEDOR,
           :New.DS_JUSTIFICATIVA,
           :New.IN_DIMENSIONAMENTO,
           :New.VL_UNITARIO_ITEM,
           :New.QTD_JAN,
           :New.QTD_FEV,
           :New.QTD_MAR,
           :New.QTD_ABR,
           :New.QTD_MAI,
           :New.QTD_JUN,
           :New.QTD_JUL,
           :New.QTD_AGO,
           :New.QTD_SET,
           :New.QTD_OUT,
           :New.QTD_NOV,
           :New.QTD_DEZ,
           :New.VL_UNITARIO_ITEM1,
           :New.QTD_JAN1,
           :New.QTD_FEV1,
           :New.QTD_MAR1,
           :New.QTD_ABR1,
           :New.QTD_MAI1,
           :New.QTD_JUN1,
           :New.QTD_JUL1,
           :New.QTD_AGO1,
           :New.QTD_SET1,
           :New.QTD_OUT1,
           :New.QTD_NOV1,
           :New.QTD_DEZ1,
           :New.VL_UNITARIO_ITEM2,
           :New.QTD_JAN2,
           :New.QTD_FEV2,
           :New.QTD_MAR2,
           :New.QTD_ABR2,
           :New.QTD_MAI2,
           :New.QTD_JUN2,
           :New.QTD_JUL2,
           :New.QTD_AGO2,
           :New.QTD_SET2,
           :New.QTD_OUT2,
           :New.QTD_NOV2,
           :New.QTD_DEZ2,
           :New.VL_UNITARIO_ITEM3,
           :New.QTD_JAN3,
           :New.QTD_FEV3,
           :New.QTD_MAR3,
           :New.QTD_ABR3,
           :New.QTD_MAI3,
           :New.QTD_JUN3,
           :New.QTD_JUL3,
           :New.QTD_AGO3,
           :New.QTD_SET3,
           :New.QTD_OUT3,
           :New.QTD_NOV3,
           :New.QTD_DEZ3,
           :New.VL_UNITARIO_ITEM4,
           :New.QTD_JAN4,
           :New.QTD_FEV4,
           :New.QTD_MAR4,
           :New.QTD_ABR4,
           :New.QTD_MAI4,
           :New.QTD_JUN4,
           :New.QTD_JUL4,
           :New.QTD_AGO4,
           :New.QTD_SET4,
           :New.QTD_OUT4,
           :New.QTD_NOV4,
           :New.QTD_DEZ4,
           :New.VAL_JAN,
           :New.VAL_FEV,
           :New.VAL_MAR,
           :New.VAL_ABR,
           :New.VAL_MAI,
           :New.VAL_JUN,
           :New.VAL_JUL,
           :New.VAL_AGO,
           :New.VAL_SET,
           :New.VAL_OUT,
           :New.VAL_NOV,
           :New.VAL_DEZ,
           :New.VAL_JAN1,
           :New.VAL_FEV1,
           :New.VAL_MAR1,
           :New.VAL_ABR1,
           :New.VAL_MAI1,
           :New.VAL_JUN1,
           :New.VAL_JUL1,
           :New.VAL_AGO1,
           :New.VAL_SET1,
           :New.VAL_OUT1,
           :New.VAL_NOV1,
           :New.VAL_DEZ1,
           :New.VAL_JAN2,
           :New.VAL_FEV2,
           :New.VAL_MAR2,
           :New.VAL_ABR2,
           :New.VAL_MAI2,
           :New.VAL_JUN2,
           :New.VAL_JUL2,
           :New.VAL_AGO2,
           :New.VAL_SET2,
           :New.VAL_OUT2,
           :New.VAL_NOV2,
           :New.VAL_DEZ2,
           :New.VAL_JAN3,
           :New.VAL_FEV3,
           :New.VAL_MAR3,
           :New.VAL_ABR3,
           :New.VAL_MAI3,
           :New.VAL_JUN3,
           :New.VAL_JUL3,
           :New.VAL_AGO3,
           :New.VAL_SET3,
           :New.VAL_OUT3,
           :New.VAL_NOV3,
           :New.VAL_DEZ3,
           :New.VAL_JAN4,
           :New.VAL_FEV4,
           :New.VAL_MAR4,
           :New.VAL_ABR4,
           :New.VAL_MAI4,
           :New.VAL_JUN4,
           :New.VAL_JUL4,
           :New.VAL_AGO4,
           :New.VAL_SET4,
           :New.VAL_OUT4,
           :New.VAL_NOV4,
           :New.VAL_DEZ4
          );
    ELSIF UPDATING THEN
      IF :New.CC1_NR_CONTA <> :Old.CC1_NR_CONTA THEN
        rLOG.NR_CONTA := :New.CC1_NR_CONTA;
      END IF;
      IF :New.CC2_CD_CENTRO_CUSTO <> :Old.CC2_CD_CENTRO_CUSTO THEN
        rLOG.CD_CENTRO_CUSTO := :New.CC2_CD_CENTRO_CUSTO;
      END IF;
      IF :New.PO_CD_PROGRAMA <> :Old.PO_CD_PROGRAMA THEN
        rLOG.CD_PROGRAMA := :New.PO_CD_PROGRAMA;
      END IF;
      IF :New.PRJ_CD_PROJETO <> :Old.PRJ_CD_PROJETO THEN
        rLOG.CD_PROJETO := :New.PRJ_CD_PROJETO;
      END IF;
      IF :New.DEP_CD_DEPENDENCIA_GERD <> :Old.DEP_CD_DEPENDENCIA_GERD THEN
        rLOG.CD_DEPENDENCIA_GERD := :New.DEP_CD_DEPENDENCIA_GERD;
      END IF;
      IF :New.CC2_CD_CENTRO_CUSTO_GERD <> :Old.CC2_CD_CENTRO_CUSTO_GERD THEN
        rLOG.CD_CENTRO_CUSTO_GERD := :New.CC2_CD_CENTRO_CUSTO_GERD;
      END IF;
      IF :New.IN_CENTRALIZADO <> :Old.IN_CENTRALIZADO THEN
        rLOG.IN_CENTRALIZADO := :New.IN_CENTRALIZADO;
      END IF;
      IF :New.DEP_CD_DEPENDENCIA_GEST <> :Old.DEP_CD_DEPENDENCIA_GEST THEN
        rLOG.CD_DEPENDENCIA_GEST := :New.DEP_CD_DEPENDENCIA_GEST;
      END IF;
      IF :New.CC2_CD_CENTRO_CUSTO_GEST <> :Old.CC2_CD_CENTRO_CUSTO_GEST THEN
        rLOG.CD_CENTRO_CUSTO_GEST := :New.CC2_CD_CENTRO_CUSTO_GEST;
      END IF;
      IF :New.CD_PRIORIDADE <> :Old.CD_PRIORIDADE THEN
        rLOG.CD_PRIORIDADE := :New.CD_PRIORIDADE;
      END IF;
      IF :New.GP_CD_GRUPO <> :Old.GP_CD_GRUPO THEN
        rLOG.CD_GRUPO := :New.GP_CD_GRUPO;
      END IF;
      IF :New.DS_ITEM <> :Old.DS_ITEM THEN
        rLOG.DS_ITEM := :New.DS_ITEM;
      END IF;
      IF :New.NR_CONTRATO <> :Old.NR_CONTRATO THEN
        rLOG.NR_CONTRATO := :New.NR_CONTRATO;
      END IF;
      IF :New.DT_INICIO_CONTRATO <> :Old.DT_INICIO_CONTRATO THEN
        rLOG.DT_INICIO_CONTRATO := :New.DT_INICIO_CONTRATO;
      END IF;
      IF :New.DT_TERMINO_CONTRATO <> :Old.DT_TERMINO_CONTRATO THEN
        rLOG.DT_TERMINO_CONTRATO := :New.DT_TERMINO_CONTRATO;
      END IF;
      IF :New.NO_FORNECEDOR <> :Old.NO_FORNECEDOR THEN
        rLOG.NO_FORNECEDOR := :New.NO_FORNECEDOR;
      END IF;
      IF :New.DS_JUSTIFICATIVA <> :Old.DS_JUSTIFICATIVA THEN
        rLOG.DS_JUSTIFICATIVA := :New.DS_JUSTIFICATIVA;
      END IF;
      IF :New.IN_DIMENSIONAMENTO <> :Old.IN_DIMENSIONAMENTO THEN
        rLOG.IN_DIMENSIONAMENTO := :New.IN_DIMENSIONAMENTO;
      END IF;
      IF :New.VL_UNITARIO_ITEM <> :Old.VL_UNITARIO_ITEM THEN
        rLOG.VAL_UNITARIO := :New.VL_UNITARIO_ITEM;
      END IF;
      IF :New.QTD_JAN <> :Old.QTD_JAN THEN
        rLOG.QTD_JAN := :New.QTD_JAN;
      END IF;
      IF :New.QTD_FEV <> :Old.QTD_FEV THEN
        rLOG.QTD_FEV := :New.QTD_FEV;
      END IF;
      IF :New.QTD_MAR <> :Old.QTD_MAR THEN
        rLOG.QTD_MAR := :New.QTD_MAR;
      END IF;
      IF :New.QTD_ABR <> :Old.QTD_ABR THEN
        rLOG.QTD_ABR := :New.QTD_ABR;
      END IF;
      IF :New.QTD_MAI <> :Old.QTD_MAI THEN
        rLOG.QTD_MAI := :New.QTD_MAI;
      END IF;
      IF :New.QTD_JUN <> :Old.QTD_JUN THEN
        rLOG.QTD_JUN := :New.QTD_JUN;
      END IF;
      IF :New.QTD_JUL <> :Old.QTD_JUL THEN
        rLOG.QTD_JUL := :New.QTD_JUL;
      END IF;
      IF :New.QTD_AGO <> :Old.QTD_AGO THEN
        rLOG.QTD_AGO := :New.QTD_AGO;
      END IF;
      IF :New.QTD_SET <> :Old.QTD_SET THEN
        rLOG.QTD_SET := :New.QTD_SET;
      END IF;
      IF :New.QTD_OUT <> :Old.QTD_OUT THEN
        rLOG.QTD_OUT := :New.QTD_OUT;
      END IF;
      IF :New.QTD_NOV <> :Old.QTD_NOV THEN
        rLOG.QTD_NOV := :New.QTD_NOV;
      END IF;
      IF :New.QTD_DEZ <> :Old.QTD_DEZ THEN
        rLOG.QTD_DEZ := :New.QTD_DEZ;
      END IF;
      IF :New.VL_UNITARIO_ITEM1 <> :Old.VL_UNITARIO_ITEM1 THEN
        rLOG.VAL_UNITARIO1 := :New.VL_UNITARIO_ITEM1;
      END IF;
      IF :New.QTD_JAN1 <> :Old.QTD_JAN1 THEN
        rLOG.QTD_JAN1 := :New.QTD_JAN1;
      END IF;
      IF :New.QTD_FEV1 <> :Old.QTD_FEV1 THEN
        rLOG.QTD_FEV1 := :New.QTD_FEV1;
      END IF;
      IF :New.QTD_MAR1 <> :Old.QTD_MAR1 THEN
        rLOG.QTD_MAR1 := :New.QTD_MAR1;
      END IF;
      IF :New.QTD_ABR1 <> :Old.QTD_ABR1 THEN
        rLOG.QTD_ABR1 := :New.QTD_ABR1;
      END IF;
      IF :New.QTD_MAI1 <> :Old.QTD_MAI1 THEN
        rLOG.QTD_MAI1 := :New.QTD_MAI1;
      END IF;
      IF :New.QTD_JUN1 <> :Old.QTD_JUN1 THEN
        rLOG.QTD_JUN1 := :New.QTD_JUN1;
      END IF;
      IF :New.QTD_JUL1 <> :Old.QTD_JUL1 THEN
        rLOG.QTD_JUL1 := :New.QTD_JUL1;
      END IF;
      IF :New.QTD_AGO1 <> :Old.QTD_AGO1 THEN
        rLOG.QTD_AGO1 := :New.QTD_AGO1;
      END IF;
      IF :New.QTD_SET1 <> :Old.QTD_SET1 THEN
        rLOG.QTD_SET1 := :New.QTD_SET1;
      END IF;
      IF :New.QTD_OUT1 <> :Old.QTD_OUT1 THEN
        rLOG.QTD_OUT1 := :New.QTD_OUT1;
      END IF;
      IF :New.QTD_NOV1 <> :Old.QTD_NOV1 THEN
        rLOG.QTD_NOV1 := :New.QTD_NOV1;
      END IF;
      IF :New.QTD_DEZ1 <> :Old.QTD_DEZ1 THEN
        rLOG.QTD_DEZ1 := :New.QTD_DEZ1;
      END IF;
      IF :New.VL_UNITARIO_ITEM2 <> :Old.VL_UNITARIO_ITEM2 THEN
        rLOG.VAL_UNITARIO2 := :New.VL_UNITARIO_ITEM2;
      END IF;
      IF :New.QTD_JAN2 <> :Old.QTD_JAN2 THEN
        rLOG.QTD_JAN2 := :New.QTD_JAN2;
      END IF;
      IF :New.QTD_FEV2 <> :Old.QTD_FEV2 THEN
        rLOG.QTD_FEV2 := :New.QTD_FEV2;
      END IF;
      IF :New.QTD_MAR2 <> :Old.QTD_MAR2 THEN
        rLOG.QTD_MAR2 := :New.QTD_MAR2;
      END IF;
      IF :New.QTD_ABR2 <> :Old.QTD_ABR2 THEN
        rLOG.QTD_ABR2 := :New.QTD_ABR2;
      END IF;
      IF :New.QTD_MAI2 <> :Old.QTD_MAI2 THEN
        rLOG.QTD_MAI2 := :New.QTD_MAI2;
      END IF;
      IF :New.QTD_JUN2 <> :Old.QTD_JUN2 THEN
        rLOG.QTD_JUN2 := :New.QTD_JUN2;
      END IF;
      IF :New.QTD_JUL2 <> :Old.QTD_JUL2 THEN
        rLOG.QTD_JUL2 := :New.QTD_JUL2;
      END IF;
      IF :New.QTD_AGO2 <> :Old.QTD_AGO2 THEN
        rLOG.QTD_AGO2 := :New.QTD_AGO2;
      END IF;
      IF :New.QTD_SET2 <> :Old.QTD_SET2 THEN
        rLOG.QTD_SET2 := :New.QTD_SET2;
      END IF;
      IF :New.QTD_OUT2 <> :Old.QTD_OUT2 THEN
        rLOG.QTD_OUT2 := :New.QTD_OUT2;
      END IF;
      IF :New.QTD_NOV2 <> :Old.QTD_NOV2 THEN
        rLOG.QTD_NOV2 := :New.QTD_NOV2;
      END IF;
      IF :New.QTD_DEZ2 <> :Old.QTD_DEZ2 THEN
        rLOG.QTD_DEZ2 := :New.QTD_DEZ2;
      END IF;
      IF :New.VL_UNITARIO_ITEM3 <> :Old.VL_UNITARIO_ITEM3 THEN
        rLOG.VAL_UNITARIO3 := :New.VL_UNITARIO_ITEM3;
      END IF;
      IF :New.QTD_JAN3 <> :Old.QTD_JAN3 THEN
        rLOG.QTD_JAN3 := :New.QTD_JAN3;
      END IF;
      IF :New.QTD_FEV3 <> :Old.QTD_FEV3 THEN
        rLOG.QTD_FEV3 := :New.QTD_FEV3;
      END IF;
      IF :New.QTD_MAR3 <> :Old.QTD_MAR3 THEN
        rLOG.QTD_MAR3 := :New.QTD_MAR3;
      END IF;
      IF :New.QTD_ABR3 <> :Old.QTD_ABR3 THEN
        rLOG.QTD_ABR3 := :New.QTD_ABR3;
      END IF;
      IF :New.QTD_MAI3 <> :Old.QTD_MAI3 THEN
        rLOG.QTD_MAI3 := :New.QTD_MAI3;
      END IF;
      IF :New.QTD_JUN3 <> :Old.QTD_JUN3 THEN
        rLOG.QTD_JUN3 := :New.QTD_JUN3;
      END IF;
      IF :New.QTD_JUL3 <> :Old.QTD_JUL3 THEN
        rLOG.QTD_JUL3 := :New.QTD_JUL3;
      END IF;
      IF :New.QTD_AGO3 <> :Old.QTD_AGO3 THEN
        rLOG.QTD_AGO3 := :New.QTD_AGO3;
      END IF;
      IF :New.QTD_SET3 <> :Old.QTD_SET3 THEN
        rLOG.QTD_SET3 := :New.QTD_SET3;
      END IF;
      IF :New.QTD_OUT3 <> :Old.QTD_OUT3 THEN
        rLOG.QTD_OUT3 := :New.QTD_OUT3;
      END IF;
      IF :New.QTD_NOV3 <> :Old.QTD_NOV3 THEN
        rLOG.QTD_NOV3 := :New.QTD_NOV3;
      END IF;
      IF :New.QTD_DEZ3 <> :Old.QTD_DEZ3 THEN
        rLOG.QTD_DEZ3 := :New.QTD_DEZ3;
      END IF;
      IF :New.VL_UNITARIO_ITEM4 <> :Old.VL_UNITARIO_ITEM4 THEN
        rLOG.VAL_UNITARIO4 := :New.VL_UNITARIO_ITEM4;
      END IF;
      IF :New.QTD_JAN4 <> :Old.QTD_JAN4 THEN
        rLOG.QTD_JAN4 := :New.QTD_JAN4;
      END IF;
      IF :New.QTD_FEV4 <> :Old.QTD_FEV4 THEN
        rLOG.QTD_FEV4 := :New.QTD_FEV4;
      END IF;
      IF :New.QTD_MAR4 <> :Old.QTD_MAR4 THEN
        rLOG.QTD_MAR4 := :New.QTD_MAR4;
      END IF;
      IF :New.QTD_ABR4 <> :Old.QTD_ABR4 THEN
        rLOG.QTD_ABR4 := :New.QTD_ABR4;
      END IF;
      IF :New.QTD_MAI4 <> :Old.QTD_MAI4 THEN
        rLOG.QTD_MAI4 := :New.QTD_MAI4;
      END IF;
      IF :New.QTD_JUN4 <> :Old.QTD_JUN4 THEN
        rLOG.QTD_JUN4 := :New.QTD_JUN4;
      END IF;
      IF :New.QTD_JUL4 <> :Old.QTD_JUL4 THEN
        rLOG.QTD_JUL4 := :New.QTD_JUL4;
      END IF;
      IF :New.QTD_AGO4 <> :Old.QTD_AGO4 THEN
        rLOG.QTD_AGO4 := :New.QTD_AGO4;
      END IF;
      IF :New.QTD_SET4 <> :Old.QTD_SET4 THEN
        rLOG.QTD_SET4 := :New.QTD_SET4;
      END IF;
      IF :New.QTD_OUT4 <> :Old.QTD_OUT4 THEN
        rLOG.QTD_OUT4 := :New.QTD_OUT4;
      END IF;
      IF :New.QTD_NOV4 <> :Old.QTD_NOV4 THEN
        rLOG.QTD_NOV4 := :New.QTD_NOV4;
      END IF;
      IF :New.QTD_DEZ4 <> :Old.QTD_DEZ4 THEN
        rLOG.QTD_DEZ4 := :New.QTD_DEZ4;
      END IF;
      IF :New.VAL_JAN <> :Old.VAL_JAN THEN
        rLOG.VAL_JAN := :New.VAL_JAN;
      END IF;
      IF :New.VAL_FEV <> :Old.VAL_FEV THEN
        rLOG.VAL_FEV := :New.VAL_FEV;
      END IF;
      IF :New.VAL_MAR <> :Old.VAL_MAR THEN
        rLOG.VAL_MAR := :New.VAL_MAR;
      END IF;
      IF :New.VAL_ABR <> :Old.VAL_ABR THEN
        rLOG.VAL_ABR := :New.VAL_ABR;
      END IF;
      IF :New.VAL_MAI <> :Old.VAL_MAI THEN
        rLOG.VAL_MAI := :New.VAL_MAI;
      END IF;
      IF :New.VAL_JUN <> :Old.VAL_JUN THEN
        rLOG.VAL_JUN := :New.VAL_JUN;
      END IF;
      IF :New.VAL_JUL <> :Old.VAL_JUL THEN
        rLOG.VAL_JUL := :New.VAL_JUL;
      END IF;
      IF :New.VAL_AGO <> :Old.VAL_AGO THEN
        rLOG.VAL_AGO := :New.VAL_AGO;
      END IF;
      IF :New.VAL_SET <> :Old.VAL_SET THEN
        rLOG.VAL_SET := :New.VAL_SET;
      END IF;
      IF :New.VAL_OUT <> :Old.VAL_OUT THEN
        rLOG.VAL_OUT := :New.VAL_OUT;
      END IF;
      IF :New.VAL_NOV <> :Old.VAL_NOV THEN
        rLOG.VAL_NOV := :New.VAL_NOV;
      END IF;
      IF :New.VAL_DEZ <> :Old.VAL_DEZ THEN
        rLOG.VAL_DEZ := :New.VAL_DEZ;
      END IF;
      IF :New.VAL_JAN1 <> :Old.VAL_JAN1 THEN
        rLOG.VAL_JAN1 := :New.VAL_JAN1;
      END IF;
      IF :New.VAL_FEV1 <> :Old.VAL_FEV1 THEN
        rLOG.VAL_FEV1 := :New.VAL_FEV1;
      END IF;
      IF :New.VAL_MAR1 <> :Old.VAL_MAR1 THEN
        rLOG.VAL_MAR1 := :New.VAL_MAR1;
      END IF;
      IF :New.VAL_ABR1 <> :Old.VAL_ABR1 THEN
        rLOG.VAL_ABR1 := :New.VAL_ABR1;
      END IF;
      IF :New.VAL_MAI1 <> :Old.VAL_MAI1 THEN
        rLOG.VAL_MAI1 := :New.VAL_MAI1;
      END IF;
      IF :New.VAL_JUN1 <> :Old.VAL_JUN1 THEN
        rLOG.VAL_JUN1 := :New.VAL_JUN1;
      END IF;
      IF :New.VAL_JUL1 <> :Old.VAL_JUL1 THEN
        rLOG.VAL_JUL1 := :New.VAL_JUL1;
      END IF;
      IF :New.VAL_AGO1 <> :Old.VAL_AGO1 THEN
        rLOG.VAL_AGO1 := :New.VAL_AGO1;
      END IF;
      IF :New.VAL_SET1 <> :Old.VAL_SET1 THEN
        rLOG.VAL_SET1 := :New.VAL_SET1;
      END IF;
      IF :New.VAL_OUT1 <> :Old.VAL_OUT1 THEN
        rLOG.VAL_OUT1 := :New.VAL_OUT1;
      END IF;
      IF :New.VAL_NOV1 <> :Old.VAL_NOV1 THEN
        rLOG.VAL_NOV1 := :New.VAL_NOV1;
      END IF;
      IF :New.VAL_DEZ1 <> :Old.VAL_DEZ1 THEN
        rLOG.VAL_DEZ1 := :New.VAL_DEZ1;
      END IF;
      IF :New.VAL_JAN2 <> :Old.VAL_JAN2 THEN
        rLOG.VAL_JAN2 := :New.VAL_JAN2;
      END IF;
      IF :New.VAL_FEV2 <> :Old.VAL_FEV2 THEN
        rLOG.VAL_FEV2 := :New.VAL_FEV2;
      END IF;
      IF :New.VAL_MAR2 <> :Old.VAL_MAR2 THEN
        rLOG.VAL_MAR2 := :New.VAL_MAR2;
      END IF;
      IF :New.VAL_ABR2 <> :Old.VAL_ABR2 THEN
        rLOG.VAL_ABR2 := :New.VAL_ABR2;
      END IF;
      IF :New.VAL_MAI2 <> :Old.VAL_MAI2 THEN
        rLOG.VAL_MAI2 := :New.VAL_MAI2;
      END IF;
      IF :New.VAL_JUN2 <> :Old.VAL_JUN2 THEN
        rLOG.VAL_JUN2 := :New.VAL_JUN2;
      END IF;
      IF :New.VAL_JUL2 <> :Old.VAL_JUL2 THEN
        rLOG.VAL_JUL2 := :New.VAL_JUL2;
      END IF;
      IF :New.VAL_AGO2 <> :Old.VAL_AGO2 THEN
        rLOG.VAL_AGO2 := :New.VAL_AGO2;
      END IF;
      IF :New.VAL_SET2 <> :Old.VAL_SET2 THEN
        rLOG.VAL_SET2 := :New.VAL_SET2;
      END IF;
      IF :New.VAL_OUT2 <> :Old.VAL_OUT2 THEN
        rLOG.VAL_OUT2 := :New.VAL_OUT2;
      END IF;
      IF :New.VAL_NOV2 <> :Old.VAL_NOV2 THEN
        rLOG.VAL_NOV2 := :New.VAL_NOV2;
      END IF;
      IF :New.VAL_DEZ2 <> :Old.VAL_DEZ2 THEN
        rLOG.VAL_DEZ2 := :New.VAL_DEZ2;
      END IF;
      IF :New.VAL_JAN3 <> :Old.VAL_JAN3 THEN
        rLOG.VAL_JAN3 := :New.VAL_JAN3;
      END IF;
      IF :New.VAL_FEV3 <> :Old.VAL_FEV3 THEN
        rLOG.VAL_FEV3 := :New.VAL_FEV3;
      END IF;
      IF :New.VAL_MAR3 <> :Old.VAL_MAR3 THEN
        rLOG.VAL_MAR3 := :New.VAL_MAR3;
      END IF;
      IF :New.VAL_ABR3 <> :Old.VAL_ABR3 THEN
        rLOG.VAL_ABR3 := :New.VAL_ABR3;
      END IF;
      IF :New.VAL_MAI3 <> :Old.VAL_MAI3 THEN
        rLOG.VAL_MAI3 := :New.VAL_MAI3;
      END IF;
      IF :New.VAL_JUN3 <> :Old.VAL_JUN3 THEN
        rLOG.VAL_JUN3 := :New.VAL_JUN3;
      END IF;
      IF :New.VAL_JUL3 <> :Old.VAL_JUL3 THEN
        rLOG.VAL_JUL3 := :New.VAL_JUL3;
      END IF;
      IF :New.VAL_AGO3 <> :Old.VAL_AGO3 THEN
        rLOG.VAL_AGO3 := :New.VAL_AGO3;
      END IF;
      IF :New.VAL_SET3 <> :Old.VAL_SET3 THEN
        rLOG.VAL_SET3 := :New.VAL_SET3;
      END IF;
      IF :New.VAL_OUT3 <> :Old.VAL_OUT3 THEN
        rLOG.VAL_OUT3 := :New.VAL_OUT3;
      END IF;
      IF :New.VAL_NOV3 <> :Old.VAL_NOV3 THEN
        rLOG.VAL_NOV3 := :New.VAL_NOV3;
      END IF;
      IF :New.VAL_DEZ3 <> :Old.VAL_DEZ3 THEN
        rLOG.VAL_DEZ3 := :New.VAL_DEZ3;
      END IF;
      IF :New.VAL_JAN4 <> :Old.VAL_JAN4 THEN
        rLOG.VAL_JAN4 := :New.VAL_JAN4;
      END IF;
      IF :New.VAL_FEV4 <> :Old.VAL_FEV4 THEN
        rLOG.VAL_FEV4 := :New.VAL_FEV4;
      END IF;
      IF :New.VAL_MAR4 <> :Old.VAL_MAR4 THEN
        rLOG.VAL_MAR4 := :New.VAL_MAR4;
      END IF;
      IF :New.VAL_ABR4 <> :Old.VAL_ABR4 THEN
        rLOG.VAL_ABR4 := :New.VAL_ABR4;
      END IF;
      IF :New.VAL_MAI4 <> :Old.VAL_MAI4 THEN
        rLOG.VAL_MAI4 := :New.VAL_MAI4;
      END IF;
      IF :New.VAL_JUN4 <> :Old.VAL_JUN4 THEN
        rLOG.VAL_JUN4 := :New.VAL_JUN4;
      END IF;
      IF :New.VAL_JUL4 <> :Old.VAL_JUL4 THEN
        rLOG.VAL_JUL4 := :New.VAL_JUL4;
      END IF;
      IF :New.VAL_AGO4 <> :Old.VAL_AGO4 THEN
        rLOG.VAL_AGO4 := :New.VAL_AGO4;
      END IF;
      IF :New.VAL_SET4 <> :Old.VAL_SET4 THEN
        rLOG.VAL_SET4 := :New.VAL_SET4;
      END IF;
      IF :New.VAL_OUT4 <> :Old.VAL_OUT4 THEN
        rLOG.VAL_OUT4 := :New.VAL_OUT4;
      END IF;
      IF :New.VAL_NOV4 <> :Old.VAL_NOV4 THEN
        rLOG.VAL_NOV4 := :New.VAL_NOV4;
      END IF;
      IF :New.VAL_DEZ4 <> :Old.VAL_DEZ4 THEN
        rLOG.VAL_DEZ4 := :New.VAL_DEZ4;
      END IF;
      Insert Into LOG_ITENS_PROPOSTAS_ORCAMENTOS
        (
         COD_USUARIO,
         DAT_MANUTENCAO,
         TIP_MANUTENCAO,
         NR_ANO,
         CD_DEPENDENCIA,
         CD_NIVEL_VERSAO,
         CD_VERSAO,
         CD_DEPENDENCIA_SOLI,
         NR_ITEM,
         NR_CONTA,
         CD_CENTRO_CUSTO,
         CD_PROGRAMA,
         CD_PROJETO,
         CD_DEPENDENCIA_GERD,
         CD_CENTRO_CUSTO_GERD,
         IN_CENTRALIZADO,
         CD_DEPENDENCIA_GEST,
         CD_CENTRO_CUSTO_GEST,
         CD_PRIORIDADE,
         CD_GRUPO,
         DS_ITEM,
         NR_CONTRATO,
         DT_INICIO_CONTRATO,
         DT_TERMINO_CONTRATO,
         NO_FORNECEDOR,
         DS_JUSTIFICATIVA,
         IN_DIMENSIONAMENTO,
         VAL_UNITARIO,
         QTD_JAN,
         QTD_FEV,
         QTD_MAR,
         QTD_ABR,
         QTD_MAI,
         QTD_JUN,
         QTD_JUL,
         QTD_AGO,
         QTD_SET,
         QTD_OUT,
         QTD_NOV,
         QTD_DEZ,
         VAL_UNITARIO1,
         QTD_JAN1,
         QTD_FEV1,
         QTD_MAR1,
         QTD_ABR1,
         QTD_MAI1,
         QTD_JUN1,
         QTD_JUL1,
         QTD_AGO1,
         QTD_SET1,
         QTD_OUT1,
         QTD_NOV1,
         QTD_DEZ1,
         VAL_UNITARIO2,
         QTD_JAN2,
         QTD_FEV2,
         QTD_MAR2,
         QTD_ABR2,
         QTD_MAI2,
         QTD_JUN2,
         QTD_JUL2,
         QTD_AGO2,
         QTD_SET2,
         QTD_OUT2,
         QTD_NOV2,
         QTD_DEZ2,
         VAL_UNITARIO3,
         QTD_JAN3,
         QTD_FEV3,
         QTD_MAR3,
         QTD_ABR3,
         QTD_MAI3,
         QTD_JUN3,
         QTD_JUL3,
         QTD_AGO3,
         QTD_SET3,
         QTD_OUT3,
         QTD_NOV3,
         QTD_DEZ3,
         VAL_UNITARIO4,
         QTD_JAN4,
         QTD_FEV4,
         QTD_MAR4,
         QTD_ABR4,
         QTD_MAI4,
         QTD_JUN4,
         QTD_JUL4,
         QTD_AGO4,
         QTD_SET4,
         QTD_OUT4,
         QTD_NOV4,
         QTD_DEZ4,
         VAL_JAN,
         VAL_FEV,
         VAL_MAR,
         VAL_ABR,
         VAL_MAI,
         VAL_JUN,
         VAL_JUL,
         VAL_AGO,
         VAL_SET,
         VAL_OUT,
         VAL_NOV,
         VAL_DEZ,
         VAL_JAN1,
         VAL_FEV1,
         VAL_MAR1,
         VAL_ABR1,
         VAL_MAI1,
         VAL_JUN1,
         VAL_JUL1,
         VAL_AGO1,
         VAL_SET1,
         VAL_OUT1,
         VAL_NOV1,
         VAL_DEZ1,
         VAL_JAN2,
         VAL_FEV2,
         VAL_MAR2,
         VAL_ABR2,
         VAL_MAI2,
         VAL_JUN2,
         VAL_JUL2,
         VAL_AGO2,
         VAL_SET2,
         VAL_OUT2,
         VAL_NOV2,
         VAL_DEZ2,
         VAL_JAN3,
         VAL_FEV3,
         VAL_MAR3,
         VAL_ABR3,
         VAL_MAI3,
         VAL_JUN3,
         VAL_JUL3,
         VAL_AGO3,
         VAL_SET3,
         VAL_OUT3,
         VAL_NOV3,
         VAL_DEZ3,
         VAL_JAN4,
         VAL_FEV4,
         VAL_MAR4,
         VAL_ABR4,
         VAL_MAI4,
         VAL_JUN4,
         VAL_JUL4,
         VAL_AGO4,
         VAL_SET4,
         VAL_OUT4,
         VAL_NOV4,
         VAL_DEZ4
        )
        Values
          (
           USER,
           SYSDATE,
           'A',
           :Old.VSP_NR_ANO,
           0,
           :Old.VSP_CD_NIVEL_VERSAO,
           :Old.VSP_CD_VERSAO,
           :Old.DEP_CD_DEPENDENCIA,
           :Old.NR_ITEM,
           rLOG.NR_CONTA,
           rLOG.CD_CENTRO_CUSTO,
           rLOG.CD_PROGRAMA,
           rLOG.CD_PROJETO,
           rLOG.CD_DEPENDENCIA_GERD,
           rLOG.CD_CENTRO_CUSTO_GERD,
           rLOG.IN_CENTRALIZADO,
           rLOG.CD_DEPENDENCIA_GEST,
           rLOG.CD_CENTRO_CUSTO_GEST,
           rLOG.CD_PRIORIDADE,
           rLOG.CD_GRUPO,
           rLOG.DS_ITEM,
           rLOG.NR_CONTRATO,
           rLOG.DT_INICIO_CONTRATO,
           rLOG.DT_TERMINO_CONTRATO,
           rLOG.NO_FORNECEDOR,
           rLOG.DS_JUSTIFICATIVA,
           rLOG.IN_DIMENSIONAMENTO,
           rLOG.VAL_UNITARIO,
           rLOG.QTD_JAN,
           rLOG.QTD_FEV,
           rLOG.QTD_MAR,
           rLOG.QTD_ABR,
           rLOG.QTD_MAI,
           rLOG.QTD_JUN,
           rLOG.QTD_JUL,
           rLOG.QTD_AGO,
           rLOG.QTD_SET,
           rLOG.QTD_OUT,
           rLOG.QTD_NOV,
           rLOG.QTD_DEZ,
           rLOG.VAL_UNITARIO1,
           rLOG.QTD_JAN1,
           rLOG.QTD_FEV1,
           rLOG.QTD_MAR1,
           rLOG.QTD_ABR1,
           rLOG.QTD_MAI1,
           rLOG.QTD_JUN1,
           rLOG.QTD_JUL1,
           rLOG.QTD_AGO1,
           rLOG.QTD_SET1,
           rLOG.QTD_OUT1,
           rLOG.QTD_NOV1,
           rLOG.QTD_DEZ1,
           rLOG.VAL_UNITARIO2,
           rLOG.QTD_JAN2,
           rLOG.QTD_FEV2,
           rLOG.QTD_MAR2,
           rLOG.QTD_ABR2,
           rLOG.QTD_MAI2,
           rLOG.QTD_JUN2,
           rLOG.QTD_JUL2,
           rLOG.QTD_AGO2,
           rLOG.QTD_SET2,
           rLOG.QTD_OUT2,
           rLOG.QTD_NOV2,
           rLOG.QTD_DEZ2,
           rLOG.VAL_UNITARIO3,
           rLOG.QTD_JAN3,
           rLOG.QTD_FEV3,
           rLOG.QTD_MAR3,
           rLOG.QTD_ABR3,
           rLOG.QTD_MAI3,
           rLOG.QTD_JUN3,
           rLOG.QTD_JUL3,
           rLOG.QTD_AGO3,
           rLOG.QTD_SET3,
           rLOG.QTD_OUT3,
           rLOG.QTD_NOV3,
           rLOG.QTD_DEZ3,
           rLOG.VAL_UNITARIO4,
           rLOG.QTD_JAN4,
           rLOG.QTD_FEV4,
           rLOG.QTD_MAR4,
           rLOG.QTD_ABR4,
           rLOG.QTD_MAI4,
           rLOG.QTD_JUN4,
           rLOG.QTD_JUL4,
           rLOG.QTD_AGO4,
           rLOG.QTD_SET4,
           rLOG.QTD_OUT4,
           rLOG.QTD_NOV4,
           rLOG.QTD_DEZ4,
           rLOG.VAL_JAN,
           rLOG.VAL_FEV,
           rLOG.VAL_MAR,
           rLOG.VAL_ABR,
           rLOG.VAL_MAI,
           rLOG.VAL_JUN,
           rLOG.VAL_JUL,
           rLOG.VAL_AGO,
           rLOG.VAL_SET,
           rLOG.VAL_OUT,
           rLOG.VAL_NOV,
           rLOG.VAL_DEZ,
           rLOG.VAL_JAN1,
           rLOG.VAL_FEV1,
           rLOG.VAL_MAR1,
           rLOG.VAL_ABR1,
           rLOG.VAL_MAI1,
           rLOG.VAL_JUN1,
           rLOG.VAL_JUL1,
           rLOG.VAL_AGO1,
           rLOG.VAL_SET1,
           rLOG.VAL_OUT1,
           rLOG.VAL_NOV1,
           rLOG.VAL_DEZ1,
           rLOG.VAL_JAN2,
           rLOG.VAL_FEV2,
           rLOG.VAL_MAR2,
           rLOG.VAL_ABR2,
           rLOG.VAL_MAI2,
           rLOG.VAL_JUN2,
           rLOG.VAL_JUL2,
           rLOG.VAL_AGO2,
           rLOG.VAL_SET2,
           rLOG.VAL_OUT2,
           rLOG.VAL_NOV2,
           rLOG.VAL_DEZ2,
           rLOG.VAL_JAN3,
           rLOG.VAL_FEV3,
           rLOG.VAL_MAR3,
           rLOG.VAL_ABR3,
           rLOG.VAL_MAI3,
           rLOG.VAL_JUN3,
           rLOG.VAL_JUL3,
           rLOG.VAL_AGO3,
           rLOG.VAL_SET3,
           rLOG.VAL_OUT3,
           rLOG.VAL_NOV3,
           rLOG.VAL_DEZ3,
           rLOG.VAL_JAN4,
           rLOG.VAL_FEV4,
           rLOG.VAL_MAR4,
           rLOG.VAL_ABR4,
           rLOG.VAL_MAI4,
           rLOG.VAL_JUN4,
           rLOG.VAL_JUL4,
           rLOG.VAL_AGO4,
           rLOG.VAL_SET4,
           rLOG.VAL_OUT4,
           rLOG.VAL_NOV4,
           rLOG.VAL_DEZ4
          );
    ELSIF DELETING THEN
      Insert Into LOG_ITENS_PROPOSTAS_ORCAMENTOS
        (
         COD_USUARIO,
         DAT_MANUTENCAO,
         TIP_MANUTENCAO,
         NR_ANO,
         CD_DEPENDENCIA,
         CD_NIVEL_VERSAO,
         CD_VERSAO,
         CD_DEPENDENCIA_SOLI,
         NR_ITEM
        )
        Values
          (
           USER,
           SYSDATE,
           'E',
           :Old.VSP_NR_ANO,
           0,
           :Old.VSP_CD_NIVEL_VERSAO,
           :Old.VSP_CD_VERSAO,
           :Old.DEP_CD_DEPENDENCIA,
           :Old.NR_ITEM
          );
    END IF;
  END IPS_TRG_01;
/

-- End of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_ORC_SIMULADA

-- Start of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA
-- Generated 9-mar-2004 18:59:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_proposta_orcamentaria
    (nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    dep_cd_dependencia_gerd        NUMBER(4) NOT NULL,
    cc2_cd_centro_custo_gerd       NUMBER(5) NOT NULL,
    dep_cd_dependencia_gest        NUMBER(4) NOT NULL,
    cc2_cd_centro_custo_gest       NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    po_cd_programa                 NUMBER(3) NOT NULL,
    prj_cd_projeto                 VARCHAR2(4),
    in_centralizado                NUMBER(1),
    cd_prioridade                  NUMBER(1),
    ds_justificativa               VARCHAR2(240),
    nr_contrato                    VARCHAR2(20),
    dt_inicio_contrato             DATE,
    dt_termino_contrato            DATE,
    cf_nr_item                     NUMBER(5),
    ds_item                        VARCHAR2(60),
    no_fornecedor                  VARCHAR2(60),
    ff_tp_pessoa                   NUMBER(1),
    ff_nr_cgc_cpf                  VARCHAR2(14),
    vl_unitario                    NUMBER(10,2),
    qtd_jan                        NUMBER(6),
    val_jan                        NUMBER(14,2),
    qtd_fev                        NUMBER(6),
    val_fev                        NUMBER(14,2),
    qtd_mar                        NUMBER(6),
    val_mar                        NUMBER(14,2),
    qtd_abr                        NUMBER(6),
    val_abr                        NUMBER(14,2),
    qtd_mai                        NUMBER(6),
    val_mai                        NUMBER(14,2),
    qtd_jun                        NUMBER(6),
    val_jun                        NUMBER(14,2),
    qtd_jul                        NUMBER(6),
    val_jul                        NUMBER(14,2),
    qtd_ago                        NUMBER(6),
    val_ago                        NUMBER(14,2),
    qtd_set                        NUMBER(6),
    val_set                        NUMBER(14,2),
    qtd_out                        NUMBER(6),
    val_out                        NUMBER(14,2),
    qtd_nov                        NUMBER(6),
    val_nov                        NUMBER(14,2),
    qtd_dez                        NUMBER(6),
    val_dez                        NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA

ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, nr_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_PROPOSTA_ORCAMENTARIA

-- Start of DDL Script for Table IFRDBA2.ITEM_REQUISICAO
-- Generated 9-mar-2004 18:59:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_requisicao
    (os_aa_ordem_servico            NUMBER(4) NOT NULL,
    os_nr_ordem_servico            NUMBER(6) NOT NULL,
    sq_item                        NUMBER(3) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    qt_solicitada                  NUMBER(12,2) NOT NULL,
    qt_atendida                    NUMBER(12,2),
    vl_total                       NUMBER(17,5),
    vl_unitario                    NUMBER(17,5),
    emp_nr_matricula_rec           NUMBER(7),
    apl_cd_aplicacao               CHAR(3),
    in_rc_gerada                   NUMBER(1),
    cd_orcamentario                VARCHAR2(30),
    qt_aplicar                     NUMBER(12,2),
    qt_estocar                     NUMBER(12,2),
    qt_prazo_dias                  NUMBER(4),
    dep_cd_dependencia_compra      NUMBER(4),
    cc1_nr_conta                   VARCHAR2(20),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_centro_custo_gestor         NUMBER(5),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_REQUISICAO

CREATE INDEX ifrdba2.ir_ipd_fk ON ifrdba2.item_requisicao
  (
    ipd_dep_cd_dependencia          ASC,
    ipd_ig_ci_cd_classe             ASC,
    ipd_ig_cd_item                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_REQUISICAO

ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_pk PRIMARY KEY (os_aa_ordem_servico, os_nr_ordem_servico, 
  ipd_dep_cd_dependencia, sq_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ITEM_REQUISICAO

CREATE TRIGGER ifrdba2.trg_ir
BEFORE  DELETE 
ON ifrdba2.item_requisicao
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  LOG_DS_USUARIO VARCHAR2(50);
 BEGIN
  SELECT USER||' - '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
  INTO LOG_DS_USUARIO
  FROM DUAL;
  INSERT INTO LOG_ITEM_REQUISICAO
   (OS_AA_ORDEM_SERVICO,
    OS_NR_ORDEM_SERVICO,
    SQ_ITEM,
    IPD_DEP_CD_DEPENDENCIA,
    IPD_IG_CI_CD_CLASSE,
    IPD_IG_CD_ITEM,
    QT_SOLICITADA,
    QT_ATENDIDA,
    VL_TOTAL,
    VL_UNITARIO,
    EMP_NR_MATRICULA_REC,
    APL_CD_APLICACAO,
    IN_RC_GERADA,
    CD_ORCAMENTARIO,
    QT_APLICAR,
    QT_ESTOCAR,
    QT_PRAZO_DIAS,
    DEP_CD_DEPENDENCIA_COMPRA,
    CC1_NR_CONTA,
    CD_PROGRAMA,
    CD_PROJETO,
    CD_CENTRO_CUSTO_GESTOR,
    DS_USUARIO)
  VALUES
   (:OLD.OS_AA_ORDEM_SERVICO,
    :OLD.OS_NR_ORDEM_SERVICO,
    :OLD.SQ_ITEM,
    :OLD.IPD_DEP_CD_DEPENDENCIA,
    :OLD.IPD_IG_CI_CD_CLASSE,
    :OLD.IPD_IG_CD_ITEM,
    :OLD.QT_SOLICITADA,
    :OLD.QT_ATENDIDA,
    :OLD.VL_TOTAL,
    :OLD.VL_UNITARIO,
    :OLD.EMP_NR_MATRICULA_REC,
    :OLD.APL_CD_APLICACAO,
    :OLD.IN_RC_GERADA,
    :OLD.CD_ORCAMENTARIO,
    :OLD.QT_APLICAR,
    :OLD.QT_ESTOCAR,
    :OLD.QT_PRAZO_DIAS,
    :OLD.DEP_CD_DEPENDENCIA_COMPRA,
    :OLD.CC1_NR_CONTA,
    :OLD.CD_PROGRAMA,
    :OLD.CD_PROJETO,
    :OLD.CD_CENTRO_CUSTO_GESTOR,
    LOG_DS_USUARIO);
 END;
/

-- Comments for IFRDBA2.ITEM_REQUISICAO

COMMENT ON TABLE ifrdba2.item_requisicao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_REQUISICAO

-- Start of DDL Script for Table IFRDBA2.ITEM_SAIDA_ESTOQUE
-- Generated 9-mar-2004 19:00:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_saida_estoque
    (se_dep_cd_dependencia          NUMBER(4) NOT NULL,
    se_aa_saida                    NUMBER(4) NOT NULL,
    se_nr_saida                    NUMBER(5) NOT NULL,
    sq_item                        NUMBER(3) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    qt_item                        NUMBER(12,2) NOT NULL,
    vl_unitario                    NUMBER(15,5) NOT NULL,
    vl_total                       NUMBER(15,2) NOT NULL,
    in_propriedade                 NUMBER(1) NOT NULL,
    ir_sq_item                     NUMBER(3),
    ir_os_aa_ordem_servico         NUMBER(4),
    ir_os_nr_ordem_servico         NUMBER(6),
    nr_lote                        NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_SAIDA_ESTOQUE

CREATE INDEX ifrdba2.item_saida_estoque_ind1 ON ifrdba2.item_saida_estoque
  (
    ipd_dep_cd_dependencia          ASC,
    ipd_ig_ci_cd_classe             ASC,
    ipd_ig_cd_item                  ASC,
    ir_os_aa_ordem_servico          ASC,
    ir_os_nr_ordem_servico          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_SAIDA_ESTOQUE

ALTER TABLE ifrdba2.item_saida_estoque
ADD CONSTRAINT ise_pk PRIMARY KEY (se_dep_cd_dependencia, se_aa_saida, 
  se_nr_saida, sq_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ITEM_SAIDA_ESTOQUE

-- Start of DDL Script for Table IFRDBA2.ITEM_SMS_OUTRA_DEPENDENCIA
-- Generated 9-mar-2004 19:00:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.item_sms_outra_dependencia
    (sod_aa_sms                     NUMBER(4) NOT NULL,
    sod_nr_sms                     NUMBER(8) NOT NULL,
    sod_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    dt_entrega_item                DATE NOT NULL,
    qt_fornecer                    NUMBER(12,2) NOT NULL,
    vl_unitario                    NUMBER(17,5) NOT NULL,
    dt_efetiva_entrega             DATE,
    in_situacao                    NUMBER(1),
    qt_recebida                    NUMBER(12,2),
    sq_item                        NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ITEM_SMS_OUTRA_DEPENDENCIA

CREATE INDEX ifrdba2.iso_ipd_fk ON ifrdba2.item_sms_outra_dependencia
  (
    ipd_dep_cd_dependencia          ASC,
    ipd_ig_ci_cd_classe             ASC,
    ipd_ig_cd_item                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ITEM_SMS_OUTRA_DEPENDENCIA

ALTER TABLE ifrdba2.item_sms_outra_dependencia
ADD CONSTRAINT iso_pk PRIMARY KEY (sod_aa_sms, sod_nr_sms, 
  sod_dep_cd_dependencia, ipd_ig_ci_cd_classe, ipd_ig_cd_item, 
  ipd_dep_cd_dependencia, sq_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ITEM_SMS_OUTRA_DEPENDENCIA

COMMENT ON TABLE ifrdba2.item_sms_outra_dependencia IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ITEM_SMS_OUTRA_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.LANC_TES_TEMP
-- Generated 9-mar-2004 19:00:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lanc_tes_temp
    (nr_lancamento                  NUMBER(38),
    cc1_nr_conta                   VARCHAR2(20),
    vl_lancamento                  NUMBER(14,2),
    fpg_cd_forma_pgto              VARCHAR2(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LANC_TES_TEMP

-- Start of DDL Script for Table IFRDBA2.LANCAMENTO_CONTABIL
-- Generated 9-mar-2004 19:00:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lancamento_contabil
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    evc_nr_evento                  NUMBER(5) NOT NULL,
    dt_lancamento_contabil         DATE NOT NULL,
    nr_seq                         NUMBER(4) NOT NULL,
    tdc_tp_documento               NUMBER(2) NOT NULL,
    nr_documento                   VARCHAR2(10) NOT NULL,
    dt_documento                   DATE NOT NULL,
    no_pessoa                      VARCHAR2(30),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_centro_custo                NUMBER(5),
    in_validacao                   VARCHAR2(1) NOT NULL,
    dep_cd_dependencia_dest        NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.LANCAMENTO_CONTABIL

CREATE INDEX ifrdba2.lac_dep_fk_i ON ifrdba2.lancamento_contabil
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.lac_evc_fk_i ON ifrdba2.lancamento_contabil
  (
    evc_nr_evento                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.lac_tdc_fk_i ON ifrdba2.lancamento_contabil
  (
    tdc_tp_documento                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.LANCAMENTO_CONTABIL

ALTER TABLE ifrdba2.lancamento_contabil
ADD CONSTRAINT lac_pk PRIMARY KEY (dep_cd_dependencia, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LANCAMENTO_CONTABIL

-- Start of DDL Script for Table IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL
-- Generated 9-mar-2004 19:00:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lancamento_contabil_material
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    aa_documento                   NUMBER(4) NOT NULL,
    nr_documento                   NUMBER(5) NOT NULL,
    sq_item                        NUMBER(3) NOT NULL,
    cd_natureza                    CHAR(4) NOT NULL,
    cd_dependencia_credito         NUMBER(4) NOT NULL,
    cd_dependencia_debito          NUMBER(4) NOT NULL,
    vl_lancamento_contabil         NUMBER(15,2) NOT NULL,
    dt_lancamento_contabil         DATE NOT NULL,
    cd_conta_contabil_credito      VARCHAR2(20) NOT NULL,
    cd_conta_contabil_debito       VARCHAR2(20) NOT NULL,
    cd_centro_custo_credito        NUMBER(5),
    cd_centro_custo_debito         NUMBER(5),
    cd_aplicacao                   CHAR(3),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL

ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_pk PRIMARY KEY (dep_cd_dependencia, aa_documento, 
  nr_documento, sq_item, cd_natureza)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LANCAMENTO_CONTABIL_MATERIAL

-- Start of DDL Script for Table IFRDBA2.LANCAMENTO_TESOURARIA
-- Generated 9-mar-2004 19:00:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lancamento_tesouraria
    (cc_ban_cd_banco                VARCHAR2(3),
    cc_tcc_tp_conta_corrente       VARCHAR2(1),
    nr_lancamento                  NUMBER(38) NOT NULL,
    dt_lancamento                  DATE NOT NULL,
    vl_lancamento                  NUMBER(14,2) NOT NULL,
    dt_baixa_tesouraria            DATE,
    cc1_nr_conta                   VARCHAR2(20),
    ff_dep_cd_dependencia          NUMBER(4),
    ff_tp_pessoa                   NUMBER(1),
    ff_nr_cgc_cpf                  VARCHAR2(14),
    tp_favorecido                  NUMBER(1),
    emp_nr_matricula               NUMBER(7),
    usu_nr_cgc_cpf                 VARCHAR2(14),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    dt_baixa_banco                 DATE,
    dt_baixa_contabil              DATE,
    dt_baixa_mdc                   DATE,
    no_favorecido                  VARCHAR2(60),
    dt_cancelamento                DATE,
    rsg_apl_nr_aplicacao           NUMBER(8),
    rsg_dt_referencia              DATE,
    nu_seq_ano                     NUMBER(3),
    nu_seq_mes                     NUMBER(4),
    nr_lanc_dep                    NUMBER(9) NOT NULL,
    dt_efetivacao                  DATE,
    usu_dep_cd_dependencia         NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LANCAMENTO_TESOURARIA

ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_pk PRIMARY KEY (nr_lancamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_uk UNIQUE (dep_cd_dependencia, nr_lanc_dep)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LANCAMENTO_TESOURARIA

-- Start of DDL Script for Table IFRDBA2.LANCAMENTO_TIPO_DESP_RECEITA
-- Generated 9-mar-2004 19:00:34 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lancamento_tipo_desp_receita
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    num_lancamento_dependencia     NUMBER(9) NOT NULL,
    tdr_cd_despesa_receita         VARCHAR2(5) NOT NULL,
    cc_num_conta_contabil          VARCHAR2(20),
    val_conta                      NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LANCAMENTO_TIPO_DESP_RECEITA

ALTER TABLE ifrdba2.lancamento_tipo_desp_receita
ADD CONSTRAINT lanc_tipo_desp_receita_pk PRIMARY KEY (dep_cd_dependencia, 
  num_lancamento_dependencia, tdr_cd_despesa_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LANCAMENTO_TIPO_DESP_RECEITA

-- Start of DDL Script for Table IFRDBA2.LOCALIDADES_INFRAERO
-- Generated 9-mar-2004 19:00:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.localidades_infraero
    (loi_codigo                     NUMBER(3) NOT NULL,
    loi_nome                       VARCHAR2(30) NOT NULL,
    loi_sigla_uf                   VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LOCALIDADES_INFRAERO

ALTER TABLE ifrdba2.localidades_infraero
ADD CONSTRAINT loi_pk PRIMARY KEY (loi_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.localidades_infraero
ADD CONSTRAINT loi_uk UNIQUE (loi_nome)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.LOCALIDADES_INFRAERO

COMMENT ON TABLE ifrdba2.localidades_infraero IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.LOCALIDADES_INFRAERO

-- Start of DDL Script for Table IFRDBA2.LOG_AUX_COENV_SIMBEP
-- Generated 9-mar-2004 19:00:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_aux_coenv_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    com_dthrreg_pk                 DATE NOT NULL,
    com_seq_pk                     NUMBER(6) NOT NULL,
    com_dthrenv                    DATE NOT NULL,
    com_tipcom                     NUMBER(1),
    com_endcom                     VARCHAR2(50),
    com_assunto                    VARCHAR2(100),
    com_mensagem                   VARCHAR2(2000),
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_AUX_COENV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_AUX_EQMOV_SIMBEP
-- Generated 9-mar-2004 19:00:45 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_aux_eqmov_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    eqmov_seq_pk                   NUMBER(6) NOT NULL,
    eqmov_tipo                     NUMBER(1) NOT NULL,
    eqmov_codeqp_ak                VARCHAR2(20) NOT NULL,
    eqmov_ntb_aceite               VARCHAR2(1),
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_AUX_EQMOV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_AUX_EVENT_SIMBEP
-- Generated 9-mar-2004 19:00:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_aux_event_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    eve_seq_pk                     NUMBER(6) NOT NULL,
    tpeve_cod_pk                   NUMBER(2) NOT NULL,
    eve_dthr                       DATE NOT NULL,
    eve_area                       NUMBER(6),
    eve_coletor                    VARCHAR2(1),
    oper_cracha_pk                 VARCHAR2(20),
    eve_codequip                   VARCHAR2(20),
    eve_resporig                   VARCHAR2(20),
    eve_respdest                   VARCHAR2(20),
    eve_execut                     VARCHAR2(20),
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_AUX_EVENT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_CUSTODIA
-- Generated 9-mar-2004 19:00:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_custodia
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    tp_operacao                    VARCHAR2(1) NOT NULL,
    nu_operacao                    NUMBER(5) NOT NULL,
    no_depositante                 VARCHAR2(40) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5),
    dt_operacao                    DATE NOT NULL,
    dt_vencimento                  DATE,
    dt_devolucao                   DATE,
    vl_custodia                    NUMBER(14,2) NOT NULL,
    nu_documento                   VARCHAR2(20) NOT NULL,
    nu_edital                      VARCHAR2(20),
    oca_cd_origem_caucao           VARCHAR2(3) NOT NULL,
    ds_observacao                  VARCHAR2(50),
    st_custodia                    VARCHAR2(1) NOT NULL,
    nu_contrato                    VARCHAR2(20),
    tga_cd_tp_garantia             VARCHAR2(3) NOT NULL,
    ban_cd_banco                   VARCHAR2(3),
    seg_cd_seguradora              VARCHAR2(3),
    vl_correcao                    NUMBER(14,2),
    vl_devolucao                   NUMBER(14,2),
    ds_endereco                    VARCHAR2(50),
    no_cidade                      VARCHAR2(30),
    sg_uf                          VARCHAR2(2),
    nu_cep                         NUMBER(8),
    evc_nr_evento_rcb              NUMBER(5) NOT NULL,
    eti_cd_especie_titulo          VARCHAR2(3),
    evc_nr_evento_apr              NUMBER(5),
    nr_cgc_cpf                     VARCHAR2(14),
    dt_ultima_apr                  DATE,
    cod_corretora                  VARCHAR2(3),
    dta_operacao                   DATE NOT NULL,
    tip_operacao                   VARCHAR2(1) NOT NULL,
    cod_usuario                    VARCHAR2(30) NOT NULL,
    nu_operacao_endossada          NUMBER(5),
    uor_codigo                     NUMBER(9))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_CUSTODIA

-- Start of DDL Script for Table IFRDBA2.LOG_DATA_CONTROLE
-- Generated 9-mar-2004 19:00:49 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_data_controle
    (aa_referencia                  NUMBER(4) NOT NULL,
    mm_referencia                  NUMBER(2) NOT NULL,
    dt_fechamento_contabil         DATE NOT NULL,
    dt_manutencao                  DATE NOT NULL,
    cd_usuario                     VARCHAR2(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_DATA_CONTROLE

-- Start of DDL Script for Table IFRDBA2.LOG_HORA_LIMITE_SP
-- Generated 9-mar-2004 19:00:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_hora_limite_sp
    (hls_dep_cd_dependencia         NUMBER(4) NOT NULL,
    dt_manutencao                  DATE NOT NULL,
    hr_limite_sp                   DATE NOT NULL,
    cd_usuario                     VARCHAR2(10) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LOG_HORA_LIMITE_SP

ALTER TABLE ifrdba2.log_hora_limite_sp
ADD CONSTRAINT lhl_pk PRIMARY KEY (hls_dep_cd_dependencia, dt_manutencao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_HORA_LIMITE_SP

-- Start of DDL Script for Table IFRDBA2.LOG_HST_EQTER_SIMBEP
-- Generated 9-mar-2004 19:00:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_hst_eqter_simbep
    (heqt_cod_pk                    VARCHAR2(20) NOT NULL,
    heqt_usu                       VARCHAR2(20),
    heqt_dthrent                   DATE NOT NULL,
    heqt_dthrsai                   DATE,
    heqt_forn                      NUMBER(6),
    heqt_nf                        VARCHAR2(10),
    heqt_cracha                    VARCHAR2(20),
    heqt_dsc                       VARCHAR2(150),
    heqt_numserie                  VARCHAR2(50),
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_HST_EQTER_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_HST_RECEX_SIMBEP
-- Generated 9-mar-2004 19:00:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_hst_recex_simbep
    (hext_cracha                    VARCHAR2(20) NOT NULL,
    hext_matr                      NUMBER(7) NOT NULL,
    hext_est                       VARCHAR2(2) NOT NULL,
    hext_cid                       VARCHAR2(30) NOT NULL,
    hext_cep                       VARCHAR2(9) NOT NULL,
    hext_rg                        VARCHAR2(20) NOT NULL,
    hext_end                       VARCHAR2(50) NOT NULL,
    hext_nom                       VARCHAR2(50) NOT NULL,
    hext_tel                       VARCHAR2(20),
    hext_email                     VARCHAR2(50),
    hext_dtexcl                    DATE,
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_HST_RECEX_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_HST_VISIT_SIMBEP
-- Generated 9-mar-2004 19:01:00 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_hst_visit_simbep
    (hvis_cracha_pk                 VARCHAR2(20) NOT NULL,
    hvis_seq_pk                    NUMBER(6) NOT NULL,
    hvis_dthrentra                 DATE NOT NULL,
    hvis_dthrsaida                 DATE NOT NULL,
    hvis_forn                      NUMBER(6),
    hvis_rg                        VARCHAR2(15),
    hvis_cpf                       VARCHAR2(15),
    hvis_doc                       VARCHAR2(30),
    hvis_cod                       NUMBER(7) NOT NULL,
    hvis_nome                      VARCHAR2(50) NOT NULL,
    hvis_usu                       VARCHAR2(50) NOT NULL,
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_HST_VISIT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOG_ITEM_INEDITO
-- Generated 9-mar-2004 19:01:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_item_inedito
    (os_dep_cd_dependencia          NUMBER(4),
    os_aa_ordem_servico            NUMBER(4),
    os_nr_ordem_servico            NUMBER(6),
    sq_item                        NUMBER(2),
    ds_item                        VARCHAR2(60),
    cd_aplicacao                   CHAR(3),
    cd_orcamentario                VARCHAR2(30),
    cd_estocavel                   NUMBER(1),
    qt_prazo_dias                  NUMBER(4),
    qt_aplicar                     NUMBER(12,2),
    qt_estocar                     NUMBER(12,2),
    qt_comprar                     NUMBER(12,2),
    vl_previsto                    NUMBER(17,5),
    ds_complementar                VARCHAR2(2000),
    ui_cd_unidade                  VARCHAR2(4),
    dep_cd_dependencia_compra      NUMBER(4),
    cc1_nr_conta                   VARCHAR2(20),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_centro_custo_gestor         NUMBER(5),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_ITEM_INEDITO

-- Start of DDL Script for Table IFRDBA2.LOG_ITEM_MENSAL_PROP_ORC_SIM
-- Generated 9-mar-2004 19:01:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_item_mensal_prop_orc_sim
    (cd_nivel_versao                VARCHAR2(2) NOT NULL,
    cd_versao                      VARCHAR2(2) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    cd_dependencia                 NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    mm_item                        NUMBER(2) NOT NULL,
    vl_programado                  NUMBER(14,2) NOT NULL,
    qt_programado                  NUMBER(6),
    vl_programado_dolar            NUMBER(14,2),
    cd_usuario                     VARCHAR2(10) NOT NULL,
    dt_manutencao                  DATE NOT NULL,
    tp_manutencao                  VARCHAR2(1) NOT NULL,
    st_cd_nivel_versao             VARCHAR2(1),
    st_versao                      VARCHAR2(1),
    st_nr_ano                      VARCHAR2(1),
    st_cd_dependencia              VARCHAR2(1),
    st_nr_item                     VARCHAR2(1),
    st_mm_item                     VARCHAR2(1),
    st_vl_programado               VARCHAR2(1),
    st_qt_programado               VARCHAR2(1),
    st_vl_programado_dolar         VARCHAR2(1),
    st_cd_versao                   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.LOG_ITEM_MENSAL_PROP_ORC_SIM

CREATE INDEX ifrdba2.log_mes_ind_a ON ifrdba2.log_item_mensal_prop_orc_sim
  (
    cd_nivel_versao                 ASC,
    cd_versao                       ASC,
    nr_ano                          ASC,
    cd_dependencia                  ASC,
    nr_item                         ASC,
    mm_item                         ASC,
    cd_usuario                      ASC,
    dt_manutencao                   ASC,
    tp_manutencao                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRDBA2.LOG_ITEM_MENSAL_PROP_ORC_SIM

-- Start of DDL Script for Table IFRDBA2.LOG_ITEM_PROPOSTA_ORC_SIMULADA
-- Generated 9-mar-2004 19:01:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_item_proposta_orc_simulada
    (cd_nivel_versao                VARCHAR2(2) NOT NULL,
    cd_versao                      VARCHAR2(2) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    cd_dependencia                 NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    cd_centro_custo                NUMBER(5) NOT NULL,
    cd_centro_custo_gerd           NUMBER(5) NOT NULL,
    cd_dependencia_gerd            NUMBER(4) NOT NULL,
    cd_programa                    NUMBER(3) NOT NULL,
    cd_projeto                     VARCHAR2(4) NOT NULL,
    in_centralizado                NUMBER(1) NOT NULL,
    cd_prioridade                  NUMBER(1) NOT NULL,
    vl_unitario_item               NUMBER(10,2),
    nr_contrato                    VARCHAR2(20),
    dt_inicio_contrato             DATE,
    dt_termino_contrato            DATE,
    ds_justificativa               VARCHAR2(240),
    ds_item                        VARCHAR2(60),
    cf_nr_item                     NUMBER(5),
    tp_pessoa                      NUMBER(1),
    nr_cgc_cpf                     VARCHAR2(14),
    no_fornecedor                  VARCHAR2(60),
    vl_unitario_item_dolar         NUMBER(10,2),
    cd_usuario                     VARCHAR2(10) NOT NULL,
    dt_manutencao                  DATE NOT NULL,
    tp_manutencao                  VARCHAR2(1) NOT NULL,
    in_considera_log               VARCHAR2(1) NOT NULL,
    st_cd_nivel_versao             VARCHAR2(1),
    st_cd_versao                   VARCHAR2(1),
    st_nr_ano                      VARCHAR2(1),
    st_cd_dependencia              VARCHAR2(1),
    st_nr_item                     VARCHAR2(1),
    st_cc1_nr_conta                VARCHAR2(1),
    st_cd_centro_custo             VARCHAR2(1),
    st_cd_centro_custo_gerd        VARCHAR2(1),
    st_cd_programa                 VARCHAR2(1),
    st_cd_projeto                  VARCHAR2(1),
    st_in_centralizado             VARCHAR2(1),
    st_cd_prioridade               VARCHAR2(1),
    st_vl_unitario_item            VARCHAR2(1),
    st_nr_contrato                 VARCHAR2(1),
    st_dt_inicio_contrato          VARCHAR2(1),
    st_dt_termino_contrato         VARCHAR2(1),
    st_ds_justificativa            VARCHAR2(1),
    st_ds_item                     VARCHAR2(1),
    st_cf_nr_item                  VARCHAR2(1),
    st_tp_pessoa                   VARCHAR2(1),
    st_nr_cgc_cpf                  VARCHAR2(1),
    st_no_fornecedor               VARCHAR2(1),
    st_vl_unitario_item_dolar      VARCHAR2(1),
    st_dependencia_gerd            VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.LOG_ITEM_PROPOSTA_ORC_SIMULADA

CREATE INDEX ifrdba2.log_ind_f ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_dependencia                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_a ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_nivel_versao                 ASC,
    cd_versao                       ASC,
    nr_ano                          ASC,
    cd_dependencia                  ASC,
    nr_item                         ASC,
    cd_usuario                      ASC,
    dt_manutencao                   ASC,
    tp_manutencao                   ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_c ON ifrdba2.log_item_proposta_orc_simulada
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_d ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_centro_custo                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_e ON ifrdba2.log_item_proposta_orc_simulada
  (
    cf_nr_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_g ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_programa                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_h ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_projeto                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.log_ind_b ON ifrdba2.log_item_proposta_orc_simulada
  (
    cd_nivel_versao                 ASC,
    cd_versao                       ASC,
    nr_ano                          ASC,
    cd_dependencia                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- End of DDL Script for Table IFRDBA2.LOG_ITEM_PROPOSTA_ORC_SIMULADA

-- Start of DDL Script for Table IFRDBA2.LOG_ITEM_REQUISICAO
-- Generated 9-mar-2004 19:01:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_item_requisicao
    (os_aa_ordem_servico            NUMBER(4),
    os_nr_ordem_servico            NUMBER(6),
    sq_item                        NUMBER(3),
    ipd_dep_cd_dependencia         NUMBER(4),
    ipd_ig_ci_cd_classe            VARCHAR2(4),
    ipd_ig_cd_item                 VARCHAR2(7),
    qt_solicitada                  NUMBER(12,2),
    qt_atendida                    NUMBER(12,2),
    vl_total                       NUMBER(17,5),
    vl_unitario                    NUMBER(17,5),
    emp_nr_matricula_rec           NUMBER(7),
    apl_cd_aplicacao               CHAR(3),
    in_rc_gerada                   NUMBER(1),
    cd_orcamentario                VARCHAR2(30),
    qt_aplicar                     NUMBER(12,2),
    qt_estocar                     NUMBER(12,2),
    qt_prazo_dias                  NUMBER(4),
    dep_cd_dependencia_compra      NUMBER(4),
    cc1_nr_conta                   VARCHAR2(20),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_centro_custo_gestor         NUMBER(5),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_ITEM_REQUISICAO

-- Start of DDL Script for Table IFRDBA2.LOG_ITENS_PROPOSTAS_ORCAMENTOS
-- Generated 9-mar-2004 19:01:25 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_itens_propostas_orcamentos
    (cod_usuario                    VARCHAR2(10) NOT NULL,
    dat_manutencao                 DATE NOT NULL,
    tip_manutencao                 VARCHAR2(1) NOT NULL,
    nr_ano                         NUMBER(4),
    cd_dependencia                 NUMBER(4),
    cd_nivel_versao                VARCHAR2(2),
    cd_versao                      VARCHAR2(2),
    cd_dependencia_soli            NUMBER(4),
    nr_item                        NUMBER(5),
    nr_conta                       VARCHAR2(20),
    cd_centro_custo                NUMBER(5),
    cd_programa                    NUMBER(3),
    cd_projeto                     VARCHAR2(4),
    cd_dependencia_gerd            NUMBER(4),
    cd_centro_custo_gerd           NUMBER(5),
    in_centralizado                NUMBER(1),
    cd_dependencia_gest            NUMBER(4),
    cd_centro_custo_gest           NUMBER(5),
    cd_prioridade                  NUMBER(1),
    cd_grupo                       NUMBER(4),
    ds_item                        VARCHAR2(60),
    nr_contrato                    VARCHAR2(20),
    dt_inicio_contrato             DATE,
    dt_termino_contrato            DATE,
    no_fornecedor                  VARCHAR2(60),
    ds_justificativa               VARCHAR2(240),
    in_dimensionamento             VARCHAR2(1),
    val_unitario                   NUMBER(10,2),
    qtd_jan                        NUMBER(7),
    qtd_fev                        NUMBER(7),
    qtd_mar                        NUMBER(7),
    qtd_abr                        NUMBER(7),
    qtd_mai                        NUMBER(7),
    qtd_jun                        NUMBER(7),
    qtd_jul                        NUMBER(7),
    qtd_ago                        NUMBER(7),
    qtd_set                        NUMBER(7),
    qtd_out                        NUMBER(7),
    qtd_nov                        NUMBER(7),
    qtd_dez                        NUMBER(7),
    val_unitario1                  NUMBER(10,2),
    qtd_jan1                       NUMBER(7),
    qtd_fev1                       NUMBER(7),
    qtd_mar1                       NUMBER(7),
    qtd_abr1                       NUMBER(7),
    qtd_mai1                       NUMBER(7),
    qtd_jun1                       NUMBER(7),
    qtd_jul1                       NUMBER(7),
    qtd_ago1                       NUMBER(7),
    qtd_set1                       NUMBER(7),
    qtd_out1                       NUMBER(7),
    qtd_nov1                       NUMBER(7),
    qtd_dez1                       NUMBER(7),
    val_unitario2                  NUMBER(10,2),
    qtd_jan2                       NUMBER(7),
    qtd_fev2                       NUMBER(7),
    qtd_mar2                       NUMBER(7),
    qtd_abr2                       NUMBER(7),
    qtd_mai2                       NUMBER(7),
    qtd_jun2                       NUMBER(7),
    qtd_jul2                       NUMBER(7),
    qtd_ago2                       NUMBER(7),
    qtd_set2                       NUMBER(7),
    qtd_out2                       NUMBER(7),
    qtd_nov2                       NUMBER(7),
    qtd_dez2                       NUMBER(7),
    val_unitario3                  NUMBER(10,2),
    qtd_jan3                       NUMBER(7),
    qtd_fev3                       NUMBER(7),
    qtd_mar3                       NUMBER(7),
    qtd_abr3                       NUMBER(7),
    qtd_mai3                       NUMBER(7),
    qtd_jun3                       NUMBER(7),
    qtd_jul3                       NUMBER(7),
    qtd_ago3                       NUMBER(7),
    qtd_set3                       NUMBER(7),
    qtd_out3                       NUMBER(7),
    qtd_nov3                       NUMBER(7),
    qtd_dez3                       NUMBER(7),
    val_unitario4                  NUMBER(10,2),
    qtd_jan4                       NUMBER(7),
    qtd_fev4                       NUMBER(7),
    qtd_mar4                       NUMBER(7),
    qtd_abr4                       NUMBER(7),
    qtd_mai4                       NUMBER(7),
    qtd_jun4                       NUMBER(7),
    qtd_jul4                       NUMBER(7),
    qtd_ago4                       NUMBER(7),
    qtd_set4                       NUMBER(7),
    qtd_out4                       NUMBER(7),
    qtd_nov4                       NUMBER(7),
    qtd_dez4                       NUMBER(7),
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2),
    val_jan1                       NUMBER(14,2),
    val_fev1                       NUMBER(14,2),
    val_mar1                       NUMBER(14,2),
    val_abr1                       NUMBER(14,2),
    val_mai1                       NUMBER(14,2),
    val_jun1                       NUMBER(14,2),
    val_jul1                       NUMBER(14,2),
    val_ago1                       NUMBER(14,2),
    val_set1                       NUMBER(14,2),
    val_out1                       NUMBER(14,2),
    val_nov1                       NUMBER(14,2),
    val_dez1                       NUMBER(14,2),
    val_jan2                       NUMBER(14,2),
    val_fev2                       NUMBER(14,2),
    val_mar2                       NUMBER(14,2),
    val_abr2                       NUMBER(14,2),
    val_mai2                       NUMBER(14,2),
    val_jun2                       NUMBER(14,2),
    val_jul2                       NUMBER(14,2),
    val_ago2                       NUMBER(14,2),
    val_set2                       NUMBER(14,2),
    val_out2                       NUMBER(14,2),
    val_nov2                       NUMBER(14,2),
    val_dez2                       NUMBER(14,2),
    val_jan3                       NUMBER(14,2),
    val_fev3                       NUMBER(14,2),
    val_mar3                       NUMBER(14,2),
    val_abr3                       NUMBER(14,2),
    val_mai3                       NUMBER(14,2),
    val_jun3                       NUMBER(14,2),
    val_jul3                       NUMBER(14,2),
    val_ago3                       NUMBER(14,2),
    val_set3                       NUMBER(14,2),
    val_out3                       NUMBER(14,2),
    val_nov3                       NUMBER(14,2),
    val_dez3                       NUMBER(14,2),
    val_jan4                       NUMBER(14,2),
    val_fev4                       NUMBER(14,2),
    val_mar4                       NUMBER(14,2),
    val_abr4                       NUMBER(14,2),
    val_mai4                       NUMBER(14,2),
    val_jun4                       NUMBER(14,2),
    val_jul4                       NUMBER(14,2),
    val_ago4                       NUMBER(14,2),
    val_set4                       NUMBER(14,2),
    val_out4                       NUMBER(14,2),
    val_nov4                       NUMBER(14,2),
    val_dez4                       NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_ITENS_PROPOSTAS_ORCAMENTOS

-- Start of DDL Script for Table IFRDBA2.LOG_ORDEM_SERVICO
-- Generated 9-mar-2004 19:01:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_ordem_servico
    (aa_ordem_servico               NUMBER(4),
    nr_ordem_servico               NUMBER(6),
    dep_cd_dependencia             NUMBER(4),
    dt_ordem_servico               DATE,
    dt_autorizacao                 DATE,
    in_aberta                      NUMBER(1),
    cc_cd_centro_custo             NUMBER(5),
    emp_nr_matricula_req           NUMBER(7),
    emp_nr_matricula_aut           NUMBER(7),
    uo_cd_unid_organ               NUMBER(9),
    ds_servico                     VARCHAR2(2000),
    in_mat_serv                    NUMBER(1),
    cd_aplicacao                   VARCHAR2(3),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_ORDEM_SERVICO

-- Start of DDL Script for Table IFRDBA2.LOG_SEG_USUARIO_SISTEMA
-- Generated 9-mar-2004 19:01:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_seg_usuario_sistema
    (su_id_usuario                  VARCHAR2(10) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    sgu_cd_grupo                   NUMBER(2) NOT NULL,
    ds_usuario                     VARCHAR2(100),
    id_gerente_sistema             VARCHAR2(1) NOT NULL,
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_SEG_USUARIO_SISTEMA

-- Start of DDL Script for Table IFRDBA2.LOG_SIT_MENSAL_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:01:30 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_sit_mensal_bem_patrimonial
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    vl_bem_cor_bal_ant_mo          NUMBER(17,2) NOT NULL,
    vl_bem_cor_ate_mes_mo          NUMBER(17,2) NOT NULL,
    vl_cm_bem_mes_mo               NUMBER(17,2) NOT NULL,
    vl_cm_bem_ate_mes_mo           NUMBER(17,2) NOT NULL,
    vl_dp_acum_bal_ant_mr          NUMBER(17,4) NOT NULL,
    vl_dp_acum_cor_bal_ant_mo      NUMBER(17,2) NOT NULL,
    vl_dp_acum_ate_mes_mr          NUMBER(17,4) NOT NULL,
    vl_dp_acum_cor_ate_mes_mo      NUMBER(17,2) NOT NULL,
    vl_dp_mes_mo                   NUMBER(17,2) NOT NULL,
    vl_dp_acum_ate_mes_mo          NUMBER(17,2) NOT NULL,
    vl_cm_dp_mes_mo                NUMBER(17,2) NOT NULL,
    vl_cm_dp_ate_mes_mo            NUMBER(17,2) NOT NULL,
    vl_dp_acum_bal_ant_mo          NUMBER(17,2) NOT NULL,
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4),
    no_usuario                     VARCHAR2(30),
    dt_ocorrencia                  DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_SIT_MENSAL_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.LOG_TAB_EQADQ_SIMBEP
-- Generated 9-mar-2004 19:01:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.log_tab_eqadq_simbep
    (eqadq_cod_pk                   VARCHAR2(20) NOT NULL,
    eqadq_fornec                   NUMBER(6) NOT NULL,
    eqadq_nf                       VARCHAR2(10) NOT NULL,
    eqadq_dthrsai                  DATE,
    eqadq_qtd                      NUMBER(6),
    eqadq_dsc_qtd                  VARCHAR2(200),
    dt_geracao                     DATE,
    tp_geracao                     VARCHAR2(1),
    quem_gerou                     VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.LOG_TAB_EQADQ_SIMBEP

-- Start of DDL Script for Table IFRDBA2.LOTE_ESTOQUE
-- Generated 9-mar-2004 19:01:34 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lote_estoque
    (ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    in_propriedade                 NUMBER(1) NOT NULL,
    nr_lote                        NUMBER(9) NOT NULL,
    qt_estoque_atual               NUMBER(12,2) NOT NULL,
    ds_local_estocagem             VARCHAR2(25),
    dt_limite_validade             DATE,
    vl_custo_medio_unitario        NUMBER(17,5),
    qt_inventariada                NUMBER(12,2),
    dt_inventario                  DATE,
    in_auditoria                   NUMBER(1),
    in_etiqueta                    NUMBER(1),
    dt_emissao_etiqueta            DATE,
    ca_cd_condicao                 NUMBER(2) NOT NULL,
    in_loc_remota                  NUMBER(1),
    ds_usuario                     VARCHAR2(50),
    in_material                    NUMBER(1),
    cd_sistema                     NUMBER(5),
    in_ordem                       NUMBER(1),
    nr_relacao                     NUMBER(5),
    qt_disponivel                  NUMBER(12,2),
    qt_inventario                  NUMBER(12,2),
    vl_residuo                     NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LOTE_ESTOQUE

ALTER TABLE ifrdba2.lote_estoque
ADD CONSTRAINT le_pk PRIMARY KEY (ipd_dep_cd_dependencia, ipd_ig_ci_cd_classe, 
  ipd_ig_cd_item, nr_lote)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.LOTE_ESTOQUE

COMMENT ON TABLE ifrdba2.lote_estoque IS 'SISMAT - '
/

-- End of DDL Script for Table IFRDBA2.LOTE_ESTOQUE

-- Start of DDL Script for Table IFRDBA2.LOTE_REQUISICOES_COMPRAS
-- Generated 9-mar-2004 19:01:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.lote_requisicoes_compras
    (sq_lote                        NUMBER(8) NOT NULL,
    dt_agrupamento_rc              DATE NOT NULL,
    aa_nr_pedido                   NUMBER(4),
    nr_pedido                      NUMBER(6),
    tp_pedido                      VARCHAR2(1),
    st_pedido                      NUMBER(1),
    mdl_cd_modalidade              NUMBER(2),
    tp_faixa_modalidade            NUMBER(1),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    tp_lote                        NUMBER(1) NOT NULL,
    tx_observacao                  VARCHAR2(2000),
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.LOTE_REQUISICOES_COMPRAS

ALTER TABLE ifrdba2.lote_requisicoes_compras
ADD CONSTRAINT lrc_pk PRIMARY KEY (sq_lote)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.LOTE_REQUISICOES_COMPRAS

COMMENT ON TABLE ifrdba2.lote_requisicoes_compras IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.LOTE_REQUISICOES_COMPRAS

-- Start of DDL Script for Table IFRDBA2.MATERIAL_CENTRO_CUSTO
-- Generated 9-mar-2004 19:01:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.material_centro_custo
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    id_usuario                     VARCHAR2(10) NOT NULL,
    cd_centro_custo_gestor         NUMBER(5) NOT NULL,
    cd_centro_custo_autoriza       NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MATERIAL_CENTRO_CUSTO

ALTER TABLE ifrdba2.material_centro_custo
ADD CONSTRAINT mcc_pk PRIMARY KEY (dep_cd_dependencia, id_usuario, 
  cd_centro_custo_gestor, cd_centro_custo_autoriza)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MATERIAL_CENTRO_CUSTO

-- Start of DDL Script for Table IFRDBA2.MEDIA_ARRECADACAO
-- Generated 9-mar-2004 19:01:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.media_arrecadacao
    (tdr_cd_despesa_receita         VARCHAR2(5) NOT NULL,
    vl_media_arrecadacao           NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MEDIA_ARRECADACAO

ALTER TABLE ifrdba2.media_arrecadacao
ADD CONSTRAINT mea_pk PRIMARY KEY (tdr_cd_despesa_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MEDIA_ARRECADACAO

-- Start of DDL Script for Table IFRDBA2.MEDIA_MENSAL_SERIE_MONETARIA
-- Generated 9-mar-2004 19:01:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.media_mensal_serie_monetaria
    (cd_serie                       NUMBER(3) NOT NULL,
    ma_serie                       NUMBER(6) NOT NULL,
    vl_media_serie                 NUMBER(15,4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MEDIA_MENSAL_SERIE_MONETARIA

ALTER TABLE ifrdba2.media_mensal_serie_monetaria
ADD CONSTRAINT mmsm_pk PRIMARY KEY (cd_serie, ma_serie)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MEDIA_MENSAL_SERIE_MONETARIA

-- Start of DDL Script for Table IFRDBA2.MEMBRO_COMISSAO_LICITACAO
-- Generated 9-mar-2004 19:01:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.membro_comissao_licitacao
    (cl_pl_aa_processo              NUMBER(4) NOT NULL,
    cl_pl_sq_processo              NUMBER(4) NOT NULL,
    cl_pl_dep_cd_dependencia_deten NUMBER(4) NOT NULL,
    cl_pl_mdl_cd_modalidade        NUMBER(2) NOT NULL,
    sq_dupla                       NUMBER(2) NOT NULL,
    uo_cd_unid_organ               NUMBER(9),
    emp_nr_matricula_titular       NUMBER(7),
    emp_nr_matricula_suplente      NUMBER(7),
    in_presidente_comissao         NUMBER(1),
    cl_tp_comissao                 NUMBER(1) NOT NULL,
    in_secretario_comissao         NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MEMBRO_COMISSAO_LICITACAO

ALTER TABLE ifrdba2.membro_comissao_licitacao
ADD CONSTRAINT mcl_pk PRIMARY KEY (cl_pl_aa_processo, cl_pl_sq_processo, 
  cl_pl_dep_cd_dependencia_deten, cl_pl_mdl_cd_modalidade, sq_dupla, 
  cl_tp_comissao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.MEMBRO_COMISSAO_LICITACAO

COMMENT ON TABLE ifrdba2.membro_comissao_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.MEMBRO_COMISSAO_LICITACAO

-- Start of DDL Script for Table IFRDBA2.MEMBRO_COMISSAO_PERMANENTE
-- Generated 9-mar-2004 19:01:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.membro_comissao_permanente
    (cpl_dep_cd_dependencia         NUMBER(4) NOT NULL,
    cpl_sq_comissao                NUMBER(6) NOT NULL,
    sq_dupla                       NUMBER(2) NOT NULL,
    emp_nr_matricula_titular       NUMBER(7) NOT NULL,
    emp_nr_matricula_suplente      NUMBER(7),
    in_presidente_comissao         NUMBER(1),
    in_secretario_comissao         NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MEMBRO_COMISSAO_PERMANENTE

ALTER TABLE ifrdba2.membro_comissao_permanente
ADD CONSTRAINT mcp_pk PRIMARY KEY (cpl_dep_cd_dependencia, cpl_sq_comissao, 
  sq_dupla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.MEMBRO_COMISSAO_PERMANENTE

COMMENT ON TABLE ifrdba2.membro_comissao_permanente IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.MEMBRO_COMISSAO_PERMANENTE

-- Start of DDL Script for Table IFRDBA2.MENSAGENS_USUARIO
-- Generated 9-mar-2004 19:02:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.mensagens_usuario
    (tipo                           VARCHAR2(3) NOT NULL,
    codigo                         NUMBER(5) NOT NULL,
    descricao                      VARCHAR2(78) NOT NULL,
    estilo                         VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MENSAGENS_USUARIO

ALTER TABLE ifrdba2.mensagens_usuario
ADD CONSTRAINT mensagens_usuario_pk PRIMARY KEY (tipo, codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MENSAGENS_USUARIO

-- Start of DDL Script for Table IFRDBA2.MESES
-- Generated 9-mar-2004 19:02:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.meses
    (nu_mes                         NUMBER(2) NOT NULL,
    no_mes                         VARCHAR2(3) NOT NULL,
    ds_mes                         VARCHAR2(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MESES

ALTER TABLE ifrdba2.meses
ADD CONSTRAINT mes_pk PRIMARY KEY (nu_mes)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MESES

-- Start of DDL Script for Table IFRDBA2.META
-- Generated 9-mar-2004 19:02:11 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.meta
    (cd_meta                        VARCHAR2(2) NOT NULL,
    ds_meta                        VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.META

ALTER TABLE ifrdba2.meta
ADD CONSTRAINT mta_pk PRIMARY KEY (cd_meta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.META

-- Start of DDL Script for Table IFRDBA2.MODALIDADE_LICITACAO
-- Generated 9-mar-2004 19:02:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.modalidade_licitacao
    (cd_modalidade                  NUMBER(2) NOT NULL,
    ds_modalidade                  VARCHAR2(40) NOT NULL,
    sg_modalidade                  VARCHAR2(4),
    in_modalidade_especial         NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MODALIDADE_LICITACAO

ALTER TABLE ifrdba2.modalidade_licitacao
ADD CONSTRAINT mdl_pk PRIMARY KEY (cd_modalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.MODALIDADE_LICITACAO

COMMENT ON TABLE ifrdba2.modalidade_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.MODALIDADE_LICITACAO

-- Start of DDL Script for Table IFRDBA2.MODELO_EVENTO
-- Generated 9-mar-2004 19:02:17 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.modelo_evento
    (cd_modelo                      NUMBER(3) NOT NULL,
    sg_modelo                      VARCHAR2(10) NOT NULL,
    ds_modelo                      VARCHAR2(30),
    nr_historico_millenium         NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MODELO_EVENTO

ALTER TABLE ifrdba2.modelo_evento
ADD CONSTRAINT mev_pk PRIMARY KEY (cd_modelo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MODELO_EVENTO

-- Start of DDL Script for Table IFRDBA2.MOEDA
-- Generated 9-mar-2004 19:02:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.moeda
    (cd_moeda                       NUMBER(3) NOT NULL,
    no_moeda                       VARCHAR2(40) NOT NULL,
    sg_moeda                       VARCHAR2(10) NOT NULL,
    tip_periodicidade              VARCHAR2(1) NOT NULL,
    nom_fonte_consulta             VARCHAR2(30),
    dsc_historico                  VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MOEDA

ALTER TABLE ifrdba2.moeda
ADD CONSTRAINT moe_pk PRIMARY KEY (cd_moeda)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MOEDA

-- Start of DDL Script for Table IFRDBA2.MOVIMENTACAO_CREDITO
-- Generated 9-mar-2004 19:02:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.movimentacao_credito
    (nr_ano_mov                     NUMBER(4) NOT NULL,
    dep_cd_dependencia_efetuou     NUMBER(4) NOT NULL,
    nr_movimentacao                NUMBER(6) NOT NULL,
    su_id_usuario                  VARCHAR2(10) NOT NULL,
    dt_movimentacao                DATE NOT NULL,
    tp_movimentacao                VARCHAR2(1) NOT NULL,
    nr_ano_o                       NUMBER(4),
    dep_cd_dependencia_o           NUMBER(4),
    nr_item_o                      NUMBER(5),
    mm_origem                      NUMBER(2),
    nr_ano_d                       NUMBER(4),
    dep_cd_dependencia_d           NUMBER(4),
    nr_item_d                      NUMBER(5),
    mm_destino                     NUMBER(2),
    dt_referencia_mov              DATE,
    dt_memo                        DATE,
    qt_movimentacao                NUMBER(6),
    vl_movimentacao                NUMBER(14,2),
    nr_doc_solicitante             VARCHAR2(10),
    ds_movimentacao                VARCHAR2(300),
    nr_ano_residuo                 NUMBER(4),
    dep_cd_dependencia_residuo     NUMBER(4),
    nr_item_residuo                NUMBER(5),
    flg_item_novo                  VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MOVIMENTACAO_CREDITO

ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mc_pk PRIMARY KEY (nr_ano_mov, dep_cd_dependencia_efetuou, 
  nr_movimentacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mov_cred_ck_1 CHECK (  FLG_ITEM_NOVO IN ('S','N')                                                      )
/
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mov_tip_ck CHECK (  tp_movimentacao in ('R','D','S','C','A')                                        )
/

-- End of DDL Script for Table IFRDBA2.MOVIMENTACAO_CREDITO

-- Start of DDL Script for Table IFRDBA2.MOVIMENTO_OPERACIONAL
-- Generated 9-mar-2004 19:02:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.movimento_operacional
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    vsp_cd_nivel_versao            VARCHAR2(2) NOT NULL,
    vsp_cd_versao                  VARCHAR2(2) NOT NULL,
    vsp_nr_ano                     NUMBER(4) NOT NULL,
    nr_seq                         VARCHAR2(21) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2),
    val_jan1                       NUMBER(14,2),
    val_fev1                       NUMBER(14,2),
    val_mar1                       NUMBER(14,2),
    val_abr1                       NUMBER(14,2),
    val_mai1                       NUMBER(14,2),
    val_jun1                       NUMBER(14,2),
    val_jul1                       NUMBER(14,2),
    val_ago1                       NUMBER(14,2),
    val_set1                       NUMBER(14,2),
    val_out1                       NUMBER(14,2),
    val_nov1                       NUMBER(14,2),
    val_dez1                       NUMBER(14,2),
    val_jan2                       NUMBER(14,2),
    val_fev2                       NUMBER(14,2),
    val_mar2                       NUMBER(14,2),
    val_abr2                       NUMBER(14,2),
    val_mai2                       NUMBER(14,2),
    val_jun2                       NUMBER(14,2),
    val_jul2                       NUMBER(14,2),
    val_ago2                       NUMBER(14,2),
    val_set2                       NUMBER(14,2),
    val_out2                       NUMBER(14,2),
    val_nov2                       NUMBER(14,2),
    val_dez2                       NUMBER(14,2),
    val_jan3                       NUMBER(14,2),
    val_fev3                       NUMBER(14,2),
    val_mar3                       NUMBER(14,2),
    val_abr3                       NUMBER(14,2),
    val_mai3                       NUMBER(14,2),
    val_jun3                       NUMBER(14,2),
    val_jul3                       NUMBER(14,2),
    val_ago3                       NUMBER(14,2),
    val_set3                       NUMBER(14,2),
    val_out3                       NUMBER(14,2),
    val_nov3                       NUMBER(14,2),
    val_dez3                       NUMBER(14,2),
    val_jan4                       NUMBER(14,2),
    val_fev4                       NUMBER(14,2),
    val_mar4                       NUMBER(14,2),
    val_abr4                       NUMBER(14,2),
    val_mai4                       NUMBER(14,2),
    val_jun4                       NUMBER(14,2),
    val_jul4                       NUMBER(14,2),
    val_ago4                       NUMBER(14,2),
    val_set4                       NUMBER(14,2),
    val_out4                       NUMBER(14,2),
    val_nov4                       NUMBER(14,2),
    val_dez4                       NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MOVIMENTO_OPERACIONAL

ALTER TABLE ifrdba2.movimento_operacional
ADD CONSTRAINT mop_pk PRIMARY KEY (dep_cd_dependencia, vsp_cd_nivel_versao, 
  vsp_cd_versao, vsp_nr_ano, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.MOVIMENTO_OPERACIONAL

-- Start of DDL Script for Table IFRDBA2.MUNICIPIOS
-- Generated 9-mar-2004 19:02:34 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.municipios
    (mun_codigo                     NUMBER(5) NOT NULL,
    mun_descricao                  VARCHAR2(50) NOT NULL,
    mun_ufe_sigla                  VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.MUNICIPIOS

ALTER TABLE ifrdba2.municipios
ADD CONSTRAINT mun_cod_ufe_sigla_pk PRIMARY KEY (mun_codigo, mun_ufe_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.MUNICIPIOS

COMMENT ON COLUMN ifrdba2.municipios.mun_codigo IS 'Codigo do Minicipio'
/
COMMENT ON COLUMN ifrdba2.municipios.mun_descricao IS 'Nome do Municipio'
/
COMMENT ON COLUMN ifrdba2.municipios.mun_ufe_sigla IS 'Uf a qual o municipio pertence'
/

-- End of DDL Script for Table IFRDBA2.MUNICIPIOS

-- Start of DDL Script for Table IFRDBA2.NATUREZA_MOVIMENTACAO
-- Generated 9-mar-2004 19:02:38 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.natureza_movimentacao
    (cd_natureza                    CHAR(4) NOT NULL,
    ds_natureza                    VARCHAR2(35) NOT NULL,
    cc_nr_conta_lancamento         VARCHAR2(20) NOT NULL,
    cc_nr_conta_contrapartida      VARCHAR2(20) NOT NULL,
    ds_usuario                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.NATUREZA_MOVIMENTACAO

CREATE INDEX ifrdba2.nm_ccc_fk_i ON ifrdba2.natureza_movimentacao
  (
    cc_nr_conta_contrapartida       ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.nm_ccl_fk_i ON ifrdba2.natureza_movimentacao
  (
    cc_nr_conta_lancamento          ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.NATUREZA_MOVIMENTACAO

ALTER TABLE ifrdba2.natureza_movimentacao
ADD CONSTRAINT nm_pk PRIMARY KEY (cd_natureza)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.NATUREZA_MOVIMENTACAO

COMMENT ON TABLE ifrdba2.natureza_movimentacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.NATUREZA_MOVIMENTACAO

-- Start of DDL Script for Table IFRDBA2.OCORRENCIA_FORNECEDOR
-- Generated 9-mar-2004 19:02:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ocorrencia_fornecedor
    (omd_cd_ocorrencia              VARCHAR2(5) NOT NULL,
    pdl_for_nr_cgc_cpf             VARCHAR2(14) NOT NULL,
    pdl_lrc_sq_lote                NUMBER(8) NOT NULL,
    dt_ocorrencia                  DATE NOT NULL,
    vl_ocorrencia                  NUMBER(3) NOT NULL,
    observacao                     VARCHAR2(500),
    pnl_cd_penalidade              NUMBER(2) NOT NULL,
    pdl_for_dep_cd_dependencia     NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.OCORRENCIA_FORNECEDOR

ALTER TABLE ifrdba2.ocorrencia_fornecedor
ADD CONSTRAINT ocf_pk PRIMARY KEY (omd_cd_ocorrencia, pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote, dt_ocorrencia, pnl_cd_penalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.OCORRENCIA_FORNECEDOR

COMMENT ON TABLE ifrdba2.ocorrencia_fornecedor IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.OCORRENCIA_FORNECEDOR

-- Start of DDL Script for Table IFRDBA2.OCORRENCIA_MAL_DESEMPENHO
-- Generated 9-mar-2004 19:02:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ocorrencia_mal_desempenho
    (cd_ocorrencia                  VARCHAR2(5) NOT NULL,
    ds_ocorrencia                  VARCHAR2(40) NOT NULL,
    in_impedimento                 NUMBER(1) NOT NULL,
    qt_pontos                      NUMBER(4) NOT NULL,
    tp_pontos                      VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.OCORRENCIA_MAL_DESEMPENHO

ALTER TABLE ifrdba2.ocorrencia_mal_desempenho
ADD CONSTRAINT omd_pk PRIMARY KEY (cd_ocorrencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.OCORRENCIA_MAL_DESEMPENHO

COMMENT ON TABLE ifrdba2.ocorrencia_mal_desempenho IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.OCORRENCIA_MAL_DESEMPENHO

-- Start of DDL Script for Table IFRDBA2.ORC_ALIQUOTA
-- Generated 9-mar-2004 19:02:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_aliquota
    (num_conta                      VARCHAR2(20) NOT NULL,
    val_aliquota                   NUMBER(5,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_ALIQUOTA

ALTER TABLE ifrdba2.orc_aliquota
ADD CONSTRAINT orc_aliquota_pk PRIMARY KEY (num_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_ALIQUOTA

-- Start of DDL Script for Table IFRDBA2.ORC_COMPROMISSO_SP_TEMP
-- Generated 9-mar-2004 19:02:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_compromisso_sp_temp
    (num_sp                         NUMBER(10) NOT NULL,
    cod_dep_sp                     NUMBER(4) NOT NULL,
    cod_cc_sp                      NUMBER(5) NOT NULL,
    num_ano_compromisso            NUMBER(4) NOT NULL,
    cod_dependencia_compr          NUMBER(4) NOT NULL,
    cod_centro_custo               NUMBER(5) NOT NULL,
    num_compromisso                NUMBER(6) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_COMPROMISSO_SP_TEMP

ALTER TABLE ifrdba2.orc_compromisso_sp_temp
ADD CONSTRAINT oct_num_pk PRIMARY KEY (num_sp, cod_dep_sp, cod_cc_sp, 
  num_ano_compromisso, cod_dependencia_compr, cod_centro_custo, num_compromisso)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_COMPROMISSO_SP_TEMP

-- Start of DDL Script for Table IFRDBA2.ORC_CONSOL_ANA_CONTA
-- Generated 9-mar-2004 19:03:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_consol_ana_conta
    (ocas_po_cd_programa            NUMBER(3),
    ocas_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_CONSOL_ANA_CONTA

ALTER TABLE ifrdba2.orc_consol_ana_conta
ADD CONSTRAINT ocac_uk UNIQUE (ocas_po_cd_programa, ocas_cd_sumario, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_CONSOL_ANA_CONTA

-- Start of DDL Script for Table IFRDBA2.ORC_CONSOL_ANA_SUMARIO
-- Generated 9-mar-2004 19:03:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_consol_ana_sumario
    (po_cd_programa                 NUMBER(3),
    cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_CONSOL_ANA_SUMARIO

ALTER TABLE ifrdba2.orc_consol_ana_sumario
ADD CONSTRAINT ocas_uk UNIQUE (po_cd_programa, cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_CONSOL_ANA_SUMARIO

-- Start of DDL Script for Table IFRDBA2.ORC_CONSOL_SIN_CONTA
-- Generated 9-mar-2004 19:03:11 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_consol_sin_conta
    (ocss_po_cd_programa            NUMBER(3),
    ocss_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_CONSOL_SIN_CONTA

ALTER TABLE ifrdba2.orc_consol_sin_conta
ADD CONSTRAINT ocsc_uk UNIQUE (ocss_po_cd_programa, ocss_cd_sumario, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_CONSOL_SIN_CONTA

-- Start of DDL Script for Table IFRDBA2.ORC_CONSOL_SIN_SUMARIO
-- Generated 9-mar-2004 19:03:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_consol_sin_sumario
    (po_cd_programa                 NUMBER(3),
    cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_CONSOL_SIN_SUMARIO

ALTER TABLE ifrdba2.orc_consol_sin_sumario
ADD CONSTRAINT ocss_uk UNIQUE (po_cd_programa, cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_CONSOL_SIN_SUMARIO

-- Start of DDL Script for Table IFRDBA2.ORC_DET_INTERFACE
-- Generated 9-mar-2004 19:03:19 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_det_interface
    (nom_interface                  VARCHAR2(2) NOT NULL,
    dat_interface                  DATE NOT NULL,
    seq_linha                      NUMBER(5) NOT NULL,
    des_linha                      VARCHAR2(300) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DET_INTERFACE

ALTER TABLE ifrdba2.orc_det_interface
ADD CONSTRAINT odi_seq_pk PRIMARY KEY (nom_interface, dat_interface, seq_linha)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DET_INTERFACE

-- Start of DDL Script for Table IFRDBA2.ORC_DISPEN_ANA_CONTA
-- Generated 9-mar-2004 19:03:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_dispen_ana_conta
    (odas_odis_cd_dispendio         NUMBER(5) NOT NULL,
    odas_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DISPEN_ANA_CONTA

ALTER TABLE ifrdba2.orc_dispen_ana_conta
ADD CONSTRAINT odac_pk PRIMARY KEY (odas_odis_cd_dispendio, odas_cd_sumario, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DISPEN_ANA_CONTA

-- Start of DDL Script for Table IFRDBA2.ORC_DISPEN_ANA_SUMARIO
-- Generated 9-mar-2004 19:03:26 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_dispen_ana_sumario
    (odis_cd_dispendio              NUMBER(5) NOT NULL,
    cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DISPEN_ANA_SUMARIO

ALTER TABLE ifrdba2.orc_dispen_ana_sumario
ADD CONSTRAINT odas_pk PRIMARY KEY (odis_cd_dispendio, cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DISPEN_ANA_SUMARIO

-- Start of DDL Script for Table IFRDBA2.ORC_DISPEN_SIN_CONTA
-- Generated 9-mar-2004 19:03:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_dispen_sin_conta
    (odss_odis_cd_dispendio         NUMBER(5) NOT NULL,
    odss_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DISPEN_SIN_CONTA

ALTER TABLE ifrdba2.orc_dispen_sin_conta
ADD CONSTRAINT odsc_pk PRIMARY KEY (odss_odis_cd_dispendio, odss_cd_sumario, 
  cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DISPEN_SIN_CONTA

-- Start of DDL Script for Table IFRDBA2.ORC_DISPEN_SIN_SUMARIO
-- Generated 9-mar-2004 19:03:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_dispen_sin_sumario
    (odis_cd_dispendio              NUMBER(5) NOT NULL,
    cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DISPEN_SIN_SUMARIO

ALTER TABLE ifrdba2.orc_dispen_sin_sumario
ADD CONSTRAINT odss_pk PRIMARY KEY (odis_cd_dispendio, cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DISPEN_SIN_SUMARIO

-- Start of DDL Script for Table IFRDBA2.ORC_DISPENDIO
-- Generated 9-mar-2004 19:03:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_dispendio
    (cd_dispendio                   NUMBER(5) NOT NULL,
    ds_dispendio                   VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_DISPENDIO

ALTER TABLE ifrdba2.orc_dispendio
ADD CONSTRAINT odis_pk PRIMARY KEY (cd_dispendio)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_DISPENDIO

-- Start of DDL Script for Table IFRDBA2.ORC_FILTROS_CENTRO_CUSTO
-- Generated 9-mar-2004 19:03:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_filtros_centro_custo
    (cod_centro_custo               NUMBER(5) NOT NULL,
    nom_grupo                      VARCHAR2(15) NOT NULL,
    cod_funcao                     NUMBER(4) NOT NULL,
    cod_programa                   NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_FILTROS_CENTRO_CUSTO

ALTER TABLE ifrdba2.orc_filtros_centro_custo
ADD CONSTRAINT orc_filtros_centr_custo_pk PRIMARY KEY (cod_centro_custo, 
  nom_grupo, cod_funcao, cod_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_FILTROS_CENTRO_CUSTO

-- Start of DDL Script for Table IFRDBA2.ORC_FILTROS_PROGRAMAS
-- Generated 9-mar-2004 19:03:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_filtros_programas
    (nom_campo                      VARCHAR2(100) NOT NULL,
    nom_grupo                      VARCHAR2(15) NOT NULL,
    cod_funcao                     NUMBER(4) NOT NULL,
    cod_programa                   NUMBER(3) NOT NULL,
    nom_filtro_manut               VARCHAR2(100) NOT NULL,
    nom_filtro_consulta            VARCHAR2(100) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_FILTROS_PROGRAMAS

ALTER TABLE ifrdba2.orc_filtros_programas
ADD CONSTRAINT ofp_cmp_pk PRIMARY KEY (nom_campo, nom_grupo, cod_funcao, 
  cod_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_FILTROS_PROGRAMAS

-- Start of DDL Script for Table IFRDBA2.ORC_FUNCOES_PROGRAMAS
-- Generated 9-mar-2004 19:03:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_funcoes_programas
    (cod_funcao                     NUMBER(4) NOT NULL,
    cod_programa                   NUMBER(3) NOT NULL,
    des_funcao                     VARCHAR2(100) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_FUNCOES_PROGRAMAS

ALTER TABLE ifrdba2.orc_funcoes_programas
ADD CONSTRAINT ofc_cod_pk PRIMARY KEY (cod_funcao, cod_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_FUNCOES_PROGRAMAS

-- Start of DDL Script for Table IFRDBA2.ORC_GER_INTERFACE
-- Generated 9-mar-2004 19:03:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_ger_interface
    (nom_interface                  VARCHAR2(2) NOT NULL,
    dat_interface                  DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_GER_INTERFACE

ALTER TABLE ifrdba2.orc_ger_interface
ADD CONSTRAINT ogi_chv_pk PRIMARY KEY (nom_interface, dat_interface)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_GER_INTERFACE

-- Start of DDL Script for Table IFRDBA2.ORC_ITEM_COMPROMISSO_SP_TEMP
-- Generated 9-mar-2004 19:03:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_item_compromisso_sp_temp
    (num_sp                         NUMBER(10) NOT NULL,
    cod_dep_sp                     NUMBER(4) NOT NULL,
    cod_cc_sp                      NUMBER(5) NOT NULL,
    num_ano_compromisso            NUMBER(4) NOT NULL,
    cod_dependencia_compr          NUMBER(4) NOT NULL,
    cod_centro_custo               NUMBER(5) NOT NULL,
    num_compromisso                NUMBER(6) NOT NULL,
    num_seq_comp                   NUMBER(3) NOT NULL,
    dat_pagamento                  DATE NOT NULL,
    val_pagamento                  NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_ITEM_COMPROMISSO_SP_TEMP

ALTER TABLE ifrdba2.orc_item_compromisso_sp_temp
ADD CONSTRAINT oit_num_pk PRIMARY KEY (num_sp, cod_dep_sp, cod_cc_sp, 
  num_ano_compromisso, cod_dependencia_compr, cod_centro_custo, num_compromisso, 
  num_seq_comp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_ITEM_COMPROMISSO_SP_TEMP

-- Start of DDL Script for Table IFRDBA2.ORC_PROGRAMAS
-- Generated 9-mar-2004 19:04:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_programas
    (cod_programa                   NUMBER(3) NOT NULL,
    nom_programa                   VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_PROGRAMAS

ALTER TABLE ifrdba2.orc_programas
ADD CONSTRAINT opg_cod_pk PRIMARY KEY (cod_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_PROGRAMAS

-- Start of DDL Script for Table IFRDBA2.ORC_RESTRICAO_MOVIMENTO
-- Generated 9-mar-2004 19:04:05 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_restricao_movimento
    (num_restricao                  NUMBER(6) NOT NULL,
    cod_dep_o_inicio               NUMBER(4),
    cod_dep_o_fim                  NUMBER(4),
    cod_dep_d_inicio               NUMBER(4),
    cod_dep_d_fim                  NUMBER(4),
    cod_centro_custo_o_inicio      NUMBER(5),
    cod_centro_custo_o_fim         NUMBER(5),
    cod_centro_custo_d_inicio      NUMBER(5),
    cod_centro_custo_d_fim         NUMBER(5),
    cod_programa_o_inicio          NUMBER(3),
    cod_programa_o_fim             NUMBER(3),
    cod_programa_d_inicio          NUMBER(3),
    cod_programa_d_fim             NUMBER(3),
    cod_projeto_o_inicio           NUMBER(4),
    cod_projeto_o_fim              NUMBER(4),
    cod_projeto_d_inicio           NUMBER(4),
    cod_projeto_d_fim              NUMBER(4),
    cod_conta_o_inicio             NUMBER(20),
    cod_conta_o_fim                NUMBER(20),
    cod_conta_d_inicio             NUMBER(20),
    cod_conta_d_fim                NUMBER(20),
    num_percentual                 NUMBER(5,2),
    flg_nivel_percentual           CHAR(1),
    des_restricao                  VARCHAR2(500) NOT NULL,
    des_mensagem                   VARCHAR2(300) NOT NULL,
    flg_dep_reciproca              CHAR(1),
    flg_centro_custo_reciproca     CHAR(1),
    flg_programa_reciproca         CHAR(1),
    flg_projeto_reciproca          CHAR(1),
    flg_conta_reciproca            CHAR(1),
    dat_inicio_restricao           DATE,
    dat_fim_restricao              DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_RESTRICAO_MOVIMENTO

ALTER TABLE ifrdba2.orc_restricao_movimento
ADD CONSTRAINT ocm_pk PRIMARY KEY (num_restricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_RESTRICAO_MOVIMENTO

-- Start of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_CONTA
-- Generated 9-mar-2004 19:04:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_resumo_ana_conta
    (oras_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_RESUMO_ANA_CONTA

ALTER TABLE ifrdba2.orc_resumo_ana_conta
ADD CONSTRAINT orac_pk PRIMARY KEY (oras_cd_sumario, cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_CONTA

-- Start of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_CONTA_META
-- Generated 9-mar-2004 19:04:12 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_resumo_ana_conta_meta
    (oras_cd_sumario                NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_RESUMO_ANA_CONTA_META

ALTER TABLE ifrdba2.orc_resumo_ana_conta_meta
ADD CONSTRAINT orc_res_ana_cnt_met_pk PRIMARY KEY (oras_cd_sumario, cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_CONTA_META

-- Start of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_SUMARIO
-- Generated 9-mar-2004 19:04:16 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_resumo_ana_sumario
    (cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_RESUMO_ANA_SUMARIO

ALTER TABLE ifrdba2.orc_resumo_ana_sumario
ADD CONSTRAINT oras_pk PRIMARY KEY (cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_SUMARIO

-- Start of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_SUMARIO_META
-- Generated 9-mar-2004 19:04:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_resumo_ana_sumario_meta
    (cd_sumario                     NUMBER(5) NOT NULL,
    in_nivel                       NUMBER(1) NOT NULL,
    ds_sumario                     VARCHAR2(40) NOT NULL,
    in_explosao                    VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_RESUMO_ANA_SUMARIO_META

ALTER TABLE ifrdba2.orc_resumo_ana_sumario_meta
ADD CONSTRAINT orc_res_ana_sum_met_pk PRIMARY KEY (cd_sumario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_RESUMO_ANA_SUMARIO_META

-- Start of DDL Script for Table IFRDBA2.ORC_SEGURANCA
-- Generated 9-mar-2004 19:04:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_seguranca
    (nom_grupo                      VARCHAR2(15) NOT NULL,
    cod_funcao                     NUMBER(4) NOT NULL,
    cod_programa                   NUMBER(3) NOT NULL,
    flg_manutencao                 VARCHAR2(1),
    flg_consulta                   VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_SEGURANCA

ALTER TABLE ifrdba2.orc_seguranca
ADD CONSTRAINT osg_ck_1 CHECK ( flg_manutencao in ('S','N')                                                      )
/
ALTER TABLE ifrdba2.orc_seguranca
ADD CONSTRAINT osg_ck_2 CHECK ( flg_consulta in ('S','N')                                                        )
/
ALTER TABLE ifrdba2.orc_seguranca
ADD CONSTRAINT osg_grp_pk PRIMARY KEY (nom_grupo, cod_funcao, cod_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_SEGURANCA

-- Start of DDL Script for Table IFRDBA2.ORC_SP_TEMP
-- Generated 9-mar-2004 19:04:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orc_sp_temp
    (num_sp                         NUMBER(10) NOT NULL,
    cod_dep_sp                     NUMBER(4) NOT NULL,
    cod_cc_sp                      NUMBER(5) NOT NULL,
    dat_sp                         DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORC_SP_TEMP

ALTER TABLE ifrdba2.orc_sp_temp
ADD CONSTRAINT ost_num_pk PRIMARY KEY (num_sp, cod_dep_sp, cod_cc_sp)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORC_SP_TEMP

-- Start of DDL Script for Table IFRDBA2.ORDEM_SERVICO
-- Generated 9-mar-2004 19:04:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ordem_servico
    (aa_ordem_servico               NUMBER(4) NOT NULL,
    nr_ordem_servico               NUMBER(6) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    in_aberta                      NUMBER(1) NOT NULL,
    in_mat_serv                    NUMBER(1) NOT NULL,
    emp_nr_matricula_req           NUMBER(7) NOT NULL,
    uo_cd_unid_organ               NUMBER(9) NOT NULL,
    dt_ordem_servico               DATE NOT NULL,
    cc_cd_centro_custo             NUMBER(5),
    emp_nr_matricula_aut           NUMBER(7),
    dt_autorizacao                 DATE,
    cd_aplicacao                   VARCHAR2(3),
    ds_usuario                     VARCHAR2(50),
    ds_servico                     VARCHAR2(2000),
    os_maximo                      VARCHAR2(18))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ORDEM_SERVICO

CREATE INDEX ifrdba2.os_idx ON ifrdba2.ordem_servico
  (
    dep_cd_dependencia              ASC,
    in_aberta                       ASC,
    uo_cd_unid_organ                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.os_empa_fk ON ifrdba2.ordem_servico
  (
    emp_nr_matricula_aut            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.os_empr_fk ON ifrdba2.ordem_servico
  (
    emp_nr_matricula_req            ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.os_uo_fk ON ifrdba2.ordem_servico
  (
    uo_cd_unid_organ                ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.os_cc_fk ON ifrdba2.ordem_servico
  (
    cc_cd_centro_custo              ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ORDEM_SERVICO

ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_pk PRIMARY KEY (aa_ordem_servico, nr_ordem_servico, 
  dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.ORDEM_SERVICO

CREATE TRIGGER ifrdba2.trg_os
BEFORE  DELETE 
ON ifrdba2.ordem_servico
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
	LOG_DS_USUARIO VARCHAR2(50);
BEGIN
	SELECT USER||' - '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
	INTO LOG_DS_USUARIO
	FROM DUAL;
	INSERT INTO LOG_ORDEM_SERVICO
		(AA_ORDEM_SERVICO,
		 NR_ORDEM_SERVICO,
		 DEP_CD_DEPENDENCIA,
		 DT_ORDEM_SERVICO,
		 DT_AUTORIZACAO,
		 IN_ABERTA,
		 CC_CD_CENTRO_CUSTO,
		 EMP_NR_MATRICULA_REQ,
		 EMP_NR_MATRICULA_AUT,
		 UO_CD_UNID_ORGAN,
		 DS_SERVICO,
		 IN_MAT_SERV,
		 CD_APLICACAO,
		 DS_USUARIO)
	VALUES
		(:OLD.AA_ORDEM_SERVICO,
		 :OLD.NR_ORDEM_SERVICO,
		 :OLD.DEP_CD_DEPENDENCIA,
		 :OLD.DT_ORDEM_SERVICO,
		 :OLD.DT_AUTORIZACAO,
		 :OLD.IN_ABERTA,
		 :OLD.CC_CD_CENTRO_CUSTO,
		 :OLD.EMP_NR_MATRICULA_REQ,
		 :OLD.EMP_NR_MATRICULA_AUT,
		 :OLD.UO_CD_UNID_ORGAN,
		 :OLD.DS_SERVICO,
		 :OLD.IN_MAT_SERV,
		 :OLD.CD_APLICACAO,
		 LOG_DS_USUARIO);
END;
/

-- End of DDL Script for Table IFRDBA2.ORDEM_SERVICO

-- Start of DDL Script for Table IFRDBA2.ORGAOS_EXTERNOS
-- Generated 9-mar-2004 19:04:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.orgaos_externos
    (oex_codigo                     NUMBER(5) NOT NULL,
    oex_sigla                      VARCHAR2(15) NOT NULL,
    oex_nome                       VARCHAR2(50) NOT NULL,
    oex_oex_codigo                 NUMBER(5),
    oex_ufe_sigla                  VARCHAR2(2),
    oex_endereco_logradouro        VARCHAR2(50),
    oex_endereco_bairro            VARCHAR2(30),
    oex_endereco_cidade            VARCHAR2(30),
    oex_endereco_cep               NUMBER(9),
    oex_numero_telefone            NUMBER(12),
    oex_numero_fax                 NUMBER(12),
    oex_mun_codigo                 NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ORGAOS_EXTERNOS

CREATE INDEX ifrdba2.oex_mun_fk_i ON ifrdba2.orgaos_externos
  (
    oex_ufe_sigla                   ASC,
    oex_mun_codigo                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.oex_oex_fk_i ON ifrdba2.orgaos_externos
  (
    oex_oex_codigo                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ORGAOS_EXTERNOS

ALTER TABLE ifrdba2.orgaos_externos
ADD CONSTRAINT oex_pk PRIMARY KEY (oex_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.orgaos_externos
ADD CONSTRAINT oex_uk UNIQUE (oex_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.orgaos_externos
ADD CONSTRAINT oex_uk1 UNIQUE (oex_nome)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ORGAOS_EXTERNOS

COMMENT ON TABLE ifrdba2.orgaos_externos IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ORGAOS_EXTERNOS

-- Start of DDL Script for Table IFRDBA2.ORIGEM_CAUCAO
-- Generated 9-mar-2004 19:04:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.origem_caucao
    (cd_origem_caucao               VARCHAR2(3) NOT NULL,
    no_origem_caucao               VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.ORIGEM_CAUCAO

ALTER TABLE ifrdba2.origem_caucao
ADD CONSTRAINT oca_pk PRIMARY KEY (cd_origem_caucao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORIGEM_CAUCAO

-- Start of DDL Script for Table IFRDBA2.ORIGEM_RECURSO
-- Generated 9-mar-2004 19:04:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.origem_recurso
    (cd_origem                      NUMBER(2) NOT NULL,
    no_origem                      VARCHAR2(20) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ORIGEM_RECURSO

CREATE INDEX ifrdba2.or_cc1_fk_i ON ifrdba2.origem_recurso
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ORIGEM_RECURSO

ALTER TABLE ifrdba2.origem_recurso
ADD CONSTRAINT or_pk PRIMARY KEY (cd_origem)
USING INDEX
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.ORIGEM_RECURSO

-- Start of DDL Script for Table IFRDBA2.ORIGEM_RECURSO_PROCESSO
-- Generated 9-mar-2004 19:05:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.origem_recurso_processo
    (pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia_detent   NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    or_cd_origem                   NUMBER(2) NOT NULL,
    tx_comentario                  VARCHAR2(400))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.ORIGEM_RECURSO_PROCESSO

CREATE INDEX ifrdba2.orp_or_fk_i ON ifrdba2.origem_recurso_processo
  (
    or_cd_origem                    ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.ORIGEM_RECURSO_PROCESSO

ALTER TABLE ifrdba2.origem_recurso_processo
ADD CONSTRAINT orp_pk PRIMARY KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade, or_cd_origem)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.ORIGEM_RECURSO_PROCESSO

COMMENT ON TABLE ifrdba2.origem_recurso_processo IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.ORIGEM_RECURSO_PROCESSO

-- Start of DDL Script for Table IFRDBA2.PAGAMENTO
-- Generated 9-mar-2004 19:05:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.pagamento
    (fpg_cd_forma_pgto              VARCHAR2(2),
    or_cd_origem                   NUMBER(2),
    nr_lancamento                  NUMBER(38) NOT NULL,
    in_tesouraria                  NUMBER(1),
    ds_historico_pgto              VARCHAR2(120),
    in_autorizacao_gestor          NUMBER(1),
    nr_doc_fiscal                  VARCHAR2(10),
    in_cancelado                   NUMBER(1),
    dt_pagamento                   DATE NOT NULL,
    nr_opb                         NUMBER(7),
    nr_opb2                        NUMBER(7),
    st_encargos                    NUMBER(1) NOT NULL,
    hr_entrega_fedf                VARCHAR2(5),
    evc_nr_evento_apr              NUMBER(3),
    evc_nr_evento_pag              NUMBER(3),
    in_emissao_critica             CHAR(1),
    in_tipo_sp                     VARCHAR2(1),
    nr_solicita_pagamento          NUMBER(6),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PAGAMENTO

ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_pk PRIMARY KEY (nr_lancamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PAGAMENTO

-- Start of DDL Script for Table IFRDBA2.PAGAMENTO_ITEM_COMP_ORC
-- Generated 9-mar-2004 19:05:12 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.pagamento_item_comp_orc
    (ico_co_nr_ano                  NUMBER(4) NOT NULL,
    ico_co_dep_cd_dependencia      NUMBER(4) NOT NULL,
    ico_co_nr_compromisso          NUMBER(6) NOT NULL,
    ico_nr_seq_comp                NUMBER(3) NOT NULL,
    lat_nr_lancamento              NUMBER(38) NOT NULL,
    vl_pagamento_item              NUMBER(14,2) NOT NULL,
    nr_opb                         NUMBER(7),
    vl_pagamento_dolar             NUMBER(14,2),
    vl_pagamento_item_dolar        NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PAGAMENTO_ITEM_COMP_ORC

ALTER TABLE ifrdba2.pagamento_item_comp_orc
ADD CONSTRAINT pgi_pk PRIMARY KEY (ico_co_nr_ano, ico_co_dep_cd_dependencia, 
  ico_co_nr_compromisso, ico_nr_seq_comp, lat_nr_lancamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PAGAMENTO_ITEM_COMP_ORC

-- Start of DDL Script for Table IFRDBA2.PAISES
-- Generated 9-mar-2004 19:05:16 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.paises
    (pai_codigo                     NUMBER(4) NOT NULL,
    pai_descricao                  VARCHAR2(50) NOT NULL,
    pai_usuario_atualizacao        VARCHAR2(50) NOT NULL,
    pai_data_atualizacao           DATE NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PAISES

ALTER TABLE ifrdba2.paises
ADD CONSTRAINT pai_pk PRIMARY KEY (pai_codigo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.paises
ADD CONSTRAINT pai_uk UNIQUE (pai_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PAISES

COMMENT ON TABLE ifrdba2.paises IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PAISES

-- Start of DDL Script for Table IFRDBA2.PARAM_CUSTODIA
-- Generated 9-mar-2004 19:05:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.param_custodia
    (moe_cd_moeda                   NUMBER(3),
    inf_cod_indice                 NUMBER(3),
    prc_cpmf                       NUMBER(6,3) NOT NULL,
    prc_iof                        NUMBER(6,3) NOT NULL,
    prc_ir                         NUMBER(6,3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PARAM_CUSTODIA

-- Start of DDL Script for Table IFRDBA2.PARAM_CUSTODIA_DEP
-- Generated 9-mar-2004 19:05:22 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.param_custodia_dep
    (cod_dependencia                NUMBER(4) NOT NULL,
    uor_codigo                     NUMBER(9) NOT NULL,
    nom_empregado                  VARCHAR2(60) NOT NULL,
    email                          VARCHAR2(60),
    fax                            VARCHAR2(15),
    cargo                          VARCHAR2(60) NOT NULL,
    rodape                         VARCHAR2(250) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PARAM_CUSTODIA_DEP

ALTER TABLE ifrdba2.param_custodia_dep
ADD CONSTRAINT pcd_dep_pk PRIMARY KEY (cod_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PARAM_CUSTODIA_DEP

COMMENT ON TABLE ifrdba2.param_custodia_dep IS 'SICOF - PCD - Tabela de Parametro de Custodia por dependencia'
/

-- End of DDL Script for Table IFRDBA2.PARAM_CUSTODIA_DEP

-- Start of DDL Script for Table IFRDBA2.PARAMETRO_TESOURARIA_DEP
-- Generated 9-mar-2004 19:05:26 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.parametro_tesouraria_dep
    (cod_dependencia                NUMBER(4) NOT NULL,
    uor_cod_unid_org_resp_ntcf     NUMBER(9),
    emp_num_matric_resp_ntcf       NUMBER(7),
    dsc_rodape_doc_ntcf            VARCHAR2(250),
    uor_cod_unid_org_resp2_ntcf    NUMBER(9),
    emp_num_matric_depart_mdc      NUMBER(7),
    emp_num_matric_divis_mdc       NUMBER(7),
    emp_num_matric_secao_mdc       NUMBER(7),
    moe_cd_moeda                   NUMBER(3),
    inf_cod_indice                 NUMBER(3),
    val_indice_cpmf                NUMBER(6,3),
    val_indice_iof                 NUMBER(6,3),
    val_indice_ir                  NUMBER(6,3),
    val_indice_iof_aplic           NUMBER(6,3),
    val_indice_ir_aplic            NUMBER(6,3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PARAMETRO_TESOURARIA_DEP

ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_pk PRIMARY KEY (cod_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PARAMETRO_TESOURARIA_DEP

-- Start of DDL Script for Table IFRDBA2.PARAMETROS
-- Generated 9-mar-2004 19:05:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.parametros
    (cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    nr_seq                         NUMBER(2) NOT NULL,
    qt_max_versoes_dep             NUMBER(2),
    qt_max_versoes_sede            NUMBER(2),
    vl_disp_caixa                  NUMBER(14,2),
    hr_limite_fedf                 VARCHAR2(5),
    cc1_nr_conta_pre_comp          VARCHAR2(20) NOT NULL,
    vl_detalhamento                NUMBER(14,2),
    pe_correspondencia             NUMBER(7,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.PARAMETROS

CREATE INDEX ifrdba2.par1_cc1_fk_i ON ifrdba2.parametros
  (
    cc1_nr_conta_pre_comp           ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.par_cc1_fk_i ON ifrdba2.parametros
  (
    cc1_nr_conta                    ASC
  )
  PCTFREE     40
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.PARAMETROS

ALTER TABLE ifrdba2.parametros
ADD CONSTRAINT par_pk PRIMARY KEY (nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PARAMETROS

-- Start of DDL Script for Table IFRDBA2.PARAMETROS_SISTEMAS_ADM
-- Generated 9-mar-2004 19:05:37 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.parametros_sistemas_adm
    (id_seq_pessoa                  NUMBER(10) NOT NULL,
    moe_cd_moeda_corrente          NUMBER(3) NOT NULL,
    path_texto_padrao              VARCHAR2(80) NOT NULL,
    sq_nome_edital                 NUMBER(6) NOT NULL,
    sq_nome_atas                   NUMBER(6) NOT NULL,
    path_no_editor                 VARCHAR2(80) NOT NULL,
    moe_cd_moeda_corr_licita       NUMBER(3) NOT NULL,
    dt_reposicao_estoque           DATE,
    cd_centro_custo_rep_esto       NUMBER(5) NOT NULL,
    sq_nome_ato_adm                NUMBER(6) NOT NULL,
    sq_nome_minuta_edital          NUMBER(6) NOT NULL,
    path_documentos_processos      VARCHAR2(250),
    no_string_conexao              VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Comments for IFRDBA2.PARAMETROS_SISTEMAS_ADM

COMMENT ON TABLE ifrdba2.parametros_sistemas_adm IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PARAMETROS_SISTEMAS_ADM

-- Start of DDL Script for Table IFRDBA2.PART_NUMBER
-- Generated 9-mar-2004 19:05:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.part_number
    (fab_cd_fabricante              NUMBER(4) NOT NULL,
    ig_ci_cd_classe                VARCHAR2(4) NOT NULL,
    ig_cd_item                     VARCHAR2(7) NOT NULL,
    nr_part_number                 VARCHAR2(25) NOT NULL,
    ig_dep_cd_dependencia          NUMBER(4) NOT NULL,
    fab_dep_cd_dependencia         NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.PART_NUMBER

CREATE INDEX ifrdba2.pn_ig_fk ON ifrdba2.part_number
  (
    ig_dep_cd_dependencia           ASC,
    ig_ci_cd_classe                 ASC,
    ig_cd_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.PART_NUMBER

ALTER TABLE ifrdba2.part_number
ADD CONSTRAINT pn_pk PRIMARY KEY (fab_cd_fabricante, fab_dep_cd_dependencia, 
  ig_dep_cd_dependencia, ig_ci_cd_classe, ig_cd_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PART_NUMBER

COMMENT ON TABLE ifrdba2.part_number IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PART_NUMBER

-- Start of DDL Script for Table IFRDBA2.PARTICIPANTE_DE_LICITACAO
-- Generated 9-mar-2004 19:05:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.participante_de_licitacao
    (for_nr_cgc_cpf                 VARCHAR2(14) NOT NULL,
    lrc_sq_lote                    NUMBER(8) NOT NULL,
    ds_condicao_pagamento          VARCHAR2(200),
    dt_habilitacao                 DATE,
    dt_proposta                    DATE,
    dt_validade_proposta           DATE,
    in_comparecimento              NUMBER(1),
    in_convidada                   NUMBER(1),
    in_habilitacao_documentacao    NUMBER(1),
    in_habilitacao_proposta        NUMBER(1),
    pz_entrega_total               NUMBER(5),
    moe_cd_moeda                   NUMBER(3),
    vl_nota_indicacao              NUMBER(3),
    for_dep_cd_dependencia         NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.PARTICIPANTE_DE_LICITACAO

CREATE INDEX ifrdba2.pdl_for_fk_i ON ifrdba2.participante_de_licitacao
  (
    for_nr_cgc_cpf                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.pdl_lrc_fk_i ON ifrdba2.participante_de_licitacao
  (
    lrc_sq_lote                     ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.PARTICIPANTE_DE_LICITACAO

ALTER TABLE ifrdba2.participante_de_licitacao
ADD CONSTRAINT pdl_pk PRIMARY KEY (for_dep_cd_dependencia, for_nr_cgc_cpf, 
  lrc_sq_lote)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PARTICIPANTE_DE_LICITACAO

COMMENT ON TABLE ifrdba2.participante_de_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PARTICIPANTE_DE_LICITACAO

-- Start of DDL Script for Table IFRDBA2.PATRIM_CONTROLE
-- Generated 9-mar-2004 19:05:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.patrim_controle
    (ma_processamento               NUMBER(6) NOT NULL,
    nr_conta_cm_inf_normal         VARCHAR2(20),
    nr_conta_cm_uniao              VARCHAR2(20),
    nr_conta_cm_inf_est_ea         VARCHAR2(20),
    nr_conta_dp_inf_normal_est_ea  VARCHAR2(20),
    nr_conta_interferencia         VARCHAR2(20),
    nr_conta_bx_inf_normal         VARCHAR2(20),
    nr_conta_bx_uniao              VARCHAR2(20),
    cd_centro_custo_sede_est       NUMBER(5),
    cd_centro_custo_reg_est        NUMBER(5),
    cd_centro_custo_aer_est        NUMBER(5),
    cd_programa_est                NUMBER(3),
    no_usuario                     VARCHAR2(30) NOT NULL,
    pc_remuneracao_ano             NUMBER(5,2),
    no_string_conexao              VARCHAR2(30))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PATRIM_CONTROLE

ALTER TABLE ifrdba2.patrim_controle
ADD CONSTRAINT pct_pk PRIMARY KEY (ma_processamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PATRIM_CONTROLE

-- Start of DDL Script for Table IFRDBA2.PENALIDADE
-- Generated 9-mar-2004 19:05:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.penalidade
    (cd_penalidade                  NUMBER(2) NOT NULL,
    ds_penalidade                  VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PENALIDADE

ALTER TABLE ifrdba2.penalidade
ADD CONSTRAINT pnl_pk PRIMARY KEY (cd_penalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PENALIDADE

COMMENT ON TABLE ifrdba2.penalidade IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PENALIDADE

-- Start of DDL Script for Table IFRDBA2.PERCENTUAL_RECEITA_DESPESA
-- Generated 9-mar-2004 19:06:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.percentual_receita_despesa
    (cc1_nr_conta                   VARCHAR2(20) NOT NULL,
    pc_rec_desp                    NUMBER(5,2) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PERCENTUAL_RECEITA_DESPESA

ALTER TABLE ifrdba2.percentual_receita_despesa
ADD CONSTRAINT prd_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, cc1_nr_conta)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PERCENTUAL_RECEITA_DESPESA

-- Start of DDL Script for Table IFRDBA2.PERFIL
-- Generated 9-mar-2004 19:06:05 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.perfil
    (cd_perfil                      NUMBER(2) NOT NULL,
    ds_perfil                      VARCHAR2(30) NOT NULL,
    role                           VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PERFIL

ALTER TABLE ifrdba2.perfil
ADD CONSTRAINT prl_pk PRIMARY KEY (cd_perfil)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PERFIL

COMMENT ON TABLE ifrdba2.perfil IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PERFIL

-- Start of DDL Script for Table IFRDBA2.PRE_COMPROMISSO_ORCAMENTARIO
-- Generated 9-mar-2004 19:06:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.pre_compromisso_orcamentario
    (nr_ano_pre_compromisso         NUMBER(4) NOT NULL,
    dep_cd_dependencia_pcompr      NUMBER(4) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    nr_pre_compromisso             NUMBER(6) NOT NULL,
    dt_informacao_pre_compromisso  DATE NOT NULL,
    dt_referencia_pre_comp         DATE NOT NULL,
    dt_memo                        DATE NOT NULL,
    dep_cd_dependencia_efetuou     NUMBER(4) NOT NULL,
    su_id_usuario                  VARCHAR2(10) NOT NULL,
    ds_pre_compromisso             VARCHAR2(300),
    cc1_nr_conta                   VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PRE_COMPROMISSO_ORCAMENTARIO

ALTER TABLE ifrdba2.pre_compromisso_orcamentario
ADD CONSTRAINT pc_pk PRIMARY KEY (nr_ano_pre_compromisso, 
  dep_cd_dependencia_pcompr, cc2_cd_centro_custo, nr_pre_compromisso)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PRE_COMPROMISSO_ORCAMENTARIO

-- Start of DDL Script for Table IFRDBA2.PREVISAO_PROCESSO
-- Generated 9-mar-2004 19:06:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.previsao_processo
    (qt_dias                        NUMBER(3),
    tp_contagem_dias               VARCHAR2(1),
    evl_cd_evento                  VARCHAR2(6) NOT NULL,
    mdl_cd_modalidade              NUMBER(2) NOT NULL,
    tp_avaliacao_licitacao         NUMBER(2) NOT NULL,
    sq_cronologia_evento           NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PREVISAO_PROCESSO

ALTER TABLE ifrdba2.previsao_processo
ADD CONSTRAINT ppro_pk PRIMARY KEY (evl_cd_evento, mdl_cd_modalidade, 
  tp_avaliacao_licitacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PREVISAO_PROCESSO

COMMENT ON TABLE ifrdba2.previsao_processo IS 'Tabela derivada de relacionamento- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PREVISAO_PROCESSO

-- Start of DDL Script for Table IFRDBA2.PROCESSO_LICITATORIO
-- Generated 9-mar-2004 19:06:17 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.processo_licitatorio
    (aa_processo                    NUMBER(4) NOT NULL,
    sq_processo                    NUMBER(4) NOT NULL,
    dep_cd_dependencia_detent      NUMBER(4) NOT NULL,
    mdl_cd_modalidade              NUMBER(2) NOT NULL,
    dt_abertura_processo           DATE NOT NULL,
    no_arquivo_parecer_tecnico     VARCHAR2(8),
    ds_justificativa_cancelamento  VARCHAR2(500),
    ds_objeto                      VARCHAR2(2000),
    dt_homologacao_cancelamento    DATE,
    dt_parecer_tecnico             DATE,
    in_tipo_processo               NUMBER(1) NOT NULL,
    nr_processo_administrativo     VARCHAR2(20),
    nr_projeto_basico              VARCHAR2(10),
    st_etapa_processo              NUMBER(2) NOT NULL,
    dep_cd_dependencia_benef       NUMBER(4) NOT NULL,
    uo_cd_unid_organ               NUMBER(9) NOT NULL,
    lrc_sq_lote                    NUMBER(8),
    in_homologacao_cancelamento    NUMBER(1),
    cd_recurso_orcamentario        VARCHAR2(25),
    tp_natureza_processo           NUMBER(2),
    cpl_dep_cd_dependencia         NUMBER(4),
    cpl_sq_comissao_perm           NUMBER(6),
    tp_avaliacao_licitacao         NUMBER(2),
    no_arq_parecer_prop_tecn       VARCHAR2(8),
    dt_parecer_prop_tecn           DATE,
    nr_definitivo_processo         NUMBER(4),
    aa_definitivo_processo         NUMBER(4),
    dt_processo_administrativo     DATE,
    no_diretorio_documentos        VARCHAR2(30),
    in_gera_sms_contrato           NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.PROCESSO_LICITATORIO

CREATE INDEX ifrdba2.pl_rcl_fk_i ON ifrdba2.processo_licitatorio
  (
    lrc_sq_lote                     ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.processo_licitatorio_01_ix ON ifrdba2.processo_licitatorio
  (
    mdl_cd_modalidade               ASC,
    aa_definitivo_processo          ASC,
    dep_cd_dependencia_detent       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.PROCESSO_LICITATORIO

ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_pk PRIMARY KEY (aa_processo, sq_processo, 
  dep_cd_dependencia_detent, mdl_cd_modalidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.PROCESSO_LICITATORIO

COMMENT ON TABLE ifrdba2.processo_licitatorio IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.PROCESSO_LICITATORIO

-- Start of DDL Script for Table IFRDBA2.PROGRAMA_ORCAMENTARIO
-- Generated 9-mar-2004 19:06:26 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.programa_orcamentario
    (cd_programa                    NUMBER(3) NOT NULL,
    ds_programa                    VARCHAR2(30) NOT NULL,
    cd_programa_chave              VARCHAR2(2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROGRAMA_ORCAMENTARIO

ALTER TABLE ifrdba2.programa_orcamentario
ADD CONSTRAINT po_pk PRIMARY KEY (cd_programa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROGRAMA_ORCAMENTARIO

-- Start of DDL Script for Table IFRDBA2.PROJECAO_MENSAL_REC_SIM
-- Generated 9-mar-2004 19:06:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.projecao_mensal_rec_sim
    (prs_dep_cd_dependencia         NUMBER(4) NOT NULL,
    prs_vsp_cd_nivel_versao        VARCHAR2(2) NOT NULL,
    prs_vsp_cd_versao              VARCHAR2(2) NOT NULL,
    prs_vsp_nr_ano                 NUMBER(4) NOT NULL,
    prs_nr_seq                     VARCHAR2(21) NOT NULL,
    mm_receita                     NUMBER(2) NOT NULL,
    vl_estimado                    NUMBER(14,2),
    vl_estimado_dolar              NUMBER(14,2),
    in_escolhida                   NUMBER(2),
    in_replicacao                  VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROJECAO_MENSAL_REC_SIM

ALTER TABLE ifrdba2.projecao_mensal_rec_sim
ADD CONSTRAINT pms_pk PRIMARY KEY (prs_dep_cd_dependencia, 
  prs_vsp_cd_nivel_versao, prs_vsp_cd_versao, prs_vsp_nr_ano, prs_nr_seq, 
  mm_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROJECAO_MENSAL_REC_SIM

-- Start of DDL Script for Table IFRDBA2.PROJECAO_RECEITA
-- Generated 9-mar-2004 19:06:33 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.projecao_receita
    (nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_seq                         NUMBER(5) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20),
    tar_cd_regime                  NUMBER(2),
    tdr_cd_despesa_receita         VARCHAR2(5),
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROJECAO_RECEITA

ALTER TABLE ifrdba2.projecao_receita
ADD CONSTRAINT pjr_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROJECAO_RECEITA

-- Start of DDL Script for Table IFRDBA2.PROJECAO_RECEITA_SIMULADA
-- Generated 9-mar-2004 19:06:37 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.projecao_receita_simulada
    (cc1_nr_conta                   VARCHAR2(20),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    tar_cd_regime                  NUMBER(2),
    vsp_cd_nivel_versao            VARCHAR2(2) NOT NULL,
    vsp_cd_versao                  VARCHAR2(2) NOT NULL,
    vsp_nr_ano                     NUMBER(4) NOT NULL,
    nr_seq                         VARCHAR2(21) NOT NULL,
    in_escolhida                   NUMBER(2),
    in_replicacao                  VARCHAR2(1),
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2),
    val_jan1                       NUMBER(14,2),
    val_fev1                       NUMBER(14,2),
    val_mar1                       NUMBER(14,2),
    val_abr1                       NUMBER(14,2),
    val_mai1                       NUMBER(14,2),
    val_jun1                       NUMBER(14,2),
    val_jul1                       NUMBER(14,2),
    val_ago1                       NUMBER(14,2),
    val_set1                       NUMBER(14,2),
    val_out1                       NUMBER(14,2),
    val_nov1                       NUMBER(14,2),
    val_dez1                       NUMBER(14,2),
    val_jan2                       NUMBER(14,2),
    val_fev2                       NUMBER(14,2),
    val_mar2                       NUMBER(14,2),
    val_abr2                       NUMBER(14,2),
    val_mai2                       NUMBER(14,2),
    val_jun2                       NUMBER(14,2),
    val_jul2                       NUMBER(14,2),
    val_ago2                       NUMBER(14,2),
    val_set2                       NUMBER(14,2),
    val_out2                       NUMBER(14,2),
    val_nov2                       NUMBER(14,2),
    val_dez2                       NUMBER(14,2),
    val_jan3                       NUMBER(14,2),
    val_fev3                       NUMBER(14,2),
    val_mar3                       NUMBER(14,2),
    val_abr3                       NUMBER(14,2),
    val_mai3                       NUMBER(14,2),
    val_jun3                       NUMBER(14,2),
    val_jul3                       NUMBER(14,2),
    val_ago3                       NUMBER(14,2),
    val_set3                       NUMBER(14,2),
    val_out3                       NUMBER(14,2),
    val_nov3                       NUMBER(14,2),
    val_dez3                       NUMBER(14,2),
    val_jan4                       NUMBER(14,2),
    val_fev4                       NUMBER(14,2),
    val_mar4                       NUMBER(14,2),
    val_abr4                       NUMBER(14,2),
    val_mai4                       NUMBER(14,2),
    val_jun4                       NUMBER(14,2),
    val_jul4                       NUMBER(14,2),
    val_ago4                       NUMBER(14,2),
    val_set4                       NUMBER(14,2),
    val_out4                       NUMBER(14,2),
    val_nov4                       NUMBER(14,2),
    val_dez4                       NUMBER(14,2),
    val_jan5                       NUMBER(14,2),
    val_fev5                       NUMBER(14,2),
    val_mar5                       NUMBER(14,2),
    val_abr5                       NUMBER(14,2),
    val_mai5                       NUMBER(14,2),
    val_jun5                       NUMBER(14,2),
    val_jul5                       NUMBER(14,2),
    val_ago5                       NUMBER(14,2),
    val_set5                       NUMBER(14,2),
    val_out5                       NUMBER(14,2),
    val_nov5                       NUMBER(14,2),
    val_dez5                       NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROJECAO_RECEITA_SIMULADA

ALTER TABLE ifrdba2.projecao_receita_simulada
ADD CONSTRAINT prs_pk PRIMARY KEY (vsp_nr_ano, vsp_cd_nivel_versao, 
  vsp_cd_versao, dep_cd_dependencia, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROJECAO_RECEITA_SIMULADA

-- Start of DDL Script for Table IFRDBA2.PROJETO
-- Generated 9-mar-2004 19:06:42 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.projeto
    (cd_projeto                     VARCHAR2(4) NOT NULL,
    ds_projeto                     VARCHAR2(40) NOT NULL,
    cd_projeto_chave               VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROJETO

ALTER TABLE ifrdba2.projeto
ADD CONSTRAINT prj_pk PRIMARY KEY (cd_projeto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROJETO

-- Start of DDL Script for Table IFRDBA2.PROJETO_SMART
-- Generated 9-mar-2004 19:06:45 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.projeto_smart
    (cd_projeto                     VARCHAR2(4) NOT NULL,
    ds_projeto                     VARCHAR2(40),
    cd_projeto_chave               VARCHAR2(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.PROJETO_SMART

ALTER TABLE ifrdba2.projeto_smart
ADD CONSTRAINT cd_projeto_pk PRIMARY KEY (cd_projeto)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.PROJETO_SMART

-- Start of DDL Script for Table IFRDBA2.QUANTIDADE_TARIFACAO
-- Generated 9-mar-2004 19:06:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.quantidade_tarifacao
    (lat_nr_lancamento              NUMBER(38) NOT NULL,
    det_cd_demonstra_tarifacao     NUMBER(3) NOT NULL,
    qt_tarifacao                   NUMBER(8),
    vl_tarifacao                   NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.QUANTIDADE_TARIFACAO

ALTER TABLE ifrdba2.quantidade_tarifacao
ADD CONSTRAINT qta_pk PRIMARY KEY (lat_nr_lancamento, det_cd_demonstra_tarifacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.QUANTIDADE_TARIFACAO

-- Start of DDL Script for Table IFRDBA2.RECEBIMENTO
-- Generated 9-mar-2004 19:06:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.recebimento
    (nr_lancamento                  NUMBER(38) NOT NULL,
    in_tesouraria                  NUMBER(1),
    nr_doc_fiscal                  VARCHAR2(10),
    ds_historico_recto             VARCHAR2(40),
    dt_recebimento                 DATE,
    fpg_cd_forma_pagamento         VARCHAR2(2),
    evc_nr_evento                  NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RECEBIMENTO

ALTER TABLE ifrdba2.recebimento
ADD CONSTRAINT rcb_pk PRIMARY KEY (nr_lancamento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RECEBIMENTO

-- Start of DDL Script for Table IFRDBA2.RECEITA
-- Generated 9-mar-2004 19:06:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.receita
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    cc1_nr_conta                   VARCHAR2(20),
    dt_receita                     DATE NOT NULL,
    vl_receita                     NUMBER(14,2),
    ds_historico                   VARCHAR2(40),
    tdr_cd_despesa_receita         VARCHAR2(5) NOT NULL,
    nr_seq                         NUMBER(2) NOT NULL,
    in_receita_despesa             VARCHAR2(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RECEITA

ALTER TABLE ifrdba2.receita
ADD CONSTRAINT rec_pk PRIMARY KEY (dep_cd_dependencia, tdr_cd_despesa_receita, 
  dt_receita, nr_seq)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RECEITA

-- Start of DDL Script for Table IFRDBA2.RECEITA_FINANCEIRA
-- Generated 9-mar-2004 19:07:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.receita_financeira
    (cd_receita_financeira          VARCHAR2(2) NOT NULL,
    no_receita_financeira          VARCHAR2(30) NOT NULL,
    evc_nr_evento                  NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RECEITA_FINANCEIRA

ALTER TABLE ifrdba2.receita_financeira
ADD CONSTRAINT ref_pk PRIMARY KEY (cd_receita_financeira)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RECEITA_FINANCEIRA

-- Start of DDL Script for Table IFRDBA2.RECEITAS_ORCAMENTO
-- Generated 9-mar-2004 19:07:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.receitas_orcamento
    (nro_ano                        NUMBER(4) NOT NULL,
    cod_dependencia                NUMBER(4) NOT NULL,
    nro_receita                    NUMBER(5) NOT NULL,
    nro_conta                      VARCHAR2(20),
    cod_regime                     NUMBER(2),
    val_jan                        NUMBER(14,2),
    val_fev                        NUMBER(14,2),
    val_mar                        NUMBER(14,2),
    val_abr                        NUMBER(14,2),
    val_mai                        NUMBER(14,2),
    val_jun                        NUMBER(14,2),
    val_jul                        NUMBER(14,2),
    val_ago                        NUMBER(14,2),
    val_set                        NUMBER(14,2),
    val_out                        NUMBER(14,2),
    val_nov                        NUMBER(14,2),
    val_dez                        NUMBER(14,2),
    val_jan1                       NUMBER(14,2),
    val_fev1                       NUMBER(14,2),
    val_mar1                       NUMBER(14,2),
    val_abr1                       NUMBER(14,2),
    val_mai1                       NUMBER(14,2),
    val_jun1                       NUMBER(14,2),
    val_jul1                       NUMBER(14,2),
    val_ago1                       NUMBER(14,2),
    val_set1                       NUMBER(14,2),
    val_out1                       NUMBER(14,2),
    val_nov1                       NUMBER(14,2),
    val_dez1                       NUMBER(14,2),
    val_jan2                       NUMBER(14,2),
    val_fev2                       NUMBER(14,2),
    val_mar2                       NUMBER(14,2),
    val_abr2                       NUMBER(14,2),
    val_mai2                       NUMBER(14,2),
    val_jun2                       NUMBER(14,2),
    val_jul2                       NUMBER(14,2),
    val_ago2                       NUMBER(14,2),
    val_set2                       NUMBER(14,2),
    val_out2                       NUMBER(14,2),
    val_nov2                       NUMBER(14,2),
    val_dez2                       NUMBER(14,2),
    val_jan3                       NUMBER(14,2),
    val_fev3                       NUMBER(14,2),
    val_mar3                       NUMBER(14,2),
    val_abr3                       NUMBER(14,2),
    val_mai3                       NUMBER(14,2),
    val_jun3                       NUMBER(14,2),
    val_jul3                       NUMBER(14,2),
    val_ago3                       NUMBER(14,2),
    val_set3                       NUMBER(14,2),
    val_out3                       NUMBER(14,2),
    val_nov3                       NUMBER(14,2),
    val_dez3                       NUMBER(14,2),
    val_jan4                       NUMBER(14,2),
    val_fev4                       NUMBER(14,2),
    val_mar4                       NUMBER(14,2),
    val_abr4                       NUMBER(14,2),
    val_mai4                       NUMBER(14,2),
    val_jun4                       NUMBER(14,2),
    val_jul4                       NUMBER(14,2),
    val_ago4                       NUMBER(14,2),
    val_set4                       NUMBER(14,2),
    val_out4                       NUMBER(14,2),
    val_nov4                       NUMBER(14,2),
    val_dez4                       NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RECEITAS_ORCAMENTO

ALTER TABLE ifrdba2.receitas_orcamento
ADD CONSTRAINT reo_pk PRIMARY KEY (nro_ano, cod_dependencia, nro_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RECEITAS_ORCAMENTO

-- Start of DDL Script for Table IFRDBA2.RECURSO_LICITATORIO
-- Generated 9-mar-2004 19:07:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.recurso_licitatorio
    (sq_recurso                     NUMBER(6) NOT NULL,
    pdl_for_nr_cgc_cpf_alvo        VARCHAR2(14) NOT NULL,
    pdl_lrc_sq_lote_alvo           NUMBER(8) NOT NULL,
    pl_aa_processo                 NUMBER(4) NOT NULL,
    pl_sq_processo                 NUMBER(4) NOT NULL,
    pl_dep_cd_dependencia_detent   NUMBER(4) NOT NULL,
    pl_mdl_cd_modalidade           NUMBER(2) NOT NULL,
    dt_recurso                     DATE NOT NULL,
    in_resultado                   NUMBER(1) NOT NULL,
    no_arquivo_recurso             VARCHAR2(8) NOT NULL,
    tp_recurso                     NUMBER(1) NOT NULL,
    tp_impetrado                   NUMBER(1) NOT NULL,
    pdl_for_nr_cgc_cpf_imp         VARCHAR2(14),
    pdl_lrc_sq_lote_imp            NUMBER(8),
    pdl_for_dep_cd_dependencia_te  NUMBER(4) NOT NULL,
    pdl_for_dep_cd_dependencia_do  NUMBER(4),
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RECURSO_LICITATORIO

ALTER TABLE ifrdba2.recurso_licitatorio
ADD CONSTRAINT rl_pk PRIMARY KEY (sq_recurso, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.RECURSO_LICITATORIO

COMMENT ON TABLE ifrdba2.recurso_licitatorio IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.RECURSO_LICITATORIO

-- Start of DDL Script for Table IFRDBA2.REFORMULACAO_ANDAMENTO
-- Generated 9-mar-2004 19:07:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.reformulacao_andamento
    (nr_reformulacao                NUMBER(2) NOT NULL,
    dt_inicio_reformulacao         DATE NOT NULL,
    dt_final_reformulacao          DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.REFORMULACAO_ANDAMENTO

ALTER TABLE ifrdba2.reformulacao_andamento
ADD CONSTRAINT reform_pk PRIMARY KEY (nr_reformulacao, dt_inicio_reformulacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.REFORMULACAO_ANDAMENTO

-- Start of DDL Script for Table IFRDBA2.REGIOES_GEOGRAFICAS
-- Generated 9-mar-2004 19:07:18 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.regioes_geograficas
    (uf_ufe_sigla                   VARCHAR2(2) NOT NULL,
    sg_regiao                      VARCHAR2(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.REGIOES_GEOGRAFICAS

ALTER TABLE ifrdba2.regioes_geograficas
ADD CONSTRAINT rge_ck_1 CHECK (       SG_REGIAO IN ('N','S','NE','CO','SE')       )
/
ALTER TABLE ifrdba2.regioes_geograficas
ADD CONSTRAINT rge_pk PRIMARY KEY (uf_ufe_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.REGIOES_GEOGRAFICAS

-- Start of DDL Script for Table IFRDBA2.RELACIONA_CONTA_IMPRESSAO
-- Generated 9-mar-2004 19:07:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relaciona_conta_impressao
    (cd_conta                       NUMBER(4),
    cc1_nr_conta                   VARCHAR2(20),
    tar_cd_regime                  NUMBER(2),
    po_cd_programa                 NUMBER(3),
    in_considera                   NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELACIONA_CONTA_IMPRESSAO

-- Start of DDL Script for Table IFRDBA2.RELAT_CC_SELECIONADOS
-- Generated 9-mar-2004 19:07:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relat_cc_selecionados
    (nr_sequencial                  NUMBER NOT NULL,
    cd_centro_custo                NUMBER(5) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RELAT_CC_SELECIONADOS

ALTER TABLE ifrdba2.relat_cc_selecionados
ADD CONSTRAINT pk_rcs PRIMARY KEY (nr_sequencial, cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELAT_CC_SELECIONADOS

-- Start of DDL Script for Table IFRDBA2.RELAT_COLUNA_ANUAL
-- Generated 9-mar-2004 19:07:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relat_coluna_anual
    (nr_sequencial                  NUMBER(10) NOT NULL,
    nr_parte                       NUMBER(2) NOT NULL,
    ds_titulo_01                   VARCHAR2(20),
    nr_coluna_01                   NUMBER(10),
    ds_titulo_02                   VARCHAR2(20),
    nr_coluna_02                   NUMBER(10),
    ds_titulo_03                   VARCHAR2(20),
    nr_coluna_03                   NUMBER(10),
    ds_titulo_04                   VARCHAR2(20),
    nr_coluna_04                   NUMBER(10),
    ds_titulo_05                   VARCHAR2(20),
    nr_coluna_05                   NUMBER(10),
    ds_titulo_06                   VARCHAR2(20),
    nr_coluna_06                   NUMBER(10),
    ds_titulo_07                   VARCHAR2(20),
    nr_coluna_07                   NUMBER(10),
    ds_titulo_08                   VARCHAR2(20),
    nr_coluna_08                   NUMBER(10),
    ds_titulo_09                   VARCHAR2(20),
    nr_coluna_09                   NUMBER(10),
    ds_titulo_10                   VARCHAR2(20),
    nr_coluna_10                   NUMBER(10),
    ds_titulo_11                   VARCHAR2(20),
    nr_coluna_11                   NUMBER(10),
    ds_titulo_12                   VARCHAR2(20),
    nr_coluna_12                   NUMBER(10),
    ds_titulo_13                   VARCHAR2(20),
    nr_coluna_13                   NUMBER(10))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RELAT_COLUNA_ANUAL

ALTER TABLE ifrdba2.relat_coluna_anual
ADD CONSTRAINT rcal_pk PRIMARY KEY (nr_sequencial, nr_parte)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELAT_COLUNA_ANUAL

-- Start of DDL Script for Table IFRDBA2.RELAT_DEP_SELECIONADAS
-- Generated 9-mar-2004 19:07:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relat_dep_selecionadas
    (nr_sequencial                  NUMBER NOT NULL,
    cd_dependencia                 NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RELAT_DEP_SELECIONADAS

ALTER TABLE ifrdba2.relat_dep_selecionadas
ADD CONSTRAINT pk_relat_dep_sel PRIMARY KEY (nr_sequencial, cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELAT_DEP_SELECIONADAS

-- Start of DDL Script for Table IFRDBA2.RELAT_PROJ_CODIGO
-- Generated 9-mar-2004 19:07:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relat_proj_codigo
    (tp_parcela                     NUMBER(1) NOT NULL,
    cd_parcela                     NUMBER(3) NOT NULL,
    ds_parcela                     VARCHAR2(40))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RELAT_PROJ_CODIGO

ALTER TABLE ifrdba2.relat_proj_codigo
ADD CONSTRAINT relat_proj_codigo_pk PRIMARY KEY (tp_parcela, cd_parcela)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELAT_PROJ_CODIGO

-- Start of DDL Script for Table IFRDBA2.RELAT_PROJ_VALOR
-- Generated 9-mar-2004 19:07:38 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.relat_proj_valor
    (tp_parcela                     NUMBER(1) NOT NULL,
    cd_parcela                     NUMBER(3) NOT NULL,
    mm_parcela                     NUMBER(2) NOT NULL,
    vl_parcela                     NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RELAT_PROJ_VALOR

ALTER TABLE ifrdba2.relat_proj_valor
ADD CONSTRAINT relat_proj_valor_pk PRIMARY KEY (tp_parcela, cd_parcela, 
  mm_parcela)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RELAT_PROJ_VALOR

-- Start of DDL Script for Table IFRDBA2.REQUISICAO_COMPRA_ITEM
-- Generated 9-mar-2004 19:07:42 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.requisicao_compra_item
    (aa_requisicao_compra           NUMBER(4) NOT NULL,
    nr_requisicao_compra           NUMBER(6) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    ipd_dep_cd_dependencia         NUMBER(4) NOT NULL,
    dep_cd_dependencia_compra      NUMBER(4) NOT NULL,
    qt_compra                      NUMBER(12,2) NOT NULL,
    dt_requisicao                  DATE NOT NULL,
    tp_requisicao                  VARCHAR2(1) NOT NULL,
    ipd_ig_ci_cd_classe            VARCHAR2(4) NOT NULL,
    ipd_ig_cd_item                 VARCHAR2(7) NOT NULL,
    in_ja_licitado                 NUMBER(1),
    in_lote_montado                NUMBER(1),
    st_requisicao                  NUMBER(2),
    cd_programa                    NUMBER(3),
    ir_sq_item                     NUMBER(3),
    ir_os_aa_ordem_servico         NUMBER(4),
    ipc_imo_ipr_vpo_nr_ano         NUMBER(4),
    ipc_imo_ipr_dep_cd_dependencia NUMBER(4),
    qt_prazo_dias                  NUMBER(4),
    cc_cd_centro_custo             NUMBER(5),
    cd_centro_custo_gestor         NUMBER(5),
    ipc_imo_ipr_nr_item            NUMBER(5),
    ir_os_nr_ordem_servico         NUMBER(6),
    ipc_pc_nr_pre_compromisso      NUMBER(6),
    emp_nr_matricula_aut           NUMBER(7),
    nr_autorizacao                 NUMBER(10),
    dt_autorizacao                 DATE,
    ipc_imo_ipr_vpo_cd_versao      VARCHAR2(2),
    ipc_imo_mm_item                VARCHAR2(2),
    cd_projeto                     VARCHAR2(4),
    cc1_nr_conta                   VARCHAR2(20),
    ds_usuario                     VARCHAR2(50),
    ds_observacao                  VARCHAR2(2000),
    ds_justificativa               VARCHAR2(2000),
    cd_dependencia_autoriza        NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.REQUISICAO_COMPRA_ITEM

CREATE INDEX ifrdba2.req_comp_it_idx ON ifrdba2.requisicao_compra_item
  (
    ipd_dep_cd_dependencia          ASC,
    ipd_ig_ci_cd_classe             ASC,
    ipd_ig_cd_item                  ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.rci_ir_fk ON ifrdba2.requisicao_compra_item
  (
    ir_os_aa_ordem_servico          ASC,
    ir_os_nr_ordem_servico          ASC,
    ipd_dep_cd_dependencia          ASC,
    ir_sq_item                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.idx_requisicao_compra_item ON ifrdba2.requisicao_compra_item
  (
    cd_dependencia_autoriza         ASC,
    st_requisicao                   ASC,
    dt_requisicao                   ASC,
    cd_centro_custo_gestor          ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.REQUISICAO_COMPRA_ITEM

ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_pk PRIMARY KEY (dep_cd_dependencia, aa_requisicao_compra, 
  nr_requisicao_compra)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.REQUISICAO_COMPRA_ITEM

COMMENT ON TABLE ifrdba2.requisicao_compra_item IS 'SISMAT - '
/

-- End of DDL Script for Table IFRDBA2.REQUISICAO_COMPRA_ITEM

-- Start of DDL Script for Table IFRDBA2.REQUISICAO_COMPRA_PROVISORIA
-- Generated 9-mar-2004 19:07:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.requisicao_compra_provisoria
    (aa_requisicao_compra           NUMBER(4) NOT NULL,
    nr_requisicao_compra           NUMBER(6) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    sq_requisicao                  NUMBER(3) NOT NULL,
    dt_requisicao                  DATE NOT NULL,
    tp_requisicao                  VARCHAR2(1) NOT NULL,
    qt_compra                      NUMBER(4) NOT NULL,
    dt_ultima_compra               DATE NOT NULL,
    vl_ultima_compra               NUMBER(14,2) NOT NULL,
    cd_grupo                       VARCHAR2(2) NOT NULL,
    cd_classe                      VARCHAR2(6) NOT NULL,
    cd_item                        VARCHAR2(6) NOT NULL,
    ds_comercial                   VARCHAR2(60) NOT NULL,
    in_lote_montado                NUMBER(1) NOT NULL,
    tmf_cd_tipo_material_fornecim  NUMBER(6) NOT NULL,
    lrc_sq_lote                    NUMBER(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.REQUISICAO_COMPRA_PROVISORIA

ALTER TABLE ifrdba2.requisicao_compra_provisoria
ADD CONSTRAINT rcp_pk PRIMARY KEY (aa_requisicao_compra, nr_requisicao_compra, 
  dep_cd_dependencia, sq_requisicao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.REQUISICAO_COMPRA_PROVISORIA

COMMENT ON TABLE ifrdba2.requisicao_compra_provisoria IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.REQUISICAO_COMPRA_PROVISORIA

-- Start of DDL Script for Table IFRDBA2.REQUISICOES_COMPRAS_DO_LOTE
-- Generated 9-mar-2004 19:07:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.requisicoes_compras_do_lote
    (lrc_sq_lote                    NUMBER(8) NOT NULL,
    rci_dep_cd_dependencia         NUMBER(4) NOT NULL,
    rci_aa_requisicao_compra       NUMBER(4) NOT NULL,
    rci_nr_requisicao_compra       NUMBER(6) NOT NULL,
    dt_ultima_compra               DATE NOT NULL,
    vl_preco_unitario_atual        NUMBER(14,2) NOT NULL,
    sq_item_licitacao              NUMBER(4) NOT NULL,
    nr_lote                        NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.REQUISICOES_COMPRAS_DO_LOTE

CREATE INDEX ifrdba2.rcl_rci_fk ON ifrdba2.requisicoes_compras_do_lote
  (
    rci_dep_cd_dependencia          ASC,
    rci_aa_requisicao_compra        ASC,
    rci_nr_requisicao_compra        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.REQUISICOES_COMPRAS_DO_LOTE

ALTER TABLE ifrdba2.requisicoes_compras_do_lote
ADD CONSTRAINT rcl_pk PRIMARY KEY (lrc_sq_lote, rci_dep_cd_dependencia, 
  rci_aa_requisicao_compra, rci_nr_requisicao_compra)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.REQUISICOES_COMPRAS_DO_LOTE

COMMENT ON TABLE ifrdba2.requisicoes_compras_do_lote IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.REQUISICOES_COMPRAS_DO_LOTE

-- Start of DDL Script for Table IFRDBA2.RESGATE
-- Generated 9-mar-2004 19:08:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.resgate
    (apl_nr_aplicacao               NUMBER(8) NOT NULL,
    dt_referencia                  DATE NOT NULL,
    no_atendente                   VARCHAR2(30),
    vl_irrf                        NUMBER(14,2),
    vl_resgate                     NUMBER(14,2),
    qt_cotas                       NUMBER(14,4) NOT NULL,
    evc_nr_evento                  NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RESGATE

ALTER TABLE ifrdba2.resgate
ADD CONSTRAINT rsg_pk PRIMARY KEY (apl_nr_aplicacao, dt_referencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RESGATE

-- Start of DDL Script for Table IFRDBA2.RESULTADO_META_DEPENDENCIA
-- Generated 9-mar-2004 19:08:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.resultado_meta_dependencia
    (mta_cd_meta                    VARCHAR2(2) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    vl_resultado                   NUMBER(14,2),
    nr_ano                         NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RESULTADO_META_DEPENDENCIA

ALTER TABLE ifrdba2.resultado_meta_dependencia
ADD CONSTRAINT rmd_pk PRIMARY KEY (dep_cd_dependencia, mta_cd_meta, nr_ano)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RESULTADO_META_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.RETENCAO_TRIBUTO
-- Generated 9-mar-2004 19:08:10 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.retencao_tributo
    (tda_cd_deducao_acrescimo       VARCHAR2(3) NOT NULL,
    tp_retencao_tributo            NUMBER(1),
    no_dia_retencao_tributo        VARCHAR2(3),
    ds_retencao_tributo            VARCHAR2(30) NOT NULL,
    cd_darf                        VARCHAR2(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.RETENCAO_TRIBUTO

ALTER TABLE ifrdba2.retencao_tributo
ADD CONSTRAINT ret_pk PRIMARY KEY (tda_cd_deducao_acrescimo, cd_darf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.RETENCAO_TRIBUTO

-- Start of DDL Script for Table IFRDBA2.SAIDA_ESTOQUE
-- Generated 9-mar-2004 19:08:14 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.saida_estoque
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    aa_saida                       NUMBER(4) NOT NULL,
    nr_saida                       NUMBER(5) NOT NULL,
    dt_saida                       DATE NOT NULL,
    nm_cd_natureza                 CHAR(4) NOT NULL,
    in_estorno                     NUMBER(1),
    moe_cd_moeda                   NUMBER(3),
    ti_dep_cd_dependencia          NUMBER(4),
    ti_aa_solicitacao              NUMBER(4),
    cc_cd_centro_custo             NUMBER(5),
    ti_nr_solicitacao              NUMBER(6),
    uo_cd_unid_organ               NUMBER(9),
    dt_documento                   DATE,
    cd_aplicacao                   VARCHAR2(3),
    nr_documento                   VARCHAR2(50),
    ds_usuario                     VARCHAR2(50),
    ds_destino                     VARCHAR2(60),
    ds_observacao                  VARCHAR2(500),
    ds_justificativa_baixa         VARCHAR2(500),
    dt_estorno                     DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.SAIDA_ESTOQUE

CREATE INDEX ifrdba2.saida_estoque_001_ix ON ifrdba2.saida_estoque
  (
    dep_cd_dependencia              ASC,
    dt_saida                        ASC,
    in_estorno                      ASC,
    cd_aplicacao                    ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.SAIDA_ESTOQUE

ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_pk PRIMARY KEY (dep_cd_dependencia, aa_saida, nr_saida)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SAIDA_ESTOQUE

-- Start of DDL Script for Table IFRDBA2.SALDO_BANCARIO
-- Generated 9-mar-2004 19:08:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.saldo_bancario
    (cc_ban_cd_banco                VARCHAR2(3) NOT NULL,
    cc_tcc_tp_conta_corrente       VARCHAR2(1) NOT NULL,
    dt_saldo                       DATE NOT NULL,
    vl_saldo                       NUMBER(14,2) NOT NULL,
    tp_saldo                       VARCHAR2(1) NOT NULL,
    cc_age_dep_cd_dependencia      NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SALDO_BANCARIO

ALTER TABLE ifrdba2.saldo_bancario
ADD CONSTRAINT sbc_pk PRIMARY KEY (cc_ban_cd_banco, cc_tcc_tp_conta_corrente, 
  tp_saldo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SALDO_BANCARIO

-- Start of DDL Script for Table IFRDBA2.SALDO_QUANT_COMP
-- Generated 9-mar-2004 19:08:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.saldo_quant_comp
    (nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    mm_item                        NUMBER(2) NOT NULL,
    vl_saldo_comp                  NUMBER(14,2) NOT NULL,
    qt_programado_comp             NUMBER(6),
    vl_unitario_item               NUMBER(10,2),
    vl_saldo_pcomp                 NUMBER(14,2) NOT NULL,
    qt_programado_pcomp            NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SALDO_QUANT_COMP

ALTER TABLE ifrdba2.saldo_quant_comp
ADD CONSTRAINT sqc_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, nr_item, mm_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SALDO_QUANT_COMP

-- Start of DDL Script for Table IFRDBA2.SALDO_QUANT_PCOMP
-- Generated 9-mar-2004 19:08:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.saldo_quant_pcomp
    (nr_ano                         NUMBER(4) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_item                        NUMBER(5) NOT NULL,
    mm_item                        NUMBER(2) NOT NULL,
    vl_saldo_pcomp                 NUMBER(14,2) NOT NULL,
    qt_programado_pcomp            NUMBER(6),
    vl_unitario_item               NUMBER(10,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SALDO_QUANT_PCOMP

ALTER TABLE ifrdba2.saldo_quant_pcomp
ADD CONSTRAINT sqp_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, nr_item, mm_item)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SALDO_QUANT_PCOMP

-- Start of DDL Script for Table IFRDBA2.SALDO_RECEITA_FINANCEIRA
-- Generated 9-mar-2004 19:08:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.saldo_receita_financeira
    (ref_cd_receita_financeira      VARCHAR2(2) NOT NULL,
    nu_mes_ano_saldo_receita       VARCHAR2(4) NOT NULL,
    nu_saldo_receita               NUMBER(14,2) NOT NULL,
    vl_receita_financeira          NUMBER(14,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SALDO_RECEITA_FINANCEIRA

ALTER TABLE ifrdba2.saldo_receita_financeira
ADD CONSTRAINT sdr_pk PRIMARY KEY (ref_cd_receita_financeira, 
  nu_mes_ano_saldo_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SALDO_RECEITA_FINANCEIRA

-- Start of DDL Script for Table IFRDBA2.SEG_GRUPO_USUARIO
-- Generated 9-mar-2004 19:08:36 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_grupo_usuario
    (cd_grupo                       NUMBER(2) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    no_grupo                       VARCHAR2(30) NOT NULL,
    ds_grupo                       VARCHAR2(100),
    role                           VARCHAR2(30) NOT NULL,
    in_conexao_remota              NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_GRUPO_USUARIO

ALTER TABLE ifrdba2.seg_grupo_usuario
ADD CONSTRAINT sgu_pk PRIMARY KEY (cd_grupo, ss_cd_sistema)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_GRUPO_USUARIO

-- Start of DDL Script for Table IFRDBA2.SEG_GRUPO_USUARIO_MENU
-- Generated 9-mar-2004 19:08:41 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_grupo_usuario_menu
    (sq_funcao                      NUMBER(4) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    cd_grupo                       NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_GRUPO_USUARIO_MENU

ALTER TABLE ifrdba2.seg_grupo_usuario_menu
ADD CONSTRAINT sgum_pk PRIMARY KEY (sq_funcao, ss_cd_sistema, cd_grupo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_GRUPO_USUARIO_MENU

-- Start of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO
-- Generated 9-mar-2004 19:08:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_log_usuario
    (usuario                        VARCHAR2(30),
    data_hora                      DATE,
    acao                           VARCHAR2(1),
    id_usuario                     VARCHAR2(10),
    nome_usuario                   VARCHAR2(30),
    dep_cd_dependencia             NUMBER(4),
    cc2_cd_centro_custo            NUMBER(5),
    maquina                        VARCHAR2(64),
    programa                       VARCHAR2(64),
    sousuario                      VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO

-- Start of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO_DEPENDENCIA
-- Generated 9-mar-2004 19:08:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_log_usuario_dependencia
    (usuario                        VARCHAR2(30),
    data_hora                      DATE,
    acao                           VARCHAR2(1),
    sgu_id_usuario                 VARCHAR2(10),
    dep_cd_dependencia             NUMBER(4),
    maquina                        VARCHAR2(64),
    programa                       VARCHAR2(64),
    sousuario                      VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO_SISTEMA
-- Generated 9-mar-2004 19:08:49 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_log_usuario_sistema
    (usuario                        VARCHAR2(30),
    data_hora                      DATE,
    acao                           VARCHAR2(1),
    ss_cd_sistema                  NUMBER(2),
    sgu_cd_grupo                   NUMBER(2),
    su_id_usuario                  VARCHAR2(10),
    ds_usuario                     VARCHAR2(100),
    id_gerente_sistema             VARCHAR2(1),
    maquina                        VARCHAR2(64),
    programa                       VARCHAR2(64),
    sousuario                      VARCHAR2(15))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_LOG_USUARIO_SISTEMA

-- Start of DDL Script for Table IFRDBA2.SEG_MENU
-- Generated 9-mar-2004 19:08:51 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_menu
    (sq_funcao                      NUMBER(4) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    cd_modulo                      VARCHAR2(40) NOT NULL,
    cd_funcao                      VARCHAR2(40) NOT NULL,
    tb_principal                   VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_MENU

ALTER TABLE ifrdba2.seg_menu
ADD CONSTRAINT smen_pk PRIMARY KEY (sq_funcao, ss_cd_sistema)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.seg_menu
ADD CONSTRAINT smen_uk UNIQUE (ss_cd_sistema, cd_modulo, cd_funcao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_MENU

-- Start of DDL Script for Table IFRDBA2.SEG_SISTEMA
-- Generated 9-mar-2004 19:08:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_sistema
    (cd_sistema                     NUMBER(2) NOT NULL,
    no_sistema                     VARCHAR2(60) NOT NULL,
    sg_sistema                     VARCHAR2(10) NOT NULL,
    role_sistema                   CHAR(3),
    ind_manut                      CHAR(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_SISTEMA

ALTER TABLE ifrdba2.seg_sistema
ADD CONSTRAINT ss_pk PRIMARY KEY (cd_sistema)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.seg_sistema
ADD CONSTRAINT ss_un_sg_sistema UNIQUE (sg_sistema)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_SISTEMA

-- Start of DDL Script for Table IFRDBA2.SEG_USUARIO
-- Generated 9-mar-2004 19:09:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_usuario
    (id_usuario                     VARCHAR2(10) NOT NULL,
    no_usuario                     VARCHAR2(30) NOT NULL,
    dep_cd_dependencia             NUMBER(4),
    cc2_cd_centro_custo            NUMBER(5),
    ds_usuario                     VARCHAR2(100),
    sg_unidade                     VARCHAR2(4),
    cd_administradora              VARCHAR2(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_USUARIO

ALTER TABLE ifrdba2.seg_usuario
ADD CONSTRAINT su_pk PRIMARY KEY (id_usuario)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.SEG_USUARIO

CREATE TRIGGER ifrdba2.log_usuario
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.seg_usuario
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
      insert into seg_log_usuario (usuario,
                                   data_hora,
                                   acao,
                                   id_usuario,
                                   nome_usuario,
                                   dep_cd_dependencia,
                                   cc2_cd_centro_custo,
                                   maquina,
                                   programa,
                                   sousuario)
      values(user,
             sysdate,
             'I',
             :new.id_usuario,
             :new.no_usuario,
             :new.dep_cd_dependencia,
             :new.cc2_cd_centro_custo,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if updating then
      insert into seg_log_usuario (usuario,
                                   data_hora,
                                   acao,
                                   id_usuario,
                                   nome_usuario,
                                   dep_cd_dependencia,
                                   cc2_cd_centro_custo,
                                   maquina,
                                   programa,
                                   sousuario)
      values(user,
             sysdate,
             'U',
             :old.id_usuario,
             :old.no_usuario,
             :old.dep_cd_dependencia,
             :old.cc2_cd_centro_custo,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if deleting then
      insert into seg_log_usuario (usuario,
                                   data_hora,
                                   acao,
                                   id_usuario,
                                   nome_usuario,
                                   dep_cd_dependencia,
                                   cc2_cd_centro_custo,
                                   maquina,
                                   programa,
                                   sousuario)
      values(user,
             sysdate,
             'D',
             :old.id_usuario,
             :old.no_usuario,
             :old.dep_cd_dependencia,
             :old.cc2_cd_centro_custo,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
End;
/

-- End of DDL Script for Table IFRDBA2.SEG_USUARIO

-- Start of DDL Script for Table IFRDBA2.SEG_USUARIO_CENTRO_CUSTO
-- Generated 9-mar-2004 19:09:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_usuario_centro_custo
    (su_id_usuario                  VARCHAR2(10) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    cc2_cd_centro_custo            NUMBER(5) NOT NULL,
    in_cc2_principal               VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_USUARIO_CENTRO_CUSTO

ALTER TABLE ifrdba2.seg_usuario_centro_custo
ADD CONSTRAINT succ_pk PRIMARY KEY (su_id_usuario, ss_cd_sistema, 
  cc2_cd_centro_custo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEG_USUARIO_CENTRO_CUSTO

-- Start of DDL Script for Table IFRDBA2.SEG_USUARIO_SISTEMA
-- Generated 9-mar-2004 19:09:13 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seg_usuario_sistema
    (su_id_usuario                  VARCHAR2(10) NOT NULL,
    ss_cd_sistema                  NUMBER(2) NOT NULL,
    sgu_cd_grupo                   NUMBER(2) NOT NULL,
    ds_usuario                     VARCHAR2(100),
    id_gerente_sistema             VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEG_USUARIO_SISTEMA

ALTER TABLE ifrdba2.seg_usuario_sistema
ADD CONSTRAINT sus_pk PRIMARY KEY (su_id_usuario, ss_cd_sistema, sgu_cd_grupo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.SEG_USUARIO_SISTEMA

CREATE TRIGGER ifrdba2.log_usuario_sistema
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.seg_usuario_sistema
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
      insert into seg_log_usuario_sistema (usuario,
                                           data_hora,
                                           acao,
                                           ss_cd_sistema,
                                           sgu_cd_grupo,
                                           su_id_usuario,
                                           ds_usuario,
                                           id_gerente_sistema,
                                           maquina,
                                           programa,
                                           sousuario)
      values(user,
             sysdate,
             'I',
             :new.ss_cd_sistema,
             :new.sgu_cd_grupo,
             :new.su_id_usuario,
             :new.ds_usuario,
             :new.id_gerente_sistema,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if updating then
      insert into seg_log_usuario_sistema (usuario,
                                           data_hora,
                                           acao,
                                           ss_cd_sistema,
                                           sgu_cd_grupo,
                                           su_id_usuario,
                                           ds_usuario,
                                           id_gerente_sistema,
                                           maquina,
                                           programa,
                                           sousuario)
      values(user,
             sysdate,
             'U',
             :old.ss_cd_sistema,
             :old.sgu_cd_grupo,
             :old.su_id_usuario,
             :old.ds_usuario,
             :old.id_gerente_sistema,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
   if deleting then
      insert into seg_log_usuario_sistema (usuario,
                                           data_hora,
                                           acao,
                                           ss_cd_sistema,
                                           sgu_cd_grupo,
                                           su_id_usuario,
                                           ds_usuario,
                                           id_gerente_sistema,
                                           maquina,
                                           programa,
                                           sousuario)
      values(user,
             sysdate,
             'D',
             :old.ss_cd_sistema,
             :old.sgu_cd_grupo,
             :old.su_id_usuario,
             :old.ds_usuario,
             :old.id_gerente_sistema,
             v_maquina,
             v_programa,
             v_sousuario);
   end if;
End;
/
CREATE TRIGGER ifrdba2.aft_idu_seg_usuario_sistema
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.seg_usuario_sistema
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_SEG_USUARIO_SISTEMA (
SU_ID_USUARIO
,SS_CD_SISTEMA
,SGU_CD_GRUPO
,DS_USUARIO
,ID_GERENTE_SISTEMA
,tp_geracao
,quem_gerou
)
values (
:new.SU_ID_USUARIO
,:new.SS_CD_SISTEMA
,:new.SGU_CD_GRUPO
,:new.DS_USUARIO
,:new.ID_GERENTE_SISTEMA
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_SEG_USUARIO_SISTEMA (
SU_ID_USUARIO
,SS_CD_SISTEMA
,SGU_CD_GRUPO
,DS_USUARIO
,ID_GERENTE_SISTEMA
,tp_geracao
,quem_gerou
)
values (
:old.SU_ID_USUARIO
,:old.SS_CD_SISTEMA
,:old.SGU_CD_GRUPO
,:old.DS_USUARIO
,:old.ID_GERENTE_SISTEMA
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_SEG_USUARIO_SISTEMA (
SU_ID_USUARIO
,SS_CD_SISTEMA
,SGU_CD_GRUPO
,DS_USUARIO
,ID_GERENTE_SISTEMA
,tp_geracao
,quem_gerou
)
values (
:old.SU_ID_USUARIO
,:old.SS_CD_SISTEMA
,:old.SGU_CD_GRUPO
,:old.DS_USUARIO
,:old.ID_GERENTE_SISTEMA
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.SEG_USUARIO_SISTEMA

-- Start of DDL Script for Table IFRDBA2.SEGURADORA
-- Generated 9-mar-2004 19:09:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seguradora
    (cd_seguradora                  VARCHAR2(3) NOT NULL,
    no_seguradora                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEGURADORA

ALTER TABLE ifrdba2.seguradora
ADD CONSTRAINT seg_pk PRIMARY KEY (cd_seguradora)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEGURADORA

-- Start of DDL Script for Table IFRDBA2.SEQ_BOLETO
-- Generated 9-mar-2004 19:09:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seq_boleto
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    tdr_cd_despesa_receita         VARCHAR2(5) NOT NULL,
    nr_boleto                      NUMBER(4) NOT NULL,
    dt_alteracao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEQ_BOLETO

ALTER TABLE ifrdba2.seq_boleto
ADD CONSTRAINT sbo_pk PRIMARY KEY (dep_cd_dependencia, tdr_cd_despesa_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEQ_BOLETO

-- Start of DDL Script for Table IFRDBA2.SEQ_MDC
-- Generated 9-mar-2004 19:09:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seq_mdc
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_mdc_mes                     NUMBER(4),
    nr_mdc_ano                     NUMBER(4),
    dt_alteracao                   DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEQ_MDC

ALTER TABLE ifrdba2.seq_mdc
ADD CONSTRAINT smd_pk PRIMARY KEY (dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEQ_MDC

-- Start of DDL Script for Table IFRDBA2.SEQ_RECIBO
-- Generated 9-mar-2004 19:09:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.seq_recibo
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    nr_recibo                      NUMBER(6),
    dt_alteracao                   DATE,
    nr_recibo_cheque               NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SEQ_RECIBO

ALTER TABLE ifrdba2.seq_recibo
ADD CONSTRAINT sre_pk PRIMARY KEY (dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SEQ_RECIBO

-- Start of DDL Script for Table IFRDBA2.SERIE_MONETARIA
-- Generated 9-mar-2004 19:09:37 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.serie_monetaria
    (cd_serie                       NUMBER(3) NOT NULL,
    no_serie                       VARCHAR2(30) NOT NULL,
    ma_inicial                     NUMBER(6) NOT NULL,
    ma_final                       NUMBER(6),
    nr_criterio_conversao          NUMBER(2) NOT NULL,
    nr_criterio_correcao           NUMBER(2) NOT NULL,
    nr_criterio_depreciacao        NUMBER(2) NOT NULL,
    moe_cd_moeda                   NUMBER(3) NOT NULL,
    in_utiliz_serie                NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SERIE_MONETARIA

ALTER TABLE ifrdba2.serie_monetaria
ADD CONSTRAINT smo_pk PRIMARY KEY (cd_serie)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SERIE_MONETARIA

-- Start of DDL Script for Table IFRDBA2.SERVIDOR
-- Generated 9-mar-2004 19:09:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.servidor
    (no_string_conexao              VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SERVIDOR

-- Start of DDL Script for Table IFRDBA2.SICAF
-- Generated 9-mar-2004 19:09:42 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sicaf
    (cd_sicaf                       VARCHAR2(6) NOT NULL,
    ds_sicaf                       VARCHAR2(80) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SICAF

ALTER TABLE ifrdba2.sicaf
ADD CONSTRAINT scf_pk PRIMARY KEY (cd_sicaf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.SICAF

COMMENT ON TABLE ifrdba2.sicaf IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.SICAF

-- Start of DDL Script for Table IFRDBA2.SIPAT_EMPREGADOS
-- Generated 9-mar-2004 19:09:46 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sipat_empregados
    (nr_matricula                   NUMBER(7) NOT NULL,
    no_empregado                   VARCHAR2(50) NOT NULL,
    ds_cargo                       VARCHAR2(50),
    sg_unidade_org                 VARCHAR2(10),
    ds_unidade_org                 VARCHAR2(60),
    cd_dependencia                 NUMBER(4),
    dep_pagamento                  NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SIPAT_EMPREGADOS

ALTER TABLE ifrdba2.sipat_empregados
ADD CONSTRAINT sipatemp_pk PRIMARY KEY (nr_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SIPAT_EMPREGADOS

-- Start of DDL Script for Table IFRDBA2.SIPAT_INTERFACE_CONTABIL
-- Generated 9-mar-2004 19:09:50 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sipat_interface_contabil
    (nr_sequencial                  NUMBER(7) NOT NULL,
    smcp_in_uniao                  NUMBER(1),
    smcp_cp1_dep_cd_dependencia    NUMBER(4),
    cp_cc1_nr_conta                VARCHAR2(20),
    cd_centro_custo                NUMBER(5),
    dccd                           CHAR(1),
    in_operacao                    NUMBER(2),
    dapo_po_cd_programa            NUMBER(3),
    vl_mo                          NUMBER(17,2),
    vl_mr                          NUMBER(17,4),
    chave_contabil                 VARCHAR2(20),
    vl_dp_mo_ea                    NUMBER(17,2),
    vl_dp_mr_ea                    NUMBER(17,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.SIPAT_INTERFACE_CONTABIL

CREATE INDEX ifrdba2.sic_01 ON ifrdba2.sipat_interface_contabil
  (
    in_operacao                     ASC,
    smcp_in_uniao                   ASC,
    smcp_cp1_dep_cd_dependencia     ASC,
    cp_cc1_nr_conta                 ASC,
    dapo_po_cd_programa             ASC,
    cd_centro_custo                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.sic_02 ON ifrdba2.sipat_interface_contabil
  (
    in_operacao                     ASC,
    smcp_in_uniao                   ASC,
    smcp_cp1_dep_cd_dependencia     ASC,
    cp_cc1_nr_conta                 ASC,
    cd_centro_custo                 ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.SIPAT_INTERFACE_CONTABIL

ALTER TABLE ifrdba2.sipat_interface_contabil
ADD CONSTRAINT sic_pk PRIMARY KEY (nr_sequencial)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SIPAT_INTERFACE_CONTABIL

-- Start of DDL Script for Table IFRDBA2.SIPAT_INTERFACE_SEQUENCIAL
-- Generated 9-mar-2004 19:09:57 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sipat_interface_sequencial
    (smcp_cp1_dep_cd_dependencia    NUMBER(4) NOT NULL,
    nr_sequencial                  NUMBER(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SIPAT_INTERFACE_SEQUENCIAL

-- Start of DDL Script for Table IFRDBA2.SISTEMA
-- Generated 9-mar-2004 19:09:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sistema
    (cd_sistema                     NUMBER(5) NOT NULL,
    sis_cd_sistema                 NUMBER(5),
    no_sistema                     VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.SISTEMA

CREATE INDEX ifrdba2.sis_sis_fk_i ON ifrdba2.sistema
  (
    sis_cd_sistema                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.SISTEMA

ALTER TABLE ifrdba2.sistema
ADD CONSTRAINT sis_pk PRIMARY KEY (cd_sistema)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.SISTEMA

COMMENT ON TABLE ifrdba2.sistema IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.SISTEMA

-- Start of DDL Script for Table IFRDBA2.SIT_ANUAL_CONTA_PATRIM_EXE_ANT
-- Generated 9-mar-2004 19:10:04 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sit_anual_conta_patrim_exe_ant
    (cp1_cp_nr_conta                NUMBER(5) NOT NULL,
    cp1_dep_cd_dependencia         NUMBER(4) NOT NULL,
    aa_situacao                    NUMBER(4) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    vl_bem_cor_mo                  NUMBER(17,2),
    vl_bem_mr                      NUMBER(17,4),
    vl_dp_acum_cor_mo              NUMBER(17,2),
    vl_dp_acum_mr                  NUMBER(17,4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SIT_ANUAL_CONTA_PATRIM_EXE_ANT

ALTER TABLE ifrdba2.sit_anual_conta_patrim_exe_ant
ADD CONSTRAINT saca_pk PRIMARY KEY (cp1_cp_nr_conta, cp1_dep_cd_dependencia, 
  aa_situacao, in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SIT_ANUAL_CONTA_PATRIM_EXE_ANT

-- Start of DDL Script for Table IFRDBA2.SIT_MENSAL_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:10:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sit_mensal_bem_patrimonial
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    vl_bem_cor_bal_ant_mo          NUMBER(17,2) NOT NULL,
    vl_bem_cor_ate_mes_mo          NUMBER(17,2) NOT NULL,
    vl_cm_bem_mes_mo               NUMBER(17,2) NOT NULL,
    vl_cm_bem_ate_mes_mo           NUMBER(17,2) NOT NULL,
    vl_dp_acum_bal_ant_mr          NUMBER(17,4) NOT NULL,
    vl_dp_acum_cor_bal_ant_mo      NUMBER(17,2) NOT NULL,
    vl_dp_acum_ate_mes_mr          NUMBER(17,4) NOT NULL,
    vl_dp_acum_cor_ate_mes_mo      NUMBER(17,2) NOT NULL,
    vl_dp_mes_mo                   NUMBER(17,2) NOT NULL,
    vl_dp_acum_ate_mes_mo          NUMBER(17,2) NOT NULL,
    vl_cm_dp_mes_mo                NUMBER(17,2) NOT NULL,
    vl_cm_dp_ate_mes_mo            NUMBER(17,2) NOT NULL,
    vl_dp_acum_bal_ant_mo          NUMBER(17,2) NOT NULL,
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SIT_MENSAL_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.sit_mensal_bem_patrimonial
ADD CONSTRAINT smbp_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, ma_situacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.SIT_MENSAL_BEM_PATRIMONIAL

CREATE TRIGGER ifrdba2.trg_log_sit_mensal_bem_patrim
BEFORE  DELETE 
ON ifrdba2.sit_mensal_bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
	insert into log_sit_mensal_bem_patrimonial
	(   BP_NR_BEM
        ,BP_IN_UNIAO
        ,MA_SITUACAO
        ,VL_BEM_COR_BAL_ANT_MO
        ,VL_BEM_COR_ATE_MES_MO
        ,VL_CM_BEM_MES_MO
        ,VL_CM_BEM_ATE_MES_MO
        ,VL_DP_ACUM_BAL_ANT_MR
        ,VL_DP_ACUM_COR_BAL_ANT_MO
        ,VL_DP_ACUM_ATE_MES_MR
        ,VL_DP_ACUM_COR_ATE_MES_MO
        ,VL_DP_MES_MO
        ,VL_DP_ACUM_ATE_MES_MO
        ,VL_CM_DP_MES_MO
        ,VL_CM_DP_ATE_MES_MO
        ,VL_DP_ACUM_BAL_ANT_MO
        ,CD_CENTRO_NEGOCIO
        ,DEP_CD_DEPENDENCIA
	,NO_USUARIO
	,DT_OCORRENCIA
	)
	values
	(
         :old.BP_NR_BEM
        ,:old.BP_IN_UNIAO
        ,:old.MA_SITUACAO
        ,:old.VL_BEM_COR_BAL_ANT_MO
        ,:old.VL_BEM_COR_ATE_MES_MO
        ,:old.VL_CM_BEM_MES_MO
        ,:OLD.VL_CM_BEM_ATE_MES_MO
        ,:OLD.VL_DP_ACUM_BAL_ANT_MR
        ,:OLD.VL_DP_ACUM_COR_BAL_ANT_MO
        ,:OLD.VL_DP_ACUM_ATE_MES_MR
        ,:OLD.VL_DP_ACUM_COR_ATE_MES_MO
        ,:OLD.VL_DP_MES_MO
        ,:OLD.VL_DP_ACUM_ATE_MES_MO
        ,:OLD.VL_CM_DP_MES_MO
        ,:OLD.VL_CM_DP_ATE_MES_MO
        ,:OLD.VL_DP_ACUM_BAL_ANT_MO
        ,:OLD.CD_CENTRO_NEGOCIO
        ,:OLD.DEP_CD_DEPENDENCIA
	,USER
	,SYSDATE
	);
END;
/
CREATE TRIGGER ifrdba2.trg_smbp01
BEFORE INSERT 
ON ifrdba2.sit_mensal_bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
CURSOR pega_bem(NrBem IN NUMBER, InUniao IN NUMBER)
   IS
   -- pega o codigo da dependencia que esta manipulando o
   -- bem patrimonial
   SELECT bp.aat_dep_cd_dependencia
   FROM bem_patrimonial bp
WHERE
   bp.nr_bem = NrBem
   AND bp.in_uniao = InUniao;
CURSOR pega_dep(CdDependencia IN NUMBER)
   IS
   -- obtem o codigo da dependencia a qual esta dependencia
   -- esta subordinada
   SELECT dp.dep_dep_codigo
   FROM dependencias dp
WHERE
   dp.dep_codigo = CdDependencia;
WkCdDep NUMBER;
WkCdCdDep NUMBER;
BEGIN
   OPEN pega_bem(:new.bp_nr_bem, :new.bp_in_uniao);
   FETCH pega_bem INTO WkCdDep;
   -- Obs. via foreign key entre sit_mensal_bem_patrimonial e
   -- bem patrimonial, é garantido que haverá um valor para
   -- o bem patrimonial, portanto, não é necessário a validação
   CLOSE pega_bem;
   OPEN pega_dep(WkCdDep);
   FETCH pega_dep INTO WkCdCdDep;
   -- Obs. via foreign key entre bem_patrimonial e
   -- dependencias, é garantido que haverá um valor para
   -- a dependencia, portanto não é necessário a validação
   CLOSE pega_dep;
   :new.cd_centro_negocio := WkCdCdDep;
   :new.dep_cd_dependencia := WkCdDep;
END;
/

-- End of DDL Script for Table IFRDBA2.SIT_MENSAL_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.SIT_MENSAL_CONTA_PATRIMONIAL
-- Generated 9-mar-2004 19:10:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sit_mensal_conta_patrimonial
    (cp1_cp_nr_conta                NUMBER(5) NOT NULL,
    cp1_dep_cd_dependencia         NUMBER(4) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    vl_adi_bem_mo                  NUMBER(17,2),
    vl_adi_bem_mr                  NUMBER(17,4),
    vl_exc_adi_bem_mo              NUMBER(17,2),
    vl_exc_adi_bem_mr              NUMBER(17,4),
    vl_exc_cm_bem_mo               NUMBER(17,2),
    vl_exc_cm_bem_mo_ea            NUMBER(17,2),
    vl_transf_ent_bem_mo           NUMBER(17,2),
    vl_transf_ent_bem_mr           NUMBER(17,4),
    vl_transf_sai_bem_mo           NUMBER(17,2),
    vl_transf_sai_bem_mr           NUMBER(17,4),
    vl_baixa_bem_mo                NUMBER(17,2),
    vl_baixa_bem_mr                NUMBER(17,4),
    vl_cm_bem_mo                   NUMBER(17,2),
    vl_adi_dp_mo                   NUMBER(17,2),
    vl_adi_dp_mr                   NUMBER(17,4),
    vl_exc_dp_mo                   NUMBER(17,2),
    vl_exc_dp_mo_ea                NUMBER(17,2),
    vl_exc_cm_dp_mo                NUMBER(17,2),
    vl_exc_cm_dp_mo_ea             NUMBER(17,2),
    vl_exc_dp_mr                   NUMBER(17,4),
    vl_exc_dp_mr_ea                NUMBER(17,4),
    vl_transf_ent_dp_mo            NUMBER(17,2),
    vl_transf_ent_dp_mr            NUMBER(17,4),
    vl_transf_sai_dp_mo            NUMBER(17,2),
    vl_transf_sai_dp_mr            NUMBER(17,4),
    vl_baixa_dp_mo                 NUMBER(17,2),
    vl_baixa_dp_mr                 NUMBER(17,4),
    vl_cm_dp_mo                    NUMBER(17,2),
    vl_adi_bem_acum_ex_mo          NUMBER(17,2),
    vl_adi_bem_acum_ex_mr          NUMBER(17,4),
    vl_exc_adi_bem_acum_ex_mo      NUMBER(17,2),
    vl_exc_adi_bem_acum_ex_mr      NUMBER(17,4),
    vl_exc_cm_bem_acum_ex_mo       NUMBER(17,2),
    vl_exc_cm_bem_acum_ex_mo_ea    NUMBER(17,2),
    vl_transf_ent_bem_acum_ex_mo   NUMBER(17,2),
    vl_transf_ent_bem_acum_ex_mr   NUMBER(17,4),
    vl_transf_sai_bem_acum_ex_mo   NUMBER(17,2),
    vl_transf_sai_bem_acum_ex_mr   NUMBER(17,4),
    vl_baixa_bem_acum_ex_mo        NUMBER(17,2),
    vl_baixa_bem_acum_ex_mr        NUMBER(17,4),
    vl_cm_bem_acum_ex_mo           NUMBER(17,2),
    vl_adi_dp_acum_ex_mo           NUMBER(17,2),
    vl_adi_dp_acum_ex_mr           NUMBER(17,4),
    vl_exc_dp_acum_ex_mo           NUMBER(17,2),
    vl_exc_dp_acum_ex_mo_ea        NUMBER(17,2),
    vl_exc_cm_dp_acum_ex_mo        NUMBER(17,2),
    vl_exc_cm_dp_acum_ex_mo_ea     NUMBER(17,2),
    vl_exc_dp_acum_ex_mr           NUMBER(17,4),
    vl_exc_dp_acum_ex_mr_ea        NUMBER(17,4),
    vl_transf_ent_dp_acum_ex_mo    NUMBER(17,2),
    vl_transf_ent_dp_acum_ex_mr    NUMBER(17,4),
    vl_transf_sai_dp_acum_ex_mo    NUMBER(17,2),
    vl_transf_sai_dp_acum_ex_mr    NUMBER(17,4),
    vl_baixa_dp_acum_ex_mo         NUMBER(17,2),
    vl_baixa_dp_acum_ex_mr         NUMBER(17,4),
    vl_cm_dp_acum_ex_mo            NUMBER(17,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SIT_MENSAL_CONTA_PATRIMONIAL

ALTER TABLE ifrdba2.sit_mensal_conta_patrimonial
ADD CONSTRAINT smcp_pk PRIMARY KEY (cp1_cp_nr_conta, cp1_dep_cd_dependencia, 
  ma_situacao, in_uniao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SIT_MENSAL_CONTA_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.SITUACAO_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:10:19 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.situacao_bem_patrimonial
    (cd_situacao                    NUMBER(2) NOT NULL,
    in_depreciacao                 NUMBER(1) NOT NULL,
    no_situacao                    VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SITUACAO_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.situacao_bem_patrimonial
ADD CONSTRAINT sbp_pk PRIMARY KEY (cd_situacao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SITUACAO_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.SMS
-- Generated 9-mar-2004 19:10:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sms
    (aa_sms                         NUMBER(4) NOT NULL,
    nr_sms                         NUMBER(8) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    pdl_for_nr_cgc_cpf             VARCHAR2(14) NOT NULL,
    pdl_lrc_sq_lote                NUMBER(8) NOT NULL,
    dt_provavel_entrega            DATE NOT NULL,
    dt_entrega_atualizada          DATE,
    dt_efetiva_entrega             DATE,
    in_liberado_pgto               NUMBER(1) NOT NULL,
    in_servico_material            NUMBER(1) NOT NULL,
    dt_expedicao                   DATE NOT NULL,
    dt_recebimento                 DATE,
    ds_justificativa_atraso        VARCHAR2(200),
    pdl_for_dep_cd_dependencia     NUMBER(4) NOT NULL,
    tx_observacao                  VARCHAR2(1500),
    nr_definitivo_sms              NUMBER(10),
    aa_definitivo_sms              NUMBER(4),
    nr_laudo_rep                   VARCHAR2(8),
    in_sms_contrato                NUMBER(1) NOT NULL,
    dt_encaminhamento_contrato     DATE,
    uo_cd_unid_organ_destino       NUMBER(9),
    nr_definitivo_contrato         VARCHAR2(30),
    dt_assinatura_contrato         DATE,
    dt_entrega_os_sms              DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.SMS

CREATE INDEX ifrdba2.sms_dep_fk_i ON ifrdba2.sms
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.sms_pdl_fk_i ON ifrdba2.sms
  (
    pdl_for_nr_cgc_cpf              ASC,
    pdl_lrc_sq_lote                 ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.SMS

ALTER TABLE ifrdba2.sms
ADD CONSTRAINT sms_pk PRIMARY KEY (aa_sms, nr_sms, dep_cd_dependencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.SMS

COMMENT ON TABLE ifrdba2.sms IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.SMS

-- Start of DDL Script for Table IFRDBA2.SMS_NF_FOR_DEP
-- Generated 9-mar-2004 19:10:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sms_nf_for_dep
    (sms_aa_sms                     NUMBER(4) NOT NULL,
    sms_nr_sms                     NUMBER(8) NOT NULL,
    sms_dep_cd_dependencia         NUMBER(4) NOT NULL,
    nfd_ford_dep_cd_dependencia    NUMBER(4) NOT NULL,
    nfd_ford_for_nr_cgc_cpf        VARCHAR2(14) NOT NULL,
    nfd_nr_nota_fiscal             NUMBER(12) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SMS_NF_FOR_DEP

ALTER TABLE ifrdba2.sms_nf_for_dep
ADD CONSTRAINT snf_pk PRIMARY KEY (sms_aa_sms, sms_nr_sms, 
  sms_dep_cd_dependencia, nfd_ford_dep_cd_dependencia, nfd_ford_for_nr_cgc_cpf, 
  nfd_nr_nota_fiscal)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.SMS_NF_FOR_DEP

COMMENT ON TABLE ifrdba2.sms_nf_for_dep IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.SMS_NF_FOR_DEP

-- Start of DDL Script for Table IFRDBA2.SMS_OUTRA_DEPENDENCIA
-- Generated 9-mar-2004 19:10:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.sms_outra_dependencia
    (aa_sms                         NUMBER(4) NOT NULL,
    nr_sms                         NUMBER(8) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    vl_desconto_nota               NUMBER(3) NOT NULL,
    in_impedimento                 NUMBER(1),
    in_servico_material            NUMBER(1) NOT NULL,
    dt_provavel_entrega            DATE NOT NULL,
    dt_entrega_atualizada          DATE,
    dt_efetiva_entrega             DATE,
    vl_total                       NUMBER(17,5),
    nr_compromisso_orc             VARCHAR2(10),
    in_liberado_pgto               NUMBER(1) NOT NULL,
    ds_justificativa_atraso        VARCHAR2(200),
    dt_expedicao                   DATE,
    pdl_for_dep_cd_dependencia     NUMBER(4) NOT NULL,
    pdl_for_nr_cgc_cpf             VARCHAR2(14) NOT NULL,
    pdl_lrc_sq_lote                NUMBER(8) NOT NULL,
    nr_definitivo_sms              NUMBER(10),
    aa_definitivo_sms              NUMBER(4),
    nr_laudo_rep                   VARCHAR2(8),
    dt_recebimento                 DATE,
    in_sms_contrato                NUMBER(1) NOT NULL,
    dt_encaminhamento_contrato     DATE,
    uo_cd_unid_organ_destino       NUMBER(9),
    nr_definitivo_contrato         VARCHAR2(30),
    dt_assinatura_contrato         DATE,
    dt_entrega_os_sms              DATE,
    tx_observacao                  VARCHAR2(600))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.SMS_OUTRA_DEPENDENCIA

CREATE INDEX ifrdba2.sod_dep_fk_i ON ifrdba2.sms_outra_dependencia
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.SMS_OUTRA_DEPENDENCIA

ALTER TABLE ifrdba2.sms_outra_dependencia
ADD CONSTRAINT sod_pk PRIMARY KEY (aa_sms, nr_sms, dep_cd_dependencia)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.SMS_OUTRA_DEPENDENCIA

COMMENT ON TABLE ifrdba2.sms_outra_dependencia IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.SMS_OUTRA_DEPENDENCIA

-- Start of DDL Script for Table IFRDBA2.SS_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:10:41 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.ss_bem_patrimonial
    (nr_bem_atual                   VARCHAR2(12) NOT NULL,
    in_uniao_atual                 NUMBER(1) NOT NULL,
    nr_bem_ant                     NUMBER(7) NOT NULL,
    in_uniao_ant                   NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.SS_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.ss_bem_patrimonial
ADD CONSTRAINT ss_bp_pk PRIMARY KEY (nr_bem_atual, in_uniao_atual)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.SS_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.TAB_ACESS_SIMBEP
-- Generated 9-mar-2004 19:10:44 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_acess_simbep
    (oper_cracha_pk                 VARCHAR2(20) NOT NULL,
    aces_seq_pk                    NUMBER(6) NOT NULL,
    aces_senha                     VARCHAR2(10) NOT NULL,
    aces_datalimite                DATE NOT NULL,
    palm_serie_pk                  VARCHAR2(30),
    area_cod_pk                    NUMBER(6),
    aces_perfil                    NUMBER(2) NOT NULL,
    aces_oracle                    VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TAB_ACESS_SIMBEP

CREATE INDEX ifrdba2.ix_acess_oracle ON ifrdba2.tab_acess_simbep
  (
    aces_oracle                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TAB_ACESS_SIMBEP

ALTER TABLE ifrdba2.tab_acess_simbep
ADD CONSTRAINT pk_acess_simbep PRIMARY KEY (oper_cracha_pk, aces_seq_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_ACESS_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_ARFUN_SIMBEP
-- Generated 9-mar-2004 19:10:49 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_arfun_simbep
    (area_cod_pk                    NUMBER(6) NOT NULL,
    loc_cod_pk                     NUMBER(6),
    area_tel                       VARCHAR2(20),
    area_barra                     VARCHAR2(20),
    area_nom                       VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TAB_ARFUN_SIMBEP

CREATE INDEX ifrdba2.ix_arfun_barra01 ON ifrdba2.tab_arfun_simbep
  (
    area_barra                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TAB_ARFUN_SIMBEP

ALTER TABLE ifrdba2.tab_arfun_simbep
ADD CONSTRAINT pk_arfun_simbep PRIMARY KEY (area_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_ARFUN_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_AUTMO_SIMBEP
-- Generated 9-mar-2004 19:10:54 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_autmo_simbep
    (oper_detentor                  VARCHAR2(20) NOT NULL,
    tpmov_cod_pk                   NUMBER(3) NOT NULL,
    oper_operador                  VARCHAR2(20) NOT NULL,
    aut_datalimite                 DATE)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_AUTMO_SIMBEP

ALTER TABLE ifrdba2.tab_autmo_simbep
ADD CONSTRAINT pk_autmo_simbep PRIMARY KEY (oper_detentor, tpmov_cod_pk, 
  oper_operador)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_AUTMO_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_CORRETORA_VALORES
-- Generated 9-mar-2004 19:10:58 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_corretora_valores
    (cod_corretora                  VARCHAR2(3) NOT NULL,
    dsc_corretora                  VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_CORRETORA_VALORES

ALTER TABLE ifrdba2.tab_corretora_valores
ADD CONSTRAINT tb_corretora_valores_pk PRIMARY KEY (cod_corretora)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_CORRETORA_VALORES

-- Start of DDL Script for Table IFRDBA2.TAB_DATA_LIMITE_ORCAMENTO
-- Generated 9-mar-2004 19:11:01 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_data_limite_orcamento
    (tip_evento                     VARCHAR2(1),
    cod_dependencia                NUMBER(4) NOT NULL,
    ano_mes_referencia             NUMBER(6) NOT NULL,
    tip_operacao                   VARCHAR2(1),
    dat_inicio_orcamento           DATE NOT NULL,
    dat_fim_orcamento              DATE,
    dat_transacao                  DATE,
    cod_usuario                    VARCHAR2(10) NOT NULL,
    dsc_motivo                     VARCHAR2(1000),
    tip_dependencia                NUMBER(1),
    dlo_cod_dependencia            NUMBER(4),
    ind_dfot                       VARCHAR2(1) NOT NULL,
    num_nivel                      NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_DATA_LIMITE_ORCAMENTO

ALTER TABLE ifrdba2.tab_data_limite_orcamento
ADD CONSTRAINT dlo_dep_ck CHECK (  TIP_DEPENDENCIA IN (1,2,3)                                                      )
/
ALTER TABLE ifrdba2.tab_data_limite_orcamento
ADD CONSTRAINT dlo_evento_ck CHECK (  TIP_EVENTO IN ('I','A')                                                         )
/
ALTER TABLE ifrdba2.tab_data_limite_orcamento
ADD CONSTRAINT dlo_operacao_ck CHECK (  TIP_OPERACAO IN ('B','F')                                                       )
/
ALTER TABLE ifrdba2.tab_data_limite_orcamento
ADD CONSTRAINT dlo_ref_pk PRIMARY KEY (cod_dependencia, ano_mes_referencia, 
  num_nivel)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_DATA_LIMITE_ORCAMENTO

-- Start of DDL Script for Table IFRDBA2.TAB_ENDER_SIMBEP
-- Generated 9-mar-2004 19:11:06 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_ender_simbep
    (end_cod_pk                     NUMBER(6) NOT NULL,
    end_est                        VARCHAR2(2) NOT NULL,
    end_cep                        VARCHAR2(15) NOT NULL,
    end_ruanum                     VARCHAR2(50) NOT NULL,
    end_cid                        VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_ENDER_SIMBEP

ALTER TABLE ifrdba2.tab_ender_simbep
ADD CONSTRAINT pk_ender_simbep PRIMARY KEY (end_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_ENDER_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_EQADQ_SIMBEP
-- Generated 9-mar-2004 19:11:09 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_eqadq_simbep
    (eqadq_cod_pk                   VARCHAR2(20) NOT NULL,
    eqadq_fornec                   NUMBER(6) NOT NULL,
    eqadq_nf                       VARCHAR2(10) NOT NULL,
    eqadq_dthrsai                  DATE,
    eqadq_qtd                      NUMBER(6),
    eqadq_dsc_qtd                  VARCHAR2(200))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_EQADQ_SIMBEP

ALTER TABLE ifrdba2.tab_eqadq_simbep
ADD CONSTRAINT pk_eqadq_simbep PRIMARY KEY (eqadq_cod_pk, eqadq_fornec)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TAB_EQADQ_SIMBEP

CREATE TRIGGER ifrdba2.aft_idu_tab_eqadq_simbep
AFTER INSERT  OR UPDATE  OR  DELETE 
ON ifrdba2.tab_eqadq_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO LOG_TAB_EQADQ_SIMBEP (
EQADQ_COD_PK
,EQADQ_FORNEC
,EQADQ_NF
,EQADQ_DTHRSAI
,EQADQ_QTD
,EQADQ_DSC_QTD
,tp_geracao
,quem_gerou
)
values (
:new.EQADQ_COD_PK
,:new.EQADQ_FORNEC
,:new.EQADQ_NF
,:new.EQADQ_DTHRSAI
,:new.EQADQ_QTD
,:new.EQADQ_DSC_QTD
,'I'
,user
);
end if;
IF DELETING THEN
INSERT INTO LOG_TAB_EQADQ_SIMBEP (
EQADQ_COD_PK
,EQADQ_FORNEC
,EQADQ_NF
,EQADQ_DTHRSAI
,EQADQ_QTD
,EQADQ_DSC_QTD
,tp_geracao
,quem_gerou
)
values (
:old.EQADQ_COD_PK
,:old.EQADQ_FORNEC
,:old.EQADQ_NF
,:old.EQADQ_DTHRSAI
,:old.EQADQ_QTD
,:old.EQADQ_DSC_QTD
,'D'
,user
);
end if;
IF UPDATING THEN
INSERT INTO LOG_TAB_EQADQ_SIMBEP (
EQADQ_COD_PK
,EQADQ_FORNEC
,EQADQ_NF
,EQADQ_DTHRSAI
,EQADQ_QTD
,EQADQ_DSC_QTD
,tp_geracao
,quem_gerou
)
values (
:old.EQADQ_COD_PK
,:old.EQADQ_FORNEC
,:old.EQADQ_NF
,:old.EQADQ_DTHRSAI
,:old.EQADQ_QTD
,:old.EQADQ_DSC_QTD
,'U'
,user
);
end if;
END;
/

-- End of DDL Script for Table IFRDBA2.TAB_EQADQ_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_EQTER_SIMBEP
-- Generated 9-mar-2004 19:11:13 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_eqter_simbep
    (equiter_cod_pk                 VARCHAR2(20) NOT NULL,
    equiter_usu                    VARCHAR2(20),
    equiter_dthrent                DATE NOT NULL,
    equiter_dthrsai                DATE,
    equiter_forn                   NUMBER(6),
    equiter_nf                     VARCHAR2(10),
    visi_cracha_pk                 VARCHAR2(20),
    equiter_dsc                    VARCHAR2(150),
    equiter_numserie               VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_EQTER_SIMBEP

ALTER TABLE ifrdba2.tab_eqter_simbep
ADD CONSTRAINT pk_eqter_simbep PRIMARY KEY (equiter_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TAB_EQTER_SIMBEP

CREATE TRIGGER ifrdba2.tr01_tab_eqter_simbep
BEFORE  DELETE 
ON ifrdba2.tab_eqter_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  INSERT
  INTO HST_EQTER_SIMBEP
    (HEQT_COD_PK		,
     HEQT_USU		,
     HEQT_DTHRENT		,
     HEQT_DTHRSAI		,
     HEQT_FORN		,
     HEQT_NF		,
     HEQT_CRACHA  	,
     HEQT_DSC		,
     HEQT_NUMSERIE
    )
  VALUES
    (
     :OLD.EQUITER_COD_PK	,
     :OLD.EQUITER_USU		,
     :OLD.EQUITER_DTHRENT	,
     SYSDATE			,
     :OLD.EQUITER_FORN		,
     :OLD.EQUITER_NF		,
     :OLD.VISI_CRACHA_PK	,
     :OLD.EQUITER_DSC		,
     :OLD.EQUITER_NUMSERIE
     );
END TR01_TAB_EQTER_SIMBEP;
/
CREATE TRIGGER ifrdba2.tr02_tab_eqter_simbep
AFTER INSERT 
ON ifrdba2.tab_eqter_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    VALOR NUMBER(7);
BEGIN
  SELECT COUNT(*) INTO VALOR FROM HST_EQTER_SIMBEP
      WHERE HEQT_COD_PK = :NEW.EQUITER_COD_PK;
  IF VALOR <> 0 THEN
     DELETE HST_EQTER_SIMBEP
        WHERE HEQT_COD_PK = :NEW.EQUITER_COD_PK;
  END IF;
END TR02_TAB_EQTER_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.TAB_EQTER_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_ESTADO_SIMBEP
-- Generated 9-mar-2004 19:11:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_estado_simbep
    (est_cod_pk                     NUMBER(6) NOT NULL,
    est_sigla                      VARCHAR2(2) NOT NULL,
    est_nome                       VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_ESTADO_SIMBEP

ALTER TABLE ifrdba2.tab_estado_simbep
ADD CONSTRAINT pk_estado_simbep PRIMARY KEY (est_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_ESTADO_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_FORNE_SIMBEP
-- Generated 9-mar-2004 19:11:23 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_forne_simbep
    (forn_cod_pk                    NUMBER(6) NOT NULL,
    forn_cgc                       VARCHAR2(20) NOT NULL,
    forn_nom                       VARCHAR2(50) NOT NULL,
    forn_cep                       VARCHAR2(9),
    forn_est                       VARCHAR2(2),
    forn_tel                       VARCHAR2(20),
    forn_cid                       VARCHAR2(50),
    forn_end                       VARCHAR2(50),
    forn_prodesc                   VARCHAR2(50),
    forn_email                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_FORNE_SIMBEP

ALTER TABLE ifrdba2.tab_forne_simbep
ADD CONSTRAINT pk_forne_simbep PRIMARY KEY (forn_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TAB_FORNE_SIMBEP

CREATE TRIGGER ifrdba2.tr01_tab_forne_simbep
BEFORE  DELETE 
ON ifrdba2.tab_forne_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  INSERT
  INTO HST_FORNE_SIMBEP
    (
     HFORN_COD_PK    ,
     HFORN_CGC       ,
     HFORN_CEP       ,
     HFORN_EST       ,
     HFORN_TEL       ,
     HDATA_EXCLUSAO  ,
     HFORN_CID       ,
     HFORN_END       ,
     HFORN_NOM       ,
     HFORN_PRODESC   ,
     HFORN_EMAIL
    )
  VALUES
    (:OLD.FORN_COD_PK ,
     :OLD.FORN_CGC    ,
     :OLD.FORN_CEP    ,
     :OLD.FORN_EST    ,
     :OLD.FORN_TEL    ,
     SYSDATE         ,
     :OLD.FORN_CID    ,
     :OLD.FORN_END    ,
     :OLD.FORN_NOM    ,
     :OLD.FORN_PRODESC,
     :OLD.FORN_EMAIL
     );
END TR01_TAB_FORNE_SIMBEP;
/
CREATE TRIGGER ifrdba2.tr02_tab_forne_simbep
AFTER INSERT 
ON ifrdba2.tab_forne_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    VALOR NUMBER(7);
BEGIN
  SELECT count(*) INTO VALOR FROM HST_FORNE_SIMBEP
      WHERE HFORN_COD_PK = :NEW.FORN_COD_PK;
  IF VALOR <> 0 THEN
     DELETE HST_FORNE_SIMBEP
        WHERE HFORN_COD_PK = :NEW.FORN_COD_PK;
END IF;
END TR02_TAB_FORNE_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.TAB_FORNE_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_FUNCCLT_SIMBEP
-- Generated 9-mar-2004 19:11:29 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_funcclt_simbep
    (nr_matricula                   NUMBER(7) NOT NULL,
    no_empregado                   VARCHAR2(60) NOT NULL,
    ds_cargo                       VARCHAR2(10),
    cd_dependencia                 VARCHAR2(10),
    tp_status                      NUMBER(2) NOT NULL,
    cd_cracha                      VARCHAR2(20) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_FUNCCLT_SIMBEP

ALTER TABLE ifrdba2.tab_funcclt_simbep
ADD CONSTRAINT pk_funclt_simbep PRIMARY KEY (nr_matricula)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_FUNCCLT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_FUNOP_SIMBEP
-- Generated 9-mar-2004 19:11:32 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_funop_simbep
    (func_cod                       NUMBER(2) NOT NULL,
    func_dsc                       VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_FUNOP_SIMBEP

ALTER TABLE ifrdba2.tab_funop_simbep
ADD CONSTRAINT pk_funop_simbep PRIMARY KEY (func_cod)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_FUNOP_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_LOCAL_SIMBEP
-- Generated 9-mar-2004 19:11:35 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_local_simbep
    (loc_cod_pk                     NUMBER(6) NOT NULL,
    end_cod_pk                     NUMBER(6) NOT NULL,
    loc_sala                       VARCHAR2(10),
    loc_and                        VARCHAR2(10),
    loc_pred                       VARCHAR2(20))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_LOCAL_SIMBEP

ALTER TABLE ifrdba2.tab_local_simbep
ADD CONSTRAINT pk_local_simbep PRIMARY KEY (loc_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_LOCAL_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_LOG_SIMBEP
-- Generated 9-mar-2004 19:11:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_log_simbep
    (log_cod_pk                     NUMBER(10) NOT NULL,
    log_dthr                       DATE NOT NULL,
    log_tipo                       VARCHAR2(2) NOT NULL,
    log_codeqp                     VARCHAR2(20),
    log_area                       NUMBER(6),
    log_oper_cracha                VARCHAR2(20),
    log_eve_coletor                VARCHAR2(1),
    log_cracha_porteiro            VARCHAR2(20),
    log_resp_dest                  VARCHAR2(20),
    log_resp_senha                 VARCHAR2(10),
    log_sentido                    VARCHAR2(1),
    log_resp_msg                   VARCHAR2(2000))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TAB_LOG_SIMBEP

CREATE INDEX ifrdba2.ix_log_eqp01 ON ifrdba2.tab_log_simbep
  (
    log_codeqp                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TAB_LOG_SIMBEP

ALTER TABLE ifrdba2.tab_log_simbep
ADD CONSTRAINT pk_log_simbep PRIMARY KEY (log_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_LOG_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_MOVIM_SIMBEP
-- Generated 9-mar-2004 19:11:43 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_movim_simbep
    (mov_cod_pk                     NUMBER(6) NOT NULL,
    mov_status                     NUMBER(1) NOT NULL,
    mov_tipomov                    NUMBER(3) NOT NULL,
    mov_dthrregis                  DATE NOT NULL,
    mov_origdetint                 VARCHAR2(20),
    mov_origareaint                NUMBER(6),
    mov_origrespon                 VARCHAR2(20),
    mov_origareaext                NUMBER(6),
    mov_origusu                    VARCHAR2(20),
    mov_destdetint                 VARCHAR2(20),
    mov_destrespon                 VARCHAR2(20),
    mov_destareaint                NUMBER(6),
    mov_destusu                    VARCHAR2(20),
    mov_destareaext                NUMBER(6),
    mov_tempexe                    NUMBER(8),
    mov_dthrinioper                DATE,
    mov_dthrinidevol               DATE,
    mov_ntb                        NUMBER(6),
    mov_cod_movgerador             NUMBER(6))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_MOVIM_SIMBEP

ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT pk_movim_simbep PRIMARY KEY (mov_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_MOVIM_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_OPERA_SIMBEP
-- Generated 9-mar-2004 19:11:48 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_opera_simbep
    (oper_cracha_pk                 VARCHAR2(20) NOT NULL,
    area_cod_pk                    NUMBER(6) NOT NULL,
    oper_tipo                      NUMBER(1) NOT NULL,
    oper_matr                      NUMBER(7) NOT NULL,
    func_cod                       NUMBER(2),
    oper_email                     VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TAB_OPERA_SIMBEP

CREATE UNIQUE INDEX ifrdba2.ix_opera_matr01 ON ifrdba2.tab_opera_simbep
  (
    oper_matr                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TAB_OPERA_SIMBEP

ALTER TABLE ifrdba2.tab_opera_simbep
ADD CONSTRAINT pk_opera_simbep PRIMARY KEY (oper_cracha_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_OPERA_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_PALM_SIMBEP
-- Generated 9-mar-2004 19:11:53 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_palm_simbep
    (palm_serie_pk                  VARCHAR2(30) NOT NULL,
    palm_desc                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_PALM_SIMBEP

ALTER TABLE ifrdba2.tab_palm_simbep
ADD CONSTRAINT pk_palm_simbep PRIMARY KEY (palm_serie_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_PALM_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_RECEX_SIMBEP
-- Generated 9-mar-2004 19:11:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_recex_simbep
    (ext_cracha                     VARCHAR2(20) NOT NULL,
    ext_matr                       NUMBER(7) NOT NULL,
    sta_cod_pk                     NUMBER(1) NOT NULL,
    ext_est                        VARCHAR2(2) NOT NULL,
    ext_cid                        VARCHAR2(30) NOT NULL,
    ext_cep                        VARCHAR2(9) NOT NULL,
    ext_rg                         VARCHAR2(20) NOT NULL,
    ext_end                        VARCHAR2(50) NOT NULL,
    ext_nom                        VARCHAR2(50) NOT NULL,
    ext_tel                        VARCHAR2(20),
    ext_email                      VARCHAR2(50))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_RECEX_SIMBEP

ALTER TABLE ifrdba2.tab_recex_simbep
ADD CONSTRAINT pk_recex_simbep PRIMARY KEY (ext_cracha)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TAB_RECEX_SIMBEP

CREATE TRIGGER ifrdba2.tr01_tab_recex_simbep
BEFORE  DELETE 
ON ifrdba2.tab_recex_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  INSERT
  INTO HST_RECEX_SIMBEP
    (HEXT_CRACHA		,
     HEXT_MATR		,
     HEXT_EST		,
     HEXT_CID		,
     HEXT_CEP		,
     HEXT_RG		,
     HEXT_END		,
     HEXT_NOM	  	,
     HEXT_TEL		,
     HEXT_EMAIL         ,
     HEXT_DTEXCL
    )
  VALUES
    (
     :OLD.EXT_CRACHA	,
     :OLD.EXT_MATR	,
     :OLD.EXT_EST		,
     :OLD.EXT_CID		,
     :OLD.EXT_CEP		,
     :OLD.EXT_RG		,
     :OLD.EXT_END		,
     :OLD.EXT_NOM		,
     :OLD.EXT_TEL		,
     :OLD.EXT_EMAIL	,
     SYSDATE
     );
END TR01_TAB_RECEX_SIMBEP;
/
CREATE TRIGGER ifrdba2.tr02_tab_recex_simbep
AFTER INSERT 
ON ifrdba2.tab_recex_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    VALOR NUMBER(7);
BEGIN
  SELECT COUNT(*) INTO VALOR FROM HST_RECEX_SIMBEP
      WHERE UPPER(HEXT_CRACHA) = UPPER(:NEW.EXT_CRACHA);

  IF VALOR <> 0 THEN
     DELETE HST_RECEX_SIMBEP
        WHERE UPPER(HEXT_CRACHA) = UPPER(:NEW.EXT_CRACHA);
  END IF;
END TR02_TAB_RECEX_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.TAB_RECEX_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_STFUN_SIMBEP
-- Generated 9-mar-2004 19:12:02 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_stfun_simbep
    (sta_cod_pk                     NUMBER(1) NOT NULL,
    sta_dsc                        VARCHAR2(15) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_STFUN_SIMBEP

ALTER TABLE ifrdba2.tab_stfun_simbep
ADD CONSTRAINT pk_stfun_simbep PRIMARY KEY (sta_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_STFUN_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_TPEVE_SIMBEP
-- Generated 9-mar-2004 19:12:05 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_tpeve_simbep
    (tpeve_cod_pk                   NUMBER(2) NOT NULL,
    tpeve_dsc                      VARCHAR2(100) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_TPEVE_SIMBEP

ALTER TABLE ifrdba2.tab_tpeve_simbep
ADD CONSTRAINT pk_tpeve_simbep PRIMARY KEY (tpeve_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_TPEVE_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_TPMOV_SIMBEP
-- Generated 9-mar-2004 19:12:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_tpmov_simbep
    (tpmov_cod_pk                   NUMBER(3) NOT NULL,
    tpmov_desc                     VARCHAR2(200) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_TPMOV_SIMBEP

ALTER TABLE ifrdba2.tab_tpmov_simbep
ADD CONSTRAINT pk_tpmov_simbep PRIMARY KEY (tpmov_cod_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAB_TPMOV_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TAB_VISIT_SIMBEP
-- Generated 9-mar-2004 19:12:12 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tab_visit_simbep
    (visi_cracha_pk                 VARCHAR2(20) NOT NULL,
    visi_dthrentra                 DATE NOT NULL,
    visi_forn                      NUMBER(6),
    visi_rg                        VARCHAR2(15),
    visi_cpf                       VARCHAR2(15),
    visi_doc                       VARCHAR2(30),
    visi_cod                       NUMBER(7) NOT NULL,
    visi_nome                      VARCHAR2(50) NOT NULL,
    visi_usu                       VARCHAR2(50) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAB_VISIT_SIMBEP

ALTER TABLE ifrdba2.tab_visit_simbep
ADD CONSTRAINT pk_visit_simbep PRIMARY KEY (visi_cracha_pk)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TAB_VISIT_SIMBEP

CREATE TRIGGER ifrdba2.tr01_tab_visit_simbep
BEFORE  DELETE 
ON ifrdba2.tab_visit_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  INSERT
  INTO HST_VISIT_SIMBEP
      (HVIS_CRACHA_PK  ,
       HVIS_SEQ_PK     ,
       HVIS_DTHRENTRA  ,
       HVIS_DTHRSAIDA  ,
	 HVIS_FORN	     ,
       HVIS_RG         ,
       HVIS_CPF        ,
       HVIS_DOC        ,
	 HVIS_COD        ,
       HVIS_NOME       ,
       HVIS_USU        )
    VALUES
      (:OLD.VISI_CRACHA_PK,
       HVIS_SEQ_SIMBEP.NEXTVAL ,
       :OLD.VISI_DTHRENTRA     ,
       SYSDATE                 ,
       :OLD.VISI_FORN          ,
       :OLD.VISI_RG            ,
       :OLD.VISI_CPF           ,
       :OLD.VISI_DOC           ,
       :OLD.VISI_COD           ,
       :OLD.VISI_NOME          ,
       :OLD.VISI_USU           );
END TR01_TAB_VISIT_SIMBEP;
/
CREATE TRIGGER ifrdba2.tr02_tab_visit_simbep
AFTER INSERT 
ON ifrdba2.tab_visit_simbep
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    VALOR NUMBER(7);
BEGIN
  SELECT COUNT(*) INTO VALOR FROM HST_VISIT_SIMBEP
      WHERE HVIS_CRACHA_PK = :NEW.VISI_CRACHA_PK;
  IF VALOR <> 0 THEN
     DELETE HST_VISIT_SIMBEP
      WHERE HVIS_CRACHA_PK = :NEW.VISI_CRACHA_PK;
  END IF;
END TR02_TAB_VISIT_SIMBEP;
/

-- End of DDL Script for Table IFRDBA2.TAB_VISIT_SIMBEP

-- Start of DDL Script for Table IFRDBA2.TARIFA_BANCARIA
-- Generated 9-mar-2004 19:12:18 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tarifa_bancaria
    (cd_tarifa_bancaria             NUMBER(3) NOT NULL,
    ds_tarifa_bancaria             VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TARIFA_BANCARIA

ALTER TABLE ifrdba2.tarifa_bancaria
ADD CONSTRAINT tab_pk PRIMARY KEY (cd_tarifa_bancaria)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TARIFA_BANCARIA

-- Start of DDL Script for Table IFRDBA2.TAXAS_RECEITA_DESPESA
-- Generated 9-mar-2004 19:12:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.taxas_receita_despesa
    (nr_ano                         NUMBER(4) NOT NULL,
    mm_taxa                        NUMBER(2) NOT NULL,
    tarifaria_vl                   NUMBER(4,2) NOT NULL,
    comercial_vl                   NUMBER(4,2) NOT NULL,
    ataero_vl                      NUMBER(4,2) NOT NULL,
    receita_ataero_vl              NUMBER(4,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TAXAS_RECEITA_DESPESA

ALTER TABLE ifrdba2.taxas_receita_despesa
ADD CONSTRAINT trd_pk PRIMARY KEY (nr_ano, mm_taxa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TAXAS_RECEITA_DESPESA

-- Start of DDL Script for Table IFRDBA2.TELEF_UNIDADE_ORGANIZACIONAL
-- Generated 9-mar-2004 19:12:24 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.telef_unidade_organizacional
    (cod_unidade_organizacional     NUMBER(9) NOT NULL,
    num_telefone                   VARCHAR2(12) NOT NULL,
    ind_telefone_fax               VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TELEF_UNIDADE_ORGANIZACIONAL

ALTER TABLE ifrdba2.telef_unidade_organizacional
ADD CONSTRAINT tel_unid_organiz_ck CHECK (ind_telefone_fax in ('T','F'))
/
ALTER TABLE ifrdba2.telef_unidade_organizacional
ADD CONSTRAINT tel_unid_organiz_pk PRIMARY KEY (cod_unidade_organizacional, 
  num_telefone)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TELEF_UNIDADE_ORGANIZACIONAL

-- Start of DDL Script for Table IFRDBA2.TEMP_OLMAR
-- Generated 9-mar-2004 19:12:28 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.temp_olmar
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    ig_ci_cd_classe                VARCHAR2(4) NOT NULL,
    ig_cd_item                     VARCHAR2(7) NOT NULL,
    dt_valor_previsto              DATE,
    in_origem                      NUMBER(1),
    qt_vida_util_dias              NUMBER(4),
    vl_previsto                    NUMBER(17,5),
    abc_cd_classificacao           VARCHAR2(6),
    in_custo_atualizado            NUMBER(1),
    cd_estocavel                   NUMBER(1),
    cd_ressuprimento               NUMBER(1),
    cd_orcamentario                VARCHAR2(30),
    qt_tle                         NUMBER(5),
    in_critico_iso                 NUMBER(1),
    ds_usuario                     VARCHAR2(50),
    qr_estoque_iso                 NUMBER(12,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TEMP_OLMAR

-- Start of DDL Script for Table IFRDBA2.TEMP_VERSAO_SIMULACAO_PROP_ORC
-- Generated 9-mar-2004 19:12:30 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.temp_versao_simulacao_prop_orc
    (cd_nivel_versao                VARCHAR2(2),
    cd_versao                      VARCHAR2(2),
    nr_ano                         NUMBER(4),
    cd_dependencia                 NUMBER(4),
    id_impressao                   NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TEMP_VERSAO_SIMULACAO_PROP_ORC

-- Start of DDL Script for Table IFRDBA2.TEXTO_PADRAO
-- Generated 9-mar-2004 19:12:31 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.texto_padrao
    (cd_padrao                      VARCHAR2(10) NOT NULL,
    mdl_cd_modalidade              NUMBER(2) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    ds_identif_texto               VARCHAR2(100) NOT NULL,
    no_arquivo_padrao              VARCHAR2(16) NOT NULL,
    tp_texto                       NUMBER(1) NOT NULL,
    in_inativo                     NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TEXTO_PADRAO

CREATE INDEX ifrdba2.tp_dep_fk_i ON ifrdba2.texto_padrao
  (
    dep_cd_dependencia              ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.tp_mdl_fk_i ON ifrdba2.texto_padrao
  (
    mdl_cd_modalidade               ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TEXTO_PADRAO

ALTER TABLE ifrdba2.texto_padrao
ADD CONSTRAINT tp_pk PRIMARY KEY (cd_padrao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.TEXTO_PADRAO

COMMENT ON TABLE ifrdba2.texto_padrao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.TEXTO_PADRAO

-- Start of DDL Script for Table IFRDBA2.TIPO_AJUSTE_REGIME_CAIXA
-- Generated 9-mar-2004 19:12:40 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_ajuste_regime_caixa
    (cd_regime                      NUMBER(2) NOT NULL,
    ds_regime                      VARCHAR2(35) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_AJUSTE_REGIME_CAIXA

ALTER TABLE ifrdba2.tipo_ajuste_regime_caixa
ADD CONSTRAINT tar_pk PRIMARY KEY (cd_regime)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_AJUSTE_REGIME_CAIXA

-- Start of DDL Script for Table IFRDBA2.TIPO_BAIXA_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:12:44 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_baixa_bem_patrimonial
    (cd_tipo_baixa                  NUMBER(2) NOT NULL,
    no_tipo_baixa                  VARCHAR2(30) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_BAIXA_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.tipo_baixa_bem_patrimonial
ADD CONSTRAINT tbbp_fk PRIMARY KEY (cd_tipo_baixa)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_BAIXA_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.TIPO_CONTA_CORRENTE
-- Generated 9-mar-2004 19:12:47 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_conta_corrente
    (tp_conta_corrente              VARCHAR2(1) NOT NULL,
    ds_tipo_conta_corrente         VARCHAR2(30) NOT NULL,
    nr_opb                         NUMBER(7))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_CONTA_CORRENTE

ALTER TABLE ifrdba2.tipo_conta_corrente
ADD CONSTRAINT tcc_pk PRIMARY KEY (tp_conta_corrente)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_CONTA_CORRENTE

-- Start of DDL Script for Table IFRDBA2.TIPO_DEDUCAO_ACRESCIMO
-- Generated 9-mar-2004 19:12:49 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_deducao_acrescimo
    (cd_deducao_acrescimo           VARCHAR2(3) NOT NULL,
    ds_deducao_acrescimo           VARCHAR2(35) NOT NULL,
    st_deducao_acrescimo           VARCHAR2(1) NOT NULL,
    in_retorna_saldo               NUMBER(1),
    evc_nr_evento                  NUMBER(3) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_DEDUCAO_ACRESCIMO

ALTER TABLE ifrdba2.tipo_deducao_acrescimo
ADD CONSTRAINT tda_pk PRIMARY KEY (cd_deducao_acrescimo)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_DEDUCAO_ACRESCIMO

-- Start of DDL Script for Table IFRDBA2.TIPO_DESPESA_RECEITA
-- Generated 9-mar-2004 19:12:52 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_despesa_receita
    (cd_despesa_receita             VARCHAR2(5) NOT NULL,
    ds_despesa_receita             VARCHAR2(35) NOT NULL,
    ds_abreviacao                  VARCHAR2(10),
    tp_pagamento_recebimento       VARCHAR2(1),
    in_ent_sai                     VARCHAR2(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_DESPESA_RECEITA

ALTER TABLE ifrdba2.tipo_despesa_receita
ADD CONSTRAINT tdr_pk PRIMARY KEY (cd_despesa_receita)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_DESPESA_RECEITA

-- Start of DDL Script for Table IFRDBA2.TIPO_DOCUMENTO
-- Generated 9-mar-2004 19:12:56 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_documento
    (tp_documento                   NUMBER(2) NOT NULL,
    ds_documento                   VARCHAR2(35) NOT NULL,
    ds_abreviacao                  VARCHAR2(10),
    tp_pessoa                      NUMBER(1))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_DOCUMENTO

ALTER TABLE ifrdba2.tipo_documento
ADD CONSTRAINT tdc_pk PRIMARY KEY (tp_documento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.tipo_documento
ADD CONSTRAINT tdc_tp_pessoa_ck CHECK (                                       TP_PESSOA IN (1,2,3)       )
/

-- End of DDL Script for Table IFRDBA2.TIPO_DOCUMENTO

-- Start of DDL Script for Table IFRDBA2.TIPO_DOCUMENTO_LICITACAO
-- Generated 9-mar-2004 19:13:00 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_documento_licitacao
    (dep_cd_dependencia             NUMBER(4) NOT NULL,
    cd_documento                   NUMBER(3) NOT NULL,
    ds_identif_documento           VARCHAR2(100) NOT NULL,
    no_arquivo_doc_padrao          VARCHAR2(16) NOT NULL,
    in_inativo                     NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_DOCUMENTO_LICITACAO

ALTER TABLE ifrdba2.tipo_documento_licitacao
ADD CONSTRAINT tdl_pk PRIMARY KEY (dep_cd_dependencia, cd_documento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.TIPO_DOCUMENTO_LICITACAO

COMMENT ON TABLE ifrdba2.tipo_documento_licitacao IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.TIPO_DOCUMENTO_LICITACAO

-- Start of DDL Script for Table IFRDBA2.TIPO_EVENTO
-- Generated 9-mar-2004 19:13:03 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_evento
    (tp_evento                      NUMBER(2) NOT NULL,
    ds_evento                      VARCHAR2(40) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_EVENTO

ALTER TABLE ifrdba2.tipo_evento
ADD CONSTRAINT tev_pk PRIMARY KEY (tp_evento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_EVENTO

-- Start of DDL Script for Table IFRDBA2.TIPO_GARANTIA
-- Generated 9-mar-2004 19:13:07 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_garantia
    (cd_tipo_garantia               VARCHAR2(3) NOT NULL,
    no_tipo_garantia               VARCHAR2(50) NOT NULL,
    nr_evento_recebimento          NUMBER(5) NOT NULL,
    nr_evento_devolucao            NUMBER(5) NOT NULL,
    nr_evento_apropriacao          NUMBER(5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_GARANTIA

ALTER TABLE ifrdba2.tipo_garantia
ADD CONSTRAINT tga_pk PRIMARY KEY (cd_tipo_garantia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TIPO_GARANTIA

-- Start of DDL Script for Table IFRDBA2.TIPO_MATERIAL_DO_FORNECEDOR
-- Generated 9-mar-2004 19:13:11 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_material_do_fornecedor
    (tmf_cd_tipo_material_fornecime NUMBER(6) NOT NULL,
    for_nr_cgc_cpf                 VARCHAR2(14) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_MATERIAL_DO_FORNECEDOR

ALTER TABLE ifrdba2.tipo_material_do_fornecedor
ADD CONSTRAINT tmdf_pk PRIMARY KEY (tmf_cd_tipo_material_fornecime, 
  for_nr_cgc_cpf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.TIPO_MATERIAL_DO_FORNECEDOR

COMMENT ON TABLE ifrdba2.tipo_material_do_fornecedor IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.TIPO_MATERIAL_DO_FORNECEDOR

-- Start of DDL Script for Table IFRDBA2.TIPO_MATERIAL_FORNECIMENTO
-- Generated 9-mar-2004 19:13:15 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tipo_material_fornecimento
    (cd_tipo_material_fornecimento  NUMBER(6) NOT NULL,
    ds_tipo_material_fornecimento  VARCHAR2(80) NOT NULL,
    scf_cd_sicaf                   VARCHAR2(6) NOT NULL,
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TIPO_MATERIAL_FORNECIMENTO

ALTER TABLE ifrdba2.tipo_material_fornecimento
ADD CONSTRAINT tmf_pk PRIMARY KEY (cd_tipo_material_fornecimento)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.TIPO_MATERIAL_FORNECIMENTO

COMMENT ON TABLE ifrdba2.tipo_material_fornecimento IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.TIPO_MATERIAL_FORNECIMENTO

-- Start of DDL Script for Table IFRDBA2.TMP1_DETALHEDEPRECREMUN
-- Generated 9-mar-2004 19:13:20 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.tmp1_detalhedeprecremun
    (cp1_dep_cd_dependencia         NUMBER(4) NOT NULL,
    cp1_cp_nr_conta                NUMBER(5) NOT NULL,
    cd_centro_custo                NUMBER(5) NOT NULL,
    ma_situacao                    NUMBER(6) NOT NULL,
    in_uniao                       NUMBER(1) NOT NULL,
    vl_adi_dp_mo                   NUMBER(17,2),
    vl_adi_dp_mr                   NUMBER(17,4),
    vl_remun_mo                    NUMBER(17,2),
    vl_remun_mr                    NUMBER(17,2),
    vl_cm_dp_mo                    NUMBER(17,2))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TMP1_DETALHEDEPRECREMUN

-- Start of DDL Script for Table IFRDBA2.TOTAIS_CONTA_IMPRESSAO
-- Generated 9-mar-2004 19:13:21 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.totais_conta_impressao
    (cd_conta_tot                   NUMBER(4),
    cd_conta_ref                   NUMBER(4),
    in_sinal                       NUMBER(1),
    vl_fator                       NUMBER(7,5))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.TOTAIS_CONTA_IMPRESSAO

-- Start of DDL Script for Table IFRDBA2.TRANSFER_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:13:22 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.transfer_bem_patrimonial
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    dt_saida                       DATE NOT NULL,
    tp_transferencia               CHAR(1) NOT NULL,
    dt_entrada                     DATE,
    nr_doc_transferencia           VARCHAR2(8),
    cd_dep_origem                  NUMBER(4),
    cd_dep_destino                 NUMBER(4),
    id_area_origem                 NUMBER(7),
    id_area_destino                NUMBER(7),
    nr_matric_detentor_origem      NUMBER(7),
    nr_matric_detentor_destino     NUMBER(7),
    nr_conta_origem                NUMBER(5),
    nr_conta_destino               NUMBER(5),
    no_usuario_origem              VARCHAR2(30),
    no_usuario_destino             VARCHAR2(30),
    in_cancelamento                NUMBER(1),
    ds_motivo_cancelamento         VARCHAR2(100),
    in_efetivacao                  NUMBER(1) NOT NULL,
    cd_grupo_origem                NUMBER(4),
    cd_grupo_destino               NUMBER(4),
    cd_centro_negocio_origem       NUMBER(4),
    cd_centro_negocio_destino      NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.TRANSFER_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.transfer_bem_patrimonial
ADD CONSTRAINT tbp_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, dt_saida, 
  tp_transferencia)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.TRANSFER_BEM_PATRIMONIAL

CREATE TRIGGER ifrdba2.trg_tbp01
BEFORE INSERT 
ON ifrdba2.transfer_bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN (NEW.CD_CENTRO_NEGOCIO_ORIGEM IS NULL OR NEW.CD_CENTRO_NEGOCIO_DESTINO IS NULL)
Declare
   Cursor Recupera_CN (P_Cd_Dep in number) is
      Select DEP_CD_DEPENDENCIA
      From DEPENDENCIA
      Where CD_DEPENDENCIA = P_Cd_Dep;
Begin
   Open  Recupera_CN(:NEW.CD_DEP_ORIGEM);
   Fetch Recupera_CN into :NEW.CD_CENTRO_NEGOCIO_ORIGEM;
   Close Recupera_CN;
   Open  Recupera_CN(:NEW.CD_DEP_DESTINO);
   Fetch Recupera_CN into :NEW.CD_CENTRO_NEGOCIO_DESTINO;
   Close Recupera_CN;
End;
/

-- End of DDL Script for Table IFRDBA2.TRANSFER_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.TRANSFERENCIA_ITENS
-- Generated 9-mar-2004 19:13:27 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.transferencia_itens
    (dep_cd_dependencia_orig        NUMBER(4) NOT NULL,
    aa_solicitacao                 NUMBER(4) NOT NULL,
    nr_solicitacao                 NUMBER(6) NOT NULL,
    dt_solicitacao                 DATE NOT NULL,
    in_transferencia               NUMBER(1) NOT NULL,
    dep_cd_dependencia_dest        NUMBER(4) NOT NULL,
    cd_centro_custo                NUMBER(5),
    ds_usuario                     VARCHAR2(50),
    cd_aplicacao                   VARCHAR2(3))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.TRANSFERENCIA_ITENS

CREATE INDEX ifrdba2.ti_dep_d_fk_i ON ifrdba2.transferencia_itens
  (
    dep_cd_dependencia_dest         ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.ti_dep_o_fk_i ON ifrdba2.transferencia_itens
  (
    dep_cd_dependencia_orig         ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.TRANSFERENCIA_ITENS

ALTER TABLE ifrdba2.transferencia_itens
ADD CONSTRAINT ti_pk PRIMARY KEY (dep_cd_dependencia_orig, aa_solicitacao, 
  nr_solicitacao)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.TRANSFERENCIA_ITENS

COMMENT ON TABLE ifrdba2.transferencia_itens IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.TRANSFERENCIA_ITENS

-- Start of DDL Script for Table IFRDBA2.UNIDADE_ITEM
-- Generated 9-mar-2004 19:13:34 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.unidade_item
    (cd_unidade                     VARCHAR2(4) NOT NULL,
    ds_unidade                     VARCHAR2(120))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.UNIDADE_ITEM

ALTER TABLE ifrdba2.unidade_item
ADD CONSTRAINT ui_pk PRIMARY KEY (cd_unidade)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.UNIDADE_ITEM

COMMENT ON TABLE ifrdba2.unidade_item IS '- Retrofitted'
/

-- End of DDL Script for Table IFRDBA2.UNIDADE_ITEM

-- Start of DDL Script for Table IFRDBA2.UNIDADES_FEDERACAO
-- Generated 9-mar-2004 19:13:39 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.unidades_federacao
    (ufe_sigla                      VARCHAR2(2) NOT NULL,
    ufe_descricao                  VARCHAR2(50) NOT NULL,
    ufe_codigo                     NUMBER(2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.UNIDADES_FEDERACAO

CREATE UNIQUE INDEX ifrdba2.ufe_codigo_uk ON ifrdba2.unidades_federacao
  (
    ufe_codigo                      ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.UNIDADES_FEDERACAO

ALTER TABLE ifrdba2.unidades_federacao
ADD CONSTRAINT ufe_pk PRIMARY KEY (ufe_sigla)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/
ALTER TABLE ifrdba2.unidades_federacao
ADD CONSTRAINT ufe_uk UNIQUE (ufe_descricao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.UNIDADES_FEDERACAO

-- Start of DDL Script for Table IFRDBA2.UNIDADES_ORGANIZACIONAIS
-- Generated 9-mar-2004 19:13:45 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.unidades_organizacionais
    (uor_codigo                     NUMBER(9) NOT NULL,
    uor_nome                       VARCHAR2(100),
    uor_sigla                      VARCHAR2(10),
    uor_codigo_lotacao_anterior    NUMBER(9),
    uor_dep_codigo                 NUMBER(4),
    uor_uor_codigo                 NUMBER(9),
    uor_sequencia_estrutura        VARCHAR2(10),
    uor_data_criacao               DATE,
    uor_ds_documento_criacao       VARCHAR2(50),
    uor_data_extincao              DATE,
    uor_ds_documento_extincao      VARCHAR2(50),
    uor_dep_codigo_vincula_pgto    NUMBER(4),
    uor_nome_abreviado             VARCHAR2(60),
    uor_tipo_unidad_org            NUMBER(2),
    uor_dep_adm_material           NUMBER(4),
    uor_endereco_logradouro        VARCHAR2(50),
    uor_endereco_bairro            VARCHAR2(30),
    uor_endereco_municipio         VARCHAR2(50),
    uor_ufe_sigla                  VARCHAR2(2),
    uor_cep                        VARCHAR2(8),
    uor_numero_fax                 VARCHAR2(8))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Indexes for IFRDBA2.UNIDADES_ORGANIZACIONAIS

CREATE INDEX ifrdba2.uor_dep_fk_i ON ifrdba2.unidades_organizacionais
  (
    uor_dep_codigo                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.uor_dep_vincula_pgto_fk_i ON ifrdba2.unidades_organizacionais
  (
    uor_dep_codigo_vincula_pgto     ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/
CREATE INDEX ifrdba2.uor_uor_fk_i ON ifrdba2.unidades_organizacionais
  (
    uor_uor_codigo                  ASC
  )
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/


-- Constraints for IFRDBA2.UNIDADES_ORGANIZACIONAIS

ALTER TABLE ifrdba2.unidades_organizacionais
ADD CONSTRAINT uor_pk PRIMARY KEY (uor_codigo)
USING INDEX
  PCTFREE     50
  INITRANS    2
  MAXTRANS    255
/

-- Comments for IFRDBA2.UNIDADES_ORGANIZACIONAIS

COMMENT ON TABLE ifrdba2.unidades_organizacionais IS 'Unidades Administrativas'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_cep IS 'NÚMERO DO CÓDIGO DE ENDEREÇAMENTO POSTAL (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_codigo IS 'CÓDIGO IDENTIFICADOR DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_codigo_lotacao_anterior IS 'CODIGO IDENTIFICADOR DA LOTAÇÃO (UNIDADE ORGANIZACIONAL) ANTERIOR'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_data_criacao IS 'DATA DE CRIAÇÃO DA LOTAÇÃO( UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_data_extincao IS 'DATA DE EXTINÇÃO DA UNIDADE ORGANIZACIONAL'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_dep_adm_material IS 'DEPENDÊNCIA ADMINISTRADORA DE MATERIAL DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_dep_codigo IS 'IDENTIFICADOR DA DEPENDÊNCIA SEGUNDO A ESTRUTURA ORGANIZACIONAL DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_dep_codigo_vincula_pgto IS 'IDENTIFICADOR DA DEPENDÊNCIA SEGUNDO A ESTRUTURA ORGANIZACIONAL DA LOTAÇÃO (UNIDADE ORGANIZACIONAL) VINCULADA AO PAGAMENTO'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_ds_documento_criacao IS 'DESCRIÇÃO DO DOCUMENTO DE CRIAÇÃO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_ds_documento_extincao IS 'DESCRIÇÃO DO DOCUMENTO DE EXTINÇÃO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_endereco_bairro IS 'DESCRIÇÃO DO ENDEREÇO DO BAIRRO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_endereco_logradouro IS 'DESCRIÇÃO DO ENDEREÇO DO LOGRADOURO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_endereco_municipio IS 'DESCRIÇÃO DO ENDEREÇO DO MUNICIPIO DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_nome IS 'NOME DA LOTAÇÃO ( UNIDADE ORGANIZACIONAL) COMPLETO'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_nome_abreviado IS 'NOME DA LOTAÇÃO (UNIDADE ORGANIZACIONAL) ABREVIADO'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_numero_fax IS 'NUMERO DO FAX DO UOR.'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_sequencia_estrutura IS 'IDENTIFICADOR DO SEQUENCIAL DA ESTRUTURA DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_sigla IS 'SIGLA DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_tipo_unidad_org IS 'TIPO DA UNIDADE ORGANIZACIONAL'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_ufe_sigla IS 'DESCRIÇÃO DA SIGLA DA UNIDADE FEDERATIVA DA LOTAÇÃO (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN ifrdba2.unidades_organizacionais.uor_uor_codigo IS 'SUBORDINAÇÃO IMEDIATA (AUTO RELACIONAMENTO)'
/

-- End of DDL Script for Table IFRDBA2.UNIDADES_ORGANIZACIONAIS

-- Start of DDL Script for Table IFRDBA2.USUARIO_TESOURARIA
-- Generated 9-mar-2004 19:13:55 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.usuario_tesouraria
    (nr_cgc_cpf                     VARCHAR2(14) NOT NULL,
    no_usuario                     VARCHAR2(50) NOT NULL,
    ds_endereco                    VARCHAR2(50),
    ds_cidade                      VARCHAR2(30),
    sg_uf                          VARCHAR2(2),
    nr_ddd                         VARCHAR2(4),
    nr_cep                         NUMBER(8),
    nr_telefone                    VARCHAR2(10),
    nr_ramal                       VARCHAR2(4),
    dep_cd_dependencia             NUMBER(4) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.USUARIO_TESOURARIA

ALTER TABLE ifrdba2.usuario_tesouraria
ADD CONSTRAINT usu_pk PRIMARY KEY (dep_cd_dependencia, nr_cgc_cpf)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.USUARIO_TESOURARIA

-- Start of DDL Script for Table IFRDBA2.VALOR_CARAC_BEM_PATRIMONIAL
-- Generated 9-mar-2004 19:13:59 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.valor_carac_bem_patrimonial
    (bp_nr_bem                      NUMBER(7) NOT NULL,
    bp_in_uniao                    NUMBER(1) NOT NULL,
    cgp_gp_cd_grupo                NUMBER(4) NOT NULL,
    cgp_cp1_cd_caracteristica      NUMBER(4) NOT NULL,
    ds_valor_assumido              VARCHAR2(40),
    cd_centro_negocio              NUMBER(4),
    dep_cd_dependencia             NUMBER(4))
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.VALOR_CARAC_BEM_PATRIMONIAL

ALTER TABLE ifrdba2.valor_carac_bem_patrimonial
ADD CONSTRAINT vcebp_pk PRIMARY KEY (bp_nr_bem, bp_in_uniao, cgp_gp_cd_grupo, 
  cgp_cp1_cd_caracteristica)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- Triggers for IFRDBA2.VALOR_CARAC_BEM_PATRIMONIAL

CREATE TRIGGER ifrdba2.trg_vcbp01
BEFORE INSERT 
ON ifrdba2.valor_carac_bem_patrimonial
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
CURSOR pega_bem(NrBem IN NUMBER, InUniao IN NUMBER)
   IS
   -- pega o codigo da dependencia que esta manipulando o
   -- bem patrimonial
   SELECT bp.aat_dep_cd_dependencia
   FROM bem_patrimonial bp
WHERE
   bp.nr_bem = NrBem
   AND bp.in_uniao = InUniao;
CURSOR pega_dep(CdDependencia IN NUMBER)
   IS
   -- obtem o codigo da dependencia a qual esta dependencia
   -- esta subordinada
   SELECT dp.dep_dep_codigo
   FROM dependencias dp
WHERE
   dp.dep_codigo = CdDependencia;
WkCdDep NUMBER;
WkCdCdDep NUMBER;
BEGIN
   OPEN pega_bem(:new.bp_nr_bem, :new.bp_in_uniao);
   FETCH pega_bem INTO WkCdDep;
   -- Obs. via foreign key entre valor_carac_bem_patrimonial e
   -- bem patrimonial, é garantido que haverá um valor para
   -- o bem patrimonial, portanto, não é necessário a validação
   CLOSE pega_bem;
   OPEN pega_dep(WkCdDep);
   FETCH pega_dep INTO WkCdCdDep;
   -- Obs. via foreign key entre bem_patrimonial e
   -- dependencias, é garantido que haverá um valor para
   -- a dependencia, portanto não é necessário a validação
   CLOSE pega_dep;
   :new.cd_centro_negocio := WkCdCdDep;
   :new.dep_cd_dependencia := WkCdDep;
END;
/

-- End of DDL Script for Table IFRDBA2.VALOR_CARAC_BEM_PATRIMONIAL

-- Start of DDL Script for Table IFRDBA2.VALOR_TARIFA_BANCO
-- Generated 9-mar-2004 19:14:04 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.valor_tarifa_banco
    (ban_cd_banco                   VARCHAR2(3) NOT NULL,
    tab_cd_tarifa_bancaria         NUMBER(3) NOT NULL,
    vl_tarifa                      NUMBER(14,2) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.VALOR_TARIFA_BANCO

ALTER TABLE ifrdba2.valor_tarifa_banco
ADD CONSTRAINT vtb_pk PRIMARY KEY (ban_cd_banco, tab_cd_tarifa_bancaria)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.VALOR_TARIFA_BANCO

-- Start of DDL Script for Table IFRDBA2.VERSAO_SIMULACAO_PROPOSTA_ORC
-- Generated 9-mar-2004 19:14:08 from IFRDBA2@BDSEDE4

CREATE TABLE ifrdba2.versao_simulacao_proposta_orc
    (cd_nivel_versao                VARCHAR2(2) NOT NULL,
    cd_versao                      VARCHAR2(2) NOT NULL,
    nr_ano                         NUMBER(4) NOT NULL,
    in_escolhida                   NUMBER(1),
    ds_versao                      VARCHAR2(35) NOT NULL,
    vsp_cd_nivel_versao            VARCHAR2(2),
    vsp_cd_versao                  VARCHAR2(2),
    vsp_nr_ano                     NUMBER(4),
    tp_moeda                       NUMBER(2),
    dep_cd_dependencia             NUMBER(4) NOT NULL,
    vsp_dep_cd_dependencia         NUMBER(4),
    in_liberada                    NUMBER(1) NOT NULL)
  PCTFREE     10
  PCTUSED     40
  INITRANS    1
  MAXTRANS    255
/

-- Constraints for IFRDBA2.VERSAO_SIMULACAO_PROPOSTA_ORC

ALTER TABLE ifrdba2.versao_simulacao_proposta_orc
ADD CONSTRAINT vsp_ck_1 CHECK (in_liberada in (0,1))
/
ALTER TABLE ifrdba2.versao_simulacao_proposta_orc
ADD CONSTRAINT vsp_pk PRIMARY KEY (nr_ano, dep_cd_dependencia, cd_nivel_versao, 
  cd_versao)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

-- End of DDL Script for Table IFRDBA2.VERSAO_SIMULACAO_PROPOSTA_ORC

-- Foreign Key
ALTER TABLE ifrdba2.acesso_spsc
ADD CONSTRAINT ac_cc2_fk FOREIGN KEY (cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.acesso_spsc
ADD CONSTRAINT as_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.acesso_spsc
ADD CONSTRAINT as_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.acomp_situacao_bem_patrim
ADD CONSTRAINT asbp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
ALTER TABLE ifrdba2.acomp_situacao_bem_patrim
ADD CONSTRAINT asbp_sbp_ant_fk FOREIGN KEY (sbp_cd_situacao_anterior)
REFERENCES IFRDBA2.situacao_bem_patrimonial (cd_situacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.acomp_situacao_bem_patrim
ADD CONSTRAINT asbp_sbp_atu_fk FOREIGN KEY (sbp_cd_situacao_atual)
REFERENCES IFRDBA2.situacao_bem_patrimonial (cd_situacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.agenciainf
ADD CONSTRAINT agb_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.agenciainf
ADD CONSTRAINT agb_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.agenciainf
ADD CONSTRAINT agb_mun_fk FOREIGN KEY (cod_municipio, sg_uf)
REFERENCES IFRDBA2.municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.agrupamento_contabil
ADD CONSTRAINT ac_ac_pk FOREIGN KEY (cod_agrup_relac)
REFERENCES IFRDBA2.agrupamento_contabil (cod_agrupamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.agrupamento_receita
ADD CONSTRAINT fk_agr_r_2_agr_r FOREIGN KEY (cod_agrup_relac)
REFERENCES IFRDBA2.agrupamento_receita (cod_agrupamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.ajuste_item_compromisso_orc
ADD CONSTRAINT aico_ico FOREIGN KEY (nr_ano_compromisso, 
  dep_cd_dependencia_compr, cc2_cd_centro_custo, nr_compromisso, nr_seq_comp)
REFERENCES IFRDBA2.item_compromisso_orcamentario (nr_ano_compromisso,dep_cd_dependencia_compr,cc2_cd_centro_custo,nr_compromisso,nr_seq_comp) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.almoxarifados
ADD CONSTRAINT alm_alm1_fk FOREIGN KEY (dep_vinculacao)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.almoxarifados
ADD CONSTRAINT alm_alm2_fk FOREIGN KEY (dep_material_adm)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.almoxarifados
ADD CONSTRAINT alm_alm3_fk FOREIGN KEY (dep_material_tecnico)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.almoxarifados
ADD CONSTRAINT alm_alm4_fk FOREIGN KEY (dep_compra)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aplicacao
ADD CONSTRAINT apl_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.aplicacao
ADD CONSTRAINT apl_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.area_limite_modalidade
ADD CONSTRAINT arlm_ar2_fk FOREIGN KEY (ar2_cd_area)
REFERENCES IFRDBA2.area (cd_area) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.area_limite_modalidade
ADD CONSTRAINT arlm_mdl_fk FOREIGN KEY (mdl_cd_modalidade)
REFERENCES IFRDBA2.modalidade_licitacao (cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tph_fk FOREIGN KEY (tp_cd_padrao_hab)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tpjh_fk FOREIGN KEY (tp_cd_padrao_jul_hab)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tpjp_fk FOREIGN KEY (tp_cd_padrao_jul_pro)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tppa_fk FOREIGN KEY (tp_cd_padrao_par_tecn)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tppr_fk FOREIGN KEY (tp_cd_padrao_pro_tecn)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ata_licitacao
ADD CONSTRAINT al_tpp_fk FOREIGN KEY (tp_cd_padrao_pro)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.ato_administrativo
ADD CONSTRAINT aa_cl_fk FOREIGN KEY (cl_pl_aa_processo, cl_pl_sq_processo, 
  cl_pl_dep_cd_dependencia, cl_pl_mdl_cd_modalidade, cl_tp_comissao)
REFERENCES IFRDBA2.comissao_licitacao (pl_aa_processo,pl_sq_processo,pl_dep_cd_dependencia_detent,pl_mdl_cd_modalidade,tp_comissao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ato_administrativo
ADD CONSTRAINT aa_cpl_fk FOREIGN KEY (cpl_dep_cd_dependencia, cpl_sq_comissao)
REFERENCES IFRDBA2.comissao_permanente_licitacao (dep_cd_dependencia,sq_comissao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ato_administrativo
ADD CONSTRAINT aa_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_acao_simbep
ADD CONSTRAINT fk01_acao FOREIGN KEY (tpeve_cod_pk)
REFERENCES IFRDBA2.tab_tpeve_simbep (tpeve_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_coenv_simbep
ADD CONSTRAINT fk01_comunenvia FOREIGN KEY (mov_cod_pk)
REFERENCES IFRDBA2.tab_movim_simbep (mov_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_comov_simbep
ADD CONSTRAINT fk01_comunicmov FOREIGN KEY (mov_cod_pk)
REFERENCES IFRDBA2.tab_movim_simbep (mov_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_eqmov_simbep
ADD CONSTRAINT fk01_equipamov FOREIGN KEY (mov_cod_pk)
REFERENCES IFRDBA2.tab_movim_simbep (mov_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_event_simbep
ADD CONSTRAINT fk01_eventomov FOREIGN KEY (mov_cod_pk)
REFERENCES IFRDBA2.tab_movim_simbep (mov_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.aux_event_simbep
ADD CONSTRAINT fk02_eventomov FOREIGN KEY (tpeve_cod_pk)
REFERENCES IFRDBA2.tab_tpeve_simbep (tpeve_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.aux_event_simbep
ADD CONSTRAINT fk03_eventomov FOREIGN KEY (eve_area)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_exmov_simbep
ADD CONSTRAINT fk01_executamov FOREIGN KEY (mov_cod_pk)
REFERENCES IFRDBA2.tab_movim_simbep (mov_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.aux_respd_simbep
ADD CONSTRAINT fk01_respdest FOREIGN KEY (mov_cod_pk, eve_seq_pk)
REFERENCES IFRDBA2.aux_event_simbep (mov_cod_pk,eve_seq_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.baixa_bem_patrimonial
ADD CONSTRAINT bdbp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
ALTER TABLE ifrdba2.baixa_bem_patrimonial
ADD CONSTRAINT bdbp_tbbp_fk FOREIGN KEY (tbbp_cd_tipo_baixa)
REFERENCES IFRDBA2.tipo_baixa_bem_patrimonial (cd_tipo_baixa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.balancete_mensal_almoxarifado
ADD CONSTRAINT bma_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.banco_forma_pagto
ADD CONSTRAINT bfp_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.banco_forma_pagto
ADD CONSTRAINT bfp_fpg_fk FOREIGN KEY (fpg_cd_forma_pgto)
REFERENCES IFRDBA2.forma_de_pagamento (cd_forma_pgto) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_aat_fk FOREIGN KEY (aat_dep_cd_dependencia, aat_id_area)
REFERENCES IFRDBA2.area_atendida (dep_cd_dependencia,id_area) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_cp1_fk FOREIGN KEY (cp1_cp_nr_conta, aat_dep_cd_dependencia)
REFERENCES IFRDBA2.conta_patrimonial_dependencia (cp_nr_conta,dep_cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_ec_fk FOREIGN KEY (ec_cd_estado)
REFERENCES IFRDBA2.estado_conservacao (cd_estado) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_fc_fk FOREIGN KEY (fc_cd_forma)
REFERENCES IFRDBA2.forma_aquisicao (cd_forma) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_gp_fk FOREIGN KEY (gp_cd_grupo)
REFERENCES IFRDBA2.grupo_patrimonial (cd_grupo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.bem_patrimonial
ADD CONSTRAINT bp_sbp_fk FOREIGN KEY (sbp_cd_situacao)
REFERENCES IFRDBA2.situacao_bem_patrimonial (cd_situacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.bem_patrimonial_temp
ADD CONSTRAINT bpt_bp_fk FOREIGN KEY (bpt_nr_bem, bpt_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial_temp (nr_bem,in_uniao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.carac_grupo_patrimonial
ADD CONSTRAINT cgp_cp1_fk FOREIGN KEY (cp1_cd_caracteristica)
REFERENCES IFRDBA2.caracteristica_patrimonial (cd_caracteristica) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.carac_grupo_patrimonial
ADD CONSTRAINT cgp_gp_fk FOREIGN KEY (gp_cd_grupo)
REFERENCES IFRDBA2.grupo_patrimonial (cd_grupo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.carac_mat_item_generico
ADD CONSTRAINT cmig_cma_fk FOREIGN KEY (cma_cd_caracteristica)
REFERENCES IFRDBA2.caracteristica_material (cd_caracteristica) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.carac_mat_item_generico
ADD CONSTRAINT cmig_ig_fk FOREIGN KEY (ig_dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.catalogo_financeiro
ADD CONSTRAINT cf_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.centro_custo_por_dep
ADD CONSTRAINT ccd_cc2_fk FOREIGN KEY (ccd_cct_codigo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.centro_custo_por_dep
ADD CONSTRAINT ccd_dep_fk FOREIGN KEY (ccd_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.centro_custo_uor
ADD CONSTRAINT ccu_uor_fk FOREIGN KEY (ccu_uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.classificacao_abc
ADD CONSTRAINT abc_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.classificacao_contabil_fin
ADD CONSTRAINT clc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.classificacao_contabil_fin
ADD CONSTRAINT clc_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.classificacao_contabil_fin
ADD CONSTRAINT clc_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.classificacao_contabil_fin
ADD CONSTRAINT clc_pag_fk FOREIGN KEY (pag_nr_lancamento)
REFERENCES IFRDBA2.pagamento (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.combinacao_evento
ADD CONSTRAINT ce1_evc_fk FOREIGN KEY (evc_nr_evento1)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.combinacao_evento
ADD CONSTRAINT ce2_evc_fk FOREIGN KEY (evc_nr_evento2)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.comissao_licitacao
ADD CONSTRAINT cl_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.comissao_permanente_licitacao
ADD CONSTRAINT cpl_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_dep_2_fk FOREIGN KEY (dep_cd_dependencia_efetuou)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario
ADD CONSTRAINT co_dep_fk FOREIGN KEY (dep_cd_dependencia_compr)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_ccu_pk FOREIGN KEY (cod_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_ctb_fk FOREIGN KEY (num_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_dep_fk FOREIGN KEY (cod_dependencia_compr)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.compromisso_orcamentario_temp
ADD CONSTRAINT cot_eft_pk FOREIGN KEY (cod_dependencia_efetuou)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_contabil
ADD CONSTRAINT cc1_or_fk FOREIGN KEY (or_cd_origem)
REFERENCES IFRDBA2.origem_recurso (cd_origem) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_contabil
ADD CONSTRAINT cc1_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_agb_fk FOREIGN KEY (ban_cd_banco, age_cd_agencia)
REFERENCES IFRDBA2.agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_dep_fk FOREIGN KEY (age_dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente
ADD CONSTRAINT cc_tcc_fk FOREIGN KEY (tcc_tp_conta_corrente)
REFERENCES IFRDBA2.tipo_conta_corrente (tp_conta_corrente) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_corrente_fornecedor
ADD CONSTRAINT ccf_age_fk FOREIGN KEY (ban_cd_banco, age_cd_agencia)
REFERENCES IFRDBA2.agenciainf (ban_cd_banco,cd_agencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente_fornecedor
ADD CONSTRAINT ccf_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_corrente_fornecedor
ADD CONSTRAINT ccf_det_fk FOREIGN KEY (det_cd_demonstra_tarifacao)
REFERENCES IFRDBA2.demonstra_tarifacao (cd_demonstra_tarifacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_creditar
ADD CONSTRAINT ccr_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_creditar
ADD CONSTRAINT ccr_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_creditar_sp
ADD CONSTRAINT ccs_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_creditar_sp
ADD CONSTRAINT ccs_clc_fk FOREIGN KEY (clc_pag_nr_lancamento, clc_nr_seq)
REFERENCES IFRDBA2.classificacao_contabil_fin (pag_nr_lancamento,nr_seq) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_grupo
ADD CONSTRAINT cnt_grupo_val_ccontabil FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_grupo
ADD CONSTRAINT cnt_grupo_val_grp_patrim FOREIGN KEY (gp_cd_grupo)
REFERENCES IFRDBA2.grupo_patrimonial (cd_grupo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_bem_inf_fk FOREIGN KEY (cc1_nr_conta_bem_inf)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_bem_uniao_fk FOREIGN KEY (cc1_nr_conta_bem_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_cm_bem_inf_fk FOREIGN KEY (cc1_nr_conta_cm_bem_inf)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_cm_bem_uniao_fk FOREIGN KEY (cc1_nr_conta_cm_bem_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_desp_dp_inf_fk FOREIGN KEY (cc1_nr_conta_desp_dp_inf)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_desp_dp_uniao_fk FOREIGN KEY (cc1_nr_conta_desp_dp_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_dp_bem_inf_fk FOREIGN KEY (cc1_nr_conta_dp_bem_inf)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_dp_bem_uniao_fk FOREIGN KEY (cc1_nr_conta_dp_bem_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_rem_inf_fk FOREIGN KEY (cc1_nr_conta_rem_inf)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cc1_rem_uniao_fk FOREIGN KEY (cc1_nr_conta_rem_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cp_cp_fk FOREIGN KEY (nr_conta)
REFERENCES IFRDBA2.conta_patrimonial (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cspv_nr_conta_spv_dp_fk FOREIGN KEY (cspv_nr_conta_spv_dp)
REFERENCES IFRDBA2.conta_spv (nr_conta_spv) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial
ADD CONSTRAINT cspv_nr_conta_spv_rem_fk FOREIGN KEY (cspv_nr_conta_spv_rem)
REFERENCES IFRDBA2.conta_spv (nr_conta_spv) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conta_patrimonial_dependencia
ADD CONSTRAINT cp1_cp_fk FOREIGN KEY (cp_nr_conta)
REFERENCES IFRDBA2.conta_patrimonial (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conta_patrimonial_dependencia
ADD CONSTRAINT cp1_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.conversao_unidade
ADD CONSTRAINT cu_uia_fk FOREIGN KEY (ui_cd_unidade_convertida)
REFERENCES IFRDBA2.unidade_item (cd_unidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.conversao_unidade
ADD CONSTRAINT cu_uie_fk FOREIGN KEY (ui_cd_unidade_converte)
REFERENCES IFRDBA2.unidade_item (cd_unidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.cotacao_moeda
ADD CONSTRAINT cmo_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd1_evc_fk FOREIGN KEY (evc_nr_evento_apr)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
DISABLE
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_cec_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_ctd_fk FOREIGN KEY (dep_cd_dependencia, nu_operacao_endossada)
REFERENCES IFRDBA2.custodia (dep_cd_dependencia,nu_operacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_eti_fk FOREIGN KEY (eti_cd_especie_titulo)
REFERENCES IFRDBA2.especie_titulo (cd_especie_titulo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_evc_fk FOREIGN KEY (evc_nr_evento_rcb)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_oca_fk FOREIGN KEY (oca_cd_origem_caucao)
REFERENCES IFRDBA2.origem_caucao (cd_origem_caucao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_seg_fk FOREIGN KEY (seg_cd_seguradora)
REFERENCES IFRDBA2.seguradora (cd_seguradora) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_tga_fk FOREIGN KEY (tga_cd_tp_garantia)
REFERENCES IFRDBA2.tipo_garantia (cd_tipo_garantia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_uor_fk FOREIGN KEY (uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT ctd_ust_fk FOREIGN KEY (dep_cd_dependencia, nr_cgc_cpf_usuario)
REFERENCES IFRDBA2.usuario_tesouraria (dep_cd_dependencia,nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.custodia
ADD CONSTRAINT custod_val_tb_corret_valor FOREIGN KEY (cod_corretora)
REFERENCES IFRDBA2.tab_corretora_valores (cod_corretora) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.debito_credito
ADD CONSTRAINT dc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.debito_credito
ADD CONSTRAINT dc_lac_fk FOREIGN KEY (lac_dep_cd_dependencia, lac_nr_seq)
REFERENCES IFRDBA2.lancamento_contabil (dep_cd_dependencia,nr_seq) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.deducao_acrescimo
ADD CONSTRAINT dea_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.deducao_acrescimo
ADD CONSTRAINT dea_tda_fk FOREIGN KEY (tda_cd_deducao_acrescimo)
REFERENCES IFRDBA2.tipo_deducao_acrescimo (cd_deducao_acrescimo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.deducao_acrescimo_dep
ADD CONSTRAINT dad_dea_fk FOREIGN KEY (dea_lat_nr_lancamento, 
  dea_tda_cd_deducao_acrescimo, dea_nr_seq)
REFERENCES IFRDBA2.deducao_acrescimo (lat_nr_lancamento,tda_cd_deducao_acrescimo,nr_seq) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.deducao_acrescimo_dep
ADD CONSTRAINT dad_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.demonstra_tarifacao
ADD CONSTRAINT det_tab_fk FOREIGN KEY (tab_cd_tarifa_bancaria)
REFERENCES IFRDBA2.tarifa_bancaria (cd_tarifa_bancaria) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_dep_fk FOREIGN KEY (dep_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_grupos_dependencias_fk FOREIGN KEY (dep_grupos_dependencias)
REFERENCES IFRSRH.grupos_dependencias (gdp_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.dependencias
ADD CONSTRAINT dep_mun_fk FOREIGN KEY (dep_mun_codigo, dep_ufe_sigla)
REFERENCES IFRDBA2.municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.derivado_imob_transf
ADD CONSTRAINT dit_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.derivado_imob_transf
ADD CONSTRAINT dit_iat_fk FOREIGN KEY (iat_bp_nr_bem, iat_bp_in_uniao, 
  iat_dt_transf)
REFERENCES IFRDBA2.imob_andamento_transf (bp_nr_bem,bp_in_uniao,dt_transf) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.detalhe_adicao_exclusao_fa
ADD CONSTRAINT daefa_fc_fk FOREIGN KEY (fc_cd_forma)
REFERENCES IFRDBA2.forma_aquisicao (cd_forma) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.detalhe_adicao_exclusao_fa
ADD CONSTRAINT daefa_smcp_fk FOREIGN KEY (smcp_cp1_cp_nr_conta, 
  smcp_cp1_dep_cd_dependencia, smcp_ma_situacao, smcp_in_uniao)
REFERENCES IFRDBA2.sit_mensal_conta_patrimonial (cp1_cp_nr_conta,cp1_dep_cd_dependencia,ma_situacao,in_uniao) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.detalhe_adicao_po
ADD CONSTRAINT dapo_po_fk FOREIGN KEY (po_cd_programa)
REFERENCES IFRDBA2.programa_orcamentario (cd_programa) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.detalhe_adicao_po
ADD CONSTRAINT dapo_smcp_fk FOREIGN KEY (smcp_cp1_cp_nr_conta, 
  smcp_cp1_dep_cd_dependencia, smcp_ma_situacao, smcp_in_uniao)
REFERENCES IFRDBA2.sit_mensal_conta_patrimonial (cp1_cp_nr_conta,cp1_dep_cd_dependencia,ma_situacao,in_uniao) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.detalhe_deprec_remun
ADD CONSTRAINT ddr_cc2_fk FOREIGN KEY (cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.detalhe_estrutura
ADD CONSTRAINT de_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.detalhe_estrutura
ADD CONSTRAINT de_de_fk FOREIGN KEY (de_eci_cd_estrutura, de_cd_detalhe, 
  de_nr_nivel)
REFERENCES IFRDBA2.detalhe_estrutura (eci_cd_estrutura,cd_detalhe,nr_nivel) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.detalhe_estrutura
ADD CONSTRAINT de_eci_fk FOREIGN KEY (eci_cd_estrutura)
REFERENCES IFRDBA2.estrutura_consolidacao_info (cd_estrutura) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.divulgacao_licitacao
ADD CONSTRAINT dvl_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.documento_fiscal
ADD CONSTRAINT dfi_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.documento_fiscal
ADD CONSTRAINT dfi_tdc_fk FOREIGN KEY (tdc_tp_documento)
REFERENCES IFRDBA2.tipo_documento (tp_documento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.documentos_processo
ADD CONSTRAINT dop_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.documentos_processo
ADD CONSTRAINT dop_tdl_fk FOREIGN KEY (pl_dep_cd_dependencia, tdl_cd_documento)
REFERENCES IFRDBA2.tipo_documento_licitacao (dep_cd_dependencia,cd_documento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.edital_licitacao
ADD CONSTRAINT el_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.edital_licitacao
ADD CONSTRAINT el_tp_fk FOREIGN KEY (tp_cd_padrao)
REFERENCES IFRDBA2.texto_padrao (cd_padrao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_cc2_fk FOREIGN KEY (cc_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_for_fk FOREIGN KEY (for_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_nm_fk FOREIGN KEY (nm_cd_natureza)
REFERENCES IFRDBA2.natureza_movimentacao (cd_natureza) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.entrada_estoque
ADD CONSTRAINT ee_uor_fk FOREIGN KEY (uo_cd_unid_organ)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.estrutura_margem_operacional
ADD CONSTRAINT emo_ac_fk FOREIGN KEY (cod_agrupamento)
REFERENCES IFRDBA2.agrupamento_contabil (cod_agrupamento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.estrutura_margem_operacional
ADD CONSTRAINT emo_cc1_fk FOREIGN KEY (nro_conta_contabil)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.estrutura_receita
ADD CONSTRAINT fk_agr_r_2_cnt_c FOREIGN KEY (nro_conta_contabil)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.estrutura_receita
ADD CONSTRAINT fk_agr_r_2_est_r FOREIGN KEY (cod_agrupamento)
REFERENCES IFRDBA2.agrupamento_receita (cod_agrupamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.evento_contabil
ADD CONSTRAINT evc_mev_fk FOREIGN KEY (mev_cd_modelo)
REFERENCES IFRDBA2.modelo_evento (cd_modelo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.evento_contabil
ADD CONSTRAINT evc_tev_fk FOREIGN KEY (tp_evento)
REFERENCES IFRDBA2.tipo_evento (tp_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.evento_do_processo
ADD CONSTRAINT evp_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.evento_do_processo
ADD CONSTRAINT evp_ppr_fk FOREIGN KEY (ppr_cd_evento, pl_mdl_cd_modalidade, 
  ppro_tp_avaliacao_licitacao)
REFERENCES IFRDBA2.previsao_processo (evl_cd_evento,mdl_cd_modalidade,tp_avaliacao_licitacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.evento_gestor
ADD CONSTRAINT evg_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.evento_gestor
ADD CONSTRAINT evg_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.fabricante
ADD CONSTRAINT fab_dep1_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.fator_previsao
ADD CONSTRAINT fp_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.feriado
ADD CONSTRAINT fer_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.fluxo_caixa
ADD CONSTRAINT flx_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.forma_aquisicao
ADD CONSTRAINT fc_cc1_inf_fk FOREIGN KEY (cc1_nr_conta_infraero)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.forma_aquisicao
ADD CONSTRAINT fc_cc1_uni_fk FOREIGN KEY (cc1_nr_conta_uniao)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.forma_de_pagamento
ADD CONSTRAINT fpg_dfp_fk FOREIGN KEY (dfg_cd_demonstra_forma)
REFERENCES IFRDBA2.demonstra_forma_pagto (cd_demonstra_forma) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.fornecedor
ADD CONSTRAINT for_dep_fk FOREIGN KEY (dep_cd_dependencia_impedimento)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.fornecedor
ADD CONSTRAINT for_for_fk FOREIGN KEY (for_nr_cgc_cpf_matriz)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.fornecedor
ADD CONSTRAINT for_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.fornecedor_dependencia
ADD CONSTRAINT ford_dep2_fk FOREIGN KEY (dep_cd_dependencia_cn)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.fornecedor_dependencia
ADD CONSTRAINT ford_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.fornecedor_dependencia
ADD CONSTRAINT ford_for_fk FOREIGN KEY (for_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.grupo_patrimonial
ADD CONSTRAINT cp_gp_fk FOREIGN KEY (cp_nr_conta)
REFERENCES IFRDBA2.conta_patrimonial (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.hist_cancel_lanctes
ADD CONSTRAINT hcl_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.historico_centro_custos
ADD CONSTRAINT hcc_cct_fk FOREIGN KEY (hcc_cct_codigo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.historico_centro_custos
ADD CONSTRAINT hcc_emp_fk FOREIGN KEY (hcc_emp_numero_matricula)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.historico_dependencias
ADD CONSTRAINT hde_dep_fk FOREIGN KEY (hde_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.historico_fornecedor
ADD CONSTRAINT hf_for_fk FOREIGN KEY (for_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.historico_fornecedor
ADD CONSTRAINT hf_pen_fk FOREIGN KEY (pnl_cd_penalidade)
REFERENCES IFRDBA2.penalidade (cd_penalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.historico_hora_limite_sp
ADD CONSTRAINT hhl_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.historico_hora_limite_sp
ADD CONSTRAINT hhl_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.historico_unid_organiz
ADD CONSTRAINT huo_uor_fk FOREIGN KEY (huo_uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.hora_limite_sp
ADD CONSTRAINT hls_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.hst_acess_simbep
ADD CONSTRAINT fk01_hstacess FOREIGN KEY (palm_serie_pk)
REFERENCES IFRDBA2.tab_palm_simbep (palm_serie_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.hst_acess_simbep
ADD CONSTRAINT fk02_hstacess FOREIGN KEY (area_cod_pk)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.hst_acess_simbep
ADD CONSTRAINT fk03_hstacess FOREIGN KEY (oper_cracha_pk)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.imob_andamento_transf
ADD CONSTRAINT iat_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.incidencia_centro_custo
ADD CONSTRAINT icc_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
ALTER TABLE ifrdba2.incidencia_centro_custo
ADD CONSTRAINT icc_cc2_fk FOREIGN KEY (iccd_cc_cd_centro_custo, 
  iccd_dep_cd_dependencia)
REFERENCES IFRDBA2.incidencia_centro_custo_dep (cc_cd_centro_custo,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.incidencia_centro_custo_dep
ADD CONSTRAINT iccp_cc_fk FOREIGN KEY (cc_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.incidencia_centro_custo_dep
ADD CONSTRAINT iccp_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.indices_fin_valores
ADD CONSTRAINT ifv_ifi_fk FOREIGN KEY (cod_indice)
REFERENCES IFRDBA2.indices_financeiros (cod_indice) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.inventario
ADD CONSTRAINT inv_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_compromisso_orc_temp
ADD CONSTRAINT iot_cot_pk FOREIGN KEY (num_compromisso_temp)
REFERENCES IFRDBA2.compromisso_orcamentario_temp (num_compromisso_temp) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_compromisso_orc_temp
ADD CONSTRAINT iot_ipo_pk FOREIGN KEY (num_ano, cod_dependencia, num_item)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_compromisso_orcamentario
ADD CONSTRAINT ico_co_fk FOREIGN KEY (nr_ano_compromisso, 
  dep_cd_dependencia_compr, cc2_cd_centro_custo, nr_compromisso)
REFERENCES IFRDBA2.compromisso_orcamentario (nr_ano_compromisso,dep_cd_dependencia_compr,cc2_cd_centro_custo,nr_compromisso) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_compromisso_orcamentario
ADD CONSTRAINT ico_ipc_fk FOREIGN KEY (nr_ano_pre_compromisso, 
  dep_cd_dependencia_pcompr, cc2_cd_centro_custo_2, nr_pre_compromisso, 
  nr_seq_pcomp)
REFERENCES IFRDBA2.item_pre_compromisso_orcamenta (nr_ano_pre_compromisso,dep_cd_dependencia_pcompr,cc2_cd_centro_custo,nr_pre_compromisso,nr_seq_pcomp) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_compromisso_orcamentario
ADD CONSTRAINT ico_ipr_fk FOREIGN KEY (nr_ano, dep_cd_dependencia, nr_item)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_da_transferencia
ADD CONSTRAINT idt_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_da_transferencia
ADD CONSTRAINT idt_sti_fk FOREIGN KEY (ti_dep_cd_dependencia_orig, 
  ti_aa_solicitacao, ti_nr_solicitacao)
REFERENCES IFRDBA2.transferencia_itens (dep_cd_dependencia_orig,aa_solicitacao,nr_solicitacao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_do_sistema
ADD CONSTRAINT ids_ig_fk FOREIGN KEY (ig_dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_do_sistema
ADD CONSTRAINT ids_sis_fk FOREIGN KEY (sis_cd_sistema)
REFERENCES IFRDBA2.sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_entrada_estoque
ADD CONSTRAINT iee_ee_pk FOREIGN KEY (ee_dep_cd_dependencia, ee_aa_entrada, 
  ee_nr_entrada)
REFERENCES IFRDBA2.entrada_estoque (dep_cd_dependencia,aa_entrada,nr_entrada) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_entrada_estoque
ADD CONSTRAINT iee_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_am_fk FOREIGN KEY (am_cd_aquisicao)
REFERENCES IFRDBA2.aquisicao_material (cd_aquisicao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_ci_fk FOREIGN KEY (ci_cd_classe)
REFERENCES IFRDBA2.classe_item (cd_classe) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_ig2_fk FOREIGN KEY (dep_cd_dep_nacional, ci_cd_clas_nacional, 
  cd_item_nacional)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_ig_fk FOREIGN KEY (ig_dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_tmf_fk FOREIGN KEY (tmf_cd_tipo_material_fornecime)
REFERENCES IFRDBA2.tipo_material_fornecimento (cd_tipo_material_fornecimento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_uie_fk FOREIGN KEY (ui_cd_unidade_estoca)
REFERENCES IFRDBA2.unidade_item (cd_unidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico
ADD CONSTRAINT ig_uif_fk FOREIGN KEY (ui_cd_unidade_fornece)
REFERENCES IFRDBA2.unidade_item (cd_unidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_generico_substituido
ADD CONSTRAINT igs_ig1_fk FOREIGN KEY (ig_dep_cd_depend_1, ig_ci_cd_classe_1, 
  ig_cd_item_1)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_generico_substituido
ADD CONSTRAINT igs_ig2_fk FOREIGN KEY (ig_dep_cd_depend_2, ig_ci_cd_classe_2, 
  ig_cd_item_2)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_cc2_fk FOREIGN KEY (cd_centro_custo_gestor)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_dep_fk FOREIGN KEY (dep_cd_dependencia_compra)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_os_fk FOREIGN KEY (os_aa_ordem_servico, os_nr_ordem_servico, 
  os_dep_cd_dependencia)
REFERENCES IFRDBA2.ordem_servico (aa_ordem_servico,nr_ordem_servico,dep_cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_inedito
ADD CONSTRAINT ii_ui_fk FOREIGN KEY (ui_cd_unidade)
REFERENCES IFRDBA2.unidade_item (cd_unidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_por_dependencia
ADD CONSTRAINT ipd_abc_fk FOREIGN KEY (dep_cd_dependencia, abc_cd_classificacao)
REFERENCES IFRDBA2.classificacao_abc (dep_cd_dependencia,cd_classificacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_por_dependencia
ADD CONSTRAINT ipd_ig_fk FOREIGN KEY (dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_pre_compromisso_orcamenta
ADD CONSTRAINT ipc_ipr_fk FOREIGN KEY (nr_ano, dep_cd_dependencia, nr_item)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_pre_compromisso_orcamenta
ADD CONSTRAINT ipc_pc_fk FOREIGN KEY (nr_ano_pre_compromisso, 
  dep_cd_dependencia_pcompr, cc2_cd_centro_custo, nr_pre_compromisso)
REFERENCES IFRDBA2.pre_compromisso_orcamentario (nr_ano_pre_compromisso,dep_cd_dependencia_pcompr,cc2_cd_centro_custo,nr_pre_compromisso) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_proposta_licitacao
ADD CONSTRAINT ipl_pdl_fk FOREIGN KEY (pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_licitacao
ADD CONSTRAINT ipl_rcl_fk FOREIGN KEY (rcl_lrc_sq_lote, 
  rcl_rci_dep_cd_dependencia, rcl_rci_aa_requisicao_compra, 
  rcl_rci_nr_requisicao_compra)
REFERENCES IFRDBA2.requisicoes_compras_do_lote (lrc_sq_lote,rci_dep_cd_dependencia,rci_aa_requisicao_compra,rci_nr_requisicao_compra) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_licitacao
ADD CONSTRAINT ipl_sms_fk FOREIGN KEY (sms_aa_sms, sms_nr_sms, 
  sms_dep_cd_dependencia)
REFERENCES IFRDBA2.sms (aa_sms,nr_sms,dep_cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_licitacao
ADD CONSTRAINT ipl_sod_fk FOREIGN KEY (sod_aa_sms, sod_nr_sms, 
  sod_dep_cd_dependencia)
REFERENCES IFRDBA2.sms_outra_dependencia (aa_sms,nr_sms,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ipos_cc_fk FOREIGN KEY (cc2_cd_centro_custo_gest)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ipos_dep_fk FOREIGN KEY (dep_cd_dependencia_gest)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_cc2_gerd_fk FOREIGN KEY (cc2_cd_centro_custo_gerd)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_cf_fk FOREIGN KEY (cf_nr_item)
REFERENCES IFRDBA2.catalogo_financeiro (nr_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_dep_gerd_fk FOREIGN KEY (dep_cd_dependencia_gerd)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_for_fk FOREIGN KEY (ff_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_gp_fk FOREIGN KEY (gp_cd_grupo)
REFERENCES IFRDBA2.grupo_patrimonial (cd_grupo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_po_fk FOREIGN KEY (po_cd_programa)
REFERENCES IFRDBA2.programa_orcamentario (cd_programa) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orc_simulada
ADD CONSTRAINT ips_prj_fk FOREIGN KEY (prj_cd_projeto)
REFERENCES IFRDBA2.projeto (cd_projeto) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_cc2_2_fk FOREIGN KEY (cc2_cd_centro_custo_gerd)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_cc2_3_fk FOREIGN KEY (cc2_cd_centro_custo_gest)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_cf_fk FOREIGN KEY (cf_nr_item)
REFERENCES IFRDBA2.catalogo_financeiro (nr_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_dep_2_fk FOREIGN KEY (dep_cd_dependencia_gest)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_for_2_fk FOREIGN KEY (ff_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor (nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_po_fk FOREIGN KEY (po_cd_programa)
REFERENCES IFRDBA2.programa_orcamentario (cd_programa) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_proposta_orcamentaria
ADD CONSTRAINT ipr_prj_fk FOREIGN KEY (prj_cd_projeto)
REFERENCES IFRDBA2.projeto (cd_projeto) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_apl_fk FOREIGN KEY (apl_cd_aplicacao)
REFERENCES IFRDBA2.aplicacao_item_requisicao (cd_aplicacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_cc2_fk FOREIGN KEY (cd_centro_custo_gestor)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_dep_fk FOREIGN KEY (dep_cd_dependencia_compra)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_requisicao
ADD CONSTRAINT ir_os_fk FOREIGN KEY (os_aa_ordem_servico, os_nr_ordem_servico, 
  ipd_dep_cd_dependencia)
REFERENCES IFRDBA2.ordem_servico (aa_ordem_servico,nr_ordem_servico,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_saida_estoque
ADD CONSTRAINT ise_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_saida_estoque
ADD CONSTRAINT ise_se_fk FOREIGN KEY (se_dep_cd_dependencia, se_aa_saida, 
  se_nr_saida)
REFERENCES IFRDBA2.saida_estoque (dep_cd_dependencia,aa_saida,nr_saida) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.item_sms_outra_dependencia
ADD CONSTRAINT iso_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.item_sms_outra_dependencia
ADD CONSTRAINT iso_sod_fk FOREIGN KEY (sod_aa_sms, sod_nr_sms, 
  sod_dep_cd_dependencia)
REFERENCES IFRDBA2.sms_outra_dependencia (aa_sms,nr_sms,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lancamento_contabil
ADD CONSTRAINT lac_dep1_fk FOREIGN KEY (dep_cd_dependencia_dest)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil
ADD CONSTRAINT lac_tdc_fk FOREIGN KEY (tdc_tp_documento)
REFERENCES IFRDBA2.tipo_documento (tp_documento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_alm1_fk FOREIGN KEY (cd_dependencia_credito)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_alm2_fk FOREIGN KEY (cd_dependencia_debito)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_cc1_fk FOREIGN KEY (cd_centro_custo_credito)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_cc2_fk FOREIGN KEY (cd_centro_custo_debito)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_cco1_fk FOREIGN KEY (cd_conta_contabil_credito)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_cco2_fk FOREIGN KEY (cd_conta_contabil_debito)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_lcm_fk FOREIGN KEY (cd_aplicacao)
REFERENCES IFRDBA2.aplicacao_item_requisicao (cd_aplicacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_contabil_material
ADD CONSTRAINT lcm_nm_fk FOREIGN KEY (cd_natureza)
REFERENCES IFRDBA2.natureza_movimentacao (cd_natureza) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_cc_fk FOREIGN KEY (dep_cd_dependencia, cc_ban_cd_banco, 
  cc_tcc_tp_conta_corrente)
REFERENCES IFRDBA2.conta_corrente (age_dep_cd_dependencia,ban_cd_banco,tcc_tp_conta_corrente) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_rsg_fk FOREIGN KEY (rsg_apl_nr_aplicacao, rsg_dt_referencia)
REFERENCES IFRDBA2.resgate (apl_nr_aplicacao,dt_referencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tesouraria
ADD CONSTRAINT lat_usu_fk FOREIGN KEY (usu_dep_cd_dependencia, usu_nr_cgc_cpf)
REFERENCES IFRDBA2.usuario_tesouraria (dep_cd_dependencia,nr_cgc_cpf) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lancamento_tipo_desp_receita
ADD CONSTRAINT lanc_tp_desp_rec_val_ccontabil FOREIGN KEY (cc_num_conta_contabil)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tipo_desp_receita
ADD CONSTRAINT lanc_tp_desp_rec_val_lan_tes FOREIGN KEY (dep_cd_dependencia, 
  num_lancamento_dependencia)
REFERENCES IFRDBA2.lancamento_tesouraria (dep_cd_dependencia,nr_lanc_dep) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lancamento_tipo_desp_receita
ADD CONSTRAINT lanc_tp_des_rec_val_tp_des_rec FOREIGN KEY (
  tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.log_hora_limite_sp
ADD CONSTRAINT lhl_hls_fk FOREIGN KEY (hls_dep_cd_dependencia)
REFERENCES IFRDBA2.hora_limite_sp (dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lote_estoque
ADD CONSTRAINT le_ca_fk FOREIGN KEY (ca_cd_condicao)
REFERENCES IFRDBA2.condicao_armazenamento (cd_condicao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.lote_estoque
ADD CONSTRAINT le_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.lote_requisicoes_compras
ADD CONSTRAINT lrc_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.material_centro_custo
ADD CONSTRAINT mcc_cc2_2_fk FOREIGN KEY (cd_centro_custo_autoriza)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.material_centro_custo
ADD CONSTRAINT mcc_cc2_fk FOREIGN KEY (cd_centro_custo_gestor)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.material_centro_custo
ADD CONSTRAINT mcc_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.material_centro_custo
ADD CONSTRAINT mcc_su_fk FOREIGN KEY (id_usuario)
REFERENCES IFRDBA2.seg_usuario (id_usuario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.media_arrecadacao
ADD CONSTRAINT mea_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.media_mensal_serie_monetaria
ADD CONSTRAINT mmsm_smo_fk FOREIGN KEY (cd_serie)
REFERENCES IFRDBA2.serie_monetaria (cd_serie) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.membro_comissao_licitacao
ADD CONSTRAINT mcl_cl_fk FOREIGN KEY (cl_pl_aa_processo, cl_pl_sq_processo, 
  cl_pl_dep_cd_dependencia_deten, cl_pl_mdl_cd_modalidade, cl_tp_comissao)
REFERENCES IFRDBA2.comissao_licitacao (pl_aa_processo,pl_sq_processo,pl_dep_cd_dependencia_detent,pl_mdl_cd_modalidade,tp_comissao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.membro_comissao_licitacao
ADD CONSTRAINT mcl_uo_fk FOREIGN KEY (uo_cd_unid_organ)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.membro_comissao_permanente
ADD CONSTRAINT mcp_cpl_fk FOREIGN KEY (cpl_dep_cd_dependencia, cpl_sq_comissao)
REFERENCES IFRDBA2.comissao_permanente_licitacao (dep_cd_dependencia,sq_comissao) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mc_dep_fk FOREIGN KEY (dep_cd_dependencia_efetuou)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mc_ipr_2_fk FOREIGN KEY (nr_ano_d, dep_cd_dependencia_d, 
  nr_item_d)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mc_ipr_3_fk FOREIGN KEY (nr_ano_residuo, 
  dep_cd_dependencia_residuo, nr_item_residuo)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.movimentacao_credito
ADD CONSTRAINT mc_ipr_fk FOREIGN KEY (nr_ano_o, dep_cd_dependencia_o, nr_item_o)
REFERENCES IFRDBA2.item_proposta_orcamentaria (nr_ano,dep_cd_dependencia,nr_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.movimento_operacional
ADD CONSTRAINT mop_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.movimento_operacional
ADD CONSTRAINT mop_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.municipios
ADD CONSTRAINT mun_ufe_fk FOREIGN KEY (mun_ufe_sigla)
REFERENCES IFRDBA2.unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.natureza_movimentacao
ADD CONSTRAINT nm_ccc_fk FOREIGN KEY (cc_nr_conta_contrapartida)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.natureza_movimentacao
ADD CONSTRAINT nm_ccl_fk FOREIGN KEY (cc_nr_conta_lancamento)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.ocorrencia_fornecedor
ADD CONSTRAINT ocf_omd_fk FOREIGN KEY (omd_cd_ocorrencia)
REFERENCES IFRDBA2.ocorrencia_mal_desempenho (cd_ocorrencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ocorrencia_fornecedor
ADD CONSTRAINT ocf_pdl_fk FOREIGN KEY (pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ocorrencia_fornecedor
ADD CONSTRAINT ocf_pnl_fk FOREIGN KEY (pnl_cd_penalidade)
REFERENCES IFRDBA2.penalidade (cd_penalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_aliquota
ADD CONSTRAINT orc_aliq_cont_contabil_fk FOREIGN KEY (num_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_compromisso_sp_temp
ADD CONSTRAINT oct_dep_fk FOREIGN KEY (num_sp, cod_dep_sp, cod_cc_sp)
REFERENCES IFRDBA2.orc_sp_temp (num_sp,cod_dep_sp,cod_cc_sp) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_consol_ana_conta
ADD CONSTRAINT ocac_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orc_consol_ana_conta
ADD CONSTRAINT ocac_ocas_fk FOREIGN KEY (ocas_po_cd_programa, ocas_cd_sumario)
REFERENCES IFRDBA2.orc_consol_ana_sumario (po_cd_programa,cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_consol_ana_sumario
ADD CONSTRAINT ocas_po_fk FOREIGN KEY (po_cd_programa)
REFERENCES IFRDBA2.programa_orcamentario (cd_programa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_consol_sin_conta
ADD CONSTRAINT ocsc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orc_consol_sin_conta
ADD CONSTRAINT ocsc_ocss_fk FOREIGN KEY (ocss_po_cd_programa, ocss_cd_sumario)
REFERENCES IFRDBA2.orc_consol_sin_sumario (po_cd_programa,cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_consol_sin_sumario
ADD CONSTRAINT ocss_po_fk FOREIGN KEY (po_cd_programa)
REFERENCES IFRDBA2.programa_orcamentario (cd_programa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_det_interface
ADD CONSTRAINT odi_ogi_fk FOREIGN KEY (nom_interface, dat_interface)
REFERENCES IFRDBA2.orc_ger_interface (nom_interface,dat_interface) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_dispen_ana_conta
ADD CONSTRAINT odac_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orc_dispen_ana_conta
ADD CONSTRAINT odac_odas_fk FOREIGN KEY (odas_odis_cd_dispendio, odas_cd_sumario)
REFERENCES IFRDBA2.orc_dispen_ana_sumario (odis_cd_dispendio,cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_dispen_ana_sumario
ADD CONSTRAINT odas_odis_fk FOREIGN KEY (odis_cd_dispendio)
REFERENCES IFRDBA2.orc_dispendio (cd_dispendio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_dispen_sin_conta
ADD CONSTRAINT odsc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orc_dispen_sin_conta
ADD CONSTRAINT odsc_odss_fk FOREIGN KEY (odss_odis_cd_dispendio, odss_cd_sumario)
REFERENCES IFRDBA2.orc_dispen_sin_sumario (odis_cd_dispendio,cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_dispen_sin_sumario
ADD CONSTRAINT odss_odis_fk FOREIGN KEY (odis_cd_dispendio)
REFERENCES IFRDBA2.orc_dispendio (cd_dispendio) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_filtros_centro_custo
ADD CONSTRAINT orc_fil_cc_val_orc_segur FOREIGN KEY (nom_grupo, cod_funcao, 
  cod_programa)
REFERENCES IFRDBA2.orc_seguranca (nom_grupo,cod_funcao,cod_programa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_filtros_programas
ADD CONSTRAINT ofp_seg_fk FOREIGN KEY (nom_grupo, cod_funcao, cod_programa)
REFERENCES IFRDBA2.orc_seguranca (nom_grupo,cod_funcao,cod_programa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_item_compromisso_sp_temp
ADD CONSTRAINT oit_dep_fk FOREIGN KEY (num_sp, cod_dep_sp, cod_cc_sp, 
  num_ano_compromisso, cod_dependencia_compr, cod_centro_custo, num_compromisso)
REFERENCES IFRDBA2.orc_compromisso_sp_temp (num_sp,cod_dep_sp,cod_cc_sp,num_ano_compromisso,cod_dependencia_compr,cod_centro_custo,num_compromisso) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_resumo_ana_conta
ADD CONSTRAINT orac_oras_fk FOREIGN KEY (oras_cd_sumario)
REFERENCES IFRDBA2.orc_resumo_ana_sumario (cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_resumo_ana_conta_meta
ADD CONSTRAINT orc_res_cnt_val_orc_res_sum FOREIGN KEY (oras_cd_sumario)
REFERENCES IFRDBA2.orc_resumo_ana_sumario_meta (cd_sumario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_seguranca
ADD CONSTRAINT osg_fun_fk FOREIGN KEY (cod_funcao, cod_programa)
REFERENCES IFRDBA2.orc_funcoes_programas (cod_funcao,cod_programa) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orc_sp_temp
ADD CONSTRAINT ost_cc_fk FOREIGN KEY (cod_cc_sp)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orc_sp_temp
ADD CONSTRAINT ost_dep_fk FOREIGN KEY (cod_dep_sp)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_cc_fk FOREIGN KEY (cc_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_empa_fk FOREIGN KEY (emp_nr_matricula_aut)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_empr_fk FOREIGN KEY (emp_nr_matricula_req)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.ordem_servico
ADD CONSTRAINT os_uo_fk FOREIGN KEY (uo_cd_unid_organ)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.orgaos_externos
ADD CONSTRAINT oex_mun_fk FOREIGN KEY (oex_mun_codigo, oex_ufe_sigla)
REFERENCES IFRDBA2.municipios (mun_codigo,mun_ufe_sigla) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.orgaos_externos
ADD CONSTRAINT oex_oex_fk FOREIGN KEY (oex_oex_codigo)
REFERENCES IFRDBA2.orgaos_externos (oex_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.origem_recurso
ADD CONSTRAINT or_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.origem_recurso_processo
ADD CONSTRAINT orp_or_fk FOREIGN KEY (or_cd_origem)
REFERENCES IFRDBA2.origem_recurso (cd_origem) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.origem_recurso_processo
ADD CONSTRAINT orp_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag1_evc_fk FOREIGN KEY (evc_nr_evento_apr)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_evc_fk FOREIGN KEY (evc_nr_evento_pag)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_fpg_fk FOREIGN KEY (fpg_cd_forma_pgto)
REFERENCES IFRDBA2.forma_de_pagamento (cd_forma_pgto) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_lat_fk FOREIGN KEY (nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pagamento
ADD CONSTRAINT pag_or_fk FOREIGN KEY (or_cd_origem)
REFERENCES IFRDBA2.origem_recurso (cd_origem) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.pagamento_item_comp_orc
ADD CONSTRAINT pgi_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.param_custodia
ADD CONSTRAINT pcu_inf_fk FOREIGN KEY (inf_cod_indice)
REFERENCES IFRDBA2.indices_financeiros (cod_indice) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.param_custodia
ADD CONSTRAINT pcu_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.param_custodia_dep
ADD CONSTRAINT pcd_dep_fk FOREIGN KEY (cod_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.param_custodia_dep
ADD CONSTRAINT pcd_uor_fk FOREIGN KEY (uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_depenc FOREIGN KEY (cod_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_empregado FOREIGN KEY (emp_num_matric_resp_ntcf)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_empregado2 FOREIGN KEY (emp_num_matric_depart_mdc)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_empregado3 FOREIGN KEY (emp_num_matric_divis_mdc)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_empregado4 FOREIGN KEY (emp_num_matric_secao_mdc)
REFERENCES IFRSRH.cadastros (emp_numero_matricula) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_indic_financ FOREIGN KEY (inf_cod_indice)
REFERENCES IFRDBA2.indices_financeiros (cod_indice) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_moeda FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_unid_organiz FOREIGN KEY (
  uor_cod_unid_org_resp_ntcf)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametro_tesouraria_dep
ADD CONSTRAINT par_tes_dep_val_unid_organiz2 FOREIGN KEY (
  uor_cod_unid_org_resp2_ntcf)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.parametros
ADD CONSTRAINT par1_cc1_fk FOREIGN KEY (cc1_nr_conta_pre_comp)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametros
ADD CONSTRAINT par_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.parametros_sistemas_adm
ADD CONSTRAINT psa_cc_fk FOREIGN KEY (cd_centro_custo_rep_esto)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametros_sistemas_adm
ADD CONSTRAINT psa_moe1_fk FOREIGN KEY (moe_cd_moeda_corr_licita)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.parametros_sistemas_adm
ADD CONSTRAINT psa_moe_fk FOREIGN KEY (moe_cd_moeda_corrente)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.part_number
ADD CONSTRAINT pn_fab_fk FOREIGN KEY (fab_cd_fabricante, fab_dep_cd_dependencia)
REFERENCES IFRDBA2.fabricante (cd_fabricante,dep_cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.part_number
ADD CONSTRAINT pn_ig_fk FOREIGN KEY (ig_dep_cd_dependencia, ig_ci_cd_classe, 
  ig_cd_item)
REFERENCES IFRDBA2.item_generico (dep_cd_dependencia,ci_cd_classe,cd_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.participante_de_licitacao
ADD CONSTRAINT pdl_ford_fk FOREIGN KEY (for_dep_cd_dependencia, for_nr_cgc_cpf)
REFERENCES IFRDBA2.fornecedor_dependencia (dep_cd_dependencia,for_nr_cgc_cpf) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.participante_de_licitacao
ADD CONSTRAINT pdl_lrc_fk FOREIGN KEY (lrc_sq_lote)
REFERENCES IFRDBA2.lote_requisicoes_compras (sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.participante_de_licitacao
ADD CONSTRAINT pdl_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.percentual_receita_despesa
ADD CONSTRAINT prd_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.percentual_receita_despesa
ADD CONSTRAINT prd_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.pre_compromisso_orcamentario
ADD CONSTRAINT pc_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pre_compromisso_orcamentario
ADD CONSTRAINT pc_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pre_compromisso_orcamentario
ADD CONSTRAINT pc_dep_2_fk FOREIGN KEY (dep_cd_dependencia_efetuou)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.pre_compromisso_orcamentario
ADD CONSTRAINT pc_dep_fk FOREIGN KEY (dep_cd_dependencia_pcompr)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.previsao_processo
ADD CONSTRAINT evl_cd_evento_fk FOREIGN KEY (evl_cd_evento)
REFERENCES IFRDBA2.evento_licitatorio (cd_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.previsao_processo
ADD CONSTRAINT mdl_cd_mod_fk FOREIGN KEY (mdl_cd_modalidade)
REFERENCES IFRDBA2.modalidade_licitacao (cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_cpl_fk FOREIGN KEY (cpl_dep_cd_dependencia, 
  cpl_sq_comissao_perm)
REFERENCES IFRDBA2.comissao_permanente_licitacao (dep_cd_dependencia,sq_comissao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_dep_ben_fk FOREIGN KEY (dep_cd_dependencia_benef)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_dep_dt_fk FOREIGN KEY (dep_cd_dependencia_detent)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_mdl_fk FOREIGN KEY (mdl_cd_modalidade)
REFERENCES IFRDBA2.modalidade_licitacao (cd_modalidade) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.processo_licitatorio
ADD CONSTRAINT pl_uo_fk FOREIGN KEY (uo_cd_unid_organ)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.projecao_receita
ADD CONSTRAINT pjr_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.projecao_receita
ADD CONSTRAINT pjr_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.projecao_receita
ADD CONSTRAINT pjr_tar_fk FOREIGN KEY (tar_cd_regime)
REFERENCES IFRDBA2.tipo_ajuste_regime_caixa (cd_regime) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.projecao_receita
ADD CONSTRAINT pjr_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.projecao_receita_simulada
ADD CONSTRAINT prs_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.projecao_receita_simulada
ADD CONSTRAINT prs_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.projecao_receita_simulada
ADD CONSTRAINT prs_tar_fk FOREIGN KEY (tar_cd_regime)
REFERENCES IFRDBA2.tipo_ajuste_regime_caixa (cd_regime) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.quantidade_tarifacao
ADD CONSTRAINT qta_det_fk FOREIGN KEY (det_cd_demonstra_tarifacao)
REFERENCES IFRDBA2.demonstra_tarifacao (cd_demonstra_tarifacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.quantidade_tarifacao
ADD CONSTRAINT qta_lat_fk FOREIGN KEY (lat_nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.recebimento
ADD CONSTRAINT rcb_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.recebimento
ADD CONSTRAINT rcb_fpg_fk FOREIGN KEY (fpg_cd_forma_pagamento)
REFERENCES IFRDBA2.forma_de_pagamento (cd_forma_pgto) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.recebimento
ADD CONSTRAINT rcb_lat_fk FOREIGN KEY (nr_lancamento)
REFERENCES IFRDBA2.lancamento_tesouraria (nr_lancamento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.receita
ADD CONSTRAINT rec_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.receita
ADD CONSTRAINT rec_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.receita
ADD CONSTRAINT rec_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.receita_financeira
ADD CONSTRAINT ref_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.recurso_licitatorio
ADD CONSTRAINT rl_pdl1_fk FOREIGN KEY (pdl_for_dep_cd_dependencia_te, 
  pdl_for_nr_cgc_cpf_alvo, pdl_lrc_sq_lote_alvo)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.recurso_licitatorio
ADD CONSTRAINT rl_pdl2_fk FOREIGN KEY (pdl_for_dep_cd_dependencia_do, 
  pdl_for_nr_cgc_cpf_imp, pdl_lrc_sq_lote_imp)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.recurso_licitatorio
ADD CONSTRAINT rl_pl_fk FOREIGN KEY (pl_aa_processo, pl_sq_processo, 
  pl_dep_cd_dependencia_detent, pl_mdl_cd_modalidade)
REFERENCES IFRDBA2.processo_licitatorio (aa_processo,sq_processo,dep_cd_dependencia_detent,mdl_cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.regioes_geograficas
ADD CONSTRAINT rge_uf_fk FOREIGN KEY (uf_ufe_sigla)
REFERENCES IFRDBA2.unidades_federacao (ufe_sigla) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_cc1_fk FOREIGN KEY (cc1_nr_conta)
REFERENCES IFRDBA2.conta_contabil (nr_conta) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_cc2_fk FOREIGN KEY (cd_centro_custo_gestor)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_cc_fk FOREIGN KEY (cc_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_dep_com_fk FOREIGN KEY (dep_cd_dependencia_compra)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_ipd_fk FOREIGN KEY (ipd_dep_cd_dependencia, 
  ipd_ig_ci_cd_classe, ipd_ig_cd_item)
REFERENCES IFRDBA2.item_por_dependencia (dep_cd_dependencia,ig_ci_cd_classe,ig_cd_item) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.requisicao_compra_item
ADD CONSTRAINT rci_ir_fk FOREIGN KEY (ir_os_aa_ordem_servico, 
  ir_os_nr_ordem_servico, ipd_dep_cd_dependencia, ir_sq_item)
REFERENCES IFRDBA2.item_requisicao (os_aa_ordem_servico,os_nr_ordem_servico,ipd_dep_cd_dependencia,sq_item) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.requisicao_compra_provisoria
ADD CONSTRAINT rcp_tmf_fk FOREIGN KEY (tmf_cd_tipo_material_fornecim)
REFERENCES IFRDBA2.tipo_material_fornecimento (cd_tipo_material_fornecimento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.requisicoes_compras_do_lote
ADD CONSTRAINT rcl_lrc_fk FOREIGN KEY (lrc_sq_lote)
REFERENCES IFRDBA2.lote_requisicoes_compras (sq_lote) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.resgate
ADD CONSTRAINT rsg_apl_fk FOREIGN KEY (apl_nr_aplicacao)
REFERENCES IFRDBA2.aplicacao (nr_aplicacao) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.resgate
ADD CONSTRAINT rsg_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.resultado_meta_dependencia
ADD CONSTRAINT rmd_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.resultado_meta_dependencia
ADD CONSTRAINT rmd_mta_fk FOREIGN KEY (mta_cd_meta)
REFERENCES IFRDBA2.meta (cd_meta) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.retencao_tributo
ADD CONSTRAINT ret_tda_fk FOREIGN KEY (tda_cd_deducao_acrescimo)
REFERENCES IFRDBA2.tipo_deducao_acrescimo (cd_deducao_acrescimo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_alm_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_cc2_fk FOREIGN KEY (cc_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_nm_fk FOREIGN KEY (nm_cd_natureza)
REFERENCES IFRDBA2.natureza_movimentacao (cd_natureza) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.saida_estoque
ADD CONSTRAINT se_uor_fk FOREIGN KEY (uo_cd_unid_organ)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.saldo_bancario
ADD CONSTRAINT sbc_cc_fk FOREIGN KEY (cc_age_dep_cd_dependencia, cc_ban_cd_banco, 
  cc_tcc_tp_conta_corrente)
REFERENCES IFRDBA2.conta_corrente (age_dep_cd_dependencia,ban_cd_banco,tcc_tp_conta_corrente) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.saldo_receita_financeira
ADD CONSTRAINT srf_ref_fk FOREIGN KEY (ref_cd_receita_financeira)
REFERENCES IFRDBA2.receita_financeira (cd_receita_financeira) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_grupo_usuario
ADD CONSTRAINT sgu_fk_ss FOREIGN KEY (ss_cd_sistema)
REFERENCES IFRDBA2.seg_sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_grupo_usuario_menu
ADD CONSTRAINT sgum_sem_fk FOREIGN KEY (sq_funcao, ss_cd_sistema)
REFERENCES IFRDBA2.seg_menu (sq_funcao,ss_cd_sistema) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_grupo_usuario_menu
ADD CONSTRAINT sgum_sgu_fk FOREIGN KEY (cd_grupo, ss_cd_sistema)
REFERENCES IFRDBA2.seg_grupo_usuario (cd_grupo,ss_cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_menu
ADD CONSTRAINT smen_ss_fk FOREIGN KEY (ss_cd_sistema)
REFERENCES IFRDBA2.seg_sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_usuario
ADD CONSTRAINT su_fk_cc2 FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_usuario
ADD CONSTRAINT su_fk_dep FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_usuario_centro_custo
ADD CONSTRAINT succ_cc2_fk FOREIGN KEY (cc2_cd_centro_custo)
REFERENCES IFRDBA2.centro_custo (cd_centro_custo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_usuario_centro_custo
ADD CONSTRAINT succ_ss_fk FOREIGN KEY (ss_cd_sistema)
REFERENCES IFRDBA2.seg_sistema (cd_sistema) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_usuario_centro_custo
ADD CONSTRAINT succ_su_fk FOREIGN KEY (su_id_usuario)
REFERENCES IFRDBA2.seg_usuario (id_usuario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seg_usuario_sistema
ADD CONSTRAINT sus_fk_sgu FOREIGN KEY (sgu_cd_grupo, ss_cd_sistema)
REFERENCES IFRDBA2.seg_grupo_usuario (cd_grupo,ss_cd_sistema) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_usuario_sistema
ADD CONSTRAINT sus_fk_ss FOREIGN KEY (ss_cd_sistema)
REFERENCES IFRDBA2.seg_sistema (cd_sistema) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seg_usuario_sistema
ADD CONSTRAINT sus_fk_su FOREIGN KEY (su_id_usuario)
REFERENCES IFRDBA2.seg_usuario (id_usuario) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seq_boleto
ADD CONSTRAINT sbo_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.seq_boleto
ADD CONSTRAINT sbo_tdr_fk FOREIGN KEY (tdr_cd_despesa_receita)
REFERENCES IFRDBA2.tipo_despesa_receita (cd_despesa_receita) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seq_mdc
ADD CONSTRAINT smd_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.seq_recibo
ADD CONSTRAINT sre_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.serie_monetaria
ADD CONSTRAINT smo_moe_fk FOREIGN KEY (moe_cd_moeda)
REFERENCES IFRDBA2.moeda (cd_moeda) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sipat_interface_sequencial
ADD CONSTRAINT sip_inter_seq_val_depend FOREIGN KEY (smcp_cp1_dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sistema
ADD CONSTRAINT sis_sis_fk FOREIGN KEY (sis_cd_sistema)
REFERENCES IFRDBA2.sistema (cd_sistema) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sit_anual_conta_patrim_exe_ant
ADD CONSTRAINT saca_cp1_fk FOREIGN KEY (cp1_cp_nr_conta, cp1_dep_cd_dependencia)
REFERENCES IFRDBA2.conta_patrimonial_dependencia (cp_nr_conta,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sit_mensal_bem_patrimonial
ADD CONSTRAINT smbp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.sit_mensal_conta_patrimonial
ADD CONSTRAINT smcp_cp1_fk FOREIGN KEY (cp1_cp_nr_conta, cp1_dep_cd_dependencia)
REFERENCES IFRDBA2.conta_patrimonial_dependencia (cp_nr_conta,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sms
ADD CONSTRAINT sms_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.sms
ADD CONSTRAINT sms_pdl_fk FOREIGN KEY (pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.sms
ADD CONSTRAINT sms_uor_fk FOREIGN KEY (uo_cd_unid_organ_destino)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sms_nf_for_dep
ADD CONSTRAINT snf_sms_fk FOREIGN KEY (sms_aa_sms, sms_nr_sms, 
  sms_dep_cd_dependencia)
REFERENCES IFRDBA2.sms (aa_sms,nr_sms,dep_cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.sms_outra_dependencia
ADD CONSTRAINT sod_dep1_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.sms_outra_dependencia
ADD CONSTRAINT sod_pdl_fk FOREIGN KEY (pdl_for_dep_cd_dependencia, 
  pdl_for_nr_cgc_cpf, pdl_lrc_sq_lote)
REFERENCES IFRDBA2.participante_de_licitacao (for_dep_cd_dependencia,for_nr_cgc_cpf,lrc_sq_lote) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.sms_outra_dependencia
ADD CONSTRAINT sod_uor_fk FOREIGN KEY (uo_cd_unid_organ_destino)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_acess_simbep
ADD CONSTRAINT fk01_acesso FOREIGN KEY (oper_cracha_pk)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_acess_simbep
ADD CONSTRAINT fk02_acesso FOREIGN KEY (area_cod_pk)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_acess_simbep
ADD CONSTRAINT fk03_acesso FOREIGN KEY (palm_serie_pk)
REFERENCES IFRDBA2.tab_palm_simbep (palm_serie_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_arfun_simbep
ADD CONSTRAINT fk01_areafunc FOREIGN KEY (loc_cod_pk)
REFERENCES IFRDBA2.tab_local_simbep (loc_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_autmo_simbep
ADD CONSTRAINT fk01_autorizamovim FOREIGN KEY (oper_operador)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_autmo_simbep
ADD CONSTRAINT fk02_autorizamovim FOREIGN KEY (oper_detentor)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_autmo_simbep
ADD CONSTRAINT fk03_autorizamovim FOREIGN KEY (tpmov_cod_pk)
REFERENCES IFRDBA2.tab_tpmov_simbep (tpmov_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_data_limite_orcamento
ADD CONSTRAINT dlo_dependencia_fk FOREIGN KEY (cod_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_eqter_simbep
ADD CONSTRAINT fk01_equipterc FOREIGN KEY (equiter_usu)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_eqter_simbep
ADD CONSTRAINT fk02_equipterc FOREIGN KEY (visi_cracha_pk)
REFERENCES IFRDBA2.tab_visit_simbep (visi_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_eqter_simbep
ADD CONSTRAINT fk03_equipterc FOREIGN KEY (equiter_forn)
REFERENCES IFRDBA2.tab_forne_simbep (forn_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_local_simbep
ADD CONSTRAINT fk01_local FOREIGN KEY (end_cod_pk)
REFERENCES IFRDBA2.tab_ender_simbep (end_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk01_movimento FOREIGN KEY (mov_destusu)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk04_movimento FOREIGN KEY (mov_origusu)
REFERENCES IFRDBA2.tab_opera_simbep (oper_cracha_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk07_movimento FOREIGN KEY (mov_tipomov)
REFERENCES IFRDBA2.tab_tpmov_simbep (tpmov_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk08_movimento FOREIGN KEY (mov_destareaint)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk09_movimento FOREIGN KEY (mov_origareaint)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk10_movimento FOREIGN KEY (mov_destareaext)
REFERENCES IFRDBA2.tab_forne_simbep (forn_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_movim_simbep
ADD CONSTRAINT fk11_movimento FOREIGN KEY (mov_origareaext)
REFERENCES IFRDBA2.tab_forne_simbep (forn_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_opera_simbep
ADD CONSTRAINT fk01_operador FOREIGN KEY (area_cod_pk)
REFERENCES IFRDBA2.tab_arfun_simbep (area_cod_pk) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tab_opera_simbep
ADD CONSTRAINT fk02_operador FOREIGN KEY (func_cod)
REFERENCES IFRDBA2.tab_funop_simbep (func_cod) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_recex_simbep
ADD CONSTRAINT fk01_statusfunc FOREIGN KEY (sta_cod_pk)
REFERENCES IFRDBA2.tab_stfun_simbep (sta_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tab_visit_simbep
ADD CONSTRAINT fk01_fornecod FOREIGN KEY (visi_forn)
REFERENCES IFRDBA2.tab_forne_simbep (forn_cod_pk) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.telef_unidade_organizacional
ADD CONSTRAINT tel_unid_organiz_val_unid_org FOREIGN KEY (
  cod_unidade_organizacional)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.texto_padrao
ADD CONSTRAINT tp_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.texto_padrao
ADD CONSTRAINT tp_mdl_fk FOREIGN KEY (mdl_cd_modalidade)
REFERENCES IFRDBA2.modalidade_licitacao (cd_modalidade) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tipo_deducao_acrescimo
ADD CONSTRAINT tda_evc_fk FOREIGN KEY (evc_nr_evento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tipo_documento_licitacao
ADD CONSTRAINT tdl_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tipo_garantia
ADD CONSTRAINT tga_evcd_fk FOREIGN KEY (nr_evento_devolucao)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tipo_garantia
ADD CONSTRAINT tga_evcr_fk FOREIGN KEY (nr_evento_recebimento)
REFERENCES IFRDBA2.evento_contabil (nr_evento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tipo_material_do_fornecedor
ADD CONSTRAINT tmdf_tmf_fk FOREIGN KEY (tmf_cd_tipo_material_fornecime)
REFERENCES IFRDBA2.tipo_material_fornecimento (cd_tipo_material_fornecimento) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.tipo_material_fornecimento
ADD CONSTRAINT tmf_dep_fk FOREIGN KEY (dep_cd_dependencia)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.tipo_material_fornecimento
ADD CONSTRAINT tmf_scf_fk FOREIGN KEY (scf_cd_sicaf)
REFERENCES IFRDBA2.sicaf (cd_sicaf) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.transfer_bem_patrimonial
ADD CONSTRAINT tbp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
-- Foreign Key
ALTER TABLE ifrdba2.transferencia_itens
ADD CONSTRAINT ti_dep_d_fk FOREIGN KEY (dep_cd_dependencia_dest)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.transferencia_itens
ADD CONSTRAINT ti_dep_o_fk FOREIGN KEY (dep_cd_dependencia_orig)
REFERENCES IFRDBA2.almoxarifados (cd_dependencia) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.unidades_organizacionais
ADD CONSTRAINT uor_dep_fk FOREIGN KEY (uor_dep_codigo)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.unidades_organizacionais
ADD CONSTRAINT uor_dep_vincula_pgto_fk FOREIGN KEY (uor_dep_codigo_vincula_pgto)
REFERENCES IFRDBA2.dependencias (dep_codigo) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.unidades_organizacionais
ADD CONSTRAINT uor_uor_fk FOREIGN KEY (uor_uor_codigo)
REFERENCES IFRDBA2.unidades_organizacionais (uor_codigo) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.valor_carac_bem_patrimonial
ADD CONSTRAINT vcbp_bp_fk FOREIGN KEY (bp_nr_bem, bp_in_uniao)
REFERENCES IFRDBA2.bem_patrimonial (nr_bem,in_uniao) ON DELETE CASCADE
/
ALTER TABLE ifrdba2.valor_carac_bem_patrimonial
ADD CONSTRAINT vcbp_cgp_fk FOREIGN KEY (cgp_gp_cd_grupo, 
  cgp_cp1_cd_caracteristica)
REFERENCES IFRDBA2.carac_grupo_patrimonial (gp_cd_grupo,cp1_cd_caracteristica) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.valor_tarifa_banco
ADD CONSTRAINT vtb_ban_fk FOREIGN KEY (ban_cd_banco)
REFERENCES IFRDBA2.bancoinf (cd_banco) ON DELETE SET NULL
/
ALTER TABLE ifrdba2.valor_tarifa_banco
ADD CONSTRAINT vtb_tab_fk FOREIGN KEY (tab_cd_tarifa_bancaria)
REFERENCES IFRDBA2.tarifa_bancaria (cd_tarifa_bancaria) ON DELETE SET NULL
/
-- Foreign Key
ALTER TABLE ifrdba2.versao_simulacao_proposta_orc
ADD CONSTRAINT vsp_vsp_fk FOREIGN KEY (vsp_nr_ano, vsp_dep_cd_dependencia, 
  vsp_cd_nivel_versao, vsp_cd_versao)
REFERENCES IFRDBA2.versao_simulacao_proposta_orc (nr_ano,dep_cd_dependencia,cd_nivel_versao,cd_versao) ON DELETE SET NULL
/
-- End of DDL script for Foreign Key(s)
