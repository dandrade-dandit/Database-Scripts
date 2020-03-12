CREATE INDEX workorder_ndx9 ON workorder
  (
    siteid                          ASC,
    location                        ASC,
    problemcode                     ASC,
    status                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_idx_temp ON workorder
  (
    siteid                          ASC,
    status                          ASC,
    statusdate                      ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE UNIQUE INDEX maxreportdate_idx ON workorder
  (
    wonum                           ASC,
    crewid                          ASC,
    status                          ASC,
    istask                          ASC,
    siteid                          ASC,
    orgid                           ASC,
    reportdate                      ASC,
    actfinish                       ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE UNIQUE INDEX workorder_ndx1 ON workorder
  (
    siteid                          ASC,
    wonum                           ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx10 ON workorder
  (
    parent                          ASC,
    siteid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx11 ON workorder
  (
    wopm7                           ASC,
    siteid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE UNIQUE INDEX workorder_ndx12 ON workorder
  (
    wonum                           ASC,
    istask                          ASC,
    historyflag                     ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx13 ON workorder
  (
    siteid                          ASC,
    istask                          ASC,
    historyflag                     ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx14 ON workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm7                           ASC,
    siteid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx15 ON workorder
  (
    historyflag                     ASC,
    istask                          ASC,
    wopm6                           ASC,
    siteid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx16 ON workorder
  (
    siteid                          ASC,
    crewid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx17 ON workorder
  (
    ldkey                           ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx18 ON workorder
  (
    siteid                          ASC,
    crewid                          ASC,
    status                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx19 ON workorder
  (
    wopm6                           ASC,
    siteid                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx2 ON workorder
  (
    siteid                          ASC,
    status                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx3 ON workorder
  (
    siteid                          ASC,
    historyflag                     ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx4 ON workorder
  (
    siteid                          ASC,
    interid                         ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx5 ON workorder
  (
    siteid                          ASC,
    wfid                            ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx6 ON workorder
  (
    siteid                          ASC,
    respondby                       ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx7 ON workorder
  (
    siteid                          ASC,
    eqnum                           ASC,
    problemcode                     ASC,
    status                          ASC
  )
TABLESPACE TSI_MAXIMO
/

CREATE INDEX workorder_ndx8 ON workorder
  (
    siteid                          ASC,
    jpnum                           ASC
  )
TABLESPACE TSI_MAXIMO
/


CREATE OR REPLACE TRIGGER tr_aux_os_estatistica
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
   v_num                         NUMBER (2) := 0;
   v_count1                      NUMBER (2) := 0;
   v_wonum                       ifrmaximo.aux_os_estatistica.wo_wonum%TYPE
                                                                        := '0';
   v_laborcode                   ifrmaximo.aux_os_estatistica.lab_laborcode%TYPE
                                                                        := '0';
   v_itemnum                     ifrmaximo.aux_os_estatistica.mat_itemnum%TYPE
                                                                        := '0';
   v_toolnum                     ifrmaximo.aux_os_estatistica.to_toolnum%TYPE
                                                                        := '0';
   v_numreg                      ifrmaximo.aux_os_estatistica.wo_num_reg%TYPE
                                                                         := 0;
   v_minreg                      ifrmaximo.aux_os_estatistica.wo_num_reg%TYPE
                                                                         := 0;

   CURSOR cur_lab (
      p_wonum                             workorder.wonum%TYPE
   )
   IS
      SELECT lt.laborcode,
             lt.craft,
             lt.payrate,
             lt.regularhrs,
             lt.gldebitacct,
             lt.glcreditacct,
             lt.linecost,
             lt.outside
        FROM labtrans lt
       WHERE lt.siteid = 'INFRAERO'
         AND lt.refwo = p_wonum;

   CURSOR cur_mat (
      p_wonum                             workorder.wonum%TYPE
   )
   IS
      SELECT mt.itemnum,
             i.description,
             mt.quantity,
             mt.linecost,
             mt.gldebitacct,
             mt.glcreditacct
        FROM matusetrans mt,
             item i
       WHERE mt.siteid = 'INFRAERO'
         AND mt.itemnum = i.itemnum
         AND mt.refwo = p_wonum;

   CURSOR cur_tt (
      p_wonum                             workorder.wonum%TYPE
   )
   IS
      SELECT tt.toolnum,
             t.description,
             tt.toolqty,
             tt.linecost,
             tt.gldebitacct,
             tt.glcreditacct
        FROM tooltrans tt,
             tool t
       WHERE tt.siteid = 'INFRAERO'
         AND tt.toolnum = t.toolnum
         AND tt.refwo = p_wonum;
BEGIN
   IF :NEW.status = 'FECHADA'
   THEN
      SELECT COUNT (
                *
             )
        INTO v_count1
        FROM aux_os_estatistica
       WHERE wo_wonum = :NEW.wonum;

      IF v_count1 > 0
      THEN
         DELETE FROM aux_os_estatistica
         WHERE       wo_wonum = :NEW.wonum;
      END IF;

      v_numreg := v_numreg + 1;

      INSERT INTO aux_os_estatistica
                  (wo_wonum,
                   wo_num_reg,
                   wo_wopm7,
                   wo_worktype,
                   wo_statusdate,
                   wo_eqnum,
                   wo_location,
                   wo_crewid,
                   wo_glaccount,
                   wo_wo1, -- Centro de Custo Executante
                   wo_wo3, -- HH Profissional
                   wo_wo4, -- Custo Profissional
                   wo_wo5, -- Custo Material
                   wo_wo6, -- Custo Ferramenta
                   wo_wo7, -- Custo Servico
                   wo_wo8, -- Custo Total
                   wo_wo10, -- Custo Transporte
                   wo_wo11, -- Custo Diaria
                   wo_wo12, -- Custo Frete
                   wo_wo15, -- Custo Servicos Terceiros
                   wo_wo16 -- Custo Outros
                  )
      VALUES      (:NEW.wonum,
                   v_numreg,
                   :NEW.wopm7,
                   :NEW.worktype,
                   :NEW.statusdate,
                   :NEW.eqnum,
                   :NEW.location,
                   :NEW.crewid,
                   :NEW.glaccount,
                   :NEW.wo1,
                   :NEW.wo3,
                   :NEW.wo4,
                   :NEW.wo5,
                   :NEW.wo6,
                   :NEW.wo7,
                   :NEW.wo8,
                   :NEW.wo10,
                   :NEW.wo11,
                   :NEW.wo12,
                   :NEW.wo15,
                   :NEW.wo16
                  );

      v_numreg := 0;

      FOR carga_lab IN cur_lab (
                          :NEW.wonum
                       )
      LOOP
         v_numreg := v_numreg + 1;

         BEGIN
            SELECT aoe.wo_num_reg,
                   aoe.lab_laborcode
              INTO v_num,
                   v_laborcode
              FROM aux_os_estatistica aoe
             WHERE aoe.wo_wonum = :NEW.wonum
               AND aoe.wo_num_reg = v_numreg;

            BEGIN
               UPDATE aux_os_estatistica
               SET    lab_laborcode = carga_lab.laborcode,
                      lab_craft = carga_lab.craft,
                      lab_payrate = carga_lab.payrate,
                      lab_regularhrs = carga_lab.regularhrs,
                      lab_gldebitacct = carga_lab.gldebitacct,
                      lab_glcreditacct = carga_lab.glcreditacct,
                      lab_linecost = carga_lab.linecost,
                      lab_outside = carga_lab.outside
               WHERE  wo_wonum = :NEW.wonum
                  AND wo_num_reg = v_numreg;
            EXCEPTION
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20100,
                     'ERRO NO UPDATE DO LABTRANS ' || SQLERRM
                  );
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               INSERT INTO aux_os_estatistica
                           (wo_wonum,
                            wo_num_reg,
                            wo_wopm7,
                            wo_worktype,
                            wo_statusdate,
                            wo_eqnum,
                            wo_location,
                            wo_crewid,
                            wo_glaccount,
                            wo_wo1, -- Centro de Custo Executante
                            wo_wo3, -- HH Profissional
                            wo_wo4, -- Custo Profissional
                            wo_wo5, -- Custo Material
                            wo_wo6, -- Custo Ferramenta
                            wo_wo7, -- Custo Servico
                            wo_wo8, -- Custo Total
                            wo_wo10, -- Custo Transporte
                            wo_wo11, -- Custo Diaria
                            wo_wo12, -- Custo Frete
                            wo_wo15, -- Custo Servicos Terceiros
                            wo_wo16, -- Custo Outros
                            lab_laborcode,
                            lab_craft,
                            lab_payrate,
                            lab_regularhrs,
                            lab_gldebitacct,
                            lab_glcreditacct,
                            lab_linecost,
                            lab_outside
                           )
               VALUES      (:NEW.wonum,
                            v_numreg,
                            :NEW.wopm7,
                            :NEW.worktype,
                            :NEW.statusdate,
                            :NEW.eqnum,
                            :NEW.location,
                            :NEW.crewid,
                            :NEW.glaccount,
                            :NEW.wo1,
                            :NEW.wo3,
                            :NEW.wo4,
                            :NEW.wo5,
                            :NEW.wo6,
                            :NEW.wo7,
                            :NEW.wo8,
                            :NEW.wo10,
                            :NEW.wo11,
                            :NEW.wo12,
                            :NEW.wo15,
                            :NEW.wo16,
                            carga_lab.laborcode,
                            carga_lab.craft,
                            carga_lab.payrate,
                            carga_lab.regularhrs,
                            carga_lab.gldebitacct,
                            carga_lab.glcreditacct,
                            carga_lab.linecost,
                            carga_lab.outside
                           );
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20100,
                  'ERRO LABTRANS' || SQLERRM
               );
         END;
      END LOOP;

      v_numreg := 0;

      FOR carga_mat IN cur_mat (
                          :NEW.wonum
                       )
      LOOP
         v_numreg := v_numreg + 1;

         BEGIN
            SELECT aoe.wo_num_reg,
                   aoe.mat_itemnum
              INTO v_num,
                   v_itemnum
              FROM aux_os_estatistica aoe
             WHERE aoe.wo_wonum = :NEW.wonum
               AND aoe.wo_num_reg = v_numreg;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_num := NULL;
               v_laborcode := NULL;
         END;

         IF      (v_num IS NOT NULL)
             AND (v_itemnum IS NULL)
         THEN
            v_numreg := v_numreg;

            UPDATE aux_os_estatistica
            SET    mat_itemnum = carga_mat.itemnum,
                   mat_desc = carga_mat.description,
                   mat_qtd = carga_mat.quantity,
                   mat_linecost = carga_mat.linecost,
                   mat_gldebitacct = carga_mat.gldebitacct,
                   mat_glcreditacct = carga_mat.glcreditacct
            WHERE  wo_wonum = :NEW.wonum
               AND wo_num_reg = v_numreg;
         END IF;

         IF      (v_num IS NULL)
             AND (v_itemnum IS NULL)
         THEN
            INSERT INTO aux_os_estatistica
                        (wo_wonum,
                         wo_num_reg,
                         wo_wopm7,
                         wo_worktype,
                         wo_statusdate,
                         wo_eqnum,
                         wo_location,
                         wo_crewid,
                         wo_glaccount,
                         wo_wo1, -- Centro de Custo Executante
                         wo_wo3, -- HH Profissional
                         wo_wo4, -- Custo Profissional
                         wo_wo5, -- Custo Material
                         wo_wo6, -- Custo Ferramenta
                         wo_wo7, -- Custo Servico
                         wo_wo8, -- Custo Total
                         wo_wo10, -- Custo Transporte
                         wo_wo11, -- Custo Diaria
                         wo_wo12, -- Custo Frete
                         wo_wo15, -- Custo Servicos Terceiros
                         wo_wo16, -- Custo Outros
                         mat_itemnum,
                         mat_desc,
                         mat_qtd,
                         mat_linecost,
                         mat_gldebitacct,
                         mat_glcreditacct
                        )
            VALUES      (:NEW.wonum,
                         v_numreg,
                         :NEW.wopm7,
                         :NEW.worktype,
                         :NEW.statusdate,
                         :NEW.eqnum,
                         :NEW.location,
                         :NEW.crewid,
                         :NEW.glaccount,
                         :NEW.wo1,
                         :NEW.wo3,
                         :NEW.wo4,
                         :NEW.wo5,
                         :NEW.wo6,
                         :NEW.wo7,
                         :NEW.wo8,
                         :NEW.wo10,
                         :NEW.wo11,
                         :NEW.wo12,
                         :NEW.wo15,
                         :NEW.wo16,
                         carga_mat.itemnum,
                         carga_mat.description,
                         carga_mat.quantity,
                         carga_mat.linecost,
                         carga_mat.gldebitacct,
                         carga_mat.glcreditacct
                        );
         END IF;
      END LOOP;

      v_numreg := 0;

      FOR carga_tt IN cur_tt (
                         :NEW.wonum
                      )
      LOOP
         v_numreg := v_numreg + 1;

         BEGIN
            SELECT aoe.wo_num_reg,
                   aoe.to_toolnum
              INTO v_num,
                   v_toolnum
              FROM aux_os_estatistica aoe
             WHERE aoe.wo_wonum = :NEW.wonum
               AND aoe.wo_num_reg = v_numreg;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_num := NULL;
               v_toolnum := NULL;
         END;

         IF      (v_num IS NOT NULL)
             AND (v_toolnum IS NULL)
         THEN
            UPDATE aux_os_estatistica
            SET    to_toolnum = carga_tt.toolnum,
                   to_desc = carga_tt.description,
                   to_toolqty = carga_tt.toolqty,
                   to_linecost = carga_tt.linecost,
                   to_gldebitacct = carga_tt.gldebitacct,
                   to_glcreditacct = carga_tt.glcreditacct
            WHERE  wo_wonum = :NEW.wonum
               AND wo_num_reg = v_numreg;
         END IF;

         IF      (v_num IS NULL)
             AND (v_toolnum IS NULL)
         THEN
            INSERT INTO aux_os_estatistica
                        (wo_wonum,
                         wo_num_reg,
                         wo_wopm7,
                         wo_worktype,
                         wo_statusdate,
                         wo_eqnum,
                         wo_location,
                         wo_crewid,
                         wo_glaccount,
                         wo_wo1, -- Centro de Custo Executante
                         wo_wo3, -- HH Profissional
                         wo_wo4, -- Custo Profissional
                         wo_wo5, -- Custo Material
                         wo_wo6, -- Custo Ferramenta
                         wo_wo7, -- Custo Servico
                         wo_wo8, -- Custo Total
                         wo_wo10, -- Custo Transporte
                         wo_wo11, -- Custo Diaria
                         wo_wo12, -- Custo Frete
                         wo_wo15, -- Custo Servicos Terceiros
                         wo_wo16, -- Custo Outros
                         to_toolnum,
                         to_desc,
                         to_toolqty,
                         to_gldebitacct,
                         to_glcreditacct,
                         to_linecost
                        )
            VALUES      (:NEW.wonum,
                         v_numreg,
                         :NEW.wopm7,
                         :NEW.worktype,
                         :NEW.statusdate,
                         :NEW.eqnum,
                         :NEW.location,
                         :NEW.crewid,
                         :NEW.glaccount,
                         :NEW.wo1,
                         :NEW.wo3,
                         :NEW.wo4,
                         :NEW.wo5,
                         :NEW.wo6,
                         :NEW.wo7,
                         :NEW.wo8,
                         :NEW.wo10,
                         :NEW.wo11,
                         :NEW.wo12,
                         :NEW.wo15,
                         :NEW.wo16,
                         carga_tt.toolnum,
                         carga_tt.description,
                         carga_tt.toolqty,
                         carga_tt.gldebitacct,
                         carga_tt.glcreditacct,
                         carga_tt.linecost
                        );
         END IF;
      END LOOP;
   
--      COMMIT;
   END IF; -- STATUS FECHADA
EXCEPTION
   WHEN OTHERS
   THEN
      raise_application_error (
         -20100,
         'N?O FOI POSSIVEL COMPLETAR A OPERAC?O PARA A OS  ' || SQLERRM
      );
END;
/

CREATE OR REPLACE TRIGGER tr_calc_os1
 BEFORE
  INSERT OR UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   
--Copiando valores ja contabilizados pelo MAXIMO
SELECT SUM(LINECOST) INTO :new.wo5 FROM MATUSETRANS WHERE REFWO = :NEW.WONUM;
   :NEW.wo3 := :NEW.actlabhrs;
   :NEW.wo4 := :NEW.actlabcost;
--   :new.actmatcost:=:new.wo5;
   :NEW.wo6 := :NEW.acttoolcost;
   :NEW.wo7 := :NEW.actservcost;

   
-- Tratando valores extras nulos
   IF :NEW.wo5 IS NULL THEN :NEW.wo5 := 0;
   END IF;
   
   IF :NEW.wo10 IS NULL THEN :NEW.wo10 := 0;
   END IF;

   IF :NEW.wo11 IS NULL THEN :NEW.wo11 := 0;
   END IF;

   IF :NEW.wo12 IS NULL THEN :NEW.wo12 := 0;
   END IF;

   IF :NEW.wo15 IS NULL THEN :NEW.wo15 := 0;
   END IF;

   IF :NEW.wo16 IS NULL THEN :NEW.wo16 := 0;
   END IF;

   
-- Calculando total geral (WO8)
   :NEW.wo8 :=   :NEW.wo4 + :NEW.wo5 + :NEW.wo6 + :NEW.wo7 + :NEW.wo10 + :NEW.wo11 + :NEW.wo12 + :NEW.wo15 + :NEW.wo16; 
END;
/

CREATE OR REPLACE TRIGGER tr_depe_workorder
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF :NEW.CHANGEBY <>'IFRMAXIMO' THEN
     IF SUBSTR(:NEW.CHANGEBY,1,1) = 'I' THEN
        SELECT SUBSTR(USER01,1,4), NULL
        INTO :NEW.WOPM7, :NEW.WOPM6
        FROM IFRMAXIMO.USUARIO
        WHERE USERNUM=:NEW.CHANGEBY;
     END IF;
     IF SUBSTR(:NEW.CHANGEBY,1,1) = 'C' THEN
        SELECT SUBSTR(USER01,1,4), USER01
        INTO :NEW.WOPM7, :NEW.WOPM6
        FROM IFRMAXIMO.USUARIO
        WHERE USERNUM=:NEW.CHANGEBY;
     END IF;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER workorder_t
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE NEXTVAL INTEGER; BEGIN SELECT MAXSEQ.NEXTVAL INTO NEXTVAL FROM DUAL; :NEW.ROWSTAMP := NEXTVAL; END;
/

CREATE OR REPLACE TRIGGER tr_sapios
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   IF (SUBSTR (:NEW.wonum, 1, 2) = 'SA')
   THEN
      IF (:NEW.status IN ('CAN', 'FECHADA'))
      THEN
         BEGIN
            UPDATE integracao.int_maximo_sapios
               SET dsc_defeito = NULL,
                   flg_transmissao = '0',
                   dat_transmissao = NULL,
                   flg_abertura_os = '0',
                   cod_os = NULL,
                   dat_abertura_os = NULL,
                   dat_defeito = NULL,
                   dat_inicio_preventiva = NULL,
                   dat_fim_preventiva = NULL
             WHERE cod_os = :NEW.wonum
               AND cod_dependencia = :NEW.wopm7
               AND cod_equipamento = :NEW.eqnum;
         END;
      END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_status1
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
   v_labor                       labtrans.laborcode%TYPE := '';
   v_count                       NUMBER (5) := 0;
   v_count2                      NUMBER (5) := 0;
   v_count3                      NUMBER (5) := 0;
   V_TESTE                       WORKORDER.status%TYPE :='';
BEGIN
   V_TESTE := TRIM(:OLD.status);
--   IF ((:NEW.status = 'FECHADA') AND (V_TESTE <> 'COMP'))  THEN
--            raise_application_error(-20667, 'A T E N C ? O  -  ANTES DE FECHAR A ''OS'' FAVOR CONCLUI-LA.');
--   END IF;

   IF :NEW.status = 'COMP' THEN
      BEGIN
         SELECT COUNT (itemnum)
           INTO v_count
           FROM invreserve
          WHERE wonum = :NEW.wonum;

         IF v_count <> 0 THEN
            BEGIN
               SELECT COUNT (itemnum)
                 INTO v_count2
                 FROM matusetrans
                WHERE refwo = :NEW.wonum;

               IF v_count2 = 0  THEN
                  BEGIN
                     raise_application_error (-20669,'O Material solicitado para esta OS não foi Aplicado.');
                  END;
               END IF;
            END;
         END IF;

         IF ((LENGTH (TRIM (:NEW.glaccount)) = '') or (LENGTH (TRIM (:NEW.wo1)) = ''))THEN
            raise_application_error (-20661,'Preencha o Centro de Custo do Orgão Beneficiado e Executante.');
         END IF;

         IF :NEW.wo8 <> 0 THEN
            BEGIN
               SELECT COUNT (laborcode)
                 INTO v_count3
                 FROM labtrans
                WHERE refwo = :NEW.wonum;

               IF v_count3 = 0 THEN
                  BEGIN
                     IF (LENGTH (TRIM (:NEW.wo1)) = '') THEN
                        raise_application_error(-20662, 'Preencha o Centro de Custo do Orgão Executante
                                                         ou Associe um Profissional no Utilizado.');
                     END IF;
                  END;
               END IF;
            END;
         END IF;
      END;
   END IF;
END;
/*         raise_application_error (-20660, ':new.status'||:new.status||':old.status'||:OLD.status);
         IF :NEW.status = 'FECHADA'
         THEN
            NULL;
         END IF; */
/

CREATE OR REPLACE TRIGGER tr_sismat1
 BEFORE
  UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
   V_STATUS ORDEM_SERVICO.IN_ABERTA%TYPE :='';
   V_COUNT   NUMBER(5)  :=0;
   CURSOR CAN_OS
        (P_WONUM ORDEM_SERVICO.OS_MAXIMO%TYPE) IS
      SELECT NR_ORDEM_SERVICO,AA_ORDEM_SERVICO, IN_ABERTA
      FROM ORDEM_SERVICO
      WHERE OS_MAXIMO = P_WONUM;
BEGIN
   IF :NEW.STATUS = 'CAN' THEN
      BEGIN
      FOR CANCELAMENTO IN CAN_OS (:NEW.WONUM) LOOP
         IF CANCELAMENTO.IN_ABERTA <> 4 THEN
            BEGIN
               RAISE_APPLICATION_ERROR(-20777,'FAVOR FECHAR A RM VINCULADA A ESTA ORDEM DE SERVICO.');
            END;
         END IF;
      END LOOP;
      END;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_tarefas
 BEFORE
  INSERT
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
BEGIN
  IF :NEW.ISTASK='S' THEN
    :NEW.STATUS:='APRV';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_is_eq_wo
 AFTER
   INSERT OR UPDATE OF eqnum
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
   v_is        ifrmaximo.wosafetyplan.safetyplanid%TYPE   := '';
   v_desc_is   ifrmaximo.wosafetyplan.description%TYPE    := '';
   v_count     NUMBER (5)                                 := 0;
   V_COUNT_ALTERA NUMBER (5)                              := 0;
BEGIN
   IF INSERTING THEN
     BEGIN
        SELECT COUNT (spworkassetid)
          INTO v_count
          FROM spworkasset
         WHERE workequipment = :NEW.eqnum AND siteid = 'INFRAERO';

        IF v_count <> 0
        THEN
           BEGIN
              SELECT safetyplanid
                INTO v_is
                FROM spworkasset
               WHERE workequipment = :NEW.eqnum AND siteid = 'INFRAERO';
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN
                 raise_application_error
                                      (-20641,
                                       'EQUIPAMENTO SEM INSTRUÇÃO DE TRABALHO.'
                                       );
           END;

           BEGIN
              SELECT description
                INTO v_desc_is
                FROM ifrmaximo.safetyplan
               WHERE safetyplanid = v_is AND siteid = 'INFRAERO';
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN
                 raise_application_error
                                       (-20642,
                                        'INSTRUÇÃO DE TRABALHO NÃO CADASTRADA.'
                                       );
           END;
        --   :NEW.WOEQ7 := V_IS;

           INSERT INTO wosafetyplan
                       (wonum,
                        safetyplanid,
                        description,
                        changeby,
                        changedate,
                        orgid,
                        siteid)
                VALUES (:NEW.WONUM,
                        V_IS,
                        V_DESC_IS,
                        :NEW.CHANGEBY,
                        SYSDATE,
                        'INFRAERO',
                        'INFRAERO');
        END IF;
        END;
     END IF;
     
     IF UPDATING THEN
        IF LENGTH(TRIM(:NEW.EQNUM)) = 0 THEN
           DELETE FROM wosafetyplan WHERE WONUM = :NEW.WONUM;
        END IF;
        
        IF LENGTH(TRIM(:NEW.EQNUM)) <> 0 THEN
           BEGIN
             SELECT COUNT (spworkassetid)
               INTO v_count
               FROM spworkasset
              WHERE workequipment = :NEW.eqnum AND siteid = 'INFRAERO';

              IF v_count <> 0 THEN
                 BEGIN
                    SELECT safetyplanid
                      INTO v_is
                      FROM spworkasset
                     WHERE workequipment = :NEW.eqnum AND siteid = 'INFRAERO';
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    raise_application_error (-20641,'EQUIPAMENTO SEM INSTRUÇÃO DE TRABALHO.');
                 END;
              BEGIN
                SELECT description
                  INTO v_desc_is
                  FROM ifrmaximo.safetyplan
                 WHERE safetyplanid = v_is AND siteid = 'INFRAERO';
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 raise_application_error(-20642,'INSTRUÇÃO DE TRABALHO NÃO CADASTRADA.');
              END;

              SELECT COUNT(safetyplanid)
                INTO V_COUNT_ALTERA
                FROM wosafetyplan
              WHERE WONUM = :NEW.WONUM;

              IF V_COUNT_ALTERA <> 0 THEN
                 UPDATE wosafetyplan SET
                           safetyplanid = V_IS,
                           description = V_DESC_IS ,
                           changeby = :NEW.CHANGEBY,
                           changedate = SYSDATE
                 WHERE WONUM = :NEW.WONUM;
              END IF;
              IF V_COUNT_ALTERA = 0 THEN
                 INSERT INTO wosafetyplan
                       (wonum,
                        safetyplanid,
                        description,
                        changeby,
                        changedate,
                        orgid,
                        siteid)
                  VALUES (:NEW.WONUM,
                        V_IS,
                        V_DESC_IS,
                        :NEW.CHANGEBY,
                        SYSDATE,
                        'INFRAERO',
                        'INFRAERO');
                 END IF; -- V_COUNT_ALTERA  -- Se não existir registro na wosafetyplan faz insert
             END IF; -- V_COUNT <> 0 Se existir IS para o Equipamento alterado Verifica se existe na wosafetyplan
             IF V_COUNT = 0 THEN
                DELETE FROM wosafetyplan WHERE WONUM = :NEW.WONUM;
             END IF;  -- Se o Novo Equipamento não Tiver IS associado deleta da wosafetyplan
           END; -- BEGIN
        END IF; -- EQNUM <> 0 -- Se equipamento não for nulo.
     END IF; -- IF UPDATING
END;
/

CREATE OR REPLACE TRIGGER tr_comp
 BEFORE
   UPDATE OF status
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE

BEGIN
   IF :NEW.STATUS = 'COMP' THEN
      IF LENGTH(TRIM(:NEW.GLACCOUNT)) = 0 THEN  -- BENEFICIADO
         raise_application_error(-20670,'CENTRO DE CUSTO DO ÓRGÃO BENEFICIADO NÃO ESTA PREENCHIDO.'); 
      END IF;
     
      IF LENGTH(TRIM(:NEW.WO1)) = 0 THEN   -- EXECUTANTE OS
         raise_application_error(-20671,'CENTRO DE CUSTO DO ÓRGÃO EXECUTANTE NÃO ESTA PREENCHIDO.');       
	  END IF;

      IF LENGTH(TRIM(:NEW.EQNUM)) = 0 THEN   -- VERIFICA SE HÁ EQUIPAMENTO NA ORDEM DE SERVIÇO
         IF LENGTH(TRIM(:NEW.WO20)) = 0 THEN   -- TEMPO DE INDISPONIBILIDADE
            raise_application_error(-20672,'FAVOR INFORMAR O TEMPO DE INDISPONIBILIDADE DO EQUIPAMENTO.');         
         END IF;
      END IF;   
     
	  IF LENGTH(TRIM(:NEW.WO20)) = 0 THEN   -- PROJETO
         raise_application_error(-20673,'O PROJETO NÃO ESTÁ PREENCHIDO.');       	 
      END IF; 
      
   END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_indisptotal_after
 AFTER
  INSERT OR DELETE OR UPDATE
 ON workorder
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
                        'N?o conseguiu atualizar os totais de indisponibilidade '
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
                     'N?o conseguiu localizar A OS na tabela de Indisponibilidade '
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

CREATE OR REPLACE TRIGGER trg_linha_indisponibilidade
 BEFORE
  INSERT OR UPDATE
 ON workorder
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.wo31 IS NULL OR :NEW.wo30 IS NULL
   THEN
      :NEW.wo19 := :NEW.wo19;
   ELSE
      :NEW.wo19 := ((:NEW.wo31 - :NEW.wo30) * 24);
   END IF;
END;
/


GRANT SELECT ON workorder TO c000255
/
GRANT SELECT ON workorder TO c000464
/
GRANT SELECT ON workorder TO c000479
/
GRANT SELECT ON workorder TO c000514
/
GRANT SELECT ON workorder TO c0303700
/
GRANT SELECT ON workorder TO c050235174
/
GRANT SELECT ON workorder TO c0579202
/
GRANT SELECT ON workorder TO c0799300
/
GRANT SELECT ON workorder TO c0883404060
/
GRANT SELECT ON workorder TO c1019201
/
GRANT SELECT ON workorder TO c1530104
/
GRANT SELECT ON workorder TO c1666499
/
GRANT SELECT ON workorder TO c1754504
/
GRANT SELECT ON workorder TO c1796105
/
GRANT SELECT ON workorder TO c1807405
/
GRANT SELECT ON workorder TO c1854005
/
GRANT SELECT ON workorder TO c1876005
/
GRANT SELECT ON workorder TO c1880505
/
GRANT SELECT ON workorder TO c194944968
/
GRANT SELECT ON workorder TO c3238785
/
GRANT SELECT ON workorder TO c43719092
/
GRANT SELECT ON workorder TO c4881595
/
GRANT SELECT ON workorder TO c5053329
/
GRANT SELECT ON workorder TO c514314960
/
GRANT SELECT ON workorder TO c5209102
/
GRANT SELECT ON workorder TO c5388553
/
GRANT SELECT ON workorder TO c5420202
/
GRANT SELECT ON workorder TO c5897204
/
GRANT SELECT ON workorder TO c5905746
/
GRANT SELECT ON workorder TO c5940702
/
GRANT SELECT ON workorder TO c679098843
/
GRANT SELECT ON workorder TO c710467203
/
GRANT SELECT ON workorder TO c768357313
/
GRANT SELECT ON workorder TO caraujoabbe
/
GRANT SELECT ON workorder TO caraujobe
/
GRANT SELECT ON workorder TO catlasgr
/
GRANT SELECT ON workorder TO catlassp
/
GRANT SELECT ON workorder TO ccascardigr
/
GRANT SELECT ON workorder TO cccrgl
/
GRANT SELECT ON workorder TO cchaoverdebe
/
GRANT SELECT ON workorder TO cctmfz
/
GRANT SELECT ON workorder TO cebcmct
/
GRANT SELECT ON workorder TO celshadayct
/
GRANT SELECT ON workorder TO cema01
/
GRANT SELECT ON workorder TO cema02
/
GRANT SELECT ON workorder TO cema03
/
GRANT SELECT ON workorder TO cema04
/
GRANT SELECT ON workorder TO cempressgr
/
GRANT SELECT ON workorder TO cengeletricacr
/
GRANT SELECT ON workorder TO cengeletricact
/
GRANT SELECT ON workorder TO cengeletricafz
/
GRANT SELECT ON workorder TO cengeletricakp
/
GRANT SELECT ON workorder TO cetercgl
/
GRANT SELECT ON workorder TO cexcelgl
/
GRANT SELECT ON workorder TO cgpcf
/
GRANT SELECT ON workorder TO cgutierrezkp
/
GRANT SELECT ON workorder TO cheacoopa
/
GRANT SELECT ON workorder TO chidelmarf
/
GRANT SELECT ON workorder TO ciacitgr
/
GRANT SELECT ON workorder TO cicsupplygl
/
GRANT SELECT ON workorder TO cicsupplyrj
/
GRANT SELECT ON workorder TO cinterwaycg
/
GRANT SELECT ON workorder TO cinterwaygr
/
GRANT SELECT ON workorder TO cjlhsp
/
GRANT SELECT ON workorder TO cmarinseg
/
GRANT SELECT ON workorder TO cmpe014gr
/
GRANT SELECT ON workorder TO cmpe024sp
/
GRANT SELECT ON workorder TO cmpe033gr
/
GRANT SELECT ON workorder TO cmpe041gr
/
GRANT SELECT ON workorder TO cmpe069sp
/
GRANT SELECT ON workorder TO cmpe071fgr
/
GRANT SELECT ON workorder TO cmpe071gr
/
GRANT SELECT ON workorder TO cmpe072gr
/
GRANT SELECT ON workorder TO cmpeeg
/
GRANT SELECT ON workorder TO cmpegl
/
GRANT SELECT ON workorder TO cmpegr
/
GRANT SELECT ON workorder TO cmpekp
/
GRANT SELECT ON workorder TO cmperj
/
GRANT SELECT ON workorder TO cntkgr
/
GRANT SELECT ON workorder TO cntksp
/
GRANT SELECT ON workorder TO cotisgr
/
GRANT SELECT ON workorder TO cpa004261416
/
GRANT SELECT ON workorder TO cpa067340834
/
GRANT SELECT ON workorder TO cpa086415534
/
GRANT SELECT ON workorder TO cparanact
/
GRANT SELECT ON workorder TO cpontualfz
/
GRANT SELECT ON workorder TO cproclimasv
/
GRANT SELECT ON workorder TO csaitpa
/
GRANT SELECT ON workorder TO csalgadocf
/
GRANT SELECT ON workorder TO cschefferct
/
GRANT SELECT ON workorder TO cservtecfz
/
GRANT SELECT ON workorder TO cservteckp
/
GRANT SELECT ON workorder TO cservtecsp
/
GRANT SELECT ON workorder TO csgekp
/
GRANT SELECT ON workorder TO csheffergr
/
GRANT SELECT ON workorder TO csipecgr
/
GRANT SELECT ON workorder TO csistemagr
/
GRANT SELECT ON workorder TO csm21gl
/
GRANT SELECT ON workorder TO csociplanct
/
GRANT SELECT ON workorder TO csupplygr
/
GRANT SELECT ON workorder TO cteamgl
/
GRANT SELECT ON workorder TO ctecnengegl
/
GRANT SELECT ON workorder TO ctecnytcf
/
GRANT SELECT ON workorder TO ctecnytpa
/
GRANT SELECT ON workorder TO ctecnytsv
/
GRANT SELECT ON workorder TO cteldatact
/
GRANT SELECT ON workorder TO cthermarbe
/
GRANT SELECT ON workorder TO cthermareg
/
GRANT DELETE ON workorder TO ctis837
/
GRANT SELECT ON workorder TO ctis837
/
GRANT UPDATE ON workorder TO ctis837
/
GRANT SELECT ON workorder TO ctranspolixgr
/
GRANT SELECT ON workorder TO cultratecgr
/
GRANT SELECT ON workorder TO cuniaofz
/
GRANT SELECT ON workorder TO cviateccf
/
GRANT SELECT ON workorder TO cviatecgr
/
GRANT SELECT ON workorder TO cviateckp
/
GRANT SELECT ON workorder TO cviatecmo
/
GRANT SELECT ON workorder TO cviatecsv
/
GRANT DELETE ON workorder TO deflt
/
GRANT SELECT ON workorder TO deflt
/
GRANT UPDATE ON workorder TO deflt
/
GRANT SELECT ON workorder TO dema01
/
GRANT SELECT ON workorder TO dema02
/
GRANT SELECT ON workorder TO dema03
/
GRANT SELECT ON workorder TO dema04
/
GRANT SELECT ON workorder TO i0000000
/
GRANT SELECT ON workorder TO i0001978
/
GRANT SELECT ON workorder TO i0116268
/
GRANT SELECT ON workorder TO i0137551
/
GRANT SELECT ON workorder TO i0154356
/
GRANT SELECT ON workorder TO i0160658
/
GRANT SELECT ON workorder TO i0169141
/
GRANT SELECT ON workorder TO i0173155
/
GRANT SELECT ON workorder TO i0174152
/
GRANT SELECT ON workorder TO i0201478
/
GRANT SELECT ON workorder TO i0208947
/
GRANT SELECT ON workorder TO i0209650
/
GRANT SELECT ON workorder TO i0240661
/
GRANT SELECT ON workorder TO i0515643
/
GRANT SELECT ON workorder TO i0534638
/
GRANT SELECT ON workorder TO i0539917
/
GRANT SELECT ON workorder TO i0566914
/
GRANT SELECT ON workorder TO i0577613
/
GRANT SELECT ON workorder TO i0580042
/
GRANT SELECT ON workorder TO i0583523
/
GRANT SELECT ON workorder TO i0590332
/
GRANT SELECT ON workorder TO i0596020
/
GRANT SELECT ON workorder TO i0598602
/
GRANT SELECT ON workorder TO i0600069
/
GRANT SELECT ON workorder TO i0600853
/
GRANT SELECT ON workorder TO i0602357
/
GRANT SELECT ON workorder TO i0603648
/
GRANT SELECT ON workorder TO i0605740
/
GRANT SELECT ON workorder TO i0607440
/
GRANT SELECT ON workorder TO i0608045
/
GRANT SELECT ON workorder TO i0608241
/
GRANT SELECT ON workorder TO i0608339
/
GRANT SELECT ON workorder TO i0608535
/
GRANT SELECT ON workorder TO i0608927
/
GRANT SELECT ON workorder TO i0609140
/
GRANT SELECT ON workorder TO i0609336
/
GRANT SELECT ON workorder TO i0610065
/
GRANT SELECT ON workorder TO i0611846
/
GRANT SELECT ON workorder TO i0613448
/
GRANT SELECT ON workorder TO i0618727
/
GRANT SELECT ON workorder TO i0619626
/
GRANT SELECT ON workorder TO i0619822
/
GRANT SELECT ON workorder TO i0622643
/
GRANT SELECT ON workorder TO i0623346
/
GRANT SELECT ON workorder TO i0623444
/
GRANT SELECT ON workorder TO i0624147
/
GRANT SELECT ON workorder TO i0624441
/
GRANT SELECT ON workorder TO i0627138
/
GRANT SELECT ON workorder TO i0627726
/
GRANT SELECT ON workorder TO i0632835
/
GRANT SELECT ON workorder TO i0643730
/
GRANT SELECT ON workorder TO i0644041
/
GRANT SELECT ON workorder TO i0645136
/
GRANT SELECT ON workorder TO i0646329
/
GRANT SELECT ON workorder TO i0647620
/
GRANT SELECT ON workorder TO i0655034
/
GRANT SELECT ON workorder TO i0661826
/
GRANT SELECT ON workorder TO i0661924
/
GRANT SELECT ON workorder TO i0668609
/
GRANT SELECT ON workorder TO i0669018
/
GRANT SELECT ON workorder TO i0670629
/
GRANT SELECT ON workorder TO i0672133
/
GRANT SELECT ON workorder TO i0677118
/
GRANT SELECT ON workorder TO i0677216
/
GRANT SELECT ON workorder TO i0681524
/
GRANT SELECT ON workorder TO i0687997
/
GRANT SELECT ON workorder TO i0689893
/
GRANT SELECT ON workorder TO i0698598
/
GRANT SELECT ON workorder TO i0700358
/
GRANT SELECT ON workorder TO i0707925
/
GRANT SELECT ON workorder TO i0713835
/
GRANT SELECT ON workorder TO i0718428
/
GRANT SELECT ON workorder TO i0721249
/
GRANT SELECT ON workorder TO i0721347
/
GRANT SELECT ON workorder TO i0727427
/
GRANT SELECT ON workorder TO i0745229
/
GRANT SELECT ON workorder TO i0748024
/
GRANT SELECT ON workorder TO i0748808
/
GRANT SELECT ON workorder TO i0751237
/
GRANT SELECT ON workorder TO i0751629
/
GRANT SELECT ON workorder TO i0753525
/
GRANT SELECT ON workorder TO i0757513
/
GRANT SELECT ON workorder TO i0759801
/
GRANT SELECT ON workorder TO i0765123
/
GRANT SELECT ON workorder TO i0765417
/
GRANT SELECT ON workorder TO i0795896
/
GRANT SELECT ON workorder TO i0796108
/
GRANT SELECT ON workorder TO i0797890
/
GRANT SELECT ON workorder TO i0799492
/
GRANT SELECT ON workorder TO i0805240
/
GRANT SELECT ON workorder TO i0805436
/
GRANT SELECT ON workorder TO i0806139
/
GRANT SELECT ON workorder TO i0808819
/
GRANT SELECT ON workorder TO i0808917
/
GRANT SELECT ON workorder TO i0809130
/
GRANT SELECT ON workorder TO i0809228
/
GRANT SELECT ON workorder TO i0809326
/
GRANT SELECT ON workorder TO i0809522
/
GRANT SELECT ON workorder TO i0809816
/
GRANT SELECT ON workorder TO i0814239
/
GRANT SELECT ON workorder TO i0814337
/
GRANT SELECT ON workorder TO i0835522
/
GRANT SELECT ON workorder TO i0839020
/
GRANT SELECT ON workorder TO i1004081
/
GRANT SELECT ON workorder TO i1007268
/
GRANT SELECT ON workorder TO i1007464
/
GRANT SELECT ON workorder TO i1014371
/
GRANT SELECT ON workorder TO i1016071
/
GRANT SELECT ON workorder TO i1019356
/
GRANT SELECT ON workorder TO i1019454
/
GRANT SELECT ON workorder TO i1019650
/
GRANT SELECT ON workorder TO i1019944
/
GRANT SELECT ON workorder TO i1021082
/
GRANT SELECT ON workorder TO i1022961
/
GRANT SELECT ON workorder TO i1025756
/
GRANT SELECT ON workorder TO i1038743
/
GRANT SELECT ON workorder TO i1039446
/
GRANT SELECT ON workorder TO i1041466
/
GRANT SELECT ON workorder TO i1043264
/
GRANT SELECT ON workorder TO i1045356
/
GRANT SELECT ON workorder TO i1052655
/
GRANT SELECT ON workorder TO i1053260
/
GRANT SELECT ON workorder TO i1061066
/
GRANT SELECT ON workorder TO i1062357
/
GRANT SELECT ON workorder TO i1066541
/
GRANT SELECT ON workorder TO i1067930
/
GRANT SELECT ON workorder TO i1069434
/
GRANT SELECT ON workorder TO i1070163
/
GRANT SELECT ON workorder TO i1071356
/
GRANT SELECT ON workorder TO i1071748
/
GRANT SELECT ON workorder TO i1072353
/
GRANT SELECT ON workorder TO i1073840
/
GRANT SELECT ON workorder TO i1073938
/
GRANT SELECT ON workorder TO i1077044
/
GRANT SELECT ON workorder TO i1079822
/
GRANT SELECT ON workorder TO i1083836
/
GRANT SELECT ON workorder TO i1086729
/
GRANT SELECT ON workorder TO i1087138
/
GRANT SELECT ON workorder TO i1088429
/
GRANT SELECT ON workorder TO i1414939
/
GRANT SELECT ON workorder TO i1455724
/
GRANT SELECT ON workorder TO i1460637
/
GRANT SELECT ON workorder TO i1460833
/
GRANT SELECT ON workorder TO i1472921
/
GRANT SELECT ON workorder TO i1478217
/
GRANT SELECT ON workorder TO i1479999
/
GRANT SELECT ON workorder TO i1523345
/
GRANT SELECT ON workorder TO i1523443
/
GRANT SELECT ON workorder TO i1527137
/
GRANT SELECT ON workorder TO i1529915
/
GRANT SELECT ON workorder TO i1532050
/
GRANT SELECT ON workorder TO i1537231
/
GRANT SELECT ON workorder TO i1553823
/
GRANT SELECT ON workorder TO i1554232
/
GRANT SELECT ON workorder TO i1555719
/
GRANT SELECT ON workorder TO i1555817
/
GRANT SELECT ON workorder TO i1556128
/
GRANT SELECT ON workorder TO i1556324
/
GRANT SELECT ON workorder TO i1556422
/
GRANT SELECT ON workorder TO i1558416
/
GRANT SELECT ON workorder TO i1558514
/
GRANT SELECT ON workorder TO i1702640
/
GRANT SELECT ON workorder TO i1902140
/
GRANT SELECT ON workorder TO i1929209
/
GRANT SELECT ON workorder TO i1930330
/
GRANT SELECT ON workorder TO i1936410
/
GRANT SELECT ON workorder TO i1937603
/
GRANT SELECT ON workorder TO i1940032
/
GRANT SELECT ON workorder TO i1940816
/
GRANT SELECT ON workorder TO i1941519
/
GRANT SELECT ON workorder TO i1942712
/
GRANT SELECT ON workorder TO i1943121
/
GRANT SELECT ON workorder TO i1943611
/
GRANT SELECT ON workorder TO i1944118
/
GRANT SELECT ON workorder TO i1944902
/
GRANT SELECT ON workorder TO i1946897
/
GRANT SELECT ON workorder TO i1947698
/
GRANT SELECT ON workorder TO i1947992
/
GRANT SELECT ON workorder TO i1948008
/
GRANT SELECT ON workorder TO i1948695
/
GRANT SELECT ON workorder TO i1949005
/
GRANT SELECT ON workorder TO i1949496
/
GRANT SELECT ON workorder TO i1950420
/
GRANT SELECT ON workorder TO i1950518
/
GRANT SELECT ON workorder TO i1951123
/
GRANT SELECT ON workorder TO i2227636
/
GRANT SELECT ON workorder TO i2316736
/
GRANT SELECT ON workorder TO i2319237
/
GRANT SELECT ON workorder TO i2320456
/
GRANT SELECT ON workorder TO i2323251
/
GRANT SELECT ON workorder TO i2349225
/
GRANT SELECT ON workorder TO i2356622
/
GRANT SELECT ON workorder TO i2369707
/
GRANT SELECT ON workorder TO i2371237
/
GRANT SELECT ON workorder TO i2398404
/
GRANT SELECT ON workorder TO i2402061
/
GRANT SELECT ON workorder TO i2403735
/
GRANT SELECT ON workorder TO i2406735
/
GRANT SELECT ON workorder TO i2604535
/
GRANT SELECT ON workorder TO i2611050
/
GRANT SELECT ON workorder TO i2614335
/
GRANT SELECT ON workorder TO i2617718
/
GRANT SELECT ON workorder TO i2620833
/
GRANT SELECT ON workorder TO i2621242
/
GRANT SELECT ON workorder TO i2626031
/
GRANT SELECT ON workorder TO i2627028
/
GRANT SELECT ON workorder TO i2627126
/
GRANT SELECT ON workorder TO i2627616
/
GRANT SELECT ON workorder TO i2628123
/
GRANT SELECT ON workorder TO i2628417
/
GRANT SELECT ON workorder TO i2629806
/
GRANT SELECT ON workorder TO i2630731
/
GRANT SELECT ON workorder TO i2631238
/
GRANT SELECT ON workorder TO i2632725
/
GRANT SELECT ON workorder TO i2633330
/
GRANT SELECT ON workorder TO i2633722
/
GRANT SELECT ON workorder TO i2633820
/
GRANT SELECT ON workorder TO i2635128
/
GRANT SELECT ON workorder TO i2905125
/
GRANT SELECT ON workorder TO i2908508
/
GRANT SELECT ON workorder TO i3028637
/
GRANT SELECT ON workorder TO i3236727
/
GRANT SELECT ON workorder TO i3243830
/
GRANT SELECT ON workorder TO i3246037
/
GRANT SELECT ON workorder TO i3261044
/
GRANT SELECT ON workorder TO i3264035
/
GRANT SELECT ON workorder TO i3265228
/
GRANT SELECT ON workorder TO i3272037
/
GRANT SELECT ON workorder TO i3277904
/
GRANT SELECT ON workorder TO i3294317
/
GRANT SELECT ON workorder TO i3294807
/
GRANT SELECT ON workorder TO i3297995
/
GRANT SELECT ON workorder TO i3298109
/
GRANT SELECT ON workorder TO i3299499
/
GRANT SELECT ON workorder TO i3317041
/
GRANT SELECT ON workorder TO i3326824
/
GRANT SELECT ON workorder TO i3327429
/
GRANT SELECT ON workorder TO i3330446
/
GRANT SELECT ON workorder TO i3331443
/
GRANT SELECT ON workorder TO i3405928
/
GRANT SELECT ON workorder TO i3412639
/
GRANT SELECT ON workorder TO i3412737
/
GRANT SELECT ON workorder TO i3617026
/
GRANT SELECT ON workorder TO i3618611
/
GRANT SELECT ON workorder TO i3624227
/
GRANT SELECT ON workorder TO i3625616
/
GRANT SELECT ON workorder TO i3628803
/
GRANT SELECT ON workorder TO i3930906
/
GRANT SELECT ON workorder TO i3932018
/
GRANT SELECT ON workorder TO i3932999
/
GRANT SELECT ON workorder TO i3937788
/
GRANT SELECT ON workorder TO i3939782
/
GRANT SELECT ON workorder TO i3940314
/
GRANT SELECT ON workorder TO i3941703
/
GRANT SELECT ON workorder TO i3942112
/
GRANT SELECT ON workorder TO i3943109
/
GRANT SELECT ON workorder TO i3943403
/
GRANT SELECT ON workorder TO i3943698
/
GRANT SELECT ON workorder TO i3944989
/
GRANT SELECT ON workorder TO i3946787
/
GRANT SELECT ON workorder TO i3947686
/
GRANT SELECT ON workorder TO i3949386
/
GRANT SELECT ON workorder TO i3949778
/
GRANT SELECT ON workorder TO i4102554
/
GRANT SELECT ON workorder TO i4103551
/
GRANT SELECT ON workorder TO i4104254
/
GRANT SELECT ON workorder TO i4104450
/
GRANT SELECT ON workorder TO i4105545
/
GRANT SELECT ON workorder TO i4108046
/
GRANT SELECT ON workorder TO i4110654
/
GRANT SELECT ON workorder TO i4113057
/
GRANT SELECT ON workorder TO i4117437
/
GRANT SELECT ON workorder TO i4118924
/
GRANT SELECT ON workorder TO i4121941
/
GRANT SELECT ON workorder TO i4123543
/
GRANT SELECT ON workorder TO i4123837
/
GRANT SELECT ON workorder TO i4124050
/
GRANT SELECT ON workorder TO i4125929
/
GRANT SELECT ON workorder TO i4126044
/
GRANT SELECT ON workorder TO i4128038
/
GRANT SELECT ON workorder TO i4128626
/
GRANT SELECT ON workorder TO i4129525
/
GRANT SELECT ON workorder TO i4134732
/
GRANT SELECT ON workorder TO i4141737
/
GRANT SELECT ON workorder TO i4145823
/
GRANT SELECT ON workorder TO i4149811
/
GRANT SELECT ON workorder TO i4155231
/
GRANT SELECT ON workorder TO i4155721
/
GRANT SELECT ON workorder TO i4157715
/
GRANT SELECT ON workorder TO i4158810
/
GRANT SELECT ON workorder TO i4161435
/
GRANT SELECT ON workorder TO i4161533
/
GRANT SELECT ON workorder TO i4163723
/
GRANT SELECT ON workorder TO i4166420
/
GRANT SELECT ON workorder TO i4166714
/
GRANT SELECT ON workorder TO i4166812
/
GRANT SELECT ON workorder TO i4167123
/
GRANT SELECT ON workorder TO i4172036
/
GRANT SELECT ON workorder TO i4178116
/
GRANT SELECT ON workorder TO i4181917
/
GRANT SELECT ON workorder TO i4182031
/
GRANT SELECT ON workorder TO i4182032
/
GRANT SELECT ON workorder TO i4183029
/
GRANT SELECT ON workorder TO i4186412
/
GRANT SELECT ON workorder TO i4187115
/
GRANT SELECT ON workorder TO i4187998
/
GRANT SELECT ON workorder TO i4189305
/
GRANT SELECT ON workorder TO i4191129
/
GRANT SELECT ON workorder TO i4193319
/
GRANT SELECT ON workorder TO i4194120
/
GRANT SELECT ON workorder TO i4194414
/
GRANT SELECT ON workorder TO i4199498
/
GRANT SELECT ON workorder TO i4221446
/
GRANT SELECT ON workorder TO i4223440
/
GRANT SELECT ON workorder TO i4231736
/
GRANT SELECT ON workorder TO i4253722
/
GRANT SELECT ON workorder TO i4256223
/
GRANT SELECT ON workorder TO i4256321
/
GRANT SELECT ON workorder TO i4256811
/
GRANT SELECT ON workorder TO i4258413
/
GRANT SELECT ON workorder TO i4259116
/
GRANT SELECT ON workorder TO i4259704
/
GRANT SELECT ON workorder TO i4508320
/
GRANT SELECT ON workorder TO i4536314
/
GRANT SELECT ON workorder TO i4538014
/
GRANT SELECT ON workorder TO i4538995
/
GRANT SELECT ON workorder TO i4540230
/
GRANT SELECT ON workorder TO i4543123
/
GRANT SELECT ON workorder TO i4543221
/
GRANT SELECT ON workorder TO i4548697
/
GRANT SELECT ON workorder TO i4549988
/
GRANT SELECT ON workorder TO i4701331
/
GRANT SELECT ON workorder TO i4711229
/
GRANT SELECT ON workorder TO i4717701
/
GRANT SELECT ON workorder TO i4719598
/
GRANT SELECT ON workorder TO i4719696
/
GRANT SELECT ON workorder TO i4720522
/
GRANT SELECT ON workorder TO i4726406
/
GRANT SELECT ON workorder TO i4727109
/
GRANT SELECT ON workorder TO i4727305
/
GRANT SELECT ON workorder TO i4733411
/
GRANT SELECT ON workorder TO i4734310
/
GRANT SELECT ON workorder TO i4734506
/
GRANT SELECT ON workorder TO i4734702
/
GRANT SELECT ON workorder TO i4735798
/
GRANT SELECT ON workorder TO i4735896
/
GRANT SELECT ON workorder TO i4735994
/
GRANT SELECT ON workorder TO i4737596
/
GRANT SELECT ON workorder TO i4738397
/
GRANT SELECT ON workorder TO i4744306
/
GRANT SELECT ON workorder TO i4746399
/
GRANT SELECT ON workorder TO i4747494
/
GRANT SELECT ON workorder TO i4750804
/
GRANT SELECT ON workorder TO i4751703
/
GRANT SELECT ON workorder TO i4912216
/
GRANT SELECT ON workorder TO i6001256
/
GRANT SELECT ON workorder TO i6002939
/
GRANT SELECT ON workorder TO i6003250
/
GRANT SELECT ON workorder TO i6007336
/
GRANT SELECT ON workorder TO i6009526
/
GRANT SELECT ON workorder TO i6011154
/
GRANT SELECT ON workorder TO i6011252
/
GRANT SELECT ON workorder TO i6011546
/
GRANT SELECT ON workorder TO i6011840
/
GRANT SELECT ON workorder TO i6012151
/
GRANT SELECT ON workorder TO i6013442
/
GRANT SELECT ON workorder TO i6013932
/
GRANT SELECT ON workorder TO i6016825
/
GRANT SELECT ON workorder TO i6018721
/
GRANT SELECT ON workorder TO i6018819
/
GRANT SELECT ON workorder TO i6020447
/
GRANT SELECT ON workorder TO i6020839
/
GRANT SELECT ON workorder TO i6021640
/
GRANT SELECT ON workorder TO i6024043
/
GRANT SELECT ON workorder TO i6026527
/
GRANT SELECT ON workorder TO i6027524
/
GRANT SELECT ON workorder TO i6029714
/
GRANT SELECT ON workorder TO i6032535
/
GRANT SELECT ON workorder TO i6032633
/
GRANT SELECT ON workorder TO i6033336
/
GRANT SELECT ON workorder TO i6033532
/
GRANT SELECT ON workorder TO i6034921
/
GRANT SELECT ON workorder TO i6035722
/
GRANT SELECT ON workorder TO i6037030
/
GRANT SELECT ON workorder TO i6037814
/
GRANT SELECT ON workorder TO i6040145
/
GRANT SELECT ON workorder TO i6040439
/
GRANT SELECT ON workorder TO i6040635
/
GRANT SELECT ON workorder TO i6041142
/
GRANT SELECT ON workorder TO i6041338
/
GRANT SELECT ON workorder TO i6042139
/
GRANT SELECT ON workorder TO i6042923
/
GRANT SELECT ON workorder TO i6045032
/
GRANT SELECT ON workorder TO i6045130
/
GRANT SELECT ON workorder TO i6046519
/
GRANT SELECT ON workorder TO i6048709
/
GRANT SELECT ON workorder TO i6048807
/
GRANT SELECT ON workorder TO i6049412
/
GRANT SELECT ON workorder TO i6049510
/
GRANT SELECT ON workorder TO i6049608
/
GRANT SELECT ON workorder TO i6049706
/
GRANT SELECT ON workorder TO i6050043
/
GRANT SELECT ON workorder TO i6050435
/
GRANT SELECT ON workorder TO i6051432
/
GRANT SELECT ON workorder TO i6051922
/
GRANT SELECT ON workorder TO i6052135
/
GRANT SELECT ON workorder TO i6052429
/
GRANT SELECT ON workorder TO i6052527
/
GRANT SELECT ON workorder TO i6052625
/
GRANT SELECT ON workorder TO i614837
/
GRANT SELECT ON workorder TO i6342418
/
GRANT SELECT ON workorder TO i6361413
/
GRANT SELECT ON workorder TO i6368883
/
GRANT SELECT ON workorder TO i6379190
/
GRANT SELECT ON workorder TO i6385001
/
GRANT SELECT ON workorder TO i6634205
/
GRANT SELECT ON workorder TO i6637491
/
GRANT SELECT ON workorder TO i6660107
/
GRANT SELECT ON workorder TO i6671983
/
GRANT SELECT ON workorder TO i6697957
/
GRANT SELECT ON workorder TO i6705896
/
GRANT SELECT ON workorder TO i6711315
/
GRANT SELECT ON workorder TO i6715401
/
GRANT SELECT ON workorder TO i6722112
/
GRANT SELECT ON workorder TO i6752689
/
GRANT SELECT ON workorder TO i6767474
/
GRANT SELECT ON workorder TO i6768079
/
GRANT SELECT ON workorder TO i6768961
/
GRANT SELECT ON workorder TO i6774479
/
GRANT SELECT ON workorder TO i6779170
/
GRANT SELECT ON workorder TO i6780585
/
GRANT SELECT ON workorder TO i6782579
/
GRANT SELECT ON workorder TO i6784083
/
GRANT SELECT ON workorder TO i6811997
/
GRANT SELECT ON workorder TO i6812307
/
GRANT SELECT ON workorder TO i7001936
/
GRANT SELECT ON workorder TO i7204525
/
GRANT SELECT ON workorder TO i7408209
/
GRANT SELECT ON workorder TO i8104720
/
GRANT SELECT ON workorder TO i8105325
/
GRANT SELECT ON workorder TO i8306410
/
GRANT SELECT ON workorder TO i8803885
/
GRANT SELECT ON workorder TO i8809279
/
GRANT SELECT ON workorder TO i9003820
/
GRANT SELECT ON workorder TO i9006027
/
GRANT SELECT ON workorder TO i9006615
/
GRANT SELECT ON workorder TO i9008021
/
GRANT SELECT ON workorder TO i9008217
/
GRANT SELECT ON workorder TO i9008511
/
GRANT SELECT ON workorder TO i9008805
/
GRANT SELECT ON workorder TO i9010923
/
GRANT SELECT ON workorder TO i9011038
/
GRANT SELECT ON workorder TO i9011920
/
GRANT SELECT ON workorder TO i9023910
/
GRANT SELECT ON workorder TO i9024809
/
GRANT SELECT ON workorder TO i9025414
/
GRANT SELECT ON workorder TO i9025512
/
GRANT SELECT ON workorder TO i9026215
/
GRANT SELECT ON workorder TO i9026509
/
GRANT SELECT ON workorder TO i9027016
/
GRANT SELECT ON workorder TO i9027506
/
GRANT SELECT ON workorder TO i9028896
/
GRANT SELECT ON workorder TO i9028994
/
GRANT SELECT ON workorder TO i9029599
/
GRANT SELECT ON workorder TO i9029991
/
GRANT SELECT ON workorder TO i9033416
/
GRANT SELECT ON workorder TO i9033514
/
GRANT SELECT ON workorder TO i9034021
/
GRANT SELECT ON workorder TO i9034707
/
GRANT SELECT ON workorder TO i9034805
/
GRANT SELECT ON workorder TO i9035508
/
GRANT SELECT ON workorder TO i9035606
/
GRANT SELECT ON workorder TO i9036113
/
GRANT SELECT ON workorder TO i9037012
/
GRANT SELECT ON workorder TO i9037306
/
GRANT SELECT ON workorder TO i9038794
/
GRANT SELECT ON workorder TO i9038892
/
GRANT SELECT ON workorder TO i9039399
/
GRANT SELECT ON workorder TO i9039889
/
GRANT SELECT ON workorder TO i9040323
/
GRANT SELECT ON workorder TO i9040421
/
GRANT SELECT ON workorder TO i9040715
/
GRANT SELECT ON workorder TO i9042415
/
GRANT SELECT ON workorder TO i9042709
/
GRANT SELECT ON workorder TO i9042807
/
GRANT SELECT ON workorder TO i9046305
/
GRANT SELECT ON workorder TO i9047106
/
GRANT SELECT ON workorder TO i9051708
/
GRANT SELECT ON workorder TO i9052803
/
GRANT SELECT ON workorder TO i9053899
/
GRANT SELECT ON workorder TO i9055206
/
GRANT SELECT ON workorder TO i9055304
/
GRANT SELECT ON workorder TO i9055991
/
GRANT SELECT ON workorder TO i9056105
/
GRANT SELECT ON workorder TO i9062603
/
GRANT SELECT ON workorder TO i9068586
/
GRANT SELECT ON workorder TO i9070507
/
GRANT SELECT ON workorder TO i9072207
/
GRANT SELECT ON workorder TO i9083102
/
GRANT SELECT ON workorder TO i9083691
/
GRANT SELECT ON workorder TO i9085391
/
GRANT SELECT ON workorder TO i9085685
/
GRANT SELECT ON workorder TO i9086094
/
GRANT SELECT ON workorder TO i9089085
/
GRANT SELECT ON workorder TO i9102818
/
GRANT SELECT ON workorder TO i9202519
/
GRANT SELECT ON workorder TO i9202813
/
GRANT SELECT ON workorder TO i9203320
/
GRANT SELECT ON workorder TO i9351301
/
GRANT SELECT ON workorder TO i9351498
/
GRANT SELECT ON workorder TO i9351596
/
GRANT SELECT ON workorder TO i9400221
/
GRANT SELECT ON workorder TO i9400319
/
GRANT SELECT ON workorder TO i9400711
/
GRANT SELECT ON workorder TO i9402803
/
GRANT SELECT ON workorder TO i9402901
/
GRANT SELECT ON workorder TO i9403506
/
GRANT SELECT ON workorder TO i9407102
/
GRANT SELECT ON workorder TO i9408296
/
GRANT SELECT ON workorder TO i9409097
/
GRANT SELECT ON workorder TO i9410903
/
GRANT SELECT ON workorder TO i9412211
/
GRANT SELECT ON workorder TO i9412407
/
GRANT SELECT ON workorder TO i9412505
/
GRANT SELECT ON workorder TO i9412701
/
GRANT SELECT ON workorder TO i9412898
/
GRANT SELECT ON workorder TO i9413012
/
GRANT SELECT ON workorder TO i9413404
/
GRANT SELECT ON workorder TO i9413699
/
GRANT SELECT ON workorder TO i9413993
/
GRANT SELECT ON workorder TO i9414205
/
GRANT SELECT ON workorder TO i9415497
/
GRANT SELECT ON workorder TO i9415595
/
GRANT SELECT ON workorder TO i9415693
/
GRANT SELECT ON workorder TO i9415889
/
GRANT SELECT ON workorder TO i9415987
/
GRANT SELECT ON workorder TO i9416101
/
GRANT SELECT ON workorder TO i9418488
/
GRANT SELECT ON workorder TO i9418684
/
GRANT SELECT ON workorder TO i9419583
/
GRANT SELECT ON workorder TO i9419681
/
GRANT SELECT ON workorder TO i9420017
/
GRANT SELECT ON workorder TO i9420115
/
GRANT SELECT ON workorder TO i9420213
/
GRANT SELECT ON workorder TO i9420311
/
GRANT SELECT ON workorder TO i9420409
/
GRANT SELECT ON workorder TO i9420507
/
GRANT SELECT ON workorder TO i9420703
/
GRANT SELECT ON workorder TO i9421504
/
GRANT SELECT ON workorder TO i9422894
/
GRANT SELECT ON workorder TO i9426686
/
GRANT SELECT ON workorder TO i9426980
/
GRANT SELECT ON workorder TO i9427095
/
GRANT SELECT ON workorder TO i9428974
/
GRANT SELECT ON workorder TO i9429285
/
GRANT SELECT ON workorder TO i9430111
/
GRANT SELECT ON workorder TO i9431206
/
GRANT SELECT ON workorder TO i9434688
/
GRANT SELECT ON workorder TO i9436094
/
GRANT SELECT ON workorder TO i9442101
/
GRANT SELECT ON workorder TO i9445965
/
GRANT SELECT ON workorder TO i9446580
/
GRANT SELECT ON workorder TO i9447577
/
GRANT SELECT ON workorder TO i9447871
/
GRANT SELECT ON workorder TO i9453487
/
GRANT SELECT ON workorder TO i9455775
/
GRANT SELECT ON workorder TO i9457573
/
GRANT SELECT ON workorder TO i9457671
/
GRANT SELECT ON workorder TO i9462682
/
GRANT SELECT ON workorder TO i9465379
/
GRANT SELECT ON workorder TO i9472874
/
GRANT SELECT ON workorder TO i9481383
/
GRANT SELECT ON workorder TO i9484570
/
GRANT SELECT ON workorder TO i9484766
/
GRANT SELECT ON workorder TO i9495661
/
GRANT SELECT ON workorder TO i9497459
/
GRANT SELECT ON workorder TO i9498358
/
GRANT SELECT ON workorder TO i9507294
/
GRANT SELECT ON workorder TO i9508585
/
GRANT SELECT ON workorder TO i9512795
/
GRANT SELECT ON workorder TO i9513596
/
GRANT SELECT ON workorder TO i9514004
/
GRANT SELECT ON workorder TO i9515001
/
GRANT SELECT ON workorder TO i9516783
/
GRANT SELECT ON workorder TO i9520404
/
GRANT SELECT ON workorder TO i9520993
/
GRANT SELECT ON workorder TO i9521009
/
GRANT SELECT ON workorder TO i9521107
/
GRANT SELECT ON workorder TO i9522987
/
GRANT SELECT ON workorder TO i9524295
/
GRANT SELECT ON workorder TO i9525880
/
GRANT SELECT ON workorder TO i9525978
/
GRANT SELECT ON workorder TO i9526681
/
GRANT SELECT ON workorder TO i9526779
/
GRANT SELECT ON workorder TO i9526975
/
GRANT SELECT ON workorder TO i9527090
/
GRANT SELECT ON workorder TO i9527188
/
GRANT SELECT ON workorder TO i9527286
/
GRANT SELECT ON workorder TO i9527384
/
GRANT SELECT ON workorder TO i9527678
/
GRANT SELECT ON workorder TO i9528283
/
GRANT SELECT ON workorder TO i9529182
/
GRANT SELECT ON workorder TO i9529966
/
GRANT SELECT ON workorder TO i9530204
/
GRANT SELECT ON workorder TO i9530891
/
GRANT SELECT ON workorder TO i9531496
/
GRANT SELECT ON workorder TO i9532395
/
GRANT SELECT ON workorder TO i9535582
/
GRANT SELECT ON workorder TO i9538279
/
GRANT SELECT ON workorder TO i9539668
/
GRANT SELECT ON workorder TO i9541001
/
GRANT SELECT ON workorder TO i9543780
/
GRANT SELECT ON workorder TO i9544581
/
GRANT SELECT ON workorder TO i9544875
/
GRANT SELECT ON workorder TO i9547866
/
GRANT SELECT ON workorder TO i9548569
/
GRANT SELECT ON workorder TO i9551194
/
GRANT SELECT ON workorder TO i9552289
/
GRANT SELECT ON workorder TO i9553972
/
GRANT SELECT ON workorder TO i9554479
/
GRANT SELECT ON workorder TO i9556865
/
GRANT SELECT ON workorder TO i9557568
/
GRANT SELECT ON workorder TO i9557764
/
GRANT SELECT ON workorder TO i9558663
/
GRANT SELECT ON workorder TO i9558761
/
GRANT SELECT ON workorder TO i9558859
/
GRANT SELECT ON workorder TO i9560977
/
GRANT SELECT ON workorder TO i9561484
/
GRANT SELECT ON workorder TO i9563674
/
GRANT SELECT ON workorder TO i9564671
/
GRANT SELECT ON workorder TO i9565962
/
GRANT SELECT ON workorder TO i9566175
/
GRANT SELECT ON workorder TO i9566273
/
GRANT SELECT ON workorder TO i9566763
/
GRANT SELECT ON workorder TO i9567270
/
GRANT SELECT ON workorder TO i9567760
/
GRANT SELECT ON workorder TO i9569362
/
GRANT SELECT ON workorder TO i9569558
/
GRANT SELECT ON workorder TO i9569754
/
GRANT SELECT ON workorder TO i9570777
/
GRANT SELECT ON workorder TO i9573082
/
GRANT SELECT ON workorder TO i9573376
/
GRANT SELECT ON workorder TO i9573474
/
GRANT SELECT ON workorder TO i9573572
/
GRANT SELECT ON workorder TO i9577266
/
GRANT SELECT ON workorder TO i9577560
/
GRANT SELECT ON workorder TO i9577570
/
GRANT SELECT ON workorder TO i9577854
/
GRANT SELECT ON workorder TO i9579848
/
GRANT SELECT ON workorder TO i9581476
/
GRANT SELECT ON workorder TO i9581574
/
GRANT SELECT ON workorder TO i9582767
/
GRANT SELECT ON workorder TO i9585856
/
GRANT SELECT ON workorder TO i9586167
/
GRANT SELECT ON workorder TO i9586265
/
GRANT SELECT ON workorder TO i9588455
/
GRANT SELECT ON workorder TO i9589452
/
GRANT SELECT ON workorder TO i9595558
/
GRANT SELECT ON workorder TO i9599154
/
GRANT SELECT ON workorder TO i9599350
/
GRANT SELECT ON workorder TO i9601895
/
GRANT SELECT ON workorder TO i9602303
/
GRANT SELECT ON workorder TO i9602598
/
GRANT SELECT ON workorder TO i9602794
/
GRANT SELECT ON workorder TO i9604494
/
GRANT SELECT ON workorder TO i9605981
/
GRANT SELECT ON workorder TO i9606292
/
GRANT SELECT ON workorder TO i9607093
/
GRANT SELECT ON workorder TO i9607877
/
GRANT SELECT ON workorder TO i9608188
/
GRANT SELECT ON workorder TO i9609087
/
GRANT SELECT ON workorder TO i9609675
/
GRANT SELECT ON workorder TO i9611499
/
GRANT SELECT ON workorder TO i9612692
/
GRANT SELECT ON workorder TO i9618674
/
GRANT SELECT ON workorder TO i9618968
/
GRANT SELECT ON workorder TO i9619083
/
GRANT SELECT ON workorder TO i9622884
/
GRANT SELECT ON workorder TO i9623097
/
GRANT SELECT ON workorder TO i9623195
/
GRANT SELECT ON workorder TO i9624094
/
GRANT SELECT ON workorder TO i9624192
/
GRANT SELECT ON workorder TO i9624486
/
GRANT SELECT ON workorder TO i9624584
/
GRANT SELECT ON workorder TO i9626382
/
GRANT SELECT ON workorder TO i9626676
/
GRANT SELECT ON workorder TO i9632978
/
GRANT SELECT ON workorder TO i9633093
/
GRANT SELECT ON workorder TO i9634776
/
GRANT SELECT ON workorder TO i9635283
/
GRANT SELECT ON workorder TO i9636770
/
GRANT SELECT ON workorder TO i9637179
/
GRANT SELECT ON workorder TO i9637277
/
GRANT SELECT ON workorder TO i9637865
/
GRANT SELECT ON workorder TO i9638372
/
GRANT SELECT ON workorder TO i9642974
/
GRANT SELECT ON workorder TO i9643481
/
GRANT SELECT ON workorder TO i9643677
/
GRANT SELECT ON workorder TO i9645965
/
GRANT SELECT ON workorder TO i9646864
/
GRANT SELECT ON workorder TO i9647371
/
GRANT SELECT ON workorder TO i9649365
/
GRANT SELECT ON workorder TO i9649463
/
GRANT SELECT ON workorder TO i9650192
/
GRANT SELECT ON workorder TO i9650388
/
GRANT SELECT ON workorder TO i9651287
/
GRANT SELECT ON workorder TO i9652872
/
GRANT SELECT ON workorder TO i9654866
/
GRANT SELECT ON workorder TO i9655765
/
GRANT SELECT ON workorder TO i9655863
/
GRANT SELECT ON workorder TO i9657563
/
GRANT SELECT ON workorder TO i9659949
/
GRANT SELECT ON workorder TO i9660776
/
GRANT SELECT ON workorder TO i9661087
/
GRANT SELECT ON workorder TO i9662280
/
GRANT SELECT ON workorder TO i9663865
/
GRANT SELECT ON workorder TO i9665957
/
GRANT SELECT ON workorder TO i9666464
/
GRANT SELECT ON workorder TO i9669651
/
GRANT SELECT ON workorder TO i9669847
/
GRANT SELECT ON workorder TO i9671769
/
GRANT SELECT ON workorder TO i9671867
/
GRANT SELECT ON workorder TO i9672178
/
GRANT SELECT ON workorder TO i9672276
/
GRANT SELECT ON workorder TO i9673175
/
GRANT SELECT ON workorder TO i9676852
/
GRANT SELECT ON workorder TO i9677751
/
GRANT SELECT ON workorder TO i9677947
/
GRANT SELECT ON workorder TO i9679070
/
GRANT SELECT ON workorder TO i9679255
/
GRANT SELECT ON workorder TO i9679549
/
GRANT SELECT ON workorder TO i9681471
/
GRANT SELECT ON workorder TO i9682468
/
GRANT SELECT ON workorder TO i9683759
/
GRANT SELECT ON workorder TO i9685557
/
GRANT SELECT ON workorder TO i9689153
/
GRANT SELECT ON workorder TO i9689643
/
GRANT SELECT ON workorder TO i9693363
/
GRANT SELECT ON workorder TO i9693951
/
GRANT SELECT ON workorder TO i9694066
/
GRANT SELECT ON workorder TO i9696256
/
GRANT SELECT ON workorder TO i9696550
/
GRANT SELECT ON workorder TO i9697743
/
GRANT SELECT ON workorder TO i9700991
/
GRANT SELECT ON workorder TO i9706189
/
GRANT SELECT ON workorder TO i9718669
/
GRANT SELECT ON workorder TO i9719960
/
GRANT SELECT ON workorder TO i9721490
/
GRANT SELECT ON workorder TO i9737958
/
GRANT SELECT ON workorder TO i9738171
/
GRANT SELECT ON workorder TO i9740681
/
GRANT SELECT ON workorder TO i9741776
/
GRANT SELECT ON workorder TO i9742773
/
GRANT SELECT ON workorder TO i9743084
/
GRANT SELECT ON workorder TO i9743182
/
GRANT SELECT ON workorder TO i9743280
/
GRANT SELECT ON workorder TO i9743378
/
GRANT SELECT ON workorder TO i9743476
/
GRANT SELECT ON workorder TO i9743672
/
GRANT SELECT ON workorder TO i9743770
/
GRANT SELECT ON workorder TO i9743966
/
GRANT SELECT ON workorder TO i9746369
/
GRANT SELECT ON workorder TO i9746859
/
GRANT SELECT ON workorder TO i9747660
/
GRANT SELECT ON workorder TO i9747758
/
GRANT SELECT ON workorder TO i9747856
/
GRANT SELECT ON workorder TO i9747954
/
GRANT SELECT ON workorder TO i9748265
/
GRANT SELECT ON workorder TO i9748461
/
GRANT SELECT ON workorder TO i9748755
/
GRANT SELECT ON workorder TO i9748853
/
GRANT SELECT ON workorder TO i9748951
/
GRANT SELECT ON workorder TO i9749164
/
GRANT SELECT ON workorder TO i9750285
/
GRANT SELECT ON workorder TO i9751576
/
GRANT SELECT ON workorder TO i9753668
/
GRANT SELECT ON workorder TO i9753766
/
GRANT SELECT ON workorder TO i9756953
/
GRANT SELECT ON workorder TO i9757950
/
GRANT SELECT ON workorder TO i9758261
/
GRANT SELECT ON workorder TO i9759552
/
GRANT SELECT ON workorder TO i9762373
/
GRANT SELECT ON workorder TO i9762471
/
GRANT SELECT ON workorder TO i9765952
/
GRANT SELECT ON workorder TO i9766067
/
GRANT SELECT ON workorder TO i9767456
/
GRANT SELECT ON workorder TO i9767750
/
GRANT SELECT ON workorder TO i9768551
/
GRANT SELECT ON workorder TO i9768649
/
GRANT SELECT ON workorder TO i9769156
/
GRANT SELECT ON workorder TO i9769254
/
GRANT SELECT ON workorder TO i9769352
/
GRANT SELECT ON workorder TO i9769450
/
GRANT SELECT ON workorder TO i9769548
/
GRANT SELECT ON workorder TO i9769646
/
GRANT SELECT ON workorder TO i9770277
/
GRANT SELECT ON workorder TO i9771862
/
GRANT SELECT ON workorder TO i9772761
/
GRANT SELECT ON workorder TO i9773268
/
GRANT SELECT ON workorder TO i9773954
/
GRANT SELECT ON workorder TO i9774167
/
GRANT SELECT ON workorder TO i9775164
/
GRANT SELECT ON workorder TO i9775850
/
GRANT SELECT ON workorder TO i9775948
/
GRANT SELECT ON workorder TO i9776749
/
GRANT SELECT ON workorder TO i9776847
/
GRANT SELECT ON workorder TO i9777060
/
GRANT SELECT ON workorder TO i9778547
/
GRANT SELECT ON workorder TO i9778743
/
GRANT SELECT ON workorder TO i9779446
/
GRANT SELECT ON workorder TO i9780665
/
GRANT SELECT ON workorder TO i9781270
/
GRANT SELECT ON workorder TO i9781368
/
GRANT SELECT ON workorder TO i9781858
/
GRANT SELECT ON workorder TO i9782757
/
GRANT SELECT ON workorder TO i9785944
/
GRANT SELECT ON workorder TO i9788739
/
GRANT SELECT ON workorder TO i9789736
/
GRANT SELECT ON workorder TO i9793260
/
GRANT SELECT ON workorder TO i9794257
/
GRANT SELECT ON workorder TO i9794355
/
GRANT SELECT ON workorder TO i9794453
/
GRANT SELECT ON workorder TO i9794845
/
GRANT SELECT ON workorder TO i9794943
/
GRANT SELECT ON workorder TO i9795842
/
GRANT SELECT ON workorder TO i9796055
/
GRANT SELECT ON workorder TO i9796741
/
GRANT SELECT ON workorder TO i9796839
/
GRANT SELECT ON workorder TO i9796937
/
GRANT SELECT ON workorder TO i9797444
/
GRANT SELECT ON workorder TO i9797640
/
GRANT SELECT ON workorder TO i9804484
/
GRANT SELECT ON workorder TO i9804974
/
GRANT SELECT ON workorder TO i9805187
/
GRANT SELECT ON workorder TO i9805383
/
GRANT SELECT ON workorder TO i9806576
/
GRANT SELECT ON workorder TO i9807181
/
GRANT SELECT ON workorder TO i9807475
/
GRANT SELECT ON workorder TO i9808178
/
GRANT SELECT ON workorder TO i9809175
/
GRANT SELECT ON workorder TO i9809371
/
GRANT SELECT ON workorder TO i9813973
/
GRANT SELECT ON workorder TO i9818566
/
GRANT SELECT ON workorder TO i9819857
/
GRANT SELECT ON workorder TO i9819955
/
GRANT SELECT ON workorder TO i9823479
/
GRANT SELECT ON workorder TO i9824182
/
GRANT SELECT ON workorder TO i9826568
/
GRANT SELECT ON workorder TO i9828268
/
GRANT SELECT ON workorder TO i9829167
/
GRANT SELECT ON workorder TO i9830386
/
GRANT SELECT ON workorder TO i9830484
/
GRANT SELECT ON workorder TO i9830582
/
GRANT SELECT ON workorder TO i9830974
/
GRANT SELECT ON workorder TO i9832282
/
GRANT SELECT ON workorder TO i9834178
/
GRANT SELECT ON workorder TO i9834570
/
GRANT SELECT ON workorder TO i9834668
/
GRANT SELECT ON workorder TO i9836270
/
GRANT SELECT ON workorder TO i9836368
/
GRANT SELECT ON workorder TO i9836662
/
GRANT SELECT ON workorder TO i9837267
/
GRANT SELECT ON workorder TO i9840382
/
GRANT SELECT ON workorder TO i9843177
/
GRANT SELECT ON workorder TO i9847557
/
GRANT SELECT ON workorder TO i9850280
/
GRANT SELECT ON workorder TO i9851473
/
GRANT SELECT ON workorder TO i9852274
/
GRANT SELECT ON workorder TO i9852862
/
GRANT SELECT ON workorder TO i9853173
/
GRANT SELECT ON workorder TO i9854464
/
GRANT SELECT ON workorder TO i9854954
/
GRANT SELECT ON workorder TO i9855167
/
GRANT SELECT ON workorder TO i9855363
/
GRANT SELECT ON workorder TO i9855755
/
GRANT SELECT ON workorder TO i9856164
/
GRANT SELECT ON workorder TO i9859743
/
GRANT SELECT ON workorder TO i9860668
/
GRANT SELECT ON workorder TO i9861175
/
GRANT SELECT ON workorder TO i9861273
/
GRANT SELECT ON workorder TO i9862368
/
GRANT SELECT ON workorder TO i9862760
/
GRANT SELECT ON workorder TO i9863463
/
GRANT SELECT ON workorder TO i9864460
/
GRANT SELECT ON workorder TO i9864852
/
GRANT SELECT ON workorder TO i9865065
/
GRANT SELECT ON workorder TO i9865261
/
GRANT SELECT ON workorder TO i9866062
/
GRANT SELECT ON workorder TO i9870468
/
GRANT SELECT ON workorder TO i9873753
/
GRANT SELECT ON workorder TO i9879441
/
GRANT SELECT ON workorder TO i9881657
/
GRANT SELECT ON workorder TO i9883058
/
GRANT SELECT ON workorder TO i9883945
/
GRANT SELECT ON workorder TO i9888146
/
GRANT SELECT ON workorder TO i9891555
/
GRANT SELECT ON workorder TO i9893647
/
GRANT SELECT ON workorder TO i9896540
/
GRANT SELECT ON workorder TO i9897047
/
GRANT SELECT ON workorder TO i9898142
/
GRANT SELECT ON workorder TO i9900687
/
GRANT SELECT ON workorder TO i9900785
/
GRANT SELECT ON workorder TO i9903482
/
GRANT SELECT ON workorder TO i9913772
/
GRANT SELECT ON workorder TO i9914181
/
GRANT SELECT ON workorder TO i9915472
/
GRANT SELECT ON workorder TO i9915570
/
GRANT SELECT ON workorder TO i9917172
/
GRANT SELECT ON workorder TO i9917270
/
GRANT SELECT ON workorder TO i9918169
/
GRANT SELECT ON workorder TO i9920875
/
GRANT SELECT ON workorder TO i9923474
/
GRANT SELECT ON workorder TO i9928851
/
GRANT SELECT ON workorder TO i9928949
/
GRANT SELECT ON workorder TO i9929554
/
GRANT SELECT ON workorder TO i9929652
/
GRANT SELECT ON workorder TO i9930479
/
GRANT SELECT ON workorder TO i9930969
/
GRANT SELECT ON workorder TO i9931084
/
GRANT SELECT ON workorder TO i9933470
/
GRANT SELECT ON workorder TO i9934075
/
GRANT SELECT ON workorder TO i9934859
/
GRANT SELECT ON workorder TO i9936951
/
GRANT SELECT ON workorder TO i9937262
/
GRANT SELECT ON workorder TO i9937360
/
GRANT SELECT ON workorder TO i9942175
/
GRANT SELECT ON workorder TO i9944855
/
GRANT SELECT ON workorder TO i9945068
/
GRANT SELECT ON workorder TO i9945558
/
GRANT SELECT ON workorder TO i9948451
/
GRANT SELECT ON workorder TO i9948549
/
GRANT SELECT ON workorder TO i9948745
/
GRANT SELECT ON workorder TO i9954263
/
GRANT SELECT ON workorder TO i9957940
/
GRANT SELECT ON workorder TO i9958055
/
GRANT SELECT ON workorder TO i9961758
/
GRANT SELECT ON workorder TO i9966351
/
GRANT SELECT ON workorder TO i9966841
/
GRANT SELECT ON workorder TO i9973258
/
GRANT SELECT ON workorder TO i9975350
/
GRANT SELECT ON workorder TO i9975448
/
GRANT SELECT ON workorder TO i9975644
/
GRANT SELECT ON workorder TO i9976151
/
GRANT SELECT ON workorder TO i9981750
/
GRANT SELECT ON workorder TO i9982943
/
GRANT SELECT ON workorder TO i9983058
/
GRANT SELECT ON workorder TO i9985346
/
GRANT SELECT ON workorder TO i9986441
/
GRANT SELECT ON workorder TO i9986539
/
GRANT SELECT ON workorder TO i9986631
/
GRANT SELECT ON workorder TO i9986637
/
GRANT SELECT ON workorder TO i9988337
/
GRANT SELECT ON workorder TO i9988435
/
GRANT SELECT ON workorder TO i9988631
/
GRANT SELECT ON workorder TO i9988729
/
GRANT SELECT ON workorder TO i9992253
/
GRANT SELECT ON workorder TO i9993446
/
GRANT SELECT ON workorder TO i9993642
/
GRANT SELECT ON workorder TO i9994933
/
GRANT SELECT ON workorder TO i9995538
/
GRANT INSERT ON workorder TO integracao
/
GRANT SELECT ON workorder TO integracao
/
GRANT SELECT ON workorder TO maxconsulta
/
GRANT SELECT ON workorder TO maxdema
/
GRANT SELECT ON workorder TO maxgrp04
/
GRANT SELECT ON workorder TO maxgrp06
/
GRANT SELECT ON workorder TO maxgrp07
/
GRANT SELECT ON workorder TO maxgrp08
/
GRANT INSERT ON workorder TO maxsapiospa
/
GRANT SELECT ON workorder TO operacao
/
GRANT DELETE ON workorder TO psdipub
/
GRANT INSERT ON workorder TO psdipub
/
GRANT SELECT ON workorder TO psdipub
/
GRANT UPDATE ON workorder TO psdipub
/
GRANT SELECT ON workorder TO sbbe01
/
GRANT SELECT ON workorder TO sbbe02
/
GRANT SELECT ON workorder TO sbbe03
/
GRANT SELECT ON workorder TO sbbe04
/
GRANT SELECT ON workorder TO sbbe06
/
GRANT SELECT ON workorder TO sbbearaujo
/
GRANT SELECT ON workorder TO sbbechaoverde
/
GRANT SELECT ON workorder TO sbbepontual
/
GRANT SELECT ON workorder TO sbbethermar
/
GRANT SELECT ON workorder TO sbbr01
/
GRANT SELECT ON workorder TO sbbr02
/
GRANT SELECT ON workorder TO sbbr03
/
GRANT SELECT ON workorder TO sbbr04
/
GRANT SELECT ON workorder TO sbbr06
/
GRANT SELECT ON workorder TO sbbv02
/
GRANT SELECT ON workorder TO sbbv03
/
GRANT SELECT ON workorder TO sbbv04
/
GRANT SELECT ON workorder TO sbcf01
/
GRANT SELECT ON workorder TO sbcf02
/
GRANT SELECT ON workorder TO sbcf03
/
GRANT SELECT ON workorder TO sbcf04
/
GRANT SELECT ON workorder TO sbcfgp
/
GRANT SELECT ON workorder TO sbcfsalgado
/
GRANT SELECT ON workorder TO sbcftecnyt
/
GRANT SELECT ON workorder TO sbcfviatec
/
GRANT SELECT ON workorder TO sbcg02
/
GRANT SELECT ON workorder TO sbcg03
/
GRANT SELECT ON workorder TO sbcg04
/
GRANT SELECT ON workorder TO sbcginterway
/
GRANT SELECT ON workorder TO sbcr02
/
GRANT SELECT ON workorder TO sbcr03
/
GRANT SELECT ON workorder TO sbcr04
/
GRANT SELECT ON workorder TO sbcrengeletrica
/
GRANT SELECT ON workorder TO sbct01
/
GRANT SELECT ON workorder TO sbct02
/
GRANT SELECT ON workorder TO sbct03
/
GRANT SELECT ON workorder TO sbct04
/
GRANT SELECT ON workorder TO sbct06
/
GRANT SELECT ON workorder TO sbctebcm
/
GRANT SELECT ON workorder TO sbctelshaday
/
GRANT SELECT ON workorder TO sbctengeletrica
/
GRANT SELECT ON workorder TO sbctparana
/
GRANT SELECT ON workorder TO sbctscheffer
/
GRANT SELECT ON workorder TO sbctsociplan
/
GRANT SELECT ON workorder TO sbctteldata
/
GRANT SELECT ON workorder TO sbeg01
/
GRANT SELECT ON workorder TO sbeg02
/
GRANT SELECT ON workorder TO sbeg03
/
GRANT SELECT ON workorder TO sbeg04
/
GRANT SELECT ON workorder TO sbegmarins
/
GRANT SELECT ON workorder TO sbegmpe
/
GRANT SELECT ON workorder TO sbegthermar
/
GRANT SELECT ON workorder TO sbfl03
/
GRANT SELECT ON workorder TO sbfl04
/
GRANT SELECT ON workorder TO sbfz01
/
GRANT SELECT ON workorder TO sbfz02
/
GRANT SELECT ON workorder TO sbfz03
/
GRANT SELECT ON workorder TO sbfz04
/
GRANT SELECT ON workorder TO sbfz06
/
GRANT SELECT ON workorder TO sbfzctm
/
GRANT SELECT ON workorder TO sbfzengeletrica
/
GRANT SELECT ON workorder TO sbfzpontual
/
GRANT SELECT ON workorder TO sbfzservtec
/
GRANT SELECT ON workorder TO sbfzuniao
/
GRANT SELECT ON workorder TO sbgl01
/
GRANT SELECT ON workorder TO sbgl02
/
GRANT SELECT ON workorder TO sbgl03
/
GRANT SELECT ON workorder TO sbgl04
/
GRANT SELECT ON workorder TO sbglccr
/
GRANT SELECT ON workorder TO sbgleterc
/
GRANT SELECT ON workorder TO sbglexcel
/
GRANT SELECT ON workorder TO sbglicsupply
/
GRANT SELECT ON workorder TO sbglmpe
/
GRANT SELECT ON workorder TO sbglsm21
/
GRANT SELECT ON workorder TO sbglteam
/
GRANT SELECT ON workorder TO sbgltecnenge
/
GRANT SELECT ON workorder TO sbgo02
/
GRANT SELECT ON workorder TO sbgo03
/
GRANT SELECT ON workorder TO sbgo04
/
GRANT SELECT ON workorder TO sbgr01
/
GRANT SELECT ON workorder TO sbgr02
/
GRANT SELECT ON workorder TO sbgr03
/
GRANT SELECT ON workorder TO sbgr04
/
GRANT SELECT ON workorder TO sbgr06
/
GRANT SELECT ON workorder TO sbgratlas
/
GRANT SELECT ON workorder TO sbgrcascardi
/
GRANT SELECT ON workorder TO sbgrcsistema
/
GRANT SELECT ON workorder TO sbgrempress
/
GRANT SELECT ON workorder TO sbgriacit
/
GRANT SELECT ON workorder TO sbgrinterway
/
GRANT SELECT ON workorder TO sbgrmpe
/
GRANT SELECT ON workorder TO sbgrmpe014
/
GRANT SELECT ON workorder TO sbgrmpe033
/
GRANT SELECT ON workorder TO sbgrmpe041
/
GRANT SELECT ON workorder TO sbgrmpe071
/
GRANT SELECT ON workorder TO sbgrmpe072
/
GRANT SELECT ON workorder TO sbgrntk
/
GRANT SELECT ON workorder TO sbgrotis
/
GRANT SELECT ON workorder TO sbgrsheffer
/
GRANT SELECT ON workorder TO sbgrsipec
/
GRANT SELECT ON workorder TO sbgrspread
/
GRANT SELECT ON workorder TO sbgrsupply
/
GRANT SELECT ON workorder TO sbgrtranspolix
/
GRANT SELECT ON workorder TO sbgrultratec
/
GRANT SELECT ON workorder TO sbgrviatec
/
GRANT SELECT ON workorder TO sbjp03
/
GRANT SELECT ON workorder TO sbjp04
/
GRANT SELECT ON workorder TO sbkp01
/
GRANT SELECT ON workorder TO sbkp02
/
GRANT SELECT ON workorder TO sbkp03
/
GRANT SELECT ON workorder TO sbkp04
/
GRANT SELECT ON workorder TO sbkp06
/
GRANT SELECT ON workorder TO sbkpengeletrica
/
GRANT SELECT ON workorder TO sbkpgutierrez
/
GRANT SELECT ON workorder TO sbkpmpe
/
GRANT SELECT ON workorder TO sbkpservtec
/
GRANT SELECT ON workorder TO sbkpsge
/
GRANT SELECT ON workorder TO sbkpviatec
/
GRANT SELECT ON workorder TO sbmo01
/
GRANT SELECT ON workorder TO sbmo02
/
GRANT SELECT ON workorder TO sbmo03
/
GRANT SELECT ON workorder TO sbmo04
/
GRANT SELECT ON workorder TO sbmoviatec
/
GRANT SELECT ON workorder TO sbmq04
/
GRANT SELECT ON workorder TO sbnt01
/
GRANT SELECT ON workorder TO sbnt02
/
GRANT SELECT ON workorder TO sbnt03
/
GRANT SELECT ON workorder TO sbnt04
/
GRANT SELECT ON workorder TO sbpa01
/
GRANT SELECT ON workorder TO sbpa02
/
GRANT SELECT ON workorder TO sbpa03
/
GRANT SELECT ON workorder TO sbpa04
/
GRANT SELECT ON workorder TO sbpa06
/
GRANT SELECT ON workorder TO sbpaconbras
/
GRANT SELECT ON workorder TO sbpaemant
/
GRANT SELECT ON workorder TO sbpaengeletrica
/
GRANT SELECT ON workorder TO sbpaheacoo
/
GRANT SELECT ON workorder TO sbpampe
/
GRANT SELECT ON workorder TO sbpasait
/
GRANT SELECT ON workorder TO sbpatecnyt
/
GRANT SELECT ON workorder TO sbpl03
/
GRANT SELECT ON workorder TO sbpl04
/
GRANT SELECT ON workorder TO sbpv02
/
GRANT SELECT ON workorder TO sbpv03
/
GRANT SELECT ON workorder TO sbpv04
/
GRANT SELECT ON workorder TO sbrb02
/
GRANT SELECT ON workorder TO sbrb03
/
GRANT SELECT ON workorder TO sbrb04
/
GRANT SELECT ON workorder TO sbrf01
/
GRANT SELECT ON workorder TO sbrf02
/
GRANT SELECT ON workorder TO sbrf03
/
GRANT SELECT ON workorder TO sbrf04
/
GRANT SELECT ON workorder TO sbrf06
/
GRANT SELECT ON workorder TO sbrfhidelma
/
GRANT SELECT ON workorder TO sbrfviatec
/
GRANT SELECT ON workorder TO sbrj01
/
GRANT SELECT ON workorder TO sbrj02
/
GRANT SELECT ON workorder TO sbrj03
/
GRANT SELECT ON workorder TO sbrj04
/
GRANT SELECT ON workorder TO sbrjicsupply
/
GRANT SELECT ON workorder TO sbrjmpe
/
GRANT SELECT ON workorder TO sbsl01
/
GRANT SELECT ON workorder TO sbsl02
/
GRANT SELECT ON workorder TO sbsl03
/
GRANT SELECT ON workorder TO sbsl04
/
GRANT SELECT ON workorder TO sbsn04
/
GRANT SELECT ON workorder TO sbsp01
/
GRANT SELECT ON workorder TO sbsp02
/
GRANT SELECT ON workorder TO sbsp03
/
GRANT SELECT ON workorder TO sbsp04
/
GRANT SELECT ON workorder TO sbspatlas
/
GRANT SELECT ON workorder TO sbspecolabor
/
GRANT SELECT ON workorder TO sbspjlh
/
GRANT SELECT ON workorder TO sbspmpe
/
GRANT SELECT ON workorder TO sbspmpe024
/
GRANT SELECT ON workorder TO sbspmpe069
/
GRANT SELECT ON workorder TO sbspntk
/
GRANT SELECT ON workorder TO sbspservtec
/
GRANT SELECT ON workorder TO sbspviatec
/
GRANT SELECT ON workorder TO sbsv01
/
GRANT SELECT ON workorder TO sbsv02
/
GRANT SELECT ON workorder TO sbsv03
/
GRANT SELECT ON workorder TO sbsv04
/
GRANT SELECT ON workorder TO sbsv06
/
GRANT SELECT ON workorder TO sbsvjohnson
/
GRANT SELECT ON workorder TO sbsvproclima
/
GRANT SELECT ON workorder TO sbsvtecnyt
/
GRANT SELECT ON workorder TO sbsvviatec
/
GRANT SELECT ON workorder TO sbte03
/
GRANT SELECT ON workorder TO sbte04
/
GRANT SELECT ON workorder TO sbtf02
/
GRANT SELECT ON workorder TO sbtf03
/
GRANT SELECT ON workorder TO sbul04
/
GRANT SELECT ON workorder TO i1024955
/
GRANT SELECT ON workorder TO i3243046
/
GRANT SELECT ON workorder TO i9606194
/
GRANT SELECT ON workorder TO i9949350
/
GRANT SELECT ON workorder TO i9847067
/
GRANT SELECT ON workorder TO i9937654
/
GRANT SELECT ON workorder TO i3804519
/
GRANT SELECT ON workorder TO i9762177
/
GRANT SELECT ON workorder TO i7704010
/
GRANT SELECT ON workorder TO i9961366
/
GRANT SELECT ON workorder TO i9465477
/
GRANT SELECT ON workorder TO i4177609
/
GRANT SELECT ON workorder TO i9686456
/
GRANT SELECT ON workorder TO i9954949
/
GRANT SELECT ON workorder TO i4740122
/
GRANT SELECT ON workorder TO i9512697
/
GRANT SELECT ON workorder TO i9935758
/
GRANT SELECT ON workorder TO i9822580
/
GRANT SELECT ON workorder TO i9796447
/
GRANT SELECT ON workorder TO sede01
/
GRANT SELECT ON workorder TO i9605589
/
GRANT SELECT ON workorder TO sbkpengeletrica004
/
GRANT SELECT ON workorder TO sbkpengeletrica012
/
GRANT SELECT ON workorder TO sbkpmpe011
/
GRANT SELECT ON workorder TO sbkpmpe005
/
GRANT SELECT ON workorder TO sbkpcorpus
/
GRANT SELECT ON workorder TO sbkpscheffer
/
GRANT SELECT ON workorder TO ceng012kp
/
GRANT SELECT ON workorder TO ceng004kp
/
GRANT SELECT ON workorder TO sbkpengeletrica018
/
GRANT SELECT ON workorder TO ceng018kp
/
GRANT SELECT ON workorder TO cmpe011kp
/
GRANT SELECT ON workorder TO cmpe005kp
/
GRANT SELECT ON workorder TO ccorpuskp
/
GRANT SELECT ON workorder TO cschefferkp
/
GRANT SELECT ON workorder TO i9911190
/
GRANT SELECT ON workorder TO sblo04
/
GRANT SELECT ON workorder TO sbjv04
/
GRANT SELECT ON workorder TO sbnf04
/
GRANT SELECT ON workorder TO sbfi04
/
GRANT SELECT ON workorder TO i9460394
/
GRANT SELECT ON workorder TO i559419
/
GRANT SELECT ON workorder TO i9570581
/
GRANT SELECT ON workorder TO i9612201
/
GRANT SELECT ON workorder TO i2371825
/
GRANT SELECT ON workorder TO i9098966
/
GRANT SELECT ON workorder TO i4914112
/
GRANT SELECT ON workorder TO sbcy04
/
GRANT SELECT ON workorder TO sbur04
/
GRANT SELECT ON workorder TO sbpj04
/
GRANT SELECT ON workorder TO i8102236
/
GRANT SELECT ON workorder TO i5218227
/
GRANT SELECT ON workorder TO i1030277
/
GRANT SELECT ON workorder TO i9983744
/
GRANT SELECT ON workorder TO sbtf04
/
GRANT SELECT ON workorder TO sbtt04
/
GRANT SELECT ON workorder TO sbcz04
/
GRANT SELECT ON workorder TO i9843079
/
GRANT SELECT ON workorder TO i2517821
/
GRANT SELECT ON workorder TO i8600609
/
GRANT SELECT ON workorder TO i8504897
/
GRANT SELECT ON workorder TO sbar04
/
GRANT SELECT ON workorder TO sbmosuperserv
/
GRANT SELECT ON workorder TO csuperservmo
/
GRANT SELECT ON workorder TO i1036063
/
GRANT SELECT ON workorder TO sbvt04
/
GRANT SELECT ON workorder TO i9983940
/
GRANT SELECT ON workorder TO i5811512
/
GRANT SELECT ON workorder TO i4750314
/
GRANT SELECT ON workorder TO i9446972
/
GRANT SELECT ON workorder TO sbar03
/
GRANT SELECT ON workorder TO i9969636
/
GRANT SELECT ON workorder TO i9672668
/
GRANT SELECT ON workorder TO i9965354
/
GRANT SELECT ON workorder TO i1036553
/
GRANT SELECT ON workorder TO i1037452
/
GRANT SELECT ON workorder TO i0220669
/
GRANT SELECT ON workorder TO sbpv06
/
GRANT SELECT ON workorder TO c65032
/
GRANT SELECT ON workorder TO c64731
/
GRANT SELECT ON workorder TO sbrb06
/
GRANT SELECT ON workorder TO sbcfmoa
/
GRANT SELECT ON workorder TO cmoacf
/
GRANT SELECT ON workorder TO sbrfsuperserv
/
GRANT SELECT ON workorder TO csuperservrf
/
GRANT SELECT ON workorder TO i9664568
/
GRANT SELECT ON workorder TO i1048837
/
GRANT SELECT ON workorder TO i9901194
/
GRANT SELECT ON workorder TO c0001305
/
GRANT SELECT ON workorder TO sbpaotis
/
GRANT SELECT ON workorder TO cotispa
/
GRANT SELECT ON workorder TO sbpatopservice
/
GRANT SELECT ON workorder TO ctopservicepa
/
GRANT SELECT ON workorder TO i9946947
/
GRANT SELECT ON workorder TO i9671671
/
GRANT SELECT ON workorder TO sbkpntk
/
GRANT SELECT ON workorder TO cntkkp
/
GRANT SELECT ON workorder TO i9986343
/
GRANT SELECT ON workorder TO sbkpsge020
/
GRANT SELECT ON workorder TO sbkpsge003
/
GRANT SELECT ON workorder TO csge020kp
/
GRANT SELECT ON workorder TO csge003kp
/
GRANT SELECT ON workorder TO i9631785
/
GRANT SELECT ON workorder TO i1053162
/
GRANT SELECT ON workorder TO i9049199
/
GRANT SELECT ON workorder TO i4115051
/
GRANT SELECT ON workorder TO i9986245
/
GRANT SELECT ON workorder TO i220669
/
GRANT SELECT ON workorder TO sbpj
/
GRANT SELECT ON workorder TO i9983548
/
GRANT SELECT ON workorder TO c11994455
/
GRANT SELECT ON workorder TO i4197601
/
GRANT SELECT ON workorder TO i7001152
/
GRANT SELECT ON workorder TO i9004621
/
GRANT SELECT ON workorder TO i9961464
/
GRANT SELECT ON workorder TO i9947650
/
GRANT SELECT ON workorder TO i9994835
/
GRANT SELECT ON workorder TO i4153237
/
GRANT SELECT ON workorder TO c968150276
/
GRANT SELECT ON workorder TO c0653216939
/
GRANT SELECT ON workorder TO c0728384000
/
GRANT SELECT ON workorder TO sbul03
/
GRANT SELECT ON workorder TO i9786647
/
GRANT SELECT ON workorder TO i9079285
/
GRANT SELECT ON workorder TO i8103135
/
GRANT SELECT ON workorder TO sbpatecnytmec
/
GRANT SELECT ON workorder TO ctecnytmecpa
/
GRANT SELECT ON workorder TO i1030767
/
GRANT SELECT ON workorder TO sbiz04
/
GRANT SELECT ON workorder TO sbma04
/
GRANT SELECT ON workorder TO i1252841
/
GRANT SELECT ON workorder TO sbpj03
/
GRANT SELECT ON workorder TO i0805044
/
GRANT SELECT ON workorder TO i9866454
/
GRANT SELECT ON workorder TO i9552583
/
GRANT SELECT ON workorder TO i9823969
/
GRANT SELECT ON workorder TO i9094684
/
GRANT SELECT ON workorder TO i0625438
/
GRANT SELECT ON workorder TO c12345678
/
GRANT SELECT ON workorder TO sbgrserviceone
/
GRANT SELECT ON workorder TO i4718306
/
GRANT SELECT ON workorder TO i9667853
/
GRANT SELECT ON workorder TO c1972
/
GRANT SELECT ON workorder TO conegr
/
GRANT SELECT ON workorder TO c12345
/
GRANT SELECT ON workorder TO c12346
/
GRANT SELECT ON workorder TO c12347
/
GRANT SELECT ON workorder TO c12348
/
GRANT SELECT ON workorder TO c12349
/
GRANT SELECT ON workorder TO c12350
/
GRANT SELECT ON workorder TO c12351
/
GRANT SELECT ON workorder TO c12352
/
GRANT SELECT ON workorder TO c12353
/
GRANT SELECT ON workorder TO c12354
/
GRANT SELECT ON workorder TO c12355
/
GRANT SELECT ON workorder TO c12356
/
GRANT SELECT ON workorder TO c12357
/
GRANT SELECT ON workorder TO c12358
/
GRANT SELECT ON workorder TO c12360
/
GRANT SELECT ON workorder TO c12361
/
GRANT SELECT ON workorder TO c12362
/
GRANT SELECT ON workorder TO c12359
/
GRANT SELECT ON workorder TO sbbecetest
/
GRANT SELECT ON workorder TO cctestbe
/
GRANT SELECT ON workorder TO i9606586
/
GRANT SELECT ON workorder TO i3251440
/
GRANT SELECT ON workorder TO c12364
/
GRANT SELECT ON workorder TO c12363
/
GRANT SELECT ON workorder TO c1524961
/
GRANT SELECT ON workorder TO i9435783
/
GRANT SELECT ON workorder TO i1091740
/
GRANT SELECT ON workorder TO c6082141
/
GRANT SELECT ON workorder TO sbpatopserviceciv
/
GRANT SELECT ON workorder TO ctopservicecivpa
/
GRANT SELECT ON workorder TO ctopservice2pa
/
GRANT SELECT ON workorder TO c0199906
/
GRANT SELECT ON workorder TO i1038645
/
GRANT SELECT ON workorder TO i9813385
/
GRANT SELECT ON workorder TO i1023370
/
GRANT SELECT ON workorder TO i1120374
/
GRANT SELECT ON workorder TO c00613
/
GRANT SELECT ON workorder TO i1091544
/
GRANT SELECT ON workorder TO i1108750
/
GRANT SELECT ON workorder TO daag01
/
GRANT SELECT ON workorder TO daag02
/
GRANT SELECT ON workorder TO daag03
/
GRANT SELECT ON workorder TO daag04
/
GRANT SELECT ON workorder TO daag06
/
GRANT SELECT ON workorder TO i198426
/
GRANT SELECT ON workorder TO c5434585
/
GRANT SELECT ON workorder TO c4945101
/
GRANT SELECT ON workorder TO c6350779
/
GRANT SELECT ON workorder TO i9556277
/
GRANT SELECT ON workorder TO i9892356
/
GRANT SELECT ON workorder TO i1089720
/
GRANT SELECT ON workorder TO c0212806
/
GRANT SELECT ON workorder TO c0197405
/
GRANT SELECT ON workorder TO c0182105
/
GRANT SELECT ON workorder TO sbiz03
/
GRANT SELECT ON workorder TO i5415912
/
GRANT SELECT ON workorder TO i625340
/
GRANT SELECT ON workorder TO sbfzinterway
/
GRANT SELECT ON workorder TO cinterwayfz
/
GRANT SELECT ON workorder TO sbsl06
/
GRANT SELECT ON workorder TO c5812083
/
GRANT SELECT ON workorder TO c4384833
/
GRANT SELECT ON workorder TO c4604945
/
GRANT SELECT ON workorder TO c1413580
/
GRANT SELECT ON workorder TO c5973844
/
GRANT DELETE ON workorder TO daagdflt
/
GRANT SELECT ON workorder TO daagdflt
/
GRANT UPDATE ON workorder TO daagdflt
/


EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRMAXIMO' , estimate_percent => 25, cascade => TRUE);