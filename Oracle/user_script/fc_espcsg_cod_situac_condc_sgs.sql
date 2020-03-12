CREATE OR REPLACE 
FUNCTION fc_espcsg_cod_situac_condc_sgs
(
  piNumEspcSg       IN INTEGER
 ,piNumAplSegEnAdAS IN INTEGER
 ,piNumEnAdAS       IN INTEGER
 ,piCodSituacEspcSg IN INTEGER
)

RETURN VARCHAR IS

 /* Variáveis de uso geral */

  sCodSituac       VARCHAR(01) := '';
  sCodSituacEnAdAS VARCHAR(01) := '';

  iNumPrpSeg      INTEGER := NULL;
  iNumAplSeg      INTEGER := NULL;

BEGIN  --> Inicio Processo

  /*
     Especificação
  */
  IF (piNumEnAdAS IS NOT NULL) THEN

    sCodSituacEnAdAS := FC_ENADAS_COD_SITUAC_SGS( piNumAplSegEnAdAS,piNumEnAdAS );
    sCodSituac       := sCodSituacEnAdAS;
    IF (sCodSituacEnAdAS = 'A') THEN
      sCodSituac := ' ';
    END IF;
    IF (sCodSituacEnAdAS = 'B') THEN
      sCodSituac := 'A';
    END IF;
    IF (sCodSituacEnAdAS = 'C') THEN
      sCodSituac := 'B';
    END IF;
    IF (sCodSituacEnAdAS = 'D') THEN
      sCodSituac := 'C';
    END IF;
    IF (sCodSituacEnAdAS = 'E') THEN
      sCodSituac := 'D';
    END IF;

  ELSE

  /*
    Verifica Proposta
  */

  BEGIN
    SELECT
      count(APLSEG.NUM_APLSEG)
    INTO
      iNumAplSeg
    FROM
       APOLICE_SEGURO_SGS APLSEG
    WHERE (APLSEG.NUM_ESPCSG (+)= piNumEspcSg);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      iNumAplSeg := NULL;
  END;

  BEGIN
    SELECT
      count(PRPSEG.NUM_SUPROR_ESPCSG)
    INTO
      iNumPrpSeg
    FROM
       ESPECIFICACAO_SEGURO_SGS  PRPSEG
    WHERE (PRPSEG.NUM_SUPROR_ESPCSG (+)= piNumEspcSg);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      iNumPrpSeg := NULL;
  END;


  IF  ((iNumPrpSeg IS NULL) OR (iNumPrpSeg <= 0))
  AND ((iNumAplSeg IS NULL) OR (iNumAplSeg <= 0))
  THEN
    sCodSituac := 'A';
  END IF;

  /*
     Cotaçâo
  */
  IF  ((iNumPrpSeg IS NOT NULL) AND (iNumPrpSeg > 0))
  AND ((iNumAplSeg IS NULL) OR (iNumAplSeg <= 0))
  THEN
    sCodSituac := 'B';
  END IF;

  /*
     Efetivada
  */
  IF  ((iNumAplSeg IS NOT NULL) AND (iNumAplSeg > 0))
  THEN
    sCodSituac := 'C';
  END IF;

   /*
     Cancelada
  */
  IF  (piCodSituacEspcSg = 9)
  THEN
    sCodSituac := 'D';
  END IF;


  END IF;

  RETURN(LTRIM(sCodSituac)); -- ( retorna o valor original )

END FC_ESPCSG_COD_SITUAC_CONDC_SGS;
/
