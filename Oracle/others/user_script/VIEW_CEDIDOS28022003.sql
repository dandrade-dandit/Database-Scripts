

-- View VIEW_CEDIDOS

CREATE OR REPLACE VIEW view_cedidos (
   codigo_dependencia,
   dep_sigla,
   uor_sigla,
   descricao_uor,
   matricula,
   nome,
   nome_abreviado,
   emp_status,
   numero_cpf,
   data_inicio,
   data_termino,
   codigo_ocorrencia,
   descricao_ocorrencia,
   codigo_orgao,
   sigla_orgao,
   nome_orgao )
AS
select dep_codigo codigo_Dependencia,
       dep_sigla dep_Sigla,
       uor_sigla UOR_sigla,
       uor_nome Descricao_UOR,
       emp_numero_matricula Matricula,
       emp_nome Nome,
       emp_nome_abreviado,
       emp_status,
       emp_numero_cpf,
       oem_data_inicio Data_Inicio,
       oem_data_termino Data_Termino,
       oem_ofu_codigo codigo_Ocorrencia,
       ofu_descricao Descricao_Ocorrencia,
       oex_codigo codigo_orgao,
       oex_sigla sigla_orgao,
       oex_nome nome_orgao
from cadastros,
     ocorrencias_empregados,
     tipos_ocorrencias,
     unidades_organizacionais,
     dependencias,
     orgaos_externos
where emp_numero_matricula   = oem_emp_numero_matricula
and   oem_ofu_codigo        in(135,136,203,249,250,251,253,254)
-- and   (oem_data_termino is null
--         or  oem_data_termino > sysdate)
-- and   oem_data_inicio < '31/12/2001'      
and   oem_ofu_codigo         = ofu_codigo
and   emp_uor_codigo_lotacao = uor_codigo(+)
and   emp_dep_codigo_lotacao = dep_codigo(+)
and   oem_oex_codigo_cedido  = oex_codigo(+)
order by dep_sigla,
         uor_sigla,
         emp_nome
/


-- End of DDL script for VIEW_CEDIDOS
