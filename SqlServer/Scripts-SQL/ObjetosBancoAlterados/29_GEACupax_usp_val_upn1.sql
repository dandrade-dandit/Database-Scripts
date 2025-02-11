USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_val_upn1]    Script Date: 12/22/2010 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.usp_val_upn1    Script Date: 19/09/2008 15:21:28 ******/


if exists(select * from sysobjects where name = 'usp_val_upn1')
   drop procedure usp_val_upn1
go


Create Procedure [dbo].[usp_val_upn1] 
    ( @p_cd_aerop			char(4), 
      @p_dt_mov_ini       	datetime, 
      @p_dt_mov_fim       	datetime, 
      @p_com_quin_atu     	int, 
      @p_com_quin_ant     	int, 
      @p_com_quin_ano_ant 	int, 
      @p_tot_voo_no_per   	int, 
      @p_tot_voo_conf     	int, 
      @p_qua_sel_dis      	int, 
      @p_qua_sel_pen      	int, 
      @p_consideracoes    	varchar(255), 
      @p_fl_val           	char(1), 
      @p_user_res_val     	varchar(30), 
      @p_dt_val           	datetime, 
      @p_fl_aut           	char(1), 
      @p_user_aut_fat     	varchar(30), 
      @p_dt_aut				datetime, 		
      @p_qua_sel_dis_geral  int, 
      @p_qua_sel_pen_geral  int,

      -- Especiais
      @p_activity_id		char(10),           	-- Código da Atividade
      @p_output				char(1) ,            	-- 1 faz select do codigo da mensagem-- 0 não faz deve utilizar variavel output
      @p_campo				char(20),            	-- Nome do campo a ser validado, ou 'todos' para validar tudo
      @p_acao				char(1),             	-- I Inclusão 	U Update 	D Delete 	C Consulta 	X viene del itemghanged
      @p_error_message_id	char(10) output,     	-- Código da mensagem de erro ou 0000 se estiver tudo OK
      @p_error_complemento	char(100) output,     	-- Complemento da mensagem
      @p_error_campo		char(20) output   )  	--  Código do campo com erro

AS 

    -- Iniciando Variaveis de Retorno
    Select @p_error_message_id = '0000', 
           @p_error_complemento = ' ',  
           @p_error_campo = ' '

    -- Outras Variaveis
    Declare	@result			VARCHAR(255)
           ,@v_fl_val_aux	char(1)

    -- validando AEROPORTO
    If @p_campo = 'cd_aerop' OR @p_campo = 'todos'
    Begin
        Select @result = no_aerop 
          From GEACutcx..cor_aeroporto_u  (nolock index = P_cor_aeroporto_u) 
         Where cd_aerop = @p_cd_aerop
        
        If  @result = '' OR @result is null
        Begin
            Select @p_error_message_id 		= 'utc0026'
                  ,@p_error_complemento 	= ''
                  ,@p_error_campo  			= 'cd_aerop'
            Goto  TERMINA 
        End 
        Else
        Begin
            Select @p_error_message_id 		= '0000'
                  ,@p_error_complemento 	= @result
                  ,@p_error_campo  			= 'cd_aerop'

            If @p_acao = 'X' Goto TERMINA
        End
    End

    -- Validando data de inicio
    If @p_campo = 'dt_mov_ini' OR @p_campo = 'todos'
    Begin
        If day(@p_dt_mov_ini) <> 1 And day(@p_dt_mov_ini) <> 16
        Begin
            Select @p_error_message_id 		= 'upa9113'
                  ,@p_error_complemento 	= ''
                  ,@p_error_campo  			= 'dt_mov_ini'
        
            Goto  TERMINA 
        End 
        Else
        Begin
            Select @p_error_message_id 		= '0000'
                  ,@p_error_complemento 	= @result
                  ,@p_error_campo  			= 'dt_mov_ini'
        
            If @p_acao = 'X' Goto TERMINA
        End
    End 

    -- Validando data de fim
    If @p_campo = 'dt_mov_fim' OR @p_campo = 'todos'
    Begin
        If (day(@p_dt_mov_fim)  <> 30 And  day(@p_dt_mov_fim) <> 31) And
           (month(@p_dt_mov_fim) = 2  And (day(@p_dt_mov_fim) not in (15,27,28, 29)))
        Begin
            Select @p_error_message_id 		= 'upa9114'
                  ,@p_error_complemento 	= ''
                  ,@p_error_campo  			= 'dt_mov_fim'
        
            Goto  TERMINA 
        End 
        Else
        Begin
            Select @p_error_message_id 		= '0000'
                  ,@p_error_complemento 	= @result
                  ,@p_error_campo  			= 'dt_mov_fim'
        
            If @p_acao = 'X' Goto TERMINA
        End
    End 

    -- Validando autorizador
    If @p_campo = 'fl_aut' OR @p_campo = 'todos'
    Begin
        If Not Exists (Select 1 
                         From pax_val_qui_res_u (nolock index = P_pax_val_qui_res_u)
                        Where cd_aerop          = @p_cd_aerop
                          And aurorizador_id    = suser_sname()
                          And inactive_ind      = 0 )
        Begin
            If suser_sname() not in ('DFTC_RIGO')
            Begin
                Select @p_error_message_id 		= 'upa9126'
                      ,@p_error_complemento 	= ''
                      ,@p_error_campo  			= 'autorizador_id'
                Goto  TERMINA 
            End 
        End

        Select @v_fl_val_aux    = fl_val
          From pax_val_quinz_hdr_u	(nolock index = P_pax_val_quinz_hdr_u)
         Where cd_aerop 		= @p_cd_aerop			
           And dt_mov_ini 		= @p_dt_mov_ini       	
           And dt_mov_fim		= @p_dt_mov_fim       	

        If @v_fl_val_aux = '0' 
        Begin
            Select @p_error_message_id 		= 'upa9127'
                  ,@p_error_complemento 	= ''
                  ,@p_error_campo  			= 'fl_aut'
            Goto  TERMINA 
        End 
    End 

    -- Validar para Salvar
    If @p_campo = 'todos'
    Begin
        If  @p_dt_mov_fim < @p_dt_mov_ini
        Begin
            Select @p_error_message_id 		= 'upa9115'
                  ,@p_error_complemento 	= ''
                  ,@p_error_campo  			= 'dt_mov_fim'
            Goto  TERMINA 
        End 

        If @p_fl_aut = '1'
        Begin
            Select @v_fl_val_aux    = fl_val
              From pax_val_quinz_hdr_u	(nolock index = P_pax_val_quinz_hdr_u)
             Where cd_aerop 		= @p_cd_aerop			
               And dt_mov_ini 		= @p_dt_mov_ini       	
               And dt_mov_fim		= @p_dt_mov_fim       	

            If @v_fl_val_aux = '0' 
            Begin
                Select @p_error_message_id 		= 'upa9127'
                      ,@p_error_complemento 	= ''
                      ,@p_error_campo  			= 'fl_aut'
                Goto  TERMINA 
            End 

            -- Incluido tratamento para selecionar somente Autorizadores "Ativos (0)" em 18/11/2009 - Adaili Dias
            If @p_acao = 'U'
            Begin
                If Not Exists (Select 1 
                                 From pax_val_qui_res_u (nolock index = P_pax_val_qui_res_u)
                                Where cd_aerop          = @p_cd_aerop
                                  And aurorizador_id    = suser_sname()
                                  And inactive_ind      = 0 )
                Begin
                    If suser_sname() not in ('DFTC_RIGO')
                    Begin
                        Select @p_error_message_id 		= 'upa9126'
                              ,@p_error_complemento 	= ''
                              ,@p_error_campo  			= 'aurorizador_id'
                        Goto  TERMINA 
                    End 
                End
            End	
        End 
    End

    TERMINA:
    
    If @p_output = '1'
    Begin
        Select @p_error_message_id,  
               @p_error_complemento,  
               @p_error_campo         
    End

    If @p_error_message_id = '0000'
        Return 0
    Else
        Return 1
