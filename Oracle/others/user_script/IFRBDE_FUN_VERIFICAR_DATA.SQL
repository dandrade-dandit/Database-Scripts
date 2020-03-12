Create Or Replace FUNCTION FUN_VERIFICAR_DATA (p_data IN DATE)
   RETURN DATE
IS
--
-- Objetivo: Ajustar o ano de uma data
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------       


-- Declare program variables as shown above

   v_data   date;

BEGIN
   
-- data 
   IF SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 7, 2) = '00'
   THEN
      IF SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 9, 2) < '60'
      THEN
         v_data := TO_DATE (
                         SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 1, 6)
                      || '20'
                      || SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 9, 2),
                      'dd/mm/yyyy'
                   );
      ELSE
         v_data := TO_DATE (
                         SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 1, 6)
                      || '19'
                      || SUBSTR (TO_CHAR (p_data, 'dd/mm/yyyy'), 9, 2),
                      'dd/mm/yyyy'
                   );
      END IF;
   END IF;
   RETURN v_data ;
EXCEPTION
   WHEN others
   THEN
      RETURN to_date('01/01/1900','dd/mm/yyyy') ;
END;
