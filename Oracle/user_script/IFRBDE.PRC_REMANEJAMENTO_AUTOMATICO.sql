-- Start of DDL Script for Procedure IFRBDE.PRC_REMANEJAMENTO_AUTOMATICO
-- Generated 18-nov-2004 11:47:41 from IFRBDE@HOMOLOG2

CREATE OR REPLACE 
PROCEDURE prc_remanejamento_automatico (
   p_num_pgose              IN      VARCHAR2,
   p_cod_origem   IN VARCHAR2,
   p_cod_destino  IN VARCHAR2
)
IS
--
   CURSOR x
   IS
      SELECT   rap_cre_cod, rap_rti_cod, rap_pgose, rap_valor, rap_cre_pgi,
               rap_valor_pago, val_saldo_recurso
          FROM ifrbde.tab_rec_aprovado
         WHERE rap_pgose = p_num_pgose
           AND rap_rti_cod = p_cod_origem
           AND val_saldo_recurso > 0
      ORDER BY rap_cre_cod;
--
   CURSOR t (p_cre_cod NUMBER)
   IS
      SELECT rap_cre_cod, rap_rti_cod, rap_pgose, rap_valor, rap_cre_pgi,
             rap_valor_pago, val_remanejado_recebido, val_remanejado_enviado,
             val_saldo_recurso, val_cronogramado
        FROM ifrbde.tab_rec_aprovado
       WHERE rap_pgose = p_num_pgose
         AND rap_cre_cod = p_cre_cod
         AND rap_rti_cod = p_cod_destino;
--
   v_rmj_cod   NUMBER (15);
   v_existe    NUMBER (1);
--

BEGIN
   FOR z IN x
   LOOP
--
      v_existe := 0;
      FOR w IN t (z.rap_cre_cod)
      LOOP
         v_existe := 1;
      END LOOP;
--
      IF v_existe = 0
      THEN
         INSERT INTO ifrbde.tab_rec_aprovado
                     (rap_cre_cod, rap_rti_cod, rap_pgose, rap_valor,
                      rap_cre_pgi)
              VALUES (z.rap_cre_cod,p_cod_destino, z.rap_pgose, 0.00,
                      'F');
      END IF;
--       
      SELECT ifrbde_views.seq_rmj_cod.NEXTVAL
        INTO v_rmj_cod
        FROM DUAL;
--
      INSERT INTO tab_remanejamento
                  (rmj_cod, rmj_ano, rmj_seq_orig, rmj_seq_dest,
                   rmj_valor, rmj_rti_cod_orig, rmj_rti_cod_dest)
           VALUES (v_rmj_cod, z.rap_pgose, z.rap_cre_cod, z.rap_cre_cod,
                   z.val_saldo_recurso, z.rap_rti_cod, p_cod_destino);
--                   
   END LOOP;
END ;
/

-- Grants for Procedure
GRANT EXECUTE ON prc_remanejamento_automatico TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_REMANEJAMENTO_AUTOMATICO

