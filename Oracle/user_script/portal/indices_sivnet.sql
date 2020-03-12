drop INDEX ifrsivnet.ix_loc_nm_aeroporto
/

DROP INDEX ifrsivnet.ix_cia_nm_cia
/

CREATE INDEX ifrsivnet.ix_loc_nm_aeroporto ON ifrsivnet.localidade
  ( nm_aeroporto )
indextype is ctxsys.context
/

CREATE INDEX ifrsivnet.ix_cia_nm_cia ON ifrsivnet.cia_aerea
  (   nome_cia  )
indextype is ctxsys.context
/
