/* Formatted on 2004/12/28 12:12 (Formatter Plus v4.5.2) */
CREATE OR REPLACE PROCEDURE ifrbde.prc_liberacao_realizacao_sp (
   p_num_seq_resumo_pag   IN       NUMBER,
   p_cod_tipo_pag_rp      IN       VARCHAR2,
   p_cnt_cre_cod          IN       NUMBER,
   p_cnt_cod              IN       VARCHAR2,
   p_dat_vencimento       IN       DATE,
   p_num_fatura_rp        IN       VARCHAR2,
   p_flg_liberacao        OUT      VARCHAR2
)
IS
   
--
   v_erro            VARCHAR2 (200);
   v_sucesso         NUMBER (1);
   
--
   v_dat_liberacao   DATE;
--
BEGIN
   v_sucesso := 0;
   v_erro := '';

   
--
-- verifica se há liberação da fatura com data de vencimento menor ou igual a hoje
--   
   IF TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy') >=
               TO_DATE (TO_CHAR (p_dat_vencimento, 'dd/mm/yyyy'), 'dd/mm/yyyy')
   THEN
      
--
-- verifica se esta liberado na tabela de liberações de SP
--
      BEGIN
         SELECT dat_liberacao
           INTO v_dat_liberacao
           FROM aux_liberacao_sp
          WHERE cnt_cre_cod_aux = p_cnt_cre_cod
            AND cnt_cod_aux = p_cnt_cod
            AND SUBSTR(trim(num_fatura_sp),1,14) = SUBSTR(trim(p_num_fatura_rp),1,14)
            AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
            AND TO_DATE (TO_CHAR (dat_liberacao, 'dd/mm/yyyy'), 'dd/mm/yyyy') >=
                        TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy')
            AND ROWNUM = 1;

         
--
--      atualiza na liberação a data que o dado foi incluido 
--
/*         UPDATE aux_liberacao_sp
            SET dat_inclusao =
                        TO_DATE (TO_CHAR (SYSDATE, 'dd/mm/yyyy'), 'dd/mm/yyyy')
          WHERE cnt_cre_cod_aux = p_cnt_cre_cod
            AND cnt_cod_aux = p_cnt_cod
            AND num_fatura_sp = p_num_fatura_rp
            AND cod_tipo_pag_rp = p_cod_tipo_pag_rp
            AND TO_DATE (TO_CHAR (dat_liberacao, 'dd/mm/yyyy'), 'dd/mm/yyyy') =
                      TO_DATE (
                         TO_CHAR (v_dat_liberacao, 'dd/mm/yyyy'),
                         'dd/mm/yyyy'
                      );

       
--
--
*/
         p_flg_liberacao := 'T';        
--
--         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_erro :=
                 'Liberação de cadastramento não foi encontrada para esta SP';
            v_sucesso := 1;
            p_flg_liberacao := 'F';
         WHEN OTHERS
         THEN
            v_erro :=
                     'Erro ao verificar de liberação de SP na Inclusão de SP'
                  || SQLERRM;
            v_sucesso := 1;
            p_flg_liberacao := 'F';
      END;
   ELSE
      p_flg_liberacao := 'F';
   END IF;

   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/

-- Grants for Procedure
GRANT EXECUTE ON prc_liberacao_realizacao_sp TO bde_geral
/

