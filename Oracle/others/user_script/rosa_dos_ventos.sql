/*
*******************************************************************************
**                     === Documentacao da Package ===
**
**  Arquivo....: Rosa_dos_ventos.pro
**  Procedure..: up_inf_rosa_dos_ventos
**  Autor......: Marco Cesare
**  Data.......: 09/10/2002
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
CREATE OR REPLACE PACKAGE pc_inf_rosa_dos_ventos
IS
   
   TYPE registro            IS RECORD (vl_grau      VARCHAR2(004),
                                       vl_col_1     NUMBER,
                                       vl_col_2     NUMBER,
                                       vl_col_3     NUMBER,
                                       vl_col_4     NUMBER,
                                       vl_col_5     NUMBER,
                                       vl_col_6     NUMBER,
                                       vl_col_7     NUMBER,
                                       vl_col_8     NUMBER,
                                       vl_col_9     NUMBER,
                                       vl_col_10    NUMBER,
                                       vl_col_11    NUMBER,
                                       vl_col_12    NUMBER,
                                       vl_col_13    NUMBER);

   TYPE registro_valor      IS RECORD (dir_020_040  NUMBER,
                                       dir_050_070  NUMBER,
                                       dir_080_100  NUMBER,
                                       dir_110_130  NUMBER,
                                       dir_140_160  NUMBER,
                                       dir_170_190  NUMBER,
                                       dir_200_220  NUMBER,
                                       dir_230_250  NUMBER,
                                       dir_260_280  NUMBER,
                                       dir_290_310  NUMBER,
                                       dir_320_340  NUMBER,
                                       dir_350_010  NUMBER,
                                       dir_total    NUMBER,
                                       dir_calmo    NUMBER);

   TYPE registro_detail       IS TABLE OF registro       INDEX BY binary_integer;
   TYPE registro_detail_valor IS TABLE OF registro_valor INDEX BY binary_integer;

   PROCEDURE up_inf_rosa_dos_ventos (p_id_estacao IN estacao.id_estacao%type,
                                     p_no_pista   IN medicao.no_pista%type,
                                     p_dt_inicial IN VARCHAR2,
                                     p_dt_final   IN VARCHAR2,
                                     p_retorno    IN OUT registro_detail);
END;
/
SHOW ERRORS;
/
CREATE OR REPLACE PACKAGE BODY pc_inf_rosa_dos_ventos
AS

/*
*******************************************************************************
**                     === Documentacao da Procedure ===
**
**  Arquivo....: Rosa_dos_ventos.pro
**  Procedure..: up_rosa_dos_ventos
**  Autor......: Marco Cesare
**  Data.......: 09/10/2002
**
**  Objetivo:
**  - Obter informações para gráfico de Rosa dos Ventos.
**
**  Tabelas Usadas:
**  - Consulta: medicao
**  - Atualiza:
**
**  Observacoes: O mecanismo de cálculo inicial é semelhante ao 
**               relatório do Sumário Climatatológico 02 com algumas
**               atividades de controle.
**    
**  Alteracoes:
**   - dd/mm/aa =
**
*******************************************************************************
*/
PROCEDURE up_inf_rosa_dos_ventos (p_id_estacao IN estacao.id_estacao%type,
                                  p_no_pista   IN medicao.no_pista%type,
                                  p_dt_inicial IN VARCHAR2,
                                  p_dt_final   IN VARCHAR2,
                                  p_retorno    IN OUT registro_detail)
IS

   /* Definição de estruturas */
   tab_registro_detail        registro_detail;
   tab_registro_detail_valor  registro_detail_valor;

   /* Definição de variáveis */
   w_total           NUMBER := 0;
   w_perc_maximo     NUMBER := 0;
   w_vl_acresc       NUMBER := 0;
   w_vl_exterior     NUMBER := 0;
   w_vl_interior     NUMBER := 0;
   w_cont_linha      NUMBER := 1;
   w_count           NUMBER;
   w_dir_vento       param_geral.cd_opcao%type := NULL;
   w_vel_vento       param_geral.cd_opcao%type := NULL;
   w_rajada          param_geral.cd_opcao%type := NULL;
   w_qt_faixa        NUMBER := 14;
   w_no_linha        NUMBER := 0;
   w_dt_inicial	     DATE;
   w_dt_final	     DATE;
	   

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

BEGIN

   /* Analisar passagem de parâmetros */
   IF (p_id_estacao IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Estação deve ser informada');
   END IF;

   IF (p_dt_inicial IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Inicial deve ser informada');
   END IF;
   
   IF (p_dt_final IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Data Final deve ser informada');
   END IF;

   /* Definir datas */
   w_dt_inicial := to_date(p_dt_inicial, 'dd/mm/rrrr');
   w_dt_final   := to_date(p_dt_final,   'dd/mm/rrrr');

   /* Obter os atributos de cada coluna do relatório */
   FOR rec0 IN Atributos_Relatorio LOOP

       /* Verificar atributo obtido */
       IF    (rec0.no_ordena1 = 01) THEN
          w_dir_vento    := rec0.cd_opcao;
       ELSIF (rec0.no_ordena1 = 02) THEN
          w_vel_vento    := rec0.cd_opcao;   
       END IF;
          
   END LOOP;

   /* Analisar se atributos foram resgatados */
   IF (w_dir_vento IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo de Direção do Vento não cadastrado');
   END IF;

   IF (w_vel_vento IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Atributo de Velocidade do Vento não cadastrado');
   END IF;

   /* Inserir quantidade de linhas correspondentes ao número faixas de velocidade */
   FOR i IN 1..w_qt_faixa LOOP
   
       /* Inicializar valores */
       tab_registro_detail_valor(i).dir_020_040 := 0;
       tab_registro_detail_valor(i).dir_050_070 := 0;
       tab_registro_detail_valor(i).dir_080_100 := 0;
       tab_registro_detail_valor(i).dir_110_130 := 0;
       tab_registro_detail_valor(i).dir_140_160 := 0;
       tab_registro_detail_valor(i).dir_170_190 := 0;
       tab_registro_detail_valor(i).dir_200_220 := 0;
       tab_registro_detail_valor(i).dir_230_250 := 0;
       tab_registro_detail_valor(i).dir_260_280 := 0;
       tab_registro_detail_valor(i).dir_290_310 := 0;
       tab_registro_detail_valor(i).dir_320_340 := 0;
       tab_registro_detail_valor(i).dir_350_010 := 0;
       tab_registro_detail_valor(i).dir_total   := 0;
       tab_registro_detail_valor(i).dir_calmo   := 0;
          
   END LOOP;

   /* Loop sobre registros da velocidade do vento */
   FOR rec1 IN Vento LOOP

       /* Direção 990 corresponde a variação da direção */
       IF (rec1.dir <> 990) THEN

          w_no_linha := 0;

          /* Analisar linha onde atribuir a informação */
          IF    ((rec1.vel >= 01.0) AND (rec1.vel < 02.5)) THEN
             w_no_linha := 01;
          END IF;
          
          IF ((rec1.vel >= 02.5) AND (rec1.vel < 04.5)) THEN
             w_no_linha := 02;
          END IF;

          IF ((rec1.vel >= 04.5) AND (rec1.vel < 06.5)) THEN
             w_no_linha := 03;
          END IF;

          IF ((rec1.vel >= 06.5) AND (rec1.vel < 08.5)) THEN
             w_no_linha := 04;
          END IF;

          IF ((rec1.vel >= 08.5) AND (rec1.vel < 10.5)) THEN
             w_no_linha := 05;
          END IF;

          IF ((rec1.vel >= 10.5) AND (rec1.vel < 12.5)) THEN
             w_no_linha := 06;
          END IF;

          IF ((rec1.vel >= 12.5) AND (rec1.vel < 14.5)) THEN
             w_no_linha := 07;
          END IF;

          IF ((rec1.vel >= 14.5) AND (rec1.vel < 16.5)) THEN
             w_no_linha := 08;
          END IF;

          IF ((rec1.vel >= 16.5) AND (rec1.vel < 18.5)) THEN
             w_no_linha := 09;
          END IF;

          IF ((rec1.vel >= 18.5) AND (rec1.vel < 20.5)) THEN
             w_no_linha := 10;
          END IF;

          IF ((rec1.vel >= 20.5) AND (rec1.vel < 22.5)) THEN
             w_no_linha := 11;
          END IF;

          IF ((rec1.vel >= 22.5) AND (rec1.vel < 24.5)) THEN
             w_no_linha := 12;
          END IF;

          IF  (rec1.vel >= 24.5)                        THEN
             w_no_linha := 13;
          END IF;
       
          /* Analisar coluna onde atribuir a informação */
          IF (w_no_linha <> 0) THEN
 
             IF    ((rec1.dir >= 020)  AND (rec1.dir <= 040)) THEN
                tab_registro_detail_valor(w_no_linha).dir_020_040 := tab_registro_detail_valor(w_no_linha).dir_020_040 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_020_040 := tab_registro_detail_valor(w_qt_faixa).dir_020_040 + 1;
             ELSIF ((rec1.dir >= 050)  AND (rec1.dir <= 070)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_050_070 := tab_registro_detail_valor(w_no_linha).dir_050_070 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_050_070 := tab_registro_detail_valor(w_qt_faixa).dir_050_070 + 1;
             ELSIF ((rec1.dir >= 080)  AND (rec1.dir <= 100)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_080_100 := tab_registro_detail_valor(w_no_linha).dir_080_100 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_080_100 := tab_registro_detail_valor(w_qt_faixa).dir_080_100 + 1;
             ELSIF ((rec1.dir >= 110)  AND (rec1.dir <= 130)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_110_130 := tab_registro_detail_valor(w_no_linha).dir_110_130 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_110_130 := tab_registro_detail_valor(w_qt_faixa).dir_110_130 + 1;
             ELSIF ((rec1.dir >= 140)  AND (rec1.dir <= 160)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_140_160 := tab_registro_detail_valor(w_no_linha).dir_140_160 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_140_160 := tab_registro_detail_valor(w_qt_faixa).dir_140_160 + 1;
             ELSIF ((rec1.dir >= 170)  AND (rec1.dir <= 190)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_170_190 := tab_registro_detail_valor(w_no_linha).dir_170_190 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_170_190 := tab_registro_detail_valor(w_qt_faixa).dir_170_190 + 1;
             ELSIF ((rec1.dir >= 200)  AND (rec1.dir <= 220)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_200_220 := tab_registro_detail_valor(w_no_linha).dir_200_220 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_200_220 := tab_registro_detail_valor(w_qt_faixa).dir_200_220 + 1;
             ELSIF ((rec1.dir >= 230)  AND (rec1.dir <= 250)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_230_250 := tab_registro_detail_valor(w_no_linha).dir_230_250 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_230_250 := tab_registro_detail_valor(w_qt_faixa).dir_230_250 + 1;
             ELSIF ((rec1.dir >= 260)  AND (rec1.dir <= 280)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_260_280 := tab_registro_detail_valor(w_no_linha).dir_260_280 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_260_280 := tab_registro_detail_valor(w_qt_faixa).dir_260_280 + 1;
             ELSIF ((rec1.dir >= 290)  AND (rec1.dir <= 310)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_290_310 := tab_registro_detail_valor(w_no_linha).dir_290_310 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_290_310 := tab_registro_detail_valor(w_qt_faixa).dir_290_310 + 1;
             ELSIF ((rec1.dir >= 320)  AND (rec1.dir <= 340)) THEN   
                tab_registro_detail_valor(w_no_linha).dir_320_340 := tab_registro_detail_valor(w_no_linha).dir_320_340 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_320_340 := tab_registro_detail_valor(w_qt_faixa).dir_320_340 + 1;
             ELSIF (((rec1.dir >= 350) AND (rec1.dir <= 360)) OR ((rec1.dir >= 010) AND (rec1.dir <= 010))) THEN
                tab_registro_detail_valor(w_no_linha).dir_350_010 := tab_registro_detail_valor(w_no_linha).dir_350_010 + 1;
                tab_registro_detail_valor(w_qt_faixa).dir_350_010 := tab_registro_detail_valor(w_qt_faixa).dir_350_010 + 1;
             END IF;          

             /* Adicionar ao total da linha e total geral */
             tab_registro_detail_valor(w_no_linha).dir_total := tab_registro_detail_valor(w_no_linha).dir_total + 1;
             tab_registro_detail_valor(w_qt_faixa).dir_total := tab_registro_detail_valor(w_qt_faixa).dir_total + 1;
             w_total                                         := w_total  + 1;
          
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
      tab_registro_detail_valor(w_qt_faixa).dir_calmo := 0;
   ELSE
      tab_registro_detail_valor(1).dir_calmo          := w_count;
      tab_registro_detail_valor(w_qt_faixa).dir_calmo := w_count;
   END IF;     

   /* Evitar "divide by zero" */
   IF (w_total <> 0) THEN
   
      /* Transformar em percentual */
      FOR i IN 1..w_qt_faixa LOOP
   
          /* Inicializar valores */
          tab_registro_detail_valor(i).dir_020_040 := round(tab_registro_detail_valor(i).dir_020_040 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_050_070 := round(tab_registro_detail_valor(i).dir_050_070 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_080_100 := round(tab_registro_detail_valor(i).dir_080_100 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_110_130 := round(tab_registro_detail_valor(i).dir_110_130 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_140_160 := round(tab_registro_detail_valor(i).dir_140_160 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_170_190 := round(tab_registro_detail_valor(i).dir_170_190 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_200_220 := round(tab_registro_detail_valor(i).dir_200_220 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_230_250 := round(tab_registro_detail_valor(i).dir_230_250 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_260_280 := round(tab_registro_detail_valor(i).dir_260_280 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_290_310 := round(tab_registro_detail_valor(i).dir_290_310 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_320_340 := round(tab_registro_detail_valor(i).dir_320_340 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_350_010 := round(tab_registro_detail_valor(i).dir_350_010 * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_total   := round(tab_registro_detail_valor(i).dir_total   * 100 / w_total, 2);
          tab_registro_detail_valor(i).dir_calmo   := round(tab_registro_detail_valor(i).dir_calmo   * 100 / w_total, 2);
          
      END LOOP;

      /* Gerar linha de totais de linha */
      tab_registro_detail(73).vl_grau   := 'TLIN';
      tab_registro_detail(73).vl_col_1  := tab_registro_detail_valor(w_qt_faixa).dir_020_040;
      tab_registro_detail(73).vl_col_2  := tab_registro_detail_valor(w_qt_faixa).dir_050_070;
      tab_registro_detail(73).vl_col_3  := tab_registro_detail_valor(w_qt_faixa).dir_080_100;
      tab_registro_detail(73).vl_col_4  := tab_registro_detail_valor(w_qt_faixa).dir_110_130;
      tab_registro_detail(73).vl_col_5  := tab_registro_detail_valor(w_qt_faixa).dir_140_160;
      tab_registro_detail(73).vl_col_6  := tab_registro_detail_valor(w_qt_faixa).dir_170_190;
      tab_registro_detail(73).vl_col_7  := tab_registro_detail_valor(w_qt_faixa).dir_200_220;
      tab_registro_detail(73).vl_col_8  := tab_registro_detail_valor(w_qt_faixa).dir_230_250;
      tab_registro_detail(73).vl_col_9  := tab_registro_detail_valor(w_qt_faixa).dir_260_280;
      tab_registro_detail(73).vl_col_10 := tab_registro_detail_valor(w_qt_faixa).dir_290_310;
      tab_registro_detail(73).vl_col_11 := tab_registro_detail_valor(w_qt_faixa).dir_320_340;
      tab_registro_detail(73).vl_col_12 := tab_registro_detail_valor(w_qt_faixa).dir_350_010;
      tab_registro_detail(73).vl_col_13 := tab_registro_detail_valor(w_qt_faixa).dir_calmo;
      
      /* Gerar linha de totais de coluna */
      tab_registro_detail(74).vl_grau   := 'TCOL';
      tab_registro_detail(74).vl_col_1  := tab_registro_detail_valor(1).dir_total;
      tab_registro_detail(74).vl_col_2  := tab_registro_detail_valor(2).dir_total;
      tab_registro_detail(74).vl_col_3  := tab_registro_detail_valor(3).dir_total;
      tab_registro_detail(74).vl_col_4  := tab_registro_detail_valor(4).dir_total;
      tab_registro_detail(74).vl_col_5  := tab_registro_detail_valor(5).dir_total;
      tab_registro_detail(74).vl_col_6  := tab_registro_detail_valor(6).dir_total;
      tab_registro_detail(74).vl_col_7  := tab_registro_detail_valor(7).dir_total;
      tab_registro_detail(74).vl_col_8  := tab_registro_detail_valor(8).dir_total;
      tab_registro_detail(74).vl_col_9  := tab_registro_detail_valor(9).dir_total;
      tab_registro_detail(74).vl_col_10 := tab_registro_detail_valor(10).dir_total;
      tab_registro_detail(74).vl_col_11 := tab_registro_detail_valor(11).dir_total;
      tab_registro_detail(74).vl_col_12 := tab_registro_detail_valor(12).dir_total;
      tab_registro_detail(74).vl_col_13 := tab_registro_detail_valor(13).dir_total;
      
      /* Analisar percentual máximo */
      IF (tab_registro_detail_valor(w_qt_faixa).dir_020_040 > w_perc_maximo) THEN
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_020_040;
      END IF;
      
      IF (tab_registro_detail_valor(w_qt_faixa).dir_050_070 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_050_070;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_080_100 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_080_100;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_110_130 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_110_130;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_140_160 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_140_160;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_170_190 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_170_190;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_200_220 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_200_220;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_230_250 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_230_250;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_260_280 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_260_280;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_290_310 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_290_310;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_320_340 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_320_340;
      END IF;

      IF (tab_registro_detail_valor(w_qt_faixa).dir_350_010 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(w_qt_faixa).dir_350_010;
      END IF;

      /* Verificar valor de acréscimo */
      IF   ((w_perc_maximo >= 10) AND (w_perc_maximo < 15)) THEN
         w_vl_acresc   := 5;
      ELSIF (w_perc_maximo >= 15) THEN
         w_vl_acresc   := 10;
      END IF;

      /* Verificar valor máximo para definir círculo exterior */
      IF    ((w_perc_maximo >= 15) AND (w_perc_maximo < 25)) THEN
         w_vl_exterior   := 4000;
      ELSIF ((w_perc_maximo >= 25) AND (w_perc_maximo < 35)) THEN
         w_vl_exterior   := 4000;
      ELSE
         w_vl_exterior   := 4000;
      END IF;

      /* Acrescer valores por faixa */
      FOR i IN 1..(w_qt_faixa - 1) LOOP
   
          /* Inicializar valores */
          IF (i = 1) THEN
             tab_registro_detail_valor(i).dir_020_040 := tab_registro_detail_valor(i).dir_020_040 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_050_070 := tab_registro_detail_valor(i).dir_050_070 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_080_100 := tab_registro_detail_valor(i).dir_080_100 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_110_130 := tab_registro_detail_valor(i).dir_110_130 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_140_160 := tab_registro_detail_valor(i).dir_140_160 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_170_190 := tab_registro_detail_valor(i).dir_170_190 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_200_220 := tab_registro_detail_valor(i).dir_200_220 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_230_250 := tab_registro_detail_valor(i).dir_230_250 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_260_280 := tab_registro_detail_valor(i).dir_260_280 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_290_310 := tab_registro_detail_valor(i).dir_290_310 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_320_340 := tab_registro_detail_valor(i).dir_320_340 + w_vl_acresc;
             tab_registro_detail_valor(i).dir_350_010 := tab_registro_detail_valor(i).dir_350_010 + w_vl_acresc;
          ELSE   
             tab_registro_detail_valor(i).dir_020_040 := tab_registro_detail_valor(i).dir_020_040 + tab_registro_detail_valor(i - 1).dir_020_040; 
             tab_registro_detail_valor(i).dir_050_070 := tab_registro_detail_valor(i).dir_050_070 + tab_registro_detail_valor(i - 1).dir_050_070; 
             tab_registro_detail_valor(i).dir_080_100 := tab_registro_detail_valor(i).dir_080_100 + tab_registro_detail_valor(i - 1).dir_080_100; 
             tab_registro_detail_valor(i).dir_110_130 := tab_registro_detail_valor(i).dir_110_130 + tab_registro_detail_valor(i - 1).dir_110_130; 
             tab_registro_detail_valor(i).dir_140_160 := tab_registro_detail_valor(i).dir_140_160 + tab_registro_detail_valor(i - 1).dir_140_160; 
             tab_registro_detail_valor(i).dir_170_190 := tab_registro_detail_valor(i).dir_170_190 + tab_registro_detail_valor(i - 1).dir_170_190; 
             tab_registro_detail_valor(i).dir_200_220 := tab_registro_detail_valor(i).dir_200_220 + tab_registro_detail_valor(i - 1).dir_200_220; 
             tab_registro_detail_valor(i).dir_230_250 := tab_registro_detail_valor(i).dir_230_250 + tab_registro_detail_valor(i - 1).dir_230_250; 
             tab_registro_detail_valor(i).dir_260_280 := tab_registro_detail_valor(i).dir_260_280 + tab_registro_detail_valor(i - 1).dir_260_280; 
             tab_registro_detail_valor(i).dir_290_310 := tab_registro_detail_valor(i).dir_290_310 + tab_registro_detail_valor(i - 1).dir_290_310; 
             tab_registro_detail_valor(i).dir_320_340 := tab_registro_detail_valor(i).dir_320_340 + tab_registro_detail_valor(i - 1).dir_320_340; 
             tab_registro_detail_valor(i).dir_350_010 := tab_registro_detail_valor(i).dir_350_010 + tab_registro_detail_valor(i - 1).dir_350_010; 
          END IF;
          
      END LOOP;
      
      /* Analisar maior valor na linha 07 */
      w_perc_maximo    := 0;
      
      IF (tab_registro_detail_valor(7).dir_020_040 > w_perc_maximo) THEN
         w_perc_maximo := tab_registro_detail_valor(7).dir_020_040;
      END IF;
      
      IF (tab_registro_detail_valor(7).dir_050_070 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_050_070;
      END IF;

      IF (tab_registro_detail_valor(7).dir_080_100 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_080_100;
      END IF;

      IF (tab_registro_detail_valor(7).dir_110_130 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_110_130;
      END IF;

      IF (tab_registro_detail_valor(7).dir_140_160 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_140_160;
      END IF;

      IF (tab_registro_detail_valor(7).dir_170_190 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_170_190;
      END IF;

      IF (tab_registro_detail_valor(7).dir_200_220 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_200_220;
      END IF;

      IF (tab_registro_detail_valor(7).dir_230_250 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_230_250;
      END IF;

      IF (tab_registro_detail_valor(7).dir_260_280 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_260_280;
      END IF;

      IF (tab_registro_detail_valor(7).dir_290_310 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_290_310;
      END IF;

      IF (tab_registro_detail_valor(7).dir_320_340 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_320_340;
      END IF;

      IF (tab_registro_detail_valor(7).dir_350_010 > w_perc_maximo) THEN 
         w_perc_maximo := tab_registro_detail_valor(7).dir_350_010;
      END IF;

      /* Verificar valor máximo para definir círculo interior */
      w_perc_maximo    := trunc(w_perc_maximo / 3);
      
      IF    ((w_perc_maximo >= 05) AND (w_perc_maximo < 15)) THEN
         w_vl_interior := 1000;
      ELSIF ((w_perc_maximo >= 15) AND (w_perc_maximo < 25)) THEN
         w_vl_interior := 2000;
      ELSE
         w_vl_interior := 0500;
      END IF;

      /* Inicializar valores */
      FOR i IN 1..72 LOOP

          IF ((i = 1) OR (mod(i - 7,6) = 0)) THEN
             tab_registro_detail(i).vl_col_1     := w_vl_exterior;
             
             IF (i = 01) THEN
                tab_registro_detail(i).vl_grau   := '0º';
             END IF;                
                
             IF (i = 07) THEN
                tab_registro_detail(i).vl_grau   := '30º';
             END IF;                

             IF (i = 13) THEN
                tab_registro_detail(i).vl_grau   := '60º';
             END IF;                

             IF (i = 19) THEN
                tab_registro_detail(i).vl_grau   := '90º';
             END IF;                

             IF (i = 25) THEN
                tab_registro_detail(i).vl_grau   := '120º';
             END IF;                

             IF (i = 31) THEN
                tab_registro_detail(i).vl_grau   := '150º';
             END IF;                

             IF (i = 37) THEN
                tab_registro_detail(i).vl_grau   := '180º';
             END IF;                

             IF (i = 43) THEN
                tab_registro_detail(i).vl_grau   := '210º';
             END IF;                

             IF (i = 49) THEN
                tab_registro_detail(i).vl_grau   := '240º';
             END IF;                

             IF (i = 55) THEN
                tab_registro_detail(i).vl_grau   := '270º';
             END IF;                

             IF (i = 61) THEN
                tab_registro_detail(i).vl_grau   := '300º';
             END IF;                

             IF (i = 67) THEN
                tab_registro_detail(i).vl_grau   := '330º';
             END IF;                
 
          ELSE 
             tab_registro_detail(i).vl_col_1     := 0;
             tab_registro_detail(i).vl_grau      := '.';
          END IF;
      
          tab_registro_detail(i).vl_col_2        := 0;
          tab_registro_detail(i).vl_col_3        := 0;
          tab_registro_detail(i).vl_col_4        := 0; 
          tab_registro_detail(i).vl_col_5        := 0; 
          tab_registro_detail(i).vl_col_6        := 0; 
          tab_registro_detail(i).vl_col_7        := 0; 
          tab_registro_detail(i).vl_col_8        := 0; 
          tab_registro_detail(i).vl_col_9        := w_vl_interior; 
          
      END LOOP;
      
      /* Loop sobre as 12 colunas */
      FOR i IN 1..12 LOOP

          /* Repetição dos valores 5 vezes */
          FOR j IN 1..5 LOOP

              /* Coluna de 0º graus */
              IF (i = 1) THEN

                 /* Caso específico essa coluna */
                 IF    (j = 4) THEN
                    tab_registro_detail(71).vl_col_8           := tab_registro_detail_valor(1).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_7           := tab_registro_detail_valor(2).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_6           := tab_registro_detail_valor(3).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_5           := tab_registro_detail_valor(4).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_4           := tab_registro_detail_valor(5).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_3           := tab_registro_detail_valor(6).dir_350_010 * 100;
                    tab_registro_detail(71).vl_col_2           := tab_registro_detail_valor(7).dir_350_010 * 100;
                    w_cont_linha                               := w_cont_linha - 1;
                 ELSIF (j = 5) THEN
                    tab_registro_detail(72).vl_col_8           := tab_registro_detail_valor(1).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_7           := tab_registro_detail_valor(2).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_6           := tab_registro_detail_valor(3).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_5           := tab_registro_detail_valor(4).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_4           := tab_registro_detail_valor(5).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_3           := tab_registro_detail_valor(6).dir_350_010 * 100;
                    tab_registro_detail(72).vl_col_2           := tab_registro_detail_valor(7).dir_350_010 * 100;
                    w_cont_linha                               := w_cont_linha - 1;
                 ELSE
                    tab_registro_detail(w_cont_linha).vl_col_8 := tab_registro_detail_valor(1).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_7 := tab_registro_detail_valor(2).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_6 := tab_registro_detail_valor(3).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_5 := tab_registro_detail_valor(4).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_4 := tab_registro_detail_valor(5).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_3 := tab_registro_detail_valor(6).dir_350_010 * 100;
                    tab_registro_detail(w_cont_linha).vl_col_2 := tab_registro_detail_valor(7).dir_350_010 * 100;
                 END IF;
                 
              END IF;
              
              /* Coluna de 30º graus */
              IF (i = 2) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_020_040 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_020_040 * 100;
              END IF;
              
              /* Coluna de 60º graus */
              IF (i = 3) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_050_070 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_050_070 * 100;
              END IF;

              /* Coluna de 90º graus */
              IF (i = 4) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_080_100 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_080_100 * 100;
              END IF;

              /* Coluna de 120º graus */
              IF (i = 5) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_110_130 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_110_130 * 100;
              END IF;

              /* Coluna de 150º graus */
              IF (i = 6) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_140_160 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_140_160 * 100;
              END IF;

              /* Coluna de 180º graus */
              IF (i = 7) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_170_190 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_170_190 * 100;
              END IF;

              /* Coluna de 210º graus */
              IF (i = 8) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_200_220 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_200_220 * 100;
              END IF;

              /* Coluna de 240º graus */
              IF (i = 9) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_230_250 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_230_250 * 100;
              END IF;

              /* Coluna de 270º graus */
              IF (i = 10) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_260_280 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_260_280 * 100;
              END IF;

              /* Coluna de 300º graus */
              IF (i = 11) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_290_310 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_290_310 * 100;
              END IF;

              /* Coluna de 330º graus */
              IF (i = 12) THEN
                 tab_registro_detail(w_cont_linha).vl_col_8    := tab_registro_detail_valor(1).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_7    := tab_registro_detail_valor(2).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_6    := tab_registro_detail_valor(3).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_5    := tab_registro_detail_valor(4).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_4    := tab_registro_detail_valor(5).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_3    := tab_registro_detail_valor(6).dir_320_340 * 100;
                 tab_registro_detail(w_cont_linha).vl_col_2    := tab_registro_detail_valor(7).dir_320_340 * 100;
              END IF;

              /* Incrementar contador de linha */
              w_cont_linha := w_cont_linha + 1;
              
          END LOOP;
      
          /* Incrementar contador de linha */
          w_cont_linha := w_cont_linha + 1;

      END LOOP;
      
   END IF;

   /* Definir retorno */
   p_retorno := tab_registro_detail;

END up_inf_rosa_dos_ventos;

END pc_inf_rosa_dos_ventos;
/
SHOW ERRORS;
/
GRANT EXECUTE ON pc_inf_rosa_dos_ventos TO bdclim_ger_01
/