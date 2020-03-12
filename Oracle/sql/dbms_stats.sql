--Por tabela

DBMS_STATS.GATHER_TABLE_STATS (ownname => 'IFRMAXIMO', tabname => 'LEITURA_SELOS', estimate_percent => 25 );

--Por Owner

EXEC DBMS_STATS.GATHER_SCHEMA_STATS (ownname=> 'IFRSRH2', estimate_percent => 25, cascade=> TRUE );
EXEC DBMS_STATS.GATHER_SCHEMA_STATS (ownname=> 'INTDBA2', estimate_percent => 25, cascade=> TRUE );
EXEC DBMS_STATS.GATHER_SCHEMA_STATS (ownname=> 'IFRMAXIMO', estimate_percent => 25, cascade=> TRUE );

--Por Índice

exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_TEMP', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX19', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX17', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX11', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX12', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX13', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX10', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX14', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX5', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX6', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX16', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX18', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX1', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX2', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX3', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX4', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX7', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX8', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX9', estimate_percent => 25 );
exec DBMS_STATS.GATHER_INDEX_STATS (ownname => 'IFRMAXIMO', indname => 'WORKORDER_NDX15', estimate_percent => 25 );
