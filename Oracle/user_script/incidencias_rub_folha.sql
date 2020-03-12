create or replace PROCEDURE ifrsrh_folha.prc_incidencias_rub_folha (PMES NUMBER, PANO NUMBER)
IS
CURSOR C_ARQ IS
    SELECT A.IRU_RUB_CODIGO,
           A.IRU_RUB_CODIGO_INCIDE,
           A.IRU_TIP_NORMAL,
           A.IRU_TIP_DIFERENCA,
           A.IRU_TIP_ESTORNO_DEV
    FROM   IFRSRH.INCIDENCIAS_RUBRICAS A
    WHERE (A.DATA_TERMINO IS NULL OR
           TO_NUMBER(TO_CHAR(A.DATA_TERMINO,'YYYYMMDD')) >= TO_NUMBER(LPAD(TO_CHAR(PANO),4,'0')||
                                                                      LPAD(TO_CHAR(PMES),2,'0')||LPAD(TO_CHAR(01),2,'0')));

v_cont      number       := 0;
BEGIN
   FOR R_ARQ IN C_ARQ LOOP
           begin
                   INSERT INTO IFRSRH_FOLHA.INCIDENCIAS_RUBRICAS
                       (IRU_RUB_CODIGO
                       ,IRU_RUB_CODIGO_INCIDE
                       ,IRU_TIP_NORMAL
                       ,IRU_TIP_DIFERENCA
                       ,IRU_TIP_ESTORNO_DEV
                      )
                      VALUES
                       (R_ARQ.IRU_RUB_CODIGO
                       ,R_ARQ.IRU_RUB_CODIGO_INCIDE
                       ,R_ARQ.IRU_TIP_NORMAL
                       ,R_ARQ.IRU_TIP_DIFERENCA
                       ,R_ARQ.IRU_TIP_ESTORNO_DEV
                   );
           exception
              when DUP_VAL_ON_INDEX then
                 null;
              when OTHERS then
                 Raise_Application_Error(-20000,'Erro ao inserir registro',true);
           end;
           v_cont      := v_cont + 1;
           IF v_cont   = 100 THEN
                   v_cont  := 0;
                   commit;
           END IF;
   END LOOP;
   commit;
END;
