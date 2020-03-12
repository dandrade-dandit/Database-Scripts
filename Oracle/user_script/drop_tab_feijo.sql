CREATE TABLE HST_SELOS(
	SEQ_RSTE			number(6)	not null
,	SERIE_SELO			varchar2(2) 	not null
,	NUM_SELO			number(7)	not null
,	DAT_ENTREGA_SELO		date 		not null
,	CIA_CD_CIA_AEREA		varchar2(3) 	not null
,	DEP_CODIGO			number(4)	not null
,	COD_MOTIVO			number(3)	not null
,	DAT_LEITURA_SELO		date 		not null
,	DEP_CODIGO_LEITURA		number(4)	not null
,	DT_FECHAMENTO			date		not null
,	COD_PAGAMENTO			number(2)	not null
)
/

INSERT INTO TABELAS VALUES  ('SISELO', 'HST_SELOS', 'IFRSELO', 'TABELA')
/

CREATE PUBLIC SYNONYM HST_SELOS FOR IFRSELO.HST_SELOS
/

GRANT SELECT ON HST_SELOS TO SELO_DES
/