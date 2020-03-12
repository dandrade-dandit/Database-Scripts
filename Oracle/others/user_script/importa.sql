CREATE OR REPLACE PROCEDURE up_inf_importa_historico  (p_no_sinotico IN importa_infomet.nsinot%type,
                                                       p_aa_medicao  IN importa_infomet.ano%type   ,
                                                       p_mm_medicao  IN importa_infomet.mes%type   )
                           
IS
/*
*******************************************************************************
**                  === Documentacao da Procedure ===
**
**  Arquivo..: importa.pro
**  Procedure: up_inf_importa_historico
**  Autor....: Marco Cesare
**  Data.....: 15/07/2002
**
**  Objetivo:
**  - Importar os dados hist�ricos do Infomet
**
**  Programa(s) que chama(m):
**  - Procedure: 
**
**  Tabelas Usadas:
**  - Consulta: 
**  - Atualiza: 
**
**  Parametro(s):
**  - p_no_sinotico  = N�mero do sin�tico (obrigat�rio)
**  - p_aa_medicao   = Ano da medi��o (opcional)
**  - p_mm_medicao   = M�s da medi��o (opcional)
**
**  Retorno:
**  - Descri��o do erro ou brancos em caso de sucesso
**
**  Observacoes:
**  - As informa��es para importa��o dever�o ser carregadas via LOADER
**    no banco de dados para posterior execu��o desta procedure. Esta 
**    procedure ir� analisar cada um dos registros contidos na tabela
**    IMPORTA_INFOMET. A tabela ATRIBUTO_INFRAERO definir� os c�digos 
**    dos atributos para o BDCLIM.
**
**    Ao final da importa��o ser� gerado um registro na tabela 
**    LOG_IMPORTA_INFOMET detalhando a importa��o e os registros com
**    problemas ser�o inseridos na tabela LOG_ERRO_IMPORTA_INFOMET.
**    No caso de algum atributo n�o possuir valor ele ser� gravado 
**    com o valor "0"
**
**    O tratamento dos atributos ser�o feitos da seguinte maneira:
**
**    Dire��o Vento: Tratado como num�rico em dezena de graus, 
**                   portanto seu valor ser� inclu�do multiplicado
**                   por 10. No caso de valor 99 ser� desprezado.
**    Veloc.Vento  : Tratado como num�rico em n�s.
**    Rajada Vento : Tratado como num�rico em n�s.
**    Visibilidade : Tratado como num�rico em dec�metro.
**    Dire��o Visib: Tratado como alfanum�rico. Os valores devem
**                   constar na tabela atributo_codigo. 
**    RVR (Visib)  : Tratado como num�rico em dec�metro.
**    Cond. Tempo  : Tratado como alfanum�rico. Os valores devem
**                   constar na tabela atributo_codigo e estar�o 
**                   separados por v�rgulas.
**    Qtde. Nuvem  : Tratado como num�rico em oitavos. No caso de 
**                   c�u obscurecido registra-se 9. A altitude ser�
**                   determinada pela coluna NUVn_ALT convertida de
**                   dec�metro para metros (dam * 10 = m).
**    Tipo Nuvem   : Tratado como alfanum�rico. No caso de 
**                   c�u obscurecido registra-se 9. A altitude ser�
**                   determinada pela coluna NUVn_ALT convertida de
**                   dec�metro para metros (dam * 10 = m).
**    Dire��o Nuvem: Tratado como alfanum�rico. No caso de 
**                   c�u obscurecido registra-se 9. A altitude ser�
**                   determinada pela coluna NUVn_ALT convertida de
**                   dec�metro para metros (dam * 10 = m).
**    Total Nuvem  : Tratado como num�rico em oitavos. 
**    Teto Nuvem   : Tratado como num�rico em dec�metros. 
**    QFH          : Tratado como num�rico em hectopascal. 
**    QFE          : Tratado como num�rico em hectopascal. 
**    QFF          : Tratado como num�rico em hectopascal. 
**    Tend. Press�o: Tratado como alfanum�rico. Os valores devem
**                   constar na tabela atributo_codigo. 
**    Temp. Ar     : Tratado como num�rico em graus Celsius.
**    Bulbo Seco   : Tratado como num�rico em graus Celsius.
**    Bulbo �mido  : Tratado como num�rico em graus Celsius.
**    Ponto Orvalho: Tratado como num�rico em graus Celsius.
**    Umidade Rel. : Tratado como num�rico em percentual.
**    M�dia 12 hs  : Tratado como num�rico em graus Celsius.
**    Altitude 850 : Tratado como num�rico em dec�metros geopotenciais.
**    Precipitacao : Tratado como num�rico em milimetros.
**    Tempo Precip : Tratado como num�rico em minutos.
**    Observa��o   : Tratado como alfanum�rico. Os valores est�o separados
**                   pelo caracter "&" e devem constar da tabela 
**                   atributo_codigo.
**
**  Alteracoes:
**  - dd/mm/aa =
**
*******************************************************************************
*/

   /* Vari�veis de trabalho */
   w_param_sin           varchar2(020);
   w_param_ano           varchar2(020);
   w_param_mes           varchar2(020);
   
   w_dc_erro             varchar2(050);
   w_vl_erro             varchar2(050);
   w_fl_erro             boolean;   
   w_fl_erro_obs         boolean;
   w_cd_erro             number;

   w_id_estacao          estacao.id_estacao%type;
   w_cd_estacao          estacao.cd_estacao%type;
   w_no_pista            estacao_pista.no_pista%type;
   w_no_pista_1          estacao_pista.no_pista%type;
   w_no_pista_2          estacao_pista.no_pista%type;
   w_no_pista_3          estacao_pista.no_pista%type;
   w_no_pista_4          estacao_pista.no_pista%type;
   w_tb_cond_tempo       varchar2(050);
   w_vl_observacao_aux1  varchar2(050);
   w_vl_observacao_aux2  varchar2(050);

   w_fl_pista1           boolean;
   w_fl_pista2           boolean;
   w_fl_pista3           boolean;
   w_fl_pista4           boolean;
   w_dt_medicao          medicao.dt_medicao%type;
   w_dt_medicao_aux      medicao.dt_medicao%type;
   w_hr_medicao          medicao.hr_medicao%type;
   w_qt_horas            number;
   w_hr_inicio           varchar2(004) := NULL; 
   w_count               integer;

   w_fl_modifica         boolean       := FALSE;
   w_vl_precipt          number;
   w_dia_ant             varchar2(020) := NULL;
   w_vl_anterior         number        := 0;
   w_hh_prec             varchar2(020);
   w_mi_prec             varchar2(020);

   w_cd_sinotico         varchar2(020);
   w_aa_medicao          varchar2(020);
   w_mm_medicao          varchar2(020);
   w_dd_medicao          varchar2(020);
   w_hh_medicao          varchar2(020);
   w_mi_medicao          varchar2(020);

   /* Atributos dos c�digos */ 
   w_cd_dir_vento        atributo.cd_atributo%type     := null;
   w_cd_veloc_vento      atributo.cd_atributo%type     := null;
   w_cd_rajada_vento     atributo.cd_atributo%type     := null;
   w_cd_visibilidade     atributo.cd_atributo%type     := null;
   w_cd_direc_visib      atributo.cd_atributo%type     := null;
   w_cd_rvr              atributo.cd_atributo%type     := null;
   w_cd_cond_tempo       atributo.cd_atributo%type     := null;
   w_cd_qtde_nuvem       atributo.cd_atributo%type     := null;
   w_cd_tipo_nuvem       atributo.cd_atributo%type     := null;
   w_cd_direcao_nuvem    atributo.cd_atributo%type     := null;
   w_cd_total_nuvem      atributo.cd_atributo%type     := null;
   w_cd_teto             atributo.cd_atributo%type     := null;
   w_cd_qnh              atributo.cd_atributo%type     := null;
   w_cd_qfe              atributo.cd_atributo%type     := null;
   w_cd_qff              atributo.cd_atributo%type     := null;
   w_cd_tend_pressao     atributo.cd_atributo%type     := null;
   w_cd_diferenca3       atributo.cd_atributo%type     := null;
   w_cd_tp               atributo.cd_atributo%type     := null;
   w_cd_bs               atributo.cd_atributo%type     := null;
   w_cd_bu               atributo.cd_atributo%type     := null;
   w_cd_po               atributo.cd_atributo%type     := null;
   w_cd_ur               atributo.cd_atributo%type     := null;
   w_cd_media12          atributo.cd_atributo%type     := null;
   w_cd_alt850           atributo.cd_atributo%type     := null;
   w_cd_precipitacao     atributo.cd_atributo%type     := null;
   w_cd_dur_precipit     atributo.cd_atributo%type     := null;
   w_cd_tempo            atributo.cd_atributo%type     := null;
   w_cd_observacao       atributo.cd_atributo%type     := null;

   /* Tipo de medi��o dos atributos */
   w_tp_dir_vento        atributo.cd_tipo_medicao%type := null;
   w_tp_veloc_vento      atributo.cd_tipo_medicao%type := null;
   w_tp_rajada_vento     atributo.cd_tipo_medicao%type := null;
   w_tp_visibilidade     atributo.cd_tipo_medicao%type := null;
   w_tp_direc_visib      atributo.cd_tipo_medicao%type := null;
   w_tp_rvr              atributo.cd_tipo_medicao%type := null;
   w_tp_cond_tempo       atributo.cd_tipo_medicao%type := null;
   w_tp_qtde_nuvem       atributo.cd_tipo_medicao%type := null;
   w_tp_tipo_nuvem       atributo.cd_tipo_medicao%type := null;
   w_tp_direcao_nuvem    atributo.cd_tipo_medicao%type := null;
   w_tp_total_nuvem      atributo.cd_tipo_medicao%type := null;
   w_tp_teto             atributo.cd_tipo_medicao%type := null;
   w_tp_qnh              atributo.cd_tipo_medicao%type := null;
   w_tp_qfe              atributo.cd_tipo_medicao%type := null;
   w_tp_qff              atributo.cd_tipo_medicao%type := null;
   w_tp_tend_pressao     atributo.cd_tipo_medicao%type := null;
   w_tp_diferenca3       atributo.cd_tipo_medicao%type := null;
   w_tp_tp               atributo.cd_tipo_medicao%type := null;
   w_tp_bs               atributo.cd_tipo_medicao%type := null;
   w_tp_bu               atributo.cd_tipo_medicao%type := null;
   w_tp_po               atributo.cd_tipo_medicao%type := null;
   w_tp_ur               atributo.cd_tipo_medicao%type := null;
   w_tp_media12          atributo.cd_tipo_medicao%type := null;
   w_tp_alt850           atributo.cd_tipo_medicao%type := null;
   w_tp_precipitacao     atributo.cd_tipo_medicao%type := null;
   w_tp_dur_precipit     atributo.cd_tipo_medicao%type := null;
   w_tp_tempo            atributo.cd_tipo_medicao%type := null;
   w_tp_observacao       atributo.cd_tipo_medicao%type := null;

   /* Cursor para obter correla��o atributos Infomet e BDCLIM */
   CURSOR Atributos_Bdclim IS
          SELECT ai1.cd_atributo, at1.cd_tipo_medicao, ai1.cd_infraero
          FROM   atributo_infraero ai1, atributo at1
          WHERE  ai1.cd_atributo = at1.cd_atributo
            AND  ai1.cd_infraero in ('DIRVENTO', 'VELVENTO', 'RAJVENTO', 'VISIBILI',
                                     'DIRVISIB', 'RVRVISIB', 'CONDTEMP', 'QTDNUVEM',
                                     'TIPNUVEM', 'DIRNUVEM', 'TOTNUVEM', 'TETNUVEM',
                                     'PRESSQNH', 'PRESSQFE', 'PRESSQFF', 'PRESSTEN',
                                     'DIFER3HR', 'TEMPERAT', 'TEMPERBS', 'TEMPERBU',
                                     'TEMPERPO', 'UMIDRELA', 'TEMP12HR', 'PRESS850',
                                     'PRECIPIT', 'TEMPOPRE', 'OBSERVAC', 'DURPRECI');
                                
   /* Cursor para obter as medi�oes a serem importadas */
   CURSOR Medicao_Infomet IS
          SELECT distinct NSINOT, ANO, MES, DIA, HORA, MINUTO, CAB1_VENTO, DIR1,
                          VEL1, RJD1, CAB2_VENTO, DIR2, VEL2, RJD2, CAB3_VENTO,
                          DIR3, VEL3, RJD3, CAB4_VENTO, DIR4, VEL4, RJD4, VIS,
                          DIR_VIS_MN, PIST_RVR1, RVR1, PIST_RVR2, RVR2, PIST_RVR3,
                          RVR3, PIST_RVR4, RVR4, CGTP1, CGTP2, CGTP3, NUV1_QNT, 
                          NUV1_TIP, NUV1_ALT, NUV2_QNT, NUV2_TIP, NUV2_ALT, NUV3_QNT,
                          NUV3_TIP, NUV3_ALT, NUV4_QNT, NUV4_TIP, NUV4_ALT, NUV1_DIR,
                          NUV2_DIR, NUV3_DIR, NUV4_DIR, TOTAL_NUV, PIST1_TETO, TETO1,
                          PIST2_TETO, TETO2, QNH, QFE, QFF, A_TEND, DIF_3HOR, PISTA1_TMP,
                          TP1, BS1, BU1, PO1, UR1, PISTA2_TMP, TP2, BS2, BU2, PO2, UR2,
                          MED_12HOR, ALT_850, PRECIPT, DIGITADOR, DATADIG, HORA_DIGT,
                          ERRO, PIST3_TETO, TETO3, PIST4_TETO, TETO4, TEMPO, OBSERVACAO
          FROM   importa_infomet
          WHERE  nsinot = w_param_sin
            AND  ano    = nvl(w_param_ano, ano)
            AND  mes    = nvl(w_param_mes, mes)
          ORDER by to_number(ano), to_number(mes), to_number(dia), to_number(hora);

            
BEGIN

   /* Verificar par�metros */
   IF (p_no_sinotico IS NULL) THEN
      RETURN;
   END IF;

   IF (p_aa_medicao IS NULL) THEN
      RETURN;
   END IF;

   IF (p_mm_medicao IS NULL) THEN
      RETURN;
   END IF;

   /* Analisar se possui algum registro */
   SELECT count(*) INTO w_count
   FROM   atributo_infraero ai1, atributo at1
   WHERE  ai1.cd_atributo = at1.cd_atributo
     AND  ai1.cd_infraero in ('DIRVENTO', 'VELVENTO', 'RAJVENTO', 'VISIBILI',
                              'DIRVISIB', 'RVRVISIB', 'CONDTEMP', 'QTDNUVEM',
                              'TIPNUVEM', 'DIRNUVEM', 'TOTNUVEM', 'TETNUVEM',
                              'PRESSQNH', 'PRESSQFE', 'PRESSQFF', 'PRESSTEN',
                              'DIFER3HR', 'TEMPERAT', 'TEMPERBS', 'TEMPERBU',
                              'TEMPERPO', 'UMIDRELA', 'TEMP12HR', 'PRESS850',
                              'PRECIPIT', 'TEMPOPRE', 'OBSERVAC', 'DURPRECI');

   /* Analisar retorno */
   IF (w_count > 0) THEN

      /* Obter o atributo BDCLIM para cada atributo INFOMET */
      FOR rec0 IN Atributos_Bdclim LOOP

          /* Verificar atributo obtido */
          IF    (rec0.cd_infraero  = 'DIRVENTO') THEN
             w_cd_dir_vento       := rec0.cd_atributo;
             w_tp_dir_vento       := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'VELVENTO') THEN
             w_cd_veloc_vento     := rec0.cd_atributo;
             w_tp_veloc_vento     := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'RAJVENTO') THEN
             w_cd_rajada_vento    := rec0.cd_atributo;
             w_tp_rajada_vento    := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'VISIBILI') THEN
             w_cd_visibilidade    := rec0.cd_atributo;     
             w_tp_visibilidade    := rec0.cd_tipo_medicao;     
          ELSIF (rec0.cd_infraero  = 'DIRVISIB') THEN
             w_cd_direc_visib     := rec0.cd_atributo;      
             w_tp_direc_visib     := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'RVRVISIB') THEN
             w_cd_rvr             := rec0.cd_atributo;    
             w_tp_rvr             := rec0.cd_tipo_medicao;    
          ELSIF (rec0.cd_infraero  = 'CONDTEMP') THEN
             w_cd_cond_tempo      := rec0.cd_atributo;    
             w_tp_cond_tempo      := rec0.cd_tipo_medicao;    
          ELSIF (rec0.cd_infraero  = 'QTDNUVEM') THEN
             w_cd_qtde_nuvem      := rec0.cd_atributo;    
             w_tp_qtde_nuvem      := rec0.cd_tipo_medicao;    
          ELSIF (rec0.cd_infraero  = 'TIPNUVEM') THEN
             w_cd_tipo_nuvem      := rec0.cd_atributo;    
             w_tp_tipo_nuvem      := rec0.cd_tipo_medicao;    
          ELSIF (rec0.cd_infraero  = 'DIRNUVEM') THEN
             w_cd_direcao_nuvem   := rec0.cd_atributo;   
             w_tp_direcao_nuvem   := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'TOTNUVEM') THEN
             w_cd_total_nuvem     := rec0.cd_atributo;   
             w_tp_total_nuvem     := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'TETNUVEM') THEN
             w_cd_teto            := rec0.cd_atributo;   
             w_tp_teto            := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'PRESSQNH') THEN
             w_cd_qnh             := rec0.cd_atributo;   
             w_tp_qnh             := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'PRESSQFE') THEN
             w_cd_qfe             := rec0.cd_atributo;   
             w_tp_qfe             := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'PRESSQFF') THEN
             w_cd_qff             := rec0.cd_atributo;   
             w_tp_qff             := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'PRESSTEN') THEN
             w_cd_tend_pressao    := rec0.cd_atributo;   
             w_tp_tend_pressao    := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'DIFER3HR') THEN
             w_cd_diferenca3      := rec0.cd_atributo;   
             w_tp_diferenca3      := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'TEMPERAT') THEN
             w_cd_tp              := rec0.cd_atributo;   
             w_tp_tp              := rec0.cd_tipo_medicao;   
          ELSIF (rec0.cd_infraero  = 'TEMPERBS') THEN
             w_cd_bs              := rec0.cd_atributo;      
             w_tp_bs              := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'TEMPERBU') THEN
             w_cd_bu              := rec0.cd_atributo;      
             w_tp_bu              := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'TEMPERPO') THEN
             w_cd_po              := rec0.cd_atributo;      
             w_tp_po              := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'UMIDRELA') THEN
             w_cd_ur              := rec0.cd_atributo;      
             w_tp_ur              := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'TEMP12HR') THEN
             w_cd_media12         := rec0.cd_atributo;      
             w_tp_media12         := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'PRESS850') THEN
             w_cd_alt850          := rec0.cd_atributo;      
             w_tp_alt850          := rec0.cd_tipo_medicao;      
          ELSIF (rec0.cd_infraero  = 'PRECIPIT') THEN
             w_cd_precipitacao    := rec0.cd_atributo;
             w_tp_precipitacao    := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'TEMPOPRE') THEN
             w_cd_tempo           := rec0.cd_atributo;
             w_tp_tempo           := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'OBSERVAC') THEN
             w_cd_observacao      := rec0.cd_atributo;
             w_tp_observacao      := rec0.cd_tipo_medicao;
          ELSIF (rec0.cd_infraero  = 'DURPRECI') THEN
             w_cd_dur_precipit    := rec0.cd_atributo;
             w_tp_dur_precipit    := rec0.cd_tipo_medicao;
          END IF;          
          
      END LOOP;
      
   END IF;

   /* Atribuir valores as vari�veis de controle */
   w_param_sin   := rtrim(p_no_sinotico);
   w_param_ano   := rtrim(p_aa_medicao);
   w_param_mes   := rtrim(p_mm_medicao);

   /* Antes de qualquer coisa analisar a esta��o */
   w_cd_sinotico := rtrim(p_no_sinotico);

   IF    (w_cd_sinotico = '') THEN
       pc_inf_geral.pro_grava_erro_importacao('N�mero do Sin�tico em Branco ', w_cd_sinotico, w_cd_sinotico, w_param_ano, w_param_mes, '01', '00', '00', w_fl_erro);
   ELSIF (not pc_inf_geral.fun_testa_numerico(w_cd_sinotico)) THEN
       pc_inf_geral.pro_grava_erro_importacao('Formato Sin�tico inv�lido    ', w_cd_sinotico, w_cd_sinotico, w_param_ano, w_param_mes, '01', '00', '00', w_fl_erro);
   ELSE
   
      /* Verificar se esta��o est� cadastrada */
      SELECT max(id_estacao), max(cd_estacao)
      INTO   w_id_estacao, w_cd_estacao
      FROM   estacao
      WHERE  cd_synop = to_number(w_cd_sinotico);
           
      /* Verificar retorno */
      IF (w_id_estacao IS NULL) THEN
         pc_inf_geral.pro_grava_erro_importacao('Esta��o inv�lida', w_cd_sinotico, w_cd_sinotico, w_param_ano, w_param_mes, '01', '00', '00', w_fl_erro);
      ELSE
      
         /* Obter pista principal */
         SELECT max(no_pista)
         INTO   w_no_pista
         FROM   estacao_pista
         WHERE  id_estacao   = w_id_estacao
           AND  fl_principal = 'S';
           
         /* Verificar retorno */
         IF (w_no_pista IS NULL) THEN
            pc_inf_geral.pro_grava_erro_importacao('Pista Principal n�o informada', w_cd_sinotico, w_cd_sinotico, w_param_ano, w_param_mes, '01', '00', '00', w_fl_erro);
         ELSE

            /* Obter medi��es relativas aos par�metros passados */
            FOR rec1 IN Medicao_Infomet LOOP

                /* Inicializar vari�veis */
                w_fl_erro     := false;
    
                /* Atribuir valores as vari�veis de controle */
                w_aa_medicao  := rtrim(rec1.ano);
                w_mm_medicao  := rtrim(rec1.mes);
                w_dd_medicao  := rtrim(rec1.dia);
                w_hh_medicao  := rtrim(rec1.hora);
                w_mi_medicao  := rtrim(rec1.minuto);

                /*
                ****************************************************
                ** Analisar cada um dos campos para verificar      *
                ** consist�ncia. Alguns campos dependem de outros, *
                ** neste caso a consist�ncia ser� cruzada e os     *
                ** campos com erros desprezados.                   *
                ****************************************************
                */

                /* Verificar informa�oes da chave */
                IF    (w_aa_medicao  = '') THEN
                   pc_inf_geral.pro_grava_erro_importacao('Ano em Branco                ', w_aa_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                ELSIF (w_mm_medicao  = '') THEN
                   pc_inf_geral.pro_grava_erro_importacao('Mes em Branco                ', w_mm_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                ELSIF (w_dd_medicao  = '') THEN
                   pc_inf_geral.pro_grava_erro_importacao('Dia em Branco                ', w_dd_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                ELSIF (w_hh_medicao  = '') THEN
                   pc_inf_geral.pro_grava_erro_importacao('Hora em Branco               ', w_dd_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                ELSIF (w_mi_medicao  = '') THEN
                   pc_inf_geral.pro_grava_erro_importacao('Minuto em Branco             ', w_mi_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                ELSE
         
                   /* Analisar convers�o dos valores da chave para num�rico */
                   IF      (not pc_inf_geral.fun_testa_numerico(w_aa_medicao))  THEN
                      pc_inf_geral.pro_grava_erro_importacao('Formato do Ano inv�lido   ', w_aa_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF   (not pc_inf_geral.fun_testa_numerico(w_mm_medicao))  THEN
                      pc_inf_geral.pro_grava_erro_importacao('Formato do M�s inv�lido   ', w_mm_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF   (not pc_inf_geral.fun_testa_numerico(w_dd_medicao))  THEN
                      pc_inf_geral.pro_grava_erro_importacao('Formato do Dia inv�lido   ', w_dd_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF   (not pc_inf_geral.fun_testa_numerico(w_hh_medicao))  THEN
                      pc_inf_geral.pro_grava_erro_importacao('Formato da Hora inv�lida  ', w_hh_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF   (not pc_inf_geral.fun_testa_numerico(w_mi_medicao))  THEN
                      pc_inf_geral.pro_grava_erro_importacao('Formato do Minuto inv�lido', w_mi_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Analisar valores do campo chave convertidos */
                      IF    (to_number(to_char(sysdate, 'yyyy')) < to_number(w_aa_medicao)) THEN
                         pc_inf_geral.pro_grava_erro_importacao('Ano maior que atual    ', w_aa_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_aa_medicao) < 1900)                                THEN
                         pc_inf_geral.pro_grava_erro_importacao('Ano muito antigo       ', w_aa_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_mm_medicao) > 12)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('M�s inv�lido           ', w_mm_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_mm_medicao) < 01)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('M�s inv�lido           ', w_mm_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_dd_medicao) > 31)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Dia inv�lido           ', w_dd_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_dd_medicao) < 01)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Dia inv�lido           ', w_dd_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_hh_medicao) > 23)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Hora inv�lida          ', w_hh_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_hh_medicao) < 00)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Hora inv�lida          ', w_hh_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_mi_medicao) > 59)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Minuto inv�lido        ', w_mi_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSIF (to_number(w_mi_medicao) < 00)                                  THEN
                         pc_inf_geral.pro_grava_erro_importacao('Minuto inv�lido        ', w_mi_medicao , w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      ELSE
               
                         /* Definir quantidade de caracteres por vari�vel */
                         w_aa_medicao  := substr(to_char(10000 + to_number(w_aa_medicao)),2,4);
                         w_mm_medicao  := substr(to_char(100   + to_number(w_mm_medicao)),2,2);
                         w_dd_medicao  := substr(to_char(100   + to_number(w_dd_medicao)),2,2);
                         w_hh_medicao  := substr(to_char(100   + to_number(w_hh_medicao)),2,2);
                         w_mi_medicao  := substr(to_char(100   + to_number(w_mi_medicao)),2,2);
   
                         /* Definir data e hora */
                         w_dt_medicao := to_date(w_dd_medicao || w_mm_medicao || w_aa_medicao || ' 00:00', 'ddmmyyyy hh24:mi');
                         w_hr_medicao := w_hh_medicao || w_mi_medicao;
                     
                      END IF;
                  
                   END IF;
     
                END IF;
       
                /* Se n�o houve erro continua */
                IF (not w_fl_erro) THEN

                   /* Inicializar vari�veis */
                   w_fl_erro     := false;
                   w_fl_pista1   := false;
                   w_fl_pista2   := false;
                   w_fl_pista3   := false;
                   w_fl_pista4   := false;
                   
                   /* Trabalhar com vari�vel sobre a pista */
                   w_no_pista_1 := rec1.cab1_vento;
                   w_no_pista_2 := rec1.cab2_vento;
                   w_no_pista_3 := rec1.cab3_vento;
                   w_no_pista_4 := rec1.cab4_vento;
                   
                   /* Retirar caracter "/" da pista 1 */
                   w_count      := instr(w_no_pista_1, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_1 := substr(w_no_pista_1, 01, w_count - 1);
                   END IF;
                   
                   /* Retirar caracter "/" da pista 2 */
                   w_count      := instr(w_no_pista_2, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_2 := substr(w_no_pista_2, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 3 */
                   w_count      := instr(w_no_pista_3, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_3 := substr(w_no_pista_3, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 4 */
                   w_count      := instr(w_no_pista_4, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_4 := substr(w_no_pista_4, 01, w_count - 1);
                   END IF;
                   
                   /* Analisar se pistas est�o cadastradas */
                   IF ((w_no_pista_1 IS NULL) or (w_no_pista_1 = '')) THEN
                      w_no_pista_1 := w_no_pista;
                   END IF;
                   
                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_1 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_1;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista1 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 1 nao cadastrada', w_no_pista_1, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   IF (w_no_pista_2 IS NOT NULL) THEN
                   
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_2;
               
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista2 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 2 nao cadastrada', w_no_pista_2, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;
           
                   IF (w_no_pista_3 IS NOT NULL) THEN
                   
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_3;
                
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista3 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 3 nao cadastrada', w_no_pista_3, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
               
                   END IF;
           
                   IF (w_no_pista_4 IS NOT NULL) THEN
                 
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_4;
                
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista4 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 4 nao cadastrada', w_no_pista_4, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
              
                   END IF;

                   /* Analisar dire��o do vento das pistas */
                   IF ((w_cd_dir_vento IS NULL) AND ((rec1.dir1 IS NOT NULL)   OR
                                                     (rec1.dir2 IS NOT NULL)   OR
                                                     (rec1.dir3 IS NOT NULL)   OR
                                                     (rec1.dir4 IS NOT NULL))) THEN

                      pc_inf_geral.pro_grava_erro_importacao('At.Direcao Vento nao cadastrado', w_cd_dir_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_dir_vento <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Direcao Vento inv�lido ', w_cd_dir_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar dire��o da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.dir1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor da dire��o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.dir1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Dire��o Vento 1 inv�lida', rtrim(rec1.dir1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_dir_vento, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.dir1)) * 10, null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
 
                      /* Verificar dire��o da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.dir2 IS NOT NULL)) THEN
     
                         /* Analisar convers�o do valor da dire��o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.dir2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Dire��o Vento 2 inv�lida', rtrim(rec1.dir2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_dir_vento, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.dir2)) * 10, null, w_cd_erro, null, 'S');
                         END IF;

                      END IF;
              
                      /* Verificar dire��o da pista 3 */
                      IF ((w_fl_pista3) AND (rec1.dir3 IS NOT NULL)) THEN
  
                         /* Analisar convers�o do valor da dire��o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.dir3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Dire��o Vento 3 inv�lida', rtrim(rec1.dir3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_dir_vento, w_no_pista_3, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.dir3)) * 10, null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
 
                      /* Verificar dire��o da pista 4 */
                      IF ((w_fl_pista4) AND (rec1.dir4 IS NOT NULL)) THEN

                         /* Analisar convers�o do valor da dire��o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.dir4)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Dire��o Vento 4 inv�lida', rtrim(rec1.dir4), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_dir_vento, w_no_pista_4, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.dir4)) * 10, null, w_cd_erro, null, 'S');
                         END IF;

                      END IF;
 
                   END IF;
                  
                   /* Analisar velocidade do vento das pistas */
                   IF ((w_cd_veloc_vento IS NULL) AND ((rec1.vel1 IS NOT NULL)   OR
                                                       (rec1.vel2 IS NOT NULL)   OR
                                                       (rec1.vel3 IS NOT NULL)   OR
                                                       (rec1.vel4 IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Velocidade Vento nao cadastrado', w_cd_veloc_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_veloc_vento <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Velocidade Vento inv�lido ', w_cd_veloc_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE

                      /* Verificar velocidade da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.vel1 IS NOT NULL) AND (rtrim(rec1.vel1) <> '99')) THEN
   
                         /* Analisar convers�o do valor da velocidade */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.vel1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Velocidade Vento 1 inv�lida', rtrim(rec1.vel1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_veloc_vento, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.vel1)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;

                      /* Verificar velocidade da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.vel2 IS NOT NULL) AND (rtrim(rec1.vel2) <> '99')) THEN
 
                         /* Analisar convers�o do valor da velocidade */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.vel2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Velocidade Vento 2 inv�lida', rtrim(rec1.vel2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_veloc_vento, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.vel2)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
 
                      /* Verificar velocidade da pista 3 */
                      IF ((w_fl_pista3) AND (rec1.vel3 IS NOT NULL) AND (rtrim(rec1.vel3) <> '99')) THEN
 
                         /* Analisar convers�o do valor da velocidade */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.vel3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Velocidade Vento 3 inv�lida', rtrim(rec1.vel3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_veloc_vento, w_no_pista_3, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.vel3)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
 
                      /* Verificar velocidade da pista 4 */
                      IF ((w_fl_pista4) AND (rec1.vel4 IS NOT NULL) AND (rtrim(rec1.vel4) <> '99')) THEN
      
                         /* Analisar convers�o do valor da velocidade */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.vel4)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Velocidade Vento 4 inv�lida', rtrim(rec1.vel4), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_veloc_vento, w_no_pista_4, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.vel4)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
                 
                   END IF;

                   /* Analisar rajada do vento das pistas */
                   IF ((w_cd_rajada_vento IS NULL) AND ((rec1.rjd1 IS NOT NULL)   OR
                                                        (rec1.rjd2 IS NOT NULL)   OR
                                                        (rec1.rjd3 IS NOT NULL)   OR
                                                        (rec1.rjd4 IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Rajada �ao cadastrado', w_cd_rajada_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_rajada_vento <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Rajada inv�lido ', w_cd_rajada_vento, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar rajada da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.rjd1 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rjd1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Rajada Vento 1 inv�lida', rtrim(rec1.rjd1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rajada_vento, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rjd1)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
           
                      /* Verificar rajada da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.rjd2 IS NOT NULL)) THEN
    
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rjd2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Rajada Vento 2 inv�lida', rtrim(rec1.rjd2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rajada_vento, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rjd2)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
           
                      /* Verificar rajada da pista 3 */
                      IF ((w_fl_pista3) AND (rec1.rjd3 IS NOT NULL)) THEN
  
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rjd3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Rajada Vento 3 inv�lida', rtrim(rec1.rjd3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rajada_vento, w_no_pista_3, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rjd3)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
 
                      /* Verificar rajada da pista 4 */
                      IF ((w_fl_pista4) AND (rec1.rjd4 IS NOT NULL)) THEN
  
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rjd4)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Rajada Vento 4 inv�lida', rtrim(rec1.rjd4), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rajada_vento, w_no_pista_4, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rjd4)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
 
                   END IF;

                   /* Analisar visibilidade na pista principal */
                   IF ((w_cd_visibilidade IS NULL) AND (rec1.vis IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Visibilidade n�o cadastrado', w_cd_visibilidade, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_visibilidade <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Visibilidade inv�lido ', w_cd_visibilidade, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar visibilidade */
                      IF (rec1.vis IS NOT NULL) THEN
                   
                         /* Analisar convers�o do valor da visibilidade */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.vis)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Visibilidade inv�lida', rtrim(rec1.vis), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_visibilidade, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.vis)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                   /* Analisar dire��o da visibilidade m�nima na pista principal */
                   IF ((w_cd_direc_visib IS NULL) AND (rec1.dir_vis_mn IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Dire��o Vis. M�nima n�o cadastrado', w_cd_direc_visib, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_direc_visib <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Dire��o Vis. M�nima inv�lido ', w_cd_direc_visib, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar visibilidade */
                      IF (rec1.dir_vis_mn IS NOT NULL) THEN
                      
                         /* Verificar se c�digo est� cadastrado */
                         SELECT count(*) INTO w_count
                         FROM   atributo_codigo
                         WHERE  cd_atributo = w_cd_direc_visib
                           AND  vl_atributo = rec1.dir_vis_mn;
                      
                         /* Analisar retorno */
                         IF (w_count <= 0) THEN
                            pc_inf_geral.pro_grava_erro_importacao('Dire��o Visibilidade M�nima inv�lida', rec1.dir_vis_mn, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_direc_visib, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, null, rec1.dir_vis_mn, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;
                   
                   commit;
                   
                   /* Inicializar vari�veis */
                   w_fl_pista1   := false;
                   w_fl_pista2   := false;
                   w_fl_pista3   := false;
                   w_fl_pista4   := false;

                   /* Trabalhar com vari�vel sobre a pista */
                   w_no_pista_1 := rec1.pist_rvr1;
                   w_no_pista_2 := rec1.pist_rvr2;
                   w_no_pista_3 := rec1.pist_rvr3;
                   w_no_pista_4 := rec1.pist_rvr4;
                   
                   /* Retirar caracter "/" da pista 1 */
                   w_count      := instr(w_no_pista_1, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_1 := substr(w_no_pista_1, 01, w_count - 1);
                   END IF;
                   
                   /* Retirar caracter "/" da pista 2 */
                   w_count      := instr(w_no_pista_2, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_2 := substr(w_no_pista_2, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 3 */
                   w_count      := instr(w_no_pista_3, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_3 := substr(w_no_pista_3, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 4 */
                   w_count      := instr(w_no_pista_4, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_4 := substr(w_no_pista_4, 01, w_count - 1);
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_1 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_1;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista1 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 1 nao cadastrada para RVR', w_no_pista_1, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_2 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_2;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista2 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 2 nao cadastrada para RVR', w_no_pista_2, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;
                   
                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_3 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_3;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista3 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 3 nao cadastrada para RVR', w_no_pista_3, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_4 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_4;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista4 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 4 nao cadastrada para RVR', w_no_pista_4, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   /* Analisar RVR das pistas */
                   IF ((w_cd_rvr IS NULL) AND ((rec1.rvr1 IS NOT NULL)   OR
                                               (rec1.rvr2 IS NOT NULL)   OR
                                               (rec1.rvr3 IS NOT NULL)   OR
                                               (rec1.rvr4 IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.RVR n�o cadastrado', w_cd_rvr, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_rvr <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.RVR inv�lido ', w_cd_rvr, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar RVR da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.rvr1 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rvr1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('RVR 1 inv�lido', rtrim(rec1.rvr1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rvr, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rvr1)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
           
                      /* Verificar RVR da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.rvr2 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rvr2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('RVR 2 inv�lido', rtrim(rec1.rvr2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rvr, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rvr2)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;

                      /* Verificar RVR da pista 3 */
                      IF ((w_fl_pista3) AND (rec1.rvr3 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rvr3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('RVR 3 inv�lido', rtrim(rec1.rvr3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rvr, w_no_pista_3, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rvr3)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;

                      /* Verificar RVR da pista 4 */
                      IF ((w_fl_pista4) AND (rec1.rvr4 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor da rajada */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.rvr4)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('RVR 4 inv�lido', rtrim(rec1.rvr3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_rvr, w_no_pista_4, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.rvr4)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
                      
                   END IF;
               
                   /* Inicializar vari�vel de condi��o de tempo */
                   w_tb_cond_tempo := '';
                   
                   /* Analisar condi��o tempo na pista principal */
                   IF ((w_cd_cond_tempo IS NULL) AND ((rec1.cgtp1 IS NOT NULL)   OR
                                                      (rec1.cgtp2 IS NOT NULL)   OR
                                                      (rec1.cgtp3 IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Condi��o Tempo n�o cadastrado', w_cd_cond_tempo, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_cond_tempo <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Condi��o Tempo inv�lido ', w_cd_cond_tempo, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar condi��o do tempo 1 */
                      IF (rec1.cgtp1 IS NOT NULL) THEN

                         /* Testar num�rico */                      
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.cgtp1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('CGTP 1 inv�lido', rtrim(rec1.cgtp1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                      
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_cond_tempo
                              AND  vl_atributo = substr(to_char(100 + to_number(rtrim(rec1.cgtp1))),2,2);
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Condi��o Tempo 1 inv�lida', rtrim(rec1.cgtp1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               w_tb_cond_tempo := w_tb_cond_tempo || substr(to_char(100 + to_number(rtrim(rec1.cgtp1))),2,2) || ',';
                            END IF;
                            
                         END IF;
                         
                      END IF;
                      
                      /* Verificar condi��o do tempo 2 */
                      IF (rec1.cgtp2 IS NOT NULL) THEN
                      
                         /* Testar num�rico */                      
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.cgtp2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('CGTP 2 inv�lido', rtrim(rec1.cgtp2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE

                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_cond_tempo
                              AND  vl_atributo = substr(to_char(100 + to_number(rtrim(rec1.cgtp2))),2,2);
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Condi��o Tempo 2 inv�lida', rtrim(rec1.cgtp2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               w_tb_cond_tempo := w_tb_cond_tempo || substr(to_char(100 + to_number(rtrim(rec1.cgtp2))),2,2) || ',';
                            END IF;
                            
                         END IF;
                         
                      END IF;
                      
                      /* Verificar condi��o do tempo 1 */
                      IF (rec1.cgtp3 IS NOT NULL) THEN
                      
                         /* Testar num�rico */                      
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.cgtp3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('CGTP 3 inv�lido', rtrim(rec1.cgtp3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE

                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_cond_tempo
                              AND  vl_atributo = substr(to_char(100 + to_number(rtrim(rec1.cgtp3))),2,2);
                         
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Condi��o Tempo 3 inv�lida', rtrim(rec1.cgtp3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               w_tb_cond_tempo := w_tb_cond_tempo || substr(to_char(100 + to_number(rtrim(rec1.cgtp3))),2,2) || ',';
                            END IF;
                            
                         END IF;
                         
                      END IF;
                      
                      /* Retirar v�rgula final */
                      w_tb_cond_tempo := substr(w_tb_cond_tempo, 1, length(w_tb_cond_tempo) - 1);

                      /* Incluir informa��o */
                      up_inf_atualiza_medicao (w_cd_estacao, w_cd_cond_tempo, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, null, w_tb_cond_tempo, w_cd_erro, null, 'S');
                      
                   END IF;

                   /* Analisar informa��es de qtde nuvem na pista principal */
                   IF ((w_cd_qtde_nuvem IS NULL) AND ((rec1.nuv1_qnt IS NOT NULL)   OR
                                                      (rec1.nuv2_qnt IS NOT NULL)   OR
                                                      (rec1.nuv3_qnt IS NOT NULL)   OR
                                                      (rec1.nuv4_qnt IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Quantidade Nuvem n�o cadastrado', w_cd_qtde_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_qtde_nuvem <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Quantidade Nuvem inv�lido ', w_cd_qtde_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE

                      /* Verificar se quantidade nuvem 1 est� preenchida */
                      IF (rec1.nuv1_qnt IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 1 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv1_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 1 inv�lida', rtrim(rec1.nuv1_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Analisar convers�o da quantidade de nuvem 1 */
                            IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv1_qnt)))  THEN
                               pc_inf_geral.pro_grava_erro_importacao('Qtde.Nuvem 1 inv�lida', rtrim(rec1.nuv1_qnt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_qtde_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv1_alt)) * 10, null, null, to_number(rtrim(rec1.nuv1_qnt)), null, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se quantidade nuvem 2 est� preenchida */
                      IF (rec1.nuv2_qnt IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 2 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv2_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 2 inv�lida', rtrim(rec1.nuv2_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Analisar convers�o da quantidade de nuvem 2 */
                            IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv2_qnt)))  THEN
                               pc_inf_geral.pro_grava_erro_importacao('Qtde.Nuvem 2 inv�lida', rtrim(rec1.nuv2_qnt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_qtde_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv2_alt)) * 10, null, null, to_number(rtrim(rec1.nuv2_qnt)), null, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se quantidade nuvem 3 est� preenchida */
                      IF (rec1.nuv3_qnt IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 3 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv3_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 3 inv�lida', rtrim(rec1.nuv3_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Analisar convers�o da quantidade de nuvem 3 */
                            IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv3_qnt)))  THEN
                               pc_inf_geral.pro_grava_erro_importacao('Qtde.Nuvem 3 inv�lida', rtrim(rec1.nuv3_qnt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_qtde_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv3_alt)) * 10, null, null, to_number(rtrim(rec1.nuv3_qnt)), null, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;
 
                      /* Verificar se quantidade nuvem 4 est� preenchida */
                      IF (rec1.nuv4_qnt IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 4 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv4_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 4 inv�lida', rtrim(rec1.nuv4_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Analisar convers�o da quantidade de nuvem 4 */
                            IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv4_qnt)))  THEN
                               pc_inf_geral.pro_grava_erro_importacao('Qtde.Nuvem 4 inv�lida', rtrim(rec1.nuv4_qnt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_qtde_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv4_alt)) * 10, null, null, to_number(rtrim(rec1.nuv4_qnt)), null, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;
                      
                   END IF;
                   
                   /* Analisar informa��es do tipo nuvem na pista principal */
                   IF ((w_cd_tipo_nuvem IS NULL) AND ((rec1.nuv1_tip IS NOT NULL)   OR
                                                      (rec1.nuv2_tip IS NOT NULL)   OR
                                                      (rec1.nuv3_tip IS NOT NULL)   OR
                                                      (rec1.nuv4_tip IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Tipo Nuvem n�o cadastrado', w_cd_tipo_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_tipo_nuvem <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Tipo Nuvem inv�lido ', w_cd_tipo_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE

                      /* Verificar se tipo nuvem 1 est� preenchida */
                      IF (rec1.nuv1_tip IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 1 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv1_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 1 inv�lida', rtrim(rec1.nuv1_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_tipo_nuvem
                              AND  vl_atributo = rec1.nuv1_tip;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Tipo Nuvem 1 inv�lida', rtrim(rec1.nuv1_tip), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_tipo_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv1_alt)) * 10, null, null, null, rec1.nuv1_tip, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se tipo nuvem 2 est� preenchida */
                      IF (rec1.nuv2_tip IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 2 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv2_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 2 inv�lida', rtrim(rec1.nuv2_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_tipo_nuvem
                              AND  vl_atributo = rec1.nuv2_tip;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Tipo Nuvem 2 inv�lida', rtrim(rec1.nuv2_tip), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_tipo_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv2_alt)) * 10, null, null, null, rec1.nuv2_tip, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se tipo nuvem 3 est� preenchida */
                      IF (rec1.nuv3_tip IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 3 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv3_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 3 inv�lida', rtrim(rec1.nuv3_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_tipo_nuvem
                              AND  vl_atributo = rec1.nuv3_tip;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Tipo Nuvem 3 inv�lida', rtrim(rec1.nuv3_tip), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_tipo_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv3_alt)) * 10, null, null, null, rec1.nuv3_tip, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se tipo nuvem 4 est� preenchida */
                      IF (rec1.nuv4_tip IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 4 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv4_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 4 inv�lida', rtrim(rec1.nuv4_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_tipo_nuvem
                              AND  vl_atributo = rec1.nuv4_tip;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Tipo Nuvem 4 inv�lida', rtrim(rec1.nuv4_tip), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_tipo_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv4_alt)) * 10, null, null, null, rec1.nuv4_tip, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;
                      
                   END IF;
                   
                   /* Analisar informa��es do tipo nuvem na pista principal */
                   IF ((w_cd_direcao_nuvem IS NULL) AND ((rec1.nuv1_dir IS NOT NULL)   OR
                                                         (rec1.nuv2_dir IS NOT NULL)   OR
                                                         (rec1.nuv3_dir IS NOT NULL)   OR
                                                         (rec1.nuv4_dir IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Dire��o Nuvem n�o cadastrado', w_cd_direcao_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_direcao_nuvem <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Dire��o Nuvem inv�lido ', w_cd_direcao_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE

                      /* Verificar se dire��o nuvem 1 est� preenchida */
                      IF (rec1.nuv1_dir IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 1 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv1_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 1 inv�lida', rtrim(rec1.nuv1_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_direcao_nuvem
                              AND  vl_atributo = rec1.nuv1_dir;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Dire��o Nuvem 1 inv�lida', rtrim(rec1.nuv1_dir), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_direcao_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv1_alt)) * 10, null, null, null, rec1.nuv1_dir, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se dire��o nuvem 2 est� preenchida */
                      IF (rec1.nuv2_dir IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 2 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv2_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 2 inv�lida', rtrim(rec1.nuv2_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_direcao_nuvem
                              AND  vl_atributo = rec1.nuv2_dir;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Dire��o Nuvem 2 inv�lida', rtrim(rec1.nuv2_dir), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_direcao_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv2_alt)) * 10, null, null, null, rec1.nuv2_dir, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se dire��o nuvem 3 est� preenchida */
                      IF (rec1.nuv3_dir IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 3 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv3_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 3 inv�lida', rtrim(rec1.nuv3_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_direcao_nuvem
                              AND  vl_atributo = rec1.nuv3_dir;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Dire��o Nuvem 3 inv�lida', rtrim(rec1.nuv3_dir), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_direcao_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv3_alt)) * 10, null, null, null, rec1.nuv3_dir, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;

                      /* Verificar se dire��o nuvem 4 est� preenchida */
                      IF (rec1.nuv4_dir IS NOT NULL) THEN

                         /* Analisar convers�o da altitude 4 */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.nuv4_alt)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Alt.Nuvem 4 inv�lida', rtrim(rec1.nuv4_alt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                        
                            /* Verificar se c�digo est� cadastrado */
                            SELECT count(*) INTO w_count
                            FROM   atributo_codigo
                            WHERE  cd_atributo = w_cd_direcao_nuvem
                              AND  vl_atributo = rec1.nuv4_dir;
                      
                            /* Analisar retorno */
                            IF (w_count <= 0) THEN
                               pc_inf_geral.pro_grava_erro_importacao('Dire��o Nuvem 4 inv�lida', rtrim(rec1.nuv4_dir), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                            ELSE
                               up_inf_atualiza_medicao (w_cd_estacao, w_cd_direcao_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, to_number(rtrim(rec1.nuv4_alt)) * 10, null, null, null, rec1.nuv4_dir, w_cd_erro, null, 'S');
                            END IF;
                         
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 1 ');

                   /* Analisar total de nuvens na pista principal */
                   IF ((w_cd_total_nuvem IS NULL) AND (rec1.total_nuv IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Total Nuvem n�o cadastrado', w_cd_total_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_total_nuvem <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Total Nuvem inv�lido ', w_cd_total_nuvem, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar visibilidade */
                      IF (rec1.total_nuv IS NOT NULL) THEN
                   
                         /* Analisar convers�o do total de nuvem */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.total_nuv)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Total Nuvem inv�lida', rtrim(rec1.total_nuv), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_total_nuvem, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.total_nuv)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                   commit;

                   /* Inicializar vari�veis */
                   w_fl_pista1  := false;
                   w_fl_pista2  := false;
                   w_fl_pista3  := false;
                   w_fl_pista4  := false;

                   /* Trabalhar com vari�vel sobre a pista */
                   w_no_pista_1 := rec1.pist1_teto;
                   w_no_pista_2 := rec1.pist2_teto;
                   w_no_pista_3 := rec1.pist3_teto;
                   w_no_pista_4 := rec1.pist4_teto;
                   
                   /* Retirar caracter "/" da pista 1 */
                   w_count      := instr(w_no_pista_1, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_1 := substr(w_no_pista_1, 01, w_count - 1);
                   END IF;
                   
                   /* Retirar caracter "/" da pista 2 */
                   w_count      := instr(w_no_pista_2, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_2 := substr(w_no_pista_2, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 3 */
                   w_count      := instr(w_no_pista_3, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_3 := substr(w_no_pista_3, 01, w_count - 1);
                   END IF;

                   /* Retirar caracter "/" da pista 4 */
                   w_count      := instr(w_no_pista_4, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_4 := substr(w_no_pista_4, 01, w_count - 1);
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_1 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_1;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista1 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 1 nao cadastrada para Teto', w_no_pista_1, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_2 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_2;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista2 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 2 nao cadastrada para Teto', w_no_pista_2, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;
                   
                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_3 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_3;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista3 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 3 nao cadastrada para Teto', w_no_pista_3, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_4 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_4;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista4 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 4 nao cadastrada para Teto', w_no_pista_4, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;


--                   dbms_output.put_line('Passou 2 ');

                   /* Analisar teto das pistas */
                   IF ((w_cd_teto IS NULL) AND ((rec1.teto1 IS NOT NULL)   OR
                                                (rec1.teto2 IS NOT NULL)   OR
                                                (rec1.teto3 IS NOT NULL)   OR
                                                (rec1.teto4 IS NOT NULL))) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Teto n�o cadastrado', w_cd_teto, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_teto <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Teto inv�lido ', w_cd_teto, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar Teto da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.teto1 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor do teto */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.teto1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Teto 1 inv�lido', rtrim(rec1.teto1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_teto, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.teto1)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
                             
                      /* Verificar Teto da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.teto2 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor do teto */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.teto2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Teto 2 inv�lido', rtrim(rec1.teto2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_teto, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.teto2)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;

                      /* Verificar Teto da pista 3 */
                      IF ((w_fl_pista3) AND (rec1.teto3 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor do teto */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.teto3)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Teto 3 inv�lido', rtrim(rec1.teto3), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_teto, w_no_pista_3, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.teto3)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;

                      /* Verificar Teto da pista 4 */
                      IF ((w_fl_pista4) AND (rec1.teto4 IS NOT NULL)) THEN
 
                         /* Analisar convers�o do valor do teto */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.teto4)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Teto 4 inv�lido', rtrim(rec1.teto4), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_teto, w_no_pista_4, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.teto4)), null, w_cd_erro, null, 'S');
                         END IF;
                 
                      END IF;
                   
                   END IF;                   

--                   dbms_output.put_line('Passou 3 ');


                   /* Analisar QNH na pista principal */
                   IF ((w_cd_qnh IS NULL) AND (rec1.qnh IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.QNH n�o cadastrado', w_cd_qnh, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_qnh <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.QNH inv�lido ', w_cd_qnh, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar QNH */
                      IF (rec1.qnh IS NOT NULL) THEN
                   
                         /* Analisar convers�o do QNH */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.qnh))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('QNH inv�lido', rtrim(rec1.qnh), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_qnh, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.qnh)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 4 ');

                   /* Analisar QFE na pista principal */
                   IF ((w_cd_qfe IS NULL) AND (rec1.qfe IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.QFE n�o cadastrado', w_cd_qfe, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_qfe <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.QFE inv�lido ', w_cd_qfe, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar QFE */
                      IF (rec1.qfe IS NOT NULL) THEN
                   
                         /* Analisar convers�o do QFE */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.qfe))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('QFE inv�lido', rtrim(rec1.qfe), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_qfe, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.qfe)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 5 ');

                   /* Analisar QFF na pista principal */
                   IF ((w_cd_qff IS NULL) AND (rec1.qff IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.QFF n�o cadastrado', w_cd_qff, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_qff <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.QFF inv�lido ', w_cd_qff, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar QFF */
                      IF (rec1.qff IS NOT NULL) THEN
                   
                         /* Analisar convers�o do QFF */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.qff))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('QFF inv�lido', rtrim(rec1.qff), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_qff, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.qff)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 6 ');

                   /* Analisar tend�ncia press�o na pista principal */
                   IF ((w_cd_tend_pressao IS NULL) AND (rec1.a_tend IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Tend�ncia Press�o n�o cadastrado', w_cd_tend_pressao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_tend_pressao <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Tend�ncia Press�o inv�lido ', w_cd_tend_pressao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar tend�ncia press�o */
                      IF (rec1.a_tend IS NOT NULL) THEN
                      
                         /* Verificar se c�digo est� cadastrado */
                         SELECT count(*) INTO w_count
                         FROM   atributo_codigo
                         WHERE  cd_atributo = w_cd_tend_pressao
                           AND  vl_atributo = rec1.a_tend;
                      
                         /* Analisar retorno */
                         IF (w_count <= 0) THEN
                            pc_inf_geral.pro_grava_erro_importacao('Tend�ncia Press�o inv�lida', rec1.a_tend, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tend_pressao, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, null, rec1.a_tend, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 7 ');

                   /* Analisar diferen�a de press�o na pista principal */
                   IF ((w_cd_diferenca3 IS NULL) AND (rec1.dif_3hor IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Diferen�a 3 horas n�o cadastrado', w_cd_diferenca3, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_diferenca3 <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Diferen�a 3 horas inv�lido ', w_cd_diferenca3, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar diferen�a */
                      IF (rec1.dif_3hor IS NOT NULL) THEN
                   
                         /* Analisar convers�o da diferen�a de press�o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.dif_3hor))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('Diferen�a 3 horas inv�lido', rtrim(rec1.dif_3hor), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_diferenca3, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.dif_3hor)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 8 ');


                   /* Inicializar vari�veis */
                   w_fl_pista1   := false;
                   w_fl_pista2   := false;

                   /* Trabalhar com vari�vel sobre a pista */
                   w_no_pista_1  := rec1.pista1_tmp;
                   w_no_pista_2  := rec1.pista2_tmp;

                   /* Retirar caracter "/" da pista 1 */
                   w_count      := instr(w_no_pista_1, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_1 := substr(w_no_pista_1, 01, w_count - 1);
                   END IF;
                   
                   /* Retirar caracter "/" da pista 2 */
                   w_count      := instr(w_no_pista_2, '/');
                   IF (w_count > 0) THEN
                      w_no_pista_2 := substr(w_no_pista_2, 01, w_count - 1);
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF ((w_no_pista_1 IS NULL) or (w_no_pista_1 = '')) THEN
                      w_no_pista_1 := w_no_pista;
                   END IF;

                   /* Analisar se pistas est�o cadastradas */
                   IF (w_no_pista_1 IS NOT NULL) THEN
             
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_1;
                  
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista1 := true;
                      ELSE
                         w_fl_pista1  := true;
                         w_no_pista_1 := w_no_pista;
                      END IF;
                
                   END IF;

                   IF (w_no_pista_2 IS NOT NULL) THEN
                   
                      SELECT count(*) INTO w_count
                      FROM   estacao_pista 
                      WHERE  id_estacao = w_id_estacao
                        AND  no_pista   = w_no_pista_2;
               
                      /* Analisar retorno */
                      IF (w_count > 0) THEN
                         w_fl_pista2 := true;
                      ELSE
                         pc_inf_geral.pro_grava_erro_importacao('Pista 2 nao cadastrada', w_no_pista_2, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                      END IF;
                
                   END IF;
          
                   /* Analisar temperatura */
                   IF ((w_cd_tp IS NULL) AND (rec1.tp1 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura nao cadastrado', w_cd_tp, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_tp <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura inv�lido ', w_cd_tp, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar temperatura da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.tp1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor da temperatura */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.tp1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura 1 inv�lida', rtrim(rec1.tp1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tp, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.tp1)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

--                   dbms_output.put_line('Passou 9 ');

                   /* Analisar bulbo seco */
                   IF ((w_cd_bs IS NULL) AND (rec1.bs1 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura BS nao cadastrado', w_cd_bs, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_bs <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura BS inv�lido ', w_cd_bs, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE

                      /* Verificar bulbo seco da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.bs1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do bulbo seco */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.bs1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura BS 1 inv�lida', rtrim(rec1.bs1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_bs, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.bs1)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar bulbo �mido */
                   IF ((w_cd_bu IS NULL) AND (rec1.bu1 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura BU nao cadastrado', w_cd_bu, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_bu <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura BU inv�lido ', w_cd_bu, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar bulbo �mido da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.bu1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do bulbo �mido */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.bu1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura BU 1 inv�lida', rtrim(rec1.bu1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_bu, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.bu1)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar ponto de orvalho */
                   IF ((w_cd_po IS NULL) AND (rec1.po1 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura Ponto de Orvalho nao cadastrado', w_cd_po, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_po <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura Ponto de Orvalho inv�lido ', w_cd_po, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar ponto de orvalho da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.po1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do ponto de orvalho */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.po1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura PO 1 inv�lida', rtrim(rec1.po1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_po, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.po1)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar umidade relativa */
                   IF ((w_cd_ur IS NULL) AND (rec1.ur1 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Umidade Relativa nao cadastrado', w_cd_ur, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_ur <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Umidade Relativa inv�lido ', w_cd_ur, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar umidade relativa da pista 1 */
                      IF ((w_fl_pista1) AND (rec1.ur1 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor da umidade relativa */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.ur1)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura UR 1 inv�lida', rtrim(rec1.ur1), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_ur, w_no_pista_1, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.ur1)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar temperatura */
                   IF ((w_cd_tp IS NULL) AND (rec1.tp2 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura nao cadastrado', w_cd_tp, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_tp <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura inv�lido ', w_cd_tp, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar temperatura da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.tp2 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor da temperatura */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.tp2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura 2 inv�lida', rtrim(rec1.tp2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tp, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.tp2)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar bulbo seco */
                   IF ((w_cd_bs IS NULL) AND (rec1.bs2 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura BS nao cadastrado', w_cd_bs, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_bs <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura BS inv�lido ', w_cd_bs, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar bulbo seco da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.bs2 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do bulbo seco */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.bs2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura BS 2 inv�lida', rtrim(rec1.bs2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_bs, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.bs2)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar bulbo �mido */
                   IF ((w_cd_bu IS NULL) AND (rec1.bu2 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura BU nao cadastrado', w_cd_bu, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_bu <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura BU inv�lido ', w_cd_bu, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar bulbo �mido da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.bu2 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do bulbo �mido */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.bu2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura BU 1 inv�lida', rtrim(rec1.bu2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_bu, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.bu2)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar ponto de orvalho */
                   IF ((w_cd_po IS NULL) AND (rec1.po2 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Temperatura Ponto de Orvalho nao cadastrado', w_cd_po, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_po <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Temperatura Ponto de Orvalho inv�lido ', w_cd_po, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar ponto de orvalho da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.po2 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor do ponto de orvalho */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.po2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura PO 2 inv�lida', rtrim(rec1.po2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_po, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.po2)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar umidade relativa */
                   IF ((w_cd_ur IS NULL) AND (rec1.ur2 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Umidade Relativa nao cadastrado', w_cd_ur, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_ur <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Umidade Relativa inv�lido ', w_cd_ur, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
 
                      /* Verificar umidade relativa da pista 2 */
                      IF ((w_fl_pista2) AND (rec1.ur2 IS NOT NULL)) THEN
       
                         /* Analisar convers�o do valor da umidade relativa */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.ur2)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Temperatura UR 2 inv�lida', rtrim(rec1.ur2), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_ur, w_no_pista_2, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.ur2)), null, w_cd_erro, null, 'S');
                         END IF;
                  
                      END IF;
                      
                   END IF;

                   /* Analisar m�dia 12 horas */
                   IF ((w_cd_media12 IS NULL) AND (rec1.med_12hor IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.M�dia 12 Horas n�o cadastrado', w_cd_media12, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_media12 <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.M�dia 12 Horas inv�lido ', w_cd_media12, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar m�dia 12 horas */
                      IF (rec1.med_12hor IS NOT NULL) THEN
                   
                         /* Analisar convers�o da m�dia das 12 horas */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.med_12hor))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('M�dia 12 Horas inv�lido', rtrim(rec1.med_12hor), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_media12, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.med_12hor)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                   /* Analisar altitude 850 hpa */
                   IF ((w_cd_alt850 IS NULL) AND (rec1.alt_850 IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Altitude 850 hpa n�o cadastrado', w_cd_alt850, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_alt850 <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Altitude 850 hpa inv�lido ', w_cd_alt850, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar altitude 850 hpa */
                      IF (rec1.alt_850 IS NOT NULL) THEN
                   
                         /* Analisar convers�o altitude 850 hpa */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.alt_850))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('Altitude 850 hpa inv�lida', rtrim(rec1.alt_850), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_alt850, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.alt_850)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                   /* Analisar precipita��o */
                   IF ((w_cd_precipitacao IS NULL) AND (rec1.precipt IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Precipita��o n�o cadastrado', w_cd_precipitacao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_precipitacao <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Precipita��o inv�lido ', w_cd_precipitacao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar precipita��o */
                      IF (rec1.precipt IS NOT NULL) THEN
                   
                         /* Analisar convers�o precipita��o */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.precipt))) THEN
                            pc_inf_geral.pro_grava_erro_importacao('Precipita��o inv�lida', rtrim(rec1.precipt), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_precipitacao, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.precipt)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                      /* Verificar dura��o da precipita��o */
                      IF (w_cd_dur_precipit IS NOT NULL) THEN

                         /* Inicializar vari�vel */
                         w_fl_modifica := FALSE;
                         w_vl_precipt  := NVL(rec1.precipt, 0);
                         
                         /* Verificar se mudou o dia */
                         IF ((w_dia_ant <> w_dd_medicao) AND (w_dia_ant IS NOT NULL)) THEN
                            w_fl_modifica := TRUE;
                         END IF;
                             
                         /* Verificar se zerou valor */
                         IF ((w_vl_anterior <> 0) AND (w_vl_precipt = 0)) THEN
                            w_vl_precipt  := 0;
                            w_fl_modifica := TRUE;
                         END IF;
                         
                         /* Analisar mudan�a */
                         IF ((w_fl_modifica) AND (w_hr_inicio IS NOT NULL)) THEN
                            w_qt_horas    := (to_number(substr(w_hh_medicao,1,2)) * 60) + (to_number(substr(w_hh_medicao,3,2))) - (to_number(substr(w_mi_medicao,1,2)) * 60) - (to_number(substr(w_mi_medicao,3,2)));
                            w_hr_inicio   := NULL;
                            w_vl_anterior := 0;
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_dur_precipit, w_no_pista, w_dt_medicao, w_hr_inicio, null, null, null, w_qt_horas, null, w_cd_erro, null, 'S');
                         END IF;

                         /* Define hora inicial se ainda n�o encontrou */
                         IF ((w_hr_inicio IS NULL) AND (w_vl_precipt <> 0)) THEN
                            w_hr_inicio := substr((100 + to_number(w_hh_medicao)),2,2) || substr((100 + to_number(w_mi_medicao)),2,2);
                         END IF;
                               
                         /* Determinar dia anterior */
                         w_dia_ant      := w_dd_medicao;
                         w_vl_anterior  := w_vl_precipt;
                            
                      END IF;

                   END IF;

--                   dbms_output.put_line('Passou 10 ');


                   /* Verificar dura��o da precipita��o */
                   IF (w_cd_tempo IS NOT NULL) THEN

                      /* Inicializar vari�vel */
                      w_fl_modifica := FALSE;
                      w_vl_precipt  := NVL(to_number(rec1.precipt), 0);
                      w_hh_prec     := w_hh_medicao;
                      w_mi_prec     := w_mi_medicao; 
                      
                      /* Verificar se mudou o dia */
                      IF ((w_dia_ant <> w_dd_medicao) AND (w_dia_ant IS NOT NULL)) THEN
                         w_fl_modifica := TRUE;
                      END IF;
                             
                      /* Verificar se zerou valor */
                      IF ((w_vl_anterior <> 0) AND (w_vl_precipt = 0)) THEN
                         w_vl_precipt  := 0;
                         w_fl_modifica := TRUE;
                      END IF;

                      /* Analisar mudan�a */
                      IF ((w_fl_modifica) AND (w_hr_inicio IS NOT NULL)) THEN
                      
                         IF (w_dia_ant <> w_dd_medicao) THEN
                            w_qt_horas       := (24 * 60) - (to_number(substr(w_hr_inicio,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                            w_dt_medicao_aux := to_date(w_dia_ant || w_mm_medicao || w_aa_medicao || ' 00:00', 'ddmmyyyy hh24:mi');
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tempo, w_no_pista, w_dt_medicao_aux, w_hr_inicio, null, null, null, w_qt_horas, null, w_cd_erro, null, 'S');
                         ELSE
                            w_qt_horas    := (to_number(w_hh_prec) * 60) + (to_number(w_mi_prec)) - (to_number(substr(w_hr_inicio,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tempo, w_no_pista, w_dt_medicao, w_hr_inicio, null, null, null, w_qt_horas, null, w_cd_erro, null, 'S');
                         END IF;
                         
                         w_hr_inicio   := NULL;
                         w_vl_anterior := 0;
                      END IF;

                      /* Define hora inicial se ainda n�o encontrou */
                      IF ((w_hr_inicio IS NULL) AND (w_vl_precipt <> 0)) THEN
                         w_hr_inicio := substr((100 + to_number(w_hh_medicao)),2,2) || substr((100 + to_number(w_mi_medicao)),2,2);
                      END IF;
                               
                      /* Determinar dia anterior */
                      w_dia_ant      := w_dd_medicao;
                      w_vl_anterior  := w_vl_precipt;
                      
                   END IF;

                   /* Analisar tempo de precipita��o na pista principal */
                   IF ((w_cd_tempo IS NULL) AND (rec1.tempo IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Tempo Precipita��o n�o cadastrado', w_cd_tempo, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_tempo <> 'N') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo Tempo Precipita��o inv�lido    ', w_cd_tempo, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar tempo */
                      IF (rec1.tempo IS NOT NULL) THEN
                   
                         /* Analisar convers�o do valor do tempo */
                         IF (not pc_inf_geral.fun_testa_numerico(rtrim(rec1.tempo)))  THEN
                            pc_inf_geral.pro_grava_erro_importacao('Tempo Precipita��o inv�lida', rtrim(rec1.tempo), w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                         ELSE 
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_tempo, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, to_number(rtrim(rec1.tempo)), null, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                   /* Analisar observa��o na pista principal */
                   IF ((w_cd_observacao IS NULL) AND (rec1.observacao IS NOT NULL)) THEN
                      pc_inf_geral.pro_grava_erro_importacao('At.Observa��o n�o cadastrado', w_cd_observacao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSIF (w_tp_observacao <> 'S') THEN   
                      pc_inf_geral.pro_grava_erro_importacao('Tipo At.Observa��o inv�lido ', w_cd_observacao, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                   ELSE
           
                      /* Verificar observa��o */
                      IF (rec1.observacao IS NOT NULL) THEN

                         /* Atribuir valor as vari�veis auxiliares */
                         w_vl_observacao_aux1 := rtrim(rec1.observacao);
                         w_fl_erro_obs        := false;
                      
                         /* Loop para desmembrar as observa��es e testar cada uma */
                         WHILE (rtrim(w_vl_observacao_aux1) <> '') LOOP

                               /* Localizar separador de observa��o */
                               w_count := instr(w_vl_observacao_aux1, '&');
                               
                               /* Verificar se encontrou separador */
                               IF (w_count > 0) THEN
                                  w_vl_observacao_aux2 := substr(w_vl_observacao_aux1, 01, w_count - 1);
                                  w_vl_observacao_aux1 := substr(w_vl_observacao_aux1, w_count + 1, 50);
                               ELSE
                                  w_vl_observacao_aux2 := w_vl_observacao_aux1;
                                  w_vl_observacao_aux1 := '';
                               END IF;

                               /* Verificar se c�digo est� cadastrado */
                               SELECT count(*) INTO w_count
                               FROM   atributo_codigo
                               WHERE  cd_atributo = w_cd_observacao
                                 AND  vl_atributo = w_vl_observacao_aux2;
                      
                               /* Analisar retorno */
                               IF (w_count <= 0) THEN
                                  pc_inf_geral.pro_grava_erro_importacao('Observa��o inv�lida', w_vl_observacao_aux2, w_cd_sinotico, w_aa_medicao, w_mm_medicao, w_dd_medicao, w_hh_medicao, w_mi_medicao, w_fl_erro);
                                  w_fl_erro_obs := true;
                               END IF;

                         END LOOP;

                         IF (NOT w_fl_erro_obs) THEN
                            up_inf_atualiza_medicao (w_cd_estacao, w_cd_observacao, w_no_pista, w_dt_medicao, w_hr_medicao, null, null, null, null, rec1.observacao, w_cd_erro, null, 'S');
                         END IF;
                         
                      END IF;
                      
                   END IF;

                END IF;
                
                commit;
          
            END LOOP;       

            /* Inserir informa��o de importa��o realizada */
            DELETE FROM log_importa_infomet 
            WHERE nsinot = p_no_sinotico
              AND ano    = p_aa_medicao
              AND mes    = p_mm_medicao;
           
            INSERT INTO log_importa_infomet VALUES (p_no_sinotico, p_aa_medicao, p_mm_medicao, sysdate);
            commit;

            /* Analisar mudan�a de dia */
            IF ((w_fl_modifica) AND (w_hr_inicio IS NOT NULL)) THEN
               w_qt_horas    := (24 * 60) - (to_number(substr(w_hr_inicio,1,2)) * 60) - (to_number(substr(w_hr_inicio,3,2)));
               up_inf_atualiza_medicao (w_cd_estacao, w_cd_tempo, w_no_pista, w_dt_medicao, w_hr_inicio, null, null, null, w_qt_horas, null, w_cd_erro, null, 'S');
               commit;
            END IF;
            
         END IF;
         
      END IF;
      
   END IF;

END up_inf_importa_historico;
/
SHOW ERRORS;
/
GRANT EXECUTE ON up_inf_importa_historico TO bdclim_ger_01
/