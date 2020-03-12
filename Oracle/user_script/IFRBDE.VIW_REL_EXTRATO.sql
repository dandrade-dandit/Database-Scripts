

CREATE OR REPLACE VIEW viw_rel_extrato (
   cn,
   cncod,
   depsigla,
   depdesc,
   depcod,
   sequencial,
   contrato,
   vcontrato,
   vtermo,
   vfaturadop0,
   vfaturadoreaj,
   vtotalfaturado,
   vsaldocontrato,
   firma,
   recurso,
   vencimento,
   tipo,
   valor,
   pagamento,
   pago,
   acumulado,
   fatura,
   vatualcontrato,
   vtotalp,
   vsaldop0,
   ano )
AS
SELECT cn.dpp_desc, cn.dpp_cod, dep.dep_sigla, dep.dep_desc, dep.dep_cod, cre.cre_cod,
       cnt.cnt_cod, cnt.cnt_valor_compromisso, cnt.cnt_valor_termo,
       cnt.cnt_valor_pago, cnt.cnt_valor_reaj_pago, cnt.cnt_valor_pago,
       cnt.cnt_valor, fir.fir_nome, rti.rti_sigla,
       TO_CHAR (crp.dat_vencimento_pag, 'DD/MM/YYYY'), ccp.cod_tipo_pag,
       (ccp.val_pagamento - ccp.val_glosa), TO_CHAR (crp.dat_pagamento, 'DD/MM/YYYY'),
       ccp.val_liquido_nota, ccp.val_faturado, ccp.num_fatura_pagamento,
       (cnt.cnt_valor_compromisso + cnt.cnt_valor_termo),
       (cnt.cnt_valor_pago + cnt.cnt_valor_reaj_pago),
       ((cnt.cnt_valor_compromisso + cnt.cnt_valor_termo) - cnt.cnt_valor_pago
       ), ccp.num_ano_pgose
  FROM ifrbde.tab_contrato cnt,
       ifrbde.tab_dependencia dep,
       ifrbde.tab_dependencia_pai cn,
       ifrbde.tab_carencia cre,
       ifrbde.tab_tipo_recurso_item rti,
       ifrbde.tab_firma fir,
       ifrbde.cad_pagamento_contrato ccp,
       ifrbde.cad_resumo_valores crv,
       ifrbde.cad_participantes_contrato cpc,
       ifrbde.cad_resumo_pagamento crp
 WHERE cre.cre_dep_cod = dep.dep_cod AND
       cpc.num_seq_contrato_part = cnt.num_seq_contrato AND
       cpc.num_fir_cod = fir.fir_cod AND
       dep.dep_dpp_cod = cn.dpp_cod AND
       ccp.cod_recurso = rti.rti_cod AND
       cnt.num_seq_contrato = crv.num_seq_contrato_res AND
       crv.num_seq_resumo = crp.num_seq_pag_contrato_rp AND
       ccp.num_seq_contrato_pag = crp.num_seq_resumo_pag AND
       cnt.cnt_cre_cod = cre.cre_cod
/

-- Grants for View
GRANT SELECT ON viw_rel_extrato TO bde_geral
/

-- End of DDL Script for View IFRBDE.VIW_REL_EXTRATO

