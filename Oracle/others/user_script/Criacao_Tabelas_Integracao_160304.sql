CREATE TABLE INTEGRACAO.conf_security_u (
 payable_entity_id varchar2(5) NOT NULL ,
 contract_id varchar2(30) NOT NULL ,
 cod_momento_aprovacao varchar2(3) NOT NULL ,
 seq_seg varchar2(5) NOT NULL ,
 tipo_user_or_group varchar2(1) NOT NULL ,
 cod_user_or_group varchar2(30) NOT NULL ,
 doc_origem_aproval varchar2(40) NOT NULL ,
 sistema_origem_code varchar2(2) NOT NULL ,
 contract_versao_origem varchar2(2) NOT NULL ,
 date_created date NOT NULL ,
 user_id_created varchar2(30) NOT NULL ,
 date_changed date NOT NULL ,
 user_id_changed varchar2(30) NOT NULL ,
 inactive_ind varchar2(1) NOT NULL ,
 active_date date NOT NULL ,
 chgstamp number NOT NULL 
) 
/

grant select, insert, update, delete on INTEGRACAO.conf_security_u to INTEGRACAO_SS;

COMMENT ON TABLE CONF_SECURITY_U IS 'Tabela que contém os Usuários habilitados para manusear o contrato em seu momento específico.';
comment on column CONF_SECURITY_U.PAYABLE_ENTITY_ID  is 'Entidade de Pagamento';
comment on column CONF_SECURITY_U.CONTRACT_ID  is 'Número do Contrato';
comment on column CONF_SECURITY_U.COD_MOMENTO_APROVACAO  is 'Código Momento de Aprovação';
comment on column CONF_SECURITY_U.SEQ_SEG  is 'Sequência';
comment on column CONF_SECURITY_U.TIPO_USER_OR_GROUP  is 'Tipo Usuário ou Grupo';
comment on column CONF_SECURITY_U.COD_USER_OR_GROUP  is 'ID Usuário ou Grupo';
comment on column CONF_SECURITY_U.DOC_ORIGEM_APROVAL  is 'Ato Administrativo';
comment on column CONF_SECURITY_U.SISTEMA_ORIGEM_CODE  is 'Cod. Sistema de Origem';
comment on column CONF_SECURITY_U.CONTRACT_VERSAO_ORIGEM  is 'Número Contrato Origem';
comment on column CONF_SECURITY_U.DATE_CREATED  is 'Data de criação do registro';
comment on column CONF_SECURITY_U.USER_ID_CREATED  is 'Usuário criador';
comment on column CONF_SECURITY_U.DATE_CHANGED  is 'Data de alteração do registro';
comment on column CONF_SECURITY_U.USER_ID_CHANGED  is 'Usuário alterador';
comment on column CONF_SECURITY_U.INACTIVE_IND  is 'Status de inativação';
comment on column CONF_SECURITY_U.ACTIVE_DATE  is 'Data de Ativação';
comment on column CONF_SECURITY_U.CHGSTAMP  is 'Controle Qtde alterações';


CREATE TABLE INTEGRACAO.conf_exp_detail_u (
 payable_entity_id varchar2(5) NOT NULL ,
 contract_id varchar2(30) NOT NULL ,
 contract_versao varchar2(2) NOT NULL ,
 seq_item varchar2(4) NOT NULL ,
 tipo_aquisicao varchar2(2) NOT NULL ,
 item_id varchar2(26) NOT NULL ,
 qty float NOT NULL ,
 unit_of_measure varchar2(4) NOT NULL ,
 item_descp varchar2(35) NOT NULL ,
 tipo_valor varchar2(2) NOT NULL ,
 vl_item number(12,2) NOT NULL ,
 sistema_origem_code varchar2(2) NOT NULL ,
 contract_versao_origem varchar2(2) NOT NULL ,
 date_created date NOT NULL ,
 user_id_created varchar2(30) NOT NULL ,
 date_changed date NOT NULL ,
 user_id_changed varchar2(30) NOT NULL ,
 inactive_ind varchar2(1) NOT NULL ,
 active_date date NOT NULL ,
 chgstamp number NOT NULL 
) 
/


comment on table CONF_EXP_DETAIL_U is  'São as linhas dos itens (detalhe) que compõem o Contrato Expresso.';
comment on column CONF_EXP_DETAIL_U.PAYABLE_ENTITY_ID is 'Entidade de Pagamento';
comment on column CONF_EXP_DETAIL_U.CONTRACT_ID is 'Número do Contrato';
comment on column CONF_EXP_DETAIL_U.CONTRACT_VERSAO is 'Versão do Contrato';
comment on column CONF_EXP_DETAIL_U.SEQ_ITEM is 'Seqüência da linha (Reg)';
comment on column CONF_EXP_DETAIL_U.TIPO_AQUISICAO is 'Tipo de Aquisição';
comment on column CONF_EXP_DETAIL_U.ITEM_ID is 'ID do Item (Conta Contabil)';
comment on column CONF_EXP_DETAIL_U.QTY is 'Quantidade';
comment on column CONF_EXP_DETAIL_U.UNIT_OF_MEASURE is 'Unidade de Medida';
comment on column CONF_EXP_DETAIL_U.ITEM_DESCP is 'Descrição do Item';
comment on column CONF_EXP_DETAIL_U.TIPO_VALOR is 'Tipo do Valor';
comment on column CONF_EXP_DETAIL_U.VL_ITEM is 'Valor o Item';
comment on column CONF_EXP_DETAIL_U.SISTEMA_ORIGEM_CODE is 'Sistema de Origem';
comment on column CONF_EXP_DETAIL_U.CONTRACT_VERSAO_ORIGEM is 'No versão de Origem';
comment on column CONF_EXP_DETAIL_U.DATE_CREATED is 'Data de criação do Reg.';
comment on column CONF_EXP_DETAIL_U.USER_ID_CREATED is 'ID usuario criador';
comment on column CONF_EXP_DETAIL_U.DATE_CHANGED is 'Data de alteração';
comment on column CONF_EXP_DETAIL_U.USER_ID_CHANGED is 'Usuário alterador';
comment on column CONF_EXP_DETAIL_U.INACTIVE_IND is 'Status Inativo';
comment on column CONF_EXP_DETAIL_U.ACTIVE_DATE is 'Data de ativação';
comment on column CONF_EXP_DETAIL_U.CHGSTAMP is 'Controle Qtde alterações';


grant select, insert, update, delete on INTEGRACAO.conf_exp_detail_u to INTEGRACAO_SS;

CREATE TABLE INTEGRACAO.conf_exp_head_u (
 payable_entity_id varchar2(5) NOT NULL ,
 contract_id varchar2(30) NOT NULL ,
 contract_versao varchar2(2) NOT NULL ,
 contract_status_code varchar2(2) NOT NULL ,
 contract_desc varchar2(150) NOT NULL ,
 codigo_tip_doc varchar2(2) NOT NULL ,
 contract_type varchar2(4) NOT NULL ,
 contract_sub_type varchar2(4) NOT NULL ,
 ano varchar2(4) NOT NULL ,
 payable_entity_id_oper varchar2(5) NOT NULL ,
 manager_id varchar2(30) NOT NULL ,
 proposta_data date NOT NULL ,
 inicio_data date NOT NULL ,
 tipo_prazo varchar2(2) NOT NULL ,
 quant_prazo int NOT NULL ,
 termino_data date NOT NULL ,
 vendor_id varchar2(10) NOT NULL ,
 vendor_loc_code varchar2(3) NOT NULL ,
 seq_nbr varchar2(3) NOT NULL ,
 banco varchar2(11) NOT NULL ,
 dependencia varchar2(3) NOT NULL ,
 conta varchar2(9) NOT NULL ,
 certificador varchar2(30) NOT NULL ,
 autorizador varchar2(30) NOT NULL ,
 vl_tot_contrato number(12,2) NOT NULL ,
 contract_id_vendor varchar2(30) NOT NULL ,
 sistema_origem_code varchar2(2) NOT NULL ,
 contract_versao_origem varchar2(2) NOT NULL ,
 date_created date NOT NULL ,
 user_id_created varchar2(30) NOT NULL ,
 date_changed date NOT NULL ,
 user_id_changed varchar2(30) NOT NULL ,
 inactive_ind varchar2(1) NOT NULL ,
 active_date date NOT NULL ,
 chgstamp number NOT NULL 
) 
/

comment on table CONF_EXP_HEAD_U is 'São os dados principais do Contrato Expresso a ser migrado ao SmartStream.';
comment on column CONF_EXP_HEAD_U.PAYABLE_ENTITY_ID is 'Entidade de Pagamento';
comment on column CONF_EXP_HEAD_U.CONTRACT_ID is 'Número do Contrato';
comment on column CONF_EXP_HEAD_U.CONTRACT_VERSAO is 'Versão do Contrato';
comment on column CONF_EXP_HEAD_U.CONTRACT_STATUS_CODE is 'Status do Contrato';
comment on column CONF_EXP_HEAD_U.CONTRACT_DESC is 'Descrição do Contrato de acordo com o tipo';
comment on column CONF_EXP_HEAD_U.CODIGO_TIP_DOC is 'Tipo do Documento (credenciamento)';
comment on column CONF_EXP_HEAD_U.CONTRACT_TYPE is 'Tipo do Contrato';
comment on column CONF_EXP_HEAD_U.CONTRACT_SUB_TYPE is 'SubTipo do Contrato';
comment on column CONF_EXP_HEAD_U.ANO is 'Ano de assinatura do Contrato';
comment on column CONF_EXP_HEAD_U.PAYABLE_ENTITY_ID_OPER is 'Entidade Operacional';
comment on column CONF_EXP_HEAD_U.MANAGER_ID is 'Centro de Custo Principal';
comment on column CONF_EXP_HEAD_U.PROPOSTA_DATA is 'Data da Proposta';
comment on column CONF_EXP_HEAD_U.INICIO_DATA is 'Data de Inicio';
comment on column CONF_EXP_HEAD_U.TIPO_PRAZO is 'Tipo do Prazo';
comment on column CONF_EXP_HEAD_U.QUANT_PRAZO is 'Qtde do prazo';
comment on column CONF_EXP_HEAD_U.TERMINO_DATA is 'Data de Termino';
comment on column CONF_EXP_HEAD_U.VENDOR_ID is 'ID do Fornecedor';
comment on column CONF_EXP_HEAD_U.VENDOR_LOC_CODE is 'LOC do Fornecedor';
comment on column CONF_EXP_HEAD_U.SEQ_NBR is 'Sequencia Bancária';
comment on column CONF_EXP_HEAD_U.CERTIFICADOR is 'ID do Certificador ';
comment on column CONF_EXP_HEAD_U.AUTORIZADOR is 'ID do Autorizador';
comment on column CONF_EXP_HEAD_U.VL_TOT_CONTRATO is 'Valor  do Contrato';
comment on column CONF_EXP_HEAD_U.CONTRACT_ID_VENDOR is 'No. Contrato Origem Benefícios';
comment on column CONF_EXP_HEAD_U.SISTEMA_ORIGEM_CODE is 'Sistema de Origem';
comment on column CONF_EXP_HEAD_U.CONTRACT_VERSAO_ORIGEM is 'No versão de Origem';
comment on column CONF_EXP_HEAD_U.DATE_CREATED is 'Data de criação do Reg.';
comment on column CONF_EXP_HEAD_U.USER_ID_CREATED is 'ID usuario criador';
comment on column CONF_EXP_HEAD_U.DATE_CHANGED is 'Data de alteração';
comment on column CONF_EXP_HEAD_U.USER_ID_CHANGED is 'Usuário alterador';
comment on column CONF_EXP_HEAD_U.INACTIVE_IND is 'Status Inativo';
comment on column CONF_EXP_HEAD_U.ACTIVE_DATE is 'Data de ativação';
comment on column CONF_EXP_HEAD_U.CHGSTAMP is 'Controle Qtde alterações';


grant select, insert, update, DELETE on INTEGRACAO.conf_exp_head_u to INTEGRACAO_SS;

-- Criação de comentários
comment on table CONF_ITEM_REQUISITADOS_U is 'Seleção do Item do Governo.';
comment on column CONF_ITEM_REQUISITADOS_U.PAYABLE_ENTITY_ID  is 'Entidade de Pagamento';
comment on column CONF_ITEM_REQUISITADOS_U.CONTRACT_ID  is 'Número do Contrato';
comment on column CONF_ITEM_REQUISITADOS_U.CONTRACT_VERSAO  is 'Versão do Contrato';
comment on column CONF_ITEM_REQUISITADOS_U.TIPO_AQUISICAO  is 'Tipo Aquisição';
comment on column CONF_ITEM_REQUISITADOS_U.ITEM_ID_GOV  is 'Cod Item Governo';
comment on column CONF_ITEM_REQUISITADOS_U.ITEM_ID  is 'Cod. Item';
comment on column CONF_ITEM_REQUISITADOS_U.ITEM_DESCP  is 'Descrição do Item';
comment on column CONF_ITEM_REQUISITADOS_U.QTY  is 'Quantidade';
comment on column CONF_ITEM_REQUISITADOS_U.UNIT_OF_MEASURE  is 'Unidade Medida';
comment on column CONF_ITEM_REQUISITADOS_U.VL_TEM  is 'Valor do Item';
comment on column CONF_ITEM_REQUISITADOS_U.SEQ_ITEM  is 'Sequencia do Item';
comment on column CONF_ITEM_REQUISITADOS_U.SISTEMA_ORIGEM_COD  is 'Código Sistema de Origem';
comment on column CONF_ITEM_REQUISITADOS_U.CONTRACT_VERSAO_ORIGEM  is 'Versão contrato origem';
comment on column CONF_ITEM_REQUISITADOS_U.DATE_CREATED  is 'Data de criação do registro';
comment on column CONF_ITEM_REQUISITADOS_U.USER_ID_CREATED  is 'Usuário criador do registro';
comment on column CONF_ITEM_REQUISITADOS_U.DATE_CHANGED  is 'Data de alteração';
comment on column CONF_ITEM_REQUISITADOS_U.USER_ID_CHANGED  is 'Usuário que alterou o registro';
comment on column CONF_ITEM_REQUISITADOS_U.INACTIVE_IND  is 'Flag de inativação';
comment on column CONF_ITEM_REQUISITADOS_U.ACTIVE_DATE  is 'Data de inativação';
comment on column CONF_ITEM_REQUISITADOS_U.CHGSTAMP  is 'Controle de Versão do registro';


