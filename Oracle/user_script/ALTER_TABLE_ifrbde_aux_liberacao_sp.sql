ALTER TABLE ifrbde.aux_liberacao_sp
ADD(cnt_cre_cod_aux NUMBER(10),
cnt_cod_aux VARCHAR2(30))
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.cnt_cod_aux IS 'Numero do Contrato '
/
COMMENT ON COLUMN ifrbde.aux_liberacao_sp.cnt_cre_cod_aux IS 'Numero sequencial da Carencia'
/

