CREATE OR REPLACE PROCEDURE P_CARGA_INVENTORY IS

   V_ITEMNUM VARCHAR2(20) := '0';

 CURSOR CURCARGA IS
    SELECT  B.CI_CD_CLASSE||B.CD_ITEM ITEMNUM,
        DECODE(B.DEP_CD_DEPENDENCIA,
        '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
        '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP','25','ALMOXSBEG',
        '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP','58','ALMOXSBCF','61','ALMOXSBGL',
        '62','ALMOXSBRJ','20','ALMOXSBMO','5','DELETAR','8','DELETAR','901','DELETAR') LOCATION,
        DECODE(C.CD_ESTOCAVEL, '1', 'EST', '0', 'NE','','NULL') ESTOCAVEL,
        c.ABC_CD_CLASSIFICACAO CLASSIFICACAO,
        b.UI_CD_UNIDADE_FORNECE FORNECE,
        b.UI_CD_UNIDADE_ESTOCA  ESTOCA
   FROM ITEM_GENERICO b,
        ITEM_POR_DEPENDENCIA c
   WHERE ((c.IG_CD_ITEM             = b.CD_ITEM
     AND   c.IG_CI_CD_CLASSE        = b.CI_CD_CLASSE
     AND   c.DEP_CD_DEPENDENCIA     = b.DEP_CD_DEPENDENCIA)
     AND   B.DEP_CD_DEPENDENCIA IN ('1','2','4','7','10','13','14','15','20',
                              '24','25','26','28','57','58','62'));
   
     
BEGIN
  FOR CARGAi IN CURCARGA LOOP 
      BEGIN
         
         BEGIN
            SELECT j.ITEMNUM INTO V_ITEMNUM
            FROM IFRMAXIMO.INVENTORY j
            WHERE j.ITEMNUM  = CARGAi.ITEMNUM 
              AND j.LOCATION = CARGAi.LOCATION;
         EXCEPTION
            when no_data_found then
              begin
               INSERT INTO IFRMAXIMO.INVENTORY(
                  ITEMNUM,
                  LOCATION,
                  STDCOST,
                  LASTCOST,
                  AVGCOST,
                  CATEGORY,     
                  ABCTYPE, 
                  ISSUEUNIT,
                  ORDERUNIT,
                  MINLEVEL,
                  MAXLEVEL,
                  CONVERSION,
                  ORDERQTY,
                  ISSUEYTD,
                  ISSUE1YRAGO,
                  ISSUE2YRAGO,
                  ISSUE3YRAGO,
                  CCF,
                  DELIVERYTIME,
                  IL10
                  ) VALUES (
                   CARGAi.ITEMNUM,
                   CARGAi.LOCATION,
                   '0',
                   '0',
                   '0',
                   CARGAi.ESTOCAVEL,
                   CARGAi.CLASSIFICACAO,
                   CARGAi.FORNECE,
                   CARGAi.ESTOCA,                 
                   '0',
                   '0',
                   '1',
                   '1',
                   '0',
                   '0',
                   '0',
                   '0',
                   '0',
                   '0',
                   'S');
                  COMMIT;
              End;
         END;     
      END;
   END LOOP;
 END;