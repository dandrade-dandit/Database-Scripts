SELECT a.seq_candidato, a.num_concurso, a.num_inscricao,
       a.nom_candidato, a.tip_sexo, a.seq_cargo_concurso,
       a.num_classificacao, a.mun_codigo_candidato,
       a.mun_ufe_sigla_candidato, a.num_nota_final, a.num_identidade,
       a.dsc_orgao_emissor, a.dsc_uf_orgao_emissor, a.num_cpf,
       a.dat_nascimento, a.flg_pne, a.tip_pne, a.dep_cod_concurso,
       a.cod_raca, a.num_cor_cpf, (SELECT dsc_cargo_concurso FROM ifrsrh_concurso.tab_cargo_concurso WHERE seq_cargo_concurso=a.seq_cargo_concurso) AS NOM_CARGO 
  FROM ifrsrh_concurso.cad_candidato a
  WHERE a.num_concurso = '01.2/2009.01'


SELECT a.seq_candidato, a.num_concurso, a.num_inscricao,
       a.nom_candidato, a.tip_sexo, a.seq_cargo_concurso,
       a.num_classificacao, a.mun_codigo_candidato,
       a.mun_ufe_sigla_candidato, a.num_nota_final, a.num_identidade,
       a.dsc_orgao_emissor, a.dsc_uf_orgao_emissor, a.num_cpf,
       a.dat_nascimento, a.flg_pne, a.tip_pne, a.dep_cod_concurso,
       a.cod_raca, a.num_cor_cpf, (SELECT dsc_cargo_concurso FROM ifrsrh_concurso.tab_cargo_concurso WHERE seq_cargo_concurso=a.seq_cargo_concurso) AS NOM_CARGO 
  FROM ifrsrh_concurso.cad_candidato a
  WHERE a.num_concurso = '01.2/2009.01'
  and a.mun_ufe_sigla_candidato =  'DF'
  and a.seq_cargo_concurso in (163835, 168171, 163910, 168360, 163813, 163581)
  and num_classificacao > '0000000000'
  order by seq_cargo_concurso, num_classificacao

--SELECT * FROM VALOR_INCENTIVO WHERE ANO_PDVI = 2009 AND DAT_DESLIGAMENTO IS NOT NULL


create or replace VIEW PESQUISA AS
SELECT 
        a.egt_emp_numero_matricula
,       b.emp_nome
,       (select dep_sigla from dependencias where dep_codigo = a.egt_dep_codigo) as "sigla dependência de lotação"
,       (select uor_sigla from unidades_organizacionais where uor_codigo = a.egt_uor_codigo) as "sigla lotação"
,       a.egt_crp_ano_pagamento
,       a.egt_crp_mes_pagamento
,       a.egt_remuneracao_liquido
  FROM  ifrsrh.empregados_pagamentos a
  ,     ifrsrh.cadastros b
  WHERE a.egt_emp_numero_matricula = b.emp_numero_matricula
    AND a.egt_crp_ano_pagamento in (2005, 2006, 2007, 2008, 2009)
    AND a.egt_crp_sequencial in (1,2)
 ORDER
    BY  b.emp_dep_codigo_fisico
,       a.egt_crp_ano_pagamento
,       a.egt_crp_mes_pagamento  