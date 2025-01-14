CREATE OR REPLACE PROCEDURE PROC_MAXIMO IS

V_MAXIMO        ORDEM_SERVICO.OS_MAXIMO%type          := '';
V_RM            IFRMAXIMO.WPMATERIAL.PR%type          := '0';
V_STATUSOS      ORDEM_SERVICO.IN_ABERTA%type          := '9';
V_STATUS        IFRMAXIMO.WPMATERIAL.WPM5%type        := '';
V_STATUS1       IFRMAXIMO.WPMATERIAL.WPM5%type        := '';
V_QT_SOLICITADA IFRMAXIMO.WPMATERIAL.WPM4%TYPE        := '0';
V_QT_ATENDIDA   IFRMAXIMO.WPMATERIAL.ITEMQTY%TYPE     := '0';
V_VALOR         ITEM_REQUISICAO.VL_UNITARIO%TYPE      := '0';
V_DATA          ORDEM_SERVICO.DT_ORDEM_SERVICO%type;
V_DEP           ORDEM_SERVICO.DEP_CD_DEPENDENCIA%type := '0';
V_ITEMNUM       IFRMAXIMO.ITEM.ITEMNUM%TYPE           := '';
V_ITEM          IFRMAXIMO.ITEM.ITEMNUM%TYPE           := '';
V_DESCRICAO     IFRMAXIMO.ITEM.DESCRIPTION%TYPE       := '';
V_MATERIAL      IFRMAXIMO.ITEM.STOCKTYPE%TYPE         := '';
V_CATEGORIA     IFRMAXIMO.ITEM.IN2%TYPE               := '';
V_ORIGEM        IFRMAXIMO.ITEM.IN3%TYPE               := '';
V_ESTOCAVEL     IFRMAXIMO.INVENTORY.CATEGORY%TYPE     := '';
V_CLASSIFICACAO IFRMAXIMO.INVENTORY.ABCTYPE%TYPE      := '';
V_FORNECE       IFRMAXIMO.INVENTORY.ISSUEUNIT%TYPE    := '';
V_ESTOCA        IFRMAXIMO.INVENTORY.ORDERUNIT%TYPE    := '';
VL_MATERIAIS    IFRMAXIMO.WORKORDER.WO5%TYPE          := '0';
V_CONTADOR      IFRMAXIMO.INVRESERVE.REQUESTNUM%TYPE  :='';
V_WONUM         IFRMAXIMO.INVRESERVE.WONUM%TYPE       :='0';
V_CURBAL        IFRMAXIMO.INVBALANCES.CURBAL%TYPE     :='0';
V_PHYSCNT       IFRMAXIMO.INVBALANCES.PHYSCNT%TYPE    :='0';
V_VL_UNITARIO   IFRMAXIMO.INVENTORY.STDCOST%TYPE      :='0';

CURSOR  CUR_RM IS
     SELECT DISTINCT OS.OS_MAXIMO,
          OS.NR_ORDEM_SERVICO,
          OS.DT_ORDEM_SERVICO,
          OS.DEP_CD_DEPENDENCIA,
          OS.DS_USUARIO,
          IT.SQ_ITEM,
          IT.IPD_IG_CI_CD_CLASSE||IT.IPD_IG_CD_ITEM||DECODE(OS.DEP_CD_DEPENDENCIA,
          '1','SD','2','BR','4','BE','7','CT','10','FZ','13','PA','14','RF','15','SV','20','MO',
          '24','SP','25','EG','26','KP','28','NT','57','GR','58','CF','61','GL','62','RJ') ITEM,          
          DECODE(IT.QT_ATENDIDA,'','0',IT.QT_ATENDIDA) QT_ATENDIDA,
          IT.QT_SOLICITADA,
          IT.VL_UNITARIO,
          OS.IN_ABERTA
     FROM ORDEM_SERVICO OS,
          ITEM_REQUISICAO IT         
     WHERE (IT.IPD_DEP_CD_DEPENDENCIA = OS.DEP_CD_DEPENDENCIA)
       AND (IT.OS_NR_ORDEM_SERVICO = OS.NR_ORDEM_SERVICO)
       AND (IT.OS_AA_ORDEM_SERVICO = OS.AA_ORDEM_SERVICO)
       AND (OS.OS_MAXIMO NOT IN (SELECT DISTINCT A.WONUM 
                                 FROM WPMATERIAL A
                                 WHERE A.WPM5 IS NOT NULL))
       AND (OS.AA_ORDEM_SERVICO >= '2002')
       AND (OS.OS_MAXIMO IS NOT NULL)
     UNION 
     SELECT DISTINCT OS.OS_MAXIMO,
          OS.NR_ORDEM_SERVICO,
          OS.DT_ORDEM_SERVICO,
          OS.DEP_CD_DEPENDENCIA,
          OS.DS_USUARIO,      
          IT.SQ_ITEM,
          IT.IPD_IG_CI_CD_CLASSE||IT.IPD_IG_CD_ITEM||DECODE(OS.DEP_CD_DEPENDENCIA,
          '1','SD','2','BR','4','BE','7','CT','10','FZ','13','PA','14','RF','15','SV','20','MO',
          '24','SP','25','EG','26','KP','28','NT','57','GR','58','CF','61','GL','62','RJ') ITEM,
          DECODE(IT.QT_ATENDIDA,'','0',IT.QT_ATENDIDA) QT_ATENDIDA,
          IT.QT_SOLICITADA,
          IT.VL_UNITARIO,
          OS.IN_ABERTA
     FROM ORDEM_SERVICO OS,
          ITEM_REQUISICAO IT,
          WPMATERIAL WP
     WHERE (IT.IPD_DEP_CD_DEPENDENCIA = OS.DEP_CD_DEPENDENCIA)
     AND (IT.OS_NR_ORDEM_SERVICO = OS.NR_ORDEM_SERVICO)
     AND (IT.OS_AA_ORDEM_SERVICO = OS.AA_ORDEM_SERVICO)
     AND (OS.OS_MAXIMO is not null)
     AND (OS.AA_ORDEM_SERVICO >= '2002')
     AND (WP.WONUM = OS.OS_MAXIMO)
     AND (WP.WPM5 <> 'Fechada p/ atendimento');  

BEGIN

   FOR REG_SISMAT IN CUR_RM LOOP
      BEGIN
         V_RM            := '0'; V_STATUS        := '';
         V_QT_SOLICITADA := '0'; V_QT_ATENDIDA   := '0';
         V_VALOR         := '0'; V_STATUSOS      := '9';
         V_CONTADOR      := '';  V_WONUM         := '0';
         V_CURBAL        := '0'; V_PHYSCNT       := '0';
         

	 IF REG_SISMAT.IN_ABERTA = '0' THEN
            V_STATUS1 := 'Aberta p/ solicita��o e atendimento';
       	 END IF;

	 IF REG_SISMAT.IN_ABERTA= '1' THEN
	    V_STATUS1 := 'Fechada p/ solicita��o e Aberta p/ atendimento';
       	 END IF;

         IF REG_SISMAT.IN_ABERTA = '2' THEN
            V_STATUS1 := 'Aberta p/ item in�dito e Fechada para atendimento';
         END IF;

         IF REG_SISMAT.IN_ABERTA = '4' THEN
            V_STATUS1 := 'Fechada p/ atendimento';
         END IF;

         IF REG_SISMAT.IN_ABERTA IS NULL THEN
            V_STATUS1 := 'Entrar em Contato com Equipe Maximo';
         END IF;
         

         BEGIN

            SELECT IE.VL_UNITARIO
            INTO   V_VL_UNITARIO                             
            FROM   ITEM_ENTRADA_ESTOQUE IE
            WHERE (IE.EE_NR_ENTRADA, IE.IPD_DEP_CD_DEPENDENCIA, IE.IPD_IG_CI_CD_CLASSE, IE.IPD_IG_CD_ITEM) IN
                  (SELECT MAX(B.EE_NR_ENTRADA),B.IPD_DEP_CD_DEPENDENCIA, B.IPD_IG_CI_CD_CLASSE, B.IPD_IG_CD_ITEM 
                   FROM ITEM_ENTRADA_ESTOQUE B
                   WHERE   (B.IPD_DEP_CD_DEPENDENCIA = REG_SISMAT.DEP_CD_DEPENDENCIA)
                     AND   (B.IPD_IG_CI_CD_CLASSE    = SUBSTR(REG_SISMAT.ITEM,1,4))
                     AND   (B.IPD_IG_CD_ITEM         = SUBSTR(REG_SISMAT.ITEM,5,7))
                   GROUP BY B.IPD_DEP_CD_DEPENDENCIA, B.IPD_IG_CI_CD_CLASSE, B.IPD_IG_CD_ITEM 
                   )
            AND IE.EE_NR_ENTRADA IS NOT NULL; 

         EXCEPTION
            WHEN OTHERS THEN

                V_VL_UNITARIO := REG_SISMAT.VL_UNITARIO; 
         END; 

         BEGIN
            SELECT  DISTINCT PR, WPM5, WPM4, ITEMQTY, UNITCOST
            INTO   V_RM, V_STATUS, V_QT_SOLICITADA, V_QT_ATENDIDA, V_VALOR
            FROM   IFRMAXIMO.WPMATERIAL
            WHERE  PR = REG_SISMAT.NR_ORDEM_SERVICO
              AND  PRLINENUM = REG_SISMAT.SQ_ITEM
              AND  WONUM = REG_SISMAT.OS_MAXIMO
              AND  LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                   '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                   '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP','25','ALMOXSBEG',
                   '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBGR','58','ALMOXSBCF','61','ALMOXSBGL',
                   '62','ALMOXSBRJ','20','ALMOXSBMO');

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               
               BEGIN
                  SELECT distinct I.ITEMNUM
                  INTO   V_ITEM
                  FROM   IFRMAXIMO.ITEM I
                  WHERE  I.ITEMNUM  = REG_SISMAT.ITEM;
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     BEGIN
                        SELECT DISTINCT Y.ITEMNUM
                        INTO   V_ITEM
                        FROM   IFRMAXIMO.INVENTORY Y
                        WHERE  Y.ITEMNUM  = REG_SISMAT.ITEM
                          AND  Y.LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                         '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                         '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
                         '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
                         '62','ALMOXSBRJ','20','ALMOXSBMO');
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             SELECT CI_CD_CLASSE||CD_ITEM||DECODE(DEP_CD_DEPENDENCIA,
                                    '1','SD','2','BR','4','BE','7','CT','10','FZ','13','PA',
                                    '14','RF','15','SV','20','MO','24','SP','25','EG','26','KP',
                                    '28','NT','57','GR','58','CF','61','GL','62','RJ') ITEMNUM,
        	                    DS_PADRAO DESCRICAO,
	                            DECODE (IN_MATERIAL_TECNICO, '1', 'C', '2', 'P') MATERIAL,
        	                    DECODE (ST_CATEGORIA, '0', 'N', '1', 'R', '2','P') CATEGORIA,
	                            DECODE (ORIGEM_MATERIAL,'1', 'N','2','I') ORIGEM
        	             INTO   V_ITEMNUM, V_DESCRICAO, V_MATERIAL, V_CATEGORIA, V_ORIGEM
	                     FROM   ITEM_GENERICO
        	             WHERE  CI_CD_CLASSE = SUBSTR(REG_SISMAT.ITEM,1,4)
                	       AND  CD_ITEM = SUBSTR(REG_SISMAT.ITEM,5,7)
	                       AND  DEP_CD_DEPENDENCIA = REG_SISMAT.DEP_CD_DEPENDENCIA;


	                     SELECT DECODE(C.CD_ESTOCAVEL, '1', 'EST', '0', 'NE') ESTOCAVEL,
			            c.ABC_CD_CLASSIFICACAO CLASSIFICACAO,
			            b.UI_CD_UNIDADE_FORNECE FORNECE,
		        	    b.UI_CD_UNIDADE_ESTOCA  ESTOCA
	                     INTO   V_ESTOCAVEL, V_CLASSIFICACAO, V_FORNECE, V_ESTOCA
   			     FROM   ITEM_GENERICO b,
                	            ITEM_POR_DEPENDENCIA c
	                     WHERE  ((c.IG_CD_ITEM            = b.CD_ITEM
			       AND  c.IG_CI_CD_CLASSE        = b.CI_CD_CLASSE
                	       AND  c.DEP_CD_DEPENDENCIA     = b.DEP_CD_DEPENDENCIA)
	                       AND  (b.CD_ITEM               = SUBSTR(REG_SISMAT.ITEM,5,7)
		               AND  b.CI_CD_CLASSE           = SUBSTR(REG_SISMAT.ITEM,1,4)
			       AND  b.DEP_CD_DEPENDENCIA     = REG_SISMAT.DEP_CD_DEPENDENCIA));



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
	                        INSPECTIONREQUIRED
        	             ) VALUES (
                	        V_ITEMNUM,
                        	V_DESCRICAO,
	                        V_MATERIAL,
        	                V_CATEGORIA,
                	        V_ORIGEM,
                        	'N',
	                        'NLOTE',
        	                'N',
                	        'N',
                        	'N',
	                        'N');
        	             COMMIT;

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
                                DELIVERYTIME
                           ) VALUES (
                                REG_SISMAT.ITEM,
                                DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                         '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                         '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
                         '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
                         '62','ALMOXSBRJ','20','ALMOXSBMO'),
                                V_VL_UNITARIO ,
                                V_VL_UNITARIO ,
                                V_VL_UNITARIO ,
                                V_ESTOCAVEL,
                                V_CLASSIFICACAO,
                                V_FORNECE,
                                V_ESTOCA,
                                '0',
                                '0',
                                '1',
                                '1',
                                '0',
                                '0',
                                '0',
                                '0',
                                '0',
                                '0');
                           COMMIT;
                           BEGIN
                              SELECT DISTINCT PR, WPM5, WPM4, ITEMQTY, UNITCOST
                              INTO   V_RM, V_STATUS, V_QT_SOLICITADA, V_QT_ATENDIDA, V_VALOR
                              FROM   IFRMAXIMO.WPMATERIAL
                              WHERE  PR = REG_SISMAT.NR_ORDEM_SERVICO
              		        AND  PRLINENUM = REG_SISMAT.SQ_ITEM
              		        AND  WONUM = REG_SISMAT.OS_MAXIMO
              		        AND  LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                   	          '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                   		  '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
                   		  '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
                   		  '62','ALMOXSBRJ','20','ALMOXSBMO');
                           EXCEPTION 
                              WHEN NO_DATA_FOUND THEN

                           	INSERT INTO IFRMAXIMO.WPMATERIAL(
       			    	WONUM,                                     -- N�MERO DA OS
		            	PR,                                        -- N�MERO DA RM
        		    	REQUIREDATE,                               -- DATA DA RM
		            	WPM5,                                      -- STATUS
        		    	PRLINENUM,                                 -- SEQUENCIAL DO ITEM NA RM
		            	ITEMNUM,                                   -- CODIGO DO ITEM
        		    	LOCATION,                                  -- ALMOXARIFADO
        		    	WPM4,                                      -- QUANTIDADE SOLICITADA
		            	ITEMQTY,                                   -- QUANTIDADE ATENDIDA
	        	    	UNITCOST,                                  -- VALOR UNITARIO
        		    	DIRECTREQ,                                 -- CAMPO NOT NULL
	        	    	UNITCOSTHASCHANGED)                        -- CAMPO NOT NULL
	        	 	VALUES (
		            	REG_SISMAT.OS_MAXIMO,                      -- OS DO MAXIMO
	        	    	REG_SISMAT.NR_ORDEM_SERVICO,               -- NR. DA RM
		            	REG_SISMAT.DT_ORDEM_SERVICO,               -- DATA DA RM
	        	    	v_status1,                                 -- STATUS
		            	REG_SISMAT.sq_item,                        -- SEQUENCIAL DO ITEM NA RM
        		    	REG_SISMAT.ITEM,                           -- CODIGO DO ITEM
		            	DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
        		     	'1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
		             	'13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
        		     	'26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		             	'62','ALMOXSBRJ','20','ALMOXSBMO'), -- ALMOXARIFADO
        		    	REG_SISMAT.qt_solicitada,                  -- QUANTIDADE SOLICITADA
		            	REG_SISMAT.qt_atendida,                    -- QUANTIDADE ATENDIDA
        		    	V_VL_UNITARIO ,      -- VALOR UNITARIO DO ITEM
		            	'N',                                       -- VALOR PADRAO
        		    	'0');                                      -- VALOR PADRAO
			 	COMMIT; 
                        END;        
               
                        IF (REG_SISMAT.qt_atendida <> '0')  THEN
                           BEGIN  
                             

                              BEGIN   
                                 SELECT DISTINCT WONUM
                                 INTO V_WONUM
                                 FROM IFRMAXIMO.INVRESERVE
                                 WHERE WONUM   = REG_SISMAT.OS_MAXIMO
                                   AND ITEMNUM = REG_SISMAT.ITEM;
                              EXCEPTION 
                                 WHEN NO_DATA_FOUND THEN 
      		              	    
                                    SELECT MAX(REQUESTNUM) + 1 
        		            INTO V_CONTADOR 
	        	            FROM IFRMAXIMO.INVRESERVE 
                      	            WHERE REQUESTNUM > 9999; 

                                    UPDATE IFRMAXIMO.INVENTORY
               			    SET STDCOST = V_VL_UNITARIO ,
                   			AVGCOST = V_VL_UNITARIO ,
                   			LASTCOST = V_VL_UNITARIO 
               			    WHERE ITEMNUM = REG_SISMAT.ITEM
			              AND LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
				      '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
				      '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
				      '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
				      '62','ALMOXSBRJ','20','ALMOXSBMO'); 

			      	    INSERT INTO IFRMAXIMO.INVRESERVE(
                                       REQUESTNUM,
			               ITEMNUM, 
	        	               LOCATION, 
		             	       WONUM, 
		             	       ACTUALQTY, 
		             	       RESERVEDQTY, 
		             	       INITFLAG, 
		             	       DIRECTREQ, 
		             	       REQUESTEDBY) 
		                    VALUES (
                                       V_CONTADOR,
		             	       REG_SISMAT.ITEM,
		             	       DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	                     	       '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
	                     	       '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	                     	       '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
	                     	       '62','ALMOXSBRJ','20','ALMOXSBMO'), -- ALMOXARIFADO
		             	       REG_SISMAT.OS_MAXIMO,
                                       REG_SISMAT.qt_atendida, 
		             	       REG_SISMAT.qt_atendida,
		             	       'N',
		             	       'N',
		             	       SUBSTR(REG_SISMAT.DS_USUARIO,1,8));
	             	            COMMIT;
			            BEGIN
			               SELECT DISTINCT CURBAL, PHYSCNT INTO V_CURBAL, V_PHYSCNT FROM INVBALANCES
			               WHERE ITEMNUM  = REG_SISMAT.ITEM AND
			               LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
			               '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
			               '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
			               '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
			               '62','ALMOXSBRJ','20','ALMOXSBMO');
			            EXCEPTION
			               WHEN NO_DATA_FOUND THEN          
		                          INSERT INTO INVBALANCES 
				             (ITEMNUM,
				              LOCATION,
				              CURBAL,
				              PHYSCNT,
				              PHYSCNTDATE,
				              RECONCILED,
				              IB3)
				           VALUES
			        	      (REG_SISMAT.ITEM,
				               DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
			        	       '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
				               '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
			        	       '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
				               '62','ALMOXSBRJ','20','ALMOXSBMO'),
			        	       REG_SISMAT.QT_ATENDIDA,
				               REG_SISMAT.QT_ATENDIDA,
			        	       SYSDATE,
				               'S',
			        	       'INTERFACE');
					   COMMIT;
			             END; 
			             UPDATE INVBALANCES SET CURBAL  = REG_SISMAT.QT_ATENDIDA + V_CURBAL,
			                                    PHYSCNT = REG_SISMAT.QT_ATENDIDA + V_PHYSCNT,
              		                                        IB3 = 'INTERFACE'
			             WHERE ITEMNUM  = REG_SISMAT.ITEM AND
	               		           LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
				             '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
        				     '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
				             '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
				             '62','ALMOXSBRJ','20','ALMOXSBMO');
			             COMMIT;
                              END;      
                           END;
                        END IF;                                
                     END; -- SE N�O EXISTIR NA INVENTORY

               END; --  SE N�O EXISTIR NA ITEM

               BEGIN
                  SELECT DISTINCT Y.ITEMNUM
                  INTO   V_ITEM
                  FROM   IFRMAXIMO.INVENTORY Y
                  WHERE  Y.ITEMNUM  = REG_SISMAT.ITEM
                    AND  Y.LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                         '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                         '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
                         '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
                         '62','ALMOXSBRJ','20','ALMOXSBMO');
               EXCEPTION
                 WHEN NO_DATA_FOUND THEN
		    SELECT DECODE(C.CD_ESTOCAVEL, '1', 'EST', '0', 'NE') ESTOCAVEL,
		        c.ABC_CD_CLASSIFICACAO CLASSIFICACAO,
		        b.UI_CD_UNIDADE_FORNECE FORNECE,
		        b.UI_CD_UNIDADE_ESTOCA  ESTOCA
	            INTO   V_ESTOCAVEL, V_CLASSIFICACAO, V_FORNECE, V_ESTOCA
   		    FROM   ITEM_GENERICO b,
                	    ITEM_POR_DEPENDENCIA c
	            WHERE  ((c.IG_CD_ITEM            = b.CD_ITEM
		       AND  c.IG_CI_CD_CLASSE        = b.CI_CD_CLASSE
                       AND  c.DEP_CD_DEPENDENCIA     = b.DEP_CD_DEPENDENCIA)
	               AND  (b.CD_ITEM               = SUBSTR(REG_SISMAT.ITEM,5,7)
		       AND  b.CI_CD_CLASSE           = SUBSTR(REG_SISMAT.ITEM,1,4)
		       AND  b.DEP_CD_DEPENDENCIA     = REG_SISMAT.DEP_CD_DEPENDENCIA));
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
                       DELIVERYTIME
                    ) VALUES (
                       REG_SISMAT.ITEM,
                       DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
                         '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
                         '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
                         '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
                         '62','ALMOXSBRJ','20','ALMOXSBMO'),
                       V_VL_UNITARIO ,
                       V_VL_UNITARIO ,
                       V_VL_UNITARIO ,
                       V_ESTOCAVEL,
                       V_CLASSIFICACAO,
                       V_FORNECE,
                       V_ESTOCA,
                       '0',
                       '0',
                       '1',
                       '1',
                       '0',
                       '0',
                       '0',
                       '0',
                       '0',
                       '0');
                        COMMIT;
               END; -- SE EXISTIR NA ITEM E N�O EXISTIR NA INVENTORY


         UPDATE IFRMAXIMO.INVENTORY SET STDCOST = V_VL_UNITARIO 
         WHERE ITEMNUM = REG_SISMAT.ITEM AND
               LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
             '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
             '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
             '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
             '62','ALMOXSBRJ','20','ALMOXSBMO');
         COMMIT;
         BEGIN
            SELECT DISTINCT PR, WPM5, WPM4, ITEMQTY, UNITCOST
            INTO   V_RM, V_STATUS, V_QT_SOLICITADA, V_QT_ATENDIDA, V_VALOR
            FROM   IFRMAXIMO.WPMATERIAL
            WHERE  PR = REG_SISMAT.NR_ORDEM_SERVICO
             AND  PRLINENUM = REG_SISMAT.SQ_ITEM
             AND  WONUM = REG_SISMAT.OS_MAXIMO
             AND  LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
              '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
              '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
              '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
              '62','ALMOXSBRJ','20','ALMOXSBMO');
         EXCEPTION 
            WHEN NO_DATA_FOUND THEN

  	       INSERT INTO IFRMAXIMO.WPMATERIAL(
        	    WONUM,                                     -- N�MERO DA OS
	            PR,                                        -- N�MERO DA RM
        	    REQUIREDATE,                               -- DATA DA RM
	            WPM5,                                      -- STATUS
        	    PRLINENUM,                                 -- SEQUENCIAL DO ITEM NA RM
	            ITEMNUM,                                   -- CODIGO DO ITEM
        	    LOCATION,                                  -- ALMOXARIFADO
	            WPM4,                                      -- QUANTIDADE SOLICITADA
        	    ITEMQTY,                                   -- QUANTIDADE ATENDIDA
	            UNITCOST,                                  -- VALOR UNITARIO
        	    DIRECTREQ,                                 -- CAMPO NOT NULL
	            UNITCOSTHASCHANGED)                        -- CAMPO NOT NULL
        	 VALUES (
	            REG_SISMAT.OS_MAXIMO,                      -- OS DO MAXIMO
        	    REG_SISMAT.NR_ORDEM_SERVICO,               -- NR. DA RM
	            REG_SISMAT.DT_ORDEM_SERVICO,               -- DATA DA RM
        	    v_status1,                                 -- STATUS
	            REG_SISMAT.sq_item,                        -- SEQUENCIAL DO ITEM NA RM
	            REG_SISMAT.ITEM,                           -- CODIGO DO ITEM
        	    DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	             '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
        	     '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	             '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
        	     '62','ALMOXSBRJ','20','ALMOXSBMO'), -- ALMOXARIFADO
	            REG_SISMAT.qt_solicitada,                  -- QUANTIDADE SOLICITADA
        	    REG_SISMAT.qt_atendida,                    -- QUANTIDADE ATENDIDA
	            V_VL_UNITARIO ,                    -- VALOR UNITARIO DO ITEM
        	    'N',                                       -- VALOR PADRAO
	            '0');                                      -- VALOR PADRAO

	         COMMIT;
         END;
         
         IF (REG_SISMAT.qt_atendida <> '0')  THEN
            BEGIN  
            BEGIN                
              SELECT DISTINCT WONUM
              INTO V_WONUM
              FROM IFRMAXIMO.INVRESERVE
              WHERE ITEMNUM = REG_SISMAT.ITEM
               AND WONUM = REG_SISMAT.OS_MAXIMO; 
            EXCEPTION
               WHEN NO_DATA_FOUND THEN 
              
      	       SELECT MAX(REQUESTNUM) + 1 
               INTO V_CONTADOR 
	       FROM IFRMAXIMO.INVRESERVE 
               WHERE REQUESTNUM > 9999; 
               
               UPDATE IFRMAXIMO.INVENTORY
                SET STDCOST  = V_VL_UNITARIO ,
                    LASTCOST = V_VL_UNITARIO ,
                     AVGCOST = V_VL_UNITARIO 
               WHERE ITEMNUM = REG_SISMAT.ITEM
                AND LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	          '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
	          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	          '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
	          '62','ALMOXSBRJ','20','ALMOXSBMO');
                
               INSERT INTO IFRMAXIMO.INVRESERVE(
                  REQUESTNUM,
		  ITEMNUM, 
	          LOCATION, 
		  WONUM, 
		  ACTUALQTY, 
		  RESERVEDQTY, 
		  INITFLAG, 
		  DIRECTREQ, 
		  REQUESTEDBY) 
	       VALUES (
                  V_CONTADOR,
		  REG_SISMAT.ITEM,
		  DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	          '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
	          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	          '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
	          '62','ALMOXSBRJ','20','ALMOXSBMO'), -- ALMOXARIFADO
		  REG_SISMAT.OS_MAXIMO,
                  REG_SISMAT.qt_atendida, 
		  REG_SISMAT.qt_atendida,
		  'N',
		  'N',
	          SUBSTR(REG_SISMAT.DS_USUARIO,1,8));
	       COMMIT;

	       BEGIN
	          SELECT DISTINCT CURBAL, PHYSCNT INTO V_CURBAL, V_PHYSCNT FROM INVBALANCES
	          WHERE ITEMNUM  = REG_SISMAT.ITEM AND
	          LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	          '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
	          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	          '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
	          '62','ALMOXSBRJ','20','ALMOXSBMO');
	       EXCEPTION
	          WHEN NO_DATA_FOUND THEN          
	             INSERT INTO INVBALANCES 
	                (ITEMNUM,
	                 LOCATION,
		         CURBAL,
		         PHYSCNT,
		         PHYSCNTDATE,
		         RECONCILED,
		         IB3)
		     VALUES
	       	         (REG_SISMAT.ITEM,
			  DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
	        	  '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
		          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	        	  '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		          '62','ALMOXSBRJ','20','ALMOXSBMO'),
	        	  REG_SISMAT.QT_ATENDIDA,
		          REG_SISMAT.QT_ATENDIDA,
	        	  SYSDATE,
		          'S',
	        	  'INTERFACE');
		      COMMIT;
	        END; 
	        UPDATE INVBALANCES SET CURBAL  = REG_SISMAT.QT_ATENDIDA + V_CURBAL,
                                       PHYSCNT = REG_SISMAT.QT_ATENDIDA + V_PHYSCNT,
                                           IB3 = 'INTERFACE'
	        WHERE ITEMNUM  = REG_SISMAT.ITEM AND
	              LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
		      '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
        	      '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	              '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		      '62','ALMOXSBRJ','20','ALMOXSBMO');
		COMMIT;
            END;
            END;
         END IF;       
         END; -- SE EXISTIR NA WPMATERIAL

         IF V_STATUS <> 'Fechada p/ atenditendimento' THEN
            BEGIN
               UPDATE IFRMAXIMO.WPMATERIAL SET WPM5 = V_STATUS1
               WHERE WONUM = REG_SISMAT.OS_MAXIMO;

	         IF (REG_SISMAT.qt_atendida <> '0')  THEN
        	    BEGIN  
	                    
		       IF REG_SISMAT.QT_ATENDIDA <> V_QT_ATENDIDA THEN
	                  BEGIN
        	             UPDATE IFRMAXIMO.WPMATERIAL 
                	     SET ITEMQTY = (REG_SISMAT.QT_ATENDIDA + V_QT_ATENDIDA)
	                     WHERE WONUM = REG_SISMAT.OS_MAXIMO
        	             AND PRLINENUM = REG_SISMAT.SQ_ITEM
                	     AND ITEMNUM = REG_SISMAT.ITEM;
	                     COMMIT;
        	          END;
	               END IF;
   
                                    
        	       UPDATE IFRMAXIMO.INVENTORY
	                 SET STDCOST  = V_VL_UNITARIO ,
        	             AVGCOST  = V_VL_UNITARIO ,
                	     LASTCOST = V_VL_UNITARIO 
	               WHERE ITEMNUM  = REG_SISMAT.ITEM
        	         AND LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
		         '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
		         '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	        	 '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		         '62','ALMOXSBRJ','20','ALMOXSBMO');  
        	       
	               BEGIN   
        	          SELECT DISTINCT WONUM
                	  INTO V_WONUM
	                  FROM IFRMAXIMO.INVRESERVE
        	          WHERE WONUM   = REG_SISMAT.OS_MAXIMO
	                    AND ITEMNUM = REG_SISMAT.ITEM;
	               EXCEPTION 
	                  WHEN NO_DATA_FOUND THEN 
	      		     SELECT MAX(REQUESTNUM) + 1 
	        	     INTO V_CONTADOR 
		             FROM IFRMAXIMO.INVRESERVE 
	                     WHERE REQUESTNUM > 9999; 

		       	     INSERT INTO IFRMAXIMO.INVRESERVE(
	                        REQUESTNUM,
				ITEMNUM, 
		        	LOCATION, 
			        WONUM, 
			        ACTUALQTY, 
			        RESERVEDQTY, 
			        INITFLAG, 
			        DIRECTREQ, 
			        REQUESTEDBY) 
			     VALUES (
	                        V_CONTADOR,
			        REG_SISMAT.ITEM,
			        DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
		                '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
		                '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
		                '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		                '62','ALMOXSBRJ','20','ALMOXSBMO'), -- ALMOXARIFADO
			        REG_SISMAT.OS_MAXIMO,
	                        REG_SISMAT.qt_atendida, 
			        REG_SISMAT.qt_atendida,
			        'N',
			        'N',
			        SUBSTR(REG_SISMAT.DS_USUARIO,1,8));
		             COMMIT;
                       END;      
		       BEGIN
		          SELECT DISTINCT CURBAL, PHYSCNT INTO V_CURBAL, V_PHYSCNT FROM INVBALANCES
		          WHERE ITEMNUM  = REG_SISMAT.ITEM AND
		          LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
		          '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
		          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
		          '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		          '62','ALMOXSBRJ','20','ALMOXSBMO');
		       EXCEPTION
		          WHEN NO_DATA_FOUND THEN          
		             INSERT INTO INVBALANCES 
		                (ITEMNUM,
		                 LOCATION,
			         CURBAL,
			         PHYSCNT,
			         PHYSCNTDATE,
			         RECONCILED,
			         IB3)
			     VALUES
		       	         (REG_SISMAT.ITEM,
				  DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
		        	  '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
			          '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
	        		  '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
		        	  '62','ALMOXSBRJ','20','ALMOXSBMO'),
		        	  REG_SISMAT.QT_ATENDIDA,
			          REG_SISMAT.QT_ATENDIDA,
		        	  SYSDATE,
			          'S',
		        	  'INTERFACE');
			      COMMIT;
		       END; 
		       UPDATE INVBALANCES SET CURBAL  = REG_SISMAT.QT_ATENDIDA + V_CURBAL,
	                                      PHYSCNT = REG_SISMAT.QT_ATENDIDA + V_PHYSCNT,
	                                          IB3 = 'INTERFACE'
		       WHERE ITEMNUM  = REG_SISMAT.ITEM AND
		             LOCATION = DECODE(REG_SISMAT.DEP_CD_DEPENDENCIA,
			     '1', 'ALMOXSEDE', '2','ALMOXSBBR','4', 'ALMOXSBBE','7', 'ALMOXSBCT','10','ALMOXSBFZ',
        		     '13','ALMOXSBPA','14','ALMOXSBRF','15','ALMOXSBSV','24','ALMOXSBSP1','25','ALMOXSBEG',
		             '26','ALMOXSBKP','28','ALMOXSBNT','57','ALMOXSBSP2','58','ALMOXSBCF','61','ALMOXSBGL',
			     '62','ALMOXSBRJ','20','ALMOXSBMO');
		       COMMIT;
                
               	    END;
                 END IF; -- condi��o de atendimento <> 0      
            END;
         END IF; -- condi��o de status <> de Fechada p/ atendimento       
      END; -- BEGIN DO FOR
   END LOOP;  -- FOR
END; -- FINAL DO BLOCO
