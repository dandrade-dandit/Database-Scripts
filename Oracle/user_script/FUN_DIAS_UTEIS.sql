CREATE OR REPLACE
FUNCTION        fun_dias_uteis (mes NUMBER, ano NUMBER, p_dep NUMBER DEFAULT 1)
   RETURN NUMBER
IS
   v_quant_dias_uteis   NUMBER (9);
BEGIN
   SELECT COUNT (DATA)
     INTO v_quant_dias_uteis
     FROM (SELECT DATA
             FROM (SELECT TO_DATE (   TO_CHAR (dia, '00')
                                   || TO_CHAR (TO_NUMBER (mes), '00')
                                   || TO_CHAR (TO_NUMBER (ano), '0000'),
                                   'ddmmyyyy'
                                  ) DATA,
                          TO_NUMBER
                             (TO_CHAR (TO_DATE (   TO_CHAR (dia, '00')
                                                || TO_CHAR (TO_NUMBER (mes),
                                                            '00'
                                                           )
                                                || TO_CHAR (TO_NUMBER (ano),
                                                            '0000'
                                                           ),
                                                'ddmmyyyy'
                                               ),
                                       'd'
                                      )
                             ) dia_da_semana
                     FROM (SELECT TO_NUMBER (1) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (2) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (3) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (4) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (5) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (6) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (7) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (8) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (9) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (10) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (11) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (12) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (13) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (14) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (15) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (16) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (17) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (18) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (19) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (20) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (21) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (22) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (23) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (24) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (25) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (26) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (27) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (28) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (29) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (30) dia
                             FROM DUAL
                           UNION
                           SELECT TO_NUMBER (31) dia
                             FROM DUAL)
                    WHERE TO_NUMBER
                             (TO_CHAR
                                 (LAST_DAY
                                         (TO_DATE (   '01'
                                                   || TO_CHAR (TO_NUMBER (mes),
                                                               '00'
                                                              )
                                                   || TO_CHAR (TO_NUMBER (ano),
                                                               '0000'
                                                              ),
                                                   'ddmmyyyy'
                                                  )
                                         ),
                                  'dd'
                                 )
                             ) >= dia)
            WHERE dia_da_semana NOT IN (1, 7)
              AND DATA NOT IN (SELECT dt_feriado  -- retorna os feriados nacionais
																															FROM   FERIADO
																															WHERE  DEP_CD_DEPENDENCIA = 1 -- Devem ser pegos os feriados da SEDE
																															AND    ST_FERIADO = 1         -- Feriados do tipo Nacional
																															UNION
																															SELECT dt_feriado  -- retorna os feriados locais da dependência que está sendo pesquisada
																															FROM   FERIADO
																															WHERE  DEP_CD_DEPENDENCIA = p_dep
																															AND    ST_FERIADO <> 1        -- Feriados locais
																														));

   RETURN v_quant_dias_uteis;
END;
/
