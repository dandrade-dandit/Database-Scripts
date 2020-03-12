restore database pubs
from disk = 'F:\PUBS_FULL.BAK'
with norecovery

restore log pubs
from disk = 'F:\PUBS_LOG.BAK'
with recovery