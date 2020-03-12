DECLARE 
CURSOR C1 IS  
SELECT  a.logradouro, a.bairro,a.uf, a.cep, a.municipio, a.dddfone, a.fone, a.dddfax, a.fax, A.UOR_COD
FROM UNIDADES_ORGANIZACIONAIS U
,    uor a
WHERE A.uor_cod = U.UOR_CODIGO;


BEGIN
FOR X IN C1 LOOP

UPDATE  UNIDADES_ORGANIZACIONAIS
SET     UOR_ENDERECO_LOGRADOURO = X.logradouro
,       UOR_ENDERECO_BAIRRO     = X.bairro
,       uor_endereco_municipio  = X.municipio
,       UOR_UFE_SIGLA           = SUBSTR(X.uf,1,2)
,       UOR_CEP                 = X.cep
,       uor_numero_fax          = X.fax
WHERE   UOR_CODIGO              = X.UOR_COD;

END LOOP;
END;


/*

SELECT a.dep_cod, a.uor_cod, a.logradouro, a.bairro, a.municipio, a.uf,
       a.cep, a.dddfone, a.fone, a.dddfax, a.fax
  FROM uor a

  

--  alter table ifrdba2.unidades_organizacionais modify UOR_ENDERECO_LOGRADOURO varchar2(200)

SELECT * FROM ifrdba2.unidades_organizacionais WHERE UOR_DATA_EXTINCAO IS NULL


SELECT * FROM UNIDADES_ORGANIZACIONAIS
--UPDATE UNIDADES_ORGANIZACIONAIS SET  UOR_UFE_SIGLA = 'DF'
WHERE UOR_UFE_SIGLA = 'D.'

commit

SELECT  u.*
FROM UNIDADES_ORGANIZACIONAIS U
,    end_uor a
WHERE A.uor = U.UOR_CODIGO;



SELECT a.dep_cod, a.uor_cod, a.logradouro, a.bairro, a.municipio, a.uf,
       a.cep, a.dddfone, a.fone, a.dddfax, a.fax
  FROM end_uor a
  
  
  update end_uor
  set cep = replace(cep,'.','')
  
select * from UNIDADES_ORGANIZACIONAIS where uor_data_extincao is null and uor_endereco_logradouro is null

*/
