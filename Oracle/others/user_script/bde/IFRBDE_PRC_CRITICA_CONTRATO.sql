CREATE OR REPLACE PROCEDURE PRC_CRITICA_CONTRATO (v_num_seq_contrato IN NUMBER)
IS
   
--
-- objetivo: executar criticas sobre os dados do contrato para que possa
-- se enviado para o smartstream
--
-- Historico de modifica��es
--  Pessoa                Data        Comentarios
-- ---------            ------       -------------------------------------------
-- Carlos lassance      17/03/2003   cria��o da procedure
--
-- variaveis
   v_sucesso             NUMBER (1);
   v_msg_critica         VARCHAR2 (2000);
   v_existe              NUMBER (1);
   v_situacao_contrato   ifrbde.tab_contrato.tip_situacao_contrato%TYPE;

   
-- cursores
   CURSOR regf (p_num_seq_contrato NUMBER)
   IS
      SELECT a.*
        FROM ifrbde.tab_firma a, ifrbde.cad_participantes_contrato b
       WHERE b.num_fir_cod = a.fir_cod
         AND b.num_seq_contrato_part = p_num_seq_contrato;

   CURSOR regr (p_num_seq_contrato NUMBER)
   IS
      SELECT *
        FROM ifrbde.cad_resumo_valores
       WHERE num_seq_contrato_res = p_num_seq_contrato;

   CURSOR regi (p_num_seq_contrato NUMBER)
   IS
      SELECT DISTINCT b.*
                 FROM ifrbde.tab_rec_aprovado a,
                      ifrbde.tab_tipo_recurso_item b,
                      ifrbde.tab_contrato c
                WHERE c.num_seq_contrato = p_num_seq_contrato
                  AND c.cnt_cre_cod = a.rap_cre_cod
                  AND a.rap_rti_cod = b.rti_cod
                  AND b.rti_conta = '000000000';

   CURSOR regc (p_num_seq_contrato NUMBER)
   IS
      SELECT c.*, b.*, d.*
        FROM ifrbde.tab_contrato c,
             ifrbde.tab_carencia b,
             ifrbde.tab_dependencia d
       WHERE c.num_seq_contrato = p_num_seq_contrato
         AND c.cnt_cre_cod = b.cre_cod
         AND b.cre_dep_cod = d.dep_cod;
BEGIN
   v_sucesso := 0;
   v_msg_critica := ' ';

   SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
     INTO v_msg_critica
     FROM DUAL;

   
-- verifica se existem empresas sem cnpj cadastradas para o contrato
   v_existe := 0;

   FOR regs IN regf (v_num_seq_contrato)
   LOOP
      v_existe := 1;

      IF regs.fir_cnpj IS NULL
      THEN
         v_msg_critica :=    v_msg_critica
                          || ' - '
                          || ' Empresa : '
                          || regs.fir_nome
                          || ' N�o esta com o CNPJ cadastrado ';
         v_sucesso := 1;
      END IF;

      IF regs.fir_cnpj = '00.000.000/0000-00'
      THEN
         v_msg_critica :=    v_msg_critica
                          || ' - '
                          || ' Empresa : '
                          || regs.fir_nome
                          || ' N�o esta com o CNPJ zerado ';
         v_sucesso := 1;
      END IF;
   END LOOP;

   IF v_existe = 0
   THEN
      v_msg_critica :=
               v_msg_critica
            || ' - '
            || ' N�o existem Empresas cadastradas para este contrato ';
      v_sucesso := 1;
   END IF;

   
-- verifica se existe resumo com cronogramas divergentes
   v_existe := 0;

   FOR regs IN regr (v_num_seq_contrato)
   LOOP
      v_existe := 1;

      IF NVL (regs.val_pagamento, 0) = 0
      THEN
         v_msg_critica :=    v_msg_critica
                          || ' - Cronograma do Resumo de Valores em '
                          || regs.tip_moeda
                          || ' esta zerado ';
         v_sucesso := 1;
      ELSE
         IF    (  NVL (regs.val_resumo, 0)
                + NVL (regs.val_termo, 0)
                - NVL (regs.val_pagamento, 0) <> 0
               )
            OR (  NVL (regs.val_resumo_sec, 0)
                + NVL (regs.val_termo_sec, 0)
                - NVL (regs.val_pagamento_sec, 0) >= 1
               )
            OR (  NVL (regs.val_resumo_sec, 0)
                + NVL (regs.val_termo_sec, 0)
                - NVL (regs.val_pagamento_sec, 0) < -1
               )
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Resumo de Valores em '
                  || regs.tip_moeda
                  || ' esta com o valor do cronograma diferente do total do resumo + aditivo ';
            v_sucesso := 1;
         END IF;
      END IF;
   END LOOP;

   IF v_existe = 0
   THEN
      v_msg_critica :=
               v_msg_critica
            || ' - '
            || ' N�o existem Resumos de Valores para este contrato ';
      v_sucesso := 1;
   END IF;

   
-- verifica se os recursos aprovados n�o tem conta contabil zerada
   v_existe := 0;

   FOR regs IN regi (v_num_seq_contrato)
   LOOP
      v_existe := 1;
      v_msg_critica :=    v_msg_critica
                       || ' - '
                       || ' Recurso : '
                       || regs.rti_sigla
                       || ' - '
                       || regs.rti_desc
                       || ' esta com a conta contabil zerada ';
   
--      v_sucesso := 1;
   END LOOP;

   
-- verifica��es nos dados do contrato
   v_existe := 0;

   FOR regs IN regc (v_num_seq_contrato)
   LOOP
      v_existe := 1;

      IF NVL (regs.cnt_valor, 0) < 0
      THEN
         IF SUBSTR (regs.cnt_cod, 1, 2) <> 'CV'
         THEN
            v_msg_critica :=    v_msg_critica
                             || ' - Contrato - Valor do Saldo esta Negativo ';
         ELSE
            v_msg_critica :=    v_msg_critica
                             || ' - Conv�nio - Valor do Saldo esta Negativo ';
         END IF;

         v_sucesso := 1;
      END IF;

      -- Verifica Dados da Licita��o (Anderson 13/04/2004) 
      IF      UPPER (regs.cod_modalidade_licitacao) <> 'DISP'
          AND UPPER (regs.cod_modalidade_licitacao) <> 'INEX'
      THEN
         IF    (regs.dsc_fundamento_legal IS NULL)
            OR (regs.num_licitacao IS NULL)
            OR (regs.num_ano_licitacao IS NULL)
            OR (regs.num_processo IS NULL)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - As informa��es dos Dados da Licita��o s�o obrigat�rios ';
            v_sucesso := 1;
         END IF;
      END IF;

      IF    UPPER (regs.cod_modalidade_licitacao) = 'DISP'
         OR UPPER (regs.cod_modalidade_licitacao) = 'INEX'
      THEN
         IF (regs.num_inciso IS NULL)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - As informa��es dos Dados da Licita��o s�o obrigat�rios '
                  || ' - Falta campo Inciso';
            v_sucesso := 1;
         END IF;
      END IF;

      -- Verifica dados da publica��o (Anderson 13/04/2004) 
      IF UPPER (regs.cod_modalidade_licitacao) <> 'DISP'
      THEN
         IF    (regs.dat_publicacao IS NULL)
            OR (regs.num_dou_publicacao IS NULL)
            OR (regs.num_pagina_publicacao IS NULL)
            OR (regs.num_secao_publicacao IS NULL)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - As informa��es dos Dados da Publica��o s�o obrigat�rios ';
            v_sucesso := 1;
         END IF;
      END IF;
         IF (SUBSTR (regs.cnt_cod, 1, 2) = 'TC') and
             (regs.NUM_SEQ_ASSINATURA_2 is null) then
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - A 2� assinatura � obrigat�ria para contrato do tipo "TC" !! ';
            v_sucesso := 1;
         end if;
         if regs.CNT_DATA_PROPOSTA > regs.CNT_DATA then
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - A Data da Proposta deve ser menor ou igual a Data do Contrato!! ';
            v_sucesso := 1;
         end if;
         if regs.DAT_PUBLICACAO <= regs.CNT_DATA then
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - A Data da Publica��o deve ser maior que a Data do Contrato!! ';
            v_sucesso := 1;
         end if;

/*
      IF SUBSTR (regs.cnt_cod, 1, 2) = 'CV'
      THEN
         SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
           INTO v_msg_critica
           FROM DUAL;

         v_msg_critica :=    v_msg_critica
                          || ' - Conv�nio - Liberado ';
         v_sucesso := 0;
      END IF;
*/
   END LOOP;

   
-- atualiza a situacao e a area de descri��o das criticas
   FOR regs IN regc (v_num_seq_contrato)
   LOOP
      IF v_sucesso = 1
      THEN
         v_situacao_contrato := 5;
      ELSE
         IF regs.tip_situacao_contrato = 5
         THEN
            v_situacao_contrato := 4;
         ELSE
            v_situacao_contrato := regs.tip_situacao_contrato;
         END IF;

         v_msg_critica :=    v_msg_critica
                          || ' - N�o foram encontrados Erros';
      END IF;

      BEGIN
         UPDATE ifrbde.tab_contrato
            SET tip_situacao_contrato = v_situacao_contrato,
                dsc_critica_contrato = v_msg_critica
          WHERE num_seq_contrato = v_num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20100,
                  'Erro ao Atualizar Situa��o do Contrato e as Criticas '
               || SQLERRM
            );
      END;

      -- disparar a integra��o com smartstream para altera��o da situa��o do contrato
      IF  regs.tip_situacao_contrato IN (2, 4) AND v_sucesso = 0
      THEN
         
--
-- (   regs.cre_projeto = 'S' OR regs.dep_dpp_cod IN (69,66,67,68,70) ) AND
--
--
-- OS CONTRATOS QUE EST�O ESTRUTURADOS COMO CONV�NIOS FOI LIBERADO A TRANSMISS�O
-- PARA O SS:CONTRATOS A PARTIR DE 5/4/2004
-- COM O E-MAIL ENVIADO PELO GESTOR ALEXANDRE RADIS
--       
--         IF SUBSTR (regs.cnt_cod, 1, 2) <> 'CV'
--         THEN
--
--  Exclui a vers�o do contrato atual da integra��o
--
         ifrbde.prc_exclui_sst_contrato (
            regs.cnt_cod,
            regs.num_versao_contrato
         );
--
-- refaz o saldo no cronograma
--
         ifrbde.prc_calcula_hst_pag_crono (v_num_seq_contrato);
--
--    transmite para o area de integra��o a ultima vers�o do contrato
--
         ifrbde.prc_conf_identificacao_u (v_num_seq_contrato);
         ifrbde.prc_conf_objeto_u (v_num_seq_contrato);
         ifrbde.prc_conf_termo_u (v_num_seq_contrato);
         ifrbde.prc_conf_datas_u (v_num_seq_contrato);
         ifrbde.prc_conf_publicacao_u (v_num_seq_contrato);
         ifrbde.prc_conf_participantes_u (v_num_seq_contrato);
         ifrbde.prc_conf_item_ident_u (v_num_seq_contrato);
         ifrbde.prc_conf_item_acct_u (v_num_seq_contrato);
         ifrbde.prc_conf_item_resumo_u (v_num_seq_contrato);
         ifrbde.prc_conf_item_cronog_u (v_num_seq_contrato);
         
/*         ELSE
            BEGIN
               SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                 INTO v_msg_critica
                 FROM DUAL;

               v_msg_critica :=
                        v_msg_critica
                     || ' - Mudan�a de situa��o Efetivada com sucesso  ';

               UPDATE ifrbde.tab_contrato
                  SET tip_situacao_contrato = 6,
                      dsc_critica_contrato = v_msg_critica
                WHERE num_seq_contrato = v_num_seq_contrato;
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                        'Erro ao Atualizar Situa��o do Contrato para enviado a Financeira '
                     || SQLERRM
                  );
            END;
         END IF;
*/

      END IF;
   END LOOP;
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'erro na procedure de critica '
         || SQLERRM
      );
END prc_critica_contrato;
