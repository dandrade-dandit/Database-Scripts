SELECT *
FROM DESC CADASTROS
  where EMP_NUMERO_MATRICULA = 1442835
  
SELECT * FROM UNIDADES_ORGANIZACIONAIS WHERE UOR_DEP_CODIGO = 162 AND UOR_DATA_EXTINCAO IS NULL
    
    
UPDATE CADASTROS SET EMP_DEP_CODIGO_LOTACAO=162, EMP_DEP_CODIGO_PAGTO=162, EMP_DEP_CODIGO_FISICO=162,
EMP_UOR_CODIGO_LOTACAO=12066,EMP_UOR_CODIGO_FISICO=12066,EMP_UOR_CODIGO_FISICO_AGENDA=12066,
emp_qfu_fun_codigo=963, emp_qfu_hfl_uor_codigo=12066, emp_qfu_hfl_data_vigencia=to_date('26/02/2010','DD/MM/YYYY'), EMP_TIPO_REMUNERACAO_FUNCAO = 'RG'
WHERE EMP_NUMERO_MATRICULA = 1442835

UPDATE CADASTROS
SET EMP_STATUS = 2
WHERE EMP_NUMERO_MATRICULA = 1951711

select *
from cadastros
where EMP_UOR_CODIGO_FISICO=12066