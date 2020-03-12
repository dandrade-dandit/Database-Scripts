
PROMPT 'IFRMAXIMO';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRGESTAO_TI' , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRSEG';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRSEG' , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRBDE';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRBDE' , estimate_percent => 25, cascade => TRUE);
PROMPT 'INTEGRACAO';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRSEG' , estimate_percent => 25, cascade => TRUE);


PROMPT 'IFRSRH';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRSRH'   , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRDBA2';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRDBA2'   , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRHUMANUS';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRHUMANUS', estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRMAT';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRMAT'   , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRLIC';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRLIC'    , estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRDOC';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRDOC'    , estimate_percent => 25, cascade => TRUE);
PROMPT 'DISCOVERER';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'DISCOVERER', estimate_percent => 25, cascade => TRUE);
PROMPT 'IFRPROUVI_OWNER';
EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'IFRPROUVI_OWNER', estimate_percent => 25, cascade => TRUE);
