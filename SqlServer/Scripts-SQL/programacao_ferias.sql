SELECT C.emp_nome, c.emp_numero_matricula  ,  pfe_data_inicio_2
   ,  pfe_data_termino_2
FROM IFRSRH.PROGRAMACOES_FERIAS p
   ,  IFRSRH.CADASTROS C
where pfe_data_inicio_2 >= to_date('08/04/2013','DD/MM/RRRR')
  and pfe_data_termino_2 < to_date('30/04/2013','DD/MM/RRRR')
  AND  EMP_NUMERO_MATRICULA = PFE_EMP_NUMERO_MATRICULA
  AND  c.emp_dep_codigo_fisico = 1
  order by 1