CREATE OR REPLACE
FUNCTION FUN_DIAS_REPOUSO_REMUNERADO (p_mes number,
                                      p_ano number,
                                      p_dep number,
                                      p_seq_beneficiario number,
                                      p_flg_tipo_beneficiario varchar2) RETURN NUMBER IS
    -- Função criada para retornar o número de dias de repouso remunerado para estagiários
    -- escalados para trabalhar em dias de feriado.
	cursor c_rep_rem is
		SELECT   SUM(CASE
		            WHEN (c.DATA - f.dat_inicio) < 0 THEN 0
		            WHEN (c.data >= f.dat_inicio and c.data < f.dia_primeira_folga) THEN 1
		            WHEN ABS (MOD ((c.DATA - f.dia_primeira_folga),
		                           (h.num_dias_trabalhados + h.num_dias_folga
		                           )
		                          )
		                     ) < h.num_dias_folga
		               THEN 0
		            ELSE 1
		         END) qtd_rep_rem
		    FROM (SELECT TO_DATE (   TO_CHAR (dia, '00')
		                          || TO_CHAR (TO_NUMBER (p_mes), '00')
		                          || TO_CHAR (TO_NUMBER (p_ano), '0000'),
		                          'ddmmyyyy'
		                         ) DATA,
		                 TO_NUMBER
		                    (TO_CHAR (TO_DATE (   TO_CHAR (dia, '00')
		                                       || TO_CHAR (TO_NUMBER (p_mes), '00')
		                                       || TO_CHAR (TO_NUMBER (p_ano), '0000'),
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
		                     (TO_CHAR (LAST_DAY (TO_DATE (   '01'
		                                                  || TO_CHAR (TO_NUMBER (p_mes),
		                                                              '00'
		                                                             )
		                                                  || TO_CHAR (TO_NUMBER (p_ano),
		                                                              '0000'
		                                                             ),
		                                                  'ddmmyyyy'
		                                                 )
		                                        ),
		                               'dd'
		                              )
		                     ) >= dia) c,
		         cad_escala f,
		         tab_turno g,
		         tab_tipo_escala h,
		         (SELECT *  -- retorna os feriados nacionais
            FROM   FERIADO
            WHERE  DEP_CD_DEPENDENCIA = 1 -- Devem ser pegos os feriados da SEDE
            AND    ST_FERIADO = 1         -- Feriados do tipo Nacional
            UNION
            SELECT *  -- retorna os feriados locais da dependência que está sendo pesquisada
            FROM   FERIADO
            WHERE  DEP_CD_DEPENDENCIA = p_dep
            AND    ST_FERIADO <> 1) i,
		         (SELECT a1.seq_escala,
		                 a1.dat_inicio dt_fim
		            FROM cad_escala a1
		           WHERE a1.seq_beneficiario = p_seq_beneficiario
		             AND  a1.flg_tipo_beneficiario = p_flg_tipo_beneficiario
		             AND (   TO_NUMBER (TO_CHAR (a1.dat_inicio, 'yyyy')) < p_ano
		  		                  OR (    TO_NUMBER (TO_CHAR (a1.dat_inicio, 'yyyy')) = p_ano
		  		             AND TO_NUMBER (TO_CHAR (a1.dat_inicio, 'mm')) <= p_mes
		  		                 )
		  		             )) dt_fim
		 WHERE f.flg_tipo_beneficiario(+) = p_flg_tipo_beneficiario
		     AND f.seq_beneficiario(+) = p_seq_beneficiario
		     AND c.data >= f.dat_inicio
		     AND (dt_fim.dt_fim is null or c.data <= (dt_fim.dt_fim - 1))
		     AND c.data = i.dt_feriado
		     AND f.dia_primeira_folga IS NOT NULL
		     AND f.seq_tipo_escala IS NOT NULL
		     AND f.seq_turno = g.seq_turno(+)
		     AND f.seq_tipo_escala = h.seq_tipo_escala(+)
		     --  Restrições do forms
         AND f.seq_escala < dt_fim.seq_escala(+)
         AND f.dat_inicio <= dt_fim.dt_fim(+)
				     AND (   TO_NUMBER (TO_CHAR (f.dat_inicio, 'yyyy')) < p_ano
				          OR (    TO_NUMBER (TO_CHAR (f.dat_inicio, 'yyyy')) = p_ano
				              AND TO_NUMBER (TO_CHAR (f.dat_inicio, 'mm')) <= p_mes
				             )
				         )
				     AND (dt_fim.dt_fim IS NULL
				          OR (   TO_NUMBER (TO_CHAR (dt_fim.dt_fim, 'yyyy')) > p_ano
				              OR (    TO_NUMBER (TO_CHAR (dt_fim.dt_fim, 'yyyy')) = p_ano
				                  AND TO_NUMBER (TO_CHAR (dt_fim.dt_fim, 'mm')) >= p_mes
				                 )
				             )
				         )
		             AND (    dt_fim.dt_fim IS NULL
		                  OR  dt_fim.dt_fim = (select min(f2.dat_inicio)
		                                         from cad_escala f2
		                                        where f2.seq_escala > f.seq_escala
		                                          and f2.seq_beneficiario = f.seq_beneficiario
		                                          and f2.flg_tipo_beneficiario = f.flg_tipo_beneficiario
		                                          and f2.dat_inicio > f.dat_inicio));
	v_retorno number;
begin
	
  open  c_rep_rem;
  fetch c_rep_rem into v_retorno;
  close c_rep_rem;
	
	return(v_retorno);
	
end;
/
