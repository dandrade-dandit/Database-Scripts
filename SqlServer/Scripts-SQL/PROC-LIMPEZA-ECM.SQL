--1) DELETES...EXECUTAR 3 VEZES.
delete from IFRECM.ALTERACAO_PRAZO;
delete from IFRECM.AREA_INTERESSADA; 
delete from IFRECM.ASSINANTE; 
delete from IFRECM.ATO_ADM_REFERENCIA; 
delete from IFRECM.ATO_ADM_REVISOR; 
delete from IFRECM.ATO_ADMINISTRATIVO; 
delete from IFRECM.AUDITORIA; 
delete from IFRECM.AUTORIDADE_SUPERIOR; 
delete from IFRECM.CAIXA_ENTRADA; 
delete from IFRECM.CAIXA_PENDENCIA; 
delete from IFRECM.CAIXA_PENDENCIA_GRUPO; 
delete from IFRECM.CARTA_EXECUTIVA; 
delete from IFRECM.CARTA_FORMAL; 
delete from IFRECM.CARTA_FORMAL_CC; 
delete from IFRECM.CF_AREA_INTERESSADA; 
delete from IFRECM.CF_ASSINANTE;           
delete from IFRECM.CF_DESTINATARIO; 
delete from IFRECM.CF_REFERENCIA; 
delete from IFRECM.CF_REVISOR; 
delete from IFRECM.DESP_AREA_INTERESSADA; 
delete from IFRECM.DESPACHO;               
delete from IFRECM.DESPACHO_CC; 
delete from IFRECM.DESPACHO_DESTINATARIO; 
delete from IFRECM.DESPACHO_REFERENCIA; 
delete from IFRECM.DESPACHO_REVISOR; 
delete from IFRECM.DEST_GRUPO_DESTINATARIO; 
delete from IFRECM.DESTINATARIO;    
delete from IFRECM.DOCUMENTO_OFICIAL where tipo_documento_id != 8; 
delete from IFRECM.FAX;  
delete from IFRECM.FAX_REFERENCIA;     
delete from IFRECM.GRUPO_DESTINATARIO; 
delete from IFRECM.GRUPO_DESTINATARIO_INTERNO; 
delete from IFRECM.HISTORICO_WORKFLOW; 
delete from IFRECM.MLT_DOCUMENTO_GUIA; 
delete from IFRECM.MLT_ENCAMINHAMENTO; 
delete from IFRECM.MLT_GUIA_REMESSA; 
delete from IFRECM.PEC;                                                                                      
delete from IFRECM.PEC_ENCAMINHAMENTO; 
delete from IFRECM.PEC_HISTORICO;
 delete from IFRECM.PEC_VOLUME;                                                                                 
delete from IFRECM.PERM_EMPREGADO_PROTOCOLO; 
delete from IFRECM.PROTOCOLO; 
delete from IFRECM.REFERENCIA; 
delete from IFRECM.REVISOR; 
delete from IFRECM.UNIDADE_ORGANIZACIONAL;  


--2) UPDATE
Update ifrecm.MLT_PARAM_DEP_MALOTE set NUMERO_GRD =0, NUMERO_PEC=0;

--3) INSERTS OU UPDATES DOS PROTOCOLOS DAS DEPENDENCIAS
--SEDE
--0 para SIGILOSO
UPDATE ifrecm.documento_oficial
   SET num_documento = 28956
 WHERE SIGLA_UOR = 'SEDE'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 0;
   
--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 4954
 WHERE SIGLA_UOR = 'SEDE'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;


--SBBR
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 18706, 'SBBR', SYSDATE, 8, 0, NULL);


--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 397
 WHERE SIGLA_UOR = 'SBBR'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   
--SBCG
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 4017, 'SBCG', SYSDATE, 8, 0, NULL);

   
--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 26
 WHERE SIGLA_UOR = 'SBCG'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   
--SBGO
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 5241, 'SBGO', SYSDATE, 8, 0, NULL);

   
--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 4
 WHERE SIGLA_UOR = 'SBGO'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   
--SBPJ
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 4342, 'SBPJ', SYSDATE, 8, 0, NULL);

   
--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 976
 WHERE SIGLA_UOR = 'SBPJ'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   
--SBCR
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 1843, 'SBCR', SYSDATE, 8, 0, NULL);
   
--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 20
 WHERE SIGLA_UOR = 'SBCR'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   
--SRCO
--0 para SIGILOSO
UPDATE ifrecm.documento_oficial
   SET num_documento = 13875
 WHERE SIGLA_UOR = 'SRCO'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 0;
   
--1  para OSTENSIVO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 224, 'SRCO', SYSDATE, 8, 1, NULL);

UPDATE ifrecm.documento_oficial
   SET num_documento = 
 WHERE SIGLA_UOR = ''
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;  
   
--SBPP
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 2092, 'SBPP', SYSDATE, 8, 0, NULL);

--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 22
 WHERE SIGLA_UOR = 'SBPP'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;


--SBCY
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 3863, 'SBCY', SYSDATE, 8, 0, NULL);


--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 50
 WHERE SIGLA_UOR = 'SBCY'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;


--SBBW
--0 para SIGILOSO
INSERT INTO ifrecm.documento_oficial VALUES(IFRECM.SEQ_DOC_OFICIAL_ID.NEXTVAL, 1, 'SBBW', SYSDATE, 8, 0, NULL);

--1  para OSTENSIVO
UPDATE ifrecm.documento_oficial
   SET num_documento = 1
 WHERE SIGLA_UOR = 'SBBW'
   AND TIPO_DOCUMENTO_ID = 8
   AND COD_NATUREZA = 1;
   