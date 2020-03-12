CREATE OR REPLACE 
FUNCTION fc_aplseg_cod_situac_condc_sgs(
 piNumAplSeg        IN INTEGER
,piNumAnterAplseg   IN INTEGER
,psMrcRenovvAplSeg  IN VARCHAR
,pdtDatIniVgcAplSeg IN DATE
,pdtDatFimVgcAplSeg IN DATE
,pdtDatFimPrvAplSeg IN DATE
,pdtDatRefcia       IN DATE)
RETURN VARCHAR IS
/*
*/
 iNumEspcSg       INTEGER := 0;
 iNumPrximaAplSeg INTEGER := 0;
 sCodSituac       VARCHAR(01) := '';
 sNumSituac       VARCHAR(01) := '';

 dDatIniVgc DATE;
 dDatFimVgc DATE;
 dDatRefcia DATE;
BEGIN

  dDatRefcia := pdtDatRefcia;
  IF (dDatRefcia IS NULL) THEN
    dDatRefcia := SYSDATE;
  END IF;

  dDatIniVgc := pdtDatIniVgcAplSeg;
  If (pdtDatFimPrvAplSeg IS NULL) THEN
    dDatFimVgc := pdtDatFimVgcAplSeg;
  ELSE
    dDatFimVgc := pdtDatFimPrvAplSeg;
  END IF;

    IF  (dDatIniVgc <= dDatRefcia)
    AND ((dDatFimVgc IS NULL) OR (dDatFimVgc >= dDatRefcia))
    THEN
      sNumSituac := '1';
    ELSE
      IF (dDatFimVgc < dDatRefcia) THEN
        sNumSituac := '2';
      ELSE
        IF (dDatIniVgc > dDatRefcia) THEN
          sNumSituac := '4';
        END IF;
      END IF;
    END IF;


  /*
     Vigentes
  */
  IF (sNumSituac = '1') THEN
--    sCodSituac := 'A';

    /*
        Sem Origem
        Sem Prorrogac?o
    */
    IF  ((piNumAnterAplSeg  IS NULL) OR (piNumAnterAplSeg <= 0))
    AND (pdtDatFimPrvAplSeg IS NULL)
    THEN
        sCodSituac := 'A';
    END IF;
    /*
        Sem Origem
        Com Prorrogac?o
    */
    IF  ((piNumAnterAplSeg  IS NULL) OR (piNumAnterAplSeg <= 0))
    AND (pdtDatFimPrvAplSeg IS NOT NULL)
    THEN
      sCodSituac := 'C';
    END IF;
    /*
        Com Origem
        Sem Prorrogac?o
    */
    IF  ((piNumAnterAplSeg  IS NOT NULL) AND (piNumAnterAplSeg > 0))
    AND (pdtDatFimPrvAplSeg IS NULL)
    THEN
      sCodSituac := 'B';
    END IF;
    /*
        Com Origem
        Sem Prorrogac?o
    */
    IF  ((piNumAnterAplSeg  IS NOT NULL) AND (piNumAnterAplSeg > 0))
    AND (pdtDatFimPrvAplSeg IS NOT NULL)
    THEN
        sCodSituac := 'D';
    END IF;

  END IF;

  /*
      Vencidas
  */
  IF (sNumSituac = '2') THEN
    /*
      Recupera Especificação
    */
    BEGIN
      SELECT
        min(ESPCSG.NUM_ESPCSG)
        ,min(APLSEG.NUM_APLSEG)
      INTO
        iNumEspcSg
        ,iNumPrximaAplSeg
      FROM
        ESPECIFICACAO_SEGURO_SGS ESPCSG
        ,APOLICE_SEGURO_SGS APLSEG
      WHERE (ESPCSG.NUM_APLSEG (+)= piNumAplSeg
        AND  ESPCSG.NUM_ESPCSG IS NULL)
        AND (APLSEG.NUM_ANTER_APLSEG (+)= piNumAplSeg);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        iNumEspcSg := NULL;
    END;

    /*
        Renovada
    */
    IF (iNumPrximaAplSeg IS NOT NULL) THEN
      sCodSituac := 'E';
    END IF;

    /*
        Encerrada
    */
    IF (psMrcRenovvAplSeg = 'N') THEN
      sCodSituac := 'F';
    END IF;

    /*
        Vencida
    */
    IF  (psMrcRenovvAplSeg = 'S')
    AND (iNumEspcSg       IS NULL)
    AND (iNumPrximaAplSeg IS NULL)   THEN
      sCodSituac := 'G';
    END IF;

    /*
        Em Renovac?o
    */
    IF  (psMrcRenovvAplSeg = 'S')
    AND (iNumEspcSg       IS NOT NULL)
    AND (iNumPrximaAplSeg IS NULL)   THEN
      sCodSituac := 'H';
    END IF;

  END IF;

  /*
      Canceladas
  */
  IF (sNumSituac = '3') THEN
    sCodSituac := 'I';
  END IF;

  /*
      Vigencias Futuras
  */
  IF (sNumSituac = '4') THEN
    sCodSituac := 'J';
  END IF;


  RETURN(LTRIM(sCodSituac));

END FC_APLSEG_COD_SITUAC_CONDC_SGS;
/
