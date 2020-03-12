-- Start of DDL Script for Procedure IFRBDE.PRC_GRAVAR_USUARIO_CARENCIA
-- Generated 4-abr-2005 10:06:41 from IFRBDE@homolog2

-- Drop the old instance of PRC_GRAVAR_USUARIO_CARENCIA
CREATE OR REPLACE 
PROCEDURE prc_gravar_usuario_carencia (
   v_seq_carencia         IN   NUMBER,
   v_tip_parte_carencia   IN   VARCHAR2
)
IS
   
--
-- objetivo: gravar no arquivo aux_usuario_carencia o numero sequencial da carencia e o tipo da operacao
-- (R) remanejamento e (P) precompromisso
--
-- Historico de modificações
--  Pessoa                Data        Comentarios
-- ---------            ------       -------------------------------------------
-- Carlos lassance      22/03/2005   criação da procedure
--
-- variaveis

   v_sucesso   NUMBER (1);
BEGIN
   v_sucesso := 0;

   
--
   BEGIN
      DELETE FROM ifrbde.aux_usuario_carencia
            WHERE nom_username = USER 
			AND seq_carencia   = v_seq_carencia
			AND tip_operacao   = v_tip_parte_carencia;
   
--
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (
            -20100,
               'erro ao excluir o usuario do arquivo auxiliar do carencia do tipo '
            || v_tip_parte_carencia
            || ' - '
            || SQLERRM
         );
   END;

   BEGIN
      INSERT INTO ifrbde.aux_usuario_carencia
                  (nom_username, seq_carencia, tip_operacao)
           VALUES (USER, v_seq_carencia, v_tip_parte_carencia);
   
--
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (
            -20100,
               'erro ao incluir o usuario do arquivo auxiliar de carencia do tipo '
            || v_tip_parte_carencia
            || ' - '
            || SQLERRM
         );
   END;
--
END prc_gravar_usuario_carencia;
/

-- Grants for Procedure
GRANT EXECUTE ON prc_gravar_usuario_carencia TO bde_geral
/


-- End of DDL Script for Procedure IFRBDE.PRC_GRAVAR_USUARIO_CARENCIA

