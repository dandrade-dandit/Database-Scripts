/****** Object:  LinkedServer [ S-PJBN18\PRDSBPJ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N' S-PJBN18\PRDSBPJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N' S-PJBN18\PRDSBPJ01',@useself=N'True',@locallogin=NULL,@rmtuser=N'siso_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.2.17.32]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.2.17.32', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.2.17.32',@useself=N'False',@locallogin=NULL,@rmtuser=N'siso_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.2.17.32', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.31.17.20\PRDSBRJ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.31.17.20\PRDSBRJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.31.17.20\PRDSBRJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.44.17.30\PRDSBCG01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.44.17.30\PRDSBCG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.44.17.30\PRDSBCG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.50.17.16\PRDSBRB01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.50.17.16\PRDSBRB01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.50.17.16\PRDSBRB01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.54.17.12\PRDSBPV01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.54.17.12\PRDSBPV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.54.17.12\PRDSBPV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.60.17.21]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.60.17.21', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.60.17.21',@useself=N'False',@locallogin=NULL,@rmtuser=N'siso_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.60.17.21', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.68.17.3\prdsbpk02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.68.17.3\prdsbpk02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.68.17.3\prdsbpk02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.7.17.11\PRDSRBE01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.7.17.11\PRDSRBE01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.7.17.11\PRDSRBE01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.7.17.11\PRDSRBE01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.71.129.2]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.71.129.2', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.71.129.2',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.71.129.2', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.76.17.31\PRDSBTE01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.76.17.31\PRDSBTE01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.76.17.31\PRDSBTE01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.91.17.9\PRODSBSL01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.91.17.9\PRODSBSL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.91.17.9\PRODSBSL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'10.91.17.9\PRODSBSL01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [10.94.17.6\PRDSBMA01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.94.17.6\PRDSBMA01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.94.17.6\PRDSBMA01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [10.96.17.4\prdsbcj03]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'10.96.17.4\prdsbcj03', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'10.96.17.4\prdsbcj03',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [ODBC-SBIL]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBIL', @srvproduct=N'ODBC-SBIL', @provider=N'MSDASQL', @datasrc=N'ODBC-SBIL'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBIL',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBIL', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBJP]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBJP', @srvproduct=N'ODBC-SBJP', @provider=N'MSDASQL', @datasrc=N'ODBC-SBJP'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBJP',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJP', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBJU]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBJU', @srvproduct=N'ODBC-SBJU', @provider=N'MSDASQL', @datasrc=N'ODBC-SBJU'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBJU',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBJU', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBKG]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBKG', @srvproduct=N'ODBC-SBKG', @provider=N'MSDASQL', @datasrc=N'ODBC-SBKG'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBKG',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBKG', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBME]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBME', @srvproduct=N'ODBC-SBME', @provider=N'MSDASQL', @datasrc=N'ODBC-SBME'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBME',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [ODBC-SBNT]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBNT', @srvproduct=N'ODBC-SBNT', @provider=N'MSDASQL', @datasrc=N'ODBC-SBNT'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBNT',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [ODBC-SBPL]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBPL', @srvproduct=N'ODBC-SBPL', @provider=N'MSDASQL', @datasrc=N'ODBC-SBPL'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBPL',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBPL', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [ODBC-SBSJ]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'ODBC-SBSJ', @srvproduct=N'ODBC-SBSJ', @provider=N'MSDASQL', @datasrc=N'ODBC-SBSJ'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'ODBC-SBSJ',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'ODBC-SBSJ', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_CRBN03]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_CRBN03', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_CRBN03',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_CRBN03', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_LOBN08\PRDSBLO01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_LOBN08\PRDSBLO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_LOBN08\PRDSBLO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S_LOBN08\PRDSBLO01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S_MQGN06\PRODSBMQ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_MQGN06\PRODSBMQ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_MQGN06\PRODSBMQ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S_SNGN06\PRODSBSN01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_SNGN06\PRODSBSN01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_SNGN06\PRODSBSN01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S_UGGN01\PRDSBUG01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S_UGGN01\PRDSBUG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S_UGGN01\PRDSBUG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-ARSN01\PRDSBAR01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-ARSN01\PRDSBAR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-ARSN01\PRDSBAR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-bhbn23\prdsbbh01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-bhbn23\prdsbbh01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-bhbn23\prdsbbh01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-BIBN02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-BIBN02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-BIBN02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-BIBN02', @optname=N'rpc out', @optvalue=N'false'
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

/****** Object:  LinkedServer [S-BRBN19\PRDSBBR01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-BRBN19\PRDSBBR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-BRBN19\PRDSBBR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-bvsiv01\prdsbbv01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-bvsiv01\prdsbbv01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-bvsiv01\prdsbbv01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-CFBN32\PRDSBCF02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CFBN32\PRDSBCF02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CFBN32\PRDSBCF02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-CMGN02\prdsbcm01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CMGN02\prdsbcm01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CMGN02\prdsbcm01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-cpbn03\prdsbcp01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-cpbn03\prdsbcp01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-cpbn03\prdsbcp01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-CRBN03\PRDSBCR01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CRBN03\PRDSBCR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CRBN03\PRDSBCR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-CTBN24\PRDSBCT01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CTBN24\PRDSBCT01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CTBN24\PRDSBCT01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-CYBN12\PRDSBCY01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-CYBN12\PRDSBCY01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-CYBN12\PRDSBCY01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-czsiv01\prdsbcz01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-czsiv01\prdsbcz01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-czsiv01\prdsbcz01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-FIBN09\PRDSBFI02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FIBN09\PRDSBFI02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FIBN09\PRDSBFI02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-FLBN06\prdsbfl01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FLBN06\prdsbfl01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FLBN06\prdsbfl01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-FZSN01\PRDSBFZ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-FZSN01\PRDSBFZ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-FZSN01\PRDSBFZ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-GOBN17\PRDSBGO01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-GOBN17\PRDSBGO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-GOBN17\PRDSBGO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-HTGN07\PRODSBHT02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-HTGN07\PRODSBHT02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-HTGN07\PRODSBHT02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-HTGN07\PRODSBHT02', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-ILBN08]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-ILBN08', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-ILBN08',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-ILBN08', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-IZGN07\PRDSBIZ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-IZGN07\PRDSBIZ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-IZGN07\PRDSBIZ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-JVBN10\PRDSBJV01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-JVBN10\PRDSBJV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-JVBN10\PRDSBJV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-KGSN01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-KGSN01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-KGSN01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-KGSN01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-MESIV06]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MESIV06', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MESIV06',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MESIV06', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-MKAN02\PRDSBMK01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MKAN02\PRDSBMK01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MKAN02\PRDSBMK01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-MNSIV01\PRDSBEG01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MNSIV01\PRDSBEG01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MNSIV01\PRDSBEG01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-MOSN01\PRDSBMO01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-MOSN01\PRDSBMO01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-MOSN01\PRDSBMO01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-MOSN01\PRDSBMO01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-NFBN06\PRDSBNF01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-NFBN06\PRDSBNF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-NFBN06\PRDSBNF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-NTSN01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-NTSN01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-NTSN01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-NTSN01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-PABN05\PRDSBPA01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PABN05\PRDSBPA01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PABN05\PRDSBPA01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-PJBN18\PRDSBPJ01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PJBN18\PRDSBPJ01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PJBN18\PRDSBPJ01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-PLSN01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-PLSN01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-PLSN01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-PLSN01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQL1SBRF\PRDSBRF01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQL1SBRF\PRDSBRF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQL1SBRF\PRDSBRF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [sqlsbsp\prdsbsp01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'sqlsbsp\prdsbsp01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'sqlsbsp\prdsbsp01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'sqlsbsp\prdsbsp01', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [SQLSISOGRU\PRDSBGR01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSISOGRU\PRDSBGR01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSISOGRU\PRDSBGR01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [SQLSISOVCP\PRDSBKP01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQLSISOVCP\PRDSBKP01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQLSISOVCP\PRDSBKP01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-RJBN135\PRDSBGL01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-RJBN135\PRDSBGL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-RJBN135\PRDSBGL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-SEBN146\PROD]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-SEBN146\PROD', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SEBN146\PROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_linkedserver',@rmtpassword='########'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SEBN146\PROD',@useself=N'False',@locallogin=N'usr_auditoria',@rmtuser=N'usr_linkedserver',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'S-SEBN146\PROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [S-SVBN25\PRDSBSV01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-SVBN25\PRDSBSV01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-SVBN25\PRDSBSV01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-TFSIV01\PRDSBTF01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-TFSIV01\PRDSBTF01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-TFSIV01\PRDSBTF01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [S-TTSIV01\PRDSBTT01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'S-TTSIV01\PRDSBTT01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'S-TTSIV01\PRDSBTT01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-ulbn18\PRDSBUL01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-ulbn18\PRDSBUL01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-ulbn18\PRDSBUL01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-urbn18\prdsbur01]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-urbn18\prdsbur01', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-urbn18\prdsbur01',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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

/****** Object:  LinkedServer [s-vtbn08\prdsbvt02]    Script Date: 12/07/2010 13:58:41 ******/
EXEC master.dbo.sp_addlinkedserver @server = N's-vtbn08\prdsbvt02', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N's-vtbn08\prdsbvt02',@useself=N'False',@locallogin=NULL,@rmtuser=N'usr_sivnet_carga',@rmtpassword='########'

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


