CREATE OR REPLACE 
PROCEDURE trata_doc_cobranca_sem_sp (P_SEQ_COBRANCA IN NUMBER) IS
----------------------------------------------------------------------
-- Procedure que migra os documentos de cobran�a previamente        --
-- inseridos na rotina de lan�amento de faturas para o SSContratos  --
--(integra��o com smart stream) para fluxo de caixa e posterior     --
-- vincula��o �s SP�s que ser�o migrados na procedure               --
-- trata_doc_cobranca_com_sp                                        --
--                                                                  --
-- Criada 	        em 02/04/2004                                    --
--                                                                  --
-- AUTOR : Eduardo Lima - Grupo IOS                                 --
--                                                                  --
----------------------------------------------------------------------
  -- VARI�VEIS PARA UTILIZA��O NO CONTRATO EXPRESSO

  V_REGIONAL          VARCHAR2(2)   := NULL;
  V_REG_ENT_OPER      VARCHAR2(2)   := NULL;
  V_VERSAO            VARCHAR2(2)   := '00'; -- FIXO
  V_TIPO_CONTRATO     VARCHAR2(2)   := NULL;
  V_ENT_OPERACIONAL   VARCHAR2(3)   := NULL;
  V_EXISTE_CONTRATO   NUMBER        := 0;
  V_CENTRO_CUSTO      VARCHAR2(7)   := '201456'; --FIXO
  V_DESCRICAO_MED     VARCHAR2(200) := 'SERVI�OS M�DICOS E HOSPITALARES PRESTADOS AOS EMPREGADOS E/OU SEUS DEPENDENTES';
  V_DESCRICAO_ODO     VARCHAR2(200) := 'SERVI�OS ODONTOL�GICOS PRESTADOS AOS EMPREGADOS E/OU SEUS DEPENDENTES';
  V_DESC_BENEFICIO    VARCHAR2(200) := NULL;
  V_PRAZO             NUMBER(2);
  V_CNPJ_CPF          VARCHAR2(12);
  V_LOCALIZACAO       VARCHAR2(3)   := ' ';
  V_SEQUENCIA         VARCHAR2(3);
  V_CERTIFICADOR      VARCHAR2(10);
  V_AUTORIZADOR       VARCHAR2(10);
  V_VLR_TOT_CONTRATO  NUMBER(5,2) := 0.01;
  V_ERRO              VARCHAR2(500) := NULL;

  -- VARI�VEIS PARA O DETALHE DO CONTRATO EXPRESSO

  V_SEQUENCIAL        NUMBER(4)    := 0;
  V_CODIGO_MED        VARCHAR2(11) := '03110300430';
  V_CODIGO_ODO        VARCHAR2(11) := '03110300650';
  V_QTDE              NUMBER(1)    := 1;
  V_DESCRICAO         VARCHAR2(3); -- SE FOR MED, RECEBER 'MED'. SE FOR ODO, RECEBER 'ODO'
  V_VALOR_LINHA       NUMBER(5,2)  := 0.01;

  -- VARI�VEIS PARA SOLICITA��O DE PAGAMENTO

  V_RESUMO            VARCHAR2(3) := '001';
  V_PARCELA           VARCHAR2(3) := '001';
  V_NUM_PARCELA       VARCHAR2(4) := NULL;
  V_VLR_SECUNDARIO    NUMBER(5,2) := 0;
  V_VLR_RETENCAO      NUMBER(15,2);

  -- VARI�VEIS PARA RATEIO SP

  V_LINHA_RATEIO       NUMBER(4);
  V_ENT_RATEIO         VARCHAR2(5)  := 'INFRA';
  V_CONTA_EXCEDENTE    VARCHAR2(11);
  V_CONTA_PDIN         VARCHAR2(11);
  V_PROGRAMA           VARCHAR2(3) := '001';
  V_VLR_RATEIO         NUMBER(12,2);
  V_DOCUMENTO_COBRANCA NUMBER;
  V_CREDENCIADO        NUMBER;
  V_DEPENDENCIA        NUMBER(4);
  V_BENEFICIO          VARCHAR2(3);

BEGIN
  BEGIN
    FOR REG IN (SELECT TDC.TDC_SEQ_COBRANCA          SEQ_COBRANCA,
                       TDC.TDC_DEP_CODIGO            DEPENDENCIA,
                       TDC.TDC_BEN_SIGLA             SIGLA,
                       DECODE(TDC.TDC_BEN_SIGLA,'MED','AM','ODO','AO') TIPO_CONTRATO,
                       CC.CC_ANO                     ANO,
                       TDC.TDC_DEP_CODIGO            ENT_OPERACIONAL,
                       CC.CC_DT_PROPOSTA             DT_PROPOSTA,
                       CC.CC_DT_ORDEM_SERVICO        DT_INICIO,
                       CRE.CRE_CGC_CPF               CNPJ_CPF,
                       CRE.CRE_TIPO_PESSOA           TIPO_PESSOA,
                       TDC.TDC_CONTRATO              CONTRATO,
                       CRE.CRE_DEP_RESP_INCL         DEP_ENT_OPER,
                       TDC.TDC_SEQ_BANCARIA          SEQ_BANCARIA,
                       TDC.TDC_VLR_DOC_FISCAL        VL_DOC_FISCAL,
                       TDC.TDC_NR_DOC_FISCAL         NR_DOC_FISCAL,
                       TDC.TDC_DT_EMISS_DOC_FISCAL   DT_EMISSAO_DOC_FISCAL,
                       TDC.TDC_DT_PAGAMENTO          DATA_PAGAMENTO,
                       TDC.TDC_DT_CADASTRO           DATA_CADASTRO,
                       TDC.TDC_RESP_REGISTRO         RESP_REGISTRO
                FROM   TAB_DOC_COBRANCA       TDC,
                       CREDENCIADOS           CRE,
                       CREDENCIADOS_CONTRATOS CC
                WHERE  CRE.CRE_SEQUENCIAL  = CC.CC_CBE_CRE_SEQUENCIAL
                AND    CRE.CRE_SEQUENCIAL  = TDC.TDC_CRE_SEQUENCIAL
                AND    CC.CC_CBE_BEN_SIGLA = TDC.TDC_BEN_SIGLA
                AND    CC.CC_DEP_CODIGO    = TDC.TDC_DEP_CODIGO
                AND    SUBSTR(TDC.TDC_CONTRATO,1,2) = 'TC'
                AND   (TDC.TDC_SEQ_COBRANCA   = P_SEQ_COBRANCA OR (P_SEQ_COBRANCA IS NULL AND TDC.TDC_DT_ENVIO IS NULL))
                AND    CC.CC_VIGENCIA      = (SELECT MAX(CC2.CC_VIGENCIA)
                   		  	                      FROM   CREDENCIADOS_CONTRATOS CC2
                   			                        WHERE  CC2.CC_CBE_BEN_SIGLA      = TDC.TDC_BEN_SIGLA
                   			                        AND    CC2.CC_DEP_CODIGO         = TDC.TDC_DEP_CODIGO
                   			                        AND    CC2.CC_CBE_CRE_SEQUENCIAL = TDC.TDC_CRE_SEQUENCIAL))
    LOOP
       -- VERIFICAR SE J� EXISTE O CONTRATO MIGRADO.
       -- CASO N�O EXISTA, MIGRAR AS TABELAS PRINCIPAIS:
       --   - IDENTIFICA��O DO CONTRATO
       --   - OBJETO DO CONTRATO
       --   - CONTRATADA/PARTICIPE DO CONTRATO
       --   - ITEM RESUMO

       -- CASO EXISTA, MIGRAR AS TABELAS:
       --   - CRONOGRAMA

       -- BUSCAR A ENTIDADE OPERACIONAL QUE SER� A DEPEND�NCIA DO AUTORIZADOR/CERTIFICADOR

       V_EXISTE_CONTRATO := 0;
       -- BUSCAR A REGIONAL PARA FORMAR A ENTIDADE DO CONTRATO (PAYABLE_ENTITY_ID)
       BEGIN
         SELECT DECODE(DEP.DEP_TIPO,1,1,2,DEP.DEP_CODIGO,DEP.DEP_DEP_CODIGO)
         INTO   V_REGIONAL
         FROM   DEPENDENCIAS DEP
         WHERE  DEP.DEP_CODIGO = REG.DEP_ENT_OPER
         AND    DEP.DEP_DATA_EXTINCAO IS NULL;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           DBMS_OUTPUT.PUT_LINE('REGIONAL N�O LOCALIZADA: '||V_ENT_OPERACIONAL);
       END;

       -- BUSCAR A REGIONAL PARA FORMAR A ENTIDADE OPERACIONAL
       BEGIN
         SELECT DECODE(DEP.DEP_TIPO,1,1,2,DEP.DEP_CODIGO,DEP.DEP_DEP_CODIGO)
         INTO   V_REG_ENT_OPER
         FROM   DEPENDENCIAS DEP
         WHERE  DEP.DEP_CODIGO = REG.ENT_OPERACIONAL
         AND    DEP.DEP_DATA_EXTINCAO IS NULL;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           DBMS_OUTPUT.PUT_LINE('REGIONAL DA ENTIDADE OPERACIONAL N�O LOCALIZADA: '||V_ENT_OPERACIONAL);
       END;

       BEGIN
         SELECT COUNT(1)
         INTO   V_EXISTE_CONTRATO
         FROM   CONF_IDENTIFICACAO_U
         WHERE  CONTRACT_ID         = REG.CONTRATO
         AND    CONTRACT_VERSAO     = '00';
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
            V_EXISTE_CONTRATO := 0;
       END;

       -- TRATAMENTO DO CNPJ/CPF DO CREDENCIADO
       BEGIN
         IF REG.TIPO_PESSOA = 1 THEN -- PESSOA F�SICA
            V_CNPJ_CPF    := LPAD(REG.CNPJ_CPF,9,'0');
            V_LOCALIZACAO := ' ';
         ELSIF REG.TIPO_PESSOA = 2 THEN -- PESSOA JUR�DICA
            V_CNPJ_CPF    := LPAD(REG.CNPJ_CPF,12,'0');
            V_LOCALIZACAO := SUBSTR(V_CNPJ_CPF,10,3);
            V_CNPJ_CPF    := SUBSTR(V_CNPJ_CPF,1,9);
         END IF;
       END;

       V_SEQUENCIAL  := 0;
       -- TRATAMENTO DO TIPO DE AQUISIC�O
       BEGIN
         NULL;
       END;
       V_DESC_BENEFICIO := NULL;
       -- DESCRI��O DO DETALHE
       IF REG.TIPO_CONTRATO = 'AM' THEN
          V_DESCRICAO := 'MED';
          V_DESC_BENEFICIO := V_DESCRICAO_MED;
       ELSIF REG.TIPO_CONTRATO = 'AO' THEN
          V_DESCRICAO := 'ODO';
          V_DESC_BENEFICIO := V_DESCRICAO_ODO;
       END IF;
       -- TIPO DE VALOR
       BEGIN
         NULL;
       END;

       -- SE O CONTRATO N�O EXISTIR
       IF V_EXISTE_CONTRATO = 0 THEN
          -- IDENTIFICA��O DO CONTRATO (HEADER)
          BEGIN
            INSERT INTO CONF_IDENTIFICACAO_U
                       (PAYABLE_ENTITY_ID,
                        CONTRACT_ID,
                        CONTRACT_VERSAO,
                        CONTRACT_DESC,
                        CONTRACT_STATUS_CODE,
                        CONTRACT_PREV_STATUS_CODE,
                        CONTRACT_TYPE,
                        CONTRACT_SUB_TYPE,
                        CONTRACT_ID_VENDOR,
                        CODIGO_MOD_CONTRATACAO,
                        MANAGER_ID,
                        SECURITY_CODE,
                        SISTEMA_ORIGEM_CODE,
                        CONTRACT_VERSAO_ORIGEM,
                        DATE_CREATED,
                        USER_ID_CREATED,
                        DATE_CHANGED,
                        USER_ID_CHANGED,
                        INACTIVE_IND,
                        ACTIVE_DATE,
                        CHGSTAMP,
                        INCISO,
                        FUNDAMENTO_LEGAL,
                        REGULARIDADE_FISCAL)
            VALUES     (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                        REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                        '00',                                                    -- VERS�O
                        V_DESC_BENEFICIO,                                        -- DESCRI��O DO CONTRATO
                        'IC',                                                    -- STATUS DO CONTRATO
                        'IC',                                                    -- STATUS ANTERIOR DO CONTRATO
                        REG.TIPO_CONTRATO,                                       -- TIPO DO CONTRATO
                        '0001',                                                  -- SUB-TIPO DO CONTRATO
                        REG.CONTRATO,                                            -- REFERENCIA DO CONTRATO
                        'INEX',                                                  -- MODALIDADE DE CONTRATA��O
                        V_CENTRO_CUSTO,                                          -- ID DE REFERENCIA
                        ' ',                                                     -- C�DIDO DE SEGURAN�A (BRANCO)
                        '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                        '00',                                                    -- C�DIGO DO CONTRATO NA ORIGEM
                        REG.DATA_CADASTRO,                                       -- DATA DE CRIA��O DO REGISTRO
                        REG.RESP_REGISTRO,                                       -- RESPONS�VEL PELA CRIA��O DO REGISTRO
                        '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                        ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                        '0',                                                     -- FLAG DE INATIVA��O
                        '01/01/1900',                                            -- DATA DE INATIVA��O
                        0,                                                       -- CONTROLE DE VERS�O DO REGISTRO
                        0,                                                       -- INCISO
                        'ART. 25 DO RCLI',                                       -- FUNDAMENTO LEGAL
                        'CR'                                                     -- REGULARIDADE FISCAL
                        );
         EXCEPTION
           WHEN OTHERS THEN
              V_ERRO := 'ERRO NA MIGRA��O DA IDENTIFICA��O DO CONTRATO: '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
              UPDATE TAB_DOC_COBRANCA
              SET    TDC_OBSERVACAO = V_ERRO
              WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
              V_ERRO := NULL;
         END;

         -- OBJETO DO CONTRATO

         BEGIN
           INSERT INTO CONF_OBJETO_U
                      (PAYABLE_ENTITY_ID,
                       CONTRACT_ID,
                       CONTRACT_VERSAO,
                       OBJETO_DESC,
                       SISTEMA_ORIGEM_CODE,
                       CONTRACT_VERSAO_ORIGEM,
                       DATE_CREATED,
                       USER_ID_CREATED,
                       DATE_CHANGED,
                       USER_ID_CHANGED,
                       INACTIVE_IND,
                       ACTIVE_DATE,
                       CHGSTAMP)
           VALUES     (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                       REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                       '00',                                                    -- VERS�O
                       V_DESC_BENEFICIO,                                        -- DESCRI��O DO CONTRATO
                       '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                       '00',                                                    -- C�DIGO DO CONTRATO NA ORIGEM
                       REG.DATA_CADASTRO,                                       -- DATA DE CRIA��O DO REGISTRO
                       REG.RESP_REGISTRO,                                       -- RESPONS�VEL PELA CRIA��O DO REGISTRO
                       '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                       ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                       '0',                                                     -- FLAG DE INATIVA��O
                       '01/01/1900',                                            -- DATA DE INATIVA��O
                       0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                       );
         EXCEPTION
           WHEN OTHERS THEN
              V_ERRO := 'ERRO NA MIGRA��O DO OBJETO DO CONTRATO: '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
              UPDATE TAB_DOC_COBRANCA
              SET    TDC_OBSERVACAO = V_ERRO
              WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
              V_ERRO := NULL;
         END;

         -- CONTRATADA/PARTICIPE DO CONTRATO

         BEGIN
           INSERT INTO CONF_PARTICIPANTES_U
                      (PAYABLE_ENTITY_ID,
                       CONTRACT_ID,
                       CONTRACT_VERSAO,
                       VENDOR_ID,
                       VENDOR_LOC_CODE,
                       ADDR_FMT,
                       ADDR_LINE_1,
                       STREET_OR_POST_OFFICE_BOX_1,
                       STREET_OR_POST_OFFICE_BOX_2,
                       CITY_NAME,
                       COUNTRY_SUB_ENTITY_CODE,
                       POSTAL_CODE,
                       COUNTRY_CODE,
                       COM_DDD,
                       COM_TEL,
                       COM_FAX,
                       COM_EMAIL,
                       COD_RELACAO_CONTRATO,
                       TYPE_OF_PMT,
                       SEQ_NBR,
                       SISTEMA_ORIGEM_CODE,
                       CONTRACT_VERSAO_ORIGEM,
                       DATE_CREATED,
                       USER_ID_CREATED,
                       DATE_CHANGED,
                       USER_ID_CHANGED,
                       INACTIVE_IND,
                       ACTIVE_DATE,
                       CHGSTAMP)
           VALUES     (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                       REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                       '00',                                                    -- VERS�O
                       V_CNPJ_CPF,                                              -- CPF/CNPJ DO CONTRATADO
                       NVL(V_LOCALIZACAO,' '),                                  -- LOCALIZA��O DO CONTRATADO
                       'GN3',                                                   -- C�DIGO DO ENDERE�O
                       ' ',                                                     -- LINHA DO ENDERE�O
                       ' ',                                                     --
                       ' ',                                                     --
                       ' ',                                                     -- CIDADE
                       ' ',                                                     -- ENTIDADE DO PA�S
                       ' ',                                                     -- CEP
                       ' ',                                                     -- C�DIGO DO PA�S
                       ' ',                                                     -- DDD
                       ' ',                                                     -- TELEFONE
                       ' ',                                                     -- FAX
                       ' ',                                                     -- E-MAIL
                       '01',                                                    -- C�DIGO RELA��O DO CONTRATO
                       'BT',                                                    -- TIPO DE PAGAMENTO
                       REG.SEQ_BANCARIA,                                        -- SEQUENCIAL BANC�RIO
                       '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                       '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                       REG.DATA_CADASTRO,                                       -- DATA DE CRIA��O DO REGISTRO
                       REG.RESP_REGISTRO,                                       -- RESPONS�VEL PELA CRIA��O DO REGISTRO
                       '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                       ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                       '0',                                                     -- FLAG DE INATIVA��O
                       '01/01/1900',                                            -- DATA DE INATIVA��O
                       0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                       );
         EXCEPTION
           WHEN OTHERS THEN
             V_ERRO := 'ERRO NA MIGRA��O DA CONTRATADA/PARTICIPE DO CONTRATO: '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
             UPDATE TAB_DOC_COBRANCA
             SET    TDC_OBSERVACAO = V_ERRO
             WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
             V_ERRO := NULL;
         END;

         -- ITEM RESUMO

         BEGIN
           INSERT INTO CONF_ITEM_RESUMO_U
                      (PAYABLE_ENTITY_ID,
                       CONTRACT_ID,
                       CONTRACT_VERSAO,
                       SEQ_ITEM,
                       CODIGO_RESUMO_VALOR,
                       TIPO_VALOR,
                       CURR_CODE,
                       CURR_CODE_SECDY,
                       IND_CURR_CODE_CONTROLE,
                       PRIM_AMT,
                       SECDY_AMT,
                       DATA_ULTIMO_REAJUSTE,
                       DATA_PROX_REAJUSTE,
                       USER_FLD_3,
                       USER_FLD_4,
                       USER_DATE_2,
                       USER_AMT_1,
                       SISTEMA_ORIGEM_CODE,
                       CONTRACT_VERSAO_ORIGEM,
                       DATE_CREATED,
                       USER_ID_CREATED,
                       DATE_CHANGED,
                       USER_ID_CHANGED,
                       INACTIVE_IND,
                       ACTIVE_DATE,
                       CHGSTAMP)
           VALUES     (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                       REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                       '00',                                                    -- VERS�O
                       '0001',                                                  -- SEQUENCIAL DO ITEM
                       '001',                                                   -- C�DIGO DO RESUMO
                       'L',                                                     -- TIPO DE VALOR (LIVRE)
                       'R$',                                                    -- S�MBOLO MOEDA PRINCIPAL
                       ' ',                                                     -- S�MBOLO MOEDA SECUND�RIA
                       '1',                                                     -- �NDICE DE CONTROLE
                       REG.VL_DOC_FISCAL,                                      -- VALOR PRINCIPAL (REAL)
                       0,                                                       -- VALOR SECUND�RIO (OUTRA MOEDA)
                       '01/01/1900',                                            -- DATA �LTIMO REAJUSTE
                       '01/01/1900',                                            -- DATA PR�XIMO REAJUSTE
                       ' ',                                                     --
                       ' ',                                                     --
                       '01/01/1900',                                            --
                       0,                                                       --
                       '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                       '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                       REG.DATA_CADASTRO,                                       -- DATA DE CRIA��O DO REGISTRO
                       REG.RESP_REGISTRO,                                       -- RESPONS�VEL PELA CRIA��O DO REGISTRO
                       '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                       ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                       '0',                                                     -- FLAG DE INATIVA��O
                       '01/01/1900',                                            -- DATA DE INATIVA��O
                       0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                       );
         EXCEPTION
           WHEN OTHERS THEN
             V_ERRO := 'ERRO NA MIGRA��O DO ITEM DO RESUMO: '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
             UPDATE TAB_DOC_COBRANCA
             SET    TDC_OBSERVACAO = V_ERRO
             WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
             V_ERRO := NULL;
         END;

         -- CRONOGRAMA

         BEGIN
            INSERT INTO CONF_ITEM_CRONOGRAMA_U (PAYABLE_ENTITY_ID,
                                                CONTRACT_ID,
                                                CONTRACT_VERSAO,
                                                SEQ_ITEM,
                                                CODIGO_RESUMO_VALOR,
                                                TIPO_CRONOGRAMA,
                                                NUMERO_PARCELA,
                                                VENDOR_ID,
                                                VENDOR_LOC_CODE,
                                                TIPO_VALOR,
                                                DATA_VENCTO,
                                                PRIM_AMT,
                                                SECDY_AMT,
                                                CODIGO_RECURSO,
                                                VENDOR_ID_REC,
                                                VENDOR_LOC_CODE_REC,
                                                SISTEMA_ORIGEM_CODE,
                                                CONTRACT_VERSAO_ORIGEM,
                                                PMT_METH_ID,
                                                PAYABLE_ENTITY_ID_OPER,
                                                DATE_CREATED,
                                                USER_ID_CREATED,
                                                DATE_CHANGED,
                                                USER_ID_CHANGED,
                                                INACTIVE_IND,
                                                ACTIVE_DATE,
                                                CHGSTAMP)
            VALUES (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                    REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                    '00',                                                    -- VERS�O
                    '0001',                                                  -- SEQUENCIAL DO ITEM
                    '001',                                                   -- C�DIGO DO RESUMO
                    'D',                                                     -- TIPO DE CRONOGRAMA
                    '0001',                                                  -- N�MERO DA PARCELA
                    V_CNPJ_CPF,                                              -- CPF/CNPJ DO CONTRATADO
                    NVL(V_LOCALIZACAO,' '),                                  -- LOCALIZA��O DO CONTRATADO
                    'L',                                                     -- TIPO DO VALOR
                    REG.DATA_PAGAMENTO,                                      -- DATA DE PAGAMENTO
                    REG.VL_DOC_FISCAL,                                       -- VALOR PRINCIPAL (REAL)
                    0,                                                       -- VALOR SECUND�RIO (OUTRA MOEDA)
                    'CC',                                                    -- C�DIGO DO RECURSO
                    ' ',                                                     -- C�DIGO FORNCEDOR REC
                    ' ',                                                     -- LOCALIZA��O FORNCEDOR REC
                    '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                    '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                    LPAD(REG.ENT_OPERACIONAL,3,'0')||'CC',                       -- M�TODO DE PAGAMENTO
                    LPAD(V_REG_ENT_OPER,2,'0')||LPAD(REG.ENT_OPERACIONAL,3,'0'), -- ENTIDADE DE PAGAMENTO
                    '01/01/1900',                                            -- DATA DE CRIA��O DO REGISTRO (BRANCO)
                    ' ',                                                     -- USU�RIO QUE CRIOU O REGISTRO (BRANCO)
                    '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                    ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                    '0',                                                     -- FLAG DE INATIVA��O
                    '01/01/1900',                                            -- DATA DE INATIVA��O
                    0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                    );

         EXCEPTION
           WHEN OTHERS THEN
             V_ERRO := 'ERRO NA MIGRA��O DO ITEM DO CRONOGRAMA '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
             UPDATE TAB_DOC_COBRANCA
             SET    TDC_OBSERVACAO = V_ERRO
             WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
             V_ERRO := NULL;
         END;

        IF REG.TIPO_CONTRATO = 'AO' THEN
                     -- INSERIR ATIVOS
            BEGIN
              INSERT INTO CONF_ITEM_IDENT_U(PAYABLE_ENTITY_ID,
                                            CONTRACT_ID,
                                            CONTRACT_VERSAO,
                                            SEQ_ITEM,
                                            TIPO_AQUISICAO,
                                            QTY,
                                            UNIT_OF_MEASURE,
                                            ITEM_ID,
                                            ITEM_DESCP,
                                            SISTEMA_ORIGEM_CODE,
                                            CONTRACT_VERSAO_ORIGEM,
                                            DATE_CREATED,
                                            USER_ID_CREATED,
                                            DATE_CHANGED,
                                            USER_ID_CHANGED,
                                            INACTIVE_IND,
                                            ACTIVE_DATE,
                                            CHGSTAMP)
             VALUES (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                     REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                     '00',                                                    -- VERS�O
                     '0001',                                                  -- SEQUENCIAL DO ITEM
                     'AD',                                                    -- TIPO DE AQUISI��O
                     1,                                                       -- QUANTIDADE
                     'UNID',                                                  -- UNIDADE DE MEDIDA
                     V_CODIGO_ODO,                                            -- C�DIGO DO ITEM
                     'PRODONTO',                                              -- DESCRICAO DO ITEM
                     '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                     '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                     REG.DATA_CADASTRO,                                       -- DATA DE CRIACAO DO REGISTRO
                     REG.RESP_REGISTRO,                                       -- USUARIO QUE CRIOU O REGISTRO
                     '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                     ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                     '0',                                                     -- FLAG DE INATIVA��O
                     '01/01/1900',                                            -- DATA DE INATIVA��O
                     0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                     );
           EXCEPTION
             WHEN OTHERS THEN
               DBMS_OUTPUT.PUT_LINE('ERRO AO INSERIR ITEM DO CONTRATO - ATIVO(AO): '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM);
           END;

           BEGIN
             INSERT INTO CONF_ITEM_REQUISITADOS_U (PAYABLE_ENTITY_ID,
                                                 CONTRACT_ID,
                                                 CONTRACT_VERSAO,
                                                 SITE_ID,
                                                 REQ_ID,
                                                 REQ_LINE_NBR,
                                                 TIPO_AQUISICAO,
                                                 ITEM_ID_GOV,
                                                 ITEM_ID,
                                                 ITEM_DESCP,
                                                 QTY,
                                                 UNIT_OF_MEASURE,
                                                 VL_ITEM,
                                                 ISSUE_SITE_ID,
                                                 ISSUE_STOCKROOM_ID,
                                                 SEQ_ITEM,
                                                 SISTEMA_ORIGEM_CODE,
                                                 CONTRACT_VERSAO_ORIGEM,
                                                 DATE_CREATED,
                                                 USER_ID_CREATED,
                                                 DATE_CHANGED,
                                                 USER_ID_CHANGED,
                                                 INACTIVE_IND,
                                                 ACTIVE_DATE,
                                                 CHGSTAMP)
             VALUES (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                     REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                     '00',                                                    -- VERS�O
                     'INF',                                                   --
                     'PROVISORIO',                                            -- ID REQUISICAO
                     1,                                                       -- N�MERO LINHA REQUISICAO
                     'AD',                                                    -- TIPO AQUISICAO
                     'GYYYY311030065',                                        -- C�D. ITEM GOVERNO
                     V_CODIGO_ODO,                                            -- C�DIGO DO ITEM
                     'PRODONTO',                                              -- DESCRICAO DO ITEM
                     1,                                                       -- QUANTIDADE
                     'UNID',                                                  -- UNIDADE DE MEDIDA
                     REG.VL_DOC_FISCAL,                                       -- VALOR PRINCIPAL (REAL)
                     ' ',                                                     -- BRANCO
                     ' ',                                                     -- BRANCO
                     '0001',                                                  -- SEQUENCIAL DO ITEM
                     '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                     '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                     REG.DATA_CADASTRO,                                       -- DATA DE CRIACAO DO REGISTRO
                     REG.RESP_REGISTRO,                                       -- USUARIO QUE CRIOU O REGISTRO
                     '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                     ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                     '0',                                                     -- FLAG DE INATIVA��O
                     '01/01/1900',                                            -- DATA DE INATIVA��O
                     0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                     );
           EXCEPTION
             WHEN OTHERS THEN
               DBMS_OUTPUT.PUT_LINE('ERRO AO INSERIR ITEM REQUISICAO - ATIVO(AO): '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM);
           END;

        END IF;

       ELSE -- OU SEJA, J� EXISTE O CONTRATO MIGRADO

         -- PEGAR O MAIOR N�MERO DE PARCELA DO CONTRATO
         BEGIN
           SELECT LPAD(NVL(MAX(NUMERO_PARCELA),0)+1,4,'0')
           INTO   V_NUM_PARCELA
           FROM   CONF_ITEM_CRONOGRAMA_U
           WHERE  CONTRACT_ID         = REG.CONTRATO
           AND    CONTRACT_VERSAO     = '00';
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
             V_NUM_PARCELA := '0001';
         END;

         -- CRONOGRAMA

         BEGIN
            INSERT INTO CONF_ITEM_CRONOGRAMA_U (PAYABLE_ENTITY_ID,
                                                CONTRACT_ID,
                                                CONTRACT_VERSAO,
                                                SEQ_ITEM,
                                                CODIGO_RESUMO_VALOR,
                                                TIPO_CRONOGRAMA,
                                                NUMERO_PARCELA,
                                                VENDOR_ID,
                                                VENDOR_LOC_CODE,
                                                TIPO_VALOR,
                                                DATA_VENCTO,
                                                PRIM_AMT,
                                                SECDY_AMT,
                                                CODIGO_RECURSO,
                                                VENDOR_ID_REC,
                                                VENDOR_LOC_CODE_REC,
                                                SISTEMA_ORIGEM_CODE,
                                                CONTRACT_VERSAO_ORIGEM,
                                                PMT_METH_ID,
                                                PAYABLE_ENTITY_ID_OPER,
                                                DATE_CREATED,
                                                USER_ID_CREATED,
                                                DATE_CHANGED,
                                                USER_ID_CHANGED,
                                                INACTIVE_IND,
                                                ACTIVE_DATE,
                                                CHGSTAMP)
            VALUES (LPAD(V_REGIONAL,2,'0')||LPAD(REG.DEP_ENT_OPER,3,'0'), -- ENTIDADE DE PAGAMENTO
                    REG.CONTRATO,                                            -- N�MERO DO CONTRATO
                    '00',                                                    -- VERS�O
                    '0001',                                                  -- SEQUENCIAL DO ITEM
                    '001',                                                   -- C�DIGO DO RESUMO
                    'D',                                                     -- TIPO DE CRONOGRAMA
                    V_NUM_PARCELA,                                           -- N�MERO DA PARCELA
                    V_CNPJ_CPF,                                              -- CPF/CNPJ DO CONTRATADO
                    NVL(V_LOCALIZACAO,' '),                                  -- LOCALIZA��O DO CONTRATADO
                    'L',                                                     -- TIPO DO VALOR
                    REG.DATA_PAGAMENTO,                                      -- DATA DE PAGAMENTO
                    REG.VL_DOC_FISCAL,                                       -- VALOR PRINCIPAL (REAL)
                    0,                                                       -- VALOR SECUND�RIO (OUTRA MOEDA)
                    'CC',                                                    -- C�DIGO DO RECURSO
                    ' ',                                                     -- C�DIGO FORNCEDOR REC
                    ' ',                                                     -- LOCALIZA��O FORNCEDOR REC
                    '03',                                                    -- C�DIGO DO SISTEMA DE ORIGEM
                    '00',                                                    -- VERS�O DO CONTRATO DE ORIGEM
                    LPAD(REG.ENT_OPERACIONAL,3,'0')||'CC',                       -- M�TODO DE PAGAMENTO
                    LPAD(V_REG_ENT_OPER,2,'0')||LPAD(REG.ENT_OPERACIONAL,3,'0'), -- ENTIDADE DE PAGAMENTO
                    '01/01/1900',                                            -- DATA DE CRIA��O DO REGISTRO (BRANCO)
                    ' ',                                                     -- USU�RIO QUE CRIOU O REGISTRO (BRANCO)
                    '01/01/1900',                                            -- DATA DE ALTERA��O (BRANCO)
                    ' ',                                                     -- USU�RIO QUE ALTEROU O REGISTRO (BRANCO)
                    '0',                                                     -- FLAG DE INATIVA��O
                    '01/01/1900',                                            -- DATA DE INATIVA��O
                    0                                                        -- CONTROLE DE VERS�O DO REGISTRO
                    );

         EXCEPTION
           WHEN OTHERS THEN
             V_ERRO := 'ERRO NA MIGRA��O DO ITEM DO CRONOGRAMA '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM;
             UPDATE TAB_DOC_COBRANCA
             SET    TDC_OBSERVACAO = V_ERRO
             WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
             V_ERRO := NULL;
             DBMS_OUTPUT.PUT_LINE('ERRO NA MIGRA��O DO ITEM DO CRONOGRAMA '||REG.CONTRATO||' - '||TO_CHAR(SQLCODE)||' - '||SQLERRM);
         END;

       END IF;
       UPDATE TAB_DOC_COBRANCA
       SET    TDC_DT_ENVIO = SYSDATE
       WHERE  TDC_SEQ_COBRANCA = REG.SEQ_COBRANCA;
       COMMIT;
   END LOOP;
  END;
END;
/

-- Grants for Procedure
GRANT EXECUTE ON trata_doc_cobranca_sem_sp TO rh_perfil_99
/


-- End of DDL Script for Procedure IFRSRH2.TRATA_DOC_COBRANCA_SEM_SP

