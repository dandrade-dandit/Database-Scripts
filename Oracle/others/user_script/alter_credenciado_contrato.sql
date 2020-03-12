ALTER TABLE credenciados_contratos
ADD (
    cc_irmp153 varchar2(1) NULL,
    cc_csll varchar2(1) NULL,
    cc_cofins varchar2(1) NULL,
    cc_pispasep varchar2(1) NULL
    )
/


COMMENT ON COLUMN credenciados_contratos.cc_irmp153 IS 'informa se o credenciado retém ou não o imposto de renda de acordo com a MP 153/2003'
/

COMMENT ON COLUMN credenciados_contratos.cc_csll IS 'informa se o credenciado retém ou não a Contribuição Social sobre Lucro Líquido de acordo com a MP 153/2003'
/

COMMENT ON COLUMN credenciados_contratos.cc_cofins IS 'informa se o credenciado retém ou não a Contribuição para o financiamento da Seguridade Social de acordo com a MP 153/2003'
/

COMMENT ON COLUMN credenciados_contratos.cc_pispasep IS 'informa se o credenciado retém ou não o PIS/PASEP de acordo com a MP 153/2003'
/
       
 ALTER TABLE credenciados_contratos
  ADD CONSTRAINT crecon_ck_3 CHECK ( cc_irmp153 IN ( 'S' , 'N' ) )
/   

 ALTER TABLE credenciados_contratos
  ADD CONSTRAINT crecon_ck_4 CHECK ( cc_csll IN ( 'S' , 'N' ) )
/   

 ALTER TABLE credenciados_contratos
  ADD CONSTRAINT crecon_ck_5 CHECK ( cc_cofins IN ( 'S' , 'N' ) )
/   

 ALTER TABLE credenciados_contratos
  ADD CONSTRAINT crecon_ck_6 CHECK ( cc_pispasep IN ( 'S' , 'N' ) )
/   

