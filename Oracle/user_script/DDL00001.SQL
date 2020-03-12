CREATE OR REPLACE PACKAGE APROVACAO
IS
PROCEDURE PROPOSTA 
           (
            pNR_ANO   Number
           );
PROCEDURE RECEITA
           (
            pNR_ANO          Number,
            pCD_VERSAO       Number,
            pEXISTE_PROPOSTA Boolean
           );
PROCEDURE DESPESA
             (
              pNR_ANO          Number,
              pCD_VERSAO       Number,
              pEXISTE_PROPOSTA Boolean
             );
FUNCTION VALOR_ANO_SEGUINTE
          (
           v_rowid VARCHAR2,
           v_tipo  VARCHAR2
          ) RETURN NUMBER;
END APROVACAO;
/
