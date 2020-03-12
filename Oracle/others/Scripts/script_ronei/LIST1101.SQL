-- Este ‚ um script de comandos para executar uma copia online do banco
-- de dados VENDAS. Antes de executar este script, use o SQL*DBA para
-- conectar-se ao banco de dados com uma identifica‡Æo de usu rio que
-- tenha os seguintes privil‚gios de sistema: ALTER DATABASE,
-- MANAGE TABLESPACE. Al‚m disso, o usu rio executando o script deve ter
-- as permissäes de arquivos para os arquivos e diret¢rios especificados.

-- limpa arquivos de copia antigos do diret¢rio de copia
host rm /tmp/dbbackup/*

-- faz a copia do tablespace SYSTEM
ALTER TABLESPACE system BEGIN BACKUP;
host cp $ORACLE_HOME/dbs/systvend.dbf /tmp/dbbackup/systvend.dbf
ALTER TABLESPACE system END BACKUP;

-- faz a copia do tablespace RBS
ALTER TABLESPACE rbs BEGIN BACKUP;
host cp $ORACLE_HOME/dbs/rbsvend.dbf /tmp/dbbackup/rbsvend.dbf
ALTER TABLESPACE rbs END BACKUP;

-- faz a copia do tablespace TEMP
ALTER TABLESPACE temp BEGIN BACKUP;
host cp $ORACLE_HOME/dbs/tempvend.dbf /tmp/dbbackup/tempvend.dbf
ALTER TABLESPACE temp END BACKUP;

-- faz a copia do tablespace TOOLS
ALTER TABLESPACE tools BEGIN BACKUP;
host cp $ORACLE_HOME/dbs/toolvend.dbf /tmp/dbbackup/toolvend.dbf
ALTER TABLESPACE tools END BACKUP;

-- faz a copia do tablespace USERS
ALTER TABLESPACE users BEGIN BACKUP;
host cp $ORACLE_HOME/dbs/usrvend.dbf /tmp/dbbackup/usrvend.dbf
ALTER TABLESPACE users END BACKUP;

-- faz a copia do arquivo de controle do banco de dados
ALTER DATABASE BACKUP CONTROLFILE TO '/tmp/dbbackup/ctrlvendas.ctl'

-- faz a copia dos arquivos de parƒmetros de inicializa‡Æo do banco de dados
host cp $ORACLE_HOME/dbs/*.ora /tmp/dbbackup
-- faz a copia dos arquivos de configura‡Æo do SQL*Net V2 do servidor
host cp /etc/*.ora /tmp/dbbackup

-- faz a copia de scripts de administra‡Æo especiais
host cp $ORACLE_HOME/rdbms/admin/~*.sql /tmp/dbbackup

-- arquiva e comprime os arquivos no diret¢rio de copia
host tar -cvf /tmp/dbbackup/dbbackup.tar /tmp/dbbackup/*
host compress /tmp/dbbackup/dbbackup.tar

-- limpa todos os arquivos de copia tempor rios do diret¢rio de copia,
-- exceto o arquivo de copia comprimido
host rm /tmp/dbbackup/*.dbf
host rm /tmp/dbbackup/*.ctl
host rm /tmp/dbbackup/*.ora
host rm /tmp/dbbackup/*.sql
