SELECT  --*
'UPDATE CADASTROS SET ' || 
'  emp_qlp_car_codigo =  ' ||  NVL(TO_CHAR(emp_qlp_car_codigo),'NULL') ||
', emp_qlp_car_codigo_nivel = ' ||  NVL(TO_CHAR(emp_qlp_car_codigo_nivel),'NULL') || 
', emp_qlp_car_occ_codigo  =  ' ||  NVL(TO_CHAR(emp_qlp_car_occ_codigo),'NULL') ||
', emp_qfu_fun_codigo =  ' || NVL(TO_CHAR(emp_qfu_fun_codigo),'NULL') ||
', emp_qfu_hfl_uor_codigo =  ' ||  NVL(TO_CHAR(emp_qfu_hfl_uor_codigo),'NULL') ||
', emp_tipo_remuneracao_funcao =  ''' ||  NVL(TO_CHAR(emp_tipo_remuneracao_funcao),'') || '''' ||
', emp_qfu_fun_codigo_substitui =  ' ||  NVL(TO_CHAR(emp_qfu_fun_codigo_substitui),'NULL') ||
', emp_qfu_hfl_uor_cod_subst =  ' ||  NVL(TO_CHAR(emp_qfu_hfl_uor_cod_subst),'NULL') ||
', emp_dep_codigo_lotacao =  ' || emp_dep_codigo_lotacao ||
', emp_dep_codigo_pagto =  ' || emp_dep_codigo_pagto ||
', emp_dep_codigo_fisico =  ' || emp_dep_codigo_fisico ||
', emp_uor_codigo_lotacao =  ' || emp_uor_codigo_lotacao || 
', emp_uor_codigo_fisico =  ' || emp_uor_codigo_fisico ||
', emp_uor_codigo_fisico_agenda =  ' || emp_uor_codigo_fisico_agenda ||
' WHERE EMP_NUMERO_MATRICULA = ' || EMP_NUMERO_MATRICULA || ';'
  FROM  CADASTROS
 WHERE  (EMP_NOME LIKE 'ANTONIO%PADUA%' OR
        EMP_NOME LIKE 'DENEZIR%CARRIJO%' OR
        EMP_NOME LIKE 'LUCIANO%MAZZEI%' OR
        EMP_NOME LIKE 'ALMIR%CRUZ%' OR
        EMP_NOME LIKE 'EXPEDITA%MESQUITAemp_nsa_codigo_padrao%' OR
        EMP_NOME LIKE 'SILVIA%NAVES%' OR
        EMP_NOME LIKE 'RAUL%COSTA%' OR
        EMP_NOME LIKE 'GILMARA%COLARES%' OR
        EMP_NOME LIKE 'CHRISTIANO%MORAES%')
        
 AND EMP_STATUS != 2

SELECT  --*
'UPDATE CADASTROS SET ' || 
'  emp_qlp_car_codigo =  ' ||  NVL(TO_CHAR(emp_qlp_car_codigo),'NULL') ||
', emp_qlp_car_codigo_nivel = ' ||  NVL(TO_CHAR(emp_qlp_car_codigo_nivel),'NULL') || 
', emp_qlp_car_occ_codigo  =  ' ||  NVL(TO_CHAR(emp_qlp_car_occ_codigo),'NULL') ||
', emp_qfu_fun_codigo =  ' || NVL(TO_CHAR(emp_qfu_fun_codigo),'NULL') ||
', emp_qfu_hfl_uor_codigo =  ' ||  NVL(TO_CHAR(emp_qfu_hfl_uor_codigo),'NULL') ||
', emp_tipo_remuneracao_funcao =  ''' ||  NVL(TO_CHAR(emp_tipo_remuneracao_funcao),'') || '''' ||
', emp_qfu_fun_codigo_substitui =  ' ||  NVL(TO_CHAR(emp_qfu_fun_codigo_substitui),'NULL') ||
', emp_qfu_hfl_uor_cod_subst =  ' ||  NVL(TO_CHAR(emp_qfu_hfl_uor_cod_subst),'NULL') ||
', emp_dep_codigo_lotacao =  ' || emp_dep_codigo_lotacao ||
', emp_dep_codigo_pagto =  ' || emp_dep_codigo_pagto ||
', emp_dep_codigo_fisico =  ' || emp_dep_codigo_fisico ||
', emp_uor_codigo_lotacao =  ' || emp_uor_codigo_lotacao || 
', emp_uor_codigo_fisico =  ' || emp_uor_codigo_fisico ||
', emp_uor_codigo_fisico_agenda =  ' || emp_uor_codigo_fisico_agenda ||
' WHERE EMP_NUMERO_MATRICULA = ' || EMP_NUMERO_MATRICULA || ';'
  FROM  CADASTROS
 WHERE  EMP_NUMERO_MATRICULA IN ( 787501, 4188210, 788302, 801644, 823140, 4129525, 764126, 737227)
 AND EMP_STATUS != 2


EXEC ifragenda.proc_carga_age_empregados;



 UPDATE CADASTROS SET 
, emp_dep_codigo_lotacao =  2
, emp_dep_codigo_pagto =  2
, emp_dep_codigo_fisico =  2
, emp_uor_codigo_lotacao =  11236 
, emp_uor_codigo_fisico =  11236
, emp_uor_codigo_fisico_agenda =  11236
 WHERE EMP_NUMERO_MATRICULA =  
/


EXEC ifragenda.proc_carga_age_empregados;