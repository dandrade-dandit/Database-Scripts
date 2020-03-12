/* Formatted on 18/04/2005 09:45 (Formatter Plus v4.8.0) */
CREATE OR REPLACE TRIGGER ifrseg.trg_cad_tabela_02_bd
   BEFORE DELETE
   ON ifrseg.cad_tabela
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CURSOR grupo IS
      SELECT cod_grupo
        FROM ifrseg.cad_grupo
       WHERE cod_sistema_grupo = :OLD.cod_sistema_esquema
         AND tip_grupo = 'O';
BEGIN
   FOR grp IN grupo
   LOOP
      DELETE FROM ifrseg.cad_acesso_objeto
            WHERE num_seq_objeto = :OLD.num_seq_tabela
              AND num_cod_grupo_acesso_obj = grp.cod_grupo
              AND cod_sistema_grupo = :OLD.cod_sistema_esquema;
   END LOOP;

   DELETE FROM ifrseg.cad_campo
         WHERE num_seq_tabela_campo = :OLD.num_seq_tabela;

   DELETE FROM ifrseg.cad_formulario
         WHERE num_seq_tabela_formulario = :OLD.num_seq_tabela;
EXCEPTION
   WHEN OTHERS THEN
      raise_application_error (-20100, SQLERRM);
END;
/

