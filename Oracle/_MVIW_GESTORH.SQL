-- query 1

CREATE MATERIALIZED VIEW IFRSRH2.MVIW_REL_FPG16410_1
PCTFREE 0 PCTUSED 10 MAXTRANS 255 
TABLESPACE "TSD_MAXIMO"
BUILD IMMEDIATE 
REFRESH COMPLETE
START WITH to_date('18-Jun-2004 02:00','dd-Mon-yyyy HH:MI')
NEXT (TRUNC(sysdate) + 30)
AS
select rub.rub_codigo        rubrica,
       rub.rub_denominacao            descricao,
       mov.mov_tip_rubrica            tipo,
       mov.mov_emp_numero_matricula   matricula,
       mov.mov_versao_pagamento       versao, 
       mov.mov_ano_referencia         ano_referencia,
       mov.mov_ano_referencia         ano_rubrica
from   movimentacao mov,
       rubricas     rub
where  mov.mov_data_calculo                              is not null 
and    substr(mov_rub_codigo,1,2)                        not in ('19','59')
and    nvl(mov_ind_lancamento_liq_negat,'N')             = 'N'
and    mov.mov_valor                                     is not null 
and    mov.mov_valor                                     <> 0
and    rub.rub_codigo                                    = mov.mov_rub_codigo
group by rub.rub_codigo,
       rub.rub_denominacao,
       mov.mov_tip_rubrica,
       mov.mov_emp_numero_matricula,
       mov.mov_versao_pagamento, 
       mov.mov_ano_referencia,
       mov.mov_ano_referencia
order by 1, 5 
/

/*
Quantidade de registros hoje    : 1.974.402
Previsão de crescimento por mês : 9.000 empregados * 20 rubricas (em média) = aproximadamente 180.000 registros
Chave primária proposta         : rubrica, tipo, matricula, versao, ano
Periodicidade de atualização    : todo dia 1º de cada mês

*/



-- query 2
CREATE MATERIALIZED VIEW IFRSRH2.MVIW_REL_FPG16410_2
PCTFREE 0 PCTUSED 10 MAXTRANS 255 
TABLESPACE "TSD_MAXIMO"
BUILD IMMEDIATE 
REFRESH COMPLETE
START WITH to_date('18-Jun-2004 02:00','dd-Mon-yyyy HH:MI')
NEXT (TRUNC(sysdate) + 30)
AS
select egt.egt_emp_numero_matricula matricula,
        egt.egt_crp_mes_pagamento    mes,
        egt.egt_crp_ano_pagamento    ano,
        nvl(sum(trunc(((egt.egt_base_fgts*8)/100),2)),00) base_fgts_1,
        nvl(sum(nvl(egt.egt_base_fgts,0)),00)             base_fgts_2,
        nvl(sum(nvl(egt.egt_base_inss,0)),00)             base_inss,
        nvl(sum(nvl(egt.egt_base_irrf,0)),00)             base_irrf,
        nvl(sum(nvl(egt.egt_base_arsaprev,0)),00)         base_arsaprev
from    empregados_pagamentos egt
group by egt.egt_emp_numero_matricula,
         egt.egt_crp_mes_pagamento,
         egt.egt_crp_ano_pagamento
/

/*         
Quantidade de registros hoje    : 206.422
Previsão de crescimento por mês : 9.000 empregados = 9.000 registros
Chave primária proposta         : matricula, mes
Periodicidade de atualização    : todo dia 1º de cada mês
*/