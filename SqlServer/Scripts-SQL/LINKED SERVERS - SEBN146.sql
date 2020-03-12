/****** Object:  LinkedServer [ S-PJBN18\PRDSBPJ01]    Script Date: 05/18/2012 10:28:11 ******/
EXEC master.dbo.sp_addlinkedserver @server = N' S-PJBN18\PRDSBPJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N' S-PJBN18\PRDSBPJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N' S-PJBN18\PRDSBPJ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.31.17.20\PRDSBRJ01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.31.17.20\PRDSBRJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.31.17.20\PRDSBRJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.31.17.20\PRDSBRJ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.41.17.100\prdsbsp01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.41.17.100\prdsbsp01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.41.17.100\prdsbsp01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.41.17.100\prdsbsp01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.44.17.30\PRDSBCG01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.44.17.30\PRDSBCG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.44.17.30\PRDSBCG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.44.17.30\PRDSBCG01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.46.17.12\PRDSBSJ01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.46.17.12\PRDSBSJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.46.17.12\PRDSBSJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.46.17.12\PRDSBSJ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.50.17.16\PRDSBRB01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.50.17.16\PRDSBRB01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.50.17.16\PRDSBRB01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.50.17.16\PRDSBRB01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.54.17.12\PRDSBPV01]    Script Date: 05/18/2012 10:28:12 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.54.17.12\PRDSBPV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.54.17.12\PRDSBPV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.54.17.12\PRDSBPV01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.68.17.3\prdsbpk02]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.68.17.3\prdsbpk02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.68.17.3\prdsbpk02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.68.17.3\prdsbpk02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.76.17.31\PRDSBTE01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.76.17.31\PRDSBTE01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.76.17.31\PRDSBTE01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.76.17.31\PRDSBTE01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.91.17.6\PRODSBSL01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.91.17.6\PRODSBSL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.91.17.6\PRODSBSL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.6\PRODSBSL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.94.17.6\PRDSBMA01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.94.17.6\PRDSBMA01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.94.17.6\PRDSBMA01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.94.17.6\PRDSBMA01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.96.17.4\prdsbcj03]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.96.17.4\prdsbcj03', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.96.17.4\prdsbcj03',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.96.17.4\prdsbcj03', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBME]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBME', @srvproduct=N'ODBC-SBME', @provider=N'MSDASQL', @datasrc=N'ODBC-SBME'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBME',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBME', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBNT]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBNT', @srvproduct=N'ODBC-SBNT', @provider=N'MSDASQL', @datasrc=N'ODBC-SBNT'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBNT',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBNT', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_MQGN06\PRODSBMQ01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_MQGN06\PRODSBMQ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_MQGN06\PRODSBMQ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_MQGN06\PRODSBMQ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_SLSN10\BACKSBSL01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_SLSN10\BACKSBSL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_SLSN10\BACKSBSL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SLSN10\BACKSBSL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_SNGN06\PRODSBSN01]    Script Date: 05/18/2012 10:28:13 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_SNGN06\PRODSBSN01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_SNGN06\PRODSBSN01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_SNGN06\PRODSBSN01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_UGGN01\PRDSBUG01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_UGGN01\PRDSBUG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_UGGN01\PRDSBUG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_UGGN01\PRDSBUG01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-ARSN01\PRDSBAR01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-ARSN01\PRDSBAR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-ARSN01\PRDSBAR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ARSN01\PRDSBAR01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-bhbn23\prdsbbh01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-bhbn23\prdsbbh01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-bhbn23\prdsbbh01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-bhbn23\prdsbbh01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-BIBN02]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-BIBN02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-BIBN02',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL

GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-BRBN177\PROD]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-BRBN177\PROD', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-BRBN177\PROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN177\PROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-BRBN19\PRDSBBR01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-BRBN19\PRDSBBR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-BRBN19\PRDSBBR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BRBN19\PRDSBBR01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-bvsiv01\prdsbbv01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-bvsiv01\prdsbbv01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-bvsiv01\prdsbbv01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-bvsiv01\prdsbbv01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-CFBN32\PRDSBCF02]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CFBN32\PRDSBCF02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CFBN32\PRDSBCF02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CFBN32\PRDSBCF02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-CMGN02\prdsbcm01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CMGN02\prdsbcm01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CMGN02\prdsbcm01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CMGN02\prdsbcm01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-cpbn03\prdsbcp01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-cpbn03\prdsbcp01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-cpbn03\prdsbcp01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-cpbn03\prdsbcp01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-CRBN03\PRDSBCR01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CRBN03\PRDSBCR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CRBN03\PRDSBCR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CRBN03\PRDSBCR01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-CTBN24\PRDSBCT01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CTBN24\PRDSBCT01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CTBN24\PRDSBCT01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CTBN24\PRDSBCT01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-CYBN12\PRDSBCY01]    Script Date: 05/18/2012 10:28:14 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CYBN12\PRDSBCY01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CYBN12\PRDSBCY01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-CYBN12\PRDSBCY01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-czsiv01\prdsbcz01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-czsiv01\prdsbcz01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-czsiv01\prdsbcz01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-czsiv01\prdsbcz01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-FIBN09\PRDSBFI02]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FIBN09\PRDSBFI02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FIBN09\PRDSBFI02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FIBN09\PRDSBFI02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-FLBN06\prdsbfl01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FLBN06\prdsbfl01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FLBN06\prdsbfl01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FLBN06\prdsbfl01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-FZSN01\PRDSBFZ01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FZSN01\PRDSBFZ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FZSN01\PRDSBFZ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-FZSN01\PRDSBFZ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-GOBN17\PRDSBGO01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-GOBN17\PRDSBGO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-GOBN17\PRDSBGO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-GOBN17\PRDSBGO01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-HTBN101\PRODSBHT01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-HTBN101\PRODSBHT01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-HTBN101\PRODSBHT01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTBN101\PRODSBHT01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-ILBN07\PRDSBIL01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-ILBN07\PRDSBIL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-ILBN07\PRDSBIL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN07\PRDSBIL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-ILBN08\PRDSBIL01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-ILBN08\PRDSBIL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-ILBN08\PRDSBIL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08\PRDSBIL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-IZGN07\PRDSBIZ01]    Script Date: 05/18/2012 10:28:15 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-IZGN07\PRDSBIZ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-IZGN07\PRDSBIZ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-IZGN07\PRDSBIZ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-JPSN02\PRDSBJP02]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-JPSN02\PRDSBJP02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-JPSN02\PRDSBJP02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JPSN02\PRDSBJP02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-JUSN01\PRDSBJU02]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-JUSN01\PRDSBJU02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-JUSN01\PRDSBJU02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JUSN01\PRDSBJU02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-JVBN10\PRDSBJV01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-JVBN10\PRDSBJV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-JVBN10\PRDSBJV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-JVBN10\PRDSBJV01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-KGSN02\PRDSBKG02]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-KGSN02\PRDSBKG02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-KGSN02\PRDSBKG02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN02\PRDSBKG02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-LOBN31\PRDSBLO31]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-LOBN31\PRDSBLO31', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-LOBN31\PRDSBLO31',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-LOBN31\PRDSBLO31', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-MKAN02\PRDSBMK01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MKAN02\PRDSBMK01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MKAN02\PRDSBMK01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MKAN02\PRDSBMK01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-MNSIV01\PRDSBEG01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MNSIV01\PRDSBEG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MNSIV01\PRDSBEG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MNSIV01\PRDSBEG01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-MOBN20\PRDSBMO01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MOBN20\PRDSBMO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MOBN20\PRDSBMO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOBN20\PRDSBMO01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-NFBN06\PRDSBNF01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-NFBN06\PRDSBNF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-NFBN06\PRDSBNF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NFBN06\PRDSBNF01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-PABN05\PRDSBPA01]    Script Date: 05/18/2012 10:28:16 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PABN05\PRDSBPA01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PABN05\PRDSBPA01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PABN05\PRDSBPA01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-PJBN18\PRDSBPJ01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PJBN18\PRDSBPJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PJBN18\PRDSBPJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PJBN18\PRDSBPJ01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-PLSN02\PRDSBPL02]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PLSN02\PRDSBPL02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PLSN02\PRDSBPL02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN02\PRDSBPL02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQL1SBRF\PRDSBRF01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQL1SBRF\PRDSBRF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQL1SBRF\PRDSBRF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL1SBRF\PRDSBRF01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSISOGRU\PRDSBGR01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSISOGRU\PRDSBGR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSISOGRU\PRDSBGR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOGRU\PRDSBGR01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSISOVCP\PRDSBKP01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSISOVCP\PRDSBKP01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSISOVCP\PRDSBKP01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSISOVCP\PRDSBKP01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSRNO01\PRODSRNO01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSRNO01\PRODSRNO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSRNO01\PRODSRNO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQLSRNO01\PRODSRNO01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-RJBN135\PRDSBGL01]    Script Date: 05/18/2012 10:28:17 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-RJBN135\PRDSBGL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-RJBN135\PRDSBGL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-RJBN135\PRDSBGL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-SVBN24\PRDSBSV01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-SVBN24\PRDSBSV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SVBN24\PRDSBSV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN24\PRDSBSV01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-SVBN25\PRDSBSV01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-SVBN25\PRDSBSV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SVBN25\PRDSBSV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SVBN25\PRDSBSV01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-TFSIV01\PRDSBTF01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-TFSIV01\PRDSBTF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-TFSIV01\PRDSBTF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TFSIV01\PRDSBTF01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-TTSIV01\PRDSBTT01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-TTSIV01\PRDSBTT01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-TTSIV01\PRDSBTT01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-TTSIV01\PRDSBTT01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-ulbn18\PRDSBUL01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-ulbn18\PRDSBUL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-ulbn18\PRDSBUL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-ulbn18\PRDSBUL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-urbn18\prdsbur01]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-urbn18\prdsbur01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-urbn18\prdsbur01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-urbn18\prdsbur01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [s-vtbn08\prdsbvt02]    Script Date: 05/18/2012 10:28:18 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-vtbn08\prdsbvt02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-vtbn08\prdsbvt02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='sivnet@usr'

GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N's-vtbn08\prdsbvt02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


