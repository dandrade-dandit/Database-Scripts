ALTER TABLE IFRBDE.TAB_REC_APROVADO
    ADD (VAL_CRONOGRAMADO               NUMBER(18,2) )
/
COMMENT ON COLUMN IFRBDE.TAB_REC_APROVADO.VAL_CRONOGRAMADO IS 'Valor Total do que esta cronogramado nos contratos para carencia,ano,recurso'
/
