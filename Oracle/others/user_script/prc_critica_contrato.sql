/* Formatted on 2004/12/08 13:58 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PROCEDURE ifrbde.prc_critica_contrato (
   v_num_seq_contrato   IN   NUMBER
)
IS
   
--
-- objetivo: executar criticas sobre os dados do contrato para que possa
-- se enviado para o smartstream
--
-- Historico de modificações
--  Pessoa                Data        Comentarios
-- ---------            ------       -------------------------------------------
-- Carlos lassance      17/03/2003   criação da procedure
--
-- variaveis
   v_sucesso             NUMBER (1);
   v_msg_critica         VARCHAR2 (2000);
   v_existe              NUMBER (1);
   v_existe_real         NUMBER (1);
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

   CURSOR regt (p_num_seq_contrato_ta NUMBER)
   IS
      SELECT a.cta_cnt_cre_cod, a.cta_cnt_cod, a.cta_periodo, a.cta_num,
             a.cta_objeto, a.cta_valor, a.cta_prazo, a.cta_deb_cred,
             a.cta_aum_dim, a.num_seq_termo, a.num_seq_contrato_termo,
             a.dat_periodo, a.num_seq_resumo_ta, a.dat_moeda_ta,
             a.val_moeda_ta, a.tip_cotacao_moeda, a.num_versao_contrato_vta
        FROM tab_cont_termo_aditivo a
       WHERE a.num_seq_contrato_termo = p_num_seq_contrato_ta
         AND a.cta_valor = 0
         AND a.num_versao_contrato_vta <> '00';
BEGIN
   v_sucesso := 0;
   v_msg_critica := ' ';
   v_existe_real := 0;

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
                          || ' Não esta com o CNPJ cadastrado ';
         v_sucesso := 1;
      END IF;

      IF regs.fir_cnpj = '00.000.000/0000-00'
      THEN
         v_msg_critica :=    v_msg_critica
                          || ' - '
                          || ' Empresa : '
                          || regs.fir_nome
                          || ' Não esta com o CNPJ zerado ';
         v_sucesso := 1;
      END IF;
   END LOOP;

   IF v_existe = 0
   THEN
      v_msg_critica :=
               v_msg_critica
            || ' - '
            || ' Não existem Empresas cadastradas para este contrato ';
      v_sucesso := 1;
   END IF;

   
-- verifica se existem algum de termo de valor com o valor zerado para o contrato
   v_existe := 0;

   FOR rggt IN regt (v_num_seq_contrato)
   LOOP
      v_existe := 1;
      v_msg_critica :=
               v_msg_critica
            || ' -  Existe registro de termo aditivo com valor zerado ';
      v_sucesso := 1;
   END LOOP;

   
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

      
--
--
-- calcula os totais para o cronograma realizado de desembolso, Desembolso aduaneiro
--
      IF regs.flg_moeda_controle = 1
      THEN
         IF NVL (regs.val_pagamento, 0) <>
                                        NVL (regs.val_crono_realizado_pag, 0)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Valor Total do Cronograma Realizado para desembolso '
                  || TO_CHAR (NVL (regs.val_crono_realizado_pag, 0))
                  || ' não pode ser diferente do Valor Total do Cronograma Financeiro '
                  || TO_CHAR (NVL (regs.val_pagamento, 0));
            v_existe_real := 1;
         END IF;

         
--
-- calcula os totais para o cronograma de reajuste
--


         IF NVL (regs.val_reajuste, 0) <
                                        NVL (regs.val_crono_realizado_reaj, 0)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Valor Total do Cronograma Realizado para reajuste '
                  || TO_CHAR (NVL (regs.val_crono_realizado_reaj, 0))
                  || ' não pode ser menor do que Valor Total do Cronograma Financeiro para reajuste '
                  || TO_CHAR (NVL (regs.val_reajuste, 0));
            v_existe_real := 1;
         END IF;
      END IF;

      
--
--  calcula o resumo para moeda secundaria
--
--
-- calcula os totais para o cronograma de desembolso, Desembolso aduaneiro
--

      IF regs.flg_moeda_controle = 2
      THEN
         IF NVL (regs.val_pagamento_sec, 0) <>
                                    NVL (regs.val_crono_realizado_pag_sec, 0)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Valor Total do Cronograma Realizado para desembolso '
                  || TO_CHAR (NVL (regs.val_crono_realizado_pag_sec, 0))
                  || ' não pode ser diferente do Valor Total do Cronograma Financeiro '
                  || TO_CHAR (NVL (regs.val_pagamento_sec, 0))
                  || ' para moeda secundaria ';
            v_existe_real := 1;
         END IF;
      END IF;
   
--
/*
         IF NVL (regs.qtd_crono_realizado_invalidos, 0) > 0
            THEN
               BEGIN
                  -- trunc(nvl(regs.dat_base_crono_invalido,systdate),'dd/mm/yyyy')

                  tot_qtd_ocorrencias_crono := 0;

                  SELECT COUNT (*)
                    INTO tot_qtd_ocorrencias_crono
                    FROM ifrbde.cad_resumo_cronograma
                   WHERE num_seq_contrato_rc = regs.num_seq_resumo
                     AND TO_DATE (
                            TO_CHAR (dat_vencimento_rc, 'dd/mm/yyyy'),
                            'dd/mm/yyyy'
                         ) < TO_DATE (
                                TO_CHAR (SYSDATE, 'dd/mm/yyyy'),
                                'dd/mm/yyyy'
                             )
                     AND num_seq_resumo_pag = NULL;

                  IF tot_qtd_ocorrencias_crono > 0
                  THEN
            v_msg_critica :=
                     v_msg_critica                           || ' - Existe(m) '
                           || TO_CHAR (tot_qtd_ocorrencias_crono)
                           || ' Ocorrência(s) de cronograma(s) de realização com data de vencimento menor que '
                           || TO_CHAR (SYSDATE, 'dd/mm/yyyy');
                    v_existe_real := 1;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                      NULL;
                  WHEN OTHERS
                  THEN
                     v_erro :=
                           'Não foi possível atualizar os Totais do Cronograma de Desembolso ou Desembaraço Aduaneiro para moeda secundaria';
                     v_sucesso := 1;
               END;
            END IF;
*/

--
   END LOOP;

   IF v_existe = 0
   THEN
      v_msg_critica :=
               v_msg_critica
            || ' - '
            || ' Não existem Resumos de Valores para este contrato ';
      v_sucesso := 1;
   END IF;

   
-- verifica se os recursos aprovados não tem conta contabil zerada
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

   
-- verificações nos dados do contrato
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
                             || ' - Convênio - Valor do Saldo esta Negativo ';
         END IF;

         v_sucesso := 1;
      END IF;

      -- Verifica Dados da Licitação (Anderson 13/04/2004)
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
                  || ' - Contrato - As informações dos Dados da Licitação são obrigatórios ';
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
                  || ' - Contrato - As informações dos Dados da Licitação são obrigatórios '
                  || ' - Falta campo Inciso';
            v_sucesso := 1;
         END IF;
      END IF;

      -- Verifica dados da publicação (Anderson 13/04/2004)
      IF UPPER (regs.cod_modalidade_licitacao) <> 'DISP'
      THEN
         IF    (regs.dat_publicacao IS NULL)
            OR (regs.num_dou_publicacao IS NULL)
            OR (regs.num_pagina_publicacao IS NULL)
            OR (regs.num_secao_publicacao IS NULL)
         THEN
            v_msg_critica :=
                     v_msg_critica
                  || ' - Contrato - As informações dos Dados da Publicação são obrigatórios ';
            v_sucesso := 1;
         END IF;
      END IF;

      IF      (SUBSTR (regs.cnt_cod, 1, 2) = 'TC')
          AND (regs.num_seq_assinatura_2 IS NULL)
      THEN
         v_msg_critica :=
                  v_msg_critica
               || ' - Contrato - A 2ª assinatura é obrigatória para contrato do tipo "TC" !! ';
         v_sucesso := 1;
      END IF;

      IF regs.cnt_data_proposta > regs.cnt_data
      THEN
         v_msg_critica :=
                  v_msg_critica
               || ' - Contrato - A Data da Proposta deve ser menor ou igual a Data do Contrato!! ';
         v_sucesso := 1;
      END IF;

      IF regs.dat_publicacao <= regs.cnt_data
      THEN
         v_msg_critica :=
                  v_msg_critica
               || ' - Contrato - A Data da Publicação deve ser maior que a Data do Contrato!! ';
         v_sucesso := 1;
      END IF;
   END LOOP;

   
-- atualiza a situacao e a area de descrição das criticas
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
                          || ' - Não foram encontrados Erros';
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
                  'Erro ao Atualizar Situação do Contrato e as Criticas '
               || SQLERRM
            );
      END;

      
-- disparar a integração com smartstream para alteração da situação do contrato
      IF  regs.tip_situacao_contrato IN (2, 4) AND v_sucesso = 0
      THEN
         
--
--  Exclui a versão do contrato atual da integração
--
         BEGIN
            ifrbde.prc_exclui_sst_contrato (
               regs.cnt_cod,
               regs.num_versao_contrato
            );
            
--
-- limpa o historico e refaz o saldo no cronograma antes da versão atual
--
            ifrbde.prc_calcula_hst_pag_crono (v_num_seq_contrato);
            
--
--    transmite para o area de integração a ultima versão do contrato
--
            ifrbde.prc_conf_identificacao_u (v_num_seq_contrato);
            ifrbde.prc_conf_objeto_u (v_num_seq_contrato);
            ifrbde.prc_conf_termo_u (v_num_seq_contrato);
            ifrbde.prc_conf_datas_publicacao_u (v_num_seq_contrato);
            
--            ifrbde.prc_conf_datas_u (v_num_seq_contrato);
--            ifrbde.prc_conf_publicacao_u (v_num_seq_contrato);
            ifrbde.prc_conf_participantes_u (v_num_seq_contrato);
            ifrbde.prc_conf_item_ident_u (v_num_seq_contrato);
            
-- revisar pk
            ifrbde.prc_conf_item_acct_u (v_num_seq_contrato);
            ifrbde.prc_conf_item_resumo_u (v_num_seq_contrato);
            
-- revisar pk
            ifrbde.prc_conf_item_cronog_u (v_num_seq_contrato);
            
--
--
-- refaz o saldo no cronograma da versão atual
--
            ifrbde.prc_calcula_hst_pag_crono_vers (v_num_seq_contrato);

            IF v_existe_real = 1
            THEN
               
--
--   executa a rotina quando for enviado para financeira e avisar que necessita de ajuste
--
               ifrbde.prc_gerar_cronograma_realizado (v_num_seq_contrato);

               
--
--   se der erro com o cronograma de realização atualiza a situação do contrato para aguardando ajuste
--
               UPDATE ifrbde.tab_contrato
                  SET tip_situacao_contrato = 9,
                      dsc_critica_contrato =
                               v_msg_critica
                            || ' - Dados do Contrato foram enviados com sucesso, mas verifique os valores do cronograma de realização '
                WHERE num_seq_contrato = v_num_seq_contrato;

               v_situacao_contrato := 9;
            ELSE
               
--
--   se não der erro atualiza a situação do contrato para enviado a financeira
--
               UPDATE ifrbde.tab_contrato
                  SET tip_situacao_contrato = 6,
                      dsc_critica_contrato =
                               TO_CHAR (SYSDATE, 'dd/mm/yyyy hh:mi:ss')
                            || ' - Dados do Contrato foram enviados com sucesso '
                WHERE num_seq_contrato = v_num_seq_contrato;

               v_situacao_contrato := 6;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                     'Erro ao Atualizar Situação do Contrato e as Criticas para Envio ao SmartStream '
                  || SQLERRM
               );
         END;
      END IF;
   END LOOP;
--
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
            'erro na procedure de critica '
         || SQLERRM
      );
END prc_critica_contrato;
/

-- Grants for Procedure
GRANT EXECUTE ON ifrbde.prc_critica_contrato TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_CRITICA_CONTRATO

