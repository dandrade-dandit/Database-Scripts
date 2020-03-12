/*==============================================================*/
/* Database name:  interfaceSmartStream                         */
/* DBMS name:      ORACLE Version 8                             */
/* Created on:     15/01/2003 09:43:28                          */
/*==============================================================*/

/*==============================================================*/
/* Table: conf_datas_u                                          */
/*==============================================================*/

create table conf_datas_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   proposta_data        DATE                             not null,
   assinatura_data      DATE                             not null,
   tipo_prazo           VARCHAR2(2)                      not null,
   quant_prazo          NUMBER(6)                        not null,
   entrega_data         DATE                             not null,
   garantia_data        DATE                             not null,
   inicio_data          DATE                             not null,
   termino_prev_data    DATE                             not null,
   termino_data         DATE                             not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                    not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_datas_u primary key (payable_entity_id, contract_id, contract_versao)
)
/


/*==============================================================*/
/* Table: conf_identificacao_u                                  */
/*==============================================================*/


create table conf_identificacao_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   contract_desc        VARCHAR2(70)                     not null,
   contract_status_code VARCHAR2(2)                      not null,
   contract_prev_status_code VARCHAR2(2)                      not null,
   contract_type        VARCHAR2(4)                      not null,
   contract_sub_type    VARCHAR2(4)                      not null,
   contract_id_vendor   VARCHAR2(30)                     not null,
   codigo_mod_contratacao VARCHAR2(4)                      not null,
   manager_id           VARCHAR2(30)                     not null,
   security_code        VARCHAR2(10)                     not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_identificacao_u primary key (payable_entity_id, contract_id, contract_versao)
)
/


/*==============================================================*/
/* Table: conf_item_acct_distin_u                               */
/*==============================================================*/


create table conf_item_acct_distin_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   ldr_entity_id        VARCHAR2(5)                      not null,
   dependencia          VARCHAR2(3)                      not null,
   conta                VARCHAR2(9)                      not null,
   programa             VARCHAR2(2)                      not null,
   projeto              VARCHAR2(4)                      not null,
   custo                VARCHAR2(6)                      not null,
   int_tipo_distr       VARCHAR2(1)                      not null,
   per_valor_distr      NUMBER(8,3)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                    not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_acct_distin_u primary key (payable_entity_id, contract_id, contract_versao, seq_item, ldr_entity_id, dependencia, conta, programa, projeto, custo)
)
/


/*==============================================================*/
/* Table: conf_item_cronograma_u                                */
/*==============================================================*/


create table conf_item_cronograma_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   codigo_resumo_valor  VARCHAR2(3)                      not null,
   tipo_cronograma      VARCHAR2(1)                      not null,
   numero_parcela       VARCHAR2(4)                      not null,
   vendor_id            VARCHAR2(10)                     not null,
   vendor_loc_code      VARCHAR2(3)                      not null,
   tipo_valor           VARCHAR2(2)                      not null,
   data_vencto          DATE                             not null,
   prim_amt             NUMBER(8,2)                      not null,
   secdy_amt            NUMBER(8,2)                      not null,
   codigo_recurso       VARCHAR2(5)                      not null,
   vendor_id_rec        VARCHAR2(10)                     not null,
   vendor_loc_code_rec  VARCHAR2(3)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_cronograma_u primary key (payable_entity_id, contract_id, contract_versao, seq_item, codigo_resumo_valor, tipo_cronograma, numero_parcela)
)
/


/*==============================================================*/
/* Table: conf_item_ident_u                                     */
/*==============================================================*/


create table conf_item_ident_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   qty                  NUMBER(8,3)                      not null,
   unit_of_measure      VARCHAR2(4)                      not null,
   item_id              VARCHAR2(26)                     not null,
   item_descp           VARCHAR2(35)                     not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_ident_u primary key (payable_entity_id, contract_id, contract_versao, seq_item)
)
/


/*==============================================================*/
/* Table: conf_item_projeto_u                                   */
/*==============================================================*/


create table conf_item_projeto_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   project_ind_automatico VARCHAR2(1)                      not null,
   project_entity_id    VARCHAR2(5)                      not null,
   project_id           VARCHAR2(20)                     not null,
   component_id         VARCHAR2(20)                     not null,
   cost_element_id      VARCHAR2(1)                      not null,
   manager_id           VARCHAR2(30)                     not null,
   security_code        VARCHAR2(10)                     not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_projeto_u primary key (payable_entity_id, contract_id, contract_versao, seq_item)
)
/


/*==============================================================*/
/* Table: conf_item_reajuste_u                                  */
/*==============================================================*/


create table conf_item_reajuste_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   codigo_resumo_valor  VARCHAR2(3)                      not null,
   begin_date           DATE                             not null,
   end_date             DATE                             not null,
   tipo_reajuste        VARCHAR2(1)                      not null,
   ind_real_previsto    VARCHAR2(15)                     not null,
   nm_indice            VARCHAR2(20)                     not null,
   fator_reajuste       NUMBER(8,3)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_reajuste_u primary key (payable_entity_id, contract_id, contract_versao, seq_item, codigo_resumo_valor, begin_date)
)
/


/*==============================================================*/
/* Table: conf_item_resumo_u                                    */
/*==============================================================*/


create table conf_item_resumo_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   codigo_resumo_valor  VARCHAR2(3)                      not null,
   tipo_valor           VARCHAR2(2)                      not null,
   curr_code            VARCHAR2(3)                      not null,
   curr_code_secdy      VARCHAR2(3)                      not null,
   ind_curr_code_controle VARCHAR2(1)                      not null,
   prim_amt             NUMBER(8,2)                      not null,
   secdy_amt            NUMBER(8,2)                      not null,
   data_ultimo_reajuste DATE                             not null,
   data_prox_reajuste   DATE                             not null,
   user_fld_3           VARCHAR2(15)                     not null,
   user_fld_4           VARCHAR2(10)                     not null,
   user_date_2          DATE                             not null,
   user_amt_1           NUMBER(8,2)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_resumo_u primary key (payable_entity_id, contract_id, contract_versao, seq_item, codigo_resumo_valor)
)
/


/*==============================================================*/
/* Table: conf_item_usuario_u                                   */
/*==============================================================*/


create table conf_item_usuario_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   seq_item             VARCHAR2(4)                      not null,
   user_fld_1           VARCHAR2(20)                     not null,
   user_fld_2           VARCHAR2(15)                     not null,
   user_fld_3           VARCHAR2(15)                     not null,
   user_fld_4           VARCHAR2(10)                     not null,
   user_fld_5           VARCHAR2(10)                     not null,
   user_fld_6           VARCHAR2(5)                      not null,
   user_date_1          DATE                             not null,
   user_date_2          DATE                             not null,
   user_amt_1           NUMBER(8,2)                      not null,
   user_amt_2           NUMBER(8,2)                      not null,
   user_amt_3           NUMBER(8,2)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_item_usuario_u primary key (payable_entity_id, contract_id, contract_versao, seq_item)
)
/


/*==============================================================*/
/* Table: conf_objeto_u                                         */
/*==============================================================*/


create table conf_objeto_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   objeto_desc          VARCHAR2(255)                    not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_objeto_u primary key (payable_entity_id, contract_id, contract_versao)
)
/


/*==============================================================*/
/* Table: conf_participantes_u                                  */
/*==============================================================*/


create table conf_participantes_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   vendor_id            VARCHAR2(10)                     not null,
   vendor_loc_code      VARCHAR2(3)                      not null,
   addr_fmt             VARCHAR2(6)                      not null,
   addr_line_1          VARCHAR2(35)                     not null,
   street_or_post_office_box_1 VARCHAR2(35)              not null,
   street_or_post_office_box_2 VARCHAR2(35)              not null,
   city_name            VARCHAR2(35)                     not null,
   country_sub_entity_code VARCHAR2(9)                   not null,
   postal_code          VARCHAR2(9)                      not null,
   country_code         VARCHAR2(2)                      not null,
   com_ddd              VARCHAR2(5)                      not null,
   com_tel              VARCHAR2(9)                      not null,
   com_fax              VARCHAR2(9)                      not null,
   com_email            VARCHAR2(70)                     not null,
   cod_relacao_contrato VARCHAR2(2)                      not null,
   type_of_pmt          VARCHAR2(4)                      not null,
   seq_nbr              VARCHAR2(3)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                    not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_participantes_u primary key (payable_entity_id, contract_id, contract_versao, vendor_id, vendor_loc_code)
)
/


/*==============================================================*/
/* Table: conf_publicacao_u                                     */
/*==============================================================*/


create table conf_publicacao_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   publicacao_data      DATE                             not null,
   publicacao_numero_dou VARCHAR2(10)                     not null,
   publicacao_secao     VARCHAR2(5)                      not null,
   publicacao_pagina    VARCHAR2(5)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_publicacao_u primary key (payable_entity_id, contract_id, contract_versao)
)
/


/*==============================================================*/
/* Table: conf_representantes_u                                 */
/*==============================================================*/


create table conf_representantes_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   cpf_repres           VARCHAR2(10)                     not null,
   num_rg               VARCHAR2(15)                     not null,
   no_repres            VARCHAR2(60)                     not null,
   cargo_repres         VARCHAR2(60)                     not null,
   tipo_representante   VARCHAR2(2)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_representantes_u primary key (payable_entity_id, contract_id, contract_versao, cpf_repres)
)
/


/*==============================================================*/
/* Table: conf_termo_u                                          */
/*==============================================================*/


create table conf_termo_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   contract_numero_termo VARCHAR2(30)                     not null,
   data_termo           DATE                             not null,
   objeto_desc          VARCHAR2(255)                    not null,
   publicacao_data      DATE                             not null,
   publicacao_numero_dou VARCHAR2(10)                     not null,
   publicacao_secao     VARCHAR2(5)                      not null,
   publicacao_pagina    VARCHAR2(5)                      not null,
   user_fld_3           VARCHAR2(15)                     not null,
   user_fld_4           VARCHAR2(10)                     not null,
   tipo_termo           VARCHAR2(2)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_termo_u primary key (payable_entity_id, contract_id, contract_versao, contract_numero_termo)
)
/


/*==============================================================*/
/* Table: conf_usuario_u                                        */
/*==============================================================*/


create table conf_usuario_u  (
   payable_entity_id    VARCHAR2(5)                      not null,
   contract_id          VARCHAR2(30)                     not null,
   contract_versao      VARCHAR2(2)                      not null,
   user_fld_1           VARCHAR2(20)                     not null,
   user_fld_2           VARCHAR2(15)                     not null,
   user_fld_3           VARCHAR2(15)                     not null,
   user_fld_4           VARCHAR2(10)                     not null,
   user_fld_5           VARCHAR2(10)                     not null,
   user_fld_6           VARCHAR2(5)                      not null,
   user_date_1          DATE                             not null,
   user_date_2          DATE                             not null,
   user_amt_1           NUMBER(8,2)                      not null,
   user_amt_2           NUMBER(8,2)                      not null,
   user_amt_3           NUMBER(8,2)                      not null,
   sistema_origem_code  VARCHAR2(2)                      not null,
   contract_versao_origem VARCHAR2(2)                      not null,
   date_created         DATE                             not null,
   user_id_created      VARCHAR2(30)                     not null,
   date_changed         DATE                             not null,
   user_id_changed      VARCHAR2(30)                     not null,
   inactive_ind         VARCHAR2(1)                      not null,
   active_date          DATE                             not null,
   chgstamp             NUMBER(6)                        not null,
   constraint P_conf_usuario_u primary key (payable_entity_id, contract_id, contract_versao)
)
/


