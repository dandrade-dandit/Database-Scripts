create or replace package PCK_ANALISE IS 
  procedure PRC_RATEIO_AUTOMATICO
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_COD_VERSAO_ORIGEM           in       varchar2,
              p_COD_DEPENDENCIA_ELABORACAO  in       number,
              p_NR_ITEM                     in       number,
              p_COD_VERSAO_DESTINO          in       varchar2,
              p_CC1_NR_CONTA                in       varchar2,
              p_CC2_CD_CENTRO_CUSTO         in       number,
              p_SEQ_ANO_ORCAMENTO           in       number,
              p_VAL_TOTAL_SOLICITANTE       in  out  number,
              p_VAL_TOTAL_PROGRAMACAO       in  out  number,
              p_IND_RETORNO                 in  out  boolean,
              p_DSC_RETORNO                 in  out  varchar2
             );
  procedure PRC_COPIA_VERSAO
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
             );
  procedure PRC_GERA_NIVEL
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             );
  procedure PRC_VERIFICACAO
             (
              p_NUM_ANO                     in       number,
              p_COD_NIVEL                   in       varchar2,
              p_COD_DEPENDENCIA_AGRUPADORA  in       number,
              p_COD_VERSAO                  in       varchar2,
              p_IND_RETORNO                     out  boolean,
              p_DSC_RETORNO                     out  varchar2
             );
end PCK_ANALISE;
