--1

SELECT  emp_numero_matricula "Matrícula"
,       emp_nome "Nome"
,       emp_numero_cpf "CPF"
,       emp_endereco_eletronico_mail "E-Mail"
,       DECODE(emp_qfu_fun_codigo, '', (select car_nome from cargos c where c.car_codigo = emp_qlp_car_codigo and c.car_codigo_nivel =emp_qlp_car_codigo_nivel  and c.car_occ_codigo = emp_qlp_car_occ_codigo), (SELECT a.fun_nome FROM ifrsrh.cargos_confianca a where a.fun_codigo = emp_qfu_fun_codigo) ) "Cargo"
,       (select uor_sigla from unidades_organizacionais where uor_codigo = emp_uor_codigo_fisico) "Sigla Lotação"
,       (select uor_nome from unidades_organizacionais where uor_codigo = emp_uor_codigo_fisico) "Nome Lotação"
,       (select dep_sigla from dependencias where dep_codigo = emp_dep_codigo_fisico) "Sigla Dependência"
,       (select dep_nome from dependencias where dep_codigo = emp_dep_codigo_fisico) "Nome Dependência"
,       null "DDD"
,       null "Ramal"
FROM    CADASTROS
WHERE   EMP_STATUS <> 2
and     emp_numero_matricula in (
select emp_numero_matricula
from cadastros
where emp_status <> 2
minus
select efc_emp_numero_matricula 
from EMPREGADO_FONE_COMERCIAL
)
order by 2



--2

SELECT  emp_numero_matricula "Matrícula"
,       emp_nome "Nome"
,       emp_numero_cpf "CPF"
,       emp_endereco_eletronico_mail "E-Mail"
,       DECODE(emp_qfu_fun_codigo, '', (select car_nome from cargos c where c.car_codigo = emp_qlp_car_codigo and c.car_codigo_nivel =emp_qlp_car_codigo_nivel  and c.car_occ_codigo = emp_qlp_car_occ_codigo), (SELECT a.fun_nome FROM ifrsrh.cargos_confianca a where a.fun_codigo = emp_qfu_fun_codigo) ) "Cargo"
,       (nvl(decode((select dep_sigla from dependencias where dep_codigo in(select dep_dep_codigo from dependencias where dep_codigo = emp_dep_codigo_fisico)), 'SEDE',(select dep_sigla from dependencias where dep_codigo = emp_dep_codigo_fisico), (select dep_sigla from dependencias where dep_codigo in(select dep_dep_codigo from dependencias where dep_codigo = emp_dep_codigo_fisico))),'SEDE' )) "Sigla da Regional"
,       (nvl(decode((select dep_sigla from dependencias where dep_codigo in(select dep_dep_codigo from dependencias where dep_codigo = emp_dep_codigo_fisico)), 'SEDE',(select dep_nome from dependencias where dep_codigo = emp_dep_codigo_fisico), (select dep_nome from dependencias where dep_codigo in(select dep_dep_codigo from dependencias where dep_codigo = emp_dep_codigo_fisico))),'SEDE' )) "Nome da Regional"
,       (select dep_sigla from dependencias where dep_codigo = emp_dep_codigo_fisico) "Sigla Dependência"
,       (select dep_nome from dependencias where dep_codigo = emp_dep_codigo_fisico) "Nome Dependência"
,       (select uor_sigla from unidades_organizacionais where uor_codigo = emp_uor_codigo_fisico) "Sigla Lotação"
,       (select uor_nome from unidades_organizacionais where uor_codigo = emp_uor_codigo_fisico) "Nome Lotação"
,       null "DDD"
,       null "Ramal"
FROM    CADASTROS
WHERE   EMP_STATUS <> 2
and     emp_dep_codigo_fisico  <> 902
and     emp_uor_codigo_fisico <> 10999999
and     emp_numero_matricula in (
select emp_numero_matricula
from cadastros
where emp_status <> 2
minus
select efc_emp_numero_matricula 
from EMPREGADO_FONE_COMERCIAL
)
order by 6,8,10,2

