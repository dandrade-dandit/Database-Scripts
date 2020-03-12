

CREATE OR REPLACE TRIGGER LOG_AUDIT_DOCUMENTOS_COBRANCA
after insert  or delete  or update
  of DOC_NUMERO,            
     DOC_CBE_BEN_SIGLA,               
     DOC_CBE_CRE_SEQUENCIAL,          
     DOC_DATA,                       
     DOC_TIPO,                        
     DOC_EMB_EMP_NUMERO_MATRICULA,    
     DOC_PVI_SEQUENCIAL,              
     DOC_DEP_CODIGO,                           
     DOC_VALOR_PARTICIPACAO,          
     DOC_MES_PAGAMENTO,               
     DOC_ANO_PAGAMENTO,              
     DOC_PROCESSO_ENCERRADO,          
     DOC_NR_DOC_FISCAL,               
     DOC_DEP_RESP_INCL,               
     DOC_TIPO_PEDIDO,
     DOC_SISTEMA,
     DOC_DATA_CRIACAO,
     DOC_DATA_GERACAO_PARTICIPACAO    

on DOCUMENTOS_COBRANCA

referencing new as new old as old

for each row

declare

begin

  if inserting then

      insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
      (cod_usuario,
       DTA_OPERACAO,
       tip_operacao,
       DOC_NUMERO_NEW,
       DOC_CBE_BEN_SIGLA_NEW,
       DOC_CBE_CRE_SEQUENCIAL_NEW,
       DOC_DATA_NEW,
       DOC_TIPO_NEW,
       DOC_EMB_EMP_NUMERO_MATRICULA_NEW,
       DOC_PVI_SEQUENCIAL_NEW,
       DOC_DEP_CODIGO_NEW,
       DOC_VALOR_PARTICIPACAO_NEW,
       DOC_MES_PAGAMENTO_NEW,
       DOC_ANO_PAGAMENTO_NEW,
       DOC_PROCESSO_ENCERRADO_NEW,
       DOC_NR_DOC_FISCAL_NEW,  
       DOC_DEP_RESP_INCL_NEW,
       DOC_TIPO_PEDIDO_NEW,
       DOC_SISTEMA_NEW,
       DOC_DATA_CRIACAO_NEW,
       DOC_DATA_GERACAO_PARTICIPACAO_NEW)
       values  (user,
              to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
              'I', 
              :NEW.DOC_NUMERO,            
              :NEW.DOC_CBE_BEN_SIGLA,               
              :NEW.DOC_CBE_CRE_SEQUENCIAL,
              :NEW.DOC_DATA,
              :NEW.DOC_TIPO,
              :NEW.DOC_EMB_EMP_NUMERO_MATRICULA,
              :NEW.DOC_PVI_SEQUENCIAL,
              :NEW.DOC_VALOR_PARTICIPACAO,
              :NEW.DOC_MES_PAGAMENTO,
              :NEW.DOC_ANO_PAGAMENTO,
              :NEW.DOC_PROCESSO_ENCERRADO,
              :NEW.DOC_NR_DOC_FISCAL,  
              :NEW.DOC_DEP_RESP_INCL,
              :NEW.DOC_TIPO_PEDIDO,
              :NEW.DOC_SISTEMA,
              :NEW.DOC_DATA_CRIACAO,
              :NEW.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;

  if deleting then

      insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
      (cod_usuario,
       DTA_OPERACAO,,
       tip_operacao,
       DOC_NUMERO_OLD,
       DOC_CBE_BEN_SIGLA_OLD,
       DOC_CBE_CRE_SEQUENCIAL_OLD,
       DOC_DATA_OLD,
       DOC_TIPO_OLD,
       DOC_EMB_EMP_NUMERO_MATRICULA_OLD,
       DOC_PVI_SEQUENCIAL_OLD,
       DOC_DEP_CODIGO_OLD,
       DOC_VALOR_PARTICIPACAO_OLD,
       DOC_MES_PAGAMENTO_OLD,
       DOC_ANO_PAGAMENTO_OLD,
       DOC_PROCESSO_ENCERRADO_OLD,
       DOC_NR_DOC_FISCAL_OLD,
       DOC_DEP_RESP_INCL_OLD,
       DOC_TIPO_PEDIDO_OLD,
       DOC_SISTEMA_OLD,
       DOC_DATA_CRIACAO_OLD,
       DOC_DATA_GERACAO_PARTICIPACAO_OLD)
       values  (user,
              to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
              'I', 
              :OLD.DOC_NUMERO,            
              :OLD.DOC_CBE_BEN_SIGLA,               
              :OLD.DOC_CBE_CRE_SEQUENCIAL,
              :OLD.DOC_DATA,
              :OLD.DOC_TIPO,
              :OLD.DOC_EMB_EMP_NUMERO_MATRICULA,
              :OLD.DOC_PVI_SEQUENCIAL,
              :OLD.DOC_VALOR_PARTICIPACAO,
              :OLD.DOC_MES_PAGAMENTO,
              :OLD.DOC_ANO_PAGAMENTO,
              :OLD.DOC_PROCESSO_ENCERRADO,
              :OLD.DOC_NR_DOC_FISCAL,  
              :OLD.DOC_DEP_RESP_INCL,
              :OLD.DOC_TIPO_PEDIDO,
              :OLD.DOC_SISTEMA,
              :OLD.DOC_DATA_CRIACAO,
              :OLD.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;

  if updating then

     insert into LOG_AUDIT_DOCUMENTOS_COBRANCA
     (cod_usuario,
      dta_operacao,
      tip_operacao,
      DOC_NUMERO_NEW,
      DOC_CBE_BEN_SIGLA_NEW,
      DOC_CBE_CRE_SEQUENCIAL_NEW,
      DOC_DATA_NEW,
      DOC_TIPO_NEW,
      DOC_EMB_EMP_NUMERO_MATRICULA_NEW,
      DOC_PVI_SEQUENCIAL_NEW,
      DOC_DEP_CODIGO_NEW,
      DOC_VALOR_PARTICIPACAO_NEW,
      DOC_MES_PAGAMENTO_NEW,
      DOC_ANO_PAGAMENTO_NEW,
      DOC_PROCESSO_ENCERRADO_NEW,
      DOC_NR_DOC_FISCAL_NEW,  
      DOC_DEP_RESP_INCL_NEW,
      DOC_TIPO_PEDIDO_NEW,
      DOC_SISTEMA_NEW,
      DOC_DATA_CRIACAO_NEW,
      DOC_DATA_GERACAO_PARTICIPACAO_NEW,
      DOC_NUMERO_OLD,
      DOC_CBE_BEN_SIGLA_OLD,
      DOC_CBE_CRE_SEQUENCIAL_OLD,
      DOC_DATA_OLD,
      DOC_TIPO_OLD,
      DOC_EMB_EMP_NUMERO_MATRICULA_OLD,
      DOC_PVI_SEQUENCIAL_OLD,
      DOC_DEP_CODIGO_OLD,
      DOC_VALOR_PARTICIPACAO_OLD,
      DOC_MES_PAGAMENTO_OLD,
      DOC_ANO_PAGAMENTO_OLD,
      DOC_PROCESSO_ENCERRADO_OLD,
      DOC_NR_DOC_FISCAL_OLD,
      DOC_DEP_RESP_INCL_OLD,
      DOC_TIPO_PEDIDO_OLD,
      DOC_SISTEMA_OLD,
      DOC_DATA_CRIACAO_OLD,
      DOC_DATA_GERACAO_PARTICIPACAO_OLD)
      values  (user,
              to_date(to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
              'A', 
              :OLD.DOC_NUMERO,            
              :OLD.DOC_CBE_BEN_SIGLA,               
              :OLD.DOC_CBE_CRE_SEQUENCIAL, 
              :NEW.DOC_DATA,
              :NEW.DOC_TIPO,
              :NEW.DOC_EMB_EMP_NUMERO_MATRICULA,
              :NEW.DOC_PVI_SEQUENCIAL,
              :OLD.DOC_DEP_CODIGO,
              :NEW.DOC_VALOR_PARTICIPACAO,
              :NEW.DOC_MES_PAGAMENTO,
              :NEW.DOC_ANO_PAGAMENTO,
              :NEW.DOC_PROCESSO_ENCERRADO,
              :NEW.DOC_NR_DOC_FISCAL,  
              :NEW.DOC_DEP_RESP_INCL,
              :NEW.DOC_TIPO_PEDIDO,
              :NEW.DOC_SISTEMA,
              :NEW.DOC_DATA_CRIACAO,
              :NEW.DOC_DATA_GERACAO_PARTICIPACAO,
              :OLD.DOC_NUMERO,            
              :OLD.DOC_CBE_BEN_SIGLA,               
              :OLD.DOC_CBE_CRE_SEQUENCIAL,
              :OLD.DOC_DATA_OLD,
              :OLD.DOC_TIPO_OLD,
              :OLD.DOC_EMB_EMP_NUMERO_MATRICULA,
              :OLD.DOC_PVI_SEQUENCIAL,
              :OLD.DOC_DEP_CODIGO,
              :OLD.DOC_VALOR_PARTICIPACAO,
              :OLD.DOC_MES_PAGAMENTO,
              :OLD.DOC_ANO_PAGAMENTO,
              :OLD.DOC_PROCESSO_ENCERRADO,
              :OLD.DOC_NR_DOC_FISCAL,
              :OLD.DOC_DEP_RESP_INCL,
              :OLD.DOC_TIPO_PEDIDO,
              :OLD.DOC_SISTEMA,
              :OLD.DOC_DATA_CRIACAO,
              :OLD.DOC_DATA_GERACAO_PARTICIPACAO);

  end if;
       
  end if;

end;
/
