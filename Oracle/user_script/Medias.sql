/*
******************************************************************************
*  - Tabelas Temporarias para Calculo das Medias
******************************************************************************
*/
DROP   TABLE temp_inf_medias2;
DROP   TABLE temp_inf_medias3;
DROP   TABLE temp_inf_medias4;
/* Primeira Medicao por Atributo e Estacao */
CREATE TABLE temp_inf_medias2(
           sessionid       number  (10)  not null,
           id_estacao      number  (06)  not null,
           cd_atributo     varchar2(04)  not null,
           no_pista        varchar2(20)  not null,
           dt_pri_medicao  date              null
) STORAGE (INITIAL 100K NEXT 100K)
/
GRANT SELECT, INSERT, UPDATE, DELETE ON temp_inf_medias2 TO bdclim_ger_01
/
/* Ultima Medicao por Atributo e Estacao */
CREATE TABLE temp_inf_medias3
(
           sessionid       number  (10)  not null,
           id_estacao      number  (06)  not null,
           cd_atributo     varchar2(04)  not null,
           no_pista        varchar2(20)  not null,
           pc_minimo       number  (03)  not null,
           dt_ult_calculo  date          not null,
           dt_fim_calculo  date              null
) STORAGE (INITIAL 100K NEXT 100K)
/
GRANT SELECT, INSERT, UPDATE, DELETE ON temp_inf_medias3 TO bdclim_ger_01
/
/* Medicoes extremas por Atributo e Estacao */
CREATE TABLE temp_inf_medias4
(
           sessionid       number(10)    not null,
           dt_medicao      date          not null,
           no_dias         NUMBER(04)        null,
           vl_medicao      NUMBER(16,6)      null
) STORAGE (INITIAL 100K NEXT 100K)
/
GRANT SELECT, INSERT, UPDATE, DELETE ON temp_inf_medias3 TO bdclim_ger_01
/

/*
*******************************************************************************
**  Geracao de dado do tipo Media
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_media (p_id_estacao          IN estacao.id_estacao%type,
                                                  p_cd_atributo         IN medicao.cd_atributo%type,
                                                  p_no_pista            IN medicao.no_pista%type,
                                                  p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                  p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                  p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                  p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                  p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                  p_dt_inicial          IN date,
                                                  p_dt_final            IN date,
                                                  p_vl_altitude         IN estacao.vl_altitude%type,
                                                  p_vl_latitude         IN estacao.vl_latitude%type,
                                                  p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;

   CURSOR Geracao_Media IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 avg(vl_medicao) vl_media,
                 count(distinct dt_medicao || hr_medicao) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao  = nvl(p_hr_obs_atrib_origem, hr_medicao))
            AND  (substr(hr_medicao,3,2) = '00')
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao );

BEGIN

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Media LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (p_cd_grupo_dado = 'D') AND (rec1.no_dias < (p_pc_minimo * 1   / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'C') AND (rec1.no_dias < (p_pc_minimo * 10  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'M') AND (rec1.no_dias < (p_pc_minimo * 30  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'A') AND (rec1.no_dias < (p_pc_minimo * 360 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao  ,
                                   p_cd_atributo ,
                                   p_no_pista    ,
                                   rec1.dt_media ,
                                   '0000'        ,
                                   p_vl_altitude ,
                                   p_vl_latitude ,
                                   p_vl_longitude, 
                                   rec1.vl_media ,
                                   0             ,
                                   null          ,
                                   'N'           ,
                                   w_cd_erro);

       END IF;

   END LOOP;

END up_inf_geracao_media;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Maxima
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_maxima(p_id_estacao          IN estacao.id_estacao%type,
                                                  p_cd_atributo         IN medicao.cd_atributo%type,
                                                  p_no_pista            IN medicao.no_pista%type,
                                                  p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                  p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                  p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                  p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                  p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                  p_dt_inicial          IN date,
                                                  p_dt_final            IN date,
                                                  p_vl_altitude         IN estacao.vl_altitude%type,
                                                  p_vl_latitude         IN estacao.vl_latitude%type,
                                                  p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;

   CURSOR Geracao_Maxima IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 max(vl_medicao) vl_media,
                 count(distinct dt_medicao || hr_medicao) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao  = nvl(p_hr_obs_atrib_origem, hr_medicao))
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao );

BEGIN

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Maxima LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (p_cd_grupo_dado = 'D') AND (rec1.no_dias < (p_pc_minimo * 1   / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'C') AND (rec1.no_dias < (p_pc_minimo * 10  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'M') AND (rec1.no_dias < (p_pc_minimo * 30  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'A') AND (rec1.no_dias < (p_pc_minimo * 360 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao  ,
                                   p_cd_atributo ,
                                   p_no_pista    ,
                                   rec1.dt_media ,
                                   '0000'        ,
                                   p_vl_altitude ,
                                   p_vl_latitude ,
                                   p_vl_longitude, 
                                   rec1.vl_media ,
                                   0             ,
                                   null          ,
                                   'N'           ,
                                   w_cd_erro);

       END IF;

   END LOOP;

END up_inf_geracao_maxima;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Maxima Horária
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_maxima_hr(p_id_estacao          IN estacao.id_estacao%type,
                                                     p_cd_atributo         IN medicao.cd_atributo%type,
                                                     p_no_pista            IN medicao.no_pista%type,
                                                     p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                     p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                     p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                     p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                     p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                     p_dt_inicial          IN date,
                                                     p_dt_final            IN date,
                                                     p_vl_altitude         IN estacao.vl_altitude%type,
                                                     p_vl_latitude         IN estacao.vl_latitude%type,
                                                     p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;

   CURSOR Geracao_Maxima_Hr IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 hr_medicao,
                 max(vl_medicao) vl_media,
                 count(distinct dt_medicao || hr_medicao) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao  = nvl(p_hr_obs_atrib_origem, hr_medicao))
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ),
                   hr_medicao;

BEGIN

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Maxima_Hr LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (rec1.no_dias < (p_pc_minimo * 1 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao   ,
                                   p_cd_atributo  ,
                                   p_no_pista     ,
                                   rec1.dt_media  ,
                                   rec1.hr_medicao,
                                   p_vl_altitude  ,
                                   p_vl_latitude  ,
                                   p_vl_longitude , 
                                   rec1.vl_media  ,
                                   0              ,
                                   null           ,
                                   'N'            ,
                                   w_cd_erro); 

       END IF;

   END LOOP;

END up_inf_geracao_maxima_hr;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Maxima Horária em 6 horas
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_maxima_6hr(p_id_estacao          IN estacao.id_estacao%type,
                                                      p_cd_atributo         IN medicao.cd_atributo%type,
                                                      p_no_pista            IN medicao.no_pista%type,
                                                      p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                      p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                      p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                      p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                      p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                      p_dt_inicial          IN date,
                                                      p_dt_final            IN date,
                                                      p_vl_altitude         IN estacao.vl_altitude%type,
                                                      p_vl_latitude         IN estacao.vl_latitude%type,
                                                      p_vl_longitude        IN estacao.vl_longitude%type)

IS

   j             INTEGER;
   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;
   w_hr_inicial  medicao.hr_medicao%type;
   w_hr_final    medicao.hr_medicao%type;

   CURSOR Geracao_Maxima_6Hr IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 w_hr_inicial hr_medicao,
                 max(vl_medicao) vl_media,
                 count(*) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao >= w_hr_inicial)
            AND  (hr_medicao <  w_hr_final)
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao );

BEGIN

   /* Loop para os 4 horários do dia */
   FOR j IN 1..4 LOOP

      /* Definir horários */
      IF    (j = 1) THEN
         w_hr_inicial := '0000';
         w_hr_final   := '0600';
      ELSIF (j = 2) THEN
         w_hr_inicial := '0600';
         w_hr_final   := '1200';
      ELSIF (j = 3) THEN
         w_hr_inicial := '1200';
         w_hr_final   := '1800';
      ELSE
         w_hr_inicial := '1800';
         w_hr_final   := '2400';
      END IF;
      
      /* Loop sobre os valores resgatados */
      FOR rec1 IN Geracao_Maxima_6Hr LOOP

          /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
          IF    (rec1.no_dias < (p_pc_minimo * 1 / 100)) THEN
             w_fl_pcminimo := FALSE;
          ELSE
             w_fl_pcminimo := TRUE;
          END IF;

          /* Verificar se existem registros suficientes para calculo */
          IF w_fl_pcminimo THEN

             /* Efetivacao da tabela de Medicao */
             up_inf_efetiva_medicao  (p_id_estacao   ,
                                      p_cd_atributo  ,
                                      p_no_pista     ,
                                      rec1.dt_media  ,
                                      rec1.hr_medicao,
                                      p_vl_altitude  ,
                                      p_vl_latitude  ,
                                      p_vl_longitude , 
                                      rec1.vl_media  ,
                                      0              ,
                                      null           ,
                                      'N'            ,
                                      w_cd_erro); 
   
          END IF;

      END LOOP;
   
   END LOOP;

END up_inf_geracao_maxima_6hr;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Mínima
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_minima(p_id_estacao          IN estacao.id_estacao%type,
                                                  p_cd_atributo         IN medicao.cd_atributo%type,
                                                  p_no_pista            IN medicao.no_pista%type,
                                                  p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                  p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                  p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                  p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                  p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                  p_dt_inicial          IN date,
                                                  p_dt_final            IN date,
                                                  p_vl_altitude         IN estacao.vl_altitude%type,
                                                  p_vl_latitude         IN estacao.vl_latitude%type,
                                                  p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;

   CURSOR Geracao_Minima IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 min(vl_medicao) vl_media,
                 count(distinct dt_medicao || hr_medicao) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao  = nvl(p_hr_obs_atrib_origem, hr_medicao))
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao );

BEGIN

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Minima LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (p_cd_grupo_dado = 'D') AND (rec1.no_dias < (p_pc_minimo * 1   / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'C') AND (rec1.no_dias < (p_pc_minimo * 10  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'M') AND (rec1.no_dias < (p_pc_minimo * 30  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'A') AND (rec1.no_dias < (p_pc_minimo * 360 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao  ,
                                   p_cd_atributo ,
                                   p_no_pista    ,
                                   rec1.dt_media ,
                                   '0000'        ,
                                   p_vl_altitude ,
                                   p_vl_latitude ,
                                   p_vl_longitude, 
                                   rec1.vl_media ,
                                   0             ,
                                   null          ,
                                   'N'           ,
                                   w_cd_erro);

       END IF;

   END LOOP;

END up_inf_geracao_minima;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Hora
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_hora  (p_id_estacao          IN estacao.id_estacao%type,
                                                  p_cd_atributo         IN medicao.cd_atributo%type,
                                                  p_no_pista            IN medicao.no_pista%type,
                                                  p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                  p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                  p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                  p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                  p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                  p_dt_inicial          IN date,
                                                  p_dt_final            IN date,
                                                  p_vl_altitude         IN estacao.vl_altitude%type,
                                                  p_vl_latitude         IN estacao.vl_latitude%type,
                                                  p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_cd_erro            NUMBER(004) := 0;
   w_qt_horas           NUMBER(004) := 0;
   w_diferenca          NUMBER(004) := 0;
   w_vl_medicao_str     medicao.vl_medicao_str%type;
   w_vl_medicao_str_aux medicao.vl_medicao_str%type;
   w_hr_inicio          medicao.hr_medicao%type;
   w_hr_final           medicao.hr_medicao%type;
   w_count              INTEGER;

   CURSOR Geracao_Hora IS
          SELECT hr_medicao,
                 vl_medicao_str
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao  = p_dt_inicial)
          ORDER BY 1,2;

BEGIN

   /* Inicializar variáveis */
   w_hr_inicio  := NULL;
   w_hr_final   := NULL;
   w_qt_horas   := 0;
   
   /* Testar se atributo é diário */
   IF (p_cd_grupo_dado <> 'D') THEN
      RETURN;
   END IF;

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Hora LOOP
   
       /* Inicializar variáveis */
       w_vl_medicao_str_aux := rtrim(rec1.vl_medicao_str);
       w_vl_medicao_str     := '';
       
       /* Loop para colocar zeros a esquerda dos números */
       WHILE (rtrim(w_vl_medicao_str_aux) IS NOT NULL) LOOP

             /* Localizar separador de observação */
             w_count := instr(w_vl_medicao_str_aux, ',');
                               
             /* Verificar se encontrou separador */
             IF (w_count > 0) THEN
                w_vl_medicao_str     := w_vl_medicao_str || substr(to_char(100 + to_number(substr(w_vl_medicao_str_aux, 01, w_count - 1))),2,2) || ',';
                w_vl_medicao_str_aux := rtrim(substr(w_vl_medicao_str_aux, w_count + 1, 50));
             ELSE
                w_vl_medicao_str     := w_vl_medicao_str || substr(to_char(100 + to_number(w_vl_medicao_str_aux)),2,2);
                w_vl_medicao_str_aux := NULL;
             END IF;
             
       END LOOP;

       /* Obter algum atributo_codigo para o atributo */
       SELECT count(*) INTO w_count
       FROM atributo_codigo
       WHERE  cd_atributo = p_cd_atributo 
         AND  w_vl_medicao_str like '%' || vl_atributo || '%';

       /* Analisar retorno */
       IF (w_count > 0) THEN
       
          /* Define hora inicial se ainda não encontrou */
          IF (w_hr_inicio IS NULL) THEN
             w_hr_inicio := rec1.hr_medicao;
          ELSE
          
             /* Verificar alguma hora sem medição no intervalo */
             w_diferenca := (to_number(substr(rec1.hr_medicao,1,2)) * 60) + (to_number(substr(rec1.hr_medicao,3,2))) - 
                            (to_number(substr(w_hr_final     ,1,2)) * 60) - (to_number(substr(w_hr_final ,3,2)));
                            
             IF (w_diferenca > 60) THEN
                w_qt_horas  := w_qt_horas + 60;
                w_hr_inicio := rec1.hr_medicao;
             END IF;

          END IF;

          w_hr_final     := rec1.hr_medicao;

       ELSE   
          
          /* Verificar se alguma ocorrência existiu previamente */
          IF (w_hr_inicio IS NOT NULL) THEN
             
             /* Verificar alguma hora sem medição no intervalo */
             w_diferenca := (to_number(substr(rec1.hr_medicao,1,2)) * 60) + (to_number(substr(rec1.hr_medicao,3,2))) - 
                            (to_number(substr(w_hr_inicio    ,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                            
             IF (w_diferenca > 60) THEN
                w_qt_horas := w_qt_horas + 60;
             ELSE
                w_qt_horas := w_qt_horas + w_diferenca;
             END IF;

             /* Inicializar horário */
             w_hr_inicio := NULL;
             w_hr_final  := NULL;
             
          END IF;
                        
       END IF;

   END LOOP;

   /* Analisar possível última ocorrência */
   IF (w_hr_inicio IS NOT NULL) THEN
      w_qt_horas  := w_qt_horas  + ((to_number(substr(w_hr_final,1,2)) + 1) * 60) - 
                                    (to_number(substr(w_hr_inicio,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
   END IF;
       
   /* Efetivacao da tabela de Medicao */
   IF (w_qt_horas > 0) THEN

      up_inf_efetiva_medicao  (p_id_estacao  ,
                               p_cd_atributo ,
                               p_no_pista    ,
                               p_dt_inicial  ,
                               '0000'        ,
                               p_vl_altitude ,
                               p_vl_latitude ,
                               p_vl_longitude, 
                               w_qt_horas    ,
                               0             ,
                               null          ,
                               'N'           ,
                               w_cd_erro);
   END IF;                 

END up_inf_geracao_hora;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Hora Máxima
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_horamaxima(p_id_estacao          IN estacao.id_estacao%type,
                                                      p_cd_atributo         IN medicao.cd_atributo%type,
                                                      p_no_pista            IN medicao.no_pista%type,
                                                      p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                      p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                      p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                      p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                      p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                      p_dt_inicial          IN date,
                                                      p_dt_final            IN date,
                                                      p_vl_altitude         IN estacao.vl_altitude%type,
                                                      p_vl_latitude         IN estacao.vl_latitude%type,
                                                      p_vl_longitude        IN estacao.vl_longitude%type)
IS

   /* Definição de variáveis */
   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;
   wsessionid    NUMBER;

   /* Definição de cursor */
   CURSOR Geracao_HoraMaxima IS
          SELECT me4.dt_medicao dt_media,
                 me4.no_dias,
                 max(mv1.hr_medicao) vl_media
          FROM   temp_inf_medias4 me4, medicao mv1
          WHERE  (pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, mv1.dt_medicao) = me4.dt_medicao)
            AND  (mv1.vl_medicao  = me4.vl_medicao)
            AND  (wsessionid      = me4.sessionid)
            AND  (mv1.id_estacao  = p_id_estacao)
            AND  (mv1.cd_atributo = p_cd_atributo_origem)
            AND  (mv1.no_pista    = p_no_pista)
            AND  (mv1.hr_medicao  = nvl(p_hr_obs_atrib_origem, mv1.hr_medicao))
          GROUP BY me4.dt_medicao, me4.no_dias;

BEGIN

   /* Obtendo o Numero SESSIONID para Tabela Temporaria */
   SELECT userenv('sessionid') INTO wsessionid FROM dual;

   /* Apagando todos os registros da tabela temporaria de medicoes extremas */
   DELETE temp_inf_medias4 
   WHERE sessionid = wsessionid;

   /* Obtendo valores maximos para todo o periodo */
   INSERT INTO temp_inf_medias4
   SELECT wsessionid,
          pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao),
          count(distinct dt_medicao),
          max(vl_medicao)
   FROM   medicao
   WHERE  (id_estacao   = p_id_estacao)
     AND  (cd_atributo  = p_cd_atributo_origem)
     AND  (no_pista     = p_no_pista)
     AND  (dt_medicao  >= p_dt_inicial)
     AND  (dt_medicao  <= p_dt_final)
     AND  (hr_medicao   = nvl(p_hr_obs_atrib_origem, hr_medicao))
   GROUP by pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao);

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_HoraMaxima LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (p_cd_grupo_dado = 'D') AND (rec1.no_dias < (p_pc_minimo * 1   / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'C') AND (rec1.no_dias < (p_pc_minimo * 10  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'M') AND (rec1.no_dias < (p_pc_minimo * 30  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'A') AND (rec1.no_dias < (p_pc_minimo * 360 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao  ,
                                   p_cd_atributo ,
                                   p_no_pista    ,
                                   rec1.dt_media ,
                                   '0000'        ,
                                   p_vl_altitude ,
                                   p_vl_latitude ,
                                   p_vl_longitude, 
                                   null          ,
                                   0             ,
                                   substr(rec1.vl_media,1,20),
                                   'S'           ,
                                   w_cd_erro);

       END IF;

   END LOOP;

   /* Apagando todos os registros da tabela temporaria de medicoes extremas */
   DELETE temp_inf_medias4
   WHERE  sessionid = wsessionid;

END up_inf_geracao_horamaxima;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Porcentagem Parametrizada
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_porcentagem(p_id_estacao          IN estacao.id_estacao%type,
                                                       p_cd_atributo         IN medicao.cd_atributo%type,
                                                       p_no_pista            IN medicao.no_pista%type,
                                                       p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                       p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                       p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                       p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                       p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                       p_dt_inicial          IN date,
                                                       p_dt_final            IN date,
                                                       p_vl_altitude         IN estacao.vl_altitude%type,
                                                       p_vl_latitude         IN estacao.vl_latitude%type,
                                                       p_vl_longitude        IN estacao.vl_longitude%type)
IS

   /* Definição de variáveis */
   w_fl_pcminimo BOOLEAN    := TRUE;
   w_count       NUMBER(02) := 0;
   w_count_ok    NUMBER(02) := 0;
   w_count_tot   NUMBER(02) := 0;
   w_cd_erro     NUMBER(04) := 0;
   
   w_cd_opcaoa   param_geral.cd_opcao%type;
   w_cd_opcaob   param_geral.cd_opcao%type;
   w_no_ordena1a param_geral.no_ordena1%type;
   w_no_ordena1b param_geral.no_ordena1%type;
   w_no_ordena2a param_geral.no_ordena2%type;
   w_no_ordena2b param_geral.no_ordena2%type;

   w_vl_medicaoa medicao.vl_medicao%type;
   w_vl_medicaob medicao.vl_medicao%type;
   w_vl_medicao  medicao.vl_medicao%type;

   /* Definição de cursores */
   CURSOR Geracao_Porcentagem IS
          SELECT hr_medicao,
                 min(vl_medicao) vl_medicao
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = w_cd_opcaoa)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao  = p_dt_inicial)
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ),
                   hr_medicao;

   CURSOR Geracao_Porcentagem_Atributo IS
          SELECT cd_opcao, no_ordena1, no_ordena2
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = p_cd_atributo;

BEGIN

   /* Inicializar variáveis
   w_cd_opcaoa := NULL;
   w_cd_opcaob := NULL;
   
   /* Loop sobre os valores resgatados para os atributos */
   FOR rec0 IN Geracao_Porcentagem_Atributo LOOP

       /* Incrementar índice */
       w_count := w_count + 1;
   
       /* Verificar índice */
       IF    (w_count = 1) THEN
          w_cd_opcaoa   := rec0.cd_opcao;
          w_no_ordena1a := rec0.no_ordena1;
          w_no_ordena2a := rec0.no_ordena2;
       ELSIF (w_count = 2) THEN
          w_cd_opcaob   := rec0.cd_opcao;
          w_no_ordena1b := rec0.no_ordena1;
          w_no_ordena2b := rec0.no_ordena2;
       END IF;
       
   END LOOP;
       
   /* Verificar quantidade de itens relacionados
   IF ((w_count > 2) OR (w_count < 1)) THEN
      RETURN;
   END IF;
   
   /* Inicializar variáveis */
   w_count      := 0;
   w_count_ok   := 0;
   w_count_tot  := 0;
   w_vl_medicao := NULL;

   /* Loop sobre os valores resgatados para valores */
   FOR rec1 IN Geracao_Porcentagem LOOP

       /* Incrementar quantidade para teste de percentual mínimo */
       w_count_tot := w_count_tot + 1;
 
       /* Verificar se valor está dentro dos parâmetros */
       IF ((rec1.vl_medicao >= w_no_ordena1a) AND (rec1.vl_medicao <= w_no_ordena2a)) THEN
       
          /* Verificar se deve testar o segundo parâmetro */
          IF (w_cd_opcaob IS NOT NULL) THEN
          
             /* Obter dados do segundo parâmetro */
             SELECT min(vl_medicao) INTO w_vl_medicao
             FROM   medicao
             WHERE  (id_estacao  = p_id_estacao)
               AND  (cd_atributo = w_cd_opcaob)
               AND  (no_pista    = p_no_pista)
               AND  (dt_medicao  = p_dt_inicial)
               AND  (hr_medicao  = rec1.hr_medicao);
               
             /* Verificar retorno */
             IF (w_vl_medicao IS NOT NULL) THEN
             
                /* Verificar se está dentro dos parâmetros */
                IF ((w_vl_medicao >= w_no_ordena1b) AND (w_vl_medicao <= w_no_ordena2b)) THEN
                
                   /* Analisar se valores são diferentes do anterior */
                   IF ((rec1.vl_medicao <> w_vl_medicaoa) OR (w_vl_medicao <> w_vl_medicaob)) THEN
                      w_count_ok := w_count_ok + 1;
                   END IF;
                   
                END IF;
                
             END IF;
             
             /* Atribuir valores */
             w_vl_medicaob := w_vl_medicao;
             
          ELSE
          
             /* Analisar se valores são diferentes do anterior */
             IF ((rec1.vl_medicao <> w_vl_medicaoa) OR (w_vl_medicaoa IS NULL)) THEN
                w_count_ok := w_count_ok + 1;
             END IF;
             
          END IF;
          
       ELSE
          w_count := w_count + 1;
       END IF;
      
       /* Atribuir valores */
       w_vl_medicaoa := rec1.vl_medicao;

   END LOOP;

   /* Analisar valores mínimos para inserção no banco */
   IF ((w_count_tot >= (p_pc_minimo * 24 / 100)) AND ((w_count + w_count_ok) > 0)) THEN
   
      /* Efetivacao da tabela de Medicao */
      up_inf_efetiva_medicao  (p_id_estacao  ,
                               p_cd_atributo ,
                               p_no_pista    ,
                               p_dt_inicial  ,
                               '0000'        ,
                               p_vl_altitude ,
                               p_vl_latitude ,
                               p_vl_longitude, 
                               (w_count_ok * 100) / (w_count + w_count_ok),
                               0             ,
                               null          ,
                               'N'           ,
                               w_cd_erro);

   END IF;

END up_inf_geracao_porcentagem;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Frequência Parametrizada
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_frequencia(p_id_estacao          IN estacao.id_estacao%type,
                                                      p_cd_atributo         IN medicao.cd_atributo%type,
                                                      p_no_pista            IN medicao.no_pista%type,
                                                      p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                      p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                      p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                      p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                      p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                      p_dt_inicial          IN date,
                                                      p_dt_final            IN date,
                                                      p_vl_altitude         IN estacao.vl_altitude%type,
                                                      p_vl_latitude         IN estacao.vl_latitude%type,
                                                      p_vl_longitude        IN estacao.vl_longitude%type)
IS

   /* Definição de variáveis */
   w_fl_pcminimo BOOLEAN    := TRUE;
   w_count       NUMBER(02) := 0;
   w_count_ok    NUMBER(02) := 0;
   w_count_tot   NUMBER(02) := 0;
   w_cd_erro     NUMBER(04) := 0;
   w_hr_inicio   medicao.hr_medicao%type;
   
   w_cd_opcaoa   param_geral.cd_opcao%type;
   w_cd_opcaob   param_geral.cd_opcao%type;
   w_no_ordena1a param_geral.no_ordena1%type;
   w_no_ordena1b param_geral.no_ordena1%type;
   w_no_ordena2a param_geral.no_ordena2%type;
   w_no_ordena2b param_geral.no_ordena2%type;

   w_vl_medicaoa medicao.vl_medicao%type;
   w_vl_medicaob medicao.vl_medicao%type;
   w_vl_medicao  medicao.vl_medicao%type;

   /* Definição de cursores */
   CURSOR Geracao_Frequencia IS
          SELECT hr_medicao,
                 min(vl_medicao) vl_medicao
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = w_cd_opcaoa)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao  = p_dt_inicial)
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ),
                   hr_medicao;

   CURSOR Geracao_Frequencia_Atributo IS
          SELECT cd_opcao, no_ordena1, no_ordena2
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = p_cd_atributo;

BEGIN

   /* Inicializar variáveis
   w_cd_opcaoa := NULL;
   w_cd_opcaob := NULL;
   
   /* Loop sobre os valores resgatados para os atributos */
   FOR rec0 IN Geracao_Frequencia_Atributo LOOP

       /* Incrementar índice */
       w_count := w_count + 1;
   
       /* Verificar índice */
       IF    (w_count = 1) THEN
          w_cd_opcaoa   := rec0.cd_opcao;
          w_no_ordena1a := rec0.no_ordena1;
          w_no_ordena2a := rec0.no_ordena2;
       ELSIF (w_count = 2) THEN
          w_cd_opcaob   := rec0.cd_opcao;
          w_no_ordena1b := rec0.no_ordena1;
          w_no_ordena2b := rec0.no_ordena2;
       END IF;
       
   END LOOP;
       
   /* Verificar quantidade de itens relacionados
   IF ((w_count > 2) OR (w_count < 1)) THEN
      RETURN;
   END IF;
   
   /* Inicializar variáveis */
   w_count      := 0;
   w_count_ok   := 0;
   w_count_tot  := 0;
   w_vl_medicao := NULL;
   w_hr_inicio  := NULL;

   /* Loop sobre os valores resgatados para valores */
   FOR rec1 IN Geracao_Frequencia LOOP

       /* Incrementar quantidade para teste de percentual mínimo */
       w_count_tot := w_count_tot + 1;
 
       /* Verificar se valor está dentro dos parâmetros */
       IF ((rec1.vl_medicao >= w_no_ordena1a) AND (rec1.vl_medicao <= w_no_ordena2a)) THEN
       
          /* Verificar se deve testar o segundo parâmetro */
          IF (w_cd_opcaob IS NOT NULL) THEN
          
             /* Obter dados do segundo parâmetro */
             SELECT min(vl_medicao) INTO w_vl_medicao
             FROM   medicao
             WHERE  (id_estacao  = p_id_estacao)
               AND  (cd_atributo = w_cd_opcaob)
               AND  (no_pista    = p_no_pista)
               AND  (dt_medicao  = p_dt_inicial)
               AND  (hr_medicao  = rec1.hr_medicao);
               
             /* Verificar retorno */
             IF (w_vl_medicao IS NOT NULL) THEN
             
                /* Verificar se está dentro dos parâmetros */
                IF ((w_vl_medicao >= w_no_ordena1b) AND (w_vl_medicao <= w_no_ordena2b)) THEN
                
                   /* Define hora inicial se ainda não encontrou */
                   IF (w_hr_inicio IS NULL) THEN
                      w_hr_inicio := rec1.hr_medicao;
                      w_count_ok  := w_count_ok + 1;
                   END IF;
                   
                END IF;
                
             ELSE
                w_count     := w_count + 1;
                w_hr_inicio := NULL;
             END IF;
             
          ELSE
          
             /* Define hora inicial se ainda não encontrou */
             IF (w_hr_inicio IS NULL) THEN
                w_hr_inicio := rec1.hr_medicao;
                w_count_ok  := w_count_ok + 1;
             END IF;
             
          END IF;
          
       ELSE
          w_count     := w_count + 1;
          w_hr_inicio := NULL;
       END IF;
      
       /* Atribuir valores */
       w_vl_medicaoa := rec1.vl_medicao;

   END LOOP;

   /* Analisar valores mínimos para inserção no banco */
   IF ((w_count_tot >= (p_pc_minimo * 24 / 100)) AND (w_count_ok > 0)) THEN
   
      /* Efetivacao da tabela de Medicao */
      up_inf_efetiva_medicao  (p_id_estacao  ,
                               p_cd_atributo ,
                               p_no_pista    ,
                               p_dt_inicial  ,
                               '0000'        ,
                               p_vl_altitude ,
                               p_vl_latitude ,
                               p_vl_longitude, 
                               w_count_ok    ,
                               0             ,
                               null          ,
                               'N'           ,
                               w_cd_erro);

   END IF;

END up_inf_geracao_Frequencia;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Total de Horas Parametrizada
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_totalhoras(p_id_estacao          IN estacao.id_estacao%type,
                                                      p_cd_atributo         IN medicao.cd_atributo%type,
                                                      p_no_pista            IN medicao.no_pista%type,
                                                      p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                      p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                      p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                      p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                      p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                      p_dt_inicial          IN date,
                                                      p_dt_final            IN date,
                                                      p_vl_altitude         IN estacao.vl_altitude%type,
                                                      p_vl_latitude         IN estacao.vl_latitude%type,
                                                      p_vl_longitude        IN estacao.vl_longitude%type)
IS

   /* Definição de variáveis */
   w_fl_pcminimo BOOLEAN    := TRUE;
   w_count       NUMBER(02) := 0;
   w_hr_inicio   medicao.hr_medicao%type;
   w_qt_horas    NUMBER(04) := 0;
   w_cd_erro     NUMBER(04) := 0;
   w_dt_medicao  DATE;
   
   w_cd_opcaoa   param_geral.cd_opcao%type;
   w_cd_opcaob   param_geral.cd_opcao%type;
   w_no_ordena1a param_geral.no_ordena1%type;
   w_no_ordena1b param_geral.no_ordena1%type;
   w_no_ordena2a param_geral.no_ordena2%type;
   w_no_ordena2b param_geral.no_ordena2%type;
   w_vl_medicao  medicao.vl_medicao%type;

   /* Definição de cursores */
   CURSOR Geracao_Totalhoras IS
          SELECT hr_medicao,
                 min(vl_medicao) vl_medicao
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = w_cd_opcaoa)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao  = w_dt_medicao)
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ),
                   hr_medicao;

   CURSOR Geracao_Totalhoras_Atributo IS
          SELECT cd_opcao, no_ordena1, no_ordena2
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = p_cd_atributo;

BEGIN

   /* Inicializar variáveis */
   w_cd_opcaoa  := NULL;
   w_cd_opcaob  := NULL;
   w_dt_medicao := p_dt_inicial;

   /* Loop sobre os valores resgatados para os atributos */
   FOR rec0 IN Geracao_Totalhoras_Atributo LOOP

       /* Incrementar índice */
       w_count := w_count + 1;
   
       /* Verificar índice */
       IF    (w_count = 1) THEN
          w_cd_opcaoa   := rec0.cd_opcao;
          w_no_ordena1a := rec0.no_ordena1;
          w_no_ordena2a := rec0.no_ordena2;
       ELSIF (w_count = 2) THEN
          w_cd_opcaob   := rec0.cd_opcao;
          w_no_ordena1b := rec0.no_ordena1;
          w_no_ordena2b := rec0.no_ordena2;
       END IF;
       
   END LOOP;
       
   /* Verificar quantidade de itens relacionados
   IF ((w_count > 2) OR (w_count < 1)) THEN
      RETURN;
   END IF;

   /* Loop sobre as datas */
   WHILE (w_dt_medicao <= p_dt_final) LOOP
   
         /* Inicializar variáveis */
         w_count      := 0;
         w_qt_horas   := 0;
         w_hr_inicio  := NULL;

         /* Loop sobre os valores resgatados para valores */
         FOR rec1 IN Geracao_Totalhoras LOOP

             /* Incrementar quantidade para teste de percentual mínimo */
             w_count := w_count + 1;
 
             /* Verificar se valor está dentro dos parâmetros */
             IF ((rec1.vl_medicao >= w_no_ordena1a) AND (rec1.vl_medicao <= w_no_ordena2a)) THEN
        
                /* Verificar se deve testar o segundo parâmetro */
                IF (w_cd_opcaob IS NOT NULL) THEN
          
                   /* Obter dados do segundo parâmetro */
                   SELECT min(vl_medicao) INTO w_vl_medicao
                   FROM   medicao
                   WHERE  (id_estacao  = p_id_estacao)
                     AND  (cd_atributo = w_cd_opcaob)
                     AND  (no_pista    = p_no_pista)
                     AND  (dt_medicao  = p_dt_inicial)
                     AND  (hr_medicao  = rec1.hr_medicao);
               
                   /* Verificar retorno */
                   IF (w_vl_medicao IS NOT NULL) THEN
             
                      /* Verificar se está dentro dos parâmetros */
                      IF ((w_vl_medicao >= w_no_ordena1b) AND (w_vl_medicao <= w_no_ordena2b)) THEN
                  
                         /* Define hora inicial se ainda não encontrou */
                         IF (w_hr_inicio IS NULL) THEN
                            w_hr_inicio := rec1.hr_medicao;
                         END IF;
                     
                      ELSE
                
                         /* Verificar se alguma ocorrência existiu previamente */
                         IF (w_hr_inicio IS NOT NULL) THEN
                            w_qt_horas  := w_qt_horas  + (to_number(substr(rec1.hr_medicao,1,2)) * 60) + (to_number(substr(rec1.hr_medicao,3,2))) - 
                                                         (to_number(substr(w_hr_inicio    ,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                            w_hr_inicio := NULL;
                         END IF;
                    
                      END IF;
                
                   ELSE
             
                      /* Verificar se alguma ocorrência existiu previamente */
                      IF (w_hr_inicio IS NOT NULL) THEN
                         w_qt_horas  := w_qt_horas  + (to_number(substr(rec1.hr_medicao,1,2)) * 60) + (to_number(substr(rec1.hr_medicao,3,2))) - 
                                                      (to_number(substr(w_hr_inicio    ,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                         w_hr_inicio := NULL;
                      END IF;
                   
                   END IF;
             
                ELSE

                   /* Define hora inicial se ainda não encontrou */
                   IF (w_hr_inicio IS NULL) THEN
                      w_hr_inicio := rec1.hr_medicao;
                   END IF;
      
                END IF;
          
             ELSE

                /* Verificar se alguma ocorrência existiu previamente */
                IF (w_hr_inicio IS NOT NULL) THEN
                   w_qt_horas  := w_qt_horas  + (to_number(substr(rec1.hr_medicao,1,2)) * 60) + (to_number(substr(rec1.hr_medicao,3,2))) - 
                                                (to_number(substr(w_hr_inicio    ,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                   w_hr_inicio := NULL;
                END IF;

             END IF;
      
         END LOOP;

         /* Analisar possível última ocorrência */
         IF (w_hr_inicio IS NOT NULL) THEN
            w_qt_horas  := w_qt_horas  + (to_number(substr('2400'     ,1,2)) * 60) + (to_number(substr('2400'     ,3,2))) - 
                                         (to_number(substr(w_hr_inicio,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
         END IF;

         /* Analisar valores mínimos para inserção no banco */
         IF (w_count >= (p_pc_minimo * 24 / 100)) THEN
    
            /* Efetivacao da tabela de Medicao */
            up_inf_efetiva_medicao  (p_id_estacao  ,
                                     p_cd_atributo ,
                                     p_no_pista    ,
                                     w_dt_medicao  ,
                                     '0000'        ,
                                     p_vl_altitude ,
                                     p_vl_latitude ,
                                     p_vl_longitude, 
                                     w_qt_horas    ,
                                     0             ,
                                     null          ,
                                     'N'           ,
                                     w_cd_erro);

       END IF;

       /* Incrementar data */
       w_dt_medicao := w_dt_medicao + 1;
       
   END LOOP;   

END up_inf_geracao_totalhoras;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Geracao de dado do tipo Total
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_geracao_total (p_id_estacao          IN estacao.id_estacao%type,
                                                  p_cd_atributo         IN medicao.cd_atributo%type,
                                                  p_no_pista            IN medicao.no_pista%type,
                                                  p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                  p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                  p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                  p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                  p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                  p_dt_inicial          IN date,
                                                  p_dt_final            IN date,
                                                  p_vl_altitude         IN estacao.vl_altitude%type,
                                                  p_vl_latitude         IN estacao.vl_latitude%type,
                                                  p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_fl_pcminimo BOOLEAN    := TRUE;
   w_cd_erro     NUMBER(04) := 0;

   CURSOR Geracao_Total IS
          SELECT pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao ) dt_media,
                 sum(vl_medicao) vl_media,
                 count(distinct dt_medicao || hr_medicao) no_dias
          FROM   medicao
          WHERE  (id_estacao  = p_id_estacao)
            AND  (cd_atributo = p_cd_atributo_origem)
            AND  (no_pista    = p_no_pista)
            AND  (dt_medicao >= p_dt_inicial)
            AND  (dt_medicao <= p_dt_final)
            AND  (hr_medicao  = nvl(p_hr_obs_atrib_origem, hr_medicao))
          GROUP BY pc_inf_geral.fn_obt_data_calculo(p_cd_grupo_dado, dt_medicao );

BEGIN

   /* Loop sobre os valores resgatados */
   FOR rec1 IN Geracao_Total LOOP

       /* Verificar quantidade de medicoes para atributos diarios, decendiais, mensais e anuais */
       IF    (p_cd_grupo_dado = 'D') AND (rec1.no_dias < (p_pc_minimo * 1   / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'C') AND (rec1.no_dias < (p_pc_minimo * 10  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'M') AND (rec1.no_dias < (p_pc_minimo * 30  / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSIF (p_cd_grupo_dado = 'A') AND (rec1.no_dias < (p_pc_minimo * 360 / 100)) THEN
          w_fl_pcminimo := FALSE;
       ELSE
          w_fl_pcminimo := TRUE;
       END IF;

       /* Verificar se existem registros suficientes para calculo */
       IF w_fl_pcminimo THEN

          /* Efetivacao da tabela de Medicao */
          up_inf_efetiva_medicao  (p_id_estacao  ,
                                   p_cd_atributo ,
                                   p_no_pista    ,
                                   rec1.dt_media ,
                                   '0000'        ,
                                   p_vl_altitude ,
                                   p_vl_latitude ,
                                   p_vl_longitude, 
                                   rec1.vl_media ,
                                   0             ,
                                   null          ,
                                   'N'           ,
                                   w_cd_erro);

       END IF;

   END LOOP;

END up_inf_geracao_total;
/
SHOW ERRORS;
/
/*
*******************************************************************************
**  Calcular as Medias dos Atributos
*******************************************************************************
*/
CREATE OR REPLACE PROCEDURE up_inf_calcula_media_atributo (p_id_estacao          IN estacao.id_estacao%type,
                                                           p_cd_atributo         IN medicao.cd_atributo%type,
                                                           p_no_pista            IN medicao.no_pista%type,
                                                           p_cd_tipo_geracao     IN atributo.cd_tipo_geracao%type,
                                                           p_cd_grupo_dado       IN atributo.cd_grupo_dado%type,
                                                           p_cd_atributo_origem  IN atributo.cd_atributo_origem%type,
                                                           p_hr_obs_atrib_origem IN atributo.hr_obs_atrib_origem%type,
                                                           p_pc_minimo           IN atrib_estacao.pc_minimo%type,
                                                           p_dt_inicial          IN date,
                                                           p_dt_final            IN date,
                                                           p_vl_altitude         IN estacao.vl_altitude%type,
                                                           p_vl_latitude         IN estacao.vl_latitude%type,
                                                           p_vl_longitude        IN estacao.vl_longitude%type)

IS

   w_cd_server           parametro.cd_server%type;
   w_cd_server_master    parametro.cd_server%type;

   w_cd_tipo_geracao     atributo.cd_tipo_geracao%type;
   w_cd_grupo_dado       atributo.cd_grupo_dado%type;
   w_hr_obs_atrib_origem atributo.hr_obs_atrib_origem%type;
   w_cd_atributo_origem  atributo.cd_atributo_origem%type;
   data_invalida         EXCEPTION;

BEGIN

   /* Teste do Periodo de Calculo */
   IF (p_dt_inicial > sysdate)      THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Inicial Invalida');
   END IF;

   IF (p_dt_final   > sysdate)      THEN
      RAISE data_invalida;
   END IF;

   IF (p_dt_final   < p_dt_inicial) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Final menor que Data Inicial');
   END IF;

   /* Teste se servidor de master */
   SELECT p1.cd_server, b1.name into w_cd_server, w_cd_server_master 
   FROM   parametro p1, base b1
   WHERE  p1.cd_server = b1.name;

   /* O calculo de medias so pode ser executado no servidor master */
   IF (w_cd_server != w_cd_server_master) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Calculo de Medias so no Servidor Master');
   END IF;

   /* Caso nao tenha passado o tipo de geracao ou grupo de dado */
   IF (p_cd_atributo_origem IS NULL) THEN
      SELECT max(at1.cd_tipo_geracao), max(at1.cd_grupo_dado), max(at1.hr_obs_atrib_origem), max(at1.cd_atributo_origem)
      INTO   w_cd_tipo_geracao,        w_cd_grupo_dado,        w_hr_obs_atrib_origem,        w_cd_atributo_origem
      FROM   atributo at1
      WHERE  at1.cd_atributo = p_cd_atributo;
   ELSE
      w_cd_tipo_geracao     := p_cd_tipo_geracao;
      w_cd_grupo_dado       := p_cd_grupo_dado;
      w_cd_atributo_origem  := p_cd_atributo_origem;
      w_hr_obs_atrib_origem := p_hr_obs_atrib_origem;
   END IF;

   /* Verificar atributo */
   IF (w_cd_tipo_geracao    NOT IN ('M', 'X', 'N', 'T', 'F', 'H', 'P', 'Q', 'R', 'I')) OR
      (w_cd_grupo_dado      NOT IN ('H', 'D', 'C', 'M', 'A')) OR
      (w_cd_atributo_origem IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo Invalido');
   END IF;

   /* Apagar as medias do periodo */
   IF (w_cd_tipo_geracao <> 'O') THEN
      up_inf_delecao_media(p_id_estacao, p_cd_atributo, p_no_pista, p_dt_inicial, p_dt_final);
   END IF;

   /* Calcular valores de acordo com o tipo do atributo   */
   IF    (w_cd_tipo_geracao = 'M') THEN /* Media          */
      up_inf_geracao_media        (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'X') THEN /* Máxima         */
   
      /* No caso específico de máxima diferenciar atributo horário */   
      IF (w_cd_grupo_dado   = 'H') THEN
         up_inf_geracao_maxima_hr (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
      ELSE
         up_inf_geracao_maxima    (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
      END IF;

   ELSIF (w_cd_tipo_geracao = 'I') THEN /* Máxima 6h      */
      up_inf_geracao_maxima_6hr   (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'N') THEN /* Mínima         */
      up_inf_geracao_minima       (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'H') THEN /* Horas          */
      up_inf_geracao_hora         (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'R') THEN /* Hora Máxima    */
      up_inf_geracao_horamaxima   (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'P') THEN /* Porcentagem    */
      up_inf_geracao_porcentagem  (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'F') THEN /* Frequência     */
      up_inf_geracao_frequencia   (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'Q') THEN /* Total Horas    */
      up_inf_geracao_totalhoras   (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   ELSIF (w_cd_tipo_geracao = 'T') THEN /* Total          */
      up_inf_geracao_total        (p_id_estacao, p_cd_atributo, p_no_pista, w_cd_tipo_geracao, w_cd_grupo_dado, w_cd_atributo_origem, w_hr_obs_atrib_origem, p_pc_minimo, p_dt_inicial, p_dt_final, p_vl_altitude, p_vl_latitude, p_vl_longitude);
   END IF;

EXCEPTION

   WHEN data_invalida THEN
      null;

END up_inf_calcula_media_atributo;
/
SHOW ERRORS;
/
CREATE OR REPLACE PROCEDURE up_inf_calcula_medias   (p_id_estacao   IN estacao.id_estacao%type,
                                                     p_cd_atributo  IN medicao.cd_atributo%type)
IS
/*
*******************************************************************************
**                  === Documentacao da Procedure ===
**
**  Arquivo..: Medias.pro
**  Procedure: up_inf_calcula_medias
**  Autor....: Kiko
**  Data.....: 15/06/2001
**
**  Objetivo:
**  - Calcular ou Recalcular as Medias dos Atributos.
**
**  Programa(s) que chama(m):
**  - Delphi - Programas de cadastro das Medicoes
**  - Schedule
**
**  Tabelas Usadas:
**  - Consulta: Medicao
**  - Atualiza: Medicao
**
**  Parametro(s):
**  - p_id_estacao   = Identificacao da Estacao (Opcional)
**  - p_cd_atributo  = Codigo do Atributo (Opcional)
**
**  Retorno:
**  - Atualizacao da Tabela Medicao com as medias calculadas
**
**  Observacoes:
**  -
**
**  Alteracoes:
**  - dd/mm/aa =
**
*******************************************************************************
*/

   /* Definir variáveis */
   wsessionid         NUMBER;
   w_dt_controle      DATE;
   w_cd_server        parametro.cd_server%type;
   w_cd_server_master parametro.cd_server%type;

   w_id_estacao_ant   estacao.id_estacao%type;
   w_cd_atributo_ant  atributo.cd_atributo%type;
   w_no_pista         medicao.no_pista%type;
   w_no_nivel         atributo.no_nivel%type := 0;

   /* Controle do Calculo */
   CURSOR Controle_Calculo IS
          SELECT id_estacao, cd_atributo, no_pista, dt_pri_medicao
          FROM   temp_inf_medias2 temp2
          WHERE  sessionid = wsessionid;

   /* Dados a serem calculados (recalculo e novos calculos */
   CURSOR Medias_A_Calcular (p_id_estacao NUMBER, p_cd_atributo VARCHAR2, w_dt_controle DATE) IS
          SELECT distinct ma1.id_estacao, 
                 ma1.cd_atributo,
                 ma1.no_pista,
                 at1.cd_tipo_geracao,
                 at1.cd_grupo_dado,
                 nvl(at1.cd_atributo_origem, at1.cd_atributo) cd_atributo_origem,
                 at1.hr_obs_atrib_origem,
                 pc_inf_geral.fn_pri_data_calculo(decode(at1.cd_tipo_geracao, 'O', 'M', at1.cd_grupo_dado), ma1.dt_medicao) dt_inicial,
                 pc_inf_geral.fn_obt_data_calculo(decode(at1.cd_tipo_geracao, 'O', 'M', at1.cd_grupo_dado), ma1.dt_medicao) dt_final,
                 temp3.pc_minimo,
                 es1.vl_altitude,
                 es1.vl_latitude,
                 es1.vl_longitude,
                 at1.fl_multianual,
                 at1.no_nivel,
                 '1' tp_registro
          FROM  temp_inf_medias3 temp3, medicao_alt ma1, 
                atributo at1, estacao es1
          WHERE (temp3.sessionid     = wsessionid)
            AND (ma1.id_estacao      = temp3.id_estacao )
            AND (ma1.cd_atributo     = temp3.cd_atributo)
            AND (at1.cd_atributo     = temp3.cd_atributo)
            AND (es1.id_estacao      = temp3.id_estacao)
            AND (at1.no_nivel        = w_no_nivel)
            AND (at1.cd_tipo_geracao <> 'O')
          UNION
          SELECT distinct temp3.id_estacao, 
                 temp3.cd_atributo,
                 temp3.no_pista,
                 at1.cd_tipo_geracao,
                 at1.cd_grupo_dado,
                 nvl(at1.cd_atributo_origem, at1.cd_atributo) cd_atributo_origem,
                 at1.hr_obs_atrib_origem,
                 (temp3.dt_ult_calculo + 1) dt_inicial,
                 (temp3.dt_fim_calculo    ) dt_final,
                 temp3.pc_minimo,
                 es1.vl_altitude,
                 es1.vl_latitude,
                 es1.vl_longitude,
                 at1.fl_multianual,
                 at1.no_nivel,
                 '2' tp_registro
          FROM   temp_inf_medias3 temp3, atributo at1,
                 estacao es1
          WHERE  (temp3.sessionid      = wsessionid)
            AND  (temp3.dt_fim_calculo > temp3.dt_ult_calculo)
            AND  (at1.cd_atributo      = temp3.cd_atributo)
            AND  (es1.id_estacao       = temp3.id_estacao)
            AND  (at1.no_nivel         = w_no_nivel)
            AND  (at1.cd_tipo_geracao  = 'O')
          UNION
          SELECT temp3.id_estacao, 
                 temp3.cd_atributo,
                 temp3.no_pista,
                 at1.cd_tipo_geracao,
                 '' cd_grupo_dado,
                 '' cd_atributo_origem,
                 '' hr_obs_atrib_origem,
                 min(pc_inf_geral.fn_pri_data_calculo('M', ma1.dt_medicao)) dt_inicial,
                 max((temp3.dt_fim_calculo)) dt_final,
                 0,
                 0,
                 0,
                 0,
                 at1.fl_multianual,
                 at1.no_nivel,
                 '3' tp_registro
          FROM   temp_inf_medias3 temp3, atributo at1,
                 estacao es1, medicao_alt ma1
          WHERE  (temp3.sessionid      = wsessionid)
            AND  (ma1.id_estacao       = temp3.id_estacao )
            AND  (ma1.cd_atributo      = temp3.cd_atributo)
            AND  (at1.cd_atributo      = temp3.cd_atributo)
            AND  (es1.id_estacao       = temp3.id_estacao)
            AND  (at1.no_nivel         = w_no_nivel)
            AND  (at1.cd_tipo_geracao  = 'O')
          GROUP BY temp3.id_estacao, 
                   temp3.cd_atributo,
                   temp3.no_pista,
                   at1.cd_tipo_geracao,
                   at1.fl_multianual,
                   at1.no_nivel
          ORDER BY 15, 1, 2, 7;

BEGIN

   /* Obtendo o Numero SESSIONID para Tabela Temporaria */
   SELECT userenv('sessionid') INTO wsessionid FROM dual;

   /* Teste se servidor de master */
   SELECT p1.cd_server, b1.name into w_cd_server, w_cd_server_master 
   FROM   parametro p1, base b1
   where  p1.cd_server = b1.name;

   /* O calculo de medias so pode ser executado no servidor master */
   IF (w_cd_server != w_cd_server_master) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Calculo de Medias so no Servidor Master');
   END IF;

   /* Analisar data */
   IF (to_char(SYSDATE, 'hh24:mi') < '18:00') THEN
      w_dt_controle := trunc(SYSDATE  , 'dd');
   ELSE
      w_dt_controle := trunc(SYSDATE-1, 'dd');
   END IF;

   /* Obtendo a Primeira Medicao por Atributo e Estacao */
   DELETE temp_inf_medias2
   WHERE  sessionid = wsessionid;

   INSERT INTO temp_inf_medias2
   SELECT wsessionid,
          ae1.id_estacao,
          ae1.cd_atributo,
          ae1.no_pista,
          pc_inf_geral.fn_pri_data_medicao(ae1.id_estacao, ae1.cd_atributo, ae1.no_pista)
   FROM   atrib_estacao ae1
   WHERE  (ae1.dt_ult_calculo is null)
     AND  (ae1.id_estacao  = nvl(p_id_estacao , ae1.id_estacao ))
     AND  (ae1.cd_atributo = nvl(p_cd_atributo, ae1.cd_atributo));
  
   /* Deletando os Registros sem Medicao */
   DELETE temp_inf_medias2 temp2
   WHERE  sessionid = wsessionid
     AND  temp2.dt_pri_medicao is null;
      
   /* Atualizando os controles de calculos com a data da primeira medicao -1 */
   FOR rec0 IN Controle_Calculo LOOP
     
       /* Verificar estação */
       IF (rec0.id_estacao IS NOT NULL) THEN
     
          /* Update na tabela */
          UPDATE atrib_estacao ae2 set dt_ult_calculo = rec0.dt_pri_medicao - 1
          WHERE ae2.id_estacao  = rec0.id_estacao
            AND ae2.cd_atributo = rec0.cd_atributo
            AND ae2.no_pista    = rec0.no_pista;

       END IF;

   END LOOP;

   /* Deletando a Tabela Temporaria */
   DELETE temp_inf_medias2 temp2
   WHERE sessionid = wsessionid;

   /* Loop sobre os níveis */
   WHILE (w_no_nivel <> 3) LOOP

      /* Obtendo a Data da Ultima Medicao por Atributo e Estacao */
      DELETE temp_inf_medias3
      WHERE  sessionid = wsessionid;
   
      /* Obtendo a Data da Ultima Medicao por Atributo e Estacao */
      INSERT INTO temp_inf_medias3
             SELECT wsessionid,
                    ae1.id_estacao,
                    ae1.cd_atributo,
                    ae1.no_pista,
                    ae1.pc_minimo,
                    ae1.dt_ult_calculo,
                    pc_inf_geral.fn_fim_data_calculo(decode(at1.cd_tipo_geracao, 'O', 'M', at1.cd_grupo_dado), last_day(pc_inf_geral.fn_ult_data_medicao(ae1.id_estacao, ae1.cd_atributo, ae1.no_pista)), w_dt_controle) dt_fim_calculo
             FROM  atrib_estacao ae1, atributo at1
             WHERE (ae1.dt_ult_calculo is not null)
               AND (ae1.id_estacao      = nvl(p_id_estacao , ae1.id_estacao ))
               AND (ae1.cd_atributo     = nvl(p_cd_atributo, ae1.cd_atributo))
               AND (at1.cd_atributo     = ae1.cd_atributo)
               AND (at1.no_nivel        = w_no_nivel);
   
      /* Deletando os  Atributos sem Medicao */
      DELETE temp_inf_medias3 temp3
      WHERE  temp3.sessionid = wsessionid
        AND  temp3.dt_fim_calculo is null;
  
      /* Loop das medias a calcular */
      FOR rec1 IN Medias_A_Calcular (p_id_estacao, p_cd_atributo, w_dt_controle) LOOP

--       insert into teste_media values (rec1.id_estacao,
--                                       rec1.cd_atributo,
--                                       rec1.no_pista, 
--                                       rec1.cd_tipo_geracao,
--                                       rec1.cd_grupo_dado,
--                                       rec1.cd_atributo_origem,
--                                       rec1.tp_registro,
--                                       rec1.pc_minimo,
--                                       rec1.dt_inicial,
--                                       rec1.dt_final,
--                                       rec1.vl_altitude,
--                                       rec1.vl_latitude,
--                                       rec1.vl_longitude,
--                                       rec1.fl_multianual, sysdate);
 
          /* Calculo de Medias em outro Atributo */
          IF (rec1.cd_tipo_geracao != 'O') THEN

             up_inf_calcula_media_atributo (rec1.id_estacao,
                                            rec1.cd_atributo,
                                            rec1.no_pista,
                                            rec1.cd_tipo_geracao,
                                            rec1.cd_grupo_dado,
                                            rec1.cd_atributo_origem,
                                            rec1.hr_obs_atrib_origem,
                                            rec1.pc_minimo,
                                            rec1.dt_inicial,
                                            rec1.dt_final,
                                            rec1.vl_altitude,
                                            rec1.vl_latitude,
                                            rec1.vl_longitude);
                                              
          END IF;

          /* Apagando medicao_alt */                                            
          DELETE medicao_alt
          WHERE  id_estacao  = rec1.id_estacao
            AND  cd_atributo = rec1.cd_atributo
            AND  no_pista    = rec1.no_pista
            AND  dt_medicao >= rec1.dt_inicial 
            AND  dt_medicao <= rec1.dt_final;

          /* Atualizacao do Controle de Calculo */
          UPDATE atrib_estacao set dt_ult_calculo = rec1.dt_final
          WHERE  id_estacao  = rec1.id_estacao
            AND  cd_atributo = rec1.cd_atributo
            AND  no_pista    = rec1.no_pista
            AND  (dt_ult_calculo is null or rec1.dt_final > dt_ult_calculo);

          /* Cálculo de multianual */
          IF (rec1.cd_tipo_geracao = 'O') THEN
             
             IF (rec1.tp_registro = '3') THEN
          
                /* Cálculo de multianual */
                IF (rec1.fl_multianual = 'S') THEN 
                   up_inf_calcula_media_multiano(rec1.id_estacao, rec1.cd_atributo, rec1.dt_inicial, w_dt_controle);
                END IF;
               
             END IF;
             
          ELSE
         
             /* Cálculo de multianual */
             IF (rec1.fl_multianual = 'S') THEN 
                up_inf_calcula_media_multiano(rec1.id_estacao, rec1.cd_atributo, rec1.dt_inicial, w_dt_controle);
             END IF;
              
          END IF;
       
          /* Efetivar alterações */
          COMMIT;

      END LOOP;

      /* Verificar se trouxe algo para o nível */
      w_no_nivel := w_no_nivel + 1;

      /* Deletando a Tabela Temporaria */
      DELETE temp_inf_medias3
      WHERE sessionid = wsessionid;
 
      /* Efetivar alterações */
      COMMIT;
   
   END LOOP;

END up_inf_calcula_medias;
/
SHOW ERRORS;
/
CREATE OR REPLACE PROCEDURE up_inf_forca_medias(p_id_estacao  IN estacao.id_estacao%type,
                                                p_cd_atributo IN atributo.cd_atributo%type,
                                                p_dt_inicial  IN date,
                                                p_dt_final    IN date)
IS  
/*
*******************************************************************************
**                  === Documentacao da Procedure ===
**
**  Arquivo..: Medias.pro
**  Procedure: up_inf_forca_medias
**  Autor....: Kiko
**  Data.....: 31/07/2002
**
**  Objetivo:
**  - Calcular ou Recalcular as Medias dos Atributos.
**
**  Programa(s) que chama(m):
**  - Developer 
**  - Schedule
**
**  Tabelas Usadas:
**  - Consulta: Medicao
**  - Atualiza: Medicao
**
**  Parametro(s):
**  - p_id_estacao   = Identificacao da Estacao (Opcional)
**  - p_cd_atributo  = Codigo do Atributo (Opcional)
**
**  Retorno:
**  - Atualizacao da Tabela Medicao com as medias calculadas
**
**  Observacoes:
**  -
**
**  Alteracoes:
**  - dd/mm/aa =
**
*******************************************************************************
*/

   /* Variáveis auxiliares */
   w_dt_inicial              medicao.dt_medicao%type;
   w_dt_final                medicao.dt_medicao%type;
   w_fl_ult_calculo          boolean := false;

   w_id_estacao              estacao.id_estacao%type;
   w_cd_atributo             atributo.cd_atributo%type;
   w_no_pista                estacao_pista.no_pista%type;
   w_cd_tipo_geracao         atributo.cd_tipo_geracao%type;
   w_cd_grupo_dado           atributo.cd_grupo_dado%type;
   w_cd_atributo_origem      atributo.cd_atributo_origem%type;
   w_cd_tipo_medicao         atributo.cd_tipo_medicao%type;
   w_hr_obs_atrib_origem     atributo.hr_obs_atrib_origem%type;
   w_pc_minimo               atributo.pc_minimo%type;
   w_vl_altitude             estacao.vl_altitude%type;
   w_vl_latitude             estacao.vl_latitude%type;
   w_vl_longitude            estacao.vl_longitude%type;
   w_fl_multianual           atributo.fl_multianual%type; 

   /* Loop pistas */
   CURSOR Controle_Pista IS
          SELECT distinct es1.id_estacao, 
                          at1.cd_atributo,
                          ae1.no_pista,
                          at1.cd_tipo_geracao,
                          at1.cd_grupo_dado,
                          nvl(at1.cd_atributo_origem, at1.cd_atributo) cd_atributo_origem,
                          at1.hr_obs_atrib_origem,
                          at1.pc_minimo,
                          es1.vl_altitude,
                          es1.vl_latitude,
                          es1.vl_longitude,
                          at1.fl_multianual
                   FROM  atributo at1, estacao es1, 
                         atrib_estacao ae1
                   WHERE (ae1.id_estacao  = p_id_estacao)
                     AND (ae1.cd_atributo = p_cd_atributo)
                     AND (ae1.id_estacao  = es1.id_estacao)
                     AND (ae1.cd_atributo = at1.cd_atributo)
                ORDER BY 1, 2, 3;

BEGIN

   /* Verificar estação */
   IF (p_id_estacao IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Informe o ID da Estação');
   END IF;

   IF (p_id_estacao <= 0) THEN
      RAISE_APPLICATION_ERROR(-20001, 'ID da Estação deve ser maior que zero');
   END IF;

   /* Verificar datas */
   IF (p_dt_inicial IS NULL) AND (p_dt_final IS NOT NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Inicial não foi informada'); 
   END IF;

   IF (p_dt_inicial IS NOT NULL) AND (p_dt_final IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Final não foi informada'); 
   END IF;

   /* Obter dados para cálculo */
   FOR rec0 IN Controle_Pista LOOP

      /* Se não informou as datas obter a menor medição */
      IF (p_dt_inicial IS NULL) AND (p_dt_final IS NULL) THEN

         /* Obter menor data */
         SELECT MIN(dt_medicao) INTO w_dt_inicial
         FROM MEDICAO
         WHERE id_estacao  = p_id_estacao
           AND cd_atributo = rec0.cd_atributo_origem;

         /* Verificar se encontrou algo */
         IF (w_dt_inicial IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nenhum Lançamento para a Estação');
         END IF;

         /* Determinar a data final */
         w_dt_final       := sysdate;
         w_fl_ult_calculo := true;
   
      ELSE
      
         /* Analisar datas */ 
         IF (p_dt_inicial > p_dt_final) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Data Inicial maior que data Final'); 
         END IF;
   
         /* Determinar datas */
         w_dt_inicial := p_dt_inicial;
         w_dt_final   := p_dt_final;
   
      END IF;

      /* Atualizando os controles de calculos com a data da primeira medicao -1 */
      IF (w_fl_ult_calculo) THEN
   
         UPDATE atrib_estacao ae2
         SET    dt_ult_calculo  = w_dt_inicial - 1
         WHERE  ae2.id_estacao  = p_id_estacao
           AND  ae2.cd_atributo = p_cd_atributo;

      END IF;

      /* Verificar se atributo eh observado */
      IF (rec0.cd_tipo_geracao != 'O') THEN

         /* Calcular média */  
         up_inf_calcula_media_atributo (rec0.id_estacao,
                                        rec0.cd_atributo,
                                        rec0.no_pista, 
                                        rec0.cd_tipo_geracao,
                                        rec0.cd_grupo_dado,
                                        rec0.cd_atributo_origem,
                                        rec0.hr_obs_atrib_origem,
                                        rec0.pc_minimo,
                                        w_dt_inicial,
                                        w_dt_final,
                                        rec0.vl_altitude,
                                        rec0.vl_latitude,
                                        rec0.vl_longitude);
                                        
      ELSE
         DELETE medicao_alt
         WHERE  id_estacao  = rec0.id_estacao
           AND  cd_atributo = rec0.cd_atributo
           AND  no_pista    = rec0.no_pista
           AND  dt_medicao >= w_dt_inicial 
           AND  dt_medicao <= w_dt_final;
                                        
      END IF;

      /* Cálculo de multianual */
      IF (rec0.fl_multianual = 'S') THEN
         up_inf_calcula_media_multiano(rec0.id_estacao, rec0.cd_atributo, w_dt_inicial, w_dt_final);
      END IF;

      /* Efetivar alterações */
      COMMIT;
     
   END LOOP;

END up_inf_forca_medias;
/
SHOW ERRORS;
/
GRANT EXECUTE ON up_inf_geracao_media       	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_maxima      	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_maxima_hr   	TO bdclim_ger_01
/ 
GRANT EXECUTE ON up_inf_geracao_maxima_6hr  	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_minima      	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_hora        	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_horamaxima  	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_porcentagem 	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_frequencia  	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_totalhoras  	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_geracao_total          	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_calcula_media_atributo 	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_calcula_medias	 	TO bdclim_ger_01
/
GRANT EXECUTE ON up_inf_forca_medias	 	TO bdclim_ger_01
/