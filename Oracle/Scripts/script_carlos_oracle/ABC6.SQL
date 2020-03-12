DELETE SYS.PLAN_TABLE WHERE STATEMENT_ID='ABC4';
COMMIT;
EXPLAIN PLAN SET STATEMENT_ID='ABC4' INTO SYS.PLAN_TABLE FOR
Select F1.FAT_NR_FATURA
From    Fatura F1
,       Item_Fatura ITF
,       Operacao
,       Cia_Aerea
,       Posse_aeronave ta
,       Proprietario
,       Administradora
,       Unidade_Arrecadadora
,       Fatura F2
, (select DECODE(MVR_FAT_NR_FATURA_REF_FK,NULL,0,MVR_FAT_NR_FATURA_REF_FK) V1,
          MVR_ID
   from Mensagem_Voo_Realizado MVR,
        Unidade_Vigencia UNV
   where  (MVR.MVR_UNV_CD_ADMINISTRADORA_FK = UNV.UNV_ADM_CD_ADMINISTRADORA_FK(+))
   And    (MVR.MVR_UNV_DT_VIGENCIA_FK  = UNV.UNV_DT_VIGENCIA(+))
   And    (MVR.MVR_UNV_CD_CLASSE_FK    = UNV.UNV_CLA_CD_CLASSE_FK(+))
   And    (MVR.MVR_UNV_CD_CATEGORIA_FK = UNV.UNV_CAT_CD_CATEGORIA_FK(+))
   And    (MVR.MVR_UNV_SG_UNIDADE_FK   = UNV.UNV_UNA_SG_UNIDADE_FK(+))) a
Where  (F2.FAT_NR_FATURA(+)         = a.V1)
And    (OPE_MVR_ID                  = a.MVR_ID)
And    (POA_PRO_CD_PROPRIETARIO_FK  = PRO_CD_PROPRIETARIO         (+))
And    (F1.FAT_ARN_MT_AERONAVE_FK   = POA_ARN_MT_AERONAVE_FK      (+))
And    (F1.FAT_CIA_CD_CIA_AEREA_FK  = CIA_CD_CIA_AEREA            (+))
And    (ITF_SG_UNIDADE              = UNA_SG_UNIDADE)
And    (ITF_CD_ADMINISTRADORA       = ADM_CD_ADMINISTRADORA)
And    (ITF_FAT_NR_FATURA_FK        = OPE_FAT_NR_FATURA)
And    (ITF_CD_TARIFA               = OPE_PTF_CD_TARIFA)
And    (ITF_CD_ADMINISTRADORA       = OPE_PTF_CD_ADMINISTRADORA)
And    (ITF_SG_UNIDADE              = OPE_PTF_SG_UNIDADE)
And    (ITF_FAT_NR_FATURA_FK        = F1.FAT_NR_FATURA)
And    ((F1.FAT_TP_GRUPO=1) OR  (POA_DT_VIGENCIA=(Select Max(x1.POA_DT_VIGENCIA)
                                                  From   POSSE_AERONAVE x1
                                                  Where x1.POA_DT_VIGENCIA       <= F1.FAT_DT_EMISSAO
                                                  And   x1.POA_ARN_MT_AERONAVE_FK = F1.FAT_ARN_MT_AERONAVE_FK)))
AND    rownum=1
/
col options for a15
col operation for a50
col linhas for a15
select lpad('.',2*(level-1))||operation operation,
       options,
       object_name
--       DECODE(id,0,'Custo = '||position,cardinality) Linhas
from sys.plan_table
start with id = 0 and statement_id = 'ABC4'
connect by prior id = parent_id and statement_id = 'ABC4'
/
