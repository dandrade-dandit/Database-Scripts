USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[psp_procurar_coletor]    Script Date: 12/14/2010 09:49:26 ******/
-- exec psp_procurar_coletor '101601949'


if exists(select * from sysobjects where name = 'psp_procurar_coletor')
   drop procedure psp_procurar_coletor
go


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[psp_procurar_coletor] 
(	        @p_serie_coletor	     varchar(9) )
As
    select c.dependencia
      from GEACupax..pax_coletor_u        c (nolock)
     Where serial               = @p_serie_coletor
       And c.inactive_ind 		= '0'

go
Grant Execute On psp_procurar_coletor To Public
go