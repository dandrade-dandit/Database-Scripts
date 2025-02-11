USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_ins_uqba]    Script Date: 12/20/2010 12:24:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_ins_uqba    Script Date: 19/09/2008 15:20:52 ******/


if exists(select * from sysobjects where name = 'usp_ins_uqba')
   drop procedure usp_ins_uqba
go

/*

exec usp_ins_uqba 'SBBR', '20081001', 'TAM', 'TODOS', '0'
exec usp_sel_uqba 'SBBR', '20081001', 'TAM', 'TODOS'

select * into pax_fiscal_det_u_bk_munoz_20071009 from pax_fiscal_det_u 
where cd_aerop	= 'SBBR'
and data_mov		= '20071009'

select * into pax_fiscal_head_u_u_bk_munoz_20071009 from pax_fiscal_head_u 
where cd_aerop	= 'SBBR'
and data_mov		= '20071009'

select * from pax_fiscal_head_u_u_bk_munoz_20071009

pax_fiscal_head_u
and cd_cia_aerea	= 'TAM'
and nro_voo		= 'TODOS'

order by 1,3,4,5,6,2
w
*/

Create proc [dbo].[usp_ins_uqba]
    ( @p_cd_aerop           char(4)
     ,@p_data_mov           datetime
     ,@p_cd_cia_aerea       char(3)
     ,@p_nro_voo            char(5)
     ,@p_tipo_selecao       char(1) = '1' )
As

    Set nocount on 

    If @p_tipo_selecao = '' Set @p_tipo_selecao = '1'

    /****************************************************/
    /*  BUSCAR INFORMAÇÃO DA TABELAS DE SELOS E RPE     */

    Declare @v_selo_status	char(1)
           ,@v_data_fim		datetime
           ,@v_mes_dia		char(4)
           ,@v_sql          char(8000)

    Select @v_selo_status	= '2'
          ,@v_data_fim 		= dateadd(ms, -550, dateadd(dd, 1, @p_data_mov))
          ,@v_mes_dia		= substring(convert(varchar(8), @p_data_mov,112),5,4)

    Set nocount on

    Create table  #table_xx_1
         ( cd_aerop					char(4)
          ,dt_mov					datetime
          ,cd_cia_aerea				char(4)
          ,voo_rea					char(6)
          ,qtd_selo_electronico_d	int
          ,qtd_selo_electronico_d_c	int
          ,qtd_selo_electronico_i	int
          ,qtd_selo_electronico_i_c	int
          ,qtd_selo_fisico_d		int
          ,qtd_selo_fisico_i		int
          ,qtd_selo_d				int
          ,qtd_selo_i				int	
          ,qtd_total				int	
          ,qtd_rpe					int
          ,qtd_pax_conexao			int
          ,qtd_pax_isento			int
          ,qtd_dif					int )

    Create table  #table_xx_2
         ( numero					integer IDENTITY 
          ,cd_aerop					char(4)
          ,dt_mov					datetime
          ,cd_cia_aerea				char(4)
          ,voo_rea					char(6)
          ,qtd_selo_electronico_d	int
          ,qtd_selo_electronico_d_c	int
          ,qtd_selo_electronico_i	int
          ,qtd_selo_electronico_i_c	int
          ,qtd_selo_fisico_d		int
          ,qtd_selo_fisico_i		int
          ,qtd_selo_d				int
          ,qtd_selo_i				int	
          ,qtd_total				int	
          ,qtd_rpe					int
          ,qtd_pax_conexao			int
          ,qtd_pax_isento			int
          ,qtd_dif					int )

    /*Buscar selos Fisicos*/
    If @p_nro_voo = 'TODOS' or isnumeric(@p_nro_voo) = 1
    Begin
        Insert into #table_xx_1
		Select cd_aerop					= a.cd_aerop_utilizacao
              ,dt_mov					= convert(varchar(8),a.dt_mov,112)
              ,cd_cia_aerea				= a.cd_cia_aerea
              ,voo_rea					= 'FISIC'
              ,qtd_selo_electronico_d	= Sum(0)
              ,qtd_selo_electronico_d_c	= Sum(0)
              ,qtd_selo_electronico_i	= Sum(0)
              ,qtd_selo_electronico_i_c	= Sum(0)
              ,qtd_selo_fisico_d		= Sum(case when a.tp_natureza = 'D' then 1 else 0 end)
              ,qtd_selo_fisico_i		= Sum(case when a.tp_natureza = 'I' then 1 else 0 end)
              ,qtd_selo_d				= Sum(case when a.tp_natureza = 'D' then 1 else 0 end)
              ,qtd_selo_i				= Sum(case when a.tp_natureza = 'I' then 1 else 0 end)	
              ,qtd_total				= Sum(1)
              ,qtd_rpe					= Sum(0)
              ,qtd_pax_conexao			= Sum(0)
              ,qtd_pax_isento			= Sum(0)
              ,qtd_dif					= Sum(0)
          From pax_selo_u	a (nolock index = IDX01_BI)
         Where a.selo_status			= @v_selo_status
           And a.cd_aerop_utilizacao	= @p_cd_aerop
           And a.cd_cia_aerea 			= @p_cd_cia_aerea
           And a.dt_mov           between @p_data_mov and @v_data_fim
           And a.tp_fat                 = 'F'
         Group by
               a.cd_aerop_utilizacao
              ,convert(varchar(8),a.dt_mov,112)
              ,a.cd_cia_aerea
    End

    If @p_nro_voo = 'TODOS'
    Begin
        /*Buscar selos Eletronicos*/
        Set @v_sql = ''

        -- busca selos pela data do voo
        If @p_tipo_selecao = '0'
        Begin
            Set @v_sql = '' +
                         'Insert into #table_xx_1
                          Select cd_aerop                   = a.cd_aerop
                                ,dt_mov                     = Convert(char(8), a.dt_voo_rea, 112)
                                ,cd_cia_aerea               = a.cd_cia_aerea
                                ,voo_rea                    = voo_rea
                                ,qtd_selo_electronico_d     = Sum(case when a.tp_natureza = ''D'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_d_c	= Sum(case when a.tp_natureza = ''D'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_electronico_i     = Sum(case when a.tp_natureza = ''I'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_i_c   = Sum(case when a.tp_natureza = ''I'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_fisico_d          = Sum(0)
                                ,qtd_selo_fisico_i          = Sum(0)
                                ,qtd_selo_d                 = Sum(case when a.tp_natureza = ''D'' then 1 else 0 end)
                                ,qtd_selo_i                 = Sum(case when a.tp_natureza = ''I'' then 1 else 0 end)
                                ,qtd_total                  = Sum(1)
                                ,qtd_rpe                    = Sum(0)
                                ,qtd_pax_conexao            = Sum(0)
                                ,qtd_pax_isento             = Sum(0)
                                ,qtd_dif                    = Sum(0)
                            From pax_selo_electronico_u	a (nolock index = IDX02_BI)
                           Where a.cd_aerop                 = ''' + @p_cd_aerop     + '''
                             And a.cd_cia_aerea             = ''' + @p_cd_cia_aerea + '''
                             And Convert(char(8), a.dt_voo_rea, 112) = ''' + Convert(char(8), @p_data_mov, 112) + '''
                           Group by
                                 a.cd_aerop
                                ,Convert(char(8), a.dt_voo_rea, 112)
                                ,a.cd_cia_aerea
                                ,a.voo_rea'
            Print @v_sql
        End

        -- busca selos pela data do movimento
        If @p_tipo_selecao = '1'
        Begin
            Set @v_sql = '' +
                         'Insert into #table_xx_1
                          Select cd_aerop                   = a.cd_aerop
                                ,dt_mov                     = Convert(char(8), a.dt_mov, 112)
                                ,cd_cia_aerea               = a.cd_cia_aerea
                                ,voo_rea                    = a.voo_rea
                                ,qtd_selo_electronico_d     = Sum(case when a.tp_natureza = ''D'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_d_c	= Sum(case when a.tp_natureza = ''D'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_electronico_i     = Sum(case when a.tp_natureza = ''I'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_i_c   = Sum(case when a.tp_natureza = ''I'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_fisico_d          = Sum(0)
                                ,qtd_selo_fisico_i          = Sum(0)
                                ,qtd_selo_d                 = Sum(case when a.tp_natureza = ''D'' then 1 else 0 end)
                                ,qtd_selo_i                 = Sum(case when a.tp_natureza = ''I'' then 1 else 0 end)
                                ,qtd_total                  = Sum(1)
                                ,qtd_rpe                    = Sum(0)
                                ,qtd_pax_conexao            = Sum(0)
                                ,qtd_pax_isento             = Sum(0)
                                ,qtd_dif                    = Sum(0)
                            From pax_selo_electronico_u	a (nolock index = IDX02_BI)
                           Where a.cd_aerop                 = ''' + @p_cd_aerop     + '''
                             And a.cd_cia_aerea             = ''' + @p_cd_cia_aerea + '''
                             And Convert(char(8), a.dt_mov, 112) = ''' + Convert(char(8), @p_data_mov, 112) + '''
                           Group by
                                 a.cd_aerop
                                ,Convert(char(8), a.dt_mov, 112)
                                ,a.cd_cia_aerea
                                ,a.voo_rea'
            Print @v_sql
        End

        Exec (@v_sql)
    End
    Else
    Begin
        Set @v_sql = ''

        -- busca selos pela data do voo
        If @p_tipo_selecao = '0'
        Begin
            Set @v_sql = '' +
                         'Insert into #table_xx_1
                          Select cd_aerop                   = a.cd_aerop
                                ,dt_mov                     = Convert(char(8), a.dt_voo_rea, 112)
                                ,cd_cia_aerea               = a.cd_cia_aerea
                                ,voo_rea                    = a.voo_rea
                                ,qtd_selo_electronico_d     = Sum(case when a.tp_natureza = ''D'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_d_c   = Sum(case when a.tp_natureza = ''D'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_electronico_i     = Sum(case when a.tp_natureza = ''I'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_i_c   = Sum(case when a.tp_natureza = ''I'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_fisico_d          = Sum(0)
                                ,qtd_selo_fisico_i          = Sum(0)
                                ,qtd_selo_d                 = Sum(case when a.tp_natureza = ''D'' then 1 else 0 end)
                                ,qtd_selo_i                 = Sum(case when a.tp_natureza = ''I'' then 1 else 0 end)	
                                ,qtd_total                  = Sum(1)
                                ,qtd_rpe                    = Sum(0)
                                ,qtd_pax_conexao            = Sum(0)
                                ,qtd_pax_isento             = Sum(0)
                                ,qtd_dif                    = Sum(0)
                            From pax_selo_electronico_u	a (nolock index = IDX02_BI)
                           Where a.cd_aerop                 = ''' + @p_cd_aerop     + '''
                             And a.cd_cia_aerea             = ''' + @p_cd_cia_aerea + '''
                             And Convert(char(8), a.dt_voo_rea, 112) = ''' + Convert(char(8), @p_data_mov, 112) + '''
                             And a.voo_rea                  = ''' + @p_nro_voo      + '''
                             And a.selo_status              = ''' + @v_selo_status  + '''
                           Group by
                                 a.cd_aerop
                                ,Convert(char(8), a.dt_voo_rea, 112)
                                ,a.cd_cia_aerea
                                ,a.voo_rea'
            Print @v_sql
        End

        -- busca selos pela data do movimento
        If @p_tipo_selecao = '1'
        Begin
            Set @v_sql = '' +
                         'Insert into #table_xx_1
                          Select cd_aerop                   = a.cd_aerop
                                ,dt_mov                     = Convert(char(8), a.dt_mov, 112)
                                ,cd_cia_aerea               = a.cd_cia_aerea
                                ,voo_rea                    = a.voo_rea
                                ,qtd_selo_electronico_d     = Sum(case when a.tp_natureza = ''D'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_d_c   = Sum(case when a.tp_natureza = ''D'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_electronico_i     = Sum(case when a.tp_natureza = ''I'' and tp_coletor   = ''01''       then 1 else 0 end)
                                ,qtd_selo_electronico_i_c   = Sum(case when a.tp_natureza = ''I'' and dt_confirma <> ''19000101'' then 1 else 0 end)
                                ,qtd_selo_fisico_d          = Sum(0)
                                ,qtd_selo_fisico_i          = Sum(0)
                                ,qtd_selo_d                 = Sum(case when a.tp_natureza = ''D'' then 1 else 0 end)
                                ,qtd_selo_i                 = Sum(case when a.tp_natureza = ''I'' then 1 else 0 end)	
                                ,qtd_total                  = Sum(1)
                                ,qtd_rpe                    = Sum(0)
                                ,qtd_pax_conexao            = Sum(0)
                                ,qtd_pax_isento             = Sum(0)
                                ,qtd_dif                    = Sum(0)
                            From pax_selo_electronico_u	a (nolock index = IDX02_BI)
                           Where a.cd_aerop                 = ''' + @p_cd_aerop     + '''
                             And a.cd_cia_aerea             = ''' + @p_cd_cia_aerea + '''
                             And Convert(char(8), a.dt_mov, 112) = ''' + Convert(char(8), @p_data_mov, 112) + '''
                             And a.voo_rea                  = ''' + @p_nro_voo      + '''
                             And a.selo_status              = ''' + @v_selo_status  + '''
                           Group by
                                 a.cd_aerop
                                ,Convert(char(8), a.dt_mov, 112)
                                ,a.cd_cia_aerea
                                ,a.voo_rea'
            Print @v_sql
        End

        Exec (@v_sql)
    End 

    /*Buscar RPE*/
    If @p_nro_voo = 'TODOS'
    Begin
        Insert into #table_xx_1
        Select cd_aerop					= a.cd_aerop
              ,dt_mov					= a.dt_voo
              ,cd_cia_aerea				= a.cd_cia_aerea
              ,voo_rea					= convert(char(5),convert(int,nro_voo))
              ,qtd_selo_electronico_d	= Sum(0)
              ,qtd_selo_electronico_d_c	= Sum(0)
              ,qtd_selo_electronico_i	= Sum(0)
              ,qtd_selo_electronico_i_c	= Sum(0)
              ,qtd_selo_fisico_d		= Sum(0)
              ,qtd_selo_fisico_i		= Sum(0)
              ,qtd_selo_d				= Sum(0)
              ,qtd_selo_i				= Sum(0)
              ,qtd_total				= Sum(0)
              ,qtd_rpe					= Sum(pax_tot_fat) 
              ,qtd_pax_conexao			= Sum(pax_conexao_dom + pax_conexao_int)
              ,qtd_pax_isento			= Sum(pax_tot_isento)
              ,qtd_dif					= Sum(0)
          From rpax_emb_voo_u a (nolock index = P_rpax_emb_voo_u)
         Where a.cd_aerop               = @p_cd_aerop
           And a.cd_terminal            = '1'
           And a.cd_cia_aerea           = @p_cd_cia_aerea
           And a.dt_voo           between @p_data_mov and @v_data_fim
           And a.inactive_ind           = '0'
           And a.tp_voo                <> '2'
         Group by
               a.cd_aerop
              ,a.dt_voo
              ,a.cd_cia_aerea
              ,convert(char(5),convert(int,a.nro_voo))
    End
    Else
    Begin
        Insert into #table_xx_1
        Select cd_aerop					= a.cd_aerop
              ,dt_mov					= a.dt_voo
              ,cd_cia_aerea				= a.cd_cia_aerea
              ,voo_rea					= convert(char(5),convert(int,a.nro_voo))
              ,qtd_selo_electronico_d	= Sum(0)
              ,qtd_selo_electronico_d_c	= Sum(0)
              ,qtd_selo_electronico_i	= Sum(0)
              ,qtd_selo_electronico_i_c	= Sum(0)
              ,qtd_selo_fisico_d		= Sum(0)
              ,qtd_selo_fisico_i		= Sum(0)
              ,qtd_selo_d				= Sum(0)
              ,qtd_selo_i				= Sum(0)
              ,qtd_total				= Sum(0)
              ,qtd_rpe					= Sum(pax_tot_fat)
              ,qtd_pax_conexao			= Sum(pax_conexao_dom + pax_conexao_int)
              ,qtd_pax_isento			= Sum(pax_tot_isento)
              ,qtd_dif					= Sum(0)
          From rpax_emb_voo_u a (nolock index = P_rpax_emb_voo_u)
         Where a.cd_aerop               = @p_cd_aerop
           And a.cd_terminal            = '1'
           And a.cd_cia_aerea           = @p_cd_cia_aerea
           And a.dt_voo           between @p_data_mov and @v_data_fim
           And ltrim(rtrim(a.nro_voo))  = ltrim(rtrim(@p_nro_voo))
           And a.inactive_ind           = '0'
           And a.tp_voo                <> '2'
         Group by
               a.cd_aerop
              ,a.dt_voo
              ,a.cd_cia_aerea
              ,convert(char(5),convert(int,a.nro_voo))
    End 

    /*Calcular e mostar totais*/
    Insert Into #table_xx_2 
         ( cd_aerop
          ,dt_mov		
          ,cd_cia_aerea
          ,voo_rea
          ,qtd_selo_electronico_d		
          ,qtd_selo_electronico_d_c	
          ,qtd_selo_electronico_i		
          ,qtd_selo_electronico_i_c	
          ,qtd_selo_fisico_d
          ,qtd_selo_fisico_i
          ,qtd_selo_d
          ,qtd_selo_i
          ,qtd_total
          ,qtd_rpe
          ,qtd_pax_conexao
          ,qtd_pax_isento
          ,qtd_dif)
    Select cd_aerop
          ,dt_mov
          ,cd_cia_aerea
          ,voo_rea
          ,qtd_selo_electronico_d 	= sum(qtd_selo_electronico_d)
          ,qtd_selo_electronico_d_c = sum(qtd_selo_electronico_d_c)
          ,qtd_selo_electronico_i   = sum(qtd_selo_electronico_i)
          ,qtd_selo_electronico_i_c = sum(qtd_selo_electronico_i_c)
          ,qtd_selo_fisico_d        = sum(qtd_selo_fisico_d)
          ,qtd_selo_fisico_i        = sum(qtd_selo_fisico_i)
          ,qtd_selo_d               = sum(qtd_selo_d)
          ,qtd_selo_i               = sum(qtd_selo_i)
          ,qtd_total                = sum(qtd_total)
          ,qtd_rpe                  = sum(qtd_rpe)
          ,qtd_pax_conexao          = sum(qtd_pax_conexao)
          ,qtd_pax_isento           = sum(qtd_pax_isento)
          ,qtd_dif					= sum(qtd_rpe) - sum(qtd_total) 
      From #table_xx_1 
     Group by 
           cd_aerop
          ,dt_mov
          ,cd_cia_aerea
          ,voo_rea
     Order by 1,2,3,4

    /****************************************************/
    /* COLOCAR INFORMAÇÃO NA TABELA DEFINITIVA          */

    Select * 
      Into #table_xx_3
      From pax_fiscal_det_u
     Where cd_aerop 						= @p_cd_aerop
       And convert(varchar(8),data_mov,112) = convert(varchar(8),@p_data_mov,112)
       And cd_cia_aerea						= @p_cd_cia_aerea
       And nro_voo							= @p_nro_voo 
       And ( qtd_boa_ise_dom               <> 0
        Or   qtd_boa_ise_int               <> 0
        Or   qtd_boa_con_dom               <> 0
        Or   qtd_boa_con_int               <> 0
        Or   qtd_boa_emb_dom               <> 0
        Or   qtd_boa_emb_int               <> 0
        Or   qtd_man_ise_dom               <> 0
        Or   qtd_man_ise_Int               <> 0
        Or   qtd_man_con_dom               <> 0
        Or   qtd_man_con_int               <> 0
        Or   qtd_man_emb_dom               <> 0
        Or   qtd_man_emb_int               <> 0
        Or   qtd_man_tra_dom               <> 0
        Or   qtd_man_tra_int               <> 0
        Or   cont_bilhetes                 <> 0
        Or   cont_man_voo                  <> 0
        Or   cont_pax_aero                 <> 0
        Or   comentario                    <> '' )

    --print @@rowcount

    Delete from pax_fiscal_det_u
     Where cd_aerop 						= @p_cd_aerop
       And convert(varchar(8),data_mov,112) = convert(varchar(8),@p_data_mov,112)
       And cd_cia_aerea						= @p_cd_cia_aerea
       And nro_voo							= @p_nro_voo 

    Insert into pax_fiscal_det_u
    Select @p_cd_aerop
          ,@p_data_mov 
          ,@p_cd_cia_aerea
          ,@p_nro_voo
          ,numero					-- numero
          ,voo_rea				    -- nro_voo_lista
          ,qtd_selo_fisico_d		-- sel_lid_dom_fis
          ,qtd_selo_electronico_d	-- sel_lid_dom_ele
          ,qtd_selo_fisico_i		-- sel_lid_int_fis
          ,qtd_selo_electronico_i	-- sel_lid_int_ele
          ,qtd_selo_fisico_d + qtd_selo_fisico_i + qtd_selo_electronico_d	+ qtd_selo_electronico_i -- sel_lid_tot
          ,qtd_selo_electronico_d_c	-- sel_conf_dom_ele
          ,qtd_selo_electronico_i_c	-- sel_conf_int_ele
          ,qtd_total				-- sel_tot_fat
          ,qtd_rpe				    -- tot_rpe
          ,0				        -- cont_bilhetes
          ,0				        -- cont_man_voo
          ,0				        -- cont_pax_aero
          ,qtd_pax_isento	        -- tot_pax_ise
          ,case when qtd_total = qtd_rpe then 'S' else 'N' end	-- fl_voo_lib_fat
          ,case when qtd_total = qtd_rpe or voo_rea = 'FISIC' then 'N' else 'S' end	-- fl_dados_inconsistentes
          ,qtd_pax_conexao	        -- qtd_pax_con
          ,0				        -- qtd_boa_ise_dom
          ,0				        -- qtd_boa_ise_int
          ,0				        -- qtd_boa_con_dom
          ,0				        -- qtd_boa_con_int
          ,0				        -- qtd_boa_emb_dom
          ,0				        -- qtd_boa_emb_int
          ,0				        -- qtd_man_ise_dom
          ,0				        -- qtd_man_ise_Int
          ,0				        -- qtd_man_con_dom
          ,0				        -- qtd_man_con_int
          ,0				        -- qtd_man_emb_dom
          ,0				        -- qtd_man_emb_int
          ,0				        -- qtd_man_tra_dom
          ,0				        -- qtd_man_tra_int
          ,''				        -- comentario
          ,suser_sname()	        -- matricula
          ,getdate()		        -- data_hora
          ,0
      From #table_xx_2 

    Update pax_fiscal_det_u
       Set qtd_boa_ise_dom                      = b.qtd_boa_ise_dom
          ,qtd_boa_ise_int                      = b.qtd_boa_ise_int
          ,qtd_boa_con_dom                      = b.qtd_boa_con_dom
          ,qtd_boa_con_int                      = b.qtd_boa_con_int
          ,qtd_boa_emb_dom                      = b.qtd_boa_emb_dom
          ,qtd_boa_emb_int                      = b.qtd_boa_emb_int
          ,qtd_man_ise_dom                      = b.qtd_man_ise_dom
          ,qtd_man_ise_Int                      = b.qtd_man_ise_Int
          ,qtd_man_con_dom                      = b.qtd_man_con_dom
          ,qtd_man_con_int                      = b.qtd_man_con_int
          ,qtd_man_emb_dom                      = b.qtd_man_emb_dom
          ,qtd_man_emb_int                      = b.qtd_man_emb_int
          ,qtd_man_tra_dom                      = b.qtd_man_tra_dom
          ,qtd_man_tra_int                      = b.qtd_man_tra_int
          ,cont_bilhetes                        = b.cont_bilhetes
          ,cont_man_voo                         = b.cont_man_voo
          ,cont_pax_aero                        = b.cont_pax_aero
          ,comentario                           = b.comentario
      From pax_fiscal_det_u a, #table_xx_3 b
     Where a.cd_aerop                           = b.cd_aerop
       And convert(varchar(8),a.data_mov,112) 	= convert(varchar(8),b.data_mov,112)
       And a.cd_cia_aerea						= b.cd_cia_aerea
       And a.nro_voo							= b.nro_voo
       And a.nro_voo_lista						= b.nro_voo_lista

    --select * from #table_xx_3
    --select * from #table_xx_2
    --select * from #table_xx_1

    Drop table #table_xx_3
    Drop table #table_xx_2
    Drop table #table_xx_1 

    Set nocount off
