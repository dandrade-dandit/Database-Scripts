-- Start of DDL Script for Function IFRVGA.FC_APLSEG_SITUACAO_OBAPSG_SGS
-- Generated 13-jan-2004 9:48:25 from IFRVGA@homolog

-- Drop the old instance of FC_APLSEG_SITUACAO_OBAPSG_SGS
DROP FUNCTION fc_aplseg_situacao_obapsg_sgs
/

CREATE OR REPLACE 
FUNCTION fc_aplseg_situacao_obapsg_sgs
(piNumAplseg IN INTEGER,
 piNumObapsg IN INTEGER,
 piNumVersao IN INTEGER,
 pdDataIni   IN DATE,
 pdDataFim   IN DATE)

  RETURN VARCHAR2 IS

 CURSOR Obj_Apl_Seg(iNumAplseg IN INTEGER, iNumObapsg IN INTEGER,  iNumVersao IN INTEGER,dDataIni IN DATE, dDataFim IN DATE) IS

SELECT OBAPSG.NUM_APLSEG,
       OBAPSG.NUM_OBAPSG,
       OBAPSG.NUM_VERSAO_OBAPSG,
       VRSMIN.VERSAO_MIN,
       VRSMAX.VERSAO_MAX,
       OBAPSG.DAT_INIVGC_OBAPSG,
       OBAPSG.DAT_FIMVGC_OBAPSG,
       APLSEG.DAT_INIVGC_APLSEG,
       APLSEG.DAT_FIMVGC_APLSEG,
       OBAPSG.MRC_EXCLSO_OBAPSG,
       OBAPSG.DCR_MTVEXC_OBAPSG,
       OBAPSG.SIT_OBAPSG

FROM
  (SELECT OBAPSG1.NUM_APLSEG,
          OBAPSG1.NUM_OBAPSG,
          MAX(OBAPSG1.NUM_VERSAO_OBAPSG) AS VERSAO_MAX
   FROM  OBJTO_APOLICE_SEGURO_SGS OBAPSG1
   WHERE (OBAPSG1.DAT_FIMVGC_OBAPSG  >= dDataIni                 -- INCIO PERIODO
     AND  OBAPSG1.DAT_INIVGC_OBAPSG  <= dDataFim)                -- FIM PERIODO
   GROUP BY OBAPSG1.NUM_APLSEG,
            OBAPSG1.NUM_OBAPSG
  )VRSMAX,

  (SELECT OBAPSG2.NUM_APLSEG,
          OBAPSG2.NUM_OBAPSG,
          MIN(OBAPSG2.NUM_VERSAO_OBAPSG) AS VERSAO_MIN
   FROM  OBJTO_APOLICE_SEGURO_SGS OBAPSG2
   WHERE (OBAPSG2.DAT_FIMVGC_OBAPSG  >= dDataIni                 -- INCIO PERIODO
     AND  OBAPSG2.DAT_INIVGC_OBAPSG  <= dDataFim)                -- FIM PERIODO
   GROUP BY OBAPSG2.NUM_APLSEG,
            OBAPSG2.NUM_OBAPSG
  )VRSMIN,

OBJTO_APOLICE_SEGURO_SGS OBAPSG,
APOLICE_SEGURO_SGS       APLSEG

 WHERE (OBAPSG.NUM_APLSEG         =  iNumAplseg)
   AND (OBAPSG.NUM_OBAPSG         =  iNumObapsg)
   AND (OBAPSG.NUM_VERSAO_OBAPSG  =  iNumVersao)
   AND (APLSEG.NUM_APLSEG         =  OBAPSG.NUM_APLSEG)
   AND ((OBAPSG.DAT_INIVGC_OBAPSG >= APLSEG.DAT_INIVGC_APLSEG  -- INCIO VIGENCIA APOLICE
   AND   OBAPSG.DAT_FIMVGC_OBAPSG <= APLSEG.DAT_FIMVGC_APLSEG) -- FIM VIGENCIA APOLICE
   AND (OBAPSG.DAT_FIMVGC_OBAPSG  >= dDataIni                  -- INCIO PERIODO
   AND  OBAPSG.DAT_INIVGC_OBAPSG  <= dDataFim))                -- FIM PERIODO
   AND VRSMAX.NUM_APLSEG = OBAPSG.NUM_APLSEG
   AND VRSMAX.NUM_OBAPSG = OBAPSG.NUM_OBAPSG
   AND VRSMIN.NUM_APLSEG = OBAPSG.NUM_APLSEG
   AND VRSMIN.NUM_OBAPSG = OBAPSG.NUM_OBAPSG

 ORDER BY  OBAPSG.NUM_APLSEG,
           OBAPSG.NUM_OBAPSG,
           OBAPSG.NUM_VERSAO_OBAPSG;

 /*  DECLARA  VARIAVEIS  */
   ObjApsg Obj_Apl_Seg%ROWTYPE;  -- Alias

   SITUACAO VARCHAR2 (50);

BEGIN

  OPEN  Obj_Apl_Seg(piNumAplseg,piNumObapsg, piNumVersao, pdDataIni, pdDataFim);
  FETCH Obj_Apl_Seg INTO ObjApsg;
  CLOSE Obj_Apl_Seg;

  IF (((ObjApsg.SIT_OBAPSG='E')OR((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))AND(pdDataFim>=ObjApsg.DAT_FIMVGC_OBAPSG)) THEN
    SITUACAO := 'EXCLUIDO';
  ELSE
    IF (((ObjApsg.SIT_OBAPSG='E')OR((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))
       AND(pdDataFim<ObjApsg.DAT_FIMVGC_OBAPSG))AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN) THEN
       SITUACAO := 'SUBSTITUIDOR';
    ELSE
      IF (((ObjApsg.SIT_OBAPSG='E')OR((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))
        AND(pdDataFim<ObjApsg.DAT_FIMVGC_OBAPSG))AND(ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MIN) THEN
        SITUACAO := 'EXCLUIDO';
      ELSE
        IF (((((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND NOT(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))AND(pdDataFim>=ObjApsg.DAT_FIMVGC_OBAPSG))
           AND (ObjApsg.SIT_OBAPSG='A')) THEN
          SITUACAO := 'ALTERADO';
        ELSE
          IF ((((ObjApsg.MRC_EXCLSO_OBAPSG='S') AND NOT(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto'))) AND (pdDataFim >= ObjApsg.DAT_FIMVGC_OBAPSG)) THEN
            SITUACAO := 'SUBSTITUIDO';
          ELSE
            IF (((((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND NOT(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))
              AND(pdDataFim<ObjApsg.DAT_FIMVGC_OBAPSG))AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN)AND(ObjApsg.SIT_OBAPSG='D')) THEN
              SITUACAO := 'ALTERADOR';
            ELSE
              IF ((((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND NOT(ObjApsg.DCR_MTVEXC_OBAPSG='Endosso - Exclusao Objeto')))
                AND(pdDataFim<ObjApsg.DAT_FIMVGC_OBAPSG))AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN) THEN
                SITUACAO := 'SUBSTITUIDOR';
              ELSE
                IF (((ObjApsg.MRC_EXCLSO_OBAPSG='N')AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN))AND(ObjApsg.SIT_OBAPSG='D')
                   AND(ObjApsg.NUM_VERSAO_OBAPSG=1)) THEN
                   SITUACAO := 'ATIVO';
                ELSE
                  IF (((ObjApsg.MRC_EXCLSO_OBAPSG='N')AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN))AND(ObjApsg.SIT_OBAPSG='D')) THEN
                    SITUACAO := 'SUBSTITUIDOR';
                  ELSE
                    IF ((ObjApsg.MRC_EXCLSO_OBAPSG='N')AND(ObjApsg.NUM_VERSAO_OBAPSG>ObjApsg.VERSAO_MIN))AND(TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_INIVGC_OBAPSG,'MM')) THEN
                      SITUACAO := 'SUBSTITUIDOR';
                    ELSE
                      IF ((ObjApsg.MRC_EXCLSO_OBAPSG='N')AND(ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MIN)AND((TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_INIVGC_OBAPSG,'MM'))
                        AND(ObjApsg.NUM_VERSAO_OBAPSG=1))) THEN
                        SITUACAO := 'INCLUIDO';
                      ELSE
                        IF ((ObjApsg.MRC_EXCLSO_OBAPSG='N')AND(ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MIN)AND((pdDataIni=ObjApsg.DAT_INIVGC_OBAPSG)
                          AND(ObjApsg.NUM_VERSAO_OBAPSG=1))) THEN
                          SITUACAO := 'INCLUIDO';
                        ELSE
                          IF ((ObjApsg.MRC_EXCLSO_OBAPSG='S')AND(ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MIN)AND((TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_INIVGC_OBAPSG,'MM'))
                            AND(ObjApsg.NUM_VERSAO_OBAPSG=1))AND(ObjApsg.SIT_OBAPSG = 'I')) THEN
                            SITUACAO := 'INCLUIDO';
                          ELSE
                            IF ((ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MIN)AND((pdDataIni<=ObjApsg.DAT_INIVGC_OBAPSG)AND(ObjApsg.NUM_VERSAO_OBAPSG=1))AND(ObjApsg.SIT_OBAPSG = 'I')) THEN
                              SITUACAO := 'INCLUIDO';
                            ELSE
                              IF ((ObjApsg.NUM_VERSAO_OBAPSG=0)AND(ObjApsg.DAT_INIVGC_APLSEG=ObjApsg.DAT_INIVGC_OBAPSG)) THEN
                                SITUACAO := 'ATIVO';
                              ELSE
                                IF (((ObjApsg.MRC_EXCLSO_OBAPSG='S'))AND(TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_INIVGC_OBAPSG,'MM'))) THEN
                                  SITUACAO := 'SUBSTITUIDOR';
                                ELSE
                                  IF (((ObjApsg.MRC_EXCLSO_OBAPSG='N'))AND(TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_INIVGC_OBAPSG,'MM')))THEN
                                    SITUACAO := 'SUBSTITUIDOR';
                                  ELSE
                                    IF (((ObjApsg.MRC_EXCLSO_OBAPSG='N'))AND(ObjApsg.NUM_VERSAO_OBAPSG=ObjApsg.VERSAO_MAX)AND(TO_CHAR(pdDataFim,'MM')=TO_CHAR(ObjApsg.DAT_FIMVGC_APLSEG,'MM'))) --THEN
                                      AND (TO_CHAR(pdDataFim,'MM')<>TO_CHAR(ObjApsg.DAT_INIVGC_APLSEG,'MM')) THEN
                                      SITUACAO := 'ATIVO';              --SITUACAO := 'SUBSTITUIDOR';
                                    ELSE
                                      SITUACAO := 'ATIVO';


                                    END IF;
                                  END IF;
                                END IF;
                              END IF;
                            END IF;
                          END IF;
                        END IF;
                      END IF;
                    END IF;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
  END IF;

  RETURN(SITUACAO); -- RESULTADO

END FC_APLSEG_SITUACAO_OBAPSG_SGS;
/



-- End of DDL Script for Function IFRVGA.FC_APLSEG_SITUACAO_OBAPSG_SGS

