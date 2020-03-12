

CREATE OR REPLACE
PROCEDURE SUCOTAP_RECEBE_FAT_ON_LINE
(V_NR_FATURA                   IN  FATURA.FAT_NR_FATURA%TYPE,
 V_FAT_DT_PAGAMENTO_AX         IN  VARCHAR2,
 V_FAT_DT_LANCAMENTO_AX        IN  VARCHAR2,
 V_FAT_VL_REC_MOEDA_AX         IN  FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE,
 V_LFA_DS_COMENTARIO           IN  LOG_FATURA.LFA_DS_COMENTARIO%TYPE,
 V_FAT_AGE_CD_AGENTE_REC_FK    IN  FATURA.FAT_AGE_CD_AGENTE_RECEBEDOR_FK%TYPE,
 V_FAT_CD_BANCO_FK             IN  VARCHAR2,
 V_FAT_CD_AGENCIA              IN  VARCHAR2,
 V_FAT_CD_CONTA_CORRENTE       IN  VARCHAR2,
 V_FAT_NRO_CHEQUE              IN  VARCHAR2,
 V_FAT_TP_PAGAMENTO            IN  FATURA.FAT_TP_PAGAMENTO%TYPE
)
IS
-- #######################################################################
-- ###     RECEBER DADOS DE FATURAS RECEBIDAS VIA ON-LINE DA TELA     ####
-- ###               DO MENU RECEBER ( APLICACAO R_ONLINE)            ####
-- ###                       DADOS DE ENTRADA:                        ####
-- ###     V_NR_FATURA                    ->   NR. DA FATURA          ####
-- ###     V_FAT_DT_PAGAMENTO             ->   DATA DE PAGAMENTO      ####
-- ###     V_FAT_DT_LANCAMENTO            ->   DATA DE LANCAMENTO     ####
-- ###     V_FAT_VL_REC_MOEDA             ->   VLR PAGO NA TELA       ####
-- ###     V_FAT_AGE_CD_AGENTE_REC_FK     ->   CD AGENTE RECEBEDOR    ####
-- ###     V_LFA_DS_COMENTARIO            ->   COMENTARIO             ####
-- ###     V_FAT_CD_BANCO_FK              ->   NRO DO BANCO           ####
-- ###     V_FAT_CD_AGENCIA               ->   NRO DA AGENCIA         ####
-- ###     V_FAT_CD_CONTA_CORRENTE        ->   NRO DA CONTA CORRENTE  ####
-- ###     V_FAT_NRO_CHEQUE               ->   NRO DO CHEQUE RECEBIDO ####
-- ###     V_FAT_TP_PAGAMENTO             ->   SE 0 OU 1              ####
---###--------------------------------------------------------------- ####
---###     VARIAVEIS  DE SAIDA:                                       ####
---###     USANDO RAISE_APPLICATION_ERROR                             ####
---###     V_MSG                          ->   MENSAGENS DE RETORNO   ####
-- #######################################################################
-- AUTOR: ELCIO MARINELLI
-- ATUALIZAÇÃO : 30/10/2001
-- ***********************************************************************
V_MSG                          LOG_FATURA.LFA_DS_COMENTARIO%TYPE;
--########################################################################
--###                  VARIAVEIS DA TABELA FATURA                      ###
--###               A SEREM UTILIZADAS NA APLICACAçãO                  ###
--########################################################################
T_FAT_NR_FATURA                FATURA.FAT_NR_FATURA%TYPE;
T_FAT_AGE_CD_AGENTE_REC_FK     FATURA.FAT_AGE_CD_AGENTE_RECEBEDOR_FK%TYPE;
T_FAT_CIA_CD_CIA_AEREA_FK      FATURA.FAT_CIA_CD_CIA_AEREA_FK%TYPE;
T_FAT_ARN_MT_AERONAVE_FK       FATURA.FAT_ARN_MT_AERONAVE_FK%TYPE;
T_FAT_DT_EMISSAO               FATURA.FAT_DT_EMISSAO%TYPE;
T_FAT_DT_VENCIMENTO            FATURA.FAT_DT_VENCIMENTO%TYPE;
T_FAT_DT_PAGAMENTO             FATURA.FAT_DT_PAGAMENTO%TYPE;
T_FAT_DT_LANCAMENTO            FATURA.FAT_DT_LANCAMENTO%TYPE;
T_FAT_VL_MOEDA_CORRENTE        FATURA.FAT_VL_MOEDA_CORRENTE%TYPE;
T_FAT_VL_MOEDA_ESTRANGEIRA     FATURA.FAT_VL_MOEDA_ESTRANGEIRA%TYPE;
T_FAT_VL_REC_MOEDA_CORRENTE    FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE;
T_FAT_VL_REC_MOEDA_ESTRANGEIRA FATURA.FAT_VL_REC_MOEDA_ESTRANGEIRA%TYPE;
T_FAT_TP_SITUACAO              FATURA.FAT_TP_SITUACAO%TYPE;
T_FAT_TP_SITUACAO_ALTERADA     FATURA.FAT_TP_SITUACAO%TYPE;
T_FAT_TP_NATUREZA_VOO          FATURA.FAT_TP_NATUREZA_VOO%TYPE;
T_FAT_VL_REC_MOEDA             FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE;
T_FAT_IN_INIBICAO              FATURA.FAT_IN_INIBICAO%TYPE;
T_FAT_TP_GRUPO                 FATURA.FAT_TP_GRUPO%TYPE;
T_FAT_DT_PERIODO_REFERENCIA    FATURA.FAT_DT_PERIODO_REFERENCIA%TYPE;
T_FAT_TP_PAGAMENTO             FATURA.FAT_TP_PAGAMENTO%TYPE;
T_FAT_DT_REPASSE               FATURA.FAT_DT_REPASSE%TYPE;
--T_FAT_CD_BANCO_FK              FATURA.FAT_CD_BANCO_FK%TYPE;
--T_FAT_CD_AGENCIA               FATURA.FAT_CD_AGENCIA%TYPE;
--T_FAT_CD_CONTA_CORRENTE        FATURA.FAT_CD_CONTA_CORRENTE%TYPE;
--T_FAT_NRO_CHEQUE               FATURA.FAT_NRO_CHEQUE%TYPE;

--########################################################################
--###              VARIAVEIS DA TABELA AGENTE RECEBEDOR                ###
--########################################################################
 T_AGE_TP_BANCO_TESOURARIA     NUMBER (2);
 V_FAT_DT_PAGAMENTO            FATURA.FAT_DT_PAGAMENTO%TYPE;
 V_FAT_DT_LANCAMENTO           FATURA.FAT_DT_LANCAMENTO%TYPE;
 T_RECEBE_FATURA               FATURA.FAT_TP_SITUACAO%TYPE := NULL;

---- VARIAVEIS CRIADAS PARA ATENDER JUROS E VARIACAO CAMBIAL (ITEM) -----
T_VALOR_RECEBIDO_JUROS         ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_VALOR_GRAVA_ACERTO_PARCIAL   ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_DIF_VAR_CAMBIAL              ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_DIF_REC_FATURADO             ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_GRAVA_JUROS                  FATURA.FAT_TP_NATUREZA_VOO%TYPE := NULL;
T_GRAVA_VARIACAO_CAMBIAL       FATURA.FAT_TP_NATUREZA_VOO%TYPE := NULL;
--########################################################################
--###        VARIAVEIS DE PROCEDIMENTO PARA TRATAMENTO DOS DADOS       ###
--########################################################################
T_FIXO                         FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VALOR_JUROS                  FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VALOR_JUROS_REAIS            FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_JUROS_PROPORCIONAIS          FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VALOR_DOLAR_PGTO             COTACAO_MOEDA.VL_COTACAO%TYPE :=0;
T_VALOR_DOLAR_EMISSAO          COTACAO_MOEDA.VL_COTACAO%TYPE :=0;
T_VALOR_DOLAR_VENCIMENTO       COTACAO_MOEDA.VL_COTACAO%TYPE :=0;
T_VL_PGTO_CORRETO_D            ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VL_PGTO_CORRETO_C_ATRASO     FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VL_PGTO_CORRETO_S_ATRASO     FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_PAGAMENTO_CORRETO            FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_ITEM_FATURA             ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_ITEM_FATURA_VCR         ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_ITEM_JUROS              ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_ITEM_PAGAMENTO_CORRETO  ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_AUX                     ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_AUX_PAGAMENTO_CORRETO   ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_AUX_JUROS               ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_SOMA_AUX_VCR                 ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VL_COTACAO_PGTO_FAT          FATURA.FAT_VL_VCR%TYPE :=0;
T_VL_COTACAO_PGTO_ITEM         ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_VL_COTACAO_VENCTO_FAT        FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_VL_COTACAO_VENCTO_ITEM       FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_FAT_VL_VCF                   FATURA.FAT_VL_VCF%TYPE :=0;
T_FAT_VL_VCR                   FATURA.FAT_VL_VCR%TYPE :=0;
T_ACP_VL_VCR                   ITEM_FATURA.ITF_VL_VCR%TYPE :=0;
T_VL_VCR_CORRETO               FATURA.FAT_VL_VCR%TYPE :=0;
T_VL_VCR_RATEIO                FATURA.FAT_VL_VCR%TYPE :=0;
V_FAT_VL_REC_MOEDA             FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
V_FAT_VL_PAGO                  FATURA.FAT_VL_REC_MOEDA_CORRENTE%TYPE :=0;
T_FAT_NR_FATURA_DV             FATURA.FAT_NR_FATURA_DV%TYPE :=0;
T_CHR_ID                       CHEQUE_RECEBIDO.CHR_ID%TYPE :=0;
--########################################################################
--###            VARIAVEIS PARA GERACAO DO LOG_FATURA                  ###
--########################################################################
V_FAT_TP_SITUACAO              FATURA.FAT_TP_SITUACAO%TYPE := NULL;
AX_PGTO_CORRETO                FATURA.FAT_VL_PAGAMENTO_CORRETO%TYPE;
AX_VL_REC_CORRENTE             ITEM_FATURA.ITF_VL_REC_MOEDA_CORRENTE%TYPE;
AX_VL_REC_ESTRANGEIRA          ITEM_FATURA.ITF_VL_REC_MOEDA_ESTRANGEIRA%TYPE;
--########################################################################
--###          ABRE CURSOR PARA SELECIONAR TODOS OS ITENS DA           ###
--###                  FATURA INFORMADA VIA TELA                       ###
--########################################################################
CURSOR C_ITFAT IS
  SELECT ITF_VL_MOEDA_CORRENTE
        ,ITF_VL_MOEDA_ESTRANGEIRA
        ,ITF_VL_REC_MOEDA_CORRENTE
        ,ITF_VL_REC_MOEDA_ESTRANGEIRA
        ,ITF_VL_VCR
        ,ITF_VL_PAGAMENTO_CORRETO
        ,ITF_CD_ADMINISTRADORA
        ,ITF_SG_UNIDADE
        ,ITF_FAT_NR_FATURA_FK
        ,ITF_CD_TARIFA
  FROM   ITEM_FATURA
  WHERE  ITF_FAT_NR_FATURA_FK = V_NR_FATURA;
  REG_ITFAT  C_ITFAT%ROWTYPE;
--*****************************************************************************
----     PROCEDURE PARA GRAVAR NA TABELA DO LOG_ACERTO_PARCIAL
--*****************************************************************************
  PROCEDURE GRAVA_LOG_ACERTO_PARCIAL IS

  BEGIN
    IF T_FAT_TP_NATUREZA_VOO = 'D' THEN
      BEGIN
         INSERT INTO LOG_ACERTO_PARCIAL
                    (LAP_ID
                    ,LAP_ITF_NR_FATURA
                    ,LAP_CD_TARIFA
                    ,LAP_CD_ADMINISTRADORA
                    ,LAP_SG_UNIDADE
                    ,LAP_DT_ENTRADA
                    ,LAP_HH_ENTRADA
                    ,LAP_VL_ACERTO_MO_CORRENTE
                    ,LAP_VL_ACERTO_MO_ESTRANGEIRA
                    ,LAP_TT_HISTORICO
                    ,LAP_CD_USUARIO
                    ,LAP_DS_COMENTARIO
                    ,LAP_DT_MANUTENCAO
                    ,LAP_TP_MANUTENCAO
                    ,LAP_NR_FATURA_ITF_DV
                    ,LAP_IN_ORIGEM_RECEBIMENTO
                    )
               VALUES
                   ( LAP_SEQ.NEXTVAL
                    ,T_FAT_NR_FATURA
                    ,REG_ITFAT.ITF_CD_TARIFA
                    ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                    ,REG_ITFAT.ITF_SG_UNIDADE
                    ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                    ,TO_CHAR(SYSDATE,'HH24MI')
                    ,(((T_PAGAMENTO_CORRETO - V_FAT_VL_PAGO) *
                        REG_ITFAT.ITF_VL_MOEDA_CORRENTE) / T_FAT_VL_MOEDA_CORRENTE)
                    ,NULL
                    ,'JUROS DE RECEBIMENTO '
                    ,USER
                    ,NULL
                    ,SYSDATE
                    ,'I'
                    ,T_FAT_NR_FATURA_DV
                    ,'R'
                   );
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR
            (-20101,'ERRO D LOG ACERTO PARCIAL -> REGISTRO JA EXISTE');
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR
            (-20101,'ERRO D OCORREU ERRO AO INSERIR NO LOG ACERTO PARCIAL');
      END;
    ELSIF T_FAT_TP_NATUREZA_VOO = 'I' THEN
      BEGIN
         INSERT INTO LOG_ACERTO_PARCIAL
                    (LAP_ID
                    ,LAP_ITF_NR_FATURA
                    ,LAP_CD_TARIFA
                    ,LAP_CD_ADMINISTRADORA
                    ,LAP_SG_UNIDADE
                    ,LAP_DT_ENTRADA
                    ,LAP_HH_ENTRADA
                    ,LAP_VL_ACERTO_MO_CORRENTE
                    ,LAP_VL_ACERTO_MO_ESTRANGEIRA
                    ,LAP_TT_HISTORICO
                    ,LAP_CD_USUARIO
                    ,LAP_DS_COMENTARIO
                    ,LAP_DT_MANUTENCAO
                    ,LAP_TP_MANUTENCAO
                    ,LAP_NR_FATURA_ITF_DV
                    ,LAP_IN_ORIGEM_RECEBIMENTO
                    )
               VALUES
                   ( LAP_SEQ.NEXTVAL
                    ,T_FAT_NR_FATURA
                    ,REG_ITFAT.ITF_CD_TARIFA
                    ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                    ,REG_ITFAT.ITF_SG_UNIDADE
                    ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                    ,TO_CHAR(SYSDATE,'HH24MI')
                    ,((T_PAGAMENTO_CORRETO - V_FAT_VL_PAGO) *
                       REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /T_FAT_VL_MOEDA_CORRENTE
                    ,(((T_PAGAMENTO_CORRETO - V_FAT_VL_PAGO) *
                        REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /
                        T_FAT_VL_MOEDA_CORRENTE)/T_VALOR_DOLAR_PGTO
                    ,'JUROS DE RECEBIMENTO '
                    ,USER
                    ,NULL
                    ,SYSDATE
                    ,'I'
                    ,T_FAT_NR_FATURA_DV
                    ,'R'
                   );
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR
            (-20101,'ERRO I LOG ACERTO PARCIAL -> REGISTRO JA EXISTE');
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR
            (-20101,'ERRO I OCORREU ERRO AO INSERIR NO LOG ACERTO PARCIAL');
      END;
    END IF;
  END GRAVA_LOG_ACERTO_PARCIAL;
-------------------------------------------------------------------------------
----     PROCEDURE PARA INCLUIR REGISTRO NA TABELA CHEQUE RECEBIDO      -------
-------------------------------------------------------------------------------
  PROCEDURE INCLUI_CHEQUE_RECEBIDO IS

  BEGIN
    SELECT CHR_SEQ.NEXTVAL
      INTO T_CHR_ID
      FROM DUAL;
    INSERT INTO CHEQUE_RECEBIDO
              ( chr_id
               ,chr_cd_banco_fk
               ,chr_cd_agencia
               ,chr_cd_conta_corrente
               ,chr_nro_cheque
               ,chr_vl_cheque
               ,chr_dt_cheque
               ,chr_dt_inclusao
               ,chr_motivo_devolucao
               ,chr_no_emitente
               ,chr_nr_cgc_cpf
               ,chr_dt_resgate
               ,chr_age_resgate
               ,chr_situacao_cheque
               ,chr_id_referencia
               ,chr_ds_comentario
              )
         VALUES
              ( T_CHR_ID
               ,V_FAT_CD_BANCO_FK
               ,V_FAT_CD_AGENCIA
               ,V_FAT_CD_CONTA_CORRENTE
               ,V_FAT_NRO_CHEQUE
               ,0
               ,V_FAT_DT_PAGAMENTO
               ,V_FAT_DT_PAGAMENTO
               ,NULL
               ,NULL
               ,NULL
               ,NULL
               ,NULL
               ,'RC'
               ,NULL
               ,NULL
              );

  EXCEPTION
     WHEN DUP_VAL_ON_INDEX THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR CHEQUE RECEBIDO -> REGISTRO JA EXISTE');
     WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR NA TABELA CHEUQE_RECEBIDO ');
  END INCLUI_CHEQUE_RECEBIDO;
-------------------------------------------------------------------------------
----     PROCEDURE PARA INCLUIR REGISTRO NA TABELA LOG_CHEQUE RECEBIDO  -------
-------------------------------------------------------------------------------
  PROCEDURE INCLUI_LOG_CHEQUE_RECEBIDO IS

  BEGIN
    INSERT INTO LOG_CHEQUE_RECEBIDO
              ( lcr_id
               ,lcr_chr_id
               ,lcr_cd_banco_fk
               ,lcr_cd_agencia
               ,lcr_cd_conta_corrente
               ,lcr_nro_cheque
               ,lcr_vl_cheque
               ,lcr_dt_cheque
               ,lcr_dt_inclusao
               ,lcr_motivo_devolucao
               ,lcr_no_emitente
               ,lcr_nr_cgc_cpf
               ,lcr_dt_resgate
               ,lcr_age_resgate
               ,lcr_situacao_cheque
               ,lcr_id_referencia
               ,lcr_ds_comentario
               ,lcr_cd_usuario
               ,lcr_dt_manutencao
               ,lcr_tp_manutencao
               )
         VALUES
              ( LCR_SEQ.NEXTVAL
               ,T_CHR_ID
               ,V_FAT_CD_BANCO_FK
               ,V_FAT_CD_AGENCIA
               ,V_FAT_CD_CONTA_CORRENTE
               ,V_FAT_NRO_CHEQUE
               ,0
               ,V_FAT_DT_PAGAMENTO
               ,V_FAT_DT_PAGAMENTO
               ,NULL
               ,NULL
               ,NULL
               ,NULL
               ,NULL
               ,'RC'
               ,NULL
               ,NULL
               ,USER
               ,SYSDATE
               ,'I'
              );
  EXCEPTION
     WHEN DUP_VAL_ON_INDEX THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR LOG_CHEQUE RECEBIDO -> REGISTRO JA EXISTE');
     WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR NA TABELA LOG_CHEQUE_RECEBIDO ');
  END INCLUI_LOG_CHEQUE_RECEBIDO;

-------------------------------------------------------------------------------
----  PROCEDURE PARA INCLUIR REGISTRO NA TABELA FATURA_CHEQUE RECEBIDO  -------
-------------------------------------------------------------------------------
  PROCEDURE INCLUI_FATURA_CHEQUE_RECEBIDO IS
  BEGIN
    INSERT INTO FATURA_CHEQUE_RECEBIDO
              ( FCH_CHR_ID_FK
               ,FCH_FAT_NR_FATURA_FK
               )
         VALUES
             ( T_CHR_ID
              ,V_NR_FATURA--T_FAT_NR_FATURA
              );
  EXCEPTION
     WHEN DUP_VAL_ON_INDEX THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR FATURA_CHEQUE RECEBIDO -> REGISTRO JA EXISTE');
     WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR
        (-20101,'ERRO AO INCLUIR NA TABELA FATURA_CHEQUE_RECEBIDO '||T_CHR_ID||'-'||V_NR_FATURA);
  END INCLUI_FATURA_CHEQUE_RECEBIDO;
-------------------------------------------------------------------------------

  BEGIN
     V_FAT_TP_SITUACAO    :=NULL;
     V_FAT_DT_PAGAMENTO   := TO_DATE(V_FAT_DT_PAGAMENTO_AX,'DDMMYYYY');
     V_FAT_DT_LANCAMENTO  := TO_DATE(V_FAT_DT_LANCAMENTO_AX,'DDMMYYYY');
     V_FAT_VL_REC_MOEDA   := V_FAT_VL_REC_MOEDA_AX/100;
     V_FAT_VL_PAGO        := V_FAT_VL_REC_MOEDA_AX/100;
-------------------------------------------------------------------------------
----     ROTINA PARA INCLUIR REGISTRO NAS TABELAS CHEQUE_RECEBIDO  E    -------
----                    NA FATURA_CHEQUE_RECEBIDO                      --------
-------------------------------------------------------------------------------
    BEGIN
    IF V_FAT_TP_PAGAMENTO = 1 THEN
      SELECT CHR_ID
        INTO T_CHR_ID
        FROM CHEQUE_RECEBIDO
       WHERE CHR_CD_BANCO_FK       = V_FAT_CD_BANCO_FK        AND
             CHR_CD_AGENCIA        = V_FAT_CD_AGENCIA         AND
             CHR_CD_CONTA_CORRENTE = V_FAT_CD_CONTA_CORRENTE  AND
             CHR_NRO_CHEQUE        = V_FAT_NRO_CHEQUE;

         INCLUI_FATURA_CHEQUE_RECEBIDO;
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INCLUI_CHEQUE_RECEBIDO;
            INCLUI_lOG_CHEQUE_RECEBIDO;
            INCLUI_FATURA_CHEQUE_RECEBIDO;
    END;
--########################################################################
--###            RECUPERA DADOS DA FATURA SELECIONADA PARA ATRIBUIR    ###
--###                 VALORES AS VARIAVEIS DECLARADAS                  ###
--########################################################################
    BEGIN
      SELECT FAT_NR_FATURA
            ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK
            ,FAT_CIA_CD_CIA_AEREA_FK
            ,FAT_ARN_MT_AERONAVE_FK
            ,FAT_DT_EMISSAO
            ,FAT_DT_VENCIMENTO
            ,FAT_DT_PAGAMENTO
            ,FAT_DT_LANCAMENTO
            ,FAT_VL_MOEDA_CORRENTE
            ,FAT_VL_MOEDA_ESTRANGEIRA
            ,FAT_VL_REC_MOEDA_CORRENTE
            ,FAT_VL_REC_MOEDA_ESTRANGEIRA
            ,FAT_VL_VCF
            ,FAT_TP_SITUACAO
            ,FAT_TP_NATUREZA_VOO
            ,FAT_IN_INIBICAO
            ,FAT_TP_GRUPO
            ,FAT_DT_PERIODO_REFERENCIA
            ,FAT_NR_FATURA_DV
            ,FAT_TP_PAGAMENTO
            ,FAT_DT_REPASSE
       INTO
             T_FAT_NR_FATURA
            ,T_FAT_AGE_CD_AGENTE_REC_FK
            ,T_FAT_CIA_CD_CIA_AEREA_FK
            ,T_FAT_ARN_MT_AERONAVE_FK
            ,T_FAT_DT_EMISSAO
            ,T_FAT_DT_VENCIMENTO
            ,T_FAT_DT_PAGAMENTO
            ,T_FAT_DT_LANCAMENTO
            ,T_FAT_VL_MOEDA_CORRENTE
            ,T_FAT_VL_MOEDA_ESTRANGEIRA
            ,T_FAT_VL_REC_MOEDA_CORRENTE
            ,T_FAT_VL_REC_MOEDA_ESTRANGEIRA
            ,T_FAT_VL_VCF
            ,T_FAT_TP_SITUACAO
            ,T_FAT_TP_NATUREZA_VOO
            ,T_FAT_IN_INIBICAO
            ,T_FAT_TP_GRUPO
            ,T_FAT_DT_PERIODO_REFERENCIA
            ,T_FAT_NR_FATURA_DV
            ,T_FAT_TP_PAGAMENTO
            ,T_FAT_DT_REPASSE

       FROM  FATURA
       WHERE FAT_NR_FATURA = V_NR_FATURA;
    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
           RAISE_APPLICATION_ERROR
         (-20101,'ERRO - JÁ  EXISTE MAIS DE UMA FATURA COM ESTE NUMERO');
      WHEN NO_DATA_FOUND THEN
           RAISE_APPLICATION_ERROR
         (-20101,'NUMERO DE FATURA NAO ENCONTRADO');
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR
         (-20101,'ERRO AO CONSULTAR O NRO. DA FATURA');
    END;
--########################################################################
--###     ROTINA PARA VALIDAR O AGENTE RECEBEDOR INFORMADO VIA TELA    ###
--########################################################################
    BEGIN
      SELECT AGE_TP_BANCO_TESOURARIA
        INTO T_AGE_TP_BANCO_TESOURARIA
        FROM AGENTE_RECEBEDOR
       WHERE AGE_CD_AGENTE_RECEBEDOR = V_FAT_AGE_CD_AGENTE_REC_FK;
    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
           RAISE_APPLICATION_ERROR
         (-20101,'INCONSISTêNCIA DE DADOS NA TABELA AGENTE RECEBEDOR');
      WHEN NO_DATA_FOUND THEN
           RAISE_APPLICATION_ERROR
         (-20101,'AGENTE RECEBEDOR INFORMADO NAO EXISTE');
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR
         (-20101,'ERRO AO CONSULTAR TABELA AGENTE RECEBEDOR');
    END;
-------------   VERIFICA SE DATA LANCAMENTO  >=  DATA PAGAMENTO  ---------
  IF TO_CHAR(V_FAT_DT_LANCAMENTO,'YYYYMMDD') < TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') THEN
     RAISE_APPLICATION_ERROR
     (-20101,'DATA LANçAMENTO DEVE SER MAIOR OU IGUAL A DATA PAGAMENTO');
  ELSE
    IF T_FAT_TP_SITUACAO  NOT IN ('FP','AN','CD','CR','PJ') THEN
       RAISE_APPLICATION_ERROR
       (-20101,'ESTE TIPO DE FATURA O NÃO É TRATADO NO RECEBIMENTO');
-----------------  VERIFICA SE A DATA PAGAMENTO é NULA, ------------------
---------------- E SE DATA PAGAMENTO >= DATA DE EMISSAO   ----------------
    ELSE
      IF T_FAT_DT_PAGAMENTO IS NULL AND
         TO_CHAR(T_FAT_DT_EMISSAO,'YYYYMMDD') <= TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') THEN
----------  VERIFICA SE DATA LANçAMENTO ( FATURA ) ESTá NULA  E ----------
-------       SE A DATA LANçAMENTO (TELA) >= DATA DE PAGAMENTO   ---------
        IF ( T_FAT_DT_LANCAMENTO IS NULL AND
             TO_CHAR(V_FAT_DT_LANCAMENTO,'YYYYMMDD') >=
             TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD')) OR
           ( T_FAT_TP_SITUACAO IN ('AN', 'CD', 'CR') AND
             TO_CHAR(V_FAT_DT_LANCAMENTO,'YYYYMMDD') >=
             TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD')) THEN
-----------      O VALOR PAGO (TELA) >=  VALOR FATURADO  -----------------
          IF T_FAT_VL_REC_MOEDA IS NULL THEN
            IF T_FAT_TP_NATUREZA_VOO = 'I' THEN
              BEGIN
                SELECT VL_COTACAO
                  INTO T_VALOR_DOLAR_PGTO
                  FROM COTACAO_MOEDA
                 WHERE DT_COTACAO IN
                     ( SELECT MAX(DT_COTACAO)
                         FROM COTACAO_MOEDA
                        WHERE DT_COTACAO  < V_FAT_DT_PAGAMENTO AND
                              MOE_CD_MOEDA = SUCOTAP_MOEDA)    AND
                              MOE_CD_MOEDA = SUCOTAP_MOEDA;
              EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'INCONSISTÊNCIA NA COTAÇÃO DO VALOR DO DOLAR');
                WHEN NO_DATA_FOUND THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'NAO EXISTE COTOÇÃO DO DOLAR NESTA DATA DE PAGAMENTO');
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR
                   (-20101,'ERRO AO CONSULTAR COTAçãO PARA VALOR_DOLAR_PAGO');
              END;
              BEGIN
                SELECT VL_COTACAO
                  INTO T_VALOR_DOLAR_EMISSAO
                  FROM COTACAO_MOEDA
                 WHERE DT_COTACAO IN
                     ( SELECT MAX(DT_COTACAO)
                         FROM COTACAO_MOEDA
                        WHERE DT_COTACAO  < T_FAT_DT_EMISSAO AND
                              MOE_CD_MOEDA = SUCOTAP_MOEDA)  AND
                              MOE_CD_MOEDA = SUCOTAP_MOEDA;
              EXCEPTION
                WHEN TOO_MANY_ROWS THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'INCONSISTêNCIA DE DADOS NO VALOR DO DOLAR');
                WHEN NO_DATA_FOUND THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'NAO EXISTE COTAçãO DO DOLAR PARA A DATA DE EMISSÃO');
                WHEN OTHERS THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO AO CONSULTAR VALOR DOLAR (VALOR_DOLAR_EMISSÃO)');
              END;
              IF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') >
                 TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD')  THEN
                BEGIN
                  SELECT VL_COTACAO
                    INTO T_VALOR_DOLAR_VENCIMENTO
                    FROM COTACAO_MOEDA
                   WHERE DT_COTACAO IN
                       ( SELECT MAX(DT_COTACAO)
                           FROM COTACAO_MOEDA
                          WHERE DT_COTACAO  < T_FAT_DT_VENCIMENTO AND
                                MOE_CD_MOEDA= SUCOTAP_MOEDA)      AND
                                MOE_CD_MOEDA= SUCOTAP_MOEDA;
                EXCEPTION
                  WHEN TOO_MANY_ROWS THEN
                      RAISE_APPLICATION_ERROR
                     (-20101,'INCONSISTêNCIA DE DADOS NO VALOR DOLAR (VENCIMENTO)');
                  WHEN NO_DATA_FOUND THEN
                       RAISE_APPLICATION_ERROR
                     (-20101,'NAO EXISTE COTAçãO DOLAR PARA DATA DE VENCIMENTO)');
                  WHEN OTHERS THEN
                       RAISE_APPLICATION_ERROR
                     (-20101,'ERRO AO CONSULTAR VALOR DOLAR (VENCIMENTO)');
                END;
              END IF;
            END IF;
   OPEN C_ITFAT;
   LOOP
   FETCH  C_ITFAT INTO REG_ITFAT;
----------------- ROTINA PARA ALTERAR A SITUACAO DA FATURA   -------------
    IF T_FAT_TP_SITUACAO = 'FP' THEN
       T_FAT_TP_SITUACAO_ALTERADA := 'RC';
    ELSIF T_FAT_TP_SITUACAO = 'AN' THEN
       T_FAT_TP_SITUACAO_ALTERADA := 'RA';
    ELSIF T_FAT_TP_SITUACAO = 'CD' THEN
       T_FAT_TP_SITUACAO_ALTERADA := 'RD';
    ELSIF T_FAT_TP_SITUACAO = 'CR' THEN
       T_FAT_TP_SITUACAO_ALTERADA := 'RR';
    END IF;
--- ROTINA CRIADA EM 28/12/99 P/ PERMITIR RECEBIMENTO DE FATURA COM VALOR ZERO -
    IF T_FAT_VL_MOEDA_CORRENTE = 0  AND  V_FAT_VL_PAGO = 0  THEN
      IF C_ITFAT%ROWCOUNT = 1 THEN
        BEGIN
          UPDATE FATURA
             SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                ,FAT_VL_PAGAMENTO_CORRETO       =  T_FAT_VL_MOEDA_CORRENTE
                ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
           WHERE FAT_NR_FATURA =  T_FAT_NR_FATURA;
             IF SQL%ROWCOUNT=0 THEN
                RAISE_APPLICATION_ERROR
               (-20101,'ERRO1 AO ATUALIZAR A FATURA TIPO ='||T_FAT_TP_SITUACAO);
             END IF;
             V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
             AX_PGTO_CORRETO       := T_FAT_VL_MOEDA_CORRENTE;
             AX_VL_REC_CORRENTE    := T_FAT_VL_MOEDA_CORRENTE;
             AX_VL_REC_ESTRANGEIRA := 0;
        END;
---------------- ROTINA PARA GRAVAR OS ITENS DA FATURA  -----------------------
        BEGIN
          UPDATE ITEM_FATURA
             SET ITF_VL_REC_MOEDA_CORRENTE = 0
                ,ITF_VL_PAGAMENTO_CORRETO  = 0
           WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA AND
                 ITF_FAT_NR_FATURA_FK  = V_NR_FATURA;
          IF SQL%ROWCOUNT=0 THEN
             RAISE_APPLICATION_ERROR
           (-20101,'ERRO1 AO ATUALIZAR O ITEM FATURA');
          END IF;
        END;
      END IF;
         V_MSG:='BAIXA EFETUADA COM SUCESSO';
         EXIT;
    END IF;
----------------- ROTINA PARA GRAVAR OS ITENS DA FATURA  -----------------------

--------------------------------------------------------------------------
---##                  TRATAMENTO PARA FATURA                        ##---
--------------------------------------------------------------------------
---##    NATUREZA VOO = 'D'            PAGAMENTO SEM ATRASO          ##---
--------------------------------------------------------------------------
    IF T_FAT_TP_NATUREZA_VOO = 'D' THEN
      IF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') <= TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') THEN
-----------  VALIDA SE VALOR PAGO (TELA) >= VALOR FATURADO (FATURA)  ------
        IF V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE OR
           T_FAT_IN_INIBICAO = 'J'THEN
           V_FAT_VL_REC_MOEDA := T_FAT_VL_MOEDA_CORRENTE;
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
              UPDATE FATURA
                 SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                    ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                    ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                    ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                    ,FAT_VL_PAGAMENTO_CORRETO       =  T_FAT_VL_MOEDA_CORRENTE
                    ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                    ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                    ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
               WHERE FAT_NR_FATURA =  T_FAT_NR_FATURA;
               IF SQL%ROWCOUNT=0 THEN
                  RAISE_APPLICATION_ERROR
                 (-20101,'ERRO1 AO ATUALIZAR A FATURA TIPO ='||T_FAT_TP_SITUACAO);
               END IF;
               V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
               AX_PGTO_CORRETO       := T_FAT_VL_MOEDA_CORRENTE;
               AX_VL_REC_CORRENTE    := T_FAT_VL_MOEDA_CORRENTE;
               AX_VL_REC_ESTRANGEIRA := 0;
            END;
          END IF;
          BEGIN
------- ROTINA PARA GRAVAR O VALOR RECEBIDO E CORRETO NOS ITENS DA FATURA ---------
            UPDATE ITEM_FATURA
               SET ITF_VL_REC_MOEDA_CORRENTE = REG_ITFAT.ITF_VL_MOEDA_CORRENTE
                  ,ITF_VL_PAGAMENTO_CORRETO  = REG_ITFAT.ITF_VL_MOEDA_CORRENTE
             WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                   ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                   ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                   ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                   ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
               (-20101,'ERRO1 AO ATUALIZAR O ITEM FATURA');
              END IF;
          END;
------- ROTINA PARA INCLUIR VALOR RECEBIDO  PAGO A MAIOR NA TABELA ---------------
          IF V_FAT_VL_PAGO > T_FAT_VL_MOEDA_CORRENTE THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT
                  INTO PAGAMENTO_A_MAIOR
                     ( PAG_ID
                      ,PAG_FAT_NR_FATURA_FK
                      ,PAG_DT_EMISSAO
                      ,PAG_DT_LANCAMENTO
                      ,PAG_DT_PAGAMENTO
                      ,PAG_DT_DEVOLUCAO
                      ,PAG_VL_CORRETO
                      ,PAG_VL_CREDITO
                      ,PAG_VL_PAGO
                      ,PAG_TT_COMENTARIO
                     )
                VALUES
                     ( PAG_SEQ.NEXTVAL
                      ,T_FAT_NR_FATURA
                      ,T_FAT_DT_EMISSAO
                      ,V_FAT_DT_LANCAMENTO
                      ,V_FAT_DT_PAGAMENTO
                      ,NULL
                      ,T_FAT_VL_MOEDA_CORRENTE
                      ,V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE
                      ,V_FAT_VL_PAGO
                      ,'FAT.SEM ATRASO - RECEB.A MAIOR - VIA ON-LINE'
                     );
              EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO1 AO INSERIR NA TABELA PAGAMENTO A MAIOR');
              END;
            END IF;
          END IF;
                 V_MSG:='BAIXA EFETUADA COM SUCESSO';
--------- VALIDA SE VALOR PAGO (TELA) < VALOR FATURADO ( FATURA ) -------
        ELSIF V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE THEN
              RAISE_APPLICATION_ERROR
           (-20101,'ERRO1 BAIXA NãO EFETUADA, VL. PAGO MENOR QUE FATURADO');
        END IF;
--------------------------------------------------------------------------
---##                  TRATAMENTO PARA FATURA                        ##---
--------------------------------------------------------------------------
---##    NATUREZA VOO = 'D'            PAGAMENTO COM ATRASO          ##---
--------------------------------------------------------------------------
      ELSIF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') >
            TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') THEN
        IF C_ITFAT%ROWCOUNT = 1 THEN
            T_VALOR_JUROS := ( V_FAT_DT_PAGAMENTO - T_FAT_DT_VENCIMENTO ) *
                               T_FAT_VL_MOEDA_CORRENTE / 3000;
          IF T_FAT_IN_INIBICAO = 'J'  THEN
             T_VALOR_JUROS := 0;
          END IF;
        END IF;
        T_VL_PGTO_CORRETO_D := T_FAT_VL_MOEDA_CORRENTE + T_VALOR_JUROS;
        T_FIXO := T_FAT_VL_MOEDA_CORRENTE * 0.01;
---- ROTINA PARA CALCULAR O VALOR A SER GRAVADO NA COLUNA JUROS DO ITEM ---
-----QDO VALOR PAGO E MAIOR QUE VL.FATURADO E MENOR QUE O VALOR CORRETO ---
----ELCIO ( RIO 09/02/99 )  -----------------------------------------------
        IF V_FAT_VL_PAGO >= T_VL_PGTO_CORRETO_D THEN
           V_FAT_VL_REC_MOEDA     := T_VL_PGTO_CORRETO_D;
           T_VALOR_RECEBIDO_JUROS := T_VALOR_JUROS;
           T_GRAVA_JUROS          := 'S';
        ELSIF V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_D THEN
          IF V_FAT_VL_PAGO > T_FAT_VL_MOEDA_CORRENTE THEN
             T_DIF_REC_FATURADO := V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE;
            IF T_DIF_REC_FATURADO >= T_VALOR_JUROS THEN
               T_VALOR_RECEBIDO_JUROS := T_VALOR_JUROS;
               T_GRAVA_JUROS  := 'S';
            ELSIF T_DIF_REC_FATURADO < T_VALOR_JUROS THEN
                  T_VALOR_RECEBIDO_JUROS :=  T_DIF_REC_FATURADO;
                  T_GRAVA_JUROS          := 'S';
            END IF;
          ELSIF V_FAT_VL_PAGO = T_FAT_VL_MOEDA_CORRENTE THEN
                T_VALOR_RECEBIDO_JUROS := 0;
                T_GRAVA_JUROS  := 'N';
          END IF;
        END IF;
        IF -T_FIXO <= ( V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D ) OR
                      ( V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D ) <= T_FIXO  THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
             UPDATE FATURA
                SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                   ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                   ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                   ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                   ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_D
                   ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                   ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                   ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                   ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
              WHERE FAT_NR_FATURA = T_FAT_NR_FATURA;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO2 AO ATUALIZAR A FATURA#');
              END IF;
              V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
              AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_D;
              AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
              AX_VL_REC_ESTRANGEIRA := 0;
            END;
          END IF;
          BEGIN
------- ROTINA P/ VERIFICAR  VL.RECEBIDO É DIFERENTE DA SOMATORIA DOS ITENS RECEBIDOS-----
---------------------- GRAVA DIFERENÇA NO ÚLTIMO ITEM DA FATURA---------------------------
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                 BEGIN
                   UPDATE ITEM_FATURA
                      SET ITF_VL_REC_MOEDA_CORRENTE =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  V_FAT_VL_REC_MOEDA )
                          / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX
                    WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                          ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                          ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                          ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                          ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO2 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                 END;
              END IF;
------- ROTINA P/ VERIFICAR  VL.CORRETO É DIFERENTE DA SOMATORIA DOS ITENS CORRETOS-------
---------------------- GRAVA DIFERENÇA NO ÚLTIMO ITEM DA FATURA---------------------------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_D THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                         T_VL_PGTO_CORRETO_D - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                 UPDATE ITEM_FATURA
                    SET ITF_VL_PAGAMENTO_CORRETO =
                      (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VL_PGTO_CORRETO_D )
                       / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_PAGAMENTO_CORRETO
                  WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                        ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                        ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                        ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                        ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                  IF SQL%ROWCOUNT=0 THEN
                     RAISE_APPLICATION_ERROR
                     (-20101,'ERRO2 AO ATUALIZAR O ITEM FATURA');
                  END IF;
                END;
              END IF;
------- ROTINA P/ VERIFICAR  VL.JUROS  É DIFERENTE DA SOMATORIA DOS JUROS DOS ITENS   ----
---------------------- GRAVA DIFERENÇA NO ÚLTIMO ITEM DA FATURA---------------------------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS  := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                            (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                             / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_JUROS
                      WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                            ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                            ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                            ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                            ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                        RAISE_APPLICATION_ERROR
                         (-20101,'ERRO2 AO ATUALIZAR OS JUROS DO ITEM FATURA');
                    END IF;
                  END;
                END IF;
              END IF;
                EXIT;
            END IF;
---------- ROTINA DE GRAVAÇÃO DOS VALORES NAS RESPECTIVAS COLUNAS DO ITEM FATURA -------
            UPDATE ITEM_FATURA
              SET ITF_VL_REC_MOEDA_CORRENTE =
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                      / T_FAT_VL_MOEDA_CORRENTE )
                 ,ITF_VL_PAGAMENTO_CORRETO =
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D )
                      / T_FAT_VL_MOEDA_CORRENTE )
                 ,ITF_VL_JURR =
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                      / T_FAT_VL_MOEDA_CORRENTE )
            WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                  ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                  ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                  ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                  ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
            IF SQL%ROWCOUNT=0 THEN
               RAISE_APPLICATION_ERROR
               (-20101,'ERRO3 AO ATUALIZAR O ITEM FATURA');
            END IF;
------------ROTINA QUE ACUMULA NA VARIAVEL  CADA ITEM DA FATURA LIDO --------------------------------
            IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
               T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                     /T_FAT_VL_MOEDA_CORRENTE);
               T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VL_PGTO_CORRETO_D
                     /T_FAT_VL_MOEDA_CORRENTE);
               T_SOMA_ITEM_JUROS:= T_SOMA_ITEM_JUROS +
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS
                     /T_FAT_VL_MOEDA_CORRENTE);
            ELSE
              T_SOMA_ITEM_FATURA:= 0;
              T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
              T_SOMA_ITEM_JUROS := 0;
            END IF;
          END;
-------INSERIR PAGAMENTO_A_MAIOR QUANDO VALOR PAGO > VALOR CORRETO -------
          IF ( V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_D )  THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT INTO PAGAMENTO_A_MAIOR
                          ( PAG_ID
                           ,PAG_FAT_NR_FATURA_FK
                           ,PAG_DT_EMISSAO
                           ,PAG_DT_LANCAMENTO
                           ,PAG_DT_PAGAMENTO
                           ,PAG_DT_DEVOLUCAO
                           ,PAG_VL_CORRETO
                           ,PAG_VL_CREDITO
                           ,PAG_VL_PAGO
                           ,PAG_TT_COMENTARIO
                           )
                      VALUES
                         ( PAG_SEQ.NEXTVAL
                          ,T_FAT_NR_FATURA
                          ,T_FAT_DT_EMISSAO
                          ,V_FAT_DT_LANCAMENTO
                          ,V_FAT_DT_PAGAMENTO
                          ,NULL
                          ,T_VL_PGTO_CORRETO_D
                          ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D
                          ,V_FAT_VL_PAGO
                          ,'FAT.COM ATRASO-RECEB.A MAIOR VIA ON-LINE'
                         );
              EXCEPTION
                 WHEN DUP_VAL_ON_INDEX THEN
                      RAISE_APPLICATION_ERROR
                 (-20101,'ERRO2 AO INSERIR NA TABELA PAGAMENTO A MAIOR');
              END;
            END IF;
                    V_MSG:='BAIXA EFETUADA COM SUCESSO';
----- ROTINA P/ INSERIR NA TAB. ACERTO PARCIAL QDO VL.PAGO < CORRETO -----
          ELSIF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_D ) AND
                ( V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE )  THEN
            IF T_FAT_TP_SITUACAO = 'FP' THEN
              IF (( T_FIXO > 100 ) AND
                 (( T_VL_PGTO_CORRETO_D - V_FAT_VL_PAGO ) > 100 )) OR
                 (( T_FIXO < 100 )) THEN
                IF C_ITFAT%NOTFOUND THEN
                   NULL;
                ELSE
                  BEGIN
                    INSERT
                     INTO ACERTO_PARCIAL
                         (ACP_ITF_NR_FATURA_FK
                         ,ACP_ITF_CD_TARIFA_FK
                         ,ACP_ITF_CD_ADMINISTRADORA_FK
                         ,ACP_ITF_SG_UNIDADE_FK
                         ,ACP_DT_ENTRADA
                         ,ACP_HH_ENTRADA
                         ,ACP_VL_ACERTO_MO_CORRENTE
                         ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                         ,ACP_TT_HISTORICO
                         ,ACP_DT_FIM_CORRECAO
                         ,ACP_DT_INICIO_CORRECAO
                         ,ACP_TAR_CD_TARIFA_FK
                         ,ACP_NR_FATURA_ITF_DV
                         ,ACP_IN_ORIGEM_RECEBIMENTO
                         )
                    VALUES
                        (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                        ,REG_ITFAT.ITF_CD_TARIFA
                        ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                        ,REG_ITFAT.ITF_SG_UNIDADE
---                     ,TO_DATE(TO_CHAR(SYSDATE,'DD/MM/YYYY'),'DD/MM/YYYY')
                        ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                        ,TO_CHAR(SYSDATE,'HH24MI')
                        ,(((T_VL_PGTO_CORRETO_D - V_FAT_VL_PAGO) *
                            REG_ITFAT.ITF_VL_MOEDA_CORRENTE) / T_FAT_VL_MOEDA_CORRENTE)
                        ,NULL
                        ,'JUR VENC.'||TO_CHAR(T_FAT_DT_VENCIMENTO,'DD/MM/YYYY')
                                    ||'PAGTO.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                        ,NULL
                        ,NULL
                        ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                       ,'12','12'
                                                       ,'14','15'
                                                       ,'15','15'
                                                       ,'20','22'
                                                       ,'22','22'
                                                       ,'24','25'
                                                       ,'25','25'
                                                       ,'30','32'
                                                       ,'32','32'
                                                       ,'34','35'
                                                       ,'35','35'
                                                       ,'40','42'
                                                       ,'42','42'
                                                       ,'44','45'
                                                       ,'45','45'
                                                       ,'50','52'
                                                       ,'52','52'
                                                       ,'54','55'
                                                       ,'55','55')
                         ,T_FAT_NR_FATURA_DV
                         ,'R');
                  EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                         RAISE_APPLICATION_ERROR
                       (-20101,'ERRO1 ACERTO PARCIAL -> REGISTRO JA EXISTE');
                    WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR
                       (-20101,'ERRO2 OCORREU ERRO AO INSERIR NO ACERTO PARCIAL');
                  END;
                  T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_D;
                  GRAVA_LOG_ACERTO_PARCIAL;
                END IF;
              END IF;
            END IF;
               V_MSG:='BAIXA EFETUADA COM SUCESSO';
          ELSIF (V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_D) AND
                (V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE ) THEN
                RAISE_APPLICATION_ERROR
          (-20101,'ERRO2,BAIXA NãO EFETUADA,VL. PAGO MENOR QUE O A PAGAR/FATURADO');
          END IF;
        ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D) < -T_FIXO THEN
------------------ VERIFICA SE VALOR PAGO (TELA) < VALOR FATURADO   -------------
          IF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_D ) AND
              (V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE ) THEN
               RAISE_APPLICATION_ERROR
    (-20101,'ERRO3,BAIXA NãO EFETUADA, VL.PAGO MENOR QUE O VALOR CORRETO');
------------------ VERIFIVA SE VALOR PAGO (TELA) >= AO VALOR FATURADO  ----------
          ELSIF V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                 UPDATE FATURA
                    SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                       ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                       ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                       ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                       ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_D
                       ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                       ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                       ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                       ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
                 WHERE  FAT_NR_FATURA =  T_FAT_NR_FATURA;
                  IF SQL%ROWCOUNT=0 THEN
                     RAISE_APPLICATION_ERROR
                    (-20101,'ERRO3 AO ATUALIZAR A FATURA');
                  END IF;
                  V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
                  AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_D;
                  AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
                  AX_VL_REC_ESTRANGEIRA := 0;
              END;
            END IF;
-----------  ROTINA PARA FECHAR O V_FAT_VL_REC_MOEDA (VALOR PAGO)  -------
            BEGIN
              IF C_ITFAT%NOTFOUND THEN
                IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                   T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                  BEGIN
                   UPDATE ITEM_FATURA
                      SET ITF_VL_REC_MOEDA_CORRENTE =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  V_FAT_VL_REC_MOEDA )
                         /T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX
                    WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                          ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                          ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                          ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                          ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO4 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                  END;
                END IF;
----  ROTINA PARA RATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA ------------
                IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_D THEN
                   T_SOMA_AUX_PAGAMENTO_CORRETO:=
                          T_VL_PGTO_CORRETO_D - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                  BEGIN
                    UPDATE ITEM_FATURA
                      SET ITF_VL_PAGAMENTO_CORRETO =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VL_PGTO_CORRETO_D )
                        / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_PAGAMENTO_CORRETO
                    WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                          ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                          ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                          ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                          ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO4 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                  END;
                END IF;
------------ ROTINA P/ NAO GRAVAR JUROS NOS ITENS FATURA QUANDO O VL. PAGO IGUAL---
----VL.RECEBIDO, OS JUROS SERAO COBRADOS A POSTERIORI (ACERTO PARCIAL-------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                           (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                            / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_JUROS
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
                EXIT;
            END IF;
---------- FINAL DA ROTINA DE RATEIO DOS JUROS NOS ITENS DA FATURA -------
            UPDATE ITEM_FATURA
              SET ITF_VL_REC_MOEDA_CORRENTE =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                        / T_FAT_VL_MOEDA_CORRENTE )
                   ,ITF_VL_PAGAMENTO_CORRETO =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D )
                        / T_FAT_VL_MOEDA_CORRENTE )
                   ,ITF_VL_JURR =
                        ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS
                        / T_FAT_VL_MOEDA_CORRENTE )
                WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                      ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                      ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                      ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                      ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO5 AO ATUALIZAR O ITEM FATURA');
              END IF;
-------------------------- SOMA ITENS DA FATURA --------------------------------
              IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                 T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       /T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D
                       /T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_JUROS:= T_SOMA_ITEM_JUROS +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS
                        /T_FAT_VL_MOEDA_CORRENTE);
              ELSE
                T_SOMA_ITEM_FATURA:= 0;
                T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                T_SOMA_ITEM_JUROS:= 0;
              END IF;
            END;
              V_MSG:='BAIXA EFETUADA COM SUCESSO';
          ELSIF (V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_D) AND
                (V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE) THEN
            IF T_FAT_TP_SITUACAO = 'FP' THEN
              IF C_ITFAT%NOTFOUND THEN
                NULL;
              ELSE
                IF (( T_FIXO > 100 ) AND
                   ((T_VL_PGTO_CORRETO_D - V_FAT_VL_PAGO) > 100 )) OR
                   (( T_FIXO < 100 )) THEN
                  BEGIN
                     INSERT
                      INTO ACERTO_PARCIAL
                          (ACP_ITF_NR_FATURA_FK
                          ,ACP_ITF_CD_TARIFA_FK
                          ,ACP_ITF_CD_ADMINISTRADORA_FK
                          ,ACP_ITF_SG_UNIDADE_FK
                          ,ACP_DT_ENTRADA
                          ,ACP_HH_ENTRADA
                          ,ACP_VL_ACERTO_MO_CORRENTE
                          ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                          ,ACP_TT_HISTORICO
                          ,ACP_DT_FIM_CORRECAO
                          ,ACP_DT_INICIO_CORRECAO
                          ,ACP_TAR_CD_TARIFA_FK
                          ,ACP_NR_FATURA_ITF_DV
                          ,ACP_IN_ORIGEM_RECEBIMENTO
                          )
                    VALUES
                          (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                          ,REG_ITFAT.ITF_CD_TARIFA
                          ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                          ,REG_ITFAT.ITF_SG_UNIDADE
                          ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                          ,TO_CHAR(SYSDATE,'HH24MI')
                          ,(((T_VL_PGTO_CORRETO_D - V_FAT_VL_PAGO) *
                              REG_ITFAT.ITF_VL_MOEDA_CORRENTE) / T_FAT_VL_MOEDA_CORRENTE)
                          ,NULL
                          ,'JUR VENC.'||TO_CHAR(T_FAT_DT_VENCIMENTO,'DD/MM/YYYY')
                               ||'PAGTO.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                          ,NULL
                          ,NULL
                          ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                         ,'12','12'
                                                         ,'14','15'
                                                         ,'15','15'
                                                         ,'20','22'
                                                         ,'22','22'
                                                         ,'24','25'
                                                         ,'25','25'
                                                         ,'30','32'
                                                         ,'32','32'
                                                         ,'34','35'
                                                         ,'35','35'
                                                         ,'40','42'
                                                         ,'42','42'
                                                         ,'44','45'
                                                         ,'45','45'
                                                         ,'50','52'
                                                         ,'52','52'
                                                         ,'54','55'
                                                         ,'55','55')
                          ,T_FAT_NR_FATURA_DV
                          ,'R');
                  EXCEPTION
                     WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR
                        (-20101,'ERRO3 -ACERTO PARCIAL -> REGISTRO JA EXISTE');
                  END;
                  T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_D;
                  GRAVA_LOG_ACERTO_PARCIAL;
                END IF;
              END IF;
            END IF;
          END IF;
                   V_MSG:='BAIXA EFETUADA COM SUCESSO';
-------  VERIFICA SE ( VALOR PAGO - VL_PGTO_CORRETO_D ) > FIXO  ----------
        ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D) > T_FIXO THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
              UPDATE FATURA
                SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                   ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                   ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                   ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                   ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_D
                   ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                   ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                   ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                   ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
              WHERE FAT_NR_FATURA  =  T_FAT_NR_FATURA;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO4 AO ATUALIZAR A FATURA');
              END IF;
              V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
              AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_D;
              AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
              AX_VL_REC_ESTRANGEIRA := 0;
            END;
          END IF;
-----------  ROTINA PARA FECHAR O V_FAT_VL_REC_MOEDA (VALOR PAGO)  -------
          BEGIN
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                   UPDATE ITEM_FATURA
                      SET ITF_VL_REC_MOEDA_CORRENTE =
                           (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  V_FAT_VL_REC_MOEDA )
                            / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX
                  WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                        ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                        ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                        ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                        ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                  IF SQL%ROWCOUNT=0 THEN
                     RAISE_APPLICATION_ERROR
                     (-20101,'ERRO6 AO ATUALIZAR O ITEM FATURA');
                  END IF;
                END;
              END IF;
-----  ROTINA PARA RATEAR O VALOR DO PAGAMENTO CORRETO NOS ITENS DA FATURA -----------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_D THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                       T_VL_PGTO_CORRETO_D - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                      (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D )
                       / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_PAGAMENTO_CORRETO
                  WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                        ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                        ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                        ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                        ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                  IF SQL%ROWCOUNT=0 THEN
                     RAISE_APPLICATION_ERROR
                     (-20101,'ERRO2 AO ATUALIZAR O ITEM FATURA');
                  END IF;
                END;
              END IF;
--------------------ROTINA PARA RATEAR OS JUROS NOS ITENS DA FATURA -------------------
----------- ROTINA P/ NAO GRAVAR JUROS NOS ITENS FATURA QUANDO O VL. PAGO IGUAL--------
-------------VL.RECEBIDO, OS JUROS SERAO COBRADOS A POSTERIORI (ACERTO PARCIAL --------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS  := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                     UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                        (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                         / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_JUROS
                      WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                            ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                            ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                            ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                            ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                         (-20101,'ERRO2 AO ATUALIZAR OS JUROS DO ITEM FATURA');
                    END IF;
                  END;
                END IF;
              END IF;
                  EXIT;
            END IF;
---------------     FINAL DA ROTINA DE RATEIO DO ITEM   ------------------
            UPDATE ITEM_FATURA
              SET ITF_VL_REC_MOEDA_CORRENTE =
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                      / T_FAT_VL_MOEDA_CORRENTE )
                 ,ITF_VL_PAGAMENTO_CORRETO =
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D )
                      / T_FAT_VL_MOEDA_CORRENTE )
                 ,ITF_VL_JURR =
                     ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS
                     / T_FAT_VL_MOEDA_CORRENTE )
            WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                  ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                  ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                  ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                  ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
            IF SQL%ROWCOUNT=0 THEN
               RAISE_APPLICATION_ERROR
               (-20101,'ERRO7 AO ATUALIZAR O ITEM FATURA');
            END IF;
-------------------------- SOMA ITENS DA FATURA --------------------------------
            IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
               T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                     /T_FAT_VL_MOEDA_CORRENTE);
               T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO+
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_D
                     /T_FAT_VL_MOEDA_CORRENTE);
               T_SOMA_ITEM_JUROS:= T_SOMA_ITEM_JUROS +
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS
                     /T_FAT_VL_MOEDA_CORRENTE);
            ELSE
              T_SOMA_ITEM_FATURA:= 0;
              T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
              T_SOMA_ITEM_JUROS := 0;
            END IF;
          END;
          IF (V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_D) THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT INTO PAGAMENTO_A_MAIOR
                          ( PAG_ID
                           ,PAG_FAT_NR_FATURA_FK
                           ,PAG_DT_EMISSAO
                           ,PAG_DT_LANCAMENTO
                           ,PAG_DT_PAGAMENTO
                           ,PAG_DT_DEVOLUCAO
                           ,PAG_VL_CORRETO
                           ,PAG_VL_CREDITO
                           ,PAG_VL_PAGO
                           ,PAG_TT_COMENTARIO
                            )
                      VALUES
                          ( PAG_SEQ.NEXTVAL
                           ,T_FAT_NR_FATURA
                           ,T_FAT_DT_EMISSAO
                           ,V_FAT_DT_LANCAMENTO
                           ,V_FAT_DT_PAGAMENTO
                           ,NULL
                           ,T_VL_PGTO_CORRETO_D
                           ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_D
                           ,V_FAT_VL_PAGO
                           ,'FAT. C/ATRASO-RECEBIDO A MAIOR VIA ON-LINE'
                          );
              EXCEPTION
                 WHEN DUP_VAL_ON_INDEX THEN
                      RAISE_APPLICATION_ERROR
                    (-20101,'ERRO3 AO INSERIR NA TABELA PAGAMENTO A MAIOR');
              END;
            END IF;
          END IF;
        END IF;
      END IF;
                 V_MSG:='BAIXA EFETUADA COM SUCESSO';
--------------------------------------------------------------------------
---##   TRATAMENTO DE DADOS PARA FATURA           NATUREZA VOO = I   ##---
--------------------------------------------------------------------------
    ELSIF T_FAT_TP_NATUREZA_VOO = 'I' THEN
      IF C_ITFAT%ROWCOUNT = 1 THEN
         T_FIXO := T_FAT_VL_MOEDA_CORRENTE * 0.01;

         T_VL_COTACAO_PGTO_FAT  := ( T_FAT_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_PGTO );

         T_VL_COTACAO_VENCTO_FAT:= ( T_FAT_VL_MOEDA_CORRENTE );
         T_VL_VCR_CORRETO       := ( T_FAT_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_PGTO ) -
                                     T_FAT_VL_MOEDA_CORRENTE ;
         T_FAT_VL_VCR           := ( T_VL_COTACAO_PGTO_FAT  - T_VL_COTACAO_VENCTO_FAT );
         T_ACP_VL_VCR           := ( T_VL_COTACAO_PGTO_ITEM - T_VL_COTACAO_VENCTO_ITEM );
         T_VL_COTACAO_PGTO_ITEM := ( REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_PGTO);
         T_VL_COTACAO_VENCTO_ITEM:=( REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_EMISSAO);
--------- CALCULO DO VALOR DOS JUROS  A SER COBRADO FATURA COM ATRASO ----
        IF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') > TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') THEN
           T_VALOR_JUROS_REAIS := ( V_FAT_DT_PAGAMENTO - T_FAT_DT_VENCIMENTO ) *
                ( T_FAT_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_PGTO ) / 3000;
          IF T_FAT_IN_INIBICAO = 'J'  THEN
             T_VALOR_JUROS_REAIS := 0;
          END IF;
--------- FORMULA DE CALCULO DO VALOR PAGAMENTO CORRETO COM ATRASO  ---------
          T_VL_PGTO_CORRETO_C_ATRASO :=  ( T_FAT_VL_MOEDA_ESTRANGEIRA *
                                           T_VALOR_DOLAR_PGTO) + T_VALOR_JUROS_REAIS;
          IF (T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO ) <> 0 THEN
               T_VL_VCR_RATEIO :=
                  ((T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO ) /
                   (T_VL_VCR_CORRETO + T_VALOR_JUROS_REAIS )) * T_VL_VCR_CORRETO;
          ELSE
               T_VL_VCR_RATEIO := 0;
          END IF;
        ELSIF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD')  <=
              TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') OR T_FAT_IN_INIBICAO = 'J' THEN
--------FORMULA DE CALCULO DO PAGAMENTO CORRETO DA FATURA SEM ATRASO  ----
           T_VL_PGTO_CORRETO_S_ATRASO :=
                            (T_FAT_VL_MOEDA_ESTRANGEIRA * T_VALOR_DOLAR_PGTO);
          IF (T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO ) <> 0 THEN
              T_VL_VCR_RATEIO :=
                  ((T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO ) /
                   (T_VL_VCR_CORRETO + T_VALOR_JUROS_REAIS )) * T_VL_VCR_CORRETO;
          ELSE
             T_VL_VCR_RATEIO := 0;
          END IF;
        END IF;
        --------ROTINA PARA RECEBER A FATURA INTERNACIONAL DO GRUPO I QUE FOI PAGA NOS --------
--------BANCOS 002,003 E 275 COM VALOR MENOR QUE O FATURADO E MENOR QUE O CORRETO  ----
--------DE ACORDO COM LUIS AUGUSTO / LILIAM EM 11/09/2001  ----------------------------
        IF T_FAT_TP_GRUPO = '1'      THEN
          IF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_S_ATRASO AND
               V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE ) OR

             ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_C_ATRASO AND
               V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE ) THEN
            IF V_FAT_AGE_CD_AGENTE_REC_FK IN ( 002,003,275 ) THEN
               T_RECEBE_FATURA := 'S';
            END IF;
          END IF;
        END IF;
---------------------------------------------------------------------------------------
      END IF;
-------------------------------------------------------------------------------
---##                      TRATAMENTO PARA FATURA                         ##---
-------------------------------------------------------------------------------
---##             NATUREZA VOO = I      PAGAMENTO SEM ATRASO              ##---
-------------------------------------------------------------------------------
      IF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') <=
         TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') THEN
        IF T_FAT_TP_GRUPO = '2'      THEN
          IF V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_S_ATRASO THEN
             V_FAT_VL_REC_MOEDA := T_VL_PGTO_CORRETO_S_ATRASO;
---- rotina criada para gravar a variação cambial efetivamente paga -----------
-----criada em 04/05/2000 -----------------------------------------------------
          ELSIF V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_S_ATRASO THEN
            IF V_FAT_VL_PAGO > T_FAT_VL_MOEDA_CORRENTE THEN
               T_DIF_REC_FATURADO := V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE;
              IF T_DIF_REC_FATURADO < T_FAT_VL_VCR THEN
                 T_FAT_VL_VCR := T_DIF_REC_FATURADO;
              END IF;
            ELSIF V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE THEN
                  T_DIF_REC_FATURADO := V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE;
                  T_FAT_VL_VCR := T_DIF_REC_FATURADO;
            ELSIF V_FAT_VL_PAGO = T_FAT_VL_MOEDA_CORRENTE THEN
                  T_FAT_VL_VCR := 0;
            END IF;
          END IF;
        ELSIF T_FAT_TP_GRUPO = '1' THEN
           T_FAT_VL_VCR := NULL;
           T_VL_PGTO_CORRETO_S_ATRASO := T_FAT_VL_MOEDA_CORRENTE;
           V_FAT_VL_REC_MOEDA := T_FAT_VL_MOEDA_CORRENTE;
        END IF;
        IF -T_FIXO <= ( V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO) OR
                      ( V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO) <= T_FIXO THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
             UPDATE FATURA
               SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                  ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                  ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                  ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                  ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_S_ATRASO
                  ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                  ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                  ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                  ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                  ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
             WHERE FAT_NR_FATURA = T_FAT_NR_FATURA;
             IF SQL%ROWCOUNT=0 THEN
                RAISE_APPLICATION_ERROR
                (-20101,'ERRO5 AO ATUALIZAR A FATURA');
             END IF;
             V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
             AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_S_ATRASO;
             AX_VL_REC_CORRENTE    := T_FAT_VL_MOEDA_CORRENTE;
             AX_VL_REC_ESTRANGEIRA := T_FAT_VL_MOEDA_ESTRANGEIRA;
            END;
          END IF;
          BEGIN
---------ROTINA PARA RATEAR OS VALORES RECEBIDOS NOS ITENS DA FATURA  ------------------
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                          ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA)
                           /T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX)
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                         ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE               = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
------ ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_FAT_TP_GRUPO = '2'      THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_VCR =
                            (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                             / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_VCR
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE               = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
  ------------ROTINA PARA RATEAR O VALOR DO PAGAMENTO CORRETO NOS ITENS DA FATURA ---------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_S_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                     T_VL_PGTO_CORRETO_S_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO )
                          / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_PAGAMENTO_CORRETO
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
                EXIT;
            END IF;
---- ROTINA PARA GRAVAR OU NÃO VARIAÇÃO CAMBIAL , DEPENDENDO DO GRUPO ---------
            IF T_FAT_TP_GRUPO = '2'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                    ,ITF_VL_VCR =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                        /T_FAT_VL_MOEDA_CORRENTE)
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO9 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       /T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO+
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                       /T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_FATURA_VCR:= T_SOMA_ITEM_FATURA_VCR +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                       /T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                   T_SOMA_ITEM_FATURA_VCR:= 0;
                END IF;
            ELSIF  T_FAT_TP_GRUPO = '1'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO9 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       /T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO+
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                       /T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                END IF;
            END IF;
          END;
          IF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_S_ATRASO ) AND
             ( V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE ) OR
               T_RECEBE_FATURA = 'S' THEN
            IF T_FAT_TP_SITUACAO = 'FP' THEN
              IF (( T_FIXO > 100 ) AND
                 (( V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO ) > 100 )) OR
                 (( T_FIXO < 100 )) THEN
                IF C_ITFAT%NOTFOUND THEN
                  NULL;
                ELSE
                  BEGIN
                   INSERT
                    INTO ACERTO_PARCIAL
                        (ACP_ITF_NR_FATURA_FK
                        ,ACP_ITF_CD_TARIFA_FK
                        ,ACP_ITF_CD_ADMINISTRADORA_FK
                        ,ACP_ITF_SG_UNIDADE_FK
                        ,ACP_DT_ENTRADA
                        ,ACP_HH_ENTRADA
                        ,ACP_VL_ACERTO_MO_CORRENTE
                        ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                        ,ACP_TT_HISTORICO
                        ,ACP_DT_FIM_CORRECAO
                        ,ACP_DT_INICIO_CORRECAO
                        ,ACP_TAR_CD_TARIFA_FK
                        ,ACP_NR_FATURA_ITF_DV
                        ,ACP_IN_ORIGEM_RECEBIMENTO
                        ,ACP_VL_VCR
                        )
                   VALUES
                        (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                        ,REG_ITFAT.ITF_CD_TARIFA
                        ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                        ,REG_ITFAT.ITF_SG_UNIDADE
                        ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                        ,TO_CHAR(SYSDATE,'HH24MI')
                        ,((T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO) *
                           REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /T_FAT_VL_MOEDA_CORRENTE
                        ,(((T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO) *
                           REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /
                            T_FAT_VL_MOEDA_CORRENTE)/T_VALOR_DOLAR_PGTO
                        ,'ENCARGOS EMIS-'||TO_CHAR(T_FAT_DT_EMISSAO,'DD/MM/YYYY')
                              ||'PAGTO.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                        ,NULL
                        ,NULL
                        ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                       ,'12','12'
                                                       ,'14','15'
                                                       ,'15','15'
                                                       ,'20','22'
                                                       ,'22','22'
                                                       ,'24','25'
                                                       ,'25','25'
                                                       ,'30','32'
                                                       ,'32','32'
                                                       ,'34','35'
                                                       ,'35','35'
                                                       ,'40','42'
                                                       ,'42','42'
                                                       ,'44','45'
                                                       ,'45','45'
                                                       ,'50','52'
                                                       ,'52','52'
                                                       ,'54','55'
                                                       ,'55','55')
                        ,T_FAT_NR_FATURA_DV
                        ,'R'
                        ,(T_VL_VCR_RATEIO / T_VL_VCR_CORRETO ) * T_ACP_VL_VCR
                       );
                  EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO4 ACERTO PARCIAL -> REGISTRO JA EXISTE');
                      WHEN OTHERS THEN
                          RAISE_APPLICATION_ERROR
                         (-20101,'ERRO5 OCORREU UM ERRO AO INSERIR ACERTO PARCIAL');
                  END;
                  T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_S_ATRASO;
                  GRAVA_LOG_ACERTO_PARCIAL;

                END IF;
              END IF;
            END IF;
                 V_MSG:='BAIXA EFETUADA COM SUCESSO';
          ELSIF ( V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_S_ATRASO ) THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT
                   INTO PAGAMENTO_A_MAIOR
                      ( PAG_ID
                       ,PAG_FAT_NR_FATURA_FK
                       ,PAG_DT_EMISSAO
                       ,PAG_DT_LANCAMENTO
                       ,PAG_DT_PAGAMENTO
                       ,PAG_DT_DEVOLUCAO
                       ,PAG_VL_CORRETO
                       ,PAG_VL_CREDITO
                       ,PAG_VL_PAGO
                       ,PAG_TT_COMENTARIO
                       )
                 VALUES
                     ( PAG_SEQ.NEXTVAL
                      ,T_FAT_NR_FATURA
                      ,T_FAT_DT_EMISSAO
                      ,V_FAT_DT_LANCAMENTO
                      ,V_FAT_DT_PAGAMENTO
                      ,NULL
                      ,T_VL_PGTO_CORRETO_S_ATRASO
                      ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO
                      ,V_FAT_VL_PAGO
                      ,'FATURA SEM ATRASO-RECEBIMENTO A MAIOR VIA ON-LINE');
              EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO4 PAGAMENTO A MAIOR -> REGISTRO JA EXISTE');
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR
                   (-20101,'ERRO5 AO INSERIR NO PAGAMENTO A MAIOR');
              END;
            END IF;
          END IF;
                  V_MSG:='BAIXA EFETUADA COM SUCESSO';
        ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO ) < -T_FIXO THEN
          IF T_FAT_TP_GRUPO = 1 THEN
            IF V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE THEN
                RAISE_APPLICATION_ERROR
              (-20101,'ERRO4,BAIXA NãO EFETUADA, VALOR PAGO MENOR QUE O A PAGAR');
            END IF;
          ELSIF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_S_ATRASO ) AND
                 (V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE )  THEN
                RAISE_APPLICATION_ERROR
             (-20101,'ERRO5,BAIXA NãO EFETUADA, VALOR PAGO MENOR QUE O A PAGAR');
          END IF;
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
               UPDATE FATURA
                  SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                     ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                     ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                     ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                     ,FAT_VL_PAGAMENTO_CORRETO       =  T_FAT_VL_MOEDA_CORRENTE
                     ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                     ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                     ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                     ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                     ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
               WHERE FAT_NR_FATURA = T_FAT_NR_FATURA;
              IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO6 AO ATUALIZAR A FATURA');
              END IF;
              V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
              AX_PGTO_CORRETO       := T_FAT_VL_MOEDA_CORRENTE;
              AX_VL_REC_CORRENTE    := T_FAT_VL_MOEDA_CORRENTE;
              AX_VL_REC_ESTRANGEIRA := T_FAT_VL_MOEDA_ESTRANGEIRA;
            END;
          END IF;
-----------  ROTINA PARA RATEAR O VALOR RECEBIDO NOS ITENS DA FATURA----------------
          BEGIN
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                          ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA)
                           /T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX)
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO10 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
------ ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_FAT_TP_GRUPO = '2' THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_VCR =
                            ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR)
                             /T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_VCR)
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
  ------- ROTINA PARA ATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA -----------------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_S_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                        T_VL_PGTO_CORRETO_S_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                          ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO)
                           /T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_PAGAMENTO_CORRETO)
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO10 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
                EXIT;
            END IF;
---- ROTINA PARA GRAVAR OU NÃO VARIAÇÃO CAMBIAL , DEPENDENDO DO GRUPO ---------
            IF T_FAT_TP_GRUPO = '2'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_VCR =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO11 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       /T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                       /T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                   T_SOMA_ITEM_FATURA_VCR:= 0;
                END IF;
            ELSIF T_FAT_TP_GRUPO = '1'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                        (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                        /T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO11 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       /T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                       (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO
                       /T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                   T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                END IF;
              END IF;
            END;
                  V_MSG:='BAIXA EFETUADA COM SUCESSO';
------------INSERIR ACERTO_PARCIAL QUANDO VALOR PAGO < VALOR CORRETO  ---------
          IF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_S_ATRASO ) AND
             ( V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE) OR
               T_RECEBE_FATURA = 'S' THEN
            IF T_FAT_TP_SITUACAO = 'FP'  THEN
              IF C_ITFAT%NOTFOUND THEN
                  NULL;
              ELSE
                BEGIN
                   INSERT
                    INTO ACERTO_PARCIAL
                        (ACP_ITF_NR_FATURA_FK
                        ,ACP_ITF_CD_TARIFA_FK
                        ,ACP_ITF_CD_ADMINISTRADORA_FK
                        ,ACP_ITF_SG_UNIDADE_FK
                        ,ACP_DT_ENTRADA
                        ,ACP_HH_ENTRADA
                        ,ACP_VL_ACERTO_MO_CORRENTE
                        ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                        ,ACP_TT_HISTORICO
                        ,ACP_DT_FIM_CORRECAO
                        ,ACP_DT_INICIO_CORRECAO
                        ,ACP_TAR_CD_TARIFA_FK
                        ,ACP_NR_FATURA_ITF_DV
                        ,ACP_IN_ORIGEM_RECEBIMENTO
                        ,ACP_VL_VCR
                        )
                   VALUES
                        (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                        ,REG_ITFAT.ITF_CD_TARIFA
                        ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                        ,REG_ITFAT.ITF_SG_UNIDADE
                        ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                        ,TO_CHAR(SYSDATE,'HH24MI')
                        ,((T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO) *
                           REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /T_FAT_VL_MOEDA_CORRENTE
                        ,(((T_VL_PGTO_CORRETO_S_ATRASO - V_FAT_VL_PAGO) *
                           REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /
                            T_FAT_VL_MOEDA_CORRENTE)/T_VALOR_DOLAR_PGTO
                        ,'ENCARGOS EMIS-'||TO_CHAR(T_FAT_DT_EMISSAO,'DD/MM/YYYY')
                              ||'PAGTO.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                        ,NULL
                        ,NULL
                        ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                       ,'12','12'
                                                       ,'14','15'
                                                       ,'15','15'
                                                       ,'20','22'
                                                       ,'22','22'
                                                       ,'24','25'
                                                       ,'25','25'
                                                       ,'30','32'
                                                       ,'32','32'
                                                       ,'34','35'
                                                       ,'35','35'
                                                       ,'40','42'
                                                       ,'42','42'
                                                       ,'44','45'
                                                       ,'45','45'
                                                       ,'50','52'
                                                       ,'52','52'
                                                       ,'54','55'
                                                       ,'55','55')
                        ,T_FAT_NR_FATURA_DV
                        ,'R'
                        ,(T_VL_VCR_RATEIO / T_VL_VCR_CORRETO ) * T_ACP_VL_VCR
                       );
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                         RAISE_APPLICATION_ERROR
                       (-20101,'ERRO6 ACERTO PARCIAL -> REGISTRO JA EXISTE');
                    WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR
                       (-20101,'ERRO7 OCORREU UM ERRO AO INSERIR ACERTO PARCIAL');
                END;
                T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_S_ATRASO;
                GRAVA_LOG_ACERTO_PARCIAL;

              END IF;
            END IF;
          END IF;
                  V_MSG:='BAIXA EFETUADA COM SUCESSO';
        ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO ) > T_FIXO THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
              UPDATE FATURA
                 SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                    ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                    ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                    ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                    ,FAT_VL_PAGAMENTO_CORRETO       =  T_FAT_VL_MOEDA_CORRENTE
                    ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                    ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                    ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                    ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                    ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
              WHERE FAT_NR_FATURA   =  T_FAT_NR_FATURA;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO7 AO ATUALIZAR A FATURA');
                END IF;
                V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
                AX_PGTO_CORRETO       := T_FAT_VL_MOEDA_CORRENTE;
                AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
                AX_VL_REC_ESTRANGEIRA := 0;
            END;
          END IF;
          BEGIN
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                        / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                  IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                     (-20101,'ERRO13 AO ATUALIZAR O ITEM FATURA');
                  END IF;
                END;
              END IF;
-----  ROTINA PARA RATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA -------------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_S_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                      T_VL_PGTO_CORRETO_S_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                   UPDATE ITEM_FATURA
                      SET ITF_VL_PAGAMENTO_CORRETO =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VL_PGTO_CORRETO_S_ATRASO)
                        / T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_PAGAMENTO_CORRETO)
                    WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                          ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                          ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                          ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                          ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                  IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                     (-20101,'ERRO13 AO ATUALIZAR O ITEM FATURA');
                  END IF;
                END;
              END IF;
---------- ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_FAT_TP_GRUPO = '2' THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                     UPDATE ITEM_FATURA
                        SET ITF_VL_VCR =
                          ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR)
                           /T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_VCR)
                   WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                         ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                  END;
                END IF;
              END IF;
                  EXIT;
            END IF;
---- ROTINA PARA GRAVAR OU NÃO VARIAÇÃO CAMBIAL , DEPENDENDO DO GRUPO ---------
            IF T_FAT_TP_GRUPO = '2'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                          / T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO )
                          / T_FAT_VL_MOEDA_CORRENTE )
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                    ,ITF_VL_VCR  =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                          / T_FAT_VL_MOEDA_CORRENTE )
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO12 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                      (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  V_FAT_VL_REC_MOEDA )
                       / T_FAT_VL_MOEDA_CORRENTE);
                   T_SOMA_ITEM_FATURA_VCR:= T_SOMA_ITEM_FATURA_VCR +
                      (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_FAT_VL_VCR )
                       / T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                   T_SOMA_ITEM_FATURA_VCR:= 0;
                END IF;
            ELSIF T_FAT_TP_GRUPO = '1'      THEN
              UPDATE ITEM_FATURA
                 SET ITF_VL_REC_MOEDA_CORRENTE =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                          / T_FAT_VL_MOEDA_CORRENTE)
                    ,ITF_VL_PAGAMENTO_CORRETO =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_S_ATRASO )
                          / T_FAT_VL_MOEDA_CORRENTE )
                    ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
               WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                     ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                     ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                     ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                     ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO12 AO ATUALIZAR O ITEM FATURA');
                END IF;
                IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                   T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                      (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  V_FAT_VL_REC_MOEDA )
                       / T_FAT_VL_MOEDA_CORRENTE);
                ELSE
                   T_SOMA_ITEM_FATURA:= 0;
                END IF;
            END IF;
          END;
          IF ( V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_S_ATRASO ) THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT INTO PAGAMENTO_A_MAIOR
                          ( PAG_ID
                           ,PAG_FAT_NR_FATURA_FK
                           ,PAG_DT_EMISSAO
                           ,PAG_DT_LANCAMENTO
                           ,PAG_DT_PAGAMENTO
                           ,PAG_DT_DEVOLUCAO
                           ,PAG_VL_CORRETO
                           ,PAG_VL_CREDITO
                           ,PAG_VL_PAGO
                           ,PAG_TT_COMENTARIO
                           )
                     VALUES
                          ( PAG_SEQ.NEXTVAL
                           ,T_FAT_NR_FATURA
                           ,T_FAT_DT_EMISSAO
                           ,V_FAT_DT_LANCAMENTO
                           ,V_FAT_DT_PAGAMENTO
                           ,NULL
                           ,T_VL_PGTO_CORRETO_S_ATRASO
                           ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_S_ATRASO
                           ,V_FAT_VL_PAGO
                           ,'FATURA SEM ATRASO-RECEBIMENTO A MAIOR VIA ON-LINE'
                          );
              EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO6 PAGAMENTO A MAIOR -> REGISTRO JA EXISTE');
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR
                   (-20101,'ERRO7 AO INSERIR NO PAGAMENTO A MAIOR');
              END;
            END IF;
          END IF;
        END IF;
                   V_MSG:='BAIXA EFETUADA COM SUCESSO';
------------------------------------------------------------------------------
---## ----                TRATAMENTO PARA FATURA                         ##---
------------------------------------------------------------------------------
---##            NATUREZA VOO = I      PAGAMENTO COM ATRASO              ##---
------------------------------------------------------------------------------
      ELSIF TO_CHAR(V_FAT_DT_PAGAMENTO,'YYYYMMDD') >
            TO_CHAR(T_FAT_DT_VENCIMENTO,'YYYYMMDD') THEN
------ ROTINA PARA CALCULAR O VALOR A SER GRAVADO NAS COLUNAS JUROS E   -----
-------VARIACAO CAMBIAL DO ITEM QUANDO O VALOR PAGO E MAIOR QUE O VALOR  ----
-------FATURADO E MENOR QUE O VALOR CORRETO, CONSIDERANDO PRIMEIRO OS  ------
-------JUROS E POSTERIORMENTE A VARIACAO CAMBIAL ( SOBRA OU NAO )    --------
------ELCIO ( RIO 09/02/99 )  -----------------------------------------------
        IF V_FAT_VL_PAGO >= T_VL_PGTO_CORRETO_C_ATRASO THEN
            V_FAT_VL_REC_MOEDA          := T_VL_PGTO_CORRETO_C_ATRASO;
            T_VALOR_RECEBIDO_JUROS      := T_VALOR_JUROS_REAIS;
            T_GRAVA_JUROS               := 'S';
            T_GRAVA_VARIACAO_CAMBIAL    := 'S';
            T_VALOR_GRAVA_ACERTO_PARCIAL:= 0;
        ELSIF V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_C_ATRASO THEN
          IF V_FAT_VL_PAGO > T_FAT_VL_MOEDA_CORRENTE THEN
             T_DIF_REC_FATURADO := V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE;
            IF T_DIF_REC_FATURADO >= T_VALOR_JUROS_REAIS THEN
               T_VALOR_RECEBIDO_JUROS := T_VALOR_JUROS_REAIS;
               T_GRAVA_JUROS          := 'S';
              IF ( T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS ) >= T_FAT_VL_VCR THEN
                   T_GRAVA_VARIACAO_CAMBIAL     := 'S';
                   T_VALOR_GRAVA_ACERTO_PARCIAL :=
                     (T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS) - T_FAT_VL_VCR;
              ELSIF ( T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS ) < T_FAT_VL_VCR THEN
                   T_DIF_VAR_CAMBIAL := ( T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS );
                   T_VALOR_GRAVA_ACERTO_PARCIAL :=
                       ( T_FAT_VL_VCR - ( T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS ));
                   T_GRAVA_VARIACAO_CAMBIAL     := 'S';
                   T_FAT_VL_VCR                 := T_DIF_VAR_CAMBIAL;
              END IF;
            ELSIF T_DIF_REC_FATURADO < T_VALOR_JUROS_REAIS THEN
                  T_VALOR_RECEBIDO_JUROS    := T_DIF_REC_FATURADO;
                  T_GRAVA_JUROS             := 'S';
                  T_GRAVA_VARIACAO_CAMBIAL  := 'N';
                  T_FAT_VL_VCR              := 0;
                  T_VALOR_GRAVA_ACERTO_PARCIAL := ( T_FAT_VL_VCR -
                          ( T_DIF_REC_FATURADO - T_VALOR_JUROS_REAIS ));
            END IF;
          ELSIF V_FAT_VL_PAGO = T_FAT_VL_MOEDA_CORRENTE THEN
                T_VALOR_RECEBIDO_JUROS      := 0;
                T_GRAVA_JUROS               := 'N';
                T_GRAVA_VARIACAO_CAMBIAL    := 'N';
                T_FAT_VL_VCR                := 0;
                T_VALOR_GRAVA_ACERTO_PARCIAL:= ( T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO );
          ELSIF V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE THEN
          ----  T_VALOR_RECEBIDO_JUROS      := 0;
          ----  T_GRAVA_JUROS               := 'N';
                T_GRAVA_JUROS               := 'S';
                T_DIF_REC_FATURADO := V_FAT_VL_PAGO - T_FAT_VL_MOEDA_CORRENTE;
                T_FAT_VL_VCR := T_DIF_REC_FATURADO;
          END IF;
        END IF;
        IF -T_FIXO <= (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO)  OR
                      (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO) <= T_FIXO THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
              UPDATE FATURA
                 SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                    ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                    ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                    ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                    ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_C_ATRASO
                    ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                    ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                    ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                    ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                    ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                    ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
               WHERE FAT_NR_FATURA  =  T_FAT_NR_FATURA;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO8 AO ATUALIZAR A FATURA');
                END IF;
                V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
                AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_C_ATRASO;
                AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
                AX_VL_REC_ESTRANGEIRA := T_FAT_VL_MOEDA_ESTRANGEIRA;
            END;
          END IF;
------ ROTINA PARA RATEAR O VALOR RECEBIDO NOS ITENS DA FATURA ------------------------
          BEGIN
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX  := V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                             (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                              / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                         ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
------------- ROTINA PARA RATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA  ----------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_C_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                     T_VL_PGTO_CORRETO_C_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                           (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO)
                            / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX_PAGAMENTO_CORRETO
                   WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                         ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
-----------  ROTINA PARA RATEAR OS JUROS NOS ITENS DA FATURA  --------------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                             (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS )
                              / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX_JUROS
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
------ ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_GRAVA_VARIACAO_CAMBIAL = 'S' THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_VCR =
                          (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                           / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX_VCR
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
               EXIT;
            END IF;
            UPDATE ITEM_FATURA
               SET ITF_VL_REC_MOEDA_CORRENTE =
                     (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                      /T_FAT_VL_MOEDA_CORRENTE)
                  ,ITF_VL_PAGAMENTO_CORRETO =
                      (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO
                      /T_FAT_VL_MOEDA_CORRENTE)
                  ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                  ,ITF_VL_JURR =
                      (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS
                      /T_FAT_VL_MOEDA_CORRENTE)
                  ,ITF_VL_VCR =
                      (REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                      /T_FAT_VL_MOEDA_CORRENTE)
             WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                   ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                   ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                   ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                   ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO9 AO ATUALIZAR O ITEM FATURA');
              END IF;
              IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                 T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA)
                      / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO )
                      / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_FATURA_VCR:= T_SOMA_ITEM_FATURA_VCR +
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                      / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_JUROS     := T_SOMA_ITEM_JUROS +
                     (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                      / T_FAT_VL_MOEDA_CORRENTE);

              ELSE
                 T_SOMA_ITEM_FATURA           := 0;
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                 T_SOMA_ITEM_JUROS            := 0;
                 T_SOMA_ITEM_FATURA_VCR       := 0;
              END IF;
          END;
          IF ( V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_C_ATRASO ) THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                 INSERT
                  INTO PAGAMENTO_A_MAIOR
                     ( PAG_ID
                      ,PAG_FAT_NR_FATURA_FK
                      ,PAG_DT_EMISSAO
                      ,PAG_DT_LANCAMENTO
                      ,PAG_DT_PAGAMENTO
                      ,PAG_DT_DEVOLUCAO
                      ,PAG_VL_CORRETO
                      ,PAG_VL_CREDITO
                      ,PAG_VL_PAGO
                      ,PAG_TT_COMENTARIO
                      )
                 VALUES
                     ( PAG_SEQ.NEXTVAL
                      ,T_FAT_NR_FATURA
                      ,T_FAT_DT_EMISSAO
                      ,V_FAT_DT_LANCAMENTO
                      ,V_FAT_DT_PAGAMENTO
                      ,NULL
                      ,T_VL_PGTO_CORRETO_C_ATRASO
                      ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO
                      ,V_FAT_VL_PAGO
                      ,'FATURA C/ ATRASO-RECEBIMENTO A MAIOR VIA ON-LINE'
                     );
              EXCEPTION
                  WHEN DUP_VAL_ON_INDEX THEN
                       RAISE_APPLICATION_ERROR
                   (-20101,'ERRO8 PAGAMENTO A MAIOR -> REGISTRO JA EXISTE');
                  WHEN OTHERS THEN
                       RAISE_APPLICATION_ERROR
                   (-20101,'ERRO9 AO AO INSERIR PAGAMENTO A MAIOR');
              END;
            END IF;
                 V_MSG:='BAIXA EFETUADA COM SUCESSO';
          ELSIF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_C_ATRASO ) AND
                ( V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE ) OR
                  T_RECEBE_FATURA = 'S' THEN
            IF  T_FAT_TP_SITUACAO = 'FP'  THEN
              IF (( T_FIXO > 100 ) AND
                 (( T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO ) > 100 )) OR
                 (( T_FIXO < 100 )) THEN
                IF C_ITFAT%NOTFOUND THEN
                    NULL;
                ELSE
                  BEGIN
                   INSERT
                    INTO ACERTO_PARCIAL
                        (ACP_ITF_NR_FATURA_FK
                        ,ACP_ITF_CD_TARIFA_FK
                        ,ACP_ITF_CD_ADMINISTRADORA_FK
                        ,ACP_ITF_SG_UNIDADE_FK
                        ,ACP_DT_ENTRADA
                        ,ACP_HH_ENTRADA
                        ,ACP_VL_ACERTO_MO_CORRENTE
                        ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                        ,ACP_TT_HISTORICO
                        ,ACP_DT_FIM_CORRECAO
                        ,ACP_DT_INICIO_CORRECAO
                        ,ACP_TAR_CD_TARIFA_FK
                        ,ACP_NR_FATURA_ITF_DV
                        ,ACP_IN_ORIGEM_RECEBIMENTO
                        ,ACP_VL_VCR
                         )
                   VALUES
                        (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                        ,REG_ITFAT.ITF_CD_TARIFA
                        ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                        ,REG_ITFAT.ITF_SG_UNIDADE
                        ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                        ,TO_CHAR(SYSDATE,'HH24MI')
                        ,(((T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO) *
                            REG_ITFAT.ITF_VL_MOEDA_CORRENTE) / T_FAT_VL_MOEDA_CORRENTE)
                        ,((((T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO) *
                             REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /
                             T_FAT_VL_MOEDA_CORRENTE) / T_VALOR_DOLAR_PGTO)
                        ,'ENCARGOS EMI-'||TO_CHAR(T_FAT_DT_EMISSAO,'DD/MM/YYYY')
                               ||'PG.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                        ,NULL
                        ,NULL
                        ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                       ,'12','12'
                                                       ,'14','15'
                                                       ,'15','15'
                                                       ,'20','22'
                                                       ,'22','22'
                                                       ,'24','25'
                                                       ,'25','25'
                                                       ,'30','32'
                                                       ,'32','32'
                                                       ,'34','35'
                                                       ,'35','35'
                                                       ,'40','42'
                                                       ,'42','42'
                                                       ,'44','45'
                                                       ,'45','45'
                                                       ,'50','52'
                                                       ,'52','52'
                                                       ,'54','55'
                                                       ,'55','55')
                        ,T_FAT_NR_FATURA_DV
                        ,'R'
                        ,(T_VL_VCR_RATEIO / T_VL_VCR_CORRETO) * T_ACP_VL_VCR
                        );
                  EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                         RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 ACERTO PARCIAL -> REGISTRO JA EXISTE');
                  END;
                  T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_C_ATRASO;
                  GRAVA_LOG_ACERTO_PARCIAL;

                END IF;
              END IF;
            END IF;
          END IF;
                  V_MSG:='BAIXA EFETUADA COM SUCESSO';
        ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO) < -T_FIXO  THEN
          IF ( V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_C_ATRASO ) AND
             ( V_FAT_VL_PAGO < T_FAT_VL_MOEDA_CORRENTE ) THEN
                RAISE_APPLICATION_ERROR
              (-20101,'ERRO6,BAIXA NãO EFETUADA, VALOR PAGO MENOR QUE O FATURADO');
          ELSIF V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                UPDATE FATURA
                   SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                      ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                      ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                      ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                      ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_C_ATRASO
                      ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                      ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                      ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                      ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                      ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                      ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
                 WHERE FAT_NR_FATURA  =  T_FAT_NR_FATURA;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO9 AO ATUALIZAR A FATURA');
                END IF;
                V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
                AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_C_ATRASO;
                AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
                AX_VL_REC_ESTRANGEIRA := T_FAT_VL_MOEDA_ESTRANGEIRA;
              END;
          END IF;
--------------- ROTINA PARA RATEAR O VALOR RECEBIDO NOS ITENS DA FATURA----------------------
          BEGIN
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                            (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                             / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX)
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO17 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
--------- ROTINA PARA RATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA ---------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_C_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                         T_VL_PGTO_CORRETO_C_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                         ((REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO
                         / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX_PAGAMENTO_CORRETO)
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO17 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
-----------  ROTINA PARA RATEAR OS JUROS NOS ITENS DA FATURA  --------------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS  := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                             ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS
                             / T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_JUROS)
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
---------- ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_GRAVA_VARIACAO_CAMBIAL =  'S' THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_VCR =
                            (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR)
                             / T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_VCR)
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE               = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                  END;
                END IF;
              END IF;
                EXIT;
            END IF;
            UPDATE ITEM_FATURA
               SET ITF_VL_REC_MOEDA_CORRENTE =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                       / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_PAGAMENTO_CORRETO =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO )
                       / T_FAT_VL_MOEDA_CORRENTE)
                  ,ITF_VL_JURR =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                       / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_VCR =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                        / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
             WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                   ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                   ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                   ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                   ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO18 AO ATUALIZAR O ITEM FATURA');
              END IF;
              IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                 T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                       ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                       / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                       ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO
                       / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_JUROS := T_SOMA_ITEM_JUROS +
                       ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS
                       / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_FATURA_VCR:= T_SOMA_ITEM_FATURA_VCR +
                       ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                       / T_FAT_VL_MOEDA_CORRENTE);
              ELSE
                 T_SOMA_ITEM_FATURA    := 0;
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                 T_SOMA_ITEM_JUROS     := 0;
                 T_SOMA_ITEM_FATURA_VCR:= 0;
              END IF;
          END;
                V_MSG:='BAIXA EFETUADA COM SUCESSO';
        ELSIF (V_FAT_VL_PAGO < T_VL_PGTO_CORRETO_C_ATRASO) AND
              (V_FAT_VL_PAGO >= T_FAT_VL_MOEDA_CORRENTE) OR
               T_RECEBE_FATURA = 'S' THEN
          IF T_FAT_TP_SITUACAO = 'FP'   THEN
            IF C_ITFAT%NOTFOUND THEN
               NULL;
            ELSE
              IF (( T_FIXO > 100 ) AND
                 (( T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO ) > 100 )) OR
                 (( T_FIXO < 100 )) THEN
                BEGIN
                  INSERT
                      INTO ACERTO_PARCIAL
                          (ACP_ITF_NR_FATURA_FK
                          ,ACP_ITF_CD_TARIFA_FK
                          ,ACP_ITF_CD_ADMINISTRADORA_FK
                          ,ACP_ITF_SG_UNIDADE_FK
                          ,ACP_DT_ENTRADA
                          ,ACP_HH_ENTRADA
                          ,ACP_VL_ACERTO_MO_CORRENTE
                          ,ACP_VL_ACERTO_MO_ESTRANGEIRA
                          ,ACP_TT_HISTORICO
                          ,ACP_DT_FIM_CORRECAO
                          ,ACP_DT_INICIO_CORRECAO
                          ,ACP_TAR_CD_TARIFA_FK
                          ,ACP_NR_FATURA_ITF_DV
                          ,ACP_IN_ORIGEM_RECEBIMENTO
                          ,ACP_VL_VCR
                           )
                     VALUES
                          (REG_ITFAT.ITF_FAT_NR_FATURA_FK
                          ,REG_ITFAT.ITF_CD_TARIFA
                          ,REG_ITFAT.ITF_CD_ADMINISTRADORA
                          ,REG_ITFAT.ITF_SG_UNIDADE
                          ,TO_DATE(SYSDATE,'DD/MM/YYYY')
                          ,TO_CHAR(SYSDATE,'HH24MI')
                          ,(((T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO) *
                              REG_ITFAT.ITF_VL_MOEDA_CORRENTE) / T_FAT_VL_MOEDA_CORRENTE)
                          ,((((T_VL_PGTO_CORRETO_C_ATRASO - V_FAT_VL_PAGO) *
                               REG_ITFAT.ITF_VL_MOEDA_CORRENTE) /
                               T_FAT_VL_MOEDA_CORRENTE)/T_VALOR_DOLAR_PGTO)
                          ,'ENCARGOS EMI-'||TO_CHAR(T_FAT_DT_EMISSAO,'DD/MM/YYYY')
                                 ||'PG.'||TO_CHAR(V_FAT_DT_PAGAMENTO,'DD/MM/YYYY')
                          ,NULL
                          ,NULL
                          ,DECODE(REG_ITFAT.ITF_CD_TARIFA,'10','12'
                                                         ,'12','12'
                                                         ,'14','15'
                                                         ,'15','15'
                                                         ,'20','22'
                                                         ,'22','22'
                                                         ,'24','25'
                                                         ,'25','25'
                                                         ,'30','32'
                                                         ,'32','32'
                                                         ,'34','35'
                                                         ,'35','35'
                                                         ,'40','42'
                                                         ,'42','42'
                                                         ,'44','45'
                                                         ,'45','45'
                                                         ,'50','52'
                                                         ,'52','52'
                                                         ,'54','55'
                                                         ,'55','55')
                          ,T_FAT_NR_FATURA_DV
                          ,'R'
                          ,(T_VL_VCR_RATEIO / T_VL_VCR_CORRETO) * T_ACP_VL_VCR
                          );
                EXCEPTION
                   WHEN DUP_VAL_ON_INDEX THEN
                      RAISE_APPLICATION_ERROR
                      (-20101,'ERRO9 ACERTO PARCIAL -> REGISTRO JA EXISTE');
                END;
                T_PAGAMENTO_CORRETO :=  T_VL_PGTO_CORRETO_C_ATRASO;
                GRAVA_LOG_ACERTO_PARCIAL;
              END IF;
            END IF;
          END IF;
        END IF;
                V_MSG:='BAIXA EFETUADA COM SUCESSO';
      ELSIF (V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO) > T_FIXO  THEN
          IF C_ITFAT%ROWCOUNT = 1 THEN
            BEGIN
              UPDATE FATURA
                 SET FAT_DT_PAGAMENTO               =  V_FAT_DT_PAGAMENTO
                    ,FAT_DT_LANCAMENTO              =  V_FAT_DT_LANCAMENTO
                    ,FAT_AGE_CD_AGENTE_RECEBEDOR_FK =  V_FAT_AGE_CD_AGENTE_REC_FK
                    ,FAT_VL_REC_MOEDA_CORRENTE      =  V_FAT_VL_REC_MOEDA
                    ,FAT_VL_PAGAMENTO_CORRETO       =  T_VL_PGTO_CORRETO_C_ATRASO
                    ,FAT_VL_REC_MOEDA_ESTRANGEIRA   =  T_FAT_VL_MOEDA_ESTRANGEIRA
                    ,FAT_TP_SITUACAO                =  T_FAT_TP_SITUACAO_ALTERADA
                    ,FAT_TP_BANCO_TESOURARIA        =  T_AGE_TP_BANCO_TESOURARIA
                    ,FAT_VL_VCR                     =  T_FAT_VL_VCR
                    ,FAT_VL_JURR                    =  T_VALOR_RECEBIDO_JUROS
                    ,FAT_TP_PAGAMENTO               =  V_FAT_TP_PAGAMENTO
               WHERE FAT_NR_FATURA  =  T_FAT_NR_FATURA;
                IF SQL%ROWCOUNT=0 THEN
                   RAISE_APPLICATION_ERROR
                   (-20101,'ERRO10 AO ATUALIZAR A FATURA');
                END IF;
                V_FAT_TP_SITUACAO     := T_FAT_TP_SITUACAO_ALTERADA;
                AX_PGTO_CORRETO       := T_VL_PGTO_CORRETO_C_ATRASO;
                AX_VL_REC_CORRENTE    := V_FAT_VL_REC_MOEDA;
                AX_VL_REC_ESTRANGEIRA := T_FAT_VL_MOEDA_ESTRANGEIRA;
            END;
          END IF;
          BEGIN
----------------- ROTINA PARA RATEAR O VALOR RECEBIDO NOS ITENS DA FATURA  --------------
            IF C_ITFAT%NOTFOUND THEN
              IF T_SOMA_ITEM_FATURA <> V_FAT_VL_REC_MOEDA THEN
                 T_SOMA_AUX:= V_FAT_VL_REC_MOEDA - T_SOMA_ITEM_FATURA;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_REC_MOEDA_CORRENTE =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                          / T_FAT_VL_MOEDA_CORRENTE ) + T_SOMA_AUX
                        ,ITF_VL_REC_MOEDA_ESTRANGEIRA = REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO20 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
------- ROTINA PARA RATEAR O PAGAMENTO CORRETO NOS ITENS DA FATURA --------
              IF T_SOMA_ITEM_PAGAMENTO_CORRETO <> T_VL_PGTO_CORRETO_C_ATRASO THEN
                 T_SOMA_AUX_PAGAMENTO_CORRETO:=
                      T_VL_PGTO_CORRETO_C_ATRASO - T_SOMA_ITEM_PAGAMENTO_CORRETO;
                BEGIN
                  UPDATE ITEM_FATURA
                     SET ITF_VL_PAGAMENTO_CORRETO =
                         (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO
                         / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX_PAGAMENTO_CORRETO)
                   WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                         ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                         ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                         ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                         ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO20 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                END;
              END IF;
----------------  ROTINA PARA RATEAR OS JUROS NOS ITENS DA FATURA  --------------
              IF T_GRAVA_JUROS = 'S' THEN
                IF T_SOMA_ITEM_JUROS <> T_VALOR_RECEBIDO_JUROS THEN
                   T_SOMA_AUX_JUROS := T_VALOR_RECEBIDO_JUROS - T_SOMA_ITEM_JUROS;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_JURR =
                          (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS )
                           / T_FAT_VL_MOEDA_CORRENTE) + T_SOMA_AUX_JUROS
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE         = REG_ITFAT.ITF_SG_UNIDADE;
                      IF SQL%ROWCOUNT=0 THEN
                         RAISE_APPLICATION_ERROR
                         (-20101,'ERRO14 AO ATUALIZAR O ITEM FATURA');
                      END IF;
                  END;
                END IF;
              END IF;
-------- ROTINA PARA RATEAR A VARIAÇÃO CAMBIAL NOS ITENS DA FATURA  ------------------------
              IF T_GRAVA_VARIACAO_CAMBIAL =  'S' THEN
                IF T_SOMA_ITEM_FATURA_VCR <> T_FAT_VL_VCR THEN
                   T_SOMA_AUX_VCR := T_FAT_VL_VCR - T_SOMA_ITEM_FATURA_VCR;
                  BEGIN
                    UPDATE ITEM_FATURA
                       SET ITF_VL_VCR =
                            (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR)
                             / T_FAT_VL_MOEDA_CORRENTE) + (T_SOMA_AUX_VCR)
                     WHERE ITF_FAT_NR_FATURA_FK   = T_FAT_NR_FATURA                 AND
                           ITF_FAT_NR_FATURA_FK   = V_NR_FATURA                     AND
                           ITF_CD_TARIFA          = REG_ITFAT.ITF_CD_TARIFA         AND
                           ITF_CD_ADMINISTRADORA  = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                           ITF_SG_UNIDADE               = REG_ITFAT.ITF_SG_UNIDADE;
                    IF SQL%ROWCOUNT=0 THEN
                       RAISE_APPLICATION_ERROR
                       (-20101,'ERRO8 AO ATUALIZAR O ITEM FATURA');
                    END IF;
                  END;
                END IF;
              END IF;
                EXIT;
            END IF;
            UPDATE ITEM_FATURA
               SET ITF_VL_REC_MOEDA_CORRENTE =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA )
                        / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_PAGAMENTO_CORRETO =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO )
                        / T_FAT_VL_MOEDA_CORRENTE)
                  ,ITF_VL_JURR =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VALOR_RECEBIDO_JUROS )
                        / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_VCR =
                       (( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR )
                        / T_FAT_VL_MOEDA_CORRENTE )
                  ,ITF_VL_REC_MOEDA_ESTRANGEIRA=REG_ITFAT.ITF_VL_MOEDA_ESTRANGEIRA
             WHERE ITF_FAT_NR_FATURA_FK  = T_FAT_NR_FATURA                 AND
                   ITF_FAT_NR_FATURA_FK  = V_NR_FATURA                     AND
                   ITF_CD_TARIFA         = REG_ITFAT.ITF_CD_TARIFA         AND
                   ITF_CD_ADMINISTRADORA = REG_ITFAT.ITF_CD_ADMINISTRADORA AND
                   ITF_SG_UNIDADE        = REG_ITFAT.ITF_SG_UNIDADE;
              IF SQL%ROWCOUNT=0 THEN
                 RAISE_APPLICATION_ERROR
                 (-20101,'ERRO22 AO ATUALIZAR O ITEM FATURA');
              END IF;
              IF T_FAT_VL_MOEDA_CORRENTE > 0 THEN
                 T_SOMA_ITEM_FATURA:= T_SOMA_ITEM_FATURA +
                        ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * V_FAT_VL_REC_MOEDA
                        / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= T_SOMA_ITEM_PAGAMENTO_CORRETO +
                        ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_VL_PGTO_CORRETO_C_ATRASO
                        / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_JUROS := T_SOMA_ITEM_JUROS +
                        ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE *  T_VALOR_RECEBIDO_JUROS
                        / T_FAT_VL_MOEDA_CORRENTE);
                 T_SOMA_ITEM_FATURA_VCR:= T_SOMA_ITEM_FATURA_VCR +
                       ( REG_ITFAT.ITF_VL_MOEDA_CORRENTE * T_FAT_VL_VCR
                       / T_FAT_VL_MOEDA_CORRENTE);
              ELSE
                 T_SOMA_ITEM_FATURA     := 0;
                 T_SOMA_ITEM_PAGAMENTO_CORRETO:= 0;
                 T_SOMA_ITEM_JUROS      := 0;
                 T_SOMA_ITEM_FATURA_VCR := 0;
              END IF;
          END;
  -------------INSERIR PAGAMENTO_A_MAIOR QUANDO VALOR PAGO > VALOR CORRETO  ----
          IF ( V_FAT_VL_PAGO > T_VL_PGTO_CORRETO_C_ATRASO ) THEN
            IF C_ITFAT%ROWCOUNT = 1 THEN
              BEGIN
                INSERT INTO PAGAMENTO_A_MAIOR
                          ( PAG_ID
                           ,PAG_FAT_NR_FATURA_FK
                           ,PAG_DT_EMISSAO
                           ,PAG_DT_LANCAMENTO
                           ,PAG_DT_PAGAMENTO
                           ,PAG_DT_DEVOLUCAO
                           ,PAG_VL_CORRETO
                           ,PAG_VL_CREDITO
                           ,PAG_VL_PAGO
                           ,PAG_TT_COMENTARIO
                           )
                      VALUES
                          ( PAG_SEQ.NEXTVAL
                           ,T_FAT_NR_FATURA
                           ,T_FAT_DT_EMISSAO
                           ,V_FAT_DT_LANCAMENTO
                           ,V_FAT_DT_PAGAMENTO
                           ,NULL
                           ,T_VL_PGTO_CORRETO_C_ATRASO
                           ,V_FAT_VL_PAGO - T_VL_PGTO_CORRETO_C_ATRASO
                           ,V_FAT_VL_PAGO
                           ,'FAT.INT C/ATRASO-RECEBIMENTO A MAIOR VIA ON-LINE'
                          );
              EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO10 PAGAMENTO A MAIOR -> REGISTRO JA EXISTE');
                WHEN OTHERS THEN
                     RAISE_APPLICATION_ERROR
                   (-20101,'ERRO11 NãO PREVISTO AO INSERIR PAGAMENTO A MAIOR');
              END;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
               V_MSG:='BAIXA EFETUADA COM SUCESSO';
---------------  FIM DE T_FAT_TP_SITUACAO = 'FP'---------------------------
     EXIT WHEN C_ITFAT%NOTFOUND;
   END LOOP;
              IF V_MSG = 'BAIXA EFETUADA COM SUCESSO' THEN
                INSERT
                 INTO LOG_FATURA
                    ( LFA_ID
                     ,LFA_NR_FATURA
                     ,LFA_NR_FATURA_DV
                     ,LFA_CD_AGENTE_RECEBEDOR
                     ,LFA_CD_CIA_AEREA
                     ,LFA_MT_AERONAVE
                     ,LFA_DT_EMISSAO
                     ,LFA_DT_VENCIMENTO
                     ,LFA_DT_PAGAMENTO
                     ,LFA_DT_LANCAMENTO
                     ,LFA_TP_GRUPO
                     ,LFA_VL_MOEDA_CORRENTE
                     ,LFA_VL_MOEDA_ESTRANGEIRA
                     ,LFA_VL_REC_MOEDA_CORRENTE
                     ,LFA_VL_REC_MOEDA_ESTRANGEIRA
                     ,LFA_TP_SITUACAO
                     ,LFA_TP_NATUREZA_VOO
                     ,LFA_TP_BANCO_TESOURARIA
                     ,LFA_DT_PERIODO_REFERENCIA
                     ,LFA_CD_USUARIO
                     ,LFA_DT_MANUTENCAO
                     ,LFA_TP_MANUTENCAO
                     ,LFA_DS_COMENTARIO
                     ,LFA_VL_PAGAMENTO_CORRETO
                     ,LFA_TP_PAGAMENTO
                     )
                VALUES
                    ( LFA_SEQ.NEXTVAL
                     ,T_FAT_NR_FATURA
                     ,T_FAT_NR_FATURA_DV
                     ,V_FAT_AGE_CD_AGENTE_REC_FK
                     ,T_FAT_CIA_CD_CIA_AEREA_FK
                     ,T_FAT_ARN_MT_AERONAVE_FK
                     ,T_FAT_DT_EMISSAO
                     ,T_FAT_DT_VENCIMENTO
                     ,V_FAT_DT_PAGAMENTO
                     ,V_FAT_DT_LANCAMENTO
                     ,T_FAT_TP_GRUPO
                     ,T_FAT_VL_MOEDA_CORRENTE
                     ,T_FAT_VL_MOEDA_ESTRANGEIRA
                     ,AX_VL_REC_CORRENTE
                     ,AX_VL_REC_ESTRANGEIRA
                     ,T_FAT_TP_SITUACAO_ALTERADA
                     ,T_FAT_TP_NATUREZA_VOO
                     ,T_AGE_TP_BANCO_TESOURARIA
                     ,T_FAT_DT_PERIODO_REFERENCIA
                     ,USER
                     ,SYSDATE
                     ,'U'
                     ,V_LFA_DS_COMENTARIO
                     ,AX_PGTO_CORRETO
                     ,V_FAT_TP_PAGAMENTO
                    );
                COMMIT;
              ELSE
                ROLLBACK;
              END IF;
            CLOSE  C_ITFAT;
          ELSE
              RAISE_APPLICATION_ERROR
             (-20101,'O CAMPO VL.RECEBIDO DA FATURA JÁ CONTÉM VALORES');
          END IF;
        ELSE
            RAISE_APPLICATION_ERROR
           (-20101,'O CAMPO DT. LANÇAMENTO DA FATURA JÁ CONTÉM UMA DATA');
        END IF;
      ELSE
          RAISE_APPLICATION_ERROR
        (-20101,'O CAMPO DT. PAGAMENTO DA FATURA JÁ COMTÉM UMA DATA');
      END IF;
    END IF;
  END IF;
END;
/

-- End of DDL script for SUCOTAP_RECEBE_FAT_ON_LINE
