/*
*******************************************************************************
**                     === Documentacao da Package ===
**
**  Arquivo....: Sumario_mensal_02.pro
**  Procedure..: pc_inf_sumario_mensal_02
**  Autor......: Marco Cesare
**  Data.......: 15/06/2002
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
CREATE OR REPLACE PACKAGE pc_inf_sumario_mensal_02
IS
   TYPE registro            IS RECORD (dir_020_040  VARCHAR2(010),
                                       dir_050_070  VARCHAR2(010),
                                       dir_080_100  VARCHAR2(010),
                                       dir_110_130  VARCHAR2(010),
                                       dir_140_160  VARCHAR2(010),
                                       dir_170_190  VARCHAR2(010),
                                       dir_200_220  VARCHAR2(010),
                                       dir_230_250  VARCHAR2(010),
                                       dir_260_280  VARCHAR2(010),
                                       dir_290_310  VARCHAR2(010),
                                       dir_320_340  VARCHAR2(010),
                                       dir_350_010  VARCHAR2(010),
                                       dir_total    VARCHAR2(010),
                                       dir_calmo    VARCHAR2(010));

   TYPE registro_detail IS TABLE OF registro INDEX BY binary_integer;

   PROCEDURE up_inf_sumario_mensal_02 (p_id_estacao IN estacao.id_estacao%type,
                                       p_mes        IN VARCHAR2,
                                       p_ano        IN VARCHAR2,
                                       p_no_pista   IN medicao.no_pista%type,
                                       p_retorno    IN OUT registro_detail);
END;
/
SHOW ERRORS;
/
CREATE OR REPLACE PACKAGE BODY pc_inf_sumario_mensal_02
AS

/*
*******************************************************************************
**                     === Documentacao da Procedure ===
**
**  Arquivo....: Sumario_mensal_02.pro
**  Procedure..: up_inf_sumario_mensal_02
**  Autor......: Marco Cesare
**  Data.......: 15/06/2002
**
**  Objetivo:
**  - Obter informações para relatório de Sumário Climatológico Mensal 02.
**
**  Tabelas Usadas:
**  - Consulta: medicao
**  - Atualiza:
**
**  Observacoes: Inicialmente serão geradas 14 linhas correspondentes a 
**               13 faixas de velocidade e 1 de totalização. As colunas
**               são determinadas pelas faixas de direção.
**    
**  Alteracoes:
**   - dd/mm/aa =
**
*******************************************************************************
*/
PROCEDURE up_inf_sumario_mensal_02 (p_id_estacao IN estacao.id_estacao%type,
                                    p_mes        IN VARCHAR2,
                                    p_ano        IN VARCHAR2,
                                    p_no_pista   IN medicao.no_pista%type,
                                    p_retorno    IN OUT registro_detail)
IS

   /* Definição de estruturas */
   tab_registro_detail  registro_detail;

   /* Definição de variáveis */
   w_dt_inicial      DATE;
   w_dt_final        DATE;
   w_count           NUMBER;
   w_dir_vento       param_geral.cd_opcao%type := NULL;
   w_vel_vento       param_geral.cd_opcao%type := NULL;
   w_rajada          param_geral.cd_opcao%type := NULL;
   w_qt_faixa        NUMBER := 25;
   w_no_linha        NUMBER := 0;
   
   /* Definição de cursor para resgatar atributos */
   CURSOR Atributos_Relatorio IS
          SELECT cd_opcao, no_ordena1
          FROM   param_geral
          WHERE  cd_sistema = 'INF'
            AND  cd_tpreg   = 'SUM02'
          ORDER BY no_ordena1;
          
   /* Definição de cursor para resgatar velocidade do vento */
   CURSOR Vento IS
          SELECT v.vl_medicao vel, d.vl_medicao dir
          FROM   medicao v, medicao d
          WHERE  v.id_estacao   = p_id_estacao
            AND  v.cd_atributo  = w_vel_vento
            AND  v.no_pista     = nvl(p_no_pista, v.no_pista)
            AND  v.dt_medicao  >= w_dt_inicial
            AND  v.dt_medicao  <= w_dt_final
            AND  substr(v.hr_medicao,3,2) = '00'
            AND  v.id_estacao   = d.id_estacao
            AND  d.cd_atributo  = w_dir_vento
            AND  v.no_pista     = d.no_pista
            AND  v.dt_medicao   = d.dt_medicao
            AND  v.hr_medicao   = d.hr_medicao
            AND  v.vl_altitude  = d.vl_altitude;
            
   CURSOR Rajada IS
          SELECT v.vl_medicao vel, d.vl_medicao dir
          FROM   medicao v, medicao d
          WHERE  v.id_estacao   = p_id_estacao
            AND  v.cd_atributo  = w_rajada
            AND  v.no_pista     = nvl(p_no_pista, v.no_pista)
            AND  v.dt_medicao  >= w_dt_inicial
            AND  v.dt_medicao  <= w_dt_final
            AND  substr(v.hr_medicao,3,2) = '00'
            AND  v.id_estacao   = d.id_estacao
            AND  d.cd_atributo  = w_dir_vento
            AND  v.no_pista     = d.no_pista
            AND  v.dt_medicao   = d.dt_medicao
            AND  v.hr_medicao   = d.hr_medicao
            AND  v.vl_altitude  = d.vl_altitude
          ORDER BY 1;

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
          w_vel_vento    := rec0.cd_opcao;   
       ELSIF (rec0.no_ordena1 = 03) THEN
          w_rajada       := rec0.cd_opcao;   
       END IF;
          
   END LOOP;

   /* Analisar se atributos foram resgatados */
   IF (w_dir_vento IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo de Direção do Vento não cadastrado');
   END IF;

   IF (w_vel_vento IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo de Velocidade do Vento não cadastrado');
   END IF;

   IF (w_rajada IS NULL)    THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo de Rajada não cadastrado');
   END IF;

   /* Inserir quantidade de linhas correspondentes ao número faixas de velocidade */
   FOR i IN 1..w_qt_faixa LOOP
   
       /* Verificar se é linha par */
       IF (mod(i, 2) = 0) THEN
          tab_registro_detail(i).dir_020_040 := '';
          tab_registro_detail(i).dir_050_070 := '';
          tab_registro_detail(i).dir_080_100 := '';
          tab_registro_detail(i).dir_110_130 := '';
          tab_registro_detail(i).dir_140_160 := '';
          tab_registro_detail(i).dir_170_190 := '';
          tab_registro_detail(i).dir_200_220 := '';
          tab_registro_detail(i).dir_230_250 := '';
          tab_registro_detail(i).dir_260_280 := '';
          tab_registro_detail(i).dir_290_310 := '';
          tab_registro_detail(i).dir_320_340 := '';
          tab_registro_detail(i).dir_350_010 := '';
          tab_registro_detail(i).dir_total   := '';
          tab_registro_detail(i).dir_calmo   := '';
       ELSE
          tab_registro_detail(i).dir_020_040 := 0;
          tab_registro_detail(i).dir_050_070 := 0;
          tab_registro_detail(i).dir_080_100 := 0;
          tab_registro_detail(i).dir_110_130 := 0;
          tab_registro_detail(i).dir_140_160 := 0;
          tab_registro_detail(i).dir_170_190 := 0;
          tab_registro_detail(i).dir_200_220 := 0;
          tab_registro_detail(i).dir_230_250 := 0;
          tab_registro_detail(i).dir_260_280 := 0;
          tab_registro_detail(i).dir_290_310 := 0;
          tab_registro_detail(i).dir_320_340 := 0;
          tab_registro_detail(i).dir_350_010 := 0;
          tab_registro_detail(i).dir_total   := 0;
          tab_registro_detail(i).dir_calmo   := '';
       END IF;   
          
   END LOOP;

   /* Loop sobre registros da velocidade do vento */
   FOR rec1 IN Vento LOOP

       /* Direção 990 corresponde a variação da direção */
       IF (rec1.dir <> 990) THEN

          /* Analisar linha onde atribuir a informação */
          IF    ((rec1.vel >= 01.0) AND (rec1.vel < 02.5)) THEN
             w_no_linha := 01;
          ELSIF ((rec1.vel >= 02.5) AND (rec1.vel < 04.5)) THEN
             w_no_linha := 03;
          ELSIF ((rec1.vel >= 04.5) AND (rec1.vel < 06.5)) THEN
             w_no_linha := 05;
          ELSIF ((rec1.vel >= 06.5) AND (rec1.vel < 08.5)) THEN
             w_no_linha := 07;
          ELSIF ((rec1.vel >= 08.5) AND (rec1.vel < 10.5)) THEN
             w_no_linha := 09;
          ELSIF ((rec1.vel >= 10.5) AND (rec1.vel < 12.5)) THEN
             w_no_linha := 11;
          ELSIF ((rec1.vel >= 12.5) AND (rec1.vel < 14.5)) THEN
             w_no_linha := 13;
          ELSIF ((rec1.vel >= 14.5) AND (rec1.vel < 16.5)) THEN
             w_no_linha := 15;
          ELSIF ((rec1.vel >= 16.5) AND (rec1.vel < 18.5)) THEN
             w_no_linha := 17;
          ELSIF ((rec1.vel >= 18.5) AND (rec1.vel < 20.5)) THEN
             w_no_linha := 19;
          ELSIF ((rec1.vel >= 20.5) AND (rec1.vel < 22.5)) THEN
             w_no_linha := 21;
          ELSIF  (rec1.vel >= 22.5)                        THEN
             w_no_linha := 23;
          ELSE
             w_no_linha := 0;
          END IF;
       
          /* Analisar coluna onde atribuir a informação */
          IF (w_no_linha <> 0) THEN
 
             IF    ((rec1.dir >= 020)  AND (rec1.dir <= 040)) THEN
                tab_registro_detail(w_no_linha).dir_020_040 := tab_registro_detail(w_no_linha).dir_020_040 + 1;
                tab_registro_detail(w_qt_faixa).dir_020_040 := tab_registro_detail(w_qt_faixa).dir_020_040 + 1;
             ELSIF ((rec1.dir >= 050)  AND (rec1.dir <= 070)) THEN   
                tab_registro_detail(w_no_linha).dir_050_070 := tab_registro_detail(w_no_linha).dir_050_070 + 1;
                tab_registro_detail(w_qt_faixa).dir_050_070 := tab_registro_detail(w_qt_faixa).dir_050_070 + 1;
             ELSIF ((rec1.dir >= 080)  AND (rec1.dir <= 100)) THEN   
                tab_registro_detail(w_no_linha).dir_080_100 := tab_registro_detail(w_no_linha).dir_080_100 + 1;
                tab_registro_detail(w_qt_faixa).dir_080_100 := tab_registro_detail(w_qt_faixa).dir_080_100 + 1;
             ELSIF ((rec1.dir >= 110)  AND (rec1.dir <= 130)) THEN   
                tab_registro_detail(w_no_linha).dir_110_130 := tab_registro_detail(w_no_linha).dir_110_130 + 1;
                tab_registro_detail(w_qt_faixa).dir_110_130 := tab_registro_detail(w_qt_faixa).dir_110_130 + 1;
             ELSIF ((rec1.dir >= 140)  AND (rec1.dir <= 160)) THEN   
                tab_registro_detail(w_no_linha).dir_140_160 := tab_registro_detail(w_no_linha).dir_140_160 + 1;
                tab_registro_detail(w_qt_faixa).dir_140_160 := tab_registro_detail(w_qt_faixa).dir_140_160 + 1;
             ELSIF ((rec1.dir >= 170)  AND (rec1.dir <= 190)) THEN   
                tab_registro_detail(w_no_linha).dir_170_190 := tab_registro_detail(w_no_linha).dir_170_190 + 1;
                tab_registro_detail(w_qt_faixa).dir_170_190 := tab_registro_detail(w_qt_faixa).dir_170_190 + 1;
             ELSIF ((rec1.dir >= 200)  AND (rec1.dir <= 220)) THEN   
                tab_registro_detail(w_no_linha).dir_200_220 := tab_registro_detail(w_no_linha).dir_200_220 + 1;
                tab_registro_detail(w_qt_faixa).dir_200_220 := tab_registro_detail(w_qt_faixa).dir_200_220 + 1;
             ELSIF ((rec1.dir >= 230)  AND (rec1.dir <= 250)) THEN   
                tab_registro_detail(w_no_linha).dir_230_250 := tab_registro_detail(w_no_linha).dir_230_250 + 1;
                tab_registro_detail(w_qt_faixa).dir_230_250 := tab_registro_detail(w_qt_faixa).dir_230_250 + 1;
             ELSIF ((rec1.dir >= 260)  AND (rec1.dir <= 280)) THEN   
                tab_registro_detail(w_no_linha).dir_260_280 := tab_registro_detail(w_no_linha).dir_260_280 + 1;
                tab_registro_detail(w_qt_faixa).dir_260_280 := tab_registro_detail(w_qt_faixa).dir_260_280 + 1;
             ELSIF ((rec1.dir >= 290)  AND (rec1.dir <= 310)) THEN   
                tab_registro_detail(w_no_linha).dir_290_310 := tab_registro_detail(w_no_linha).dir_290_310 + 1;
                tab_registro_detail(w_qt_faixa).dir_290_310 := tab_registro_detail(w_qt_faixa).dir_290_310 + 1;
             ELSIF ((rec1.dir >= 320)  AND (rec1.dir <= 340)) THEN   
                tab_registro_detail(w_no_linha).dir_320_340 := tab_registro_detail(w_no_linha).dir_320_340 + 1;
                tab_registro_detail(w_qt_faixa).dir_320_340 := tab_registro_detail(w_qt_faixa).dir_320_340 + 1;
             ELSIF (((rec1.dir >= 350) AND (rec1.dir <= 360)) OR ((rec1.dir >= 010) AND (rec1.dir <= 010))) THEN
                tab_registro_detail(w_no_linha).dir_350_010 := tab_registro_detail(w_no_linha).dir_350_010 + 1;
                tab_registro_detail(w_qt_faixa).dir_350_010 := tab_registro_detail(w_qt_faixa).dir_350_010 + 1;
             END IF;          

             /* Adicionar ao total da linha e total geral */
             tab_registro_detail(w_no_linha).dir_total := tab_registro_detail(w_no_linha).dir_total + 1;
             tab_registro_detail(w_qt_faixa).dir_total := tab_registro_detail(w_qt_faixa).dir_total + 1;
          
          END IF;   
          
       END IF;
          
   END LOOP;

   /* Obter quantidade de vento calmo */
   SELECT count(*) INTO w_count
   FROM   medicao
   WHERE  id_estacao   = p_id_estacao
     AND  cd_atributo  = w_vel_vento
     AND  no_pista     = nvl(p_no_pista, no_pista)
     AND  dt_medicao  >= w_dt_inicial
     AND  dt_medicao  <= w_dt_final
     AND  substr(hr_medicao,3,2) = '00'
     AND  vl_medicao   = 0;
     
   /* Analisar retorno */
   IF (w_count IS NULL) THEN
      tab_registro_detail(w_qt_faixa).dir_calmo := '0';
   ELSE
      tab_registro_detail(w_qt_faixa).dir_calmo := to_char(w_count);
   END IF;     

   /* Loop sobre registros da rajada */
   FOR rec2 IN Rajada LOOP

       /* Analisar linha onde atribuir a informação */
       IF    ((rec2.vel >= 01.0) AND (rec2.vel < 02.5)) THEN
          w_no_linha := 02;
       ELSIF ((rec2.vel >= 02.5) AND (rec2.vel < 04.5)) THEN
          w_no_linha := 04;
       ELSIF ((rec2.vel >= 04.5) AND (rec2.vel < 06.5)) THEN
          w_no_linha := 06;
       ELSIF ((rec2.vel >= 06.5) AND (rec2.vel < 08.5)) THEN
          w_no_linha := 08;
       ELSIF ((rec2.vel >= 08.5) AND (rec2.vel < 10.5)) THEN
          w_no_linha := 10;
       ELSIF ((rec2.vel >= 10.5) AND (rec2.vel < 12.5)) THEN
          w_no_linha := 12;
       ELSIF ((rec2.vel >= 12.5) AND (rec2.vel < 14.5)) THEN
          w_no_linha := 14;
       ELSIF ((rec2.vel >= 14.5) AND (rec2.vel < 16.5)) THEN
          w_no_linha := 16;
       ELSIF ((rec2.vel >= 16.5) AND (rec2.vel < 18.5)) THEN
          w_no_linha := 18;
       ELSIF ((rec2.vel >= 18.5) AND (rec2.vel < 20.5)) THEN
          w_no_linha := 20;
       ELSIF ((rec2.vel >= 20.5) AND (rec2.vel < 22.5)) THEN
          w_no_linha := 22;
       ELSIF  (rec2.vel >= 22.5)                        THEN
          w_no_linha := 24;
       ELSE
          w_no_linha := 0;
       END IF;
       
       /* Analisar coluna onde atribuir a informação */
       IF (w_no_linha <> 0) THEN

          IF    ((rec2.dir >= 020)  AND (rec2.dir <= 040)) THEN
             tab_registro_detail(w_no_linha).dir_020_040 := 'RJD ' || to_char(rec2.vel);
          ELSIF ((rec2.dir >= 050)  AND (rec2.dir <= 070)) THEN   
             tab_registro_detail(w_no_linha).dir_050_070 := 'RJD ' || to_char(rec2.vel);
          ELSIF ((rec2.dir >= 080)  AND (rec2.dir <= 100)) THEN   
             tab_registro_detail(w_no_linha).dir_080_100 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 110)  AND (rec2.dir <= 130)) THEN   
             tab_registro_detail(w_no_linha).dir_110_130 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 140)  AND (rec2.dir <= 160)) THEN   
             tab_registro_detail(w_no_linha).dir_140_160 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 170)  AND (rec2.dir <= 190)) THEN   
             tab_registro_detail(w_no_linha).dir_170_190 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 200)  AND (rec2.dir <= 220)) THEN   
             tab_registro_detail(w_no_linha).dir_200_220 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 230)  AND (rec2.dir <= 250)) THEN   
             tab_registro_detail(w_no_linha).dir_230_250 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 260)  AND (rec2.dir <= 280)) THEN   
             tab_registro_detail(w_no_linha).dir_260_280 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 290)  AND (rec2.dir <= 310)) THEN   
             tab_registro_detail(w_no_linha).dir_290_310 := 'RJD ' || to_char(rec2.vel); 
          ELSIF ((rec2.dir >= 320)  AND (rec2.dir <= 330)) THEN   
             tab_registro_detail(w_no_linha).dir_320_340 := 'RJD ' || to_char(rec2.vel); 
          ELSIF (((rec2.dir >= 350) AND (rec2.dir <= 360)) OR ((rec2.dir >= 010) AND (rec2.dir <= 010))) THEN
             tab_registro_detail(w_no_linha).dir_350_010 := 'RJD ' || to_char(rec2.vel);
          END IF;          

       END IF;   
          
   END LOOP;

   /* Definir retorno */
   p_retorno := tab_registro_detail;

END up_inf_sumario_mensal_02;

END pc_inf_sumario_mensal_02;
/
SHOW ERRORS;
/
GRANT EXECUTE ON pc_inf_sumario_mensal_02 TO bdclim_ger_01
/