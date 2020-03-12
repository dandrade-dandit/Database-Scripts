CREATE OR REPLACE VIEW viw_crono_realizado_sipreco (
   payable_entity_id,
   contract_id,
   contract_versao,
   tipo_cronograma,
   data_vencto,
   prim_amt,
   secdy_amt,
   sigla_recurso,
   sigla_recurso_ss,
   desc_recurso )
AS
SELECT DISTINCT TRIM (TO_CHAR (y.dpp_ncod, '00'))
            || TRIM (TO_CHAR (ifrbde.fun_converter_dep (x.dep_cod), '000')),
            a.cnt_cod, a.num_versao_contrato,
            DECODE (b.tip_resumo_crono, 'DE', 'D', 'DA', 'D', 'RJ', 'R', ' '),
            b.dat_vencimento_rc, b.val_resumo_crno, b.val_moeda_sec_rc, 
            w.rti_sigla, w.rti_sigla_ss, w.rti_desc
       FROM ifrbde.tab_contrato a,
            ifrbde.cad_resumo_cronograma b,
            ifrbde.cad_resumo_valores d,
            ifrbde.tab_carencia f,
            ifrbde.tab_dependencia x,
            ifrbde.tab_dependencia_pai y,
            ifrbde.tab_tipo_recurso_item w,
            ifrbde.tab_rec_aprovado z 
      WHERE a.cnt_cre_cod = f.cre_cod
        AND a.num_seq_contrato = d.num_seq_contrato_res
        AND d.num_seq_resumo = b.num_seq_contrato_rc
        and f.cre_cod = z.rap_cre_cod
        and z.rap_rti_cod = w.rti_cod
        AND f.cre_dep_cod = x.dep_cod
        AND x.dep_dpp_cod = y.dpp_cod
        AND b.tip_resumo_crono IN ('DE', 'DA', 'RJ')
        AND b.num_seq_resumo_pag IS NULL
        AND a.tip_situacao_contrato = 6
        AND b.dat_vencimento_rc > SYSDATE
   ORDER BY b.dat_vencimento_rc, a.cnt_cod
/
-- Grants for View
GRANT SELECT ON viw_crono_realizado_sipreco TO integrass
/

-- End of DDL Script for View INTEGRACAO.VIW_CRONO_REALIZADO_SIPRECO

