DROP PACKAGE ifrbde_views.pck_sipreco
/

CREATE OR REPLACE 
PACKAGE ifrbde_views.pck_sipreco AS
   -- tipos globais  
   TYPE tyt_usuario IS TABLE OF ifrbde_views.tab_log.log_usuario%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mensagem IS TABLE OF VARCHAR2 (50)
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
-------------------------
  --- TAB_FORMULARIO
   SUBTYPE t_frm_nome IS ifrbde_views.tab_formulario.frm_nome%TYPE;

   SUBTYPE t_frm_tbl_nome IS ifrbde_views.tab_formulario.frm_tbl_nome%TYPE;

   SUBTYPE t_frm_titulo IS ifrbde_views.tab_formulario.frm_titulo%TYPE;

   SUBTYPE t_frm_frm_pai IS ifrbde_views.tab_formulario.frm_frm_pai%TYPE;

   SUBTYPE t_frm_ordem IS ifrbde_views.tab_formulario.frm_ordem%TYPE;

   SUBTYPE t_frm_ligacao IS ifrbde_views.tab_formulario.frm_ligacao%TYPE;

   TYPE tyt_frm_nome IS TABLE OF t_frm_nome
      INDEX BY BINARY_INTEGER;

   TYPE tyt_frm_tbl_nome IS TABLE OF t_frm_tbl_nome
      INDEX BY BINARY_INTEGER;

   TYPE tyt_frm_titulo IS TABLE OF t_frm_titulo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_frm_frm_pai IS TABLE OF t_frm_frm_pai
      INDEX BY BINARY_INTEGER;

   TYPE tyt_frm_ordem IS TABLE OF t_frm_ordem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_frm_ligacao IS TABLE OF t_frm_ligacao
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome
   );

   PROCEDURE stp_exclui_formulario (
      p_usuario              VARCHAR2,
      vo_ok         OUT      tyt_ok,
      vi_frm_nome   IN       t_frm_nome
   );

   PROCEDURE stp_inclui_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome,
      vi_frm_tbl_nome   IN       t_frm_tbl_nome,
      vi_frm_titulo     IN       t_frm_titulo,
      vi_frm_frm_pai    IN       t_frm_frm_pai,
      vi_frm_ordem      IN       t_frm_ordem,
      vi_frm_ligacao    IN       t_frm_ligacao
   );

   PROCEDURE stp_altera_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome,
      vi_frm_tbl_nome   IN       t_frm_tbl_nome,
      vi_frm_titulo     IN       t_frm_titulo,
      vi_frm_frm_pai    IN       t_frm_frm_pai,
      vi_frm_ordem      IN       t_frm_ordem,
      vi_frm_ligacao    IN       t_frm_ligacao
   );

   
-------------------------
   --- TAB_CAMPO
   SUBTYPE t_cpo_tbl_nome IS ifrbde_views.tab_campo.cpo_tbl_nome%TYPE;

   SUBTYPE t_cpo_nome IS ifrbde_views.tab_campo.cpo_nome%TYPE;

   SUBTYPE t_cpo_titulo IS ifrbde_views.tab_campo.cpo_titulo%TYPE;

   SUBTYPE t_cpo_ordem IS ifrbde_views.tab_campo.cpo_ordem%TYPE;

   SUBTYPE t_cpo_tipo IS ifrbde_views.tab_campo.cpo_tipo%TYPE;

   SUBTYPE t_cpo_chave IS ifrbde_views.tab_campo.cpo_chave%TYPE;

   SUBTYPE t_cpo_obrigatorio IS ifrbde_views.tab_campo.cpo_obrigatorio%TYPE;

   SUBTYPE t_cpo_auto IS ifrbde_views.tab_campo.cpo_auto%TYPE;

   SUBTYPE t_cpo_grid IS ifrbde_views.tab_campo.cpo_grid%TYPE;

   SUBTYPE t_cpo_procura IS ifrbde_views.tab_campo.cpo_procura%TYPE;

   SUBTYPE t_cpo_tamanho IS ifrbde_views.tab_campo.cpo_tamanho%TYPE;

   SUBTYPE t_cpo_linhas IS ifrbde_views.tab_campo.cpo_linhas%TYPE;

   SUBTYPE t_cpo_largura IS ifrbde_views.tab_campo.cpo_largura%TYPE;

   SUBTYPE t_cpo_cols IS ifrbde_views.tab_campo.cpo_cols%TYPE;

   SUBTYPE t_cpo_mascara IS ifrbde_views.tab_campo.cpo_mascara%TYPE;

   SUBTYPE t_cpo_padrao IS ifrbde_views.tab_campo.cpo_padrao%TYPE;

   SUBTYPE t_cpo_opcoes IS ifrbde_views.tab_campo.cpo_opcoes%TYPE;

   SUBTYPE t_cpo_valores IS ifrbde_views.tab_campo.cpo_valores%TYPE;

   SUBTYPE t_cpo_tabela_origem IS ifrbde_views.tab_campo.cpo_tabela_origem%TYPE;

   SUBTYPE t_cpo_campo_origem IS ifrbde_views.tab_campo.cpo_campo_origem%TYPE;

   SUBTYPE t_cpo_campo_exibir IS ifrbde_views.tab_campo.cpo_campo_exibir%TYPE;

   SUBTYPE t_cpo_html_antes IS ifrbde_views.tab_campo.cpo_html_antes%TYPE;

   SUBTYPE t_cpo_html_depois IS ifrbde_views.tab_campo.cpo_html_depois%TYPE;

   TYPE tyt_cpo_tbl_nome IS TABLE OF t_cpo_tbl_nome
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_nome IS TABLE OF t_cpo_nome
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_titulo IS TABLE OF t_cpo_titulo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_ordem IS TABLE OF t_cpo_ordem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_tipo IS TABLE OF t_cpo_tipo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_chave IS TABLE OF t_cpo_chave
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_obrigatorio IS TABLE OF t_cpo_obrigatorio
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_auto IS TABLE OF t_cpo_auto
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_grid IS TABLE OF t_cpo_grid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_procura IS TABLE OF t_cpo_procura
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_tamanho IS TABLE OF t_cpo_tamanho
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_linhas IS TABLE OF t_cpo_linhas
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_largura IS TABLE OF t_cpo_largura
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_cols IS TABLE OF t_cpo_cols
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_mascara IS TABLE OF t_cpo_mascara
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_padrao IS TABLE OF t_cpo_padrao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_opcoes IS TABLE OF t_cpo_opcoes
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_valores IS TABLE OF t_cpo_valores
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_tabela_origem IS TABLE OF t_cpo_tabela_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_campo_origem IS TABLE OF t_cpo_campo_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_campo_exibir IS TABLE OF t_cpo_campo_exibir
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_html_antes IS TABLE OF t_cpo_html_antes
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cpo_html_depois IS TABLE OF t_cpo_html_depois
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome
   );

   PROCEDURE stp_exclui_campo (
      p_usuario                  VARCHAR2,
      vo_ok             OUT      tyt_ok,
      vi_cpo_tbl_nome   IN       t_cpo_tbl_nome,
      vi_cpo_nome       IN       t_cpo_nome
   );

   PROCEDURE stp_inclui_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome,
      vi_cpo_titulo          IN       t_cpo_titulo,
      vi_cpo_ordem           IN       t_cpo_ordem,
      vi_cpo_tipo            IN       t_cpo_tipo,
      vi_cpo_chave           IN       t_cpo_chave,
      vi_cpo_obrigatorio     IN       t_cpo_obrigatorio,
      vi_cpo_auto            IN       t_cpo_auto,
      vi_cpo_grid            IN       t_cpo_grid,
      vi_cpo_procura         IN       t_cpo_procura,
      vi_cpo_tamanho         IN       t_cpo_tamanho,
      vi_cpo_linhas          IN       t_cpo_linhas,
      vi_cpo_largura         IN       t_cpo_largura,
      vi_cpo_cols            IN       t_cpo_cols,
      vi_cpo_mascara         IN       t_cpo_mascara,
      vi_cpo_padrao          IN       t_cpo_padrao,
      vi_cpo_opcoes          IN       t_cpo_opcoes,
      vi_cpo_valores         IN       t_cpo_valores,
      vi_cpo_tabela_origem   IN       t_cpo_tabela_origem,
      vi_cpo_campo_origem    IN       t_cpo_campo_origem,
      vi_cpo_campo_exibir    IN       t_cpo_campo_exibir,
      vi_cpo_html_antes      IN       t_cpo_html_antes,
      vi_cpo_html_depois     IN       t_cpo_html_depois
   );

   PROCEDURE stp_altera_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome,
      vi_cpo_titulo          IN       t_cpo_titulo,
      vi_cpo_ordem           IN       t_cpo_ordem,
      vi_cpo_tipo            IN       t_cpo_tipo,
      vi_cpo_chave           IN       t_cpo_chave,
      vi_cpo_obrigatorio     IN       t_cpo_obrigatorio,
      vi_cpo_auto            IN       t_cpo_auto,
      vi_cpo_grid            IN       t_cpo_grid,
      vi_cpo_procura         IN       t_cpo_procura,
      vi_cpo_tamanho         IN       t_cpo_tamanho,
      vi_cpo_linhas          IN       t_cpo_linhas,
      vi_cpo_largura         IN       t_cpo_largura,
      vi_cpo_cols            IN       t_cpo_cols,
      vi_cpo_mascara         IN       t_cpo_mascara,
      vi_cpo_padrao          IN       t_cpo_padrao,
      vi_cpo_opcoes          IN       t_cpo_opcoes,
      vi_cpo_valores         IN       t_cpo_valores,
      vi_cpo_tabela_origem   IN       t_cpo_tabela_origem,
      vi_cpo_campo_origem    IN       t_cpo_campo_origem,
      vi_cpo_campo_exibir    IN       t_cpo_campo_exibir,
      vi_cpo_html_antes      IN       t_cpo_html_antes,
      vi_cpo_html_depois     IN       t_cpo_html_depois
   );

   
----------------------------------------------------------------------------------------
   FUNCTION stf_cur2str (
      curvalue   IN   NUMBER
   )
      RETURN VARCHAR2;

   
-------------------------------------------------------------------------------------------
-- Funcoes Globais

   PROCEDURE stp_teste;

   -- validacao de usuario e senha, armazena em TAB_ACESSO
   PROCEDURE stp_login (
      vo_ok         OUT      tyt_ok,
      p_usuario     IN       VARCHAR2,
      p_senha       IN       VARCHAR2,
      p_sessionid   IN       NUMBER
   );

   -- traz o USUARIO de acordo com a SESSIOID de  TAB_ACESSO);
   PROCEDURE stp_validar (
      vo_usuario    OUT   tyt_usuario,
      p_sessionid         NUMBER
   );

   -- verifica se um usuario tem acesso a determinada tabela ou objeto (p_acao := "PESQUISA"|"EXCLUI"|"INCLUI"|"ALTERA")
   FUNCTION stf_permitido (
      p_usuario   IN   VARCHAR2,
      p_objeto    IN   VARCHAR2,
      p_acao      IN   VARCHAR2
   )
      RETURN BOOLEAN;

   -- retorna todas as permissoes de um usuario sobre um objeto
   PROCEDURE stp_permissoes (
      p_usuario     IN       VARCHAR2,
      p_objeto      IN       VARCHAR2,
      vo_pesquisa   OUT      tyt_ok,
      vo_exclui     OUT      tyt_ok,
      vo_inclui     OUT      tyt_ok,
      vo_altera     OUT      tyt_ok
   );

   -- armazena um log de atividade
   PROCEDURE stp_log (
      p_usuario   VARCHAR2,
      p_tabela    VARCHAR2,
      p_tipo      VARCHAR2,
      p_dado      VARCHAR2
   );

   -- retorna os formularios (e filhos)
   PROCEDURE stp_formularios (
      frm_nome       OUT      tyt_frm_nome,
      frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      frm_titulo     OUT      tyt_frm_titulo,
      frm_frm_pai    OUT      tyt_frm_frm_pai,
      frm_ordem      OUT      tyt_frm_ordem,
      frm_ligacao    OUT      tyt_frm_ligacao,
      p_formulario   IN       VARCHAR2
   );

   -- retorna os campos de uma determinada tabela (virtual)
   PROCEDURE stp_campos (
      cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      cpo_nome            OUT      tyt_cpo_nome,
      cpo_titulo          OUT      tyt_cpo_titulo,
      cpo_ordem           OUT      tyt_cpo_ordem,
      cpo_tipo            OUT      tyt_cpo_tipo,
      cpo_chave           OUT      tyt_cpo_chave,
      cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      cpo_auto            OUT      tyt_cpo_auto,
      cpo_grid            OUT      tyt_cpo_grid,
      cpo_tamanho         OUT      tyt_cpo_tamanho,
      cpo_linhas          OUT      tyt_cpo_linhas,
      cpo_largura         OUT      tyt_cpo_largura,
      cpo_cols            OUT      tyt_cpo_cols,
      cpo_mascara         OUT      tyt_cpo_mascara,
      cpo_padrao          OUT      tyt_cpo_padrao,
      cpo_opcoes          OUT      tyt_cpo_opcoes,
      cpo_valores         OUT      tyt_cpo_valores,
      cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      cpo_html_antes      OUT      tyt_cpo_html_antes,
      cpo_html_depois     OUT      tyt_cpo_html_depois,
      p_tabela            IN       VARCHAR2
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_FIRMA
   SUBTYPE t_fir_cod IS ifrbde_views.tab_firma.fir_cod%TYPE;

   SUBTYPE t_tip_cnpj_cpf IS ifrbde_views.tab_firma.tip_cnpj_cpf%TYPE;

   SUBTYPE t_fir_cnpj IS ifrbde_views.tab_firma.fir_cnpj%TYPE;

   SUBTYPE t_fir_nome IS ifrbde_views.tab_firma.fir_nome%TYPE;

   SUBTYPE t_fir_razao IS VARCHAR2 (100);

   SUBTYPE t_fir_contato IS VARCHAR2 (60);

   SUBTYPE t_ds_endereco IS VARCHAR2 (70);

   SUBTYPE t_ds_complemento IS VARCHAR2 (70);

   SUBTYPE t_ds_bairro IS VARCHAR2 (70);

   SUBTYPE t_ds_cidade IS VARCHAR2 (70);

   SUBTYPE t_nu_cep IS VARCHAR2 (18);

   SUBTYPE t_fir_fone IS VARCHAR2 (40);

   SUBTYPE t_fir_fax IS VARCHAR2 (40);

   SUBTYPE t_sg_uf IS VARCHAR2 (4);

   SUBTYPE t_sg_pais IS VARCHAR2 (4);

   SUBTYPE t_fir_email IS VARCHAR2 (100);

   SUBTYPE t_fir_obs IS ifrbde_views.tab_firma.fir_obs%TYPE;

   TYPE tyt_fir_cod IS TABLE OF t_fir_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tip_cnpj_cpf IS TABLE OF t_tip_cnpj_cpf
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_cnpj IS TABLE OF t_fir_cnpj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_nome IS TABLE OF t_fir_nome
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_razao IS TABLE OF t_fir_razao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_contato IS TABLE OF t_fir_contato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ds_endereco IS TABLE OF t_ds_endereco
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ds_complemento IS TABLE OF t_ds_complemento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ds_bairro IS TABLE OF t_ds_bairro
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ds_cidade IS TABLE OF t_ds_cidade
      INDEX BY BINARY_INTEGER;

   TYPE tyt_nu_cep IS TABLE OF t_nu_cep
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_fone IS TABLE OF t_fir_fone
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_fax IS TABLE OF t_fir_fax
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sg_uf IS TABLE OF t_sg_uf
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sg_pais IS TABLE OF t_sg_pais
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_email IS TABLE OF t_fir_email
      INDEX BY BINARY_INTEGER;

   TYPE tyt_fir_obs IS TABLE OF t_fir_obs
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_fir_cod          IN       t_fir_cod
   );

   PROCEDURE stp_exclui_firma (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_fir_cod   IN       t_fir_cod
   );

   PROCEDURE stp_inclui_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_tip_cnpj_cpf     IN       t_tip_cnpj_cpf,
      vi_fir_cnpj         IN       t_fir_cnpj,
      vi_fir_nome         IN       t_fir_nome,
      vi_fir_obs          IN       t_fir_obs
   );

   PROCEDURE stp_altera_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_fir_cod          IN       t_fir_cod,
      vi_tip_cnpj_cpf     IN       t_tip_cnpj_cpf,
      vi_fir_cnpj         IN       t_fir_cnpj,
      vi_fir_nome         IN       t_fir_nome,
      vi_fir_obs          IN       t_fir_obs
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_EIXO
   SUBTYPE t_eix_cod IS ifrbde_views.tab_eixo.eix_cod%TYPE;

   SUBTYPE t_eix_desc IS ifrbde_views.tab_eixo.eix_desc%TYPE;

   TYPE tyt_eix_cod IS TABLE OF ifrbde_views.tab_eixo.eix_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_eix_desc IS TABLE OF ifrbde_views.tab_eixo.eix_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_cod    IN       t_eix_cod
   );

   PROCEDURE stp_exclui_eixo (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_eix_cod   IN       t_eix_cod
   );

   PROCEDURE stp_inclui_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_desc   IN       t_eix_desc
   );

   PROCEDURE stp_altera_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_cod    IN       t_eix_cod,
      vi_eix_desc   IN       t_eix_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_ETAPA_OBRA
   SUBTYPE t_eto_cod IS ifrbde_views.tab_etapa_obra.eto_cod%TYPE;

   SUBTYPE t_eto_desc IS ifrbde_views.tab_etapa_obra.eto_desc%TYPE;

   TYPE tyt_eto_cod IS TABLE OF ifrbde_views.tab_etapa_obra.eto_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_eto_desc IS TABLE OF ifrbde_views.tab_etapa_obra.eto_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_cod    IN       t_eto_cod
   );

   PROCEDURE stp_exclui_etapa_obra (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_eto_cod   IN       t_eto_cod
   );

   PROCEDURE stp_inclui_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_desc   IN       t_eto_desc
   );

   PROCEDURE stp_altera_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_cod    IN       t_eto_cod,
      vi_eto_desc   IN       t_eto_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_OBRAS_TIPOS
   SUBTYPE t_obt_cod IS ifrbde_views.tab_obras_tipos.obt_cod%TYPE;

   SUBTYPE t_obt_desc IS ifrbde_views.tab_obras_tipos.obt_desc%TYPE;

   TYPE tyt_obt_cod IS TABLE OF ifrbde_views.tab_obras_tipos.obt_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_obt_desc IS TABLE OF ifrbde_views.tab_obras_tipos.obt_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_cod    IN       t_obt_cod
   );

   PROCEDURE stp_exclui_obras_tipos (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_obt_cod   IN       t_obt_cod
   );

   PROCEDURE stp_inclui_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_desc   IN       t_obt_desc
   );

   PROCEDURE stp_altera_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_cod    IN       t_obt_cod,
      vi_obt_desc   IN       t_obt_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_MOV_DOTACAO
   SUBTYPE t_mdt_ano IS ifrbde_views.tab_mov_dotacao.mdt_ano%TYPE;

   SUBTYPE t_mdt_doc IS ifrbde_views.tab_mov_dotacao.mdt_doc%TYPE;

   SUBTYPE t_mdt_data IS t_data;

   SUBTYPE t_mdt_tipo_doc IS ifrbde_views.tab_mov_dotacao.mdt_tipo_doc%TYPE;

   SUBTYPE t_mdt_rti_cod_orig IS ifrbde_views.tab_mov_dotacao.mdt_rti_cod_orig%TYPE;

   SUBTYPE t_mdt_dpp_orig IS ifrbde_views.tab_mov_dotacao.mdt_dpp_orig%TYPE;

   SUBTYPE t_mdt_rti_cod_dest IS ifrbde_views.tab_mov_dotacao.mdt_rti_cod_dest%TYPE;

   SUBTYPE t_mdt_dpp_dest IS ifrbde_views.tab_mov_dotacao.mdt_dpp_dest%TYPE;

   SUBTYPE t_mdt_diretoria IS ifrbde_views.tab_mov_dotacao.mdt_diretoria%TYPE;

   SUBTYPE t_mdt_motivo IS ifrbde_views.tab_mov_dotacao.mdt_motivo%TYPE;

   SUBTYPE t_mdt_valor IS ifrbde_views.tab_mov_dotacao.mdt_valor%TYPE;

   TYPE tyt_mdt_ano IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_ano%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_doc IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_doc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_tipo_doc IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_tipo_doc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_rti_cod_orig IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_rti_cod_orig%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_dpp_orig IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_dpp_orig%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_rti_cod_dest IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_rti_cod_dest%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_dpp_dest IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_dpp_dest%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_diretoria IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_diretoria%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_motivo IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_motivo%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_mdt_valor IS TABLE OF ifrbde_views.tab_mov_dotacao.mdt_valor%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig
   );

   PROCEDURE stp_exclui_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig
   );

   PROCEDURE stp_inclui_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig,
      vi_mdt_rti_cod_dest   IN       t_mdt_rti_cod_dest,
      vi_mdt_dpp_dest       IN       t_mdt_dpp_dest,
      vi_mdt_diretoria      IN       t_mdt_diretoria,
      vi_mdt_motivo         IN       t_mdt_motivo,
      vi_mdt_valor          IN       t_mdt_valor
   );

   PROCEDURE stp_altera_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig,
      vi_mdt_rti_cod_dest   IN       t_mdt_rti_cod_dest,
      vi_mdt_dpp_dest       IN       t_mdt_dpp_dest,
      vi_mdt_diretoria      IN       t_mdt_diretoria,
      vi_mdt_motivo         IN       t_mdt_motivo,
      vi_mdt_valor          IN       t_mdt_valor
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_NATUREZA_OBRA
   SUBTYPE t_nto_cod IS ifrbde_views.tab_natureza_obra.nto_cod%TYPE;

   SUBTYPE t_nto_desc IS ifrbde_views.tab_natureza_obra.nto_desc%TYPE;

   TYPE tyt_nto_cod IS TABLE OF ifrbde_views.tab_natureza_obra.nto_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_nto_desc IS TABLE OF ifrbde_views.tab_natureza_obra.nto_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod
   );

   PROCEDURE stp_exclui_natureza_obra (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_nto_cod   IN       t_nto_cod
   );

   PROCEDURE stp_inclui_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod,
      vi_nto_desc   IN       t_nto_desc
   );

   PROCEDURE stp_altera_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod,
      vi_nto_desc   IN       t_nto_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_NATUREZA_OBRA_FIL
   SUBTYPE t_ntf_nto_cod IS ifrbde_views.tab_natureza_obra_fil.ntf_nto_cod%TYPE;

   SUBTYPE t_ntf_cod IS ifrbde_views.tab_natureza_obra_fil.ntf_cod%TYPE;

   SUBTYPE t_ntf_desc IS ifrbde_views.tab_natureza_obra_fil.ntf_desc%TYPE;

   TYPE tyt_ntf_nto_cod IS TABLE OF ifrbde_views.tab_natureza_obra_fil.ntf_nto_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ntf_cod IS TABLE OF ifrbde_views.tab_natureza_obra_fil.ntf_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ntf_desc IS TABLE OF ifrbde_views.tab_natureza_obra_fil.ntf_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod
   );

   PROCEDURE stp_exclui_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod
   );

   PROCEDURE stp_inclui_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod,
      vi_ntf_desc      IN       t_ntf_desc
   );

   PROCEDURE stp_altera_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod,
      vi_ntf_desc      IN       t_ntf_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_DEPENDENCIA_PAI
   SUBTYPE t_dpp_cod IS ifrbde_views.tab_dependencia_pai.dpp_cod%TYPE;

   SUBTYPE t_dpp_desc IS ifrbde_views.tab_dependencia_pai.dpp_desc%TYPE;

   SUBTYPE t_dpp_sigla IS ifrbde_views.tab_dependencia_pai.dpp_sigla%TYPE;

   TYPE tyt_dpp_cod IS TABLE OF ifrbde_views.tab_dependencia_pai.dpp_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dpp_desc IS TABLE OF ifrbde_views.tab_dependencia_pai.dpp_desc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dpp_sigla IS TABLE OF ifrbde_views.tab_dependencia_pai.dpp_sigla%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod
   );

   PROCEDURE stp_exclui_dependencia_pai (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_dpp_cod   IN       t_dpp_cod
   );

   PROCEDURE stp_inclui_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod,
      vi_dpp_desc    IN       t_dpp_desc,
      vi_dpp_sigla   IN       t_dpp_sigla
   );

   PROCEDURE stp_altera_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod,
      vi_dpp_desc    IN       t_dpp_desc,
      vi_dpp_sigla   IN       t_dpp_sigla
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_DEPENDENCIA
   SUBTYPE t_dep_dpp_cod IS ifrbde_views.tab_dependencia.dep_dpp_cod%TYPE;

   SUBTYPE t_dep_cod IS ifrbde_views.tab_dependencia.dep_cod%TYPE;

   SUBTYPE t_dep_desc IS ifrbde_views.tab_dependencia.dep_desc%TYPE;

   SUBTYPE t_dep_sigla IS ifrbde_views.tab_dependencia.dep_sigla%TYPE;

   SUBTYPE t_dep_uf IS ifrbde_views.tab_dependencia.dep_uf%TYPE;

   SUBTYPE t_dep_eix_cod IS ifrbde_views.tab_dependencia.dep_eix_cod%TYPE;

   SUBTYPE t_dep_tipo IS ifrbde_views.tab_dependencia.dep_tipo%TYPE;

   TYPE tyt_dep_dpp_cod IS TABLE OF ifrbde_views.tab_dependencia.dep_dpp_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_cod IS TABLE OF ifrbde_views.tab_dependencia.dep_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_desc IS TABLE OF ifrbde_views.tab_dependencia.dep_desc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_sigla IS TABLE OF ifrbde_views.tab_dependencia.dep_sigla%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_uf IS TABLE OF ifrbde_views.tab_dependencia.dep_uf%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_eix_cod IS TABLE OF ifrbde_views.tab_dependencia.dep_eix_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dep_tipo IS TABLE OF ifrbde_views.tab_dependencia.dep_tipo%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_cod       IN       t_dep_cod
   );

   PROCEDURE stp_exclui_dependencia (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_dep_cod   IN       t_dep_cod
   );

   PROCEDURE stp_inclui_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_dpp_cod   IN       t_dep_dpp_cod,
      vi_dep_cod       IN       t_dep_cod,
      vi_dep_desc      IN       t_dep_desc,
      vi_dep_sigla     IN       t_dep_sigla,
      vi_dep_uf        IN       t_dep_uf,
      vi_dep_eix_cod   IN       t_dep_eix_cod,
      vi_dep_tipo      IN       t_dep_tipo
   );

   PROCEDURE stp_altera_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_dpp_cod   IN       t_dep_dpp_cod,
      vi_dep_cod       IN       t_dep_cod,
      vi_dep_desc      IN       t_dep_desc,
      vi_dep_sigla     IN       t_dep_sigla,
      vi_dep_uf        IN       t_dep_uf,
      vi_dep_eix_cod   IN       t_dep_eix_cod,
      vi_dep_tipo      IN       t_dep_tipo
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_INDICE
   SUBTYPE t_ice_cod IS ifrbde_views.tab_indice.ice_cod%TYPE;

   TYPE tyt_ice_cod IS TABLE OF ifrbde_views.tab_indice.ice_cod%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_indice (
      p_usuario             VARCHAR2,
      vo_ice_cod   OUT      tyt_ice_cod,
      vi_ice_cod   IN       t_ice_cod
   );

   PROCEDURE stp_exclui_indice (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_ice_cod   IN       t_ice_cod
   );

   PROCEDURE stp_inclui_indice (
      p_usuario             VARCHAR2,
      vo_ice_cod   OUT      tyt_ice_cod,
      vi_ice_cod   IN       t_ice_cod
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_INDICE_FIL
   SUBTYPE t_ici_ice_cod IS ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE;

   SUBTYPE t_ici_periodo IS t_data;

   SUBTYPE t_ici_valor_diario IS ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE;

   TYPE tyt_ici_ice_cod IS TABLE OF ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ici_periodo IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ici_valor_diario IS TABLE OF ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo
   );

   PROCEDURE stp_exclui_indice_fil (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_ici_ice_cod   IN       t_ici_ice_cod,
      vi_ici_periodo   IN       t_ici_periodo
   );

   PROCEDURE stp_inclui_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   );

   PROCEDURE stp_altera_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_TIPO_RECURSO
   SUBTYPE t_rct_cod IS ifrbde_views.tab_tipo_recurso.rct_cod%TYPE;

   SUBTYPE t_rct_desc IS ifrbde_views.tab_tipo_recurso.rct_desc%TYPE;

   SUBTYPE t_rct_sigla IS ifrbde_views.tab_tipo_recurso.rct_sigla%TYPE;

   TYPE tyt_rct_cod IS TABLE OF ifrbde_views.tab_tipo_recurso.rct_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rct_desc IS TABLE OF ifrbde_views.tab_tipo_recurso.rct_desc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rct_sigla IS TABLE OF ifrbde_views.tab_tipo_recurso.rct_sigla%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod
   );

   PROCEDURE stp_exclui_tipo_recurso (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rct_cod   IN       t_rct_cod
   );

   PROCEDURE stp_inclui_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod,
      vi_rct_desc    IN       t_rct_desc,
      vi_rct_sigla   IN       t_rct_sigla
   );

   PROCEDURE stp_altera_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod,
      vi_rct_desc    IN       t_rct_desc,
      vi_rct_sigla   IN       t_rct_sigla
   );

   
----------------------------------------------------------------------------------------------
  --- TAB_TIPO_RECURSO_ITEM
   SUBTYPE t_rti_rct_cod IS ifrbde_views.tab_tipo_recurso_item.rti_rct_cod%TYPE;

   SUBTYPE t_rti_cod IS ifrbde_views.tab_tipo_recurso_item.rti_cod%TYPE;

   SUBTYPE t_rti_desc IS ifrbde_views.tab_tipo_recurso_item.rti_desc%TYPE;

   SUBTYPE t_rti_sigla IS ifrbde_views.tab_tipo_recurso_item.rti_sigla%TYPE;

   SUBTYPE t_rti_conta IS ifrbde_views.tab_tipo_recurso_item.rti_conta%TYPE;

   SUBTYPE t_rti_programa IS ifrbde_views.tab_tipo_recurso_item.rti_programa%TYPE;

   TYPE tyt_rti_rct_cod IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_rct_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rti_cod IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rti_desc IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_desc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rti_sigla IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_sigla%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rti_conta IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_conta%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rti_programa IS TABLE OF ifrbde_views.tab_tipo_recurso_item.rti_programa%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_cod        IN       t_rti_cod
   );

   PROCEDURE stp_exclui_tipo_recurso_item (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rti_cod   IN       t_rti_cod
   );

   PROCEDURE stp_inclui_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_rct_cod    IN       t_rti_rct_cod,
      vi_rti_cod        IN       t_rti_cod,
      vi_rti_desc       IN       t_rti_desc,
      vi_rti_sigla      IN       t_rti_sigla,
      vi_rti_conta      IN       t_rti_conta,
      vi_rti_programa   IN       t_rti_programa
   );

   PROCEDURE stp_altera_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_rct_cod    IN       t_rti_rct_cod,
      vi_rti_cod        IN       t_rti_cod,
      vi_rti_desc       IN       t_rti_desc,
      vi_rti_sigla      IN       t_rti_sigla,
      vi_rti_conta      IN       t_rti_conta,
      vi_rti_programa   IN       t_rti_programa
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_AREA
   SUBTYPE t_are_cod IS ifrbde_views.tab_area.are_cod%TYPE;

   SUBTYPE t_are_desc IS ifrbde_views.tab_area.are_desc%TYPE;

   TYPE tyt_are_cod IS TABLE OF ifrbde_views.tab_area.are_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_are_desc IS TABLE OF ifrbde_views.tab_area.are_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_cod    IN       t_are_cod
   );

   PROCEDURE stp_exclui_area (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_are_cod   IN       t_are_cod
   );

   PROCEDURE stp_inclui_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_desc   IN       t_are_desc
   );

   PROCEDURE stp_altera_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_cod    IN       t_are_cod,
      vi_are_desc   IN       t_are_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_AREA_ENVOLVIDA
   SUBTYPE t_aen_cod IS ifrbde_views.tab_area_envolvida.aen_cod%TYPE;

   SUBTYPE t_aen_subcod IS ifrbde_views.tab_area_envolvida.aen_subcod%TYPE;

   SUBTYPE t_aen_desc IS ifrbde_views.tab_area_envolvida.aen_desc%TYPE;

   TYPE tyt_aen_cod IS TABLE OF ifrbde_views.tab_area_envolvida.aen_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_aen_subcod IS TABLE OF ifrbde_views.tab_area_envolvida.aen_subcod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_aen_desc IS TABLE OF ifrbde_views.tab_area_envolvida.aen_desc%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_subcod   IN       t_aen_subcod
   );

   PROCEDURE stp_exclui_area_envolvida (
      p_usuario                VARCHAR2,
      vo_ok           OUT      tyt_ok,
      vi_aen_subcod   IN       t_aen_subcod
   );

   PROCEDURE stp_inclui_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_cod      IN       t_aen_cod,
      vi_aen_subcod   IN       t_aen_subcod,
      vi_aen_desc     IN       t_aen_desc
   );

   PROCEDURE stp_altera_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_cod      IN       t_aen_cod,
      vi_aen_subcod   IN       t_aen_subcod,
      vi_aen_desc     IN       t_aen_desc
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_DOTACAO
   SUBTYPE t_dot_ano IS ifrbde_views.tab_dotacao.dot_ano%TYPE;

   SUBTYPE t_dot_rti_cod IS ifrbde_views.tab_dotacao.dot_rti_cod%TYPE;

   SUBTYPE t_dot_valor IS ifrbde_views.tab_dotacao.dot_valor%TYPE;

   TYPE tyt_dot_ano IS TABLE OF ifrbde_views.tab_dotacao.dot_ano%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dot_rti_cod IS TABLE OF ifrbde_views.tab_dotacao.dot_rti_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dot_valor IS TABLE OF ifrbde_views.tab_dotacao.dot_valor%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod
   );

   PROCEDURE stp_exclui_dotacao (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod
   );

   PROCEDURE stp_inclui_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod,
      vi_dot_valor     IN       t_dot_valor
   );

   PROCEDURE stp_altera_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod,
      vi_dot_valor     IN       t_dot_valor
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_ITEM_DOTACAO
   SUBTYPE t_dti_dot_ano IS ifrbde_views.tab_item_dotacao.dti_dot_ano%TYPE;

   SUBTYPE t_dti_dot_rti_cod IS ifrbde_views.tab_item_dotacao.dti_dot_rti_cod%TYPE;

   SUBTYPE t_dti_dpp_cod IS ifrbde_views.tab_item_dotacao.dti_dpp_cod%TYPE;

   SUBTYPE t_dti_valor IS ifrbde_views.tab_item_dotacao.dti_valor%TYPE;

   TYPE tyt_dti_dot_ano IS TABLE OF ifrbde_views.tab_item_dotacao.dti_dot_ano%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dti_dot_rti_cod IS TABLE OF ifrbde_views.tab_item_dotacao.dti_dot_rti_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dti_dpp_cod IS TABLE OF ifrbde_views.tab_item_dotacao.dti_dpp_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dti_valor IS TABLE OF ifrbde_views.tab_item_dotacao.dti_valor%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod
   );

   PROCEDURE stp_exclui_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod
   );

   PROCEDURE stp_inclui_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod,
      vi_dti_valor         IN       t_dti_valor
   );

   PROCEDURE stp_altera_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod,
      vi_dti_valor         IN       t_dti_valor
   );

   
--------------------------------------------------------------------------------
   --- TAB_REMANEJAMENTO
   SUBTYPE t_rmj_cod IS ifrbde_views.tab_remanejamento.rmj_cod%TYPE;

   SUBTYPE t_rmj_ano IS ifrbde_views.tab_remanejamento.rmj_ano%TYPE;

   SUBTYPE t_rmj_seq_orig IS ifrbde_views.tab_remanejamento.rmj_seq_orig%TYPE;

   SUBTYPE t_rmj_rti_cod_orig IS ifrbde_views.tab_remanejamento.rmj_rti_cod_orig%TYPE;

   SUBTYPE t_rmj_dep_orig IS VARCHAR2 (106);

   SUBTYPE t_rmj_obj_orig IS VARCHAR2 (8000);

   SUBTYPE t_rmj_seq_dest IS ifrbde_views.tab_remanejamento.rmj_seq_dest%TYPE;

   SUBTYPE t_rmj_rti_cod_dest IS ifrbde_views.tab_remanejamento.rmj_rti_cod_dest%TYPE;

   SUBTYPE t_rmj_dep_dest IS VARCHAR2 (106);

   SUBTYPE t_rmj_obj_dest IS VARCHAR2 (8000);

   SUBTYPE t_rmj_valor IS ifrbde_views.tab_remanejamento.rmj_valor%TYPE;

   SUBTYPE t_dat_remanejamento IS t_data;

   SUBTYPE t_rmj_usuario IS ifrbde_views.tab_remanejamento.rmj_usuario%TYPE;

   TYPE tyt_rmj_cod IS TABLE OF t_rmj_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_ano IS TABLE OF t_rmj_ano
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_seq_orig IS TABLE OF t_rmj_seq_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_rti_cod_orig IS TABLE OF t_rmj_rti_cod_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_dep_orig IS TABLE OF t_rmj_dep_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_obj_orig IS TABLE OF t_rmj_obj_orig
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_seq_dest IS TABLE OF t_rmj_seq_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_rti_cod_dest IS TABLE OF t_rmj_rti_cod_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_dep_dest IS TABLE OF t_rmj_dep_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_obj_dest IS TABLE OF t_rmj_obj_dest
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_valor IS TABLE OF t_rmj_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dat_remanejamento IS TABLE OF t_dat_remanejamento
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rmj_usuario IS TABLE OF t_rmj_usuario
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_remanejamento (
      p_usuario                       VARCHAR2,
      vo_rmj_cod             OUT      tyt_rmj_cod,
      vo_rmj_ano             OUT      tyt_rmj_ano,
      vo_rmj_seq_orig        OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig    OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig        OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig        OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest        OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest    OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest        OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest        OUT      tyt_rmj_obj_dest,
      vo_rmj_valor           OUT      tyt_rmj_valor,
      vo_dat_remanejamento   OUT      tyt_dat_remanejamento,
      vo_rmj_usuario         OUT      tyt_rmj_usuario,
      vi_rmj_cod             IN       t_rmj_cod
   );

   PROCEDURE stp_exclui_remanejamento (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rmj_cod   IN       t_rmj_cod
   );

   PROCEDURE stp_inclui_remanejamento (
      p_usuario                       VARCHAR2,
      vo_rmj_cod             OUT      tyt_rmj_cod,
      vo_rmj_ano             OUT      tyt_rmj_ano,
      vo_rmj_seq_orig        OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig    OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig        OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig        OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest        OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest    OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest        OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest        OUT      tyt_rmj_obj_dest,
      vo_rmj_valor           OUT      tyt_rmj_valor,
      vo_dat_remanejamento   OUT      tyt_dat_remanejamento,
      vo_rmj_usuario         OUT      tyt_rmj_usuario,
      vi_rmj_ano             IN       t_rmj_ano,
      vi_rmj_seq_orig        IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig    IN       t_rmj_rti_cod_orig,
      vi_rmj_seq_dest        IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest    IN       t_rmj_rti_cod_dest,
      vi_rmj_valor           IN       t_rmj_valor,
      vi_dat_remanejamento   IN       t_dat_remanejamento,
      vi_rmj_usuario         IN       t_rmj_usuario
   );

   PROCEDURE stp_altera_remanejamento (
      p_usuario                       VARCHAR2,
      vo_rmj_cod             OUT      tyt_rmj_cod,
      vo_rmj_ano             OUT      tyt_rmj_ano,
      vo_rmj_seq_orig        OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig    OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig        OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig        OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest        OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest    OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest        OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest        OUT      tyt_rmj_obj_dest,
      vo_rmj_valor           OUT      tyt_rmj_valor,
      vo_dat_remanejamento   OUT      tyt_dat_remanejamento,
      vo_rmj_usuario         OUT      tyt_rmj_usuario,
      vi_rmj_cod             IN       t_rmj_cod,
      vi_rmj_ano             IN       t_rmj_ano,
      vi_rmj_seq_orig        IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig    IN       t_rmj_rti_cod_orig,
      vi_rmj_seq_dest        IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest    IN       t_rmj_rti_cod_dest,
      vi_rmj_valor           IN       t_rmj_valor,
      vi_dat_remanejamento   IN       t_dat_remanejamento,
      vi_rmj_usuario         IN       t_rmj_usuario
   );

   
--------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
   --- CAD_RECURSOS_SOLICITADOS
   SUBTYPE t_num_seq_carencia IS ifrbde_views.cad_recursos_solicitados.num_seq_carencia%TYPE;

   SUBTYPE t_num_ano IS ifrbde_views.cad_recursos_solicitados.num_ano%TYPE;

   SUBTYPE t_val_proposta IS ifrbde_views.cad_recursos_solicitados.val_proposta%TYPE;

   TYPE tyt_num_seq_carencia IS TABLE OF t_num_seq_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_ano IS TABLE OF t_num_ano
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_proposta IS TABLE OF t_val_proposta
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano
   );

   PROCEDURE stp_exclui_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano
   );

   PROCEDURE stp_inclui_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano,
      vi_val_proposta       IN       t_val_proposta
   );

   PROCEDURE stp_altera_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano,
      vi_val_proposta       IN       t_val_proposta
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_REC_PRECOMPROVADO
   SUBTYPE t_rpr_cre_cod IS ifrbde_views.tab_rec_precomprovado.rpr_cre_cod%TYPE;

   SUBTYPE t_rpr_pgose IS ifrbde_views.tab_rec_precomprovado.rpr_pgose%TYPE;

   SUBTYPE t_rpr_rti_cod IS ifrbde_views.tab_rec_precomprovado.rpr_rti_cod%TYPE;

   SUBTYPE t_rpr_num IS ifrbde_views.tab_rec_precomprovado.rpr_num%TYPE;

   SUBTYPE t_rpr_data IS t_data;

   SUBTYPE t_rpr_valor IS ifrbde_views.tab_rec_precomprovado.rpr_valor%TYPE;

   TYPE tyt_rpr_cre_cod IS TABLE OF ifrbde_views.tab_rec_precomprovado.rpr_cre_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_pgose IS TABLE OF ifrbde_views.tab_rec_precomprovado.rpr_pgose%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_rti_cod IS TABLE OF ifrbde_views.tab_rec_precomprovado.rpr_rti_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_num IS TABLE OF ifrbde_views.tab_rec_precomprovado.rpr_num%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rpr_valor IS TABLE OF ifrbde_views.tab_rec_precomprovado.rpr_valor%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num
   );

   PROCEDURE stp_exclui_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num
   );

   PROCEDURE stp_inclui_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num,
      vi_rpr_data      IN       t_rpr_data,
      vi_rpr_valor     IN       t_rpr_valor
   );

   PROCEDURE stp_altera_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num,
      vi_rpr_data      IN       t_rpr_data,
      vi_rpr_valor     IN       t_rpr_valor
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_CARENCIA
   SUBTYPE t_cre_cod IS ifrbde_views.tab_carencia.cre_cod%TYPE;

   SUBTYPE t_cre_dep_cod IS ifrbde_views.tab_carencia.cre_dep_cod%TYPE;

   SUBTYPE t_cre_prior_aeroporto IS ifrbde_views.tab_carencia.cre_prior_aeroporto%TYPE;

   SUBTYPE t_cre_prior_cnl IS ifrbde_views.tab_carencia.cre_prior_cnl%TYPE;

   SUBTYPE t_cre_tipo IS ifrbde_views.tab_carencia.cre_tipo%TYPE;

   SUBTYPE t_cre_desc IS ifrbde_views.tab_carencia.cre_desc%TYPE;

   SUBTYPE t_cre_justificativa IS ifrbde_views.tab_carencia.cre_justificativa%TYPE;

   SUBTYPE t_cre_aen_subcod IS ifrbde_views.tab_carencia.cre_aen_subcod%TYPE;

   SUBTYPE t_cre_ntf_cod IS ifrbde_views.tab_carencia.cre_ntf_cod%TYPE;

   SUBTYPE t_cre_etp_cod IS ifrbde_views.tab_carencia.cre_etp_cod%TYPE;

   SUBTYPE t_cre_tipo_obra_cod IS ifrbde_views.tab_carencia.cre_tipo_obra_cod%TYPE;

   SUBTYPE t_cre_inicio IS ifrbde_views.tab_carencia.cre_inicio%TYPE;

   SUBTYPE t_cre_termino IS ifrbde_views.tab_carencia.cre_termino%TYPE;

   SUBTYPE t_cre_vlobras IS ifrbde_views.tab_carencia.cre_vlobras%TYPE;

   SUBTYPE t_cre_projeto IS ifrbde_views.tab_carencia.cre_projeto%TYPE;

   SUBTYPE t_num_seq_pessoal_carencia IS ifrbde_views.tab_carencia.num_seq_pessoal_carencia%TYPE;

   SUBTYPE t_cre_data IS CHAR (10);

   SUBTYPE t_cre_aen_pai IS VARCHAR2 (24);

   SUBTYPE t_cre_ntf_pai IS VARCHAR2 (24);

   SUBTYPE t_cre_prazo IS ifrbde_views.tab_carencia.cre_prazo%TYPE;

   SUBTYPE t_cre_valor_aprov IS VARCHAR2 (28);

   SUBTYPE t_cre_valor_pago IS VARCHAR2 (28);

   TYPE tyt_cre_cod IS TABLE OF ifrbde_views.tab_carencia.cre_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_dep_cod IS TABLE OF ifrbde_views.tab_carencia.cre_dep_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_prior_aeroporto IS TABLE OF ifrbde_views.tab_carencia.cre_prior_aeroporto%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_prior_cnl IS TABLE OF ifrbde_views.tab_carencia.cre_prior_cnl%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_tipo IS TABLE OF ifrbde_views.tab_carencia.cre_tipo%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_desc IS TABLE OF ifrbde_views.tab_carencia.cre_desc%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_justificativa IS TABLE OF ifrbde_views.tab_carencia.cre_justificativa%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_aen_pai IS TABLE OF t_cre_aen_pai
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_ntf_pai IS TABLE OF t_cre_ntf_pai
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_aen_subcod IS TABLE OF ifrbde_views.tab_carencia.cre_aen_subcod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_ntf_cod IS TABLE OF ifrbde_views.tab_carencia.cre_ntf_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_etp_cod IS TABLE OF ifrbde_views.tab_carencia.cre_etp_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_tipo_obra_cod IS TABLE OF ifrbde_views.tab_carencia.cre_tipo_obra_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_inicio IS TABLE OF ifrbde_views.tab_carencia.cre_inicio%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_termino IS TABLE OF ifrbde_views.tab_carencia.cre_termino%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_vlobras IS TABLE OF ifrbde_views.tab_carencia.cre_vlobras%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_projeto IS TABLE OF ifrbde_views.tab_carencia.cre_projeto%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_prazo IS TABLE OF t_cre_prazo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_valor_aprov IS TABLE OF t_cre_valor_aprov
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cre_valor_pago IS TABLE OF t_cre_valor_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_seq_pessoal_carencia IS TABLE OF t_num_seq_pessoal_carencia
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_cod                    IN       t_cre_cod
   );

   PROCEDURE stp_exclui_carencia (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_cre_cod   IN       t_cre_cod
   );

   PROCEDURE stp_inclui_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_cre_prior_aeroporto        IN       t_cre_prior_aeroporto,
      vi_cre_prior_cnl              IN       t_cre_prior_cnl,
      vi_cre_tipo                   IN       t_cre_tipo,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cre_etp_cod                IN       t_cre_etp_cod,
      vi_cre_tipo_obra_cod          IN       t_cre_tipo_obra_cod,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_cre_vlobras                IN       t_cre_vlobras
   );

   PROCEDURE stp_altera_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_cod                    IN       t_cre_cod,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_cre_prior_aeroporto        IN       t_cre_prior_aeroporto,
      vi_cre_prior_cnl              IN       t_cre_prior_cnl,
      vi_cre_tipo                   IN       t_cre_tipo,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cre_etp_cod                IN       t_cre_etp_cod,
      vi_cre_tipo_obra_cod          IN       t_cre_tipo_obra_cod,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_cre_vlobras                IN       t_cre_vlobras
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_CONT_TERMO_ADITIVO
   SUBTYPE t_cta_cnt_cre_cod IS ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cre_cod%TYPE;

   SUBTYPE t_cta_cnt_cod IS ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cod%TYPE;

   SUBTYPE t_cta_periodo IS t_data;

   SUBTYPE t_cta_num IS ifrbde_views.tab_cont_termo_aditivo.cta_num%TYPE;

   SUBTYPE t_cta_objeto IS ifrbde_views.tab_cont_termo_aditivo.cta_objeto%TYPE;

   SUBTYPE t_cta_valor IS ifrbde_views.tab_cont_termo_aditivo.cta_valor%TYPE;

   SUBTYPE t_cta_prazo IS ifrbde_views.tab_cont_termo_aditivo.cta_prazo%TYPE;

   SUBTYPE t_cta_deb_cred IS ifrbde_views.tab_cont_termo_aditivo.cta_deb_cred%TYPE;

   SUBTYPE t_cta_aum_dim IS ifrbde_views.tab_cont_termo_aditivo.cta_aum_dim%TYPE;

   TYPE tyt_cta_cnt_cre_cod IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cre_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_cnt_cod IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_periodo IS TABLE OF t_cta_periodo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_num IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_num%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_objeto IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_objeto%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_valor IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_valor%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_prazo IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_prazo%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_deb_cred IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_deb_cred%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cta_aum_dim IS TABLE OF ifrbde_views.tab_cont_termo_aditivo.cta_aum_dim%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_cont_termo_aditiv (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num
   );

   PROCEDURE stp_exclui_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num
   );

   PROCEDURE stp_inclui_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num,
      vi_cta_objeto        IN       t_cta_objeto,
      vi_cta_valor         IN       t_cta_valor,
      vi_cta_deb_cred      IN       t_cta_deb_cred,
      vi_cta_prazo         IN       t_cta_prazo,
      vi_cta_aum_dim       IN       t_cta_aum_dim
   );

   PROCEDURE stp_altera_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num,
      vi_cta_objeto        IN       t_cta_objeto,
      vi_cta_valor         IN       t_cta_valor,
      vi_cta_deb_cred      IN       t_cta_deb_cred,
      vi_cta_prazo         IN       t_cta_prazo,
      vi_cta_aum_dim       IN       t_cta_aum_dim
   );

   
----------------------------------------------------------------------------------------------
   --- TAB_CONTRATO_REAJUSTE
   SUBTYPE t_crj_cnt_cre_cod IS ifrbde_views.tab_contrato_reajuste.crj_cnt_cre_cod%TYPE;

   SUBTYPE t_crj_cnt_cod IS ifrbde_views.tab_contrato_reajuste.crj_cnt_cod%TYPE;

   SUBTYPE t_crj_pgose IS ifrbde_views.tab_contrato_reajuste.crj_pgose%TYPE;

   SUBTYPE t_crj_periodo IS t_data;

   SUBTYPE t_crj_valor IS ifrbde_views.tab_contrato_reajuste.crj_valor%TYPE;

   TYPE tyt_crj_cnt_cre_cod IS TABLE OF ifrbde_views.tab_contrato_reajuste.crj_cnt_cre_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_crj_cnt_cod IS TABLE OF ifrbde_views.tab_contrato_reajuste.crj_cnt_cod%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_crj_pgose IS TABLE OF ifrbde_views.tab_contrato_reajuste.crj_pgose%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tyt_crj_periodo IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_crj_valor IS TABLE OF ifrbde_views.tab_contrato_reajuste.crj_valor%TYPE
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo
   );

   PROCEDURE stp_exclui_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo
   );

   PROCEDURE stp_inclui_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo,
      vi_crj_valor         IN       t_crj_valor
   );

   PROCEDURE stp_altera_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo,
      vi_crj_valor         IN       t_crj_valor
   );

   
--------------------------------------------------------------------------------
   --- CAD_RESPONSAVEIS
   SUBTYPE t_num_seq_pessoal IS ifrbde_views.cad_responsaveis.num_seq_pessoal%TYPE;

   SUBTYPE t_num_mat_infraero IS ifrbde_views.cad_responsaveis.num_mat_infraero%TYPE;

   SUBTYPE t_nom_responsavel IS ifrbde_views.cad_responsaveis.nom_responsavel%TYPE;

   SUBTYPE t_cod_dependencia IS ifrbde_views.cad_responsaveis.cod_dependencia%TYPE;

   SUBTYPE t_num_cpf IS ifrbde_views.cad_responsaveis.num_cpf%TYPE;

   SUBTYPE t_dsc_email_notes IS ifrbde_views.cad_responsaveis.dsc_email_notes%TYPE;

   SUBTYPE t_flg_carencia IS ifrbde_views.cad_responsaveis.flg_carencia%TYPE;

   SUBTYPE t_flg_contrato IS ifrbde_views.cad_responsaveis.flg_contrato%TYPE;

   SUBTYPE t_flg_assinatura IS ifrbde_views.cad_responsaveis.flg_assinatura%TYPE;

   SUBTYPE t_flg_fiscal IS ifrbde_views.cad_responsaveis.flg_fiscal%TYPE;

   TYPE tyt_num_seq_pessoal IS TABLE OF t_num_seq_pessoal
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_mat_infraero IS TABLE OF t_num_mat_infraero
      INDEX BY BINARY_INTEGER;

   TYPE tyt_nom_responsavel IS TABLE OF t_nom_responsavel
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_dependencia IS TABLE OF t_cod_dependencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_num_cpf IS TABLE OF t_num_cpf
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dsc_email_notes IS TABLE OF t_dsc_email_notes
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_carencia IS TABLE OF t_flg_carencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_contrato IS TABLE OF t_flg_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_assinatura IS TABLE OF t_flg_assinatura
      INDEX BY BINARY_INTEGER;

   TYPE tyt_flg_fiscal IS TABLE OF t_flg_fiscal
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_seq_pessoal    IN       t_num_seq_pessoal
   );

   PROCEDURE stp_exclui_responsaveis (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_num_seq_pessoal   IN       t_num_seq_pessoal
   );

   PROCEDURE stp_inclui_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_mat_infraero   IN       t_num_mat_infraero,
      vi_nom_responsavel    IN       t_nom_responsavel,
      vi_cod_dependencia    IN       t_cod_dependencia,
      vi_num_cpf            IN       t_num_cpf,
      vi_dsc_email_notes    IN       t_dsc_email_notes,
      vi_flg_carencia       IN       t_flg_carencia,
      vi_flg_contrato       IN       t_flg_contrato,
      vi_flg_assinatura     IN       t_flg_assinatura,
      vi_flg_fiscal         IN       t_flg_fiscal
   );

   PROCEDURE stp_altera_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_seq_pessoal    IN       t_num_seq_pessoal,
      vi_num_mat_infraero   IN       t_num_mat_infraero,
      vi_nom_responsavel    IN       t_nom_responsavel,
      vi_cod_dependencia    IN       t_cod_dependencia,
      vi_num_cpf            IN       t_num_cpf,
      vi_dsc_email_notes    IN       t_dsc_email_notes,
      vi_flg_carencia       IN       t_flg_carencia,
      vi_flg_contrato       IN       t_flg_contrato,
      vi_flg_assinatura     IN       t_flg_assinatura,
      vi_flg_fiscal         IN       t_flg_fiscal
   );

   
--------------------------------------------------------------------------------
   --- TAB_REC_APROVADO
   SUBTYPE t_rap_cre_cod IS ifrbde_views.tab_rec_aprovado.rap_cre_cod%TYPE;

   SUBTYPE t_rap_pgose IS ifrbde_views.tab_rec_aprovado.rap_pgose%TYPE;

   SUBTYPE t_rap_rti_cod IS ifrbde_views.tab_rec_aprovado.rap_rti_cod%TYPE;

   SUBTYPE t_rap_valor IS ifrbde_views.tab_rec_aprovado.rap_valor%TYPE;

   SUBTYPE t_rap_cre_pgi IS ifrbde_views.tab_rec_aprovado.rap_cre_pgi%TYPE;

   SUBTYPE t_rap_valor_pago IS VARCHAR2 (30);

   SUBTYPE t_val_remanejado_enviado IS VARCHAR2 (36);

   SUBTYPE t_val_remanejado_recebido IS VARCHAR2 (36);

   SUBTYPE t_val_saldo_recurso IS VARCHAR2 (36);

   TYPE tyt_rap_cre_cod IS TABLE OF t_rap_cre_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_pgose IS TABLE OF t_rap_pgose
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_rti_cod IS TABLE OF t_rap_rti_cod
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_valor IS TABLE OF t_rap_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_cre_pgi IS TABLE OF t_rap_cre_pgi
      INDEX BY BINARY_INTEGER;

   TYPE tyt_rap_valor_pago IS TABLE OF t_rap_valor_pago
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_remanejado_enviado IS TABLE OF t_val_remanejado_enviado
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_remanejado_recebido IS TABLE OF t_val_remanejado_recebido
      INDEX BY BINARY_INTEGER;

   TYPE tyt_val_saldo_recurso IS TABLE OF t_val_saldo_recurso
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod
   );

   PROCEDURE stp_exclui_rec_aprovado (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_rap_cre_cod   IN       t_rap_cre_cod,
      vi_rap_pgose     IN       t_rap_pgose,
      vi_rap_rti_cod   IN       t_rap_rti_cod
   );

   PROCEDURE stp_inclui_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod,
      vi_rap_valor                 IN       t_rap_valor,
      vi_rap_cre_pgi               IN       t_rap_cre_pgi
   );

   PROCEDURE stp_altera_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod,
      vi_rap_valor                 IN       t_rap_valor,
      vi_rap_cre_pgi               IN       t_rap_cre_pgi
   );
--------------------------------------------------------------------------------
END pck_sipreco;
/

-- Grants for Package
GRANT EXECUTE ON ifrbde_views.pck_sipreco TO bde_views
/
GRANT EXECUTE ON ifrbde_views.pck_sipreco TO bde_geral
/

CREATE OR REPLACE 
PACKAGE BODY ifrbde_views.pck_sipreco AS
   PROCEDURE stp_teste AS
      v_x                           NUMBER;
   BEGIN
      v_x := 1;
   END stp_teste;

   
--------------------------------------------------------------------
   -- Pesquisa Campos dos Formularios
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CAMPO', 'PESQUISA') THEN
         SELECT cpo_tbl_nome,
                cpo_nome,
                cpo_titulo,
                cpo_ordem,
                cpo_tipo,
                cpo_chave,
                cpo_obrigatorio,
                cpo_auto,
                cpo_grid,
                cpo_procura,
                cpo_tamanho,
                cpo_linhas,
                cpo_largura,
                cpo_cols,
                cpo_mascara,
                cpo_padrao,
                cpo_opcoes,
                cpo_valores,
                cpo_tabela_origem,
                cpo_campo_origem,
                cpo_campo_exibir,
                cpo_html_antes,
                cpo_html_depois
           INTO vo_cpo_tbl_nome (1),
                vo_cpo_nome (1),
                vo_cpo_titulo (1),
                vo_cpo_ordem (1),
                vo_cpo_tipo (1),
                vo_cpo_chave (1),
                vo_cpo_obrigatorio (1),
                vo_cpo_auto (1),
                vo_cpo_grid (1),
                vo_cpo_procura (1),
                vo_cpo_tamanho (1),
                vo_cpo_linhas (1),
                vo_cpo_largura (1),
                vo_cpo_cols (1),
                vo_cpo_mascara (1),
                vo_cpo_padrao (1),
                vo_cpo_opcoes (1),
                vo_cpo_valores (1),
                vo_cpo_tabela_origem (1),
                vo_cpo_campo_origem (1),
                vo_cpo_campo_exibir (1),
                vo_cpo_html_antes (1),
                vo_cpo_html_depois (1)
           FROM ifrbde_views.tab_campo
          WHERE cpo_tbl_nome = vi_cpo_tbl_nome AND cpo_nome = vi_cpo_nome;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END stp_pesquisa_campo;

   -- Exclui Campos dos Formularios
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_campo (
      p_usuario                  VARCHAR2,
      vo_ok             OUT      tyt_ok,
      vi_cpo_tbl_nome   IN       t_cpo_tbl_nome,
      vi_cpo_nome       IN       t_cpo_nome
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_CAMPO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_campo
               WHERE cpo_tbl_nome = vi_cpo_tbl_nome AND cpo_nome =
                                                                  vi_cpo_nome;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_CAMPO',
               'E',
               vi_cpo_tbl_nome || vi_cpo_nome
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END stp_exclui_campo;

   
--------------------------------------------------------------------
   -- Inclui Campos dos Formularios
   -- retorna o recordset correspondente
   PROCEDURE stp_inclui_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome,
      vi_cpo_titulo          IN       t_cpo_titulo,
      vi_cpo_ordem           IN       t_cpo_ordem,
      vi_cpo_tipo            IN       t_cpo_tipo,
      vi_cpo_chave           IN       t_cpo_chave,
      vi_cpo_obrigatorio     IN       t_cpo_obrigatorio,
      vi_cpo_auto            IN       t_cpo_auto,
      vi_cpo_grid            IN       t_cpo_grid,
      vi_cpo_procura         IN       t_cpo_procura,
      vi_cpo_tamanho         IN       t_cpo_tamanho,
      vi_cpo_linhas          IN       t_cpo_linhas,
      vi_cpo_largura         IN       t_cpo_largura,
      vi_cpo_cols            IN       t_cpo_cols,
      vi_cpo_mascara         IN       t_cpo_mascara,
      vi_cpo_padrao          IN       t_cpo_padrao,
      vi_cpo_opcoes          IN       t_cpo_opcoes,
      vi_cpo_valores         IN       t_cpo_valores,
      vi_cpo_tabela_origem   IN       t_cpo_tabela_origem,
      vi_cpo_campo_origem    IN       t_cpo_campo_origem,
      vi_cpo_campo_exibir    IN       t_cpo_campo_exibir,
      vi_cpo_html_antes      IN       t_cpo_html_antes,
      vi_cpo_html_depois     IN       t_cpo_html_depois
   ) AS
      v_cpo_tbl_nome                tab_campo.cpo_tbl_nome%TYPE;
      v_cpo_nome                    tab_campo.cpo_nome%TYPE;
      v_cpo_titulo                  tab_campo.cpo_titulo%TYPE;
      v_cpo_ordem                   tab_campo.cpo_ordem%TYPE;
      v_cpo_tipo                    tab_campo.cpo_tipo%TYPE;
      v_cpo_chave                   tab_campo.cpo_chave%TYPE;
      v_cpo_obrigatorio             tab_campo.cpo_obrigatorio%TYPE;
      v_cpo_auto                    tab_campo.cpo_auto%TYPE;
      v_cpo_grid                    tab_campo.cpo_grid%TYPE;
      v_cpo_procura                 tab_campo.cpo_procura%TYPE;
      v_cpo_tamanho                 tab_campo.cpo_tamanho%TYPE;
      v_cpo_linhas                  tab_campo.cpo_linhas%TYPE;
      v_cpo_largura                 tab_campo.cpo_largura%TYPE;
      v_cpo_cols                    tab_campo.cpo_cols%TYPE;
      v_cpo_mascara                 tab_campo.cpo_mascara%TYPE;
      v_cpo_padrao                  tab_campo.cpo_padrao%TYPE;
      v_cpo_opcoes                  tab_campo.cpo_opcoes%TYPE;
      v_cpo_valores                 tab_campo.cpo_valores%TYPE;
      v_cpo_tabela_origem           tab_campo.cpo_tabela_origem%TYPE;
      v_cpo_campo_origem            tab_campo.cpo_campo_origem%TYPE;
      v_cpo_campo_exibir            tab_campo.cpo_campo_exibir%TYPE;
      v_cpo_html_antes              tab_campo.cpo_html_antes%TYPE;
      v_cpo_html_depois             tab_campo.cpo_html_depois%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CAMPO', 'INCLUI') THEN
         v_cpo_tbl_nome := RTRIM (LTRIM (UPPER (vi_cpo_tbl_nome)));
         v_cpo_nome := RTRIM (LTRIM (UPPER (vi_cpo_nome)));
         v_cpo_titulo := RTRIM (LTRIM ((vi_cpo_titulo)));
         v_cpo_tipo := RTRIM (LTRIM ((vi_cpo_tipo)));
         v_cpo_mascara := RTRIM (LTRIM ((vi_cpo_mascara)));
         v_cpo_padrao := RTRIM (LTRIM ((vi_cpo_padrao)));
         v_cpo_opcoes := RTRIM (LTRIM ((vi_cpo_opcoes)));
         v_cpo_valores := RTRIM (LTRIM ((vi_cpo_valores)));
         v_cpo_tabela_origem := RTRIM (LTRIM ((vi_cpo_tabela_origem)));
         v_cpo_campo_origem := RTRIM (LTRIM ((vi_cpo_campo_origem)));
         v_cpo_campo_exibir := RTRIM (LTRIM ((vi_cpo_campo_exibir)));
         v_cpo_html_antes := RTRIM (LTRIM ((vi_cpo_html_antes)));
         v_cpo_html_depois := RTRIM (LTRIM ((vi_cpo_html_depois)));
         v_cpo_ordem := vi_cpo_ordem;
         v_cpo_chave := vi_cpo_chave;
         v_cpo_obrigatorio := vi_cpo_obrigatorio;
         v_cpo_auto := vi_cpo_auto;
         v_cpo_grid := vi_cpo_grid;
         v_cpo_procura := vi_cpo_procura;
         v_cpo_tamanho := vi_cpo_tamanho;
         v_cpo_linhas := vi_cpo_linhas;
         v_cpo_largura := vi_cpo_largura;
         v_cpo_cols := vi_cpo_cols;

         INSERT INTO ifrbde.tab_campo
                     (cpo_tbl_nome,
                      cpo_nome,
                      cpo_titulo,
                      cpo_ordem,
                      cpo_tipo,
                      cpo_chave,
                      cpo_obrigatorio,
                      cpo_auto,
                      cpo_grid,
                      cpo_procura,
                      cpo_tamanho,
                      cpo_linhas,
                      cpo_largura,
                      cpo_cols,
                      cpo_mascara,
                      cpo_padrao,
                      cpo_opcoes,
                      cpo_valores,
                      cpo_tabela_origem,
                      cpo_campo_origem,
                      cpo_campo_exibir,
                      cpo_html_antes,
                      cpo_html_depois
                     )
              VALUES (v_cpo_tbl_nome,
                      v_cpo_nome,
                      v_cpo_titulo,
                      v_cpo_ordem,
                      v_cpo_tipo,
                      v_cpo_chave,
                      v_cpo_obrigatorio,
                      v_cpo_auto,
                      v_cpo_grid,
                      v_cpo_procura,
                      v_cpo_tamanho,
                      v_cpo_linhas,
                      v_cpo_largura,
                      v_cpo_cols,
                      v_cpo_mascara,
                      v_cpo_padrao,
                      v_cpo_opcoes,
                      v_cpo_valores,
                      v_cpo_tabela_origem,
                      v_cpo_campo_origem,
                      v_cpo_campo_exibir,
                      v_cpo_html_antes,
                      v_cpo_html_depois
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_campo (
               p_usuario,
               vo_cpo_tbl_nome,
               vo_cpo_nome,
               vo_cpo_titulo,
               vo_cpo_ordem,
               vo_cpo_tipo,
               vo_cpo_chave,
               vo_cpo_obrigatorio,
               vo_cpo_auto,
               vo_cpo_grid,
               vo_cpo_procura,
               vo_cpo_tamanho,
               vo_cpo_linhas,
               vo_cpo_largura,
               vo_cpo_cols,
               vo_cpo_mascara,
               vo_cpo_padrao,
               vo_cpo_opcoes,
               vo_cpo_valores,
               vo_cpo_tabela_origem,
               vo_cpo_campo_origem,
               vo_cpo_campo_exibir,
               vo_cpo_html_antes,
               vo_cpo_html_depois,
               v_cpo_tbl_nome,
               v_cpo_nome
            );
            -- LOG
            stp_log (
               p_usuario,
               'TAB_CAMPO',
               'I',
               vi_cpo_tbl_nome || vi_cpo_nome
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
   -- Altera Campos dos Formularios
   -- retorna o recordset correspondente
   PROCEDURE stp_altera_campo (
      p_usuario                       VARCHAR2,
      vo_cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      vo_cpo_nome            OUT      tyt_cpo_nome,
      vo_cpo_titulo          OUT      tyt_cpo_titulo,
      vo_cpo_ordem           OUT      tyt_cpo_ordem,
      vo_cpo_tipo            OUT      tyt_cpo_tipo,
      vo_cpo_chave           OUT      tyt_cpo_chave,
      vo_cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      vo_cpo_auto            OUT      tyt_cpo_auto,
      vo_cpo_grid            OUT      tyt_cpo_grid,
      vo_cpo_procura         OUT      tyt_cpo_procura,
      vo_cpo_tamanho         OUT      tyt_cpo_tamanho,
      vo_cpo_linhas          OUT      tyt_cpo_linhas,
      vo_cpo_largura         OUT      tyt_cpo_largura,
      vo_cpo_cols            OUT      tyt_cpo_cols,
      vo_cpo_mascara         OUT      tyt_cpo_mascara,
      vo_cpo_padrao          OUT      tyt_cpo_padrao,
      vo_cpo_opcoes          OUT      tyt_cpo_opcoes,
      vo_cpo_valores         OUT      tyt_cpo_valores,
      vo_cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      vo_cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      vo_cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      vo_cpo_html_antes      OUT      tyt_cpo_html_antes,
      vo_cpo_html_depois     OUT      tyt_cpo_html_depois,
      vi_cpo_tbl_nome        IN       t_cpo_tbl_nome,
      vi_cpo_nome            IN       t_cpo_nome,
      vi_cpo_titulo          IN       t_cpo_titulo,
      vi_cpo_ordem           IN       t_cpo_ordem,
      vi_cpo_tipo            IN       t_cpo_tipo,
      vi_cpo_chave           IN       t_cpo_chave,
      vi_cpo_obrigatorio     IN       t_cpo_obrigatorio,
      vi_cpo_auto            IN       t_cpo_auto,
      vi_cpo_grid            IN       t_cpo_grid,
      vi_cpo_procura         IN       t_cpo_procura,
      vi_cpo_tamanho         IN       t_cpo_tamanho,
      vi_cpo_linhas          IN       t_cpo_linhas,
      vi_cpo_largura         IN       t_cpo_largura,
      vi_cpo_cols            IN       t_cpo_cols,
      vi_cpo_mascara         IN       t_cpo_mascara,
      vi_cpo_padrao          IN       t_cpo_padrao,
      vi_cpo_opcoes          IN       t_cpo_opcoes,
      vi_cpo_valores         IN       t_cpo_valores,
      vi_cpo_tabela_origem   IN       t_cpo_tabela_origem,
      vi_cpo_campo_origem    IN       t_cpo_campo_origem,
      vi_cpo_campo_exibir    IN       t_cpo_campo_exibir,
      vi_cpo_html_antes      IN       t_cpo_html_antes,
      vi_cpo_html_depois     IN       t_cpo_html_depois
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_campo
              WHERE cpo_tbl_nome = vi_cpo_tbl_nome AND cpo_nome = vi_cpo_nome
         FOR UPDATE;

      v_tab_campo                   ifrbde_views.tab_campo%ROWTYPE;
      v_cpo_tbl_nome                ifrbde_views.tab_campo.cpo_tbl_nome%TYPE;
      v_cpo_nome                    ifrbde_views.tab_campo.cpo_nome%TYPE;
      v_cpo_titulo                  ifrbde_views.tab_campo.cpo_titulo%TYPE;
      v_cpo_ordem                   ifrbde_views.tab_campo.cpo_ordem%TYPE;
      v_cpo_tipo                    ifrbde_views.tab_campo.cpo_tipo%TYPE;
      v_cpo_chave                   ifrbde_views.tab_campo.cpo_chave%TYPE;
      v_cpo_obrigatorio             ifrbde_views.tab_campo.cpo_obrigatorio%TYPE;
      v_cpo_auto                    ifrbde_views.tab_campo.cpo_auto%TYPE;
      v_cpo_grid                    ifrbde_views.tab_campo.cpo_grid%TYPE;
      v_cpo_procura                 ifrbde_views.tab_campo.cpo_procura%TYPE;
      v_cpo_tamanho                 ifrbde_views.tab_campo.cpo_tamanho%TYPE;
      v_cpo_linhas                  ifrbde_views.tab_campo.cpo_linhas%TYPE;
      v_cpo_largura                 ifrbde_views.tab_campo.cpo_largura%TYPE;
      v_cpo_cols                    ifrbde_views.tab_campo.cpo_cols%TYPE;
      v_cpo_mascara                 ifrbde_views.tab_campo.cpo_mascara%TYPE;
      v_cpo_padrao                  ifrbde_views.tab_campo.cpo_padrao%TYPE;
      v_cpo_opcoes                  ifrbde_views.tab_campo.cpo_opcoes%TYPE;
      v_cpo_valores                 ifrbde_views.tab_campo.cpo_valores%TYPE;
      v_cpo_tabela_origem           ifrbde_views.tab_campo.cpo_tabela_origem%TYPE;
      v_cpo_campo_origem            ifrbde_views.tab_campo.cpo_campo_origem%TYPE;
      v_cpo_campo_exibir            ifrbde_views.tab_campo.cpo_campo_exibir%TYPE;
      v_cpo_html_antes              ifrbde_views.tab_campo.cpo_html_antes%TYPE;
      v_cpo_html_depois             ifrbde_views.tab_campo.cpo_html_depois%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CAMPO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_campo;

         IF NOT c_cursor%NOTFOUND THEN
            v_cpo_tbl_nome := RTRIM (LTRIM (UPPER (vi_cpo_tbl_nome)));
            v_cpo_nome := RTRIM (LTRIM (UPPER (vi_cpo_nome)));
            v_cpo_titulo := RTRIM (LTRIM ((vi_cpo_titulo)));
            v_cpo_tipo := RTRIM (LTRIM ((vi_cpo_tipo)));
            v_cpo_mascara := RTRIM (LTRIM ((vi_cpo_mascara)));
            v_cpo_padrao := RTRIM (LTRIM ((vi_cpo_padrao)));
            v_cpo_opcoes := RTRIM (LTRIM ((vi_cpo_opcoes)));
            v_cpo_valores := RTRIM (LTRIM ((vi_cpo_valores)));
            v_cpo_tabela_origem := RTRIM (LTRIM ((vi_cpo_tabela_origem)));
            v_cpo_campo_origem := RTRIM (LTRIM ((vi_cpo_campo_origem)));
            v_cpo_campo_exibir := RTRIM (LTRIM ((vi_cpo_campo_exibir)));
            v_cpo_html_antes := RTRIM (LTRIM ((vi_cpo_html_antes)));
            v_cpo_html_depois := RTRIM (LTRIM ((vi_cpo_html_depois)));
            v_cpo_ordem := vi_cpo_ordem;
            v_cpo_chave := vi_cpo_chave;
            v_cpo_obrigatorio := vi_cpo_obrigatorio;
            v_cpo_auto := vi_cpo_auto;
            v_cpo_grid := vi_cpo_grid;
            v_cpo_procura := vi_cpo_procura;
            v_cpo_tamanho := vi_cpo_tamanho;
            v_cpo_linhas := vi_cpo_linhas;
            v_cpo_largura := vi_cpo_largura;
            v_cpo_cols := vi_cpo_cols;

            UPDATE ifrbde.tab_campo
               SET cpo_titulo = v_cpo_titulo,
                   cpo_ordem = v_cpo_ordem,
                   cpo_tipo = v_cpo_tipo,
                   cpo_chave = v_cpo_chave,
                   cpo_obrigatorio = v_cpo_obrigatorio,
                   cpo_auto = v_cpo_auto,
                   cpo_grid = v_cpo_grid,
                   cpo_procura = v_cpo_procura,
                   cpo_tamanho = v_cpo_tamanho,
                   cpo_linhas = v_cpo_linhas,
                   cpo_largura = v_cpo_largura,
                   cpo_cols = v_cpo_cols,
                   cpo_mascara = v_cpo_mascara,
                   cpo_padrao = v_cpo_padrao,
                   cpo_opcoes = v_cpo_opcoes,
                   cpo_valores = v_cpo_valores,
                   cpo_tabela_origem = v_cpo_tabela_origem,
                   cpo_campo_origem = v_cpo_campo_origem,
                   cpo_campo_exibir = v_cpo_campo_exibir,
                   cpo_html_antes = v_cpo_html_antes,
                   cpo_html_depois = v_cpo_html_depois
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_campo (
                  p_usuario,
                  vo_cpo_tbl_nome,
                  vo_cpo_nome,
                  vo_cpo_titulo,
                  vo_cpo_ordem,
                  vo_cpo_tipo,
                  vo_cpo_chave,
                  vo_cpo_obrigatorio,
                  vo_cpo_auto,
                  vo_cpo_grid,
                  vo_cpo_procura,
                  vo_cpo_tamanho,
                  vo_cpo_linhas,
                  vo_cpo_largura,
                  vo_cpo_cols,
                  vo_cpo_mascara,
                  vo_cpo_padrao,
                  vo_cpo_opcoes,
                  vo_cpo_valores,
                  vo_cpo_tabela_origem,
                  vo_cpo_campo_origem,
                  vo_cpo_campo_exibir,
                  vo_cpo_html_antes,
                  vo_cpo_html_depois,
                  v_cpo_tbl_nome,
                  v_cpo_nome
               );
               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_CAMPO',
                  'A',
                  vi_cpo_tbl_nome || vi_cpo_nome
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Pesquisa Formularios do Sistema
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_FORMULARIO', 'PESQUISA') THEN
         SELECT frm_nome,
                frm_tbl_nome,
                frm_titulo,
                frm_frm_pai,
                frm_ordem,
                frm_ligacao
           INTO vo_frm_nome (1),
                vo_frm_tbl_nome (1),
                vo_frm_titulo (1),
                vo_frm_frm_pai (1),
                vo_frm_ordem (1),
                vo_frm_ligacao (1)
           FROM ifrbde_views.tab_formulario
          WHERE frm_nome = vi_frm_nome;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (
            -20100,
            ' Erro ao pesquisa Formulario - '
            || TO_CHAR (SQLCODE)
            || ' - '
            || SQLERRM
         );
   END;

   -- Exclui Formularios do Sistema
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_formulario (
      p_usuario              VARCHAR2,
      vo_ok         OUT      tyt_ok,
      vi_frm_nome   IN       t_frm_nome
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_FORMULARIO', 'EXCLUI') THEN
         DELETE FROM ifrbde.tab_formulario
               WHERE frm_nome = vi_frm_nome;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_FORMULARIO', 'E', vi_frm_nome);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Formularios do Sistema
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome,
      vi_frm_tbl_nome   IN       t_frm_tbl_nome,
      vi_frm_titulo     IN       t_frm_titulo,
      vi_frm_frm_pai    IN       t_frm_frm_pai,
      vi_frm_ordem      IN       t_frm_ordem,
      vi_frm_ligacao    IN       t_frm_ligacao
   ) AS
      v_frm_nome                    tab_formulario.frm_nome%TYPE;
      v_frm_tbl_nome                tab_formulario.frm_tbl_nome%TYPE;
      v_frm_titulo                  tab_formulario.frm_titulo%TYPE;
      v_frm_frm_pai                 tab_formulario.frm_frm_pai%TYPE;
      v_frm_ordem                   tab_formulario.frm_ordem%TYPE;
      v_frm_ligacao                 tab_formulario.frm_ligacao%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_FORMULARIO', 'INCLUI') THEN
         v_frm_nome := RTRIM (LTRIM (UPPER (vi_frm_nome)));
         v_frm_tbl_nome := RTRIM (LTRIM (UPPER (vi_frm_tbl_nome)));
         v_frm_titulo := RTRIM (LTRIM ((vi_frm_titulo)));
         v_frm_frm_pai := RTRIM (LTRIM (UPPER (vi_frm_frm_pai)));
         v_frm_ligacao := RTRIM (LTRIM (UPPER (vi_frm_ligacao)));
         v_frm_ordem := vi_frm_ordem;

         INSERT INTO ifrbde.tab_formulario
                     (frm_nome,
                      frm_tbl_nome,
                      frm_titulo,
                      frm_frm_pai,
                      frm_ordem,
                      frm_ligacao
                     )
              VALUES (v_frm_nome,
                      v_frm_tbl_nome,
                      v_frm_titulo,
                      v_frm_frm_pai,
                      v_frm_ordem,
                      v_frm_ligacao
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_formulario (
               p_usuario,
               vo_frm_nome,
               vo_frm_tbl_nome,
               vo_frm_titulo,
               vo_frm_frm_pai,
               vo_frm_ordem,
               vo_frm_ligacao,
               v_frm_nome
            );
            -- LOG
            stp_log (p_usuario, 'TAB_FORMULARIO', 'I', vi_frm_nome);
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
   -- Altera Formularios do Sistema
   -- retorna o recordset correspondente
   PROCEDURE stp_altera_formulario (
      p_usuario                  VARCHAR2,
      vo_frm_nome       OUT      tyt_frm_nome,
      vo_frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      vo_frm_titulo     OUT      tyt_frm_titulo,
      vo_frm_frm_pai    OUT      tyt_frm_frm_pai,
      vo_frm_ordem      OUT      tyt_frm_ordem,
      vo_frm_ligacao    OUT      tyt_frm_ligacao,
      vi_frm_nome       IN       t_frm_nome,
      vi_frm_tbl_nome   IN       t_frm_tbl_nome,
      vi_frm_titulo     IN       t_frm_titulo,
      vi_frm_frm_pai    IN       t_frm_frm_pai,
      vi_frm_ordem      IN       t_frm_ordem,
      vi_frm_ligacao    IN       t_frm_ligacao
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde.tab_formulario
              WHERE frm_nome = vi_frm_nome
         FOR UPDATE;

      v_tab_formulario              ifrbde_views.tab_formulario%ROWTYPE;
      v_frm_nome                    ifrbde_views.tab_formulario.frm_nome%TYPE;
      v_frm_tbl_nome                ifrbde_views.tab_formulario.frm_tbl_nome%TYPE;
      v_frm_titulo                  ifrbde_views.tab_formulario.frm_titulo%TYPE;
      v_frm_frm_pai                 ifrbde_views.tab_formulario.frm_frm_pai%TYPE;
      v_frm_ordem                   ifrbde_views.tab_formulario.frm_ordem%TYPE;
      v_frm_ligacao                 ifrbde_views.tab_formulario.frm_ligacao%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_FORMULARIO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_formulario;

         IF NOT c_cursor%NOTFOUND THEN
            v_frm_nome := RTRIM (LTRIM (UPPER (vi_frm_nome)));
            v_frm_tbl_nome := RTRIM (LTRIM (UPPER (vi_frm_tbl_nome)));
            v_frm_titulo := RTRIM (LTRIM ((vi_frm_titulo)));
            v_frm_frm_pai := RTRIM (LTRIM (UPPER (vi_frm_frm_pai)));
            v_frm_ligacao := RTRIM (LTRIM (UPPER (vi_frm_ligacao)));
            v_frm_ordem := vi_frm_ordem;

            UPDATE ifrbde.tab_formulario
               SET frm_tbl_nome = v_frm_tbl_nome,
                   frm_titulo = v_frm_titulo,
                   frm_frm_pai = v_frm_frm_pai,
                   frm_ordem = v_frm_ordem,
                   frm_ligacao = v_frm_ligacao
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_formulario (
                  p_usuario,
                  vo_frm_nome,
                  vo_frm_tbl_nome,
                  vo_frm_titulo,
                  vo_frm_frm_pai,
                  vo_frm_ordem,
                  vo_frm_ligacao,
                  v_frm_nome
               );
               -- LOG
               stp_log (p_usuario, 'TAB_FORMULARIO', 'A', vi_frm_nome);
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- converte um valor moeda em string
   FUNCTION stf_cur2str (
      curvalue   IN   NUMBER
   )
      RETURN VARCHAR2 AS
      v_strvalue                    VARCHAR2 (200);
   BEGIN
      v_strvalue := TO_CHAR (curvalue, '999,999,999.99');
      v_strvalue := REPLACE (v_strvalue, '.', '!');
      v_strvalue := REPLACE (v_strvalue, ',', '.');
      v_strvalue := RTRIM (LTRIM (REPLACE (v_strvalue, '!', ',')));

      IF v_strvalue = ',00' THEN
         v_strvalue := '0,00';
      END IF;

      RETURN v_strvalue;
   END;

   
---------------------------------------------------------------------------------------------------------------------
   -- validacao de usuario e senha, armazena em TAB_ACESSO
   PROCEDURE stp_login (
      vo_ok         OUT   tyt_ok,
      p_usuario           VARCHAR2,
      p_senha             VARCHAR2,
      p_sessionid         NUMBER
   ) AS
      v_ok                          NUMBER (1) DEFAULT 0;
      v_cod                         ifrbde_views.tab_acesso.acs_cod%TYPE;
      v_usuario                     VARCHAR2 (30);
      v_senha                       VARCHAR2 (30);
   BEGIN
      SELECT ifrbde_views.seq_acs_cod.NEXTVAL
        INTO v_cod
        FROM DUAL;

      v_usuario := p_usuario;
      v_senha := p_senha;

      -- SELECT su_id_usuario
      -- INTO v_usuario
      -- FROM seg_usuario_sistema
      -- WHERE ss_cd_sistema = 22 AND su_id_usuario = p_usuario;


      IF SQL%ROWCOUNT = 1 THEN
         -- grava log de acesso
         INSERT INTO ifrbde_views.tab_acesso
                     (acs_cod,
                      acs_data,
                      acs_usuario,
                      acs_sessionid
                     )
              VALUES (v_cod,
                      SYSDATE,
                      v_usuario,
                      p_sessionid
                     );

         -- verifica
         IF SQL%ROWCOUNT = 1 THEN
            COMMIT;
            v_ok := 1;
         ELSE
            ROLLBACK;
         END IF;
      END IF;

      vo_ok (1) := v_ok;
   END;

   -- traz o USUARIO de acordo com a SESSIOID de  TAB_ACESSO);
   PROCEDURE stp_validar (
      vo_usuario    OUT      tyt_usuario,
      p_sessionid   IN       NUMBER
   ) AS
      CURSOR c_usuario IS
         SELECT   acs_usuario
             FROM ifrbde_views.tab_acesso
            WHERE acs_sessionid = p_sessionid
         ORDER BY acs_data DESC;
   BEGIN
      vo_usuario (1) := '';

      FOR c IN c_usuario
      LOOP
         vo_usuario (1) := c.acs_usuario;
         EXIT WHEN TRUE;
      END LOOP;
   END;

   
--------------------------------------------------------------------
-- Verifica se o usuario tem permissao de acesso a determinada tabela/acao
-- retorna TRUE/FALSE
   FUNCTION stf_permitido (
      p_usuario   IN   VARCHAR2,
      p_objeto    IN   VARCHAR2,
      p_acao      IN   VARCHAR2
   )
      RETURN BOOLEAN AS
      v_flg_pesquisa                VARCHAR2 (1);
      v_flg_inclusao                VARCHAR2 (1);
      v_flg_alteracao               VARCHAR2 (1);
      v_flg_exclusao                VARCHAR2 (1);
      v_cod_grupo                   NUMBER (3);
      vo_flg_pesquisa               VARCHAR2 (1);
      vo_flg_inclusao               VARCHAR2 (1);
      vo_flg_alteracao              VARCHAR2 (1);
      vo_flg_exclusao               VARCHAR2 (1);
   BEGIN
      v_flg_pesquisa := '';
      v_flg_inclusao := '';
      v_flg_alteracao := '';
      v_flg_exclusao := '';
      v_flg_pesquisa := '';
      v_cod_grupo := '';
      vo_flg_inclusao := '';
      vo_flg_alteracao := '';
      vo_flg_exclusao := '';

      
-- DEPENDENTE DO SISEG
      BEGIN
         SELECT flg_pesquisa,
                flg_inclusao,
                flg_alteracao,
                flg_exclusao,
                cod_grupo
           INTO v_flg_pesquisa,
                v_flg_inclusao,
                v_flg_alteracao,
                v_flg_exclusao,
                v_cod_grupo
           FROM ifrbde.cad_acesso
          WHERE nom_username = p_usuario;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;

      BEGIN
         SELECT flg_pesquisa,
                flg_inclusao,
                flg_alteracao,
                flg_exclusao
           INTO v_flg_pesquisa,
                v_flg_inclusao,
                v_flg_alteracao,
                v_flg_exclusao
           FROM ifrbde.cad_acesso_objeto
          WHERE nom_objeto = p_objeto AND cod_grupo = v_cod_grupo;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;

      
--      
      IF p_acao = 'PESQUISA' THEN
         IF vo_flg_pesquisa <> '' THEN
            IF vo_flg_pesquisa = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_pesquisa = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

      
--      
      IF p_acao = 'INCLUI' THEN
         IF vo_flg_inclusao <> '' THEN
            IF vo_flg_inclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_inclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

      
--      
      IF p_acao = 'ALTERA' THEN
         IF vo_flg_alteracao <> '' THEN
            IF vo_flg_alteracao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_alteracao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;

      
--      
      IF p_acao = 'EXCLUI' THEN
         IF vo_flg_exclusao <> '' THEN
            IF vo_flg_exclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         ELSE
            IF v_flg_exclusao = 'S' THEN
               RETURN TRUE;
            ELSE
               RETURN FALSE;
            END IF;
         END IF;
      END IF;
   
--
   END;

   
-------------------------------------------------------------------------------
   -- retorna todas as permissoes de um usuario sobre um objeto
   PROCEDURE stp_permissoes (
      p_usuario     IN       VARCHAR2,
      p_objeto      IN       VARCHAR2,
      vo_pesquisa   OUT      tyt_ok,
      vo_exclui     OUT      tyt_ok,
      vo_inclui     OUT      tyt_ok,
      vo_altera     OUT      tyt_ok
   ) AS
   BEGIN
      vo_pesquisa (1) := 0;
      vo_exclui (1) := 0;
      vo_inclui (1) := 0;
      vo_altera (1) := 0;

      IF stf_permitido (p_usuario, p_objeto, 'PESQUISA') THEN
         vo_pesquisa (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'EXCLUI') THEN
         vo_exclui (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'INCLUI') THEN
         vo_inclui (1) := 1;
      END IF;

      IF stf_permitido (p_usuario, p_objeto, 'ALTERA') THEN
         vo_altera (1) := 1;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Armazena Log de acesso
   PROCEDURE stp_log (
      p_usuario   VARCHAR2,
      p_tabela    VARCHAR2,
      p_tipo      VARCHAR2,
      p_dado      VARCHAR2
   ) AS
      v_cod                         ifrbde_views.tab_log.log_cod%TYPE;
   BEGIN
      SELECT ifrbde_views.seq_log_cod.NEXTVAL
        INTO v_cod
        FROM DUAL;

      INSERT INTO ifrbde_views.tab_log
                  (log_cod,
                   log_data,
                   log_usuario,
                   log_tabela,
                   log_tipo,
                   log_dado
                  )
           VALUES (v_cod,
                   SYSDATE,
                   p_usuario,
                   p_tabela,
                   p_tipo,
                   p_dado
                  );
   END;

   
--------------------------------------------------------------------
-- Retorna os formularios com o nome p_formulario (filhos tb)
   PROCEDURE stp_formularios (
      frm_nome       OUT      tyt_frm_nome,
      frm_tbl_nome   OUT      tyt_frm_tbl_nome,
      frm_titulo     OUT      tyt_frm_titulo,
      frm_frm_pai    OUT      tyt_frm_frm_pai,
      frm_ordem      OUT      tyt_frm_ordem,
      frm_ligacao    OUT      tyt_frm_ligacao,
      p_formulario   IN       VARCHAR2
   ) AS
      CURSOR c_formularios IS
         SELECT   *
             FROM ifrbde_views.tab_formulario
            WHERE UPPER (frm_nome) = UPPER (p_formulario)
               OR UPPER (frm_frm_pai) = UPPER (p_formulario)
         ORDER BY frm_ordem;

      v_counter                     NUMBER (3) := 1;
   BEGIN
      FOR c IN c_formularios
      LOOP
         frm_nome (v_counter) := c.frm_nome;
         frm_tbl_nome (v_counter) := c.frm_tbl_nome;
         frm_titulo (v_counter) := c.frm_titulo;
         frm_frm_pai (v_counter) := c.frm_frm_pai;
         frm_ordem (v_counter) := c.frm_ordem;
         frm_ligacao (v_counter) := c.frm_ligacao;
         v_counter := v_counter + 1;
      END LOOP;
   END;

   
--------------------------------------------------------------------
-- Retorna os campos de uma tabela/formulario
   PROCEDURE stp_campos (
      cpo_tbl_nome        OUT      tyt_cpo_tbl_nome,
      cpo_nome            OUT      tyt_cpo_nome,
      cpo_titulo          OUT      tyt_cpo_titulo,
      cpo_ordem           OUT      tyt_cpo_ordem,
      cpo_tipo            OUT      tyt_cpo_tipo,
      cpo_chave           OUT      tyt_cpo_chave,
      cpo_obrigatorio     OUT      tyt_cpo_obrigatorio,
      cpo_auto            OUT      tyt_cpo_auto,
      cpo_grid            OUT      tyt_cpo_grid,
      cpo_tamanho         OUT      tyt_cpo_tamanho,
      cpo_linhas          OUT      tyt_cpo_linhas,
      cpo_largura         OUT      tyt_cpo_largura,
      cpo_cols            OUT      tyt_cpo_cols,
      cpo_mascara         OUT      tyt_cpo_mascara,
      cpo_padrao          OUT      tyt_cpo_padrao,
      cpo_opcoes          OUT      tyt_cpo_opcoes,
      cpo_valores         OUT      tyt_cpo_valores,
      cpo_tabela_origem   OUT      tyt_cpo_tabela_origem,
      cpo_campo_origem    OUT      tyt_cpo_campo_origem,
      cpo_campo_exibir    OUT      tyt_cpo_campo_exibir,
      cpo_html_antes      OUT      tyt_cpo_html_antes,
      cpo_html_depois     OUT      tyt_cpo_html_depois,
      p_tabela            IN       VARCHAR2
   ) AS
      CURSOR c_campos IS
         SELECT   *
             FROM ifrbde_views.tab_campo
            WHERE cpo_tbl_nome = p_tabela
         ORDER BY cpo_ordem;

      v_counter                     NUMBER (3) := 1;
   BEGIN
      FOR c IN c_campos
      LOOP
         cpo_tbl_nome (v_counter) := c.cpo_tbl_nome;
         cpo_nome (v_counter) := c.cpo_nome;
         cpo_titulo (v_counter) := c.cpo_titulo;
         cpo_ordem (v_counter) := c.cpo_ordem;
         cpo_tipo (v_counter) := c.cpo_tipo;
         cpo_chave (v_counter) := c.cpo_chave;
         cpo_obrigatorio (v_counter) := c.cpo_obrigatorio;
         cpo_auto (v_counter) := c.cpo_auto;
         cpo_grid (v_counter) := c.cpo_grid;
         cpo_tamanho (v_counter) := c.cpo_tamanho;
         cpo_linhas (v_counter) := c.cpo_linhas;
         cpo_largura (v_counter) := c.cpo_largura;
         cpo_cols (v_counter) := c.cpo_cols;
         cpo_mascara (v_counter) := c.cpo_mascara;
         cpo_padrao (v_counter) := c.cpo_padrao;
         cpo_opcoes (v_counter) := c.cpo_opcoes;
         cpo_valores (v_counter) := c.cpo_valores;
         cpo_tabela_origem (v_counter) := c.cpo_tabela_origem;
         cpo_campo_origem (v_counter) := c.cpo_campo_origem;
         cpo_campo_exibir (v_counter) := c.cpo_campo_exibir;
         cpo_html_antes (v_counter) := c.cpo_html_antes;
         cpo_html_depois (v_counter) := c.cpo_html_depois;
         v_counter := v_counter + 1;
      END LOOP;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   -- Pesquisa Cadastro de Firmas
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_fir_cod          IN       t_fir_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_FIRMA',
            'PESQUISA'
         ) THEN
         SELECT fir_cod,
                tip_cnpj_cpf,
                fir_cnpj,
                fir_nome,
                fir_razao,
                fir_contato,
                ds_endereco,
                ds_complemento,
                ds_bairro,
                ds_cidade,
                nu_cep,
                fir_fone,
                fir_fax,
                sg_uf,
                sg_pais,
                fir_email,
                fir_obs
           INTO vo_fir_cod (1),
                vo_tip_cnpj_cpf (1),
                vo_fir_cnpj (1),
                vo_fir_nome (1),
                vo_fir_razao (1),
                vo_fir_contato (1),
                vo_ds_endereco (1),
                vo_ds_complemento (1),
                vo_ds_bairro (1),
                vo_ds_cidade (1),
                vo_nu_cep (1),
                vo_fir_fone (1),
                vo_fir_fax (1),
                vo_sg_uf (1),
                vo_sg_pais (1),
                vo_fir_email (1),
                vo_fir_obs (1)
           FROM ifrbde_views.tab_firma
          WHERE fir_cod = vi_fir_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Cadastro de Firmas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_firma (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_fir_cod   IN       t_fir_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_FIRMA',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_firma
               WHERE fir_cod = vi_fir_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_FIRMA',
               'E',
               TO_CHAR (vi_fir_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Firmas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_tip_cnpj_cpf     IN       t_tip_cnpj_cpf,
      vi_fir_cnpj         IN       t_fir_cnpj,
      vi_fir_nome         IN       t_fir_nome,
      vi_fir_obs          IN       t_fir_obs
   ) AS
      v_fir_cod                     tab_firma.fir_cod%TYPE;
      v_tip_cnpj_cpf                tab_firma.tip_cnpj_cpf%TYPE;
      v_fir_cnpj                    tab_firma.fir_cnpj%TYPE;
      v_fir_nome                    tab_firma.fir_nome%TYPE;
      v_fir_obs                     tab_firma.fir_obs%TYPE;
      v_sucesso                     NUMBER (1);
      v_achou                       NUMBER (1);
      v_erro                        VARCHAR2 (200);
      v_numero_limite               NUMBER (5);
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_FIRMA',
            'INCLUI'
         ) THEN
         v_erro := 'Não conseguiu selecionar o próximo sequencial para Firma';
         v_sucesso := 0;
         v_achou := 0;

         FOR x IN 1 .. 9999
         LOOP
            BEGIN
               SELECT fir_cod
                 INTO v_numero_limite
                 FROM ifrbde.tab_firma
                WHERE fir_cod = x;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                  v_fir_cod := x;
                  v_achou := 1;
               WHEN OTHERS THEN
                  raise_application_error (
                     -20100,
                     v_erro || ' - ' || TO_CHAR (SQLCODE) || ' - ' || SQLERRM
                  );
                  v_sucesso := 1;
            END;

            IF v_achou = 1 OR v_sucesso = 1 THEN
               EXIT;
            END IF;
         END LOOP;

         IF  v_numero_limite = 9999 AND v_sucesso = 0 THEN
            v_erro := 'Sequencial atinguiu o limite máximo, maior que 9999';
            raise_application_error (
               -20100,
               v_erro || ' - ' || TO_CHAR (SQLCODE) || ' - ' || SQLERRM
            );
         END IF;

         IF v_sucesso = 0 THEN
            v_tip_cnpj_cpf := RTRIM (LTRIM (UPPER (vi_tip_cnpj_cpf)));
            v_fir_cnpj := RTRIM (LTRIM (UPPER (vi_fir_cnpj)));
            v_fir_nome := RTRIM (LTRIM (UPPER (vi_fir_nome)));
            v_fir_obs := RTRIM (LTRIM (UPPER (vi_fir_obs)));

            BEGIN
               INSERT INTO ifrbde_views.tab_firma
                           (fir_cod,
                            tip_cnpj_cpf,
                            fir_cnpj,
                            fir_nome,
                            fir_obs
                           )
                    VALUES (v_fir_cod,
                            v_tip_cnpj_cpf,
                            v_fir_cnpj,
                            v_fir_nome,
                            v_fir_obs
                           );
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error (
                     -20100,
                     v_erro || ' - ' || TO_CHAR (SQLCODE) || ' - ' || SQLERRM
                  );
                  v_sucesso := 1;
            END;

            IF v_sucesso = 0 THEN
               stp_pesquisa_firma (
                  p_usuario,
                  vo_fir_cod,
                  vo_tip_cnpj_cpf,
                  vo_fir_cnpj,
                  vo_fir_nome,
                  vo_fir_razao,
                  vo_fir_contato,
                  vo_ds_endereco,
                  vo_ds_complemento,
                  vo_ds_bairro,
                  vo_ds_cidade,
                  vo_nu_cep,
                  vo_fir_fone,
                  vo_fir_fax,
                  vo_sg_uf,
                  vo_sg_pais,
                  vo_fir_email,
                  vo_fir_obs,
                  v_fir_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_FIRMA',
                  'I',
                  TO_CHAR (v_fir_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Firmas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_firma (
      p_usuario                    VARCHAR2,
      vo_fir_cod          OUT      tyt_fir_cod,
      vo_tip_cnpj_cpf     OUT      tyt_tip_cnpj_cpf,
      vo_fir_cnpj         OUT      tyt_fir_cnpj,
      vo_fir_nome         OUT      tyt_fir_nome,
      vo_fir_razao        OUT      tyt_fir_razao,
      vo_fir_contato      OUT      tyt_fir_contato,
      vo_ds_endereco      OUT      tyt_ds_endereco,
      vo_ds_complemento   OUT      tyt_ds_complemento,
      vo_ds_bairro        OUT      tyt_ds_bairro,
      vo_ds_cidade        OUT      tyt_ds_cidade,
      vo_nu_cep           OUT      tyt_nu_cep,
      vo_fir_fone         OUT      tyt_fir_fone,
      vo_fir_fax          OUT      tyt_fir_fax,
      vo_sg_uf            OUT      tyt_sg_uf,
      vo_sg_pais          OUT      tyt_sg_pais,
      vo_fir_email        OUT      tyt_fir_email,
      vo_fir_obs          OUT      tyt_fir_obs,
      vi_fir_cod          IN       t_fir_cod,
      vi_tip_cnpj_cpf     IN       t_tip_cnpj_cpf,
      vi_fir_cnpj         IN       t_fir_cnpj,
      vi_fir_nome         IN       t_fir_nome,
      vi_fir_obs          IN       t_fir_obs
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_firma
              WHERE fir_cod = vi_fir_cod
         FOR UPDATE;

      v_tab_firma                   ifrbde_views.tab_firma%ROWTYPE;
      v_fir_cod                     ifrbde_views.tab_firma.fir_cod%TYPE;
      v_tip_cnpj_cpf                ifrbde_views.tab_firma.tip_cnpj_cpf%TYPE;
      v_fir_cnpj                    ifrbde_views.tab_firma.fir_cnpj%TYPE;
      v_fir_nome                    ifrbde_views.tab_firma.fir_nome%TYPE;
      v_fir_obs                     ifrbde_views.tab_firma.fir_obs%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_FIRMA',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_firma;

         IF NOT c_cursor%NOTFOUND THEN
            v_tip_cnpj_cpf := RTRIM (LTRIM (UPPER (vi_tip_cnpj_cpf)));
            v_fir_cnpj := RTRIM (LTRIM (UPPER (vi_fir_cnpj)));
            v_fir_nome := RTRIM (LTRIM (UPPER (vi_fir_nome)));
            v_fir_obs := RTRIM (LTRIM (UPPER (vi_fir_obs)));

            UPDATE ifrbde_views.tab_firma
               SET tip_cnpj_cpf = v_tip_cnpj_cpf,
                   fir_cnpj = v_fir_cnpj,
                   fir_nome = v_fir_nome,
                   fir_obs = v_fir_obs
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_firma (
                  p_usuario,
                  vo_fir_cod,
                  vo_tip_cnpj_cpf,
                  vo_fir_cnpj,
                  vo_fir_nome,
                  vo_fir_razao,
                  vo_fir_contato,
                  vo_ds_endereco,
                  vo_ds_complemento,
                  vo_ds_bairro,
                  vo_ds_cidade,
                  vo_nu_cep,
                  vo_fir_fone,
                  vo_fir_fax,
                  vo_sg_uf,
                  vo_sg_pais,
                  vo_fir_email,
                  vo_fir_obs,
                  vi_fir_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_FIRMA',
                  'A',
                  TO_CHAR (vi_fir_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Eixos de Desenvolvimento
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_cod    IN       t_eix_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_EIXO', 'PESQUISA') THEN
         SELECT eix_cod,
                eix_desc
           INTO vo_eix_cod (1),
                vo_eix_desc (1)
           FROM ifrbde_views.tab_eixo
          WHERE eix_cod = vi_eix_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Eixos de Desenvolvimento
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_eixo (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_eix_cod   IN       t_eix_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_EIXO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_eixo
               WHERE eix_cod = vi_eix_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_EIXO', 'E', TO_CHAR (vi_eix_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Eixos de Desenvolvimento
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_desc   IN       t_eix_desc
   ) AS
      v_eix_cod                     ifrbde_views.tab_eixo.eix_cod%TYPE;
      v_eix_desc                    ifrbde_views.tab_eixo.eix_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_EIXO', 'INCLUI') THEN
         SELECT ifrbde_views.seq_eix_cod.NEXTVAL
           INTO v_eix_cod
           FROM DUAL;

         v_eix_desc := RTRIM (LTRIM (UPPER (vi_eix_desc)));

         INSERT INTO ifrbde_views.tab_eixo
                     (eix_cod,
                      eix_desc
                     )
              VALUES (v_eix_cod,
                      v_eix_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT eix_cod,
                   eix_desc
              INTO vo_eix_cod (1),
                   vo_eix_desc (1)
              FROM ifrbde_views.tab_eixo
             WHERE eix_cod = v_eix_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_EIXO',
               'I',
               TO_CHAR (v_eix_cod) || v_eix_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Eixos de Desenvolvimento
-- retorna o recordset correspondente
   PROCEDURE stp_altera_eixo (
      p_usuario              VARCHAR2,
      vo_eix_cod    OUT      tyt_eix_cod,
      vo_eix_desc   OUT      tyt_eix_desc,
      vi_eix_cod    IN       t_eix_cod,
      vi_eix_desc   IN       t_eix_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_eixo
              WHERE eix_cod = vi_eix_cod
         FOR UPDATE;

      v_tab_eixo                    ifrbde_views.tab_eixo%ROWTYPE;
      v_eix_cod                     ifrbde_views.tab_eixo.eix_cod%TYPE;
      v_eix_desc                    ifrbde_views.tab_eixo.eix_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_EIXO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_eixo;

         IF NOT c_cursor%NOTFOUND THEN
            v_eix_cod := vi_eix_cod;
            v_eix_desc := RTRIM (LTRIM (UPPER (vi_eix_desc)));

            UPDATE ifrbde_views.tab_eixo
               SET eix_desc = v_eix_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT eix_cod,
                      eix_desc
                 INTO vo_eix_cod (1),
                      vo_eix_desc (1)
                 FROM ifrbde_views.tab_eixo
                WHERE eix_cod = v_eix_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_EIXO',
                  'A',
                  TO_CHAR (vi_eix_cod) || v_eix_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Etapas
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_cod    IN       t_eto_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ETAPA_OBRA', 'PESQUISA') THEN
         SELECT eto_cod,
                eto_desc
           INTO vo_eto_cod (1),
                vo_eto_desc (1)
           FROM ifrbde_views.tab_etapa_obra
          WHERE eto_cod = vi_eto_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Etapas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_etapa_obra (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_eto_cod   IN       t_eto_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_ETAPA_OBRA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_etapa_obra
               WHERE eto_cod = vi_eto_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_ETAPA_OBRA', 'E', TO_CHAR (vi_eto_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Etapas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_desc   IN       t_eto_desc
   ) AS
      v_eto_cod                     ifrbde_views.tab_etapa_obra.eto_cod%TYPE;
      v_eto_desc                    ifrbde_views.tab_etapa_obra.eto_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ETAPA_OBRA', 'INCLUI') THEN
         SELECT ifrbde_views.seq_eto_cod.NEXTVAL
           INTO v_eto_cod
           FROM DUAL;

         v_eto_desc := RTRIM (LTRIM (UPPER (vi_eto_desc)));

         INSERT INTO ifrbde_views.tab_etapa_obra
                     (eto_cod,
                      eto_desc
                     )
              VALUES (v_eto_cod,
                      v_eto_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT eto_cod,
                   eto_desc
              INTO vo_eto_cod (1),
                   vo_eto_desc (1)
              FROM ifrbde_views.tab_etapa_obra
             WHERE eto_cod = v_eto_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_ETAPA_OBRA',
               'I',
               TO_CHAR (v_eto_cod) || v_eto_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Etapas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_etapa_obra (
      p_usuario              VARCHAR2,
      vo_eto_cod    OUT      tyt_eto_cod,
      vo_eto_desc   OUT      tyt_eto_desc,
      vi_eto_cod    IN       t_eto_cod,
      vi_eto_desc   IN       t_eto_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_etapa_obra
              WHERE eto_cod = vi_eto_cod
         FOR UPDATE;

      v_tab_etapa_obra              ifrbde_views.tab_etapa_obra%ROWTYPE;
      v_eto_cod                     ifrbde_views.tab_etapa_obra.eto_cod%TYPE;
      v_eto_desc                    ifrbde_views.tab_etapa_obra.eto_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ETAPA_OBRA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_etapa_obra;

         IF NOT c_cursor%NOTFOUND THEN
            v_eto_desc := RTRIM (LTRIM (UPPER (vi_eto_desc)));
            v_eto_cod := vi_eto_cod;

            UPDATE ifrbde_views.tab_etapa_obra
               SET eto_desc = v_eto_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT eto_cod,
                      eto_desc
                 INTO vo_eto_cod (1),
                      vo_eto_desc (1)
                 FROM ifrbde_views.tab_etapa_obra
                WHERE eto_cod = v_eto_cod;

               -- LOG
               stp_log (p_usuario, 'TAB_ETAPA_OBRA', 'A', TO_CHAR (
                                                             vi_eto_cod
                                                          ));
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Tipos de Obras
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_cod    IN       t_obt_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_OBRAS_TIPOS', 'PESQUISA') THEN
         SELECT obt_cod,
                obt_desc
           INTO vo_obt_cod (1),
                vo_obt_desc (1)
           FROM ifrbde_views.tab_obras_tipos
          WHERE obt_cod = vi_obt_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Tipos de Obras
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_obras_tipos (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_obt_cod   IN       t_obt_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_OBRAS_TIPOS', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_obras_tipos
               WHERE obt_cod = vi_obt_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_OBRAS_TIPOS', 'E', TO_CHAR (vi_obt_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Tipos de Obras
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_desc   IN       t_obt_desc
   ) AS
      v_obt_cod                     ifrbde_views.tab_obras_tipos.obt_cod%TYPE;
      v_obt_desc                    ifrbde_views.tab_obras_tipos.obt_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_OBRAS_TIPOS', 'INCLUI') THEN
         SELECT ifrbde_views.seq_obt_cod.NEXTVAL
           INTO v_obt_cod
           FROM DUAL;

         v_obt_desc := RTRIM (LTRIM (UPPER (vi_obt_desc)));

         INSERT INTO ifrbde_views.tab_obras_tipos
                     (obt_cod,
                      obt_desc
                     )
              VALUES (v_obt_cod,
                      v_obt_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT obt_cod,
                   obt_desc
              INTO vo_obt_cod (1),
                   vo_obt_desc (1)
              FROM ifrbde_views.tab_obras_tipos
             WHERE obt_cod = v_obt_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_OBRAS_TIPOS',
               'I',
               TO_CHAR (v_obt_cod) || v_obt_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Tipos de Obras
-- retorna o recordset correspondente
   PROCEDURE stp_altera_obras_tipos (
      p_usuario              VARCHAR2,
      vo_obt_cod    OUT      tyt_obt_cod,
      vo_obt_desc   OUT      tyt_obt_desc,
      vi_obt_cod    IN       t_obt_cod,
      vi_obt_desc   IN       t_obt_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_obras_tipos
              WHERE obt_cod = vi_obt_cod
         FOR UPDATE;

      v_tab_obras_tipos             ifrbde_views.tab_obras_tipos%ROWTYPE;
      v_obt_cod                     ifrbde_views.tab_obras_tipos.obt_cod%TYPE;
      v_obt_desc                    ifrbde_views.tab_obras_tipos.obt_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_OBRAS_TIPOS', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_obras_tipos;

         IF NOT c_cursor%NOTFOUND THEN
            v_obt_desc := RTRIM (LTRIM (UPPER (vi_obt_desc)));
            v_obt_cod := vi_obt_cod;

            UPDATE ifrbde_views.tab_obras_tipos
               SET obt_desc = v_obt_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT obt_cod,
                      obt_desc
                 INTO vo_obt_cod (1),
                      vo_obt_desc (1)
                 FROM ifrbde_views.tab_obras_tipos
                WHERE obt_cod = v_obt_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_OBRAS_TIPOS',
                  'A',
                  TO_CHAR (vi_obt_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Movimento da Dotação
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_MOV_DOTACAO', 'PESQUISA') THEN
         SELECT mdt_ano,
                mdt_doc,
                TO_CHAR (mdt_data, 'DD/MM/YYYY'),
                mdt_tipo_doc,
                mdt_rti_cod_orig,
                mdt_dpp_orig,
                mdt_rti_cod_dest,
                mdt_dpp_dest,
                mdt_diretoria,
                mdt_motivo,
                mdt_valor
           INTO vo_mdt_ano (1),
                vo_mdt_doc (1),
                vo_mdt_data (1),
                vo_mdt_tipo_doc (1),
                vo_mdt_rti_cod_orig (1),
                vo_mdt_dpp_orig (1),
                vo_mdt_rti_cod_dest (1),
                vo_mdt_dpp_dest (1),
                vo_mdt_diretoria (1),
                vo_mdt_motivo (1),
                vo_mdt_valor (1)
           FROM ifrbde_views.tab_mov_dotacao
          WHERE mdt_ano = vi_mdt_ano
            AND mdt_doc = vi_mdt_doc
            AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
            AND mdt_tipo_doc = vi_mdt_tipo_doc
            AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
            AND mdt_dpp_orig = vi_mdt_dpp_orig;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Movimento da Dotação
   -- retorna o OK ou nao
   -- CHEQUE A DOCUMENTACAO PARA MAIS DETALHES
   PROCEDURE stp_exclui_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig
   ) AS
      CURSOR c_mov_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_mov_dotacao
              WHERE mdt_ano = vi_mdt_ano
                AND mdt_doc = vi_mdt_doc
                AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
                AND mdt_tipo_doc = vi_mdt_tipo_doc
                AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
                AND mdt_dpp_orig = vi_mdt_dpp_orig
         FOR UPDATE;

      CURSOR c_item_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      CURSOR c_item_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      v_tab_mov_dotacao             ifrbde_views.tab_mov_dotacao%ROWTYPE;
      v_tab_dotacao_origem          ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_dotacao_destino         ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_item_dotacao_origem     ifrbde_views.tab_item_dotacao%ROWTYPE;
      v_tab_item_dotacao_destino    ifrbde_views.tab_item_dotacao%ROWTYPE;
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_MOV_DOTACAO', 'EXCLUI') THEN
         OPEN c_mov_dotacao;
         FETCH c_mov_dotacao INTO v_tab_mov_dotacao;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 0 THEN -- Suplemento
            -- tira o valor da dotacao origem
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 1 THEN -- Remanejamento
            -- soma o valor na dotacao origem e tira do destino
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 2 THEN -- Descentralizacao
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest
            );
            FETCH c_dotacao_destino INTO v_tab_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 3 THEN -- Remanejo
            -- soma o valor na dotacao origem         
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         DELETE FROM ifrbde_views.tab_mov_dotacao
               WHERE mdt_ano = vi_mdt_ano
                 AND mdt_doc = vi_mdt_doc
                 AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
                 AND mdt_tipo_doc = vi_mdt_tipo_doc
                 AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
                 AND mdt_dpp_orig = vi_mdt_dpp_orig;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_MOV_DOTACAO',
               'E',
               vi_mdt_ano
               || vi_mdt_doc
               || vi_mdt_data
               || TO_CHAR (vi_mdt_tipo_doc)
               || vi_mdt_rti_cod_orig
               || TO_CHAR (vi_mdt_dpp_orig)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Movimento da Dotação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig,
      vi_mdt_rti_cod_dest   IN       t_mdt_rti_cod_dest,
      vi_mdt_dpp_dest       IN       t_mdt_dpp_dest,
      vi_mdt_diretoria      IN       t_mdt_diretoria,
      vi_mdt_motivo         IN       t_mdt_motivo,
      vi_mdt_valor          IN       t_mdt_valor
   ) AS
      v_mdt_ano                     ifrbde_views.tab_mov_dotacao.mdt_ano%TYPE;
      v_mdt_doc                     ifrbde_views.tab_mov_dotacao.mdt_doc%TYPE;
      v_mdt_data                    ifrbde_views.tab_mov_dotacao.mdt_data%TYPE;
      v_mdt_tipo_doc                ifrbde_views.tab_mov_dotacao.mdt_tipo_doc%TYPE;
      v_mdt_rti_cod_orig            ifrbde_views.tab_mov_dotacao.mdt_rti_cod_orig%TYPE;
      v_mdt_dpp_orig                ifrbde_views.tab_mov_dotacao.mdt_dpp_orig%TYPE;
      v_mdt_rti_cod_dest            ifrbde_views.tab_mov_dotacao.mdt_rti_cod_dest%TYPE;
      v_mdt_dpp_dest                ifrbde_views.tab_mov_dotacao.mdt_dpp_dest%TYPE;
      v_mdt_diretoria               ifrbde_views.tab_mov_dotacao.mdt_diretoria%TYPE;
      v_mdt_motivo                  ifrbde_views.tab_mov_dotacao.mdt_motivo%TYPE;
      v_mdt_valor                   ifrbde_views.tab_mov_dotacao.mdt_valor%TYPE;

      CURSOR c_mov_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_mov_dotacao
              WHERE mdt_ano = vi_mdt_ano
                AND mdt_doc = vi_mdt_doc
                AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
                AND mdt_tipo_doc = vi_mdt_tipo_doc
                AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
                AND mdt_dpp_orig = vi_mdt_dpp_orig
         FOR UPDATE;

      CURSOR c_item_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      CURSOR c_item_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      v_tab_mov_dotacao             ifrbde_views.tab_mov_dotacao%ROWTYPE;
      v_tab_dotacao_origem          ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_dotacao_destino         ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_item_dotacao_origem     ifrbde_views.tab_item_dotacao%ROWTYPE;
      v_tab_item_dotacao_destino    ifrbde_views.tab_item_dotacao%ROWTYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_MOV_DOTACAO', 'INCLUI') THEN
         v_mdt_ano := RTRIM (LTRIM (UPPER (vi_mdt_ano)));
         v_mdt_doc := RTRIM (LTRIM (UPPER (vi_mdt_doc)));
         v_mdt_rti_cod_orig := RTRIM (LTRIM (UPPER (vi_mdt_rti_cod_orig)));
         v_mdt_rti_cod_dest := RTRIM (LTRIM (UPPER (vi_mdt_rti_cod_dest)));
         v_mdt_diretoria := RTRIM (LTRIM (UPPER (vi_mdt_diretoria)));
         v_mdt_motivo := RTRIM (LTRIM (UPPER (vi_mdt_motivo)));
         v_mdt_data := TO_DATE (vi_mdt_data, 'DD/MM/YYYY');
         v_mdt_tipo_doc := vi_mdt_tipo_doc;
         v_mdt_dpp_orig := vi_mdt_dpp_orig;
         v_mdt_dpp_dest := vi_mdt_dpp_dest;
         v_mdt_valor := vi_mdt_valor;

         INSERT INTO ifrbde_views.tab_mov_dotacao
                     (mdt_ano,
                      mdt_doc,
                      mdt_data,
                      mdt_tipo_doc,
                      mdt_rti_cod_orig,
                      mdt_dpp_orig,
                      mdt_rti_cod_dest,
                      mdt_dpp_dest,
                      mdt_diretoria,
                      mdt_motivo,
                      mdt_valor
                     )
              VALUES (v_mdt_ano,
                      v_mdt_doc,
                      v_mdt_data,
                      v_mdt_tipo_doc,
                      v_mdt_rti_cod_orig,
                      v_mdt_dpp_orig,
                      v_mdt_rti_cod_dest,
                      v_mdt_dpp_dest,
                      v_mdt_diretoria,
                      v_mdt_motivo,
                      v_mdt_valor
                     );

         -- faz as atualizacoes

         OPEN c_mov_dotacao;
         FETCH c_mov_dotacao INTO v_tab_mov_dotacao;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 0 THEN -- Suplemento
            -- tira o valor da dotacao origem
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 1 THEN -- Remanejamento
            -- soma o valor na dotacao origem e tira do destino
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 2 THEN -- Descentralizacao
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest
            );
            FETCH c_dotacao_destino INTO v_tab_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 3 THEN -- Remanejo
            -- soma o valor na dotacao origem         
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         IF SQL%ROWCOUNT = 1 THEN
            SELECT mdt_ano,
                   mdt_doc,
                   TO_CHAR (mdt_data, 'DD/MM/YYYY'),
                   mdt_tipo_doc,
                   mdt_rti_cod_orig,
                   mdt_dpp_orig,
                   mdt_rti_cod_dest,
                   mdt_dpp_dest,
                   mdt_diretoria,
                   mdt_motivo,
                   mdt_valor
              INTO vo_mdt_ano (1),
                   vo_mdt_doc (1),
                   vo_mdt_data (1),
                   vo_mdt_tipo_doc (1),
                   vo_mdt_rti_cod_orig (1),
                   vo_mdt_dpp_orig (1),
                   vo_mdt_rti_cod_dest (1),
                   vo_mdt_dpp_dest (1),
                   vo_mdt_diretoria (1),
                   vo_mdt_motivo (1),
                   vo_mdt_valor (1)
              FROM ifrbde_views.tab_mov_dotacao
             WHERE mdt_ano = v_mdt_ano
               AND mdt_doc = v_mdt_doc
               AND mdt_data = v_mdt_data
               AND mdt_tipo_doc = v_mdt_tipo_doc
               AND mdt_rti_cod_orig = v_mdt_rti_cod_orig
               AND mdt_dpp_orig = v_mdt_dpp_orig;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_MOV_DOTACAO',
               'I',
               vi_mdt_ano
               || vi_mdt_doc
               || vi_mdt_data
               || TO_CHAR (vi_mdt_tipo_doc)
               || vi_mdt_rti_cod_orig
               || TO_CHAR (vi_mdt_dpp_orig)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Movimento da Dotação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_mov_dotacao (
      p_usuario                      VARCHAR2,
      vo_mdt_ano            OUT      tyt_mdt_ano,
      vo_mdt_doc            OUT      tyt_mdt_doc,
      vo_mdt_data           OUT      tyt_mdt_data,
      vo_mdt_tipo_doc       OUT      tyt_mdt_tipo_doc,
      vo_mdt_rti_cod_orig   OUT      tyt_mdt_rti_cod_orig,
      vo_mdt_dpp_orig       OUT      tyt_mdt_dpp_orig,
      vo_mdt_rti_cod_dest   OUT      tyt_mdt_rti_cod_dest,
      vo_mdt_dpp_dest       OUT      tyt_mdt_dpp_dest,
      vo_mdt_diretoria      OUT      tyt_mdt_diretoria,
      vo_mdt_motivo         OUT      tyt_mdt_motivo,
      vo_mdt_valor          OUT      tyt_mdt_valor,
      vi_mdt_ano            IN       t_mdt_ano,
      vi_mdt_doc            IN       t_mdt_doc,
      vi_mdt_data           IN       t_mdt_data,
      vi_mdt_tipo_doc       IN       t_mdt_tipo_doc,
      vi_mdt_rti_cod_orig   IN       t_mdt_rti_cod_orig,
      vi_mdt_dpp_orig       IN       t_mdt_dpp_orig,
      vi_mdt_rti_cod_dest   IN       t_mdt_rti_cod_dest,
      vi_mdt_dpp_dest       IN       t_mdt_dpp_dest,
      vi_mdt_diretoria      IN       t_mdt_diretoria,
      vi_mdt_motivo         IN       t_mdt_motivo,
      vi_mdt_valor          IN       t_mdt_valor
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_mov_dotacao
              WHERE mdt_ano = vi_mdt_ano
                AND mdt_doc = vi_mdt_doc
                AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
                AND mdt_tipo_doc = vi_mdt_tipo_doc
                AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
                AND mdt_dpp_orig = vi_mdt_dpp_orig
         FOR UPDATE;

      v_mdt_ano                     ifrbde_views.tab_mov_dotacao.mdt_ano%TYPE;
      v_mdt_doc                     ifrbde_views.tab_mov_dotacao.mdt_doc%TYPE;
      v_mdt_data                    ifrbde_views.tab_mov_dotacao.mdt_data%TYPE;
      v_mdt_tipo_doc                ifrbde_views.tab_mov_dotacao.mdt_tipo_doc%TYPE;
      v_mdt_rti_cod_orig            ifrbde_views.tab_mov_dotacao.mdt_rti_cod_orig%TYPE;
      v_mdt_dpp_orig                ifrbde_views.tab_mov_dotacao.mdt_dpp_orig%TYPE;
      v_mdt_rti_cod_dest            ifrbde_views.tab_mov_dotacao.mdt_rti_cod_dest%TYPE;
      v_mdt_dpp_dest                ifrbde_views.tab_mov_dotacao.mdt_dpp_dest%TYPE;
      v_mdt_diretoria               ifrbde_views.tab_mov_dotacao.mdt_diretoria%TYPE;
      v_mdt_motivo                  ifrbde_views.tab_mov_dotacao.mdt_motivo%TYPE;
      v_mdt_valor                   ifrbde_views.tab_mov_dotacao.mdt_valor%TYPE;

      CURSOR c_mov_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_mov_dotacao
              WHERE mdt_ano = vi_mdt_ano
                AND mdt_doc = vi_mdt_doc
                AND mdt_data = TO_DATE (vi_mdt_data, 'DD/MM/YYYY')
                AND mdt_tipo_doc = vi_mdt_tipo_doc
                AND mdt_rti_cod_orig = vi_mdt_rti_cod_orig
                AND mdt_dpp_orig = vi_mdt_dpp_orig
         FOR UPDATE;

      CURSOR c_item_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_origem (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      CURSOR c_item_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2,
         dep   NUMBER
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = ano
                AND dti_dot_rti_cod = rec
                AND dti_dpp_cod = dep
         FOR UPDATE;

      CURSOR c_dotacao_destino (
         ano   VARCHAR2,
         rec   VARCHAR2
      ) IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = ano AND dot_rti_cod = rec
         FOR UPDATE;

      v_tab_mov_dotacao             ifrbde_views.tab_mov_dotacao%ROWTYPE;
      v_tab_dotacao_origem          ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_dotacao_destino         ifrbde_views.tab_dotacao%ROWTYPE;
      v_tab_item_dotacao_origem     ifrbde_views.tab_item_dotacao%ROWTYPE;
      v_tab_item_dotacao_destino    ifrbde_views.tab_item_dotacao%ROWTYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_MOV_DOTACAO', 'ALTERA') THEN
         OPEN c_mov_dotacao;
         FETCH c_mov_dotacao INTO v_tab_mov_dotacao;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 0 THEN -- Suplemento
            -- tira o valor da dotacao origem
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 1 THEN -- Remanejamento
            -- soma o valor na dotacao origem e tira do destino
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 2 THEN -- Descentralizacao
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
            OPEN c_item_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest,
               v_tab_mov_dotacao.mdt_dpp_dest
            );
            FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_dotacao_destino (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_dest
            );
            FETCH c_dotacao_destino INTO v_tab_dotacao_destino;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_destino;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_destino;
         END IF;

         IF v_tab_mov_dotacao.mdt_tipo_doc = 3 THEN -- Remanejo
            -- soma o valor na dotacao origem         
            OPEN c_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig
            );
            FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
            OPEN c_item_dotacao_origem (
               v_tab_mov_dotacao.mdt_ano,
               v_tab_mov_dotacao.mdt_rti_cod_orig,
               v_tab_mov_dotacao.mdt_dpp_orig
            );
            FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_dotacao_origem;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
             WHERE  CURRENT OF c_item_dotacao_origem;
         END IF;

         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_mov_dotacao;

         IF NOT c_cursor%NOTFOUND THEN
            v_mdt_ano := RTRIM (LTRIM (UPPER (vi_mdt_ano)));
            v_mdt_doc := RTRIM (LTRIM (UPPER (vi_mdt_doc)));
            v_mdt_rti_cod_orig := RTRIM (LTRIM (UPPER (vi_mdt_rti_cod_orig)));
            v_mdt_rti_cod_dest := RTRIM (LTRIM (UPPER (vi_mdt_rti_cod_dest)));
            v_mdt_diretoria := RTRIM (LTRIM (UPPER (vi_mdt_diretoria)));
            v_mdt_motivo := RTRIM (LTRIM (UPPER (vi_mdt_motivo)));
            v_mdt_data := TO_DATE (vi_mdt_data, 'DD/MM/YYYY');
            v_mdt_tipo_doc := vi_mdt_tipo_doc;
            v_mdt_dpp_orig := vi_mdt_dpp_orig;
            v_mdt_dpp_dest := vi_mdt_dpp_dest;
            v_mdt_valor := vi_mdt_valor;

            UPDATE ifrbde_views.tab_mov_dotacao
               SET mdt_rti_cod_dest = v_mdt_rti_cod_dest,
                   mdt_dpp_dest = v_mdt_dpp_dest,
                   mdt_diretoria = v_mdt_diretoria,
                   mdt_motivo = v_mdt_motivo,
                   mdt_valor = v_mdt_valor
             WHERE  CURRENT OF c_cursor;

            CLOSE c_mov_dotacao;
            OPEN c_mov_dotacao;
            FETCH c_mov_dotacao INTO v_tab_mov_dotacao;

            IF v_tab_mov_dotacao.mdt_tipo_doc = 0 THEN -- Suplemento
               -- tira o valor da dotacao origem
               CLOSE c_dotacao_origem;
               OPEN c_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig
               );
               FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
               CLOSE c_item_dotacao_origem;
               OPEN c_item_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig,
                  v_tab_mov_dotacao.mdt_dpp_orig
               );
               FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

               UPDATE ifrbde_views.tab_dotacao
                  SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_dotacao_origem;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_origem;
            END IF;

            IF v_tab_mov_dotacao.mdt_tipo_doc = 1 THEN -- Remanejamento
               -- soma o valor na dotacao origem e tira do destino
               CLOSE c_item_dotacao_origem;
               OPEN c_item_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig,
                  v_tab_mov_dotacao.mdt_dpp_orig
               );
               FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
               CLOSE c_item_dotacao_destino;
               OPEN c_item_dotacao_destino (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_dest,
                  v_tab_mov_dotacao.mdt_dpp_dest
               );
               FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_origem;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_destino;
            END IF;

            IF v_tab_mov_dotacao.mdt_tipo_doc = 2 THEN -- Descentralizacao
               CLOSE c_item_dotacao_origem;
               OPEN c_item_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig,
                  v_tab_mov_dotacao.mdt_dpp_orig
               );
               FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;
               CLOSE c_item_dotacao_destino;
               OPEN c_item_dotacao_destino (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_dest,
                  v_tab_mov_dotacao.mdt_dpp_dest
               );
               FETCH c_item_dotacao_destino INTO v_tab_item_dotacao_destino;
               CLOSE c_dotacao_origem;
               OPEN c_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig
               );
               FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
               CLOSE c_dotacao_destino;
               OPEN c_dotacao_destino (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_dest
               );
               FETCH c_dotacao_destino INTO v_tab_dotacao_destino;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_origem;

               UPDATE ifrbde_views.tab_dotacao
                  SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_dotacao_origem;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo + v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_destino;

               UPDATE ifrbde_views.tab_dotacao
                  SET dot_saldo = dot_saldo + v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_dotacao_destino;
            END IF;

            IF v_tab_mov_dotacao.mdt_tipo_doc = 3 THEN -- Remanejo
               -- soma o valor na dotacao origem         
               CLOSE c_dotacao_origem;
               OPEN c_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig
               );
               FETCH c_dotacao_origem INTO v_tab_dotacao_origem;
               CLOSE c_item_dotacao_origem;
               OPEN c_item_dotacao_origem (
                  v_tab_mov_dotacao.mdt_ano,
                  v_tab_mov_dotacao.mdt_rti_cod_orig,
                  v_tab_mov_dotacao.mdt_dpp_orig
               );
               FETCH c_item_dotacao_origem INTO v_tab_item_dotacao_origem;

               UPDATE ifrbde_views.tab_dotacao
                  SET dot_saldo = dot_saldo - v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_dotacao_origem;

               UPDATE ifrbde_views.tab_item_dotacao
                  SET dti_saldo = dti_saldo - v_tab_mov_dotacao.mdt_valor
                WHERE  CURRENT OF c_item_dotacao_origem;
            END IF;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT mdt_ano,
                      mdt_doc,
                      TO_CHAR (mdt_data, 'DD/MM/YYYY'),
                      mdt_tipo_doc,
                      mdt_rti_cod_orig,
                      mdt_dpp_orig,
                      mdt_rti_cod_dest,
                      mdt_dpp_dest,
                      mdt_diretoria,
                      mdt_motivo,
                      mdt_valor
                 INTO vo_mdt_ano (1),
                      vo_mdt_doc (1),
                      vo_mdt_data (1),
                      vo_mdt_tipo_doc (1),
                      vo_mdt_rti_cod_orig (1),
                      vo_mdt_dpp_orig (1),
                      vo_mdt_rti_cod_dest (1),
                      vo_mdt_dpp_dest (1),
                      vo_mdt_diretoria (1),
                      vo_mdt_motivo (1),
                      vo_mdt_valor (1)
                 FROM ifrbde_views.tab_mov_dotacao
                WHERE mdt_ano = v_mdt_ano
                  AND mdt_doc = v_mdt_doc
                  AND mdt_data = v_mdt_data
                  AND mdt_tipo_doc = v_mdt_tipo_doc
                  AND mdt_rti_cod_orig = v_mdt_rti_cod_orig
                  AND mdt_dpp_orig = v_mdt_dpp_orig;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_MOV_DOTACAO',
                  'A',
                  vi_mdt_ano
                  || vi_mdt_doc
                  || vi_mdt_data
                  || TO_CHAR (vi_mdt_tipo_doc)
                  || vi_mdt_rti_cod_orig
                  || TO_CHAR (vi_mdt_dpp_orig)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Natureza da Obra
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA', 'PESQUISA') THEN
         SELECT nto_cod,
                nto_desc
           INTO vo_nto_cod (1),
                vo_nto_desc (1)
           FROM ifrbde_views.tab_natureza_obra
          WHERE nto_cod = vi_nto_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Natureza da Obra
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_natureza_obra (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_nto_cod   IN       t_nto_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_natureza_obra
               WHERE nto_cod = vi_nto_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_NATUREZA_OBRA', 'E', TO_CHAR (
                                                             vi_nto_cod
                                                          ));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Natureza da Obra
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod,
      vi_nto_desc   IN       t_nto_desc
   ) AS
      v_nto_cod                     ifrbde_views.tab_natureza_obra.nto_cod%TYPE;
      v_nto_desc                    ifrbde_views.tab_natureza_obra.nto_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA', 'INCLUI') THEN
         v_nto_desc := RTRIM (LTRIM (UPPER (vi_nto_desc)));
         v_nto_cod := vi_nto_cod;

         INSERT INTO ifrbde_views.tab_natureza_obra
                     (nto_cod,
                      nto_desc
                     )
              VALUES (v_nto_cod,
                      v_nto_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT nto_cod,
                   nto_desc
              INTO vo_nto_cod (1),
                   vo_nto_desc (1)
              FROM ifrbde_views.tab_natureza_obra
             WHERE nto_cod = v_nto_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_NATUREZA_OBRA',
               'I',
               TO_CHAR (vi_nto_cod) || v_nto_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Natureza da Obra
-- retorna o recordset correspondente
   PROCEDURE stp_altera_natureza_obra (
      p_usuario              VARCHAR2,
      vo_nto_cod    OUT      tyt_nto_cod,
      vo_nto_desc   OUT      tyt_nto_desc,
      vi_nto_cod    IN       t_nto_cod,
      vi_nto_desc   IN       t_nto_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_natureza_obra
              WHERE nto_cod = vi_nto_cod
         FOR UPDATE;

      v_tab_natureza_obra           ifrbde_views.tab_natureza_obra%ROWTYPE;
      v_nto_cod                     ifrbde_views.tab_natureza_obra.nto_cod%TYPE;
      v_nto_desc                    ifrbde_views.tab_natureza_obra.nto_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_natureza_obra;

         IF NOT c_cursor%NOTFOUND THEN
            v_nto_desc := RTRIM (LTRIM (UPPER (vi_nto_desc)));
            v_nto_cod := vi_nto_cod;

            UPDATE ifrbde_views.tab_natureza_obra
               SET nto_desc = v_nto_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT nto_cod,
                      nto_desc
                 INTO vo_nto_cod (1),
                      vo_nto_desc (1)
                 FROM ifrbde_views.tab_natureza_obra
                WHERE nto_cod = v_nto_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_NATUREZA_OBRA',
                  'A',
                  TO_CHAR (vi_nto_cod) || v_nto_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Itens da Natureza
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA_FIL', 'PESQUISA') THEN
         SELECT ntf_nto_cod,
                ntf_cod,
                ntf_desc
           INTO vo_ntf_nto_cod (1),
                vo_ntf_cod (1),
                vo_ntf_desc (1)
           FROM ifrbde_views.tab_natureza_obra_fil
          WHERE ntf_nto_cod = vi_ntf_nto_cod AND ntf_cod = vi_ntf_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Itens da Natureza
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA_FIL', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_natureza_obra_fil
               WHERE ntf_nto_cod = vi_ntf_nto_cod AND ntf_cod = vi_ntf_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_NATUREZA_OBRA_FIL',
               'E',
               TO_CHAR (vi_ntf_nto_cod) || vi_ntf_cod
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Itens da Natureza
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod,
      vi_ntf_desc      IN       t_ntf_desc
   ) AS
      v_ntf_nto_cod                 ifrbde_views.tab_natureza_obra_fil.ntf_nto_cod%TYPE;
      v_ntf_cod                     ifrbde_views.tab_natureza_obra_fil.ntf_cod%TYPE;
      v_ntf_desc                    ifrbde_views.tab_natureza_obra_fil.ntf_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA_FIL', 'INCLUI') THEN
         v_ntf_cod := RTRIM (LTRIM (UPPER (vi_ntf_cod)));
         v_ntf_desc := RTRIM (LTRIM (UPPER (vi_ntf_desc)));
         v_ntf_nto_cod := vi_ntf_nto_cod;

         INSERT INTO ifrbde_views.tab_natureza_obra_fil
                     (ntf_nto_cod,
                      ntf_cod,
                      ntf_desc
                     )
              VALUES (v_ntf_nto_cod,
                      v_ntf_cod,
                      v_ntf_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT ntf_nto_cod,
                   ntf_cod,
                   ntf_desc
              INTO vo_ntf_nto_cod (1),
                   vo_ntf_cod (1),
                   vo_ntf_desc (1)
              FROM ifrbde_views.tab_natureza_obra_fil
             WHERE ntf_nto_cod = v_ntf_nto_cod AND ntf_cod = v_ntf_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_NATUREZA_OBRA_FIL',
               'I',
               TO_CHAR (vi_ntf_nto_cod) || v_ntf_cod || v_ntf_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Itens da Natureza
-- retorna o recordset correspondente
   PROCEDURE stp_altera_natureza_obra_fil (
      p_usuario                 VARCHAR2,
      vo_ntf_nto_cod   OUT      tyt_ntf_nto_cod,
      vo_ntf_cod       OUT      tyt_ntf_cod,
      vo_ntf_desc      OUT      tyt_ntf_desc,
      vi_ntf_nto_cod   IN       t_ntf_nto_cod,
      vi_ntf_cod       IN       t_ntf_cod,
      vi_ntf_desc      IN       t_ntf_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_natureza_obra_fil
              WHERE ntf_nto_cod = vi_ntf_nto_cod AND ntf_cod = vi_ntf_cod
         FOR UPDATE;

      v_tab_natureza_obra_fil       ifrbde_views.tab_natureza_obra_fil%ROWTYPE;
      v_ntf_nto_cod                 ifrbde_views.tab_natureza_obra_fil.ntf_nto_cod%TYPE;
      v_ntf_cod                     ifrbde_views.tab_natureza_obra_fil.ntf_cod%TYPE;
      v_ntf_desc                    ifrbde_views.tab_natureza_obra_fil.ntf_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_NATUREZA_OBRA_FIL', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_natureza_obra_fil;

         IF NOT c_cursor%NOTFOUND THEN
            v_ntf_cod := RTRIM (LTRIM (UPPER (vi_ntf_cod)));
            v_ntf_desc := RTRIM (LTRIM (UPPER (vi_ntf_desc)));
            v_ntf_nto_cod := vi_ntf_nto_cod;

            UPDATE ifrbde_views.tab_natureza_obra_fil
               SET ntf_desc = v_ntf_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT ntf_nto_cod,
                      ntf_cod,
                      ntf_desc
                 INTO vo_ntf_nto_cod (1),
                      vo_ntf_cod (1),
                      vo_ntf_desc (1)
                 FROM ifrbde_views.tab_natureza_obra_fil
                WHERE ntf_nto_cod = v_ntf_nto_cod AND ntf_cod = v_ntf_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_NATUREZA_OBRA_FIL',
                  'A',
                  TO_CHAR (vi_ntf_nto_cod) || v_ntf_cod || v_ntf_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Cadastro de Dependências
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA_PAI', 'PESQUISA') THEN
         SELECT dpp_cod,
                dpp_desc,
                dpp_sigla
           INTO vo_dpp_cod (1),
                vo_dpp_desc (1),
                vo_dpp_sigla (1)
           FROM ifrbde_views.tab_dependencia_pai
          WHERE dpp_cod = vi_dpp_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Cadastro de Dependências
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_dependencia_pai (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_dpp_cod   IN       t_dpp_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA_PAI', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_dependencia_pai
               WHERE dpp_cod = vi_dpp_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_DEPENDENCIA_PAI',
               'E',
               TO_CHAR (vi_dpp_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Dependências
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod,
      vi_dpp_desc    IN       t_dpp_desc,
      vi_dpp_sigla   IN       t_dpp_sigla
   ) AS
      v_dpp_cod                     ifrbde_views.tab_dependencia_pai.dpp_cod%TYPE;
      v_dpp_desc                    ifrbde_views.tab_dependencia_pai.dpp_desc%TYPE;
      v_dpp_sigla                   ifrbde_views.tab_dependencia_pai.dpp_sigla%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA_PAI', 'INCLUI') THEN
         v_dpp_desc := RTRIM (LTRIM (UPPER (vi_dpp_desc)));
         v_dpp_sigla := RTRIM (LTRIM (UPPER (vi_dpp_sigla)));
         v_dpp_cod := vi_dpp_cod;

         INSERT INTO ifrbde_views.tab_dependencia_pai
                     (dpp_cod,
                      dpp_desc,
                      dpp_sigla
                     )
              VALUES (v_dpp_cod,
                      v_dpp_desc,
                      v_dpp_sigla
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT dpp_cod,
                   dpp_desc,
                   dpp_sigla
              INTO vo_dpp_cod (1),
                   vo_dpp_desc (1),
                   vo_dpp_sigla (1)
              FROM ifrbde_views.tab_dependencia_pai
             WHERE dpp_cod = v_dpp_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_DEPENDENCIA_PAI',
               'I',
               TO_CHAR (vi_dpp_cod) || v_dpp_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Dependências
-- retorna o recordset correspondente
   PROCEDURE stp_altera_dependencia_pai (
      p_usuario               VARCHAR2,
      vo_dpp_cod     OUT      tyt_dpp_cod,
      vo_dpp_desc    OUT      tyt_dpp_desc,
      vo_dpp_sigla   OUT      tyt_dpp_sigla,
      vi_dpp_cod     IN       t_dpp_cod,
      vi_dpp_desc    IN       t_dpp_desc,
      vi_dpp_sigla   IN       t_dpp_sigla
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_dependencia_pai
              WHERE dpp_cod = vi_dpp_cod
         FOR UPDATE;

      v_tab_dependencia_pai         ifrbde_views.tab_dependencia_pai%ROWTYPE;
      v_dpp_cod                     ifrbde_views.tab_dependencia_pai.dpp_cod%TYPE;
      v_dpp_desc                    ifrbde_views.tab_dependencia_pai.dpp_desc%TYPE;
      v_dpp_sigla                   ifrbde_views.tab_dependencia_pai.dpp_sigla%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA_PAI', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_dependencia_pai;

         IF NOT c_cursor%NOTFOUND THEN
            v_dpp_desc := RTRIM (LTRIM (UPPER (vi_dpp_desc)));
            v_dpp_sigla := RTRIM (LTRIM (UPPER (vi_dpp_sigla)));
            v_dpp_cod := vi_dpp_cod;

            UPDATE ifrbde_views.tab_dependencia_pai
               SET dpp_desc = v_dpp_desc,
                   dpp_sigla = v_dpp_sigla
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT dpp_cod,
                      dpp_desc,
                      dpp_sigla
                 INTO vo_dpp_cod (1),
                      vo_dpp_desc (1),
                      vo_dpp_sigla (1)
                 FROM ifrbde_views.tab_dependencia_pai
                WHERE dpp_cod = v_dpp_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_DEPENDENCIA_PAI',
                  'A',
                  TO_CHAR (vi_dpp_cod) || v_dpp_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Dependências
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_cod       IN       t_dep_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA', 'PESQUISA') THEN
         SELECT dep_dpp_cod,
                dep_cod,
                dep_desc,
                dep_sigla,
                dep_uf,
                dep_eix_cod,
                dep_tipo
           INTO vo_dep_dpp_cod (1),
                vo_dep_cod (1),
                vo_dep_desc (1),
                vo_dep_sigla (1),
                vo_dep_uf (1),
                vo_dep_eix_cod (1),
                vo_dep_tipo (1)
           FROM ifrbde_views.tab_dependencia
          WHERE dep_cod = vi_dep_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Dependências
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_dependencia (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_dep_cod   IN       t_dep_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_dependencia
               WHERE dep_cod = vi_dep_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_DEPENDENCIA', 'E', TO_CHAR (vi_dep_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Dependências
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_dpp_cod   IN       t_dep_dpp_cod,
      vi_dep_cod       IN       t_dep_cod,
      vi_dep_desc      IN       t_dep_desc,
      vi_dep_sigla     IN       t_dep_sigla,
      vi_dep_uf        IN       t_dep_uf,
      vi_dep_eix_cod   IN       t_dep_eix_cod,
      vi_dep_tipo      IN       t_dep_tipo
   ) AS
      v_dep_dpp_cod                 ifrbde_views.tab_dependencia.dep_dpp_cod%TYPE;
      v_dep_cod                     ifrbde_views.tab_dependencia.dep_cod%TYPE;
      v_dep_desc                    ifrbde_views.tab_dependencia.dep_desc%TYPE;
      v_dep_sigla                   ifrbde_views.tab_dependencia.dep_sigla%TYPE;
      v_dep_uf                      ifrbde_views.tab_dependencia.dep_uf%TYPE;
      v_dep_eix_cod                 ifrbde_views.tab_dependencia.dep_eix_cod%TYPE;
      v_dep_tipo                    ifrbde_views.tab_dependencia.dep_tipo%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA', 'INCLUI') THEN
         v_dep_desc := RTRIM (LTRIM (UPPER (vi_dep_desc)));
         v_dep_sigla := RTRIM (LTRIM (UPPER (vi_dep_sigla)));
         v_dep_uf := RTRIM (LTRIM (UPPER (vi_dep_uf)));
         v_dep_tipo := RTRIM (LTRIM (UPPER (vi_dep_tipo)));
         v_dep_dpp_cod := vi_dep_dpp_cod;
         v_dep_cod := vi_dep_cod;
         v_dep_eix_cod := vi_dep_eix_cod;

         INSERT INTO ifrbde_views.tab_dependencia
                     (dep_dpp_cod,
                      dep_cod,
                      dep_desc,
                      dep_sigla,
                      dep_uf,
                      dep_eix_cod,
                      dep_tipo
                     )
              VALUES (v_dep_dpp_cod,
                      v_dep_cod,
                      v_dep_desc,
                      v_dep_sigla,
                      v_dep_uf,
                      v_dep_eix_cod,
                      v_dep_tipo
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT dep_dpp_cod,
                   dep_cod,
                   dep_desc,
                   dep_sigla,
                   dep_uf,
                   dep_eix_cod,
                   dep_tipo
              INTO vo_dep_dpp_cod (1),
                   vo_dep_cod (1),
                   vo_dep_desc (1),
                   vo_dep_sigla (1),
                   vo_dep_uf (1),
                   vo_dep_eix_cod (1),
                   vo_dep_tipo (1)
              FROM ifrbde_views.tab_dependencia
             WHERE dep_cod = v_dep_cod;

            -- LOG
            stp_log (p_usuario, 'TAB_DEPENDENCIA', 'I', TO_CHAR (vi_dep_cod));
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Dependências
-- retorna o recordset correspondente
   PROCEDURE stp_altera_dependencia (
      p_usuario                 VARCHAR2,
      vo_dep_dpp_cod   OUT      tyt_dep_dpp_cod,
      vo_dep_cod       OUT      tyt_dep_cod,
      vo_dep_desc      OUT      tyt_dep_desc,
      vo_dep_sigla     OUT      tyt_dep_sigla,
      vo_dep_uf        OUT      tyt_dep_uf,
      vo_dep_eix_cod   OUT      tyt_dep_eix_cod,
      vo_dep_tipo      OUT      tyt_dep_tipo,
      vi_dep_dpp_cod   IN       t_dep_dpp_cod,
      vi_dep_cod       IN       t_dep_cod,
      vi_dep_desc      IN       t_dep_desc,
      vi_dep_sigla     IN       t_dep_sigla,
      vi_dep_uf        IN       t_dep_uf,
      vi_dep_eix_cod   IN       t_dep_eix_cod,
      vi_dep_tipo      IN       t_dep_tipo
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_dependencia
              WHERE dep_cod = vi_dep_cod
         FOR UPDATE;

      v_tab_dependencia             ifrbde_views.tab_dependencia%ROWTYPE;
      v_dep_dpp_cod                 ifrbde_views.tab_dependencia.dep_dpp_cod%TYPE;
      v_dep_cod                     ifrbde_views.tab_dependencia.dep_cod%TYPE;
      v_dep_desc                    ifrbde_views.tab_dependencia.dep_desc%TYPE;
      v_dep_sigla                   ifrbde_views.tab_dependencia.dep_sigla%TYPE;
      v_dep_uf                      ifrbde_views.tab_dependencia.dep_uf%TYPE;
      v_dep_eix_cod                 ifrbde_views.tab_dependencia.dep_eix_cod%TYPE;
      v_dep_tipo                    ifrbde_views.tab_dependencia.dep_tipo%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DEPENDENCIA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_dependencia;

         IF NOT c_cursor%NOTFOUND THEN
            v_dep_desc := RTRIM (LTRIM (UPPER (vi_dep_desc)));
            v_dep_sigla := RTRIM (LTRIM (UPPER (vi_dep_sigla)));
            v_dep_uf := RTRIM (LTRIM (UPPER (vi_dep_uf)));
            v_dep_tipo := RTRIM (LTRIM (UPPER (vi_dep_tipo)));
            v_dep_dpp_cod := vi_dep_dpp_cod;
            v_dep_cod := vi_dep_cod;
            v_dep_eix_cod := vi_dep_eix_cod;

            UPDATE ifrbde_views.tab_dependencia
               SET dep_dpp_cod = v_dep_dpp_cod,
                   dep_desc = v_dep_desc,
                   dep_sigla = v_dep_sigla,
                   dep_uf = v_dep_uf,
                   dep_eix_cod = v_dep_eix_cod,
                   dep_tipo = v_dep_tipo
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT dep_dpp_cod,
                      dep_cod,
                      dep_desc,
                      dep_sigla,
                      dep_uf,
                      dep_eix_cod,
                      dep_tipo
                 INTO vo_dep_dpp_cod (1),
                      vo_dep_cod (1),
                      vo_dep_desc (1),
                      vo_dep_sigla (1),
                      vo_dep_uf (1),
                      vo_dep_eix_cod (1),
                      vo_dep_tipo (1)
                 FROM ifrbde_views.tab_dependencia
                WHERE dep_cod = v_dep_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_DEPENDENCIA',
                  'A',
                  TO_CHAR (vi_dep_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Cadastro de Índices
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice (
      p_usuario             VARCHAR2,
      vo_ice_cod   OUT      tyt_ice_cod,
      vi_ice_cod   IN       t_ice_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_INDICE', 'PESQUISA') THEN
         SELECT ice_cod
           INTO vo_ice_cod (1)
           FROM ifrbde_views.tab_indice
          WHERE ice_cod = vi_ice_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Cadastro de Índices
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_indice (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_ice_cod   IN       t_ice_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_INDICE', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_indice
               WHERE ice_cod = vi_ice_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_INDICE', 'E', vi_ice_cod);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Índices
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice (
      p_usuario             VARCHAR2,
      vo_ice_cod   OUT      tyt_ice_cod,
      vi_ice_cod   IN       t_ice_cod
   ) AS
      v_ice_cod                     ifrbde_views.tab_indice.ice_cod%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_INDICE', 'INCLUI') THEN
         v_ice_cod := RTRIM (LTRIM (UPPER (vi_ice_cod)));

         INSERT INTO ifrbde_views.tab_indice
                     (ice_cod)
              VALUES (v_ice_cod);

         IF SQL%ROWCOUNT = 1 THEN
            SELECT ice_cod
              INTO vo_ice_cod (1)
              FROM ifrbde_views.tab_indice
             WHERE ice_cod = v_ice_cod;

            -- LOG
            stp_log (p_usuario, 'TAB_INDICE', 'I', vi_ice_cod);
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Itens
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_INDICE_FIL', 'PESQUISA') THEN
         SELECT ici_ice_cod,
                TO_CHAR (ici_periodo, 'DD/MM/YYYY'),
                ici_valor_diario
           INTO vo_ici_ice_cod (1),
                vo_ici_periodo (1),
                vo_ici_valor_diario (1)
           FROM ifrbde_views.tab_indice_fil
          WHERE ici_ice_cod = vi_ici_ice_cod
            AND ici_periodo = TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Itens
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_indice_fil (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_ici_ice_cod   IN       t_ici_ice_cod,
      vi_ici_periodo   IN       t_ici_periodo
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_INDICE_FIL', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_indice_fil
               WHERE ici_ice_cod = vi_ici_ice_cod
                 AND ici_periodo = TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_INDICE_FIL',
               'E',
               vi_ici_ice_cod || vi_ici_periodo
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Itens
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   ) AS
      v_ici_ice_cod                 ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo                 ifrbde_views.tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario            ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_INDICE_FIL', 'INCLUI') THEN
         v_ici_ice_cod := RTRIM (LTRIM (UPPER (vi_ici_ice_cod)));
         v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
         v_ici_valor_diario := vi_ici_valor_diario;

         INSERT INTO ifrbde_views.tab_indice_fil
                     (ici_ice_cod,
                      ici_periodo,
                      ici_valor_diario
                     )
              VALUES (v_ici_ice_cod,
                      v_ici_periodo,
                      v_ici_valor_diario
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT ici_ice_cod,
                   TO_CHAR (ici_periodo, 'DD/MM/YYYY'),
                   ici_valor_diario
              INTO vo_ici_ice_cod (1),
                   vo_ici_periodo (1),
                   vo_ici_valor_diario (1)
              FROM ifrbde_views.tab_indice_fil
             WHERE ici_ice_cod = v_ici_ice_cod AND ici_periodo =
                                                                v_ici_periodo;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_INDICE_FIL',
               'I',
               v_ici_ice_cod || TO_CHAR (v_ici_periodo)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Itens
-- retorna o recordset correspondente
   PROCEDURE stp_altera_indice_fil (
      p_usuario                      VARCHAR2,
      vo_ici_ice_cod        OUT      tyt_ici_ice_cod,
      vo_ici_periodo        OUT      tyt_ici_periodo,
      vo_ici_valor_diario   OUT      tyt_ici_valor_diario,
      vi_ici_ice_cod        IN       t_ici_ice_cod,
      vi_ici_periodo        IN       t_ici_periodo,
      vi_ici_valor_diario   IN       t_ici_valor_diario
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_indice_fil
              WHERE ici_ice_cod = vi_ici_ice_cod
                AND ici_periodo = TO_DATE (vi_ici_periodo, 'DD/MM/YYYY')
         FOR UPDATE;

      v_tab_indice_fil              ifrbde_views.tab_indice_fil%ROWTYPE;
      v_ici_ice_cod                 ifrbde_views.tab_indice_fil.ici_ice_cod%TYPE;
      v_ici_periodo                 ifrbde_views.tab_indice_fil.ici_periodo%TYPE;
      v_ici_valor_diario            ifrbde_views.tab_indice_fil.ici_valor_diario%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_INDICE_FIL', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_indice_fil;

         IF NOT c_cursor%NOTFOUND THEN
            v_ici_ice_cod := RTRIM (LTRIM (UPPER (vi_ici_ice_cod)));
            v_ici_periodo := TO_DATE (vi_ici_periodo, 'DD/MM/YYYY');
            v_ici_valor_diario := vi_ici_valor_diario;

            UPDATE ifrbde_views.tab_indice_fil
               SET ici_valor_diario = v_ici_valor_diario
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT ici_ice_cod,
                      TO_CHAR (ici_periodo, 'DD/MM/YYYY'),
                      ici_valor_diario
                 INTO vo_ici_ice_cod (1),
                      vo_ici_periodo (1),
                      vo_ici_valor_diario (1)
                 FROM ifrbde_views.tab_indice_fil
                WHERE ici_ice_cod = v_ici_ice_cod
                  AND ici_periodo = v_ici_periodo;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_INDICE_FIL',
                  'A',
                  v_ici_ice_cod || TO_CHAR (v_ici_periodo)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Tipos de Recursos
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO', 'PESQUISA') THEN
         SELECT rct_cod,
                rct_desc,
                rct_sigla
           INTO vo_rct_cod (1),
                vo_rct_desc (1),
                vo_rct_sigla (1)
           FROM ifrbde_views.tab_tipo_recurso
          WHERE rct_cod = vi_rct_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Tipos de Recursos
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_tipo_recurso (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rct_cod   IN       t_rct_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_tipo_recurso
               WHERE rct_cod = vi_rct_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_TIPO_RECURSO', 'E', TO_CHAR (vi_rct_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Tipos de Recursos
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod,
      vi_rct_desc    IN       t_rct_desc,
      vi_rct_sigla   IN       t_rct_sigla
   ) AS
      v_rct_cod                     ifrbde_views.tab_tipo_recurso.rct_cod%TYPE;
      v_rct_desc                    ifrbde_views.tab_tipo_recurso.rct_desc%TYPE;
      v_rct_sigla                   ifrbde_views.tab_tipo_recurso.rct_sigla%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO', 'INCLUI') THEN
         v_rct_desc := RTRIM (LTRIM (UPPER (vi_rct_desc)));
         v_rct_sigla := RTRIM (LTRIM (UPPER (vi_rct_sigla)));
         v_rct_cod := vi_rct_cod;

         INSERT INTO ifrbde_views.tab_tipo_recurso
                     (rct_cod,
                      rct_desc,
                      rct_sigla
                     )
              VALUES (v_rct_cod,
                      v_rct_desc,
                      v_rct_sigla
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT rct_cod,
                   rct_desc,
                   rct_sigla
              INTO vo_rct_cod (1),
                   vo_rct_desc (1),
                   vo_rct_sigla (1)
              FROM ifrbde_views.tab_tipo_recurso
             WHERE rct_cod = v_rct_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_TIPO_RECURSO',
               'I',
               TO_CHAR (v_rct_cod) || v_rct_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Tipos de Recursos
-- retorna o recordset correspondente
   PROCEDURE stp_altera_tipo_recurso (
      p_usuario               VARCHAR2,
      vo_rct_cod     OUT      tyt_rct_cod,
      vo_rct_desc    OUT      tyt_rct_desc,
      vo_rct_sigla   OUT      tyt_rct_sigla,
      vi_rct_cod     IN       t_rct_cod,
      vi_rct_desc    IN       t_rct_desc,
      vi_rct_sigla   IN       t_rct_sigla
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_tipo_recurso
              WHERE rct_cod = vi_rct_cod
         FOR UPDATE;

      v_tab_tipo_recurso            ifrbde_views.tab_tipo_recurso%ROWTYPE;
      v_rct_cod                     ifrbde_views.tab_tipo_recurso.rct_cod%TYPE;
      v_rct_desc                    ifrbde_views.tab_tipo_recurso.rct_desc%TYPE;
      v_rct_sigla                   ifrbde_views.tab_tipo_recurso.rct_sigla%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_tipo_recurso;

         IF NOT c_cursor%NOTFOUND THEN
            v_rct_desc := RTRIM (LTRIM (UPPER (vi_rct_desc)));
            v_rct_sigla := RTRIM (LTRIM (UPPER (vi_rct_sigla)));
            v_rct_cod := vi_rct_cod;

            UPDATE ifrbde_views.tab_tipo_recurso
               SET rct_desc = v_rct_desc,
                   rct_sigla = v_rct_sigla
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT rct_cod,
                      rct_desc,
                      rct_sigla
                 INTO vo_rct_cod (1),
                      vo_rct_desc (1),
                      vo_rct_sigla (1)
                 FROM ifrbde_views.tab_tipo_recurso
                WHERE rct_cod = v_rct_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_TIPO_RECURSO',
                  'A',
                  TO_CHAR (v_rct_cod) || v_rct_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Itens do tipo de recurso
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_cod        IN       t_rti_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO_ITEM', 'PESQUISA') THEN
         SELECT rti_rct_cod,
                rti_cod,
                rti_desc,
                rti_sigla,
                rti_conta,
                rti_programa
           INTO vo_rti_rct_cod (1),
                vo_rti_cod (1),
                vo_rti_desc (1),
                vo_rti_sigla (1),
                vo_rti_conta (1),
                vo_rti_programa (1)
           FROM ifrbde_views.tab_tipo_recurso_item
          WHERE rti_cod = vi_rti_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Itens do tipo de recurso
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_tipo_recurso_item (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rti_cod   IN       t_rti_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO_ITEM', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_tipo_recurso_item
               WHERE rti_cod = vi_rti_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_TIPO_RECURSO_ITEM', 'E', vi_rti_cod);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Itens do tipo de recurso
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_rct_cod    IN       t_rti_rct_cod,
      vi_rti_cod        IN       t_rti_cod,
      vi_rti_desc       IN       t_rti_desc,
      vi_rti_sigla      IN       t_rti_sigla,
      vi_rti_conta      IN       t_rti_conta,
      vi_rti_programa   IN       t_rti_programa
   ) AS
      v_rti_rct_cod                 ifrbde_views.tab_tipo_recurso_item.rti_rct_cod%TYPE;
      v_rti_cod                     ifrbde_views.tab_tipo_recurso_item.rti_cod%TYPE;
      v_rti_desc                    ifrbde_views.tab_tipo_recurso_item.rti_desc%TYPE;
      v_rti_sigla                   ifrbde_views.tab_tipo_recurso_item.rti_sigla%TYPE;
      v_rti_conta                   ifrbde_views.tab_tipo_recurso_item.rti_conta%TYPE;
      v_rti_programa                ifrbde_views.tab_tipo_recurso_item.rti_programa%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO_ITEM', 'INCLUI') THEN
         v_rti_cod := RTRIM (LTRIM (UPPER (vi_rti_cod)));
         v_rti_desc := RTRIM (LTRIM (UPPER (vi_rti_desc)));
         v_rti_sigla := RTRIM (LTRIM (UPPER (vi_rti_sigla)));
         v_rti_conta := RTRIM (LTRIM (UPPER (vi_rti_conta)));
         v_rti_programa := RTRIM (LTRIM (UPPER (vi_rti_programa)));
         v_rti_rct_cod := vi_rti_rct_cod;

         INSERT INTO ifrbde_views.tab_tipo_recurso_item
                     (rti_rct_cod,
                      rti_cod,
                      rti_desc,
                      rti_sigla,
                      rti_conta,
                      rti_programa
                     )
              VALUES (v_rti_rct_cod,
                      v_rti_cod,
                      v_rti_desc,
                      v_rti_sigla,
                      v_rti_conta,
                      v_rti_programa
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT rti_rct_cod,
                   rti_cod,
                   rti_desc,
                   rti_sigla,
                   rti_conta,
                   rti_programa
              INTO vo_rti_rct_cod (1),
                   vo_rti_cod (1),
                   vo_rti_desc (1),
                   vo_rti_sigla (1),
                   vo_rti_conta (1),
                   vo_rti_programa (1)
              FROM ifrbde_views.tab_tipo_recurso_item
             WHERE rti_cod = v_rti_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_TIPO_RECURSO_ITEM',
               'I',
               v_rti_cod || v_rti_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Itens do tipo de recurso
-- retorna o recordset correspondente
   PROCEDURE stp_altera_tipo_recurso_item (
      p_usuario                  VARCHAR2,
      vo_rti_rct_cod    OUT      tyt_rti_rct_cod,
      vo_rti_cod        OUT      tyt_rti_cod,
      vo_rti_desc       OUT      tyt_rti_desc,
      vo_rti_sigla      OUT      tyt_rti_sigla,
      vo_rti_conta      OUT      tyt_rti_conta,
      vo_rti_programa   OUT      tyt_rti_programa,
      vi_rti_rct_cod    IN       t_rti_rct_cod,
      vi_rti_cod        IN       t_rti_cod,
      vi_rti_desc       IN       t_rti_desc,
      vi_rti_sigla      IN       t_rti_sigla,
      vi_rti_conta      IN       t_rti_conta,
      vi_rti_programa   IN       t_rti_programa
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_tipo_recurso_item
              WHERE rti_cod = vi_rti_cod
         FOR UPDATE;

      v_tab_tipo_recurso_item       ifrbde_views.tab_tipo_recurso_item%ROWTYPE;
      v_rti_rct_cod                 ifrbde_views.tab_tipo_recurso_item.rti_rct_cod%TYPE;
      v_rti_cod                     ifrbde_views.tab_tipo_recurso_item.rti_cod%TYPE;
      v_rti_desc                    ifrbde_views.tab_tipo_recurso_item.rti_desc%TYPE;
      v_rti_sigla                   ifrbde_views.tab_tipo_recurso_item.rti_sigla%TYPE;
      v_rti_conta                   ifrbde_views.tab_tipo_recurso_item.rti_conta%TYPE;
      v_rti_programa                ifrbde_views.tab_tipo_recurso_item.rti_programa%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_TIPO_RECURSO_ITEM', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_tipo_recurso_item;

         IF NOT c_cursor%NOTFOUND THEN
            v_rti_cod := RTRIM (LTRIM (UPPER (vi_rti_cod)));
            v_rti_desc := RTRIM (LTRIM (UPPER (vi_rti_desc)));
            v_rti_sigla := RTRIM (LTRIM (UPPER (vi_rti_sigla)));
            v_rti_conta := RTRIM (LTRIM (UPPER (vi_rti_conta)));
            v_rti_programa := RTRIM (LTRIM (UPPER (vi_rti_programa)));
            v_rti_rct_cod := vi_rti_rct_cod;

            UPDATE ifrbde_views.tab_tipo_recurso_item
               SET rti_rct_cod = v_rti_rct_cod,
                   rti_desc = v_rti_desc,
                   rti_sigla = v_rti_sigla,
                   rti_conta = v_rti_conta,
                   rti_programa = v_rti_programa
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT rti_rct_cod,
                      rti_cod,
                      rti_desc,
                      rti_sigla,
                      rti_conta,
                      rti_programa
                 INTO vo_rti_rct_cod (1),
                      vo_rti_cod (1),
                      vo_rti_desc (1),
                      vo_rti_sigla (1),
                      vo_rti_conta (1),
                      vo_rti_programa (1)
                 FROM ifrbde_views.tab_tipo_recurso_item
                WHERE rti_cod = v_rti_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_TIPO_RECURSO_ITEM',
                  'A',
                  v_rti_cod || v_rti_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Áreas Envolvidas
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_cod    IN       t_are_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA', 'PESQUISA') THEN
         SELECT are_cod,
                are_desc
           INTO vo_are_cod (1),
                vo_are_desc (1)
           FROM ifrbde_views.tab_area
          WHERE are_cod = vi_are_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Áreas Envolvidas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_area (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_are_cod   IN       t_are_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_AREA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_area
               WHERE are_cod = vi_are_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_AREA', 'E', TO_CHAR (vi_are_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Áreas Envolvidas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_desc   IN       t_are_desc
   ) AS
      v_are_cod                     ifrbde_views.tab_area.are_cod%TYPE;
      v_are_desc                    ifrbde_views.tab_area.are_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA', 'INCLUI') THEN
         SELECT ifrbde_views.seq_are_cod.NEXTVAL
           INTO v_are_cod
           FROM DUAL;

         v_are_desc := RTRIM (LTRIM (UPPER (vi_are_desc)));

         INSERT INTO ifrbde_views.tab_area
                     (are_cod,
                      are_desc
                     )
              VALUES (v_are_cod,
                      v_are_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT are_cod,
                   are_desc
              INTO vo_are_cod (1),
                   vo_are_desc (1)
              FROM ifrbde_views.tab_area
             WHERE are_cod = v_are_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_AREA',
               'I',
               TO_CHAR (v_are_cod) || v_are_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Áreas Envolvidas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_area (
      p_usuario              VARCHAR2,
      vo_are_cod    OUT      tyt_are_cod,
      vo_are_desc   OUT      tyt_are_desc,
      vi_are_cod    IN       t_are_cod,
      vi_are_desc   IN       t_are_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_area
              WHERE are_cod = vi_are_cod
         FOR UPDATE;

      v_tab_area                    ifrbde_views.tab_area%ROWTYPE;
      v_are_cod                     ifrbde_views.tab_area.are_cod%TYPE;
      v_are_desc                    ifrbde_views.tab_area.are_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_area;

         IF NOT c_cursor%NOTFOUND THEN
            v_are_desc := RTRIM (LTRIM (UPPER (vi_are_desc)));

            UPDATE ifrbde_views.tab_area
               SET are_desc = v_are_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT are_cod,
                      are_desc
                 INTO vo_are_cod (1),
                      vo_are_desc (1)
                 FROM ifrbde_views.tab_area
                WHERE are_cod = v_are_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_AREA',
                  'A',
                  TO_CHAR (vi_are_cod) || v_are_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Áreas envolvidas
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_subcod   IN       t_aen_subcod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA_ENVOLVIDA', 'PESQUISA') THEN
         SELECT aen_cod,
                aen_subcod,
                aen_desc
           INTO vo_aen_cod (1),
                vo_aen_subcod (1),
                vo_aen_desc (1)
           FROM ifrbde_views.tab_area_envolvida
          WHERE aen_subcod = vi_aen_subcod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Áreas envolvidas
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_area_envolvida (
      p_usuario                VARCHAR2,
      vo_ok           OUT      tyt_ok,
      vi_aen_subcod   IN       t_aen_subcod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_AREA_ENVOLVIDA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_area_envolvida
               WHERE aen_subcod = vi_aen_subcod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_AREA_ENVOLVIDA', 'E', vi_aen_subcod);
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Áreas envolvidas
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_cod      IN       t_aen_cod,
      vi_aen_subcod   IN       t_aen_subcod,
      vi_aen_desc     IN       t_aen_desc
   ) AS
      v_aen_cod                     ifrbde_views.tab_area_envolvida.aen_cod%TYPE;
      v_aen_subcod                  ifrbde_views.tab_area_envolvida.aen_subcod%TYPE;
      v_aen_desc                    ifrbde_views.tab_area_envolvida.aen_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA_ENVOLVIDA', 'INCLUI') THEN
         v_aen_subcod := RTRIM (LTRIM (UPPER (vi_aen_subcod)));
         v_aen_desc := RTRIM (LTRIM (UPPER (vi_aen_desc)));
         v_aen_cod := RTRIM (LTRIM (UPPER (vi_aen_cod)));

         INSERT INTO ifrbde_views.tab_area_envolvida
                     (aen_cod,
                      aen_subcod,
                      aen_desc
                     )
              VALUES (v_aen_cod,
                      v_aen_subcod,
                      v_aen_desc
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT aen_cod,
                   aen_subcod,
                   aen_desc
              INTO vo_aen_cod (1),
                   vo_aen_subcod (1),
                   vo_aen_desc (1)
              FROM ifrbde_views.tab_area_envolvida
             WHERE aen_subcod = v_aen_subcod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_AREA_ENVOLVIDA',
               'I',
               v_aen_subcod || v_aen_desc
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Áreas envolvidas
-- retorna o recordset correspondente
   PROCEDURE stp_altera_area_envolvida (
      p_usuario                VARCHAR2,
      vo_aen_cod      OUT      tyt_aen_cod,
      vo_aen_subcod   OUT      tyt_aen_subcod,
      vo_aen_desc     OUT      tyt_aen_desc,
      vi_aen_cod      IN       t_aen_cod,
      vi_aen_subcod   IN       t_aen_subcod,
      vi_aen_desc     IN       t_aen_desc
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_area_envolvida
              WHERE aen_subcod = vi_aen_subcod
         FOR UPDATE;

      v_tab_area_envolvida          ifrbde_views.tab_area_envolvida%ROWTYPE;
      v_aen_cod                     ifrbde_views.tab_area_envolvida.aen_cod%TYPE;
      v_aen_subcod                  ifrbde_views.tab_area_envolvida.aen_subcod%TYPE;
      v_aen_desc                    ifrbde_views.tab_area_envolvida.aen_desc%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_AREA_ENVOLVIDA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_area_envolvida;

         IF NOT c_cursor%NOTFOUND THEN
            v_aen_subcod := RTRIM (LTRIM (UPPER (vi_aen_subcod)));
            v_aen_desc := RTRIM (LTRIM (UPPER (vi_aen_desc)));
            v_aen_cod := RTRIM (LTRIM (UPPER (vi_aen_cod)));

            UPDATE ifrbde_views.tab_area_envolvida
               SET aen_cod = v_aen_cod,
                   aen_desc = v_aen_desc
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT aen_cod,
                      aen_subcod,
                      aen_desc
                 INTO vo_aen_cod (1),
                      vo_aen_subcod (1),
                      vo_aen_desc (1)
                 FROM ifrbde_views.tab_area_envolvida
                WHERE aen_subcod = v_aen_subcod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_AREA_ENVOLVIDA',
                  'A',
                  v_aen_subcod || v_aen_desc
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Dotação Orçamentária
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DOTACAO', 'PESQUISA') THEN
         SELECT dot_ano,
                dot_rti_cod,
                dot_valor
           INTO vo_dot_ano (1),
                vo_dot_rti_cod (1),
                vo_dot_valor (1)
           FROM ifrbde_views.tab_dotacao
          WHERE dot_ano = vi_dot_ano AND dot_rti_cod = vi_dot_rti_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Dotação Orçamentária
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_dotacao (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_DOTACAO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_dotacao
               WHERE dot_ano = vi_dot_ano AND dot_rti_cod = vi_dot_rti_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_DOTACAO',
               'E',
               vi_dot_ano || vi_dot_rti_cod
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Dotação Orçamentária
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod,
      vi_dot_valor     IN       t_dot_valor
   ) AS
      v_dot_ano                     ifrbde_views.tab_dotacao.dot_ano%TYPE;
      v_dot_rti_cod                 ifrbde_views.tab_dotacao.dot_rti_cod%TYPE;
      v_dot_valor                   ifrbde_views.tab_dotacao.dot_valor%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DOTACAO', 'INCLUI') THEN
         v_dot_ano := RTRIM (LTRIM (UPPER (vi_dot_ano)));
         v_dot_rti_cod := RTRIM (LTRIM (UPPER (vi_dot_rti_cod)));
         v_dot_valor := vi_dot_valor;

         INSERT INTO ifrbde_views.tab_dotacao
                     (dot_ano,
                      dot_rti_cod,
                      dot_valor,
                      dot_saldo
                     )
              VALUES (v_dot_ano,
                      v_dot_rti_cod,
                      v_dot_valor,
                      v_dot_valor
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT dot_ano,
                   dot_rti_cod,
                   dot_valor
              INTO vo_dot_ano (1),
                   vo_dot_rti_cod (1),
                   vo_dot_valor (1)
              FROM ifrbde_views.tab_dotacao
             WHERE dot_ano = v_dot_ano AND dot_rti_cod = v_dot_rti_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_DOTACAO',
               'I',
               vi_dot_ano || vi_dot_rti_cod
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Dotação Orçamentária
-- retorna o recordset correspondente
   PROCEDURE stp_altera_dotacao (
      p_usuario                 VARCHAR2,
      vo_dot_ano       OUT      tyt_dot_ano,
      vo_dot_rti_cod   OUT      tyt_dot_rti_cod,
      vo_dot_valor     OUT      tyt_dot_valor,
      vi_dot_ano       IN       t_dot_ano,
      vi_dot_rti_cod   IN       t_dot_rti_cod,
      vi_dot_valor     IN       t_dot_valor
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = vi_dot_ano AND dot_rti_cod = vi_dot_rti_cod
         FOR UPDATE;

      v_tab_dotacao                 ifrbde_views.tab_dotacao%ROWTYPE;
      v_dot_ano                     ifrbde_views.tab_dotacao.dot_ano%TYPE;
      v_dot_rti_cod                 ifrbde_views.tab_dotacao.dot_rti_cod%TYPE;
      v_dot_valor                   ifrbde_views.tab_dotacao.dot_valor%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_DOTACAO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_dotacao;

         IF NOT c_cursor%NOTFOUND THEN
            v_dot_ano := RTRIM (LTRIM (UPPER (vi_dot_ano)));
            v_dot_rti_cod := RTRIM (LTRIM (UPPER (vi_dot_rti_cod)));
            v_dot_valor := vi_dot_valor;

            UPDATE ifrbde_views.tab_dotacao
               SET dot_valor = v_dot_valor
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT dot_ano,
                      dot_rti_cod,
                      dot_valor
                 INTO vo_dot_ano (1),
                      vo_dot_rti_cod (1),
                      vo_dot_valor (1)
                 FROM ifrbde_views.tab_dotacao
                WHERE dot_ano = v_dot_ano AND dot_rti_cod = v_dot_rti_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_DOTACAO',
                  'A',
                  vi_dot_ano || vi_dot_rti_cod
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Item da dotação
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ITEM_DOTACAO', 'PESQUISA') THEN
         SELECT dti_dot_ano,
                dti_dot_rti_cod,
                dti_dpp_cod,
                dti_valor
           INTO vo_dti_dot_ano (1),
                vo_dti_dot_rti_cod (1),
                vo_dti_dpp_cod (1),
                vo_dti_valor (1)
           FROM ifrbde_views.tab_item_dotacao
          WHERE dti_dot_ano = vi_dti_dot_ano
            AND dti_dot_rti_cod = vi_dti_dot_rti_cod
            AND dti_dpp_cod = vi_dti_dpp_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Item da dotação
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod
   ) AS
      CURSOR c_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = RTRIM (LTRIM (UPPER (vi_dti_dot_ano)))
                AND dot_rti_cod = RTRIM (LTRIM (UPPER (vi_dti_dot_rti_cod)))
         FOR UPDATE;

      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = vi_dti_dot_ano
                AND dti_dot_rti_cod = vi_dti_dot_rti_cod
                AND dti_dpp_cod = vi_dti_dpp_cod
         FOR UPDATE;

      v_tab_item_dotacao            ifrbde_views.tab_item_dotacao%ROWTYPE;
      v_tab_dotacao                 ifrbde_views.tab_dotacao%ROWTYPE;
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_ITEM_DOTACAO', 'EXCLUI') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_item_dotacao;
         OPEN c_dotacao;
         FETCH c_dotacao INTO v_tab_dotacao;

         UPDATE ifrbde_views.tab_dotacao
            SET dot_valor = dot_valor - v_tab_item_dotacao.dti_valor,
                dot_saldo = dot_saldo - v_tab_item_dotacao.dti_valor
          WHERE  CURRENT OF c_dotacao;

         CLOSE c_dotacao;
         CLOSE c_cursor;

         DELETE FROM ifrbde_views.tab_item_dotacao
               WHERE dti_dot_ano = vi_dti_dot_ano
                 AND dti_dot_rti_cod = vi_dti_dot_rti_cod
                 AND dti_dpp_cod = vi_dti_dpp_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_ITEM_DOTACAO',
               'E',
               vi_dti_dot_ano || vi_dti_dot_rti_cod || TO_CHAR (
                                                          vi_dti_dpp_cod
                                                       )
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Item da dotação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod,
      vi_dti_valor         IN       t_dti_valor
   ) AS
      v_dti_dot_ano                 ifrbde_views.tab_item_dotacao.dti_dot_ano%TYPE;
      v_dti_dot_rti_cod             ifrbde_views.tab_item_dotacao.dti_dot_rti_cod%TYPE;
      v_dti_dpp_cod                 ifrbde_views.tab_item_dotacao.dti_dpp_cod%TYPE;
      v_dti_valor                   ifrbde_views.tab_item_dotacao.dti_valor%TYPE;
      v_tab_dotacao                 ifrbde_views.tab_dotacao%ROWTYPE;

      CURSOR c_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = RTRIM (LTRIM (UPPER (vi_dti_dot_ano)))
                AND dot_rti_cod = RTRIM (LTRIM (UPPER (vi_dti_dot_rti_cod)))
         FOR UPDATE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ITEM_DOTACAO', 'INCLUI') THEN
         v_dti_dot_ano := RTRIM (LTRIM (UPPER (vi_dti_dot_ano)));
         v_dti_dot_rti_cod := RTRIM (LTRIM (UPPER (vi_dti_dot_rti_cod)));
         v_dti_dpp_cod := vi_dti_dpp_cod;
         v_dti_valor := vi_dti_valor;
         OPEN c_dotacao;
         FETCH c_dotacao INTO v_tab_dotacao;

         UPDATE ifrbde_views.tab_dotacao
            SET dot_saldo = dot_saldo + v_dti_valor,
                dot_valor = dot_valor + v_dti_valor
          WHERE  CURRENT OF c_dotacao;

         INSERT INTO ifrbde_views.tab_item_dotacao
                     (dti_dot_ano,
                      dti_dot_rti_cod,
                      dti_dpp_cod,
                      dti_valor,
                      dti_saldo
                     )
              VALUES (v_dti_dot_ano,
                      v_dti_dot_rti_cod,
                      v_dti_dpp_cod,
                      v_dti_valor,
                      v_dti_valor
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT dti_dot_ano,
                   dti_dot_rti_cod,
                   dti_dpp_cod,
                   dti_valor
              INTO vo_dti_dot_ano (1),
                   vo_dti_dot_rti_cod (1),
                   vo_dti_dpp_cod (1),
                   vo_dti_valor (1)
              FROM ifrbde_views.tab_item_dotacao
             WHERE dti_dot_ano = v_dti_dot_ano
               AND dti_dot_rti_cod = v_dti_dot_rti_cod
               AND dti_dpp_cod = v_dti_dpp_cod;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_ITEM_DOTACAO',
               'I',
               v_dti_dot_ano || v_dti_dot_rti_cod || TO_CHAR (v_dti_dpp_cod)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Item da dotação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_item_dotacao (
      p_usuario                     VARCHAR2,
      vo_dti_dot_ano       OUT      tyt_dti_dot_ano,
      vo_dti_dot_rti_cod   OUT      tyt_dti_dot_rti_cod,
      vo_dti_dpp_cod       OUT      tyt_dti_dpp_cod,
      vo_dti_valor         OUT      tyt_dti_valor,
      vi_dti_dot_ano       IN       t_dti_dot_ano,
      vi_dti_dot_rti_cod   IN       t_dti_dot_rti_cod,
      vi_dti_dpp_cod       IN       t_dti_dpp_cod,
      vi_dti_valor         IN       t_dti_valor
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_item_dotacao
              WHERE dti_dot_ano = vi_dti_dot_ano
                AND dti_dot_rti_cod = vi_dti_dot_rti_cod
                AND dti_dpp_cod = vi_dti_dpp_cod
         FOR UPDATE;

      CURSOR c_dotacao IS
         SELECT     *
               FROM ifrbde_views.tab_dotacao
              WHERE dot_ano = RTRIM (LTRIM (UPPER (vi_dti_dot_ano)))
                AND dot_rti_cod = RTRIM (LTRIM (UPPER (vi_dti_dot_rti_cod)))
         FOR UPDATE;

      v_tab_item_dotacao            ifrbde_views.tab_item_dotacao%ROWTYPE;
      v_tab_dotacao                 ifrbde_views.tab_dotacao%ROWTYPE;
      v_dti_dot_ano                 ifrbde_views.tab_item_dotacao.dti_dot_ano%TYPE;
      v_dti_dot_rti_cod             ifrbde_views.tab_item_dotacao.dti_dot_rti_cod%TYPE;
      v_dti_dpp_cod                 ifrbde_views.tab_item_dotacao.dti_dpp_cod%TYPE;
      v_dti_valor                   ifrbde_views.tab_item_dotacao.dti_valor%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_ITEM_DOTACAO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_item_dotacao;
         OPEN c_dotacao;
         FETCH c_dotacao INTO v_tab_dotacao;

         UPDATE ifrbde_views.tab_dotacao
            SET dot_valor = dot_valor - v_tab_item_dotacao.dti_valor,
                dot_saldo = dot_saldo - v_tab_item_dotacao.dti_valor
          WHERE  CURRENT OF c_dotacao;

         UPDATE ifrbde_views.tab_dotacao
            SET dot_valor = dot_valor + vi_dti_valor,
                dot_saldo = dot_saldo + vi_dti_valor
          WHERE  CURRENT OF c_dotacao;

         CLOSE c_dotacao;

         IF NOT c_cursor%NOTFOUND THEN
            v_dti_dot_ano := RTRIM (LTRIM (UPPER (vi_dti_dot_ano)));
            v_dti_dot_rti_cod := RTRIM (LTRIM (UPPER (vi_dti_dot_rti_cod)));
            v_dti_dpp_cod := vi_dti_dpp_cod;
            v_dti_valor := vi_dti_valor;

            UPDATE ifrbde_views.tab_item_dotacao
               SET dti_valor = v_dti_valor,
                   dti_saldo = v_dti_valor
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT dti_dot_ano,
                      dti_dot_rti_cod,
                      dti_dpp_cod,
                      dti_valor
                 INTO vo_dti_dot_ano (1),
                      vo_dti_dot_rti_cod (1),
                      vo_dti_dpp_cod (1),
                      vo_dti_valor (1)
                 FROM ifrbde_views.tab_item_dotacao
                WHERE dti_dot_ano = v_dti_dot_ano
                  AND dti_dot_rti_cod = v_dti_dot_rti_cod
                  AND dti_dpp_cod = v_dti_dpp_cod;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_ITEM_DOTACAO',
                  'A',
                  v_dti_dot_ano || v_dti_dot_rti_cod || TO_CHAR (
                                                           v_dti_dpp_cod
                                                        )
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Pesquisa recursos solicitados
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'CAD_RECURSOS', 'PESQUISA') THEN
         SELECT num_seq_carencia,
                num_ano,
                stf_cur2str (NVL (val_proposta, 0))
           INTO vo_num_seq_carencia (1),
                vo_num_ano (1),
                vo_val_proposta (1)
           FROM ifrbde_views.cad_recursos_solicitados
          WHERE num_seq_carencia = vi_num_seq_carencia
            AND num_ano = vi_num_ano;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui recursos solicitados
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_ok                 OUT      tyt_ok,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano
   ) AS
      v_erro                        VARCHAR2 (200);
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'CAD_RECURSOS', 'EXCLUI') THEN
         v_erro :=
              'Não é possivel remover os Recursos Solicitados para este ano.';

         DELETE FROM ifrbde_views.cad_recursos_solicitados
               WHERE num_seq_carencia = vi_num_seq_carencia
                 AND num_ano = vi_num_ano;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'CAD_RECURSOS_SOLICITADOS',
               'E',
               TO_CHAR (vi_num_seq_carencia) || vi_num_ano
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         ROLLBACK;
         raise_application_error (-20100, v_erro);
   END;

   
--------------------------------------------------------------------
-- Inclui Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano,
      vi_val_proposta       IN       t_val_proposta
   ) AS
      v_num_seq_carencia            ifrbde_views.cad_recursos_solicitados.num_seq_carencia%TYPE;
      v_num_ano                     ifrbde_views.cad_recursos_solicitados.num_ano%TYPE;
      v_val_proposta                ifrbde_views.cad_recursos_solicitados.val_proposta%TYPE;
      v_erro                        VARCHAR2 (200);
   BEGIN
      v_erro :=
              'Não é possivel incluir os Recursos Solicitados para este ano.';

      IF stf_permitido (p_usuario, 'CAD_RECURSOS_SOLICITADOS', 'INCLUI') THEN
         v_num_seq_carencia := vi_num_seq_carencia;
         v_num_ano := RTRIM (LTRIM (UPPER (vi_num_ano)));
         v_val_proposta := vi_val_proposta;

         INSERT INTO ifrbde_views.cad_recursos_solicitados
                     (num_seq_carencia,
                      num_ano,
                      val_proposta
                     )
              VALUES (v_num_seq_carencia,
                      v_num_ano,
                      v_val_proposta
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_rec_solicitados (
               p_usuario,
               vo_num_seq_carencia,
               vo_num_ano,
               vo_val_proposta,
               v_num_seq_carencia,
               v_num_ano
            );
            -- LOG
            stp_log (
               p_usuario,
               'CAD_RECURSOS_SOLICITADOS',
               'I',
               TO_CHAR (vi_num_seq_carencia)
               || vi_num_ano
               || TO_CHAR (vi_val_proposta)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera recursos solicitados
-- retorna o recordset correspondente
   PROCEDURE stp_altera_rec_solicitados (
      p_usuario                      VARCHAR2,
      vo_num_seq_carencia   OUT      tyt_num_seq_carencia,
      vo_num_ano            OUT      tyt_num_ano,
      vo_val_proposta       OUT      tyt_val_proposta,
      vi_num_seq_carencia   IN       t_num_seq_carencia,
      vi_num_ano            IN       t_num_ano,
      vi_val_proposta       IN       t_val_proposta
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_recursos_solicitados
              WHERE num_seq_carencia = vi_num_seq_carencia
                AND num_ano = vi_num_ano
         FOR UPDATE;

      v_cad_recursos_solicitados    ifrbde_views.cad_recursos_solicitados%ROWTYPE;
      v_num_seq_carencia            ifrbde_views.cad_recursos_solicitados.num_seq_carencia%TYPE;
      v_num_ano                     ifrbde_views.cad_recursos_solicitados.num_ano%TYPE;
      v_val_proposta                ifrbde_views.cad_recursos_solicitados.val_proposta%TYPE;
      v_erro                        VARCHAR2 (200);
   BEGIN
      v_erro :=
              'Não é possivel Alterar os Recursos Solicitados para este ano.';

      IF stf_permitido (p_usuario, 'CAD_RECURSOS_SOLICITADOS', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_recursos_solicitados;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_seq_carencia := vi_num_seq_carencia;
            v_num_ano := RTRIM (LTRIM (UPPER (vi_num_ano)));
            v_val_proposta := vi_val_proposta;

            UPDATE ifrbde_views.cad_recursos_solicitados
               SET num_ano = v_num_ano,
                   val_proposta = v_val_proposta
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_rec_solicitados (
                  p_usuario,
                  vo_num_seq_carencia,
                  vo_num_ano,
                  vo_val_proposta,
                  v_num_seq_carencia,
                  v_num_ano
               );
               -- LOG
               stp_log (
                  p_usuario,
                  'CAD_RECURSOS_SOLICITADOS',
                  'A',
                  TO_CHAR (vi_num_seq_carencia)
                  || vi_num_ano
                  || TO_CHAR (vi_val_proposta)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         ROLLBACK;
         raise_application_error (-20100, v_erro);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Empenho
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_PRECOMPROVADO', 'PESQUISA') THEN
         SELECT rpr_cre_cod,
                rpr_pgose,
                rpr_rti_cod,
                rpr_num,
                TO_CHAR (rpr_data, 'DD/MM/YYYY'),
                rpr_valor
           INTO vo_rpr_cre_cod (1),
                vo_rpr_pgose (1),
                vo_rpr_rti_cod (1),
                vo_rpr_num (1),
                vo_rpr_data (1),
                vo_rpr_valor (1)
           FROM ifrbde_views.tab_rec_precomprovado
          WHERE rpr_cre_cod = vi_rpr_cre_cod
            AND rpr_pgose = vi_rpr_pgose
            AND rpr_rti_cod = vi_rpr_rti_cod
            AND rpr_num = vi_rpr_num;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Empenho
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num
   ) AS
      CURSOR c_rec_precomprovado IS
         SELECT     *
               FROM ifrbde_views.tab_rec_precomprovado
              WHERE rpr_cre_cod = vi_rpr_cre_cod
                AND rpr_rti_cod = vi_rpr_rti_cod
                AND rpr_pgose = vi_rpr_pgose
                AND UPPER (rpr_num) = UPPER (vi_rpr_num)
         FOR UPDATE;

      v_tab_rec_precomprovado       ifrbde_views.tab_rec_precomprovado%ROWTYPE;
      v_erro                        VARCHAR2 (200);
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_REC_PRECOMPROVADO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_rec_precomprovado
               WHERE  CURRENT OF c_rec_precomprovado;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_REC_PRECOMPROVADO',
               'E',
               TO_CHAR (vi_rpr_cre_cod)
               || vi_rpr_pgose
               || vi_rpr_rti_cod
               || vi_rpr_num
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;

         CLOSE c_rec_precomprovado;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro);
   END;

   
--------------------------------------------------------------------
-- Inclui Empenho
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num,
      vi_rpr_data      IN       t_rpr_data,
      vi_rpr_valor     IN       t_rpr_valor
   ) AS
      CURSOR c_rec_precomprovado IS
         SELECT     *
               FROM ifrbde_views.tab_rec_precomprovado
              WHERE rpr_cre_cod = vi_rpr_cre_cod
                AND rpr_rti_cod = vi_rpr_rti_cod
                AND rpr_pgose = vi_rpr_pgose
                AND UPPER (rpr_num) = UPPER (vi_rpr_num)
         FOR UPDATE;

      v_tab_rec_precomprovado       ifrbde_views.tab_rec_precomprovado%ROWTYPE;
      v_rpr_cre_cod                 ifrbde_views.tab_rec_precomprovado.rpr_cre_cod%TYPE;
      v_rpr_pgose                   ifrbde_views.tab_rec_precomprovado.rpr_pgose%TYPE;
      v_rpr_rti_cod                 ifrbde_views.tab_rec_precomprovado.rpr_rti_cod%TYPE;
      v_rpr_num                     ifrbde_views.tab_rec_precomprovado.rpr_num%TYPE;
      v_rpr_data                    ifrbde_views.tab_rec_precomprovado.rpr_data%TYPE;
      v_rpr_valor                   ifrbde_views.tab_rec_precomprovado.rpr_valor%TYPE;
      v_erro                        VARCHAR2 (200);
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_PRECOMPROVADO', 'INCLUI') THEN
         v_rpr_pgose := RTRIM (LTRIM (UPPER (vi_rpr_pgose)));
         v_rpr_rti_cod := RTRIM (LTRIM (UPPER (vi_rpr_rti_cod)));
         v_rpr_num := RTRIM (LTRIM (UPPER (vi_rpr_num)));
         v_rpr_data := TO_DATE (vi_rpr_data, 'DD/MM/YYYY');
         v_rpr_cre_cod := vi_rpr_cre_cod;
         v_rpr_valor := vi_rpr_valor;

         INSERT INTO ifrbde_views.tab_rec_precomprovado
                     (rpr_cre_cod,
                      rpr_pgose,
                      rpr_rti_cod,
                      rpr_num,
                      rpr_data,
                      rpr_valor
                     )
              VALUES (v_rpr_cre_cod,
                      v_rpr_pgose,
                      v_rpr_rti_cod,
                      v_rpr_num,
                      TO_DATE (v_rpr_data, 'DD/MM/YYYY'),
                      v_rpr_valor
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT rpr_cre_cod,
                   rpr_pgose,
                   rpr_rti_cod,
                   rpr_num,
                   TO_CHAR (rpr_data, 'DD/MM/YYYY'),
                   rpr_valor
              INTO vo_rpr_cre_cod (1),
                   vo_rpr_pgose (1),
                   vo_rpr_rti_cod (1),
                   vo_rpr_num (1),
                   vo_rpr_data (1),
                   vo_rpr_valor (1)
              FROM ifrbde_views.tab_rec_precomprovado
             WHERE rpr_cre_cod = v_rpr_cre_cod
               AND rpr_pgose = v_rpr_pgose
               AND rpr_rti_cod = v_rpr_rti_cod
               AND rpr_num = v_rpr_num;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_REC_PRECOMPROVADO',
               'I',
               TO_CHAR (vi_rpr_cre_cod)
               || vi_rpr_pgose
               || vi_rpr_rti_cod
               || vi_rpr_num
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro);
   END;

   
--------------------------------------------------------------------
-- Altera Empenho
-- retorna o recordset correspondente
   PROCEDURE stp_altera_rec_precomprovado (
      p_usuario                 VARCHAR2,
      vo_rpr_cre_cod   OUT      tyt_rpr_cre_cod,
      vo_rpr_pgose     OUT      tyt_rpr_pgose,
      vo_rpr_rti_cod   OUT      tyt_rpr_rti_cod,
      vo_rpr_num       OUT      tyt_rpr_num,
      vo_rpr_data      OUT      tyt_rpr_data,
      vo_rpr_valor     OUT      tyt_rpr_valor,
      vi_rpr_cre_cod   IN       t_rpr_cre_cod,
      vi_rpr_pgose     IN       t_rpr_pgose,
      vi_rpr_rti_cod   IN       t_rpr_rti_cod,
      vi_rpr_num       IN       t_rpr_num,
      vi_rpr_data      IN       t_rpr_data,
      vi_rpr_valor     IN       t_rpr_valor
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_rec_precomprovado
              WHERE rpr_cre_cod = vi_rpr_cre_cod
                AND rpr_pgose = vi_rpr_pgose
                AND rpr_rti_cod = vi_rpr_rti_cod
                AND rpr_num = vi_rpr_num
         FOR UPDATE;

      v_tab_rec_precomprovado       ifrbde_views.tab_rec_precomprovado%ROWTYPE;
      v_rpr_cre_cod                 ifrbde_views.tab_rec_precomprovado.rpr_cre_cod%TYPE;
      v_rpr_pgose                   ifrbde_views.tab_rec_precomprovado.rpr_pgose%TYPE;
      v_rpr_rti_cod                 ifrbde_views.tab_rec_precomprovado.rpr_rti_cod%TYPE;
      v_rpr_num                     ifrbde_views.tab_rec_precomprovado.rpr_num%TYPE;
      v_rpr_data                    ifrbde_views.tab_rec_precomprovado.rpr_data%TYPE;
      v_rpr_valor                   ifrbde_views.tab_rec_precomprovado.rpr_valor%TYPE;
      v_erro                        VARCHAR2 (200);
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_PRECOMPROVADO', 'ALTERA') THEN
         CLOSE c_cursor;
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_precomprovado;

         IF NOT c_cursor%NOTFOUND THEN
            v_rpr_pgose := RTRIM (LTRIM (UPPER (vi_rpr_pgose)));
            v_rpr_rti_cod := RTRIM (LTRIM (UPPER (vi_rpr_rti_cod)));
            v_rpr_num := RTRIM (LTRIM (UPPER (vi_rpr_num)));
            v_rpr_data := TO_DATE (vi_rpr_data, 'DD/MM/YYYY');
            v_rpr_cre_cod := vi_rpr_cre_cod;
            v_rpr_valor := vi_rpr_valor;

            UPDATE ifrbde_views.tab_rec_precomprovado
               SET rpr_data = v_rpr_data,
                   rpr_valor = v_rpr_valor
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT rpr_cre_cod,
                      rpr_pgose,
                      rpr_rti_cod,
                      rpr_num,
                      TO_CHAR (rpr_data, 'DD/MM/YYYY'),
                      rpr_valor
                 INTO vo_rpr_cre_cod (1),
                      vo_rpr_pgose (1),
                      vo_rpr_rti_cod (1),
                      vo_rpr_num (1),
                      vo_rpr_data (1),
                      vo_rpr_valor (1)
                 FROM ifrbde_views.tab_rec_precomprovado
                WHERE rpr_cre_cod = v_rpr_cre_cod
                  AND rpr_pgose = v_rpr_pgose
                  AND rpr_rti_cod = v_rpr_rti_cod
                  AND rpr_num = v_rpr_num;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_REC_PRECOMPROVADO',
                  'A',
                  TO_CHAR (vi_rpr_cre_cod)
                  || vi_rpr_pgose
                  || vi_rpr_rti_cod
                  || vi_rpr_num
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro);
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Cadastro de Carências
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_cod                    IN       t_cre_cod
   ) AS
      v_erro                        VARCHAR2 (200);
   BEGIN
      v_erro := ' Erro ao selecionar a Carência';

      IF stf_permitido (p_usuario, 'TAB_CARENCIA', 'PESQUISA') THEN
         SELECT cre_cod,
                cre_dep_cod,
                cre_prior_aeroporto,
                cre_prior_cnl,
                cre_tipo,
                cre_desc,
                cre_justificativa,
                cre_aen_subcod,
                are_desc,
                cre_ntf_cod,
                nto_desc,
                cre_etp_cod,
                cre_tipo_obra_cod,
                cre_inicio,
                cre_termino,
                TO_CHAR (cre_data, 'DD/MM/YYYY'),
                cre_vlobras,
                cre_projeto,
                cre_prazo,
                num_seq_pessoal_carencia
           INTO vo_cre_cod (1),
                vo_cre_dep_cod (1),
                vo_cre_prior_aeroporto (1),
                vo_cre_prior_cnl (1),
                vo_cre_tipo (1),
                vo_cre_desc (1),
                vo_cre_justificativa (1),
                vo_cre_aen_subcod (1),
                vo_cre_aen_pai (1),
                vo_cre_ntf_cod (1),
                vo_cre_ntf_pai (1),
                vo_cre_etp_cod (1),
                vo_cre_tipo_obra_cod (1),
                vo_cre_inicio (1),
                vo_cre_termino (1),
                vo_cre_data (1),
                vo_cre_vlobras (1),
                vo_cre_projeto (1),
                vo_cre_prazo (1),
                vo_num_seq_pessoal_carencia (1)
           FROM ifrbde_views.tab_carencia,
                ifrbde_views.tab_area_envolvida,
                ifrbde_views.tab_area,
                ifrbde_views.tab_natureza_obra_fil,
                ifrbde_views.tab_natureza_obra
          WHERE cre_cod = vi_cre_cod
            AND cre_ntf_cod = ntf_cod
            AND ntf_nto_cod = nto_cod
            AND cre_aen_subcod = aen_subcod
            AND aen_cod = are_cod;

         SELECT stf_cur2str (NVL (SUM (rap_valor), 0))
           INTO vo_cre_valor_aprov (1)
           FROM ifrbde_views.tab_rec_aprovado
          WHERE rap_cre_cod = vi_cre_cod;

         SELECT stf_cur2str (NVL (SUM (rap_valor_pago), 0))
           INTO vo_cre_valor_pago (1)
           FROM ifrbde_views.tab_rec_aprovado
          WHERE rap_cre_cod = vi_cre_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro || SQLERRM);
         ROLLBACK;
   END;

   -- Exclui Cadastro de Carências
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_carencia (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_cre_cod   IN       t_cre_cod
   ) AS
      v_erro                        VARCHAR2 (200);
   BEGIN
      vo_ok (1) := 0;
      v_erro :=
            'Impossivel remover Carência com Recursos/Empenho/Contratos associados';

      IF stf_permitido (p_usuario, 'TAB_CARENCIA', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_carencia
               WHERE cre_cod = vi_cre_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (p_usuario, 'TAB_CARENCIA', 'E', TO_CHAR (vi_cre_cod));
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro || SQLERRM);
         ROLLBACK;
   END;

   
-- Inclui Cadastro de Carências
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_cre_prior_aeroporto        IN       t_cre_prior_aeroporto,
      vi_cre_prior_cnl              IN       t_cre_prior_cnl,
      vi_cre_tipo                   IN       t_cre_tipo,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cre_etp_cod                IN       t_cre_etp_cod,
      vi_cre_tipo_obra_cod          IN       t_cre_tipo_obra_cod,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_cre_vlobras                IN       t_cre_vlobras
   ) AS
      v_cre_cod                     ifrbde_views.tab_carencia.cre_cod%TYPE;
      v_cre_dep_cod                 ifrbde_views.tab_carencia.cre_dep_cod%TYPE;
      v_cre_prior_aeroporto         ifrbde_views.tab_carencia.cre_prior_aeroporto%TYPE;
      v_cre_prior_cnl               ifrbde_views.tab_carencia.cre_prior_cnl%TYPE;
      v_cre_tipo                    ifrbde_views.tab_carencia.cre_tipo%TYPE;
      v_cre_desc                    ifrbde_views.tab_carencia.cre_desc%TYPE;
      v_cre_justificativa           ifrbde_views.tab_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod              ifrbde_views.tab_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                 ifrbde_views.tab_carencia.cre_ntf_cod%TYPE;
      v_cre_etp_cod                 ifrbde_views.tab_carencia.cre_etp_cod%TYPE;
      v_cre_tipo_obra_cod           ifrbde_views.tab_carencia.cre_tipo_obra_cod%TYPE;
      v_cre_inicio                  ifrbde_views.tab_carencia.cre_inicio%TYPE;
      v_cre_termino                 ifrbde_views.tab_carencia.cre_termino%TYPE;
      v_cre_data                    ifrbde_views.tab_carencia.cre_data%TYPE;
      v_cre_vlobras                 ifrbde_views.tab_carencia.cre_vlobras%TYPE;
      v_cre_projeto                 ifrbde_views.tab_carencia.cre_projeto%TYPE;
      v_cre_prazo                   ifrbde_views.tab_carencia.cre_prazo%TYPE;
      v_num_seq_pessoal_carencia    ifrbde_views.tab_carencia.num_seq_pessoal_carencia%TYPE;
      v_sucesso                     NUMBER (1);
      v_erro                        VARCHAR2 (200);
   BEGIN
      v_sucesso := 0;

      IF stf_permitido (p_usuario, 'TAB_CARENCIA', 'INCLUI') THEN
         v_cre_prior_aeroporto :=
                               RTRIM (LTRIM (UPPER (vi_cre_prior_aeroporto)));

         SELECT ifrbde_views.seq_cre_cod.NEXTVAL
           INTO v_cre_cod
           FROM DUAL;

         
--
-- criticas do carência
--
         IF vi_cre_prazo < 0 THEN
            v_erro := 'Prazo de Execução do Carência não pode ser negativa';
            v_sucesso := 1;
         END IF;

         
-- 
--
         IF v_sucesso = 0 THEN
            v_cre_prior_cnl := RTRIM (LTRIM (UPPER (vi_cre_prior_cnl)));
            v_cre_desc := RTRIM (LTRIM (UPPER (vi_cre_desc)));
            v_cre_justificativa :=
                                 RTRIM (LTRIM (UPPER (vi_cre_justificativa)));
            v_cre_aen_subcod := RTRIM (LTRIM (UPPER (vi_cre_aen_subcod)));
            v_cre_ntf_cod := RTRIM (LTRIM (UPPER (vi_cre_ntf_cod)));
            v_cre_inicio := RTRIM (LTRIM (UPPER (vi_cre_inicio)));
            v_cre_termino := RTRIM (LTRIM (UPPER (vi_cre_termino)));
            v_cre_projeto := RTRIM (LTRIM (UPPER (vi_cre_projeto)));
            v_cre_data := TO_DATE (vi_cre_data, 'DD/MM/YYYY');
            v_cre_dep_cod := vi_cre_dep_cod;
            v_cre_tipo := vi_cre_tipo;
            v_cre_etp_cod := vi_cre_etp_cod;
            v_cre_prazo := vi_cre_prazo;
            v_cre_tipo_obra_cod := vi_cre_tipo_obra_cod;
            v_cre_vlobras := vi_cre_vlobras;
            v_num_seq_pessoal_carencia := vi_num_seq_pessoal_carencia;
            v_erro :=
               'Verifique se o Sequencial não está duplicado, erro nos dados';

            INSERT INTO ifrbde_views.tab_carencia
                        (cre_cod,
                         cre_dep_cod,
                         cre_prior_aeroporto,
                         cre_prior_cnl,
                         cre_tipo,
                         cre_desc,
                         cre_justificativa,
                         cre_aen_subcod,
                         cre_ntf_cod,
                         cre_etp_cod,
                         cre_tipo_obra_cod,
                         cre_inicio,
                         cre_termino,
                         cre_data,
                         cre_vlobras,
                         cre_projeto,
                         cre_total_pago,
                         cre_prazo,
                         num_seq_pessoal_carencia
                        )
                 VALUES (v_cre_cod,
                         v_cre_dep_cod,
                         v_cre_prior_aeroporto,
                         v_cre_prior_cnl,
                         v_cre_tipo,
                         v_cre_desc,
                         v_cre_justificativa,
                         v_cre_aen_subcod,
                         v_cre_ntf_cod,
                         v_cre_etp_cod,
                         v_cre_tipo_obra_cod,
                         v_cre_inicio,
                         v_cre_termino,
                         v_cre_data,
                         v_cre_vlobras,
                         v_cre_projeto,
                         0,
                         v_cre_prazo,
                         v_num_seq_pessoal_carencia
                        );

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_carencia (
                  p_usuario,
                  vo_cre_cod,
                  vo_cre_dep_cod,
                  vo_cre_prior_aeroporto,
                  vo_cre_prior_cnl,
                  vo_cre_tipo,
                  vo_num_seq_pessoal_carencia,
                  vo_cre_desc,
                  vo_cre_justificativa,
                  vo_cre_aen_subcod,
                  vo_cre_aen_pai,
                  vo_cre_ntf_cod,
                  vo_cre_ntf_pai,
                  vo_cre_etp_cod,
                  vo_cre_tipo_obra_cod,
                  vo_cre_prazo,
                  vo_cre_inicio,
                  vo_cre_termino,
                  vo_cre_data,
                  vo_cre_projeto,
                  vo_cre_vlobras,
                  vo_cre_valor_aprov,
                  vo_cre_valor_pago,
                  v_cre_cod
               );
               -- LOG
               stp_log (p_usuario, 'TAB_CARENCIA', 'I', TO_CHAR (v_cre_cod));
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         
--
         ELSE
            raise_application_error (-20100, v_erro);
            ROLLBACK;
         END IF;
      
--                  
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, v_erro || SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Carências
-- retorna o recordset correspondente
   PROCEDURE stp_altera_carencia (
      p_usuario                              VARCHAR2,
      vo_cre_cod                    OUT      tyt_cre_cod,
      vo_cre_dep_cod                OUT      tyt_cre_dep_cod,
      vo_cre_prior_aeroporto        OUT      tyt_cre_prior_aeroporto,
      vo_cre_prior_cnl              OUT      tyt_cre_prior_cnl,
      vo_cre_tipo                   OUT      tyt_cre_tipo,
      vo_num_seq_pessoal_carencia   OUT      tyt_num_seq_pessoal_carencia,
      vo_cre_desc                   OUT      tyt_cre_desc,
      vo_cre_justificativa          OUT      tyt_cre_justificativa,
      vo_cre_aen_subcod             OUT      tyt_cre_aen_subcod,
      vo_cre_aen_pai                OUT      tyt_cre_aen_pai,
      vo_cre_ntf_cod                OUT      tyt_cre_ntf_cod,
      vo_cre_ntf_pai                OUT      tyt_cre_ntf_pai,
      vo_cre_etp_cod                OUT      tyt_cre_etp_cod,
      vo_cre_tipo_obra_cod          OUT      tyt_cre_tipo_obra_cod,
      vo_cre_prazo                  OUT      tyt_cre_prazo,
      vo_cre_inicio                 OUT      tyt_cre_inicio,
      vo_cre_termino                OUT      tyt_cre_termino,
      vo_cre_data                   OUT      tyt_cre_data,
      vo_cre_projeto                OUT      tyt_cre_projeto,
      vo_cre_vlobras                OUT      tyt_cre_vlobras,
      vo_cre_valor_aprov            OUT      tyt_cre_valor_aprov,
      vo_cre_valor_pago             OUT      tyt_cre_valor_pago,
      vi_cre_cod                    IN       t_cre_cod,
      vi_cre_dep_cod                IN       t_cre_dep_cod,
      vi_cre_prior_aeroporto        IN       t_cre_prior_aeroporto,
      vi_cre_prior_cnl              IN       t_cre_prior_cnl,
      vi_cre_tipo                   IN       t_cre_tipo,
      vi_num_seq_pessoal_carencia   IN       t_num_seq_pessoal_carencia,
      vi_cre_desc                   IN       t_cre_desc,
      vi_cre_justificativa          IN       t_cre_justificativa,
      vi_cre_aen_subcod             IN       t_cre_aen_subcod,
      vi_cre_ntf_cod                IN       t_cre_ntf_cod,
      vi_cre_etp_cod                IN       t_cre_etp_cod,
      vi_cre_tipo_obra_cod          IN       t_cre_tipo_obra_cod,
      vi_cre_prazo                  IN       t_cre_prazo,
      vi_cre_inicio                 IN       t_cre_inicio,
      vi_cre_termino                IN       t_cre_termino,
      vi_cre_data                   IN       t_cre_data,
      vi_cre_projeto                IN       t_cre_projeto,
      vi_cre_vlobras                IN       t_cre_vlobras
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_carencia
              WHERE cre_cod = vi_cre_cod
         FOR UPDATE;

      v_tab_carencia                ifrbde_views.tab_carencia%ROWTYPE;
      v_cre_cod                     ifrbde_views.tab_carencia.cre_cod%TYPE;
      v_cre_dep_cod                 ifrbde_views.tab_carencia.cre_dep_cod%TYPE;
      v_cre_prior_aeroporto         ifrbde_views.tab_carencia.cre_prior_aeroporto%TYPE;
      v_cre_prior_cnl               ifrbde_views.tab_carencia.cre_prior_cnl%TYPE;
      v_cre_tipo                    ifrbde_views.tab_carencia.cre_tipo%TYPE;
      v_cre_desc                    ifrbde_views.tab_carencia.cre_desc%TYPE;
      v_cre_justificativa           ifrbde_views.tab_carencia.cre_justificativa%TYPE;
      v_cre_aen_subcod              ifrbde_views.tab_carencia.cre_aen_subcod%TYPE;
      v_cre_ntf_cod                 ifrbde_views.tab_carencia.cre_ntf_cod%TYPE;
      v_cre_etp_cod                 ifrbde_views.tab_carencia.cre_etp_cod%TYPE;
      v_cre_tipo_obra_cod           ifrbde_views.tab_carencia.cre_tipo_obra_cod%TYPE;
      v_cre_inicio                  ifrbde_views.tab_carencia.cre_inicio%TYPE;
      v_cre_termino                 ifrbde_views.tab_carencia.cre_termino%TYPE;
      v_cre_data                    ifrbde_views.tab_carencia.cre_data%TYPE;
      v_cre_vlobras                 ifrbde_views.tab_carencia.cre_vlobras%TYPE;
      v_cre_projeto                 ifrbde_views.tab_carencia.cre_projeto%TYPE;
      v_cre_prazo                   ifrbde_views.tab_carencia.cre_prazo%TYPE;
      v_num_seq_pessoal_carencia    ifrbde_views.tab_carencia.num_seq_pessoal_carencia%TYPE;
      v_sucesso                     NUMBER (1);
      v_erro                        VARCHAR2 (200);
   BEGIN
      v_sucesso := 0;

      IF stf_permitido (p_usuario, 'TAB_CARENCIA', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_carencia;

         IF NOT c_cursor%NOTFOUND THEN
            
--
-- criticas do carência
--
            IF vi_cre_prazo < 0 THEN
               v_erro :=
                        'Prazo de Execução do Carência não pode ser negativa';
               v_sucesso := 1;
            END IF;

            
-- 
--
            IF v_sucesso = 0 THEN
               v_cre_prior_aeroporto :=
                               RTRIM (LTRIM (UPPER (vi_cre_prior_aeroporto)));
               v_cre_prior_cnl := RTRIM (LTRIM (UPPER (vi_cre_prior_cnl)));
               v_cre_desc := RTRIM (LTRIM (UPPER (vi_cre_desc)));
               v_cre_justificativa :=
                                 RTRIM (LTRIM (UPPER (vi_cre_justificativa)));
               v_cre_aen_subcod := RTRIM (LTRIM (UPPER (vi_cre_aen_subcod)));
               v_cre_ntf_cod := RTRIM (LTRIM (UPPER (vi_cre_ntf_cod)));
               v_cre_inicio := RTRIM (LTRIM (UPPER (vi_cre_inicio)));
               v_cre_termino := RTRIM (LTRIM (UPPER (vi_cre_termino)));
               v_cre_projeto := RTRIM (LTRIM (UPPER (vi_cre_projeto)));
               v_cre_data := TO_DATE (vi_cre_data, 'DD/MM/YYYY');
               v_cre_cod := vi_cre_cod;
               v_cre_dep_cod := vi_cre_dep_cod;
               v_cre_tipo := vi_cre_tipo;
               v_cre_etp_cod := vi_cre_etp_cod;
               v_cre_tipo_obra_cod := vi_cre_tipo_obra_cod;
               v_cre_vlobras := vi_cre_vlobras;
               v_cre_prazo := vi_cre_prazo;
               v_num_seq_pessoal_carencia := vi_num_seq_pessoal_carencia;

               UPDATE ifrbde_views.tab_carencia
                  SET cre_dep_cod = v_cre_dep_cod,
                      cre_prior_aeroporto = v_cre_prior_aeroporto,
                      cre_prior_cnl = v_cre_prior_cnl,
                      cre_tipo = v_cre_tipo,
                      cre_desc = v_cre_desc,
                      cre_justificativa = v_cre_justificativa,
                      cre_aen_subcod = v_cre_aen_subcod,
                      cre_ntf_cod = v_cre_ntf_cod,
                      cre_etp_cod = v_cre_etp_cod,
                      cre_tipo_obra_cod = v_cre_tipo_obra_cod,
                      cre_inicio = v_cre_inicio,
                      cre_termino = v_cre_termino,
                      cre_data = v_cre_data,
                      cre_vlobras = v_cre_vlobras,
                      cre_projeto = v_cre_projeto,
                      cre_prazo = v_cre_prazo,
                      num_seq_pessoal_carencia = v_num_seq_pessoal_carencia
                WHERE  CURRENT OF c_cursor;

               IF SQL%ROWCOUNT = 1 THEN
                  stp_pesquisa_carencia (
                     p_usuario,
                     vo_cre_cod,
                     vo_cre_dep_cod,
                     vo_cre_prior_aeroporto,
                     vo_cre_prior_cnl,
                     vo_cre_tipo,
                     vo_num_seq_pessoal_carencia,
                     vo_cre_desc,
                     vo_cre_justificativa,
                     vo_cre_aen_subcod,
                     vo_cre_aen_pai,
                     vo_cre_ntf_cod,
                     vo_cre_ntf_pai,
                     vo_cre_etp_cod,
                     vo_cre_tipo_obra_cod,
                     vo_cre_prazo,
                     vo_cre_inicio,
                     vo_cre_termino,
                     vo_cre_data,
                     vo_cre_projeto,
                     vo_cre_vlobras,
                     vo_cre_valor_aprov,
                     vo_cre_valor_pago,
                     v_cre_cod
                  );
                  -- LOG
                  stp_log (
                     p_usuario,
                     'TAB_CARENCIA',
                     'A',
                     TO_CHAR (vi_cre_cod)
                  );
                  COMMIT;
               ELSE
                  ROLLBACK;
               END IF;
            
--
            ELSE
               raise_application_error (-20100, v_erro || SQLERRM);
               ROLLBACK;
            END IF;
         
--            
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Pesquisa Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_cont_termo_aditiv (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONT_TERMO_ADITIVO', 'PESQUISA') THEN
         SELECT cta_cnt_cre_cod,
                cta_cnt_cod,
                cta_periodo,
                cta_num,
                cta_objeto,
                cta_valor,
                cta_deb_cred,
                cta_prazo,
                cta_aum_dim
           INTO vo_cta_cnt_cre_cod (1),
                vo_cta_cnt_cod (1),
                vo_cta_periodo (1),
                vo_cta_num (1),
                vo_cta_objeto (1),
                vo_cta_valor (1),
                vo_cta_deb_cred (1),
                vo_cta_prazo (1),
                vo_cta_aum_dim (1)
           FROM ifrbde_views.tab_cont_termo_aditivo
          WHERE cta_cnt_cre_cod = vi_cta_cnt_cre_cod
            AND cta_cnt_cod = vi_cta_cnt_cod
            AND cta_periodo = vi_cta_periodo
            AND cta_num = vi_cta_num;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   -- Exclui Termo aditivo
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_CONT_TERMO_ADITIVO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_cont_termo_aditivo
               WHERE cta_cnt_cre_cod = vi_cta_cnt_cre_cod
                 AND cta_cnt_cod = vi_cta_cnt_cod
                 AND cta_periodo = vi_cta_periodo
                 AND cta_num = vi_cta_num;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_CONT_TERMO_ADITIVO',
               'E',
               TO_CHAR (vi_cta_cnt_cre_cod) || vi_cta_cnt_cod || vi_cta_num
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Inclui Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num,
      vi_cta_objeto        IN       t_cta_objeto,
      vi_cta_valor         IN       t_cta_valor,
      vi_cta_deb_cred      IN       t_cta_deb_cred,
      vi_cta_prazo         IN       t_cta_prazo,
      vi_cta_aum_dim       IN       t_cta_aum_dim
   ) AS
      v_cta_cnt_cre_cod             tab_cont_termo_aditivo.cta_cnt_cre_cod%TYPE;
      v_cta_cnt_cod                 tab_cont_termo_aditivo.cta_cnt_cod%TYPE;
      v_cta_periodo                 tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                     tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto                  tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                   tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred                tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_cta_prazo                   tab_cont_termo_aditivo.cta_prazo%TYPE;
      v_cta_aum_dim                 tab_cont_termo_aditivo.cta_aum_dim%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONT_TERMO_ADITIVO', 'INCLUI') THEN
         v_cta_cnt_cod := RTRIM (LTRIM (UPPER (vi_cta_cnt_cod)));
         v_cta_num := RTRIM (LTRIM (UPPER (vi_cta_num)));
         v_cta_objeto := RTRIM (LTRIM (UPPER (vi_cta_objeto)));
         v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
         v_cta_cnt_cre_cod := vi_cta_cnt_cre_cod;
         v_cta_valor := vi_cta_valor;
         v_cta_deb_cred := vi_cta_deb_cred;
         v_cta_prazo := vi_cta_prazo;
         v_cta_aum_dim := vi_cta_aum_dim;

         INSERT INTO ifrbde_views.tab_cont_termo_aditivo
                     (cta_cnt_cre_cod,
                      cta_cnt_cod,
                      cta_periodo,
                      cta_num,
                      cta_objeto,
                      cta_valor,
                      cta_deb_cred,
                      cta_prazo,
                      cta_aum_dim
                     )
              VALUES (v_cta_cnt_cre_cod,
                      v_cta_cnt_cod,
                      v_cta_periodo,
                      v_cta_num,
                      v_cta_objeto,
                      v_cta_valor,
                      v_cta_deb_cred,
                      v_cta_prazo,
                      v_cta_aum_dim
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_cont_termo_aditiv (
               p_usuario,
               vo_cta_cnt_cre_cod,
               vo_cta_cnt_cod,
               vo_cta_periodo,
               vo_cta_num,
               vo_cta_objeto,
               vo_cta_valor,
               vo_cta_deb_cred,
               vo_cta_prazo,
               vo_cta_aum_dim,
               v_cta_cnt_cre_cod,
               v_cta_cnt_cod,
               v_cta_periodo,
               v_cta_num
            );
            -- LOG
            stp_log (
               p_usuario,
               'TAB_CONT_TERMO_ADITIVO',
               'I',
               TO_CHAR (vi_cta_cnt_cre_cod) || vi_cta_cnt_cod || vi_cta_num
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Altera Termo aditivo
-- retorna o recordset correspondente
   PROCEDURE stp_altera_cont_termo_aditivo (
      p_usuario                     VARCHAR2,
      vo_cta_cnt_cre_cod   OUT      tyt_cta_cnt_cre_cod,
      vo_cta_cnt_cod       OUT      tyt_cta_cnt_cod,
      vo_cta_periodo       OUT      tyt_cta_periodo,
      vo_cta_num           OUT      tyt_cta_num,
      vo_cta_objeto        OUT      tyt_cta_objeto,
      vo_cta_valor         OUT      tyt_cta_valor,
      vo_cta_deb_cred      OUT      tyt_cta_deb_cred,
      vo_cta_prazo         OUT      tyt_cta_prazo,
      vo_cta_aum_dim       OUT      tyt_cta_aum_dim,
      vi_cta_cnt_cre_cod   IN       t_cta_cnt_cre_cod,
      vi_cta_cnt_cod       IN       t_cta_cnt_cod,
      vi_cta_periodo       IN       t_cta_periodo,
      vi_cta_num           IN       t_cta_num,
      vi_cta_objeto        IN       t_cta_objeto,
      vi_cta_valor         IN       t_cta_valor,
      vi_cta_deb_cred      IN       t_cta_deb_cred,
      vi_cta_prazo         IN       t_cta_prazo,
      vi_cta_aum_dim       IN       t_cta_aum_dim
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_cont_termo_aditivo
              WHERE cta_cnt_cre_cod = vi_cta_cnt_cre_cod
                AND cta_cnt_cod = vi_cta_cnt_cod
                AND cta_periodo = vi_cta_periodo
                AND cta_num = vi_cta_num
         FOR UPDATE;

      v_tab_cont_termo_aditivo      ifrbde_views.tab_cont_termo_aditivo%ROWTYPE;
      v_cta_cnt_cre_cod             ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cre_cod%TYPE;
      v_cta_cnt_cod                 ifrbde_views.tab_cont_termo_aditivo.cta_cnt_cod%TYPE;
      v_cta_periodo                 ifrbde_views.tab_cont_termo_aditivo.cta_periodo%TYPE;
      v_cta_num                     ifrbde_views.tab_cont_termo_aditivo.cta_num%TYPE;
      v_cta_objeto                  ifrbde_views.tab_cont_termo_aditivo.cta_objeto%TYPE;
      v_cta_valor                   ifrbde_views.tab_cont_termo_aditivo.cta_valor%TYPE;
      v_cta_deb_cred                ifrbde_views.tab_cont_termo_aditivo.cta_deb_cred%TYPE;
      v_cta_prazo                   ifrbde_views.tab_cont_termo_aditivo.cta_prazo%TYPE;
      v_cta_aum_dim                 ifrbde_views.tab_cont_termo_aditivo.cta_aum_dim%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONT_TERMO_ADITIVO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_cont_termo_aditivo;

         IF NOT c_cursor%NOTFOUND THEN
            v_cta_cnt_cod := RTRIM (LTRIM (UPPER (vi_cta_cnt_cod)));
            v_cta_num := RTRIM (LTRIM (UPPER (vi_cta_num)));
            v_cta_objeto := RTRIM (LTRIM (UPPER (vi_cta_objeto)));
            v_cta_periodo := TO_DATE (vi_cta_periodo, 'DD/MM/YYYY');
            v_cta_cnt_cre_cod := vi_cta_cnt_cre_cod;
            v_cta_valor := vi_cta_valor;
            v_cta_deb_cred := vi_cta_deb_cred;
            v_cta_prazo := vi_cta_prazo;
            v_cta_aum_dim := vi_cta_aum_dim;

            UPDATE ifrbde_views.tab_cont_termo_aditivo
               SET cta_objeto = v_cta_objeto,
                   cta_valor = v_cta_valor,
                   cta_deb_cred = v_cta_deb_cred,
                   cta_prazo = v_cta_prazo,
                   cta_aum_dim = v_cta_aum_dim
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_cont_termo_aditiv (
                  p_usuario,
                  vo_cta_cnt_cre_cod,
                  vo_cta_cnt_cod,
                  vo_cta_periodo,
                  vo_cta_num,
                  vo_cta_objeto,
                  vo_cta_valor,
                  vo_cta_deb_cred,
                  vo_cta_prazo,
                  vo_cta_aum_dim,
                  v_cta_cnt_cre_cod,
                  v_cta_cnt_cod,
                  v_cta_periodo,
                  v_cta_num
               );
               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_CONT_TERMO_ADITIVO',
                  'A',
                  TO_CHAR (vi_cta_cnt_cre_cod) || vi_cta_cnt_cod || vi_cta_num
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
-----------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------
   -- Pesquisa Reajuste de Contrato
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONTRATO_REAJUSTE', 'PESQUISA') THEN
         SELECT crj_cnt_cre_cod,
                crj_cnt_cod,
                crj_pgose,
                TO_CHAR (crj_periodo, 'DD/MM/YYYY'),
                crj_valor
           INTO vo_crj_cnt_cre_cod (1),
                vo_crj_cnt_cod (1),
                vo_crj_pgose (1),
                vo_crj_periodo (1),
                vo_crj_valor (1)
           FROM ifrbde_views.tab_contrato_reajuste
          WHERE crj_cnt_cre_cod = vi_crj_cnt_cre_cod
            AND crj_cnt_cod = vi_crj_cnt_cod
            AND crj_pgose = vi_crj_pgose
            AND crj_periodo = TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Reajuste de Contrato
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo
   ) AS
      v_crj_valor                   ifrbde_views.tab_contrato_reajuste.crj_valor%TYPE;
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_CONTRATO_REAJUSTE', 'EXCLUI') THEN
         SELECT crj_valor
           INTO v_crj_valor
           FROM ifrbde_views.tab_contrato_reajuste
          WHERE crj_cnt_cre_cod = vi_crj_cnt_cre_cod
            AND crj_cnt_cod = vi_crj_cnt_cod
            AND crj_pgose = vi_crj_pgose
            AND crj_periodo = TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');

         UPDATE ifrbde_views.tab_contrato
            SET cnt_valor_reaj = cnt_valor_reaj - v_crj_valor
          WHERE cnt_cre_cod = vi_crj_cnt_cre_cod AND cnt_cod = vi_crj_cnt_cod;

         DELETE FROM ifrbde_views.tab_contrato_reajuste
               WHERE crj_cnt_cre_cod = vi_crj_cnt_cre_cod
                 AND crj_cnt_cod = vi_crj_cnt_cod
                 AND crj_pgose = vi_crj_pgose
                 AND crj_periodo = TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_CONTRATO_REAJUSTE',
               'E',
               TO_CHAR (vi_crj_cnt_cre_cod)
               || vi_crj_cnt_cod
               || vi_crj_pgose
               || vi_crj_periodo
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Inclui Reajuste de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo,
      vi_crj_valor         IN       t_crj_valor
   ) AS
      v_crj_cnt_cre_cod             tab_contrato_reajuste.crj_cnt_cre_cod%TYPE;
      v_crj_cnt_cod                 tab_contrato_reajuste.crj_cnt_cod%TYPE;
      v_crj_pgose                   tab_contrato_reajuste.crj_pgose%TYPE;
      v_crj_periodo                 tab_contrato_reajuste.crj_periodo%TYPE;
      v_crj_valor                   tab_contrato_reajuste.crj_valor%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONTRATO_REAJUSTE', 'INCLUI') THEN
         v_crj_cnt_cod := RTRIM (LTRIM (UPPER (vi_crj_cnt_cod)));
         v_crj_pgose := RTRIM (LTRIM (UPPER (vi_crj_pgose)));
         v_crj_periodo := TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');
         v_crj_cnt_cre_cod := vi_crj_cnt_cre_cod;
         v_crj_valor := vi_crj_valor;

         UPDATE ifrbde_views.tab_contrato
            SET cnt_valor_reaj = cnt_valor_reaj + vi_crj_valor
          WHERE cnt_cre_cod = vi_crj_cnt_cre_cod AND cnt_cod = vi_crj_cnt_cod;

         INSERT INTO ifrbde_views.tab_contrato_reajuste
                     (crj_cnt_cre_cod,
                      crj_cnt_cod,
                      crj_pgose,
                      crj_periodo,
                      crj_valor
                     )
              VALUES (v_crj_cnt_cre_cod,
                      v_crj_cnt_cod,
                      v_crj_pgose,
                      v_crj_periodo,
                      v_crj_valor
                     );

         IF SQL%ROWCOUNT = 1 THEN
            SELECT crj_cnt_cre_cod,
                   crj_cnt_cod,
                   crj_pgose,
                   TO_CHAR (crj_periodo, 'DD/MM/YYYY'),
                   crj_valor
              INTO vo_crj_cnt_cre_cod (1),
                   vo_crj_cnt_cod (1),
                   vo_crj_pgose (1),
                   vo_crj_periodo (1),
                   vo_crj_valor (1)
              FROM ifrbde_views.tab_contrato_reajuste
             WHERE crj_cnt_cre_cod = v_crj_cnt_cre_cod
               AND crj_cnt_cod = v_crj_cnt_cod
               AND crj_pgose = v_crj_pgose
               AND crj_periodo = v_crj_periodo;

            -- LOG
            stp_log (
               p_usuario,
               'TAB_CONTRATO_REAJUSTE',
               'I',
               TO_CHAR (vi_crj_cnt_cre_cod)
               || vi_crj_cnt_cod
               || vi_crj_pgose
               || vi_crj_periodo
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Altera Reajuste de Contrato
-- retorna o recordset correspondente
   PROCEDURE stp_altera_contrato_reajuste (
      p_usuario                     VARCHAR2,
      vo_crj_cnt_cre_cod   OUT      tyt_crj_cnt_cre_cod,
      vo_crj_cnt_cod       OUT      tyt_crj_cnt_cod,
      vo_crj_pgose         OUT      tyt_crj_pgose,
      vo_crj_periodo       OUT      tyt_crj_periodo,
      vo_crj_valor         OUT      tyt_crj_valor,
      vi_crj_cnt_cre_cod   IN       t_crj_cnt_cre_cod,
      vi_crj_cnt_cod       IN       t_crj_cnt_cod,
      vi_crj_pgose         IN       t_crj_pgose,
      vi_crj_periodo       IN       t_crj_periodo,
      vi_crj_valor         IN       t_crj_valor
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_contrato_reajuste
              WHERE crj_cnt_cre_cod = vi_crj_cnt_cre_cod
                AND crj_cnt_cod = vi_crj_cnt_cod
                AND crj_pgose = vi_crj_pgose
                AND crj_periodo = TO_DATE (vi_crj_periodo, 'DD/MM/YYYY')
         FOR UPDATE;

      v_tab_contrato_reajuste       ifrbde_views.tab_contrato_reajuste%ROWTYPE;
      v_crj_cnt_cre_cod             ifrbde_views.tab_contrato_reajuste.crj_cnt_cre_cod%TYPE;
      v_crj_cnt_cod                 ifrbde_views.tab_contrato_reajuste.crj_cnt_cod%TYPE;
      v_crj_pgose                   ifrbde_views.tab_contrato_reajuste.crj_pgose%TYPE;
      v_crj_periodo                 ifrbde_views.tab_contrato_reajuste.crj_periodo%TYPE;
      v_crj_valor                   ifrbde_views.tab_contrato_reajuste.crj_valor%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_CONTRATO_REAJUSTE', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_contrato_reajuste;

         IF NOT c_cursor%NOTFOUND THEN
            SELECT crj_valor
              INTO v_crj_valor
              FROM ifrbde_views.tab_contrato_reajuste
             WHERE crj_cnt_cre_cod = vi_crj_cnt_cre_cod
               AND crj_cnt_cod = vi_crj_cnt_cod
               AND crj_pgose = vi_crj_pgose
               AND crj_periodo = TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');

            UPDATE ifrbde_views.tab_contrato
               SET cnt_valor_reaj = cnt_valor_reaj - v_crj_valor
             WHERE cnt_cre_cod = vi_crj_cnt_cre_cod
               AND cnt_cod = vi_crj_cnt_cod;

            v_crj_cnt_cod := RTRIM (LTRIM (UPPER (vi_crj_cnt_cod)));
            v_crj_pgose := RTRIM (LTRIM (UPPER (vi_crj_pgose)));
            v_crj_periodo := TO_DATE (vi_crj_periodo, 'DD/MM/YYYY');
            v_crj_cnt_cre_cod := vi_crj_cnt_cre_cod;
            v_crj_valor := vi_crj_valor;

            UPDATE ifrbde_views.tab_contrato
               SET cnt_valor_reaj = cnt_valor_reaj + v_crj_valor
             WHERE cnt_cre_cod = vi_crj_cnt_cre_cod
               AND cnt_cod = vi_crj_cnt_cod;

            UPDATE ifrbde_views.tab_contrato_reajuste
               SET crj_valor = v_crj_valor
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               SELECT crj_cnt_cre_cod,
                      crj_cnt_cod,
                      crj_pgose,
                      TO_CHAR (crj_periodo, 'DD/MM/YYYY'),
                      crj_valor
                 INTO vo_crj_cnt_cre_cod (1),
                      vo_crj_cnt_cod (1),
                      vo_crj_pgose (1),
                      vo_crj_periodo (1),
                      vo_crj_valor (1)
                 FROM ifrbde_views.tab_contrato_reajuste
                WHERE crj_cnt_cre_cod = v_crj_cnt_cre_cod
                  AND crj_cnt_cod = v_crj_cnt_cod
                  AND crj_pgose = v_crj_pgose
                  AND crj_periodo = v_crj_periodo;

               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_CONTRATO_REAJUSTE',
                  'A',
                  TO_CHAR (vi_crj_cnt_cre_cod)
                  || vi_crj_cnt_cod
                  || vi_crj_pgose
                  || vi_crj_periodo
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
         ROLLBACK;
   END;

   
--------------------------------------------------------------------
-- Pesquisa Cadastro de Responsaveis
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_seq_pessoal    IN       t_num_seq_pessoal
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'CAD_RESPONSAVEIS', 'PESQUISA') THEN
         SELECT num_seq_pessoal,
                num_mat_infraero,
                nom_responsavel,
                cod_dependencia,
                num_cpf,
                dsc_email_notes,
                flg_carencia,
                flg_contrato,
                flg_assinatura,
                flg_fiscal
           INTO vo_num_seq_pessoal (1),
                vo_num_mat_infraero (1),
                vo_nom_responsavel (1),
                vo_cod_dependencia (1),
                vo_num_cpf (1),
                vo_dsc_email_notes (1),
                vo_flg_carencia (1),
                vo_flg_contrato (1),
                vo_flg_assinatura (1),
                vo_flg_fiscal (1)
           FROM ifrbde_views.cad_responsaveis
          WHERE num_seq_pessoal = vi_num_seq_pessoal;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Cadastro de Responsaveis
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_responsaveis (
      p_usuario                     VARCHAR2,
      vo_ok                OUT      tyt_ok,
      vi_num_seq_pessoal   IN       t_num_seq_pessoal
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'CAD_RESPONSAVEIS', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.cad_responsaveis
               WHERE num_seq_pessoal = vi_num_seq_pessoal;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'CAD_RESPONSAVEIS',
               'E',
               TO_CHAR (vi_num_seq_pessoal)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Cadastro de Responsaveis
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_mat_infraero   IN       t_num_mat_infraero,
      vi_nom_responsavel    IN       t_nom_responsavel,
      vi_cod_dependencia    IN       t_cod_dependencia,
      vi_num_cpf            IN       t_num_cpf,
      vi_dsc_email_notes    IN       t_dsc_email_notes,
      vi_flg_carencia       IN       t_flg_carencia,
      vi_flg_contrato       IN       t_flg_contrato,
      vi_flg_assinatura     IN       t_flg_assinatura,
      vi_flg_fiscal         IN       t_flg_fiscal
   ) AS
      v_num_seq_pessoal             cad_responsaveis.num_seq_pessoal%TYPE;
      v_num_mat_infraero            cad_responsaveis.num_mat_infraero%TYPE;
      v_nom_responsavel             cad_responsaveis.nom_responsavel%TYPE;
      v_cod_dependencia             cad_responsaveis.cod_dependencia%TYPE;
      v_num_cpf                     cad_responsaveis.num_cpf%TYPE;
      v_dsc_email_notes             cad_responsaveis.dsc_email_notes%TYPE;
      v_flg_carencia                cad_responsaveis.flg_carencia%TYPE;
      v_flg_contrato                cad_responsaveis.flg_contrato%TYPE;
      v_flg_assinatura              cad_responsaveis.flg_assinatura%TYPE;
      v_flg_fiscal                  cad_responsaveis.flg_fiscal%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'CAD_RESPONSAVEIS', 'INCLUI') THEN
         
--         SELECT seq_num_seq_pessoal.nextval
--         INTO v_num_seq_pessoal
--         FROM dual;
         SELECT MAX (NVL (num_seq_pessoal, 0)) + 1
           INTO v_num_seq_pessoal
           FROM ifrbde.cad_responsaveis;

         v_num_mat_infraero := RTRIM (LTRIM (UPPER (vi_num_mat_infraero)));
         v_nom_responsavel := RTRIM (LTRIM (UPPER (vi_nom_responsavel)));
         v_num_cpf := RTRIM (LTRIM (UPPER (vi_num_cpf)));
         v_dsc_email_notes := RTRIM (LTRIM (UPPER (vi_dsc_email_notes)));
         v_flg_carencia := RTRIM (LTRIM (UPPER (vi_flg_carencia)));
         v_flg_contrato := RTRIM (LTRIM (UPPER (vi_flg_contrato)));
         v_flg_assinatura := RTRIM (LTRIM (UPPER (vi_flg_assinatura)));
         v_flg_fiscal := RTRIM (LTRIM (UPPER (vi_flg_fiscal)));
         v_cod_dependencia := vi_cod_dependencia;

         INSERT INTO ifrbde_views.cad_responsaveis
                     (num_seq_pessoal,
                      num_mat_infraero,
                      nom_responsavel,
                      cod_dependencia,
                      num_cpf,
                      dsc_email_notes,
                      flg_carencia,
                      flg_contrato,
                      flg_assinatura,
                      flg_fiscal
                     )
              VALUES (v_num_seq_pessoal,
                      v_num_mat_infraero,
                      v_nom_responsavel,
                      v_cod_dependencia,
                      v_num_cpf,
                      v_dsc_email_notes,
                      v_flg_carencia,
                      v_flg_contrato,
                      v_flg_assinatura,
                      v_flg_fiscal
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_responsaveis (
               p_usuario,
               vo_num_seq_pessoal,
               vo_num_mat_infraero,
               vo_nom_responsavel,
               vo_cod_dependencia,
               vo_num_cpf,
               vo_dsc_email_notes,
               vo_flg_carencia,
               vo_flg_contrato,
               vo_flg_assinatura,
               vo_flg_fiscal,
               v_num_seq_pessoal
            );
            -- LOG
            stp_log (
               p_usuario,
               'CAD_RESPONSAVEIS',
               'I',
               TO_CHAR (v_num_seq_pessoal)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Cadastro de Responsaveis
-- retorna o recordset correspondente
   PROCEDURE stp_altera_responsaveis (
      p_usuario                      VARCHAR2,
      vo_num_seq_pessoal    OUT      tyt_num_seq_pessoal,
      vo_num_mat_infraero   OUT      tyt_num_mat_infraero,
      vo_nom_responsavel    OUT      tyt_nom_responsavel,
      vo_cod_dependencia    OUT      tyt_cod_dependencia,
      vo_num_cpf            OUT      tyt_num_cpf,
      vo_dsc_email_notes    OUT      tyt_dsc_email_notes,
      vo_flg_carencia       OUT      tyt_flg_carencia,
      vo_flg_contrato       OUT      tyt_flg_contrato,
      vo_flg_assinatura     OUT      tyt_flg_assinatura,
      vo_flg_fiscal         OUT      tyt_flg_fiscal,
      vi_num_seq_pessoal    IN       t_num_seq_pessoal,
      vi_num_mat_infraero   IN       t_num_mat_infraero,
      vi_nom_responsavel    IN       t_nom_responsavel,
      vi_cod_dependencia    IN       t_cod_dependencia,
      vi_num_cpf            IN       t_num_cpf,
      vi_dsc_email_notes    IN       t_dsc_email_notes,
      vi_flg_carencia       IN       t_flg_carencia,
      vi_flg_contrato       IN       t_flg_contrato,
      vi_flg_assinatura     IN       t_flg_assinatura,
      vi_flg_fiscal         IN       t_flg_fiscal
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.cad_responsaveis
              WHERE num_seq_pessoal = vi_num_seq_pessoal
         FOR UPDATE;

      v_cad_responsaveis            ifrbde_views.cad_responsaveis%ROWTYPE;
      v_num_seq_pessoal             ifrbde_views.cad_responsaveis.num_seq_pessoal%TYPE;
      v_num_mat_infraero            ifrbde_views.cad_responsaveis.num_mat_infraero%TYPE;
      v_nom_responsavel             ifrbde_views.cad_responsaveis.nom_responsavel%TYPE;
      v_cod_dependencia             ifrbde_views.cad_responsaveis.cod_dependencia%TYPE;
      v_num_cpf                     ifrbde_views.cad_responsaveis.num_cpf%TYPE;
      v_dsc_email_notes             ifrbde_views.cad_responsaveis.dsc_email_notes%TYPE;
      v_flg_carencia                ifrbde_views.cad_responsaveis.flg_carencia%TYPE;
      v_flg_contrato                ifrbde_views.cad_responsaveis.flg_contrato%TYPE;
      v_flg_assinatura              ifrbde_views.cad_responsaveis.flg_assinatura%TYPE;
      v_flg_fiscal                  ifrbde_views.cad_responsaveis.flg_fiscal%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'CAD_RESPONSAVEIS', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_cad_responsaveis;

         IF NOT c_cursor%NOTFOUND THEN
            v_num_mat_infraero := RTRIM (LTRIM (UPPER (vi_num_mat_infraero)));
            v_nom_responsavel := RTRIM (LTRIM (UPPER (vi_nom_responsavel)));
            v_num_cpf := RTRIM (LTRIM (UPPER (vi_num_cpf)));
            v_dsc_email_notes := RTRIM (LTRIM (UPPER (vi_dsc_email_notes)));
            v_flg_carencia := RTRIM (LTRIM (UPPER (vi_flg_carencia)));
            v_flg_contrato := RTRIM (LTRIM (UPPER (vi_flg_contrato)));
            v_flg_assinatura := RTRIM (LTRIM (UPPER (vi_flg_assinatura)));
            v_flg_fiscal := RTRIM (LTRIM (UPPER (vi_flg_fiscal)));
            v_cod_dependencia := vi_cod_dependencia;

            UPDATE ifrbde_views.cad_responsaveis
               SET num_mat_infraero = v_num_mat_infraero,
                   nom_responsavel = v_nom_responsavel,
                   cod_dependencia = v_cod_dependencia,
                   num_cpf = v_num_cpf,
                   dsc_email_notes = v_dsc_email_notes,
                   flg_carencia = v_flg_carencia,
                   flg_contrato = v_flg_contrato,
                   flg_assinatura = v_flg_assinatura,
                   flg_fiscal = v_flg_fiscal
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_responsaveis (
                  p_usuario,
                  vo_num_seq_pessoal,
                  vo_num_mat_infraero,
                  vo_nom_responsavel,
                  vo_cod_dependencia,
                  vo_num_cpf,
                  vo_dsc_email_notes,
                  vo_flg_carencia,
                  vo_flg_contrato,
                  vo_flg_assinatura,
                  vo_flg_fiscal,
                  v_num_seq_pessoal
               );
               -- LOG
               stp_log (
                  p_usuario,
                  'CAD_RESPONSAVEIS',
                  'A',
                  TO_CHAR (vi_num_seq_pessoal)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------

   -- Pesquisa Remanejamento
   -- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_remanejamento (
      p_usuario                       VARCHAR2,
      vo_rmj_cod             OUT      tyt_rmj_cod,
      vo_rmj_ano             OUT      tyt_rmj_ano,
      vo_rmj_seq_orig        OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig    OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig        OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig        OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest        OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest    OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest        OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest        OUT      tyt_rmj_obj_dest,
      vo_rmj_valor           OUT      tyt_rmj_valor,
      vo_dat_remanejamento   OUT      tyt_dat_remanejamento,
      vo_rmj_usuario         OUT      tyt_rmj_usuario,
      vi_rmj_cod             IN       t_rmj_cod
   ) AS
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REMANEJAMENTO',
            'PESQUISA'
         ) THEN
         SELECT a.rmj_cod,
                a.rmj_ano,
                a.rmj_seq_orig,
                a.rmj_rti_cod_orig,
                bd.dep_desc AS rmj_dep_orig,
                b.cre_desc AS rmj_obj_orig,
                a.rmj_seq_dest,
                a.rmj_rti_cod_dest,
                cd.dep_desc AS rmj_dep_dest,
                c.cre_desc AS rmj_obj_dest,
                a.rmj_valor,
                TO_DATE (TO_CHAR (a.dat_remanejamento, 'DD/MM/YYYY'), 'DD/MM/YYYY'),
                a.rmj_usuario
           INTO vo_rmj_cod (1),
                vo_rmj_ano (1),
                vo_rmj_seq_orig (1),
                vo_rmj_rti_cod_orig (1),
                vo_rmj_dep_orig (1),
                vo_rmj_obj_orig (1),
                vo_rmj_seq_dest (1),
                vo_rmj_rti_cod_dest (1),
                vo_rmj_dep_dest (1),
                vo_rmj_obj_dest (1),
                vo_rmj_valor (1),
                vo_dat_remanejamento (1),
                vo_rmj_usuario (1)
           FROM ifrbde_views.tab_remanejamento a,
                ifrbde_views.tab_carencia b,
                ifrbde_views.tab_carencia c,
                ifrbde_views.tab_dependencia bd,
                ifrbde_views.tab_dependencia cd
          WHERE a.rmj_cod = vi_rmj_cod
            AND a.rmj_seq_orig = b.cre_cod
            AND a.rmj_seq_dest = c.cre_cod
            AND b.cre_dep_cod = bd.dep_cod
            AND c.cre_dep_cod = cd.dep_cod;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   -- Exclui Remanejamento
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_remanejamento (
      p_usuario             VARCHAR2,
      vo_ok        OUT      tyt_ok,
      vi_rmj_cod   IN       t_rmj_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REMANEJAMENTO',
            'EXCLUI'
         ) THEN
         DELETE FROM ifrbde_views.tab_remanejamento
               WHERE rmj_cod = vi_rmj_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_REMANEJAMENTO',
               'E',
               TO_CHAR (vi_rmj_cod)
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Inclui Remanejamento
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_remanejamento (
      p_usuario                      VARCHAR2,
      vo_rmj_cod            OUT      tyt_rmj_cod,
      vo_rmj_ano            OUT      tyt_rmj_ano,
      vo_rmj_seq_orig       OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig   OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig       OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig       OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest       OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest   OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest       OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest       OUT      tyt_rmj_obj_dest,
      vo_rmj_valor          OUT      tyt_rmj_valor,
      vo_dat_remanejamento           OUT      tyt_dat_remanejamento,
      vo_rmj_usuario        OUT      tyt_rmj_usuario,
      vi_rmj_ano            IN       t_rmj_ano,
      vi_rmj_seq_orig       IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig   IN       t_rmj_rti_cod_orig,
      vi_rmj_seq_dest       IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest   IN       t_rmj_rti_cod_dest,
      vi_rmj_valor          IN       t_rmj_valor,
      vi_dat_remanejamento           IN       t_dat_remanejamento,
      vi_rmj_usuario        IN       t_rmj_usuario
   ) AS
      v_rmj_cod                     tab_remanejamento.rmj_cod%TYPE;
      v_rmj_ano                     tab_remanejamento.rmj_ano%TYPE;
      v_rmj_seq_orig                tab_remanejamento.rmj_seq_orig%TYPE;
      v_rmj_rti_cod_orig            tab_remanejamento.rmj_rti_cod_orig%TYPE;
      v_rmj_seq_dest                tab_remanejamento.rmj_seq_dest%TYPE;
      v_rmj_rti_cod_dest            tab_remanejamento.rmj_rti_cod_dest%TYPE;
      v_rmj_valor                   tab_remanejamento.rmj_valor%TYPE;
      v_dat_remanejamento                    tab_remanejamento.dat_remanejamento%TYPE;
      v_rmj_usuario                 tab_remanejamento.rmj_usuario%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REMANEJAMENTO',
            'INCLUI'
         ) THEN
         SELECT seq_rmj_cod.NEXTVAL
           INTO v_rmj_cod
           FROM DUAL;

         v_rmj_ano := RTRIM (LTRIM (UPPER (vi_rmj_ano)));
         v_rmj_rti_cod_orig := RTRIM (LTRIM (UPPER (vi_rmj_rti_cod_orig)));
         v_rmj_rti_cod_dest := RTRIM (LTRIM (UPPER (vi_rmj_rti_cod_dest)));
         v_rmj_usuario := USER;
         v_dat_remanejamento := TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'), 'DD/MM/YYYY');
         v_rmj_seq_orig := vi_rmj_seq_orig;
         v_rmj_seq_dest := vi_rmj_seq_dest;
         v_rmj_valor := vi_rmj_valor;

         INSERT INTO ifrbde_views.tab_remanejamento
                     (rmj_cod,
                      rmj_ano,
                      rmj_seq_orig,
                      rmj_rti_cod_orig,
                      rmj_seq_dest,
                      rmj_rti_cod_dest,
                      rmj_valor,
                      dat_remanejamento,
                      rmj_usuario
                     )
              VALUES (v_rmj_cod,
                      v_rmj_ano,
                      v_rmj_seq_orig,
                      v_rmj_rti_cod_orig,
                      v_rmj_seq_dest,
                      v_rmj_rti_cod_dest,
                      v_rmj_valor,
                      v_dat_remanejamento,
                      v_rmj_usuario
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_remanejamento (
               p_usuario,
               vo_rmj_cod,
               vo_rmj_ano,
               vo_rmj_seq_orig,
               vo_rmj_rti_cod_orig,
               vo_rmj_dep_orig,
               vo_rmj_obj_orig,
               vo_rmj_seq_dest,
               vo_rmj_rti_cod_dest,
               vo_rmj_dep_dest,
               vo_rmj_obj_dest,
               vo_rmj_valor,
               vo_dat_remanejamento,
               vo_rmj_usuario,
               v_rmj_cod
            );
            -- LOG
            ifrbde_views.pck_seguranca.stp_log (
               p_usuario,
               'TAB_REMANEJAMENTO',
               'I',
               TO_CHAR (v_rmj_cod)
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Altera Remanejamento
-- retorna o recordset correspondente
   PROCEDURE stp_altera_remanejamento (
      p_usuario                      VARCHAR2,
      vo_rmj_cod            OUT      tyt_rmj_cod,
      vo_rmj_ano            OUT      tyt_rmj_ano,
      vo_rmj_seq_orig       OUT      tyt_rmj_seq_orig,
      vo_rmj_rti_cod_orig   OUT      tyt_rmj_rti_cod_orig,
      vo_rmj_dep_orig       OUT      tyt_rmj_dep_orig,
      vo_rmj_obj_orig       OUT      tyt_rmj_obj_orig,
      vo_rmj_seq_dest       OUT      tyt_rmj_seq_dest,
      vo_rmj_rti_cod_dest   OUT      tyt_rmj_rti_cod_dest,
      vo_rmj_dep_dest       OUT      tyt_rmj_dep_dest,
      vo_rmj_obj_dest       OUT      tyt_rmj_obj_dest,
      vo_rmj_valor          OUT      tyt_rmj_valor,
      vo_dat_remanejamento           OUT      tyt_dat_remanejamento,
      vo_rmj_usuario        OUT      tyt_rmj_usuario,
      vi_rmj_cod            IN       t_rmj_cod,
      vi_rmj_ano            IN       t_rmj_ano,
      vi_rmj_seq_orig       IN       t_rmj_seq_orig,
      vi_rmj_rti_cod_orig   IN       t_rmj_rti_cod_orig,
      vi_rmj_seq_dest       IN       t_rmj_seq_dest,
      vi_rmj_rti_cod_dest   IN       t_rmj_rti_cod_dest,
      vi_rmj_valor          IN       t_rmj_valor,
      vi_dat_remanejamento           IN       t_dat_remanejamento,
      vi_rmj_usuario        IN       t_rmj_usuario
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_remanejamento
              WHERE rmj_cod = vi_rmj_cod
         FOR UPDATE;

      v_tab_remanejamento           ifrbde_views.tab_remanejamento%ROWTYPE;
      v_rmj_cod                     ifrbde_views.tab_remanejamento.rmj_cod%TYPE;
      v_rmj_ano                     ifrbde_views.tab_remanejamento.rmj_ano%TYPE;
      v_rmj_seq_orig                ifrbde_views.tab_remanejamento.rmj_seq_orig%TYPE;
      v_rmj_rti_cod_orig            ifrbde_views.tab_remanejamento.rmj_rti_cod_orig%TYPE;
      v_rmj_seq_dest                ifrbde_views.tab_remanejamento.rmj_seq_dest%TYPE;
      v_rmj_rti_cod_dest            ifrbde_views.tab_remanejamento.rmj_rti_cod_dest%TYPE;
      v_rmj_valor                   ifrbde_views.tab_remanejamento.rmj_valor%TYPE;
      v_dat_remanejamento                    ifrbde_views.tab_remanejamento.dat_remanejamento%TYPE;
      v_rmj_usuario                 ifrbde_views.tab_remanejamento.rmj_usuario%TYPE;
   BEGIN
      IF ifrbde_views.pck_seguranca.stf_permitido (
            p_usuario,
            'TAB_REMANEJAMENTO',
            'ALTERA'
         ) THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_remanejamento;

         IF NOT c_cursor%NOTFOUND THEN
            v_rmj_ano := RTRIM (LTRIM (UPPER (vi_rmj_ano)));
            v_rmj_rti_cod_orig := RTRIM (LTRIM (UPPER (vi_rmj_rti_cod_orig)));
            v_rmj_rti_cod_dest := RTRIM (LTRIM (UPPER (vi_rmj_rti_cod_dest)));
            v_rmj_usuario := USER;
            v_dat_remanejamento :=
                        TO_DATE (TO_CHAR (SYSDATE, 'DD/MM/YYYY'), 'DD/MM/YYYY');
            v_rmj_seq_orig := vi_rmj_seq_orig;
            v_rmj_seq_dest := vi_rmj_seq_dest;
            v_rmj_valor := vi_rmj_valor;

            UPDATE ifrbde_views.tab_remanejamento
               SET rmj_ano = v_rmj_ano,
                   rmj_seq_orig = v_rmj_seq_orig,
                   rmj_rti_cod_orig = v_rmj_rti_cod_orig,
                   rmj_seq_dest = v_rmj_seq_dest,
                   rmj_rti_cod_dest = v_rmj_rti_cod_dest,
                   rmj_valor = v_rmj_valor,
                   dat_remanejamento = v_dat_remanejamento,
                   rmj_usuario = v_rmj_usuario
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_remanejamento (
                  p_usuario,
                  vo_rmj_cod,
                  vo_rmj_ano,
                  vo_rmj_seq_orig,
                  vo_rmj_rti_cod_orig,
                  vo_rmj_dep_orig,
                  vo_rmj_obj_orig,
                  vo_rmj_seq_dest,
                  vo_rmj_rti_cod_dest,
                  vo_rmj_dep_dest,
                  vo_rmj_obj_dest,
                  vo_rmj_valor,
                  vo_dat_remanejamento,
                  vo_rmj_usuario,
                  vi_rmj_cod
               );
               -- LOG
               ifrbde_views.pck_seguranca.stp_log (
                  p_usuario,
                  'TAB_REMANEJAMENTO',
                  'A',
                  TO_CHAR (vi_rmj_cod)
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error (-20100, SQLERRM);
   END;

   
--------------------------------------------------------------------
-- Pesquisa Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_pesquisa_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod
   ) AS
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_APROVADO', 'PESQUISA') THEN
         SELECT rap_cre_cod,
                rap_pgose,
                rap_rti_cod,
                rap_valor,
                rap_cre_pgi,
                stf_cur2str (NVL (rap_valor_pago, 0)),
                stf_cur2str (NVL (val_remanejado_enviado, 0)),
                stf_cur2str (NVL (val_remanejado_recebido, 0)),
                stf_cur2str (NVL (val_saldo_recurso, 0))
           INTO vo_rap_cre_cod (1),
                vo_rap_pgose (1),
                vo_rap_rti_cod (1),
                vo_rap_valor (1),
                vo_rap_cre_pgi (1),
                vo_rap_valor_pago (1),
                vo_val_remanejado_enviado (1),
                vo_val_remanejado_recebido (1),
                vo_val_saldo_recurso (1)
           FROM ifrbde_views.tab_rec_aprovado
          WHERE rap_cre_cod = vi_rap_cre_cod
            AND rap_pgose = vi_rap_pgose
            AND rap_rti_cod = vi_rap_rti_cod;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL; -- nenhum tratamento
   END;

   -- Exclui Aprovação
   -- retorna o OK ou nao
   PROCEDURE stp_exclui_rec_aprovado (
      p_usuario                 VARCHAR2,
      vo_ok            OUT      tyt_ok,
      vi_rap_cre_cod   IN       t_rap_cre_cod,
      vi_rap_pgose     IN       t_rap_pgose,
      vi_rap_rti_cod   IN       t_rap_rti_cod
   ) AS
   BEGIN
      vo_ok (1) := 0;

      IF stf_permitido (p_usuario, 'TAB_REC_APROVADO', 'EXCLUI') THEN
         DELETE FROM ifrbde_views.tab_rec_aprovado
               WHERE rap_cre_cod = vi_rap_cre_cod
                 AND rap_pgose = vi_rap_pgose
                 AND rap_rti_cod = vi_rap_rti_cod;

         IF SQL%ROWCOUNT = 1 THEN
            vo_ok (1) := 1;
            -- LOG
            stp_log (
               p_usuario,
               'TAB_REC_APROVADO',
               'E',
               TO_CHAR (vi_rap_cre_cod) || vi_rap_pgose || vi_rap_rti_cod
            );
            COMMIT;
         ELSIF SQL%ROWCOUNT > 1 THEN
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Inclui Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_inclui_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod,
      vi_rap_valor                 IN       t_rap_valor,
      vi_rap_cre_pgi               IN       t_rap_cre_pgi
   ) AS
      v_rap_cre_cod                 tab_rec_aprovado.rap_cre_cod%TYPE;
      v_rap_pgose                   tab_rec_aprovado.rap_pgose%TYPE;
      v_rap_rti_cod                 tab_rec_aprovado.rap_rti_cod%TYPE;
      v_rap_valor                   tab_rec_aprovado.rap_valor%TYPE;
      v_rap_cre_pgi                 tab_rec_aprovado.rap_cre_pgi%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_APROVADO', 'INCLUI') THEN
         v_rap_pgose := RTRIM (LTRIM (UPPER (vi_rap_pgose)));
         v_rap_rti_cod := RTRIM (LTRIM (UPPER (vi_rap_rti_cod)));
         v_rap_cre_pgi := RTRIM (LTRIM (UPPER (vi_rap_cre_pgi)));
         v_rap_cre_cod := vi_rap_cre_cod;
         v_rap_valor := vi_rap_valor;

         INSERT INTO ifrbde_views.tab_rec_aprovado
                     (rap_cre_cod,
                      rap_pgose,
                      rap_rti_cod,
                      rap_valor,
                      rap_cre_pgi
                     )
              VALUES (v_rap_cre_cod,
                      v_rap_pgose,
                      v_rap_rti_cod,
                      v_rap_valor,
                      v_rap_cre_pgi
                     );

         IF SQL%ROWCOUNT = 1 THEN
            stp_pesquisa_rec_aprovado (
               p_usuario,
               vo_rap_cre_cod,
               vo_rap_pgose,
               vo_rap_rti_cod,
               vo_rap_valor,
               vo_rap_cre_pgi,
               vo_rap_valor_pago,
               vo_val_remanejado_enviado,
               vo_val_remanejado_recebido,
               vo_val_saldo_recurso,
               v_rap_cre_cod,
               v_rap_pgose,
               v_rap_rti_cod
            );
            -- LOG
            stp_log (
               p_usuario,
               'TAB_REC_APROVADO',
               'I',
               TO_CHAR (vi_rap_cre_cod) || vi_rap_pgose || vi_rap_rti_cod
            );
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END IF;
   END;

   
--------------------------------------------------------------------
-- Altera Aprovação
-- retorna o recordset correspondente
   PROCEDURE stp_altera_rec_aprovado (
      p_usuario                             VARCHAR2,
      vo_rap_cre_cod               OUT      tyt_rap_cre_cod,
      vo_rap_pgose                 OUT      tyt_rap_pgose,
      vo_rap_rti_cod               OUT      tyt_rap_rti_cod,
      vo_rap_valor                 OUT      tyt_rap_valor,
      vo_rap_cre_pgi               OUT      tyt_rap_cre_pgi,
      vo_rap_valor_pago            OUT      tyt_rap_valor_pago,
      vo_val_remanejado_enviado    OUT      tyt_val_remanejado_enviado,
      vo_val_remanejado_recebido   OUT      tyt_val_remanejado_recebido,
      vo_val_saldo_recurso         OUT      tyt_val_saldo_recurso,
      vi_rap_cre_cod               IN       t_rap_cre_cod,
      vi_rap_pgose                 IN       t_rap_pgose,
      vi_rap_rti_cod               IN       t_rap_rti_cod,
      vi_rap_valor                 IN       t_rap_valor,
      vi_rap_cre_pgi               IN       t_rap_cre_pgi
   ) AS
      CURSOR c_cursor IS
         SELECT     *
               FROM ifrbde_views.tab_rec_aprovado
              WHERE rap_cre_cod = vi_rap_cre_cod
                AND rap_pgose = vi_rap_pgose
                AND rap_rti_cod = vi_rap_rti_cod
         FOR UPDATE;

      v_tab_rec_aprovado            ifrbde_views.tab_rec_aprovado%ROWTYPE;
      v_rap_cre_cod                 ifrbde_views.tab_rec_aprovado.rap_cre_cod%TYPE;
      v_rap_pgose                   ifrbde_views.tab_rec_aprovado.rap_pgose%TYPE;
      v_rap_rti_cod                 ifrbde_views.tab_rec_aprovado.rap_rti_cod%TYPE;
      v_rap_valor                   ifrbde_views.tab_rec_aprovado.rap_valor%TYPE;
      v_rap_cre_pgi                 ifrbde_views.tab_rec_aprovado.rap_cre_pgi%TYPE;
   BEGIN
      IF stf_permitido (p_usuario, 'TAB_REC_APROVADO', 'ALTERA') THEN
         OPEN c_cursor;
         FETCH c_cursor INTO v_tab_rec_aprovado;

         IF NOT c_cursor%NOTFOUND THEN
            v_rap_pgose := RTRIM (LTRIM (UPPER (vi_rap_pgose)));
            v_rap_rti_cod := RTRIM (LTRIM (UPPER (vi_rap_rti_cod)));
            v_rap_cre_pgi := RTRIM (LTRIM (UPPER (vi_rap_cre_pgi)));
            v_rap_cre_cod := vi_rap_cre_cod;
            v_rap_valor := vi_rap_valor;

            UPDATE ifrbde_views.tab_rec_aprovado
               SET rap_valor = v_rap_valor,
                   rap_cre_pgi = v_rap_cre_pgi
             WHERE  CURRENT OF c_cursor;

            IF SQL%ROWCOUNT = 1 THEN
               stp_pesquisa_rec_aprovado (
                  p_usuario,
                  vo_rap_cre_cod,
                  vo_rap_pgose,
                  vo_rap_rti_cod,
                  vo_rap_valor,
                  vo_rap_cre_pgi,
                  vo_rap_valor_pago,
                  vo_val_remanejado_enviado,
                  vo_val_remanejado_recebido,
                  vo_val_saldo_recurso,
                  v_rap_cre_cod,
                  v_rap_pgose,
                  v_rap_rti_cod
               );
               -- LOG
               stp_log (
                  p_usuario,
                  'TAB_REC_APROVADO',
                  'A',
                  TO_CHAR (vi_rap_cre_cod) || vi_rap_pgose || vi_rap_rti_cod
               );
               COMMIT;
            ELSE
               ROLLBACK;
            END IF;
         END IF;
      END IF;
   END;
---------------------------------------------------------------------------------
-- FIM DA PACKAGE   
END pck_sipreco;
/


-- End of DDL Script for Package IFRBDE_VIEWS.PCK_SIPRECO


