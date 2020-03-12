--**********************************************
--SEQUENCES
--**********************************************

--------------------------------------------------------
--  DDL for Sequence CONCESSIONARIA_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."CONCESSIONARIA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ANEXO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ANEXO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_APROVACAO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_APROVACAO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_AREA_ATUACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_AREA_ATUACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_AREA_EXTERNA
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_AREA_EXTERNA"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ARQUITETURA_SOLUCAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ARQUITETURA_SOLUCAO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ATENDIMENTO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ATENDIMENTO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ATIVIDADE_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ATIVIDADE_CHAMADO"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ATRIBUICAO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ATRIBUICAO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_AVALIACAO_ATENDIMENTO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_AVALIACAO_ATENDIMENTO"  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_BANCO_DE_DADOS
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_BANCO_DE_DADOS"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_CATEGORIA_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_CATEGORIA_CHAMADO"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_CRITICIDADE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_CRITICIDADE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_EDIFICACAO_INFRAERO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_EDIFICACAO_INFRAERO"  MINVALUE 1 MAXVALUE 999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_EQUIPE_ATRIBUICAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_EQUIPE_ATRIBUICAO"  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_EQUIPE_TI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_EQUIPE_TI"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FASE_ITEM_CONFIGURACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_FASE_ITEM_CONFIGURACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FASE_PROJETO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_FASE_PROJETO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FERIADO_DEP
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_FERIADO_DEP"  MINVALUE 1 MAXVALUE 10000 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  CYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FERIADO_GTI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_FERIADO_GTI"  MINVALUE 1 MAXVALUE 10000 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  CYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FREQUENCIA_MANUTENCAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_FREQUENCIA_MANUTENCAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_HISTORICO_ACESSO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_HISTORICO_ACESSO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_HISTORICO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_HISTORICO_CHAMADO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_INFORMATIVO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_INFORMATIVO"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_INOPERANCIA_ITEM_CONFIG
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_INOPERANCIA_ITEM_CONFIG"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ITEM_CONFIGURACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ITEM_CONFIGURACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_LINGUAGEM_PROGRAMACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_LINGUAGEM_PROGRAMACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_LOCALIZACAO_FISICA
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_LOCALIZACAO_FISICA"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_MARCA_HARDWARE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_MARCA_HARDWARE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_MENU_ACESSO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_MENU_ACESSO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_MOTIVO_SUSPENCAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_MOTIVO_SUSPENCAO"  MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ORDEM_SERVICO_TI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ORDEM_SERVICO_TI"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_ORIGEM_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_ORIGEM_CHAMADO"  MINVALUE 1 MAXVALUE 20 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  CYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PERFIL_ACESSO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_PERFIL_ACESSO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PERFIL_RECURSO_TI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_PERFIL_RECURSO_TI"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PRIORIDADE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_PRIORIDADE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PRIORIDADE_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_PRIORIDADE_CHAMADO"  MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_RELAC_ITEM_CONFIGURACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_RELAC_ITEM_CONFIGURACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SEGMENTO_NEGOCIO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_SEGMENTO_NEGOCIO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SERVIDOR
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_SERVIDOR"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SISTEMA_OPERACIONAL
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_SISTEMA_OPERACIONAL"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SITUACAO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_SITUACAO_CHAMADO"  MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_STATUS_SOFTWARE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_STATUS_SOFTWARE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_STATUS_TAREFA_TI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_STATUS_TAREFA_TI"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SUBTIPO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_SUBTIPO_CHAMADO"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TAREFA_TI
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TAREFA_TI"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIME_SHEET
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIME_SHEET"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIPO_CHAMADO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIPO_CHAMADO"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIPO_DISPONIBILIDADE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIPO_DISPONIBILIDADE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIPO_ITEM_CONFIGURACAO
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIPO_ITEM_CONFIGURACAO"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIPO_RELAC_ITEM_CONFIG
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIPO_RELAC_ITEM_CONFIG"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_TIPO_SOFTWARE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_TIPO_SOFTWARE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_UNIDADE_MEDIDA_SOFTWARE
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_UNIDADE_MEDIDA_SOFTWARE"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_USUARIO_CONCESSIONARIA
--------------------------------------------------------

   CREATE SEQUENCE  "IFRCACCOM"."SEQ_USUARIO_CONCESSIONARIA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
