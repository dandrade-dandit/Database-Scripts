
CREATE OR REPLACE VIEW viw_natureza (
   codigo,
   desc_natureza )
AS
SELECT a.ntf_cod,    b.nto_desc
                  || ' - '
                  || a.ntf_desc
  FROM tab_natureza_obra_fil a, tab_natureza_obra b
 WHERE b.nto_cod = a.ntf_nto_cod
 order by a.ntf_cod
/


