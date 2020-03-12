--*******************************************************
--VIEWS
--*******************************************************
--------------------------------------------------------
--  DDL for View VIW_CADASTROS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_CADASTROS" ("EMP_NUMERO_MATRICULA", "EMP_NOME", "EMP_NOME_ABREVIADO", "EMP_QLP_CARGO", "EMP_QLP_SIGLA", "EMP_DEP_FISICO_TIPO", "EMP_DEP_FISICO_TIPO_NOME", "EMP_UOR_SIGLA", "EMP_UOR_NOME", "UOR_SIGLA_FISICO", "UOR_NOME_FISICO", "UOR_CODIGO_FISICO", "EMP_QFU_FUNCAO", "EMP_DEP_LOTACAO", "EMP_DEP_CODIGO_LOTACAO", "EMP_DEP_LOTACAO_SIGLA", "EMP_DEP_FISICO", "EMP_DEP_CODIGO_FISICO", "EMP_DEP_FISICO_SIGLA", "EMP_UOR_LOTACAO", "EMP_UOR_CODIGO_LOTACAO", "EMP_STATUS", "EMP_NOME_GUERRA", "EMP_ENDERECO_ELETRONICO_MAIL", "EMP_EFC_UFF_VOIP_DDD_DIRETO", "EMP_EFC_UFF_FONE_DIRETO", "EMP_EFC_UFF_VOIP", "EMP_UOR_CODIGO_FISICO_AGENDA", "EMP_UOR_SIGLA_FISICO_AGENDA", "EMP_UOR_FISICO_AGENDA", "EMP_NUMERO_CPF") AS 
  SELECT
        CAD.EMP_NUMERO_MATRICULA
,       CAD.EMP_NOME
,       CAD.EMP_NOME_ABREVIADO
,       CAR.CAR_NOME AS EMP_QLP_CARGO
,       CAR.CAR_SIGLA AS EMP_QLP_SIGLA
,       DEP2.DEP_TIPO AS EMP_DEP_FISICO_TIPO
,       DECODE(DEP2.DEP_TIPO, 1,'SEDE', 2,'SUPERINTENDÊNCIA', 3,'AEROPORTO', 4,'GTA',5,'COORDENAÇÃO DE NEGÓCIO', 6,'GNA',7,'UNA', 8,'CONVÊNIOS COM RESSARCIMENTO', 9,'CONVÊNIOS SEM RESSARCIMENTO',10,'DEPENDÊNCIA GNA', 11,'DEPENDÊNCIA UNA',12,'DEPENDÊNCIA DE DEPENDÊNCIA', DEP2.DEP_TIPO) AS EMP_DEP_FISICO_TIPO_NOME
,       UOR.UOR_SIGLA AS EMP_UOR_SIGLA
,       UOR.UOR_NOME AS EMP_UOR_NOME
,       UOR2.UOR_SIGLA AS UOR_SIGLA_FISICO
,       UOR2.UOR_NOME AS UOR_NOME_FISICO
,       CAD.EMP_UOR_CODIGO_FISICO AS UOR_CODIGO_FISICO
,       CARGOS_CONFIANCA.FUN_NOME AS EMP_QFU_FUNCAO
,       DEP.DEP_NOME AS EMP_DEP_LOTACAO
,       CAD.EMP_DEP_CODIGO_LOTACAO
,       DEP.DEP_SIGLA AS EMP_DEP_LOTACAO_SIGLA
,       DEP2.DEP_NOME AS EMP_DEP_FISICO
,       CAD.EMP_DEP_CODIGO_FISICO
,       DEP2.DEP_SIGLA AS EMP_DEP_FISICO_SIGLA
,       UOR.UOR_NOME AS EMP_UOR_LOTACAO
,       CAD.EMP_UOR_CODIGO_LOTACAO
,       DECODE(CAD.EMP_STATUS,0,'TEMPORARIAMENTE AFASTADO',1,'ATIVO',2,'DESLIGADO',CAD.EMP_STATUS) AS EMP_STATUS
,       CAD.EMP_NOME_GUERRA
,       CAD.EMP_ENDERECO_ELETRONICO_MAIL
,       ( SELECT F.EFC_UFF_VOIP_DDD FROM EMPREGADO_FONE_COMERCIAL F WHERE
        CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
        AND F.EFC_UFF_TIPO= 1 AND ROWNUM < 2) AS EMP_EFC_UFF_VOIP_DDD_DIRETO
,       ( SELECT F.EFC_UFF_NUMERO FROM EMPREGADO_FONE_COMERCIAL F WHERE
        CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
        AND F.EFC_UFF_TIPO= 1 AND ROWNUM < 2) AS EMP_EFC_UFF_FONE_DIRETO
,       ( SELECT F.EFC_UFF_NUMERO FROM EMPREGADO_FONE_COMERCIAL F WHERE
        CAD.EMP_NUMERO_MATRICULA = F.EFC_EMP_NUMERO_MATRICULA
        AND F.EFC_UFF_TIPO= 4 AND ROWNUM < 2) AS EMP_EFC_UFF_VOIP
,       CAD.EMP_UOR_CODIGO_FISICO_AGENDA
,       UOR3.UOR_SIGLA EMP_UOR_SIGLA_FISICO_AGENDA
,       UOR3.UOR_NOME EMP_UOR_FISICO_AGENDA
,       CAD.EMP_NUMERO_CPF
FROM    CADASTROS CAD
,       CARGOS CAR
,       DEPENDENCIAS DEP
,       DEPENDENCIAS DEP2
,       UNIDADES_ORGANIZACIONAIS UOR
,       UNIDADES_ORGANIZACIONAIS UOR2
,       UNIDADES_ORGANIZACIONAIS UOR3
,       CARGOS_CONFIANCA
WHERE   CAD.EMP_STATUS <> 2
AND     UOR.UOR_TIPO_UNIDAD_ORG <> 14
AND     CAR.CAR_CODIGO (+)= CAD.EMP_QLP_CAR_CODIGO
AND     CAR.CAR_CODIGO_NIVEL (+)= CAD.EMP_QLP_CAR_CODIGO_NIVEL
AND     CAR.CAR_OCC_CODIGO (+)= CAD.EMP_QLP_CAR_OCC_CODIGO
AND     DEP.DEP_CODIGO (+)= CAD.EMP_DEP_CODIGO_LOTACAO
AND     DEP2.DEP_CODIGO (+)= CAD.EMP_DEP_CODIGO_FISICO
AND     UOR.UOR_CODIGO(+)= CAD.EMP_UOR_CODIGO_LOTACAO
AND     UOR2.UOR_CODIGO (+)= CAD.EMP_UOR_CODIGO_FISICO
AND     UOR3.UOR_CODIGO (+)= CAD.emp_uor_codigo_fisico_agenda
AND     CARGOS_CONFIANCA.FUN_CODIGO (+)= CAD.EMP_QFU_FUN_CODIGO
/

--------------------------------------------------------
--  DDL for View VIW_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_CHAMADOS" ("SEQ_CHAMADO", "NUM_CHAMADO_PAI", "SEQ_ATRIBUICAO_CHAMADO", "NUM_MATRICULA_SOLICITANTE", "SEQ_ATIVIDADE_CHAMADO", "SEQ_LOCALIZACAO_FISICA", "SEQ_PRIORIDADE_CHAMADO", "SEQ_ITEM_CONFIGURACAO", "SEQ_AVALIACAO_ATENDIMENTO", "SEQ_EQUIPE_TI", "SEQ_SITUACAO_CHAMADO", "NUM_MATRICULA", "SEQ_EQUIPE_ATRIBUICAO", "ANO_ABERTURA_CHAM", "MES_ABERTURA_CHAM", "DIA_ABERTURA_CHAM", "HR_ABERTURA_CHAM", "MIM_ABERTURA_CHAM", "DTH_ABERTURA", "DTH_ATRIBUICAO", "DTH_INICIO_EFETIVO", "DTH_ENCERRAMENTO_EFETIVO", "IND2", "IND3", "IND4", "IND5") AS 
  select
        a.seq_chamado
     ,  nvl(a.num_chamado_pai, 0) as num_chamado_pai
     ,  ac.seq_atribuicao_chamado
     ,  a.num_matricula_solicitante
     ,  a.seq_atividade_chamado
     --,  a.seq_situacao_chamado
     ,  nvl(a.seq_localizacao_fisica,0) as seq_localizacao_fisica
     ,  a.seq_prioridade_chamado
     ,  nvl(a.seq_item_configuracao, 0) as seq_item_configuracao
     ,  nvl(a.seq_avaliacao_atendimento,0) as seq_avaliacao_atendimento
     ,  ac.seq_equipe_ti
     ,  ac.seq_situacao_chamado
     ,  nvl(ac.num_matricula,0) as num_matricula
     ,  nvl(ac.seq_equipe_atribuicao,0) as seq_equipe_atribuicao
     ,  to_char(a.dth_abertura, 'YYYY') as ano_abertura_cham
     ,  to_char(a.dth_abertura, 'MM') as mes_abertura_cham
     ,  to_char(a.dth_abertura, 'DD') as dia_abertura_cham
     ,  to_char(a.dth_abertura, 'HH') as hr_abertura_cham
     ,  to_char(a.dth_abertura, 'MI') as mim_abertura_cham
     ,  a.dth_abertura
     --,  a.dth_triagem_efetiva
     --,  a.dth_inicio_previsao
     --,  a.dth_inicio_efetivo dth_inicio_efetivo_cham
     --,  a.dth_encerramento_efetivo dth_encerramento_efetivo_cham
     --,  (trunc((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24) - trunc((a.dth_encerramento_efetivo - a.dth_inicio_efetivo)*24))*60))) as ind1
     ,  ac.dth_atribuicao 
     ,  ac.dth_inicio_efetivo
     ,  ac.dth_encerramento_efetivo
     ,  NVL(to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))), 0) as ind2
     ,  NVL(TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))), 0) as ind3
     ,  CASE 
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) < 30 THEN 1
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 31 AND 60 THEN 2
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 61 AND 90 THEN 3
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 91 AND 120 THEN 4
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 121 AND 180 THEN 5
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 181 AND 240 THEN 6
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 241 AND 300 THEN 7
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) BETWEEN 301 AND 360 THEN 8
           WHEN to_number(trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24)*60) + (trunc(to_char((((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24) - trunc((ac.dth_inicio_efetivo - ac.dth_atribuicao)*24))*60))) > 361  THEN 9
           ELSE 0                                                                             
        END AS IND4
     ,  CASE 
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) < 30 THEN 1
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 31 AND 60 THEN 2
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 61 AND 90 THEN 3
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 91 AND 120 THEN 4
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 121 AND 180 THEN 5
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 181 AND 240 THEN 6
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 241 AND 300 THEN 7
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) BETWEEN 301 AND 360 THEN 8
           WHEN TO_NUMBER(trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24)*60) + (trunc(to_char((((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24) - trunc((ac.dth_encerramento_efetivo - ac.dth_inicio_efetivo)*24))*60))) > 361  THEN 9
           ELSE 0                                                                             
        END AS IND5
  from  chamado a
     ,  atribuicao_chamado ac
 where  a.seq_chamado = ac.seq_chamado 
/

--------------------------------------------------------
--  DDL for View VIW_FORNECEDOR
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_FORNECEDOR" ("NUM_CPF_CGC", "NOM_FORNECEDOR", "NO_RAZAO_SOCIAL", "NO_CONTATO", "NUM_TELEFONE_CONTATO") AS 
  SELECT NR_CGC_CPF NUM_CPF_CGC,NO_FORNECEDOR AS NOM_FORNECEDOR,
          NO_RAZAO_SOCIAL AS ,NO_CONTATO AS,
          '('||NR_DDD1||') '||NR_TELEFONE1 AS NUM_TELEFONE_CONTATO
     FROM IFRLIC.FORNECEDOR
/

 

   COMMENT ON TABLE "IFRCACCOM"."VIW_FORNECEDOR"  IS 'Tabela que mantém informações sobre fornecedores de TI da INFRAERO.';
--------------------------------------------------------
--  DDL for View VIW_INDICADORES_CMMI
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_INDICADORES_CMMI" ("NOM_PROJETO", "SEQ_CHAMADO", "SEQ_EQUIPE_TI", "SEQ_PRIORIDADE_CHAMADO", "SEQ_SITUACAO_CHAMADO", "DTH_ABERTURA") AS 
  SELECT  UPPER(c.nom_projeto) as nom_projeto
,       c.seq_chamado
,       a.seq_equipe_ti
,       c.seq_prioridade_chamado
,       c.seq_situacao_chamado
,       c.dth_abertura
FROM    chamado c,
        atribuicao_chamado a
WHERE   c.seq_chamado = a.seq_chamado 
/

--------------------------------------------------------
--  DDL for View VIW_REPORT_SBCF
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_REPORT_SBCF" ("SEQ_CHAMADO", "NUM_MATRICULA_SOLICITANTE", "SEQ_ATIVIDADE_CHAMADO", "SEQ_SITUACAO_CHAMADO", "SEQ_LOCALIZACAO_FISICA", "SEQ_PRIORIDADE_CHAMADO", "TXT_CHAMADO", "DTH_ABERTURA", "DTH_TRIAGEM_EFETIVA", "DTH_INICIO_PREVISAO", "DTH_INICIO_EFETIVO_CHA", "DTH_ENCERRAMENTO_EFETIVO_CHA", "DTH_AGENDAMENTO", "NUM_MATRICULA_CONTATO", "SEQ_ITEM_CONFIGURACAO", "NUM_PRIORIDADE_FILA", "FLG_SOLICITACAO_ATENDIDA", "NUM_MATRICULA_AVALIADOR", "TXT_AVALIACAO", "SEQ_AVALIACAO_ATENDIMENTO", "NUM_CHAMADO_PAI", "NOM_PROJETO", "NUM_TAMANHO_METRICA", "FLG_INCIDENTE", "FLG_REQ_SERVICO", "SEQ_ATRIBUICAO_CHAMADO", "SEQ_EQUIPE_TI", "NUM_MATRICULA", "TXT_ATIVIDADE", "DTH_ATRIBUICAO", "DTH_INICIO_EFETIVO_ATRIB_CHA", "DTH_ENCERRAMENTO_EFETIVO", "SEQ_EQUIPE_ATRIBUICAO", "TXT_ENCERRAMENTO", "NUM_HORAS_TRABALHADAS", "SEQ_EDIFICACAO_INFRAERO", "NOM_LOCALIZACAO_FISICA", "NOME_ABREVIADO", "LOTACAO") AS 
  select c.SEQ_CHAMADO,
       c.NUM_MATRICULA_SOLICITANTE,
       c.SEQ_ATIVIDADE_CHAMADO,
       c.SEQ_SITUACAO_CHAMADO,
       c.SEQ_LOCALIZACAO_FISICA,
       c.SEQ_PRIORIDADE_CHAMADO,
       c.TXT_CHAMADO,
       c.DTH_ABERTURA,
       c.DTH_TRIAGEM_EFETIVA,
       c.DTH_INICIO_PREVISAO,
       c.DTH_INICIO_EFETIVO as DTH_INICIO_EFETIVO_CHA,
       c.DTH_ENCERRAMENTO_EFETIVO AS DTH_ENCERRAMENTO_EFETIVO_CHA,
       c.DTH_AGENDAMENTO,
       c.NUM_MATRICULA_CONTATO,
       c.SEQ_ITEM_CONFIGURACAO,
       c.NUM_PRIORIDADE_FILA,
       c.FLG_SOLICITACAO_ATENDIDA,
       c.NUM_MATRICULA_AVALIADOR,
       c.TXT_AVALIACAO,
       c.SEQ_AVALIACAO_ATENDIMENTO,
       c.NUM_CHAMADO_PAI,
       c.NOM_PROJETO,
       c.NUM_TAMANHO_METRICA,
       c.FLG_INCIDENTE,
       c.FLG_REQ_SERVICO,
       ac.SEQ_ATRIBUICAO_CHAMADO,
       ac.SEQ_EQUIPE_TI,
       ac.NUM_MATRICULA,
       ac.TXT_ATIVIDADE,
       ac.DTH_ATRIBUICAO,
       ac.DTH_INICIO_EFETIVO AS DTH_INICIO_EFETIVO_ATRIB_CHA,
       ac.DTH_ENCERRAMENTO_EFETIVO,
       ac.SEQ_EQUIPE_ATRIBUICAO,
       ac.TXT_ENCERRAMENTO,
       ac.NUM_HORAS_TRABALHADAS,
       lf.SEQ_EDIFICACAO_INFRAERO,
       lf.NOM_LOCALIZACAO_FISICA,
       tae.nome_abreviado,
       tae.lotacao
from   chamado c
   ,   atribuicao_chamado ac
   ,   localizacao_fisica lf
   ,   tab_age_empregados tae
where  c.seq_chamado = ac.seq_chamado 
  and  c.seq_localizacao_fisica = lf.seq_localizacao_fisica(+)
  and  c.num_matricula_solicitante = tae.matricula(+)
  and  seq_equipe_ti = 525
/

--------------------------------------------------------
--  DDL for View VIW_TINE_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TINE_CHAMADOS" ("Numero Chamado", "Tipo Chamado", "Subtipo Chamado", "Atividade", "Sistema", "Prioridade", "Situacao Chamado", "Solicitacao", "Matricula Solicitante", "Nome Solicitante", "Data de Abertura", "Inicio Efetivo", "Data Encerramento", "Avaliação do chamado", "Comentários na avaliação", "Equipe atendimento", "DEPENDENCIA", "LOTACAO", "NOM_EDIFICACAO_INFRAERO", "NOM_LOCALIZACAO_FISICA", "Sigla Dependencia") AS 
  select  c.seq_chamado "Numero Chamado",
        t.dsc_tipo_chamado "Tipo Chamado",
        s.dsc_subtipo_chamado "Subtipo Chamado",
        a.dsc_atividade_chamado "Atividade",
        i.nom_item_configuracao "Sistema",
        p.dsc_prioridade_chamado "Prioridade",
        sc.dsc_situacao_chamado "Situacao Chamado",
        c.txt_chamado "Solicitacao",
        c.num_matricula_solicitante "Matricula Solicitante",
        v.nome "Nome Solicitante",
        c.dth_abertura "Data de Abertura",
        c.dth_inicio_efetivo "Inicio Efetivo",
        c.dth_encerramento_efetivo "Data Encerramento",
        av.seq_avaliacao_atendimento "Avaliação do chamado",
        c.txt_avaliacao "Comentários na avaliação",
        x.nom_equipe_ti "Equipe atendimento", 
        v.dependencia,
        v.lotacao,
        ei.nom_edificacao_infraero, lf.nom_localizacao_fisica,
        d.dep_sigla "Sigla Dependencia"
from    chamado c
        inner join atividade_chamado a on c.seq_atividade_chamado = a.seq_atividade_chamado
        inner join subtipo_chamado s on s.seq_subtipo_chamado = a.seq_subtipo_chamado
        inner join tipo_chamado t on t.seq_tipo_chamado = s.seq_tipo_chamado
        inner join prioridade_chamado p on c.seq_prioridade_chamado = p.seq_prioridade_chamado
        inner join situacao_chamado sc on c.seq_situacao_chamado = sc.seq_situacao_chamado
        inner join (select distinct at.seq_chamado,
                at.seq_equipe_ti,
                et.nom_equipe_ti
         from   atribuicao_chamado at
        inner join equipe_ti et on et.seq_equipe_ti = at.seq_equipe_ti
         ) x on c.seq_chamado = x.seq_chamado
        left join viw_age_empregados v on c.num_matricula_solicitante = substr(v.mat_geral,2,9)
        left join localizacao_fisica lf on c.seq_localizacao_fisica = lf.seq_localizacao_fisica
        left join edificacao_infraero ei on ei.seq_edificacao_infraero = lf.seq_edificacao_infraero
        left join dependencias d on d.dep_codigo = ei.cod_dependencia
        left join item_configuracao i on i.seq_item_configuracao = c.seq_item_configuracao
        left join avaliacao_atendimento av on c.seq_avaliacao_atendimento = av.seq_avaliacao_atendimento
where  x.seq_equipe_ti in ( 
722,-- SRNE - Sistemas   
724,-- SRNE - Laboratório
730,-- SBJP - Equipe JPTI
734,-- SBTE - Equipe TETI
758,-- SRNE - Gerência   
701,-- SRNE - Suporte    
727,-- SBFZ - Equipe FZTI
729,-- SBNT - Equipe NTTI
733,-- SBKG - Equipe SBKG
761,-- SBRF - Suporte    
762,-- SBRF - Telemática 
721,-- SRNE - Redes      
725,-- SRNE - Logística  
731,-- SBPL - Equipe SBPL
723,-- SRNE - Telemática 
732,-- SBJU - Equipe SBJU
747--SBRF - Equipe RFTI
                            )
order by 1 
/

--------------------------------------------------------
--  DDL for View VIW_TINE_HISTORICO_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TINE_HISTORICO_CHAMADOS" ("Numero Chamado", "Data Acao", "Situacao", "Matricula Resp", "Nome Resp", "Observacao") AS 
  select  h.seq_chamado "Numero Chamado",
        h.dth_historico "Data Acao",
        s.dsc_situacao_chamado "Situacao",
        h.num_matricula "Matricula Resp",
        v.nome "Nome Resp",
        h.txt_historico "Observacao"
from    historico_chamado h
        inner join situacao_chamado s on
        (h.seq_situacao_chamado = s.seq_situacao_chamado)
        inner join recurso_ti r on
        (r.num_matricula_recurso = h.num_matricula)
        left join viw_age_empregados v on
        (h.num_matricula = substr(v.mat_geral,2,9))
where   r.seq_equipe_ti in (
722,-- SRNE - Sistemas   
724,-- SRNE - Laboratório
730,-- SBJP - Equipe JPTI
734,-- SBTE - Equipe TETI
758,-- SRNE - Gerência   
701,-- SRNE - Suporte    
727,-- SBFZ - Equipe FZTI
729,-- SBNT - Equipe NTTI
733,-- SBKG - Equipe SBKG
761,-- SBRF - Suporte    
762,-- SBRF - Telemática 
721,-- SRNE - Redes      
725,-- SRNE - Logística  
731,-- SBPL - Equipe SBPL
723,-- SRNE - Telemática 
732, -- SBJU - Equipe SBJU
747--SBRF - Equipe RFTI
)
order by 1 
/

--------------------------------------------------------
--  DDL for View VIW_TINE_TAREFAS_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TINE_TAREFAS_CHAMADOS" ("Numero Chamado", "Data Atribuicao", "Data Inicio", "Data Encerramento", "Equipe Resp", "Matricula Demandado", "Profissional Demandado", "Situacao", "Atividade Demandada", "Observacao Atendimento") AS 
  select  a.seq_chamado "Numero Chamado",
        a.dth_atribuicao "Data Atribuicao",
        a.dth_inicio_efetivo "Data Inicio",
        a.dth_encerramento_efetivo "Data Encerramento",
        e.nom_equipe_ti "Equipe Resp",
        a.num_matricula "Matricula Demandado",
        v.nome "Profissional Demandado",
        s.dsc_situacao_chamado "Situacao",
        a.txt_atividade "Atividade Demandada",
        a.txt_encerramento "Observacao Atendimento"
from    atribuicao_chamado a
        inner join Equipe_Ti e on (e.seq_equipe_ti = a.seq_equipe_ti)
        inner join situacao_chamado s on (a.seq_situacao_chamado = s.seq_situacao_chamado)
        left join viw_age_empregados v on (a.num_matricula = substr(v.mat_geral,2,9))
where   a.seq_equipe_ti in (
722,-- SRNE - Sistemas   
724,-- SRNE - Laboratório
730,-- SBJP - Equipe JPTI
734,-- SBTE - Equipe TETI
758,-- SRNE - Gerência   
701,-- SRNE - Suporte    
727,-- SBFZ - Equipe FZTI
729,-- SBNT - Equipe NTTI
733,-- SBKG - Equipe SBKG
761,-- SBRF - Suporte    
762,-- SBRF - Telemática 
721,-- SRNE - Redes      
725,-- SRNE - Logística  
731,-- SBPL - Equipe SBPL
723,-- SRNE - Telemática 
732,-- SBJU - Equipe SBJU
747--SBRF - Equipe RFTI
                            )
Order By 1,2 
/

--------------------------------------------------------
--  DDL for View VIW_TIPS_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS_CHAMADOS" ("Numero Chamado", "Tipo Chamado", "Subtipo Chamado", "Atividade", "Sistema", "Prioridade", "Situacao Chamado", "Solicitacao", "Matricula Solicitante", "Nome Solicitante", "Data de Abertura", "Inicio Efetivo", "Data Encerramento") AS 
  select  distinct c.seq_chamado "Numero Chamado",
        t.dsc_tipo_chamado "Tipo Chamado",
        s.dsc_subtipo_chamado "Subtipo Chamado",
        a.dsc_atividade_chamado "Atividade",
        i.nom_item_configuracao "Sistema",
        p.dsc_prioridade_chamado "Prioridade",
        sc.dsc_situacao_chamado "Situacao Chamado",
        c.txt_chamado "Solicitacao",
        c.num_matricula_solicitante "Matricula Solicitante",
        v.nome "Nome Solicitante",
        c.dth_abertura "Data de Abertura",
        c.dth_inicio_efetivo "Inicio Efetivo",
        c.dth_encerramento_efetivo "Data Encerramento"
from    chamado c,
        atividade_chamado a,
        tipo_chamado t,
        subtipo_chamado s,
        item_configuracao i,
        prioridade_chamado p,
        situacao_chamado sc,
        viw_age_empregados v,
        (select distinct seq_chamado,
                seq_equipe_ti, dth_atribuicao
         from   atribuicao_chamado        
         ) x
where   c.seq_atividade_chamado = a.seq_atividade_chamado
and     c.seq_chamado = x.seq_chamado
and     c.num_matricula_solicitante = substr(v.mat_geral,2,9)
and     c.seq_situacao_chamado = sc.seq_situacao_chamado
and     c.seq_prioridade_chamado = p.seq_prioridade_chamado
and     i.seq_item_configuracao(+) = c.seq_item_configuracao
and     t.seq_tipo_chamado = s.seq_tipo_chamado
and     s.seq_subtipo_chamado = a.seq_subtipo_chamado
and     x.seq_equipe_ti in (284,  --    TIPS-2 - Administração de Banco de Dados
                            883,  --    TIPS-2 - Arquitetura Infraestrutura
                            241,  --    TIPS-2 - Operação e Monitoramento
                            1120, --    TIPS-2 - Suporte a Atendimento
                            222,   --    TIPS-2 - Suporte a Infraestrutura
                            1241 --   TIPS-2 - Suporte à Logística
                            )
and(
    c.dth_abertura >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
    or c.dth_encerramento_efetivo  >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
    --Este campo ficou de fora pq se não é garantido que é de uma das equipes acima.
    --c.dth_inicio_efetivo
    or x.dth_atribuicao >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
)
order by 1
/

--------------------------------------------------------
--  DDL for View VIW_TIPS_HISTORICO_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS_HISTORICO_CHAMADOS" ("Numero Chamado", "Data Acao", "Situacao", "Matricula Resp", "NOME", "Observacao") AS 
  select h.seq_chamado "Numero Chamado",
        h.dth_historico "Data Acao",
        s.dsc_situacao_chamado "Situacao",
        h.num_matricula "Matricula Resp",nome,
        h.txt_historico "Observacao"
from    historico_chamado h,
        situacao_chamado s,
        recurso_ti r,
        viw_age_empregados v
where   h.seq_situacao_chamado = s.seq_situacao_chamado
and     r.num_matricula_recurso = h.num_matricula
and     h.num_matricula = substr(v.mat_geral,2,9)
and     r.seq_equipe_ti in (284,  --    TIPS-2 - Administração de Banco de Dados
                            883,  --    TIPS-2 - Arquitetura Infraestrutura
                            241,  --    TIPS-2 - Operação e Monitoramento
                            1120, --    TIPS-2 - Suporte a Atendimento
                            222,   --    TIPS-2 - Suporte a Infraestrutura
                            1241 --   TIPS-2 - Suporte à Logística
                            )
and     h.dth_historico >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
order by 1
/

--------------------------------------------------------
--  DDL for View VIW_TIPS_TAREFAS_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS_TAREFAS_CHAMADOS" ("Numero Chamado", "Matricula Solicitante", "Nome Solicitante", "Lotacao Solicitante", "Data Atribuicao", "Data Inicio", "Data Encerramento", "Equipe Resp", "Matricula Demandado", "Profissional Demandado", "Situacao", "Atividade Demandada", "Observacao Atendimento") AS 
  select  a.seq_chamado "Numero Chamado",
        c.num_matricula_solicitante "Matricula Solicitante",
        V2.Nome "Nome Solicitante",
        V2.lotacao "Lotacao Solicitante",
        a.dth_atribuicao "Data Atribuicao",
        a.dth_inicio_efetivo "Data Inicio",
        a.dth_encerramento_efetivo "Data Encerramento",
        E.Nom_Equipe_Ti "Equipe Resp",
        a.num_matricula "Matricula Demandado",
        v.nome "Profissional Demandado",
        s.dsc_situacao_chamado "Situacao",
        a.txt_atividade "Atividade Demandada",
        a.txt_encerramento "Observacao Atendimento"
from    atribuicao_chamado a,
        equipe_ti e,
        viw_age_empregados v,
        Situacao_Chamado S,
        Chamado C,
        Viw_Age_Empregados V2
where   e.seq_equipe_ti = a.seq_equipe_ti
and     a.seq_situacao_chamado = s.seq_situacao_chamado
and     a.num_matricula = substr(v.mat_geral,2,9)
and     a.seq_chamado = c.seq_chamado
And     C.Num_Matricula_Solicitante = Substr(V2.Mat_Geral,2,9)
and     a.seq_equipe_ti in (284,  --    TIPS-2 - Administração de Banco de Dados
                            883,  --    TIPS-2 - Arquitetura Infraestrutura
                            241,  --    TIPS-2 - Operação e Monitoramento
                            1120, --    TIPS-2 - Suporte a Atendimento
                            222,   --    TIPS-2 - Suporte a Infraestrutura
                            1241 --   TIPS-2 - Suporte à Logística
                            )
and     (a.dth_atribuicao >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
or c.dth_encerramento_efetivo  >= to_date('03/12/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss'))
Order By 1,2
/

--------------------------------------------------------
--  DDL for View VIW_TIPS3_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS3_CHAMADOS" ("Numero Chamado", "Tipo Chamado", "Subtipo Chamado", "Atividade", "Sistema", "Prioridade", "Situacao Chamado", "Solicitacao", "Matricula Solicitante", "Nome Solicitante", "Data de Abertura", "Inicio Efetivo", "Data Encerramento", "Avaliação do chamado", "Comentários na avaliação") AS 
  select  c.seq_chamado "Numero Chamado",
        t.dsc_tipo_chamado "Tipo Chamado",
        s.dsc_subtipo_chamado "Subtipo Chamado",
        a.dsc_atividade_chamado "Atividade",
        i.nom_item_configuracao "Sistema",
        p.dsc_prioridade_chamado "Prioridade",
        sc.dsc_situacao_chamado "Situacao Chamado",
        c.txt_chamado "Solicitacao",
        c.num_matricula_solicitante "Matricula Solicitante",
        v.nome "Nome Solicitante",
        c.dth_abertura "Data de Abertura",
        c.dth_inicio_efetivo "Inicio Efetivo",
        c.dth_encerramento_efetivo "Data Encerramento",
        av.seq_avaliacao_atendimento "Avaliação do chamado",
        c.txt_avaliacao "Comentários na avaliação"
from    chamado c
        inner join atividade_chamado a on c.seq_atividade_chamado = a.seq_atividade_chamado
        inner join subtipo_chamado s on s.seq_subtipo_chamado = a.seq_subtipo_chamado
        inner join tipo_chamado t on t.seq_tipo_chamado = s.seq_tipo_chamado
        inner join prioridade_chamado p on c.seq_prioridade_chamado = p.seq_prioridade_chamado
        inner join situacao_chamado sc on c.seq_situacao_chamado = sc.seq_situacao_chamado
        inner join viw_age_empregados v on c.num_matricula_solicitante = substr(v.mat_geral,2,9)
        inner join (select distinct seq_chamado,
                seq_equipe_ti
         from   atribuicao_chamado
         ) x on c.seq_chamado = x.seq_chamado
        left join item_configuracao i on i.seq_item_configuracao = c.seq_item_configuracao
        left join avaliacao_atendimento av on c.seq_avaliacao_atendimento = av.seq_avaliacao_atendimento
where  x.seq_equipe_ti in (141, --	Serviço de Atendimento ao Cliente
                            681  --	SEDE - Call Center
                            )
and     (c.dth_abertura >= to_date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss') --Qual será o período atendido?
or       c.dth_encerramento_efetivo >= to_date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss')
        )
order by 1
/

--------------------------------------------------------
--  DDL for View VIW_TIPS3_HISTORICO_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS3_HISTORICO_CHAMADOS" ("Numero Chamado", "Data Acao", "Situacao", "Matricula Resp", "Observacao") AS 
  select  h.seq_chamado "Numero Chamado",
        h.dth_historico "Data Acao",
        s.dsc_situacao_chamado "Situacao",
        h.num_matricula "Matricula Resp",
        h.txt_historico "Observacao"
from    historico_chamado h,
        situacao_chamado s,
        recurso_ti r
where   h.seq_situacao_chamado = s.seq_situacao_chamado
and     r.num_matricula_recurso = h.num_matricula
and     r.seq_equipe_ti in (141, --	Serviço de Atendimento ao Cliente
                            681  --	SEDE - Call Center
                            )
and     h.dth_historico >= to_date('24/07/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
order by 1
/

--------------------------------------------------------
--  DDL for View VIW_TIPS3_TAREFAS_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIPS3_TAREFAS_CHAMADOS" ("Numero Chamado", "Data Atribuicao", "Data Inicio", "Data Encerramento", "Equipe Resp", "Matricula Demandado", "Profissional Demandado", "Situacao", "Atividade Demandada", "Observacao Atendimento") AS 
  select  a.seq_chamado "Numero Chamado",
        a.dth_atribuicao "Data Atribuicao",
        a.dth_inicio_efetivo "Data Inicio",
        a.dth_encerramento_efetivo "Data Encerramento",
        e.nom_equipe_ti "Equipe Resp",
        a.num_matricula "Matricula Demandado",
        v.nome "Profissional Demandado",
        s.dsc_situacao_chamado "Situacao",
        a.txt_atividade "Atividade Demandada",
        a.txt_encerramento "Observacao Atendimento"
from    atribuicao_chamado a,
        Equipe_Ti E,
        viw_age_empregados v,
        situacao_chamado s
where   e.seq_equipe_ti = a.seq_equipe_ti
and     a.seq_situacao_chamado = s.seq_situacao_chamado
and     a.num_matricula = substr(v.mat_geral,2,9)
and     a.seq_equipe_ti in (141, --	Serviço de Atendimento ao Cliente
                            681  --	SEDE - Call Center
                            )
And     A.Dth_Atribuicao >= To_Date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss') 
Order By 1,2
/

--------------------------------------------------------
--  DDL for View VIW_TIRS1_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIRS1_CHAMADOS" ("Numero Chamado", "Tipo Chamado", "Subtipo Chamado", "Atividade", "Sistema", "Prioridade", "Situacao Chamado", "Solicitacao", "Matricula Solicitante", "Nome Solicitante", "Data de Abertura", "Inicio Efetivo", "Data Encerramento", "Avaliação do chamado", "Comentários na avaliação") AS 
  select  c.seq_chamado "Numero Chamado",
        t.dsc_tipo_chamado "Tipo Chamado",
        s.dsc_subtipo_chamado "Subtipo Chamado",
        a.dsc_atividade_chamado "Atividade",
        i.nom_item_configuracao "Sistema",
        p.dsc_prioridade_chamado "Prioridade",
        sc.dsc_situacao_chamado "Situacao Chamado",
        c.txt_chamado "Solicitacao",
        c.num_matricula_solicitante "Matricula Solicitante",
        v.nome "Nome Solicitante",
        c.dth_abertura "Data de Abertura",
        c.dth_inicio_efetivo "Inicio Efetivo",
        c.dth_encerramento_efetivo "Data Encerramento",
        av.seq_avaliacao_atendimento "Avaliação do chamado",
        c.txt_avaliacao "Comentários na avaliação"
from    chamado c
        inner join atividade_chamado a on c.seq_atividade_chamado = a.seq_atividade_chamado
        inner join subtipo_chamado s on s.seq_subtipo_chamado = a.seq_subtipo_chamado
        inner join tipo_chamado t on t.seq_tipo_chamado = s.seq_tipo_chamado
        inner join prioridade_chamado p on c.seq_prioridade_chamado = p.seq_prioridade_chamado
        inner join situacao_chamado sc on c.seq_situacao_chamado = sc.seq_situacao_chamado
        inner join viw_age_empregados v on c.num_matricula_solicitante = substr(v.mat_geral,2,9)
        inner join (select distinct seq_chamado,
                seq_equipe_ti
         from   atribuicao_chamado
         ) x on c.seq_chamado = x.seq_chamado
        left join item_configuracao i on i.seq_item_configuracao = c.seq_item_configuracao
        left join avaliacao_atendimento av on c.seq_avaliacao_atendimento = av.seq_avaliacao_atendimento
where  x.seq_equipe_ti in (1080  --  TIRS-1 - Equipe de atendimento de Redes / Telecom 
  )
and     (c.dth_abertura >= to_date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss') --Qual será o período atendido?
or       c.dth_encerramento_efetivo >= to_date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss')
        )
order by 1 
/

--------------------------------------------------------
--  DDL for View VIW_TIRS1_HISTORICO_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIRS1_HISTORICO_CHAMADOS" ("Numero Chamado", "Data Acao", "Situacao", "Matricula Resp", "Observacao") AS 
  select  h.seq_chamado "Numero Chamado",
        h.dth_historico "Data Acao",
        s.dsc_situacao_chamado "Situacao",
        h.num_matricula "Matricula Resp",
        h.txt_historico "Observacao"
from    historico_chamado h,
        situacao_chamado s,
        recurso_ti r
where   h.seq_situacao_chamado = s.seq_situacao_chamado
and     r.num_matricula_recurso = h.num_matricula
and     r.seq_equipe_ti in (1080   -- TIRS-1 - Equipe de atendimento de Redes / Telecom
 )
and     h.dth_historico >= to_date('24/07/2012 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
order by 1 
/

--------------------------------------------------------
--  DDL for View VIW_TIRS1_TAREFAS_CHAMADOS
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_TIRS1_TAREFAS_CHAMADOS" ("Numero Chamado", "Data Atribuicao", "Data Inicio", "Data Encerramento", "Equipe Resp", "Matricula Demandado", "Profissional Demandado", "Situacao", "Atividade Demandada", "Observacao Atendimento") AS 
  select  a.seq_chamado "Numero Chamado",
        a.dth_atribuicao "Data Atribuicao",
        a.dth_inicio_efetivo "Data Inicio",
        a.dth_encerramento_efetivo "Data Encerramento",
        e.nom_equipe_ti "Equipe Resp",
        a.num_matricula "Matricula Demandado",
        v.nome "Profissional Demandado",
        s.dsc_situacao_chamado "Situacao",
        a.txt_atividade "Atividade Demandada",
        a.txt_encerramento "Observacao Atendimento"
from    atribuicao_chamado a,
        Equipe_Ti E,
        viw_age_empregados v,
        situacao_chamado s
where   e.seq_equipe_ti = a.seq_equipe_ti
and     a.seq_situacao_chamado = s.seq_situacao_chamado
and     a.num_matricula = substr(v.mat_geral,2,9)
and     a.seq_equipe_ti in (1080  --  TIRS-1 - Equipe de atendimento de Redes / Telecom
                            )
And     A.Dth_Atribuicao >= To_Date('24/07/2012 00:00:00','dd/mm/rrrr hh24:mi:ss') 
Order By 1,2 
/

--------------------------------------------------------
--  DDL for View VIW_UOR
--------------------------------------------------------

CREATE OR REPLACE FORCE VIEW "IFRCACCOM"."VIW_UOR" ("UOR_CODIGO", "UOR_SIGLA", "UOR_NOME", "UOR_DATA_CRIACAO", "UOR_DATA_EXTINCAO", "UOR_UFE_SIGLA", "UOR_UOR_CODIGO", "UOR_DEP_CODIGO", "DEP_SIGLA", "DEP_NOME") AS 
  SELECT
              "UOR_CODIGO",
              "UOR_SIGLA",
              "UOR_NOME",
              "UOR_DATA_CRIACAO",
              "UOR_DATA_EXTINCAO",
              "UOR_UFE_SIGLA",
              "UOR_UOR_CODIGO",
              "UOR_DEP_CODIGO",
              "DEP_SIGLA",
              "DEP_NOME"              
       FROM UNIDADES_ORGANIZACIONAIS A, DEPENDENCIAS B
       WHERE A.UOR_DEP_CODIGO = B.DEP_CODIGO(+)
/
