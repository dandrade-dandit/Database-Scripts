create index MOV_PEN_FK on IFRSRH.MOVIMENTACAO
(MOV_EMP_NUMERO_MATRICULA,MOV_PEN_CODIGO)
Tablespace TSI_PESSOAL;

create index OEM_DEP_FK on IFRSRH.OCORRENCIAS_EMPREGADOS
(OEM_DEP_CODIGO)
Tablespace TSI_PESSOAL;

create index FK_GUI_ASM on IFRSRH.GUIAS
(GUI_ASM_SENHA)
Tablespace TSI_PESSOAL;

create index GUI_PVB_FK on IFRSRH.GUIAS
(GUI_EMP_NUMERO_MATRICULA,GUI_PVI_SEQUENCIAL,GUI_DOC_CBE_BEN_SIGLA,GUI_PVB_ADESAO)
Tablespace TSI_PESSOAL;

create index GPR_ABO_FK on IFRSRH.GUIAS_PROCEDIMENTOS
(GPR_ABO_CODIGO)
Tablespace TSI_PESSOAL;

create index ATO_EMB_FK on IFRSRH.AUTORIZACOES_TRATAMENTOS_ODONT
(ATO_EMB_EMP_NUMERO_MATRICULA,ATO_EMB_BEN_SIGLA)
Tablespace TSI_PESSOAL;

create index BSG_EMP_BEN_FK on IFRSRH.BENEFICIARIOS_SEGUROS
(BSG_EMB_EMP_NUMERO_MATRICULA,BSG_EMB_BEN_SIGLA)
Tablespace TSI_PESSOAL;

create index ORT_EMB_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS
(ORT_EMB_EMP_NUMERO_MATRICULA,ORT_EMB_BEN_SIGLA)
Tablespace TSI_PESSOAL; 


create index ORT_DEP_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS
(ORT_DEP_CODIGO)
Tablespace TSI_PESSOAL;

create index ORT_UOR_FK on IFRSRH.OCORRENCIAS_RECEB_TICKETS
(ORT_UOR_CODIGO)
Tablespace TSI_PESSOAL;
