alter table ifrbde.cad_resumo_pagamento
add(
dsc_retencao_rp varchar2(250))
/
COMMENT ON COLUMN ifrbde.cad_resumo_pagamento.dsc_retencao_rp IS 'Informações sobre a retenção'
/
