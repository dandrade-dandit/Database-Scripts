select  e.matricula 
     ,  e.nome
     ,  e.dependencia
     ,  e.lotacao
     ,  e.cargo_funcao
     ,  e.email
     ,  e.ddd || ' ' || e.telefone as telefone
     ,  e.voip
     ,  c.EMP_DDD_CELULAR_CORP || ' ' || c.EMP_NUMERO_CELULAR_CORP CEL_COPORATIVO
  from viw_age_empregados e
     , IFRAGENDA.CELULAR_CORPORATIVO c
 where e.matricula = c.EMP_MATRICULA(+) 
  and  e.I_T = 'I'
  and  e.dependencia NOT LIKE 'TA%'
 order
    by 3,4,2