/* Formatted on 2005/10/10 16:50 (Formatter Plus v4.8.0) */
ALTER TABLE ifrbde.tab_carencia 
ADD num_prioridade_superint NUMBER(1) DEFAULT 0
/
COMMENT ON COLUMN ifrbe.tab_carencia.num_prioridade_superint IS 'Numero da prioridade da superintendência'
/

