SELECT SU_ID_USUARIO,SS_CD_SISTEMA FROM SEG_USUARIO_SISTEMA
WHERE SU_ID_USUARIO='OLMAR';

SU_ID_USUA SS_CD_SISTEMA
---------- -------------
OLMAR                  3
OLMAR                  5
OLMAR                  1
OLMAR                  4
OLMAR                  8
OLMAR                 11
OLMAR                 10

7 rows selected.

SELECT * FROM SEG_SISTEMA_OAB ORDER BY SG_SISTEMA,ROLE_SISTEMA;

CD_SISTEMA NO_SISTEMA                                                   SG_SISTEMA ROL
---------- ------------------------------------------------------------ ---------- ---
         1 SISEG   - CONTROLE DE ACESSO                                  SEG       SEG
         2 SICOF   - CONTROLE ORÇAMENTÁRIO E FINANCEIRO                 COF
        16 MODULO DE PROPOSTA                                           COF        ORC
         3 MODULO DE TESOURARIA                                         COF        TES
         8 SISLIC  - LICITACAO                                          LIC        LIC
         7 SISMAT  - MATERIAL                                           MAT        MAT
         4 SIPAT   - PATRIMÔNIO                                         PAT        PAT
        14 SICCOB - CONTRATOS COMERCIAIS                                SCC        SCC
         5 GESTORH - RECURSOS HUMANO                                    SRH
        10 MÓDULO DE BENEFÍCIOS - BEN                                   SRH        BEN
        15 CADASTRO DE PESSOAL - CAD                                    SRH        CAD
        13 INFRANET                                                     SRH        NET
        11 FOLHA DE PAGAMENTO - SFP                                     SRH        SFP
         9 AVALIACAO DE DESEMPENHO - SIAD                               SRH        SIA
        12 PROGRESSÃO FUNCIONAL - SPF                                   SRH        SPF
         6 SUCOTAP - TARIFAÇÃO VOOS                                     SUC        SUC

16 rows selected.

SELECT SU_ID_USUARIO,SS_CD_SISTEMA FROM SEG_USUARIO_SISTEMA
WHERE SU_ID_USUARIO='OLMAR';


SELECT B.SU_ID_USUARIO,A.NO_SISTEMA
FROM SEG_SISTEMA_OAB A, SEG_USUARIO_SISTEMA B
WHERE B.SU_ID_USUARIO='OLMAR' AND
      A.CD_SISTEMA+=B.SS_CD_SISTEMA
ORDER BY A.SG_SISTEMA,A.ROLE_SISTEMA
;

SELECT '*',A.NO_SISTEMA
FROM SEG_SISTEMA_OAB A
WHERE A.CD_SISTEMA IN (SELECT B.SS_CD_SISTEMA 
                       FROM SEG_USUARIO_SISTEMA B
                       WHERE B.SU_ID_USUARIO='OLMAR')
UNION
SELECT ' ',A.NO_SISTEMA
FROM SEG_SISTEMA_OAB A
WHERE A.CD_SISTEMA NOT IN (SELECT B.SS_CD_SISTEMA 
 FROM SEG_USUARIO_SISTEMA B
 WHERE B.SU_ID_USUARIO='OLMAR');




/******MARCUS*****************/

SELECT A.NO_SISTEMA,
       B.SU_ID_USUARIO
FROM 
	SEG_SISTEMA_OAB A,
	SEG_USUARIO_SISTEMA B
WHERE 
	A.CD_SISTEMA(+)=B.SS_CD_SISTEMA
AND
--	B.SU_ID_USUARIO='OLMAR'
--ORDER BY A.SG_SISTEMA,A.ROLE_SISTEMA
/




SELECT A.NO_SISTEMA
FROM   SEG_SISTEMA_OAB A
/



SELECT	       	B.SU_ID_USUARIO,
		B.SS_CD_SISTEMA,
		A.CD_SISTEMA
FROM 		SISTEMAS_DO_USUARIO B,
		SEG_SISTEMA A
WHERE
		B.SS_CD_SISTEMA(+)=A.CD_SISTEMA
ORDER BY    A.CD_SISTEMA 
/





CREATE VIEW SISTEMAS_DO_USUARIO AS
SELECT         *
FROM   SEG_USUARIO_SISTEMA_OAB 
WHERE
  SU_ID_USUARIO=(SELECT USER FROM DUAL)
/
