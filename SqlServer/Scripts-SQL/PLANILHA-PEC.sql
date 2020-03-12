--***************************************************************************************
SELECT  *--UOR_SIGLA
  FROM  UOR
 --WHERE  uor_SIGLA = 'SBUL' AND uor_data_extincao IS NULL
  start 
   with UOR.UOR_CODIGO = 11759
connect 
     by 
  prior UOR.UOR_CODIGO = UOR.UOR_UOR_CODIGO


--***************************************************************************************
SELECT  NOME, CARGO_FUNCAO, DEPENDENCIA, LOTACAO, EMAIL, DDD, TELEFONE, VOIP
  FROM  IFRAGENDA.viw_age_empregados
 WHERE  LOTACAO IN (
SELECT  UOR_SIGLA
  FROM  UOR
  WHERE LOTACAO != 'CEDIDO'
  start 
   with UOR.UOR_CODIGO = 11759 --11621 --13790
connect 
     by 
  prior UOR.UOR_CODIGO = UOR.UOR_UOR_CODIGO)
  ORDER BY LOTACAO, NOME


--***************************************************************************************