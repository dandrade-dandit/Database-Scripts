/*
*******************************************************************************
**                     === Documentacao da Package ===
**
**  Arquivo....: Climatologico_estatistico_mensal.pro
**  Procedure..: pc_inf_climat_estat_mensal
**  Autor......: Karina Melo
**  Data.......: 03/01/2003
**
**  Objetivo:
**  - Gerar estat�sticas mensais dos seguintes atributos: temperatura do ar, press�o 
**    atmosf�rica, umidade relativa, velocidade do vento, dire��o do vento, precipita��o
**    trovoada, nevoeiro
**  - Package englobando a procedure e as estruturas de retorno.
**
**  Observacoes: 
**
**  Alteracoes:
**   - dd/mm/aa =
**
*******************************************************************************
*/
CREATE OR REPLACE PACKAGE pc_inf_climat_estat_mensal
IS
   TYPE registro            IS RECORD (	ta_media    	NUMBER, -- Temperatura do Ar M�dia Mensal
							ta_maxima		NUMBER, -- Temperatura do Ar M�xima Mensal
							ta_minima		NUMBER, -- Temperatura do Ar M�nima Mensal
							ta_media_max_dia	NUMBER, -- Temperatura do Ar M�dia Mensal das M�ximas Di�rias
							ta_media_min_dia	NUMBER, -- Temperatura do Ar M�dia Mensal das M�nimas Di�rias
							ta_ampl_var_dia	NUMBER, -- Temperatura do Ar Maior Amplitude da Varia��o Di�ria

							pa_media_qfe  	NUMBER, -- Press�o Atmosf�rica M�dia  Mensal ao N�vel da Esta��o    (QFE)
							pa_media_qff  	NUMBER, -- Press�o Atmosf�rica M�dia  Mensal ao N�vel do Mar        (QFF)
							pa_media_qnh  	NUMBER, -- Press�o Atmosf�rica M�dia  Mensal do Ajuste do Alt�metro (QNH)
							pa_max_qfe  	NUMBER, -- Press�o Atmosf�rica M�xima Mensal ao N�vel da Esta��o    (QFE)
							pa_max_qff  	NUMBER, -- Press�o Atmosf�rica M�xima Mensal ao N�vel do Mar        (QFF)
							pa_max_qnh  	NUMBER, -- Press�o Atmosf�rica M�xima Mensal do Ajuste do Alt�metro (QNH)
							pa_min_qfe  	NUMBER, -- Press�o Atmosf�rica M�nima Mensal ao N�vel da Esta��o    (QFE)
							pa_min_qff  	NUMBER, -- Press�o Atmosf�rica M�nima Mensal ao N�vel do Mar        (QFF)
							pa_min_qnh  	NUMBER, -- Press�o Atmosf�rica M�nima Mensal do Ajuste do Alt�metro (QNH)
							pa_media_max_qfe  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�ximas Di�rias ao N�vel da Esta��o    (QFE)
							pa_media_max_qff  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�ximas Di�rias ao N�vel do Mar        (QFF)
							pa_media_max_qnh  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�ximas Di�rias do Ajuste do Alt�metro (QNH)
							pa_media_min_qfe  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�nima Di�rias ao N�vel da Esta��o     (QFE)
							pa_media_min_qff  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�nima Di�rias ao N�vel do Mar         (QFF)
							pa_media_min_qnh  NUMBER, -- Press�o Atmosf�rica M�dia  Mensal das M�nima Di�rias do Ajuste do Alt�metro  (QNH)
							pa_ampl_var_qfe   NUMBER, -- Press�o Atmosf�rica M�dia  Mensal Maior Amplitude de Varia��o Di�ria ao N�vel da Esta��o     (QFE)
							pa_ampl_var_qff   NUMBER, -- Press�o Atmosf�rica M�dia  Mensal Maior Amplitude de Varia��o Di�ria ao N�vel do Mar         (QFF)
							pa_ampl_var_qnh   NUMBER, -- Press�o Atmosf�rica M�dia  Mensal Maior Amplitude de Varia��o Di�ria do Ajuste do Alt�metro  (QNH)

							ur_media    	NUMBER, -- Umidade Relativa M�dia Mensal
							ur_maxima		NUMBER, -- Umidade Relativa M�xima Mensal
							ur_minima		NUMBER, -- Umidade Relativa M�nima Mensal
							ur_media_max_dia	NUMBER, -- Umidade Relativa M�dia Mensal das M�ximas Di�rias
							ur_media_min_dia	NUMBER, -- Umidade Relativa M�dia Mensal das M�nimas Di�rias
							ur_ampl_var_dia	NUMBER, -- Umidade Relativa Maior Amplitude da Varia��o Di�ria

                                          vv_media    	NUMBER, -- Velocidade do Vento M�dia Mensal
							vv_maxima		NUMBER, -- Velocidade do Vento M�xima Mensal
							vv_media_max_dia	NUMBER, -- Velocidade do Vento M�dia Mensal das M�ximas Di�rias
							vv_max_rajada	NUMBER, -- Velocidade do Vento M�xima Rajada Mensal
							vv_media_max_raj	NUMBER, -- Velocidade do Vento das Rajadas M�ximas Di�rias

                                          dv_pred_01    	NUMBER, -- Dire��o do Vento 1� Predomin�ncia Mensal
							dv_pred_02		NUMBER, -- Dire��o do Vento 2� Predomin�ncia Mensal
							dv_pred_03		NUMBER, -- Dire��o do Vento 3� Predomin�ncia Mensal
							dv_tot_ocorr	NUMBER, -- Dire��o do Vento Total Mensal de Ocorr�ncias Perpendiculares ao Eixo Longitudinal da Pista

                                          pr_total_mens     NUMBER, -- Precipita��o Total Mensal
							pr_duracao_mens	NUMBER, -- Precipita��o Dura��o Mensal(em horas e minutos)
							pr_total_dia	NUMBER, -- Precipita��o Total M�ximo Di�rio
							pr_duracao_dia	NUMBER, -- Precipita��o Dura��o M�xima Di�ria (em horas e minuto)

                                          tr_total_dias    	NUMBER, -- Trovoada mensal em dias em que houve ocorr�ncia
							tr_total_horas	NUMBER, -- Trovoada mensal (em horas e minutos) de ocorr�ncia

                                          nv_total_dias    	NUMBER, -- Nevoeiro mensal em dias em que houve ocorr�ncia
							nv_total_horas	NUMBER, -- Nevoeiro mensal (em horas e minutos) de ocorr�ncia
 
                                          cd_unidade_ta     VARCHAR2(20),  -- Unidade de medi��o da temperatura do ar
                                          cd_unidade_pa     VARCHAR2(20),  -- Unidade de medi��o da precipita��o
                                          cd_unidade_ur     VARCHAR2(20),  -- Unidade de medi��o da umidade relativa
                                          cd_unidade_vv     VARCHAR2(20),  -- Unidade de medi��o da velocidade do vento
                                          cd_unidade_dv     VARCHAR2(20),  -- Unidade de medi��o da dire��o do vento
                                          cd_unidade_pr     VARCHAR2(20),  -- Unidade de medi��o da precipita��o
                                          cd_unidade_dp     VARCHAR2(20),  -- Unidade de medi��o da dura��o da precipita��o
                                          cd_unidade_tr     VARCHAR2(20),  -- Unidade de medi��o da trovoada
                                          cd_unidade_nv     VARCHAR2(20)); -- Unidade de medi��o da dura��o do nevoeiro

   TYPE registro_detail IS TABLE OF registro INDEX BY binary_integer;

   PROCEDURE up_inf_climat_estat_mensal (p_id_estacao IN  estacao.id_estacao%type,
                                         p_mes        IN  VARCHAR2,
                                         p_ano        IN  VARCHAR2,
                                         p_retorno    IN  OUT registro_detail);
                                       
END;
/
SHOW ERRORS;
/
CREATE OR REPLACE PACKAGE BODY pc_inf_climat_estat_mensal
AS

/*
*******************************************************************************
**                     === Documentacao da Procedure ===
**
**  Arquivo....: Climatologico_estatistico_mensal.pro
**  Procedure..: up_inf_climat_estat_mensal
**  Autor......: Karina Melo
**  Data.......: 03/01/2003
**
**  Objetivo:
**  - Obter informa��es para relat�rio Climatol�gico Estat�stico Mensal
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
PROCEDURE up_inf_climat_estat_mensal(p_id_estacao IN estacao.id_estacao%type,
                                     p_mes        IN VARCHAR2,
                                     p_ano        IN VARCHAR2,
                                     p_retorno    IN OUT registro_detail)

IS

   /* Defini��o de estruturas */
   tab_registro_detail  registro_detail;

   /* Defini��o de vari�veis */
   w_dt_inicial      DATE;
   w_dt_final        DATE; 
   w_dd_medicao      NUMBER := 0;
   w_vl_medicao      medicao.vl_medicao%type;
   w_no_row          NUMBER := 0;
   w_vl_campo        VARCHAR2(015);
   w_temp_ar         param_geral.cd_opcao%type := NULL;
   w_pa_qfe          param_geral.cd_opcao%type := NULL;
   w_pa_qff          param_geral.cd_opcao%type := NULL;
   w_pa_qnh          param_geral.cd_opcao%type := NULL;
   w_umidade         param_geral.cd_opcao%type := NULL;
   w_vel_vento       param_geral.cd_opcao%type := NULL;
   w_raj_vento       param_geral.cd_opcao%type := NULL;
   w_dir_vento       param_geral.cd_opcao%type := NULL;
   w_precipitacao    param_geral.cd_opcao%type := NULL;
   w_duracao_prec    param_geral.cd_opcao%type := NULL;
   w_trovoada        param_geral.cd_opcao%type := NULL;
   w_nevoeiro        param_geral.cd_opcao%type := NULL;

   w_predominancia   NUMBER;

   /* Defini��o de cursor para recuperar atributos relativos a cada entrada do relat�rio */
   CURSOR Atributos_Relatorio IS
          SELECT cd_opcao, no_ordena1
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = 'EST01'
          ORDER BY no_ordena1;

   /* Defini��o de cursor para recuperar os valores de dire��o do vento */
   CURSOR Predominancia_Vento IS
          SELECT  me1.vl_medicao valor, count(me1.vl_medicao) contador
          FROM medicao me1
          WHERE me1.id_estacao = p_id_estacao
          AND me1.cd_atributo  = w_dir_vento
          AND me1.dt_medicao  >= w_dt_inicial
          AND me1.dt_medicao  <= w_dt_final
          GROUP BY me1.vl_medicao
          ORDER BY 2 DESC;

BEGIN

   /* Analisar passagem de par�metros */
   IF (p_id_estacao IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Esta��o deve ser informada');
   END IF;
   
   IF (p_mes IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'M�s deve ser informado');
   END IF;
   
   IF (p_ano IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ano deve ser informado');
   END IF;

   /* Definir datas */
   w_dt_inicial := to_date('01/' || p_mes || '/' || p_ano , 'dd/mm/rrrr');
   w_dt_final   := last_day(w_dt_inicial);
   
   /* Obter os atributos de cada coluna do relat�rio */
   FOR rec0 IN Atributos_Relatorio LOOP

       /* Verificar atributo obtido */
       IF    (rec0.no_ordena1 = 01) THEN
          w_temp_ar      := rec0.cd_opcao;
       ELSIF (rec0.no_ordena1 = 02) THEN
          w_pa_qfe       := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 03) THEN
          w_pa_qff       := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 04) THEN
          w_pa_qnh       := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 05) THEN
          w_umidade      := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 06) THEN
          w_vel_vento    := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 07) THEN
          w_raj_vento    := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 08) THEN
          w_dir_vento    := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 09) THEN
          w_precipitacao := rec0.cd_opcao;  
       ELSIF (rec0.no_ordena1 = 10) THEN
          w_duracao_prec := rec0.cd_opcao;  
        ELSIF (rec0.no_ordena1 = 11) THEN
          w_trovoada     := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 12) THEN
          w_nevoeiro     := rec0.cd_opcao;   
       END IF;
          
   END LOOP;
   
   /* Inicializar estrutura de retorno */
   tab_registro_detail(1).ta_media         := NULL;
   tab_registro_detail(1).ta_maxima        := NULL;
   tab_registro_detail(1).ta_minima        := NULL;
   tab_registro_detail(1).ta_media_max_dia := NULL;
   tab_registro_detail(1).ta_media_min_dia := NULL;
   tab_registro_detail(1).ta_ampl_var_dia  := NULL;
   tab_registro_detail(1).pa_media_qfe     := NULL;
   tab_registro_detail(1).pa_media_qff     := NULL;
   tab_registro_detail(1).pa_media_qnh     := NULL;
   tab_registro_detail(1).pa_max_qfe       := NULL;
   tab_registro_detail(1).pa_max_qff       := NULL;
   tab_registro_detail(1).pa_max_qnh       := NULL;
   tab_registro_detail(1).pa_min_qfe       := NULL;
   tab_registro_detail(1).pa_min_qff       := NULL;
   tab_registro_detail(1).pa_min_qnh       := NULL;
   tab_registro_detail(1).pa_media_max_qfe := NULL;
   tab_registro_detail(1).pa_media_max_qff := NULL;
   tab_registro_detail(1).pa_media_max_qnh := NULL;
   tab_registro_detail(1).pa_media_min_qfe := NULL;
   tab_registro_detail(1).pa_media_min_qff := NULL;
   tab_registro_detail(1).pa_media_min_qnh := NULL;
   tab_registro_detail(1).pa_ampl_var_qfe  := NULL;
   tab_registro_detail(1).pa_ampl_var_qff  := NULL;
   tab_registro_detail(1).pa_ampl_var_qnh  := NULL;
   tab_registro_detail(1).vv_media         := NULL;
   tab_registro_detail(1).vv_maxima        := NULL;
   tab_registro_detail(1).vv_media_max_dia := NULL;
   tab_registro_detail(1).vv_max_rajada    := NULL;
   tab_registro_detail(1).vv_media_max_raj := NULL;
   tab_registro_detail(1).dv_pred_01       := NULL;
   tab_registro_detail(1).dv_pred_02       := NULL;
   tab_registro_detail(1).dv_pred_03       := NULL;
   tab_registro_detail(1).dv_tot_ocorr     := NULL;
   tab_registro_detail(1).pr_total_mens    := NULL;
   tab_registro_detail(1).pr_duracao_mens  := NULL;
   tab_registro_detail(1).pr_total_dia     := NULL;
   tab_registro_detail(1).pr_duracao_dia   := NULL;
   tab_registro_detail(1).tr_total_dias    := NULL;
   tab_registro_detail(1).tr_total_horas   := NULL;
   tab_registro_detail(1).nv_total_dias    := NULL;
   tab_registro_detail(1).nv_total_horas   := NULL;
   tab_registro_detail(1).cd_unidade_ta    := NULL;
   tab_registro_detail(1).cd_unidade_pa    := NULL;
   tab_registro_detail(1).cd_unidade_ur    := NULL;
   tab_registro_detail(1).cd_unidade_vv    := NULL;
   tab_registro_detail(1).cd_unidade_dv    := NULL;
   tab_registro_detail(1).cd_unidade_pr    := NULL;
   tab_registro_detail(1).cd_unidade_dp    := NULL;
   tab_registro_detail(1).cd_unidade_tr    := NULL;
   tab_registro_detail(1).cd_unidade_nv    := NULL;  

   /* Obter informa��es da temperatura do ar */
   IF (w_temp_ar IS NOT NULL) THEN

      -- Recupera a unidade de medi��o da temperatura do ar na esta��o
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_ta
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_temp_ar;
   
      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).ta_media
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_temp_ar
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao), min(me1.vl_medicao)
      INTO tab_registro_detail(1).ta_maxima, tab_registro_detail(1).ta_minima
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_temp_ar
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;


      SELECT  avg(max(me1.vl_medicao)), avg(min(me1.vl_medicao)), max(max(me1.vl_medicao) - min(me1.vl_medicao))
      INTO tab_registro_detail(1).ta_media_max_dia, tab_registro_detail(1).ta_media_min_dia, tab_registro_detail(1).ta_ampl_var_dia
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_temp_ar
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da press�o atmosf�rica ao n�vel da esta��o */
   IF (w_pa_qfe IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da press�o atmosf�rica ao n�vel da esta��o
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_pa
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_pa_qfe;

      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).pa_media_qfe
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qfe
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao), min(me1.vl_medicao)
      INTO    tab_registro_detail(1).pa_max_qfe, tab_registro_detail(1).pa_min_qfe
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qfe
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao)), avg(min(me1.vl_medicao)), max(max(me1.vl_medicao) - min(me1.vl_medicao))
      INTO tab_registro_detail(1).pa_media_max_qfe, tab_registro_detail(1).pa_media_min_qfe, tab_registro_detail(1).pa_ampl_var_qfe
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qfe
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da press�o atmosf�rica ao n�vel do mar */
   IF (w_pa_qff IS NOT NULL) THEN
   
      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).pa_media_qff
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qff
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao), min(me1.vl_medicao)
      INTO tab_registro_detail(1).pa_max_qff, tab_registro_detail(1).pa_min_qff
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qff
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao)), avg(min(me1.vl_medicao)), max(max(me1.vl_medicao) - min(me1.vl_medicao))
      INTO tab_registro_detail(1).pa_media_max_qff, tab_registro_detail(1).pa_media_min_qff, tab_registro_detail(1).pa_ampl_var_qff
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qff
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;

   END IF;


   /* Obter informa��es da press�o atmosf�rica do ajuste do alt�metro */
   IF (w_pa_qnh IS NOT NULL) THEN
   
      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).pa_media_qnh
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qnh
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao), min(me1.vl_medicao)
      INTO tab_registro_detail(1).pa_max_qnh, tab_registro_detail(1).pa_min_qnh
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qnh
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao)), avg(min(me1.vl_medicao)), max(max(me1.vl_medicao) - min(me1.vl_medicao))
      INTO tab_registro_detail(1).pa_media_max_qnh, tab_registro_detail(1).pa_media_min_qnh, tab_registro_detail(1).pa_ampl_var_qnh
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_pa_qnh
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da umidade relativa */
   IF (w_umidade IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da umidade relativa
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_ur
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_umidade;

      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).ur_media
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_umidade
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao), min(me1.vl_medicao)
      INTO tab_registro_detail(1).ur_maxima, tab_registro_detail(1).ur_minima
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_umidade
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao)), avg(min(me1.vl_medicao)), max(max(me1.vl_medicao) - min(me1.vl_medicao))
      INTO tab_registro_detail(1).ur_media_max_dia, tab_registro_detail(1).ur_media_min_dia, tab_registro_detail(1).ur_ampl_var_dia
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_umidade
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da velocidade do vento */
   IF (w_vel_vento IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da velocidade do vento
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_vv
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_vel_vento;

      /* Definir cursor */
      SELECT  avg(me1.vl_medicao)
      INTO tab_registro_detail(1).vv_media
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_vel_vento
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      AND substr(me1.hr_medicao,3,2) = '00';

      SELECT  max(me1.vl_medicao)
      INTO tab_registro_detail(1).vv_maxima
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_vel_vento
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao))
      INTO tab_registro_detail(1).vv_media_max_dia
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_vel_vento
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da rajada do vento */
   IF (w_raj_vento IS NOT NULL) THEN
   
      /* Definir cursor */
      SELECT  max(me1.vl_medicao)
      INTO tab_registro_detail(1).vv_max_rajada
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_raj_vento
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  avg(max(me1.vl_medicao))
      INTO tab_registro_detail(1).vv_media_max_raj
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_raj_vento
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      

   END IF;

   /* Obter informa��es da predomin�ncia da dire��o do vento */
   IF (w_dir_vento IS NOT NULL) THEN
 
      -- Recupera a unidade de medida da dire��o do vento
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_dv
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_dir_vento;

      w_predominancia := 1;

      FOR rec1 IN Predominancia_Vento LOOP

         IF w_predominancia = 1 THEN
            tab_registro_detail(1).dv_pred_01 := rec1.valor;

         ELSIF w_predominancia = 2 THEN
            tab_registro_detail(1).dv_pred_02 := rec1.valor;

         ELSIF w_predominancia = 3 THEN
            tab_registro_detail(1).dv_pred_03 := rec1.valor;

         END IF;
   
         w_predominancia :=  w_predominancia + 1;

         EXIT WHEN w_predominancia > 3;

      END LOOP;

   END IF;

   /* Obter informa��es da precipita��o */
   IF (w_precipitacao IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da precipita��o
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_pr
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_precipitacao;

      /* Definir cursor */
      SELECT  sum(me1.vl_medicao)
      INTO tab_registro_detail(1).pr_total_mens
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_precipitacao
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  max(sum(me1.vl_medicao))
      INTO tab_registro_detail(1).pr_total_dia
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_precipitacao
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      
   END IF;

  /* Obter informa��es da dura��o da precipita��o */
   IF (w_duracao_prec IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da dura��o da precipita��o
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_dp
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_duracao_prec;

      /* Definir cursor */
      SELECT  sum(me1.vl_medicao)
      INTO tab_registro_detail(1).pr_duracao_mens
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_duracao_prec
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

      SELECT  max(sum(me1.vl_medicao))
      INTO tab_registro_detail(1).pr_duracao_dia
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_duracao_prec
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final
      GROUP BY DT_MEDICAO;
      
   END IF;

   /* Obter informa��es da trovoada */
   IF (w_trovoada IS NOT NULL) THEN
   
      -- Recupera a unidade de medida da trovoada
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_tr
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_trovoada;

      /* Definir cursor */
      SELECT  count(distinct me1.dt_medicao), sum(me1.vl_medicao)
      INTO tab_registro_detail(1).tr_total_dias, tab_registro_detail(1).tr_total_horas
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_trovoada
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

   END IF;

   /* Obter informa��es de nevoeiro */
   IF (w_nevoeiro IS NOT NULL) THEN
   
      -- Recupera a unidade de medida do nevoeiro
      SELECT  max(co1.cd_unidade)
      INTO tab_registro_detail(1).cd_unidade_nv
      FROM corr_atrib_est co1
      WHERE co1.id_estacao = p_id_estacao
      AND co1.cd_atributo  = w_nevoeiro;

      /* Definir cursor */
      SELECT  count(distinct me1.dt_medicao), sum(me1.vl_medicao)
      INTO tab_registro_detail(1).nv_total_dias, tab_registro_detail(1).nv_total_horas
      FROM medicao me1
      WHERE me1.id_estacao = p_id_estacao
      AND me1.cd_atributo  = w_nevoeiro
      AND me1.dt_medicao  >= w_dt_inicial
      AND me1.dt_medicao  <= w_dt_final;

   END IF;

  /* Definir retorno */
  p_retorno := tab_registro_detail;

END up_inf_climat_estat_mensal;

END pc_inf_climat_estat_mensal;
/
SHOW ERRORS;
/
GRANT EXECUTE ON pc_inf_climat_estat_mensal TO bdclim_ger_01
/