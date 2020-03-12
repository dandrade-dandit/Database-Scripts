/****** Object:  LinkedServer [10.0.17.100]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.0.17.100', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.0.17.100',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.0.17.100',@useself=N'False',@locallogin=N'DBS',@rmtuser=N'sa',@rmtpassword='########'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.0.17.100',@useself=N'False',@locallogin=N'D_SEDE\I1419434',@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.0.17.100', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [CORPORATIVO]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'CORPORATIVO', @srvproduct=N'PRODSEDE', @provider=N'OraOLEDB.Oracle', @datasrc=N'PRODSEDE'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'CORPORATIVO',@useself=N'False',@locallogin=NULL,@rmtuser=N'USR_CORP_SQLSERVER',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'CORPORATIVO', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [PRODSEDE]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'PRODSEDE', @srvproduct=N'PRODSEDE', @provider=N'OraOLEDB.Oracle', @datasrc=N'PRODSEDE', @provstr=N'Provider=MSDAORA.1;Password=INFRAERO;User ID=INTEGRASS;Data Source=PRODSEDE'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'PRODSEDE',@useself=N'False',@locallogin=NULL,@rmtuser=N'integrass',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [PRODSEDE2]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'PRODSEDE2', @srvproduct=N'PRODSEDE2', @provider=N'OraOLEDB.Oracle', @datasrc=N'PRODSEDE2', @provstr=N'Provider=OraOLEDB.Oracle.1;Password=INFRAERO;User ID=INTEGRASS;Data Source=PRODSEDE2'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'PRODSEDE2',@useself=N'False',@locallogin=NULL,@rmtuser=N'INTEGRASS',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'PRODSEDE2', @optname=N'use remote collation', @optvalue=N'false'
GO

/****** Object:  LinkedServer [S-SEWN241]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-SEWN241', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SEWN241',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEWN241', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSSDSV]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSSDSV', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSSDSV',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSDSV', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSSHML]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSSHML', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSSHML',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSHML', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSSI]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSSI', @srvproduct=N'SQLSSI', @provider=N'SQLNCLI', @datasrc=N'SQLSSI', @catalog=N'master'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSSI',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSI', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSSIII]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSSIII', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSSIII',@useself=N'False',@locallogin=NULL,@rmtuser=N'DBS',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIII', @optname=N'use remote collation', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSSIV]    Script Date: 02/07/2011 12:50:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSSIV', @srvproduct=N'S_SEBN67', @provider=N'SQLNCLI', @datasrc=N'S_SEBN67', @catalog=N'master'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSSIV',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSSIV', @optname=N'use remote collation', @optvalue=N'true'
GO

