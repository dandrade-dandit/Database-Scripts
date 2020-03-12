
-- View VIW_PL2002

CREATE OR REPLACE VIEW VIW_PL2002 (
                COD_DEP,
                DEP_SIGLA,
                MATRICULA,
                D800,
                D900,
                D1000,
                D1100,
                D1200,
                PERCEN,
                D800_PER,
                D900_PER,
                D1000_PER,
                D1100_PER,
                D1200_PER 
     )
AS
         SELECT MOV.MOV_EMP_DEP_CODIGO_PAGTO COD_DEP,
                DEP.DEP_SIGLA DEP_SIGLA,
                MOV.MAT MAT,
                MOV.D800 D800,
                MOV.D900 D900,
                MOV.D1000 D1000,
                MOV.D1100 D1100,
                MOV.D1200 D1200,
                DEP.PER PERCEN,
                ((D800/2)+(D800/2)*DEP.PER/100) D800_PER,
                ((D900/2)+(D900/2)*DEP.PER/100) D900_PER,
                ((D1000/2)+(D1000/2)*DEP.PER/100) D1000_PER,
                ((D1100/2)+(D1100/2)*DEP.PER/100) D1100_PER,
                ((D1200/2)+(D1200/2)*DEP.PER/100) D1200_PER
         FROM (
              SELECT DEP_CODIGO,
                     DEP_SIGLA,
                     DECODE(
                   DEP_CODIGO,1,92,2,94.17,4,92.31,5,84,6,80,7,76.67,8,80,9,85.45,10,85,
                   11,96.15,12,76,13,88.57,
                   14,89.09,15,86.67,16,90,17,89.09,
                   18,84,19,95.56,20,90,21,86.40,
                   22,95,23,88,24,85.45,25,96.74,
                   26,88.93,27,92,28,85,29,92.73,
                   30,88,31,89.09,32,90,33,90,
                   34,88,35,80,37,91.11,38,88,
                   39,92,40,89.09,41,92,42,84,
                   43,92.73,44,92.73,46,88,47,84,
                   48,85.45,49,100,50,90,51,88,
                   52,84,53,89.09,54,95,56,95,
                   57,86,58,81.54,60,90,61,84,
                   62,92,63,92,64,80,65,88,
                   71,90,72,80,73,86.67,74,100,
                   75,88.57,76,90,78,86.67,79,77.14,
                   80,93.33,81,82.86,83,72.86,84,76.67,
                   85,84,86,86.67,87,88.57,88,86.67,
                   89,93.33,90,100,91,100,92,86.67,
                   93,93.33,94,93.33,95,82.86,96,93.33,
                   97,100,98,86.67,99,80,113,90,
                   149,75,152,86.67,150,86
                   ,0) PER
                FROM DEPENDENCIAS
              ORDER BY DEP_CODIGO
              ) DEP,
              (
              SELECT
               MOV_EMP_DEP_CODIGO_PAGTO,
               MOV_EMP_NUMERO_MATRICULA MAT,
               DECODE(MOV_VERSAO_PAGAMENTO, 28, MOV_VALOR,0) D800,
               DECODE(MOV_VERSAO_PAGAMENTO, 29, MOV_VALOR,0) D900,
               DECODE(MOV_VERSAO_PAGAMENTO, 30, MOV_VALOR,0) D1000,
               DECODE(MOV_VERSAO_PAGAMENTO, 11, MOV_VALOR,0) D1100,
               DECODE(MOV_VERSAO_PAGAMENTO, 12, MOV_VALOR,0) D1200
                FROM MOVIMENTACAO
               WHERE MOV_ANO_REFERENCIA = 2003
                AND MOV_MES_REFERENCIA = 2
                AND MOV_VERSAO_PAGAMENTO IN (28,29,30,11,12)
                -- AND MOV_VERSAO_PAGAMENTO IN (11,12)
                AND MOV_RUB_CODIGO = 1405
               ORDER BY MOV_EMP_DEP_CODIGO_PAGTO
               ) MOV
          WHERE DEP.DEP_CODIGO = MOV.MOV_EMP_DEP_CODIGO_PAGTO
          ORDER BY DEP.DEP_CODIGO
/


-- End of DDL script for VIW_PL2002
