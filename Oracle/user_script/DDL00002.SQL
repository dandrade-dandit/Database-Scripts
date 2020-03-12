CREATE OR REPLACE PACKAGE BODY APROVACAO
Is
FUNCTION Valor_Ano_Seguinte
           (
            v_rowid VARCHAR2,
            v_tipo  VARCHAR2
           ) RETURN NUMBER IS
    CURSOR C_VALOR_DESP IS
        SELECT NVL(lITENS.VL_UNITARIO_ITEM1, 0)*(
                    NVL(lITENS.QTD_JAN1, 0) +
                    NVL(lITENS.QTD_FEV1, 0) +
                    NVL(lITENS.QTD_MAR1, 0) +
                    NVL(lITENS.QTD_ABR1, 0) +
                    NVL(lITENS.QTD_MAI1, 0) +
                    NVL(lITENS.QTD_JUN1, 0) +
                    NVL(lITENS.QTD_JUL1, 0) +
                    NVL(lITENS.QTD_AGO1, 0) +
                    NVL(lITENS.QTD_SET1, 0) +
                    NVL(lITENS.QTD_OUT1, 0) +
                    NVL(lITENS.QTD_NOV1, 0) +
                    NVL(lITENS.QTD_DEZ1, 0)) + 
                    NVL(lITENS.VAL_JAN1, 0) +
                    NVL(lITENS.VAL_FEV1, 0) +
                    NVL(lITENS.VAL_MAR1, 0) +
                    NVL(lITENS.VAL_ABR1, 0) +
                    NVL(lITENS.VAL_MAI1, 0) +
                    NVL(lITENS.VAL_JUN1, 0) +
                    NVL(lITENS.VAL_JUL1, 0) +
                    NVL(lITENS.VAL_AGO1, 0) +
                    NVL(lITENS.VAL_SET1, 0) +
                    NVL(lITENS.VAL_OUT1, 0) +
                    NVL(lITENS.VAL_NOV1, 0) +
                    NVL(lITENS.VAL_DEZ1, 0) +
                    NVL(lITENS.VL_UNITARIO_ITEM2, 0)*(
                    NVL(lITENS.QTD_JAN2, 0) +
                    NVL(lITENS.QTD_FEV2, 0) +
                    NVL(lITENS.QTD_MAR2, 0) +
                    NVL(lITENS.QTD_ABR2, 0) +
                    NVL(lITENS.QTD_MAI2, 0) +
                    NVL(lITENS.QTD_JUN2, 0) +
                    NVL(lITENS.QTD_JUL2, 0) +
                    NVL(lITENS.QTD_AGO2, 0) +
                    NVL(lITENS.QTD_SET2, 0) +
                    NVL(lITENS.QTD_OUT2, 0) +
                    NVL(lITENS.QTD_NOV2, 0) +
                    NVL(lITENS.QTD_DEZ2, 0)) + 
                    NVL(lITENS.VAL_JAN2, 0) +
                    NVL(lITENS.VAL_FEV2, 0) +
                    NVL(lITENS.VAL_MAR2, 0) +
                    NVL(lITENS.VAL_ABR2, 0) +
                    NVL(lITENS.VAL_MAI2, 0) +
                    NVL(lITENS.VAL_JUN2, 0) +
                    NVL(lITENS.VAL_JUL2, 0) +
                    NVL(lITENS.VAL_AGO2, 0) +
                    NVL(lITENS.VAL_SET2, 0) +
                    NVL(lITENS.VAL_OUT2, 0) +
                    NVL(lITENS.VAL_NOV2, 0) +
                    NVL(lITENS.VAL_DEZ2, 0) +
                    NVL(lITENS.VL_UNITARIO_ITEM3, 0)*(
                    NVL(lITENS.QTD_JAN3, 0) +
                    NVL(lITENS.QTD_FEV3, 0) +
                    NVL(lITENS.QTD_MAR3, 0) +
                    NVL(lITENS.QTD_ABR3, 0) +
                    NVL(lITENS.QTD_MAI3, 0) +
                    NVL(lITENS.QTD_JUN3, 0) +
                    NVL(lITENS.QTD_JUL3, 0) +
                    NVL(lITENS.QTD_AGO3, 0) +
                    NVL(lITENS.QTD_SET3, 0) +
                    NVL(lITENS.QTD_OUT3, 0) +
                    NVL(lITENS.QTD_NOV3, 0) +
                    NVL(lITENS.QTD_DEZ3, 0)) + 
                    NVL(lITENS.VAL_JAN3, 0) +
                    NVL(lITENS.VAL_FEV3, 0) +
                    NVL(lITENS.VAL_MAR3, 0) +
                    NVL(lITENS.VAL_ABR3, 0) +
                    NVL(lITENS.VAL_MAI3, 0) +
                    NVL(lITENS.VAL_JUN3, 0) +
                    NVL(lITENS.VAL_JUL3, 0) +
                    NVL(lITENS.VAL_AGO3, 0) +
                    NVL(lITENS.VAL_SET3, 0) +
                    NVL(lITENS.VAL_OUT3, 0) +
                    NVL(lITENS.VAL_NOV3, 0) +
                    NVL(lITENS.VAL_DEZ3, 0) +
                    NVL(lITENS.VL_UNITARIO_ITEM4, 0)*(
                    NVL(lITENS.QTD_JAN4, 0) +
                    NVL(lITENS.QTD_FEV4, 0) +
                    NVL(lITENS.QTD_MAR4, 0) +
                    NVL(lITENS.QTD_ABR4, 0) +
                    NVL(lITENS.QTD_MAI4, 0) +
                    NVL(lITENS.QTD_JUN4, 0) +
                    NVL(lITENS.QTD_JUL4, 0) +
                    NVL(lITENS.QTD_AGO4, 0) +
                    NVL(lITENS.QTD_SET4, 0) +
                    NVL(lITENS.QTD_OUT4, 0) +
                    NVL(lITENS.QTD_NOV4, 0) +
                    NVL(lITENS.QTD_DEZ4, 0)) + 
                    NVL(lITENS.VAL_JAN4, 0) +
                    NVL(lITENS.VAL_FEV4, 0) +
                    NVL(lITENS.VAL_MAR4, 0) +
                    NVL(lITENS.VAL_ABR4, 0) +
                    NVL(lITENS.VAL_MAI4, 0) +
                    NVL(lITENS.VAL_JUN4, 0) +
                    NVL(lITENS.VAL_JUL4, 0) +
                    NVL(lITENS.VAL_AGO4, 0) +
                    NVL(lITENS.VAL_SET4, 0) +
                    NVL(lITENS.VAL_OUT4, 0) +
                    NVL(lITENS.VAL_NOV4, 0) +
                    NVL(lITENS.VAL_DEZ4, 0)
      FROM ITEM_PROPOSTA_ORC_SIMULADA lITENS
     WHERE ROWID = v_rowid;

    CURSOR C_VALOR_REC IS
        SELECT      NVL(lITENS.VAL_JAN1, 0) +
                    NVL(lITENS.VAL_FEV1, 0) +
                    NVL(lITENS.VAL_MAR1, 0) +
                    NVL(lITENS.VAL_ABR1, 0) +
                    NVL(lITENS.VAL_MAI1, 0) +
                    NVL(lITENS.VAL_JUN1, 0) +
                    NVL(lITENS.VAL_JUL1, 0) +
                    NVL(lITENS.VAL_AGO1, 0) +
                    NVL(lITENS.VAL_SET1, 0) +
                    NVL(lITENS.VAL_OUT1, 0) +
                    NVL(lITENS.VAL_NOV1, 0) +
                    NVL(lITENS.VAL_DEZ1, 0) +
                    NVL(lITENS.VAL_JAN2, 0) +
                    NVL(lITENS.VAL_FEV2, 0) +
                    NVL(lITENS.VAL_MAR2, 0) +
                    NVL(lITENS.VAL_ABR2, 0) +
                    NVL(lITENS.VAL_MAI2, 0) +
                    NVL(lITENS.VAL_JUN2, 0) +
                    NVL(lITENS.VAL_JUL2, 0) +
                    NVL(lITENS.VAL_AGO2, 0) +
                    NVL(lITENS.VAL_SET2, 0) +
                    NVL(lITENS.VAL_OUT2, 0) +
                    NVL(lITENS.VAL_NOV2, 0) +
                    NVL(lITENS.VAL_DEZ2, 0) +
                    NVL(lITENS.VAL_JAN3, 0) +
                    NVL(lITENS.VAL_FEV3, 0) +
                    NVL(lITENS.VAL_MAR3, 0) +
                    NVL(lITENS.VAL_ABR3, 0) +
                    NVL(lITENS.VAL_MAI3, 0) +
                    NVL(lITENS.VAL_JUN3, 0) +
                    NVL(lITENS.VAL_JUL3, 0) +
                    NVL(lITENS.VAL_AGO3, 0) +
                    NVL(lITENS.VAL_SET3, 0) +
                    NVL(lITENS.VAL_OUT3, 0) +
                    NVL(lITENS.VAL_NOV3, 0) +
                    NVL(lITENS.VAL_DEZ3, 0) +
                    NVL(lITENS.VAL_JAN4, 0) +
                    NVL(lITENS.VAL_FEV4, 0) +
                    NVL(lITENS.VAL_MAR4, 0) +
                    NVL(lITENS.VAL_ABR4, 0) +
                    NVL(lITENS.VAL_MAI4, 0) +
                    NVL(lITENS.VAL_JUN4, 0) +
                    NVL(lITENS.VAL_JUL4, 0) +
                    NVL(lITENS.VAL_AGO4, 0) +
                    NVL(lITENS.VAL_SET4, 0) +
                    NVL(lITENS.VAL_OUT4, 0) +
                    NVL(lITENS.VAL_NOV4, 0) +
                    NVL(lITENS.VAL_DEZ4, 0)
      FROM PROJECAO_RECEITA_SIMULADA lITENS
     WHERE ROWID = v_rowid;
    v_retorno NUMBER := 0;
BEGIN
    if v_tipo = 'DESPESA' then
        open c_valor_desp;
        fetch c_valor_desp into v_retorno;
        close c_valor_desp;
    elsif v_tipo = 'RECEITA' then
        open c_valor_rec;
        fetch c_valor_rec into v_retorno;
        close c_valor_rec;
    end if;
  return v_retorno;
END;
PROCEDURE PROPOSTA 
           (
            pNR_ANO   Number
           )
  Is
  ---------------------------
  -- DEPENDÊNCIAS ORÇADAS  --
  ---------------------------
  Cursor cuDEP_ORCADAS
          (
           pNR_ANO  Number
          )
    Is
    Select CD_DEPENDENCIA
      From DEPENDENCIAS_SICOF DEP
      Where DEP.DT_CRIACAO
            <= 
            to_date('31/12/'||to_char(pNR_ANO),'DD/MM/YYYY') 
            And
            (
             DEP.DT_EXTINCAO IS NULL
             Or
             to_date('01/01/'||to_char(pNR_ANO) ,'DD/MM/YYYY') 
             <= 
             DEP.DT_EXTINCAO
            )
            And
            DEP.CD_DEPENDENCIA NOT IN (SELECT VSP.DEP_CD_DEPENDENCIA
                                         FROM VERSAO_SIMULACAO_PROPOSTA_ORC VSP
                                         WHERE VSP.CD_NIVEL_VERSAO = '1'
                                               AND 
                                               VSP.CD_VERSAO = '1'
                                               AND 
                                               VSP.NR_ANO = pNR_ANO + 1)
      Connect By Prior CD_DEPENDENCIA = DEP_CD_DEPENDENCIA
      Start With CD_DEPENDENCIA = 1
      Order By 1;
BEGIN
  FOR nDEP_ORCADAS In cuDEP_ORCADAS(pNR_ANO) LOOP
    BEGIN
      Insert Into VERSAO_SIMULACAO_PROPOSTA_ORC
        (
         DEP_CD_DEPENDENCIA,
         CD_VERSAO,
         CD_NIVEL_VERSAO,
         NR_ANO,
         DS_VERSAO,
         IN_ESCOLHIDA,
         VSP_CD_VERSAO,
         VSP_CD_NIVEL_VERSAO,
         VSP_NR_ANO,
         TP_MOEDA,
         VSP_DEP_CD_DEPENDENCIA,
         IN_LIBERADA
        )
        Values
        (
         nDEP_ORCADAS.CD_DEPENDENCIA,
         '1',
         '1',
         pNR_ANO+1,
         'VERSAO ORIGINAL',
         0,
         NULL,
         NULL,
         NULL,
         1,
         NULL,
         0
        );
      COMMIT;  
    EXCEPTION
        When DUP_VAL_ON_INDEX then
          NULL;
        When OTHERS then
          Raise_Application_Error(-20000,'Tabela VERSAO_SIMULACAO_PROPOSTA_ORC: '||SQLERRM);
    END;
  END LOOP;
EXCEPTION
  When OTHERS then
    Raise_Application_Error(-20000,'PROPOSTA: '||SQLERRM);
END PROPOSTA;
-------------
-- RECEITA --
-------------
PROCEDURE RECEITA
           (
            pNR_ANO          Number,
            pCD_VERSAO       Number,
            pEXISTE_PROPOSTA Boolean
           )
Is
  ---------------------------------------------------------------------------
  -- RECEITA
  --------------------------------------------------------------------------- 
  Cursor cuVERIF_RECEITA
    (
     pNR_ANO     Number
    )
    Is
    Select '1'
      From RECEITAS_ORCAMENTO ROR
      Where ROR.NRO_ANO = pNR_ANO;
  Cursor cuVERIF_PROJECAO_ANO_SEGUINTE
    (
     pNR_ANO     Number
    )
    Is
    Select '1'
      From PROJECAO_RECEITA_SIMULADA PRS
      Where PRS.VSP_NR_ANO = pNR_ANO;
  Cursor cuRECEITA
    (
     pNR_ANO     Number,
     pCD_VERSAO  Number
    )
    Is
    Select PRS.ROWID,
           PRS.DEP_CD_DEPENDENCIA        COD_DEPENDENCIA,
           PRS.CC1_NR_CONTA              NRO_CONTA,
           PRS.TAR_CD_REGIME             COD_REGIME,
           PRS.NR_SEQ                    NRO_RECEITA,
           PRS.VAL_JAN                   VAL_JAN,
           PRS.VAL_FEV                   VAL_FEV,
           PRS.VAL_MAR                   VAL_MAR,
           PRS.VAL_ABR                   VAL_ABR,
           PRS.VAL_MAI                   VAL_MAI,
           PRS.VAL_JUN                   VAL_JUN,
           PRS.VAL_JUL                   VAL_JUL,
           PRS.VAL_AGO                   VAL_AGO,
           PRS.VAL_SET                   VAL_SET,
           PRS.VAL_OUT                   VAL_OUT,
           PRS.VAL_NOV                   VAL_NOV,
           PRS.VAL_DEZ                   VAL_DEZ,
           PRS.VAL_JAN1                  VAL_JAN1,
           PRS.VAL_FEV1                  VAL_FEV1,
           PRS.VAL_MAR1                  VAL_MAR1,
           PRS.VAL_ABR1                  VAL_ABR1,
           PRS.VAL_MAI1                  VAL_MAI1,
           PRS.VAL_JUN1                  VAL_JUN1,
           PRS.VAL_JUL1                  VAL_JUL1,
           PRS.VAL_AGO1                  VAL_AGO1,
           PRS.VAL_SET1                  VAL_SET1,
           PRS.VAL_OUT1                  VAL_OUT1,
           PRS.VAL_NOV1                  VAL_NOV1,
           PRS.VAL_DEZ1                  VAL_DEZ1,
           PRS.VAL_JAN2                  VAL_JAN2,
           PRS.VAL_FEV2                  VAL_FEV2,
           PRS.VAL_MAR2                  VAL_MAR2,
           PRS.VAL_ABR2                  VAL_ABR2,
           PRS.VAL_MAI2                  VAL_MAI2,
           PRS.VAL_JUN2                  VAL_JUN2,
           PRS.VAL_JUL2                  VAL_JUL2,
           PRS.VAL_AGO2                  VAL_AGO2,
           PRS.VAL_SET2                  VAL_SET2,
           PRS.VAL_OUT2                  VAL_OUT2,
           PRS.VAL_NOV2                  VAL_NOV2,
           PRS.VAL_DEZ2                  VAL_DEZ2,
           PRS.VAL_JAN3                  VAL_JAN3,
           PRS.VAL_FEV3                  VAL_FEV3,
           PRS.VAL_MAR3                  VAL_MAR3,
           PRS.VAL_ABR3                  VAL_ABR3,
           PRS.VAL_MAI3                  VAL_MAI3,
           PRS.VAL_JUN3                  VAL_JUN3,
           PRS.VAL_JUL3                  VAL_JUL3,
           PRS.VAL_AGO3                  VAL_AGO3,
           PRS.VAL_SET3                  VAL_SET3,
           PRS.VAL_OUT3                  VAL_OUT3,
           PRS.VAL_NOV3                  VAL_NOV3,
           PRS.VAL_DEZ3                  VAL_DEZ3,
           PRS.VAL_JAN4                  VAL_JAN4,
           PRS.VAL_FEV4                  VAL_FEV4,
           PRS.VAL_MAR4                  VAL_MAR4,
           PRS.VAL_ABR4                  VAL_ABR4,
           PRS.VAL_MAI4                  VAL_MAI4,
           PRS.VAL_JUN4                  VAL_JUN4,
           PRS.VAL_JUL4                  VAL_JUL4,
           PRS.VAL_AGO4                  VAL_AGO4,
           PRS.VAL_SET4                  VAL_SET4,
           PRS.VAL_OUT4                  VAL_OUT4,
           PRS.VAL_NOV4                  VAL_NOV4,
           PRS.VAL_DEZ4                  VAL_DEZ4
      From PROJECAO_RECEITA_SIMULADA PRS
      Where PRS.VSP_NR_ANO = pNR_ANO
            And
            PRS.VSP_CD_NIVEL_VERSAO = '3'
            And
            PRS.VSP_CD_VERSAO = pCD_VERSAO
      Order By 1;
  cFETCH Varchar2(1);
  lFOUND Boolean;
  val_Ano_Seguinte NUMBER := 0;
BEGIN
  --
  -- VERIFICAÇÃO RECEITA PREVIAMENTE CARREGADA
  --
  Open cuVERIF_RECEITA(pNR_ANO);
  Fetch cuVERIF_RECEITA Into cFETCH;
  lFOUND := cuVERIF_RECEITA%Found;
  Close cuVERIF_RECEITA;
  IF lFOUND = TRUE THEN
    Raise_Application_Error(-20000,'Orçamento Aprovado de Receita foi carregada anteriormente. '||SQLERRM);
  ELSE
    Open cuVERIF_PROJECAO_ANO_SEGUINTE(pNR_ANO+1);
    Fetch cuVERIF_PROJECAO_ANO_SEGUINTE Into cFETCH;
    lFOUND := cuVERIF_PROJECAO_ANO_SEGUINTE%Found;
    Close cuVERIF_PROJECAO_ANO_SEGUINTE;
    --
    -- CARGA DA RECEITA EM APROVADO E ANO SEGUINTE ORÇAMENTO
    --
    FOR lRECEITA In cuRECEITA
                    (
                     pNR_ANO,
                     pCD_VERSAO
                    ) LOOP
      BEGIN
        INSERT INTO RECEITAS_ORCAMENTO
          (
           NRO_ANO,                  COD_DEPENDENCIA,          NRO_RECEITA,
           NRO_CONTA,                COD_REGIME,               VAL_JAN,
           VAL_FEV,                  VAL_MAR,                  VAL_ABR,
           VAL_MAI,                  VAL_JUN,                  VAL_JUL,
           VAL_AGO,                  VAL_SET,                  VAL_OUT,
           VAL_NOV,                  VAL_DEZ,                  VAL_JAN1,
           VAL_FEV1,                 VAL_MAR1,                 VAL_ABR1,
           VAL_MAI1,                 VAL_JUN1,                 VAL_JUL1,
           VAL_AGO1,                 VAL_SET1,                 VAL_OUT1,
           VAL_NOV1,                 VAL_DEZ1,                 VAL_JAN2,
           VAL_FEV2,                 VAL_MAR2,                 VAL_ABR2,
           VAL_MAI2,                 VAL_JUN2,                 VAL_JUL2,
           VAL_AGO2,                 VAL_SET2,                 VAL_OUT2,
           VAL_NOV2,                 VAL_DEZ2,                 VAL_JAN3,
           VAL_FEV3,                 VAL_MAR3,                 VAL_ABR3,
           VAL_MAI3,                 VAL_JUN3,                 VAL_JUL3,
           VAL_AGO3,                 VAL_SET3,                 VAL_OUT3,
           VAL_NOV3,                 VAL_DEZ3,                 VAL_JAN4,
           VAL_FEV4,                 VAL_MAR4,                 VAL_ABR4,
           VAL_MAI4,                 VAL_JUN4,                 VAL_JUL4,
           VAL_AGO4,                 VAL_SET4,                 VAL_OUT4,
           VAL_NOV4,                 VAL_DEZ4 )
          VALUES
          (
           pNR_ANO,                  lRECEITA.COD_DEPENDENCIA, lRECEITA.NRO_RECEITA,
           lRECEITA.NRO_CONTA,       lRECEITA.COD_REGIME,      lRECEITA.VAL_JAN,
           lRECEITA.VAL_FEV,         lRECEITA.VAL_MAR,         lRECEITA.VAL_ABR,
           lRECEITA.VAL_MAI,         lRECEITA.VAL_JUN,         lRECEITA.VAL_JUL,
           lRECEITA.VAL_AGO,         lRECEITA.VAL_SET,         lRECEITA.VAL_OUT,
           lRECEITA.VAL_NOV,         lRECEITA.VAL_DEZ,         lRECEITA.VAL_JAN1,
           lRECEITA.VAL_FEV1,        lRECEITA.VAL_MAR1,        lRECEITA.VAL_ABR1,
           lRECEITA.VAL_MAI1,        lRECEITA.VAL_JUN1,        lRECEITA.VAL_JUL1,
           lRECEITA.VAL_AGO1,        lRECEITA.VAL_SET1,        lRECEITA.VAL_OUT1,
           lRECEITA.VAL_NOV1,        lRECEITA.VAL_DEZ1,        lRECEITA.VAL_JAN2,
           lRECEITA.VAL_FEV2,        lRECEITA.VAL_MAR2,        lRECEITA.VAL_ABR2,
           lRECEITA.VAL_MAI2,        lRECEITA.VAL_JUN2,        lRECEITA.VAL_JUL2,
           lRECEITA.VAL_AGO2,        lRECEITA.VAL_SET2,        lRECEITA.VAL_OUT2,
           lRECEITA.VAL_NOV2,        lRECEITA.VAL_DEZ2,        lRECEITA.VAL_JAN3,
           lRECEITA.VAL_FEV3,        lRECEITA.VAL_MAR3,        lRECEITA.VAL_ABR3,
           lRECEITA.VAL_MAI3,        lRECEITA.VAL_JUN3,        lRECEITA.VAL_JUL3,
           lRECEITA.VAL_AGO3,        lRECEITA.VAL_SET3,        lRECEITA.VAL_OUT3,
           lRECEITA.VAL_NOV3,        lRECEITA.VAL_DEZ3,        lRECEITA.VAL_JAN4,
           lRECEITA.VAL_FEV4,        lRECEITA.VAL_MAR4,        lRECEITA.VAL_ABR4,
           lRECEITA.VAL_MAI4,        lRECEITA.VAL_JUN4,        lRECEITA.VAL_JUL4,
           lRECEITA.VAL_AGO4,        lRECEITA.VAL_SET4,        lRECEITA.VAL_OUT4,
           lRECEITA.VAL_NOV4,        lRECEITA.VAL_DEZ4 );
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          Raise_Application_Error(-20000,'Tabela RECEITAS_ORCAMENTO '||SQLERRM);
      END;
      val_Ano_Seguinte := Valor_Ano_Seguinte(lRECEITA.ROWID, 'RECEITA');
      IF (pEXISTE_PROPOSTA = FALSE OR
          lFOUND = FALSE) AND
         (val_Ano_Seguinte > 0) THEN
        BEGIN
          Insert Into PROJECAO_RECEITA_SIMULADA
            (
             CC1_NR_CONTA,             DEP_CD_DEPENDENCIA,       TAR_CD_REGIME,          
             VSP_CD_NIVEL_VERSAO,      VSP_CD_VERSAO,            VSP_NR_ANO,               
             NR_SEQ,                   VAL_JAN,                  VAL_FEV,        
             VAL_MAR,                  VAL_ABR,                  VAL_MAI,        
             VAL_JUN,                  VAL_JUL,                  VAL_AGO,        
             VAL_SET,                  VAL_OUT,                  VAL_NOV,        
             VAL_DEZ,                  VAL_JAN1,                 VAL_FEV1,
             VAL_MAR1,                 VAL_ABR1,                 VAL_MAI1,
             VAL_JUN1,                 VAL_JUL1,                 VAL_AGO1,
             VAL_SET1,                 VAL_OUT1,                 VAL_NOV1,
             VAL_DEZ1,                 VAL_JAN2,                 VAL_FEV2,
             VAL_MAR2,                 VAL_ABR2,                 VAL_MAI2,
             VAL_JUN2,                 VAL_JUL2,                 VAL_AGO2,
             VAL_SET2,                 VAL_OUT2,                 VAL_NOV2,
             VAL_DEZ2,                 VAL_JAN3,                 VAL_FEV3,
             VAL_MAR3,                 VAL_ABR3,                 VAL_MAI3,
             VAL_JUN3,                 VAL_JUL3,                 VAL_AGO3,
             VAL_SET3,                 VAL_OUT3,                 VAL_NOV3,
             VAL_DEZ3,                 VAL_JAN4,                 VAL_FEV4,
             VAL_MAR4,                 VAL_ABR4,                 VAL_MAI4,
             VAL_JUN4,                 VAL_JUL4,                 VAL_AGO4,
             VAL_SET4,                 VAL_OUT4,                 VAL_NOV4,
             VAL_DEZ4 )
            Values
            (
             lRECEITA.NRO_CONTA,       lRECEITA.COD_DEPENDENCIA, lRECEITA.COD_REGIME,
             '1',                      '1',                      pNR_ANO+1,
             lRECEITA.NRO_RECEITA,     lRECEITA.VAL_JAN1,        lRECEITA.VAL_FEV1,
             lRECEITA.VAL_MAR1,        lRECEITA.VAL_ABR1,        lRECEITA.VAL_MAI1,
             lRECEITA.VAL_JUN1,        lRECEITA.VAL_JUL1,        lRECEITA.VAL_AGO1,
             lRECEITA.VAL_SET1,        lRECEITA.VAL_OUT1,        lRECEITA.VAL_NOV1,
             lRECEITA.VAL_DEZ1,        lRECEITA.VAL_JAN2,        lRECEITA.VAL_FEV2,
             lRECEITA.VAL_MAR2,        lRECEITA.VAL_ABR2,        lRECEITA.VAL_MAI2,
             lRECEITA.VAL_JUN2,        lRECEITA.VAL_JUL2,        lRECEITA.VAL_AGO2,
             lRECEITA.VAL_SET2,        lRECEITA.VAL_OUT2,        lRECEITA.VAL_NOV2,
             lRECEITA.VAL_DEZ2,        lRECEITA.VAL_JAN3,        lRECEITA.VAL_FEV3,
             lRECEITA.VAL_MAR3,        lRECEITA.VAL_ABR3,        lRECEITA.VAL_MAI3,
             lRECEITA.VAL_JUN3,        lRECEITA.VAL_JUL3,        lRECEITA.VAL_AGO3,
             lRECEITA.VAL_SET3,        lRECEITA.VAL_OUT3,        lRECEITA.VAL_NOV3,
             lRECEITA.VAL_DEZ3,        lRECEITA.VAL_JAN4,        lRECEITA.VAL_FEV4,
             lRECEITA.VAL_MAR4,        lRECEITA.VAL_ABR4,        lRECEITA.VAL_MAI4,
             lRECEITA.VAL_JUN4,        lRECEITA.VAL_JUL4,        lRECEITA.VAL_AGO4,
             lRECEITA.VAL_SET4,        lRECEITA.VAL_OUT4,        lRECEITA.VAL_NOV4,
             lRECEITA.VAL_DEZ4,        Null,                     Null,
             Null,                     Null,                     Null,
             Null,                     Null,                     Null,
             Null,                     Null,                     Null,
             Null );
          COMMIT;   
        EXCEPTION
          WHEN OTHERS THEN
            Raise_Application_Error(-20000,'Tabela PROJECAO_RECEITA_SIMULADA: '||SQLERRM);
        END;
      END IF;
    END LOOP;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    Raise_Application_Error(-20000,'RECEITA: '||SQLERRM);
END RECEITA;
--
-- DESPESA
--
PROCEDURE DESPESA
  (
   pNR_ANO          Number,
   pCD_VERSAO       Number,
   pEXISTE_PROPOSTA Boolean
  )
  IS
  ---------------------------------------------------------------------------
  -- VERIFICAÇÃO DE CARGA DE DESPESA EXECUTADA
  ---------------------------------------------------------------------------
  Cursor cuVERIF_DESPESA
    (
     pNR_ANO     Number
    )
    Is
    Select '1'
      From DESPESAS_ORCAMENTO DOA
      Where DOA.NRO_ANO = pNR_ANO;

  Cursor cuVERIF_PROPOSTA_ANO_SEGUINTE
    (
     pNR_ANO     Number
    )
    Is
    Select '1'
      From ITEM_PROPOSTA_ORC_SIMULADA IPOS
      Where IPOS.VSP_NR_ANO = pNR_ANO;
  ---------------------------------------------------------------------------
  -- DESPESA
  ---------------------------------------------------------------------------
  Cursor cuITENS
    (
     pNR_ANO     Number,
     pCD_VERSAO  Number
    )
    Is
    Select IPOS.ROWID,
           IPOS.DEP_CD_DEPENDENCIA       CD_DEPENDENCIA,             
           IPOS.NR_ITEM                  NR_ITEM,                        
           IPOS.CC2_CD_CENTRO_CUSTO      CD_CENTRO_CUSTO,
           IPOS.DEP_CD_DEPENDENCIA_GERD  CD_DEPENDENCIA_GERD,
           IPOS.CC2_CD_CENTRO_CUSTO_GERD CD_CENTRO_CUSTO_GERD,
           IPOS.DEP_CD_DEPENDENCIA_GEST  CD_DEPENDENCIA_GEST,
           IPOS.CC2_CD_CENTRO_CUSTO_GEST CD_CENTRO_CUSTO_GEST,
           IPOS.CC1_NR_CONTA             NR_CONTA,
           IPOS.IN_DIMENSIONAMENTO       IN_DIMENSIONAMENTO,
           IPOS.PO_CD_PROGRAMA           CD_PROGRAMA,
           IPOS.PRJ_CD_PROJETO           CD_PROJETO,
           IPOS.IN_CENTRALIZADO          IN_CENTRALIZADO,
           IPOS.CD_PRIORIDADE            CD_PRIORIDADE,
           IPOS.DS_JUSTIFICATIVA         DS_JUSTIFICATIVA,
           IPOS.NR_CONTRATO              NR_CONTRATO,
           IPOS.DT_INICIO_CONTRATO       DT_INICIO_CONTRATO,             
           IPOS.DT_TERMINO_CONTRATO      DT_TERMINO_CONTRATO,            
           IPOS.GP_CD_GRUPO              CD_GRUPO,
           IPOS.DS_ITEM                  DS_ITEM,
           IPOS.NO_FORNECEDOR            NO_FORNECEDOR,
           IPOS.VL_UNITARIO_ITEM         VL_UNITARIO_ITEM,
           IPOS.QTD_JAN                  QTD_JAN,
           IPOS.VAL_JAN                  VAL_JAN,
           IPOS.QTD_FEV                  QTD_FEV,
           IPOS.VAL_FEV                  VAL_FEV,
           IPOS.QTD_MAR                  QTD_MAR,
           IPOS.VAL_MAR                  VAL_MAR,
           IPOS.QTD_ABR                  QTD_ABR,
           IPOS.VAL_ABR                  VAL_ABR,
           IPOS.QTD_MAI                  QTD_MAI,
           IPOS.VAL_MAI                  VAL_MAI,
           IPOS.QTD_JUN                  QTD_JUN,
           IPOS.VAL_JUN                  VAL_JUN,
           IPOS.QTD_JUL                  QTD_JUL,
           IPOS.VAL_JUL                  VAL_JUL,
           IPOS.QTD_AGO                  QTD_AGO,
           IPOS.VAL_AGO                  VAL_AGO,
           IPOS.QTD_SET                  QTD_SET,
           IPOS.VAL_SET                  VAL_SET,
           IPOS.QTD_OUT                  QTD_OUT,
           IPOS.VAL_OUT                  VAL_OUT,
           IPOS.QTD_NOV                  QTD_NOV,
           IPOS.VAL_NOV                  VAL_NOV,
           IPOS.QTD_DEZ                  QTD_DEZ,
           IPOS.VAL_DEZ                  VAL_DEZ,
           IPOS.VL_UNITARIO_ITEM1        VL_UNITARIO_ITEM1,
           IPOS.QTD_JAN1                 QTD_JAN1,
           IPOS.VAL_JAN1                 VAL_JAN1,
           IPOS.QTD_FEV1                 QTD_FEV1,
           IPOS.VAL_FEV1                 VAL_FEV1,
           IPOS.QTD_MAR1                 QTD_MAR1,
           IPOS.VAL_MAR1                 VAL_MAR1,
           IPOS.QTD_ABR1                 QTD_ABR1,
           IPOS.VAL_ABR1                 VAL_ABR1,
           IPOS.QTD_MAI1                 QTD_MAI1,
           IPOS.VAL_MAI1                 VAL_MAI1,
           IPOS.QTD_JUN1                 QTD_JUN1,
           IPOS.VAL_JUN1                 VAL_JUN1,
           IPOS.QTD_JUL1                 QTD_JUL1,
           IPOS.VAL_JUL1                 VAL_JUL1,
           IPOS.QTD_AGO1                 QTD_AGO1,
           IPOS.VAL_AGO1                 VAL_AGO1,
           IPOS.QTD_SET1                 QTD_SET1,
           IPOS.VAL_SET1                 VAL_SET1,
           IPOS.QTD_OUT1                 QTD_OUT1,
           IPOS.VAL_OUT1                 VAL_OUT1,
           IPOS.QTD_NOV1                 QTD_NOV1,
           IPOS.VAL_NOV1                 VAL_NOV1,
           IPOS.QTD_DEZ1                 QTD_DEZ1,
           IPOS.VAL_DEZ1                 VAL_DEZ1,
           IPOS.VL_UNITARIO_ITEM2        VL_UNITARIO_ITEM2,
           IPOS.QTD_JAN2                 QTD_JAN2,
           IPOS.VAL_JAN2                 VAL_JAN2,
           IPOS.QTD_FEV2                 QTD_FEV2,
           IPOS.VAL_FEV2                 VAL_FEV2,
           IPOS.QTD_MAR2                 QTD_MAR2,
           IPOS.VAL_MAR2                 VAL_MAR2,
           IPOS.QTD_ABR2                 QTD_ABR2,
           IPOS.VAL_ABR2                 VAL_ABR2,
           IPOS.QTD_MAI2                 QTD_MAI2,
           IPOS.VAL_MAI2                 VAL_MAI2,
           IPOS.QTD_JUN2                 QTD_JUN2,
           IPOS.VAL_JUN2                 VAL_JUN2,
           IPOS.QTD_JUL2                 QTD_JUL2,
           IPOS.VAL_JUL2                 VAL_JUL2,
           IPOS.QTD_AGO2                 QTD_AGO2,
           IPOS.VAL_AGO2                 VAL_AGO2,
           IPOS.QTD_SET2                 QTD_SET2,
           IPOS.VAL_SET2                 VAL_SET2,
           IPOS.QTD_OUT2                 QTD_OUT2,
           IPOS.VAL_OUT2                 VAL_OUT2,
           IPOS.QTD_NOV2                 QTD_NOV2,
           IPOS.VAL_NOV2                 VAL_NOV2,
           IPOS.QTD_DEZ2                 QTD_DEZ2,
           IPOS.VAL_DEZ2                 VAL_DEZ2,
           IPOS.VL_UNITARIO_ITEM3        VL_UNITARIO_ITEM3,
           IPOS.QTD_JAN3                 QTD_JAN3,
           IPOS.VAL_JAN3                 VAL_JAN3,
           IPOS.QTD_FEV3                 QTD_FEV3,
           IPOS.VAL_FEV3                 VAL_FEV3,
           IPOS.QTD_MAR3                 QTD_MAR3,
           IPOS.VAL_MAR3                 VAL_MAR3,
           IPOS.QTD_ABR3                 QTD_ABR3,
           IPOS.VAL_ABR3                 VAL_ABR3,
           IPOS.QTD_MAI3                 QTD_MAI3,
           IPOS.VAL_MAI3                 VAL_MAI3,
           IPOS.QTD_JUN3                 QTD_JUN3,
           IPOS.VAL_JUN3                 VAL_JUN3,
           IPOS.QTD_JUL3                 QTD_JUL3,
           IPOS.VAL_JUL3                 VAL_JUL3,
           IPOS.QTD_AGO3                 QTD_AGO3,
           IPOS.VAL_AGO3                 VAL_AGO3,
           IPOS.QTD_SET3                 QTD_SET3,
           IPOS.VAL_SET3                 VAL_SET3,
           IPOS.QTD_OUT3                 QTD_OUT3,
           IPOS.VAL_OUT3                 VAL_OUT3,
           IPOS.QTD_NOV3                 QTD_NOV3,
           IPOS.VAL_NOV3                 VAL_NOV3,
           IPOS.QTD_DEZ3                 QTD_DEZ3,
           IPOS.VAL_DEZ3                 VAL_DEZ3,
           IPOS.VL_UNITARIO_ITEM4        VL_UNITARIO_ITEM4,
           IPOS.QTD_JAN4                 QTD_JAN4,
           IPOS.VAL_JAN4                 VAL_JAN4,
           IPOS.QTD_FEV4                 QTD_FEV4,
           IPOS.VAL_FEV4                 VAL_FEV4,
           IPOS.QTD_MAR4                 QTD_MAR4,
           IPOS.VAL_MAR4                 VAL_MAR4,
           IPOS.QTD_ABR4                 QTD_ABR4,
           IPOS.VAL_ABR4                 VAL_ABR4,
           IPOS.QTD_MAI4                 QTD_MAI4,
           IPOS.VAL_MAI4                 VAL_MAI4,
           IPOS.QTD_JUN4                 QTD_JUN4,
           IPOS.VAL_JUN4                 VAL_JUN4,
           IPOS.QTD_JUL4                 QTD_JUL4,
           IPOS.VAL_JUL4                 VAL_JUL4,
           IPOS.QTD_AGO4                 QTD_AGO4,
           IPOS.VAL_AGO4                 VAL_AGO4,
           IPOS.QTD_SET4                 QTD_SET4,
           IPOS.VAL_SET4                 VAL_SET4,
           IPOS.QTD_OUT4                 QTD_OUT4,
           IPOS.VAL_OUT4                 VAL_OUT4,
           IPOS.QTD_NOV4                 QTD_NOV4,
           IPOS.VAL_NOV4                 VAL_NOV4,
           IPOS.QTD_DEZ4                 QTD_DEZ4,
           IPOS.VAL_DEZ4                 VAL_DEZ4
      From ITEM_PROPOSTA_ORC_SIMULADA IPOS
      Where IPOS.VSP_CD_NIVEL_VERSAO = '3'
            And
            IPOS.VSP_CD_VERSAO = pCD_VERSAO
            And
            IPOS.VSP_NR_ANO = pNR_ANO;
  cFETCH  Char(1);
  lFOUND  Boolean := False;
  val_Ano_Seguinte NUMBER := 0;
  lITENS  cuITENS%ROWTYPE;
BEGIN
  ---------------------------------------------------------------------------
  -- DESPESA                                                               --
  ---------------------------------------------------------------------------
  Open cuVERIF_DESPESA(pNR_ANO);
  Fetch cuVERIF_DESPESA Into cFETCH;
  lFOUND := cuVERIF_DESPESA%Found;
  Close cuVERIF_DESPESA;
  IF lFOUND = TRUE THEN
    Raise_Application_Error(-20000,'Despesa já foi criada');
  ELSE
    Open cuVERIF_PROPOSTA_ANO_SEGUINTE(pNR_ANO+1);
    Fetch cuVERIF_PROPOSTA_ANO_SEGUINTE Into cFETCH;
    lFOUND := cuVERIF_PROPOSTA_ANO_SEGUINTE%Found;
    Close cuVERIF_PROPOSTA_ANO_SEGUINTE;
    FOR lITENSx In cuITENS
                    (
                     pNR_ANO,
                     pCD_VERSAO
                    ) LOOP
      lITENS := lITENSx;
      BEGIN
        INSERT INTO DESPESAS_ORCAMENTO
          (
           NRO_ANO,                       COD_DEPENDENCIA,                NRO_ITEM,
           COD_CENTRO_CUSTO,              COD_PROGRAMA,                   COD_PROJETO,
           NRO_CONTA,                     IND_CENTRALIZADO,               IND_DIMENSIONAMENTO,
           COD_DEPENDENCIA_GESTOR_PREV,   COD_CENTRO_CUSTO_GESTOR_PREV,   COD_PRIORIDADE,
           COD_DEPENDENCIA_GESTOR_DEF,    COD_CENTRO_CUSTO_GESTOR_DEF,    DES_JUSTIFICATIVA,
           COD_GRUPO,                     DES_ITEM,                       NRO_CONTRATO,
           DAT_INICIO_CONTRATO,           DAT_TERMINO_CONTRATO,           VAL_UNITARIO,
           QTD_JAN,                       QTD_FEV,                        QTD_MAR,
           QTD_ABR,                       QTD_MAI,                        QTD_JUN,
           QTD_JUL,                       QTD_AGO,                        QTD_SET,
           QTD_OUT,                       QTD_NOV,                        QTD_DEZ,
           VAL_UNITARIO1,                 QTD_JAN1,                       QTD_FEV1,
           QTD_MAR1,                      QTD_ABR1,                       QTD_MAI1,
           QTD_JUN1,                      QTD_JUL1,                       QTD_AGO1,
           QTD_SET1,                      QTD_OUT1,                       QTD_NOV1,
           QTD_DEZ1,                      VAL_UNITARIO2,                  QTD_JAN2,
           QTD_FEV2,                      QTD_MAR2,                       QTD_ABR2,
           QTD_MAI2,                      QTD_JUN2,                       QTD_JUL2,
           QTD_AGO2,                      QTD_SET2,                       QTD_OUT2,
           QTD_NOV2,                      QTD_DEZ2,                       VAL_UNITARIO3,
           QTD_JAN3,                      QTD_FEV3,                       QTD_MAR3,
           QTD_ABR3,                      QTD_MAI3,                       QTD_JUN3,
           QTD_JUL3,                      QTD_AGO3,                       QTD_SET3,
           QTD_OUT3,                      QTD_NOV3,                       QTD_DEZ3,
           VAL_UNITARIO4,                 QTD_JAN4,                       QTD_FEV4,
           QTD_MAR4,                      QTD_ABR4,                       QTD_MAI4,
           QTD_JUN4,                      QTD_JUL4,                       QTD_AGO4,
           QTD_SET4,                      QTD_OUT4,                       QTD_NOV4,
           QTD_DEZ4,                      VAL_JAN,                        VAL_FEV,
           VAL_MAR,                       VAL_ABR,                        VAL_MAI,
           VAL_JUN,                       VAL_JUL,                        VAL_AGO,
           VAL_SET,                       VAL_OUT,                        VAL_NOV,
           VAL_DEZ,                       VAL_JAN1,                       VAL_FEV1,
           VAL_MAR1,                      VAL_ABR1,                       VAL_MAI1,
           VAL_JUN1,                      VAL_JUL1,                       VAL_AGO1,
           VAL_SET1,                      VAL_OUT1,                       VAL_NOV1,
           VAL_DEZ1,                      VAL_JAN2,                       VAL_FEV2,
           VAL_MAR2,                      VAL_ABR2,                       VAL_MAI2,
           VAL_JUN2,                      VAL_JUL2,                       VAL_AGO2,
           VAL_SET2,                      VAL_OUT2,                       VAL_NOV2,
           VAL_DEZ2,                      VAL_JAN3,                       VAL_FEV3,
           VAL_MAR3,                      VAL_ABR3,                       VAL_MAI3,
           VAL_JUN3,                      VAL_JUL3,                       VAL_AGO3,
           VAL_SET3,                      VAL_OUT3,                       VAL_NOV3,
           VAL_DEZ3,                      VAL_JAN4,                       VAL_FEV4,
           VAL_MAR4,                      VAL_ABR4,                       VAL_MAI4,
           VAL_JUN4,                      VAL_JUL4,                       VAL_AGO4,
           VAL_SET4,                      VAL_OUT4,                       VAL_NOV4,
           VAL_DEZ4 )
          VALUES
          (
           pNR_ANO,                       lITENS.CD_DEPENDENCIA,          lITENS.NR_ITEM,
           lITENS.CD_CENTRO_CUSTO,        lITENS.CD_PROGRAMA,             lITENS.CD_PROJETO,
           lITENS.NR_CONTA,               lITENS.IN_CENTRALIZADO,         lITENS.IN_DIMENSIONAMENTO,
           lITENS.CD_DEPENDENCIA_GEST,    lITENS.CD_CENTRO_CUSTO_GEST,    lITENS.CD_PRIORIDADE,
           lITENS.CD_DEPENDENCIA_GERD,    lITENS.CD_CENTRO_CUSTO_GERD,    lITENS.DS_JUSTIFICATIVA,
           lITENS.CD_GRUPO,               lITENS.DS_ITEM,                 lITENS.NR_CONTRATO,
           lITENS.DT_INICIO_CONTRATO,     lITENS.DT_TERMINO_CONTRATO,     lITENS.VL_UNITARIO_ITEM,
           lITENS.QTD_JAN,                lITENS.QTD_FEV,                 lITENS.QTD_MAR,
           lITENS.QTD_ABR,                lITENS.QTD_MAI,                 lITENS.QTD_JUN,
           lITENS.QTD_JUL,                lITENS.QTD_AGO,                 lITENS.QTD_SET,
           lITENS.QTD_OUT,                lITENS.QTD_NOV,                 lITENS.QTD_DEZ,
           lITENS.VL_UNITARIO_ITEM1,      lITENS.QTD_JAN1,                lITENS.QTD_FEV1,
           lITENS.QTD_MAR1,               lITENS.QTD_ABR1,                lITENS.QTD_MAI1,
           lITENS.QTD_JUN1,               lITENS.QTD_JUL1,                lITENS.QTD_AGO1,
           lITENS.QTD_SET1,               lITENS.QTD_OUT1,                lITENS.QTD_NOV1,
           lITENS.QTD_DEZ1,               lITENS.VL_UNITARIO_ITEM2,       lITENS.QTD_JAN2,
           lITENS.QTD_FEV2,               lITENS.QTD_MAR2,                lITENS.QTD_ABR2,
           lITENS.QTD_MAI2,               lITENS.QTD_JUN2,                lITENS.QTD_JUL2,
           lITENS.QTD_AGO2,               lITENS.QTD_SET2,                lITENS.QTD_OUT2,
           lITENS.QTD_NOV2,               lITENS.QTD_DEZ2,                lITENS.VL_UNITARIO_ITEM3,
           lITENS.QTD_JAN3,               lITENS.QTD_FEV3,                lITENS.QTD_MAR3,
           lITENS.QTD_ABR3,               lITENS.QTD_MAI3,                lITENS.QTD_JUN3,
           lITENS.QTD_JUL3,               lITENS.QTD_AGO3,                lITENS.QTD_SET3,
           lITENS.QTD_OUT3,               lITENS.QTD_NOV3,                lITENS.QTD_DEZ3,
           lITENS.VL_UNITARIO_ITEM4,      lITENS.QTD_JAN4,                lITENS.QTD_FEV4,
           lITENS.QTD_MAR4,               lITENS.QTD_ABR4,                lITENS.QTD_MAI4,
           lITENS.QTD_JUN4,               lITENS.QTD_JUL4,                lITENS.QTD_AGO4,
           lITENS.QTD_SET4,               lITENS.QTD_OUT4,                lITENS.QTD_NOV4,
           lITENS.QTD_DEZ4,               lITENS.VAL_JAN,                 lITENS.VAL_FEV,
           lITENS.VAL_MAR,                lITENS.VAL_ABR,                 lITENS.VAL_MAI,
           lITENS.VAL_JUN,                lITENS.VAL_JUL,                 lITENS.VAL_AGO,
           lITENS.VAL_SET,                lITENS.VAL_OUT,                 lITENS.VAL_NOV,
           lITENS.VAL_DEZ,                lITENS.VAL_JAN1,                lITENS.VAL_FEV1,
           lITENS.VAL_MAR1,               lITENS.VAL_ABR1,                lITENS.VAL_MAI1,
           lITENS.VAL_JUN1,               lITENS.VAL_JUL1,                lITENS.VAL_AGO1,
           lITENS.VAL_SET1,               lITENS.VAL_OUT1,                lITENS.VAL_NOV1,
           lITENS.VAL_DEZ1,               lITENS.VAL_JAN2,                lITENS.VAL_FEV2,
           lITENS.VAL_MAR2,               lITENS.VAL_ABR2,                lITENS.VAL_MAI2,
           lITENS.VAL_JUN2,               lITENS.VAL_JUL2,                lITENS.VAL_AGO2,
           lITENS.VAL_SET2,               lITENS.VAL_OUT2,                lITENS.VAL_NOV2,
           lITENS.VAL_DEZ2,               lITENS.VAL_JAN3,                lITENS.VAL_FEV3,
           lITENS.VAL_MAR3,               lITENS.VAL_ABR3,                lITENS.VAL_MAI3,
           lITENS.VAL_JUN3,               lITENS.VAL_JUL3,                lITENS.VAL_AGO3,
           lITENS.VAL_SET3,               lITENS.VAL_OUT3,                lITENS.VAL_NOV3,
           lITENS.VAL_DEZ3,               lITENS.VAL_JAN4,                lITENS.VAL_FEV4,
           lITENS.VAL_MAR4,               lITENS.VAL_ABR4,                lITENS.VAL_MAI4,
           lITENS.VAL_JUN4,               lITENS.VAL_JUL4,                lITENS.VAL_AGO4,
           lITENS.VAL_SET4,               lITENS.VAL_OUT4,                lITENS.VAL_NOV4,
           lITENS.VAL_DEZ4 );
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          Raise_Application_Error(-20000,'Tabela DESPESAS_ORCAMENTOS_APROVADOS. '||SQLERRM);
      END;
      val_Ano_Seguinte := Valor_Ano_Seguinte(lITENS.ROWID, 'DESPESA');
      IF (pEXISTE_PROPOSTA = FALSE OR
          lFOUND = FALSE) AND
         (val_Ano_Seguinte > 0) THEN
        BEGIN
          Insert Into ITEM_PROPOSTA_ORC_SIMULADA
            (
             VSP_CD_NIVEL_VERSAO,           VSP_CD_VERSAO,                VSP_NR_ANO,                       
             DEP_CD_DEPENDENCIA,            NR_ITEM,                      CC1_NR_CONTA,                     
             CC2_CD_CENTRO_CUSTO,           CC2_CD_CENTRO_CUSTO_GERD,     DEP_CD_DEPENDENCIA_GERD,        
             PO_CD_PROGRAMA,                PRJ_CD_PROJETO,               IN_CENTRALIZADO,                  
             CD_PRIORIDADE,                 VL_UNITARIO_ITEM,             NR_CONTRATO,                      
             DT_INICIO_CONTRATO,            DT_TERMINO_CONTRATO,          DS_JUSTIFICATIVA,                 
             DS_ITEM,                       GP_CD_GRUPO,                  NO_FORNECEDOR,                    
             DEP_CD_DEPENDENCIA_GEST,       CC2_CD_CENTRO_CUSTO_GEST,     QTD_JAN,
             VAL_JAN,                       QTD_FEV,                      VAL_FEV,
             QTD_MAR,                       VAL_MAR,                      QTD_ABR,
             VAL_ABR,                       QTD_MAI,                      VAL_MAI,
             QTD_JUN,                       VAL_JUN,                      QTD_JUL,
             VAL_JUL,                       QTD_AGO,                      VAL_AGO,
             QTD_SET,                       VAL_SET,                      QTD_OUT,
             VAL_OUT,                       QTD_NOV,                      VAL_NOV,
             QTD_DEZ,                       VAL_DEZ,                      QTD_JAN1,
             VAL_JAN1,                      QTD_FEV1,                     VAL_FEV1,
             QTD_MAR1,                      VAL_MAR1,                     QTD_ABR1,
             VAL_ABR1,                      QTD_MAI1,                     VAL_MAI1,
             QTD_JUN1,                      VAL_JUN1,                     QTD_JUL1,
             VAL_JUL1,                      QTD_AGO1,                     VAL_AGO1,
             QTD_SET1,                      VAL_SET1,                     QTD_OUT1,
             VAL_OUT1,                      QTD_NOV1,                     VAL_NOV1,
             QTD_DEZ1,                      VAL_DEZ1,                     QTD_JAN2,
             VAL_JAN2,                      QTD_FEV2,                     VAL_FEV2,
             QTD_MAR2,                      VAL_MAR2,                     QTD_ABR2,
             VAL_ABR2,                      QTD_MAI2,                     VAL_MAI2,
             QTD_JUN2,                      VAL_JUN2,                     QTD_JUL2,
             VAL_JUL2,                      QTD_AGO2,                     VAL_AGO2,
             QTD_SET2,                      VAL_SET2,                     QTD_OUT2,
             VAL_OUT2,                      QTD_NOV2,                     VAL_NOV2,
             QTD_DEZ2,                      VAL_DEZ2,                     QTD_JAN3,
             VAL_JAN3,                      QTD_FEV3,                     VAL_FEV3,
             QTD_MAR3,                      VAL_MAR3,                     QTD_ABR3,
             VAL_ABR3,                      QTD_MAI3,                     VAL_MAI3,
             QTD_JUN3,                      VAL_JUN3,                     QTD_JUL3,
             VAL_JUL3,                      QTD_AGO3,                     VAL_AGO3,
             QTD_SET3,                      VAL_SET3,                     QTD_OUT3,
             VAL_OUT3,                      QTD_NOV3,                     VAL_NOV3,
             QTD_DEZ3,                      VAL_DEZ3,                     QTD_JAN4,
             VAL_JAN4,                      QTD_FEV4,                     VAL_FEV4,
             QTD_MAR4,                      VAL_MAR4,                     QTD_ABR4,
             VAL_ABR4,                      QTD_MAI4,                     VAL_MAI4,
             QTD_JUN4,                      VAL_JUN4,                     QTD_JUL4,
             VAL_JUL4,                      QTD_AGO4,                     VAL_AGO4,
             QTD_SET4,                      VAL_SET4,                     QTD_OUT4,
             VAL_OUT4,                      QTD_NOV4,                     VAL_NOV4,
             QTD_DEZ4,                      VAL_DEZ4,                     VL_UNITARIO_ITEM1,      
             VL_UNITARIO_ITEM2,             VL_UNITARIO_ITEM3,            VL_UNITARIO_ITEM4,      
             IN_DIMENSIONAMENTO )
            Values 
            (
            '1',                            '1',                          pNR_ANO+1,
            lITENS.CD_DEPENDENCIA,          lITENS.NR_ITEM,               lITENS.NR_CONTA,                     
            lITENS.CD_CENTRO_CUSTO,         lITENS.CD_CENTRO_CUSTO_GERD,  lITENS.CD_DEPENDENCIA_GERD,        
            decode(pNR_ANO+1, 2002, NULL, 2003, null, lITENS.CD_PROGRAMA),                   
                                            lITENS.CD_PROJETO,            lITENS.IN_CENTRALIZADO,                  
            lITENS.CD_PRIORIDADE,           lITENS.VL_UNITARIO_ITEM1,     lITENS.NR_CONTRATO,                        
            lITENS.DT_INICIO_CONTRATO,      lITENS.DT_TERMINO_CONTRATO,   lITENS.DS_JUSTIFICATIVA,                 
            lITENS.DS_ITEM,                 lITENS.CD_GRUPO,              lITENS.NO_FORNECEDOR,                    
            lITENS.CD_DEPENDENCIA_GEST,     lITENS.CD_CENTRO_CUSTO_GEST,  lITENS.QTD_JAN1,
            lITENS.VAL_JAN1,                lITENS.QTD_FEV1,              lITENS.VAL_FEV1,
            lITENS.QTD_MAR1,                lITENS.VAL_MAR1,              lITENS.QTD_ABR1,
            lITENS.VAL_ABR1,                lITENS.QTD_MAI1,              lITENS.VAL_MAI1,
            lITENS.QTD_JUN1,                lITENS.VAL_JUN1,              lITENS.QTD_JUL1,
            lITENS.VAL_JUL1,                lITENS.QTD_AGO1,              lITENS.VAL_AGO1,
            lITENS.QTD_SET1,                lITENS.VAL_SET1,              lITENS.QTD_OUT1,
            lITENS.VAL_OUT1,                lITENS.QTD_NOV1,              lITENS.VAL_NOV1,
            lITENS.QTD_DEZ1,                lITENS.VAL_DEZ1,              lITENS.QTD_JAN2,
            lITENS.VAL_JAN2,                lITENS.QTD_FEV2,              lITENS.VAL_FEV2,
            lITENS.QTD_MAR2,                lITENS.VAL_MAR2,              lITENS.QTD_ABR2,
            lITENS.VAL_ABR2,                lITENS.QTD_MAI2,              lITENS.VAL_MAI2,
            lITENS.QTD_JUN2,                lITENS.VAL_JUN2,              lITENS.QTD_JUL2,
            lITENS.VAL_JUL2,                lITENS.QTD_AGO2,              lITENS.VAL_AGO2,
            lITENS.QTD_SET2,                lITENS.VAL_SET2,              lITENS.QTD_OUT2,
            lITENS.VAL_OUT2,                lITENS.QTD_NOV2,              lITENS.VAL_NOV2,
            lITENS.QTD_DEZ2,                lITENS.VAL_DEZ2,              lITENS.QTD_JAN3,
            lITENS.VAL_JAN3,                lITENS.QTD_FEV3,              lITENS.VAL_FEV3,
            lITENS.QTD_MAR3,                lITENS.VAL_MAR3,              lITENS.QTD_ABR3,
            lITENS.VAL_ABR3,                lITENS.QTD_MAI3,              lITENS.VAL_MAI3,
            lITENS.QTD_JUN3,                lITENS.VAL_JUN3,              lITENS.QTD_JUL3,
            lITENS.VAL_JUL3,                lITENS.QTD_AGO3,              lITENS.VAL_AGO3,
            lITENS.QTD_SET3,                lITENS.VAL_SET3,              lITENS.QTD_OUT3,
            lITENS.VAL_OUT3,                lITENS.QTD_NOV3,              lITENS.VAL_NOV3,
            lITENS.QTD_DEZ3,                lITENS.VAL_DEZ3,              lITENS.QTD_JAN4,
            lITENS.VAL_JAN4,                lITENS.QTD_FEV4,              lITENS.VAL_FEV4,
            lITENS.QTD_MAR4,                lITENS.VAL_MAR4,              lITENS.QTD_ABR4,
            lITENS.VAL_ABR4,                lITENS.QTD_MAI4,              lITENS.VAL_MAI4,
            lITENS.QTD_JUN4,                lITENS.VAL_JUN4,              lITENS.QTD_JUL4,
            lITENS.VAL_JUL4,                lITENS.QTD_AGO4,              lITENS.VAL_AGO4,
            lITENS.QTD_SET4,                lITENS.VAL_SET4,              lITENS.QTD_OUT4,
            lITENS.VAL_OUT4,                lITENS.QTD_NOV4,              lITENS.VAL_NOV4,
            lITENS.QTD_DEZ4,                lITENS.VAL_DEZ4,              Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'V',0,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'Q',lITENS.VL_UNITARIO_ITEM2,Null),
            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',lITENS.VL_UNITARIO_ITEM3,Null),
                                            Decode(lITENS.IN_DIMENSIONAMENTO,'Q',lITENS.VL_UNITARIO_ITEM4,Null),
                                                                          Decode(lITENS.IN_DIMENSIONAMENTO,'Q',0,Null),
            lITENS.IN_DIMENSIONAMENTO );
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            Raise_Application_Error(-20000,'Tabela ITEM_PROPOSTA_ORC_SIMULADA: '||SQLERRM);
        END;
      END IF;
    END LOOP;
  END IF;
EXCEPTION
  When OTHERS then
    Raise_Application_Error(-20000,'PROPOSTA: '||SQLERRM);
END DESPESA;
END APROVACAO;
/
