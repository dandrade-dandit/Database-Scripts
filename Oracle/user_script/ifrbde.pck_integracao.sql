-- Start of DDL Script for Package IFRBDE.PCK_INTEGRACAO
-- Generated 2-dez-2004 20:34:29 from SYSMAN@HOMOLOG2

CREATE OR REPLACE 
PACKAGE ifrbde.pck_integracao IS
--------------------------------------------------------------------------------
   -- tipos globais
   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

--------------------------------------------------------------------------------
   --- VIW_CONF_IDENTIFICACAO_U
   SUBTYPE t_payable_entity_id IS ifrbde.viw_conf_identificacao_u.payable_entity_id%TYPE;

   SUBTYPE t_contract_id IS ifrbde.viw_conf_identificacao_u.contract_id%TYPE;

   SUBTYPE t_contract_versao IS ifrbde.viw_conf_identificacao_u.contract_versao%TYPE;

   SUBTYPE t_contract_desc IS ifrbde.viw_conf_identificacao_u.contract_desc%TYPE;

   SUBTYPE t_contract_status_code IS ifrbde.viw_conf_identificacao_u.contract_status_code%TYPE;

   SUBTYPE t_contract_prev_status_code IS ifrbde.viw_conf_identificacao_u.contract_prev_status_code%TYPE;

   SUBTYPE t_contract_type IS ifrbde.viw_conf_identificacao_u.contract_type%TYPE;

   SUBTYPE t_contract_sub_type IS ifrbde.viw_conf_identificacao_u.contract_sub_type%TYPE;

   SUBTYPE t_contract_id_vendor IS ifrbde.viw_conf_identificacao_u.contract_id_vendor%TYPE;

   SUBTYPE t_codigo_mod_contratacao IS ifrbde.viw_conf_identificacao_u.codigo_mod_contratacao%TYPE;

   SUBTYPE t_manager_id IS ifrbde.viw_conf_identificacao_u.manager_id%TYPE;

   SUBTYPE t_security_code IS ifrbde.viw_conf_identificacao_u.security_code%TYPE;

   SUBTYPE t_sistema_origem_code IS ifrbde.viw_conf_identificacao_u.sistema_origem_code%TYPE;

   SUBTYPE t_contract_versao_origem IS ifrbde.viw_conf_identificacao_u.contract_versao_origem%TYPE;

   SUBTYPE t_date_created IS t_data;

   SUBTYPE t_user_id_created IS ifrbde.viw_conf_identificacao_u.user_id_created%TYPE;

   SUBTYPE t_date_changed IS t_data;

   SUBTYPE t_user_id_changed IS ifrbde.viw_conf_identificacao_u.user_id_changed%TYPE;

   SUBTYPE t_inactive_ind IS ifrbde.viw_conf_identificacao_u.inactive_ind%TYPE;

   SUBTYPE t_active_date IS t_data;

   TYPE tyt_payable_entity_id IS TABLE OF t_payable_entity_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id IS TABLE OF t_contract_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao IS TABLE OF t_contract_versao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_desc IS TABLE OF t_contract_desc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_status_code IS TABLE OF t_contract_status_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_prev_status_code IS TABLE OF t_contract_prev_status_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_type IS TABLE OF t_contract_type
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_sub_type IS TABLE OF t_contract_sub_type
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_vendor IS TABLE OF t_contract_id_vendor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_codigo_mod_contratacao IS TABLE OF t_codigo_mod_contratacao
      INDEX BY BINARY_INTEGER;

   TYPE tyt_manager_id IS TABLE OF t_manager_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_security_code IS TABLE OF t_security_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code IS TABLE OF t_sistema_origem_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem IS TABLE OF t_contract_versao_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created IS TABLE OF t_date_created
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created IS TABLE OF t_user_id_created
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed IS TABLE OF t_date_changed
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed IS TABLE OF t_user_id_changed
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind IS TABLE OF t_inactive_ind
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date IS TABLE OF t_active_date
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_identificaca (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao
   );

   PROCEDURE stp_exclui_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao
   );

   PROCEDURE stp_inclui_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao,
      vi_contract_desc           IN       t_contract_desc,
      vi_contract_type           IN       t_contract_type,
      vi_contract_sub_type       IN       t_contract_sub_type,
      vi_contract_id_vendor      IN       t_contract_id_vendor,
      vi_codigo_mod_contratacao  IN       t_codigo_mod_contratacao,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created         IN       t_user_id_created
   );

   PROCEDURE stp_altera_conf_identificacao_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id       OUT      tyt_payable_entity_id,
      vo_contract_id             OUT      tyt_contract_id,
      vo_contract_versao         OUT      tyt_contract_versao,
      vo_contract_desc           OUT      tyt_contract_desc,
      vo_contract_status_code    OUT      tyt_contract_status_code,
      vo_contract_prev_status_code OUT    tyt_contract_prev_status_code,
      vo_contract_type           OUT      tyt_contract_type,
      vo_contract_sub_type       OUT      tyt_contract_sub_type,
      vo_contract_id_vendor      OUT      tyt_contract_id_vendor,
      vo_codigo_mod_contratacao  OUT      tyt_codigo_mod_contratacao,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code     OUT      tyt_sistema_origem_code,
      vo_contract_versao_origem  OUT      tyt_contract_versao_origem,
      vo_date_created            OUT      tyt_date_created,
      vo_user_id_created         OUT      tyt_user_id_created,
      vo_date_changed            OUT      tyt_date_changed,
      vo_user_id_changed         OUT      tyt_user_id_changed,
      vo_inactive_ind            OUT      tyt_inactive_ind,
      vo_active_date             OUT      tyt_active_date,
      vi_payable_entity_id       IN       t_payable_entity_id,
      vi_contract_id             IN       t_contract_id,
      vi_contract_versao         IN       t_contract_versao,
      vi_contract_desc           IN       t_contract_desc,
      vi_contract_type           IN       t_contract_type,
      vi_contract_sub_type       IN       t_contract_sub_type,
      vi_contract_id_vendor      IN       t_contract_id_vendor,
      vi_codigo_mod_contratacao  IN       t_codigo_mod_contratacao,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created         IN       t_user_id_created
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_OBJETO_U
   SUBTYPE t_payable_entity_id_obj IS ifrbde.viw_conf_objeto_u.payable_entity_id_obj%TYPE;

   SUBTYPE t_contract_id_obj IS ifrbde.viw_conf_objeto_u.contract_id_obj%TYPE;

   SUBTYPE t_contract_versao_obj IS ifrbde.viw_conf_objeto_u.contract_versao_obj%TYPE;

   SUBTYPE t_objeto_desc IS ifrbde.viw_conf_objeto_u.objeto_desc%TYPE;

   SUBTYPE t_sistema_origem_code_obj IS ifrbde.viw_conf_objeto_u.sistema_origem_code_obj%TYPE;

   SUBTYPE t_contract_versao_origem_obj IS ifrbde.viw_conf_objeto_u.contract_versao_origem_obj%TYPE;

   SUBTYPE t_date_created_obj IS t_data;

   SUBTYPE t_user_id_created_obj IS ifrbde.viw_conf_objeto_u.user_id_created_obj%TYPE;

   SUBTYPE t_date_changed_obj IS t_data;

   SUBTYPE t_user_id_changed_obj IS ifrbde.viw_conf_objeto_u.user_id_changed_obj%TYPE;

   SUBTYPE t_inactive_ind_obj IS ifrbde.viw_conf_objeto_u.inactive_ind_obj%TYPE;

   SUBTYPE t_active_date_obj IS t_data;

   TYPE tyt_payable_entity_id_obj IS TABLE OF t_payable_entity_id_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_obj IS TABLE OF t_contract_id_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_obj IS TABLE OF t_contract_versao_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_objeto_desc IS TABLE OF t_objeto_desc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_obj IS TABLE OF t_sistema_origem_code_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_obj IS TABLE OF t_contract_versao_origem_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_obj IS TABLE OF t_date_created_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_obj IS TABLE OF t_user_id_created_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_obj IS TABLE OF t_date_changed_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_obj IS TABLE OF t_user_id_changed_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_obj IS TABLE OF t_inactive_ind_obj
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_obj IS TABLE OF t_active_date_obj
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj
   );

   PROCEDURE stp_exclui_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj
   );

   PROCEDURE stp_inclui_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_user_id_created_obj     IN       t_user_id_created_obj
   );

   PROCEDURE stp_altera_conf_objeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_obj   OUT      tyt_payable_entity_id_obj,
      vo_contract_id_obj         OUT      tyt_contract_id_obj,
      vo_contract_versao_obj     OUT      tyt_contract_versao_obj,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_sistema_origem_code_obj OUT      tyt_sistema_origem_code_obj,
      vo_contract_versao_origem_obj OUT   tyt_contract_versao_origem_obj,
      vo_date_created_obj        OUT      tyt_date_created_obj,
      vo_user_id_created_obj     OUT      tyt_user_id_created_obj,
      vo_date_changed_obj        OUT      tyt_date_changed_obj,
      vo_user_id_changed_obj     OUT      tyt_user_id_changed_obj,
      vo_inactive_ind_obj        OUT      tyt_inactive_ind_obj,
      vo_active_date_obj         OUT      tyt_active_date_obj,
      vi_payable_entity_id_obj   IN       t_payable_entity_id_obj,
      vi_contract_id_obj         IN       t_contract_id_obj,
      vi_contract_versao_obj     IN       t_contract_versao_obj,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_user_id_created_obj     IN       t_user_id_created_obj
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_DATAS_U
   SUBTYPE t_payable_entity_id_dt IS ifrbde.viw_conf_datas_u.payable_entity_id_dt%TYPE;

   SUBTYPE t_contract_id_dt IS ifrbde.viw_conf_datas_u.contract_id_dt%TYPE;

   SUBTYPE t_contract_versao_dt IS ifrbde.viw_conf_datas_u.contract_versao_dt%TYPE;

   SUBTYPE t_proposta_data IS t_data;

   SUBTYPE t_assinatura_data IS t_data;

   SUBTYPE t_tipo_prazo IS ifrbde.viw_conf_datas_u.tipo_prazo%TYPE;

   SUBTYPE t_quant_prazo IS ifrbde.viw_conf_datas_u.quant_prazo%TYPE;

   SUBTYPE t_entrega_data IS t_data;

   SUBTYPE t_garantia_data IS t_data;

   SUBTYPE t_inicio_data IS t_data;

   SUBTYPE t_termino_prev_data IS t_data;

   SUBTYPE t_termino_data IS t_data;

   SUBTYPE t_sistema_origem_code_dt IS ifrbde.viw_conf_datas_u.sistema_origem_code_dt%TYPE;

   SUBTYPE t_contract_versao_origem_dt IS ifrbde.viw_conf_datas_u.contract_versao_origem_dt%TYPE;

   SUBTYPE t_date_created_dt IS t_data;

   SUBTYPE t_user_id_created_dt IS ifrbde.viw_conf_datas_u.user_id_created_dt%TYPE;

   SUBTYPE t_date_changed_dt IS t_data;

   SUBTYPE t_user_id_changed_dt IS ifrbde.viw_conf_datas_u.user_id_changed_dt%TYPE;

   SUBTYPE t_inactive_ind_dt IS ifrbde.viw_conf_datas_u.inactive_ind_dt%TYPE;

   SUBTYPE t_active_date_dt IS t_data;

   TYPE tyt_payable_entity_id_dt IS TABLE OF t_payable_entity_id_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_dt IS TABLE OF t_contract_id_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_dt IS TABLE OF t_contract_versao_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_proposta_data IS TABLE OF t_proposta_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_assinatura_data IS TABLE OF t_assinatura_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tipo_prazo IS TABLE OF t_tipo_prazo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_quant_prazo IS TABLE OF t_quant_prazo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_entrega_data IS TABLE OF t_entrega_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_garantia_data IS TABLE OF t_garantia_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inicio_data IS TABLE OF t_inicio_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_termino_prev_data IS TABLE OF t_termino_prev_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_termino_data IS TABLE OF t_termino_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_dt IS TABLE OF t_sistema_origem_code_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_dt IS TABLE OF t_contract_versao_origem_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_dt IS TABLE OF t_date_created_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_dt IS TABLE OF t_user_id_created_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_dt IS TABLE OF t_date_changed_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_dt IS TABLE OF t_user_id_changed_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_dt IS TABLE OF t_inactive_ind_dt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_dt IS TABLE OF t_active_date_dt
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt
   );

   PROCEDURE stp_exclui_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt
   );

   PROCEDURE stp_inclui_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt,
      vi_proposta_data           IN       t_proposta_data,
      vi_assinatura_data         IN       t_assinatura_data,
      vi_tipo_prazo              IN       t_tipo_prazo,
      vi_quant_prazo             IN       t_quant_prazo,
      vi_entrega_data            IN       t_entrega_data,
      vi_garantia_data           IN       t_garantia_data,
      vi_inicio_data             IN       t_inicio_data,
      vi_termino_prev_data       IN       t_termino_prev_data,
      vi_termino_data            IN       t_termino_data,
      vi_user_id_created_dt      IN       t_user_id_created_dt
   );

   PROCEDURE stp_altera_conf_datas_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_dt    OUT      tyt_payable_entity_id_dt,
      vo_contract_id_dt          OUT      tyt_contract_id_dt,
      vo_contract_versao_dt      OUT      tyt_contract_versao_dt,
      vo_proposta_data           OUT      tyt_proposta_data,
      vo_assinatura_data         OUT      tyt_assinatura_data,
      vo_tipo_prazo              OUT      tyt_tipo_prazo,
      vo_quant_prazo             OUT      tyt_quant_prazo,
      vo_entrega_data            OUT      tyt_entrega_data,
      vo_garantia_data           OUT      tyt_garantia_data,
      vo_inicio_data             OUT      tyt_inicio_data,
      vo_termino_prev_data       OUT      tyt_termino_prev_data,
      vo_termino_data            OUT      tyt_termino_data,
      vo_sistema_origem_code_dt  OUT      tyt_sistema_origem_code_dt,
      vo_contract_versao_origem_dt OUT    tyt_contract_versao_origem_dt,
      vo_date_created_dt         OUT      tyt_date_created_dt,
      vo_user_id_created_dt      OUT      tyt_user_id_created_dt,
      vo_date_changed_dt         OUT      tyt_date_changed_dt,
      vo_user_id_changed_dt      OUT      tyt_user_id_changed_dt,
      vo_inactive_ind_dt         OUT      tyt_inactive_ind_dt,
      vo_active_date_dt          OUT      tyt_active_date_dt,
      vi_payable_entity_id_dt    IN       t_payable_entity_id_dt,
      vi_contract_id_dt          IN       t_contract_id_dt,
      vi_contract_versao_dt      IN       t_contract_versao_dt,
      vi_proposta_data           IN       t_proposta_data,
      vi_assinatura_data         IN       t_assinatura_data,
      vi_tipo_prazo              IN       t_tipo_prazo,
      vi_quant_prazo             IN       t_quant_prazo,
      vi_entrega_data            IN       t_entrega_data,
      vi_garantia_data           IN       t_garantia_data,
      vi_inicio_data             IN       t_inicio_data,
      vi_termino_prev_data       IN       t_termino_prev_data,
      vi_termino_data            IN       t_termino_data,
      vi_user_id_created_dt      IN       t_user_id_created_dt
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_PARTICIPANTES_U
   SUBTYPE t_payable_entity_id_prc IS ifrbde.viw_conf_participantes_u.payable_entity_id_prc%TYPE;

   SUBTYPE t_contract_id_prc IS ifrbde.viw_conf_participantes_u.contract_id_prc%TYPE;

   SUBTYPE t_contract_versao_prc IS ifrbde.viw_conf_participantes_u.contract_versao_prc%TYPE;

   SUBTYPE t_vendor_id IS ifrbde.viw_conf_participantes_u.vendor_id%TYPE;

   SUBTYPE t_vendor_loc_code IS ifrbde.viw_conf_participantes_u.vendor_loc_code%TYPE;

   SUBTYPE t_addr_fmt IS ifrbde.viw_conf_participantes_u.addr_fmt%TYPE;

   SUBTYPE t_cod_relacao_contrato IS ifrbde.viw_conf_participantes_u.cod_relacao_contrato%TYPE;

   SUBTYPE t_addr_line_1 IS ifrbde.viw_conf_participantes_u.addr_line_1%TYPE;

   SUBTYPE t_com_ddd IS ifrbde.viw_conf_participantes_u.com_ddd%TYPE;

   SUBTYPE t_street_post_office_box_1 IS ifrbde.viw_conf_participantes_u.street_post_office_box_1%TYPE;

   SUBTYPE t_com_tel IS ifrbde.viw_conf_participantes_u.com_tel%TYPE;

   SUBTYPE t_street_post_office_box_2 IS ifrbde.viw_conf_participantes_u.street_post_office_box_2%TYPE;

   SUBTYPE t_com_fax IS ifrbde.viw_conf_participantes_u.com_fax%TYPE;

   SUBTYPE t_city_name IS ifrbde.viw_conf_participantes_u.city_name%TYPE;

   SUBTYPE t_com_email IS ifrbde.viw_conf_participantes_u.com_email%TYPE;

   SUBTYPE t_country_sub_entity_code IS ifrbde.viw_conf_participantes_u.country_sub_entity_code%TYPE;

   SUBTYPE t_postal_code IS ifrbde.viw_conf_participantes_u.postal_code%TYPE;

   SUBTYPE t_country_code IS ifrbde.viw_conf_participantes_u.country_code%TYPE;

   SUBTYPE t_type_of_pmt IS ifrbde.viw_conf_participantes_u.type_of_pmt%TYPE;

   SUBTYPE t_seq_nbr IS ifrbde.viw_conf_participantes_u.seq_nbr%TYPE;

   SUBTYPE t_sistema_origem_code_prc IS ifrbde.viw_conf_participantes_u.sistema_origem_code_prc%TYPE;

   SUBTYPE t_contract_versao_origem_prc IS ifrbde.viw_conf_participantes_u.contract_versao_origem_prc%TYPE;

   SUBTYPE t_date_created_prc IS t_data;

   SUBTYPE t_user_id_created_prc IS ifrbde.viw_conf_participantes_u.user_id_created_prc%TYPE;

   SUBTYPE t_date_changed_prc IS t_data;

   SUBTYPE t_user_id_changed_prc IS ifrbde.viw_conf_participantes_u.user_id_changed_prc%TYPE;

   SUBTYPE t_inactive_ind_prc IS ifrbde.viw_conf_participantes_u.inactive_ind_prc%TYPE;

   SUBTYPE t_active_date_prc IS t_data;

   TYPE tyt_payable_entity_id_prc IS TABLE OF t_payable_entity_id_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_prc IS TABLE OF t_contract_id_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_prc IS TABLE OF t_contract_versao_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_id IS TABLE OF t_vendor_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_loc_code IS TABLE OF t_vendor_loc_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_addr_fmt IS TABLE OF t_addr_fmt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cod_relacao_contrato IS TABLE OF t_cod_relacao_contrato
      INDEX BY BINARY_INTEGER;

   TYPE tyt_addr_line_1 IS TABLE OF t_addr_line_1
      INDEX BY BINARY_INTEGER;

   TYPE tyt_com_ddd IS TABLE OF t_com_ddd
      INDEX BY BINARY_INTEGER;

   TYPE tyt_street_post_office_box_1 IS TABLE OF t_street_post_office_box_1
      INDEX BY BINARY_INTEGER;

   TYPE tyt_com_tel IS TABLE OF t_com_tel
      INDEX BY BINARY_INTEGER;

   TYPE tyt_street_post_office_box_2 IS TABLE OF t_street_post_office_box_2
      INDEX BY BINARY_INTEGER;

   TYPE tyt_com_fax IS TABLE OF t_com_fax
      INDEX BY BINARY_INTEGER;

   TYPE tyt_city_name IS TABLE OF t_city_name
      INDEX BY BINARY_INTEGER;

   TYPE tyt_com_email IS TABLE OF t_com_email
      INDEX BY BINARY_INTEGER;

   TYPE tyt_country_sub_entity_code IS TABLE OF t_country_sub_entity_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_postal_code IS TABLE OF t_postal_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_country_code IS TABLE OF t_country_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_type_of_pmt IS TABLE OF t_type_of_pmt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_seq_nbr IS TABLE OF t_seq_nbr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_prc IS TABLE OF t_sistema_origem_code_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_prc IS TABLE OF t_contract_versao_origem_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_prc IS TABLE OF t_date_created_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_prc IS TABLE OF t_user_id_created_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_prc IS TABLE OF t_date_changed_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_prc IS TABLE OF t_user_id_changed_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_prc IS TABLE OF t_inactive_ind_prc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_prc IS TABLE OF t_active_date_prc
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_participante (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code
   );

   PROCEDURE stp_exclui_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code
   );

   PROCEDURE stp_inclui_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_cod_relacao_contrato    IN       t_cod_relacao_contrato,
      vi_addr_line_1             IN       t_addr_line_1,
      vi_com_ddd                 IN       t_com_ddd,
      vi_street_post_office_box_1 IN      t_street_post_office_box_1,
      vi_com_tel                 IN       t_com_tel,
      vi_street_post_office_box_2 IN      t_street_post_office_box_2,
      vi_com_fax                 IN       t_com_fax,
      vi_city_name               IN       t_city_name,
      vi_com_email               IN       t_com_email,
      vi_country_sub_entity_code IN       t_country_sub_entity_code,
      vi_postal_code             IN       t_postal_code,
      vi_country_code            IN       t_country_code,
      vi_type_of_pmt             IN       t_type_of_pmt,
      vi_seq_nbr                 IN       t_seq_nbr,
      vi_user_id_created_prc     IN       t_user_id_created_prc
   );

   PROCEDURE stp_altera_conf_participantes_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_prc   OUT      tyt_payable_entity_id_prc,
      vo_contract_id_prc         OUT      tyt_contract_id_prc,
      vo_contract_versao_prc     OUT      tyt_contract_versao_prc,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_addr_fmt                OUT      tyt_addr_fmt,
      vo_cod_relacao_contrato    OUT      tyt_cod_relacao_contrato,
      vo_addr_line_1             OUT      tyt_addr_line_1,
      vo_com_ddd                 OUT      tyt_com_ddd,
      vo_street_post_office_box_1 OUT     tyt_street_post_office_box_1,
      vo_com_tel                 OUT      tyt_com_tel,
      vo_street_post_office_box_2 OUT     tyt_street_post_office_box_2,
      vo_com_fax                 OUT      tyt_com_fax,
      vo_city_name               OUT      tyt_city_name,
      vo_com_email               OUT      tyt_com_email,
      vo_country_sub_entity_code OUT      tyt_country_sub_entity_code,
      vo_postal_code             OUT      tyt_postal_code,
      vo_country_code            OUT      tyt_country_code,
      vo_type_of_pmt             OUT      tyt_type_of_pmt,
      vo_seq_nbr                 OUT      tyt_seq_nbr,
      vo_sistema_origem_code_prc OUT      tyt_sistema_origem_code_prc,
      vo_contract_versao_origem_prc OUT   tyt_contract_versao_origem_prc,
      vo_date_created_prc        OUT      tyt_date_created_prc,
      vo_user_id_created_prc     OUT      tyt_user_id_created_prc,
      vo_date_changed_prc        OUT      tyt_date_changed_prc,
      vo_user_id_changed_prc     OUT      tyt_user_id_changed_prc,
      vo_inactive_ind_prc        OUT      tyt_inactive_ind_prc,
      vo_active_date_prc         OUT      tyt_active_date_prc,
      vi_payable_entity_id_prc   IN       t_payable_entity_id_prc,
      vi_contract_id_prc         IN       t_contract_id_prc,
      vi_contract_versao_prc     IN       t_contract_versao_prc,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_cod_relacao_contrato    IN       t_cod_relacao_contrato,
      vi_addr_line_1             IN       t_addr_line_1,
      vi_com_ddd                 IN       t_com_ddd,
      vi_street_post_office_box_1 IN      t_street_post_office_box_1,
      vi_com_tel                 IN       t_com_tel,
      vi_street_post_office_box_2 IN      t_street_post_office_box_2,
      vi_com_fax                 IN       t_com_fax,
      vi_city_name               IN       t_city_name,
      vi_com_email               IN       t_com_email,
      vi_country_sub_entity_code IN       t_country_sub_entity_code,
      vi_postal_code             IN       t_postal_code,
      vi_country_code            IN       t_country_code,
      vi_type_of_pmt             IN       t_type_of_pmt,
      vi_seq_nbr                 IN       t_seq_nbr,
      vi_user_id_created_prc     IN       t_user_id_created_prc
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_TERMO_U
   SUBTYPE t_payable_entity_id_ter IS ifrbde.viw_conf_termo_u.payable_entity_id_ter%TYPE;

   SUBTYPE t_contract_id_ter IS ifrbde.viw_conf_termo_u.contract_id_ter%TYPE;

   SUBTYPE t_contract_versao_ter IS ifrbde.viw_conf_termo_u.contract_versao_ter%TYPE;

   SUBTYPE t_contract_numero_termo IS ifrbde.viw_conf_termo_u.contract_numero_termo%TYPE;

   SUBTYPE t_data_termo IS t_data;

--   SUBTYPE t_objeto_desc IS ifrbde.viw_conf_termo_u.objeto_desc%TYPE;

      SUBTYPE t_publicacao_data IS t_data;

      SUBTYPE t_publicacao_numero_dou IS ifrbde.viw_conf_termo_u.publicacao_numero_dou%TYPE;

      SUBTYPE t_publicacao_secao IS ifrbde.viw_conf_termo_u.publicacao_secao%TYPE;

      SUBTYPE t_publicacao_pagina IS ifrbde.viw_conf_termo_u.publicacao_pagina%TYPE;
   SUBTYPE t_user_fld_3 IS ifrbde.viw_conf_termo_u.user_fld_3%TYPE;

   SUBTYPE t_user_fld_4 IS ifrbde.viw_conf_termo_u.user_fld_4%TYPE;

   SUBTYPE t_tipo_termo IS ifrbde.viw_conf_termo_u.tipo_termo%TYPE;

   SUBTYPE t_sistema_origem_code_ter IS ifrbde.viw_conf_termo_u.sistema_origem_code_ter%TYPE;

   SUBTYPE t_contract_versao_origem_ter IS ifrbde.viw_conf_termo_u.contract_versao_origem_ter%TYPE;

   SUBTYPE t_date_created_ter IS t_data;

   SUBTYPE t_user_id_created_ter IS ifrbde.viw_conf_termo_u.user_id_created_ter%TYPE;

   SUBTYPE t_date_changed_ter IS t_data;

   SUBTYPE t_user_id_changed_ter IS ifrbde.viw_conf_termo_u.user_id_changed_ter%TYPE;

   SUBTYPE t_inactive_ind_ter IS ifrbde.viw_conf_termo_u.inactive_ind_ter%TYPE;

   SUBTYPE t_active_date_ter IS t_data;

   TYPE tyt_payable_entity_id_ter IS TABLE OF t_payable_entity_id_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_ter IS TABLE OF t_contract_id_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_ter IS TABLE OF t_contract_versao_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_numero_termo IS TABLE OF t_contract_numero_termo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_data_termo IS TABLE OF t_data_termo
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_objeto_desc IS TABLE OF t_objeto_desc
--      INDEX BY BINARY_INTEGER;

     TYPE tyt_publicacao_data IS TABLE OF t_publicacao_data
      INDEX BY BINARY_INTEGER;

   TYPE tyt_publicacao_numero_dou IS TABLE OF t_publicacao_numero_dou
      INDEX BY BINARY_INTEGER;

     TYPE tyt_publicacao_secao IS TABLE OF t_publicacao_secao
      INDEX BY BINARY_INTEGER;

      TYPE tyt_publicacao_pagina IS TABLE OF t_publicacao_pagina
      INDEX BY BINARY_INTEGER;
   TYPE tyt_user_fld_3 IS TABLE OF t_user_fld_3
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_fld_4 IS TABLE OF t_user_fld_4
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tipo_termo IS TABLE OF t_tipo_termo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_ter IS TABLE OF t_sistema_origem_code_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_ter IS TABLE OF t_contract_versao_origem_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_ter IS TABLE OF t_date_created_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_ter IS TABLE OF t_user_id_created_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_ter IS TABLE OF t_date_changed_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_ter IS TABLE OF t_user_id_changed_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_ter IS TABLE OF t_inactive_ind_ter
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_ter IS TABLE OF t_active_date_ter
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter
   );

   PROCEDURE stp_exclui_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter
   );

   PROCEDURE stp_inclui_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter,
      vi_contract_numero_termo   IN       t_contract_numero_termo,
      vi_data_termo              IN       t_data_termo,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_publicacao_data         IN       t_publicacao_data,
      vi_publicacao_numero_dou   IN       t_publicacao_numero_dou,
      vi_publicacao_secao        IN       t_publicacao_secao,
      vi_publicacao_pagina       IN       t_publicacao_pagina,
      vi_user_fld_3              IN       t_user_fld_3,
      vi_user_fld_4              IN       t_user_fld_4,
      vi_tipo_termo              IN       t_tipo_termo,
      vi_user_id_created_ter     IN       t_user_id_created_ter
   );

   PROCEDURE stp_altera_conf_termo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ter   OUT      tyt_payable_entity_id_ter,
      vo_contract_id_ter         OUT      tyt_contract_id_ter,
      vo_contract_versao_ter     OUT      tyt_contract_versao_ter,
      vo_contract_numero_termo   OUT      tyt_contract_numero_termo,
      vo_data_termo              OUT      tyt_data_termo,
      vo_objeto_desc             OUT      tyt_objeto_desc,
      vo_publicacao_data         OUT      tyt_publicacao_data,
      vo_publicacao_numero_dou   OUT      tyt_publicacao_numero_dou,
      vo_publicacao_secao        OUT      tyt_publicacao_secao,
      vo_publicacao_pagina       OUT      tyt_publicacao_pagina,
      vo_user_fld_3              OUT      tyt_user_fld_3,
      vo_user_fld_4              OUT      tyt_user_fld_4,
      vo_tipo_termo              OUT      tyt_tipo_termo,
      vo_sistema_origem_code_ter OUT      tyt_sistema_origem_code_ter,
      vo_contract_versao_origem_ter OUT   tyt_contract_versao_origem_ter,
      vo_date_created_ter        OUT      tyt_date_created_ter,
      vo_user_id_created_ter     OUT      tyt_user_id_created_ter,
      vo_date_changed_ter        OUT      tyt_date_changed_ter,
      vo_user_id_changed_ter     OUT      tyt_user_id_changed_ter,
      vo_inactive_ind_ter        OUT      tyt_inactive_ind_ter,
      vo_active_date_ter         OUT      tyt_active_date_ter,
      vi_payable_entity_id_ter   IN       t_payable_entity_id_ter,
      vi_contract_id_ter         IN       t_contract_id_ter,
      vi_contract_versao_ter     IN       t_contract_versao_ter,
      vi_contract_numero_termo   IN       t_contract_numero_termo,
      vi_data_termo              IN       t_data_termo,
      vi_objeto_desc             IN       t_objeto_desc,
      vi_publicacao_data         IN       t_publicacao_data,
      vi_publicacao_numero_dou   IN       t_publicacao_numero_dou,
      vi_publicacao_secao        IN       t_publicacao_secao,
      vi_publicacao_pagina       IN       t_publicacao_pagina,
      vi_user_fld_3              IN       t_user_fld_3,
      vi_user_fld_4              IN       t_user_fld_4,
      vi_tipo_termo              IN       t_tipo_termo,
      vi_user_id_created_ter     IN       t_user_id_created_ter
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_ITEM_IDENT_U
   SUBTYPE t_payable_entity_id_iid IS ifrbde.viw_conf_item_ident_u.payable_entity_id_iid%TYPE;

   SUBTYPE t_contract_id_iid IS ifrbde.viw_conf_item_ident_u.contract_id_iid%TYPE;

   SUBTYPE t_contract_versao_iid IS ifrbde.viw_conf_item_ident_u.contract_versao_iid%TYPE;

   SUBTYPE t_seq_item IS ifrbde.viw_conf_item_ident_u.seq_item%TYPE;

   SUBTYPE t_qty IS ifrbde.viw_conf_item_ident_u.qty%TYPE;

   SUBTYPE t_unit_of_measure IS ifrbde.viw_conf_item_ident_u.unit_of_measure%TYPE;

   SUBTYPE t_item_id IS ifrbde.viw_conf_item_ident_u.item_id%TYPE;

   SUBTYPE t_item_descp IS ifrbde.viw_conf_item_ident_u.item_descp%TYPE;

   SUBTYPE t_sistema_origem_code_iid IS ifrbde.viw_conf_item_ident_u.sistema_origem_code_iid%TYPE;

   SUBTYPE t_contract_versao_origem_iid IS ifrbde.viw_conf_item_ident_u.contract_versao_origem_iid%TYPE;

   SUBTYPE t_date_created_iid IS t_data;

   SUBTYPE t_user_id_created_iid IS ifrbde.viw_conf_item_ident_u.user_id_created_iid%TYPE;

   SUBTYPE t_date_changed_iid IS t_data;

   SUBTYPE t_user_id_changed_iid IS ifrbde.viw_conf_item_ident_u.user_id_changed_iid%TYPE;

   SUBTYPE t_inactive_ind_iid IS ifrbde.viw_conf_item_ident_u.inactive_ind_iid%TYPE;

   SUBTYPE t_active_date_iid IS t_data;

   TYPE tyt_payable_entity_id_iid IS TABLE OF t_payable_entity_id_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_iid IS TABLE OF t_contract_id_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_iid IS TABLE OF t_contract_versao_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_seq_item IS TABLE OF t_seq_item
      INDEX BY BINARY_INTEGER;

   TYPE tyt_qty IS TABLE OF t_qty
      INDEX BY BINARY_INTEGER;

   TYPE tyt_unit_of_measure IS TABLE OF t_unit_of_measure
      INDEX BY BINARY_INTEGER;

   TYPE tyt_item_id IS TABLE OF t_item_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_item_descp IS TABLE OF t_item_descp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_iid IS TABLE OF t_sistema_origem_code_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_iid IS TABLE OF t_contract_versao_origem_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_iid IS TABLE OF t_date_created_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_iid IS TABLE OF t_user_id_created_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_iid IS TABLE OF t_date_changed_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_iid IS TABLE OF t_user_id_changed_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_iid IS TABLE OF t_inactive_ind_iid
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_iid IS TABLE OF t_active_date_iid
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid
   );

   PROCEDURE stp_exclui_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid
   );

   PROCEDURE stp_inclui_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid,
      vi_seq_item                IN       t_seq_item,
      vi_qty                     IN       t_qty,
      vi_unit_of_measure         IN       t_unit_of_measure,
      vi_item_id                 IN       t_item_id,
      vi_item_descp              IN       t_item_descp,
      vi_user_id_created_iid     IN       t_user_id_created_iid
   );

   PROCEDURE stp_altera_conf_item_ident_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_iid   OUT      tyt_payable_entity_id_iid,
      vo_contract_id_iid         OUT      tyt_contract_id_iid,
      vo_contract_versao_iid     OUT      tyt_contract_versao_iid,
      vo_seq_item                OUT      tyt_seq_item,
      vo_qty                     OUT      tyt_qty,
      vo_unit_of_measure         OUT      tyt_unit_of_measure,
      vo_item_id                 OUT      tyt_item_id,
      vo_item_descp              OUT      tyt_item_descp,
      vo_sistema_origem_code_iid OUT      tyt_sistema_origem_code_iid,
      vo_contract_versao_origem_iid OUT   tyt_contract_versao_origem_iid,
      vo_date_created_iid        OUT      tyt_date_created_iid,
      vo_user_id_created_iid     OUT      tyt_user_id_created_iid,
      vo_date_changed_iid        OUT      tyt_date_changed_iid,
      vo_user_id_changed_iid     OUT      tyt_user_id_changed_iid,
      vo_inactive_ind_iid        OUT      tyt_inactive_ind_iid,
      vo_active_date_iid         OUT      tyt_active_date_iid,
      vi_payable_entity_id_iid   IN       t_payable_entity_id_iid,
      vi_contract_id_iid         IN       t_contract_id_iid,
      vi_contract_versao_iid     IN       t_contract_versao_iid,
      vi_seq_item                IN       t_seq_item,
      vi_qty                     IN       t_qty,
      vi_unit_of_measure         IN       t_unit_of_measure,
      vi_item_id                 IN       t_item_id,
      vi_item_descp              IN       t_item_descp,
      vi_user_id_created_iid     IN       t_user_id_created_iid
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_ITEM_PROJETO_U
   SUBTYPE t_payable_entity_id_ipr IS ifrbde.viw_conf_item_projeto_u.payable_entity_id_ipr%TYPE;

   SUBTYPE t_contract_id_ipr IS ifrbde.viw_conf_item_projeto_u.contract_id_ipr%TYPE;

   SUBTYPE t_contract_versao_ipr IS ifrbde.viw_conf_item_projeto_u.contract_versao_ipr%TYPE;

--   SUBTYPE t_seq_item IS ifrbde.viw_conf_item_projeto_u.seq_item%TYPE;
   SUBTYPE t_project_ind_automatico IS ifrbde.viw_conf_item_projeto_u.project_ind_automatico%TYPE;

   SUBTYPE t_project_entity_id IS ifrbde.viw_conf_item_projeto_u.project_entity_id%TYPE;

   SUBTYPE t_project_id IS ifrbde.viw_conf_item_projeto_u.project_id%TYPE;

   SUBTYPE t_component_id IS ifrbde.viw_conf_item_projeto_u.component_id%TYPE;

   SUBTYPE t_cost_element_id IS ifrbde.viw_conf_item_projeto_u.cost_element_id%TYPE;

--   SUBTYPE t_manager_id IS ifrbde.viw_conf_item_projeto_u.manager_id%TYPE;

   --   SUBTYPE t_security_code IS ifrbde.viw_conf_item_projeto_u.security_code%TYPE;
   SUBTYPE t_sistema_origem_code_ipr IS ifrbde.viw_conf_item_projeto_u.sistema_origem_code_ipr%TYPE;

   SUBTYPE t_contract_versao_origem_ipr IS ifrbde.viw_conf_item_projeto_u.contract_versao_origem_ipr%TYPE;

   SUBTYPE t_date_created_ipr IS t_data;

   SUBTYPE t_user_id_created_ipr IS ifrbde.viw_conf_item_projeto_u.user_id_created_ipr%TYPE;

   SUBTYPE t_date_changed_ipr IS t_data;

   SUBTYPE t_user_id_changed_ipr IS ifrbde.viw_conf_item_projeto_u.user_id_changed_ipr%TYPE;

   SUBTYPE t_inactive_ind_ipr IS ifrbde.viw_conf_item_projeto_u.inactive_ind_ipr%TYPE;

   SUBTYPE t_active_date_ipr IS t_data;

   TYPE tyt_payable_entity_id_ipr IS TABLE OF t_payable_entity_id_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_ipr IS TABLE OF t_contract_id_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_ipr IS TABLE OF t_contract_versao_ipr
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_seq_item IS TABLE OF t_seq_item
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_project_ind_automatico IS TABLE OF t_project_ind_automatico
      INDEX BY BINARY_INTEGER;

   TYPE tyt_project_entity_id IS TABLE OF t_project_entity_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_project_id IS TABLE OF t_project_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_component_id IS TABLE OF t_component_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_cost_element_id IS TABLE OF t_cost_element_id
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_manager_id IS TABLE OF t_manager_id
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_security_code IS TABLE OF t_security_code
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_sistema_origem_code_ipr IS TABLE OF t_sistema_origem_code_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_ipr IS TABLE OF t_contract_versao_origem_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_ipr IS TABLE OF t_date_created_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_ipr IS TABLE OF t_user_id_created_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_ipr IS TABLE OF t_date_changed_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_ipr IS TABLE OF t_user_id_changed_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_ipr IS TABLE OF t_inactive_ind_ipr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_ipr IS TABLE OF t_active_date_ipr
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_item_projeto (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr
   );

   PROCEDURE stp_exclui_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr
   );

   PROCEDURE stp_inclui_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr,
      vi_seq_item                IN       t_seq_item,
      vi_project_ind_automatico  IN       t_project_ind_automatico,
      vi_project_entity_id       IN       t_project_entity_id,
      vi_project_id              IN       t_project_id,
      vi_component_id            IN       t_component_id,
      vi_cost_element_id         IN       t_cost_element_id,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created_ipr     IN       t_user_id_created_ipr
   );

   PROCEDURE stp_altera_conf_item_projeto_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ipr   OUT      tyt_payable_entity_id_ipr,
      vo_contract_id_ipr         OUT      tyt_contract_id_ipr,
      vo_contract_versao_ipr     OUT      tyt_contract_versao_ipr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_project_ind_automatico  OUT      tyt_project_ind_automatico,
      vo_project_entity_id       OUT      tyt_project_entity_id,
      vo_project_id              OUT      tyt_project_id,
      vo_component_id            OUT      tyt_component_id,
      vo_cost_element_id         OUT      tyt_cost_element_id,
      vo_manager_id              OUT      tyt_manager_id,
      vo_security_code           OUT      tyt_security_code,
      vo_sistema_origem_code_ipr OUT      tyt_sistema_origem_code_ipr,
      vo_contract_versao_origem_ipr OUT   tyt_contract_versao_origem_ipr,
      vo_date_created_ipr        OUT      tyt_date_created_ipr,
      vo_user_id_created_ipr     OUT      tyt_user_id_created_ipr,
      vo_date_changed_ipr        OUT      tyt_date_changed_ipr,
      vo_user_id_changed_ipr     OUT      tyt_user_id_changed_ipr,
      vo_inactive_ind_ipr        OUT      tyt_inactive_ind_ipr,
      vo_active_date_ipr         OUT      tyt_active_date_ipr,
      vi_payable_entity_id_ipr   IN       t_payable_entity_id_ipr,
      vi_contract_id_ipr         IN       t_contract_id_ipr,
      vi_contract_versao_ipr     IN       t_contract_versao_ipr,
      vi_seq_item                IN       t_seq_item,
      vi_project_ind_automatico  IN       t_project_ind_automatico,
      vi_project_entity_id       IN       t_project_entity_id,
      vi_project_id              IN       t_project_id,
      vi_component_id            IN       t_component_id,
      vi_cost_element_id         IN       t_cost_element_id,
      vi_manager_id              IN       t_manager_id,
      vi_security_code           IN       t_security_code,
      vi_user_id_created_ipr     IN       t_user_id_created_ipr
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_ITEM_ACCT_DISTIN_U
   SUBTYPE t_payable_entity_id_icc IS ifrbde.viw_conf_item_acct_distin_u.payable_entity_id_icc%TYPE;

   SUBTYPE t_contract_id_icc IS ifrbde.viw_conf_item_acct_distin_u.contract_id_icc%TYPE;

   SUBTYPE t_contract_versao_icc IS ifrbde.viw_conf_item_acct_distin_u.contract_versao_icc%TYPE;

--   SUBTYPE t_seq_item IS IFRBDE.viw_conf_item_acct_distin_u.seq_item%TYPE;
   SUBTYPE t_type_account_dist IS ifrbde.viw_conf_item_acct_distin_u.type_account_dist%TYPE;

   SUBTYPE t_ldr_entity_id IS ifrbde.viw_conf_item_acct_distin_u.ldr_entity_id%TYPE;

   SUBTYPE t_dependencia IS ifrbde.viw_conf_item_acct_distin_u.dependencia%TYPE;

   SUBTYPE t_conta IS ifrbde.viw_conf_item_acct_distin_u.conta%TYPE;

   SUBTYPE t_programa IS ifrbde.viw_conf_item_acct_distin_u.programa%TYPE;

   SUBTYPE t_projeto IS ifrbde.viw_conf_item_acct_distin_u.projeto%TYPE;

   SUBTYPE t_custo IS ifrbde.viw_conf_item_acct_distin_u.custo%TYPE;

   SUBTYPE t_int_tipo_distr IS ifrbde.viw_conf_item_acct_distin_u.int_tipo_distr%TYPE;

   SUBTYPE t_per_valor_distr IS ifrbde.viw_conf_item_acct_distin_u.per_valor_distr%TYPE;

   SUBTYPE t_sistema_origem_code_icc IS ifrbde.viw_conf_item_acct_distin_u.sistema_origem_code_icc%TYPE;

   SUBTYPE t_contract_versao_origem_icc IS ifrbde.viw_conf_item_acct_distin_u.contract_versao_origem_icc%TYPE;

   SUBTYPE t_date_created_icc IS t_data;

   SUBTYPE t_user_id_created_icc IS ifrbde.viw_conf_item_acct_distin_u.user_id_created_icc%TYPE;

   SUBTYPE t_date_changed_icc IS t_data;

   SUBTYPE t_user_id_changed_icc IS ifrbde.viw_conf_item_acct_distin_u.user_id_changed_icc%TYPE;

   SUBTYPE t_inactive_ind_icc IS ifrbde.viw_conf_item_acct_distin_u.inactive_ind_icc%TYPE;

   SUBTYPE t_active_date_icc IS t_data;

   TYPE tyt_payable_entity_id_icc IS TABLE OF t_payable_entity_id_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_icc IS TABLE OF t_contract_id_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_icc IS TABLE OF t_contract_versao_icc
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_seq_item IS TABLE OF t_seq_item
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_type_account_dist IS TABLE OF t_type_account_dist
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ldr_entity_id IS TABLE OF t_ldr_entity_id
      INDEX BY BINARY_INTEGER;

   TYPE tyt_dependencia IS TABLE OF t_dependencia
      INDEX BY BINARY_INTEGER;

   TYPE tyt_conta IS TABLE OF t_conta
      INDEX BY BINARY_INTEGER;

   TYPE tyt_programa IS TABLE OF t_programa
      INDEX BY BINARY_INTEGER;

   TYPE tyt_projeto IS TABLE OF t_projeto
      INDEX BY BINARY_INTEGER;

   TYPE tyt_custo IS TABLE OF t_custo
      INDEX BY BINARY_INTEGER;

   TYPE tyt_int_tipo_distr IS TABLE OF t_int_tipo_distr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_per_valor_distr IS TABLE OF t_per_valor_distr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_icc IS TABLE OF t_sistema_origem_code_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_icc IS TABLE OF t_contract_versao_origem_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_icc IS TABLE OF t_date_created_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_icc IS TABLE OF t_user_id_created_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_icc IS TABLE OF t_date_changed_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_icc IS TABLE OF t_user_id_changed_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_icc IS TABLE OF t_inactive_ind_icc
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_icc IS TABLE OF t_active_date_icc
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_item_acct_di (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta
   );

   PROCEDURE stp_exclui_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta
   );

   PROCEDURE stp_inclui_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_seq_item                IN       t_seq_item,
      vi_type_account_dist       IN       t_type_account_dist,
      vi_ldr_entity_id           IN       t_ldr_entity_id,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta,
      vi_programa                IN       t_programa,
      vi_projeto                 IN       t_projeto,
      vi_custo                   IN       t_custo,
      vi_int_tipo_distr          IN       t_int_tipo_distr,
      vi_per_valor_distr         IN       t_per_valor_distr,
      vi_user_id_created_icc     IN       t_user_id_created_icc
   );

   PROCEDURE stp_altera_conf_item_acct_dist (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icc   OUT      tyt_payable_entity_id_icc,
      vo_contract_id_icc         OUT      tyt_contract_id_icc,
      vo_contract_versao_icc     OUT      tyt_contract_versao_icc,
      vo_seq_item                OUT      tyt_seq_item,
      vo_type_account_dist       OUT      tyt_type_account_dist,
      vo_ldr_entity_id           OUT      tyt_ldr_entity_id,
      vo_dependencia             OUT      tyt_dependencia,
      vo_conta                   OUT      tyt_conta,
      vo_programa                OUT      tyt_programa,
      vo_projeto                 OUT      tyt_projeto,
      vo_custo                   OUT      tyt_custo,
      vo_int_tipo_distr          OUT      tyt_int_tipo_distr,
      vo_per_valor_distr         OUT      tyt_per_valor_distr,
      vo_sistema_origem_code_icc OUT      tyt_sistema_origem_code_icc,
      vo_contract_versao_origem_icc OUT   tyt_contract_versao_origem_icc,
      vo_date_created_icc        OUT      tyt_date_created_icc,
      vo_user_id_created_icc     OUT      tyt_user_id_created_icc,
      vo_date_changed_icc        OUT      tyt_date_changed_icc,
      vo_user_id_changed_icc     OUT      tyt_user_id_changed_icc,
      vo_inactive_ind_icc        OUT      tyt_inactive_ind_icc,
      vo_active_date_icc         OUT      tyt_active_date_icc,
      vi_payable_entity_id_icc   IN       t_payable_entity_id_icc,
      vi_contract_id_icc         IN       t_contract_id_icc,
      vi_contract_versao_icc     IN       t_contract_versao_icc,
      vi_seq_item                IN       t_seq_item,
      vi_type_account_dist       IN       t_type_account_dist,
      vi_ldr_entity_id           IN       t_ldr_entity_id,
      vi_dependencia             IN       t_dependencia,
      vi_conta                   IN       t_conta,
      vi_programa                IN       t_programa,
      vi_projeto                 IN       t_projeto,
      vi_custo                   IN       t_custo,
      vi_int_tipo_distr          IN       t_int_tipo_distr,
      vi_per_valor_distr         IN       t_per_valor_distr,
      vi_user_id_created_icc     IN       t_user_id_created_icc
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_ITEM_RESUMO_U
   SUBTYPE t_payable_entity_id_ire IS ifrbde.viw_conf_item_resumo_u.payable_entity_id_ire%TYPE;

   SUBTYPE t_contract_id_ire IS ifrbde.viw_conf_item_resumo_u.contract_id_ire%TYPE;

   SUBTYPE t_contract_versao_ire IS ifrbde.viw_conf_item_resumo_u.contract_versao_ire%TYPE;

--   SUBTYPE t_seq_item IS ifrbde.viw_conf_item_resumo_u.seq_item%TYPE;
   SUBTYPE t_codigo_resumo_valor IS ifrbde.viw_conf_item_resumo_u.codigo_resumo_valor%TYPE;

   SUBTYPE t_tipo_valor IS ifrbde.viw_conf_item_resumo_u.tipo_valor%TYPE;

   SUBTYPE t_curr_code IS ifrbde.viw_conf_item_resumo_u.curr_code%TYPE;

   SUBTYPE t_curr_code_secdy IS ifrbde.viw_conf_item_resumo_u.curr_code_secdy%TYPE;

   SUBTYPE t_ind_curr_code_controle IS ifrbde.viw_conf_item_resumo_u.ind_curr_code_controle%TYPE;

   SUBTYPE t_prim_amt IS ifrbde.viw_conf_item_resumo_u.prim_amt%TYPE;

   SUBTYPE t_secdy_amt IS ifrbde.viw_conf_item_resumo_u.secdy_amt%TYPE;

   SUBTYPE t_data_ultimo_reajuste IS t_data;

   SUBTYPE t_data_prox_reajuste IS t_data;

   SUBTYPE t_sistema_origem_code_ire IS ifrbde.viw_conf_item_resumo_u.sistema_origem_code_ire%TYPE;

   SUBTYPE t_contract_versao_origem_ire IS ifrbde.viw_conf_item_resumo_u.contract_versao_origem_ire%TYPE;

   SUBTYPE t_date_created_ire IS t_data;

   SUBTYPE t_user_id_created_ire IS ifrbde.viw_conf_item_resumo_u.user_id_created_ire%TYPE;

   SUBTYPE t_date_changed_ire IS t_data;

   SUBTYPE t_user_id_changed_ire IS ifrbde.viw_conf_item_resumo_u.user_id_changed_ire%TYPE;

   SUBTYPE t_inactive_ind_ire IS ifrbde.viw_conf_item_resumo_u.inactive_ind_ire%TYPE;

   SUBTYPE t_active_date_ire IS t_data;

   TYPE tyt_payable_entity_id_ire IS TABLE OF t_payable_entity_id_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_ire IS TABLE OF t_contract_id_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_ire IS TABLE OF t_contract_versao_ire
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_seq_item IS TABLE OF t_seq_item
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_codigo_resumo_valor IS TABLE OF t_codigo_resumo_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_tipo_valor IS TABLE OF t_tipo_valor
      INDEX BY BINARY_INTEGER;

   TYPE tyt_curr_code IS TABLE OF t_curr_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_curr_code_secdy IS TABLE OF t_curr_code_secdy
      INDEX BY BINARY_INTEGER;

   TYPE tyt_ind_curr_code_controle IS TABLE OF t_ind_curr_code_controle
      INDEX BY BINARY_INTEGER;

   TYPE tyt_prim_amt IS TABLE OF t_prim_amt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_secdy_amt IS TABLE OF t_secdy_amt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_data_ultimo_reajuste IS TABLE OF t_data_ultimo_reajuste
      INDEX BY BINARY_INTEGER;

   TYPE tyt_data_prox_reajuste IS TABLE OF t_data_prox_reajuste
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_ire IS TABLE OF t_sistema_origem_code_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_ire IS TABLE OF t_contract_versao_origem_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_ire IS TABLE OF t_date_created_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_ire IS TABLE OF t_user_id_created_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_ire IS TABLE OF t_date_changed_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_ire IS TABLE OF t_user_id_changed_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_ire IS TABLE OF t_inactive_ind_ire
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_ire IS TABLE OF t_active_date_ire
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_item_resumo_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire
   );

   PROCEDURE stp_exclui_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire
   );

   PROCEDURE stp_inclui_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_curr_code               IN       t_curr_code,
      vi_curr_code_secdy         IN       t_curr_code_secdy,
      vi_ind_curr_code_controle  IN       t_ind_curr_code_controle,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_data_ultimo_reajuste    IN       t_data_ultimo_reajuste,
      vi_data_prox_reajuste      IN       t_data_prox_reajuste,
      vi_user_id_created_ire     IN       t_user_id_created_ire
   );

   PROCEDURE stp_altera_conf_item_resumo_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_ire   OUT      tyt_payable_entity_id_ire,
      vo_contract_id_ire         OUT      tyt_contract_id_ire,
      vo_contract_versao_ire     OUT      tyt_contract_versao_ire,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_curr_code               OUT      tyt_curr_code,
      vo_curr_code_secdy         OUT      tyt_curr_code_secdy,
      vo_ind_curr_code_controle  OUT      tyt_ind_curr_code_controle,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_data_ultimo_reajuste    OUT      tyt_data_ultimo_reajuste,
      vo_data_prox_reajuste      OUT      tyt_data_prox_reajuste,
      vo_sistema_origem_code_ire OUT      tyt_sistema_origem_code_ire,
      vo_contract_versao_origem_ire OUT   tyt_contract_versao_origem_ire,
      vo_date_created_ire        OUT      tyt_date_created_ire,
      vo_user_id_created_ire     OUT      tyt_user_id_created_ire,
      vo_date_changed_ire        OUT      tyt_date_changed_ire,
      vo_user_id_changed_ire     OUT      tyt_user_id_changed_ire,
      vo_inactive_ind_ire        OUT      tyt_inactive_ind_ire,
      vo_active_date_ire         OUT      tyt_active_date_ire,
      vi_payable_entity_id_ire   IN       t_payable_entity_id_ire,
      vi_contract_id_ire         IN       t_contract_id_ire,
      vi_contract_versao_ire     IN       t_contract_versao_ire,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_curr_code               IN       t_curr_code,
      vi_curr_code_secdy         IN       t_curr_code_secdy,
      vi_ind_curr_code_controle  IN       t_ind_curr_code_controle,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_data_ultimo_reajuste    IN       t_data_ultimo_reajuste,
      vi_data_prox_reajuste      IN       t_data_prox_reajuste,
      vi_user_id_created_ire     IN       t_user_id_created_ire
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_ITEM_CRONOGRAMA_U
   SUBTYPE t_payable_entity_id_icr IS ifrbde.viw_conf_item_cronograma_u.payable_entity_id_icr%TYPE;

   SUBTYPE t_contract_id_icr IS ifrbde.viw_conf_item_cronograma_u.contract_id_icr%TYPE;

   SUBTYPE t_contract_versao_icr IS ifrbde.viw_conf_item_cronograma_u.contract_versao_icr%TYPE;

--   SUBTYPE t_seq_item IS IFRBDE.viw_conf_item_cronograma_u.seq_item%TYPE;
--   SUBTYPE t_codigo_resumo_valor IS IFRBDE.viw_conf_item_cronograma_u.codigo_resumo_valor%TYPE;
   SUBTYPE t_tipo_cronograma IS ifrbde.viw_conf_item_cronograma_u.tipo_cronograma%TYPE;

   SUBTYPE t_numero_parcela IS ifrbde.viw_conf_item_cronograma_u.numero_parcela%TYPE;

--   SUBTYPE t_vendor_id IS IFRBDE.viw_conf_item_cronograma_u.vendor_id%TYPE;
--   SUBTYPE t_vendor_loc_code IS IFRBDE.viw_conf_item_cronograma_u.vendor_loc_code%TYPE;
--   SUBTYPE t_tipo_valor IS IFRBDE.viw_conf_item_cronograma_u.tipo_valor%TYPE;
   SUBTYPE t_data_vencto IS t_data;

--   SUBTYPE t_prim_amt IS IFRBDE.viw_conf_item_cronograma_u.prim_amt%TYPE;
--   SUBTYPE t_secdy_amt IS IFRBDE.viw_conf_item_cronograma_u.secdy_amt%TYPE;
   SUBTYPE t_codigo_recurso IS ifrbde.viw_conf_item_cronograma_u.codigo_recurso%TYPE;

   SUBTYPE t_vendor_id_rec IS ifrbde.viw_conf_item_cronograma_u.vendor_id_rec%TYPE;

   SUBTYPE t_vendor_loc_code_rec IS ifrbde.viw_conf_item_cronograma_u.vendor_loc_code_rec%TYPE;

   SUBTYPE t_sistema_origem_code_icr IS ifrbde.viw_conf_item_cronograma_u.sistema_origem_code_icr%TYPE;

   SUBTYPE t_contract_versao_origem_icr IS ifrbde.viw_conf_item_cronograma_u.contract_versao_origem_icr%TYPE;

   SUBTYPE t_date_created_icr IS t_data;

   SUBTYPE t_user_id_created_icr IS ifrbde.viw_conf_item_cronograma_u.user_id_created_icr%TYPE;

   SUBTYPE t_date_changed_icr IS t_data;

   SUBTYPE t_user_id_changed_icr IS ifrbde.viw_conf_item_cronograma_u.user_id_changed_icr%TYPE;

   SUBTYPE t_inactive_ind_icr IS ifrbde.viw_conf_item_cronograma_u.inactive_ind_icr%TYPE;

   SUBTYPE t_active_date_icr IS t_data;

   TYPE tyt_payable_entity_id_icr IS TABLE OF t_payable_entity_id_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_icr IS TABLE OF t_contract_id_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_icr IS TABLE OF t_contract_versao_icr
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_seq_item IS TABLE OF t_seq_item
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_codigo_resumo_valor IS TABLE OF t_codigo_resumo_valor
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_tipo_cronograma IS TABLE OF t_tipo_cronograma
      INDEX BY BINARY_INTEGER;

   TYPE tyt_numero_parcela IS TABLE OF t_numero_parcela
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_vendor_id IS TABLE OF t_vendor_id
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_vendor_loc_code IS TABLE OF t_vendor_loc_code
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_tipo_valor IS TABLE OF t_tipo_valor
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_data_vencto IS TABLE OF t_data_vencto
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_prim_amt IS TABLE OF t_prim_amt
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_secdy_amt IS TABLE OF t_secdy_amt
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_codigo_recurso IS TABLE OF t_codigo_recurso
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_id_rec IS TABLE OF t_vendor_id_rec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_loc_code_rec IS TABLE OF t_vendor_loc_code_rec
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_icr IS TABLE OF t_sistema_origem_code_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_icr IS TABLE OF t_contract_versao_origem_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_icr IS TABLE OF t_date_created_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_icr IS TABLE OF t_user_id_created_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_icr IS TABLE OF t_date_changed_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_icr IS TABLE OF t_user_id_changed_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_icr IS TABLE OF t_inactive_ind_icr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_icr IS TABLE OF t_active_date_icr
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_item_cronogr (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_numero_parcela          IN       t_numero_parcela
   );

   PROCEDURE stp_exclui_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_numero_parcela          IN       t_numero_parcela
   );

   PROCEDURE stp_inclui_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_data_vencto             IN       t_data_vencto,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_codigo_recurso          IN       t_codigo_recurso,
      vi_vendor_id_rec           IN       t_vendor_id_rec,
      vi_vendor_loc_code_rec     IN       t_vendor_loc_code_rec,
      vi_user_id_created_icr     IN       t_user_id_created_icr
   );

   PROCEDURE stp_altera_conf_item_cronogram (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_icr   OUT      tyt_payable_entity_id_icr,
      vo_contract_id_icr         OUT      tyt_contract_id_icr,
      vo_contract_versao_icr     OUT      tyt_contract_versao_icr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_tipo_valor              OUT      tyt_tipo_valor,
      vo_data_vencto             OUT      tyt_data_vencto,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_codigo_recurso          OUT      tyt_codigo_recurso,
      vo_vendor_id_rec           OUT      tyt_vendor_id_rec,
      vo_vendor_loc_code_rec     OUT      tyt_vendor_loc_code_rec,
      vo_sistema_origem_code_icr OUT      tyt_sistema_origem_code_icr,
      vo_contract_versao_origem_icr OUT   tyt_contract_versao_origem_icr,
      vo_date_created_icr        OUT      tyt_date_created_icr,
      vo_user_id_created_icr     OUT      tyt_user_id_created_icr,
      vo_date_changed_icr        OUT      tyt_date_changed_icr,
      vo_user_id_changed_icr     OUT      tyt_user_id_changed_icr,
      vo_inactive_ind_icr        OUT      tyt_inactive_ind_icr,
      vo_active_date_icr         OUT      tyt_active_date_icr,
      vi_payable_entity_id_icr   IN       t_payable_entity_id_icr,
      vi_contract_id_icr         IN       t_contract_id_icr,
      vi_contract_versao_icr     IN       t_contract_versao_icr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_tipo_valor              IN       t_tipo_valor,
      vi_data_vencto             IN       t_data_vencto,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_codigo_recurso          IN       t_codigo_recurso,
      vi_vendor_id_rec           IN       t_vendor_id_rec,
      vi_vendor_loc_code_rec     IN       t_vendor_loc_code_rec,
      vi_user_id_created_icr     IN       t_user_id_created_icr
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_SOL_PAG_VAL_U
   SUBTYPE t_payable_entity_id_spv IS ifrbde.viw_conf_sol_pag_val_u.payable_entity_id_spv%TYPE;

   SUBTYPE t_contract_id_spv IS ifrbde.viw_conf_sol_pag_val_u.contract_id_spv%TYPE;

   SUBTYPE t_contract_versao_spv IS ifrbde.viw_conf_sol_pag_val_u.contract_versao_spv%TYPE;

--   SUBTYPE t_vendor_id IS IFRBDE.viw_conf_sol_pag_val_u.vendor_id%TYPE;
--   SUBTYPE t_vendor_loc_code IS IFRBDE.viw_conf_sol_pag_val_u.vendor_loc_code%TYPE;
   SUBTYPE t_pmt_rqst_nbr IS ifrbde.viw_conf_sol_pag_val_u.pmt_rqst_nbr%TYPE;

   SUBTYPE t_pmt_rqst_date IS t_data;

   SUBTYPE t_schld_pmt_nbr IS ifrbde.viw_conf_sol_pag_val_u.schld_pmt_nbr%TYPE;

--   SUBTYPE t_seq_item IS IFRBDE.viw_conf_sol_pag_val_u.seq_item%TYPE;
--   SUBTYPE t_codigo_resumo_valor IS IFRBDE.viw_conf_sol_pag_val_u.codigo_resumo_valor%TYPE;
--   SUBTYPE t_tipo_cronograma IS IFRBDE.viw_conf_sol_pag_val_u.tipo_cronograma%TYPE;
--   SUBTYPE t_numero_parcela IS IFRBDE.viw_conf_sol_pag_val_u.numero_parcela%TYPE;
--   SUBTYPE t_prim_amt IS IFRBDE.viw_conf_sol_pag_val_u.prim_amt%TYPE;
--   SUBTYPE t_secdy_amt IS IFRBDE.viw_conf_sol_pag_val_u.secdy_amt%TYPE;
   SUBTYPE t_sistema_origem_code_spv IS ifrbde.viw_conf_sol_pag_val_u.sistema_origem_code_spv%TYPE;

   SUBTYPE t_contract_versao_origem_spv IS ifrbde.viw_conf_sol_pag_val_u.contract_versao_origem_spv%TYPE;

   SUBTYPE t_date_created_spv IS t_data;

   SUBTYPE t_user_id_created_spv IS ifrbde.viw_conf_sol_pag_val_u.user_id_created_spv%TYPE;

   SUBTYPE t_date_changed_spv IS t_data;

   SUBTYPE t_user_id_changed_spv IS ifrbde.viw_conf_sol_pag_val_u.user_id_changed_spv%TYPE;

   SUBTYPE t_inactive_ind_spv IS ifrbde.viw_conf_sol_pag_val_u.inactive_ind_spv%TYPE;

   SUBTYPE t_active_date_spv IS t_data;

   TYPE tyt_payable_entity_id_spv IS TABLE OF t_payable_entity_id_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_spv IS TABLE OF t_contract_id_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_spv IS TABLE OF t_contract_versao_spv
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_vendor_id IS TABLE OF t_vendor_id
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_vendor_loc_code IS TABLE OF t_vendor_loc_code
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_pmt_rqst_nbr IS TABLE OF t_pmt_rqst_nbr
      INDEX BY BINARY_INTEGER;

   TYPE tyt_pmt_rqst_date IS TABLE OF t_pmt_rqst_date
      INDEX BY BINARY_INTEGER;

   TYPE tyt_schld_pmt_nbr IS TABLE OF t_schld_pmt_nbr
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_seq_item IS TABLE OF t_seq_item
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_codigo_resumo_valor IS TABLE OF t_codigo_resumo_valor
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_tipo_cronograma IS TABLE OF t_tipo_cronograma
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_numero_parcela IS TABLE OF t_numero_parcela
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_prim_amt IS TABLE OF t_prim_amt
--   INDEX BY BINARY_INTEGER;

   --   TYPE tyt_secdy_amt IS TABLE OF t_secdy_amt
--   INDEX BY BINARY_INTEGER;
   TYPE tyt_sistema_origem_code_spv IS TABLE OF t_sistema_origem_code_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_spv IS TABLE OF t_contract_versao_origem_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_spv IS TABLE OF t_date_created_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_spv IS TABLE OF t_user_id_created_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_spv IS TABLE OF t_date_changed_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_spv IS TABLE OF t_user_id_changed_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_spv IS TABLE OF t_inactive_ind_spv
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_spv IS TABLE OF t_active_date_spv
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_sol_pag_val_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   );

   PROCEDURE stp_exclui_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   );

   PROCEDURE stp_inclui_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_user_id_created_spv     IN       t_user_id_created_spv
   );

   PROCEDURE stp_altera_conf_sol_pag_val_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_spv   OUT      tyt_payable_entity_id_spv,
      vo_contract_id_spv         OUT      tyt_contract_id_spv,
      vo_contract_versao_spv     OUT      tyt_contract_versao_spv,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_seq_item                OUT      tyt_seq_item,
      vo_codigo_resumo_valor     OUT      tyt_codigo_resumo_valor,
      vo_tipo_cronograma         OUT      tyt_tipo_cronograma,
      vo_numero_parcela          OUT      tyt_numero_parcela,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sistema_origem_code_spv OUT      tyt_sistema_origem_code_spv,
      vo_contract_versao_origem_spv OUT   tyt_contract_versao_origem_spv,
      vo_date_created_spv        OUT      tyt_date_created_spv,
      vo_user_id_created_spv     OUT      tyt_user_id_created_spv,
      vo_date_changed_spv        OUT      tyt_date_changed_spv,
      vo_user_id_changed_spv     OUT      tyt_user_id_changed_spv,
      vo_inactive_ind_spv        OUT      tyt_inactive_ind_spv,
      vo_active_date_spv         OUT      tyt_active_date_spv,
      vi_payable_entity_id_spv   IN       t_payable_entity_id_spv,
      vi_contract_id_spv         IN       t_contract_id_spv,
      vi_contract_versao_spv     IN       t_contract_versao_spv,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_seq_item                IN       t_seq_item,
      vi_codigo_resumo_valor     IN       t_codigo_resumo_valor,
      vi_tipo_cronograma         IN       t_tipo_cronograma,
      vi_numero_parcela          IN       t_numero_parcela,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_user_id_created_spv     IN       t_user_id_created_spv
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_SOL_PAG_ACR_RET_U
   SUBTYPE t_payable_entity_id_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.payable_entity_id_par%TYPE;

   SUBTYPE t_contract_id_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.contract_id_par%TYPE;

   SUBTYPE t_contract_versao_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.contract_versao_par%TYPE;

--   SUBTYPE t_vendor_id IS ifrbde.viw_conf_sol_pag_acr_ret_u.vendor_id%TYPE;

   --   SUBTYPE t_vendor_loc_code IS ifrbde.viw_conf_sol_pag_acr_ret_u.vendor_loc_code%TYPE;

   --   SUBTYPE t_pmt_rqst_nbr IS ifrbde.viw_conf_sol_pag_acr_ret_u.pmt_rqst_nbr%TYPE;

   --   SUBTYPE t_pmt_rqst_date IS t_data;

   --   SUBTYPE t_schld_pmt_nbr IS ifrbde.viw_conf_sol_pag_acr_ret_u.schld_pmt_nbr%TYPE;
   SUBTYPE t_codigo_red_acres IS ifrbde.viw_conf_sol_pag_acr_ret_u.codigo_red_acres%TYPE;

   SUBTYPE t_trans_amt IS ifrbde.viw_conf_sol_pag_acr_ret_u.trans_amt%TYPE;

   SUBTYPE t_descp IS ifrbde.viw_conf_sol_pag_acr_ret_u.descp%TYPE;

   SUBTYPE t_sistema_origem_code_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.sistema_origem_code_par%TYPE;

   SUBTYPE t_contract_versao_origem_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.contract_versao_origem_par%TYPE;

   SUBTYPE t_date_created_par IS t_data;

   SUBTYPE t_user_id_created_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.user_id_created_par%TYPE;

   SUBTYPE t_date_changed_par IS t_data;

   SUBTYPE t_user_id_changed_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.user_id_changed_par%TYPE;

   SUBTYPE t_inactive_ind_par IS ifrbde.viw_conf_sol_pag_acr_ret_u.inactive_ind_par%TYPE;

   SUBTYPE t_active_date_par IS t_data;

   TYPE tyt_payable_entity_id_par IS TABLE OF t_payable_entity_id_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_par IS TABLE OF t_contract_id_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_par IS TABLE OF t_contract_versao_par
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_vendor_id IS TABLE OF t_vendor_id
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_vendor_loc_code IS TABLE OF t_vendor_loc_code
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_pmt_rqst_nbr IS TABLE OF t_pmt_rqst_nbr
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_pmt_rqst_date IS TABLE OF t_pmt_rqst_date
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_schld_pmt_nbr IS TABLE OF t_schld_pmt_nbr
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_codigo_red_acres IS TABLE OF t_codigo_red_acres
      INDEX BY BINARY_INTEGER;

   TYPE tyt_trans_amt IS TABLE OF t_trans_amt
      INDEX BY BINARY_INTEGER;

   TYPE tyt_descp IS TABLE OF t_descp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_par IS TABLE OF t_sistema_origem_code_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_par IS TABLE OF t_contract_versao_origem_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_par IS TABLE OF t_date_created_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_par IS TABLE OF t_user_id_created_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_par IS TABLE OF t_date_changed_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_par IS TABLE OF t_user_id_changed_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_par IS TABLE OF t_inactive_ind_par
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_par IS TABLE OF t_active_date_par
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_sol_pag_acr_ (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par
   );

   PROCEDURE stp_exclui_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par
   );

   PROCEDURE stp_inclui_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_codigo_red_acres        IN       t_codigo_red_acres,
      vi_trans_amt               IN       t_trans_amt,
      vi_descp                   IN       t_descp,
      vi_user_id_created_par     IN       t_user_id_created_par
   );

   PROCEDURE stp_altera_conf_sol_pag_acr_re (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_par   OUT      tyt_payable_entity_id_par,
      vo_contract_id_par         OUT      tyt_contract_id_par,
      vo_contract_versao_par     OUT      tyt_contract_versao_par,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_codigo_red_acres        OUT      tyt_codigo_red_acres,
      vo_trans_amt               OUT      tyt_trans_amt,
      vo_descp                   OUT      tyt_descp,
      vo_sistema_origem_code_par OUT      tyt_sistema_origem_code_par,
      vo_contract_versao_origem_par OUT   tyt_contract_versao_origem_par,
      vo_date_created_par        OUT      tyt_date_created_par,
      vo_user_id_created_par     OUT      tyt_user_id_created_par,
      vo_date_changed_par        OUT      tyt_date_changed_par,
      vo_user_id_changed_par     OUT      tyt_user_id_changed_par,
      vo_inactive_ind_par        OUT      tyt_inactive_ind_par,
      vo_active_date_par         OUT      tyt_active_date_par,
      vi_payable_entity_id_par   IN       t_payable_entity_id_par,
      vi_contract_id_par         IN       t_contract_id_par,
      vi_contract_versao_par     IN       t_contract_versao_par,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_codigo_red_acres        IN       t_codigo_red_acres,
      vi_trans_amt               IN       t_trans_amt,
      vi_descp                   IN       t_descp,
      vi_user_id_created_par     IN       t_user_id_created_par
   );

--------------------------------------------------------------------------------
   --- VIW_CONF_SOL_PAG_HEAD_U
   SUBTYPE t_payable_entity_id_sph IS ifrbde.viw_conf_sol_pag_head_u.payable_entity_id_sph%TYPE;

   SUBTYPE t_contract_id_sph IS ifrbde.viw_conf_sol_pag_head_u.contract_id_sph%TYPE;

   SUBTYPE t_contract_versao_sph IS ifrbde.viw_conf_sol_pag_head_u.contract_versao_sph%TYPE;

--   SUBTYPE t_vendor_id IS ifrbde.viw_conf_sol_pag_head_u.vendor_id%TYPE;

   --   SUBTYPE t_vendor_loc_code IS ifrbde.viw_conf_sol_pag_head_u.vendor_loc_code%TYPE;

   --   SUBTYPE t_pmt_rqst_nbr IS ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_nbr%TYPE;

   --   SUBTYPE t_pmt_rqst_date IS t_data;

   --   SUBTYPE t_schld_pmt_nbr IS ifrbde.viw_conf_sol_pag_head_u.schld_pmt_nbr%TYPE;
   SUBTYPE t_tipo_sp IS ifrbde.viw_conf_sol_pag_head_u.tipo_sp%TYPE;

   SUBTYPE t_vendor_id_origem IS ifrbde.viw_conf_sol_pag_head_u.vendor_id_origem%TYPE;

   SUBTYPE t_vendor_loc_code_origem IS ifrbde.viw_conf_sol_pag_head_u.vendor_loc_code_origem%TYPE;

   SUBTYPE t_pmt_rqst_nbr_origem IS ifrbde.viw_conf_sol_pag_head_u.pmt_rqst_nbr_origem%TYPE;

   SUBTYPE t_pmt_rqst_date_origem IS t_data;

   SUBTYPE t_schld_pmt_nbr_origem IS ifrbde.viw_conf_sol_pag_head_u.schld_pmt_nbr_origem%TYPE;

--   SUBTYPE t_prim_amt IS ifrbde.viw_conf_sol_pag_head_u.prim_amt%TYPE;

   --   SUBTYPE t_secdy_amt IS ifrbde.viw_conf_sol_pag_head_u.secdy_amt%TYPE;
   SUBTYPE t_sp_status_code IS ifrbde.viw_conf_sol_pag_head_u.sp_status_code%TYPE;

   SUBTYPE t_sistema_origem_code_sph IS ifrbde.viw_conf_sol_pag_head_u.sistema_origem_code_sph%TYPE;

   SUBTYPE t_contract_versao_origem_sph IS ifrbde.viw_conf_sol_pag_head_u.contract_versao_origem_sph%TYPE;

   SUBTYPE t_date_created_sph IS t_data;

   SUBTYPE t_user_id_created_sph IS ifrbde.viw_conf_sol_pag_head_u.user_id_created_sph%TYPE;

   SUBTYPE t_date_changed_sph IS t_data;

   SUBTYPE t_user_id_changed_sph IS ifrbde.viw_conf_sol_pag_head_u.user_id_changed_sph%TYPE;

   SUBTYPE t_inactive_ind_sph IS ifrbde.viw_conf_sol_pag_head_u.inactive_ind_sph%TYPE;

   SUBTYPE t_active_date_sph IS t_data;

   TYPE tyt_payable_entity_id_sph IS TABLE OF t_payable_entity_id_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_id_sph IS TABLE OF t_contract_id_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_sph IS TABLE OF t_contract_versao_sph
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_vendor_id IS TABLE OF t_vendor_id
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_vendor_loc_code IS TABLE OF t_vendor_loc_code
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_pmt_rqst_nbr IS TABLE OF t_pmt_rqst_nbr
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_pmt_rqst_date IS TABLE OF t_pmt_rqst_date
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_schld_pmt_nbr IS TABLE OF t_schld_pmt_nbr
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_tipo_sp IS TABLE OF t_tipo_sp
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_id_origem IS TABLE OF t_vendor_id_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_vendor_loc_code_origem IS TABLE OF t_vendor_loc_code_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_pmt_rqst_nbr_origem IS TABLE OF t_pmt_rqst_nbr_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_pmt_rqst_date_origem IS TABLE OF t_pmt_rqst_date_origem
      INDEX BY BINARY_INTEGER;

   TYPE tyt_schld_pmt_nbr_origem IS TABLE OF t_schld_pmt_nbr_origem
      INDEX BY BINARY_INTEGER;

--   TYPE tyt_prim_amt IS TABLE OF t_prim_amt
--      INDEX BY BINARY_INTEGER;

   --   TYPE tyt_secdy_amt IS TABLE OF t_secdy_amt
--      INDEX BY BINARY_INTEGER;
   TYPE tyt_sp_status_code IS TABLE OF t_sp_status_code
      INDEX BY BINARY_INTEGER;

   TYPE tyt_sistema_origem_code_sph IS TABLE OF t_sistema_origem_code_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_contract_versao_origem_sph IS TABLE OF t_contract_versao_origem_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_created_sph IS TABLE OF t_date_created_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_created_sph IS TABLE OF t_user_id_created_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_date_changed_sph IS TABLE OF t_date_changed_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_user_id_changed_sph IS TABLE OF t_user_id_changed_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_inactive_ind_sph IS TABLE OF t_inactive_ind_sph
      INDEX BY BINARY_INTEGER;

   TYPE tyt_active_date_sph IS TABLE OF t_active_date_sph
      INDEX BY BINARY_INTEGER;

   PROCEDURE stp_pesquisa_conf_sol_pag_head (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   );

   PROCEDURE stp_exclui_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_ok                      OUT      tyt_ok,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr
   );

   PROCEDURE stp_inclui_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_tipo_sp                 IN       t_tipo_sp,
      vi_vendor_id_origem        IN       t_vendor_id_origem,
      vi_vendor_loc_code_origem  IN       t_vendor_loc_code_origem,
      vi_pmt_rqst_nbr_origem     IN       t_pmt_rqst_nbr_origem,
      vi_pmt_rqst_date_origem    IN       t_pmt_rqst_date_origem,
      vi_schld_pmt_nbr_origem    IN       t_schld_pmt_nbr_origem,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_sp_status_code          IN       t_sp_status_code,
      vi_user_id_created_sph     IN       t_user_id_created_sph
   );

   PROCEDURE stp_altera_conf_sol_pag_head_u (
      p_usuario                  IN       VARCHAR2,
      vo_payable_entity_id_sph   OUT      tyt_payable_entity_id_sph,
      vo_contract_id_sph         OUT      tyt_contract_id_sph,
      vo_contract_versao_sph     OUT      tyt_contract_versao_sph,
      vo_vendor_id               OUT      tyt_vendor_id,
      vo_vendor_loc_code         OUT      tyt_vendor_loc_code,
      vo_pmt_rqst_nbr            OUT      tyt_pmt_rqst_nbr,
      vo_pmt_rqst_date           OUT      tyt_pmt_rqst_date,
      vo_schld_pmt_nbr           OUT      tyt_schld_pmt_nbr,
      vo_tipo_sp                 OUT      tyt_tipo_sp,
      vo_vendor_id_origem        OUT      tyt_vendor_id_origem,
      vo_vendor_loc_code_origem  OUT      tyt_vendor_loc_code_origem,
      vo_pmt_rqst_nbr_origem     OUT      tyt_pmt_rqst_nbr_origem,
      vo_pmt_rqst_date_origem    OUT      tyt_pmt_rqst_date_origem,
      vo_schld_pmt_nbr_origem    OUT      tyt_schld_pmt_nbr_origem,
      vo_prim_amt                OUT      tyt_prim_amt,
      vo_secdy_amt               OUT      tyt_secdy_amt,
      vo_sp_status_code          OUT      tyt_sp_status_code,
      vo_sistema_origem_code_sph OUT      tyt_sistema_origem_code_sph,
      vo_contract_versao_origem_sph OUT   tyt_contract_versao_origem_sph,
      vo_date_created_sph        OUT      tyt_date_created_sph,
      vo_user_id_created_sph     OUT      tyt_user_id_created_sph,
      vo_date_changed_sph        OUT      tyt_date_changed_sph,
      vo_user_id_changed_sph     OUT      tyt_user_id_changed_sph,
      vo_inactive_ind_sph        OUT      tyt_inactive_ind_sph,
      vo_active_date_sph         OUT      tyt_active_date_sph,
      vi_payable_entity_id_sph   IN       t_payable_entity_id_sph,
      vi_contract_id_sph         IN       t_contract_id_sph,
      vi_contract_versao_sph     IN       t_contract_versao_sph,
      vi_vendor_id               IN       t_vendor_id,
      vi_vendor_loc_code         IN       t_vendor_loc_code,
      vi_pmt_rqst_nbr            IN       t_pmt_rqst_nbr,
      vi_pmt_rqst_date           IN       t_pmt_rqst_date,
      vi_schld_pmt_nbr           IN       t_schld_pmt_nbr,
      vi_tipo_sp                 IN       t_tipo_sp,
      vi_vendor_id_origem        IN       t_vendor_id_origem,
      vi_vendor_loc_code_origem  IN       t_vendor_loc_code_origem,
      vi_pmt_rqst_nbr_origem     IN       t_pmt_rqst_nbr_origem,
      vi_pmt_rqst_date_origem    IN       t_pmt_rqst_date_origem,
      vi_schld_pmt_nbr_origem    IN       t_schld_pmt_nbr_origem,
      vi_prim_amt                IN       t_prim_amt,
      vi_secdy_amt               IN       t_secdy_amt,
      vi_sp_status_code          IN       t_sp_status_code,
      vi_user_id_created_sph     IN       t_user_id_created_sph
   );
END;                                                           -- Package spec
/

-- Grants for Package
GRANT EXECUTE ON ifrbde.pck_integracao TO bde_geral
/


-- End of DDL Script for Package IFRBDE.PCK_INTEGRACAO

