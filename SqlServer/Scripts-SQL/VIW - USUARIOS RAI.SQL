CREATE OR REPLACE FORCE VIEW "IFRMYSAR"."VIW_USUARIOS_IDM" ("MATRICULA", "NOME", "DEPENDENCIA", "LOTACAO", "FUNCAO")
AS
  SELECT 'i'
    ||lpad(num_matricula,7,'0') matricula,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(nme_cadastro), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e ') nome ,
    cod_dep_fisica dependencia ,
    cod_uor_fisica lotacao,
    (SELECT
      CASE
        WHEN emp_qfu_fun_codigo = 680
        THEN 1
        WHEN emp_qfu_fun_codigo = 685
        THEN 1
        WHEN emp_qfu_fun_codigo = 686
        THEN 1
        WHEN emp_qfu_fun_codigo = 687
        THEN 1
        WHEN emp_qfu_fun_codigo = 688
        THEN 1
        WHEN emp_qfu_fun_codigo = 877
        THEN 1
        WHEN emp_qfu_fun_codigo = 878
        THEN 1
        WHEN emp_qfu_fun_codigo = 880
        THEN 1
        WHEN emp_qfu_fun_codigo = 883
        THEN 1
        WHEN emp_qfu_fun_codigo = 884
        THEN 1
        WHEN emp_qfu_fun_codigo = 885
        THEN 1
        WHEN emp_qfu_fun_codigo = 886
        THEN 1
        WHEN emp_qfu_fun_codigo = 889
        THEN 1
        WHEN emp_qfu_fun_codigo = 890
        THEN 1
        WHEN emp_qfu_fun_codigo = 891
        THEN 1
        WHEN emp_qfu_fun_codigo = 895
        THEN 1
        WHEN emp_qfu_fun_codigo = 897
        THEN 1
        WHEN emp_qfu_fun_codigo = 898
        THEN 1
        WHEN emp_qfu_fun_codigo = 902
        THEN 1
        WHEN emp_qfu_fun_codigo = 903
        THEN 1
        WHEN emp_qfu_fun_codigo = 905
        THEN 1
        WHEN emp_qfu_fun_codigo = 907
        THEN 1
        WHEN emp_qfu_fun_codigo = 908
        THEN 1
        WHEN emp_qfu_fun_codigo = 913
        THEN 1
        WHEN emp_qfu_fun_codigo = 914
        THEN 1
        WHEN emp_qfu_fun_codigo = 918
        THEN 1
        WHEN emp_qfu_fun_codigo = 923
        THEN 1
        WHEN emp_qfu_fun_codigo = 925
        THEN 1
        WHEN emp_qfu_fun_codigo = 926
        THEN 1
        WHEN emp_qfu_fun_codigo = 927
        THEN 1
        WHEN emp_qfu_fun_codigo = 928
        THEN 1
        WHEN emp_qfu_fun_codigo = 929
        THEN 1
        WHEN emp_qfu_fun_codigo = 937
        THEN 1
        WHEN emp_qfu_fun_codigo = 945
        THEN 1
        WHEN emp_qfu_fun_codigo = 940
        THEN 1
        WHEN emp_qfu_fun_codigo = 943
        THEN 1
        WHEN emp_qfu_fun_codigo = 946
        THEN 1
        WHEN emp_qfu_fun_codigo = 947
        THEN 1
        WHEN emp_qfu_fun_codigo = 953
        THEN 1
        WHEN emp_qfu_fun_codigo = 963
        THEN 1
        WHEN emp_qfu_fun_codigo = 970
        THEN 1
        WHEN emp_qfu_fun_codigo = 971
        THEN 1
        WHEN emp_qfu_fun_codigo = 972
        THEN 1
        WHEN emp_qfu_fun_codigo = 973
        THEN 1
        WHEN emp_qfu_fun_codigo = 974
        THEN 1
        WHEN emp_qfu_fun_codigo = 975
        THEN 1
        WHEN emp_qfu_fun_codigo = 976
        THEN 1
        ELSE 0
      END
    FROM cadastros
    WHERE emp_numero_matricula = a.num_matricula
    ) funcao
  FROM IFRCORP.tab_interface_idm a
  WHERE dsc_situacao_funcional IN ('A', 'L')
  UNION ALL
  SELECT 't'
    ||SUBSTR(num_cpf,1,9) matricula ,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(nme_cadastro), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e ') nome ,
    (SELECT DEP_CODIGO
    FROM DEPENDENCIAS
    WHERE DEP_DATA_EXTINCAO IS NULL
    AND DEP_SIGLA            = NVL(
      (SELECT DEPENDENCIA
      FROM TAB_AGE_EMPREGADOS
      WHERE MAT_GERAL = 'T'
        ||SUBSTR(num_cpf,1,9)
      ),SIG_AEROPORTO)
    AND ROWNUM <= 1
    ) AS dependencia ,
    (SELECT UOR_CODIGO
    FROM UNIDADES_ORGANIZACIONAIS
    WHERE UOR_DATA_EXTINCAO IS NULL
    AND UOR_SIGLA            = DECODE(SIG_UOR_FISICA,'?',NVL(
      (SELECT LOTACAO
      FROM TAB_AGE_EMPREGADOS
      WHERE MAT_GERAL = 'T'
        ||SUBSTR(num_cpf,1,9)
      ),SIG_AEROPORTO),SIG_UOR_FISICA)--DECODE(SIG_UOR_FISICA,'?',(SELECT LOTACAO FROM TAB_AGE_EMPREGADOS WHERE MAT_GERAL = 'T' ||SUBSTR(num_cpf,1,9)),SIG_UOR_FISICA)
    AND ROWNUM <= 1
    ) AS lotacao,
    0 funcao
  FROM IFRCORP.tab_interface_idm_terc
  WHERE dsc_situacao_funcional = 'A';
UNION ALL
  SELECT 't'
    ||SUBSTR(num_cpf,1,9) matricula ,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(nme_cadastro), ' Da ', ' da '), ' De ', ' de '), ' Do ', ' do '), ' Dos ', ' dos '), ' Das ', ' das '), ' E ', ' e ') nome ,
    cod_dep_fisica dependencia ,
    cod_uor_fisica lotacao,
    0 funcao
  FROM IFRCORP.tab_interface_idm_estag
  WHERE dsc_situacao_funcional = 'ATIVO';