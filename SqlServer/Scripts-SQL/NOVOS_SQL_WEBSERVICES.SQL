--UOR
SELECT DISTINCT NVL(EMP_FUN_CODIGO, EMP_CAR_CODIGO) AS CARGO_CODIGO, 
 NVL(emp_qfu_funcao, emp_qlp_cargo) AS CARGO_FUNCAO
 , DECODE(EMP_FUN_CODIGO, NULL, 'CARGO', 'FUN플O') AS DESC_CARGO_FUNCAO 
FROM ifragenda.viw_cadastros
WHERE emp_status = 'ATIVO'
AND emp_uor_sigla = 'DAAG'
--AND EMP_FUN_CODIGO IS NULL --SOMENTE CARGO
AND EMP_FUN_CODIGO IS NOT NULL --SOMENTE FUN플O
UNION
SELECT DISTINCT subst.oem_fun_codigo_substitui AS CARGO_CODIGO, 
   (SELECT FUN_NOME FROM CARGOS_CONFIANCA WHERE fun_codigo=subst.oem_fun_codigo_substitui) AS CARGO_FUNCAO,
   'FUN플O' AS DESC_CARGO_FUNCAO 
FROM (SELECT  oem_emp_numero_matricula, oem_fun_codigo_substitui
      FROM  ocorrencias_empregados o 
     WHERE  o.oem_ofu_codigo = 220
       AND  o.oem_data_inicio <= TRUNC (SYSDATE) AND o.oem_data_termino >= TRUNC (SYSDATE) 
       and  oem_emp_numero_matricula_subst in (
                 SELECT  emp_numero_matricula 
                  FROM    ifragenda.viw_cadastros
                  WHERE   emp_uor_sigla = 'DAAG') ) subst
UNION
SELECT DISTINCT acumula.OEM_FUN_CODIGO_ACUMULA AS CARGO_CODIGO, 
   (SELECT FUN_NOME FROM CARGOS_CONFIANCA WHERE fun_codigo=acumula.OEM_FUN_CODIGO_ACUMULA) AS CARGO_FUNCAO,
   'FUN플O' AS DESC_CARGO_FUNCAO 
FROM (SELECT  oem_emp_numero_matricula, OEM_FUN_CODIGO_ACUMULA
      FROM  ocorrencias_empregados o 
     WHERE   o.oem_ofu_codigo IN (85, 217)
       AND   o.oem_data_inicio <= TRUNC (SYSDATE) AND (o.oem_data_termino >= TRUNC (SYSDATE)  OR o.oem_data_termino IS NULL )
       AND   o.oem_uor_codigo in (select uor_codigo from unidades_organizacionais where uor_sigla = 'DAAG' )) acumula
       
--COM FUN플O
SELECT  *
  FROM  (
SELECT  (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_numero_matricula ELSE a.emp_numero_matricula END) as MATRICULA_CPF, 
        (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_nome ELSE a.emp_nome END) as NOME, 
        (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = a.emp_dep_codigo_lotacao) as DEPENDENCIA,
        (uor.uor_sigla) AS LOTACAO,
        (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_endereco_eletronico_mail ELSE a.emp_endereco_eletronico_mail END) as EMAIL,
        ('I'||LTRIM(TO_CHAR(CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_numero_matricula ELSE a.emp_numero_matricula END, '0000000'))) AS MAT_GERAL
FROM    unidades_organizacionais uor 
        INNER JOIN (SELECT  *
                      FROM  (
                    SELECT  a.emp_numero_matricula, 
                            a.emp_uor_codigo_lotacao as emp_uor_codigo
                    FROM    cadastros a 
                    WHERE   a.emp_status != 2 
                    AND     (a.emp_qfu_fun_codigo IN 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un
                                   WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                     AND un.uor_codigo = a.emp_uor_codigo_lotacao) 
                    )
                    UNION
                    SELECT a.emp_numero_matricula, 
                           (CASE WHEN length(a.emp_qfu_hfl_uor_cod_acum) > 0 THEN a.emp_qfu_hfl_uor_cod_acum ELSE a.emp_uor_codigo_lotacao END) as emp_uor_codigo  
                    FROM cadastros a LEFT JOIN cadastros acu ON a.emp_numero_matricula = acu.emp_numero_matricula
                    WHERE a.emp_status != 2 
                    AND   (a.emp_qfu_fun_codigo IN 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un
                                   WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                     AND un.uor_codigo = a.emp_uor_codigo_lotacao) 
                    OR   a.emp_qfu_fun_codigo_acumula in 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un 
                                   WHERE  m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                   AND un.uor_codigo = a.emp_qfu_hfl_uor_cod_acum))
                    )) chefe
        ON uor.uor_codigo = chefe.emp_uor_codigo
        INNER JOIN cadastros a ON a.emp_numero_matricula = chefe.emp_numero_matricula
        LEFT JOIN ocorrencias_empregados o ON chefe.emp_numero_matricula = o.oem_emp_numero_matricula_subst AND o.oem_data_inicio <= TRUNC (SYSDATE) AND o.oem_data_termino >= TRUNC (SYSDATE) 
        LEFT JOIN cadastros o1 ON o.oem_emp_numero_matricula = o1.emp_numero_matricula 
        INNER JOIN IFRAGENDA.viw_cadastros v ON a.emp_numero_matricula = v.emp_numero_matricula
         WHERE chefe.emp_uor_codigo IN (SELECT a.uor_codigo
                                          FROM unidades_organizacionais a 
                                         WHERE  a.uor_dep_codigo = 1 
                                           AND 10200000 IN (SELECT b.uor_codigo
                                                              FROM unidades_organizacionais b
                                                             WHERE b.uor_data_extincao IS NULL 
                                                               AND b.uor_dep_codigo = 1
                                                             START  WITH b.uor_codigo = a.uor_codigo
                                                           CONNECT BY PRIOR b.uor_codigo = b.uor_uor_codigo)
                                         START WITH uor_uor_codigo IS NULL
                                      CONNECT BY PRIOR a.uor_codigo = a.uor_uor_codigo)
         AND (v.emp_qfu_funcao= 'DIRETOR DE ADMINISTRA플O')
         AND (v.emp_qfu_funcao IS NOT NULL )
         ORDER BY uor.uor_tipo_unidad_org  desc)
WHERE ROWNUM < 2
union
SELECT emp_numero_matricula AS MATRICULA_CPF, 
emp_nome_abreviado AS NOME, 
emp_dep_lotacao AS DEPENDENCIA,
emp_uor_sigla AS LOTACAO, 
emp_endereco_eletronico_mail AS EMAIL, 
('I'||LTRIM(TO_CHAR(emp_numero_matricula, '0000000'))) AS MAT_GERAL
FROM IFRAGENDA.viw_cadastros
WHERE emp_status = 'ATIVO'
AND emp_uor_codigo_lotacao = 10200000 
AND ((emp_qlp_cargo = 'DIRETOR DE ADMINISTRA플O') OR (emp_qfu_funcao= 'DIRETOR DE ADMINISTRA플O')) 
AND (emp_qfu_funcao IS NOT NULL )
union
SELECT emp_numero_matricula AS MATRICULA_CPF, 
emp_nome_abreviado AS NOME, 
emp_dep_lotacao AS DEPENDENCIA,
(select uor_sigla from unidades_organizacionais where emp_qfu_hfl_uor_cod_acum = uor_codigo) AS LOTACAO, 
emp_endereco_eletronico_mail AS EMAIL, 
('I'||LTRIM(TO_CHAR(emp_numero_matricula, '0000000'))) AS MAT_GERAL 
FROM ifragenda.viw_cadastros
WHERE emp_status = 'ATIVO'
AND   'DIRETOR DE ADMINISTRA플O' = (SELECT FUN_NOME FROM CARGOS_CONFIANCA WHERE fun_codigo=EMP_QFU_FUN_CODIGO_ACUMULA)
AND emp_qfu_hfl_uor_cod_acum IN (
SELECT  UOR_CODIGO
  FROM  UNIDADES_ORGANIZACIONAIS
 WHERE  UOR_CODIGO = 10200000
   AND  UOR_DATA_EXTINCAO IS NULL)
ORDER BY 2

--SEM FUN플O
SELECT  *
  FROM  (
SELECT  (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_numero_matricula ELSE a.emp_numero_matricula END) as MATRICULA_CPF, 
        (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_nome ELSE a.emp_nome END) as NOME, 
        (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = a.emp_dep_codigo_lotacao) as DEPENDENCIA,
        (uor.uor_sigla) AS LOTACAO,
        (CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_endereco_eletronico_mail ELSE a.emp_endereco_eletronico_mail END) as EMAIL,
        ('I'||LTRIM(TO_CHAR(CASE WHEN LENGTH (o1.emp_nome) > 0 THEN o1.emp_numero_matricula ELSE a.emp_numero_matricula END, '0000000'))) AS MAT_GERAL
FROM    unidades_organizacionais uor 
        INNER JOIN (SELECT  *
                      FROM  (
                    SELECT  a.emp_numero_matricula, 
                            a.emp_uor_codigo_lotacao as emp_uor_codigo
                    FROM    cadastros a 
                    WHERE   a.emp_status != 2 
                    AND     (a.emp_qfu_fun_codigo IN 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un
                                   WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                     AND un.uor_codigo = a.emp_uor_codigo_lotacao) 
                    )
                    UNION
                    SELECT a.emp_numero_matricula, 
                           (CASE WHEN length(a.emp_qfu_hfl_uor_cod_acum) > 0 THEN a.emp_qfu_hfl_uor_cod_acum ELSE a.emp_uor_codigo_lotacao END) as emp_uor_codigo  
                    FROM cadastros a LEFT JOIN cadastros acu ON a.emp_numero_matricula = acu.emp_numero_matricula
                    WHERE a.emp_status != 2 
                    AND   (a.emp_qfu_fun_codigo IN 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un
                                   WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                     AND un.uor_codigo = a.emp_uor_codigo_lotacao) 
                    OR   a.emp_qfu_fun_codigo_acumula in 
                                 (SELECT m.cod_funcao_chefia 
                                    FROM tipo_uor_funcao m
                                       , unidades_organizacionais un 
                                   WHERE  m.cod_tipo_uor = un.uor_tipo_unidad_org 
                                   AND un.uor_codigo = a.emp_qfu_hfl_uor_cod_acum))
                    )) chefe
        ON uor.uor_codigo = chefe.emp_uor_codigo
        INNER JOIN cadastros a ON a.emp_numero_matricula = chefe.emp_numero_matricula
        LEFT JOIN ocorrencias_empregados o ON chefe.emp_numero_matricula = o.oem_emp_numero_matricula_subst AND o.oem_data_inicio <= TRUNC (SYSDATE) AND o.oem_data_termino >= TRUNC (SYSDATE) 
        LEFT JOIN cadastros o1 ON o.oem_emp_numero_matricula = o1.emp_numero_matricula 
        INNER JOIN IFRAGENDA.viw_cadastros v ON a.emp_numero_matricula = v.emp_numero_matricula
         WHERE chefe.emp_uor_codigo IN (SELECT a.uor_codigo
                                          FROM unidades_organizacionais a 
                                         WHERE  a.uor_dep_codigo = 1 
                                           AND 10200000 IN (SELECT b.uor_codigo
                                                              FROM unidades_organizacionais b
                                                             WHERE b.uor_data_extincao IS NULL 
                                                               AND b.uor_dep_codigo = 1
                                                             START  WITH b.uor_codigo = a.uor_codigo
                                                           CONNECT BY PRIOR b.uor_codigo = b.uor_uor_codigo)
                                         START WITH uor_uor_codigo IS NULL
                                      CONNECT BY PRIOR a.uor_codigo = a.uor_uor_codigo)
         AND (v.emp_qfu_funcao= 'DIRETOR DE ADMINISTRA플O')
         AND (v.emp_qfu_funcao IS NOT NULL )
         ORDER BY uor.uor_tipo_unidad_org  desc)
WHERE ROWNUM < 2
union
SELECT emp_numero_matricula AS MATRICULA_CPF, 
emp_nome_abreviado AS NOME, 
emp_dep_lotacao AS DEPENDENCIA,
emp_uor_sigla AS LOTACAO, 
emp_endereco_eletronico_mail AS EMAIL, 
('I'||LTRIM(TO_CHAR(emp_numero_matricula, '0000000'))) AS MAT_GERAL
FROM IFRAGENDA.viw_cadastros
WHERE emp_status = 'ATIVO'
AND emp_uor_codigo_lotacao = 10200000 
AND ((emp_qlp_cargo = 'DIRETOR DE ADMINISTRA플O' AND emp_qfu_funcao IS NULL) OR (emp_qfu_funcao= 'DIRETOR DE ADMINISTRA플O'))
union
SELECT emp_numero_matricula AS MATRICULA_CPF, 
emp_nome_abreviado AS NOME, 
emp_dep_lotacao AS DEPENDENCIA,
(select uor_sigla from unidades_organizacionais where emp_qfu_hfl_uor_cod_acum = uor_codigo) AS LOTACAO, 
emp_endereco_eletronico_mail AS EMAIL, 
('I'||LTRIM(TO_CHAR(emp_numero_matricula, '0000000'))) AS MAT_GERAL 
FROM ifragenda.viw_cadastros
WHERE emp_status = 'ATIVO'
AND   'DIRETOR DE ADMINISTRA플O' = (SELECT FUN_NOME FROM CARGOS_CONFIANCA WHERE fun_codigo=EMP_QFU_FUN_CODIGO_ACUMULA)
AND emp_qfu_hfl_uor_cod_acum IN (
SELECT  UOR_CODIGO
  FROM  UNIDADES_ORGANIZACIONAIS
 WHERE  UOR_CODIGO = 10200000
   AND  UOR_DATA_EXTINCAO IS NULL)
ORDER BY 2