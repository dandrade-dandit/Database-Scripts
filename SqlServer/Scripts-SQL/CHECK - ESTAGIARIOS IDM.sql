SELECT  *
  FROM  cad_estagiario_pessoal
 WHERE  nom_estagiario LIKE 'NATÁLIA SC%'
 
 
 SELECT *
  FROM cad_estagiario
  WHERE SEQ_ESTAGIARIO_PESSOAL = 38757
  
  
SELECT *
  FROM UOR
WHERE  UOR_CODIGO = 12557

select
DISTINCT lpad(NUM_CPF,11,'0') NUM_CPF,
          DAT_NASCIMENTO,
          NUM_IDENTIDADE,
          DSC_ORGAO_EMISSOR,
          NUM_TELEFONE,
          NOM_ESTAGIARIO,
          NULL EMAIL,
          E.DEP_CODIGO,
          E.DEP_SIGLA,
          E.DEP_NOME,
          D.UOR_CODIGO,
          D.UOR_SIGLA,
          D.UOR_NOME,
          CASE FLG_DESLIGADO
            WHEN 'S'
            THEN 'INATIVO'
            ELSE 'ATIVO'
          END FLG_DESLIGADO,
          B.DAT_INICIO,
          'CIEE'
        FROM CAD_ESTAGIARIO B        
        INNER JOIN CAD_ESTAGIARIO_LOCALIZACAO C
        ON (C.SEQ_ESTAGIARIO = B.SEQ_ESTAGIARIO)
        LEFT JOIN UNIDADES_ORGANIZACIONAIS D
        ON (C.UOR_CODIGO = D.UOR_CODIGO)
        LEFT JOIN DEPENDENCIAS E
        ON (D.UOR_DEP_CODIGO     = E.DEP_CODIGO)
        AND (E.DEP_CODIGO        = B.DEP_CODIGO)
        INNER JOIN cad_estagiario_pessoal P
        ON (B.SEQ_ESTAGIARIO_PESSOAL = p.SEQ_ESTAGIARIO_PESSOAL)
        WHERE 
        B.FLG_DESLIGADO     != 'S'
        --AND d.uor_data_extincao IS NULL
        AND e.dep_data_extincao IS NULL
        --AND (c.dat_termino      IS NULL        OR c.dat_termino        >= sysdate)
        AND NOM_ESTAGIARIO LIKE 'NATÁLIA SC%';