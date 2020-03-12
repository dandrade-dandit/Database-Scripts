--teste
select count(1) from t_analise
/

select count(1) from t_entradas
/

select count(1) from t_orcamentos
/

select count(1) from t_res_condicoes
/

select count(1) from t_saidas
/

-- drops

ALTER TABLE t_entradas
DROP CONSTRAINT entrada_pk
/

ALTER TABLE t_entradas
DROP CONSTRAINT entrada_analise_fk
/

ALTER TABLE t_orcamentos
DROP CONSTRAINT orcamento_pk
/

ALTER TABLE t_orcamentos
DROP CONSTRAINT orcamento_analise_fk
/

ALTER TABLE t_res_condicoes
DROP CONSTRAINT res_cond_pk
/

ALTER TABLE t_res_condicoes
DROP CONSTRAINT res_cond_analise_fk
/

ALTER TABLE t_saidas
DROP CONSTRAINT saida_pk
/

ALTER TABLE t_saidas
DROP CONSTRAINT saida_analise_fk
/

ALTER TABLE t_analise
DROP CONSTRAINT analise_pk
/

--ALTER TABLE
ALTER TABLE t_analise
ADD dep_analise number(4) not null
/

ALTER TABLE t_entradas
ADD dep_analise number(4) not null
/

ALTER TABLE t_orcamentos
ADD dep_analise number(4) not null
/

ALTER TABLE t_res_condicoes
ADD dep_analise number(4) not null
/

ALTER TABLE t_saidas
ADD dep_analise number(4) not null
/

--PRIMARY KEY

ALTER TABLE t_analise
ADD CONSTRAINT analise_pk PRIMARY KEY (numero, dep_analise)
USING INDEX
  TABLESPACE  tsd_indice
/

ALTER TABLE t_entradas
ADD CONSTRAINT entrada_pk PRIMARY KEY (analise_numero, secao_arp_codigo, 
  secao_area_tipica, secao_cod_secao, ano, dep_analise)
USING INDEX
  TABLESPACE  tsd_indice
/

ALTER TABLE t_orcamentos
ADD CONSTRAINT orcamento_pk PRIMARY KEY (analise_numero, ano, dep_analise)
USING INDEX
  TABLESPACE  tsd_indice
/

ALTER TABLE t_res_condicoes
ADD CONSTRAINT res_cond_pk PRIMARY KEY (analise_numero, ano, area_tipica, 
  trafego, dep_analise)
USING INDEX
  TABLESPACE  tsd_indice
/

ALTER TABLE t_saidas
ADD CONSTRAINT saida_pk PRIMARY KEY (analise_numero, ano, prioridade, dep_analise)
USING INDEX
  TABLESPACE  tsd_indice
/

-- Foreign Key
ALTER TABLE t_analise
ADD CONSTRAINT analise_dependencia_fk FOREIGN KEY (dep_analise)
REFERENCES dependencias (dep_codigo) ON DELETE SET NULL
/

ALTER TABLE t_entradas
ADD CONSTRAINT entrada_analise_fk FOREIGN KEY (analise_numero, dep_analise)
REFERENCES t_analise (numero, dep_analise) ON DELETE SET NULL
/

ALTER TABLE t_orcamentos
ADD CONSTRAINT orcamento_analise_fk FOREIGN KEY (analise_numero, dep_analise)
REFERENCES t_analise (numero, dep_analise) ON DELETE SET NULL
/

ALTER TABLE t_res_condicoes
ADD CONSTRAINT res_cond_analise_fk FOREIGN KEY (analise_numero, dep_analise)
REFERENCES t_analise (numero, dep_analise) ON DELETE SET NULL
/

ALTER TABLE t_saidas
ADD CONSTRAINT saida_analise_fk FOREIGN KEY (analise_numero, dep_analise)
REFERENCES t_analise (numero, dep_analise) ON DELETE SET NULL
/


--
desc t_analise

desc t_entradas

desc t_orcamentos

desc t_res_condicoes

desc t_saidas


create public synonym T_FORNECEDORES            for ifrsgp.T_FORNECEDORES ;          
create public synonym T_MATERIAIS               for ifrsgp.T_MATERIAIS;         
create public synonym T_REGIOES                 for ifrsgp.T_REGIOES;
create public synonym T_ESTRUTURAS              for ifrsgp.T_ESTRUTURAS;
create public synonym T_TIPOS                   for ifrsgp.T_TIPOS;
create public synonym T_SERVICOS                for ifrsgp.T_SERVICOS;
create public synonym T_INDS                    for ifrsgp.T_INDS ;
create public synonym T_CONCEITOS               for ifrsgp.T_CONCEITOS;
create public synonym T_PRESSAO_PNEUS           for ifrsgp.T_PRESSAO_PNEUS;
create public synonym T_RESISTENCIAS            for ifrsgp.T_RESISTENCIAS;
create public synonym T_CLIMA_DEPENDENCIA       for ifrsgp.T_CLIMA_DEPENDENCIA;
create public synonym T_MATERIAIS_DE_AEROPORTOS for ifrsgp.T_MATERIAIS_DE_AEROPORTOS;
create public synonym T_SERVICOS_DE_AEROPORTOS  for ifrsgp.T_SERVICOS_DE_AEROPORTOS ;
create public synonym T_PISTAS                  for ifrsgp.T_PISTAS;
create public synonym T_ATRITOS                 for ifrsgp.T_ATRITOS;
create public synonym T_SECOES                  for ifrsgp.T_SECOES ;
create public synonym T_CAMADAS                 for ifrsgp.T_CAMADAS ;
create public synonym T_CONDICOES               for ifrsgp.T_CONDICOES   ;
create public synonym T_HISTORICOS              for ifrsgp.T_HISTORICOS ;
create public synonym T_CUSTOS                  for ifrsgp.T_CUSTOS;
create public synonym T_MODELOS_PCI             for ifrsgp.T_MODELOS_PCI;
create public synonym T_POLITICAS               for ifrsgp.T_POLITICAS ;
create public synonym T_PESOS                   for ifrsgp.T_PESOS;
create public synonym T_ANALISE                 for ifrsgp.T_ANALISE;
create public synonym T_ENTRADAS                for ifrsgp.T_ENTRADAS;
create public synonym T_SAIDAS                  for ifrsgp.T_SAIDAS;
create public synonym T_RES_CONDICOES           for ifrsgp.T_RES_CONDICOES;
create public synonym T_ORCAMENTOS              for ifrsgp.T_ORCAMENTOS;
create public synonym T_AVALIADORES             for ifrsgp.T_AVALIADORES;
create public synonym T_UAS                     for ifrsgp.T_UAS;
create public synonym T_INSPECOES               for ifrsgp.T_INSPECOES; 

