CREATE OR REPLACE TRIGGER ifrmaximo.trg_indisptotal_after
 AFTER
  INSERT OR DELETE OR UPDATE
 ON ifrmaximo.workorder
REFERENCING NEW AS NEW OLD AS OLD
DECLARE
   v_erro                      VARCHAR2 (200);
   v_sucesso                   NUMBER (1);
   v_wonum                     ifrmaximo.tab_indisponibilidade.wo_wonum%TYPE;
   v_wonum1                    ifrmaximo.tab_indisponibilidade.wo_wonum%TYPE;

BEGIN
--
--
--
   v_sucesso := 0;
   v_erro := '';
--
--
--
   IF NVL (ifrmaximo.pck_variaveis.v_pck_wonum, '0') <> '0'
   THEN
--
      v_wonum :=NVL (ifrmaximo.pck_variaveis.v_pck_wonum, '0');
--
      BEGIN
         SELECT wo_wonum
           INTO v_wonum1
           FROM ifrmaximo.tab_indisponibilidade
          WHERE wo_wonum = v_wonum;

--
         BEGIN
            UPDATE ifrmaximo.tab_indisponibilidade
               SET wo_total = -100
             WHERE wo_wonum = v_wonum;

         EXCEPTION
            WHEN OTHERS
            THEN
               v_erro :=
                        'Não conseguiu atualizar os totais de indisponibilidade '
                     || SQLERRM;
               v_sucesso := 1;
         END;
--
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
--
          INSERT INTO TAB_INDISPONIBILIDADE (WO_WONUM,WO_TOTAL)VALUES(V_WONUM,-100);
--
         WHEN OTHERS
         THEN
            v_erro :=
                     'Não conseguiu localizar A OS na tabela de Indisponibilidade '
                  || SQLERRM;
            v_sucesso := 1;
      END;

      ifrmaximo.pck_variaveis.v_pck_wonum := '0';
   END IF;

--
   IF v_sucesso <> 0
   THEN
      raise_application_error (-20100, v_erro);
   END IF;
END;
/


