/*
*******************************************************************************
**                     === Documentacao da Package ===
**
**  Arquivo....: Sumario_mensal_01.pro
**  Procedure..: pc_inf_sumario_mensal_01
**  Autor......: Marco Cesare
**  Data.......: 14/06/2002
**
**  Objetivo:
**  - Package englobando a procedure e as estruturas de retorno.
**
**  Observacoes: 
**
**  Alteracoes:
**   - dd/mm/aa =
**
*******************************************************************************
*/
CREATE OR REPLACE PACKAGE pc_inf_sumario_mensal_01
IS
   TYPE registro            IS RECORD (dd_medicao   NUMBER,
                                       cd_dir_vento VARCHAR2(015),
                                       vl_vento     VARCHAR2(015),
                                       vl_rajada    VARCHAR2(015),
                                       vl_temp_min  NUMBER,
                                       vl_temp_max  NUMBER,
                                       vl_temp_med  NUMBER,
                                       vl_pres_min  NUMBER,
                                       vl_pres_max  NUMBER,
                                       vl_pres_med  NUMBER,
                                       vl_dur_prec  VARCHAR2(015),
                                       vl_tot_prec  NUMBER,
                                       vl_dur_1500  VARCHAR2(015),
                                       vl_dur_5000  VARCHAR2(015),
                                       vl_dur_150   VARCHAR2(015),
                                       vl_dur_450   VARCHAR2(015),
                                       vl_ur        NUMBER,
                                       vl_dur_trov  VARCHAR2(015),
                                       vl_dur_nevoa VARCHAR2(015));

   TYPE registro_detail IS TABLE OF registro INDEX BY binary_integer;

   PROCEDURE up_inf_sumario_mensal_01 (p_id_estacao IN  estacao.id_estacao%type,
                                       p_mes        IN  VARCHAR2,
                                       p_ano        IN  VARCHAR2,
                                       p_no_pista   IN  medicao.no_pista%type DEFAULT NULL,
                                       p_retorno    IN  OUT registro_detail);
                                       
END;
/
SHOW ERRORS;
/
CREATE OR REPLACE PACKAGE BODY pc_inf_sumario_mensal_01
AS

/*
*******************************************************************************
**                     === Documentacao da Procedure ===
**
**  Arquivo....: Sumario_mensal_01.pro
**  Procedure..: up_inf_sumario_mensal_01
**  Autor......: Marco Cesare
**  Data.......: 14/06/2002
**
**  Objetivo:
**  - Obter informações para relatório de Sumário Climatológico Mensal 01.
**
**  Tabelas Usadas:
**  - Consulta: medicao
**  - Atualiza:
**
**  Observacoes: 
**
**  Alteracoes:
**   - dd/mm/aa =
**
*******************************************************************************
*/
PROCEDURE up_inf_sumario_mensal_01 (p_id_estacao IN estacao.id_estacao%type,
                                    p_mes        IN VARCHAR2,
                                    p_ano        IN VARCHAR2,
                                    p_no_pista   IN medicao.no_pista%type  DEFAULT NULL,
                                    p_retorno    IN OUT registro_detail)

IS

   /* Definição de estruturas */
   tab_registro_detail  registro_detail;

   /* Definição de variáveis */
   w_dt_inicial      DATE;
   w_dt_final        DATE; 
   w_dd_medicao      NUMBER := 0;
   w_vl_medicao      medicao.vl_medicao%type;
   w_qt_dias         NUMBER := 0;
   w_no_row          NUMBER := 0;
   w_vl_campo        VARCHAR2(015);
   w_dir_vento       param_geral.cd_opcao%type := NULL;
   w_vl_vento        param_geral.cd_opcao%type := NULL; 
   w_temp            param_geral.cd_opcao%type := NULL; 
   w_pressao         param_geral.cd_opcao%type := NULL; 
   w_dur_prec        param_geral.cd_opcao%type := NULL; 
   w_tot_prec        param_geral.cd_opcao%type := NULL; 
   w_dur_1500        param_geral.cd_opcao%type := NULL; 
   w_dur_5000        param_geral.cd_opcao%type := NULL; 
   w_dur_150         param_geral.cd_opcao%type := NULL; 
   w_dur_450         param_geral.cd_opcao%type := NULL; 
   w_ur              param_geral.cd_opcao%type := NULL; 
   w_dur_trov        param_geral.cd_opcao%type := NULL; 
   w_dur_nevoa       param_geral.cd_opcao%type := NULL; 
   w_rajada          param_geral.cd_opcao%type := NULL; 
   
   /* Definição de cursor */
   CURSOR Atributos_Relatorio IS
          SELECT cd_opcao, no_ordena1
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = 'SUM01'
          ORDER BY no_ordena1;

BEGIN

   /* Analisar passagem de parâmetros */
   IF (p_id_estacao IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Estação deve ser informada');
   END IF;
   
   IF (p_mes IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Mês deve ser informado');
   END IF;
   
   IF (p_ano IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ano deve ser informado');
   END IF;

   /* Definir datas */
   w_dt_inicial := to_date('01/' || p_mes || '/' || p_ano , 'dd/mm/rrrr');
   w_dt_final   := last_day(w_dt_inicial);
   
   /* Obter os atributos de cada coluna do relatório */
   FOR rec0 IN Atributos_Relatorio LOOP

       /* Verificar atributo obtido */
       IF    (rec0.no_ordena1 = 01) THEN
          w_dir_vento    := rec0.cd_opcao;
       ELSIF (rec0.no_ordena1 = 02) THEN
          w_vl_vento     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 03) THEN
          w_temp         := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 04) THEN
          w_pressao      := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 05) THEN
          w_dur_prec     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 06) THEN
          w_tot_prec     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 07) THEN
          w_dur_1500     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 08) THEN
          w_dur_5000     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 09) THEN
          w_dur_150      := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 10) THEN
          w_dur_450      := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 11) THEN
          w_ur           := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 12) THEN
          w_dur_trov     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 13) THEN
          w_dur_nevoa    := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 14) THEN
          w_rajada       := rec0.cd_opcao;   
       END IF;
          
   END LOOP;
   
   /* Definir quantidade de dias */
   SELECT (w_dt_final - w_dt_inicial + 1) 
   INTO   w_qt_dias 
   FROM DUAL;

   /* Inserir quantidade de linhas correspondentes ao número de dias do mês */
   FOR i IN 1..(w_qt_dias + 1) LOOP
       tab_registro_detail(i).dd_medicao   := i;
       tab_registro_detail(i).cd_dir_vento := NULL;
       tab_registro_detail(i).vl_vento     := NULL;
       tab_registro_detail(i).vl_rajada    := NULL;
       tab_registro_detail(i).vl_temp_min  := NULL;
       tab_registro_detail(i).vl_temp_max  := NULL;
       tab_registro_detail(i).vl_temp_med  := NULL;
       tab_registro_detail(i).vl_pres_min  := NULL;
       tab_registro_detail(i).vl_pres_max  := NULL;
       tab_registro_detail(i).vl_pres_med  := NULL;
       tab_registro_detail(i).vl_dur_prec  := NULL;
       tab_registro_detail(i).vl_tot_prec  := NULL;
       tab_registro_detail(i).vl_dur_1500  := NULL;
       tab_registro_detail(i).vl_dur_5000  := NULL;
       tab_registro_detail(i).vl_dur_150   := NULL;
       tab_registro_detail(i).vl_dur_450   := NULL;
       tab_registro_detail(i).vl_ur        := NULL;
       tab_registro_detail(i).vl_dur_trov  := NULL;
       tab_registro_detail(i).vl_dur_nevoa := NULL;
   END LOOP;

   /* Obter informações da velocidade do vento */
   IF (w_vl_vento IS NOT NULL) THEN
   
      /* Definir cursor */
      FOR rec1 IN (SELECT me1.dt_medicao, 
                          me1.vl_medicao,
                          max(me1.no_pista  ) no_pista, 
                          max(me1.hr_medicao) hr_medicao
                   FROM medicao me1
                   WHERE me1.id_estacao   = p_id_estacao
                     AND me1.cd_atributo  = w_vl_vento
                     AND me1.no_pista     = nvl(p_no_pista, me1.no_pista)
                     AND me1.dt_medicao  >= w_dt_inicial
                     AND me1.dt_medicao  <= w_dt_final
                     AND me1.vl_medicao   = (SELECT max(me2.vl_medicao)
                                             FROM medicao me2
                                             WHERE me2.id_estacao   = p_id_estacao
                                               AND me2.cd_atributo  = w_vl_vento
                                               AND me2.no_pista     = nvl(p_no_pista, me2.no_pista)
                                               AND me2.dt_medicao   = me1.dt_medicao)
                   GROUP BY me1.dt_medicao, me1.vl_medicao) LOOP

          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec1.dt_medicao, 'dd'));

          /* Atribuir valor da velocidade à linha correspondente */
          tab_registro_detail(w_dd_medicao).vl_vento := to_char(rec1.vl_medicao);
          
          /* Obter informações da direção do vento */
          IF (w_dir_vento IS NOT NULL) THEN

             SELECT max(vl_medicao) INTO w_vl_medicao
             FROM medicao
             WHERE id_estacao   = p_id_estacao
               AND cd_atributo  = w_dir_vento
               AND no_pista     = rec1.no_pista
               AND dt_medicao   = rec1.dt_medicao
               AND hr_medicao   = rec1.hr_medicao;
               
             /* Atribuir valor da direção à linha correspondente */
             IF (w_vl_medicao IS NOT NULL) THEN
                tab_registro_detail(w_dd_medicao).cd_dir_vento := to_char(w_vl_medicao);
             END IF;
             
          END IF;
                   
      END LOOP;

   END IF;
   
   /* Obter informações das temperaturas mínimas e máximas */
   IF (w_temp IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec2 IN (SELECT dt_medicao, 
                          round(max(vl_medicao),2) vl_max, 
                          round(min(vl_medicao),2) vl_min
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_temp
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
      
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec2.dt_medicao, 'dd'));

          /* Atribuir valor das temperaturas à linha correspondente */
          tab_registro_detail(w_dd_medicao).vl_temp_min  := rec2.vl_min;
          tab_registro_detail(w_dd_medicao).vl_temp_max  := rec2.vl_max;

          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_temp_min := nvl(tab_registro_detail(w_qt_dias + 1).vl_temp_min, 0) + rec2.vl_min;
          tab_registro_detail(w_qt_dias + 1).vl_temp_max := nvl(tab_registro_detail(w_qt_dias + 1).vl_temp_max, 0) + rec2.vl_max;

      END LOOP;
      
      /* Calcular média das temperaturas */
      IF (tab_registro_detail(w_qt_dias + 1).vl_temp_min IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_temp_min := round(tab_registro_detail(w_qt_dias + 1).vl_temp_min / w_qt_dias,2);
      END IF;

      IF (tab_registro_detail(w_qt_dias + 1).vl_temp_max IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_temp_max := round(tab_registro_detail(w_qt_dias + 1).vl_temp_max / w_qt_dias,2);
      END IF;

   END IF;

   /* Obter informações das pressões mínimas e máximas */
   IF (w_pressao IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec3 IN (SELECT dt_medicao, 
                          round(max(vl_medicao),2) vl_max, 
                          round(min(vl_medicao),2) vl_min
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_pressao
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
      
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec3.dt_medicao, 'dd'));

          /* Atribuir valor das pressões à linha correspondente */
          tab_registro_detail(w_dd_medicao).vl_pres_min  := rec3.vl_min;
          tab_registro_detail(w_dd_medicao).vl_pres_max  := rec3.vl_max;

          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_pres_min := nvl(tab_registro_detail(w_qt_dias + 1).vl_pres_min, 0) + rec3.vl_min;
          tab_registro_detail(w_qt_dias + 1).vl_pres_max := nvl(tab_registro_detail(w_qt_dias + 1).vl_pres_max, 0) + rec3.vl_max;
                   
      END LOOP;

      /* Calcular média das pressões */
      IF (tab_registro_detail(w_qt_dias + 1).vl_pres_min IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_pres_min := round(tab_registro_detail(w_qt_dias + 1).vl_pres_min / w_qt_dias,2);
      END IF;
      
      IF (tab_registro_detail(w_qt_dias + 1).vl_pres_max <> '0') THEN
          tab_registro_detail(w_qt_dias + 1).vl_pres_max := round(tab_registro_detail(w_qt_dias + 1).vl_pres_max / w_qt_dias,2);
      END IF;
      
   END IF;

   /* Obter informações da duração da precipitação */
   IF (w_dur_prec IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec4 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_dur_prec
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec4.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec4.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_prec  := substr(to_char(100 * (100 + trunc(rec4.vl_medicao / 60)) + mod(rec4.vl_medicao ,60)),2,4);

             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_prec := to_char(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_prec) + rec4.vl_medicao);
             
          END IF;
                   
      END LOOP;
      
      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_prec := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_prec) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_prec) ,60)),2,4);
      
   END IF;
   
   /* Obter informações do total de precipitação */
   IF (w_tot_prec IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec5 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_tot_prec
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
      
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec5.dt_medicao, 'dd'));

          /* Atribuir valor da precipitação */
          tab_registro_detail(w_dd_medicao).vl_tot_prec  := rec5.vl_medicao;
             
          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_tot_prec := nvl(tab_registro_detail(w_qt_dias + 1).vl_tot_prec, 0) + rec5.vl_medicao;
                   
      END LOOP;
      
   END IF;
   
   /* Obter informações da duração da visibilidade < 1500M */
   IF (w_dur_1500 IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec6 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_dur_1500
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec6.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec6.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_1500  := substr(to_char(100 * (100 + trunc(rec6.vl_medicao / 60)) + mod(rec6.vl_medicao ,60)),2,4);
             
             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_1500 := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_1500, 0)) + rec6.vl_medicao);

          END IF;
                   
      END LOOP;
      
      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_1500 := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_1500) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_1500) ,60)),2,4);

   END IF;
   
   /* Obter informações da duração da visibilidade > 1500M e menor < 5000 */
   IF (w_dur_5000 IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec7 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_dur_5000
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec7.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec7.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_5000 := substr(to_char(100 * (100 + trunc(rec7.vl_medicao / 60)) + mod(rec7.vl_medicao ,60)),2,4);

             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_5000 := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_5000, 0)) + rec7.vl_medicao);
             
          END IF;
                   
      END LOOP;

      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_5000 := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_5000) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_5000) ,60)),2,4);
      
   END IF;

   /* Obter informações da duração do teto < 150M */
   IF (w_dur_150 IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec8 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_dur_150
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec8.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec8.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_150 := substr(to_char(100 * (100 + trunc(rec8.vl_medicao / 60)) + mod(rec8.vl_medicao ,60)),2,4);

             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_150 := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_150, 0)) + rec8.vl_medicao);
             
          END IF;
                   
      END LOOP;
      
      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_150 := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_150) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_150) ,60)),2,4);

   END IF;

   /* Obter informações da duração do teto > 150M e < 450M */
   IF (w_dur_450 IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec9 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                   FROM medicao 
                   WHERE id_estacao   = p_id_estacao
                     AND cd_atributo  = w_dur_450
                     AND no_pista     = nvl(p_no_pista, no_pista)
                     AND dt_medicao  >= w_dt_inicial
                     AND dt_medicao  <= w_dt_final
                   GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec9.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec9.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_450  := substr(to_char(100 * (100 + trunc(rec9.vl_medicao / 60)) + mod(rec9.vl_medicao ,60)),2,4);
             
             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_450 := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_450, 0)) + rec9.vl_medicao);

          END IF;
                   
      END LOOP;

      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_450 := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_450) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_450) ,60)),2,4);
      
   END IF;

   /* Obter informações da Umidade Relativa */
   IF (w_ur IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec10 IN (SELECT dt_medicao, round(avg(vl_medicao),0) vl_medicao
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_ur
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                      AND substr(hr_medicao,3,2) = '00'
                    GROUP BY dt_medicao) LOOP
          
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec10.dt_medicao, 'dd'));

          /* Atribuir valor da Umidade Relativa */
          tab_registro_detail(w_dd_medicao).vl_ur  := rec10.vl_medicao;

          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_ur := nvl(tab_registro_detail(w_qt_dias + 1).vl_ur, 0) + rec10.vl_medicao;
                  
      END LOOP;
      
      /* Calcular média da umidade relativa */
      IF (tab_registro_detail(w_qt_dias + 1).vl_ur IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_ur := round(tab_registro_detail(w_qt_dias + 1).vl_ur / w_qt_dias,2);
      END IF;
      
   END IF;

   /* Obter informações da duração da trovoada */
   IF (w_dur_trov IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec11 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_dur_trov
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                    GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec11.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec11.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_trov  := substr(to_char(100 * (100 + trunc(rec11.vl_medicao / 60)) + mod(rec11.vl_medicao ,60)),2,4);
             
             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_trov := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_trov, 0)) + rec11.vl_medicao);

          END IF;
                   
      END LOOP;

      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_trov := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_trov) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_trov) ,60)),2,4);
      
   END IF;

   /* Obter informações da duração da névoa */
   IF (w_dur_nevoa IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec12 IN (SELECT dt_medicao, sum(vl_medicao) vl_medicao
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_dur_nevoa
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                    GROUP BY dt_medicao) LOOP
          
          /* Verificar se é maior que zero */
          IF (rec12.vl_medicao > 0) THEN
      
             /* Definir dia da medição */
             w_dd_medicao := to_number(to_char(rec12.dt_medicao, 'dd'));

             /* Atribuir valor da duração */
             tab_registro_detail(w_dd_medicao).vl_dur_nevoa  := substr(to_char(100 * (100 + trunc(rec12.vl_medicao / 60)) + mod(rec12.vl_medicao ,60)),2,4);

             /* Atribuir valor ao total */
             tab_registro_detail(w_qt_dias + 1).vl_dur_nevoa := to_char(to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_dur_nevoa, 0)) + rec12.vl_medicao);
             
          END IF;
                   
      END LOOP;
      
      /* Definir total */
      tab_registro_detail(w_qt_dias + 1).vl_dur_nevoa := substr(to_char(100 * (100 + trunc(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_nevoa) / 60)) + mod(to_number(tab_registro_detail(w_qt_dias + 1).vl_dur_nevoa) ,60)),2,4);

   END IF;

   /* Obter informações da temperatura média */
   IF (w_temp IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec13 IN (SELECT dt_medicao, 
                           round(avg(vl_medicao),2) vl_med
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_temp
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                      AND substr(hr_medicao,3,2) = '00'
                    GROUP BY dt_medicao) LOOP
       
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec13.dt_medicao, 'dd'));

          /* Atribuir valor das temperaturas à linha correspondente */
          tab_registro_detail(w_dd_medicao).vl_temp_med  := rec13.vl_med;

          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_temp_med := nvl(tab_registro_detail(w_qt_dias + 1).vl_temp_med, 0) + rec13.vl_med;

      END LOOP;
      
      /* Calcular média das temperaturas */
      IF (tab_registro_detail(w_qt_dias + 1).vl_temp_med IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_temp_med := round(tab_registro_detail(w_qt_dias + 1).vl_temp_med / w_qt_dias,2);
      END IF;

   END IF;

   /* Obter informações das pressões médias */
   IF (w_pressao IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec14 IN (SELECT dt_medicao, 
                           round(avg(vl_medicao),2) vl_med
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_pressao
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                      AND substr(hr_medicao,3,2) = '00'
                    GROUP BY dt_medicao) LOOP
      
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec14.dt_medicao, 'dd'));

          /* Atribuir valor das pressões à linha correspondente */
          tab_registro_detail(w_dd_medicao).vl_pres_med  := rec14.vl_med;

          /* Atribuir valor ao total */
          tab_registro_detail(w_qt_dias + 1).vl_pres_med := nvl(tab_registro_detail(w_qt_dias + 1).vl_pres_med, 0) + rec14.vl_med;
                   
      END LOOP;

      /* Calcular média das pressões */
      IF (tab_registro_detail(w_qt_dias + 1).vl_pres_med IS NOT NULL) THEN
          tab_registro_detail(w_qt_dias + 1).vl_pres_med := round(tab_registro_detail(w_qt_dias + 1).vl_pres_med / w_qt_dias,2);
      END IF;
      
   END IF;

   /* Obter informações da rajada */
   IF (w_rajada IS NOT NULL) THEN   
   
      /* Definir cursor */
      FOR rec15 IN (SELECT dt_medicao, max(vl_medicao) vl_medicao
                    FROM medicao 
                    WHERE id_estacao   = p_id_estacao
                      AND cd_atributo  = w_rajada
                      AND no_pista     = nvl(p_no_pista, no_pista)
                      AND dt_medicao  >= w_dt_inicial
                      AND dt_medicao  <= w_dt_final
                    GROUP BY dt_medicao) LOOP
          
          /* Definir dia da medição */
          w_dd_medicao := to_number(to_char(rec15.dt_medicao, 'dd'));

          /* Atribuir valor da rajada */
          tab_registro_detail(w_dd_medicao).vl_rajada   := to_char(rec15.vl_medicao);
                   
      END LOOP;

   END IF;
   
   /* Analisar linha do valor máximo (ou velocidade ou rajada) */
   FOR i IN 1..w_qt_dias LOOP
   
       /* Verificar maior valor */
       IF (tab_registro_detail(i).vl_vento IS NOT NULL) THEN
         
          /* Verificar velocidade do vento */
          IF (to_number(tab_registro_detail(i).vl_vento) >= to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_vento, '-9999999'))) THEN
             tab_registro_detail(w_qt_dias + 1).vl_vento := tab_registro_detail(i).vl_vento;
             w_no_row                                    := i;
          END IF;
          
       END IF;
       
       IF (tab_registro_detail(i).vl_rajada IS NOT NULL) THEN
         
          /* Verificar rajada */
          IF (to_number(tab_registro_detail(i).vl_rajada) >= to_number(nvl(tab_registro_detail(w_qt_dias + 1).vl_vento, '-9999999'))) THEN
             tab_registro_detail(w_qt_dias + 1).vl_vento := tab_registro_detail(i).vl_rajada;
             w_no_row                                    := i;
          END IF;
          
       END IF;
       

   END LOOP;   
   
   /* Verificar linha de maior velocidade do vento ou rajada */
   IF (w_no_row > 0) THEN
   
      /* Atribuir valores */
      tab_registro_detail(w_qt_dias + 1).cd_dir_vento := tab_registro_detail(w_no_row).cd_dir_vento;
      tab_registro_detail(w_qt_dias + 1).vl_vento     := tab_registro_detail(w_no_row).vl_vento;
      tab_registro_detail(w_qt_dias + 1).vl_rajada    := tab_registro_detail(w_no_row).vl_rajada;
      
   END IF;

   /* Definir retorno */
   p_retorno := tab_registro_detail;

END up_inf_sumario_mensal_01;

END pc_inf_sumario_mensal_01;
/
SHOW ERRORS;
/
GRANT EXECUTE ON pc_inf_sumario_mensal_01 TO bdclim_ger_01
/