CREATE OR REPLACE FORCE VIEW "IFRGESTAO_TI"."VIW_CADASTROS" ("EMP_NUMERO_MATRICULA", "EMP_NOME", "EMP_NOME_ABREVIADO", "EMP_QLP_CARGO", "EMP_QLP_SIGLA", "EMP_DEP_FISICO_TIPO", "EMP_DEP_FISICO_TIPO_NOME", "EMP_UOR_SIGLA", "EMP_UOR_NOME", "UOR_SIGLA_FISICO", "UOR_NOME_FISICO", "UOR_CODIGO_FISICO", "EMP_QFU_FUNCAO", "EMP_DEP_LOTACAO", "EMP_DEP_CODIGO_LOTACAO", "EMP_DEP_LOTACAO_SIGLA", "EMP_DEP_FISICO", "EMP_DEP_CODIGO_FISICO", "EMP_DEP_FISICO_SIGLA", "EMP_UOR_LOTACAO", "EMP_UOR_CODIGO_LOTACAO", "EMP_STATUS", "EMP_NOME_GUERRA", "EMP_ENDERECO_ELETRONICO_MAIL", "EMP_EFC_UFF_VOIP_DDD_DIRETO", "EMP_EFC_UFF_FONE_DIRETO", "EMP_EFC_UFF_VOIP", "EMP_UOR_CODIGO_FISICO_AGENDA", "EMP_UOR_SIGLA_FISICO_AGENDA", "EMP_UOR_FISICO_AGENDA", "EMP_NUMERO_CPF")
AS
  SELECT CAD.EMP_NUMERO_MATRICULA ,
    CAD.EMP_NOME ,
    CAD.EMP_NOME_ABREVIADO ,
    CAR.CAR_NOME                                                                                                                                                                                                                                                                          AS EMP_QLP_CARGO ,
    CAR.CAR_SIGLA                                                                                                                                                                                                                                                                         AS EMP_QLP_SIGLA ,
    DEP2.DEP_TIPO                                                                                                                                                                                                                                                                         AS EMP_DEP_FISICO_TIPO ,
    DECODE(DEP2.DEP_TIPO, 1,'SEDE', 2,'SUPERINTENDÊNCIA', 3,'AEROPORTO', 4,'GTA',5,'COORDENAÇÃO DE NEGÓCIO', 6,'GNA',7,'UNA', 8,'CONVÊNIOS COM RESSARCIMENTO', 9,'CONVÊNIOS SEM RESSARCIMENTO',10,'DEPENDÊNCIA GNA', 11,'DEPENDÊNCIA UNA',12,'DEPENDÊNCIA DE DEPENDÊNCIA', DEP2.DEP_TIPO) AS EMP_DEP_FISICO_TIPO_NOME ,
    UOR.UOR_SIGLA                                                                                                                                                                                                                                                                         AS EMP_UOR_SIGLA ,
    UOR.UOR_NOME                                                                                                                                                                                                                                                                          AS EMP_UOR_NOME ,
    UOR2.UOR_SIGLA                                                                                                                                                                                                                                                                        AS UOR_SIGLA_FISICO ,
    UOR2.UOR_NOME                                                                                                                                                                                                                                                                         AS UOR_NOME_FISICO ,
    CAD.EMP_UOR_CODIGO_FISICO                                                                                                                                                                                                                                                             AS UOR_CODIGO_FISICO ,
    CARGOS_CONFIANCA.FUN_NOME                                                                                                                                                                                                                                                             AS EMP_QFU_FUNCAO ,
    DEP.DEP_NOME                                                                                                                                                                                                                                                                          AS EMP_DEP_LOTACAO ,
    CAD.EMP_DEP_CODIGO_LOTACAO ,
    DEP.DEP_SIGLA AS EMP_DEP_LOTACAO_SIGLA ,
    DEP2.DEP_NOME AS EMP_DEP_FISICO ,
    CAD.EMP_DEP_CODIGO_FISICO ,
    DEP2.DEP_SIGLA AS EMP_DEP_FISICO_SIGLA ,
    UOR.UOR_NOME   AS EMP_UOR_LOTACAO ,
    CAD.EMP_UOR_CODIGO_LOTACAO ,
    DECODE(CAD.EMP_STATUS,0,'TEMPORARIAMENTE AFASTADO',1,'ATIVO',2,'DESLIGADO',CAD.EMP_STATUS) AS EMP_STATUS ,
    CAD.EMP_NOME_GUERRA ,
    CAD.EMP_ENDERECO_ELETRONICO_MAIL ,
    (SELECT F.EFC_UFF_VOIP_DDD
    FROM EMPREGADO_FONE_COMERCIAL F
    WHERE CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
    AND F.EFC_UFF_TIPO             = 1
    AND ROWNUM                     < 2
    ) AS EMP_EFC_UFF_VOIP_DDD_DIRETO ,
    (SELECT F.EFC_UFF_NUMERO
    FROM EMPREGADO_FONE_COMERCIAL F
    WHERE CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
    AND F.EFC_UFF_TIPO             = 1
    AND ROWNUM                     < 2
    ) AS EMP_EFC_UFF_FONE_DIRETO ,
    (SELECT F.EFC_UFF_NUMERO
    FROM EMPREGADO_FONE_COMERCIAL F
    WHERE CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
    AND F.EFC_UFF_TIPO             = 4
    AND ROWNUM                     < 2
    ) AS EMP_EFC_UFF_VOIP ,
    CAD.EMP_UOR_CODIGO_FISICO_AGENDA ,
    UOR3.UOR_SIGLA EMP_UOR_SIGLA_FISICO_AGENDA ,
    UOR3.UOR_NOME EMP_UOR_FISICO_AGENDA ,
    CAD.EMP_NUMERO_CPF
  FROM CADASTROS CAD ,
    CARGOS CAR ,
    DEPENDENCIAS DEP ,
    DEPENDENCIAS DEP2 ,
    UNIDADES_ORGANIZACIONAIS UOR ,
    UNIDADES_ORGANIZACIONAIS UOR2 ,
    UNIDADES_ORGANIZACIONAIS UOR3 ,
    CARGOS_CONFIANCA
  WHERE CAD.EMP_STATUS              <> 2
  AND UOR.UOR_TIPO_UNIDAD_ORG       <> 14
  AND CAR.CAR_CODIGO (+)             = CAD.EMP_QLP_CAR_CODIGO
  AND CAR.CAR_CODIGO_NIVEL (+)       = CAD.EMP_QLP_CAR_CODIGO_NIVEL
  AND CAR.CAR_OCC_CODIGO (+)         = CAD.EMP_QLP_CAR_OCC_CODIGO
  AND DEP.DEP_CODIGO (+)             = CAD.EMP_DEP_CODIGO_LOTACAO
  AND DEP2.DEP_CODIGO (+)            = CAD.EMP_DEP_CODIGO_FISICO
  AND UOR.UOR_CODIGO(+)              = CAD.EMP_UOR_CODIGO_LOTACAO
  AND UOR2.UOR_CODIGO (+)            = CAD.EMP_UOR_CODIGO_FISICO
  AND UOR3.UOR_CODIGO (+)            = CAD.emp_uor_codigo_fisico_agenda
  AND CARGOS_CONFIANCA.FUN_CODIGO (+)= CAD.EMP_QFU_FUN_CODIGO ;
  
