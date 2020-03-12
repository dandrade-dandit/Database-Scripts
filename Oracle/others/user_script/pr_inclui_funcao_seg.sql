CREATE OR REPLACE
PROCEDURE PR_INCLUI_FUNCAO_SEG
(pCodSistma IN VARCHAR,
 pCodFuncao IN VARCHAR,
 pCodSqncia IN VARCHAR,
 pCodSupror IN VARCHAR,
 pTipFuncao IN VARCHAR,
 pSitFuncao IN VARCHAR,
 pNomFuncao IN VARCHAR,
 pDcrFuncao IN VARCHAR,
 pNivFuncao IN VARCHAR)
IS
iNumFuncao NUMBER;
iNumSupror NUMBER;
iNivFuncao NUMBER;
iNivel     NUMBER;
BEGIN
  iNumSupror := NULL;
  IF pCodSupror IS NOT NULL THEN
    SELECT NUM_FUNCAO INTO iNumSupror
    FROM FUNCAO_SEG
    WHERE COD_SISTMA = pCodSistma
      AND COD_FUNCAO = pCodSupror;
  END IF;
  SELECT max(NUM_FUNCAO) INTO iNumFuncao
  FROM FUNCAO_SEG;
  IF iNumFuncao IS NULL THEN
    iNumFuncao := 0;
  END IF;
  iNumFuncao := iNumFuncao +1;
  INSERT INTO FUNCAO_SEG
  (NUM_FUNCAO,
   COD_SISTMA,
   NUM_SQNCIA_FUNCAO,
   COD_SQNCIA_FUNCAO,
   NUM_SUPROR_FUNCAO,
   COD_FUNCAO,
   COD_TIPO_FUNCAO,
   COD_SITUAC_FUNCAO,
   NOM_FUNCAO,
   DCR_FUNCAO
  )
  VALUES
  (iNumFuncao,
   pCodSistma,
   NULL,
   pCodSqncia,
   iNumSupror,
   pCodFuncao,
   pTipFuncao,
   pSitFuncao,
   pNomFuncao,
   pDcrFuncao);
  IF pNivFuncao IS NOT NULL THEN
  iNivel := 1;
  <<NIVFNC>>
  LOOP
    IF iNivel > LENGTH(pNivFuncao) THEN
      EXIT;
    END IF;
    iNivFuncao := TO_NUMBER(SUBSTR(pNivFuncao,iNivel,2));
    INSERT INTO FUNCAO_NIVEL_SEG
    (NUM_FUNCAO,
     COD_SISTMA,
     COD_NIVAUT
    )
    VALUES
    (iNumFuncao,
     pCodSistma,
     iNivFuncao);
    iNivel := iNivel +2;
  END LOOP;
  END IF;
END PR_INCLUI_FUNCAO_SEG;
/
