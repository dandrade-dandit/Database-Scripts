
CREATE OR REPLACE VIEW VIW_EMPREGADOS_PORTAL
(  emp_numero_matricula
,  emp_nome
,  emp_endeco_eletronico_mail
,  emp_status
)
AS
select
              "EMP_NUMERO_MATRICULA",
              "EMP_NOME",
              "EMP_ENDERECO_ELETRONICO_MAIL",
              "EMP_STATUS"              
       from   CADASTROS

/

CREATE OR REPLACE VIEW VIW_UOR_PORTAL
(  uor_codigo
,  uor_sigla
,  uor_nome
,  uor_data_criacao
,  uor_data_extincao
,  uor_ufe_sigla
,  uor_uor_codigo
)
AS
select
              "UOR_CODIGO",
              "UOR_SIGLA",
              "UOR_NOME",
              "UOR_DATA_CRIACAO",
              "UOR_DATA_EXTINCAO",
              "UOR_UFE_SIGLA",
              "UOR_UOR_CODIGO"
       from UNIDADES_ORGANIZACIONAIS
       
/


CREATE OR REPLACE VIEW VIW_DEP_PORTAL
(  dep_codigo
,  dep_sigla
,  dep_nome
,  dep_data_criacao
,  dep_data_extincao
,  dep_ufe_sigla
,  dep_dep_codigo
)
AS
select
              "DEP_CODIGO",
              "DEP_SIGLA",
              "DEP_NOME",
              "DEP_DATA_CRIACAO",
              "DEP_DATA_EXTINCAO",
              "DEP_UFE_SIGLA",
              "DEP_DEP_CODIGO"
       from DEPENDENCIAS
       
/


create role srh_Portal_licitacoes
/

create public synonym VIW_EMPREGADOS_PORTAL for IFRSRH.VIW_EMPREGADOS_PORTAL
/

create public synonym VIW_DEP_PORTAL for IFRSRH.VIW_DEP_PORTAL
/

create public synonym VIW_UOR_PORTAL for IFRSRH.VIW_UOR_PORTAL
/

insert into tabelas values ('SRHCAD', 'VIW_EMPREGADOS_PORTAL', 'IFRSRH', 'VIEW')
/

insert into tabelas values ('SRHCAD', 'VIW_DEP_PORTAL', 'IFRSRH', 'VIEW')
/

insert into tabelas values ('SRHCAD', 'VIW_UOR_PORTAL', 'IFRSRH', 'VIEW')
/


grant select on VIW_DEP_PORTAL to RH_PERFIL_99, srh_Portal_licitacoes;

grant select on VIW_EMPREGADOS_PORTAL to RH_PERFIL_99, srh_Portal_licitacoes;

grant select on VIW_UOR_PORTAL to RH_PERFIL_99, srh_Portal_licitacoes;
