ALTER TABLE ifrsrh2.credenciados_contratos
ADD CONSTRAINT cc_dep_fk FOREIGN KEY (cc_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_estrang_reg_fk FOREIGN KEY (emp_ufe_sigla_estrangeiro)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_primeiro_emprego_fk FOREIGN KEY (
  emp_ufe_sigla_primeiro_emprego)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_reg_profis_fk FOREIGN KEY (emp_ufe_sigla_reg_profis)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_ufe_tit_eleitoral_fk FOREIGN KEY (emp_ufe_sigla_tit_eleitor)
REFERENCES ifrdba2.unidades_federacao (ufe_sigla)
/

ALTER TABLE ifrsrh2.cadastros
ADD CONSTRAINT emp_uor1_fk FOREIGN KEY (emp_uor_codigo_lotacao)
REFERENCES ifrdba2.unidades_organizacionais (uor_codigo)
/

ALTER TABLE ifrsrh2.historico_movimentacao
ADD CONSTRAINT hst_mov_pen_fk FOREIGN KEY (mov_emp_numero_matricula, 
  mov_pen_codigo)
REFERENCES ifrsrh2.pensionistas (pen_emp_numero_matricula,pen_codigo)
/

ALTER TABLE ifrsrh2.movimentacao
ADD CONSTRAINT mov_rub_fk FOREIGN KEY (mov_rub_codigo)
REFERENCES ifrsrh2.rubricas (rub_codigo)
/

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_dep_fk FOREIGN KEY (oem_dep_codigo)
REFERENCES ifrdba2.dependencias (dep_codigo)
/

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm1_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm1, 
  oem_pfe_sequencial_confirm1)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_confirm2_fk FOREIGN KEY (oem_pfe_emp_num_matr_confirm2, 
  oem_pfe_sequencial_confirm2)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_pfe_program_fk FOREIGN KEY (oem_pfe_emp_num_matr_program, 
  oem_pfe_sequencial_program)
REFERENCES ifrsrh2.programacoes_ferias (pfe_emp_numero_matricula,pfe_sequencial)
DISABLE NOVALIDATE
/

ALTER TABLE ifrsrh2.ocorrencias_empregados
ADD CONSTRAINT oem_uor_fk FOREIGN KEY (oem_uor_codigo)
REFERENCES ifrdba2.unidades_organizacionais (uor_codigo)
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_1_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_1 IN ('S','N')                                           )
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_abono_pecun_2_ck CHECK ( PFE_IN_ABONO_PECUNIARIO_2 IN ('S','N')                                        )
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_1_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_1 IN ('S','N')                                        )
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_in_adiant_ferias_2_ck CHECK ( PFE_IN_ADIANTAMENTO_FERIAS_2 IN ('S','N')                                        )
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_1_ck CHECK ( PFE_INDICADOR_13_SALARIO_1 IN ('S','N')                                          )
/

ALTER TABLE ifrsrh2.programacoes_ferias
ADD CONSTRAINT pfe_indic_13_salario_2_ck CHECK ( PFE_INDICADOR_13_SALARIO_2 IN ('S','N')                                          )
/

ALTER TABLE ifrsrh2.pessoas_vinculadas
ADD CONSTRAINT pvi_mun_fk FOREIGN KEY (pvi_mun_codigo_naturalidade, 
  pvi_ufe_sigla_naturalidade)
REFERENCES ifrdba2.municipios (mun_codigo,mun_ufe_sigla)
ENABLE NOVALIDATE
/

ALTER TABLE ifrsrh2.pessoas_vinculadas
ADD CONSTRAINT pvi_pai_codigo_fk FOREIGN KEY (pvi_pai_codigo)
REFERENCES ifrdba2.paises (pai_codigo)
/
