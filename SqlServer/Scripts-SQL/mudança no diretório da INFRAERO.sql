insert into ifrdoc.bkp_20100208_cad_doc_geral
SELECT   seq_documento,
  DAT_DOCUMENTO_ORIGINAL,
  DSC_DIRETORIO_IMAGEM,
  ANO_PROTOCOLO,
  'D:\INFRADOC\Imagem\' || decode(ano_protocolo,null,to_char(DAT_DOCUMENTO_ORIGINAL, 'yyyy'),ano_protocolo) || '\' || to_char(DAT_DOCUMENTO_ORIGINAL, 'mm') || '\' || substr(DSC_DIRETORIO_IMAGEM,20, 40) as novo_dir
FROM IFRDOC.CAD_DOCUMENTO_GERAL 
where DSC_DIRETORIO_IMAGEM > ' ';

UPDATE  IFRDOC.CAD_DOCUMENTO_GERAL 
   SET  DSC_DIRETORIO_IMAGEM = 'D:\INFRADOC\Imagem\' || decode(ano_protocolo,null,to_char(DAT_DOCUMENTO_ORIGINAL, 'yyyy'),ano_protocolo) || '\' || to_char(DAT_DOCUMENTO_ORIGINAL, 'mm') || '\' || substr(DSC_DIRETORIO_IMAGEM,20, 40),
        DSC_DIRETORIO_IMAGEM_OLD_DIR = DSC_DIRETORIO_IMAGEM
where   DSC_DIRETORIO_IMAGEM > ' ';        
        
SELECT  *
FROM   IFRDOC.CAD_DOCUMENTO_GERAL 
where DSC_DIRETORIO_IMAGEM > ' ';

/*
create table ifrdoc.bkp_20100208_cad_doc_geral (
seq_documento number(10),
DAT_DOCUMENTO_ORIGINAL date,
DSC_DIRETORIO_IMAGEM varchar(200),
ANO_PROTOCOLO number(4),
DSC_DIRETORIO_IMAGEM_novo_dir varchar(200))

alter table IFRDOC.CAD_DOCUMENTO_GERAL add DSC_DIRETORIO_IMAGEM_OLD_DIR varchar(200)

ALTER TRIGGER IFRDOC.TRG_DEL_DOC_GERAL DISABLE;
ALTER TRIGGER IFRDOC.TRG_DOC_IUD DISABLE;

ALTER TRIGGER IFRDOC.TRG_DEL_DOC_GERAL ENABLE;
ALTER TRIGGER IFRDOC.TRG_DOC_IUD ENABLE;


SELECT    'move ' ||  substr(DSC_DIRETORIO_IMAGEM,20, 40) || ' ' || 
          decode(ano_protocolo,null,to_char(DAT_DOCUMENTO_ORIGINAL, 'yyyy'),ano_protocolo) || '\' || to_char(DAT_DOCUMENTO_ORIGINAL, 'mm') || '\' || substr(DSC_DIRETORIO_IMAGEM,20, 40) as novo_doc 
FROM IFRDOC.CAD_DOCUMENTO_GERAL 
where DSC_DIRETORIO_IMAGEM > ' '
ORDER BY DAT_DOCUMENTO_ORIGINAL;

select * from (
SELECT    'md ' || decode(ano_protocolo,null,to_char(DAT_DOCUMENTO_ORIGINAL, 'yyyy'),ano_protocolo) || '\' || to_char(DAT_DOCUMENTO_ORIGINAL, 'mm') as criar_pastas 
FROM IFRDOC.CAD_DOCUMENTO_GERAL 
where DSC_DIRETORIO_IMAGEM > ' ')
group by criar_pastas

*/
