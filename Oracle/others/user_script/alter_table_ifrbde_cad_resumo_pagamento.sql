alter table ifrbde.cad_resumo_pagamento
add(
dsc_retencao_rp varchar2(250))
/
COMMENT ON COLUMN ifrbde.cad_resumo_pagamento.dsc_retencao_rp IS 'Informa��es sobre a reten��o'
/
