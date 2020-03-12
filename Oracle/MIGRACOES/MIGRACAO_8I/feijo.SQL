CREATE INDEX ifrselo.hlsi_2 ON ifrselo.hst_leitura_selos
  ( dep_codigo_leitura,
    dat_leitura_selo,
    serie_selo, num_selo
   )
tablespace tsi_selo
/
