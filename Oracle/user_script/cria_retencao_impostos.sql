CREATE TABLE retencao_impostos
(
  cod_receita NUMBER(4) NOT NULL ,
  tax_ir      NUMBER(5,3) NOT NULL,
  tax_csll    NUMBER(5,3) NOT NULL,
  tax_cofins NUMBER(5,3) NOT NULL,
  tax_pispasep NUMBER(5,3) NOT NULL,
  dat_inicio DATE NOT NULL,
  dat_termino DATE
 )

/

COMMENT ON COLUMN retencao_impostos.cod_receita IS 'Código da receita para os valores percentuais a serem retidos de acordo com a MP 153/2003'
/

COMMENT ON COLUMN retencao_impostos.tax_ir IS 'valor percentual do imposto de renda '
/

COMMENT ON COLUMN retencao_impostos.tax_csll IS 'valor percentual da Contribuição Social sobre Lucro Líquido'
/

COMMENT ON COLUMN retencao_impostos.tax_cofins IS 'valor percentual da Contribuição para o financiamento da Seguridade Social'
/

COMMENT ON COLUMN retencao_impostos.tax_pispasep IS 'valor percentual do PIS/PASEP'
/

COMMENT ON COLUMN retencao_impostos.dat_inicio IS 'data inicial da vigência dos valores percentuais'
/

COMMENT ON COLUMN retencao_impostos.dat_termino IS 'data final da vigência dos valores percentuais'
/

GRANT DELETE,INSERT,SELECT,UPDATE ON retencao_impostos TO rh_perfil_99
/

ALTER TABLE retencao_impostos
 ADD CONSTRAINT retencao_pk PRIMARY KEY (cod_receita)

/

