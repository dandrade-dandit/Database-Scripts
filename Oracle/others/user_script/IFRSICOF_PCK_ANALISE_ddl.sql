CREATE OR REPLACE PACKAGE ifrsicof.pck_analise
IS
  PROCEDURE PRC_COPIA_VERSAO
             (
              p_NUM_ANO_O                     in       number,
              p_COD_NIVEL_O                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_O  in       number,
              p_COD_VERSAO_O                  in       varchar2,
              p_NUM_ANO_D                     in       number,
              p_COD_NIVEL_D                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_D  in       number,
              p_COD_VERSAO_D                  in       varchar2,
              p_IND_RETORNO                       out  boolean,
              p_DSC_RETORNO                       out  varchar2
             );
  PROCEDURE PRC_GERA_NIVEL
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             );
END pck_ANALISE;
/


CREATE OR REPLACE PACKAGE BODY ifrsicof.pck_analise
IS
--------------------
-- COPIA VERSÃO 1 --
--------------------
  PROCEDURE PRC_COPIA_VERSAO
             (
              p_NUM_ANO_O                     in       number,
              p_COD_NIVEL_O                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_O  in       number,
              p_COD_VERSAO_O                  in       varchar2,
              p_NUM_ANO_D                     in       number,
              p_COD_NIVEL_D                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_D  in       number,
              p_COD_VERSAO_D                  in       varchar2,
              p_IND_RETORNO                       out  boolean,
              p_DSC_RETORNO                       out  varchar2
             )
  IS
  ----------------------
  -- DESPESA / GESTOR --
  ----------------------
  cursor q_IPS
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2
   )
    is
    select ips.COD_DEPENDENCIA_ELABORACAO,
           ips.NR_ITEM,
           ips.DEP_CD_DEPENDENCIA_GERD,
           ips.CC2_CD_CENTRO_CUSTO_GERD,
           ips.FLG_TIPO_CONTA,
           ips.FLG_LANCAMENTO,
           ips.CC1_NR_CONTA,
           ips.DS_ITEM,
           ips.COD_CATALOGO,
           ips.NR_CONTRATO,
           ips.NO_FORNECEDOR,
           ips.DT_INICIO_CONTRATO,
           ips.DT_TERMINO_CONTRATO,
           ips.IND_CONTRATO,
           ips.PRJ_CD_PROJETO,
           ips.DS_JUSTIFICATIVA,
           ips.CD_PRIORIDADE,
           ips.IN_DIMENSIONAMENTO,
           ips.FLG_PLURIANUAL,
           ips.VAL_TOTAL_GESTOR,
           ips.VAL_JAN,
           ips.VAL_FEV,
           ips.VAL_MAR,
           ips.VAL_ABR,
           ips.VAL_MAI,
           ips.VAL_JUN,
           ips.VAL_JUL,
           ips.VAL_AGO,
           ips.VAL_SET,
           ips.VAL_OUT,
           ips.VAL_NOV,
           ips.VAL_DEZ,
           ips.VAL_JAN1,
           ips.VAL_FEV1,
           ips.VAL_MAR1,
           ips.VAL_ABR1,
           ips.VAL_MAI1,
           ips.VAL_JUN1,
           ips.VAL_JUL1,
           ips.VAL_AGO1,
           ips.VAL_SET1,
           ips.VAL_OUT1,
           ips.VAL_NOV1,
           ips.VAL_DEZ1,
           ips.VAL_JAN2,
           ips.VAL_FEV2,
           ips.VAL_MAR2,
           ips.VAL_ABR2,
           ips.VAL_MAI2,
           ips.VAL_JUN2,
           ips.VAL_JUL2,
           ips.VAL_AGO2,
           ips.VAL_SET2,
           ips.VAL_OUT2,
           ips.VAL_NOV2,
           ips.VAL_DEZ2,
           ips.VAL_JAN3,
           ips.VAL_FEV3,
           ips.VAL_MAR3,
           ips.VAL_ABR3,
           ips.VAL_MAI3,
           ips.VAL_JUN3,
           ips.VAL_JUL3,
           ips.VAL_AGO3,
           ips.VAL_SET3,
           ips.VAL_OUT3,
           ips.VAL_NOV3,
           ips.VAL_DEZ3,
           ips.VAL_JAN4,
           ips.VAL_FEV4,
           ips.VAL_MAR4,
           ips.VAL_ABR4,
           ips.VAL_MAI4,
           ips.VAL_JUN4,
           ips.VAL_JUL4,
           ips.VAL_AGO4,
           ips.VAL_SET4,
           ips.VAL_OUT4,
           ips.VAL_NOV4,
           ips.VAL_DEZ4,
           ips.VL_UNITARIO_ITEM,
           ips.QTD_JAN,
           ips.QTD_FEV,
           ips.QTD_MAR,
           ips.QTD_ABR,
           ips.QTD_MAI,
           ips.QTD_JUN,
           ips.QTD_JUL,
           ips.QTD_AGO,
           ips.QTD_SET,
           ips.QTD_OUT,
           ips.QTD_NOV,
           ips.QTD_DEZ,
           ips.VL_UNITARIO_ITEM1,
           ips.QTD_JAN1,
           ips.QTD_FEV1,
           ips.QTD_MAR1,
           ips.QTD_ABR1,
           ips.QTD_MAI1,
           ips.QTD_JUN1,
           ips.QTD_JUL1,
           ips.QTD_AGO1,
           ips.QTD_SET1,
           ips.QTD_OUT1,
           ips.QTD_NOV1,
           ips.QTD_DEZ1,
           ips.VL_UNITARIO_ITEM2,
           ips.QTD_JAN2,
           ips.QTD_FEV2,
           ips.QTD_MAR2,
           ips.QTD_ABR2,
           ips.QTD_MAI2,
           ips.QTD_JUN2,
           ips.QTD_JUL2,
           ips.QTD_AGO2,
           ips.QTD_SET2,
           ips.QTD_OUT2,
           ips.QTD_NOV2,
           ips.QTD_DEZ2,
           ips.VL_UNITARIO_ITEM3,
           ips.QTD_JAN3,
           ips.QTD_FEV3,
           ips.QTD_MAR3,
           ips.QTD_ABR3,
           ips.QTD_MAI3,
           ips.QTD_JUN3,
           ips.QTD_JUL3,
           ips.QTD_AGO3,
           ips.QTD_SET3,
           ips.QTD_OUT3,
           ips.QTD_NOV3,
           ips.QTD_DEZ3,
           ips.VL_UNITARIO_ITEM4,
           ips.QTD_JAN4,
           ips.QTD_FEV4,
           ips.QTD_MAR4,
           ips.QTD_ABR4,
           ips.QTD_MAI4,
           ips.QTD_JUN4,
           ips.QTD_JUL4,
           ips.QTD_AGO4,
           ips.QTD_SET4,
           ips.QTD_OUT4,
           ips.QTD_NOV4,
           ips.QTD_DEZ4,
           ips.SEQ_CARGA_ANO_ORCAMENTO
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where VSP_NR_ANO = p_NUM_ANO_O
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            VSP_CD_VERSAO = p_COD_VERSAO_O;
  v_VAL_TOTAL_GESTOR  number(14,2);
  ---------------------------
  -- DESPESA / SOLICITANTE --
  ---------------------------
  cursor q_ISP
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2,
           p_COD_DEPENDENCIA_ELABORACAO    number,
           p_NR_ITEM                       number
          )
    is
    select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
           isp.COD_DEPENDENCIA_SOLICITANTE,
           isp.COD_CENTRO_CUSTO_SOLICITANTE,
           isp.NUM_CONTA_SOLICITANTE,
           isp.VAL_TOTAL_SOLICITANTE,
           isp.FLG_DIMENSIONAMENTO,
           isp.COD_PROJETO
      from ITEM_SOLICITANTE_PROPOSTA  isp
      where isp.VSP_NR_ANO = p_NUM_ANO_O
            and
            isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            isp.VSP_CD_VERSAO = p_COD_VERSAO_O
            and
            isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
            and
            isp.NR_ITEM = p_NR_ITEM;
  r_ISP  q_ISP%rowtype;
  v_VAL_TOTAL_SOLICITANTE  number(14,2);
  --------------------------------------
  -- DESPESA / SOLICITANTE / SEQUENCE --
  --------------------------------------
  cursor q_ISP_SEQUENCE
    is
    select SEQ_ITEM_SOLICITANTE_PROPOSTA.currval  SEQ_ITEM_SOLICITANTE_PROPOSTA
      from DUAL;
  r_ISP_SEQUENCE  q_ISP_SEQUENCE%rowtype;
  ---------------------------
  -- DESPESA / PROGRAMACAO --
  ---------------------------
  cursor q_PSP
          (
           p_SEQ_ISP  number
          )
    is
    select psp.NUM_ANO,
           psp.VAL_JANEIRO,
           psp.VAL_FEVEREIRO,
           psp.VAL_MARCO,
           psp.VAL_ABRIL,
           psp.VAL_MAIO,
           psp.VAL_JUNHO,
           psp.VAL_JULHO,
           psp.VAL_AGOSTO,
           psp.VAL_SETEMBRO,
           psp.VAL_OUTUBRO,
           psp.VAL_NOVEMBRO,
           psp.VAL_DEZEMBRO,
           psp.VAL_UNITARIO,
           psp.QTD_JANEIRO,
           psp.QTD_FEVEREIRO,
           psp.QTD_MARCO,
           psp.QTD_ABRIL,
           psp.QTD_MAIO,
           psp.QTD_JUNHO,
           psp.QTD_JULHO,
           psp.QTD_AGOSTO,
           psp.QTD_SETEMBRO,
           psp.QTD_OUTUBRO,
           psp.QTD_NOVEMBRO,
           psp.QTD_DEZEMBRO
      from PROGRAMACAO_SOLIC_PROPOSTA  psp
      where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ISP;
  r_PSP  q_PSP%rowtype;
  v_VAL_TOTAL_PROGRAMACAO  number(14,2);
  --------------------------------------
  -- DESPESA / PROGRAMACAO / SEQUENCE --
  --------------------------------------
  cursor q_PSP_SEQUENCE
    is
    select SEQ_PROGRAMACAO_SOLIC_PROPOSTA.currval  SEQ_PROGRAMACAO_SOLIC_PROPOSTA
      from DUAL;
  r_PSP_SEQUENCE  q_PSP_SEQUENCE%rowtype;
  -------------
  -- RECEITA --
  -------------
  cursor q_PRS
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2
          )
    is
    select prs.COD_DEPENDENCIA_ELABORACAO,
           prs.NR_SEQ,
           prs.CC1_NR_CONTA,
           prs.TAR_CD_REGIME,
           prs.VAL_JAN,
           prs.VAL_FEV,
           prs.VAL_MAR,
           prs.VAL_ABR,
           prs.VAL_MAI,
           prs.VAL_JUN,
           prs.VAL_JUL,
           prs.VAL_AGO,
           prs.VAL_SET,
           prs.VAL_OUT,
           prs.VAL_NOV,
           prs.VAL_DEZ,
           prs.VAL_JAN1,
           prs.VAL_FEV1,
           prs.VAL_MAR1,
           prs.VAL_ABR1,
           prs.VAL_MAI1,
           prs.VAL_JUN1,
           prs.VAL_JUL1,
           prs.VAL_AGO1,
           prs.VAL_SET1,
           prs.VAL_OUT1,
           prs.VAL_NOV1,
           prs.VAL_DEZ1,
           prs.VAL_JAN2,
           prs.VAL_FEV2,
           prs.VAL_MAR2,
           prs.VAL_ABR2,
           prs.VAL_MAI2,
           prs.VAL_JUN2,
           prs.VAL_JUL2,
           prs.VAL_AGO2,
           prs.VAL_SET2,
           prs.VAL_OUT2,
           prs.VAL_NOV2,
           prs.VAL_DEZ2,
           prs.VAL_JAN3,
           prs.VAL_FEV3,
           prs.VAL_MAR3,
           prs.VAL_ABR3,
           prs.VAL_MAI3,
           prs.VAL_JUN3,
           prs.VAL_JUL3,
           prs.VAL_AGO3,
           prs.VAL_SET3,
           prs.VAL_OUT3,
           prs.VAL_NOV3,
           prs.VAL_DEZ3,
           prs.VAL_JAN4,
           prs.VAL_FEV4,
           prs.VAL_MAR4,
           prs.VAL_ABR4,
           prs.VAL_MAI4,
           prs.VAL_JUN4,
           prs.VAL_JUL4,
           prs.VAL_AGO4,
           prs.VAL_SET4,
           prs.VAL_OUT4,
           prs.VAL_NOV4,
           prs.VAL_DEZ4
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO_O
            and
            prs.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO_O;
  BEGIN
    p_IND_RETORNO := true;
    --------------------------------
    -- ITEM_PROPOSTA_ORC_SIMULADA --
    --------------------------------
    for f_IPS in q_IPS
                  (
                   p_NUM_ANO_O,
                   p_COD_NIVEL_O,
                   p_COD_DEPENDENCIA_AGRUPADORA_O,
                   p_COD_VERSAO_O
                  )
    LOOP
      v_VAL_TOTAL_GESTOR := f_ips.VAL_TOTAL_GESTOR;
      v_VAL_TOTAL_SOLICITANTE := 0;
      v_VAL_TOTAL_PROGRAMACAO := 0;
      BEGIN
        insert
          into ITEM_PROPOSTA_ORC_SIMULADA
           (
            VSP_NR_ANO,
            VSP_CD_NIVEL_VERSAO,
            COD_DEPENDENCIA_AGRUPADORA,
            VSP_CD_VERSAO,
            COD_DEPENDENCIA_ELABORACAO,
            NR_ITEM,
            DEP_CD_DEPENDENCIA_GERD,
            CC2_CD_CENTRO_CUSTO_GERD,
            FLG_TIPO_CONTA,
            FLG_LANCAMENTO,
            CC1_NR_CONTA,
            DS_ITEM,
            COD_CATALOGO,
            NR_CONTRATO,
            NO_FORNECEDOR,
            DT_INICIO_CONTRATO,
            DT_TERMINO_CONTRATO,
            IND_CONTRATO,
            PRJ_CD_PROJETO,
            DS_JUSTIFICATIVA,
            CD_PRIORIDADE,
            IN_DIMENSIONAMENTO,
            FLG_PLURIANUAL,
            VAL_TOTAL_GESTOR,
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
            VAL_DEZ4,
            VL_UNITARIO_ITEM,
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
            VL_UNITARIO_ITEM1,
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
            VL_UNITARIO_ITEM2,
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
            VL_UNITARIO_ITEM3,
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
            VL_UNITARIO_ITEM4,
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
            SEQ_CARGA_ANO_ORCAMENTO,
            FLG_OPERACAO_INCLUSAO
           )
          values
           (
            p_NUM_ANO_D,
            p_COD_NIVEL_D,
            p_COD_DEPENDENCIA_AGRUPADORA_D,
            p_COD_VERSAO_D,
            f_ips.COD_DEPENDENCIA_ELABORACAO,
            f_ips.NR_ITEM,
            f_ips.DEP_CD_DEPENDENCIA_GERD,
            f_ips.CC2_CD_CENTRO_CUSTO_GERD,
            f_ips.FLG_TIPO_CONTA,
            f_ips.FLG_LANCAMENTO,
            f_ips.CC1_NR_CONTA,
            f_ips.DS_ITEM,
            f_ips.COD_CATALOGO,
            f_ips.NR_CONTRATO,
            f_ips.NO_FORNECEDOR,
            f_ips.DT_INICIO_CONTRATO,
            f_ips.DT_TERMINO_CONTRATO,
            f_ips.IND_CONTRATO,
            f_ips.PRJ_CD_PROJETO,
            f_ips.DS_JUSTIFICATIVA,
            f_ips.CD_PRIORIDADE,
            f_ips.IN_DIMENSIONAMENTO,
            f_ips.FLG_PLURIANUAL,
            f_ips.VAL_TOTAL_GESTOR,
            f_ips.VAL_JAN,
            f_ips.VAL_FEV,
            f_ips.VAL_MAR,
            f_ips.VAL_ABR,
            f_ips.VAL_MAI,
            f_ips.VAL_JUN,
            f_ips.VAL_JUL,
            f_ips.VAL_AGO,
            f_ips.VAL_SET,
            f_ips.VAL_OUT,
            f_ips.VAL_NOV,
            f_ips.VAL_DEZ,
            f_ips.VAL_JAN1,
            f_ips.VAL_FEV1,
            f_ips.VAL_MAR1,
            f_ips.VAL_ABR1,
            f_ips.VAL_MAI1,
            f_ips.VAL_JUN1,
            f_ips.VAL_JUL1,
            f_ips.VAL_AGO1,
            f_ips.VAL_SET1,
            f_ips.VAL_OUT1,
            f_ips.VAL_NOV1,
            f_ips.VAL_DEZ1,
            f_ips.VAL_JAN2,
            f_ips.VAL_FEV2,
            f_ips.VAL_MAR2,
            f_ips.VAL_ABR2,
            f_ips.VAL_MAI2,
            f_ips.VAL_JUN2,
            f_ips.VAL_JUL2,
            f_ips.VAL_AGO2,
            f_ips.VAL_SET2,
            f_ips.VAL_OUT2,
            f_ips.VAL_NOV2,
            f_ips.VAL_DEZ2,
            f_ips.VAL_JAN3,
            f_ips.VAL_FEV3,
            f_ips.VAL_MAR3,
            f_ips.VAL_ABR3,
            f_ips.VAL_MAI3,
            f_ips.VAL_JUN3,
            f_ips.VAL_JUL3,
            f_ips.VAL_AGO3,
            f_ips.VAL_SET3,
            f_ips.VAL_OUT3,
            f_ips.VAL_NOV3,
            f_ips.VAL_DEZ3,
            f_ips.VAL_JAN4,
            f_ips.VAL_FEV4,
            f_ips.VAL_MAR4,
            f_ips.VAL_ABR4,
            f_ips.VAL_MAI4,
            f_ips.VAL_JUN4,
            f_ips.VAL_JUL4,
            f_ips.VAL_AGO4,
            f_ips.VAL_SET4,
            f_ips.VAL_OUT4,
            f_ips.VAL_NOV4,
            f_ips.VAL_DEZ4,
            f_ips.VL_UNITARIO_ITEM,
            f_ips.QTD_JAN,
            f_ips.QTD_FEV,
            f_ips.QTD_MAR,
            f_ips.QTD_ABR,
            f_ips.QTD_MAI,
            f_ips.QTD_JUN,
            f_ips.QTD_JUL,
            f_ips.QTD_AGO,
            f_ips.QTD_SET,
            f_ips.QTD_OUT,
            f_ips.QTD_NOV,
            f_ips.QTD_DEZ,
            f_ips.VL_UNITARIO_ITEM1,
            f_ips.QTD_JAN1,
            f_ips.QTD_FEV1,
            f_ips.QTD_MAR1,
            f_ips.QTD_ABR1,
            f_ips.QTD_MAI1,
            f_ips.QTD_JUN1,
            f_ips.QTD_JUL1,
            f_ips.QTD_AGO1,
            f_ips.QTD_SET1,
            f_ips.QTD_OUT1,
            f_ips.QTD_NOV1,
            f_ips.QTD_DEZ1,
            f_ips.VL_UNITARIO_ITEM2,
            f_ips.QTD_JAN2,
            f_ips.QTD_FEV2,
            f_ips.QTD_MAR2,
            f_ips.QTD_ABR2,
            f_ips.QTD_MAI2,
            f_ips.QTD_JUN2,
            f_ips.QTD_JUL2,
            f_ips.QTD_AGO2,
            f_ips.QTD_SET2,
            f_ips.QTD_OUT2,
            f_ips.QTD_NOV2,
            f_ips.QTD_DEZ2,
            f_ips.VL_UNITARIO_ITEM3,
            f_ips.QTD_JAN3,
            f_ips.QTD_FEV3,
            f_ips.QTD_MAR3,
            f_ips.QTD_ABR3,
            f_ips.QTD_MAI3,
            f_ips.QTD_JUN3,
            f_ips.QTD_JUL3,
            f_ips.QTD_AGO3,
            f_ips.QTD_SET3,
            f_ips.QTD_OUT3,
            f_ips.QTD_NOV3,
            f_ips.QTD_DEZ3,
            f_ips.VL_UNITARIO_ITEM4,
            f_ips.QTD_JAN4,
            f_ips.QTD_FEV4,
            f_ips.QTD_MAR4,
            f_ips.QTD_ABR4,
            f_ips.QTD_MAI4,
            f_ips.QTD_JUN4,
            f_ips.QTD_JUL4,
            f_ips.QTD_AGO4,
            f_ips.QTD_SET4,
            f_ips.QTD_OUT4,
            f_ips.QTD_NOV4,
            f_ips.QTD_DEZ4,
            f_ips.SEQ_CARGA_ANO_ORCAMENTO,
            'C'
           );
      EXCEPTION
        WHEN OTHERS
        THEN
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Tabela ITEM_PROPOSTA_ORC_SIMULADA'||chr(10)||
                           'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                           '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                           '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                           '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                           'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                           '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                           '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                           '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                           'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                           sqlerrm;
        GOTO FIM;
      END;
      ---------------------------
      -- DESPESA / SOLICITANTE --
      ---------------------------
      for f_ISP in q_ISP
                    (
                     p_NUM_ANO_O,
                     p_COD_NIVEL_O,
                     p_COD_DEPENDENCIA_AGRUPADORA_O,
                     p_COD_VERSAO_O,
                     f_ips.COD_DEPENDENCIA_ELABORACAO,
                     f_ips.NR_ITEM
                    )
      LOOP
        v_VAL_TOTAL_SOLICITANTE := v_VAL_TOTAL_SOLICITANTE + f_ISP.VAL_TOTAL_SOLICITANTE;
        BEGIN
          insert
            into ITEM_SOLICITANTE_PROPOSTA
             (
              SEQ_ITEM_SOLICITANTE_PROPOSTA,
              VSP_NR_ANO,
              VSP_CD_NIVEL_VERSAO,
              COD_DEPENDENCIA_AGRUPADORA,
              VSP_CD_VERSAO,
              COD_DEPENDENCIA_ELABORACAO,
              NR_ITEM,
              COD_DEPENDENCIA_SOLICITANTE,
              COD_CENTRO_CUSTO_SOLICITANTE,
              NUM_CONTA_SOLICITANTE,
              VAL_TOTAL_SOLICITANTE,
              FLG_DIMENSIONAMENTO,
              COD_PROJETO
             )
            values
             (
              SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
              p_NUM_ANO_D,
              p_COD_NIVEL_D,
              p_COD_DEPENDENCIA_AGRUPADORA_D,
              p_COD_VERSAO_D,
              f_ips.COD_DEPENDENCIA_ELABORACAO,
              f_ips.NR_ITEM,
              f_isp.COD_DEPENDENCIA_SOLICITANTE,
              f_isp.COD_CENTRO_CUSTO_SOLICITANTE,
              f_isp.NUM_CONTA_SOLICITANTE,
              f_isp.VAL_TOTAL_SOLICITANTE,
              f_isp.FLG_DIMENSIONAMENTO,
              f_isp.COD_PROJETO
             );
        EXCEPTION
          WHEN OTHERS
          THEN
            open q_ISP_SEQUENCE;
            fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
            close q_ISP_SEQUENCE;
            p_IND_RETORNO := false;
            p_DSC_RETORNO := 'Tabela ITEM_SOLICITANTE_PROPOSTA '||chr(10)||
                             'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                             '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                             '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                             '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                             'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                             '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                             '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                             '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                             'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                             'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                             'Sequência Solicitante....: '||r_ISP_SEQUENCE.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                             sqlerrm;
          GOTO FIM;
        END;
        ---------------------------
        -- DESPESA / PROGRAMACAO --
        ---------------------------
        for f_PSP in q_PSP
                      (
                       f_isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
                      )
        LOOP
          v_VAL_TOTAL_PROGRAMACAO := v_VAL_TOTAL_PROGRAMACAO + f_psp.VAL_JANEIRO
                                                             + f_psp.VAL_FEVEREIRO
                                                             + f_psp.VAL_MARCO
                                                             + f_psp.VAL_ABRIL
                                                             + f_psp.VAL_MAIO
                                                             + f_psp.VAL_JUNHO
                                                             + f_psp.VAL_JULHO
                                                             + f_psp.VAL_AGOSTO
                                                             + f_psp.VAL_SETEMBRO
                                                             + f_psp.VAL_OUTUBRO
                                                             + f_psp.VAL_NOVEMBRO
                                                             + f_psp.VAL_DEZEMBRO;
          BEGIN
            insert
              into PROGRAMACAO_SOLIC_PROPOSTA
               (
                SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                SEQ_ITEM_SOLICITANTE_PROPOSTA,
                NUM_ANO,
                VAL_JANEIRO,
                VAL_FEVEREIRO,
                VAL_MARCO,
                VAL_ABRIL,
                VAL_MAIO,
                VAL_JUNHO,
                VAL_JULHO,
                VAL_AGOSTO,
                VAL_SETEMBRO,
                VAL_OUTUBRO,
                VAL_NOVEMBRO,
                VAL_DEZEMBRO,
                VAL_UNITARIO,
                QTD_JANEIRO,
                QTD_FEVEREIRO,
                QTD_MARCO,
                QTD_ABRIL,
                QTD_MAIO,
                QTD_JUNHO,
                QTD_JULHO,
                QTD_AGOSTO,
                QTD_SETEMBRO,
                QTD_OUTUBRO,
                QTD_NOVEMBRO,
                QTD_DEZEMBRO
               )
              values
               (
                SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                SEQ_ITEM_SOLICITANTE_PROPOSTA.currval,
                f_psp.NUM_ANO,
                f_psp.VAL_JANEIRO,
                f_psp.VAL_FEVEREIRO,
                f_psp.VAL_MARCO,
                f_psp.VAL_ABRIL,
                f_psp.VAL_MAIO,
                f_psp.VAL_JUNHO,
                f_psp.VAL_JULHO,
                f_psp.VAL_AGOSTO,
                f_psp.VAL_SETEMBRO,
                f_psp.VAL_OUTUBRO,
                f_psp.VAL_NOVEMBRO,
                f_psp.VAL_DEZEMBRO,
                f_psp.VAL_UNITARIO,
                f_psp.QTD_JANEIRO,
                f_psp.QTD_FEVEREIRO,
                f_psp.QTD_MARCO,
                f_psp.QTD_ABRIL,
                f_psp.QTD_MAIO,
                f_psp.QTD_JUNHO,
                f_psp.QTD_JULHO,
                f_psp.QTD_AGOSTO,
                f_psp.QTD_SETEMBRO,
                f_psp.QTD_OUTUBRO,
                f_psp.QTD_NOVEMBRO,
                f_psp.QTD_DEZEMBRO
               );
          EXCEPTION
            WHEN OTHERS
            THEN
              open q_ISP_SEQUENCE;
              fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
              close q_ISP_SEQUENCE;
              open q_PSP_SEQUENCE;
              fetch q_PSP_SEQUENCE into r_PSP_SEQUENCE;
              close q_PSP_SEQUENCE;
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'Tabela PROGRAMACAO_SOLIC_PROPOSTA '||chr(10)||
                               'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                               '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                               '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                               '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                               'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                               '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                               '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                               '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                               'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                               'Sequência Solicitante....: '||r_ISP_SEQUENCE.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                               'Sequência Solicitante....: '||r_PSP_SEQUENCE.SEQ_PROGRAMACAO_SOLIC_PROPOSTA||chr(10)||
                               sqlerrm;
            GOTO FIM;
          END;
        END LOOP f_PSP;
      END LOOP f_ISP;
      IF v_VAL_TOTAL_GESTOR <> v_VAL_TOTAL_SOLICITANTE
         or
         v_VAL_TOTAL_SOLICITANTE <> v_VAL_TOTAL_PROGRAMACAO
      THEN
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Ocorreu uma inconsistência na distribuição: '||chr(10)||
                         'Valor Total Gestor      : '||ltrim(to_char(v_VAL_TOTAL_GESTOR,'9g999g999g990d00'))||chr(10)||
                         'Valor Total Solicitante : '||ltrim(to_char(v_VAL_TOTAL_SOLICITANTE,'9g999g999g990d00'))||chr(10)||
                         'Valor Total Programado  : '||ltrim(to_char(v_VAL_TOTAL_PROGRAMACAO,'9g999g999g990d00'))||chr(10)||
                         'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                         '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                         '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                         '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                         'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                         'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                         SQLERRM;
        GOTO FIM;
      END IF;
    END LOOP r_IPS;
    -------------------------------
    -- PROJECAO_RECEITA_SIMULADA --
    -------------------------------
    for f_PRS in q_PRS
                  (
                   p_NUM_ANO_O,
                   p_COD_NIVEL_O,
                   p_COD_DEPENDENCIA_AGRUPADORA_O,
                   p_COD_VERSAO_O
                  )
    LOOP
      BEGIN
        insert
          into PROJECAO_RECEITA_SIMULADA
           (
            VSP_NR_ANO,
            VSP_CD_NIVEL_VERSAO,
            COD_DEPENDENCIA_AGRUPADORA,
            VSP_CD_VERSAO,
            COD_DEPENDENCIA_ELABORACAO,
            NR_SEQ,
            CC1_NR_CONTA,
            TAR_CD_REGIME,
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
          values
           (
            p_NUM_ANO_D,
            p_COD_NIVEL_D,
            p_COD_DEPENDENCIA_AGRUPADORA_D,
            p_COD_VERSAO_D,
            f_prs.COD_DEPENDENCIA_ELABORACAO,
            f_prs.NR_SEQ,
            f_prs.CC1_NR_CONTA,
            f_prs.TAR_CD_REGIME,
            f_prs.VAL_JAN,
            f_prs.VAL_FEV,
            f_prs.VAL_MAR,
            f_prs.VAL_ABR,
            f_prs.VAL_MAI,
            f_prs.VAL_JUN,
            f_prs.VAL_JUL,
            f_prs.VAL_AGO,
            f_prs.VAL_SET,
            f_prs.VAL_OUT,
            f_prs.VAL_NOV,
            f_prs.VAL_DEZ,
            f_prs.VAL_JAN1,
            f_prs.VAL_FEV1,
            f_prs.VAL_MAR1,
            f_prs.VAL_ABR1,
            f_prs.VAL_MAI1,
            f_prs.VAL_JUN1,
            f_prs.VAL_JUL1,
            f_prs.VAL_AGO1,
            f_prs.VAL_SET1,
            f_prs.VAL_OUT1,
            f_prs.VAL_NOV1,
            f_prs.VAL_DEZ1,
            f_prs.VAL_JAN2,
            f_prs.VAL_FEV2,
            f_prs.VAL_MAR2,
            f_prs.VAL_ABR2,
            f_prs.VAL_MAI2,
            f_prs.VAL_JUN2,
            f_prs.VAL_JUL2,
            f_prs.VAL_AGO2,
            f_prs.VAL_SET2,
            f_prs.VAL_OUT2,
            f_prs.VAL_NOV2,
            f_prs.VAL_DEZ2,
            f_prs.VAL_JAN3,
            f_prs.VAL_FEV3,
            f_prs.VAL_MAR3,
            f_prs.VAL_ABR3,
            f_prs.VAL_MAI3,
            f_prs.VAL_JUN3,
            f_prs.VAL_JUL3,
            f_prs.VAL_AGO3,
            f_prs.VAL_SET3,
            f_prs.VAL_OUT3,
            f_prs.VAL_NOV3,
            f_prs.VAL_DEZ3,
            f_prs.VAL_JAN4,
            f_prs.VAL_FEV4,
            f_prs.VAL_MAR4,
            f_prs.VAL_ABR4,
            f_prs.VAL_MAI4,
            f_prs.VAL_JUN4,
            f_prs.VAL_JUL4,
            f_prs.VAL_AGO4,
            f_prs.VAL_SET4,
            f_prs.VAL_OUT4,
            f_prs.VAL_NOV4,
            f_prs.VAL_DEZ4
           );
      EXCEPTION
        WHEN OTHERS
        THEN
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Tabela PROJECAO_RECEITA_SIMULADA '||chr(10)||
                           'Origem Ano...............: '||p_NUM_ANO_O||chr(10)||
                           '       Nível.............: '||p_COD_NIVEL_O||chr(10)||
                           '       Dep.Agrupadora....: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                           '       Versão............: '||p_COD_VERSAO_O||chr(10)||
                           'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                           '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                           '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                           '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                           'Dep.Elaboração...........: '||f_prs.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Sequencia................: '||f_prs.NR_SEQ||chr(10)||
                           SQLERRM;
          GOTO FIM;
      END;
    END LOOP;
    <<FIM>>
    null;
  END PRC_COPIA_VERSAO;
-------------------------
-- GERA NÍVEL/VERSÃO 1 --
-------------------------
  PROCEDURE PRC_GERA_NIVEL
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             )
  IS
    ------------------------------
    -- DEPENDENCIA + VINCULADAS --
    ------------------------------
    cursor q_DEP
            (
             p_NUM_ANO                     number,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vdep.DEP_CODIGO  DEP_CODIGO
        from VW_DEPENDENCIA_SICOF  vdep
        where vdep.NUM_ANO = p_NUM_ANO
              and
              vdep.DEP_CODIGO
                in
                (
                 select dep.DEP_CODIGO
                   from DEPENDENCIAS  dep
                   connect by prior dep.DEP_CODIGO = dep.DEP_DEP_CODIGO
                   start with dep.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
                );
    ------------------------------------------
    -- DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
    ------------------------------------------
    cursor q_DEP_VSP_NAO_ESCOLHIDA
            (
             p_NUM_ANO                     number,
             p_COD_NIVEL                   varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vdep.DEP_CODIGO  DEP_CODIGO
        from VW_DEPENDENCIA_SICOF  vdep
        where vdep.NUM_ANO = p_NUM_ANO
              and
              exists
               (
                select NULL
                  from DEPENDENCIAS  dep1
                  where dep1.DEP_CODIGO = vdep.DEP_CODIGO
                  connect by prior dep1.DEP_CODIGO = dep1.DEP_DEP_CODIGO
                  start with dep1.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
               )
      minus
      select vsp.DEP_CD_DEPENDENCIA  DEP_CODIGO
        from VERSAO_SIMULACAO_PROPOSTA_ORC  vsp
        where vsp.NR_ANO = p_NUM_ANO
              and
              vsp.CD_NIVEL_VERSAO = p_COD_NIVEL
              and
              exists
               (
                select NULL
                  from DEPENDENCIAS  dep2
                  where dep2.DEP_CODIGO = vsp.DEP_CD_DEPENDENCIA
                  connect by prior dep2.DEP_CODIGO = dep2.DEP_DEP_CODIGO
                  start with dep2.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
               )
              and
              vsp.IN_ESCOLHIDA = 1;
    --
    r_DEP_VSP_NAO_ESCOLHIDA  q_DEP_VSP_NAO_ESCOLHIDA%rowtype;
    l_DEP_VSP_NAO_ESCOLHIDA  boolean;
    --
    ----------------------
    -- VERSÃO ESCOLHIDA --
    ----------------------
    cursor q_VSP
            (
             p_NUM_ANO                     number,
             p_COD_NIVEL                   varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vsp.CD_VERSAO  CD_VERSAO
        from VERSAO_SIMULACAO_PROPOSTA_ORC  vsp
        where vsp.NR_ANO = p_NUM_ANO
              and
              vsp.CD_NIVEL_VERSAO = p_COD_NIVEL
              and
              vsp.DEP_CD_DEPENDENCIA = p_COD_DEPENDENCIA_AGRUPADORA
              and
              vsp.IN_ESCOLHIDA = 1;
    --
    r_VSP_GERACAO    q_VSP%rowtype;
    l_VSP_GERACAO    boolean;
  ------------------------------------------------------
  -- DESPESA / GESTOR / VERIFICAÇÃO DE QUANTIDADE = 0 --
  ------------------------------------------------------
  cursor q_IPS_QUANTIDADE
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select count(*)  QTD_DESPESA
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where ips.VSP_NR_ANO = p_NUM_ANO
            and
            ips.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            ips.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            ips.VSP_CD_VERSAO = p_COD_VERSAO;
  r_IPS_QUANTIDADE  q_IPS_QUANTIDADE%rowtype;
  --------------------------------
  -- DESPESA / GESTOR / GERAÇÃO --
  --------------------------------
  cursor q_IPS
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
   )
    is
    select ips.COD_DEPENDENCIA_ELABORACAO,
           ips.NR_ITEM,
           ips.DEP_CD_DEPENDENCIA_GERD,
           ips.CC2_CD_CENTRO_CUSTO_GERD,
           ips.FLG_TIPO_CONTA,
           ips.FLG_LANCAMENTO,
           ips.CC1_NR_CONTA,
           ips.DS_ITEM,
           ips.COD_CATALOGO,
           ips.NR_CONTRATO,
           ips.NO_FORNECEDOR,
           ips.DT_INICIO_CONTRATO,
           ips.DT_TERMINO_CONTRATO,
           ips.IND_CONTRATO,
           ips.PRJ_CD_PROJETO,
           ips.DS_JUSTIFICATIVA,
           ips.CD_PRIORIDADE,
           ips.IN_DIMENSIONAMENTO,
           ips.FLG_PLURIANUAL,
           ips.VAL_TOTAL_GESTOR,
           ips.VAL_JAN,
           ips.VAL_FEV,
           ips.VAL_MAR,
           ips.VAL_ABR,
           ips.VAL_MAI,
           ips.VAL_JUN,
           ips.VAL_JUL,
           ips.VAL_AGO,
           ips.VAL_SET,
           ips.VAL_OUT,
           ips.VAL_NOV,
           ips.VAL_DEZ,
           ips.VAL_JAN1,
           ips.VAL_FEV1,
           ips.VAL_MAR1,
           ips.VAL_ABR1,
           ips.VAL_MAI1,
           ips.VAL_JUN1,
           ips.VAL_JUL1,
           ips.VAL_AGO1,
           ips.VAL_SET1,
           ips.VAL_OUT1,
           ips.VAL_NOV1,
           ips.VAL_DEZ1,
           ips.VAL_JAN2,
           ips.VAL_FEV2,
           ips.VAL_MAR2,
           ips.VAL_ABR2,
           ips.VAL_MAI2,
           ips.VAL_JUN2,
           ips.VAL_JUL2,
           ips.VAL_AGO2,
           ips.VAL_SET2,
           ips.VAL_OUT2,
           ips.VAL_NOV2,
           ips.VAL_DEZ2,
           ips.VAL_JAN3,
           ips.VAL_FEV3,
           ips.VAL_MAR3,
           ips.VAL_ABR3,
           ips.VAL_MAI3,
           ips.VAL_JUN3,
           ips.VAL_JUL3,
           ips.VAL_AGO3,
           ips.VAL_SET3,
           ips.VAL_OUT3,
           ips.VAL_NOV3,
           ips.VAL_DEZ3,
           ips.VAL_JAN4,
           ips.VAL_FEV4,
           ips.VAL_MAR4,
           ips.VAL_ABR4,
           ips.VAL_MAI4,
           ips.VAL_JUN4,
           ips.VAL_JUL4,
           ips.VAL_AGO4,
           ips.VAL_SET4,
           ips.VAL_OUT4,
           ips.VAL_NOV4,
           ips.VAL_DEZ4,
           ips.VL_UNITARIO_ITEM,
           ips.QTD_JAN,
           ips.QTD_FEV,
           ips.QTD_MAR,
           ips.QTD_ABR,
           ips.QTD_MAI,
           ips.QTD_JUN,
           ips.QTD_JUL,
           ips.QTD_AGO,
           ips.QTD_SET,
           ips.QTD_OUT,
           ips.QTD_NOV,
           ips.QTD_DEZ,
           ips.VL_UNITARIO_ITEM1,
           ips.QTD_JAN1,
           ips.QTD_FEV1,
           ips.QTD_MAR1,
           ips.QTD_ABR1,
           ips.QTD_MAI1,
           ips.QTD_JUN1,
           ips.QTD_JUL1,
           ips.QTD_AGO1,
           ips.QTD_SET1,
           ips.QTD_OUT1,
           ips.QTD_NOV1,
           ips.QTD_DEZ1,
           ips.VL_UNITARIO_ITEM2,
           ips.QTD_JAN2,
           ips.QTD_FEV2,
           ips.QTD_MAR2,
           ips.QTD_ABR2,
           ips.QTD_MAI2,
           ips.QTD_JUN2,
           ips.QTD_JUL2,
           ips.QTD_AGO2,
           ips.QTD_SET2,
           ips.QTD_OUT2,
           ips.QTD_NOV2,
           ips.QTD_DEZ2,
           ips.VL_UNITARIO_ITEM3,
           ips.QTD_JAN3,
           ips.QTD_FEV3,
           ips.QTD_MAR3,
           ips.QTD_ABR3,
           ips.QTD_MAI3,
           ips.QTD_JUN3,
           ips.QTD_JUL3,
           ips.QTD_AGO3,
           ips.QTD_SET3,
           ips.QTD_OUT3,
           ips.QTD_NOV3,
           ips.QTD_DEZ3,
           ips.VL_UNITARIO_ITEM4,
           ips.QTD_JAN4,
           ips.QTD_FEV4,
           ips.QTD_MAR4,
           ips.QTD_ABR4,
           ips.QTD_MAI4,
           ips.QTD_JUN4,
           ips.QTD_JUL4,
           ips.QTD_AGO4,
           ips.QTD_SET4,
           ips.QTD_OUT4,
           ips.QTD_NOV4,
           ips.QTD_DEZ4,
           ips.SEQ_CARGA_ANO_ORCAMENTO
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            VSP_CD_VERSAO = p_COD_VERSAO;
  v_VAL_TOTAL_GESTOR  number(14,2);
  ---------------------------
  -- DESPESA / SOLICITANTE --
  ---------------------------
  cursor q_ISP
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2,
           p_COD_DEPENDENCIA_ELABORACAO  number,
           p_NR_ITEM                     number
          )
    is
    select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
           isp.COD_DEPENDENCIA_SOLICITANTE,
           isp.COD_CENTRO_CUSTO_SOLICITANTE,
           isp.NUM_CONTA_SOLICITANTE,
           isp.VAL_TOTAL_SOLICITANTE,
           isp.FLG_DIMENSIONAMENTO,
           isp.COD_PROJETO
      from ITEM_SOLICITANTE_PROPOSTA  isp
      where isp.VSP_NR_ANO = p_NUM_ANO
            and
            isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            isp.VSP_CD_VERSAO = p_COD_VERSAO
            and
            isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
            and
            isp.NR_ITEM = p_NR_ITEM;
  r_ISP  q_ISP%rowtype;
  v_VAL_TOTAL_SOLICITANTE  number(14,2);
  --------------------------------------
  -- DESPESA / SOLICITANTE / SEQUENCE --
  --------------------------------------
  cursor q_ISP_SEQUENCE
    is
    select SEQ_ITEM_SOLICITANTE_PROPOSTA.currval  SEQ_ITEM_SOLICITANTE_PROPOSTA
      from DUAL;
  r_ISP_SEQUENCE  q_ISP_SEQUENCE%rowtype;
  ---------------------------
  -- DESPESA / PROGRAMACAO --
  ---------------------------
  cursor q_PSP
          (
           p_SEQ_ISP  number
          )
    is
    select psp.NUM_ANO,
           psp.VAL_JANEIRO,
           psp.VAL_FEVEREIRO,
           psp.VAL_MARCO,
           psp.VAL_ABRIL,
           psp.VAL_MAIO,
           psp.VAL_JUNHO,
           psp.VAL_JULHO,
           psp.VAL_AGOSTO,
           psp.VAL_SETEMBRO,
           psp.VAL_OUTUBRO,
           psp.VAL_NOVEMBRO,
           psp.VAL_DEZEMBRO,
           psp.VAL_UNITARIO,
           psp.QTD_JANEIRO,
           psp.QTD_FEVEREIRO,
           psp.QTD_MARCO,
           psp.QTD_ABRIL,
           psp.QTD_MAIO,
           psp.QTD_JUNHO,
           psp.QTD_JULHO,
           psp.QTD_AGOSTO,
           psp.QTD_SETEMBRO,
           psp.QTD_OUTUBRO,
           psp.QTD_NOVEMBRO,
           psp.QTD_DEZEMBRO
      from PROGRAMACAO_SOLIC_PROPOSTA  psp
      where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ISP;
  r_PSP  q_PSP%rowtype;
  v_VAL_TOTAL_PROGRAMACAO  number(14,2);
  --------------------------------------
  -- DESPESA / PROGRAMACAO / SEQUENCE --
  --------------------------------------
  cursor q_PSP_SEQUENCE
    is
    select SEQ_PROGRAMACAO_SOLIC_PROPOSTA.currval  SEQ_PROGRAMACAO_SOLIC_PROPOSTA
      from DUAL;
  r_PSP_SEQUENCE  q_PSP_SEQUENCE%rowtype;
  ---------------------------------------------
  -- RECEITA / VERIFICAÇÃO DE QUANTIDADE = 0 --
  ---------------------------------------------
  cursor q_PRS_QUANTIDADE
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select count(*)  QTD_RECEITA
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO
            and
            prs.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO;
  r_PRS_QUANTIDADE  q_PRS_QUANTIDADE%rowtype;
  -------------
  -- RECEITA --
  -------------
  cursor q_PRS
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select prs.COD_DEPENDENCIA_ELABORACAO,
           prs.NR_SEQ,
           prs.CC1_NR_CONTA,
           prs.TAR_CD_REGIME,
           prs.VAL_JAN,
           prs.VAL_FEV,
           prs.VAL_MAR,
           prs.VAL_ABR,
           prs.VAL_MAI,
           prs.VAL_JUN,
           prs.VAL_JUL,
           prs.VAL_AGO,
           prs.VAL_SET,
           prs.VAL_OUT,
           prs.VAL_NOV,
           prs.VAL_DEZ,
           prs.VAL_JAN1,
           prs.VAL_FEV1,
           prs.VAL_MAR1,
           prs.VAL_ABR1,
           prs.VAL_MAI1,
           prs.VAL_JUN1,
           prs.VAL_JUL1,
           prs.VAL_AGO1,
           prs.VAL_SET1,
           prs.VAL_OUT1,
           prs.VAL_NOV1,
           prs.VAL_DEZ1,
           prs.VAL_JAN2,
           prs.VAL_FEV2,
           prs.VAL_MAR2,
           prs.VAL_ABR2,
           prs.VAL_MAI2,
           prs.VAL_JUN2,
           prs.VAL_JUL2,
           prs.VAL_AGO2,
           prs.VAL_SET2,
           prs.VAL_OUT2,
           prs.VAL_NOV2,
           prs.VAL_DEZ2,
           prs.VAL_JAN3,
           prs.VAL_FEV3,
           prs.VAL_MAR3,
           prs.VAL_ABR3,
           prs.VAL_MAI3,
           prs.VAL_JUN3,
           prs.VAL_JUL3,
           prs.VAL_AGO3,
           prs.VAL_SET3,
           prs.VAL_OUT3,
           prs.VAL_NOV3,
           prs.VAL_DEZ3,
           prs.VAL_JAN4,
           prs.VAL_FEV4,
           prs.VAL_MAR4,
           prs.VAL_ABR4,
           prs.VAL_MAI4,
           prs.VAL_JUN4,
           prs.VAL_JUL4,
           prs.VAL_AGO4,
           prs.VAL_SET4,
           prs.VAL_OUT4,
           prs.VAL_NOV4,
           prs.VAL_DEZ4
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO
            and
            prs.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO;
  BEGIN
    p_IND_RETORNO := true;
    ------------------------------------------------
    -- PASSO 01 - EXCLUSÃO DE DESPESA/PROGRAMAÇÃO --
    ------------------------------------------------
    delete
      from PROGRAMACAO_SOLIC_PROPOSTA
      where SEQ_ITEM_SOLICITANTE_PROPOSTA
            in
            (
             select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
               from ITEM_SOLICITANTE_PROPOSTA isp
               where isp.VSP_NR_ANO = p_NUM_ANO
                     and
                     isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
                     and
                     isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            );
    ------------------------------------------------
    -- PASSO 02 - EXCLUSÃO DE DESPESA/SOLICITANTE --
    ------------------------------------------------
    delete
      from ITEM_SOLICITANTE_PROPOSTA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    -------------------------------------------
    -- PASSO 03 - EXCLUSÃO DE DESPESA/GESTOR --
    -------------------------------------------
    delete
      from ITEM_PROPOSTA_ORC_SIMULADA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    ------------------------------------
    -- PASSO 04 - EXCLUSÃO DE RECEITA --
    ------------------------------------
    delete
      from PROJECAO_RECEITA_SIMULADA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    -----------------------------------------------------
    -- PASSO 05 - EXCLUSÃO DE CONTROLE DE NÍVEL/VERSÃO --
    -----------------------------------------------------
    delete
      from VERSAO_SIMULACAO_PROPOSTA_ORC
      where NR_ANO = p_NUM_ANO
            and
            CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            DEP_CD_DEPENDENCIA = p_COD_DEPENDENCIA_AGRUPADORA;
    --------------------------------------------------------------------
    -- PASSO 02 - VERIFICAÇÃO DE DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
    --------------------------------------------------------------------
    l_DEP_VSP_NAO_ESCOLHIDA := FALSE;
    for f_DEP_VSP_NAO_ESCOLHIDA in q_DEP_VSP_NAO_ESCOLHIDA
                                    (
                                     p_NUM_ANO,
                                     p_COD_NIVEL-1,
                                     p_COD_DEPENDENCIA_AGRUPADORA
                                    )
    LOOP
      ----------------------------------------------------------------
      -- PASSO 03 - OBTENÇÃO DA LISTA DE DEPENDÊNCIAS PARA MENSAGEM --
      ----------------------------------------------------------------
      IF     l_DEP_VSP_NAO_ESCOLHIDA = FALSE
      THEN
        l_DEP_VSP_NAO_ESCOLHIDA := true;
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'A(s) dependência(s):  ';
        p_DSC_RETORNO := p_DSC_RETORNO ||f_DEP_VSP_NAO_ESCOLHIDA.DEP_CODIGO;
      ELSIF  l_DEP_VSP_NAO_ESCOLHIDA = TRUE
      THEN
        p_DSC_RETORNO := p_DSC_RETORNO ||','||f_DEP_VSP_NAO_ESCOLHIDA.DEP_CODIGO;
      END IF;
    END LOOP;
    IF l_DEP_VSP_NAO_ESCOLHIDA = TRUE
    THEN
      p_DSC_RETORNO := p_DSC_RETORNO ||' não está(ão) escolhida(s).';
      GOTO FIM;
    END IF;
    --------------------------------------------------------------
    -- PASSO 05 - CRIA NÍVEL/VERSÃO EM CADASTRO DE NÍVEL/VERSÃO --
    --------------------------------------------------------------
    BEGIN
      insert into VERSAO_SIMULACAO_PROPOSTA_ORC
       (
        NR_ANO,
        CD_NIVEL_VERSAO,
        DEP_CD_DEPENDENCIA,
        CD_VERSAO,
        DS_VERSAO,
        VSP_NR_ANO,
        VSP_CD_NIVEL_VERSAO,
        VSP_DEP_CD_DEPENDENCIA,
        VSP_CD_VERSAO,
        IN_ESCOLHIDA,
        IN_LIBERADA
       )
      values
       (
        p_NUM_ANO,
        p_COD_NIVEL,
        p_COD_DEPENDENCIA_AGRUPADORA,
        '1',
        'GERAÇÃO DE NÍVEL',
        null,
        null,
        null,
        null,
        0,
        0
       );
    --------------------------------------
    -- PASSO 06 - INTERRUPÇÃO POR FALHA --
    --------------------------------------
    EXCEPTION
      WHEN OTHERS
      THEN
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Tabela VERSAO_SIMULACAO_PROPOSTA_ORC : '||CHR(10)||
                         sqlerrm;
        GOTO FIM;
    END;
    ------------------------------------------------------
    -- PASSO 07 - DEPENDENCIA + VINCULADAS PARA GERAÇÃO --
    ------------------------------------------------------
    for f_DEP_GERACAO in q_DEP
                          (
                           p_NUM_ANO,
                           p_COD_DEPENDENCIA_AGRUPADORA
                          )
    LOOP
      -------------------------------------------------
      -- PASSO 08 - PESQUISA DE VERSÃO NÃO ESCOLHIDA --
      -------------------------------------------------
      open q_VSP
            (
             p_NUM_ANO,
             p_COD_NIVEL-1,
             f_DEP_GERACAO.DEP_CODIGO
            );
      fetch q_VSP into r_VSP_GERACAO;
      l_VSP_GERACAO := q_VSP%found;
      close q_VSP;
      -----------------------------------------------------
      -- PASSO 09 - DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
      -----------------------------------------------------
      IF not l_VSP_GERACAO
      THEN
        --------------------------------------
        -- PASSO 10 - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'A dependência '||f_DEP_GERACAO.DEP_CODIGO||' não foi escolhida.';
        GOTO FIM;
      END IF;
      ------------------------------------------------------
      -- DESPESA / GESTOR / VERIFICAÇÃO DE QUANTIDADE = 0 --
      ------------------------------------------------------
      open q_IPS_QUANTIDADE
            (
             p_NUM_ANO,
             p_COD_NIVEL-1,
             f_dep_geracao.DEP_CODIGO,
             r_vsp_geracao.CD_VERSAO
            );
      fetch q_IPS_QUANTIDADE into r_IPS_QUANTIDADE;
      close q_IPS_QUANTIDADE;
      IF r_IPS_QUANTIDADE.QTD_DESPESA = 0
      THEN
        --------------------------------------
        -- PASSO XX - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Despesa inexistente para :'||chr(10)||
	                 '   Ano.........: '||p_NUM_ANO||chr(10)||
                         '   Nível.......: '||to_char(p_COD_NIVEL-1)||chr(10)||
	                 '   Dependência.: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                         '   Versão......: '||r_vsp_geracao.CD_VERSAO||'.';
        GOTO FIM;
      END IF;
      --------------------------------------------
      -- PASSO 11 - GERAÇÃO DE DESPESA / GESTOR --
      --------------------------------------------
      v_VAL_TOTAL_GESTOR := 0;
      for f_IPS in q_IPS
                    (
                     p_NUM_ANO,
                     p_COD_NIVEL-1,
                     f_dep_geracao.DEP_CODIGO,
                     r_vsp_geracao.CD_VERSAO
                    )
      LOOP
        v_VAL_TOTAL_SOLICITANTE := 0;
        v_VAL_TOTAL_PROGRAMACAO := 0;
        v_VAL_TOTAL_GESTOR := f_ips.VAL_TOTAL_GESTOR;
        BEGIN
          insert
            into ITEM_PROPOSTA_ORC_SIMULADA
             (
              VSP_NR_ANO,
              VSP_CD_NIVEL_VERSAO,
              COD_DEPENDENCIA_AGRUPADORA,
              VSP_CD_VERSAO,
              COD_DEPENDENCIA_ELABORACAO,
              NR_ITEM,
              DEP_CD_DEPENDENCIA_GERD,
              CC2_CD_CENTRO_CUSTO_GERD,
              FLG_TIPO_CONTA,
              FLG_LANCAMENTO,
              CC1_NR_CONTA,
              DS_ITEM,
              COD_CATALOGO,
              NR_CONTRATO,
              NO_FORNECEDOR,
              DT_INICIO_CONTRATO,
              DT_TERMINO_CONTRATO,
              IND_CONTRATO,
              PRJ_CD_PROJETO,
              DS_JUSTIFICATIVA,
              CD_PRIORIDADE,
              IN_DIMENSIONAMENTO,
              FLG_PLURIANUAL,
              VAL_TOTAL_GESTOR,
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
              VAL_DEZ4,
              VL_UNITARIO_ITEM,
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
              VL_UNITARIO_ITEM1,
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
              VL_UNITARIO_ITEM2,
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
              VL_UNITARIO_ITEM3,
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
              VL_UNITARIO_ITEM4,
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
              SEQ_CARGA_ANO_ORCAMENTO,
              FLG_OPERACAO_INCLUSAO
             )
            values
             (
              p_NUM_ANO,
              p_COD_NIVEL,
              p_COD_DEPENDENCIA_AGRUPADORA,
              '1',
              f_ips.COD_DEPENDENCIA_ELABORACAO,
              f_ips.NR_ITEM,
              f_ips.DEP_CD_DEPENDENCIA_GERD,
              f_ips.CC2_CD_CENTRO_CUSTO_GERD,
              f_ips.FLG_TIPO_CONTA,
              f_ips.FLG_LANCAMENTO,
              f_ips.CC1_NR_CONTA,
              f_ips.DS_ITEM,
              f_ips.COD_CATALOGO,
              f_ips.NR_CONTRATO,
              f_ips.NO_FORNECEDOR,
              f_ips.DT_INICIO_CONTRATO,
              f_ips.DT_TERMINO_CONTRATO,
              f_ips.IND_CONTRATO,
              f_ips.PRJ_CD_PROJETO,
              f_ips.DS_JUSTIFICATIVA,
              f_ips.CD_PRIORIDADE,
              f_ips.IN_DIMENSIONAMENTO,
              f_ips.FLG_PLURIANUAL,
              f_ips.VAL_TOTAL_GESTOR,
              f_ips.VAL_JAN,
              f_ips.VAL_FEV,
              f_ips.VAL_MAR,
              f_ips.VAL_ABR,
              f_ips.VAL_MAI,
              f_ips.VAL_JUN,
              f_ips.VAL_JUL,
              f_ips.VAL_AGO,
              f_ips.VAL_SET,
              f_ips.VAL_OUT,
              f_ips.VAL_NOV,
              f_ips.VAL_DEZ,
              f_ips.VAL_JAN1,
              f_ips.VAL_FEV1,
              f_ips.VAL_MAR1,
              f_ips.VAL_ABR1,
              f_ips.VAL_MAI1,
              f_ips.VAL_JUN1,
              f_ips.VAL_JUL1,
              f_ips.VAL_AGO1,
              f_ips.VAL_SET1,
              f_ips.VAL_OUT1,
              f_ips.VAL_NOV1,
              f_ips.VAL_DEZ1,
              f_ips.VAL_JAN2,
              f_ips.VAL_FEV2,
              f_ips.VAL_MAR2,
              f_ips.VAL_ABR2,
              f_ips.VAL_MAI2,
              f_ips.VAL_JUN2,
              f_ips.VAL_JUL2,
              f_ips.VAL_AGO2,
              f_ips.VAL_SET2,
              f_ips.VAL_OUT2,
              f_ips.VAL_NOV2,
              f_ips.VAL_DEZ2,
              f_ips.VAL_JAN3,
              f_ips.VAL_FEV3,
              f_ips.VAL_MAR3,
              f_ips.VAL_ABR3,
              f_ips.VAL_MAI3,
              f_ips.VAL_JUN3,
              f_ips.VAL_JUL3,
              f_ips.VAL_AGO3,
              f_ips.VAL_SET3,
              f_ips.VAL_OUT3,
              f_ips.VAL_NOV3,
              f_ips.VAL_DEZ3,
              f_ips.VAL_JAN4,
              f_ips.VAL_FEV4,
              f_ips.VAL_MAR4,
              f_ips.VAL_ABR4,
              f_ips.VAL_MAI4,
              f_ips.VAL_JUN4,
              f_ips.VAL_JUL4,
              f_ips.VAL_AGO4,
              f_ips.VAL_SET4,
              f_ips.VAL_OUT4,
              f_ips.VAL_NOV4,
              f_ips.VAL_DEZ4,
              f_ips.VL_UNITARIO_ITEM,
              f_ips.QTD_JAN,
              f_ips.QTD_FEV,
              f_ips.QTD_MAR,
              f_ips.QTD_ABR,
              f_ips.QTD_MAI,
              f_ips.QTD_JUN,
              f_ips.QTD_JUL,
              f_ips.QTD_AGO,
              f_ips.QTD_SET,
              f_ips.QTD_OUT,
              f_ips.QTD_NOV,
              f_ips.QTD_DEZ,
              f_ips.VL_UNITARIO_ITEM1,
              f_ips.QTD_JAN1,
              f_ips.QTD_FEV1,
              f_ips.QTD_MAR1,
              f_ips.QTD_ABR1,
              f_ips.QTD_MAI1,
              f_ips.QTD_JUN1,
              f_ips.QTD_JUL1,
              f_ips.QTD_AGO1,
              f_ips.QTD_SET1,
              f_ips.QTD_OUT1,
              f_ips.QTD_NOV1,
              f_ips.QTD_DEZ1,
              f_ips.VL_UNITARIO_ITEM2,
              f_ips.QTD_JAN2,
              f_ips.QTD_FEV2,
              f_ips.QTD_MAR2,
              f_ips.QTD_ABR2,
              f_ips.QTD_MAI2,
              f_ips.QTD_JUN2,
              f_ips.QTD_JUL2,
              f_ips.QTD_AGO2,
              f_ips.QTD_SET2,
              f_ips.QTD_OUT2,
              f_ips.QTD_NOV2,
              f_ips.QTD_DEZ2,
              f_ips.VL_UNITARIO_ITEM3,
              f_ips.QTD_JAN3,
              f_ips.QTD_FEV3,
              f_ips.QTD_MAR3,
              f_ips.QTD_ABR3,
              f_ips.QTD_MAI3,
              f_ips.QTD_JUN3,
              f_ips.QTD_JUL3,
              f_ips.QTD_AGO3,
              f_ips.QTD_SET3,
              f_ips.QTD_OUT3,
              f_ips.QTD_NOV3,
              f_ips.QTD_DEZ3,
              f_ips.VL_UNITARIO_ITEM4,
              f_ips.QTD_JAN4,
              f_ips.QTD_FEV4,
              f_ips.QTD_MAR4,
              f_ips.QTD_ABR4,
              f_ips.QTD_MAI4,
              f_ips.QTD_JUN4,
              f_ips.QTD_JUL4,
              f_ips.QTD_AGO4,
              f_ips.QTD_SET4,
              f_ips.QTD_OUT4,
              f_ips.QTD_NOV4,
              f_ips.QTD_DEZ4,
              f_ips.SEQ_CARGA_ANO_ORCAMENTO,
              'N'
             );
        EXCEPTION
          WHEN OTHERS
          THEN
            --------------------------------------------
            -- PASSO 12 - INTERRUPÇÃO - ERRO DE DADOS --
            --------------------------------------------
            p_IND_RETORNO := false;
            p_DSC_RETORNO := 'Tabela ITEM_PROPOSTA_ORC_SIMULADA'||chr(10)||
                             'Ano..............: '||p_NUM_ANO||chr(10)||
                             'Nível............: '||p_COD_NIVEL||chr(10)||
                             'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                             'Versão...........: '||'1'||chr(10)||
                             'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                             'Sequencia Item...: '||f_ips.NR_ITEM||chr(10)||
                             sqlerrm;
          GOTO FIM;
        END;
        -------------------------------------------------
        -- PASSO 13 - GERAÇÃO DE DESPESA / SOLICITANTE --
        -------------------------------------------------
        for f_ISP in q_ISP
                      (
		       p_NUM_ANO,
                       p_COD_NIVEL-1,
                       f_dep_geracao.DEP_CODIGO,
                       r_vsp_geracao.CD_VERSAO,
                       f_ips.COD_DEPENDENCIA_ELABORACAO,
                       f_ips.NR_ITEM
                      )
        LOOP
          v_VAL_TOTAL_SOLICITANTE := v_VAL_TOTAL_SOLICITANTE + f_ISP.VAL_TOTAL_SOLICITANTE;
          BEGIN
            insert
              into ITEM_SOLICITANTE_PROPOSTA
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA,
                VSP_NR_ANO,
                VSP_CD_NIVEL_VERSAO,
                COD_DEPENDENCIA_AGRUPADORA,
                VSP_CD_VERSAO,
                COD_DEPENDENCIA_ELABORACAO,
                NR_ITEM,
                COD_DEPENDENCIA_SOLICITANTE,
                COD_CENTRO_CUSTO_SOLICITANTE,
                NUM_CONTA_SOLICITANTE,
                VAL_TOTAL_SOLICITANTE,
                FLG_DIMENSIONAMENTO,
                COD_PROJETO
               )
              values
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
                p_NUM_ANO,
                p_COD_NIVEL,
                p_COD_DEPENDENCIA_AGRUPADORA,
                '1',
                f_ips.COD_DEPENDENCIA_ELABORACAO,
                f_ips.NR_ITEM,
                f_isp.COD_DEPENDENCIA_SOLICITANTE,
                f_isp.COD_CENTRO_CUSTO_SOLICITANTE,
                f_isp.NUM_CONTA_SOLICITANTE,
                f_isp.VAL_TOTAL_SOLICITANTE,
                f_isp.FLG_DIMENSIONAMENTO,
                f_isp.COD_PROJETO
               );
          EXCEPTION
            WHEN OTHERS
            THEN
              open q_ISP_SEQUENCE;
              fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
              close q_ISP_SEQUENCE;
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'Tabela ITEM_SOLICITANTE_PROPOSTA '||chr(10)||
                               'Ano...................: '||p_NUM_ANO||chr(10)||
                               'Nível.................: '||p_COD_NIVEL||chr(10)||
                               'Dep.Agrupadora........: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                               'Versão................: '||'1'||chr(10)||
                               'Dep.Elaboração........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Sequencia Item........: '||f_ips.NR_ITEM||chr(10)||
                               'Sequência Solicitante.: '||r_isp_sequence.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                               sqlerrm;
            GOTO FIM;
          END;
          ---------------------------
          -- DESPESA / PROGRAMACAO --
          ---------------------------
          for f_PSP in q_PSP
                        (
                         f_isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
                        )
          LOOP
            v_VAL_TOTAL_PROGRAMACAO := v_VAL_TOTAL_PROGRAMACAO + f_psp.VAL_JANEIRO
                                                               + f_psp.VAL_FEVEREIRO
                                                               + f_psp.VAL_MARCO
                                                               + f_psp.VAL_ABRIL
                                                               + f_psp.VAL_MAIO
                                                               + f_psp.VAL_JUNHO
                                                               + f_psp.VAL_JULHO
                                                               + f_psp.VAL_AGOSTO
                                                               + f_psp.VAL_SETEMBRO
                                                               + f_psp.VAL_OUTUBRO
                                                               + f_psp.VAL_NOVEMBRO
                                                               + f_psp.VAL_DEZEMBRO;
            BEGIN
              insert
                into PROGRAMACAO_SOLIC_PROPOSTA
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  NUM_ANO,
                  VAL_JANEIRO,
                  VAL_FEVEREIRO,
                  VAL_MARCO,
                  VAL_ABRIL,
                  VAL_MAIO,
                  VAL_JUNHO,
                  VAL_JULHO,
                  VAL_AGOSTO,
                  VAL_SETEMBRO,
                  VAL_OUTUBRO,
                  VAL_NOVEMBRO,
                  VAL_DEZEMBRO,
                  VAL_UNITARIO,
                  QTD_JANEIRO,
                  QTD_FEVEREIRO,
                  QTD_MARCO,
                  QTD_ABRIL,
                  QTD_MAIO,
                  QTD_JUNHO,
                  QTD_JULHO,
                  QTD_AGOSTO,
                  QTD_SETEMBRO,
                  QTD_OUTUBRO,
                  QTD_NOVEMBRO,
                  QTD_DEZEMBRO
                 )
                values
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.currval,
                  f_psp.NUM_ANO,
                  f_psp.VAL_JANEIRO,
                  f_psp.VAL_FEVEREIRO,
                  f_psp.VAL_MARCO,
                  f_psp.VAL_ABRIL,
                  f_psp.VAL_MAIO,
                  f_psp.VAL_JUNHO,
                  f_psp.VAL_JULHO,
                  f_psp.VAL_AGOSTO,
                  f_psp.VAL_SETEMBRO,
                  f_psp.VAL_OUTUBRO,
                  f_psp.VAL_NOVEMBRO,
                  f_psp.VAL_DEZEMBRO,
                  f_psp.VAL_UNITARIO,
                  f_psp.QTD_JANEIRO,
                  f_psp.QTD_FEVEREIRO,
                  f_psp.QTD_MARCO,
                  f_psp.QTD_ABRIL,
                  f_psp.QTD_MAIO,
                  f_psp.QTD_JUNHO,
                  f_psp.QTD_JULHO,
                  f_psp.QTD_AGOSTO,
                  f_psp.QTD_SETEMBRO,
                  f_psp.QTD_OUTUBRO,
                  f_psp.QTD_NOVEMBRO,
                  f_psp.QTD_DEZEMBRO
                 );
            EXCEPTION
              WHEN OTHERS
              THEN
                open q_ISP_SEQUENCE;
                fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
                close q_ISP_SEQUENCE;
                open q_PSP_SEQUENCE;
                fetch q_PSP_SEQUENCE into r_PSP_SEQUENCE;
                close q_PSP_SEQUENCE;
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Tabela PROGRAMACAO_SOLIC_PROPOSTA '||chr(10)||
                                 'Ano....................: '||p_NUM_ANO||chr(10)||
                                 'Nível..................: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora.........: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão.................: '||'1'||chr(10)||
                                 'Dep.Elaboração.........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Sequencia Item.........: '||f_ips.NR_ITEM||chr(10)||
                                 'Sequência Solicitante..: '||r_isp_sequence.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                                 'Sequência Programação..: '||r_psp_sequence.SEQ_PROGRAMACAO_SOLIC_PROPOSTA||chr(10)||
                                 sqlerrm;
                GOTO FIM;
            END;
          END LOOP f_PSP;
        END LOOP f_ISP;
        IF v_VAL_TOTAL_GESTOR <> v_VAL_TOTAL_SOLICITANTE
           or
           v_VAL_TOTAL_SOLICITANTE <> v_VAL_TOTAL_PROGRAMACAO
        THEN
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Ocorreu uma inconsistência na distribuição: '||chr(10)||
                           'Valor Total Gestor.......: '||ltrim(to_char(v_VAL_TOTAL_GESTOR     ,'9g999g999g990d00'))||chr(10)||
                           'Valor Total Solicitante..: '||ltrim(to_char(v_VAL_TOTAL_SOLICITANTE,'9g999g999g990d00'))||chr(10)||
                           'Valor Total Programado...: '||ltrim(to_char(v_VAL_TOTAL_PROGRAMACAO,'9g999g999g990d00'))||chr(10)||
                           'Ano......................: '||p_NUM_ANO||chr(10)||
                           'Nível....................: '||p_COD_NIVEL||chr(10)||
                           'Dep.Agrupadora...........: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                           'Versão...................: '||'1'||chr(10)||
                           'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                           sqlerrm;
          GOTO FIM;
        END IF;
      END LOOP r_IPS;
      ---------------------------------------------
      -- RECEITA / VERIFICAÇÃO DE QUANTIDADE = 0 --
      ---------------------------------------------
      open q_PRS_QUANTIDADE
            (
             p_NUM_ANO,
             p_COD_NIVEL-1,
             f_dep_geracao.DEP_CODIGO,
             r_vsp_geracao.CD_VERSAO
            );
      fetch q_PRS_QUANTIDADE into r_PRS_QUANTIDADE;
      close q_PRS_QUANTIDADE;
      IF r_PRS_QUANTIDADE.QTD_RECEITA = 0
      THEN
        --------------------------------------
        -- PASSO XX - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Receita inexistente para :'||chr(10)||
	                 '   Ano.........: '||p_NUM_ANO||chr(10)||
                         '   Nível.......: '||to_char(p_COD_NIVEL-1)||chr(10)||
	                 '   Dependência.: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                         '   Versão......: '||r_vsp_geracao.CD_VERSAO||'.';
        GOTO FIM;
      END IF;
      -------------------------------
      -- PROJECAO_RECEITA_SIMULADA --
      -------------------------------
      for f_PRS in q_PRS
                    (
                     p_NUM_ANO,
                     p_COD_NIVEL-1,
                     f_dep_geracao.DEP_CODIGO,
                     r_vsp_geracao.CD_VERSAO
                    )
      LOOP
        BEGIN
          insert
            into PROJECAO_RECEITA_SIMULADA
             (
              VSP_NR_ANO,
              VSP_CD_NIVEL_VERSAO,
              COD_DEPENDENCIA_AGRUPADORA,
              VSP_CD_VERSAO,
              COD_DEPENDENCIA_ELABORACAO,
              NR_SEQ,
              CC1_NR_CONTA,
              TAR_CD_REGIME,
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
            values
             (
              p_NUM_ANO,
              p_COD_NIVEL,
              p_COD_DEPENDENCIA_AGRUPADORA,
              '1',
              f_prs.COD_DEPENDENCIA_ELABORACAO,
              f_prs.NR_SEQ,
              f_prs.CC1_NR_CONTA,
              f_prs.TAR_CD_REGIME,
              f_prs.VAL_JAN,
              f_prs.VAL_FEV,
              f_prs.VAL_MAR,
              f_prs.VAL_ABR,
              f_prs.VAL_MAI,
              f_prs.VAL_JUN,
              f_prs.VAL_JUL,
              f_prs.VAL_AGO,
              f_prs.VAL_SET,
              f_prs.VAL_OUT,
              f_prs.VAL_NOV,
              f_prs.VAL_DEZ,
              f_prs.VAL_JAN1,
              f_prs.VAL_FEV1,
              f_prs.VAL_MAR1,
              f_prs.VAL_ABR1,
              f_prs.VAL_MAI1,
              f_prs.VAL_JUN1,
              f_prs.VAL_JUL1,
              f_prs.VAL_AGO1,
              f_prs.VAL_SET1,
              f_prs.VAL_OUT1,
              f_prs.VAL_NOV1,
              f_prs.VAL_DEZ1,
              f_prs.VAL_JAN2,
              f_prs.VAL_FEV2,
              f_prs.VAL_MAR2,
              f_prs.VAL_ABR2,
              f_prs.VAL_MAI2,
              f_prs.VAL_JUN2,
              f_prs.VAL_JUL2,
              f_prs.VAL_AGO2,
              f_prs.VAL_SET2,
              f_prs.VAL_OUT2,
              f_prs.VAL_NOV2,
              f_prs.VAL_DEZ2,
              f_prs.VAL_JAN3,
              f_prs.VAL_FEV3,
              f_prs.VAL_MAR3,
              f_prs.VAL_ABR3,
              f_prs.VAL_MAI3,
              f_prs.VAL_JUN3,
              f_prs.VAL_JUL3,
              f_prs.VAL_AGO3,
              f_prs.VAL_SET3,
              f_prs.VAL_OUT3,
              f_prs.VAL_NOV3,
              f_prs.VAL_DEZ3,
              f_prs.VAL_JAN4,
              f_prs.VAL_FEV4,
              f_prs.VAL_MAR4,
              f_prs.VAL_ABR4,
              f_prs.VAL_MAI4,
              f_prs.VAL_JUN4,
              f_prs.VAL_JUL4,
              f_prs.VAL_AGO4,
              f_prs.VAL_SET4,
              f_prs.VAL_OUT4,
              f_prs.VAL_NOV4,
              f_prs.VAL_DEZ4
             );
        EXCEPTION
          WHEN OTHERS
          THEN
            p_IND_RETORNO := false;
            p_DSC_RETORNO := 'Tabela PROJECAO_RECEITA_SIMULADA'||chr(10)||
                             'Ano..............: '||p_NUM_ANO||chr(10)||
                             'Nível............: '||p_COD_NIVEL||chr(10)||
                             'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                             'Versão...........: '||'1'||chr(10)||
                             'Dep.Elaboração...: '||f_prs.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                             'Sequencia........: '||f_prs.NR_SEQ||chr(10)||
                             sqlerrm;
          GOTO FIM;
        END;
      END LOOP f_PRS;
    END LOOP f_DEP_GERACAO;
    <<FIM>>
    null;
  END PRC_GERA_NIVEL;
END PCK_ANALISE;
/


GRANT EXECUTE ON IFRSICOF.PCK_ANALISE TO ORC_GER_GERAL;
GRANT EXECUTE ON IFRSICOF.PCK_ANALISE TO ORC_GER_ORC;

CREATE PUBLIC SYNONYM PCK_ANALISE FOR IFRSICOF.PCK_ANALISE;

