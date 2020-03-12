select   oem_emp_numero_matricula AS MATRICULA
     ,   (select emp_nome from cadastros where emp_numero_matricula = oem_emp_numero_matricula) AS NOME
     ,   oem_data_inicio AS DATA_DESLIGAMENTO
  from   OCORRENCIAS_EMPREGADOS
 where   oem_ofu_codigo = 264
   and   oem_data_inicio >= to_date('01/11/2010','DD/MM/YYYY')
   and   oem_data_inicio <  to_date('01/12/2010','DD/MM/YYYY')
 order by 2
