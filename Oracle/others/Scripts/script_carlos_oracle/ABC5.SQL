DELETE SYS.PLAN_TABLE WHERE STATEMENT_ID='ABC4';
COMMIT;
EXPLAIN PLAN SET STATEMENT_ID='ABC4' INTO SYS.PLAN_TABLE FOR
Select /*+ index(Mensagem_Voo_Realizado MVR_FAT_REFERENCIADA_FK_I)*/
       F1.FAT_NR_FATURA,F1.FAT_NR_FATURA_DV
From    Fatura F1
,       Item_Fatura ITF
,       Operacao
,       Mensagem_Voo_Realizado
,       Cia_Aerea
,       Posse_aeronave ta
,       Proprietario
,       Unidade_Vigencia
,       Administradora
,       Unidade_Arrecadadora
,       Fatura F2
Where   (F2.FAT_NR_FATURA(+) = MVR_FAT_NR_FATURA_REF_FK)
And     (ITF_SG_UNIDADE        = UNA_SG_UNIDADE       )
And     (ITF_CD_ADMINISTRADORA = ADM_CD_ADMINISTRADORA)
And     (MVR_UNV_CD_ADMINISTRADORA_FK= UNV_ADM_CD_ADMINISTRADORA_FK(+))
And     (MVR_UNV_CD_CLASSE_FK        = UNV_CLA_CD_CLASSE_FK        (+))
And     (MVR_UNV_CD_CATEGORIA_FK     = UNV_CAT_CD_CATEGORIA_FK     (+))
And     (MVR_UNV_SG_UNIDADE_FK       = UNV_UNA_SG_UNIDADE_FK       (+))
And     (MVR_UNV_DT_VIGENCIA_FK      = UNV_DT_VIGENCIA             (+))
And     (POA_PRO_CD_PROPRIETARIO_FK  = PRO_CD_PROPRIETARIO         (+))
And     ((F1.FAT_TP_GRUPO=1) OR  (POA_DT_VIGENCIA=(Select Max(x1.POA_DT_VIGENCIA)
                                                   From   POSSE_AERONAVE x1
                                                   Where x1.POA_DT_VIGENCIA <= F1.FAT_DT_EMISSAO
                                                   And   x1.POA_ARN_MT_AERONAVE_FK = F1.FAT_ARN_MT_AERONAVE_FK)))
And    (F1.FAT_ARN_MT_AERONAVE_FK = POA_ARN_MT_AERONAVE_FK(+))
And    (F1.FAT_CIA_CD_CIA_AEREA_FK = CIA_CD_CIA_AEREA(+))
And    (OPE_MVR_ID = MVR_ID)
And    (ITF_CD_TARIFA          = OPE_PTF_CD_TARIFA        )
And    (ITF_CD_ADMINISTRADORA  = OPE_PTF_CD_ADMINISTRADORA)
And    (ITF_SG_UNIDADE         = OPE_PTF_SG_UNIDADE       )
And    (ITF_FAT_NR_FATURA_FK   = OPE_FAT_NR_FATURA        )
And    (F1.FAT_NR_FATURA       = ITF_FAT_NR_FATURA_FK)
AND    rownum = 1
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
