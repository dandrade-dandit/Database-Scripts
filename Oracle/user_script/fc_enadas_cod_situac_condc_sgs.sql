CREATE OR REPLACE 
FUNCTION fc_enadas_cod_situac_condc_sgs
(
 piNumAplSeg       IN INTEGER
,piNumEnAdAS       IN INTEGER
,piNumEspcSgEnAdAS IN INTEGER
,piNumPrpSegEnAdAS IN INTEGER
,piCodSituacEnAdAS IN INTEGER
)

RETURN VARCHAR IS

 /* Variáveis de uso geral */

 sCodSituac       VARCHAR(01) := '';
 iNumPrpSeg       INTEGER := NULL;


BEGIN  --> Inicio Processo

   /*
     Cancelada
  */
  IF  (piCodSituacEnAdAS = 9)
  THEN
    sCodSituac := 'E';
  ELSE

      /*
         Pendente
      */
      IF  (piNumEspcSgEnAdAS  IS NULL)
	  THEN
	       sCodSituac := 'A';
	  END IF;

	   /*
	     Concluida
	  */
	  IF  (piNumPrpSegEnAdAS IS NOT NULL)
	  THEN
	       sCodSituac := 'D';
	  END IF;


      IF (sCodSituac = '') THEN

	  BEGIN
	    SELECT
	      count(NUM_ESPCSG)
	    INTO
	      iNumPrpSeg
	    FROM
	      ESPECIFICACAO_SEGURO_SGS
	    WHERE NUM_SUPROR_ESPCSG = piNumEspcSgEnAdAS;
	  EXCEPTION
	    WHEN NO_DATA_FOUND THEN
	      iNumPrpSeg := NULL;
	  END;

	  /*
	     Especificação
	  */
	  IF  (piNumEspcSgEnAdAS  IS NOT NULL)
	  AND (iNumPrpSeg IS NULL)
	  THEN
	       sCodSituac := 'B';
	  END IF;

	  /*
	     Proposta
	  */
	  IF  (iNumPrpSeg IS NOT NULL)
	  AND (piNumPrpSegEnAdAS IS NULL)
	  THEN
	       sCodSituac := 'C';
	  END IF;

	  END IF;

  END IF;

  RETURN(LTRIM(sCodSituac)); -- ( retorna o valor original )

END FC_ENADAS_COD_SITUAC_CONDC_SGS;
/
