--******************************************
--PROCEDURES
--******************************************

--------------------------------------------------------
--  DDL for Procedure FORA_EXPEDIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."FORA_EXPEDIENTE" AS


v_nome_fiscal           varchar2(100);
v_email_fiscal          varchar2(100);
v_nome_preposto         varchar2(100);
v_email_preposto        varchar2(100);
v_seq_equipe            number;
v_mensagem              varchar2(2000);
v_assunto               varchar2(100);
v_existe                number;
v_erro                  varchar2(2000);


/*
Cursor: c_fora_expediente.
Finalidade: Buscar os registros lançados fora do expediente para análise e aprovação.
            Os registros recuperados são apenas dos contratos referentes ao Pregão
            050 de 2008.
*/
CURSOR c_fora_expediente IS
    SELECT  t.seq_time_sheet,
            t.seq_chamado,
            v.nom_colaborador,
            t.num_matricula,
            v.dsc_email,
            t.dth_inicio,
            t.dth_fim
    FROM    time_sheet t, viw_colaborador v
    WHERE   t.num_matricula IN (
                              SELECT num_matricula_recurso
                              FROM   recurso_ti
                              WHERE  num_contrato IN ('TC 073-PS/2009/0001','TC 074-PS/2009/0001')
                             )
    AND    (t.dth_inicio      >= to_date(SYSDATE-1 ||' 17:30:01', 'dd/mm/rrrr hh24:mi:ss') -- Após o fim do expediente do dia anterior.
            AND  t.dth_fim    <= to_date(SYSDATE-1 ||' 23:59:59', 'dd/mm/rrrr hh24:mi:ss') -- Após o fim do expediente do dia anterior.
            OR   t.dth_inicio >= to_date(SYSDATE   ||' 00:00:00', 'dd/mm/rrrr hh24:mi:ss') -- Antes do início do expediente do dia atual.
            AND  t.dth_fim    <  to_date(SYSDATE   ||' 08:00', 'dd/mm/rrrr hh24:mi:ss')    -- Antes do início do expediente do dia atual.
            OR   t.dth_inicio >= to_date(SYSDATE   ||' 12:00:01', 'dd/mm/rrrr hh24:mi:ss') -- Horário do almoço do dia atual.
            AND  t.dth_fim    <  to_date(SYSDATE   ||' 13:30', 'dd/mm/rrrr hh24:mi:ss')    -- Horário do almoço do dia atual.
            OR   to_char(t.dth_inicio, 'D') in (1,7)                                       -- Fim de semana.
            AND  to_char(t.dth_inicio, 'MM') = to_char(SYSDATE, 'MM'))                     -- Dentro do mês corrente.
    AND     t.num_matricula = v.num_matricula_colaborador
    AND     NOT EXISTS (SELECT  *
                        FROM    correcao_time_sheet
                        WHERE   seq_time_sheet = t.seq_time_sheet)                        
    ORDER BY t.num_matricula;
   
r_fora_expediente       c_fora_expediente%ROWTYPE;


-------------------------------------------------------------------------------------
--  Procedimento para buscar o e-mail dos responsáveis por aprovar a solicitação   --
-------------------------------------------------------------------------------------
PROCEDURE BUSCA_EMAIL IS
BEGIN
    BEGIN 
      SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
      INTO   v_nome_fiscal, v_email_fiscal
      FROM   equipe_ti a, 
             viw_colaborador b
      WHERE  a.NUM_MATRICULA_PRIORIZADOR = b.NUM_MATRICULA_COLABORADOR
      AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      EXCEPTION
        WHEN no_data_found THEN
            SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
            INTO   v_nome_fiscal, v_email_fiscal
            FROM   equipe_ti a, 
                   viw_colaborador b
            WHERE  a.NUM_MATRICULA_LIDER = b.NUM_MATRICULA_COLABORADOR
            AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
    END;
        
    BEGIN    
      SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
      INTO   v_nome_preposto, v_email_preposto
      FROM   equipe_ti a, 
             viw_colaborador b
      WHERE  a.NUM_MATRICULA_LIDER = b.NUM_MATRICULA_COLABORADOR
      AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      EXCEPTION
        WHEN no_data_found THEN
            SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
            INTO   v_nome_preposto, v_email_preposto
            FROM   equipe_ti a, 
                   viw_colaborador b
            WHERE  a.NUM_MATRICULA_PRIORIZADOR = b.NUM_MATRICULA_COLABORADOR
            AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      END;

END BUSCA_EMAIL;
-------------------------------------------------------------------------------------
--                              FIM DO PROCEDIMENTO                                --
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
--                 Procedimento para buscar a equipe do colaborador                --
-------------------------------------------------------------------------------------
PROCEDURE BUSCA_EQUIPE IS
BEGIN
      SELECT seq_equipe_ti
      INTO   v_seq_equipe
      FROM   recurso_ti
      WHERE  num_matricula_recurso = r_fora_expediente.num_matricula;

END BUSCA_EQUIPE;
-------------------------------------------------------------------------------------
--                              FIM DO PROCEDIMENTO                                --
-------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------
--                         INÍCIO DO BLOCO PRINCIPAL                               --
-------------------------------------------------------------------------------------
BEGIN

    OPEN c_fora_expediente;
    LOOP
    FETCH c_fora_expediente INTO r_fora_expediente;
        EXIT WHEN c_fora_expediente%NOTFOUND;
        
            SELECT  count(*)
            INTO    v_existe
            FROM    correcao_time_sheet
            WHERE   seq_time_sheet = r_fora_expediente.seq_time_sheet;
            
            /*
                Inclui uma solicitação de correção de timesheet para aprovação
                do Coordenador.
                Caso já exista uma solicitação feita pelo colaborador para um
                registro específico, este é apenas atualizado.
            */
            IF v_existe = 0 THEN 
                INSERT INTO correcao_time_sheet(SEQ_TIME_SHEET,
                                                DTH_INICIO_CORRECAO,
                                                DTH_FIM_CORRECAO,
                                                TXT_JUSTIFICATIVA_CORRECAO,
                                                FLG_APROVADO,
                                                NUM_MATRICULA_APROVADOR
                                        )
                VALUES (r_fora_expediente.seq_time_sheet,
                        r_fora_expediente.dth_inicio,
                        r_fora_expediente.dth_fim,
                        'Solicitação para aprovação feita automaticamente pelo Sistema.',
                        'N',
                        NULL
                        );
            ELSE
                UPDATE correcao_time_sheet
                SET    DTH_INICIO_CORRECAO = r_fora_expediente.dth_inicio,
                       DTH_FIM_CORRECAO = r_fora_expediente.dth_fim,
                       TXT_JUSTIFICATIVA_CORRECAO = 'Solicitação para aprovação feita automaticamente pelo Sistema.',
                       FLG_APROVADO = 'N',
                       NUM_MATRICULA_APROVADOR = NULL
                WHERE  SEQ_TIME_SHEET = r_fora_expediente.seq_time_sheet;
            END IF;
            commit;
            BUSCA_EQUIPE;
            BUSCA_EMAIL; 
            
            
            
            
---------------------------------------------------------------------------------------------------
--                         ENVIA E-MAIL PARA O COORDENADOR DA ÁREA                               --
---------------------------------------------------------------------------------------------------
            v_mensagem := v_nome_fiscal||',
    Foi encontrado pelo sistema um lancamento de horas trabalhadas pelo(a) profissional '||r_fora_expediente.nom_colaborador||' fora do horário do expediente.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Período: '|| to_char(r_fora_expediente.dth_inicio, 'dd/mm/rrrr hh24:mi:ss') ||' até '|| to_char(r_fora_expediente.dth_fim, 'dd/mm/rrrr hh24:mi:ss') ||'
    Para avaliar o lancamento, acesse o Gestao TI no menu Profissionais - Time Sheet - Analisar Solicitacoes de Correcao.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/';
            BEGIN
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', v_email_fiscal, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;
---------------------------------------------------------------------------------------------------
--                         ENVIA E-MAIL PARA O COORDENADOR DA ÁREA                               --
---------------------------------------------------------------------------------------------------

            


            
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O PREPOSTO                                    --
---------------------------------------------------------------------------------------------------
            v_mensagem := v_nome_preposto||',
    Foi encontrado pelo sistema um lancamento de horas trabalhadas pelo(a) profissional '||r_fora_expediente.nom_colaborador||' fora do horário do expediente.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Período: '|| to_char(r_fora_expediente.dth_inicio, 'dd/mm/rrrr hh24:mi:ss') ||' até '|| to_char(r_fora_expediente.dth_fim, 'dd/mm/rrrr hh24:mi:ss') ||'
    O lancamento sera avaliado pelo responsavel da area para aprovacao.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/';            
            BEGIN
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', v_email_preposto, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;
 --------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O PREPOSTO                                    --
---------------------------------------------------------------------------------------------------           
  



          
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O COLABORADOR                                 --
---------------------------------------------------------------------------------------------------
            v_mensagem := r_fora_expediente.nom_colaborador||',
    Seu lancamento realizado em '||r_fora_expediente.dth_inicio||' até '||r_fora_expediente.dth_fim||' sera analisado pela Infraero.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Aguarde a aprovacao do lancamento.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/'; 
            BEGIN            
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', r_fora_expediente.dsc_email, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;                
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O COLABORADOR                                 --
---------------------------------------------------------------------------------------------------
       

     
    END LOOP;
    CLOSE c_fora_expediente; 

END;
 
 

/
--------------------------------------------------------
--  DDL for Procedure PRC_ABRE_CHAMADO_AUTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."PRC_ABRE_CHAMADO_AUTO" (
P_num_matricula_solicitante     IN NUMBER,
P_seq_atividade_chamado         IN NUMBER,
P_seq_prioridade_chamado        IN NUMBER,
P_txt_chamado                   IN VARCHAR2
)
IS
    p_seq_chamado number;
    p_error number;
BEGIN
    p_error:=0;
    
    select seq_chamado.nextval into p_seq_chamado from dual;
    INSERT INTO chamado(
        seq_chamado,
        num_matricula_solicitante,
        seq_atividade_chamado,
        seq_situacao_chamado,
        seq_localizacao_fisica,
        seq_prioridade_chamado,
        txt_chamado,
        dth_abertura,
        dth_inicio_previsao
    )
    VALUES(
        p_seq_chamado,
        P_num_matricula_solicitante,
        P_seq_atividade_chamado,
        1,
        2,
        P_seq_prioridade_chamado,
        P_txt_chamado,
        sysdate,
        (sysdate + (20/1440))
    );
    
    p_error:=sql%rowcount;
    
    insert into Historico_chamado(
        Seq_historico_chamado,
        Seq_chamado,
        Num_matricula,
        Dth_historico,
        Seq_situacao_chamado
    )
    values(
        seq_historico_chamado.nextval,
        p_seq_chamado,
        P_num_matricula_solicitante,
        sysdate,
        1
    );
    
    p_error:=p_error+sql%rowcount;
    
    if p_error = 2 then
        commit;
    end if;
    
    EXCEPTION
        WHEN OTHERS THEN
            rollback;
            raise_application_error (-20699, SQLERRM);
END; 
 

/
--------------------------------------------------------
--  DDL for Procedure PRC_ATUALIZA_TSHEET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."PRC_ATUALIZA_TSHEET" 
as
begin
update time_sheet 
set DTH_FIM = sysdate
where DTH_FIM is null;
commit;
end;
 
 

/
--------------------------------------------------------
--  DDL for Procedure PRC_AVALIACAO_AUTOMATICA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."PRC_AVALIACAO_AUTOMATICA" AS
--DECLARE
v_seq_historico     NUMBER;
CURSOR c_avaliacao IS
    SELECT  seq_chamado, dth_abertura, dth_encerramento_efetivo,
            seq_avaliacao_atendimento,
            num_matricula_avaliador,
            flg_solicitacao_atendida,
            txt_avaliacao
    FROM    chamado
    WHERE   seq_situacao_chamado = 8
    AND     seq_avaliacao_atendimento IS NULL
    AND     dth_encerramento_efetivo <= to_date(SYSDATE-5 ||' 23:59:00', 'dd/mm/rrrr hh24:mi:ss') -- mais de cinco dias aguardando avaliação.
    ORDER BY 1;
r_avaliacao       c_avaliacao%ROWTYPE;
BEGIN
    OPEN c_avaliacao;
    LOOP
    FETCH c_avaliacao INTO r_avaliacao;
        EXIT WHEN c_avaliacao%NOTFOUND;
            UPDATE  chamado
            SET     SEQ_AVALIACAO_ATENDIMENTO = 1,
                    SEQ_SITUACAO_CHAMADO = 4,
                    NUM_MATRICULA_AVALIADOR = '0000001',
                    FLG_SOLICITACAO_ATENDIDA = 'S',
                    TXT_AVALIACAO = 'Avaliação automática realizada após mais de 5 dias do encerramento do chamado.'
            WHERE   SEQ_CHAMADO = r_avaliacao.seq_chamado;
            SELECT  SEQ_HISTORICO_CHAMADO.nextval
            INTO    v_seq_historico
            FROM    dual;
            INSERT INTO historico_chamado(SEQ_HISTORICO_CHAMADO,
                                          SEQ_CHAMADO,
                                          NUM_MATRICULA,
                                          DTH_HISTORICO,
                                          SEQ_SITUACAO_CHAMADO,
                                          SEQ_MOTIVO_SUSPENCAO,
                                          TXT_HISTORICO
                                          )
            VALUES (v_seq_historico,
                    r_avaliacao.seq_chamado,
                    '0000001',
                    SYSDATE,
                    4,
                    NULL,
                    'Avaliação automática realizada após mais de 5 dias do encerramento do chamado.'
                   );
    END LOOP;
    CLOSE c_avaliacao;
END;
 
 

/
--------------------------------------------------------
--  DDL for Procedure PRC_FORA_EXPEDIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."PRC_FORA_EXPEDIENTE" AS


v_nome_fiscal           varchar2(100);
v_email_fiscal          varchar2(100);
v_nome_preposto         varchar2(100);
v_email_preposto        varchar2(100);
v_seq_equipe            number;
v_mensagem              varchar2(2000);
v_assunto               varchar2(100);
v_existe                number;
v_erro                  varchar2(2000);


/*
Cursor: c_fora_expediente.
Finalidade: Buscar os registros lançados fora do expediente para análise e aprovação.
            Os registros recuperados são apenas dos contratos referentes ao Pregão
            050 de 2008.
*/
CURSOR c_fora_expediente IS
    SELECT  t.seq_time_sheet,
            t.seq_chamado,
            v.nom_colaborador,
            t.num_matricula,
            v.dsc_email,
            t.dth_inicio,
            t.dth_fim
    FROM    time_sheet t, viw_colaborador v
    WHERE   t.num_matricula IN (
                              SELECT num_matricula_recurso
                              FROM   recurso_ti
                              WHERE  num_contrato IN ('TC 073-PS/2009/0001','TC 074-PS/2009/0001')
                             )
    AND    (t.dth_inicio      >= to_date(SYSDATE-1 ||' 17:30:01', 'dd/mm/rrrr hh24:mi:ss') -- Após o fim do expediente do dia anterior.
            AND  t.dth_fim    <= to_date(SYSDATE-1 ||' 23:59:59', 'dd/mm/rrrr hh24:mi:ss') -- Após o fim do expediente do dia anterior.
            OR   t.dth_inicio >= to_date(SYSDATE   ||' 00:00:00', 'dd/mm/rrrr hh24:mi:ss') -- Antes do início do expediente do dia atual.
            AND  t.dth_fim    <  to_date(SYSDATE   ||' 08:00', 'dd/mm/rrrr hh24:mi:ss')    -- Antes do início do expediente do dia atual.
            OR   t.dth_inicio >= to_date(SYSDATE   ||' 12:00:01', 'dd/mm/rrrr hh24:mi:ss') -- Horário do almoço do dia atual.
            AND  t.dth_fim    <  to_date(SYSDATE   ||' 13:30', 'dd/mm/rrrr hh24:mi:ss')    -- Horário do almoço do dia atual.
            OR   to_char(t.dth_inicio, 'D') in (1,7)                                       -- Fim de semana.
            AND  to_char(t.dth_inicio, 'MM') = to_char(SYSDATE, 'MM'))                     -- Dentro do mês corrente.
    AND     t.num_matricula = v.num_matricula_colaborador
    AND     NOT EXISTS (SELECT  *
                        FROM    correcao_time_sheet
                        WHERE   seq_time_sheet = t.seq_time_sheet)                        
    ORDER BY t.num_matricula;
   
r_fora_expediente       c_fora_expediente%ROWTYPE;


-------------------------------------------------------------------------------------
--  Procedimento para buscar o e-mail dos responsáveis por aprovar a solicitação   --
-------------------------------------------------------------------------------------
PROCEDURE BUSCA_EMAIL IS
BEGIN
    BEGIN 
      SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
      INTO   v_nome_fiscal, v_email_fiscal
      FROM   equipe_ti a, 
             viw_colaborador b
      WHERE  a.NUM_MATRICULA_PRIORIZADOR = b.NUM_MATRICULA_COLABORADOR
      AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      EXCEPTION
        WHEN no_data_found THEN
            SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
            INTO   v_nome_fiscal, v_email_fiscal
            FROM   equipe_ti a, 
                   viw_colaborador b
            WHERE  a.NUM_MATRICULA_LIDER = b.NUM_MATRICULA_COLABORADOR
            AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
    END;
        
    BEGIN    
      SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
      INTO   v_nome_preposto, v_email_preposto
      FROM   equipe_ti a, 
             viw_colaborador b
      WHERE  a.NUM_MATRICULA_LIDER = b.NUM_MATRICULA_COLABORADOR
      AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      EXCEPTION
        WHEN no_data_found THEN
            SELECT b.NOM_COLABORADOR, b.DSC_EMAIL
            INTO   v_nome_preposto, v_email_preposto
            FROM   equipe_ti a, 
                   viw_colaborador b
            WHERE  a.NUM_MATRICULA_PRIORIZADOR = b.NUM_MATRICULA_COLABORADOR
            AND    a.SEQ_EQUIPE_TI = v_seq_equipe;
      END;

END BUSCA_EMAIL;
-------------------------------------------------------------------------------------
--                              FIM DO PROCEDIMENTO                                --
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
--                 Procedimento para buscar a equipe do colaborador                --
-------------------------------------------------------------------------------------
PROCEDURE BUSCA_EQUIPE IS
BEGIN
      SELECT seq_equipe_ti
      INTO   v_seq_equipe
      FROM   recurso_ti
      WHERE  num_matricula_recurso = r_fora_expediente.num_matricula;

END BUSCA_EQUIPE;
-------------------------------------------------------------------------------------
--                              FIM DO PROCEDIMENTO                                --
-------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------
--                         INÍCIO DO BLOCO PRINCIPAL                               --
-------------------------------------------------------------------------------------
BEGIN

    OPEN c_fora_expediente;
    LOOP
    FETCH c_fora_expediente INTO r_fora_expediente;
        EXIT WHEN c_fora_expediente%NOTFOUND;
        
            SELECT  count(*)
            INTO    v_existe
            FROM    correcao_time_sheet
            WHERE   seq_time_sheet = r_fora_expediente.seq_time_sheet;
            
            /*
                Inclui uma solicitação de correção de timesheet para aprovação
                do Coordenador.
                Caso já exista uma solicitação feita pelo colaborador para um
                registro específico, este é apenas atualizado.
            */
            IF v_existe = 0 THEN 
                INSERT INTO correcao_time_sheet(SEQ_TIME_SHEET,
                                                DTH_INICIO_CORRECAO,
                                                DTH_FIM_CORRECAO,
                                                TXT_JUSTIFICATIVA_CORRECAO,
                                                FLG_APROVADO,
                                                NUM_MATRICULA_APROVADOR
                                        )
                VALUES (r_fora_expediente.seq_time_sheet,
                        r_fora_expediente.dth_inicio,
                        r_fora_expediente.dth_fim,
                        'Solicitação para aprovação feita automaticamente pelo Sistema.',
                        'N',
                        NULL
                        );
            ELSE
                UPDATE correcao_time_sheet
                SET    DTH_INICIO_CORRECAO = r_fora_expediente.dth_inicio,
                       DTH_FIM_CORRECAO = r_fora_expediente.dth_fim,
                       TXT_JUSTIFICATIVA_CORRECAO = 'Solicitação para aprovação feita automaticamente pelo Sistema.',
                       FLG_APROVADO = 'N',
                       NUM_MATRICULA_APROVADOR = NULL
                WHERE  SEQ_TIME_SHEET = r_fora_expediente.seq_time_sheet;
            END IF;
            commit;
            BUSCA_EQUIPE;
            BUSCA_EMAIL; 
            
            
            
            
---------------------------------------------------------------------------------------------------
--                         ENVIA E-MAIL PARA O COORDENADOR DA ÁREA                               --
---------------------------------------------------------------------------------------------------
            v_mensagem := v_nome_fiscal||',
    Foi encontrado pelo sistema um lancamento de horas trabalhadas pelo(a) profissional '||r_fora_expediente.nom_colaborador||' fora do horário do expediente.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Período: '|| to_char(r_fora_expediente.dth_inicio, 'dd/mm/rrrr hh24:mi:ss') ||' até '|| to_char(r_fora_expediente.dth_fim, 'dd/mm/rrrr hh24:mi:ss') ||'
    Para avaliar o lancamento, acesse o Gestao TI no menu Profissionais - Time Sheet - Analisar Solicitacoes de Correcao.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/';
            BEGIN
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', v_email_fiscal, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;
---------------------------------------------------------------------------------------------------
--                         ENVIA E-MAIL PARA O COORDENADOR DA ÁREA                               --
---------------------------------------------------------------------------------------------------

            


            
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O PREPOSTO                                    --
---------------------------------------------------------------------------------------------------
            v_mensagem := v_nome_preposto||',
    Foi encontrado pelo sistema um lancamento de horas trabalhadas pelo(a) profissional '||r_fora_expediente.nom_colaborador||' fora do horário do expediente.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Período: '|| to_char(r_fora_expediente.dth_inicio, 'dd/mm/rrrr hh24:mi:ss') ||' até '|| to_char(r_fora_expediente.dth_fim, 'dd/mm/rrrr hh24:mi:ss') ||'
    O lancamento sera avaliado pelo responsavel da area para aprovacao.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/';            
            BEGIN
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', v_email_preposto, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;
 --------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O PREPOSTO                                    --
---------------------------------------------------------------------------------------------------           
  



          
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O COLABORADOR                                 --
---------------------------------------------------------------------------------------------------
            v_mensagem := r_fora_expediente.nom_colaborador||',
    Seu lancamento realizado em '||r_fora_expediente.dth_inicio||' até '||r_fora_expediente.dth_fim||' sera analisado pela Infraero.
    Chamado: '||r_fora_expediente.seq_chamado||'
    Aguarde a aprovacao do lancamento.
    Esta e uma mensagem automatica, favor nao responder.
---
Gestao TI
http://www.infranet.gov.br/gestaoti/'; 
            BEGIN            
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', r_fora_expediente.dsc_email, 'Gestao TI - WEB (Lancamento de servico fora do horario de expediente)', v_mensagem);
            EXCEPTION
            WHEN OTHERS THEN
                v_erro := SQLERRM;
                IFRSRH.ENVIA_EMAIL('gestaoti_cea@infraero.gov.br', 'gestaoti_cea@infraero.gov.br', 'Erro no envio de e-mail', v_erro);
            END;                
---------------------------------------------------------------------------------------------------
--                               ENVIA E-MAIL PARA O COLABORADOR                                 --
---------------------------------------------------------------------------------------------------
       

     
    END LOOP;
    CLOSE c_fora_expediente; 

END; 
 
 

/
--------------------------------------------------------
--  DDL for Procedure PRC_TEMPO_ATENDIMENTO_CHAMADO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "IFRCACCOM"."PRC_TEMPO_ATENDIMENTO_CHAMADO" 
(data1 in date, data2 in date)
AS
    CURSOR C_TESTE IS 
        SELECT
                c.seq_chamado NrChamado,
                decode(ac.flg_atendimento_externo, 'S','Externo',
                                                   'N','Interno') Origem,
                v.nome Executor,
                a.dth_atribuicao DataAtribuicao,
                a.dth_encerramento_efetivo DataEncerramento,
                c.dth_encerramento_efetivo DataEncerramentoChamado,
                s.dsc_subtipo_chamado Servico,
                ac.dsc_atividade_chamado Atividade,
                a.txt_encerramento DescricaoAtendimento,
                CASE WHEN ac.flg_atendimento_externo = 'S' THEN ac.qtd_min_sla_atendimento/10
                    ELSE ac.qtd_min_sla_atendimento
                END as SLAContratada,
                round((a.dth_encerramento_efetivo - a.dth_atribuicao) * 1440) TempoAtendimento,
                aa.nom_avaliacao_atendimento nomAvaliacao,
                c.txt_avaliacao dscAvaliacao,
                t.nom_equipe_ti equipeTI,
                c.dth_abertura dtAbertura,
                v2.dependencia Dependencia, v2.lotacao Lotacao, e.nom_edificacao_infraero Edificacao, l.nom_localizacao_fisica Localizacao
        FROM    atribuicao_chamado a
        INNER JOIN chamado c on(a.seq_chamado = c.seq_chamado)
        INNER JOIN atividade_chamado ac on(c.seq_atividade_chamado = ac.seq_atividade_chamado)
        INNER JOIN subtipo_chamado s on(ac.seq_subtipo_chamado = s.seq_subtipo_chamado)
        INNER JOIN equipe_ti t on (t.seq_equipe_ti = a.seq_equipe_ti)
        left join localizacao_fisica l on c.seq_localizacao_fisica = l.seq_localizacao_fisica
        left join edificacao_infraero e on l.seq_edificacao_infraero = e.seq_edificacao_infraero
        left JOIN viw_age_empregados v ON((a.num_matricula = substr(v.cpf,1,9)) or (a.num_matricula = v.matricula))
        left JOIN viw_age_empregados v2 ON((c.num_matricula_solicitante = substr(v2.cpf,1,9)) or (c.num_matricula_solicitante = v2.matricula))
        left join avaliacao_atendimento aa on c.seq_avaliacao_atendimento = aa.seq_avaliacao_atendimento
        WHERE
        a.seq_equipe_ti in (223)
        AND     ac.flg_ativo = 'S'
        AND     a.dth_atribuicao >= to_date(data1, 'dd/mm/rrrr hh24:mi:ss')
        AND     a.dth_atribuicao <= to_date(data2, 'dd/mm/rrrr hh24:mi:ss')
        order by c.seq_chamado;

    cont INTEGER;
    temp varchar(100);
    REG_CHAMADO C_TESTE%ROWTYPE;
    dt_aux date;
    dt_aux_fim date;
    cont_fds integer;
BEGIN
    OPEN C_TESTE;
    delete ifrgestao_ti.temp_sla;
    LOOP
        FETCH C_TESTE INTO REG_CHAMADO;
        EXIT WHEN C_TESTE%NOTFOUND;
        cont := 0;
        temp := '';
--DEVE CONTAR QTS SAB E DOM EXISTEM E RETIRAR 480 MIN A CADA UM.
--A EXCESSÃO QUANDO O CHAMADO FOI ABERTO OU FECHADO EM UM DESTES DIAS(SAB OU DOM).
        select count(*) into cont_fds
        from ( select rownum rnum
        from all_objects
        where rownum <= to_date(REG_CHAMADO.DataEncerramento, 'DD/MM/YYYY') - to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY')+1)
        where TO_CHAR(to_date(REG_CHAMADO.DataAtribuicao, 'DD/MM/YYYY')+rnum-1, 'D') not in ('7', '1');
        
        if(to_char(REG_CHAMADO.DataAtribuicao,'D') not in('1','7') AND to_char(REG_CHAMADO.DataEncerramento,'D') not in('1','7'))then
            --Se o fechamento foi no mesmo dia da alocação.
            IF TO_CHAR(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY') = TO_CHAR(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY')THEN
                --cont := cont + 1;
                --Se a alocação e fechamento foi realizado dentro do período de trabalho.
                if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') >= '08:00:00' and to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') <= '17:00:00')then
                    --Chamados abertos ou fechados no horário de almoço.
                    if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') or (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')then
                        --Foi atribuido e fechado no horário de almoço.
                        if((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00'))THEN
                            --dbms_output.put_line('Neste caso não deve ser considerado nenhum tempo.'  || cont || ' - ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss'));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,0,'Foi atribuido e fechado no horário de almoço.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        else
                            --Foi atribuido no horário de almoço.
                            if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00')THEN
                                dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                                dt_aux := to_date(dt_aux) + (13/24);
                                --dbms_output.put_line('Foi ATRIBUIDO no horário de ALMOÇO ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/yyyy hh24:mi:ss') || '--' || to_char(dt_aux,'dd/mm/yyyy hh24:mi:ss')  || '-- Encerr:' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/yyyy hh24:mi:ss') || 'Dif:' || (dt_aux - REG_CHAMADO.DataAtribuicao) || 'FÁCIL ' || round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)) * 1440 ));
                                insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)) * 1440 ),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                            --Foi fechado no horário de almoço.
                            elsif(to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')then
                                dt_aux := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                                dt_aux := to_date(dt_aux) + (12/24);
                                --dbms_output.put_line('Foi FECHADO no horário de ALMOÇO ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/yyyy hh24:mi:ss') || '--' || to_char(dt_aux,'dd/mm/yyyy hh24:mi:ss')  || '-- Encerr:' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/yyyy hh24:mi:ss') || 'Dif:' || (REG_CHAMADO.DataEncerramento - dt_aux) || 'FÁCIL ' || round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)) * 1440 ));
                                insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)) * 1440 ),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                            else
                                insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Erro desconhecido 1.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                            END IF;
                        end if;
                    else
                        --Atendimento com horário de almoço no meio(Desconta 1 h).
                        if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') <= '12:00:00' and to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') > '13:00:00')then
                            --dbms_output.put_line('<><><>1 ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-(1/24)) * 1440 ));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-(1/24)) * 1440 ),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        else
                            --Atendimento normal ou parte da tarde ou parte da manhã.
                            --dbms_output.put_line('<><><>2 ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) * 1440 ));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) * 1440 ),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        end if;
                    end if;
                 --Alocação e ou o encerramento foi feito no horário de descanso.
                 else
                    --Foi atribuido e fechado no horário de descanso.
                    if(((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:01' and '23:59:59')
                            or (to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '00:00:00' and '07:59:59'))
                            and
                        ((to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '17:00:01' and '23:59:59')
                            or (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '00:00:00' and '07:59:59'))
                    )THEN
                        --dbms_output.put_line('****************Neste caso não deve ser considerado nenhum tempo.');
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,0,'Alocado e fechado durante o horário de descanço.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    else
                        --Foi atribuido no horário de descanço. 17:00:01' and '00:00:00
                        if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:01' and '23:59:59')THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'dd/mm/yyyy');
                            dt_aux := to_date(dt_aux) + (17/24);                        
                            --dbms_output.put_line('..................1 -' || '100%' || to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') ||'-'||to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') ||'='|| round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(REG_CHAMADO.DataAtribuicao-dt_aux))*1440));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(REG_CHAMADO.DataAtribuicao-dt_aux))*1440),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --Foi atribuido no horário de descanço. 00:00:00' and '07:59:59
                        elsif(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '00:00:00' and '07:59:59')then
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'dd/mm/yyyy');
                            dt_aux := to_date(dt_aux) + (8/24);                        
                            --dbms_output.put_line('..................2 -' || '100%' || to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') ||'-'||to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') ||'='|| round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(dt_aux-REG_CHAMADO.DataAtribuicao))*1440));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(dt_aux-REG_CHAMADO.DataAtribuicao))*1440),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --O encerramento foi no horário de descanço. 17:00:01' and '00:00:00
                        elsif(to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '17:00:01' and '23:59:59')THEN
                            dt_aux := to_date(REG_CHAMADO.DataEncerramento,'dd/mm/yyyy');
                            dt_aux := to_date(dt_aux) + (17/24);                        
                            --dbms_output.put_line('_________1 -' || '100%' || to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') ||'-'||to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') ||'='|| round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(REG_CHAMADO.DataEncerramento-dt_aux))*1440));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(REG_CHAMADO.DataEncerramento-dt_aux))*1440),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --O encerramento foi no horário de descanço. 00:00:00' and '07:59:59
                        ELSif(to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '00:00:00' and '07:59:59')then
                            dt_aux := to_date(REG_CHAMADO.DataEncerramento,'dd/mm/yyyy');
                            dt_aux := to_date(dt_aux) + (8/24);
                            --dbms_output.put_line('_________2 -' || '100%' || to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') ||'-'||to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') ||'='|| round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(dt_aux-REG_CHAMADO.DataEncerramento))*1440));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round(((REG_CHAMADO.DataEncerramento-REG_CHAMADO.DataAtribuicao)-(dt_aux-REG_CHAMADO.DataEncerramento))*1440),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        else
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Erro desconhecido 2.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        END IF;
                    end if;
                end if;
            ELSE
                --Cálculo da diferença, em dias, da abertura ao fechamento.
                cont := REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao;
                
                --Se a alocação e fechamento foi realizado dentro do período de trabalho.
                if((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '08:00:00' and '17:00:00') or (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '08:00:00' and '17:00:00'))then
                    --Foi atribuido ou fechado durante o horário de almoço.
                    if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') or (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')then
                        --/A/F
                        if(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '13:00:01' and '17:00:00')THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (13/24);
                            --dbms_output.put_line('Horário de almoço.1 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --A/F/
                        elsIF(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '08:00:00' and '12:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')THEN
                            dt_aux := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (12/24);
                            --dbms_output.put_line('Horário de almoço.2 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)-(cont/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)-(cont/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --F/A/
                        elsIF(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '08:00:00' and '12:00:00')THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (13/24);
                            --dbms_output.put_line('Horário de almoço.3 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --/F/A
                        elsIF(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '13:00:00' and '17:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')THEN
                            dt_aux := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (12/24);
                            --dbms_output.put_line('Horário de almoço.4 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)-((cont-1)/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux)-((cont-1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --/AF/
                        elsIF(to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '12:00:01' and '13:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '12:00:01' and '13:00:00')THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (13/24);
                            
                            dt_aux_fim := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                            dt_aux_fim := to_date(dt_aux_fim) + (12/24);
                            
                            --dbms_output.put_line('Horário de almoço.5 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont-1)/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont-1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        else
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Erro desconhecido 3.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        END IF;
                    else
                        --Para os chamados abertos e fechados pela manhã e para os abertos e fechados pela tarde.(CONFERIDO).
                        if(((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '08:00:00' and '12:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '08:00:00' and '12:00:00'))
                        or ((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '13:00:00' and '17:00:00') and (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '13:00:00' and '17:00:00'))
                        )then
                            --dbms_output.put_line('<><><>3 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --Para os chamados abertos pela manhã,  e fechados pela tarde.(CONFERIDO TAMBÉM).
                        elsIF((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '08:00:00' and '12:00:00') AND (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '13:00:00' and '17:00:00'))THEN
                            --dbms_output.put_line('<><><>4 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-((cont+1)/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-((cont+1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --Para os chamados abertos pela tarde,  e fechados pela manhã.(CONFERIDO).
                        elsIF((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '13:00:00' and '17:00:00') AND (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '08:00:00' and '12:00:00'))THEN
                            --dbms_output.put_line('<><><>5 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-(cont*15*60)));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA, round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --Para os chamados abertos das 17 as 00 e fechados de 08 as 12
                        elsIF((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:00' and '23:59:59') AND (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '08:00:00' and '12:00:00'))THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (23.9998/24);
                            
                            --dbms_output.put_line('<><><>6 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-((cont-1)*15*60)-480));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-((cont-1)/24)) * 1440 )-((cont-1)*15*60)-480),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        --Para os chamados abertos das 17 as 00 e fechados de 13 as 17
                        elsIF((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:00' and '23:59:59') AND (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '13:00:00' and '17:00:00'))THEN
                            dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                            dt_aux := to_date(dt_aux) + (23.9998/24);
                            
                            --dbms_output.put_line('<><><>7 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-(cont*15*60)-480));
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (dt_aux - REG_CHAMADO.DataAtribuicao)-(cont/24)) * 1440 )-((cont-1)*15*60)-480),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        else
                            insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Condição não implementada.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                        end if;
                    end if;
                --Se a alocação e fechamento foi realizado fora do período de trabalho.
                else
                    if(REG_CHAMADO.DataEncerramento is null)then
                        --dbms_output.put_line('Chamado aberto.(Ver se considera a data de hoje.)');
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Cmamado não encerrado.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    --AF/
                    elsif((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:01' and '23:59:59')
                    and   (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '17:00:01' and '23:59:59'))then
                        dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                        dt_aux := to_date(dt_aux) + (23.9998/24);

                        dt_aux_fim := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                        dt_aux_fim := to_date(dt_aux_fim) + (17/24);
                        -- O (-480) é o período de 00 às 08 do 1º dia após a abertura.
                        -- O cont-1 na expressão ((cont-1)*15*60), é que no 1º dia não tem o período de descanço completo.
                        --dbms_output.put_line('Horário de DESCANÇO.1 ' || cont || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -(cont/24)) * 1440 )-((cont-1)*15*60)-480));
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -(cont/24)) * 1440 )-((cont-1)*15*60)-480),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    --/AF
                    elsif((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '00:00:00' and '07:59:59')
                    and   (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '00:00:00' and '07:59:59'))then
                        dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                        dt_aux := to_date(dt_aux) + (8/24);

                        dt_aux_fim := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');

                        -- O (-420) é o período de 17:00 às 23:59 do dia da abertura.
                        -- O cont-1 na expressão ((cont-1)*15*60), é que no 1º dia não tem o período de descanço completo.
                        --dbms_output.put_line('Horário de DESCANÇO.2 ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -(cont/24)) * 1440 )-((cont-1)*15*60)-420));
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -(cont/24)) * 1440 )-((cont-1)*15*60)-420),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    --A/F
                    elsif((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '17:00:01' and '23:59:59')
                    and   (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '00:00:00' and '07:59:59'))then
                        dt_aux := to_date(REG_CHAMADO.DataAtribuicao,'DD/MM/YYYY');
                        dt_aux := to_date(dt_aux) + (23.9998/24);

                        dt_aux_fim := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');

                        --dbms_output.put_line('Horário de DESCANÇO.3 ' || cont || ' - ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont)/24)) * 1440 )-(cont*15*60)));
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    --F/A
                    elsif((to_char(REG_CHAMADO.DataAtribuicao,'HH24:MI:SS') between '00:00:00' and '07:59:59')
                    and   (to_char(REG_CHAMADO.DataEncerramento,'HH24:MI:SS') between '17:00:01' and '23:59:59'))then
                        Dt_Aux := To_Date(Reg_Chamado.Dataatribuicao,'DD/MM/YYYY');
                        dt_aux := to_date(dt_aux) + (8/24);

                        dt_aux_fim := to_date(REG_CHAMADO.DataEncerramento,'DD/MM/YYYY');
                        dt_aux_fim := to_date(dt_aux_fim) + (17/24);

                        --dbms_output.put_line('Horário de DESCANÇO.4 ' || cont || ' - ' || to_char(REG_CHAMADO.DataAtribuicao,'dd/mm/rrrr hh24:mi:ss') || ' - ' || to_char(REG_CHAMADO.DataEncerramento,'dd/mm/rrrr hh24:mi:ss') || 'FÁCIL ' || round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont+1)/24)) * 1440 )-(cont*15*60)));
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,round((((REG_CHAMADO.DataEncerramento - REG_CHAMADO.DataAtribuicao) - (REG_CHAMADO.DataEncerramento - dt_aux_fim) - (dt_aux - REG_CHAMADO.DataAtribuicao) -((cont+1)/24)) * 1440 )-(cont*15*60)),null, REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    else
                        insert into ifrgestao_ti.temp_sla values(REG_CHAMADO.NRCHAMADO, REG_CHAMADO.ORIGEM, REG_CHAMADO.EXECUTOR, REG_CHAMADO.DATAATRIBUICAO, REG_CHAMADO.DATAENCERRAMENTO, REG_CHAMADO.SERVICO, REG_CHAMADO.ATIVIDADE, REG_CHAMADO.DESCRICAOATENDIMENTO, REG_CHAMADO.SLACONTRATADA,null,'Erro desconhecido 5.', REG_CHAMADO.DataEncerramentoChamado, REG_CHAMADO.nomAvaliacao, REG_CHAMADO.dscAvaliacao, REG_CHAMADO.equipeTI, REG_CHAMADO.dtAbertura, REG_CHAMADO.Dependencia, REG_CHAMADO.Lotacao, REG_CHAMADO.Edificacao, REG_CHAMADO.Localizacao);
                    end if;
                end if;
            END IF;
        ELSE
            dbms_output.put_line(REG_CHAMADO.NRCHAMADO || ' SAB/DOM ' || cont_fds);
        END IF;
--dbms_output.put_line(REG_CHAMADO.NRCHAMADO || '--' || cont_fds);
    END LOOP;
    Close C_Teste;
End;
 

/
