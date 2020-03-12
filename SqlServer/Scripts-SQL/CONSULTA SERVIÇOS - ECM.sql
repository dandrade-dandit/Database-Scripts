--original
 SELECT * 
 FROM (SELECT CASE WHEN LENGTH (o1.emp_nome) > 0 THEN 
        o1.emp_numero_matricula
        ELSE a.emp_numero_matricula END as MATRICULA, 
        CASE WHEN LENGTH (o1.emp_nome) > 0THEN 
          o1.emp_nome 
        ELSE a.emp_nome END as NOME, 
        CASE WHEN LENGTH (o1.emp_nome) > 0 THEN 
          o1.emp_endereco_eletronico_mail
        ELSE a.emp_endereco_eletronico_mail END as EMAIL,
        uor.uor_uor_codigo AS UOR_UOR_CODIGO
        FROM unidades_organizacionais uor 
        INNER JOIN (SELECT a.emp_numero_matricula, 
            CASE WHEN length(a.emp_qfu_hfl_uor_cod_acum) > 0 THEN 
              a.emp_qfu_hfl_uor_cod_acum 
            ELSE a.emp_uor_codigo_fisico 
            END as emp_uor_codigo  
            FROM cadastros a LEFT JOIN cadastros acu ON a.emp_numero_matricula = acu.emp_numero_matricula
            WHERE a.emp_status != 2 AND a.emp_qfu_fun_codigo in 
            (SELECT m.cod_funcao_chefia FROM tipo_uor_funcao m, unidades_organizacionais un
            WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org AND un.uor_codigo = a.emp_uor_codigo_fisico) 
            OR a.emp_qfu_fun_codigo_acumula in (SELECT m.cod_funcao_chefia 
            FROM tipo_uor_funcao m, unidades_organizacionais un 
            WHERE  m.cod_tipo_uor = un.uor_tipo_unidad_org AND un.uor_codigo = a.emp_qfu_hfl_uor_cod_acum )) chefe
        ON uor.uor_codigo = chefe.emp_uor_codigo
        INNER JOIN cadastros a ON a.emp_numero_matricula = chefe.emp_numero_matricula 
        LEFT OUTER JOIN ocorrencias_empregados o ON chefe.emp_numero_matricula = o.oem_emp_numero_matricula_subst
          AND o.oem_data_inicio <= TRUNC (SYSDATE) AND o.oem_data_termino >= TRUNC (SYSDATE) 
        LEFT JOIN cadastros o1 ON o.oem_emp_numero_matricula = o1.emp_numero_matricula 
                                  WHERE chefe.emp_uor_codigo IN (SELECT a.uor_codigo
                                                                  FROM unidades_organizacionais a 
                                                                  WHERE  a.uor_dep_codigo = 1 
                                                                  AND 10600000 IN (SELECT b.uor_codigo
                                                                              FROM unidades_organizacionais b
                                                                              WHERE b.uor_data_extincao IS NULL 
                                                                              AND b.uor_dep_codigo = 1
                                                                              START  WITH b.uor_codigo = a.uor_codigo
                                                                              CONNECT BY PRIOR b.uor_codigo = b.uor_uor_codigo)
                                  START WITH uor_uor_codigo IS NULL
                                  CONNECT BY PRIOR a.uor_codigo = a.uor_uor_codigo)
                                  ORDER   BY uor.uor_tipo_unidad_org desc)
WHERE ROWNUM < 2


--alterado
SELECT * 
 FROM (SELECT CASE WHEN LENGTH (o1.emp_nome) > 0 THEN 
        o1.emp_numero_matricula
        ELSE a.emp_numero_matricula END as MATRICULA_CPF, 
        CASE WHEN LENGTH (o1.emp_nome) > 0THEN 
          o1.emp_nome 
        ELSE a.emp_nome END as NOME, 
        (SELECT DEP_SIGLA FROM DEPENDENCIAS WHERE DEP_CODIGO = a.emp_dep_codigo_fisico) as DEPENDENCIA,
        uor.uor_sigla AS LOTACAO,
        CASE WHEN LENGTH (o1.emp_nome) > 0 THEN 
          o1.emp_endereco_eletronico_mail
        ELSE a.emp_endereco_eletronico_mail END as EMAIL,
        ('I'||LTRIM(TO_CHAR(CASE WHEN LENGTH (o1.emp_nome) > 0 THEN 
        o1.emp_numero_matricula
        ELSE a.emp_numero_matricula END, '0000000'))) AS MAT_GERAL
        FROM unidades_organizacionais uor 
        INNER JOIN (SELECT a.emp_numero_matricula, 
            CASE WHEN length(a.emp_qfu_hfl_uor_cod_acum) > 0 THEN 
              a.emp_qfu_hfl_uor_cod_acum 
            ELSE a.emp_uor_codigo_fisico 
            END as emp_uor_codigo  
            FROM cadastros a LEFT JOIN cadastros acu ON a.emp_numero_matricula = acu.emp_numero_matricula
            WHERE a.emp_status != 2 AND a.emp_qfu_fun_codigo in 
            (SELECT m.cod_funcao_chefia FROM tipo_uor_funcao m, unidades_organizacionais un
            WHERE m.cod_tipo_uor = un.uor_tipo_unidad_org AND un.uor_codigo = a.emp_uor_codigo_fisico) 
            OR a.emp_qfu_fun_codigo_acumula in (SELECT m.cod_funcao_chefia 
            FROM tipo_uor_funcao m, unidades_organizacionais un 
            WHERE  m.cod_tipo_uor = un.uor_tipo_unidad_org AND un.uor_codigo = a.emp_qfu_hfl_uor_cod_acum )) chefe
        ON uor.uor_codigo = chefe.emp_uor_codigo
        INNER JOIN cadastros a ON a.emp_numero_matricula = chefe.emp_numero_matricula 
        LEFT OUTER JOIN ocorrencias_empregados o ON chefe.emp_numero_matricula = o.oem_emp_numero_matricula_subst
          AND o.oem_data_inicio <= TRUNC (SYSDATE) AND o.oem_data_termino >= TRUNC (SYSDATE) 
        LEFT JOIN cadastros o1 ON o.oem_emp_numero_matricula = o1.emp_numero_matricula 
                                  WHERE chefe.emp_uor_codigo IN (SELECT a.uor_codigo
                                                                  FROM unidades_organizacionais a 
                                                                  WHERE  a.uor_dep_codigo = 1 
                                                                  AND 10600000 IN (SELECT b.uor_codigo
                                                                              FROM unidades_organizacionais b
                                                                              WHERE b.uor_data_extincao IS NULL 
                                                                              AND b.uor_dep_codigo = 1
                                                                              START  WITH b.uor_codigo = a.uor_codigo
                                                                              CONNECT BY PRIOR b.uor_codigo = b.uor_uor_codigo)
                                  START WITH uor_uor_codigo IS NULL
                                  CONNECT BY PRIOR a.uor_codigo = a.uor_uor_codigo)
                                  ORDER   BY uor.uor_tipo_unidad_org desc)
WHERE ROWNUM < 2
