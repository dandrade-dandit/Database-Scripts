--SELECT  * 
SELECT cxa.vsp_cd_nivel_versao, cxa.vsp_cd_versao, vsp_nr_ano,
       cxa.dep_cd_dependencia, cxa.nr_item, cxa.cc1_nr_conta,
       cxa.cc2_cd_centro_custo, cxa.cc2_cd_centro_custo_gerd,
       cxa.dep_cd_dependencia_gerd, cxa.prj_cd_projeto, cxa.in_centralizado,
       cxa.cd_prioridade, cxa.vl_unitario_item, cxa.nr_contrato,
       cxa.dt_inicio_contrato, cxa.dt_termino_contrato, cxa.ds_justificativa,
       cxa.ds_item, cxa.no_fornecedor, cxa.dep_cd_dependencia_gest,
       cxa.cc2_cd_centro_custo_gest, 
       cxa.qtd_jan1 AS qtd_jan, 
       cxa.val_jan1 AS val_jan, 
       cxa.qtd_fev1 AS qtd_fev, 
       cxa.val_fev1 AS val_fev, 
       cxa.qtd_mar1 AS qtd_mar, 
       cxa.val_mar1 AS val_mar, 
       cxa.qtd_abr1 AS qtd_abr, 
       cxa.val_abr1 AS val_abr, 
       cxa.qtd_mai1 AS qtd_mai, 
       cxa.val_mai1 AS val_mai, 
       cxa.qtd_jun1 AS qtd_jun, 
       cxa.val_jun1 AS val_jun, 
       cxa.qtd_jul1 AS qtd_jul, 
       cxa.val_jul1 AS val_jul, 
       cxa.qtd_ago1 AS qtd_ago, 
       cxa.val_ago1 AS val_ago, 
       cxa.qtd_set1 AS qtd_set, 
       cxa.val_set1 AS val_set, 
       cxa.qtd_out1 AS qtd_out, 
       cxa.val_out1 AS val_out, 
       cxa.qtd_nov1 AS qtd_nov, 
       cxa.val_nov1 AS val_nov, 
       cxa.qtd_dez1 AS qtd_dez, 
       cxa.val_dez1 AS val_dez, 
       
       cxa.qtd_jan2 AS qtd_jan1, 
       cxa.val_jan2 AS val_jan1, 
       cxa.qtd_fev2 AS qtd_fev1, 
       cxa.val_fev2 AS val_fev1, 
       cxa.qtd_mar2 AS qtd_mar1, 
       cxa.val_mar2 AS val_mar1, 
       cxa.qtd_abr2 AS qtd_abr1, 
       cxa.val_abr2 AS val_abr1, 
       cxa.qtd_mai2 AS qtd_mai1, 
       cxa.val_mai2 AS val_mai1, 
       cxa.qtd_jun2 AS qtd_jun1, 
       cxa.val_jun2 AS val_jun1, 
       cxa.qtd_jul2 AS qtd_jul1, 
       cxa.val_jul2 AS val_jul1, 
       cxa.qtd_ago2 AS qtd_ago1, 
       cxa.val_ago2 AS val_ago1, 
       cxa.qtd_set2 AS qtd_set1, 
       cxa.val_set2 AS val_set1, 
       cxa.qtd_out2 AS qtd_out1, 
       cxa.val_out2 AS val_out1, 
       cxa.qtd_nov2 AS qtd_nov1, 
       cxa.val_nov2 AS val_nov1, 
       cxa.qtd_dez2 AS qtd_dez1, 
       cxa.val_dez2 AS val_dez1,
       
       cxa.qtd_jan3 AS qtd_jan3, 
       cxa.val_jan3 AS val_jan3, 
       cxa.qtd_fev3 AS qtd_fev3, 
       cxa.val_fev3 AS val_fev3, 
       cxa.qtd_mar3 AS qtd_mar3, 
       cxa.val_mar3 AS val_mar3, 
       cxa.qtd_abr3 AS qtd_abr3, 
       cxa.val_abr3 AS val_abr3, 
       cxa.qtd_mai3 AS qtd_mai3, 
       cxa.val_mai3 AS val_mai3, 
       cxa.qtd_jun3 AS qtd_jun3, 
       cxa.val_jun3 AS val_jun3, 
       cxa.qtd_jul3 AS qtd_jul3, 
       cxa.val_jul3 AS val_jul3, 
       cxa.qtd_ago3 AS qtd_ago3, 
       cxa.val_ago3 AS val_ago3, 
       cxa.qtd_set3 AS qtd_set3, 
       cxa.val_set3 AS val_set3, 
       cxa.qtd_out3 AS qtd_out3, 
       cxa.val_out3 AS val_out3, 
       cxa.qtd_nov3 AS qtd_nov3, 
       cxa.val_nov3 AS val_nov3, 
       cxa.qtd_dez3 AS qtd_dez3, 
       cxa.val_dez3 AS val_dez3,
                     
       null AS qtd_jan4, 
       null AS val_jan4, 
       null AS qtd_fev4, 
       null AS val_fev4, 
       null AS qtd_mar4,
       null AS val_mar4, 
       null AS qtd_abr4, 
       null AS val_abr4, 
       null AS qtd_mai4, 
       null AS val_mai4,
       null AS qtd_jun4, 
       null AS val_jun4, 
       null AS qtd_jul4, 
       null AS val_jul4, 
       null AS qtd_ago4,
       null AS val_ago4, 
       null AS qtd_set4, 
       null AS val_set4, 
       null AS qtd_out4, 
       null AS val_out4,
       null AS qtd_nov4, 
       null AS val_nov4, 
       null AS qtd_dez4, 
       null AS val_dez4,
       
       cxa.vl_unitario_item1, cxa.vl_unitario_item2, cxa.vl_unitario_item3,
       cxa.vl_unitario_item4, cxa.in_dimensionamento, cxa.ind_contrato,
       cxa.cod_catalogo, cxa.seq_carga_ano_orcamento, cxa.flg_tipo_conta,
       cxa.flg_lancamento, cxa.val_total_gestor,
       cxa.cod_dependencia_agrupadora, cxa.cod_dependencia_elaboracao,
       cxa.flg_plurianual, cxa.po_cd_programa, cxa.flg_operacao_inclusao
       ,cxa.num_ano_item, cxa.ano_realizado, cxa.mes_realizado,
       cxa.dia_realizado, cxa.dsc_item_resumida, cxa.seq_pgose, cxa.ind_pac,
       cxa.seq_pin, cxa.dsc_responsabilidade, cxa.seq_chave_gestora,
       cxa.seq_estrutura_visao_orc_loa, cxa.emp_numero_matricula,
       cxa.seq_investimento_pac, cxa.seq_estrut_visao_orcamento,
       cxa.ind_fase_recurso, cxa.cod_projeto, cxa.dsc_projeto, 'N' as flg_aprova_item, 'N' as flg_aprova_item_2,
       0 AS flg_situacao_inv, cxa.flg_copa
  FROM  ITEM_PROPOSTA_ORC_SIMULADA cxa
 WHERE  cxa.cc1_nr_conta LIKE '%'  
   AND TO_CHAR(cxa.cc2_cd_centro_custo_gerd) LIKE '%'  
   AND cxa.vsp_nr_ano = 2010
   AND cxa.vsp_cd_nivel_versao = 3
   AND cxa.vsp_cd_versao = 10    
      AND (('T'               IN ('T') 
      AND   cxa.flg_tipo_conta             IN ('I', 'C'))
      OR  ('T'               IN ('I') 
      AND   cxa.flg_tipo_conta             IN ('I')) 
      OR  ('T'               IN ('C') 
      AND   cxa.flg_tipo_conta             IN ('C')) 
      OR  ('T'               IN ('O') 
      AND  (cxa.cc1_nr_conta             LIKE '313%' 
      OR   cxa.cc1_nr_conta             LIKE '21807001%' 
      OR   cxa.cc1_nr_conta             LIKE '216%')) 
      OR  ('T'               IN ('E') 
      AND  (cxa.cc1_nr_conta             LIKE '132%' OR  cxa.cc1_nr_conta LIKE '134%'
      OR   cxa.cc1_nr_conta             LIKE '21807002%')) )  


--****************************
SELECT  *
  FROM  ITEM_SOLICITANTE_PROPOSTA
 WHERE  VSP_NR_ANO in (2010,2011,2012,2013,2014)
   AND  SEQ_CHAVE_GESTORA IN (
    SELECT  SEQ_CHAVE_GESTORA
      FROM  ITEM_PROPOSTA_ORC_SIMULADA cxa
     WHERE  cxa.cc1_nr_conta LIKE '%'  
       AND TO_CHAR(cxa.cc2_cd_centro_custo_gerd) LIKE '%'  
       AND cxa.vsp_nr_ano = 2010
       AND cxa.vsp_cd_nivel_versao = 3
       AND cxa.vsp_cd_versao = 10    
          AND (('T'               IN ('T') 
          AND   cxa.flg_tipo_conta             IN ('I', 'C'))
          OR  ('T'               IN ('I') 
          AND   cxa.flg_tipo_conta             IN ('I')) 
          OR  ('T'               IN ('C') 
          AND   cxa.flg_tipo_conta             IN ('C')) 
          OR  ('T'               IN ('O') 
          AND  (cxa.cc1_nr_conta             LIKE '313%' 
          OR   cxa.cc1_nr_conta             LIKE '21807001%' 
          OR   cxa.cc1_nr_conta             LIKE '216%')) 
          OR  ('T'               IN ('E') 
          AND  (cxa.cc1_nr_conta             LIKE '132%' OR  cxa.cc1_nr_conta LIKE '134%'
          OR   cxa.cc1_nr_conta             LIKE '21807002%')) )   )
         
--*********************************
SELECT  *
  FROM  PROGRAMACAO_SOLIC_PROPOSTA
 WHERE  NUM_ANO in (2010,2011,2012,2013,2014)
   AND  SEQ_ITEM_SOLICITANTE_PROPOSTA IN (
        SELECT  SEQ_ITEM_SOLICITANTE_PROPOSTA
          FROM  ITEM_SOLICITANTE_PROPOSTA
         WHERE  VSP_NR_ANO = 2010
           AND  SEQ_CHAVE_GESTORA IN (
            SELECT  SEQ_CHAVE_GESTORA
              FROM  ITEM_PROPOSTA_ORC_SIMULADA cxa
             WHERE  cxa.cc1_nr_conta LIKE '%'  
               AND TO_CHAR(cxa.cc2_cd_centro_custo_gerd) LIKE '%'  
               AND cxa.vsp_nr_ano = 2010
               AND cxa.vsp_cd_nivel_versao = 3
               AND cxa.vsp_cd_versao = 10    
                  AND (('T'               IN ('T') 
                  AND   cxa.flg_tipo_conta             IN ('I', 'C'))
                  OR  ('T'               IN ('I') 
                  AND   cxa.flg_tipo_conta             IN ('I')) 
                  OR  ('T'               IN ('C') 
                  AND   cxa.flg_tipo_conta             IN ('C')) 
                  OR  ('T'               IN ('O') 
                  AND  (cxa.cc1_nr_conta             LIKE '313%' 
                  OR   cxa.cc1_nr_conta             LIKE '21807001%' 
                  OR   cxa.cc1_nr_conta             LIKE '216%')) 
                  OR  ('T'               IN ('E') 
                  AND  (cxa.cc1_nr_conta             LIKE '132%' OR  cxa.cc1_nr_conta LIKE '134%'
                  OR   cxa.cc1_nr_conta             LIKE '21807002%')) )   ) )


--*************************************************
SELECT  * 
  FROM  contratos_item
  where seq_chave_gestora in (
select  seq_chave_gestora
  FROM  ITEM_PROPOSTA_ORC_SIMULADA cxa
 WHERE  cxa.cc1_nr_conta LIKE '%'  
   AND TO_CHAR(cxa.cc2_cd_centro_custo_gerd) LIKE '%'  
   AND cxa.vsp_nr_ano = 2010
   AND cxa.vsp_cd_nivel_versao = 3
   AND cxa.vsp_cd_versao = 10    
      AND (('T'               IN ('T') 
      AND   cxa.flg_tipo_conta             IN ('I', 'C'))
      OR  ('T'               IN ('I') 
      AND   cxa.flg_tipo_conta             IN ('I')) 
      OR  ('T'               IN ('C') 
      AND   cxa.flg_tipo_conta             IN ('C')) 
      OR  ('T'               IN ('O') 
      AND  (cxa.cc1_nr_conta             LIKE '313%' 
      OR   cxa.cc1_nr_conta             LIKE '21807001%' 
      OR   cxa.cc1_nr_conta             LIKE '216%')) 
      OR  ('T'               IN ('E') 
      AND  (cxa.cc1_nr_conta             LIKE '132%' OR  cxa.cc1_nr_conta LIKE '134%'
      OR   cxa.cc1_nr_conta             LIKE '21807002%')) )  )
  

--***************************************************************************************

SELECT a.nr_item, a.flg_aprova_item, a.flg_aprova_item_2, a.flg_situacao_inv, a.flg_copa
  FROM ifrsicof.inv_item_proposta_orc_simulada a
  --update ifrsicof.inv_item_proposta_orc_simulada set flg_aprova_item = 'S', flg_aprova_item_2 = 'S', flg_situacao_Inv = 1
  where nr_item in (select a.nr_item
                      from ifrsicof.inv_contratos_item a)
/
