-- Start of DDL Script for Trigger IFRSRH.SRH_ANS_EMP_EMB
-- Generated 4-fev-2003 14:59:32 from SYSMAN@MAQUINA5

CREATE OR REPLACE TRIGGER srh_ans_emp_emb
AFTER UPDATE OF 
  emp_data_nascimento,
  emp_endereco_bairro,
  emp_endereco_logradouro,
  emp_endereco_numero_cep,
  emp_indicador_sexo,
  emp_mun_codigo_reside,
  emp_nome,
  emp_nome_mae,
  emp_numero_cpf,
  emp_numero_pis_pasep,
  emp_ufe_sigla_residente
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin

update  empregados_beneficios
set     emb_oper_ans = 2
where   emb_emp_numero_matricula = :new.emp_numero_matricula
and  emb_ben_sigla = 'MED'
and     emb_data_exclusao is null;

if  sql%notfound
then null;
end if;

End;
/

-- End of DDL Script for Trigger IFRSRH.SRH_ANS_EMP_EMB

-- Start of DDL Script for Trigger IFRSRH.SRH_ANS_PVB_ALT
-- Generated 4-fev-2003 15:01:07 from SYSMAN@MAQUINA5

CREATE OR REPLACE TRIGGER srh_ans_pvb_alt
AFTER UPDATE OF 
  emp_endereco_bairro,
  emp_endereco_logradouro,
  emp_endereco_numero_cep,
  emp_mun_codigo_reside,
  emp_ufe_sigla_residente
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin

update pessoas_vinculadas_benef
set    pvb_oper_ans = 2
where  pvb_pvi_emp_numero_matricula = :new.emp_numero_matricula
       and emb_ben_sigla = 'MED'
       and data_exclusao is null;
if sql%notfound
then null;
end if;

End;
/

-- End of DDL Script for Trigger IFRSRH.SRH_ANS_PVB_ALT

-- Start of DDL Script for Trigger IFRSRH.SRH_ATUALIZA_EMP_CATEGORIAS
-- Generated 4-fev-2003 15:01:25 from SYSMAN@MAQUINA5

CREATE OR REPLACE TRIGGER srh_atualiza_emp_categorias
AFTER UPDATE 
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
Begin
update  empregados_categorias
set     emc_quantidade = 0
where   emc_emb_emp_numero_matricula = :old.emp_numero_matricula
and 	emc_cat_dep_codigo = :old.emp_dep_codigo_lotacao;
End;
/

-- End of DDL Script for Trigger IFRSRH.SRH_ATUALIZA_EMP_CATEGORIAS

-- Start of DDL Script for Trigger IFRSRH.ATUALIZA_DEP_RESP_INCL
-- Generated 4-fev-2003 15:01:41 from SYSMAN@MAQUINA5

CREATE OR REPLACE TRIGGER atualiza_dep_resp_incl
AFTER UPDATE OF 
  emp_dep_codigo_lotacao,
ON cadastros
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN ( (NEW.EMP_DEP_CODIGO_LOTACAO <> OLD.EMP_DEP_CODIGO_LOTACAO) )
Begin
-- atualiza a tabela empregados_beneficios
update  empregados_beneficios
set     emb_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where   emb_emp_numero_matricula = :OLD.emp_numero_matricula;
-- atualiza a tabela vinculado_universitarios
update  vinculado_universitarios
set     viu_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where   viu_pvi_emp_numero_matricula = :OLD.emp_numero_matricula;
-- atualiza a tabela empregados_categorias
update 	empregados_categorias
set 	emc_dep_resp_incl = :NEW.emp_dep_codigo_lotacao
where 	emc_emb_emp_numero_matricula =  :OLD.emp_numero_matricula
and 	emc_cat_dep_codigo = :old.emp_dep_codigo_lotacao;
End;
/

-- End of DDL Script for Trigger IFRSRH.ATUALIZA_DEP_RESP_INCL

