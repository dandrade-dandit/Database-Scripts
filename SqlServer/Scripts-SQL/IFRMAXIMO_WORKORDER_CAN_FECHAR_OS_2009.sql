DECLARE
    v_dt     ifrmaximo.workorder.statusdate%TYPE := '';
    v_ct     NUMBER (2) := 0;

    CURSOR x
    IS
        SELECT  wonum, glaccount
          FROM  workorder
         WHERE  siteid = 'INFRAERO'
   				 AND  status in ('FECHADO', 'AAPRV', 'ACONDA', 'AGST', 'AGSTC', 'AGSTE', 'AMATL', 'APRG', 'APRV', 'COMP', 'EMAN', 'EMAND')
           AND  wo8 = 0
           AND  reportdate > TO_DATE ('31/12/2008', 'DD/MM/YYYY')
           AND  reportdate < TO_DATE ('01/02/2009', 'DD/MM/YYYY');
BEGIN
    v_dt := TO_DATE ('31/12/2009', 'DD/MM/YYYY');

    FOR b IN x
    LOOP
        V_CT := V_CT + 1;

        UPDATE  workorder
            SET status = 'CAN',
                    statusdate = V_DT,
                    changedate = V_DT,
                    historyflag = 'S',
                    CHANGEBY = 'I9830582'
         WHERE  wonum = b.wonum AND siteid = 'INFRAERO';

        INSERT INTO wostatus (
            wonum,
            changedate,
            glaccount,
            status,
            changeby,
            memo,
            siteid,
            orgid
        )
          VALUES   (
            b.wonum, v_dT, b.glaccount, 'CAN', 'I9830582',
            'OS CANCELADA AUTOMATICAMENTE COM AUTORIZAÇÃO DO SR. LEONARDO SANTOS, GESTOR DO SISTEMA.', 'INFRAERO', 'INFRAERO' );
        IF V_CT = 20
        THEN
            COMMIT;
            V_CT := 0;
        END IF;
    END LOOP;

    COMMIT;
END;
/






DECLARE
    v_dt     ifrmaximo.workorder.statusdate%TYPE := '';
    v_ct     NUMBER (2) := 0;

    CURSOR x
    IS
        SELECT  wonum, glaccount
          FROM  workorder
         WHERE  siteid = 'INFRAERO'
   				 AND  status in ('FECHADO', 'AAPRV', 'ACONDA', 'AGST', 'AGSTC', 'AGSTE', 'AMATL', 'APRG', 'APRV', 'COMP', 'EMAN', 'EMAND')
           AND  wo8 > 0
           AND reportdate >= TO_DATE ('01/01/2009', 'DD/MM/YYYY')
					 AND reportdate  < TO_DATE ('01/01/2010', 'DD/MM/YYYY');
BEGIN
    v_dt := TO_DATE ('31/12/2009', 'DD/MM/YYYY');

    FOR b IN x
    LOOP
        V_CT := V_CT + 1;

        UPDATE  workorder
            SET status = 'FECHADA',
                    statusdate = V_DT,
                    changedate = V_DT,
                    historyflag = 'S',
                    CHANGEBY = 'I9830582'
         WHERE  wonum = b.wonum AND siteid = 'INFRAERO';

        INSERT INTO wostatus (
            wonum,
            changedate,
            glaccount,
            status,
            changeby,
            memo,
            siteid,
            orgid
        )
          VALUES   (
            b.wonum, v_dT, b.glaccount, 'FECHADA', 'I9830582',
            'OS FECHADA AUTOMATICAMENTE COM AUTORIZAÇÃO DO SR. LEONARDO SANTOS, GESTOR DO SISTEMA.', 'INFRAERO', 'INFRAERO' );
        IF V_CT = 20
        THEN
            COMMIT;
            V_CT := 0;
        END IF;
    END LOOP;

    COMMIT;
END;
/
