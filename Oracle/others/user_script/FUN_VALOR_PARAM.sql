


CREATE OR REPLACE
function FUN_VALOR_PARAM (p_cod_grupo   IN TAB_PARAMETROS.cod_grupo%TYPE,
                          p_cod_assunto IN TAB_PARAMETROS.cod_assunto%TYPE
                          )
RETURN VARCHAR2 IS
  v_valor TAB_PARAMETROS_DETALHES.valor%TYPE;
BEGIN
  BEGIN
    SELECT VALOR
      INTO v_valor
      FROM TAB_PARAMETROS_DETALHES
     WHERE COD_GRUPO = p_cod_grupo
       AND COD_ASSUNTO = p_cod_assunto
       AND DATA_TERMINO IS NULL;
    --    
  EXCEPTION
    WHEN OTHERS THEN
      v_valor := NULL; 
  END; 
  --
  RETURN v_valor;
END;
/



