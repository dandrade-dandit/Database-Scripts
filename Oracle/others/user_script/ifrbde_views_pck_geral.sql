
CREATE OR REPLACE 
PACKAGE ifrbde_views.pck_geral AS
   -- tipos globais

   TYPE tyt_ok IS TABLE OF NUMBER (1)
      INDEX BY BINARY_INTEGER;

   SUBTYPE t_data IS CHAR (10);

   TYPE tyt_data IS TABLE OF t_data
      INDEX BY BINARY_INTEGER;

   
--------------------------------------------------------------------------------

   FUNCTION stf_cur2str (
      curvalue   IN   NUMBER
   )
      RETURN VARCHAR2;
END pck_geral;
/

-- Grants for Package
GRANT EXECUTE ON ifrbde_views.pck_geral TO bde_views
/
GRANT EXECUTE ON ifrbde_views.pck_geral TO bde_geral
/

CREATE OR REPLACE 
PACKAGE BODY ifrbde_views.pck_geral AS
   
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
END pck_geral;
/


-- End of DDL Script for Package IFRBDE_VIEWS.PCK_GERAL


