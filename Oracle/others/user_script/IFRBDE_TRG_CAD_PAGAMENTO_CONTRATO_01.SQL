CREATE OR REPLACE TRIGGER TRG_CAD_PAGAMENTO_CONTRATO_01
 BEFORE 
 INSERT OR DELETE OR UPDATE OF COD_RECURSO, COD_TIPO_PAG, DAT_SITUACAO_PAGAMENTO, NUM_ANO_PGOSE, NUM_FATURA_PAGAMENTO, NUM_SEQ_CONTRATO_PAG, NUM_SEQ_PAG_CONTRATO, TIP_SITUACAO_PAGAMENTO, VAL_ACUMULADO, VAL_COTACAO_MOEDA, VAL_FATURADO, VAL_GLOSA, VAL_IMPOSTOS, VAL_IMPOSTO_IRRF, VAL_IMPOSTO_ISS, VAL_IMPOSTO_PASEP, VAL_LIQUIDO_NOTA, VAL_MULTA, VAL_PAGAMENTO, VAL_RETENCAO
 ON CAD_PAGAMENTO_CONTRATO
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE
   v_erro                    VARCHAR2 (200);
   v_sucesso                 NUMBER (1);
   v_carencia                IFRBDE.tab_contrato.cnt_cre_cod%TYPE;
   v_pgose                   IFRBDE.tab_rec_aprovado.rap_pgose%TYPE;
   v_flg_moeda_controle      IFRBDE.cad_resumo_valores.flg_moeda_controle%TYPE;
   v_tip_situacao_contrato   IFRBDE.tab_contrato.tip_situacao_contrato%TYPE;
   v_cod_recurso_res         IFRBDE.cad_resumo_valores.cod_recurso_res%TYPE;
BEGIN
   v_sucesso := 0;
   v_erro := '';

   IF    INSERTING
      OR UPDATING
   THEN

--
-- verifica qual tipo de moeda a do resumo
--
      BEGIN
         SELECT a.flg_moeda_controle, b.tip_situacao_contrato,
                b.cnt_cre_cod
           INTO v_flg_moeda_controle, v_tip_situacao_contrato,
                v_carencia
           FROM IFRBDE.cad_resumo_valores a, IFRBDE.tab_contrato b
          WHERE a.num_seq_resumo = :NEW.num_seq_resumo_contrato
            AND a.num_seq_contrato_res = b.num_seq_contrato;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não foi possível localizar o resumo do contrato ou o contrato'
                  || SQLERRM;
            v_sucesso := 1;
      END;


--

      IF v_tip_situacao_contrato = '5'
      THEN
         v_erro :=
               ' Pagamento Bloqueado , pois o Contrato encontra-se Incompleto - Verifique as criticas do contrato e atualize as informações solicitadas';
         v_sucesso := 1;
      END IF;


--
/*      :NEW.val_liquido_nota :=   :NEW.val_pagamento
                               - (  :NEW.val_glosa
                                  + :NEW.val_retencao
                                  + :NEW.val_multa
                                  + :NEW.val_impostos
                                 );

*/
--

      IF    :NEW.val_pagamento <= 0
         OR :NEW.val_glosa < 0
         OR :NEW.val_retencao < 0
         OR :NEW.val_multa < 0
         OR :NEW.val_impostos < 0
         OR :NEW.val_liquido_nota < 0
      THEN
         v_erro :=
               ' Existe(m) valor(es) invalido(s), Não podem ser negativos e o Liquido da Fatura ou Valor P0 não podem ser iguais a zero !!!!! ';
         v_sucesso := 1;
      END IF;


-- Calcula os valores faturado e acumulado.

      :NEW.val_faturado := 0;
      :NEW.val_acumulado := 0;

      IF :NEW.cod_tipo_pag IN ('P', 'D')
      THEN
         :NEW.val_faturado :=   :NEW.val_liquido_nota
                              + :NEW.val_retencao
                              + :NEW.val_multa
                              + :NEW.val_impostos;
         :NEW.val_acumulado :=   :NEW.val_liquido_nota
                               + :NEW.val_retencao
                               + :NEW.val_multa
                               + :NEW.val_impostos;
      END IF;

      IF :NEW.cod_tipo_pag = 'R'
      THEN
         :NEW.val_faturado :=   :NEW.val_liquido_nota
                              + :NEW.val_retencao
                              + :NEW.val_multa
                              + :NEW.val_impostos;
         :NEW.val_acumulado := 0;
      END IF;

      IF  v_sucesso = 0 AND v_flg_moeda_controle = 2
      THEN
         IF NVL (:NEW.val_cotacao_moeda, 0) = 0
         THEN
            v_erro :=
                  'Quando o resumo de valores é utiliza a moeda secundaria, é obrigatório o preenchimento da Data,Valor, e Tipo de Cotação da Moeda ';
            v_sucesso := 1;
         END IF;
      END IF;


--
-- variaveis para recalculo do faturado na carencia
--
      IF v_sucesso = 0
      THEN
         IFRBDE.pck_variaveis.v_pck_num_seq_carencia := v_carencia;
         IFRBDE.pck_variaveis.v_pck_cod_recurso := :NEW.cod_recurso;
         IFRBDE.pck_variaveis.v_pck_num_ano_pgose := :NEW.num_ano_pgose;
         IFRBDE.pck_variaveis.v_pck_num_seq_resumo_contrato :=
                                                 :NEW.num_seq_resumo_contrato;
      END IF;

--

   END IF;


--
   IF  UPDATING AND v_sucesso = 0
   THEN
      IF  :OLD.cod_tipo_pag <> :NEW.cod_tipo_pag AND v_sucesso = 0
      THEN
         v_erro :=
               'Os Tipos de Pagamento não podem ser modificados - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;

/*      IF  :OLD.num_ano_pgose <> :NEW.num_ano_pgose AND v_sucesso = 0
      THEN
         v_erro :=
               'O Ano do Pgose não pode ser modificado - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF;

      IF  :OLD.cod_recurso <> :NEW.cod_recurso AND v_sucesso = 0
      THEN
         v_erro :=
               'O Recurso não pode ser modificado - Exclua o registro e redigite novamente ';
         v_sucesso := 1;
      END IF; 
*/
   END IF;

   IF  DELETING AND v_sucesso = 0
   THEN

-- verifica qual tipo de moeda a do resumo e qual a carencia

      IF v_sucesso = 0
      THEN
         BEGIN
            SELECT a.cnt_cre_cod, b.flg_moeda_controle
              INTO v_carencia, v_flg_moeda_controle
              FROM IFRBDE.tab_contrato a, IFRBDE.cad_resumo_valores b
             WHERE b.num_seq_resumo = :OLD.num_seq_resumo_contrato
               AND a.num_seq_contrato = b.num_seq_contrato_res;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=    'Não foi possível achar o contrato, verifique - '
                         || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;


--
      IF v_sucesso = 0
      THEN
         -- historico de cronograma pagamento
         BEGIN
            DELETE FROM IFRBDE.hst_pagamento_cronograma
                  WHERE num_seq_pag_contrato_hst = :OLD.num_seq_pag_contrato;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Erro ao excluir o historico de pagamento x cronograma'
                     || SQLERRM;
               v_sucesso := 1;
         END;
      END IF;


--
-- variaveis para recalculo do faturado na carencia
--
      IF v_sucesso = 0
      THEN
         IFRBDE.pck_variaveis.v_pck_num_seq_carencia := v_carencia;
         IFRBDE.pck_variaveis.v_pck_cod_recurso := :OLD.cod_recurso;
         IFRBDE.pck_variaveis.v_pck_num_ano_pgose := :OLD.num_ano_pgose;
         IFRBDE.pck_variaveis.v_pck_num_seq_resumo_contrato :=
                                                 :OLD.num_seq_resumo_contrato;
      END IF;

--
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/
