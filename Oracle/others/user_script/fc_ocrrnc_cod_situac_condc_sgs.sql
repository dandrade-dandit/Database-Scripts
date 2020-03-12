CREATE OR REPLACE 
FUNCTION fc_ocrrnc_cod_situac_condc_sgs
(
  piAnoOCRRNC        IN INTEGER
  ,piNumOCRRNC       IN INTEGER
  ,piCodSituacOcrrnc IN INTEGER
  ,piNumSnstro       IN INTEGER
  ,piQtdCausas       IN INTEGER
)
RETURN VARCHAR IS

 sCodSituac    VARCHAR(01) := '';

BEGIN  --> Inicio Processo

  /*   Cancelada   */
  IF (piCodSituacOcrrnc = 9)  THEN
     sCodSituac := 'C';
  /*   Cotacao   */
  ELSIF (piNumSnstro  IS NOT NULL)  THEN
     sCodSituac := 'B';
--  /*   Avaliada   */
--  ELSIF (OCRRNC.DCR_AVLCAO_OCRRNC  IS NOT NULL)  THEN
--     sCodSituac := 'F';
--  /*   Investigada   */
--  ELSIF (OCRRNC.DAT_FMINVS_OCRRNC  IS NOT NULL)  THEN
--     sCodSituac := 'E';
  /*   Em Investigac?o   */
  ELSIF (piQtdCausas > 0)  THEN
     sCodSituac := 'D';
  /*   Especificac?o   */
  ELSIF (piNumSnstro  IS NULL)  THEN
     sCodSituac := 'A';
  END IF;

  RETURN(LTRIM(sCodSituac)); -- ( retorna o valor original )

END FC_OCRRNC_COD_SITUAC_CONDC_SGS;
/
