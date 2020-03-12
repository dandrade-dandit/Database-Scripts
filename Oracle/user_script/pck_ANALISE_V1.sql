CREATE OR REPLACE
PACKAGE BODY                   ifrsicof.pck_analise IS
  ------------------------------------------------------
  -- RATEIO AUTOMÁTICO (CHAMADA POR PRC_COPIA_VERSAO) --
  ------------------------------------------------------
  PROCEDURE PRC_RATEIO_AUTOMATICO
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_COD_VERSAO_ORIGEM           in       varchar2,
              p_COD_DEPENDENCIA_ELABORACAO  in       number,
              p_NR_ITEM                     in       number,
              p_COD_VERSAO_DESTINO          in       varchar2,
              p_SEQ_ANO_ORCAMENTO           in       number,
              p_VAL_TOTAL_SOLICITANTE       in  out  number,
              p_VAL_TOTAL_PROGRAMACAO       in  out  number,
              p_IND_RETORNO                 in  out  boolean,
              p_DSC_RETORNO                 in  out  varchar2
             )
  IS
    v_VAL_JANEIRO       number(10);
    v_VAL_FEVEREIRO     number(10);
    v_VAL_MARCO         number(10);
    v_VAL_ABRIL         number(10);
    v_VAL_MAIO          number(10);
    v_VAL_JUNHO         number(10);
    v_VAL_JULHO         number(10);
    v_VAL_AGOSTO        number(10);
    v_VAL_SETEMBRO      number(10);
    v_VAL_OUTUBRO       number(10);
    v_VAL_NOVEMBRO      number(10);
    v_VAL_DEZEMBRO      number(10);
    v_RAZ_CENTRO_CUSTO  number(10,6);
    v_VAL_MES_CORRENTE  number(10);
    v_VAL_LANCAMENTO    number(10);
    v_VAL_LANCADO_MES   number(10);
    -------------------------
    -- CONSULTA - PASSO 01 --
    -------------------------
    cursor q_ISP_ORIGEM
            (
             p_NUM_ANO                     number,
             p_COD_NIVEL                   varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA  number,
             p_COD_VERSAO_ORIGEM           varchar2,
             p_COD_DEPENDENCIA_ELABORACAO  number,
             p_NUM_ITEM                    number
            )
      is
      select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
             isp.COD_DEPENDENCIA_SOLICITANTE,
             isp.NUM_CONTA_SOLICITANTE,
             isp.COD_PROJETO,
             isp.FLG_DIMENSIONAMENTO,
             isp.VAL_TOTAL_SOLICITANTE,
             psp.VAL_JANEIRO,
             psp.VAL_FEVEREIRO,
             psp.VAL_MARCO,
             psp.VAL_ABRIL,
             psp.VAL_MAIO,
             psp.VAL_JUNHO,
             psp.VAL_JULHO,
             psp.VAL_AGOSTO,
             psp.VAL_SETEMBRO,
             psp.VAL_OUTUBRO,
             psp.VAL_NOVEMBRO,
             psp.VAL_DEZEMBRO
        from ITEM_SOLICITANTE_PROPOSTA   isp,
             PROGRAMACAO_SOLIC_PROPOSTA  psp
        where isp.VSP_NR_ANO = p_NUM_ANO
              and
              isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
              and
              isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
              and
              isp.VSP_CD_VERSAO = p_COD_VERSAO_ORIGEM
              and
              isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
              and
              isp.NR_ITEM = p_NUM_ITEM
              and
              psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = isp.SEQ_ITEM_SOLICITANTE_PROPOSTA;
    -------------------------
    -- CONSULTA - PASSO 04 --
    -------------------------
    cursor q_RRE
            (
             p_SEQ_ANO_ORCAMENTO            number,
             p_COD_DEPENDENCIA_SOLICITANTE  number,
             p_NUM_CONTA_SOLICITANTE        varchar2
            )
      is
      select rre.SEQ_RATEIO_REALIZADO,
             rre.VAL_REALIZADO
      from CAD_RATEIO_REALIZADO  RRE
      where rre.SEQ_ANO_ORCAMENTO = p_SEQ_ANO_ORCAMENTO
            and
            rre.COD_DEPENDENCIA = p_COD_DEPENDENCIA_SOLICITANTE
            and
            rre.NUM_CONTA_CONTABIL = p_NUM_CONTA_SOLICITANTE;
    r_RRE  q_RRE%rowtype;
    l_RRE  boolean;
    -------------------------
    -- CONSULTA - PASSO 05 --
    -------------------------
    cursor q_RRD
            (
             p_SEQ_RATEIO_REALIZADO  number
            )
      is
      select rre.COD_CENTRO_CUSTO,
             rre.VAL_REALIZADO
      from CAD_RATEIO_REALIZADO_DETALHE  rre
      where rre.SEQ_RATEIO_REALIZADO = p_SEQ_RATEIO_REALIZADO;
    r_RRD  q_RRD%rowtype;
    l_RRD  boolean;
    -------------------------
    -- CONSULTA - PASSO 07 --
    -------------------------
    cursor q_ISP_DESTINO
            (
             p_NUM_ANO                         number,
             p_COD_NIVEL                       varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA      number,
             p_COD_VERSAO                      varchar2,
             p_COD_DEPENDENCIA_ELABORACAO      number,
             p_NUM_ITEM                        number,
             p_COD_DEPENDENCIA_SOLICITANTE     number,
             p_NUM_CONTA__SOLICITANTE          varchar2,
             p_COD_PROJETO                     varchar2,
             p_COD_CENTRO_CUSTO_SOLICITANTE    number
            )
      is
      select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
        from ITEM_SOLICITANTE_PROPOSTA   isp
        where isp.VSP_NR_ANO = p_NUM_ANO
              and
              isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
              and
              isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
              and
              isp.VSP_CD_VERSAO = p_COD_VERSAO
              and
              isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
              and
              isp.NR_ITEM = p_NUM_ITEM
              and
              isp.COD_DEPENDENCIA_SOLICITANTE = p_COD_DEPENDENCIA_SOLICITANTE
              and
              isp.NUM_CONTA_SOLICITANTE = p_NUM_CONTA__SOLICITANTE
              and
              (
               isp.COD_PROJETO is null
               or
               isp.COD_PROJETO = p_COD_PROJETO
              )
              and
              isp.COD_CENTRO_CUSTO_SOLICITANTE   = p_COD_CENTRO_CUSTO_SOLICITANTE;
    r_ISP_DESTINO  q_ISP_DESTINO%rowtype;
    l_ISP_DESTINO  boolean;
    -------------------------
    -- CONSULTA - PASSO 11 --
    -------------------------
    cursor q_ISP_SEQ_CURR
      is
      select SEQ_ITEM_SOLICITANTE_PROPOSTA.currval  SEQ_ITEM_SOLICITANTE_PROPOSTA
        from DUAL;
    r_ISP_SEQ_CURR  q_ISP_SEQ_CURR%rowtype;
    -------------------------
    -- CONSULTA - PASSO 16 --
    -------------------------
    cursor q_PSP_DESTINO
            (
             p_SEQ_ITEM_SOLICITANTE  number
            )
      is
      select psp.SEQ_PROGRAMACAO_SOLIC_PROPOSTA
        from PROGRAMACAO_SOLIC_PROPOSTA  psp
        where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ITEM_SOLICITANTE;
    r_PSP_DESTINO  q_PSP_DESTINO%rowtype;
    l_PSP_DESTINO  boolean;
  ------------------------
  -- INICIO DE PROCESSO --
  ------------------------
  BEGIN
    p_VAL_TOTAL_SOLICITANTE  := 0;
    p_VAL_TOTAL_PROGRAMACAO  := 0;
    -----------------------------------------------------------
    -- PASSO 01 - ITEM SOLICITANTE(S) + PROGRAMAÇÃO - ORIGEM --
    -----------------------------------------------------------
    for f_ISP_ORIGEM in q_ISP_ORIGEM
                         (
                          p_NUM_ANO,
                          p_COD_NIVEL,
                          p_COD_DEPENDENCIA_AGRUPADORA,
                          p_COD_VERSAO_ORIGEM,
                          p_COD_DEPENDENCIA_ELABORACAO,
                          p_NR_ITEM
                         )
    LOOP
      ------------------------------
      -- PASSO 02 - MES DE 1 A 12 --
      ------------------------------
      for f_MES in 1..12
      LOOP
        --------------------------------------------------
        -- PASSO 03 - DEFINIÇÃO - VALOR DO MES CORRENTE --
        --------------------------------------------------
        IF    f_MES =  1 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_JANEIRO;
        ELSIF f_MES =  2 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_FEVEREIRO;
        ELSIF f_MES =  3 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_MARCO;
        ELSIF f_MES =  4 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_ABRIL;
        ELSIF f_MES =  5 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_MAIO;
        ELSIF f_MES =  6 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_JUNHO;
        ELSIF f_MES =  7 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_JULHO;
        ELSIF f_MES =  8 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_AGOSTO;
        ELSIF f_MES =  9 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_SETEMBRO;
        ELSIF f_MES = 10 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_OUTUBRO;
        ELSIF f_MES = 11 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_NOVEMBRO;
        ELSIF f_MES = 12 THEN v_VAL_MES_CORRENTE := f_isp_origem.VAL_DEZEMBRO;
        END IF;
        v_VAL_LANCADO_MES := 0;
        ----------------------------------------------------------------------------
        -- PASSO 04 - AQUISIÇÃO DE DADOS - RATEIO REALIZADO (DEPENDÊNCIA E CONTA) --
        ----------------------------------------------------------------------------
        open q_RRE
              (
               p_SEQ_ANO_ORCAMENTO,
               f_isp_origem.COD_DEPENDENCIA_SOLICITANTE,
               f_isp_origem.NUM_CONTA_SOLICITANTE
              );
        fetch q_RRE into r_RRE;
        l_RRE := q_RRE%found;
        close q_RRE;
        ----------------------------------------------------------
        -- PASSO XX - CASO - ORÇAMENTO REALIZADO NÃO ENCONTRADO --
        ----------------------------------------------------------
        IF l_RRE = FALSE
        THEN
           p_IND_RETORNO := FALSE;
           p_DSC_RETORNO := 'ORÇAMENTO REALIZADO NÃO ENCONTRADO';
           EXIT;
        END IF;
        ------------------------------------------------------------------
        -- PASSO 05 - LOOP - RATEIO REALIZADO DETALHE (CENTRO DE CUSTO) --
        ------------------------------------------------------------------
        for f_RRD in q_RRD
                      (
                       r_RRE.SEQ_RATEIO_REALIZADO
                      )
        LOOP
          r_RRD := f_RRD;
          ------------------------
          -- PASSO 06 - CALCULO --
          ------------------------
          v_RAZ_CENTRO_CUSTO := f_RRD.VAL_REALIZADO / r_RRE.VAL_REALIZADO;
          v_VAL_LANCAMENTO := floor(v_VAL_MES_CORRENTE * (f_RRD.VAL_REALIZADO / r_RRE.VAL_REALIZADO));
          v_VAL_LANCADO_MES := v_VAL_LANCADO_MES + v_VAL_LANCAMENTO;
          ----------------------------------------------------------------
          -- PASSO 07 - LOCALIZAÇÃO - ITEM SOLICITANTE(S) - DESTINO - I --
          ----------------------------------------------------------------
          open q_ISP_DESTINO
                (
                 p_NUM_ANO,
                 p_COD_NIVEL,
                 p_COD_DEPENDENCIA_AGRUPADORA,
                 p_COD_VERSAO_DESTINO,
                 p_COD_DEPENDENCIA_ELABORACAO,
                 p_NR_ITEM,
                 f_isp_origem.COD_DEPENDENCIA_SOLICITANTE,
                 f_isp_origem.NUM_CONTA_SOLICITANTE,
                 f_isp_origem.COD_PROJETO,
                 r_rrd.COD_CENTRO_CUSTO
                );
          fetch q_ISP_DESTINO into r_ISP_DESTINO;
          l_ISP_DESTINO := q_ISP_DESTINO%found;
          close q_ISP_DESTINO;
          ------------------------------------------------------
          -- PASSO 08.NÄO EXISTE - ITEM SOLICITANTE - DESTINO --
          ------------------------------------------------------
          IF not l_ISP_DESTINO
          THEN
            -------------------------------------------------------------------------------
            -- PASSO 09 - NÄO EXISTE - ITEM SOLICITANTE DESTINO - INSERT (DEFINIR VALOR) --
            -------------------------------------------------------------------------------
            BEGIN
              insert
                into ITEM_SOLICITANTE_PROPOSTA
                 (
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  VSP_NR_ANO,
                  VSP_CD_NIVEL_VERSAO,
                  COD_DEPENDENCIA_AGRUPADORA,
                  VSP_CD_VERSAO,
                  COD_DEPENDENCIA_ELABORACAO,
                  NR_ITEM,
                  COD_DEPENDENCIA_SOLICITANTE,
                  NUM_CONTA_SOLICITANTE,
                  COD_PROJETO,
                  FLG_DIMENSIONAMENTO,
                  COD_CENTRO_CUSTO_SOLICITANTE,
                  VAL_TOTAL_SOLICITANTE
                 )
                values
                 (
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
                  p_NUM_ANO,
                  p_COD_NIVEL,
                  p_COD_DEPENDENCIA_AGRUPADORA,
                  p_COD_VERSAO_DESTINO,
                  p_COD_DEPENDENCIA_ELABORACAO,
                  p_NR_ITEM,
                  f_isp_origem.COD_DEPENDENCIA_SOLICITANTE,
                  f_isp_origem.NUM_CONTA_SOLICITANTE,
                  f_isp_origem.COD_PROJETO,
                  f_isp_origem.FLG_DIMENSIONAMENTO,
                  f_rrd.COD_CENTRO_CUSTO,
                  v_VAL_LANCAMENTO
                 );
              p_VAL_TOTAL_SOLICITANTE := p_VAL_TOTAL_SOLICITANTE + v_VAL_LANCAMENTO;
            EXCEPTION
              WHEN OTHERS
              THEN
                ------------------------------
                -- PASSO 10 - ERRO - INSERT --
                ------------------------------
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Passo 10 - INSERT ISP '||chr(10)||
                                 'Ano: '||p_NUM_ANO||chr(10)||
                                 'Nível: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                                 'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Item: '||p_NR_ITEM||chr(10)||
                                 sqlerrm;
              GOTO FIM;
            END;
            -----------------------------------------------------------------------
            -- PASSO 11 - SEQUENCIAL DE INSERÇÃO - ITEM SOLICITANTE(S) - DESTINO --
            -----------------------------------------------------------------------
            open q_ISP_SEQ_CURR;
            fetch q_ISP_SEQ_CURR into r_ISP_SEQ_CURR;
            close q_ISP_SEQ_CURR;
            r_isp_destino.SEQ_ITEM_SOLICITANTE_PROPOSTA := r_isp_seq_curr.SEQ_ITEM_SOLICITANTE_PROPOSTA;
          -----------------------------------------------------
          -- PASSO 08.EXISTE - ITEM SOLICITANTE(S) - DESTINO --
          -----------------------------------------------------
          ELSE
            ------------------------------------------------------------------------
            -- PASSO 12 - EXISTE - SOLICITANTE DESTINO - UPDATE (ADICIONAR VALOR) --
            ------------------------------------------------------------------------
            BEGIN
              update ITEM_SOLICITANTE_PROPOSTA
                set VAL_TOTAL_SOLICITANTE = VAL_TOTAL_SOLICITANTE + v_VAL_LANCAMENTO
                where VSP_NR_ANO = p_NUM_ANO
                      and
                      VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
                      and
                      COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
                      and
                      VSP_CD_VERSAO = p_COD_VERSAO_DESTINO
                      and
                      COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
                      and
                      NR_ITEM = p_NR_ITEM
                      and
                      COD_DEPENDENCIA_SOLICITANTE = f_isp_origem.COD_DEPENDENCIA_SOLICITANTE
                      and
                      NUM_CONTA_SOLICITANTE = f_isp_origem.NUM_CONTA_SOLICITANTE
                      and
                      (
                       f_isp_origem.COD_PROJETO is null
                       or
                       COD_PROJETO = f_isp_origem.COD_PROJETO
                      )
                      and
                      COD_CENTRO_CUSTO_SOLICITANTE = r_rrd.COD_CENTRO_CUSTO;
              p_VAL_TOTAL_SOLICITANTE := p_VAL_TOTAL_SOLICITANTE + v_VAL_LANCAMENTO;
            EXCEPTION
              WHEN OTHERS
              THEN
                ------------------------------
                -- PASSO 13 - ERRO - UPDATE --
                ------------------------------
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'PASSO 13 - UPDATE ISP'||chr(10)||
                                 'Ano: '||p_NUM_ANO||chr(10)||
                                 'Nível: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                                 'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Item: '||p_NR_ITEM||chr(10)||
                                 sqlerrm;
                GOTO FIM;
            END;
          END IF;
          ------------------------------
          -- PASSO 14 - RESET - MESES --
          ------------------------------
          v_VAL_JANEIRO   := 0;
          v_VAL_FEVEREIRO := 0;
          v_VAL_MARCO     := 0;
          v_VAL_ABRIL     := 0;
          v_VAL_MAIO      := 0;
          v_VAL_JUNHO     := 0;
          v_VAL_JULHO     := 0;
          v_VAL_AGOSTO    := 0;
          v_VAL_SETEMBRO  := 0;
          v_VAL_OUTUBRO   := 0;
          v_VAL_NOVEMBRO  := 0;
          v_VAL_DEZEMBRO  := 0;
          --------------------------------------------------------------------------
          -- PASSO 15 - DEFINIÇÃO - MESES - 1 DO CORRENTE E RESTANTE COM 0(ZERO)  --
          --------------------------------------------------------------------------
          IF    f_MES =  1 THEN v_VAL_JANEIRO   := v_VAL_LANCAMENTO;
          ELSIF f_MES =  2 THEN v_VAL_FEVEREIRO := v_VAL_LANCAMENTO;
          ELSIF f_MES =  3 THEN v_VAL_MARCO     := v_VAL_LANCAMENTO;
          ELSIF f_MES =  4 THEN v_VAL_ABRIL     := v_VAL_LANCAMENTO;
          ELSIF f_MES =  5 THEN v_VAL_MAIO      := v_VAL_LANCAMENTO;
          ELSIF f_MES =  6 THEN v_VAL_JUNHO     := v_VAL_LANCAMENTO;
          ELSIF f_MES =  7 THEN v_VAL_JULHO     := v_VAL_LANCAMENTO;
          ELSIF f_MES =  8 THEN v_VAL_AGOSTO    := v_VAL_LANCAMENTO;
          ELSIF f_MES =  9 THEN v_VAL_SETEMBRO  := v_VAL_LANCAMENTO;
          ELSIF f_MES = 10 THEN v_VAL_OUTUBRO   := v_VAL_LANCAMENTO;
          ELSIF f_MES = 11 THEN v_VAL_NOVEMBRO  := v_VAL_LANCAMENTO;
          ELSIF f_MES = 12 THEN v_VAL_DEZEMBRO  := v_VAL_LANCAMENTO;
          END IF;
          ----------------------------------------------------
          -- PASSO 16 - LOCALIZAÇÃO - PROGRAMAÇÃO - DESTINO --
          ----------------------------------------------------
          open q_PSP_DESTINO
                (
                 r_isp_destino.SEQ_ITEM_SOLICITANTE_PROPOSTA
                );
          fetch q_PSP_DESTINO into r_PSP_DESTINO;
          l_PSP_DESTINO := q_PSP_DESTINO%found;
          close q_PSP_DESTINO;
          -------------------------------------------------
          -- PASSO 17/NÃO EXISTE - PROGRAMAÇÃO - DESTINO --
          -------------------------------------------------
          IF not l_PSP_DESTINO
          THEN
            -------------------------------------------------------------------------------
            -- PASSO 18 - NÃO EXISTE - PROGRAMAÇÃO DESTINO - INSERT (DEFINIÇÃO DE VALOR) --
            -------------------------------------------------------------------------------
            BEGIN
              insert
                into PROGRAMACAO_SOLIC_PROPOSTA
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  NUM_ANO,
                  VAL_JANEIRO,
                  VAL_FEVEREIRO,
                  VAL_MARCO,
                  VAL_ABRIL,
                  VAL_MAIO,
                  VAL_JUNHO,
                  VAL_JULHO,
                  VAL_AGOSTO,
                  VAL_SETEMBRO,
                  VAL_OUTUBRO,
                  VAL_NOVEMBRO,
                  VAL_DEZEMBRO,
                  VAL_UNITARIO,
                  QTD_JANEIRO,
                  QTD_FEVEREIRO,
                  QTD_MARCO,
                  QTD_ABRIL,
                  QTD_MAIO,
                  QTD_JUNHO,
                  QTD_JULHO,
                  QTD_AGOSTO,
                  QTD_SETEMBRO,
                  QTD_OUTUBRO,
                  QTD_NOVEMBRO,
                  QTD_DEZEMBRO
                 )
                values
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                  r_isp_destino.SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  p_NUM_ANO,
                  v_VAL_JANEIRO,
                  v_VAL_FEVEREIRO,
                  v_VAL_MARCO,
                  v_VAL_ABRIL,
                  v_VAL_MAIO,
                  v_VAL_JUNHO,
                  v_VAL_JULHO,
                  v_VAL_AGOSTO,
                  v_VAL_SETEMBRO,
                  v_VAL_OUTUBRO,
                  v_VAL_NOVEMBRO,
                  v_VAL_DEZEMBRO,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0
                 );
              p_VAL_TOTAL_PROGRAMACAO := p_VAL_TOTAL_PROGRAMACAO + v_VAL_JANEIRO
                                                                 + v_VAL_FEVEREIRO
                                                                 + v_VAL_MARCO
                                                                 + v_VAL_ABRIL
                                                                 + v_VAL_MAIO
                                                                 + v_VAL_JUNHO
                                                                 + v_VAL_JULHO
                                                                 + v_VAL_AGOSTO
                                                                 + v_VAL_SETEMBRO
                                                                 + v_VAL_OUTUBRO
                                                                 + v_VAL_NOVEMBRO
                                                                 + v_VAL_DEZEMBRO;
              select SEQ_PROGRAMACAO_SOLIC_PROPOSTA.currval
                into r_PSP_DESTINO.SEQ_PROGRAMACAO_SOLIC_PROPOSTA
                from DUAL;
            EXCEPTION
              WHEN OTHERS
              THEN
                ------------------------------------
                -- PASSO 19 - ERRO - INSERT - PSP --
                ------------------------------------
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'PASSO 19 - INSERT PSP'||chr(10)||
                                 'Ano: '||p_NUM_ANO||chr(10)||
                                 'Nível: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                                 'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Item: '||p_NR_ITEM||chr(10)||
                                 sqlerrm;
              GOTO FIM;
            END;
          ---------------------------------------------
          -- PASSO 17/EXISTE - PROGRAMAÇÃO - DESTINO --
          ---------------------------------------------
          ELSE
            ------------------------------------------------------------------------
            -- PASSO 20 - EXISTE - PROGRAMAÇÃO DESTINO - UPDATE (ADICÃO DE VALOR) --
            ------------------------------------------------------------------------
            BEGIN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_JANEIRO   = VAL_JANEIRO   + v_VAL_JANEIRO,
                    VAL_FEVEREIRO = VAL_FEVEREIRO + v_VAL_FEVEREIRO,
                    VAL_MARCO     = VAL_MARCO     + v_VAL_MARCO,
                    VAL_ABRIL     = VAL_ABRIL     + v_VAL_ABRIL,
                    VAL_MAIO      = VAL_MAIO      + v_VAL_MAIO,
                    VAL_JUNHO     = VAL_JUNHO     + v_VAL_JUNHO,
                    VAL_JULHO     = VAL_JULHO     + v_VAL_JULHO,
                    VAL_AGOSTO    = VAL_AGOSTO    + v_VAL_AGOSTO,
                    VAL_SETEMBRO  = VAL_SETEMBRO  + v_VAL_SETEMBRO,
                    VAL_OUTUBRO   = VAL_OUTUBRO   + v_VAL_OUTUBRO,
                    VAL_NOVEMBRO  = VAL_NOVEMBRO  + v_VAL_NOVEMBRO,
                    VAL_DEZEMBRO  = VAL_DEZEMBRO  + v_VAL_DEZEMBRO
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
              p_VAL_TOTAL_PROGRAMACAO := p_VAL_TOTAL_PROGRAMACAO + v_VAL_JANEIRO
                                                                 + v_VAL_FEVEREIRO
                                                                 + v_VAL_MARCO
                                                                 + v_VAL_ABRIL
                                                                 + v_VAL_MAIO
                                                                 + v_VAL_JUNHO
                                                                 + v_VAL_JULHO
                                                                 + v_VAL_AGOSTO
                                                                 + v_VAL_SETEMBRO
                                                                 + v_VAL_OUTUBRO
                                                                 + v_VAL_NOVEMBRO
                                                                 + v_VAL_DEZEMBRO;
            EXCEPTION
              WHEN OTHERS
              THEN
                ----------------------------------
                -- PASSO 21 - ERRO - UPDATE PSP --
                ----------------------------------
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'PASSO 21 - UPDATE PSP'||chr(10)||
                                 'Ano: '||p_NUM_ANO||chr(10)||
                                 'Nível: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                                 'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Item: '||p_NR_ITEM||chr(10)||
                                 sqlerrm;
                GOTO FIM;
            END;
          END IF;  -- PASSO 17
        ------------------------------------
        -- PASSO 22 - RETORNO AO PASSO 05 --
        ------------------------------------
        END LOOP f_RRD;
        -------------------------------------
        -- PASSO 23 - VERIFICAÇÃO DE SOBRA --
        -------------------------------------
        IF  v_VAL_LANCADO_MES < v_VAL_MES_CORRENTE
        THEN
          -----------------------------------------------------------------------
          -- PASSO 24 - SOBRA - SOLICITANTE DESTINO - UPDATE (ADICIONAR VALOR) --
          -----------------------------------------------------------------------
          BEGIN
            update ITEM_SOLICITANTE_PROPOSTA
              set VAL_TOTAL_SOLICITANTE = VAL_TOTAL_SOLICITANTE + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
              where VSP_NR_ANO = p_NUM_ANO
                    and
                    VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
                    and
                    COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
                    and
                    VSP_CD_VERSAO = p_COD_VERSAO_DESTINO
                    and
                    COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
                    and
                    NR_ITEM = p_NR_ITEM
                    and
                    COD_DEPENDENCIA_SOLICITANTE = f_isp_origem.COD_DEPENDENCIA_SOLICITANTE
                    and
                    NUM_CONTA_SOLICITANTE = f_isp_origem.NUM_CONTA_SOLICITANTE
                    and
                    (
                     f_isp_origem.COD_PROJETO is null
                     or
                     COD_PROJETO = f_isp_origem.COD_PROJETO
                    )
                    and
                    COD_CENTRO_CUSTO_SOLICITANTE = r_rrd.COD_CENTRO_CUSTO;
              p_VAL_TOTAL_SOLICITANTE := p_VAL_TOTAL_SOLICITANTE + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES );
          EXCEPTION
            WHEN OTHERS
            THEN
              ------------------------------
              -- PASSO 25 - ERRO - UPDATE --
              ------------------------------
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'PASSO 25 - UPDATE ISP'||chr(10)||
                               'Ano: '||p_NUM_ANO||chr(10)||
                               'Nível: '||p_COD_NIVEL||chr(10)||
                               'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                               'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                               'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Item: '||p_NR_ITEM||chr(10)||
                               sqlerrm;
              GOTO FIM;
          END;
          -----------------------------------------------------------------------
          -- PASSO 26 - SOBRA - PROGRAMAÇÃO DESTINO - UPDATE (ADICÃO DE VALOR) --
          -----------------------------------------------------------------------
          BEGIN
            IF    f_MES = 1
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_JANEIRO   = VAL_JANEIRO   + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 2
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_FEVEREIRO = VAL_FEVEREIRO + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 3
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_MARCO     = VAL_MARCO     + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 4
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_ABRIL     = VAL_ABRIL     + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 5
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_MAIO      = VAL_MAIO      + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 6
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_JUNHO     = VAL_JUNHO     + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 7
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_JULHO     = VAL_JULHO     + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 8
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_AGOSTO    = VAL_AGOSTO    + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 9
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_SETEMBRO  = VAL_SETEMBRO  + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 10
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_OUTUBRO   = VAL_OUTUBRO   + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 11
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_NOVEMBRO  = VAL_NOVEMBRO  + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            ELSIF f_MES = 12
            THEN
              update PROGRAMACAO_SOLIC_PROPOSTA
                set VAL_DEZEMBRO  = VAL_DEZEMBRO  + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES )
                where SEQ_PROGRAMACAO_SOLIC_PROPOSTA = r_psp_destino.SEQ_PROGRAMACAO_SOLIC_PROPOSTA;
            END IF;
            p_VAL_TOTAL_PROGRAMACAO := p_VAL_TOTAL_PROGRAMACAO + ( v_VAL_MES_CORRENTE - v_VAL_LANCADO_MES );
          EXCEPTION
            WHEN OTHERS
            THEN
              ----------------------------------
              -- PASSO 27 - ERRO - UPDATE PSP --
              ----------------------------------
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'PASSO 27 - UPDATE PSP'||chr(10)||
                               'Ano: '||p_NUM_ANO||chr(10)||
                               'Nível: '||p_COD_NIVEL||chr(10)||
                               'Dep.Agrupadora: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                               'Versão: '||p_COD_VERSAO_DESTINO||chr(10)||
                               'Dep.Elaboração: '||p_COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Item: '||p_NR_ITEM||chr(10)||
                               sqlerrm;
              GOTO FIM;
          END;
        END IF;
      ------------------------------------
      -- PASSO 28 - RETORNO AO PASSO 02 --
      ------------------------------------
      END LOOP f_MES;
    ------------------------------------
    -- PASSO 29 - RETORNO AO PASSO 01 --
    ------------------------------------
    END LOOP f_ISP_ORIGEM;
    <<FIM>>
    null;
  END PRC_RATEIO_AUTOMATICO;
  --------------------
  -- COPIA VERSÃO 1 --
  --------------------
  PROCEDURE PRC_COPIA_VERSAO
             (
              p_NUM_ANO_O                     in       number,
              p_COD_NIVEL_O                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_O  in       number,
              p_COD_VERSAO_O                  in       varchar2,
              p_NUM_ANO_D                     in       number,
              p_COD_NIVEL_D                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA_D  in       number,
              p_COD_VERSAO_D                  in       varchar2,
              p_IND_RATEIO_AUTOMATICO         in       boolean,
              p_IND_RETORNO                   in  out  boolean,
              p_DSC_RETORNO                   in  out  varchar2
             )
  IS
  v_FLG_LANCAMENTO  ITEM_PROPOSTA_ORC_SIMULADA.FLG_LANCAMENTO%type;
  ----------------------
  -- DESPESA / GESTOR --
  ----------------------
  cursor q_IPS
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2
   )
    is
    select ips.COD_DEPENDENCIA_ELABORACAO,
           ips.NR_ITEM,
           ips.DEP_CD_DEPENDENCIA_GERD,
           ips.CC2_CD_CENTRO_CUSTO_GERD,
           ips.FLG_TIPO_CONTA,
           ips.FLG_LANCAMENTO,
           ips.CC1_NR_CONTA,
           ips.DS_ITEM,
           ips.COD_CATALOGO,
           ips.NR_CONTRATO,
           ips.NO_FORNECEDOR,
           ips.DT_INICIO_CONTRATO,
           ips.DT_TERMINO_CONTRATO,
           ips.IND_CONTRATO,
           ips.PRJ_CD_PROJETO,
           ips.DS_JUSTIFICATIVA,
           ips.CD_PRIORIDADE,
           ips.IN_DIMENSIONAMENTO,
           ips.FLG_PLURIANUAL,
           ips.VAL_TOTAL_GESTOR,
           ips.VAL_JAN,
           ips.VAL_FEV,
           ips.VAL_MAR,
           ips.VAL_ABR,
           ips.VAL_MAI,
           ips.VAL_JUN,
           ips.VAL_JUL,
           ips.VAL_AGO,
           ips.VAL_SET,
           ips.VAL_OUT,
           ips.VAL_NOV,
           ips.VAL_DEZ,
           ips.VAL_JAN1,
           ips.VAL_FEV1,
           ips.VAL_MAR1,
           ips.VAL_ABR1,
           ips.VAL_MAI1,
           ips.VAL_JUN1,
           ips.VAL_JUL1,
           ips.VAL_AGO1,
           ips.VAL_SET1,
           ips.VAL_OUT1,
           ips.VAL_NOV1,
           ips.VAL_DEZ1,
           ips.VAL_JAN2,
           ips.VAL_FEV2,
           ips.VAL_MAR2,
           ips.VAL_ABR2,
           ips.VAL_MAI2,
           ips.VAL_JUN2,
           ips.VAL_JUL2,
           ips.VAL_AGO2,
           ips.VAL_SET2,
           ips.VAL_OUT2,
           ips.VAL_NOV2,
           ips.VAL_DEZ2,
           ips.VAL_JAN3,
           ips.VAL_FEV3,
           ips.VAL_MAR3,
           ips.VAL_ABR3,
           ips.VAL_MAI3,
           ips.VAL_JUN3,
           ips.VAL_JUL3,
           ips.VAL_AGO3,
           ips.VAL_SET3,
           ips.VAL_OUT3,
           ips.VAL_NOV3,
           ips.VAL_DEZ3,
           ips.VAL_JAN4,
           ips.VAL_FEV4,
           ips.VAL_MAR4,
           ips.VAL_ABR4,
           ips.VAL_MAI4,
           ips.VAL_JUN4,
           ips.VAL_JUL4,
           ips.VAL_AGO4,
           ips.VAL_SET4,
           ips.VAL_OUT4,
           ips.VAL_NOV4,
           ips.VAL_DEZ4,
           ips.VL_UNITARIO_ITEM,
           ips.QTD_JAN,
           ips.QTD_FEV,
           ips.QTD_MAR,
           ips.QTD_ABR,
           ips.QTD_MAI,
           ips.QTD_JUN,
           ips.QTD_JUL,
           ips.QTD_AGO,
           ips.QTD_SET,
           ips.QTD_OUT,
           ips.QTD_NOV,
           ips.QTD_DEZ,
           ips.VL_UNITARIO_ITEM1,
           ips.QTD_JAN1,
           ips.QTD_FEV1,
           ips.QTD_MAR1,
           ips.QTD_ABR1,
           ips.QTD_MAI1,
           ips.QTD_JUN1,
           ips.QTD_JUL1,
           ips.QTD_AGO1,
           ips.QTD_SET1,
           ips.QTD_OUT1,
           ips.QTD_NOV1,
           ips.QTD_DEZ1,
           ips.VL_UNITARIO_ITEM2,
           ips.QTD_JAN2,
           ips.QTD_FEV2,
           ips.QTD_MAR2,
           ips.QTD_ABR2,
           ips.QTD_MAI2,
           ips.QTD_JUN2,
           ips.QTD_JUL2,
           ips.QTD_AGO2,
           ips.QTD_SET2,
           ips.QTD_OUT2,
           ips.QTD_NOV2,
           ips.QTD_DEZ2,
           ips.VL_UNITARIO_ITEM3,
           ips.QTD_JAN3,
           ips.QTD_FEV3,
           ips.QTD_MAR3,
           ips.QTD_ABR3,
           ips.QTD_MAI3,
           ips.QTD_JUN3,
           ips.QTD_JUL3,
           ips.QTD_AGO3,
           ips.QTD_SET3,
           ips.QTD_OUT3,
           ips.QTD_NOV3,
           ips.QTD_DEZ3,
           ips.VL_UNITARIO_ITEM4,
           ips.QTD_JAN4,
           ips.QTD_FEV4,
           ips.QTD_MAR4,
           ips.QTD_ABR4,
           ips.QTD_MAI4,
           ips.QTD_JUN4,
           ips.QTD_JUL4,
           ips.QTD_AGO4,
           ips.QTD_SET4,
           ips.QTD_OUT4,
           ips.QTD_NOV4,
           ips.QTD_DEZ4,
           ips.SEQ_CARGA_ANO_ORCAMENTO
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where VSP_NR_ANO = p_NUM_ANO_O
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            VSP_CD_VERSAO = p_COD_VERSAO_O;
  v_VAL_TOTAL_GESTOR  number(14,2);
  ---------------------------
  -- DESPESA / SOLICITANTE --
  ---------------------------
  cursor q_ISP
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2,
           p_COD_DEPENDENCIA_ELABORACAO    number,
           p_NR_ITEM                       number
          )
    is
    select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
           isp.COD_DEPENDENCIA_SOLICITANTE,
           isp.COD_CENTRO_CUSTO_SOLICITANTE,
           isp.NUM_CONTA_SOLICITANTE,
           isp.VAL_TOTAL_SOLICITANTE,
           isp.FLG_DIMENSIONAMENTO,
           isp.COD_PROJETO
      from ITEM_SOLICITANTE_PROPOSTA  isp
      where isp.VSP_NR_ANO = p_NUM_ANO_O
            and
            isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            isp.VSP_CD_VERSAO = p_COD_VERSAO_O
            and
            isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
            and
            isp.NR_ITEM = p_NR_ITEM;
  r_ISP  q_ISP%rowtype;
  v_VAL_TOTAL_SOLICITANTE       number(14,2);
  v_IND_EXISTENCIA_SOLICITANTE  boolean;
  --------------------------------------
  -- DESPESA / SOLICITANTE / SEQUENCE --
  --------------------------------------
  cursor q_ISP_SEQUENCE
    is
    select SEQ_ITEM_SOLICITANTE_PROPOSTA.currval  SEQ_ITEM_SOLICITANTE_PROPOSTA
      from DUAL;
  r_ISP_SEQUENCE  q_ISP_SEQUENCE%rowtype;
  ---------------------------
  -- DESPESA / PROGRAMACAO --
  ---------------------------
  cursor q_PSP
          (
           p_SEQ_ISP  number
          )
    is
    select psp.NUM_ANO,
           psp.VAL_JANEIRO,
           psp.VAL_FEVEREIRO,
           psp.VAL_MARCO,
           psp.VAL_ABRIL,
           psp.VAL_MAIO,
           psp.VAL_JUNHO,
           psp.VAL_JULHO,
           psp.VAL_AGOSTO,
           psp.VAL_SETEMBRO,
           psp.VAL_OUTUBRO,
           psp.VAL_NOVEMBRO,
           psp.VAL_DEZEMBRO,
           psp.VAL_UNITARIO,
           psp.QTD_JANEIRO,
           psp.QTD_FEVEREIRO,
           psp.QTD_MARCO,
           psp.QTD_ABRIL,
           psp.QTD_MAIO,
           psp.QTD_JUNHO,
           psp.QTD_JULHO,
           psp.QTD_AGOSTO,
           psp.QTD_SETEMBRO,
           psp.QTD_OUTUBRO,
           psp.QTD_NOVEMBRO,
           psp.QTD_DEZEMBRO
      from PROGRAMACAO_SOLIC_PROPOSTA  psp
      where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ISP;
  r_PSP  q_PSP%rowtype;
  v_VAL_TOTAL_PROGRAMACAO       number(14,2);
  v_IND_EXISTENCIA_PROGRAMACAO  boolean;
  --------------------------------------
  -- DESPESA / PROGRAMACAO / SEQUENCE --
  --------------------------------------
  cursor q_PSP_SEQUENCE
    is
    select SEQ_PROGRAMACAO_SOLIC_PROPOSTA.currval  SEQ_PROGRAMACAO_SOLIC_PROPOSTA
      from DUAL;
  r_PSP_SEQUENCE  q_PSP_SEQUENCE%rowtype;
    --------------------------------------
    -- TABELA DE ANO DE ORÇAMENTO - TAO --
    --------------------------------------
    cursor q_TAO
            (
             p_NUM_ANO  number
            )
      is
      select tao.SEQ_ANO_ORCAMENTO
        from TAB_ANO_ORCAMENTO  TAO
        where tao.NUM_ANO_CALENDARIO = p_NUM_ANO;
    r_TAO  q_TAO%rowtype;
    l_TAO  boolean;
  -------------
  -- RECEITA --
  -------------
  cursor q_PRS
          (
           p_NUM_ANO_O                     number,
           p_COD_NIVEL_O                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA_O  number,
           p_COD_VERSAO_O                  varchar2
          )
    is
    select prs.COD_DEPENDENCIA_ELABORACAO,
           prs.NR_SEQ,
           prs.CC1_NR_CONTA,
           prs.TAR_CD_REGIME,
           prs.VAL_JAN,
           prs.VAL_FEV,
           prs.VAL_MAR,
           prs.VAL_ABR,
           prs.VAL_MAI,
           prs.VAL_JUN,
           prs.VAL_JUL,
           prs.VAL_AGO,
           prs.VAL_SET,
           prs.VAL_OUT,
           prs.VAL_NOV,
           prs.VAL_DEZ,
           prs.VAL_JAN1,
           prs.VAL_FEV1,
           prs.VAL_MAR1,
           prs.VAL_ABR1,
           prs.VAL_MAI1,
           prs.VAL_JUN1,
           prs.VAL_JUL1,
           prs.VAL_AGO1,
           prs.VAL_SET1,
           prs.VAL_OUT1,
           prs.VAL_NOV1,
           prs.VAL_DEZ1,
           prs.VAL_JAN2,
           prs.VAL_FEV2,
           prs.VAL_MAR2,
           prs.VAL_ABR2,
           prs.VAL_MAI2,
           prs.VAL_JUN2,
           prs.VAL_JUL2,
           prs.VAL_AGO2,
           prs.VAL_SET2,
           prs.VAL_OUT2,
           prs.VAL_NOV2,
           prs.VAL_DEZ2,
           prs.VAL_JAN3,
           prs.VAL_FEV3,
           prs.VAL_MAR3,
           prs.VAL_ABR3,
           prs.VAL_MAI3,
           prs.VAL_JUN3,
           prs.VAL_JUL3,
           prs.VAL_AGO3,
           prs.VAL_SET3,
           prs.VAL_OUT3,
           prs.VAL_NOV3,
           prs.VAL_DEZ3,
           prs.VAL_JAN4,
           prs.VAL_FEV4,
           prs.VAL_MAR4,
           prs.VAL_ABR4,
           prs.VAL_MAI4,
           prs.VAL_JUN4,
           prs.VAL_JUL4,
           prs.VAL_AGO4,
           prs.VAL_SET4,
           prs.VAL_OUT4,
           prs.VAL_NOV4,
           prs.VAL_DEZ4
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO_O
            and
            prs.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL_O
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_O
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO_O;
  BEGIN
    p_IND_RETORNO := true;
    open q_TAO
          (
           p_NUM_ANO_O
          );
    fetch q_TAO into r_TAO;
    l_TAO := q_TAO%found;
    close q_TAO;
    -------------------------------------------
    -- PASSO 01 - INSERÇÃO DE DESPESA/GESTOR --
    -------------------------------------------
    for f_IPS in q_IPS
                  (
                   p_NUM_ANO_O,
                   p_COD_NIVEL_O,
                   p_COD_DEPENDENCIA_AGRUPADORA_O,
                   p_COD_VERSAO_O
                  )
    LOOP
      ----------------------------------------------------------------------------
      -- PASSO 02 - CALCULO DE TOTALIZAÇÃO / GESTOR + SOLICITANTE + PROGRAMACAO --
      ----------------------------------------------------------------------------
      v_VAL_TOTAL_GESTOR := f_ips.VAL_TOTAL_GESTOR;
      v_VAL_TOTAL_SOLICITANTE := 0;
      v_VAL_TOTAL_PROGRAMACAO := 0;
      v_IND_EXISTENCIA_SOLICITANTE := false;
      v_IND_EXISTENCIA_PROGRAMACAO := false;
      --
      v_FLG_LANCAMENTO := f_ips.FLG_LANCAMENTO;
      --
      IF p_IND_RATEIO_AUTOMATICO = TRUE
         and
         f_ips.FLG_LANCAMENTO = 'A'
      THEN
        v_FLG_LANCAMENTO := 'R';
      END IF;
      --
      BEGIN
        ---------------------------------------------
        -- PASSO 03 - INSERÇÃO DE DESPESA / GESTOR --
        ---------------------------------------------
        insert
          into ITEM_PROPOSTA_ORC_SIMULADA
           (
            VSP_NR_ANO,
            VSP_CD_NIVEL_VERSAO,
            COD_DEPENDENCIA_AGRUPADORA,
            VSP_CD_VERSAO,
            COD_DEPENDENCIA_ELABORACAO,
            NR_ITEM,
            DEP_CD_DEPENDENCIA_GERD,
            CC2_CD_CENTRO_CUSTO_GERD,
            FLG_TIPO_CONTA,
            FLG_LANCAMENTO,
            CC1_NR_CONTA,
            DS_ITEM,
            COD_CATALOGO,
            NR_CONTRATO,
            NO_FORNECEDOR,
            DT_INICIO_CONTRATO,
            DT_TERMINO_CONTRATO,
            IND_CONTRATO,
            PRJ_CD_PROJETO,
            DS_JUSTIFICATIVA,
            CD_PRIORIDADE,
            IN_DIMENSIONAMENTO,
            FLG_PLURIANUAL,
            VAL_TOTAL_GESTOR,
            VAL_JAN,
            VAL_FEV,
            VAL_MAR,
            VAL_ABR,
            VAL_MAI,
            VAL_JUN,
            VAL_JUL,
            VAL_AGO,
            VAL_SET,
            VAL_OUT,
            VAL_NOV,
            VAL_DEZ,
            VAL_JAN1,
            VAL_FEV1,
            VAL_MAR1,
            VAL_ABR1,
            VAL_MAI1,
            VAL_JUN1,
            VAL_JUL1,
            VAL_AGO1,
            VAL_SET1,
            VAL_OUT1,
            VAL_NOV1,
            VAL_DEZ1,
            VAL_JAN2,
            VAL_FEV2,
            VAL_MAR2,
            VAL_ABR2,
            VAL_MAI2,
            VAL_JUN2,
            VAL_JUL2,
            VAL_AGO2,
            VAL_SET2,
            VAL_OUT2,
            VAL_NOV2,
            VAL_DEZ2,
            VAL_JAN3,
            VAL_FEV3,
            VAL_MAR3,
            VAL_ABR3,
            VAL_MAI3,
            VAL_JUN3,
            VAL_JUL3,
            VAL_AGO3,
            VAL_SET3,
            VAL_OUT3,
            VAL_NOV3,
            VAL_DEZ3,
            VAL_JAN4,
            VAL_FEV4,
            VAL_MAR4,
            VAL_ABR4,
            VAL_MAI4,
            VAL_JUN4,
            VAL_JUL4,
            VAL_AGO4,
            VAL_SET4,
            VAL_OUT4,
            VAL_NOV4,
            VAL_DEZ4,
            VL_UNITARIO_ITEM,
            QTD_JAN,
            QTD_FEV,
            QTD_MAR,
            QTD_ABR,
            QTD_MAI,
            QTD_JUN,
            QTD_JUL,
            QTD_AGO,
            QTD_SET,
            QTD_OUT,
            QTD_NOV,
            QTD_DEZ,
            VL_UNITARIO_ITEM1,
            QTD_JAN1,
            QTD_FEV1,
            QTD_MAR1,
            QTD_ABR1,
            QTD_MAI1,
            QTD_JUN1,
            QTD_JUL1,
            QTD_AGO1,
            QTD_SET1,
            QTD_OUT1,
            QTD_NOV1,
            QTD_DEZ1,
            VL_UNITARIO_ITEM2,
            QTD_JAN2,
            QTD_FEV2,
            QTD_MAR2,
            QTD_ABR2,
            QTD_MAI2,
            QTD_JUN2,
            QTD_JUL2,
            QTD_AGO2,
            QTD_SET2,
            QTD_OUT2,
            QTD_NOV2,
            QTD_DEZ2,
            VL_UNITARIO_ITEM3,
            QTD_JAN3,
            QTD_FEV3,
            QTD_MAR3,
            QTD_ABR3,
            QTD_MAI3,
            QTD_JUN3,
            QTD_JUL3,
            QTD_AGO3,
            QTD_SET3,
            QTD_OUT3,
            QTD_NOV3,
            QTD_DEZ3,
            VL_UNITARIO_ITEM4,
            QTD_JAN4,
            QTD_FEV4,
            QTD_MAR4,
            QTD_ABR4,
            QTD_MAI4,
            QTD_JUN4,
            QTD_JUL4,
            QTD_AGO4,
            QTD_SET4,
            QTD_OUT4,
            QTD_NOV4,
            QTD_DEZ4,
            SEQ_CARGA_ANO_ORCAMENTO,
            FLG_OPERACAO_INCLUSAO
           )
          values
           (
            p_NUM_ANO_D,
            p_COD_NIVEL_D,
            p_COD_DEPENDENCIA_AGRUPADORA_D,
            p_COD_VERSAO_D,
            f_ips.COD_DEPENDENCIA_ELABORACAO,
            f_ips.NR_ITEM,
            f_ips.DEP_CD_DEPENDENCIA_GERD,
            f_ips.CC2_CD_CENTRO_CUSTO_GERD,
            f_ips.FLG_TIPO_CONTA,
            v_FLG_LANCAMENTO,
            f_ips.CC1_NR_CONTA,
            f_ips.DS_ITEM,
            f_ips.COD_CATALOGO,
            f_ips.NR_CONTRATO,
            f_ips.NO_FORNECEDOR,
            f_ips.DT_INICIO_CONTRATO,
            f_ips.DT_TERMINO_CONTRATO,
            f_ips.IND_CONTRATO,
            f_ips.PRJ_CD_PROJETO,
            f_ips.DS_JUSTIFICATIVA,
            f_ips.CD_PRIORIDADE,
            f_ips.IN_DIMENSIONAMENTO,
            f_ips.FLG_PLURIANUAL,
            f_ips.VAL_TOTAL_GESTOR,
            f_ips.VAL_JAN,
            f_ips.VAL_FEV,
            f_ips.VAL_MAR,
            f_ips.VAL_ABR,
            f_ips.VAL_MAI,
            f_ips.VAL_JUN,
            f_ips.VAL_JUL,
            f_ips.VAL_AGO,
            f_ips.VAL_SET,
            f_ips.VAL_OUT,
            f_ips.VAL_NOV,
            f_ips.VAL_DEZ,
            f_ips.VAL_JAN1,
            f_ips.VAL_FEV1,
            f_ips.VAL_MAR1,
            f_ips.VAL_ABR1,
            f_ips.VAL_MAI1,
            f_ips.VAL_JUN1,
            f_ips.VAL_JUL1,
            f_ips.VAL_AGO1,
            f_ips.VAL_SET1,
            f_ips.VAL_OUT1,
            f_ips.VAL_NOV1,
            f_ips.VAL_DEZ1,
            f_ips.VAL_JAN2,
            f_ips.VAL_FEV2,
            f_ips.VAL_MAR2,
            f_ips.VAL_ABR2,
            f_ips.VAL_MAI2,
            f_ips.VAL_JUN2,
            f_ips.VAL_JUL2,
            f_ips.VAL_AGO2,
            f_ips.VAL_SET2,
            f_ips.VAL_OUT2,
            f_ips.VAL_NOV2,
            f_ips.VAL_DEZ2,
            f_ips.VAL_JAN3,
            f_ips.VAL_FEV3,
            f_ips.VAL_MAR3,
            f_ips.VAL_ABR3,
            f_ips.VAL_MAI3,
            f_ips.VAL_JUN3,
            f_ips.VAL_JUL3,
            f_ips.VAL_AGO3,
            f_ips.VAL_SET3,
            f_ips.VAL_OUT3,
            f_ips.VAL_NOV3,
            f_ips.VAL_DEZ3,
            f_ips.VAL_JAN4,
            f_ips.VAL_FEV4,
            f_ips.VAL_MAR4,
            f_ips.VAL_ABR4,
            f_ips.VAL_MAI4,
            f_ips.VAL_JUN4,
            f_ips.VAL_JUL4,
            f_ips.VAL_AGO4,
            f_ips.VAL_SET4,
            f_ips.VAL_OUT4,
            f_ips.VAL_NOV4,
            f_ips.VAL_DEZ4,
            f_ips.VL_UNITARIO_ITEM,
            f_ips.QTD_JAN,
            f_ips.QTD_FEV,
            f_ips.QTD_MAR,
            f_ips.QTD_ABR,
            f_ips.QTD_MAI,
            f_ips.QTD_JUN,
            f_ips.QTD_JUL,
            f_ips.QTD_AGO,
            f_ips.QTD_SET,
            f_ips.QTD_OUT,
            f_ips.QTD_NOV,
            f_ips.QTD_DEZ,
            f_ips.VL_UNITARIO_ITEM1,
            f_ips.QTD_JAN1,
            f_ips.QTD_FEV1,
            f_ips.QTD_MAR1,
            f_ips.QTD_ABR1,
            f_ips.QTD_MAI1,
            f_ips.QTD_JUN1,
            f_ips.QTD_JUL1,
            f_ips.QTD_AGO1,
            f_ips.QTD_SET1,
            f_ips.QTD_OUT1,
            f_ips.QTD_NOV1,
            f_ips.QTD_DEZ1,
            f_ips.VL_UNITARIO_ITEM2,
            f_ips.QTD_JAN2,
            f_ips.QTD_FEV2,
            f_ips.QTD_MAR2,
            f_ips.QTD_ABR2,
            f_ips.QTD_MAI2,
            f_ips.QTD_JUN2,
            f_ips.QTD_JUL2,
            f_ips.QTD_AGO2,
            f_ips.QTD_SET2,
            f_ips.QTD_OUT2,
            f_ips.QTD_NOV2,
            f_ips.QTD_DEZ2,
            f_ips.VL_UNITARIO_ITEM3,
            f_ips.QTD_JAN3,
            f_ips.QTD_FEV3,
            f_ips.QTD_MAR3,
            f_ips.QTD_ABR3,
            f_ips.QTD_MAI3,
            f_ips.QTD_JUN3,
            f_ips.QTD_JUL3,
            f_ips.QTD_AGO3,
            f_ips.QTD_SET3,
            f_ips.QTD_OUT3,
            f_ips.QTD_NOV3,
            f_ips.QTD_DEZ3,
            f_ips.VL_UNITARIO_ITEM4,
            f_ips.QTD_JAN4,
            f_ips.QTD_FEV4,
            f_ips.QTD_MAR4,
            f_ips.QTD_ABR4,
            f_ips.QTD_MAI4,
            f_ips.QTD_JUN4,
            f_ips.QTD_JUL4,
            f_ips.QTD_AGO4,
            f_ips.QTD_SET4,
            f_ips.QTD_OUT4,
            f_ips.QTD_NOV4,
            f_ips.QTD_DEZ4,
            f_ips.SEQ_CARGA_ANO_ORCAMENTO,
            'C'
           );
      EXCEPTION
        WHEN OTHERS
        THEN
          --------------------------------------------
          -- PASSO 04 - INTERRUPÇÃO - ERRO DE DADOS --
          --------------------------------------------
          p_IND_RETORNO := false;
          p_DSC_RETORNO := p_NUM_ANO_D||'/'||p_COD_NIVEL_D||'/'||p_COD_DEPENDENCIA_AGRUPADORA_D||'/'||p_COD_VERSAO_D||'/'||f_ips.COD_DEPENDENCIA_ELABORACAO||'/'||f_ips.NR_ITEM||chr(10)||
                           sqlerrm;
        GOTO FIM;
      END;
      --====================================--
      -- GERAÇÃO DE SOLICITANTE/PROGRAMAÇÃO --
      --====================================--
      -----------------------------------------------
      -- PASSO XX - CONDIÇÃO - PARA FAZER O RATEIO --
      -----------------------------------------------
      IF v_FLG_LANCAMENTO = 'R'
      THEN
        --------------------------------------------
        -- PASSO XX - CHAMADA - RATEIO AUTOMÁTICO --
        --------------------------------------------
        PRC_RATEIO_AUTOMATICO
         (
          p_NUM_ANO_O,
          p_COD_NIVEL_O,
          p_COD_DEPENDENCIA_AGRUPADORA_O,
          p_COD_VERSAO_O,
          f_ips.COD_DEPENDENCIA_ELABORACAO,
          f_ips.NR_ITEM,
          p_COD_VERSAO_D,
          r_TAO.SEQ_ANO_ORCAMENTO,
          v_VAL_TOTAL_SOLICITANTE,
          v_VAL_TOTAL_PROGRAMACAO,
          p_IND_RETORNO,
          p_DSC_RETORNO
         );
        ------------------------------------------------------------------------------------
        -- PASSO XX - CONDIÇÃO - RESULTADO DO PROCESSO - RATEIO AUTOMÁTICO : BEM SUCEDIDO --
        ------------------------------------------------------------------------------------
        IF p_IND_RETORNO = true
        THEN
          --------------------------------------------------------
          -- PASSO XX - EXISTÊNCIA DE SOLICITANTE E PROGRAMAÇÃO --
          --------------------------------------------------------
          v_IND_EXISTENCIA_SOLICITANTE := true;
          v_IND_EXISTENCIA_PROGRAMACAO := true;
        --------------------------------------------------------------------------------------------------------------------------
        -- PASSO XX - CONDIÇÃO - RESULTADO DO PROCESSO DO RATEIO AUTOMÁTICO : MAL SUCEDIDO E ORÇAMENTO REALIZADO NÃO ENCONTRADO --
        --------------------------------------------------------------------------------------------------------------------------
        ELSIF p_IND_RETORNO = false
              and
              p_DSC_RETORNO = 'ORÇAMENTO REALIZADO NÃO ENCONTRADO'
        THEN
          --------------------------------------------
          -- PASSO XX - CONDIÇÃO - CONTA 113.01.005 --
          --------------------------------------------
          IF f_ips.CC1_NR_CONTA = '11301005'
          THEN
            -----------------------------------------------------------
            -- REVERSÃO DO GESTOR PARA O TIPO DE LANÇAMENTO ORIGINAL --
            -----------------------------------------------------------
            v_FLG_LANCAMENTO := f_ips.FLG_LANCAMENTO;
            update ITEM_PROPOSTA_ORC_SIMULADA
              set FLG_LANCAMENTO = v_FLG_LANCAMENTO
              where VSP_NR_ANO                 = p_NUM_ANO_D
                    and
                    VSP_CD_NIVEL_VERSAO        = p_COD_NIVEL_D
                    and
                    COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA_D
                    and
                    VSP_CD_VERSAO              = p_COD_VERSAO_D
                    and
                    COD_DEPENDENCIA_ELABORACAO = f_ips.COD_DEPENDENCIA_ELABORACAO
                    and
                    NR_ITEM                    = f_ips.NR_ITEM;
          ------------------------------------------------------
          -- PASSO XX - CONDIÇÃO - EXCEÇÃO A CONTA 113.01.005 --
          ------------------------------------------------------
          ELSE
            ----------------------------------------------
            -- PASSO XX - CALCULO - TOTAL - SOLICITANTE --
            ----------------------------------------------
            v_VAL_TOTAL_SOLICITANTE := f_ips.VAL_TOTAL_GESTOR;
            -------------------------------------------------------------------
            -- PASSO XX - INSERÇÃO DE SOLICITANTE - CONFORME CHAVE DO GESTOR --
            -------------------------------------------------------------------
            BEGIN
              insert
                into ITEM_SOLICITANTE_PROPOSTA
                 (
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  VSP_NR_ANO,
                  VSP_CD_NIVEL_VERSAO,
                  COD_DEPENDENCIA_AGRUPADORA,
                  VSP_CD_VERSAO,
                  COD_DEPENDENCIA_ELABORACAO,
                  NR_ITEM,
                  COD_DEPENDENCIA_SOLICITANTE,
                  COD_CENTRO_CUSTO_SOLICITANTE,
                  NUM_CONTA_SOLICITANTE,
                  VAL_TOTAL_SOLICITANTE,
                  FLG_DIMENSIONAMENTO,
                  COD_PROJETO
                 )
                values
                 (
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
                  p_NUM_ANO_D,
                  p_COD_NIVEL_D,
                  p_COD_DEPENDENCIA_AGRUPADORA_D,
                  p_COD_VERSAO_D,
                  f_ips.COD_DEPENDENCIA_ELABORACAO,
                  f_ips.NR_ITEM,
                  f_ips.DEP_CD_DEPENDENCIA_GERD,
                  f_ips.CC2_CD_CENTRO_CUSTO_GERD,
                  f_ips.CC1_NR_CONTA,
                  f_ips.VAL_TOTAL_GESTOR,
                  f_ips.IN_DIMENSIONAMENTO,
                  f_ips.PRJ_CD_PROJETO
                 );
            EXCEPTION
              WHEN OTHERS
              THEN
                --------------------------------------------
                -- PASSO XX - INTERRUPÇÃO - ERRO DE DADOS --
                --------------------------------------------
                open q_ISP_SEQUENCE;
                fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
                close q_ISP_SEQUENCE;
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Tabela ITEM_SOLICITANTE_PROPOSTA ,'||
                                 'Orig='||
                                 'Ano:'||p_NUM_ANO_O||','||
                                 'Nív: '||p_COD_NIVEL_O||','||
                                 'Dep.Agr: '||p_COD_DEPENDENCIA_AGRUPADORA_O||','||
                                 'Ver: '||p_COD_VERSAO_O||','||
                                 'Dest='||
                                 'Ano: '||p_NUM_ANO_D||','||
                                 'Nív: '||p_COD_NIVEL_D||','||
                                 'Dep.Agr: '||p_COD_DEPENDENCIA_AGRUPADORA_D||','||
                                 'Ver: '||p_COD_VERSAO_D||','||
                                 'Dep.Elab: '||f_ips.COD_DEPENDENCIA_ELABORACAO||','||
                                 'Nr.Item: '||f_ips.NR_ITEM||','||
                                 'Seq.Solic: '||r_isp_sequence.SEQ_ITEM_SOLICITANTE_PROPOSTA||','||
                                 sqlerrm;
              GOTO FIM;
            END;
            ----------------------------------------------
            -- PASSO XX - CALCULO - TOTAL - PROGRAMAÇÃO --
            ----------------------------------------------
            v_VAL_TOTAL_PROGRAMACAO := + f_ips.VAL_JAN
                                       + f_ips.VAL_FEV
                  		       + f_ips.VAL_MAR
                  		       + f_ips.VAL_ABR
                  		       + f_ips.VAL_MAI
                  		       + f_ips.VAL_JUN
                  		       + f_ips.VAL_JUL
                  		       + f_ips.VAL_AGO
                  		       + f_ips.VAL_SET
                  		       + f_ips.VAL_OUT
                  		       + f_ips.VAL_NOV
                  		       + f_ips.VAL_DEZ;
	    --------------------------------------------------
            -- PASSO XX - INSERÇÃO DE DESPESA / PROGRAMACAO --
            --------------------------------------------------
            BEGIN
              insert
                into PROGRAMACAO_SOLIC_PROPOSTA
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  NUM_ANO,
                  VAL_JANEIRO,
                  VAL_FEVEREIRO,
                  VAL_MARCO,
                  VAL_ABRIL,
                  VAL_MAIO,
                  VAL_JUNHO,
                  VAL_JULHO,
                  VAL_AGOSTO,
                  VAL_SETEMBRO,
                  VAL_OUTUBRO,
                  VAL_NOVEMBRO,
                  VAL_DEZEMBRO,
                  VAL_UNITARIO,
                  QTD_JANEIRO,
                  QTD_FEVEREIRO,
                  QTD_MARCO,
                  QTD_ABRIL,
                  QTD_MAIO,
                  QTD_JUNHO,
                  QTD_JULHO,
                  QTD_AGOSTO,
                  QTD_SETEMBRO,
                  QTD_OUTUBRO,
                  QTD_NOVEMBRO,
                  QTD_DEZEMBRO
                 )
                values
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.currval,
                  p_NUM_ANO_D,
                  f_ips.VAL_JAN,
                  f_ips.VAL_FEV,
                  f_ips.VAL_MAR,
                  f_ips.VAL_ABR,
                  f_ips.VAL_MAI,
                  f_ips.VAL_JUN,
                  f_ips.VAL_JUL,
                  f_ips.VAL_AGO,
                  f_ips.VAL_SET,
                  f_ips.VAL_OUT,
                  f_ips.VAL_NOV,
                  f_ips.VAL_DEZ,
                  f_ips.VL_UNITARIO_ITEM,
                  f_ips.QTD_JAN,
                  f_ips.QTD_FEV,
                  f_ips.QTD_MAR,
                  f_ips.QTD_ABR,
                  f_ips.QTD_MAI,
                  f_ips.QTD_JUN,
                  f_ips.QTD_JUL,
                  f_ips.QTD_AGO,
                  f_ips.QTD_SET,
                  f_ips.QTD_OUT,
                  f_ips.QTD_NOV,
                  f_ips.QTD_DEZ
                 );
            EXCEPTION
              WHEN OTHERS
              THEN
                --------------------------------------------
                -- PASSO 12 - INTERRUPÇÃO - ERRO DE DADOS --
                --------------------------------------------
                open q_ISP_SEQUENCE;
                fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
                close q_ISP_SEQUENCE;
                open q_PSP_SEQUENCE;
                fetch q_PSP_SEQUENCE into r_PSP_SEQUENCE;
                close q_PSP_SEQUENCE;
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Tabela PROGRAMACAO_SOLIC_PROPOSTA '||chr(10)||
                                 'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                                 '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                                 '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                                 '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                                 'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                                 '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                                 '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                                 '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                                 'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                                 'Sequência Solicitante....: '||r_ISP_SEQUENCE.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                                 'Sequência Solicitante....: '||r_PSP_SEQUENCE.SEQ_PROGRAMACAO_SOLIC_PROPOSTA||chr(10)||
                                 sqlerrm;
              GOTO FIM;
            END;
          -------------------------------------------------------------
          -- FIM - AVALIAÇÃO - CONDIÇÃO - CONTA 113.01.005 E EXCEÇÃO --
          -------------------------------------------------------------
          END IF;
        ------------------------------------------------------------------
        -- FIM - AVALIAÇÃO - RESULTADO DO PROCESSO DO RATEIO AUTOMÁTICO --
        ------------------------------------------------------------------
        END IF;
      ------------------------------------------
      -- FIM - CONDIÇÃO - PARA FAZER O RATEIO --
      ------------------------------------------
      END IF;
      -----------------------------------------------------------------
      -- PASSO XX - CASO - COPIA NORMAL DE SOLICITANTE E PROGRAMAÇÃO --
      -----------------------------------------------------------------
      IF v_FLG_LANCAMENTO <> 'R'
      THEN
        -------------------------------------------------
        -- PASSO 05 - LEITURA DE DESPESA / SOLICITANTE --
        -------------------------------------------------
        for f_ISP in q_ISP
                      (
                       p_NUM_ANO_O,
                       p_COD_NIVEL_O,
                       p_COD_DEPENDENCIA_AGRUPADORA_O,
                       p_COD_VERSAO_O,
                       f_ips.COD_DEPENDENCIA_ELABORACAO,
                       f_ips.NR_ITEM
                      )
        LOOP
          v_IND_EXISTENCIA_SOLICITANTE := true;
          -----------------------------------------------------
          -- PASSO 06 - CALCULO DE TOTALIZAÇÃO / SOLICITANTE --
          -----------------------------------------------------
          v_VAL_TOTAL_SOLICITANTE := v_VAL_TOTAL_SOLICITANTE + f_ISP.VAL_TOTAL_SOLICITANTE;
          ----------------------------------------
          -- PASSO 07 - INSERÇÃO DE SOLICITANTE --
          ----------------------------------------
          BEGIN
            insert
              into ITEM_SOLICITANTE_PROPOSTA
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA,
                VSP_NR_ANO,
                VSP_CD_NIVEL_VERSAO,
                COD_DEPENDENCIA_AGRUPADORA,
                VSP_CD_VERSAO,
                COD_DEPENDENCIA_ELABORACAO,
                NR_ITEM,
                COD_DEPENDENCIA_SOLICITANTE,
                COD_CENTRO_CUSTO_SOLICITANTE,
                NUM_CONTA_SOLICITANTE,
                VAL_TOTAL_SOLICITANTE,
                FLG_DIMENSIONAMENTO,
                COD_PROJETO
               )
              values
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
                p_NUM_ANO_D,
                p_COD_NIVEL_D,
                p_COD_DEPENDENCIA_AGRUPADORA_D,
                p_COD_VERSAO_D,
                f_ips.COD_DEPENDENCIA_ELABORACAO,
                f_ips.NR_ITEM,
                f_isp.COD_DEPENDENCIA_SOLICITANTE,
                f_isp.COD_CENTRO_CUSTO_SOLICITANTE,
                f_isp.NUM_CONTA_SOLICITANTE,
                f_isp.VAL_TOTAL_SOLICITANTE,
                f_isp.FLG_DIMENSIONAMENTO,
                f_isp.COD_PROJETO
               );
          EXCEPTION
            WHEN OTHERS
            THEN
              --------------------------------------------
              -- PASSO 08 - INTERRUPÇÃO - ERRO DE DADOS --
              --------------------------------------------
              open q_ISP_SEQUENCE;
              fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
              close q_ISP_SEQUENCE;
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'Tabela ITEM_SOLICITANTE_PROPOSTA '||chr(10)||
                               'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                               '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                               '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                               '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                               'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                               '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                               '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                               '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                               'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                               'Sequência Solicitante....: '||r_ISP_SEQUENCE.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                               sqlerrm;
            GOTO FIM;
          END;
          -------------------------------------------------
          -- PASSO 09 - LEITURA DE DESPESA / PROGRAMACAO --
          -------------------------------------------------
          for f_PSP in q_PSP
                        (
                         f_isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
                        )
          LOOP
            v_IND_EXISTENCIA_PROGRAMACAO := true;
            -----------------------------------------------------
            -- PASSO 10 - CALCULO DE TOTALIZAÇÃO / PROGRAMACAO --
            -----------------------------------------------------
            IF f_PSP.NUM_ANO = p_NUM_ANO_O
            THEN
              v_VAL_TOTAL_PROGRAMACAO := v_VAL_TOTAL_PROGRAMACAO + f_psp.VAL_JANEIRO
                                                                 + f_psp.VAL_FEVEREIRO
                                                                 + f_psp.VAL_MARCO
                                                                 + f_psp.VAL_ABRIL
                                                                 + f_psp.VAL_MAIO
                                                                 + f_psp.VAL_JUNHO
                                                                 + f_psp.VAL_JULHO
                                                                 + f_psp.VAL_AGOSTO
                                                                 + f_psp.VAL_SETEMBRO
                                                                 + f_psp.VAL_OUTUBRO
                                                                 + f_psp.VAL_NOVEMBRO
                                                                 + f_psp.VAL_DEZEMBRO;
            END IF;
            --------------------------------------------------
            -- PASSO 11 - INSERÇÃO DE DESPESA / PROGRAMACAO --
            --------------------------------------------------
            BEGIN
              insert
                into PROGRAMACAO_SOLIC_PROPOSTA
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  NUM_ANO,
                  VAL_JANEIRO,
                  VAL_FEVEREIRO,
                  VAL_MARCO,
                  VAL_ABRIL,
                  VAL_MAIO,
                  VAL_JUNHO,
                  VAL_JULHO,
                  VAL_AGOSTO,
                  VAL_SETEMBRO,
                  VAL_OUTUBRO,
                  VAL_NOVEMBRO,
                  VAL_DEZEMBRO,
                  VAL_UNITARIO,
                  QTD_JANEIRO,
                  QTD_FEVEREIRO,
                  QTD_MARCO,
                  QTD_ABRIL,
                  QTD_MAIO,
                  QTD_JUNHO,
                  QTD_JULHO,
                  QTD_AGOSTO,
                  QTD_SETEMBRO,
                  QTD_OUTUBRO,
                  QTD_NOVEMBRO,
                  QTD_DEZEMBRO
                 )
                values
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.currval,
                  f_psp.NUM_ANO,
                  f_psp.VAL_JANEIRO,
                  f_psp.VAL_FEVEREIRO,
                  f_psp.VAL_MARCO,
                  f_psp.VAL_ABRIL,
                  f_psp.VAL_MAIO,
                  f_psp.VAL_JUNHO,
                  f_psp.VAL_JULHO,
                  f_psp.VAL_AGOSTO,
                  f_psp.VAL_SETEMBRO,
                  f_psp.VAL_OUTUBRO,
                  f_psp.VAL_NOVEMBRO,
                  f_psp.VAL_DEZEMBRO,
                  f_psp.VAL_UNITARIO,
                  f_psp.QTD_JANEIRO,
                  f_psp.QTD_FEVEREIRO,
                  f_psp.QTD_MARCO,
                  f_psp.QTD_ABRIL,
                  f_psp.QTD_MAIO,
                  f_psp.QTD_JUNHO,
                  f_psp.QTD_JULHO,
                  f_psp.QTD_AGOSTO,
                  f_psp.QTD_SETEMBRO,
                  f_psp.QTD_OUTUBRO,
                  f_psp.QTD_NOVEMBRO,
                  f_psp.QTD_DEZEMBRO
                 );
            EXCEPTION
              WHEN OTHERS
              THEN
                --------------------------------------------
                -- PASSO 12 - INTERRUPÇÃO - ERRO DE DADOS --
                --------------------------------------------
                open q_ISP_SEQUENCE;
                fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
                close q_ISP_SEQUENCE;
                open q_PSP_SEQUENCE;
                fetch q_PSP_SEQUENCE into r_PSP_SEQUENCE;
                close q_PSP_SEQUENCE;
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Tabela PROGRAMACAO_SOLIC_PROPOSTA '||chr(10)||
                                 'Origem  Ano..............: '||p_NUM_ANO_O||chr(10)||
                                 '        Nível............: '||p_COD_NIVEL_O||chr(10)||
                                 '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                                 '        Versão...........: '||p_COD_VERSAO_O||chr(10)||
                                 'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                                 '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                                 '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                                 '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                                 'Dep.Elaboração...........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Sequencia Item...........: '||f_ips.NR_ITEM||chr(10)||
                                 'Sequência Solicitante....: '||r_ISP_SEQUENCE.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                                 'Sequência Solicitante....: '||r_PSP_SEQUENCE.SEQ_PROGRAMACAO_SOLIC_PROPOSTA||chr(10)||
                                 sqlerrm;
              GOTO FIM;
            END;
          END LOOP f_PSP;
        END LOOP f_ISP;
      END IF;
      ------------------------------------------------------------------------------------
      -- PASSO 13 - VERIFICAÇÃO DE DIVERGÊNCIA ENTRE VALOR GESTOR, SOLICITANTE E VALOR  --
      ------------------------------------------------------------------------------------
      IF v_VAL_TOTAL_GESTOR <> v_VAL_TOTAL_SOLICITANTE
         or
         v_VAL_TOTAL_SOLICITANTE <> v_VAL_TOTAL_PROGRAMACAO
      THEN
        ---------------------------------------------------------------------------------
        -- PASSO 14 - MENSAGEM DE DIVERGÊNCIA ENTRE VALOR GESTOR, SOLICITANTE E VALOR  --
        ---------------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := p_DSC_RETORNO|| ' / Existe ---> dif.'||
                         'Gestor='||to_char(v_VAL_TOTAL_GESTOR)||
                         'Solicitante='||to_char(v_VAL_TOTAL_SOLICITANTE)||
                         'Programado='||to_char(v_VAL_TOTAL_PROGRAMACAO)||') no Item '||
                         f_ips.NR_ITEM||' da Dependência '||f_ips.COD_DEPENDENCIA_ELABORACAO||
                         ' na versão de origem.   É solicitado que verifique este Item.';
        GOTO FIM;
      END IF;
      -------------------------------------------------------------
      -- PASSO 15 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE SOLICITANTE --
      -------------------------------------------------------------
      IF v_IND_EXISTENCIA_SOLICITANTE = false
      THEN
        ------------------------------------------------------------------------
        -- PASSO 16 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE SOLICITANTE --
        ------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := p_DSC_RETORNO||' / Solicitante(Resultado) não foi encontrado no Item : '||chr(10)||
                         'Ano..............: '||p_NUM_ANO_O||chr(10)||
                         'Nível............: '||p_COD_NIVEL_O||chr(10)||
                         'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                         'Versão...........: '||p_COD_VERSAO_O||chr(10)||
                         'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                         'Número do Item...: '||f_ips.NR_ITEM||chr(10)||
                         SQLERRM;
        GOTO FIM;
      END IF;
      -------------------------------------------------------------
      -- PASSO 17 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE PROGRAMACAO --
      -------------------------------------------------------------
      IF v_IND_EXISTENCIA_PROGRAMACAO = false
      THEN
        ------------------------------------------------------------------------
        -- PASSO 18 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE PROGRAMACAO --
        ------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := p_DSC_RETORNO||' / Programação não foi encontrada no Item : '||chr(10)||
                         'Ano..............: '||p_NUM_ANO_O||chr(10)||
                         'Nível............: '||p_COD_NIVEL_O||chr(10)||
                         'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                         'Versão...........: '||p_COD_VERSAO_O||chr(10)||
                         'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                         'Número do Item...: '||f_ips.NR_ITEM||chr(10)||
                         SQLERRM;
        GOTO FIM;
      END IF;
    END LOOP r_IPS;
    -----------------------------------
    -- PASSO 19 - LEITURA DE RECEITA --
    -----------------------------------
    for f_PRS in q_PRS
                  (
                   p_NUM_ANO_O,
                   p_COD_NIVEL_O,
                   p_COD_DEPENDENCIA_AGRUPADORA_O,
                   p_COD_VERSAO_O
                  )
    LOOP
    ------------------------------------
    -- PASSO 20 - INSERCAO DE RECEITA --
    ------------------------------------
      BEGIN
        insert
          into PROJECAO_RECEITA_SIMULADA
           (
            VSP_NR_ANO,
            VSP_CD_NIVEL_VERSAO,
            COD_DEPENDENCIA_AGRUPADORA,
            VSP_CD_VERSAO,
            COD_DEPENDENCIA_ELABORACAO,
            NR_SEQ,
            CC1_NR_CONTA,
            TAR_CD_REGIME,
            VAL_JAN,
            VAL_FEV,
            VAL_MAR,
            VAL_ABR,
            VAL_MAI,
            VAL_JUN,
            VAL_JUL,
            VAL_AGO,
            VAL_SET,
            VAL_OUT,
            VAL_NOV,
            VAL_DEZ,
            VAL_JAN1,
            VAL_FEV1,
            VAL_MAR1,
            VAL_ABR1,
            VAL_MAI1,
            VAL_JUN1,
            VAL_JUL1,
            VAL_AGO1,
            VAL_SET1,
            VAL_OUT1,
            VAL_NOV1,
            VAL_DEZ1,
            VAL_JAN2,
            VAL_FEV2,
            VAL_MAR2,
            VAL_ABR2,
            VAL_MAI2,
            VAL_JUN2,
            VAL_JUL2,
            VAL_AGO2,
            VAL_SET2,
            VAL_OUT2,
            VAL_NOV2,
            VAL_DEZ2,
            VAL_JAN3,
            VAL_FEV3,
            VAL_MAR3,
            VAL_ABR3,
            VAL_MAI3,
            VAL_JUN3,
            VAL_JUL3,
            VAL_AGO3,
            VAL_SET3,
            VAL_OUT3,
            VAL_NOV3,
            VAL_DEZ3,
            VAL_JAN4,
            VAL_FEV4,
            VAL_MAR4,
            VAL_ABR4,
            VAL_MAI4,
            VAL_JUN4,
            VAL_JUL4,
            VAL_AGO4,
            VAL_SET4,
            VAL_OUT4,
            VAL_NOV4,
            VAL_DEZ4
           )
          values
           (
            p_NUM_ANO_D,
            p_COD_NIVEL_D,
            p_COD_DEPENDENCIA_AGRUPADORA_D,
            p_COD_VERSAO_D,
            f_prs.COD_DEPENDENCIA_ELABORACAO,
            f_prs.NR_SEQ,
            f_prs.CC1_NR_CONTA,
            f_prs.TAR_CD_REGIME,
            f_prs.VAL_JAN,
            f_prs.VAL_FEV,
            f_prs.VAL_MAR,
            f_prs.VAL_ABR,
            f_prs.VAL_MAI,
            f_prs.VAL_JUN,
            f_prs.VAL_JUL,
            f_prs.VAL_AGO,
            f_prs.VAL_SET,
            f_prs.VAL_OUT,
            f_prs.VAL_NOV,
            f_prs.VAL_DEZ,
            f_prs.VAL_JAN1,
            f_prs.VAL_FEV1,
            f_prs.VAL_MAR1,
            f_prs.VAL_ABR1,
            f_prs.VAL_MAI1,
            f_prs.VAL_JUN1,
            f_prs.VAL_JUL1,
            f_prs.VAL_AGO1,
            f_prs.VAL_SET1,
            f_prs.VAL_OUT1,
            f_prs.VAL_NOV1,
            f_prs.VAL_DEZ1,
            f_prs.VAL_JAN2,
            f_prs.VAL_FEV2,
            f_prs.VAL_MAR2,
            f_prs.VAL_ABR2,
            f_prs.VAL_MAI2,
            f_prs.VAL_JUN2,
            f_prs.VAL_JUL2,
            f_prs.VAL_AGO2,
            f_prs.VAL_SET2,
            f_prs.VAL_OUT2,
            f_prs.VAL_NOV2,
            f_prs.VAL_DEZ2,
            f_prs.VAL_JAN3,
            f_prs.VAL_FEV3,
            f_prs.VAL_MAR3,
            f_prs.VAL_ABR3,
            f_prs.VAL_MAI3,
            f_prs.VAL_JUN3,
            f_prs.VAL_JUL3,
            f_prs.VAL_AGO3,
            f_prs.VAL_SET3,
            f_prs.VAL_OUT3,
            f_prs.VAL_NOV3,
            f_prs.VAL_DEZ3,
            f_prs.VAL_JAN4,
            f_prs.VAL_FEV4,
            f_prs.VAL_MAR4,
            f_prs.VAL_ABR4,
            f_prs.VAL_MAI4,
            f_prs.VAL_JUN4,
            f_prs.VAL_JUL4,
            f_prs.VAL_AGO4,
            f_prs.VAL_SET4,
            f_prs.VAL_OUT4,
            f_prs.VAL_NOV4,
            f_prs.VAL_DEZ4
           );
      EXCEPTION
        WHEN OTHERS
        THEN
          --------------------------------------------
          -- PASSO 21 - INTERRUPÇÃO - ERRO DE DADOS --
          --------------------------------------------
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Tabela PROJECAO_RECEITA_SIMULADA '||chr(10)||
                           'Origem Ano...............: '||p_NUM_ANO_O||chr(10)||
                           '       Nível.............: '||p_COD_NIVEL_O||chr(10)||
                           '       Dep.Agrupadora....: '||p_COD_DEPENDENCIA_AGRUPADORA_O||chr(10)||
                           '       Versão............: '||p_COD_VERSAO_O||chr(10)||
                           'Destino Ano..............: '||p_NUM_ANO_D||chr(10)||
                           '        Nível............: '||p_COD_NIVEL_D||chr(10)||
                           '        Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA_D||chr(10)||
                           '        Versão...........: '||p_COD_VERSAO_D||chr(10)||
                           'Dep.Elaboração...........: '||f_prs.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Sequencia................: '||f_prs.NR_SEQ||chr(10)||
                           SQLERRM;
          GOTO FIM;
      END;
    END LOOP;
    <<FIM>>
    null;
  END PRC_COPIA_VERSAO;
  ------------------------------
  -- GERA NÍVEL (EM VERSÃO 1) --
  ------------------------------
  PROCEDURE PRC_GERA_NIVEL
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             )
  IS
    ------------------------------
    -- DEPENDENCIA + VINCULADAS --
    ------------------------------
    cursor q_DEP
            (
             p_NUM_ANO                     number,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vdep.DEP_CODIGO  DEP_CODIGO
        from VW_DEPENDENCIA_SICOF  vdep
        where vdep.NUM_ANO = p_NUM_ANO
              and
              vdep.DEP_CODIGO
                in
                (
                 select dep.DEP_CODIGO
                   from DEPENDENCIAS  dep
                   where level <= 2
                   connect by prior dep.DEP_CODIGO = dep.DEP_DEP_CODIGO
                   start with dep.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
                );
    ------------------------------------------
    -- DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
    ------------------------------------------
    cursor q_DEP_VSP_NAO_ESCOLHIDA
            (
             p_NUM_ANO                     number,
             p_COD_NIVEL                   varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vdep.DEP_CODIGO  DEP_CODIGO
        from VW_DEPENDENCIA_SICOF  vdep
        where vdep.NUM_ANO = p_NUM_ANO
              and
              exists
               (
                select NULL
                  from DEPENDENCIAS  dep1
                  where dep1.DEP_CODIGO = vdep.DEP_CODIGO
                        and
                        level <= 2
                  connect by prior dep1.DEP_CODIGO = dep1.DEP_DEP_CODIGO
                  start with dep1.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
               )
      minus
      (
       select vsp.DEP_CD_DEPENDENCIA  DEP_CODIGO
         from VERSAO_SIMULACAO_PROPOSTA_ORC  vsp
         where vsp.NR_ANO = p_NUM_ANO
               and
               vsp.CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
               and
               vsp.DEP_CD_DEPENDENCIA <> 1
               and
               exists
                (
                 select NULL
                   from DEPENDENCIAS  dep2
                   where dep2.DEP_CODIGO = vsp.DEP_CD_DEPENDENCIA
                   connect by prior dep2.DEP_CODIGO = dep2.DEP_DEP_CODIGO
                   start with dep2.DEP_CODIGO = p_COD_DEPENDENCIA_AGRUPADORA
                )
               and
               vsp.IN_ESCOLHIDA = 1
       union
       select vsp.DEP_CD_DEPENDENCIA  DEP_CODIGO
         from VERSAO_SIMULACAO_PROPOSTA_ORC  vsp
         where p_COD_NIVEL = 3
               and
               vsp.NR_ANO = p_NUM_ANO
               and
               vsp.CD_NIVEL_VERSAO = '1'
               and
               vsp.DEP_CD_DEPENDENCIA = 1
               and
               vsp.IN_ESCOLHIDA = 1
      );
    --
    r_DEP_VSP_NAO_ESCOLHIDA  q_DEP_VSP_NAO_ESCOLHIDA%rowtype;
    l_DEP_VSP_NAO_ESCOLHIDA  boolean;
    --
    ----------------------
    -- VERSÃO ESCOLHIDA --
    ----------------------
    cursor q_VSP
            (
             p_NUM_ANO                     number,
             p_COD_NIVEL                   varchar2,
             p_COD_DEPENDENCIA_AGRUPADORA  number
            )
      is
      select vsp.CD_VERSAO  CD_VERSAO
        from VERSAO_SIMULACAO_PROPOSTA_ORC  vsp
        where vsp.NR_ANO = p_NUM_ANO
              and
              (
               p_COD_DEPENDENCIA_AGRUPADORA = 1
               and
               vsp.CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
               or
               p_COD_DEPENDENCIA_AGRUPADORA <> 1
               and
               vsp.CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
              )
              and
              vsp.DEP_CD_DEPENDENCIA = p_COD_DEPENDENCIA_AGRUPADORA
              and
              vsp.IN_ESCOLHIDA = 1;
    --
    r_VSP_GERACAO    q_VSP%rowtype;
    l_VSP_GERACAO    boolean;
  ------------------------------------------------------
  -- DESPESA / GESTOR / VERIFICAÇÃO DE QUANTIDADE = 0 --
  ------------------------------------------------------
  cursor q_IPS_QUANTIDADE
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select count(*)  QTD_DESPESA
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where ips.VSP_NR_ANO = p_NUM_ANO
            and
            (
             p_COD_DEPENDENCIA_AGRUPADORA = 1
             and
             ips.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
             or
             p_COD_DEPENDENCIA_AGRUPADORA <> 1
             and
             ips.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
            )
            and
            ips.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            ips.VSP_CD_VERSAO = p_COD_VERSAO;
  r_IPS_QUANTIDADE  q_IPS_QUANTIDADE%rowtype;
  --------------------------------
  -- DESPESA / GESTOR / GERAÇÃO --
  --------------------------------
  cursor q_IPS
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
   )
    is
    select ips.COD_DEPENDENCIA_ELABORACAO,
           ips.NR_ITEM,
           ips.DEP_CD_DEPENDENCIA_GERD,
           ips.CC2_CD_CENTRO_CUSTO_GERD,
           ips.FLG_TIPO_CONTA,
           ips.FLG_LANCAMENTO,
           ips.CC1_NR_CONTA,
           ips.DS_ITEM,
           ips.COD_CATALOGO,
           ips.NR_CONTRATO,
           ips.NO_FORNECEDOR,
           ips.DT_INICIO_CONTRATO,
           ips.DT_TERMINO_CONTRATO,
           ips.IND_CONTRATO,
           ips.PRJ_CD_PROJETO,
           ips.DS_JUSTIFICATIVA,
           ips.CD_PRIORIDADE,
           ips.IN_DIMENSIONAMENTO,
           ips.FLG_PLURIANUAL,
           ips.VAL_TOTAL_GESTOR,
           ips.VAL_JAN,
           ips.VAL_FEV,
           ips.VAL_MAR,
           ips.VAL_ABR,
           ips.VAL_MAI,
           ips.VAL_JUN,
           ips.VAL_JUL,
           ips.VAL_AGO,
           ips.VAL_SET,
           ips.VAL_OUT,
           ips.VAL_NOV,
           ips.VAL_DEZ,
           ips.VAL_JAN1,
           ips.VAL_FEV1,
           ips.VAL_MAR1,
           ips.VAL_ABR1,
           ips.VAL_MAI1,
           ips.VAL_JUN1,
           ips.VAL_JUL1,
           ips.VAL_AGO1,
           ips.VAL_SET1,
           ips.VAL_OUT1,
           ips.VAL_NOV1,
           ips.VAL_DEZ1,
           ips.VAL_JAN2,
           ips.VAL_FEV2,
           ips.VAL_MAR2,
           ips.VAL_ABR2,
           ips.VAL_MAI2,
           ips.VAL_JUN2,
           ips.VAL_JUL2,
           ips.VAL_AGO2,
           ips.VAL_SET2,
           ips.VAL_OUT2,
           ips.VAL_NOV2,
           ips.VAL_DEZ2,
           ips.VAL_JAN3,
           ips.VAL_FEV3,
           ips.VAL_MAR3,
           ips.VAL_ABR3,
           ips.VAL_MAI3,
           ips.VAL_JUN3,
           ips.VAL_JUL3,
           ips.VAL_AGO3,
           ips.VAL_SET3,
           ips.VAL_OUT3,
           ips.VAL_NOV3,
           ips.VAL_DEZ3,
           ips.VAL_JAN4,
           ips.VAL_FEV4,
           ips.VAL_MAR4,
           ips.VAL_ABR4,
           ips.VAL_MAI4,
           ips.VAL_JUN4,
           ips.VAL_JUL4,
           ips.VAL_AGO4,
           ips.VAL_SET4,
           ips.VAL_OUT4,
           ips.VAL_NOV4,
           ips.VAL_DEZ4,
           ips.VL_UNITARIO_ITEM,
           ips.QTD_JAN,
           ips.QTD_FEV,
           ips.QTD_MAR,
           ips.QTD_ABR,
           ips.QTD_MAI,
           ips.QTD_JUN,
           ips.QTD_JUL,
           ips.QTD_AGO,
           ips.QTD_SET,
           ips.QTD_OUT,
           ips.QTD_NOV,
           ips.QTD_DEZ,
           ips.VL_UNITARIO_ITEM1,
           ips.QTD_JAN1,
           ips.QTD_FEV1,
           ips.QTD_MAR1,
           ips.QTD_ABR1,
           ips.QTD_MAI1,
           ips.QTD_JUN1,
           ips.QTD_JUL1,
           ips.QTD_AGO1,
           ips.QTD_SET1,
           ips.QTD_OUT1,
           ips.QTD_NOV1,
           ips.QTD_DEZ1,
           ips.VL_UNITARIO_ITEM2,
           ips.QTD_JAN2,
           ips.QTD_FEV2,
           ips.QTD_MAR2,
           ips.QTD_ABR2,
           ips.QTD_MAI2,
           ips.QTD_JUN2,
           ips.QTD_JUL2,
           ips.QTD_AGO2,
           ips.QTD_SET2,
           ips.QTD_OUT2,
           ips.QTD_NOV2,
           ips.QTD_DEZ2,
           ips.VL_UNITARIO_ITEM3,
           ips.QTD_JAN3,
           ips.QTD_FEV3,
           ips.QTD_MAR3,
           ips.QTD_ABR3,
           ips.QTD_MAI3,
           ips.QTD_JUN3,
           ips.QTD_JUL3,
           ips.QTD_AGO3,
           ips.QTD_SET3,
           ips.QTD_OUT3,
           ips.QTD_NOV3,
           ips.QTD_DEZ3,
           ips.VL_UNITARIO_ITEM4,
           ips.QTD_JAN4,
           ips.QTD_FEV4,
           ips.QTD_MAR4,
           ips.QTD_ABR4,
           ips.QTD_MAI4,
           ips.QTD_JUN4,
           ips.QTD_JUL4,
           ips.QTD_AGO4,
           ips.QTD_SET4,
           ips.QTD_OUT4,
           ips.QTD_NOV4,
           ips.QTD_DEZ4,
           ips.SEQ_CARGA_ANO_ORCAMENTO
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where VSP_NR_ANO = p_NUM_ANO
            and
            (
             p_COD_DEPENDENCIA_AGRUPADORA = 1
             and
             ips.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
             or
             p_COD_DEPENDENCIA_AGRUPADORA <> 1
             and
             ips.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
            )
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            VSP_CD_VERSAO = p_COD_VERSAO;
  v_VAL_TOTAL_GESTOR  number(14,2);
  ---------------------------
  -- DESPESA / SOLICITANTE --
  ---------------------------
  cursor q_ISP
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2,
           p_COD_DEPENDENCIA_ELABORACAO  number,
           p_NR_ITEM                     number
          )
    is
    select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
           isp.COD_DEPENDENCIA_SOLICITANTE,
           isp.COD_CENTRO_CUSTO_SOLICITANTE,
           isp.NUM_CONTA_SOLICITANTE,
           isp.VAL_TOTAL_SOLICITANTE,
           isp.FLG_DIMENSIONAMENTO,
           isp.COD_PROJETO
      from ITEM_SOLICITANTE_PROPOSTA  isp
      where isp.VSP_NR_ANO = p_NUM_ANO
            and
            (
             p_COD_DEPENDENCIA_AGRUPADORA = 1
             and
             isp.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
             or
             p_COD_DEPENDENCIA_AGRUPADORA <> 1
             and
             isp.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
            )
            and
            isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            isp.VSP_CD_VERSAO = p_COD_VERSAO
            and
            isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
            and
            isp.NR_ITEM = p_NR_ITEM;
  r_ISP  q_ISP%rowtype;
  v_VAL_TOTAL_SOLICITANTE       number(14,2);
  v_IND_EXISTENCIA_SOLICITANTE  boolean;
  --------------------------------------
  -- DESPESA / SOLICITANTE / SEQUENCE --
  --------------------------------------
  cursor q_ISP_SEQUENCE
    is
    select SEQ_ITEM_SOLICITANTE_PROPOSTA.currval  SEQ_ITEM_SOLICITANTE_PROPOSTA
      from DUAL;
  r_ISP_SEQUENCE  q_ISP_SEQUENCE%rowtype;
  ---------------------------
  -- DESPESA / PROGRAMACAO --
  ---------------------------
  cursor q_PSP
          (
           p_SEQ_ISP  number
          )
    is
    select psp.NUM_ANO,
           psp.VAL_JANEIRO,
           psp.VAL_FEVEREIRO,
           psp.VAL_MARCO,
           psp.VAL_ABRIL,
           psp.VAL_MAIO,
           psp.VAL_JUNHO,
           psp.VAL_JULHO,
           psp.VAL_AGOSTO,
           psp.VAL_SETEMBRO,
           psp.VAL_OUTUBRO,
           psp.VAL_NOVEMBRO,
           psp.VAL_DEZEMBRO,
           psp.VAL_UNITARIO,
           psp.QTD_JANEIRO,
           psp.QTD_FEVEREIRO,
           psp.QTD_MARCO,
           psp.QTD_ABRIL,
           psp.QTD_MAIO,
           psp.QTD_JUNHO,
           psp.QTD_JULHO,
           psp.QTD_AGOSTO,
           psp.QTD_SETEMBRO,
           psp.QTD_OUTUBRO,
           psp.QTD_NOVEMBRO,
           psp.QTD_DEZEMBRO
      from PROGRAMACAO_SOLIC_PROPOSTA  psp
      where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ISP;
  r_PSP  q_PSP%rowtype;
  v_VAL_TOTAL_PROGRAMACAO       number(14,2);
  v_IND_EXISTENCIA_PROGRAMACAO  boolean;
  --------------------------------------
  -- DESPESA / PROGRAMACAO / SEQUENCE --
  --------------------------------------
  cursor q_PSP_SEQUENCE
    is
    select SEQ_PROGRAMACAO_SOLIC_PROPOSTA.currval  SEQ_PROGRAMACAO_SOLIC_PROPOSTA
      from DUAL;
  r_PSP_SEQUENCE  q_PSP_SEQUENCE%rowtype;
  ---------------------------------------------
  -- RECEITA / VERIFICAÇÃO DE QUANTIDADE = 0 --
  ---------------------------------------------
  cursor q_PRS_QUANTIDADE
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select count(*)  QTD_RECEITA
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO
            and
            (
             p_COD_DEPENDENCIA_AGRUPADORA = 1
             and
             prs.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
             or
             p_COD_DEPENDENCIA_AGRUPADORA <> 1
             and
             prs.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
            )
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO;
  r_PRS_QUANTIDADE  q_PRS_QUANTIDADE%rowtype;
  -------------
  -- RECEITA --
  -------------
  cursor q_PRS
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select prs.COD_DEPENDENCIA_ELABORACAO,
           prs.NR_SEQ,
           prs.CC1_NR_CONTA,
           prs.TAR_CD_REGIME,
           prs.VAL_JAN,
           prs.VAL_FEV,
           prs.VAL_MAR,
           prs.VAL_ABR,
           prs.VAL_MAI,
           prs.VAL_JUN,
           prs.VAL_JUL,
           prs.VAL_AGO,
           prs.VAL_SET,
           prs.VAL_OUT,
           prs.VAL_NOV,
           prs.VAL_DEZ,
           prs.VAL_JAN1,
           prs.VAL_FEV1,
           prs.VAL_MAR1,
           prs.VAL_ABR1,
           prs.VAL_MAI1,
           prs.VAL_JUN1,
           prs.VAL_JUL1,
           prs.VAL_AGO1,
           prs.VAL_SET1,
           prs.VAL_OUT1,
           prs.VAL_NOV1,
           prs.VAL_DEZ1,
           prs.VAL_JAN2,
           prs.VAL_FEV2,
           prs.VAL_MAR2,
           prs.VAL_ABR2,
           prs.VAL_MAI2,
           prs.VAL_JUN2,
           prs.VAL_JUL2,
           prs.VAL_AGO2,
           prs.VAL_SET2,
           prs.VAL_OUT2,
           prs.VAL_NOV2,
           prs.VAL_DEZ2,
           prs.VAL_JAN3,
           prs.VAL_FEV3,
           prs.VAL_MAR3,
           prs.VAL_ABR3,
           prs.VAL_MAI3,
           prs.VAL_JUN3,
           prs.VAL_JUL3,
           prs.VAL_AGO3,
           prs.VAL_SET3,
           prs.VAL_OUT3,
           prs.VAL_NOV3,
           prs.VAL_DEZ3,
           prs.VAL_JAN4,
           prs.VAL_FEV4,
           prs.VAL_MAR4,
           prs.VAL_ABR4,
           prs.VAL_MAI4,
           prs.VAL_JUN4,
           prs.VAL_JUL4,
           prs.VAL_AGO4,
           prs.VAL_SET4,
           prs.VAL_OUT4,
           prs.VAL_NOV4,
           prs.VAL_DEZ4
      from PROJECAO_RECEITA_SIMULADA  prs
      where prs.VSP_NR_ANO = p_NUM_ANO
            and
            (
             p_COD_DEPENDENCIA_AGRUPADORA = 1
             and
             prs.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 2)
             or
             p_COD_DEPENDENCIA_AGRUPADORA <> 1
             and
             prs.VSP_CD_NIVEL_VERSAO = to_char(p_COD_NIVEL - 1)
            )
            and
            prs.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            prs.VSP_CD_VERSAO = p_COD_VERSAO;
  BEGIN
    p_IND_RETORNO := true;
    ------------------------------------------------
    -- PASSO 01 - EXCLUSÃO DE DESPESA/PROGRAMAÇÃO --
    ------------------------------------------------
    delete
      from PROGRAMACAO_SOLIC_PROPOSTA
      where SEQ_ITEM_SOLICITANTE_PROPOSTA
            in
            (
             select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
               from ITEM_SOLICITANTE_PROPOSTA isp
               where isp.VSP_NR_ANO = p_NUM_ANO
                     and
                     isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
                     and
                     isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            );
    ------------------------------------------------
    -- PASSO 02 - EXCLUSÃO DE DESPESA/SOLICITANTE --
    ------------------------------------------------
    delete
      from ITEM_SOLICITANTE_PROPOSTA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    -------------------------------------------
    -- PASSO 03 - EXCLUSÃO DE DESPESA/GESTOR --
    -------------------------------------------
    delete
      from ITEM_PROPOSTA_ORC_SIMULADA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    ------------------------------------
    -- PASSO 04 - EXCLUSÃO DE RECEITA --
    ------------------------------------
    delete
      from PROJECAO_RECEITA_SIMULADA
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA;
    -----------------------------------------------------
    -- PASSO 05 - EXCLUSÃO DE CONTROLE DE NÍVEL/VERSÃO --
    -----------------------------------------------------
    delete
      from VERSAO_SIMULACAO_PROPOSTA_ORC
      where NR_ANO = p_NUM_ANO
            and
            CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            DEP_CD_DEPENDENCIA = p_COD_DEPENDENCIA_AGRUPADORA;
    --------------------------------------------------------------------
    -- PASSO 06 - VERIFICAÇÃO DE DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
    --------------------------------------------------------------------
    l_DEP_VSP_NAO_ESCOLHIDA := FALSE;
    for f_DEP_VSP_NAO_ESCOLHIDA in q_DEP_VSP_NAO_ESCOLHIDA
                                    (
                                     p_NUM_ANO,
                                     p_COD_NIVEL,
                                     p_COD_DEPENDENCIA_AGRUPADORA
                                    )
    LOOP
      ----------------------------------------------------------------
      -- PASSO 07 - OBTENÇÃO DA LISTA DE DEPENDÊNCIAS PARA MENSAGEM --
      ----------------------------------------------------------------
      IF     l_DEP_VSP_NAO_ESCOLHIDA = FALSE
      THEN
        l_DEP_VSP_NAO_ESCOLHIDA := true;
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'A(s) dependência(s):  ';
        p_DSC_RETORNO := p_DSC_RETORNO ||f_DEP_VSP_NAO_ESCOLHIDA.DEP_CODIGO;
      ELSIF  l_DEP_VSP_NAO_ESCOLHIDA = TRUE
      THEN
        p_DSC_RETORNO := p_DSC_RETORNO ||','||f_DEP_VSP_NAO_ESCOLHIDA.DEP_CODIGO;
      END IF;
    END LOOP;
    IF l_DEP_VSP_NAO_ESCOLHIDA = TRUE
    THEN
      p_DSC_RETORNO := p_DSC_RETORNO ||' não está(ão) escolhida(s).';
      GOTO FIM;
    END IF;
    --------------------------------------------------------------
    -- PASSO 08 - CRIA NÍVEL/VERSÃO EM CADASTRO DE NÍVEL/VERSÃO --
    --------------------------------------------------------------
    BEGIN
      insert into VERSAO_SIMULACAO_PROPOSTA_ORC
       (
        NR_ANO,
        CD_NIVEL_VERSAO,
        DEP_CD_DEPENDENCIA,
        CD_VERSAO,
        DS_VERSAO,
        VSP_NR_ANO,
        VSP_CD_NIVEL_VERSAO,
        VSP_DEP_CD_DEPENDENCIA,
        VSP_CD_VERSAO,
        IN_ESCOLHIDA,
        IN_LIBERADA
       )
      values
       (
        p_NUM_ANO,
        p_COD_NIVEL,
        p_COD_DEPENDENCIA_AGRUPADORA,
        '1',
        'GERAÇÃO DE NÍVEL',
        null,
        null,
        null,
        null,
        0,
        0
       );
    --------------------------------------
    -- PASSO 09 - INTERRUPÇÃO POR FALHA --
    --------------------------------------
    EXCEPTION
      WHEN OTHERS
      THEN
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Tabela VERSAO_SIMULACAO_PROPOSTA_ORC : '||CHR(10)||
                         sqlerrm;
        GOTO FIM;
    END;
    ------------------------------------------------------
    -- PASSO 10 - DEPENDENCIA + VINCULADAS PARA GERAÇÃO --
    ------------------------------------------------------
    for f_DEP_GERACAO in q_DEP
                          (
                           p_NUM_ANO,
                           p_COD_DEPENDENCIA_AGRUPADORA
                          )
    LOOP
      -------------------------------------------------
      -- PASSO 11 - PESQUISA DE VERSÃO NÃO ESCOLHIDA --
      -------------------------------------------------
      open q_VSP
            (
             p_NUM_ANO,
             p_COD_NIVEL,
             f_DEP_GERACAO.DEP_CODIGO
            );
      fetch q_VSP into r_VSP_GERACAO;
      l_VSP_GERACAO := q_VSP%found;
      close q_VSP;
      -----------------------------------------------------
      -- PASSO 12 - DEPENDÊNCIA COM VERSÃO NÃO ESCOLHIDA --
      -----------------------------------------------------
      IF not l_VSP_GERACAO
      THEN
        --------------------------------------
        -- PASSO 10 - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'A dependência '||f_DEP_GERACAO.DEP_CODIGO||' não foi escolhida.';
        GOTO FIM;
      END IF;
      -----------------------------------------------------------------
      -- PASSO 13 - DESPESA / GESTOR / VERIFICAÇÃO DE QUANTIDADE = 0 --
      -----------------------------------------------------------------
      open q_IPS_QUANTIDADE
            (
             p_NUM_ANO,
             p_COD_NIVEL,
             f_dep_geracao.DEP_CODIGO,
             r_vsp_geracao.CD_VERSAO
            );
      fetch q_IPS_QUANTIDADE into r_IPS_QUANTIDADE;
      close q_IPS_QUANTIDADE;
      IF r_IPS_QUANTIDADE.QTD_DESPESA = 0
      THEN
        --------------------------------------
        -- PASSO 14 - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Despesa inexistente para :'||chr(10)||
                         '   Ano.........: '||p_NUM_ANO||chr(10)||
                         '   Nível.......: '||to_char(p_COD_NIVEL-1)||chr(10)||
                         '   Dependência.: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                         '   Versão......: '||r_vsp_geracao.CD_VERSAO||'.';
        GOTO FIM;
      END IF;
      v_VAL_TOTAL_GESTOR := 0;
      --------------------------------------------
      -- PASSO 15 - LEITURA DE DESPESA / GESTOR --
      --------------------------------------------
      for f_IPS in q_IPS
                    (
                     p_NUM_ANO,
                     p_COD_NIVEL,
                     f_dep_geracao.DEP_CODIGO,
                     r_vsp_geracao.CD_VERSAO
                    )
      LOOP
        ----------------------------------------------------------------------------
        -- PASSO 16 - CALCULO DE TOTALIZAÇÃO / GESTOR + SOLICITANTE + PROGRAMACAO --
        ----------------------------------------------------------------------------
        v_VAL_TOTAL_SOLICITANTE := 0;
        v_VAL_TOTAL_PROGRAMACAO := 0;
        v_VAL_TOTAL_GESTOR      := f_ips.VAL_TOTAL_GESTOR;
        v_IND_EXISTENCIA_SOLICITANTE := false;
        v_IND_EXISTENCIA_PROGRAMACAO := false;
        ---------------------------------------------
        -- PASSO 17 - INSERÇÃO DE DESPESA / GESTOR --
        ---------------------------------------------
        BEGIN
          insert
            into ITEM_PROPOSTA_ORC_SIMULADA
             (
              VSP_NR_ANO,
              VSP_CD_NIVEL_VERSAO,
              COD_DEPENDENCIA_AGRUPADORA,
              VSP_CD_VERSAO,
              COD_DEPENDENCIA_ELABORACAO,
              NR_ITEM,
              DEP_CD_DEPENDENCIA_GERD,
              CC2_CD_CENTRO_CUSTO_GERD,
              FLG_TIPO_CONTA,
              FLG_LANCAMENTO,
              CC1_NR_CONTA,
              DS_ITEM,
              COD_CATALOGO,
              NR_CONTRATO,
              NO_FORNECEDOR,
              DT_INICIO_CONTRATO,
              DT_TERMINO_CONTRATO,
              IND_CONTRATO,
              PRJ_CD_PROJETO,
              DS_JUSTIFICATIVA,
              CD_PRIORIDADE,
              IN_DIMENSIONAMENTO,
              FLG_PLURIANUAL,
              VAL_TOTAL_GESTOR,
              VAL_JAN,
              VAL_FEV,
              VAL_MAR,
              VAL_ABR,
              VAL_MAI,
              VAL_JUN,
              VAL_JUL,
              VAL_AGO,
              VAL_SET,
              VAL_OUT,
              VAL_NOV,
              VAL_DEZ,
              VAL_JAN1,
              VAL_FEV1,
              VAL_MAR1,
              VAL_ABR1,
              VAL_MAI1,
              VAL_JUN1,
              VAL_JUL1,
              VAL_AGO1,
              VAL_SET1,
              VAL_OUT1,
              VAL_NOV1,
              VAL_DEZ1,
              VAL_JAN2,
              VAL_FEV2,
              VAL_MAR2,
              VAL_ABR2,
              VAL_MAI2,
              VAL_JUN2,
              VAL_JUL2,
              VAL_AGO2,
              VAL_SET2,
              VAL_OUT2,
              VAL_NOV2,
              VAL_DEZ2,
              VAL_JAN3,
              VAL_FEV3,
              VAL_MAR3,
              VAL_ABR3,
              VAL_MAI3,
              VAL_JUN3,
              VAL_JUL3,
              VAL_AGO3,
              VAL_SET3,
              VAL_OUT3,
              VAL_NOV3,
              VAL_DEZ3,
              VAL_JAN4,
              VAL_FEV4,
              VAL_MAR4,
              VAL_ABR4,
              VAL_MAI4,
              VAL_JUN4,
              VAL_JUL4,
              VAL_AGO4,
              VAL_SET4,
              VAL_OUT4,
              VAL_NOV4,
              VAL_DEZ4,
              VL_UNITARIO_ITEM,
              QTD_JAN,
              QTD_FEV,
              QTD_MAR,
              QTD_ABR,
              QTD_MAI,
              QTD_JUN,
              QTD_JUL,
              QTD_AGO,
              QTD_SET,
              QTD_OUT,
              QTD_NOV,
              QTD_DEZ,
              VL_UNITARIO_ITEM1,
              QTD_JAN1,
              QTD_FEV1,
              QTD_MAR1,
              QTD_ABR1,
              QTD_MAI1,
              QTD_JUN1,
              QTD_JUL1,
              QTD_AGO1,
              QTD_SET1,
              QTD_OUT1,
              QTD_NOV1,
              QTD_DEZ1,
              VL_UNITARIO_ITEM2,
              QTD_JAN2,
              QTD_FEV2,
              QTD_MAR2,
              QTD_ABR2,
              QTD_MAI2,
              QTD_JUN2,
              QTD_JUL2,
              QTD_AGO2,
              QTD_SET2,
              QTD_OUT2,
              QTD_NOV2,
              QTD_DEZ2,
              VL_UNITARIO_ITEM3,
              QTD_JAN3,
              QTD_FEV3,
              QTD_MAR3,
              QTD_ABR3,
              QTD_MAI3,
              QTD_JUN3,
              QTD_JUL3,
              QTD_AGO3,
              QTD_SET3,
              QTD_OUT3,
              QTD_NOV3,
              QTD_DEZ3,
              VL_UNITARIO_ITEM4,
              QTD_JAN4,
              QTD_FEV4,
              QTD_MAR4,
              QTD_ABR4,
              QTD_MAI4,
              QTD_JUN4,
              QTD_JUL4,
              QTD_AGO4,
              QTD_SET4,
              QTD_OUT4,
              QTD_NOV4,
              QTD_DEZ4,
              SEQ_CARGA_ANO_ORCAMENTO,
              FLG_OPERACAO_INCLUSAO
             )
            values
             (
              p_NUM_ANO,
              p_COD_NIVEL,
              p_COD_DEPENDENCIA_AGRUPADORA,
              '1',
              f_ips.COD_DEPENDENCIA_ELABORACAO,
              f_ips.NR_ITEM,
              f_ips.DEP_CD_DEPENDENCIA_GERD,
              f_ips.CC2_CD_CENTRO_CUSTO_GERD,
              f_ips.FLG_TIPO_CONTA,
              f_ips.FLG_LANCAMENTO,
              f_ips.CC1_NR_CONTA,
              f_ips.DS_ITEM,
              f_ips.COD_CATALOGO,
              f_ips.NR_CONTRATO,
              f_ips.NO_FORNECEDOR,
              f_ips.DT_INICIO_CONTRATO,
              f_ips.DT_TERMINO_CONTRATO,
              f_ips.IND_CONTRATO,
              f_ips.PRJ_CD_PROJETO,
              f_ips.DS_JUSTIFICATIVA,
              f_ips.CD_PRIORIDADE,
              f_ips.IN_DIMENSIONAMENTO,
              f_ips.FLG_PLURIANUAL,
              f_ips.VAL_TOTAL_GESTOR,
              f_ips.VAL_JAN,
              f_ips.VAL_FEV,
              f_ips.VAL_MAR,
              f_ips.VAL_ABR,
              f_ips.VAL_MAI,
              f_ips.VAL_JUN,
              f_ips.VAL_JUL,
              f_ips.VAL_AGO,
              f_ips.VAL_SET,
              f_ips.VAL_OUT,
              f_ips.VAL_NOV,
              f_ips.VAL_DEZ,
              f_ips.VAL_JAN1,
              f_ips.VAL_FEV1,
              f_ips.VAL_MAR1,
              f_ips.VAL_ABR1,
              f_ips.VAL_MAI1,
              f_ips.VAL_JUN1,
              f_ips.VAL_JUL1,
              f_ips.VAL_AGO1,
              f_ips.VAL_SET1,
              f_ips.VAL_OUT1,
              f_ips.VAL_NOV1,
              f_ips.VAL_DEZ1,
              f_ips.VAL_JAN2,
              f_ips.VAL_FEV2,
              f_ips.VAL_MAR2,
              f_ips.VAL_ABR2,
              f_ips.VAL_MAI2,
              f_ips.VAL_JUN2,
              f_ips.VAL_JUL2,
              f_ips.VAL_AGO2,
              f_ips.VAL_SET2,
              f_ips.VAL_OUT2,
              f_ips.VAL_NOV2,
              f_ips.VAL_DEZ2,
              f_ips.VAL_JAN3,
              f_ips.VAL_FEV3,
              f_ips.VAL_MAR3,
              f_ips.VAL_ABR3,
              f_ips.VAL_MAI3,
              f_ips.VAL_JUN3,
              f_ips.VAL_JUL3,
              f_ips.VAL_AGO3,
              f_ips.VAL_SET3,
              f_ips.VAL_OUT3,
              f_ips.VAL_NOV3,
              f_ips.VAL_DEZ3,
              f_ips.VAL_JAN4,
              f_ips.VAL_FEV4,
              f_ips.VAL_MAR4,
              f_ips.VAL_ABR4,
              f_ips.VAL_MAI4,
              f_ips.VAL_JUN4,
              f_ips.VAL_JUL4,
              f_ips.VAL_AGO4,
              f_ips.VAL_SET4,
              f_ips.VAL_OUT4,
              f_ips.VAL_NOV4,
              f_ips.VAL_DEZ4,
              f_ips.VL_UNITARIO_ITEM,
              f_ips.QTD_JAN,
              f_ips.QTD_FEV,
              f_ips.QTD_MAR,
              f_ips.QTD_ABR,
              f_ips.QTD_MAI,
              f_ips.QTD_JUN,
              f_ips.QTD_JUL,
              f_ips.QTD_AGO,
              f_ips.QTD_SET,
              f_ips.QTD_OUT,
              f_ips.QTD_NOV,
              f_ips.QTD_DEZ,
              f_ips.VL_UNITARIO_ITEM1,
              f_ips.QTD_JAN1,
              f_ips.QTD_FEV1,
              f_ips.QTD_MAR1,
              f_ips.QTD_ABR1,
              f_ips.QTD_MAI1,
              f_ips.QTD_JUN1,
              f_ips.QTD_JUL1,
              f_ips.QTD_AGO1,
              f_ips.QTD_SET1,
              f_ips.QTD_OUT1,
              f_ips.QTD_NOV1,
              f_ips.QTD_DEZ1,
              f_ips.VL_UNITARIO_ITEM2,
              f_ips.QTD_JAN2,
              f_ips.QTD_FEV2,
              f_ips.QTD_MAR2,
              f_ips.QTD_ABR2,
              f_ips.QTD_MAI2,
              f_ips.QTD_JUN2,
              f_ips.QTD_JUL2,
              f_ips.QTD_AGO2,
              f_ips.QTD_SET2,
              f_ips.QTD_OUT2,
              f_ips.QTD_NOV2,
              f_ips.QTD_DEZ2,
              f_ips.VL_UNITARIO_ITEM3,
              f_ips.QTD_JAN3,
              f_ips.QTD_FEV3,
              f_ips.QTD_MAR3,
              f_ips.QTD_ABR3,
              f_ips.QTD_MAI3,
              f_ips.QTD_JUN3,
              f_ips.QTD_JUL3,
              f_ips.QTD_AGO3,
              f_ips.QTD_SET3,
              f_ips.QTD_OUT3,
              f_ips.QTD_NOV3,
              f_ips.QTD_DEZ3,
              f_ips.VL_UNITARIO_ITEM4,
              f_ips.QTD_JAN4,
              f_ips.QTD_FEV4,
              f_ips.QTD_MAR4,
              f_ips.QTD_ABR4,
              f_ips.QTD_MAI4,
              f_ips.QTD_JUN4,
              f_ips.QTD_JUL4,
              f_ips.QTD_AGO4,
              f_ips.QTD_SET4,
              f_ips.QTD_OUT4,
              f_ips.QTD_NOV4,
              f_ips.QTD_DEZ4,
              f_ips.SEQ_CARGA_ANO_ORCAMENTO,
              'N'
             );
        EXCEPTION
          WHEN OTHERS
          THEN
            --------------------------------------------
            -- PASSO 18 - INTERRUPÇÃO - ERRO DE DADOS --
            --------------------------------------------
            p_IND_RETORNO := false;
            p_DSC_RETORNO := 'Tabela ITEM_PROPOSTA_ORC_SIMULADA'||chr(10)||
                             'Ano..............: '||p_NUM_ANO||chr(10)||
                             'Nível............: '||p_COD_NIVEL||chr(10)||
                             'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                             'Versão...........: '||'1'||chr(10)||
                             'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                             'Sequencia Item...: '||f_ips.NR_ITEM||chr(10)||
                             sqlerrm;
          GOTO FIM;
        END;
        -------------------------------------------------
        -- PASSO 19 - LEITURA DE DESPESA / SOLICITANTE --
        -------------------------------------------------
        for f_ISP in q_ISP
                      (
                       p_NUM_ANO,
                       p_COD_NIVEL,
                       f_dep_geracao.DEP_CODIGO,
                       r_vsp_geracao.CD_VERSAO,
                       f_ips.COD_DEPENDENCIA_ELABORACAO,
                       f_ips.NR_ITEM
                      )
        LOOP
          v_IND_EXISTENCIA_SOLICITANTE := true;
          -----------------------------------------------------
          -- PASSO 20 - CALCULO DE TOTALIZAÇÃO / SOLICITANTE --
          -----------------------------------------------------
          v_VAL_TOTAL_SOLICITANTE := v_VAL_TOTAL_SOLICITANTE + f_ISP.VAL_TOTAL_SOLICITANTE;
          --------------------------------------------------
          -- PASSO 21 - INSERÇÃO DE DESPESA / SOLICITANTE --
          --------------------------------------------------
          BEGIN
            insert
              into ITEM_SOLICITANTE_PROPOSTA
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA,
                VSP_NR_ANO,
                VSP_CD_NIVEL_VERSAO,
                COD_DEPENDENCIA_AGRUPADORA,
                VSP_CD_VERSAO,
                COD_DEPENDENCIA_ELABORACAO,
                NR_ITEM,
                COD_DEPENDENCIA_SOLICITANTE,
                COD_CENTRO_CUSTO_SOLICITANTE,
                NUM_CONTA_SOLICITANTE,
                VAL_TOTAL_SOLICITANTE,
                FLG_DIMENSIONAMENTO,
                COD_PROJETO
               )
              values
               (
                SEQ_ITEM_SOLICITANTE_PROPOSTA.nextval,
                p_NUM_ANO,
                p_COD_NIVEL,
                p_COD_DEPENDENCIA_AGRUPADORA,
                '1',
                f_ips.COD_DEPENDENCIA_ELABORACAO,
                f_ips.NR_ITEM,
                f_isp.COD_DEPENDENCIA_SOLICITANTE,
                f_isp.COD_CENTRO_CUSTO_SOLICITANTE,
                f_isp.NUM_CONTA_SOLICITANTE,
                f_isp.VAL_TOTAL_SOLICITANTE,
                f_isp.FLG_DIMENSIONAMENTO,
                f_isp.COD_PROJETO
               );
          EXCEPTION
            WHEN OTHERS
            THEN
              --------------------------------------------
              -- PASSO 22 - INTERRUPÇÃO - ERRO DE DADOS --
              --------------------------------------------
              open q_ISP_SEQUENCE;
              fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
              close q_ISP_SEQUENCE;
              p_IND_RETORNO := false;
              p_DSC_RETORNO := 'Tabela ITEM_SOLICITANTE_PROPOSTA '||chr(10)||
                               'Ano...................: '||p_NUM_ANO||chr(10)||
                               'Nível.................: '||p_COD_NIVEL||chr(10)||
                               'Dep.Agrupadora........: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                               'Versão................: '||'1'||chr(10)||
                               'Dep.Elaboração........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                               'Sequencia Item........: '||f_ips.NR_ITEM||chr(10)||
                               'Sequência Solicitante.: '||r_isp_sequence.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                               sqlerrm;
            GOTO FIM;
          END;
          -------------------------------------------------
          -- PASSO 23 - LEITURA DE DESPESA / PROGRAMACAO --
          -------------------------------------------------
          for f_PSP in q_PSP
                        (
                         f_isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
                        )
          LOOP
            v_IND_EXISTENCIA_PROGRAMACAO := true;
            -----------------------------------------------------
            -- PASSO 24 - CALCULO DE TOTALIZAÇÃO / PROGRAMACAO --
            -----------------------------------------------------
            IF f_PSP.NUM_ANO = p_NUM_ANO
            THEN
              v_VAL_TOTAL_PROGRAMACAO := v_VAL_TOTAL_PROGRAMACAO + f_psp.VAL_JANEIRO
                                                                 + f_psp.VAL_FEVEREIRO
                                                                 + f_psp.VAL_MARCO
                                                                 + f_psp.VAL_ABRIL
                                                                 + f_psp.VAL_MAIO
                                                                 + f_psp.VAL_JUNHO
                                                                 + f_psp.VAL_JULHO
                                                                 + f_psp.VAL_AGOSTO
                                                                 + f_psp.VAL_SETEMBRO
                                                                 + f_psp.VAL_OUTUBRO
                                                                 + f_psp.VAL_NOVEMBRO
                                                                 + f_psp.VAL_DEZEMBRO;
            END IF;
            --------------------------------------------------
            -- PASSO 25 - INSERÇÃO DE DESPESA / PROGRAMACAO --
            --------------------------------------------------
            BEGIN
              insert
                into PROGRAMACAO_SOLIC_PROPOSTA
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA,
                  NUM_ANO,
                  VAL_JANEIRO,
                  VAL_FEVEREIRO,
                  VAL_MARCO,
                  VAL_ABRIL,
                  VAL_MAIO,
                  VAL_JUNHO,
                  VAL_JULHO,
                  VAL_AGOSTO,
                  VAL_SETEMBRO,
                  VAL_OUTUBRO,
                  VAL_NOVEMBRO,
                  VAL_DEZEMBRO,
                  VAL_UNITARIO,
                  QTD_JANEIRO,
                  QTD_FEVEREIRO,
                  QTD_MARCO,
                  QTD_ABRIL,
                  QTD_MAIO,
                  QTD_JUNHO,
                  QTD_JULHO,
                  QTD_AGOSTO,
                  QTD_SETEMBRO,
                  QTD_OUTUBRO,
                  QTD_NOVEMBRO,
                  QTD_DEZEMBRO
                 )
                values
                 (
                  SEQ_PROGRAMACAO_SOLIC_PROPOSTA.nextval,
                  SEQ_ITEM_SOLICITANTE_PROPOSTA.currval,
                  f_psp.NUM_ANO,
                  f_psp.VAL_JANEIRO,
                  f_psp.VAL_FEVEREIRO,
                  f_psp.VAL_MARCO,
                  f_psp.VAL_ABRIL,
                  f_psp.VAL_MAIO,
                  f_psp.VAL_JUNHO,
                  f_psp.VAL_JULHO,
                  f_psp.VAL_AGOSTO,
                  f_psp.VAL_SETEMBRO,
                  f_psp.VAL_OUTUBRO,
                  f_psp.VAL_NOVEMBRO,
                  f_psp.VAL_DEZEMBRO,
                  f_psp.VAL_UNITARIO,
                  f_psp.QTD_JANEIRO,
                  f_psp.QTD_FEVEREIRO,
                  f_psp.QTD_MARCO,
                  f_psp.QTD_ABRIL,
                  f_psp.QTD_MAIO,
                  f_psp.QTD_JUNHO,
                  f_psp.QTD_JULHO,
                  f_psp.QTD_AGOSTO,
                  f_psp.QTD_SETEMBRO,
                  f_psp.QTD_OUTUBRO,
                  f_psp.QTD_NOVEMBRO,
                  f_psp.QTD_DEZEMBRO
                 );
            EXCEPTION
              WHEN OTHERS
              THEN
                --------------------------------------------
                -- PASSO 26 - INTERRUPÇÃO - ERRO DE DADOS --
                --------------------------------------------
                open q_ISP_SEQUENCE;
                fetch q_ISP_SEQUENCE into r_ISP_SEQUENCE;
                close q_ISP_SEQUENCE;
                open q_PSP_SEQUENCE;
                fetch q_PSP_SEQUENCE into r_PSP_SEQUENCE;
                close q_PSP_SEQUENCE;
                p_IND_RETORNO := false;
                p_DSC_RETORNO := 'Tabela PROGRAMACAO_SOLIC_PROPOSTA '||chr(10)||
                                 'Ano....................: '||p_NUM_ANO||chr(10)||
                                 'Nível..................: '||p_COD_NIVEL||chr(10)||
                                 'Dep.Agrupadora.........: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                                 'Versão.................: '||'1'||chr(10)||
                                 'Dep.Elaboração.........: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                                 'Sequencia Item.........: '||f_ips.NR_ITEM||chr(10)||
                                 'Sequência Solicitante..: '||r_isp_sequence.SEQ_ITEM_SOLICITANTE_PROPOSTA||chr(10)||
                                 'Sequência Programação..: '||r_psp_sequence.SEQ_PROGRAMACAO_SOLIC_PROPOSTA||chr(10)||
                                 sqlerrm;
                GOTO FIM;
            END;
          END LOOP f_PSP;
        END LOOP f_ISP;
        ---------------------------------------------------------------------
        -- PASSO 27 - DIVERGÊNCIA ENTRE VALOR GESTOR, SOLICITANTE E VALOR  --
        ---------------------------------------------------------------------
        IF v_VAL_TOTAL_GESTOR <> v_VAL_TOTAL_SOLICITANTE
           or
           v_VAL_TOTAL_SOLICITANTE <> v_VAL_TOTAL_PROGRAMACAO
        THEN
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Existe uma diferença entre valores (Gestor,Solicitante e Programado) no Item '||
                           f_ips.NR_ITEM||' da Dependência '||f_ips.COD_DEPENDENCIA_ELABORACAO||
                           ' na versão de origem.   É solicitado que verifique este Item.';
          GOTO FIM;
        END IF;
        -------------------------------------------------------------
        -- PASSO 15 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE SOLICITANTE --
        -------------------------------------------------------------
        IF v_IND_EXISTENCIA_SOLICITANTE = false
        THEN
          ------------------------------------------------------------------------
          -- PASSO 16 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE SOLICITANTE --
          ------------------------------------------------------------------------
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Solicitante(Resultado) não foi encontrado no Item : '||chr(10)||
                           'Ano..............: '||p_NUM_ANO||chr(10)||
                           'Nível............: '||p_COD_NIVEL||chr(10)||
                           'Dep.Agrupadora...: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                           'Versão...........: '||'1'||chr(10)||
                           'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Número do Item...: '||f_ips.NR_ITEM||chr(10)||
                           SQLERRM;
          GOTO FIM;
        END IF;
        -------------------------------------------------------------
        -- PASSO 17 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE PROGRAMACAO --
        -------------------------------------------------------------
        IF v_IND_EXISTENCIA_PROGRAMACAO = false
        THEN
          ------------------------------------------------------------------------
          -- PASSO 18 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE PROGRAMACAO --
          ------------------------------------------------------------------------
          p_IND_RETORNO := false;
          p_DSC_RETORNO := 'Programação não foi encontrada no Item : '||chr(10)||
                           'Ano..............: '||p_NUM_ANO||chr(10)||
                           'Nível............: '||p_COD_NIVEL||chr(10)||
                           'Dep.Agrupadora...: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                           'Versão...........: '||'1'||chr(10)||
                           'Dep.Elaboração...: '||f_ips.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                           'Número do Item...: '||f_ips.NR_ITEM||chr(10)||
                           SQLERRM;
          GOTO FIM;
        END IF;
      END LOOP r_IPS;
      --------------------------------------------------------
      -- PASSO 28 - RECEITA / VERIFICAÇÃO DE QUANTIDADE = 0 --
      --------------------------------------------------------
      open q_PRS_QUANTIDADE
            (
             p_NUM_ANO,
             p_COD_NIVEL,
             f_dep_geracao.DEP_CODIGO,
             r_vsp_geracao.CD_VERSAO
            );
      fetch q_PRS_QUANTIDADE into r_PRS_QUANTIDADE;
      close q_PRS_QUANTIDADE;
      IF r_PRS_QUANTIDADE.QTD_RECEITA = 0
      THEN
        --------------------------------------
        -- PASSO 29 - INTERRUPÇÃO POR DADOS --
        --------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Receita inexistente para :'||chr(10)||
                         '   Ano.........: '||p_NUM_ANO||chr(10)||
                         '   Nível.......: '||to_char(p_COD_NIVEL-1)||chr(10)||
                         '   Dependência.: '||f_dep_geracao.DEP_CODIGO||chr(10)||
                         '   Versão......: '||r_vsp_geracao.CD_VERSAO||'.';
        GOTO FIM;
      END IF;
      --------------------------------------------------
      -- PASSO 30 - INSERÇÃO DE RECEITA / PROGRAMACAO --
      --------------------------------------------------
      for f_PRS in q_PRS
                    (
                     p_NUM_ANO,
                     p_COD_NIVEL,
                     f_dep_geracao.DEP_CODIGO,
                     r_vsp_geracao.CD_VERSAO
                    )
      LOOP
        BEGIN
          insert
            into PROJECAO_RECEITA_SIMULADA
             (
              VSP_NR_ANO,
              VSP_CD_NIVEL_VERSAO,
              COD_DEPENDENCIA_AGRUPADORA,
              VSP_CD_VERSAO,
              COD_DEPENDENCIA_ELABORACAO,
              NR_SEQ,
              CC1_NR_CONTA,
              TAR_CD_REGIME,
              VAL_JAN,
              VAL_FEV,
              VAL_MAR,
              VAL_ABR,
              VAL_MAI,
              VAL_JUN,
              VAL_JUL,
              VAL_AGO,
              VAL_SET,
              VAL_OUT,
              VAL_NOV,
              VAL_DEZ,
              VAL_JAN1,
              VAL_FEV1,
              VAL_MAR1,
              VAL_ABR1,
              VAL_MAI1,
              VAL_JUN1,
              VAL_JUL1,
              VAL_AGO1,
              VAL_SET1,
              VAL_OUT1,
              VAL_NOV1,
              VAL_DEZ1,
              VAL_JAN2,
              VAL_FEV2,
              VAL_MAR2,
              VAL_ABR2,
              VAL_MAI2,
              VAL_JUN2,
              VAL_JUL2,
              VAL_AGO2,
              VAL_SET2,
              VAL_OUT2,
              VAL_NOV2,
              VAL_DEZ2,
              VAL_JAN3,
              VAL_FEV3,
              VAL_MAR3,
              VAL_ABR3,
              VAL_MAI3,
              VAL_JUN3,
              VAL_JUL3,
              VAL_AGO3,
              VAL_SET3,
              VAL_OUT3,
              VAL_NOV3,
              VAL_DEZ3,
              VAL_JAN4,
              VAL_FEV4,
              VAL_MAR4,
              VAL_ABR4,
              VAL_MAI4,
              VAL_JUN4,
              VAL_JUL4,
              VAL_AGO4,
              VAL_SET4,
              VAL_OUT4,
              VAL_NOV4,
              VAL_DEZ4
             )
            values
             (
              p_NUM_ANO,
              p_COD_NIVEL,
              p_COD_DEPENDENCIA_AGRUPADORA,
              '1',
              f_prs.COD_DEPENDENCIA_ELABORACAO,
              f_prs.NR_SEQ,
              f_prs.CC1_NR_CONTA,
              f_prs.TAR_CD_REGIME,
              f_prs.VAL_JAN,
              f_prs.VAL_FEV,
              f_prs.VAL_MAR,
              f_prs.VAL_ABR,
              f_prs.VAL_MAI,
              f_prs.VAL_JUN,
              f_prs.VAL_JUL,
              f_prs.VAL_AGO,
              f_prs.VAL_SET,
              f_prs.VAL_OUT,
              f_prs.VAL_NOV,
              f_prs.VAL_DEZ,
              f_prs.VAL_JAN1,
              f_prs.VAL_FEV1,
              f_prs.VAL_MAR1,
              f_prs.VAL_ABR1,
              f_prs.VAL_MAI1,
              f_prs.VAL_JUN1,
              f_prs.VAL_JUL1,
              f_prs.VAL_AGO1,
              f_prs.VAL_SET1,
              f_prs.VAL_OUT1,
              f_prs.VAL_NOV1,
              f_prs.VAL_DEZ1,
              f_prs.VAL_JAN2,
              f_prs.VAL_FEV2,
              f_prs.VAL_MAR2,
              f_prs.VAL_ABR2,
              f_prs.VAL_MAI2,
              f_prs.VAL_JUN2,
              f_prs.VAL_JUL2,
              f_prs.VAL_AGO2,
              f_prs.VAL_SET2,
              f_prs.VAL_OUT2,
              f_prs.VAL_NOV2,
              f_prs.VAL_DEZ2,
              f_prs.VAL_JAN3,
              f_prs.VAL_FEV3,
              f_prs.VAL_MAR3,
              f_prs.VAL_ABR3,
              f_prs.VAL_MAI3,
              f_prs.VAL_JUN3,
              f_prs.VAL_JUL3,
              f_prs.VAL_AGO3,
              f_prs.VAL_SET3,
              f_prs.VAL_OUT3,
              f_prs.VAL_NOV3,
              f_prs.VAL_DEZ3,
              f_prs.VAL_JAN4,
              f_prs.VAL_FEV4,
              f_prs.VAL_MAR4,
              f_prs.VAL_ABR4,
              f_prs.VAL_MAI4,
              f_prs.VAL_JUN4,
              f_prs.VAL_JUL4,
              f_prs.VAL_AGO4,
              f_prs.VAL_SET4,
              f_prs.VAL_OUT4,
              f_prs.VAL_NOV4,
              f_prs.VAL_DEZ4
             );
        EXCEPTION
          WHEN OTHERS
          THEN
            --------------------------------------
            -- PASSO 31 - INTERRUPÇÃO POR DADOS --
            --------------------------------------
            p_IND_RETORNO := false;
            p_DSC_RETORNO := 'Tabela PROJECAO_RECEITA_SIMULADA'||chr(10)||
                             'Ano..............: '||p_NUM_ANO||chr(10)||
                             'Nível............: '||p_COD_NIVEL||chr(10)||
                             'Dep.Agrupadora...: '||p_COD_DEPENDENCIA_AGRUPADORA||chr(10)||
                             'Versão...........: '||'1'||chr(10)||
                             'Dep.Elaboração...: '||f_prs.COD_DEPENDENCIA_ELABORACAO||chr(10)||
                             'Sequencia........: '||f_prs.NR_SEQ||chr(10)||
                             sqlerrm;
          GOTO FIM;
        END;
      END LOOP f_PRS;
    END LOOP f_DEP_GERACAO;
    <<FIM>>
    null;
  END PRC_GERA_NIVEL;
  -------------------------------------------------------------------
  -- VERIFICAÇÃO DE INTEGRIDADE GESTOR X SOLICITANTE X PROGRAMACAO --
  -------------------------------------------------------------------
  PROCEDURE PRC_VERIFICACAO
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_COD_VERSAO                  in       varchar2,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             )
  IS
  ----------------------
  -- DESPESA / GESTOR --
  ----------------------
  cursor q_IPS
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2
          )
    is
    select ips.COD_DEPENDENCIA_ELABORACAO,
           ips.NR_ITEM,
           ips.VAL_TOTAL_GESTOR
      from ITEM_PROPOSTA_ORC_SIMULADA  ips
      where VSP_NR_ANO = p_NUM_ANO
            and
            VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            VSP_CD_VERSAO = p_COD_VERSAO;
  v_VAL_TOTAL_GESTOR  number(14,2);
  ---------------------------
  -- DESPESA / SOLICITANTE --
  ---------------------------
  cursor q_ISP
          (
           p_NUM_ANO                     number,
           p_COD_NIVEL                   varchar2,
           p_COD_DEPENDENCIA_AGRUPADORA  number,
           p_COD_VERSAO                  varchar2,
           p_COD_DEPENDENCIA_ELABORACAO  number,
           p_NR_ITEM                     number
          )
    is
    select isp.SEQ_ITEM_SOLICITANTE_PROPOSTA,
           isp.VAL_TOTAL_SOLICITANTE
      from ITEM_SOLICITANTE_PROPOSTA  isp
      where isp.VSP_NR_ANO = p_NUM_ANO
            and
            isp.VSP_CD_NIVEL_VERSAO = p_COD_NIVEL
            and
            isp.COD_DEPENDENCIA_AGRUPADORA = p_COD_DEPENDENCIA_AGRUPADORA
            and
            isp.VSP_CD_VERSAO = p_COD_VERSAO
            and
            isp.COD_DEPENDENCIA_ELABORACAO = p_COD_DEPENDENCIA_ELABORACAO
            and
            isp.NR_ITEM = p_NR_ITEM;
  r_ISP                         q_ISP%rowtype;
  v_VAL_TOTAL_SOLICITANTE       number(14,2);
  v_IND_EXISTENCIA_SOLICITANTE  boolean;
  ---------------------------
  -- DESPESA / PROGRAMACAO --
  ---------------------------
  cursor q_PSP
          (
           p_SEQ_ISP  number
          )
    is
    select psp.NUM_ANO,
           psp.VAL_JANEIRO,
           psp.VAL_FEVEREIRO,
           psp.VAL_MARCO,
           psp.VAL_ABRIL,
           psp.VAL_MAIO,
           psp.VAL_JUNHO,
           psp.VAL_JULHO,
           psp.VAL_AGOSTO,
           psp.VAL_SETEMBRO,
           psp.VAL_OUTUBRO,
           psp.VAL_NOVEMBRO,
           psp.VAL_DEZEMBRO,
           psp.VAL_UNITARIO,
           psp.QTD_JANEIRO,
           psp.QTD_FEVEREIRO,
           psp.QTD_MARCO,
           psp.QTD_ABRIL,
           psp.QTD_MAIO,
           psp.QTD_JUNHO,
           psp.QTD_JULHO,
           psp.QTD_AGOSTO,
           psp.QTD_SETEMBRO,
           psp.QTD_OUTUBRO,
           psp.QTD_NOVEMBRO,
           psp.QTD_DEZEMBRO
      from PROGRAMACAO_SOLIC_PROPOSTA  psp
      where psp.SEQ_ITEM_SOLICITANTE_PROPOSTA = p_SEQ_ISP;
  r_PSP  q_PSP%rowtype;
  v_VAL_TOTAL_PROGRAMACAO       number(14,2);
  v_IND_EXISTENCIA_PROGRAMACAO  boolean;
  BEGIN
    p_IND_RETORNO := true;
    -------------------------------------------
    -- PASSO 01 - INSERÇÃO DE DESPESA/GESTOR --
    -------------------------------------------
    for f_IPS in q_IPS
                  (
                   p_NUM_ANO,
                   p_COD_NIVEL,
                   p_COD_DEPENDENCIA_AGRUPADORA,
                   p_COD_VERSAO
                  )
    LOOP
      ----------------------------------------------------------------------------
      -- PASSO 02 - CALCULO DE TOTALIZAÇÃO / GESTOR + SOLICITANTE + PROGRAMACAO --
      ----------------------------------------------------------------------------
      v_VAL_TOTAL_GESTOR := f_ips.VAL_TOTAL_GESTOR;
      v_VAL_TOTAL_SOLICITANTE := 0;
      v_VAL_TOTAL_PROGRAMACAO := 0;
      v_IND_EXISTENCIA_SOLICITANTE := false;
      v_IND_EXISTENCIA_PROGRAMACAO := false;
      -------------------------------------------------
      -- PASSO 05 - LEITURA DE DESPESA / SOLICITANTE --
      -------------------------------------------------
      for f_ISP in q_ISP
                    (
                     p_NUM_ANO,
                     p_COD_NIVEL,
                     p_COD_DEPENDENCIA_AGRUPADORA,
                     p_COD_VERSAO,
                     f_ips.COD_DEPENDENCIA_ELABORACAO,
                     f_ips.NR_ITEM
                    )
      LOOP
        v_IND_EXISTENCIA_SOLICITANTE := true;
        -----------------------------------------------------
        -- PASSO 06 - CALCULO DE TOTALIZAÇÃO / SOLICITANTE --
        -----------------------------------------------------
        v_VAL_TOTAL_SOLICITANTE := v_VAL_TOTAL_SOLICITANTE + f_ISP.VAL_TOTAL_SOLICITANTE;
        -------------------------------------------------
        -- PASSO 09 - LEITURA DE DESPESA / PROGRAMACAO --
        -------------------------------------------------
        for f_PSP in q_PSP
                      (
                       f_isp.SEQ_ITEM_SOLICITANTE_PROPOSTA
                      )
        LOOP
          v_IND_EXISTENCIA_PROGRAMACAO := true;
          -----------------------------------------------------
          -- PASSO 10 - CALCULO DE TOTALIZAÇÃO / PROGRAMACAO --
          -----------------------------------------------------
          IF f_PSP.NUM_ANO = p_NUM_ANO
          THEN
            v_VAL_TOTAL_PROGRAMACAO := v_VAL_TOTAL_PROGRAMACAO + f_psp.VAL_JANEIRO
                                                               + f_psp.VAL_FEVEREIRO
                                                               + f_psp.VAL_MARCO
                                                               + f_psp.VAL_ABRIL
                                                               + f_psp.VAL_MAIO
                                                               + f_psp.VAL_JUNHO
                                                               + f_psp.VAL_JULHO
                                                               + f_psp.VAL_AGOSTO
                                                               + f_psp.VAL_SETEMBRO
                                                               + f_psp.VAL_OUTUBRO
                                                               + f_psp.VAL_NOVEMBRO
                                                               + f_psp.VAL_DEZEMBRO;
          END IF;
        END LOOP f_PSP;
      END LOOP f_ISP;
      ------------------------------------------------------------------------------------
      -- PASSO 13 - VERIFICAÇÃO DE DIVERGÊNCIA ENTRE VALOR GESTOR, SOLICITANTE E VALOR  --
      ------------------------------------------------------------------------------------
      IF v_VAL_TOTAL_GESTOR <> v_VAL_TOTAL_SOLICITANTE
         or
         v_VAL_TOTAL_SOLICITANTE <> v_VAL_TOTAL_PROGRAMACAO
      THEN
        ---------------------------------------------------------------------------------
        -- PASSO 14 - MENSAGEM DE DIVERGÊNCIA ENTRE VALOR GESTOR, SOLICITANTE E VALOR  --
        ---------------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Existe uma diferença entre valores (Gestor,Solicitante e Programado) no Item '||
                         f_ips.NR_ITEM||' da Dependência '||f_ips.COD_DEPENDENCIA_ELABORACAO||
                         ' na versão de origem.   É solicitado que verifique este Item.';
        --dbms_output.put_line(p_DSC_RETORNO);
        GOTO FIM;
      END IF;
      -------------------------------------------------------------
      -- PASSO 15 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE SOLICITANTE --
      -------------------------------------------------------------
      IF v_IND_EXISTENCIA_SOLICITANTE = false
      THEN
        ------------------------------------------------------------------------
        -- PASSO 16 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE SOLICITANTE --
        ------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Solicitante(Resultado) não foi encontrado no Item '||f_ips.NR_ITEM||
                         'da Dependência '||f_ips.COD_DEPENDENCIA_ELABORACAO||'.';
        --dbms_output.put_line(p_DSC_RETORNO);
        GOTO FIM;
      END IF;
      -------------------------------------------------------------
      -- PASSO 17 - VERIFICAÇÃO DE NÃO EXISTÊNCIA DE PROGRAMACAO --
      -------------------------------------------------------------
      IF v_IND_EXISTENCIA_PROGRAMACAO = false
      THEN
        ------------------------------------------------------------------------
        -- PASSO 18 - INTERRUPÇÃO - MENSAGEM DE NÃO EXISTÊNCIA DE PROGRAMACAO --
        ------------------------------------------------------------------------
        p_IND_RETORNO := false;
        p_DSC_RETORNO := 'Programação não foi encontrada no Item '||f_ips.NR_ITEM||
                         'da Dependência '||f_ips.COD_DEPENDENCIA_ELABORACAO||'.';
        --dbms_output.put_line(p_DSC_RETORNO);
        GOTO FIM;
      END IF;
    END LOOP r_IPS;
    <<FIM>>
    null;
  END PRC_VERIFICACAO;
END PCK_ANALISE;
/
