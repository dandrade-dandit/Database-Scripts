CREATE PROCEDURE reportproceduresize (objowner IN VARCHAR2) AS
-- Este procedimento imprime um relat¢rio com o tamanho de todos os
-- procedimentos, fun‡äes, especifica‡äes de pacotes e corpos de pacotes
-- no esquema especificado.

-- Uso: EXECUTE reportproceduresize('xxx')
-- Onde: xxx = nome do esquema

-- cursor para selecionar o espa‡o de armazenamento necess rio para as
-- diversas partes de um procedimento
CURSOR objectsize (own IN VARCHAR2) IS
  SELECT owner, name, type, source_size,
    (source_size+parced_size+code_size+error_size) total_size,
    ROUND((source_size+parced_size+code_size+error_size) / source_size,1)
    storage_factor
    FROM sys.dba_object_size
    WHERE owner = own
    AND type IN ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');

BEGIN
-- imprime cabe‡alho do relat¢rio
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Relatorio de Tamanho do Objeto '||SYSDATE);
DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
DBMS_OUTPUT.PUT_LINE('');
-- imprime relat¢rio de tamanho dos componentes do objeto
FOR dbobjectsize IN objectsize (UPPER(objowner)) LOOP
  DBMS_OUTPUT.PUT_LINE('Nome do Objeto:                     '
    ||dbobjectsize.name);
  DBMS_OUTPUT.PUT_LINE('Tipo do Objeto:                     '
    ||dbobjectsize.type);
  DBMS_OUTPUT.PUT_LINE('Tamanho do Fonte do Objeto:         '
    ||dbobjectsize.source_size);
  DBMS_OUTPUT.PUT_LINE('Tamanho Total do Objeto:            '
    ||dbobjectsize.total_size);
  DBMS_OUTPUT.PUT_LINE('Fator de Armazenamento Fonte->Total '
    ||dbobjectsize.storage_factor);
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;
END reportproceduresize;
