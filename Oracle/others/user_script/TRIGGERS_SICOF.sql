-- Start of DDL Script for Trigger IFRSICOF.IPS_TRG_02
-- Generated 26/9/2005 16:23:14 from IFRSICOF@homolog

CREATE OR REPLACE TRIGGER ifrsicof.ips_trg_02
 BEFORE
  INSERT OR UPDATE
 ON ifrsicof.item_proposta_orc_simulada
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  --------------------------
  -- DEPENDENCIAS / CHAVE --
  --------------------------
  cursor q_DEP
          (
           p_DEP_CD_DEPENDENCIA   number
          )
    is
    select DEP.CD_DEPENDENCIA_CHAVE
      from DEPENDENCIAS  DEP
      where DEP_CODIGO = p_DEP_CD_DEPENDENCIA;
  r_DEP  q_DEP%rowtype;
  --------------------------
  -- CENTRO_CUSTO / CHAVE --
  --------------------------
  cursor q_CC2
          (
           p_CC2_CD_CENTRO_CUSTO  number
          )
    is
    select CC2.CD_CENTRO_CUSTO_CHAVE
      from CENTRO_CUSTO CC2
      where CC2.CD_CENTRO_CUSTO = p_CC2_CD_CENTRO_CUSTO;
  r_CC2  q_CC2%rowtype;
  ----------------------------
  -- CONTA_CONTABIL / CHAVE --
  ----------------------------
  cursor q_CC1
          (
           p_CC1_NR_CONTA  varchar2
          )
    is
    select CC1.NR_CONTA_CHAVE
      from CONTA_CONTABIL  CC1
      where CC1.NR_CONTA = p_CC1_NR_CONTA;
  r_CC1  q_CC1%rowtype;
  ---------------------
  -- PROJETO / CHAVE --
  ---------------------
  cursor q_PRJ
          (
           p_PRJ_CD_PROJETO  varchar2
          )
    is
    select PRJ.CD_PROJETO_CHAVE
      from PROJETO  PRJ
      where PRJ.CD_PROJETO = p_PRJ_CD_PROJETO  ;
  r_PRJ  q_PRJ%rowtype;
  ------------------------------
  -- COMBINACAO_CHAVE / CHAVE --
  ------------------------------
  cursor q_CCH
          (
           p_NOM_CHAVE_DEPENDENCIA     varchar2,
           p_NOM_CHAVE_CENTRO_CUSTO    varchar2, 
           p_NOM_CHAVE_CONTA_CONTABIL  varchar2,
           p_NOM_CHAVE_PROJETO         varchar2
          )
    is
    select '1'
      from COMBINACAO_CHAVE CCH
      where NOM_CHAVE_DEPENDENCIA = p_NOM_CHAVE_DEPENDENCIA
            and
            (
             p_NOM_CHAVE_CENTRO_CUSTO is not null
             and
             NOM_CHAVE_CENTRO_CUSTO = p_NOM_CHAVE_CENTRO_CUSTO
             or 
             p_NOM_CHAVE_CENTRO_CUSTO is null
            )
            and
            NOM_CHAVE_CONTA_CONTABIL = p_NOM_CHAVE_CONTA_CONTABIL
            and
            (
             p_NOM_CHAVE_PROJETO is not null
             and
             NOM_CHAVE_PROJETO = p_NOM_CHAVE_PROJETO
             or 
             p_NOM_CHAVE_PROJETO is null
            );
  r_CCH  q_CCH%rowtype;
  l_CCH  boolean;
BEGIN
  --------------------------
  -- DEPENDENCIAS / CHAVE --
  --------------------------
  open q_DEP
        (
         :New.DEP_CD_DEPENDENCIA_GERD
        );
  fetch q_DEP into r_DEP;
  close q_DEP;
  --------------------------
  -- CENTRO_CUSTO / CHAVE --
  --------------------------
  open q_CC2
        (
         :New.CC2_CD_CENTRO_CUSTO_GERD
        );
  fetch q_CC2 into r_CC2;
  close q_CC2;
  ----------------------------
  -- CONTA_CONTABIL / CHAVE --
  ----------------------------
  open q_CC1
        (
         :New.CC1_NR_CONTA
        );
  fetch q_CC1 into r_CC1;
  close q_CC1;
  ---------------------
  -- PROJETO / CHAVE --
  ---------------------
  IF :New.PRJ_CD_PROJETO <> '0000'
  THEN
    open q_PRJ                
          (                   
           :New.PRJ_CD_PROJETO
          );                  
    fetch q_PRJ into r_PRJ;
    close q_PRJ;
  END IF;
  ------------------------------
  -- COMBINACAO_CHAVE / CHAVE --
  ------------------------------
  open q_CCH
        (
         r_DEP.CD_DEPENDENCIA_CHAVE, 
         r_CC2.CD_CENTRO_CUSTO_CHAVE,
         r_CC1.NR_CONTA_CHAVE,       
         r_PRJ.CD_PROJETO_CHAVE     
        );
  fetch q_CCH into r_CCH;
  l_CCH := q_CCH%found;
  close q_CCH;
  IF not l_CCH
  THEN
    RAISE_APPLICATION_ERROR
     (
      -20000,'
      Não foi encontrado combinação de chave contábil para 
      Dep.     '||:new.DEP_CD_DEPENDENCIA_GERD ||' ('||r_DEP.CD_DEPENDENCIA_CHAVE||'), 
      Custo.   '||:New.CC2_CD_CENTRO_CUSTO_GERD||' ('||r_CC2.CD_CENTRO_CUSTO_CHAVE||'),  (Nulo para 11301002-Almoxarifado)
      Conta.   '||:New.CC1_NR_CONTA            ||' ('||r_CC1.NR_CONTA_CHAVE||'), 
      Projeto. '||:New.PRJ_CD_PROJETO          ||' ('||r_PRJ.CD_PROJETO_CHAVE||') (Não obrigatória).'
     );
  END IF;
END IPS_TRG_02;
/


-- End of DDL Script for Trigger IFRSICOF.IPS_TRG_02

-- Start of DDL Script for Trigger IFRSICOF.TRG_IPS_IUD_1
-- Generated 26/9/2005 16:23:14 from IFRSICOF@homolog

CREATE OR REPLACE TRIGGER ifrsicof.trg_ips_iud_1
 AFTER
  INSERT OR DELETE OR UPDATE
 ON ifrsicof.item_proposta_orc_simulada
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  r_LOG   LOG_ITEM_PROP_ORC_SIMULADA%RowType;
BEGIN
  --------------
  -- INCLUSÃO --
  --------------
  IF INSERTING
  THEN
    insert into LOG_ITEM_PROP_ORC_SIMULADA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
      VSP_CD_NIVEL_VERSAO,
      VSP_CD_VERSAO,
      VSP_NR_ANO,
      DEP_CD_DEPENDENCIA,
      NR_ITEM,
      CC1_NR_CONTA,
      CC2_CD_CENTRO_CUSTO,
      CC2_CD_CENTRO_CUSTO_GERD,
      DEP_CD_DEPENDENCIA_GERD,
      PO_CD_PROGRAMA,
      PRJ_CD_PROJETO,
      IN_CENTRALIZADO,
      CD_PRIORIDADE,
      VL_UNITARIO_ITEM,
      NR_CONTRATO,
      DT_INICIO_CONTRATO,
      DT_TERMINO_CONTRATO,
      DS_JUSTIFICATIVA,
      DS_ITEM,
      NO_FORNECEDOR,
      DEP_CD_DEPENDENCIA_GEST,
      CC2_CD_CENTRO_CUSTO_GEST,
      GP_CD_GRUPO,
      QTD_JAN,
      VAL_JAN,
      QTD_FEV,
      VAL_FEV,
      QTD_MAR,
      VAL_MAR,
      QTD_ABR,
      VAL_ABR,
      QTD_MAI,
      VAL_MAI,
      QTD_JUN,
      VAL_JUN,
      QTD_JUL,
      VAL_JUL,
      QTD_AGO,
      VAL_AGO,
      QTD_SET,
      VAL_SET,
      QTD_OUT,
      VAL_OUT,
      QTD_NOV,
      VAL_NOV,
      QTD_DEZ,
      VAL_DEZ,
      QTD_JAN1,
      VAL_JAN1,
      QTD_FEV1,
      VAL_FEV1,
      QTD_MAR1,
      VAL_MAR1,
      QTD_ABR1,
      VAL_ABR1,
      QTD_MAI1,
      VAL_MAI1,
      QTD_JUN1,
      VAL_JUN1,
      QTD_JUL1,
      VAL_JUL1,
      QTD_AGO1,
      VAL_AGO1,
      QTD_SET1,
      VAL_SET1,
      QTD_OUT1,
      VAL_OUT1,
      QTD_NOV1,
      VAL_NOV1,
      QTD_DEZ1,
      VAL_DEZ1,
      QTD_JAN2,
      VAL_JAN2,
      QTD_FEV2,
      VAL_FEV2,
      QTD_MAR2,
      VAL_MAR2,
      QTD_ABR2,
      VAL_ABR2,
      QTD_MAI2,
      VAL_MAI2,
      QTD_JUN2,
      VAL_JUN2,
      QTD_JUL2,
      VAL_JUL2,
      QTD_AGO2,
      VAL_AGO2,
      QTD_SET2,
      VAL_SET2,
      QTD_OUT2,
      VAL_OUT2,
      QTD_NOV2,
      VAL_NOV2,
      QTD_DEZ2,
      VAL_DEZ2,
      QTD_JAN3,
      VAL_JAN3,
      QTD_FEV3,
      VAL_FEV3,
      QTD_MAR3,
      VAL_MAR3,
      QTD_ABR3,
      VAL_ABR3,
      QTD_MAI3,
      VAL_MAI3,
      QTD_JUN3,
      VAL_JUN3,
      QTD_JUL3,
      VAL_JUL3,
      QTD_AGO3,
      VAL_AGO3,
      QTD_SET3,
      VAL_SET3,
      QTD_OUT3,
      VAL_OUT3,
      QTD_NOV3,
      VAL_NOV3,
      QTD_DEZ3,
      VAL_DEZ3,
      QTD_JAN4,
      VAL_JAN4,
      QTD_FEV4,
      VAL_FEV4,
      QTD_MAR4,
      VAL_MAR4,
      QTD_ABR4,
      VAL_ABR4,
      QTD_MAI4,
      VAL_MAI4,
      QTD_JUN4,
      VAL_JUN4,
      QTD_JUL4,
      VAL_JUL4,
      QTD_AGO4,
      VAL_AGO4,
      QTD_SET4,
      VAL_SET4,
      QTD_OUT4,
      VAL_OUT4,
      QTD_NOV4,
      VAL_NOV4,
      QTD_DEZ4,
      VAL_DEZ4,
      VL_UNITARIO_ITEM1,
      VL_UNITARIO_ITEM2,
      VL_UNITARIO_ITEM3,
      VL_UNITARIO_ITEM4,
      IN_DIMENSIONAMENTO,
      IND_CONTRATO,
      COD_CATALOGO,
      SEQ_CARGA_ANO_ORCAMENTO,
      FLG_TIPO_CONTA,
      FLG_LANCAMENTO,
      VAL_TOTAL_GESTOR,
      COD_DEPENDENCIA_AGRUPADORA,
      COD_DEPENDENCIA_ELABORACAO,
      FLG_PLURIANUAL,
      FLG_OPERACAO_INCLUSAO
     )
    values
     (
      sysdate,
      user,
      'I',
      :new.VSP_CD_NIVEL_VERSAO,
      :new.VSP_CD_VERSAO,
      :new.VSP_NR_ANO,
      :new.DEP_CD_DEPENDENCIA,
      :new.NR_ITEM,
      :new.CC1_NR_CONTA,
      :new.CC2_CD_CENTRO_CUSTO,
      :new.CC2_CD_CENTRO_CUSTO_GERD,
      :new.DEP_CD_DEPENDENCIA_GERD,
      :new.PO_CD_PROGRAMA,
      :new.PRJ_CD_PROJETO,
      :new.IN_CENTRALIZADO,
      :new.CD_PRIORIDADE,
      :new.VL_UNITARIO_ITEM,
      :new.NR_CONTRATO,
      :new.DT_INICIO_CONTRATO,
      :new.DT_TERMINO_CONTRATO,
      :new.DS_JUSTIFICATIVA,
      :new.DS_ITEM,
      :new.NO_FORNECEDOR,
      :new.DEP_CD_DEPENDENCIA_GEST,
      :new.CC2_CD_CENTRO_CUSTO_GEST,
      :new.GP_CD_GRUPO,
      :new.QTD_JAN,
      :new.VAL_JAN,
      :new.QTD_FEV,
      :new.VAL_FEV,
      :new.QTD_MAR,
      :new.VAL_MAR,
      :new.QTD_ABR,
      :new.VAL_ABR,
      :new.QTD_MAI,
      :new.VAL_MAI,
      :new.QTD_JUN,
      :new.VAL_JUN,
      :new.QTD_JUL,
      :new.VAL_JUL,
      :new.QTD_AGO,
      :new.VAL_AGO,
      :new.QTD_SET,
      :new.VAL_SET,
      :new.QTD_OUT,
      :new.VAL_OUT,
      :new.QTD_NOV,
      :new.VAL_NOV,
      :new.QTD_DEZ,
      :new.VAL_DEZ,
      :new.QTD_JAN1,
      :new.VAL_JAN1,
      :new.QTD_FEV1,
      :new.VAL_FEV1,
      :new.QTD_MAR1,
      :new.VAL_MAR1,
      :new.QTD_ABR1,
      :new.VAL_ABR1,
      :new.QTD_MAI1,
      :new.VAL_MAI1,
      :new.QTD_JUN1,
      :new.VAL_JUN1,
      :new.QTD_JUL1,
      :new.VAL_JUL1,
      :new.QTD_AGO1,
      :new.VAL_AGO1,
      :new.QTD_SET1,
      :new.VAL_SET1,
      :new.QTD_OUT1,
      :new.VAL_OUT1,
      :new.QTD_NOV1,
      :new.VAL_NOV1,
      :new.QTD_DEZ1,
      :new.VAL_DEZ1,
      :new.QTD_JAN2,
      :new.VAL_JAN2,
      :new.QTD_FEV2,
      :new.VAL_FEV2,
      :new.QTD_MAR2,
      :new.VAL_MAR2,
      :new.QTD_ABR2,
      :new.VAL_ABR2,
      :new.QTD_MAI2,
      :new.VAL_MAI2,
      :new.QTD_JUN2,
      :new.VAL_JUN2,
      :new.QTD_JUL2,
      :new.VAL_JUL2,
      :new.QTD_AGO2,
      :new.VAL_AGO2,
      :new.QTD_SET2,
      :new.VAL_SET2,
      :new.QTD_OUT2,
      :new.VAL_OUT2,
      :new.QTD_NOV2,
      :new.VAL_NOV2,
      :new.QTD_DEZ2,
      :new.VAL_DEZ2,
      :new.QTD_JAN3,
      :new.VAL_JAN3,
      :new.QTD_FEV3,
      :new.VAL_FEV3,
      :new.QTD_MAR3,
      :new.VAL_MAR3,
      :new.QTD_ABR3,
      :new.VAL_ABR3,
      :new.QTD_MAI3,
      :new.VAL_MAI3,
      :new.QTD_JUN3,
      :new.VAL_JUN3,
      :new.QTD_JUL3,
      :new.VAL_JUL3,
      :new.QTD_AGO3,
      :new.VAL_AGO3,
      :new.QTD_SET3,
      :new.VAL_SET3,
      :new.QTD_OUT3,
      :new.VAL_OUT3,
      :new.QTD_NOV3,
      :new.VAL_NOV3,
      :new.QTD_DEZ3,
      :new.VAL_DEZ3,
      :new.QTD_JAN4,
      :new.VAL_JAN4,
      :new.QTD_FEV4,
      :new.VAL_FEV4,
      :new.QTD_MAR4,
      :new.VAL_MAR4,
      :new.QTD_ABR4,
      :new.VAL_ABR4,
      :new.QTD_MAI4,
      :new.VAL_MAI4,
      :new.QTD_JUN4,
      :new.VAL_JUN4,
      :new.QTD_JUL4,
      :new.VAL_JUL4,
      :new.QTD_AGO4,
      :new.VAL_AGO4,
      :new.QTD_SET4,
      :new.VAL_SET4,
      :new.QTD_OUT4,
      :new.VAL_OUT4,
      :new.QTD_NOV4,
      :new.VAL_NOV4,
      :new.QTD_DEZ4,
      :new.VAL_DEZ4,
      :new.VL_UNITARIO_ITEM1,
      :new.VL_UNITARIO_ITEM2,
      :new.VL_UNITARIO_ITEM3,
      :new.VL_UNITARIO_ITEM4,
      :new.IN_DIMENSIONAMENTO,
      :new.IND_CONTRATO,
      :new.COD_CATALOGO,
      :new.SEQ_CARGA_ANO_ORCAMENTO,
      :new.FLG_TIPO_CONTA,
      :new.FLG_LANCAMENTO,
      :new.VAL_TOTAL_GESTOR,
      :new.COD_DEPENDENCIA_AGRUPADORA,
      :new.COD_DEPENDENCIA_ELABORACAO,
      :new.FLG_PLURIANUAL,
      :new.FLG_OPERACAO_INCLUSAO
     );
  ---------------
  -- ALTERAÇÃO --
  ---------------
  ELSIF UPDATING
  THEN
    r_log.VSP_CD_NIVEL_VERSAO := :new.VSP_CD_NIVEL_VERSAO;
    r_log.VSP_CD_VERSAO := :new.VSP_CD_VERSAO;
    r_log.VSP_NR_ANO := :new.VSP_NR_ANO;
    --
    IF :new.DEP_CD_DEPENDENCIA != :old.DEP_CD_DEPENDENCIA
    THEN
      r_log.DEP_CD_DEPENDENCIA := :new.DEP_CD_DEPENDENCIA;
    END IF;
    --
    r_log.NR_ITEM := :new.NR_ITEM;
    --
    IF :new.CC1_NR_CONTA != :old.CC1_NR_CONTA
    THEN
      r_log.CC1_NR_CONTA := :new.CC1_NR_CONTA;
    END IF;
    --
    IF :new.CC2_CD_CENTRO_CUSTO != :old.CC2_CD_CENTRO_CUSTO
    THEN
      r_log.CC2_CD_CENTRO_CUSTO := :new.CC2_CD_CENTRO_CUSTO;
    END IF;
    --
    IF :new.CC2_CD_CENTRO_CUSTO_GERD != :old.CC2_CD_CENTRO_CUSTO_GERD
    THEN
      r_log.CC2_CD_CENTRO_CUSTO_GERD := :new.CC2_CD_CENTRO_CUSTO_GERD;
    END IF;
    --
    IF :new.DEP_CD_DEPENDENCIA_GERD != :old.DEP_CD_DEPENDENCIA_GERD
    THEN
      r_log.DEP_CD_DEPENDENCIA_GERD := :new.DEP_CD_DEPENDENCIA_GERD;
    END IF;
    --
    IF :new.PO_CD_PROGRAMA != :old.PO_CD_PROGRAMA
    THEN
      r_log.PO_CD_PROGRAMA := :new.PO_CD_PROGRAMA;
    END IF;
    --
    IF :new.PRJ_CD_PROJETO != :old.PRJ_CD_PROJETO
    THEN
      r_log.PRJ_CD_PROJETO := :new.PRJ_CD_PROJETO;
    END IF;
    --
    IF :new.IN_CENTRALIZADO            != :old.IN_CENTRALIZADO
    THEN
      r_log.IN_CENTRALIZADO            := :new.IN_CENTRALIZADO;
    END IF;
    --
    IF :new.CD_PRIORIDADE              != :old.CD_PRIORIDADE
    THEN
      r_log.CD_PRIORIDADE              := :new.CD_PRIORIDADE;
    END IF;
    --
    IF :new.VL_UNITARIO_ITEM           != :old.VL_UNITARIO_ITEM
    THEN
      r_log.VL_UNITARIO_ITEM           := :new.VL_UNITARIO_ITEM;
    END IF;
    --
    IF :new.NR_CONTRATO                != :old.NR_CONTRATO
    THEN
      r_log.NR_CONTRATO                := :new.NR_CONTRATO;
    END IF;
    --
    IF :new.DT_INICIO_CONTRATO         != :old.DT_INICIO_CONTRATO
    THEN
      r_log.DT_INICIO_CONTRATO         := :new.DT_INICIO_CONTRATO;
    END IF;
    --
    IF :new.DT_TERMINO_CONTRATO != :old.DT_TERMINO_CONTRATO
    THEN
      r_log.DT_TERMINO_CONTRATO := :new.DT_TERMINO_CONTRATO;
    END IF;
    --
    IF :new.DS_JUSTIFICATIVA != :old.DS_JUSTIFICATIVA
    THEN
      r_log.DS_JUSTIFICATIVA := :new.DS_JUSTIFICATIVA;
    END IF;
    --
    IF :new.DS_ITEM != :old.DS_ITEM
    THEN
      r_log.DS_ITEM := :new.DS_ITEM;
    END IF;
    --
    IF :new.NO_FORNECEDOR != :old.NO_FORNECEDOR
    THEN
      r_log.NO_FORNECEDOR := :new.NO_FORNECEDOR;
    END IF;
    --
    IF :new.DEP_CD_DEPENDENCIA_GEST != :old.DEP_CD_DEPENDENCIA_GEST
    THEN
      r_log.DEP_CD_DEPENDENCIA_GEST := :new.DEP_CD_DEPENDENCIA_GEST;
    END IF;
    --
    IF :new.CC2_CD_CENTRO_CUSTO_GEST != :old.CC2_CD_CENTRO_CUSTO_GEST
    THEN
      r_log.CC2_CD_CENTRO_CUSTO_GEST   := :new.CC2_CD_CENTRO_CUSTO_GEST;
    END IF;
    --
    IF :new.GP_CD_GRUPO != :old.GP_CD_GRUPO
    THEN
      r_log.GP_CD_GRUPO := :new.GP_CD_GRUPO;
    END IF;
    --
    IF :new.QTD_JAN  != :old.QTD_JAN  THEN r_log.QTD_JAN  := :new.QTD_JAN ; END IF;
    IF :new.VAL_JAN  != :old.VAL_JAN  THEN r_log.VAL_JAN  := :new.VAL_JAN ; END IF;
    IF :new.QTD_FEV  != :old.QTD_FEV  THEN r_log.QTD_FEV  := :new.QTD_FEV ; END IF;
    IF :new.VAL_FEV  != :old.VAL_FEV  THEN r_log.VAL_FEV  := :new.VAL_FEV ; END IF;
    IF :new.QTD_MAR  != :old.QTD_MAR  THEN r_log.QTD_MAR  := :new.QTD_MAR ; END IF;
    IF :new.VAL_MAR  != :old.VAL_MAR  THEN r_log.VAL_MAR  := :new.VAL_MAR ; END IF;
    IF :new.QTD_ABR  != :old.QTD_ABR  THEN r_log.QTD_ABR  := :new.QTD_ABR ; END IF;
    IF :new.VAL_ABR  != :old.VAL_ABR  THEN r_log.VAL_ABR  := :new.VAL_ABR ; END IF;
    IF :new.QTD_MAI  != :old.QTD_MAI  THEN r_log.QTD_MAI  := :new.QTD_MAI ; END IF;
    IF :new.VAL_MAI  != :old.VAL_MAI  THEN r_log.VAL_MAI  := :new.VAL_MAI ; END IF;
    IF :new.QTD_JUN  != :old.QTD_JUN  THEN r_log.QTD_JUN  := :new.QTD_JUN ; END IF;
    IF :new.VAL_JUN  != :old.VAL_JUN  THEN r_log.VAL_JUN  := :new.VAL_JUN ; END IF;
    IF :new.QTD_JUL  != :old.QTD_JUL  THEN r_log.QTD_JUL  := :new.QTD_JUL ; END IF;
    IF :new.VAL_JUL  != :old.VAL_JUL  THEN r_log.VAL_JUL  := :new.VAL_JUL ; END IF;
    IF :new.QTD_AGO  != :old.QTD_AGO  THEN r_log.QTD_AGO  := :new.QTD_AGO ; END IF;
    IF :new.VAL_AGO  != :old.VAL_AGO  THEN r_log.VAL_AGO  := :new.VAL_AGO ; END IF;
    IF :new.QTD_SET  != :old.QTD_SET  THEN r_log.QTD_SET  := :new.QTD_SET ; END IF;
    IF :new.VAL_SET  != :old.VAL_SET  THEN r_log.VAL_SET  := :new.VAL_SET ; END IF;
    IF :new.QTD_OUT  != :old.QTD_OUT  THEN r_log.QTD_OUT  := :new.QTD_OUT ; END IF;
    IF :new.VAL_OUT  != :old.VAL_OUT  THEN r_log.VAL_OUT  := :new.VAL_OUT ; END IF;
    IF :new.QTD_NOV  != :old.QTD_NOV  THEN r_log.QTD_NOV  := :new.QTD_NOV ; END IF;
    IF :new.VAL_NOV  != :old.VAL_NOV  THEN r_log.VAL_NOV  := :new.VAL_NOV ; END IF;
    IF :new.QTD_DEZ  != :old.QTD_DEZ  THEN r_log.QTD_DEZ  := :new.QTD_DEZ ; END IF;
    IF :new.VAL_DEZ  != :old.VAL_DEZ  THEN r_log.VAL_DEZ  := :new.VAL_DEZ ; END IF;
    IF :new.QTD_JAN1 != :old.QTD_JAN1 THEN r_log.QTD_JAN1 := :new.QTD_JAN1; END IF;
    IF :new.VAL_JAN1 != :old.VAL_JAN1 THEN r_log.VAL_JAN1 := :new.VAL_JAN1; END IF;
    IF :new.QTD_FEV1 != :old.QTD_FEV1 THEN r_log.QTD_FEV1 := :new.QTD_FEV1; END IF;
    IF :new.VAL_FEV1 != :old.VAL_FEV1 THEN r_log.VAL_FEV1 := :new.VAL_FEV1; END IF;
    IF :new.QTD_MAR1 != :old.QTD_MAR1 THEN r_log.QTD_MAR1 := :new.QTD_MAR1; END IF;
    IF :new.VAL_MAR1 != :old.VAL_MAR1 THEN r_log.VAL_MAR1 := :new.VAL_MAR1; END IF;
    IF :new.QTD_ABR1 != :old.QTD_ABR1 THEN r_log.QTD_ABR1 := :new.QTD_ABR1; END IF;
    IF :new.VAL_ABR1 != :old.VAL_ABR1 THEN r_log.VAL_ABR1 := :new.VAL_ABR1; END IF;
    IF :new.QTD_MAI1 != :old.QTD_MAI1 THEN r_log.QTD_MAI1 := :new.QTD_MAI1; END IF;
    IF :new.VAL_MAI1 != :old.VAL_MAI1 THEN r_log.VAL_MAI1 := :new.VAL_MAI1; END IF;
    IF :new.QTD_JUN1 != :old.QTD_JUN1 THEN r_log.QTD_JUN1 := :new.QTD_JUN1; END IF;
    IF :new.VAL_JUN1 != :old.VAL_JUN1 THEN r_log.VAL_JUN1 := :new.VAL_JUN1; END IF;
    IF :new.QTD_JUL1 != :old.QTD_JUL1 THEN r_log.QTD_JUL1 := :new.QTD_JUL1; END IF;
    IF :new.VAL_JUL1 != :old.VAL_JUL1 THEN r_log.VAL_JUL1 := :new.VAL_JUL1; END IF;
    IF :new.QTD_AGO1 != :old.QTD_AGO1 THEN r_log.QTD_AGO1 := :new.QTD_AGO1; END IF;
    IF :new.VAL_AGO1 != :old.VAL_AGO1 THEN r_log.VAL_AGO1 := :new.VAL_AGO1; END IF;
    IF :new.QTD_SET1 != :old.QTD_SET1 THEN r_log.QTD_SET1 := :new.QTD_SET1; END IF;
    IF :new.VAL_SET1 != :old.VAL_SET1 THEN r_log.VAL_SET1 := :new.VAL_SET1; END IF;
    IF :new.QTD_OUT1 != :old.QTD_OUT1 THEN r_log.QTD_OUT1 := :new.QTD_OUT1; END IF;
    IF :new.VAL_OUT1 != :old.VAL_OUT1 THEN r_log.VAL_OUT1 := :new.VAL_OUT1; END IF;
    IF :new.QTD_NOV1 != :old.QTD_NOV1 THEN r_log.QTD_NOV1 := :new.QTD_NOV1; END IF;
    IF :new.VAL_NOV1 != :old.VAL_NOV1 THEN r_log.VAL_NOV1 := :new.VAL_NOV1; END IF;
    IF :new.QTD_DEZ1 != :old.QTD_DEZ1 THEN r_log.QTD_DEZ1 := :new.QTD_DEZ1; END IF;
    IF :new.VAL_DEZ1 != :old.VAL_DEZ1 THEN r_log.VAL_DEZ1 := :new.VAL_DEZ1; END IF;
    IF :new.QTD_JAN2 != :old.QTD_JAN2 THEN r_log.QTD_JAN2 := :new.QTD_JAN2; END IF;
    IF :new.VAL_JAN2 != :old.VAL_JAN2 THEN r_log.VAL_JAN2 := :new.VAL_JAN2; END IF;
    IF :new.QTD_FEV2 != :old.QTD_FEV2 THEN r_log.QTD_FEV2 := :new.QTD_FEV2; END IF;
    IF :new.VAL_FEV2 != :old.VAL_FEV2 THEN r_log.VAL_FEV2 := :new.VAL_FEV2; END IF;
    IF :new.QTD_MAR2 != :old.QTD_MAR2 THEN r_log.QTD_MAR2 := :new.QTD_MAR2; END IF;
    IF :new.VAL_MAR2 != :old.VAL_MAR2 THEN r_log.VAL_MAR2 := :new.VAL_MAR2; END IF;
    IF :new.QTD_ABR2 != :old.QTD_ABR2 THEN r_log.QTD_ABR2 := :new.QTD_ABR2; END IF;
    IF :new.VAL_ABR2 != :old.VAL_ABR2 THEN r_log.VAL_ABR2 := :new.VAL_ABR2; END IF;
    IF :new.QTD_MAI2 != :old.QTD_MAI2 THEN r_log.QTD_MAI2 := :new.QTD_MAI2; END IF;
    IF :new.VAL_MAI2 != :old.VAL_MAI2 THEN r_log.VAL_MAI2 := :new.VAL_MAI2; END IF;
    IF :new.QTD_JUN2 != :old.QTD_JUN2 THEN r_log.QTD_JUN2 := :new.QTD_JUN2; END IF;
    IF :new.VAL_JUN2 != :old.VAL_JUN2 THEN r_log.VAL_JUN2 := :new.VAL_JUN2; END IF;
    IF :new.QTD_JUL2 != :old.QTD_JUL2 THEN r_log.QTD_JUL2 := :new.QTD_JUL2; END IF;
    IF :new.VAL_JUL2 != :old.VAL_JUL2 THEN r_log.VAL_JUL2 := :new.VAL_JUL2; END IF;
    IF :new.QTD_AGO2 != :old.QTD_AGO2 THEN r_log.QTD_AGO2 := :new.QTD_AGO2; END IF;
    IF :new.VAL_AGO2 != :old.VAL_AGO2 THEN r_log.VAL_AGO2 := :new.VAL_AGO2; END IF;
    IF :new.QTD_SET2 != :old.QTD_SET2 THEN r_log.QTD_SET2 := :new.QTD_SET2; END IF;
    IF :new.VAL_SET2 != :old.VAL_SET2 THEN r_log.VAL_SET2 := :new.VAL_SET2; END IF;
    IF :new.QTD_OUT2 != :old.QTD_OUT2 THEN r_log.QTD_OUT2 := :new.QTD_OUT2; END IF;
    IF :new.VAL_OUT2 != :old.VAL_OUT2 THEN r_log.VAL_OUT2 := :new.VAL_OUT2; END IF;
    IF :new.QTD_NOV2 != :old.QTD_NOV2 THEN r_log.QTD_NOV2 := :new.QTD_NOV2; END IF;
    IF :new.VAL_NOV2 != :old.VAL_NOV2 THEN r_log.VAL_NOV2 := :new.VAL_NOV2; END IF;
    IF :new.QTD_DEZ2 != :old.QTD_DEZ2 THEN r_log.QTD_DEZ2 := :new.QTD_DEZ2; END IF;
    IF :new.VAL_DEZ2 != :old.VAL_DEZ2 THEN r_log.VAL_DEZ2 := :new.VAL_DEZ2; END IF;

    IF :new.QTD_JAN3 != :old.QTD_JAN3 THEN r_log.QTD_JAN3 := :new.QTD_JAN3; END IF;
    IF :new.VAL_JAN3 != :old.VAL_JAN3 THEN r_log.VAL_JAN3 := :new.VAL_JAN3; END IF;
    IF :new.QTD_FEV3 != :old.QTD_FEV3 THEN r_log.QTD_FEV3 := :new.QTD_FEV3; END IF;
    IF :new.VAL_FEV3 != :old.VAL_FEV3 THEN r_log.VAL_FEV3 := :new.VAL_FEV3; END IF;
    IF :new.QTD_MAR3 != :old.QTD_MAR3 THEN r_log.QTD_MAR3 := :new.QTD_MAR3; END IF;
    IF :new.VAL_MAR3 != :old.VAL_MAR3 THEN r_log.VAL_MAR3 := :new.VAL_MAR3; END IF;
    IF :new.QTD_ABR3 != :old.QTD_ABR3 THEN r_log.QTD_ABR3 := :new.QTD_ABR3; END IF;
    IF :new.VAL_ABR3 != :old.VAL_ABR3 THEN r_log.VAL_ABR3 := :new.VAL_ABR3; END IF;
    IF :new.QTD_MAI3 != :old.QTD_MAI3 THEN r_log.QTD_MAI3 := :new.QTD_MAI3; END IF;
    IF :new.VAL_MAI3 != :old.VAL_MAI3 THEN r_log.VAL_MAI3 := :new.VAL_MAI3; END IF;
    IF :new.QTD_JUN3 != :old.QTD_JUN3 THEN r_log.QTD_JUN3 := :new.QTD_JUN3; END IF;
    IF :new.VAL_JUN3 != :old.VAL_JUN3 THEN r_log.VAL_JUN3 := :new.VAL_JUN3; END IF;
    IF :new.QTD_JUL3 != :old.QTD_JUL3 THEN r_log.QTD_JUL3 := :new.QTD_JUL3; END IF;
    IF :new.VAL_JUL3 != :old.VAL_JUL3 THEN r_log.VAL_JUL3 := :new.VAL_JUL3; END IF;
    IF :new.QTD_AGO3 != :old.QTD_AGO3 THEN r_log.QTD_AGO3 := :new.QTD_AGO3; END IF;
    IF :new.VAL_AGO3 != :old.VAL_AGO3 THEN r_log.VAL_AGO3 := :new.VAL_AGO3; END IF;
    IF :new.QTD_SET3 != :old.QTD_SET3 THEN r_log.QTD_SET3 := :new.QTD_SET3; END IF;
    IF :new.VAL_SET3 != :old.VAL_SET3 THEN r_log.VAL_SET3 := :new.VAL_SET3; END IF;
    IF :new.QTD_OUT3 != :old.QTD_OUT3 THEN r_log.QTD_OUT3 := :new.QTD_OUT3; END IF;
    IF :new.VAL_OUT3 != :old.VAL_OUT3 THEN r_log.VAL_OUT3 := :new.VAL_OUT3; END IF;
    IF :new.QTD_NOV3 != :old.QTD_NOV3 THEN r_log.QTD_NOV3 := :new.QTD_NOV3; END IF;
    IF :new.VAL_NOV3 != :old.VAL_NOV3 THEN r_log.VAL_NOV3 := :new.VAL_NOV3; END IF;
    IF :new.QTD_DEZ3 != :old.QTD_DEZ3 THEN r_log.QTD_DEZ3 := :new.QTD_DEZ3; END IF;
    IF :new.VAL_DEZ3 != :old.VAL_DEZ3 THEN r_log.VAL_DEZ3 := :new.VAL_DEZ3; END IF;

    IF :new.QTD_JAN4 != :old.QTD_JAN4 THEN r_log.QTD_JAN4 := :new.QTD_JAN4; END IF;
    IF :new.VAL_JAN4 != :old.VAL_JAN4 THEN r_log.VAL_JAN4 := :new.VAL_JAN4; END IF;
    IF :new.QTD_FEV4 != :old.QTD_FEV4 THEN r_log.QTD_FEV4 := :new.QTD_FEV4; END IF;
    IF :new.VAL_FEV4 != :old.VAL_FEV4 THEN r_log.VAL_FEV4 := :new.VAL_FEV4; END IF;
    IF :new.QTD_MAR4 != :old.QTD_MAR4 THEN r_log.QTD_MAR4 := :new.QTD_MAR4; END IF;
    IF :new.VAL_MAR4 != :old.VAL_MAR4 THEN r_log.VAL_MAR4 := :new.VAL_MAR4; END IF;
    IF :new.QTD_ABR4 != :old.QTD_ABR4 THEN r_log.QTD_ABR4 := :new.QTD_ABR4; END IF;
    IF :new.VAL_ABR4 != :old.VAL_ABR4 THEN r_log.VAL_ABR4 := :new.VAL_ABR4; END IF;
    IF :new.QTD_MAI4 != :old.QTD_MAI4 THEN r_log.QTD_MAI4 := :new.QTD_MAI4; END IF;
    IF :new.VAL_MAI4 != :old.VAL_MAI4 THEN r_log.VAL_MAI4 := :new.VAL_MAI4; END IF;
    IF :new.QTD_JUN4 != :old.QTD_JUN4 THEN r_log.QTD_JUN4 := :new.QTD_JUN4; END IF;
    IF :new.VAL_JUN4 != :old.VAL_JUN4 THEN r_log.VAL_JUN4 := :new.VAL_JUN4; END IF;
    IF :new.QTD_JUL4 != :old.QTD_JUL4 THEN r_log.QTD_JUL4 := :new.QTD_JUL4; END IF;
    IF :new.VAL_JUL4 != :old.VAL_JUL4 THEN r_log.VAL_JUL4 := :new.VAL_JUL4; END IF;
    IF :new.QTD_AGO4 != :old.QTD_AGO4 THEN r_log.QTD_AGO4 := :new.QTD_AGO4; END IF;
    IF :new.VAL_AGO4 != :old.VAL_AGO4 THEN r_log.VAL_AGO4 := :new.VAL_AGO4; END IF;
    IF :new.QTD_SET4 != :old.QTD_SET4 THEN r_log.QTD_SET4 := :new.QTD_SET4; END IF;
    IF :new.VAL_SET4 != :old.VAL_SET4 THEN r_log.VAL_SET4 := :new.VAL_SET4; END IF;
    IF :new.QTD_OUT4 != :old.QTD_OUT4 THEN r_log.QTD_OUT4 := :new.QTD_OUT4; END IF;
    IF :new.VAL_OUT4 != :old.VAL_OUT4 THEN r_log.VAL_OUT4 := :new.VAL_OUT4; END IF;
    IF :new.QTD_NOV4 != :old.QTD_NOV4 THEN r_log.QTD_NOV4 := :new.QTD_NOV4; END IF;
    IF :new.VAL_NOV4 != :old.VAL_NOV4 THEN r_log.VAL_NOV4 := :new.VAL_NOV4; END IF;
    IF :new.QTD_DEZ4 != :old.QTD_DEZ4 THEN r_log.QTD_DEZ4 := :new.QTD_DEZ4; END IF;
    IF :new.VAL_DEZ4 != :old.VAL_DEZ4 THEN r_log.VAL_DEZ4 := :new.VAL_DEZ4; END IF;

    IF :new.VL_UNITARIO_ITEM1 != :old.VL_UNITARIO_ITEM1 
    THEN
      r_log.VL_UNITARIO_ITEM1 := :new.VL_UNITARIO_ITEM1;
    END IF;
    IF :new.VL_UNITARIO_ITEM2 != :old.VL_UNITARIO_ITEM2
    THEN
      r_log.VL_UNITARIO_ITEM2 := :new.VL_UNITARIO_ITEM2;
    END IF;
    IF :new.VL_UNITARIO_ITEM3 != :old.VL_UNITARIO_ITEM3
    THEN
      r_log.VL_UNITARIO_ITEM3 := :new.VL_UNITARIO_ITEM3;
    END IF;
    IF :new.VL_UNITARIO_ITEM4 != :old.VL_UNITARIO_ITEM4
    THEN
      r_log.VL_UNITARIO_ITEM4 := :new.VL_UNITARIO_ITEM4;
    END IF;
    IF :new.IN_DIMENSIONAMENTO != :old.IN_DIMENSIONAMENTO
    THEN
      r_log.IN_DIMENSIONAMENTO := :new.IN_DIMENSIONAMENTO;
    END IF;
    IF :new.IND_CONTRATO != :old.IND_CONTRATO
    THEN
      r_log.IND_CONTRATO := :new.IND_CONTRATO;
    END IF;
    IF :new.COD_CATALOGO != :old.COD_CATALOGO
    THEN
      r_log.COD_CATALOGO := :new.COD_CATALOGO;
    END IF;
    IF :new.SEQ_CARGA_ANO_ORCAMENTO    != :old.SEQ_CARGA_ANO_ORCAMENTO
    THEN
      r_log.SEQ_CARGA_ANO_ORCAMENTO    := :new.SEQ_CARGA_ANO_ORCAMENTO;
    END IF;
    IF :new.FLG_TIPO_CONTA != :old.FLG_TIPO_CONTA
    THEN
      r_log.FLG_TIPO_CONTA := :new.FLG_TIPO_CONTA;
    END IF;
    IF :new.FLG_LANCAMENTO != :old.FLG_LANCAMENTO
    THEN
      r_log.FLG_LANCAMENTO := :new.FLG_LANCAMENTO;
    END IF;
    IF :new.VAL_TOTAL_GESTOR != :old.VAL_TOTAL_GESTOR
    THEN
      r_log.VAL_TOTAL_GESTOR := :new.VAL_TOTAL_GESTOR;
    END IF;
    r_log.COD_DEPENDENCIA_AGRUPADORA := :new.COD_DEPENDENCIA_AGRUPADORA;
    r_log.COD_DEPENDENCIA_ELABORACAO := :new.COD_DEPENDENCIA_ELABORACAO;
    IF :new.FLG_PLURIANUAL != :old.FLG_PLURIANUAL
    THEN
      r_log.FLG_PLURIANUAL := :new.FLG_PLURIANUAL;
    END IF;
    IF :new.FLG_OPERACAO_INCLUSAO != :old.FLG_OPERACAO_INCLUSAO
    THEN
      r_log.FLG_OPERACAO_INCLUSAO := :new.FLG_OPERACAO_INCLUSAO;
    END IF;
    insert into LOG_ITEM_PROP_ORC_SIMULADA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
      VSP_CD_NIVEL_VERSAO,
      VSP_CD_VERSAO,
      VSP_NR_ANO,
      DEP_CD_DEPENDENCIA,
      NR_ITEM,
      CC1_NR_CONTA,
      CC2_CD_CENTRO_CUSTO,
      CC2_CD_CENTRO_CUSTO_GERD,
      DEP_CD_DEPENDENCIA_GERD,
      PO_CD_PROGRAMA,
      PRJ_CD_PROJETO,
      IN_CENTRALIZADO,
      CD_PRIORIDADE,
      VL_UNITARIO_ITEM,
      NR_CONTRATO,
      DT_INICIO_CONTRATO,
      DT_TERMINO_CONTRATO,
      DS_JUSTIFICATIVA,
      DS_ITEM,
      NO_FORNECEDOR,
      DEP_CD_DEPENDENCIA_GEST,
      CC2_CD_CENTRO_CUSTO_GEST,
      GP_CD_GRUPO,
      QTD_JAN,
      VAL_JAN,
      QTD_FEV,
      VAL_FEV,
      QTD_MAR,
      VAL_MAR,
      QTD_ABR,
      VAL_ABR,
      QTD_MAI,
      VAL_MAI,
      QTD_JUN,
      VAL_JUN,
      QTD_JUL,
      VAL_JUL,
      QTD_AGO,
      VAL_AGO,
      QTD_SET,
      VAL_SET,
      QTD_OUT,
      VAL_OUT,
      QTD_NOV,
      VAL_NOV,
      QTD_DEZ,
      VAL_DEZ,
      QTD_JAN1,
      VAL_JAN1,
      QTD_FEV1,
      VAL_FEV1,
      QTD_MAR1,
      VAL_MAR1,
      QTD_ABR1,
      VAL_ABR1,
      QTD_MAI1,
      VAL_MAI1,
      QTD_JUN1,
      VAL_JUN1,
      QTD_JUL1,
      VAL_JUL1,
      QTD_AGO1,
      VAL_AGO1,
      QTD_SET1,
      VAL_SET1,
      QTD_OUT1,
      VAL_OUT1,
      QTD_NOV1,
      VAL_NOV1,
      QTD_DEZ1,
      VAL_DEZ1,
      QTD_JAN2,
      VAL_JAN2,
      QTD_FEV2,
      VAL_FEV2,
      QTD_MAR2,
      VAL_MAR2,
      QTD_ABR2,
      VAL_ABR2,
      QTD_MAI2,
      VAL_MAI2,
      QTD_JUN2,
      VAL_JUN2,
      QTD_JUL2,
      VAL_JUL2,
      QTD_AGO2,
      VAL_AGO2,
      QTD_SET2,
      VAL_SET2,
      QTD_OUT2,
      VAL_OUT2,
      QTD_NOV2,
      VAL_NOV2,
      QTD_DEZ2,
      VAL_DEZ2,
      QTD_JAN3,
      VAL_JAN3,
      QTD_FEV3,
      VAL_FEV3,
      QTD_MAR3,
      VAL_MAR3,
      QTD_ABR3,
      VAL_ABR3,
      QTD_MAI3,
      VAL_MAI3,
      QTD_JUN3,
      VAL_JUN3,
      QTD_JUL3,
      VAL_JUL3,
      QTD_AGO3,
      VAL_AGO3,
      QTD_SET3,
      VAL_SET3,
      QTD_OUT3,
      VAL_OUT3,
      QTD_NOV3,
      VAL_NOV3,
      QTD_DEZ3,
      VAL_DEZ3,
      QTD_JAN4,
      VAL_JAN4,
      QTD_FEV4,
      VAL_FEV4,
      QTD_MAR4,
      VAL_MAR4,
      QTD_ABR4,
      VAL_ABR4,
      QTD_MAI4,
      VAL_MAI4,
      QTD_JUN4,
      VAL_JUN4,
      QTD_JUL4,
      VAL_JUL4,
      QTD_AGO4,
      VAL_AGO4,
      QTD_SET4,
      VAL_SET4,
      QTD_OUT4,
      VAL_OUT4,
      QTD_NOV4,
      VAL_NOV4,
      QTD_DEZ4,
      VAL_DEZ4,
      VL_UNITARIO_ITEM1,
      VL_UNITARIO_ITEM2,
      VL_UNITARIO_ITEM3,
      VL_UNITARIO_ITEM4,
      IN_DIMENSIONAMENTO,
      IND_CONTRATO,
      COD_CATALOGO,
      SEQ_CARGA_ANO_ORCAMENTO,
      FLG_TIPO_CONTA,
      FLG_LANCAMENTO,
      VAL_TOTAL_GESTOR,
      COD_DEPENDENCIA_AGRUPADORA,
      COD_DEPENDENCIA_ELABORACAO,
      FLG_PLURIANUAL,
      FLG_OPERACAO_INCLUSAO
     )
    values
     (
      sysdate,
      user,
      'A',
      r_log.VSP_CD_NIVEL_VERSAO,
      r_log.VSP_CD_VERSAO,
      r_log.VSP_NR_ANO,
      r_log.DEP_CD_DEPENDENCIA,
      r_log.NR_ITEM,
      r_log.CC1_NR_CONTA,
      r_log.CC2_CD_CENTRO_CUSTO,
      r_log.CC2_CD_CENTRO_CUSTO_GERD,
      r_log.DEP_CD_DEPENDENCIA_GERD,
      r_log.PO_CD_PROGRAMA,
      r_log.PRJ_CD_PROJETO,
      r_log.IN_CENTRALIZADO,
      r_log.CD_PRIORIDADE,
      r_log.VL_UNITARIO_ITEM,
      r_log.NR_CONTRATO,
      r_log.DT_INICIO_CONTRATO,
      r_log.DT_TERMINO_CONTRATO,
      r_log.DS_JUSTIFICATIVA,
      r_log.DS_ITEM,
      r_log.NO_FORNECEDOR,
      r_log.DEP_CD_DEPENDENCIA_GEST,
      r_log.CC2_CD_CENTRO_CUSTO_GEST,
      r_log.GP_CD_GRUPO,
      r_log.QTD_JAN,
      r_log.VAL_JAN,
      r_log.QTD_FEV,
      r_log.VAL_FEV,
      r_log.QTD_MAR,
      r_log.VAL_MAR,
      r_log.QTD_ABR,
      r_log.VAL_ABR,
      r_log.QTD_MAI,
      r_log.VAL_MAI,
      r_log.QTD_JUN,
      r_log.VAL_JUN,
      r_log.QTD_JUL,
      r_log.VAL_JUL,
      r_log.QTD_AGO,
      r_log.VAL_AGO,
      r_log.QTD_SET,
      r_log.VAL_SET,
      r_log.QTD_OUT,
      r_log.VAL_OUT,
      r_log.QTD_NOV,
      r_log.VAL_NOV,
      r_log.QTD_DEZ,
      r_log.VAL_DEZ,
      r_log.QTD_JAN1,
      r_log.VAL_JAN1,
      r_log.QTD_FEV1,
      r_log.VAL_FEV1,
      r_log.QTD_MAR1,
      r_log.VAL_MAR1,
      r_log.QTD_ABR1,
      r_log.VAL_ABR1,
      r_log.QTD_MAI1,
      r_log.VAL_MAI1,
      r_log.QTD_JUN1,
      r_log.VAL_JUN1,
      r_log.QTD_JUL1,
      r_log.VAL_JUL1,
      r_log.QTD_AGO1,
      r_log.VAL_AGO1,
      r_log.QTD_SET1,
      r_log.VAL_SET1,
      r_log.QTD_OUT1,
      r_log.VAL_OUT1,
      r_log.QTD_NOV1,
      r_log.VAL_NOV1,
      r_log.QTD_DEZ1,
      r_log.VAL_DEZ1,
      r_log.QTD_JAN2,
      r_log.VAL_JAN2,
      r_log.QTD_FEV2,
      r_log.VAL_FEV2,
      r_log.QTD_MAR2,
      r_log.VAL_MAR2,
      r_log.QTD_ABR2,
      r_log.VAL_ABR2,
      r_log.QTD_MAI2,
      r_log.VAL_MAI2,
      r_log.QTD_JUN2,
      r_log.VAL_JUN2,
      r_log.QTD_JUL2,
      r_log.VAL_JUL2,
      r_log.QTD_AGO2,
      r_log.VAL_AGO2,
      r_log.QTD_SET2,
      r_log.VAL_SET2,
      r_log.QTD_OUT2,
      r_log.VAL_OUT2,
      r_log.QTD_NOV2,
      r_log.VAL_NOV2,
      r_log.QTD_DEZ2,
      r_log.VAL_DEZ2,
      r_log.QTD_JAN3,
      r_log.VAL_JAN3,
      r_log.QTD_FEV3,
      r_log.VAL_FEV3,
      r_log.QTD_MAR3,
      r_log.VAL_MAR3,
      r_log.QTD_ABR3,
      r_log.VAL_ABR3,
      r_log.QTD_MAI3,
      r_log.VAL_MAI3,
      r_log.QTD_JUN3,
      r_log.VAL_JUN3,
      r_log.QTD_JUL3,
      r_log.VAL_JUL3,
      r_log.QTD_AGO3,
      r_log.VAL_AGO3,
      r_log.QTD_SET3,
      r_log.VAL_SET3,
      r_log.QTD_OUT3,
      r_log.VAL_OUT3,
      r_log.QTD_NOV3,
      r_log.VAL_NOV3,
      r_log.QTD_DEZ3,
      r_log.VAL_DEZ3,
      r_log.QTD_JAN4,
      r_log.VAL_JAN4,
      r_log.QTD_FEV4,
      r_log.VAL_FEV4,
      r_log.QTD_MAR4,
      r_log.VAL_MAR4,
      r_log.QTD_ABR4,
      r_log.VAL_ABR4,
      r_log.QTD_MAI4,
      r_log.VAL_MAI4,
      r_log.QTD_JUN4,
      r_log.VAL_JUN4,
      r_log.QTD_JUL4,
      r_log.VAL_JUL4,
      r_log.QTD_AGO4,
      r_log.VAL_AGO4,
      r_log.QTD_SET4,
      r_log.VAL_SET4,
      r_log.QTD_OUT4,
      r_log.VAL_OUT4,
      r_log.QTD_NOV4,
      r_log.VAL_NOV4,
      r_log.QTD_DEZ4,
      r_log.VAL_DEZ4,
      r_log.VL_UNITARIO_ITEM1,
      r_log.VL_UNITARIO_ITEM2,
      r_log.VL_UNITARIO_ITEM3,
      r_log.VL_UNITARIO_ITEM4,
      r_log.IN_DIMENSIONAMENTO,
      r_log.IND_CONTRATO,
      r_log.COD_CATALOGO,
      r_log.SEQ_CARGA_ANO_ORCAMENTO,
      r_log.FLG_TIPO_CONTA,
      r_log.FLG_LANCAMENTO,
      r_log.VAL_TOTAL_GESTOR,
      r_log.COD_DEPENDENCIA_AGRUPADORA,
      r_log.COD_DEPENDENCIA_ELABORACAO,
      r_log.FLG_PLURIANUAL,
      r_log.FLG_OPERACAO_INCLUSAO
     );
  --------------
  -- EXCLUSÃO --
  --------------
  ELSIF DELETING
  THEN
    insert into LOG_ITEM_PROP_ORC_SIMULADA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
      VSP_CD_NIVEL_VERSAO,
      VSP_CD_VERSAO,
      VSP_NR_ANO,
      DEP_CD_DEPENDENCIA,
      NR_ITEM,
      CC1_NR_CONTA,
      CC2_CD_CENTRO_CUSTO,
      CC2_CD_CENTRO_CUSTO_GERD,
      DEP_CD_DEPENDENCIA_GERD,
      PO_CD_PROGRAMA,
      PRJ_CD_PROJETO,
      IN_CENTRALIZADO,
      CD_PRIORIDADE,
      VL_UNITARIO_ITEM,
      NR_CONTRATO,
      DT_INICIO_CONTRATO,
      DT_TERMINO_CONTRATO,
      DS_JUSTIFICATIVA,
      DS_ITEM,
      NO_FORNECEDOR,
      DEP_CD_DEPENDENCIA_GEST,
      CC2_CD_CENTRO_CUSTO_GEST,
      GP_CD_GRUPO,
      QTD_JAN,
      VAL_JAN,
      QTD_FEV,
      VAL_FEV,
      QTD_MAR,
      VAL_MAR,
      QTD_ABR,
      VAL_ABR,
      QTD_MAI,
      VAL_MAI,
      QTD_JUN,
      VAL_JUN,
      QTD_JUL,
      VAL_JUL,
      QTD_AGO,
      VAL_AGO,
      QTD_SET,
      VAL_SET,
      QTD_OUT,
      VAL_OUT,
      QTD_NOV,
      VAL_NOV,
      QTD_DEZ,
      VAL_DEZ,
      QTD_JAN1,
      VAL_JAN1,
      QTD_FEV1,
      VAL_FEV1,
      QTD_MAR1,
      VAL_MAR1,
      QTD_ABR1,
      VAL_ABR1,
      QTD_MAI1,
      VAL_MAI1,
      QTD_JUN1,
      VAL_JUN1,
      QTD_JUL1,
      VAL_JUL1,
      QTD_AGO1,
      VAL_AGO1,
      QTD_SET1,
      VAL_SET1,
      QTD_OUT1,
      VAL_OUT1,
      QTD_NOV1,
      VAL_NOV1,
      QTD_DEZ1,
      VAL_DEZ1,
      QTD_JAN2,
      VAL_JAN2,
      QTD_FEV2,
      VAL_FEV2,
      QTD_MAR2,
      VAL_MAR2,
      QTD_ABR2,
      VAL_ABR2,
      QTD_MAI2,
      VAL_MAI2,
      QTD_JUN2,
      VAL_JUN2,
      QTD_JUL2,
      VAL_JUL2,
      QTD_AGO2,
      VAL_AGO2,
      QTD_SET2,
      VAL_SET2,
      QTD_OUT2,
      VAL_OUT2,
      QTD_NOV2,
      VAL_NOV2,
      QTD_DEZ2,
      VAL_DEZ2,
      QTD_JAN3,
      VAL_JAN3,
      QTD_FEV3,
      VAL_FEV3,
      QTD_MAR3,
      VAL_MAR3,
      QTD_ABR3,
      VAL_ABR3,
      QTD_MAI3,
      VAL_MAI3,
      QTD_JUN3,
      VAL_JUN3,
      QTD_JUL3,
      VAL_JUL3,
      QTD_AGO3,
      VAL_AGO3,
      QTD_SET3,
      VAL_SET3,
      QTD_OUT3,
      VAL_OUT3,
      QTD_NOV3,
      VAL_NOV3,
      QTD_DEZ3,
      VAL_DEZ3,
      QTD_JAN4,
      VAL_JAN4,
      QTD_FEV4,
      VAL_FEV4,
      QTD_MAR4,
      VAL_MAR4,
      QTD_ABR4,
      VAL_ABR4,
      QTD_MAI4,
      VAL_MAI4,
      QTD_JUN4,
      VAL_JUN4,
      QTD_JUL4,
      VAL_JUL4,
      QTD_AGO4,
      VAL_AGO4,
      QTD_SET4,
      VAL_SET4,
      QTD_OUT4,
      VAL_OUT4,
      QTD_NOV4,
      VAL_NOV4,
      QTD_DEZ4,
      VAL_DEZ4,
      VL_UNITARIO_ITEM1,
      VL_UNITARIO_ITEM2,
      VL_UNITARIO_ITEM3,
      VL_UNITARIO_ITEM4,
      IN_DIMENSIONAMENTO,
      IND_CONTRATO,
      COD_CATALOGO,
      SEQ_CARGA_ANO_ORCAMENTO,
      FLG_TIPO_CONTA,
      FLG_LANCAMENTO,
      VAL_TOTAL_GESTOR,
      COD_DEPENDENCIA_AGRUPADORA,
      COD_DEPENDENCIA_ELABORACAO,
      FLG_PLURIANUAL,
      FLG_OPERACAO_INCLUSAO
     )
    values
     (
      sysdate,
      user,
      'E',
      :old.VSP_CD_NIVEL_VERSAO,
      :old.VSP_CD_VERSAO,
      :old.VSP_NR_ANO,
      :old.DEP_CD_DEPENDENCIA,
      :old.NR_ITEM,
      :old.CC1_NR_CONTA,
      :old.CC2_CD_CENTRO_CUSTO,
      :old.CC2_CD_CENTRO_CUSTO_GERD,
      :old.DEP_CD_DEPENDENCIA_GERD,
      :old.PO_CD_PROGRAMA,
      :old.PRJ_CD_PROJETO,
      :old.IN_CENTRALIZADO,
      :old.CD_PRIORIDADE,
      :old.VL_UNITARIO_ITEM,
      :old.NR_CONTRATO,
      :old.DT_INICIO_CONTRATO,
      :old.DT_TERMINO_CONTRATO,
      :old.DS_JUSTIFICATIVA,
      :old.DS_ITEM,
      :old.NO_FORNECEDOR,
      :old.DEP_CD_DEPENDENCIA_GEST,
      :old.CC2_CD_CENTRO_CUSTO_GEST,
      :old.GP_CD_GRUPO,
      :old.QTD_JAN,
      :old.VAL_JAN,
      :old.QTD_FEV,
      :old.VAL_FEV,
      :old.QTD_MAR,
      :old.VAL_MAR,
      :old.QTD_ABR,
      :old.VAL_ABR,
      :old.QTD_MAI,
      :old.VAL_MAI,
      :old.QTD_JUN,
      :old.VAL_JUN,
      :old.QTD_JUL,
      :old.VAL_JUL,
      :old.QTD_AGO,
      :old.VAL_AGO,
      :old.QTD_SET,
      :old.VAL_SET,
      :old.QTD_OUT,
      :old.VAL_OUT,
      :old.QTD_NOV,
      :old.VAL_NOV,
      :old.QTD_DEZ,
      :old.VAL_DEZ,
      :old.QTD_JAN1,
      :old.VAL_JAN1,
      :old.QTD_FEV1,
      :old.VAL_FEV1,
      :old.QTD_MAR1,
      :old.VAL_MAR1,
      :old.QTD_ABR1,
      :old.VAL_ABR1,
      :old.QTD_MAI1,
      :old.VAL_MAI1,
      :old.QTD_JUN1,
      :old.VAL_JUN1,
      :old.QTD_JUL1,
      :old.VAL_JUL1,
      :old.QTD_AGO1,
      :old.VAL_AGO1,
      :old.QTD_SET1,
      :old.VAL_SET1,
      :old.QTD_OUT1,
      :old.VAL_OUT1,
      :old.QTD_NOV1,
      :old.VAL_NOV1,
      :old.QTD_DEZ1,
      :old.VAL_DEZ1,
      :old.QTD_JAN2,
      :old.VAL_JAN2,
      :old.QTD_FEV2,
      :old.VAL_FEV2,
      :old.QTD_MAR2,
      :old.VAL_MAR2,
      :old.QTD_ABR2,
      :old.VAL_ABR2,
      :old.QTD_MAI2,
      :old.VAL_MAI2,
      :old.QTD_JUN2,
      :old.VAL_JUN2,
      :old.QTD_JUL2,
      :old.VAL_JUL2,
      :old.QTD_AGO2,
      :old.VAL_AGO2,
      :old.QTD_SET2,
      :old.VAL_SET2,
      :old.QTD_OUT2,
      :old.VAL_OUT2,
      :old.QTD_NOV2,
      :old.VAL_NOV2,
      :old.QTD_DEZ2,
      :old.VAL_DEZ2,
      :old.QTD_JAN3,
      :old.VAL_JAN3,
      :old.QTD_FEV3,
      :old.VAL_FEV3,
      :old.QTD_MAR3,
      :old.VAL_MAR3,
      :old.QTD_ABR3,
      :old.VAL_ABR3,
      :old.QTD_MAI3,
      :old.VAL_MAI3,
      :old.QTD_JUN3,
      :old.VAL_JUN3,
      :old.QTD_JUL3,
      :old.VAL_JUL3,
      :old.QTD_AGO3,
      :old.VAL_AGO3,
      :old.QTD_SET3,
      :old.VAL_SET3,
      :old.QTD_OUT3,
      :old.VAL_OUT3,
      :old.QTD_NOV3,
      :old.VAL_NOV3,
      :old.QTD_DEZ3,
      :old.VAL_DEZ3,
      :old.QTD_JAN4,
      :old.VAL_JAN4,
      :old.QTD_FEV4,
      :old.VAL_FEV4,
      :old.QTD_MAR4,
      :old.VAL_MAR4,
      :old.QTD_ABR4,
      :old.VAL_ABR4,
      :old.QTD_MAI4,
      :old.VAL_MAI4,
      :old.QTD_JUN4,
      :old.VAL_JUN4,
      :old.QTD_JUL4,
      :old.VAL_JUL4,
      :old.QTD_AGO4,
      :old.VAL_AGO4,
      :old.QTD_SET4,
      :old.VAL_SET4,
      :old.QTD_OUT4,
      :old.VAL_OUT4,
      :old.QTD_NOV4,
      :old.VAL_NOV4,
      :old.QTD_DEZ4,
      :old.VAL_DEZ4,
      :old.VL_UNITARIO_ITEM1,
      :old.VL_UNITARIO_ITEM2,
      :old.VL_UNITARIO_ITEM3,
      :old.VL_UNITARIO_ITEM4,
      :old.IN_DIMENSIONAMENTO,
      :old.IND_CONTRATO,
      :old.COD_CATALOGO,
      :old.SEQ_CARGA_ANO_ORCAMENTO,
      :old.FLG_TIPO_CONTA,
      :old.FLG_LANCAMENTO,
      :old.VAL_TOTAL_GESTOR,
      :old.COD_DEPENDENCIA_AGRUPADORA,
      :old.COD_DEPENDENCIA_ELABORACAO,
      :old.FLG_PLURIANUAL,
      :old.FLG_OPERACAO_INCLUSAO
     );
  END IF;
END;
/


-- End of DDL Script for Trigger IFRSICOF.TRG_IPS_IUD_1

-- Start of DDL Script for Trigger IFRSICOF.TRG_ISP_IU_01
-- Generated 26/9/2005 16:23:14 from IFRSICOF@homolog

CREATE OR REPLACE TRIGGER ifrsicof.trg_isp_iu_01
 BEFORE
  INSERT OR UPDATE
 ON ifrsicof.item_solicitante_proposta
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  --------------------------
  -- DEPENDENCIAS / CHAVE --
  --------------------------
  cursor q_DEP
          (
           p_DEP_CD_DEPENDENCIA   number
          )
    is
    select DEP.CD_DEPENDENCIA_CHAVE
      from DEPENDENCIAS  DEP
      where DEP_CODIGO = p_DEP_CD_DEPENDENCIA;
  r_DEP  q_DEP%rowtype;
  --------------------------
  -- CENTRO_CUSTO / CHAVE --
  --------------------------
  cursor q_CC2
          (
           p_CC2_CD_CENTRO_CUSTO  number
          )
    is
    select CC2.CD_CENTRO_CUSTO_CHAVE
      from CENTRO_CUSTO CC2
      where CC2.CD_CENTRO_CUSTO = p_CC2_CD_CENTRO_CUSTO;
  r_CC2  q_CC2%rowtype;
  ----------------------------
  -- CONTA_CONTABIL / CHAVE --
  ----------------------------
  cursor q_CC1
          (
           p_CC1_NR_CONTA  varchar2
          )
    is
    select CC1.NR_CONTA_CHAVE
      from CONTA_CONTABIL  CC1
      where CC1.NR_CONTA = p_CC1_NR_CONTA;
  r_CC1  q_CC1%rowtype;
  ---------------------
  -- PROJETO / CHAVE --
  ---------------------
  cursor q_PRJ
          (
           p_PRJ_CD_PROJETO  varchar2
          )
    is
    select PRJ.CD_PROJETO_CHAVE
      from PROJETO  PRJ
      where PRJ.CD_PROJETO = p_PRJ_CD_PROJETO  ;
  r_PRJ  q_PRJ%rowtype;
  ------------------------------
  -- COMBINACAO_CHAVE / CHAVE --
  ------------------------------
  cursor q_CCH
          (
           p_NOM_CHAVE_DEPENDENCIA     varchar2,
           p_NOM_CHAVE_CENTRO_CUSTO    varchar2,
           p_NOM_CHAVE_CONTA_CONTABIL  varchar2,
           p_NOM_CHAVE_PROJETO         varchar2
          )
    is
    select '1'
      from COMBINACAO_CHAVE CCH
      where NOM_CHAVE_DEPENDENCIA = p_NOM_CHAVE_DEPENDENCIA
            and
            (
             p_NOM_CHAVE_CENTRO_CUSTO is not null
             and
             NOM_CHAVE_CENTRO_CUSTO = p_NOM_CHAVE_CENTRO_CUSTO
             or
             p_NOM_CHAVE_CENTRO_CUSTO is null
            )
            and
            NOM_CHAVE_CONTA_CONTABIL = p_NOM_CHAVE_CONTA_CONTABIL
            and
            (
             p_NOM_CHAVE_PROJETO is not null
             and
             NOM_CHAVE_PROJETO = p_NOM_CHAVE_PROJETO
             or
             p_NOM_CHAVE_PROJETO is null
            );
  r_CCH  q_CCH%rowtype;
  l_CCH  boolean;
BEGIN
  IF :new.VSP_NR_ANO <= 2005
  THEN
    GOTO SAIDA;
  END IF;
  --------------------------
  -- DEPENDENCIAS / CHAVE --
  --------------------------
  open q_DEP
        (
         :New.COD_DEPENDENCIA_SOLICITANTE
        );
  fetch q_DEP into r_DEP;
  close q_DEP;
  --------------------------
  -- CENTRO_CUSTO / CHAVE --
  --------------------------
  open q_CC2
        (
         :New.COD_CENTRO_CUSTO_SOLICITANTE
        );
  fetch q_CC2 into r_CC2;
  close q_CC2;
  ----------------------------
  -- CONTA_CONTABIL / CHAVE --
  ----------------------------
  open q_CC1
        (
         :New.NUM_CONTA_SOLICITANTE
        );
  fetch q_CC1 into r_CC1;
  close q_CC1;
  ---------------------
  -- PROJETO / CHAVE --
  ---------------------
  IF :New.COD_PROJETO <> '0000'
  THEN
    open q_PRJ
          (
           :New.COD_PROJETO
          );
    fetch q_PRJ into r_PRJ;
    close q_PRJ;
  END IF;
  ------------------------------
  -- COMBINACAO_CHAVE / CHAVE --
  ------------------------------
  open q_CCH
        (
         r_DEP.CD_DEPENDENCIA_CHAVE,
         r_CC2.CD_CENTRO_CUSTO_CHAVE,
         r_CC1.NR_CONTA_CHAVE,
         r_PRJ.CD_PROJETO_CHAVE
        );
  fetch q_CCH into r_CCH;
  l_CCH := q_CCH%found;
  close q_CCH;
  IF not l_CCH
  THEN
    RAISE_APPLICATION_ERROR
     (
      -20000,
      'Não foi encontrado combinação de chave contábil para
      Dep.     '||:new.COD_DEPENDENCIA_SOLICITANTE ||' ('||r_DEP.CD_DEPENDENCIA_CHAVE||'),
      Custo.   '||:New.COD_CENTRO_CUSTO_SOLICITANTE||' ('||r_CC2.CD_CENTRO_CUSTO_CHAVE||'), (Nulo para 11301002-Almoxarifado)
      Conta.   '||:New.NUM_CONTA_SOLICITANTE       ||' ('||r_CC1.NR_CONTA_CHAVE||'),
      Projeto. '||:New.COD_PROJETO                 ||' ('||r_PRJ.CD_PROJETO_CHAVE||') (Não obrigatória).'
     );
  END IF;
  <<SAIDA>>
  null;
END TRG_ISP_IU_01;
/


-- End of DDL Script for Trigger IFRSICOF.TRG_ISP_IU_01

-- Start of DDL Script for Trigger IFRSICOF.TRG_ISP_IUD_1
-- Generated 26/9/2005 16:23:14 from IFRSICOF@homolog

CREATE OR REPLACE TRIGGER ifrsicof.trg_isp_iud_1
 AFTER
  INSERT OR DELETE OR UPDATE
 ON ifrsicof.item_solicitante_proposta
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  r_LOG   LOG_ITEM_SOLICITANTE_PROPOSTA%RowType;
BEGIN
  --------------
  -- INCLUSÃO --
  --------------
  IF INSERTING
  THEN
    insert into LOG_ITEM_SOLICITANTE_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'I',
      :new.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      :new.VSP_NR_ANO,
      :new.VSP_CD_NIVEL_VERSAO,
      :new.COD_DEPENDENCIA_AGRUPADORA,
      :new.VSP_CD_VERSAO,
      :new.COD_DEPENDENCIA_ELABORACAO,
      :new.NR_ITEM,
      :new.COD_DEPENDENCIA_SOLICITANTE,
      :new.COD_CENTRO_CUSTO_SOLICITANTE,
      :new.NUM_CONTA_SOLICITANTE,
      :new.VAL_TOTAL_SOLICITANTE,
      :new.FLG_DIMENSIONAMENTO,
      :new.COD_PROJETO
     );
  ---------------
  -- ALTERAÇÃO --
  ---------------
  ELSIF UPDATING
  THEN
    r_log.SEQ_ITEM_SOLICITANTE_PROPOSTA := :new.SEQ_ITEM_SOLICITANTE_PROPOSTA;
    --
    IF :new.VSP_NR_ANO != :old.VSP_NR_ANO
    THEN
      r_log.VSP_NR_ANO := :new.VSP_NR_ANO;
    END IF;
    --
    IF :new.VSP_CD_NIVEL_VERSAO != :old.VSP_CD_NIVEL_VERSAO
    THEN
      r_log.VSP_CD_NIVEL_VERSAO := :new.VSP_CD_NIVEL_VERSAO;
    END IF;

    --
    IF :new.COD_DEPENDENCIA_AGRUPADORA != :old.COD_DEPENDENCIA_AGRUPADORA
    THEN
      r_log.COD_DEPENDENCIA_AGRUPADORA := :new.COD_DEPENDENCIA_AGRUPADORA;
    END IF;
    --
    IF :new.VSP_CD_VERSAO != :old.VSP_CD_VERSAO
    THEN
      r_log.VSP_CD_VERSAO := :new.VSP_CD_VERSAO;
    END IF;
    --
    IF :new.COD_DEPENDENCIA_ELABORACAO != :old.COD_DEPENDENCIA_ELABORACAO
    THEN
      r_log.COD_DEPENDENCIA_ELABORACAO := :new.COD_DEPENDENCIA_ELABORACAO;
    END IF;
    --
    IF :new.NR_ITEM != :old.NR_ITEM
    THEN
      r_log.NR_ITEM := :new.NR_ITEM;
    END IF;
    --
    IF :new.COD_DEPENDENCIA_SOLICITANTE != :old.COD_DEPENDENCIA_SOLICITANTE
    THEN
      r_log.COD_DEPENDENCIA_SOLICITANTE := :new.COD_DEPENDENCIA_SOLICITANTE;
    END IF;
    --
    IF :new.COD_CENTRO_CUSTO_SOLICITANTE != :old.COD_CENTRO_CUSTO_SOLICITANTE
    THEN
      r_log.COD_CENTRO_CUSTO_SOLICITANTE := :new.COD_CENTRO_CUSTO_SOLICITANTE;
    END IF;
    --
    IF :new.NUM_CONTA_SOLICITANTE != :old.NUM_CONTA_SOLICITANTE
    THEN
      r_log.NUM_CONTA_SOLICITANTE := :new.NUM_CONTA_SOLICITANTE;
    END IF;
    --
    IF :new.VAL_TOTAL_SOLICITANTE != :old.VAL_TOTAL_SOLICITANTE
    THEN
      r_log.VAL_TOTAL_SOLICITANTE := :new.VAL_TOTAL_SOLICITANTE;
    END IF;
    --
    IF :new.FLG_DIMENSIONAMENTO != :old.FLG_DIMENSIONAMENTO
    THEN
      r_log.FLG_DIMENSIONAMENTO := :new.FLG_DIMENSIONAMENTO;
    END IF;
    --
    IF :new.FLG_DIMENSIONAMENTO != :old.FLG_DIMENSIONAMENTO
    THEN
      r_log.FLG_DIMENSIONAMENTO := :new.FLG_DIMENSIONAMENTO;
    END IF;
    --
    IF :new.COD_PROJETO != :old.COD_PROJETO
    THEN
      r_log.COD_PROJETO := :new.COD_PROJETO;
    END IF;
    --
    insert into LOG_ITEM_SOLICITANTE_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'A',
      r_log.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      r_log.VSP_NR_ANO,
      r_log.VSP_CD_NIVEL_VERSAO,
      r_log.COD_DEPENDENCIA_AGRUPADORA,
      r_log.VSP_CD_VERSAO,
      r_log.COD_DEPENDENCIA_ELABORACAO,
      r_log.NR_ITEM,
      r_log.COD_DEPENDENCIA_SOLICITANTE,
      r_log.COD_CENTRO_CUSTO_SOLICITANTE,
      r_log.NUM_CONTA_SOLICITANTE,
      r_log.VAL_TOTAL_SOLICITANTE,
      r_log.FLG_DIMENSIONAMENTO,
      r_log.COD_PROJETO
     );
  --------------
  -- EXCLUSÃO --
  --------------
  ELSIF DELETING
  THEN
    insert into LOG_ITEM_SOLICITANTE_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'E',
      :old.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      :old.VSP_NR_ANO,
      :old.VSP_CD_NIVEL_VERSAO,
      :old.COD_DEPENDENCIA_AGRUPADORA,
      :old.VSP_CD_VERSAO,
      :old.COD_DEPENDENCIA_ELABORACAO,
      :old.NR_ITEM,
      :old.COD_DEPENDENCIA_SOLICITANTE,
      :old.COD_CENTRO_CUSTO_SOLICITANTE,
      :old.NUM_CONTA_SOLICITANTE,
      :old.VAL_TOTAL_SOLICITANTE,
      :old.FLG_DIMENSIONAMENTO,
      :old.COD_PROJETO
     );
  END IF;
END;
/


-- End of DDL Script for Trigger IFRSICOF.TRG_ISP_IUD_1

-- Start of DDL Script for Trigger IFRSICOF.TRG_PSP_IUD_1
-- Generated 26/9/2005 16:23:15 from IFRSICOF@homolog

CREATE OR REPLACE TRIGGER ifrsicof.trg_psp_iud_1
 AFTER
  INSERT OR DELETE OR UPDATE
 ON ifrsicof.programacao_solic_proposta
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
  r_LOG   LOG_PROGRAMACAO_SOLIC_PROPOSTA%RowType;
BEGIN
  --------------
  -- INCLUSÃO --
  --------------
  IF INSERTING
  THEN
    insert into LOG_PROGRAMACAO_SOLIC_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'I',
      :new.SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
      :new.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      :new.NUM_ANO,
      :new.VAL_JANEIRO,
      :new.VAL_FEVEREIRO,
      :new.VAL_MARCO,
      :new.VAL_ABRIL,
      :new.VAL_MAIO,
      :new.VAL_JUNHO,
      :new.VAL_JULHO,
      :new.VAL_AGOSTO,
      :new.VAL_SETEMBRO,
      :new.VAL_OUTUBRO,
      :new.VAL_NOVEMBRO,
      :new.VAL_DEZEMBRO,
      :new.VAL_UNITARIO,
      :new.QTD_JANEIRO,
      :new.QTD_FEVEREIRO,
      :new.QTD_MARCO,
      :new.QTD_ABRIL,
      :new.QTD_MAIO,
      :new.QTD_JUNHO,
      :new.QTD_JULHO,
      :new.QTD_AGOSTO,
      :new.QTD_SETEMBRO,
      :new.QTD_OUTUBRO,
      :new.QTD_NOVEMBRO,
      :new.QTD_DEZEMBRO
     );
  ---------------
  -- ALTERAÇÃO --
  ---------------
  ELSIF UPDATING
  THEN
    r_log.SEQ_PROGRAMACAO_SOLIC_PROPOSTA := :new.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
    --
    IF :new.SEQ_ITEM_SOLICITANTE_PROPOSTA != :old.SEQ_ITEM_SOLICITANTE_PROPOSTA
    THEN
      r_log.SEQ_ITEM_SOLICITANTE_PROPOSTA := :new.SEQ_ITEM_SOLICITANTE_PROPOSTA;
    END IF;
    IF :new.NUM_ANO       != :old.NUM_ANO       THEN r_log.NUM_ANO       := :new.NUM_ANO      ; END IF;
    IF :new.VAL_JANEIRO   != :old.VAL_JANEIRO   THEN r_log.VAL_JANEIRO   := :new.VAL_JANEIRO  ; END IF;
    IF :new.VAL_FEVEREIRO != :old.VAL_FEVEREIRO THEN r_log.VAL_FEVEREIRO := :new.VAL_FEVEREIRO; END IF;
    IF :new.VAL_MARCO     != :old.VAL_MARCO     THEN r_log.VAL_MARCO     := :new.VAL_MARCO    ; END IF;
    IF :new.VAL_ABRIL     != :old.VAL_ABRIL     THEN r_log.VAL_ABRIL     := :new.VAL_ABRIL    ; END IF;
    IF :new.VAL_MAIO      != :old.VAL_MAIO      THEN r_log.VAL_MAIO      := :new.VAL_MAIO     ; END IF;
    IF :new.VAL_JUNHO     != :old.VAL_JUNHO     THEN r_log.VAL_JUNHO     := :new.VAL_JUNHO    ; END IF;
    IF :new.VAL_JULHO     != :old.VAL_JULHO     THEN r_log.VAL_JULHO     := :new.VAL_JULHO    ; END IF;
    IF :new.VAL_AGOSTO    != :old.VAL_AGOSTO    THEN r_log.VAL_AGOSTO    := :new.VAL_AGOSTO   ; END IF;
    IF :new.VAL_SETEMBRO  != :old.VAL_SETEMBRO  THEN r_log.VAL_SETEMBRO  := :new.VAL_SETEMBRO ; END IF;
    IF :new.VAL_OUTUBRO   != :old.VAL_OUTUBRO   THEN r_log.VAL_OUTUBRO   := :new.VAL_OUTUBRO  ; END IF;
    IF :new.VAL_NOVEMBRO  != :old.VAL_NOVEMBRO  THEN r_log.VAL_NOVEMBRO  := :new.VAL_NOVEMBRO ; END IF;
    IF :new.VAL_DEZEMBRO  != :old.VAL_DEZEMBRO  THEN r_log.VAL_DEZEMBRO  := :new.VAL_DEZEMBRO ; END IF;
    IF :new.VAL_UNITARIO  != :old.VAL_UNITARIO  THEN r_log.VAL_UNITARIO  := :new.VAL_UNITARIO ; END IF;
    IF :new.QTD_JANEIRO   != :old.QTD_JANEIRO   THEN r_log.QTD_JANEIRO   := :new.QTD_JANEIRO  ; END IF;
    IF :new.QTD_FEVEREIRO != :old.QTD_FEVEREIRO THEN r_log.QTD_FEVEREIRO := :new.QTD_FEVEREIRO; END IF;
    IF :new.QTD_MARCO     != :old.QTD_MARCO     THEN r_log.QTD_MARCO     := :new.QTD_MARCO    ; END IF;
    IF :new.QTD_ABRIL     != :old.QTD_ABRIL     THEN r_log.QTD_ABRIL     := :new.QTD_ABRIL    ; END IF;
    IF :new.QTD_MAIO      != :old.QTD_MAIO      THEN r_log.QTD_MAIO      := :new.QTD_MAIO     ; END IF;
    IF :new.QTD_JUNHO     != :old.QTD_JUNHO     THEN r_log.QTD_JUNHO     := :new.QTD_JUNHO    ; END IF;
    IF :new.QTD_JULHO     != :old.QTD_JULHO     THEN r_log.QTD_JULHO     := :new.QTD_JULHO    ; END IF;
    IF :new.QTD_AGOSTO    != :old.QTD_AGOSTO    THEN r_log.QTD_AGOSTO    := :new.QTD_AGOSTO   ; END IF;
    IF :new.QTD_SETEMBRO  != :old.QTD_SETEMBRO  THEN r_log.QTD_SETEMBRO  := :new.QTD_SETEMBRO ; END IF;
    IF :new.QTD_OUTUBRO   != :old.QTD_OUTUBRO   THEN r_log.QTD_OUTUBRO   := :new.QTD_OUTUBRO  ; END IF;
    IF :new.QTD_NOVEMBRO  != :old.QTD_NOVEMBRO  THEN r_log.QTD_NOVEMBRO  := :new.QTD_NOVEMBRO ; END IF;
    IF :new.QTD_DEZEMBRO  != :old.QTD_DEZEMBRO  THEN r_log.QTD_DEZEMBRO  := :new.QTD_DEZEMBRO ; END IF;
    --
    insert into LOG_PROGRAMACAO_SOLIC_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'A',
      r_log.SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
      r_log.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      r_log.NUM_ANO,
      r_log.VAL_JANEIRO,
      r_log.VAL_FEVEREIRO,
      r_log.VAL_MARCO,
      r_log.VAL_ABRIL,
      r_log.VAL_MAIO,
      r_log.VAL_JUNHO,
      r_log.VAL_JULHO,
      r_log.VAL_AGOSTO,
      r_log.VAL_SETEMBRO,
      r_log.VAL_OUTUBRO,
      r_log.VAL_NOVEMBRO,
      r_log.VAL_DEZEMBRO,
      r_log.VAL_UNITARIO,
      r_log.QTD_JANEIRO,
      r_log.QTD_FEVEREIRO,
      r_log.QTD_MARCO,
      r_log.QTD_ABRIL,
      r_log.QTD_MAIO,
      r_log.QTD_JUNHO,
      r_log.QTD_JULHO,
      r_log.QTD_AGOSTO,
      r_log.QTD_SETEMBRO,
      r_log.QTD_OUTUBRO,
      r_log.QTD_NOVEMBRO,
      r_log.QTD_DEZEMBRO
     );
  --------------
  -- EXCLUSÃO --
  --------------
  ELSIF DELETING
  THEN
    insert into LOG_PROGRAMACAO_SOLIC_PROPOSTA
     (
      DAT_OPERACAO,
      COD_USUARIO,
      TIP_OPERACAO,
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
      sysdate,
      user,
      'E',
      :old.SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
      :old.SEQ_ITEM_SOLICITANTE_PROPOSTA,
      :old.NUM_ANO,
      :old.VAL_JANEIRO,
      :old.VAL_FEVEREIRO,
      :old.VAL_MARCO,
      :old.VAL_ABRIL,
      :old.VAL_MAIO,
      :old.VAL_JUNHO,
      :old.VAL_JULHO,
      :old.VAL_AGOSTO,
      :old.VAL_SETEMBRO,
      :old.VAL_OUTUBRO,
      :old.VAL_NOVEMBRO,
      :old.VAL_DEZEMBRO,
      :old.VAL_UNITARIO,
      :old.QTD_JANEIRO,
      :old.QTD_FEVEREIRO,
      :old.QTD_MARCO,
      :old.QTD_ABRIL,
      :old.QTD_MAIO,
      :old.QTD_JUNHO,
      :old.QTD_JULHO,
      :old.QTD_AGOSTO,
      :old.QTD_SETEMBRO,
      :old.QTD_OUTUBRO,
      :old.QTD_NOVEMBRO,
      :old.QTD_DEZEMBRO
     );
  END IF;
END;
/


-- End of DDL Script for Trigger IFRSICOF.TRG_PSP_IUD_1

