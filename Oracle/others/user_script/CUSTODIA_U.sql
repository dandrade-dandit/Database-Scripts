CREATE TABLE custodia_u
    (cd_dependencia                 CHAR(5) NOT NULL,
    nu_operacao                    CHAR(5) NOT NULL,
    tp_operacao                    CHAR(1) NOT NULL,
    cd_depositante                 CHAR(14) NOT NULL,
    localidade_depositante         CHAR(3) NOT NULL,
    nm_depositante                 CHAR(50) NOT NULL,
    cd_gestor                      CHAR(10) NOT NULL,
    nm_gestor                      CHAR(40) NOT NULL,
    dt_operacao                    DATE NOT NULL,
    dt_vencimento                  DATE NOT NULL,
    dt_devolucao                   DATE NOT NULL,
    vl_custodia                    NUMBER(13,2) NOT NULL,
    nu_documento                   CHAR(20) NOT NULL,
    nu_ope_endossado               CHAR(20) NOT NULL,
    cd_origem                      CHAR(3) NOT NULL,
    nm_origem                      CHAR(50) NOT NULL,
    observacao                     CHAR(50) NOT NULL,
    st_custodia                    CHAR(1) NOT NULL,
    nu_edital                      CHAR(20) NOT NULL,
    nu_contrato                    CHAR(30) NOT NULL,
    cd_tp_garantia                 CHAR(3) NOT NULL,
    id_seguradora                  CHAR(3) NOT NULL,
    nm_segurador                   CHAR(50) NOT NULL,
    end_seguradora                 CHAR(40) NOT NULL,
    cid_seguradora                 CHAR(40) NOT NULL,
    uf_seguradora                  CHAR(2) NOT NULL,
    cep_seguradora                 CHAR(12) NOT NULL,
    cd_banco                       CHAR(3) NOT NULL,
    nm_banco                       CHAR(40) NOT NULL,
    end_banco                      CHAR(40) NOT NULL,
    cid_banco                      CHAR(40) NOT NULL,
    uf_banco                       CHAR(2) NOT NULL,
    cep_banco                      CHAR(12) NOT NULL,
    vl_operacao                    NUMBER(13,2) NOT NULL,
    vl_correcao_ant                NUMBER(13,2) NOT NULL,
    vl_correcao_mes                NUMBER(13,2) NOT NULL,
    irrf_20                        NUMBER(13,2) NOT NULL,
    vl_devolucao                   NUMBER(13,2) NOT NULL,
    cd_titulo                      CHAR(3) NOT NULL,
    nm_titulo                      CHAR(50) NOT NULL,
    cd_corretora                   CHAR(3) NOT NULL,
    nm_corretora                   CHAR(50) NOT NULL,
    end_corretora                  CHAR(40) NOT NULL,
    cid_corretora                  CHAR(40) NOT NULL,
    uf_corretora                   CHAR(2) NOT NULL,
    cep_corretora                  CHAR(12) NOT NULL,
    cd_garantidor                  CHAR(14) NOT NULL,
    nm_garantidor                  CHAR(40) NOT NULL,
    end_garantidor                 CHAR(40) NOT NULL,
    cid_garantidor                 CHAR(40) NOT NULL,
    uf_garantidor                  CHAR(2) NOT NULL,
    cep_garantidor                 CHAR(12) NOT NULL,
    cd_banco_pre                   CHAR(3) NOT NULL,
    nm_banco_pre                   CHAR(40) NOT NULL,
    cd_agencia_pre                 CHAR(7) NOT NULL,
    nm_agencia_pre                 CHAR(30) NOT NULL,
    nu_cta_corrente                CHAR(17) NOT NULL,
    end_agencia_pre                CHAR(40) NOT NULL,
    cid_agencia_pre                CHAR(40) NOT NULL,
    uf_agencia_pre                 CHAR(2) NOT NULL,
    cep_agencia_pre                CHAR(12) NOT NULL,
    flg_ult_operacao               CHAR(1) NOT NULL,
    chgstamp                       NUMBER(2,0) NOT NULL)
/


COMMENT ON COLUMN custodia_u.cd_agencia_pre IS 'CODIGO DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.cd_banco IS 'CODIGO DO BANCO'
/
COMMENT ON COLUMN custodia_u.cd_banco_pre IS 'CODIGO DO BANCO PRE'
/
COMMENT ON COLUMN custodia_u.cd_corretora IS 'CODIGO DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.cd_dependencia IS 'CODIGO DA DEPENDENCIA'
/
COMMENT ON COLUMN custodia_u.cd_depositante IS 'CODIGO DO DEPOSITANTE (FORNECEDOR)'
/
COMMENT ON COLUMN custodia_u.cd_garantidor IS 'CODIGO DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.cd_gestor IS 'CODIGO DO GESTOR (UNIDADE ORGANIZACIONAL)'
/
COMMENT ON COLUMN custodia_u.cd_origem IS 'CODIGO DO DOCUMENTO DE ORIGEM'
/
COMMENT ON COLUMN custodia_u.cd_titulo IS 'CODIGO DO TITULO'
/
COMMENT ON COLUMN custodia_u.cd_tp_garantia IS 'CODIGO DO TIPO DE GARANTIA'
/
COMMENT ON COLUMN custodia_u.cep_agencia_pre IS 'CEP DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.cep_banco IS 'CEP DO BANCO'
/
COMMENT ON COLUMN custodia_u.cep_corretora IS 'CEP DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.cep_garantidor IS 'CEP DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.cep_seguradora IS 'CEP DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.chgstamp IS 'CONTROLE DE QTDE DE ALTERACOES DO REGISTRO'
/
COMMENT ON COLUMN custodia_u.cid_agencia_pre IS 'CIDADE DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.cid_banco IS 'CIDADE DO BANCO'
/
COMMENT ON COLUMN custodia_u.cid_corretora IS 'CIDADE DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.cid_garantidor IS 'CIDADE DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.cid_seguradora IS 'CIDADE DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.dt_devolucao IS 'DATA DE DEVOLUCAO'
/
COMMENT ON COLUMN custodia_u.dt_operacao IS 'DATA DA OPERACAO'
/
COMMENT ON COLUMN custodia_u.dt_vencimento IS 'DATA DE VENCIMENTO'
/
COMMENT ON COLUMN custodia_u.end_agencia_pre IS 'ENDERECO DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.end_banco IS 'ENDERECO DO BANCO'
/
COMMENT ON COLUMN custodia_u.end_corretora IS 'ENDERECO DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.end_garantidor IS 'ENDERECO DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.end_seguradora IS 'ENDERECO DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.flg_ult_operacao IS 'FLAG DA ULTIMA OPERACAO'
/
COMMENT ON COLUMN custodia_u.id_seguradora IS 'ID DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.irrf_20 IS 'IRRF'
/
COMMENT ON COLUMN custodia_u.localidade_depositante IS 'LOCALIDADE DO FORNECEDOR'
/
COMMENT ON COLUMN custodia_u.nm_agencia_pre IS 'NOME DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.nm_banco IS 'NOME DO BANCO'
/
COMMENT ON COLUMN custodia_u.nm_banco_pre IS 'NOME DO BANCO PRE'
/
COMMENT ON COLUMN custodia_u.nm_corretora IS 'NOME DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.nm_depositante IS 'NOME DO DEPOSITANTE'
/
COMMENT ON COLUMN custodia_u.nm_garantidor IS 'NOME DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.nm_gestor IS 'NOME DO GESTOR'
/
COMMENT ON COLUMN custodia_u.nm_origem IS 'DOCUMENTO DE ORIGEM'
/
COMMENT ON COLUMN custodia_u.nm_segurador IS 'NOME DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.nm_titulo IS 'NOME DO TITULO'
/
COMMENT ON COLUMN custodia_u.nu_contrato IS 'NUMERO DO CONTRATO'
/
COMMENT ON COLUMN custodia_u.nu_cta_corrente IS 'NUMERO DA CONTA PRE'
/
COMMENT ON COLUMN custodia_u.nu_documento IS 'NUMERO DO DOCUMENTO'
/
COMMENT ON COLUMN custodia_u.nu_edital IS 'NUMERO DO EDITAL'
/
COMMENT ON COLUMN custodia_u.nu_ope_endossado IS 'NUMERO DA OPERACAO ENDOSSADA'
/
COMMENT ON COLUMN custodia_u.nu_operacao IS 'NUMERO DA OPERACAO'
/
COMMENT ON COLUMN custodia_u.observacao IS 'OBSERVACAO'
/
COMMENT ON COLUMN custodia_u.st_custodia IS 'STATUS DA GARANTIA'
/
COMMENT ON COLUMN custodia_u.tp_operacao IS 'TIPO DA OPERACAO'
/
COMMENT ON COLUMN custodia_u.uf_agencia_pre IS 'UF DA AGENCIA PRE'
/
COMMENT ON COLUMN custodia_u.uf_banco IS 'UF DO BANCO'
/
COMMENT ON COLUMN custodia_u.uf_corretora IS 'UF DA CORRETORA'
/
COMMENT ON COLUMN custodia_u.uf_garantidor IS 'UF DO GARANTIDOR'
/
COMMENT ON COLUMN custodia_u.uf_seguradora IS 'UF DA SEGURADORA'
/
COMMENT ON COLUMN custodia_u.vl_correcao_ant IS 'VALOR DA CORRECAO ANTERIOR'
/
COMMENT ON COLUMN custodia_u.vl_correcao_mes IS 'VALOR DA CORRECAO DO MES'
/
COMMENT ON COLUMN custodia_u.vl_custodia IS 'VALOR DA CUSTODIA'
/
COMMENT ON COLUMN custodia_u.vl_devolucao IS 'VALOR DA DEVOLUCAO'
/
COMMENT ON COLUMN custodia_u.vl_operacao IS 'VALOR DA OPERACAO'
/

