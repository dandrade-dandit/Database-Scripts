
--------------------------------------------------------
--  DDL for View VIW_TEMPO_MEDIO_RECEBIMENTO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "IFRTECABC"."VIW_TEMPO_MEDIO_RECEBIMENTO" ("MODALIDADE", "CARGA", "HOUSE", "TERMO", "DATA_RECEBIMENTO", "PESO", "AER_COD", "CHEGADA_MANTRA") AS 
  (SELECT   'I' modalidade, crg_termo.crg_num carga,
             crg_termo.hcrg_num house, crg_termo.num_termo termo,
             TO_DATE (crte_dat_rec || ' ' || crte_hor_rec,
                      'DD/MM/YY HH24:mi'
                     ) data_recebimento,
             sum (decode (crte_tip, '4', crte_pes_saldo, crte_pes_rec)) peso, crg_termo.aer_cod aer_cod,
             dth_chegada_mantra chegada_mantra
        FROM crg_termo
       WHERE crg_termo.aer_cod NOT IN('002', '026','057')
         AND crte_dat_rec >= TO_DATE ('01/01/2012', 'DD/MM/YYYY')
         AND CRTE_VOL_REC > 0
         AND crte_tip <> '5'
         AND (FLG_REGISTRO_ATIVO = 'S' or FLG_REGISTRO_ATIVO IS NULL)         
    GROUP BY crg_termo.crg_num,
             crg_termo.hcrg_num,
             crg_termo.num_termo,
             crte_dat_rec,
             crg_termo.aer_cod,
             dth_chegada_mantra,
             crte_hor_rec)
   UNION ALL
   (SELECT   'E' modalidade, crg_num carga, hcrg_num house, crg_dat_rec termo,
             TO_DATE (crg_dat_rec, 'YYYYMMDD') data_recebimento,
             SUM ((crg_pes_ret + crg_pes)) peso, aer_cod, TO_DATE (NULL) chegada_mantra
        FROM crg_expo
       WHERE TO_DATE (crg_dat_rec, 'YYYYMMDD') >=
                                          TO_DATE ('01/01/2012', 'DD/MM/YYYY')
         AND aer_cod NOT IN('002', '026','057')
    GROUP BY crg_num,
             hcrg_num,
             TO_DATE (crg_dat_rec, 'YYYYMMDD'),
             crg_dat_rec,
             aer_cod)
   UNION ALL
   (SELECT   'U' modalidade, TO_CHAR (seq_carga) carga, num_hawb house,
             '' termo, crg_dat_rec data_recebimento, SUM (crg_pes_rec) peso,
             aer_cod, TO_DATE (NULL) chegada_mantra
        FROM crg_hawb_courier
       WHERE crg_dat_rec >= TO_DATE ('01/01/2012 00:00', 'dd/mm/yyyy hh24:mi')
         AND aer_cod NOT IN('002', '026','057')
    GROUP BY TO_CHAR (seq_carga), num_hawb, crg_dat_rec, aer_cod)
   UNION ALL
   (SELECT   'W' modalidade, crg_facn carga, '' house, '' termo,
             crg_dat_rec data_recebimento, SUM (crg_pes_rec) peso, aer_cod,
             TO_DATE (NULL) chegada_mantra
        FROM crg_nac
       WHERE aer_cod NOT IN('002', '026','057')
         AND crg_dat_rec >= TO_DATE ('01/01/2012', 'DD/MM/YYYY')
    GROUP BY crg_facn, crg_dat_rec, aer_cod) ;
