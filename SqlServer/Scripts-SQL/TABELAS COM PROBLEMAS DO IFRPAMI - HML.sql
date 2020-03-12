CREATE TABLE IFRPAMI.sam_matmed_aliquota
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    estado                         VARCHAR2(2),
    aliquota                       NUMBER(10,0),
    generico                       VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.sam_camposmovimentacao
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    campo                          NUMBER(10,0),
    descricao                      VARCHAR2(100),
    geraranalise                   VARCHAR2(1),
    gerarcartao                    VARCHAR2(1),
    replicartitular                VARCHAR2(1),
    ativo                          VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.sam_motivoanalisependencia
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    codigo                         NUMBER(10,0),
    descricao                      VARCHAR2(150),
    analisependecia                VARCHAR2(2),
    ativo                          VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.sam_motivoanalisependencia_doc
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    motivoanalisependencia         NUMBER(10,0),
    documento                      NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.exp_ori_rotina
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    descricao                      VARCHAR2(100),
    tabelaems                      VARCHAR2(1),
    tabelacrd                      VARCHAR2(1),
    tabelaprs                      VARCHAR2(1),
    tabelapco                      VARCHAR2(1),
    tabelapes                      VARCHAR2(1),
    tabelapdm                      VARCHAR2(1),
    tabelaesp                      VARCHAR2(1),
    tabelapde                      VARCHAR2(1),
    tabelausu                      VARCHAR2(1),
    tabelaemp                      VARCHAR2(1),
    tabelapln                      VARCHAR2(1),
    tabeladus                      VARCHAR2(1),
    tabeladpl                      VARCHAR2(1),
    tabeladug                      VARCHAR2(1),
    tabeladpg                      VARCHAR2(1),
    tabeladeg                      VARCHAR2(1),
    tabelagrp                      VARCHAR2(1),
    tabelapgr                      VARCHAR2(1),
    tabelainp                      VARCHAR2(1),
    diretorioexportacao            VARCHAR2(250),
    usuarioinclusao                NUMBER(10,0),
    datahorainclusao               DATE,
    usuarioprocessamento           NUMBER(10,0),
    datahoraprocessamento          DATE,
    status                         VARCHAR2(2),
    ocorrencias                    VARCHAR2(4000),
    codigo                         NUMBER(10,0),
    arquivoexportado               VARCHAR2(100))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.k9_int_situacaorh
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    status                         NUMBER(10,0),
    ocorrencia                     NUMBER(10,0),
    situacaorh                     NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.k9_integracaorh
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    empresa                        NUMBER(10,0),
    convenio                       NUMBER(10,0),
    leiauteimpgestorh              NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.sfn_regrapag_modulo
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    regrapag                       NUMBER(10,0),
    modulo                         NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/

CREATE TABLE IFRPAMI.web_peg
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    cartaremessa                   FLOAT(126),
    protocolo                      NUMBER(10,0),
    dataentrada                    DATE,
    prestador                      NUMBER(10,0),
    situacao                       VARCHAR2(2),
    tissmensagemtiss               NUMBER(10,0),
    ocorrencia                     CLOB)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  LOB ("OCORRENCIA") STORE AS SYS_LOB0000151954C00009$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.web_sam_beneficiario
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    registro                       NUMBER(10,0),
    operacao                       VARCHAR2(2),
    modulo                         VARCHAR2(1),
    matriculafuncional             VARCHAR2(30),
    tipobeneficiario               VARCHAR2(2),
    nome                           VARCHAR2(50),
    sexo                           VARCHAR2(2),
    datanascimento                 DATE,
    estadocivil                    NUMBER(10,0),
    nacionalidade                  NUMBER(10,0),
    dataadmissao                   DATE,
    datamatrimonio                 DATE,
    cpf                            VARCHAR2(11),
    rg                             VARCHAR2(15),
    atividadeprincipal             NUMBER(10,0),
    tipocadastro                   VARCHAR2(2),
    pispasep                       VARCHAR2(11),
    nomemae                        VARCHAR2(50),
    lotacao                        NUMBER(10,0),
    parentesco                     NUMBER(10,0),
    contrato                       NUMBER(10,0),
    familia                        NUMBER(10,0),
    tipodocumento                  VARCHAR2(2),
    documento                      VARCHAR2(50),
    orgaoemissor                   VARCHAR2(15),
    dataemissao                    DATE,
    paisemissor                    NUMBER(10,0),
    uf                             NUMBER(10,0),
    tabaproveitamentocarencia      NUMBER(10,0),
    numerocarteiraantiga           VARCHAR2(50),
    declaracaooperadora            VARCHAR2(100),
    handlebenef                    NUMBER(10,0),
    municipioatendimento           NUMBER(10,0),
    titular                        NUMBER(10,0),
    situacao                       VARCHAR2(2),
    motivosolicitacao              NUMBER(10,0),
    sequencia                      NUMBER(10,0),
    boletimocorrencia              VARCHAR2(100),
    numerodependente               VARCHAR2(2),
    usuarioinclusao                NUMBER(10,0),
    datahorainclusao               DATE,
    datacancelamento               DATE,
    dataatendimentoate             DATE,
    motivocancelamento             NUMBER(10,0),
    beneficiariotitular            NUMBER(10,0),
    permitealterarregistro         VARCHAR2(1),
    dependentesetornoutitular      VARCHAR2(1),
    efetivado                      VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.web_sam_beneficiario_alteracao
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    websambeneficiario             NUMBER(10,0),
    valororiginal                  VARCHAR2(250),
    valornovo                      VARCHAR2(250),
    valorhandle                    NUMBER(10,0),
    usuarioalteracao               NUMBER(10,0),
    datahoraalteracao              DATE,
    campoalterado                  NUMBER(10,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.web_sam_beneficiario_endereco
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    beneficiarioweb                NUMBER(10,0),
    cep                            VARCHAR2(10),
    rua                            VARCHAR2(50),
    numero                         VARCHAR2(10),
    complemento                    VARCHAR2(50),
    bairro                         VARCHAR2(40),
    cidade                         VARCHAR2(50),
    municipio                      NUMBER(10,0),
    uf                             VARCHAR2(2),
    ufmunicipios                   NUMBER(10,0),
    dddresidencial                 VARCHAR2(2),
    prefixoresidencial             VARCHAR2(4),
    sufixoresidencial              VARCHAR2(4),
    dddcomercial                   VARCHAR2(2),
    prefixocomercial               VARCHAR2(4),
    sufixocomercial                VARCHAR2(4))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.web_sam_beneficiario_mod
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    beneficiarioweb                NUMBER(10,0),
    modulo                         NUMBER(10,0),
    obrigatorio                    VARCHAR2(1),
    dataadesao                     DATE,
    operacao                       VARCHAR2(2),
    motivocancelamento             NUMBER(10,0),
    beneficiariomod                NUMBER(10,0),
    datacancelamento               DATE)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/


CREATE TABLE IFRPAMI.web_sam_beneficiario_pendencia
    (handle                         NUMBER(10,0) NOT NULL,
    z_grupo                        NUMBER(10,0),
    beneficiarioweb                NUMBER(10,0),
    analisependencia               NUMBER(10,0),
    observacao                     VARCHAR2(4000),
    status                         VARCHAR2(2),
    usuarioanalise                 NUMBER(10,0),
    datahoraanalise                DATE)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  tsd_benner
  NOCACHE
  MONITORING
  NOPARALLEL
  LOGGING
/







ALTER TABLE ifrpami.web_peg
ADD PRIMARY KEY (handle)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  tsd_benner
/
