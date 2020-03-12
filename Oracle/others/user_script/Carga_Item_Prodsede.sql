CREATE OR REPLACE PROCEDURE P_CARGA_ITEM IS

 V_ITEMNUM VARCHAR2(20) := '0';

 CURSOR FCARGA IS
   SELECT 
      CI_CD_CLASSE||CD_ITEM ITEMNUM,
      DS_PADRAO DESCRICAO,
      DECODE (IN_MATERIAL_TECNICO, '1', 'C', '2', 'P') MATERIAL,
      DECODE (ST_CATEGORIA, '0', 'N', '1', 'R', '2','P') CATEGORIA, 
      DECODE (ORIGEM_MATERIAL,'1', 'N','2','I') ORIGEM
   FROM ITEM_GENERICO
   WHERE DEP_CD_DEPENDENCIA IN ('1','2','4','7','10','13','14','15','20',
                              '24','25','26','28','57','58','62');
    
BEGIN
      
   FOR CARGAi IN FCARGA LOOP 
      BEGIN
          V_ITEMNUM :='';            
          BEGIN
             SELECT A.ITEMNUM 
             INTO V_ITEMNUM 
             FROM IFRMAXIMO.ITEM A
             WHERE A.ITEMNUM = CARGAi.ITEMNUM;
          EXCEPTION
             when no_data_found then
          
             INSERT INTO IFRMAXIMO.ITEM (
                ITEMNUM,
                DESCRIPTION,
                STOCKTYPE,
                IN2,
                IN3,
                ROTATING,
                LOTTYPE,
                CAPITALIZED,
                OUTSIDE,
                SPAREPARTAUTOADD,
                INSPECTIONREQUIRED,
                IN27
                ) VALUES (
                CARGAi.ITEMNUM,
                CARGAi.DESCRICAO,
                CARGAi.MATERIAL,
                CARGAi.CATEGORIA,
                CARGAi.ORIGEM,
                'N',
                'LOTE',
                'N',
                'N',
                'N',
                'N',
		'S');
                 COMMIT;
          END;  
        
        END;      
      END LOOP;
   END; 