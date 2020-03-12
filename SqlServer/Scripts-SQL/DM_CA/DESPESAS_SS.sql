
--despesas
Select 
       convert(char(4),processing_yr) as ano,
       dependencia,
       custo,
       conta,
       2 as ID_COMPARATIVO,
       1 as ID_PERIODICIDADE,
       sum(ldr_amt_1) as vl_jan,sum(ldr_amt_2) as vl_fev,sum(ldr_amt_3) as vl_mar,sum(ldr_amt_4) as vl_abr,
       sum(ldr_amt_5) as vl_mai,sum(ldr_amt_6) as vl_jun,sum(ldr_amt_7) as vl_jul,sum(ldr_amt_8) as vl_ago,
       sum(ldr_amt_9) as vl_set,sum(ldr_amt_10) as vl_out,sum(ldr_amt_11) as vl_nov,sum(ldr_amt_12) as vl_dez
--INTO IFRCORP..DESPESAS_SS_TEMP
From DBSglep.dbo.ldr_acct_bal (nolock)
 
Where ldr_entity_id = 'INFRA'
   and amt_class_type = 'ACTUAL'
   and processing_yr in (2011,2012,2013,2014)
   and curr_type = 'E1'
   and left(conta,1) = '3' 
   and curr_code = 'R$' 
--   and custo is not null and custo <> ''
group by processing_yr,dependencia,custo,conta

/*
--RECEITAS

Select 
       convert(char(4),processing_yr) as ano,
       dependencia,
       custo,
       conta,
       2 as ID_COMPARATIVO,
       1 as ID_PERIODICIDADE,
       sum(ldr_amt_1) as vl_jan,sum(ldr_amt_2) as vl_fev,sum(ldr_amt_3) as vl_mar,sum(ldr_amt_4) as vl_abr,
       sum(ldr_amt_5) as vl_mai,sum(ldr_amt_6) as vl_jun,sum(ldr_amt_7) as vl_jul,sum(ldr_amt_8) as vl_ago,
       sum(ldr_amt_9) as vl_set,sum(ldr_amt_10) as vl_out,sum(ldr_amt_11) as vl_nov,sum(ldr_amt_12) as vl_dez
 
From DBSglep.dbo.ldr_acct_bal (nolock)
 
Where ldr_entity_id = 'INFRA'
   and amt_class_type = 'ACTUAL'
   and processing_yr in (2014)
   and curr_type = 'E1'
   and left(conta,1) = '4' 
   and curr_code = 'R$' 
--   and custo is not null and custo <> ''
group by processing_yr,dependencia,custo,conta


*/