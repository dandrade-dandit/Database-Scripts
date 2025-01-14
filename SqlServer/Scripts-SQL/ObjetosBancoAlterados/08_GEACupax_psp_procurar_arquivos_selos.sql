USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[psp_procurar_arquivos_selos]    Script Date: 12/13/2010 11:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Stored Procedure dbo.psp_procurar_arquivos_selos    Script Date: 19/09/2008 15:20:21 ******/

if exists(select * from sysobjects where name = 'psp_procurar_arquivos_selos')
   drop procedure psp_procurar_arquivos_selos
go

/* Declaracion de Variables */

Create PROC [dbo].[psp_procurar_arquivos_selos] 
(	        @p_arquivo	                varchar(33) = '%' )
As

    Set nocount on

    Declare 
            /* VARIABLES DA TABELA DE ARQUIVOS */
            @p_cd_aerop         	    char (4) 
           ,@p_cd_terminal      	    char (10) 
           ,@p_dt_mov           	    char (10)
           ,@p_hh_mm            	    char (6) 
           ,@p_selo_status      	    char (1) 
           ,@p_cd_motivo        	    char (2) 
           ,@p_qtd_selos        	    float
           ,@p_qtd_lineas_arq           float
           ,@p_qtd_discrepancias	    float
           ,@p_qtd_lineas_erro		    float
           ,@p_qtd_discrepancias_tra 	float
           ,@p_qtd_duplicados		    float
           ,@p_tp_coletor       	    char (16) 
           ,@p_tp_baixa        	        char (1) 
           ,@p_status_arq       	    char (1) 
           ,@p_date_created     	    datetime
           ,@p_user_id_created  	    char (30) 
           ,@p_date_changed     	    datetime 
           ,@p_user_id_changed  	    char (30) 
           ,@p_inactive_ind     	    char (1) 
           ,@p_active_date      	    datetime  
           ,@p_serie_coletor		    char(15)

            /* VARIABLES DE PROCESO */
           ,@p_date_process		        datetime
           ,@p_user_process 		    char(30)
           ,@v_tp_selo				    char(1)	
           ,@v_mensaje 			        varchar(255)
           ,@p_mensaje				    varchar(255)
           ,@p_linha				    integer
           ,@p_status_arq_aux		    char(1)

    /* CREAR TABELA TEMPORARIA DE LOG DE PROCESO */

    /* INICIALIZAR VARIABLES DE PROCESO */
    Select @p_date_process      = GETDATE()
          ,@p_user_process 		= SUSER_SNAME()

    If Not Exists (Select 1 
                     From sysobjects 
                    Where name 	= 'pax_erro_job_selos_u'
                      And xtype	= 'U')
    Begin
        create table pax_erro_job_selos_u  (
               linha			        integer IDENTITY
              ,mensaje		            varchar(255) NULL
              ,data_proceso	            datetime )
    end

	Declare cursor_log_processo cursor for
		Select linha
			  ,mensaje
		  From pax_erro_job_selos_u (nolock)
		 Where data_proceso	= @p_date_process
		 Order by linha

		Insert into pax_erro_job_selos_u 
		Values ('Inicio do Processo (' + 
				CONVERT(varchar(10), @p_date_process, 103) + ' ' + 
				CONVERT(varchar(12), @p_date_process, 114) + ')', @p_date_process )

		/* DECLARAR CURSOR DE ARCHIVOS A PROCESAR */
		Declare cursor_arquivos_coletados insensitive cursor for
			Select distinct 
				   arquivo
				  ,serie_coletor
				  ,COUNT(1)
			  From pax_selos_coletados_u (nolock index = ix_pro_aquivos)
			 Where status_linha	           = '0'
			   And date_created           <= DATEADD(mi,-3,@p_date_process)
			   And arquivo		        LIKE @p_arquivo
			   And nro_linha	          >= 3
			   And left(linha,1)	      <> '#'
			   And substring(arquivo,8,2) >= '06'
			 Group by arquivo, serie_coletor
			 Order by arquivo

			/* ABRIR CURSOR DE ARQUIVOS */
			Open cursor_arquivos_coletados
			Fetch next from cursor_arquivos_coletados into
				  @p_arquivo
				 ,@p_serie_coletor
				 ,@p_qtd_lineas_arq
	
			While @@FETCH_STATUS = 0
			Begin

				If SUBSTRING(@p_arquivo, 1,3) = '000'
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'CODIGO DO AEROPORTO INVALIDO (000)" '+ ltrim(rtrim(@p_arquivo)), @p_date_process )
					Goto LEER_PROXIMO
				End

				If LEN(@p_arquivo) <> 32
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'Nome de Arquivo Invalido" '+ ltrim(rtrim(@p_arquivo)), @p_date_process )
					Goto LEER_PROXIMO
				End

				If upper(right(rtrim(@p_arquivo),4)) <> '.TXT'
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'Nome de Arquivo Invalido (não e .TXT)" '+ ltrim(rtrim(@p_arquivo)), @p_date_process )
					Goto LEER_PROXIMO
				End

				Select top 1 
					   @p_cd_aerop          = cd_aerop 
				  From GEACutcx..cor_aeroporto_u (nolock index = P_cor_aeroporto_u)
				 Where cd_aerop_num			= SUBSTRING(@p_arquivo, 1,3)
				   And inactive_ind 		= '0'

				If @p_cd_aerop is null or RTRIM(LTRIM(@p_cd_aerop)) = '' OR @@ROWCOUNT = 0
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'CODIGO DO AEROPORTO INVALIDO "' + @p_cd_aerop + '" '+ ltrim(rtrim(@p_arquivo)), @p_date_process )
					Goto LEER_PROXIMO
				End

				/* verificar se o coletor pertence ao aeroporto*/
				If Not Exists (Select 1 
				                 From pax_coletor_u (nolock)
								Where sigla     = @p_cd_aerop
								  And serial	= @p_serie_coletor)
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'COLETOR NÃO ATRIBUÍDO A ESSE AEROPORTO "' + @p_cd_aerop + ' / '+ ltrim(rtrim(@p_serie_coletor)) + '" ARQUIVO (' + ltrim(rtrim(@p_arquivo))+ ')' , @p_date_process )
					Goto LEER_PROXIMO
				End
	
				Select @p_dt_mov			= '20' + Substring(@p_arquivo, 8,6)

				If isdate( @p_dt_mov ) = 0
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'DATA DE MOVIMENTO INVALIDA "' + @p_dt_mov + '". ARQUIVO (' + @p_arquivo + ')', @p_date_process )
					Goto LEER_PROXIMO
				End

				Select @p_cd_terminal			= Substring(@p_arquivo, 4,1)
					  ,@p_dt_mov				= '20' + Substring(@p_arquivo, 8,6)
					  ,@p_hh_mm					= Substring(@p_arquivo, 15,6)
					  ,@v_tp_selo				= Substring(@p_arquivo, 6,1)
					  ,@p_selo_status 			= case when Substring(@p_arquivo, 22,1) = 'U' then '2'
													   When Substring(@p_arquivo, 22,1) = 'D' then '3'
													   When Substring(@p_arquivo, 22,1) = 'C' then '4'
													   Else @p_selo_status End
					  ,@p_tp_baixa        		= 'L'
					  ,@p_cd_motivo				= Case When Substring(@p_arquivo, 22,1) = 'U' Then 'NA'
													   Else Substring(@p_arquivo, 23,2) End
					  ,@p_tp_coletor			= '01'
					  ,@p_status_arq       		= '0'
					  ,@p_date_created     		= @p_date_process
					  ,@p_user_id_created  		= @p_user_process
					  ,@p_date_changed     		= '19000101'
					  ,@p_user_id_changed  		= ' '
					  ,@p_inactive_ind     		= '0'
					  ,@p_active_date      		= '19000101'
					  ,@p_qtd_selos        		= 0
					  ,@p_qtd_discrepancias		= 0
					  ,@p_qtd_lineas_erro		= 0
					  ,@p_qtd_discrepancias_tra	= 0
					  ,@p_qtd_duplicados		= 0

				/* VALIDA TERMINAL */
				If Not Exists ( Select 1 
								  From GEACutcx..cor_terminal_aerop_u (nolock index = P_cor_terminal_aerop_u)
								 Where cd_aerop 		= @p_cd_aerop 
								   And terminal 		= rtrim(@p_cd_terminal)
								   And inactive_ind 	= '0' )
				Begin
					Insert into pax_erro_job_selos_u 
					Values ( 'TERMINAL DE AEROPORTO INVÁLIDO OU INATIVO. "' + rtrim(@p_cd_terminal) + '"' + ltrim(rtrim(@p_arquivo)), @p_date_process )
					Goto LEER_PROXIMO
				End
	
				/* VALIDA STATUS DO SELO */
				If @p_selo_status  NOT IN ('2','3','4')
				Begin
					Insert into  pax_erro_job_selos_u 
					Values ( 'TIPO DE BAIXA DIFERENTE DE U, D OU C. "' + @p_selo_status + '"', @p_date_process )
					Goto LEER_PROXIMO
				End	
	
				-- VERIFICA SE ARQUIVO JÁ FOI PROCESSADO ANTERIORMENTE
				If Not Exists ( Select 1 
								  From GEACupax..pax_baixa_selo_u (nolock index = P_pax_baixa_selo_u)
								 Where cd_aerop 		= @p_cd_aerop
								   And cd_terminal 		= @p_cd_terminal
								   And dt_mov  			= @p_dt_mov
								   And hh_mm  			= @p_hh_mm
								   And tp_selo			= @v_tp_selo 
								   And arquivo			= @p_arquivo)
				Begin
					-- SE ARQUIVO NÃO FOI PROCESSADO ANTERIORMENTE - INCLUI ARQUIVO		
					Insert into  GEACupax..pax_baixa_selo_u (
						   cd_aerop, 
						   cd_terminal, 
						   dt_mov, 
						   hh_mm, 
						   tp_selo,
						   selo_status, 
						   arquivo, 
						   cd_motivo, 
						   qtd_selos, 
						   tp_coletor, 
						   tp_baixa, 
						   status_arq, 
						   qtd_lineas_arq, 
						   qtd_discrepancias,
						   qtd_lineas_erro,
						   qtd_discrepancias_tra,
						   qtd_duplicados,
						   date_created, 
						   user_id_created, 
						   date_changed, 
						   user_id_changed, 
						   inactive_ind, 
						   active_date, 
						   chgstamp )  
					values ( 
						   @p_cd_aerop         
						  ,@p_cd_terminal      
						  ,@p_dt_mov           
						  ,@p_hh_mm            
						  ,@v_tp_selo
						  ,@p_selo_status
						  ,@p_arquivo          
						  ,@p_cd_motivo        
						  ,@p_qtd_selos        
						  ,@p_tp_coletor       
						  ,@p_tp_baixa        
						  ,@p_status_arq       
						  ,@p_qtd_lineas_arq 
						  ,@p_qtd_discrepancias
						  ,@p_qtd_lineas_erro
						  ,@p_qtd_discrepancias_tra
						  ,@p_qtd_duplicados		
						  ,@p_date_created     
						  ,@p_user_id_created  
						  ,@p_date_changed     
						  ,@p_user_id_changed  
						  ,@p_inactive_ind     
						  ,@p_active_date      
						  ,0 )

					Set @v_mensaje = 'REQUISIÇAO CRIADA PARA ARQUIVO:' + ltrim(rtrim(@p_arquivo))
					Insert into  pax_erro_job_selos_u Values (@v_mensaje, @p_date_process)
				End
				Else
				Begin
					-- SE ARQUIVO JÁ FOI PROCESSADO ANTERIORMENTE - REPROCESSA OU NÃO ARQUIVO
					Select @p_status_arq_aux	= status_arq 
					  From GEACupax..pax_baixa_selo_u (nolock)
					 Where cd_aerop 			= @p_cd_aerop
					   And cd_terminal  		= @p_cd_terminal
					   And dt_mov  				= @p_dt_mov
					   And hh_mm  				= @p_hh_mm
					   And tp_selo				= @v_tp_selo 
					   And arquivo				= @p_arquivo

					Update GEACupax..pax_baixa_selo_u 
					   Set status_arq  			= Case When status_arq 	= '2' then '0'
													   When status_arq 	= '3' then '0'
													   When status_arq 	= '1' AND SUBSTRING(arquivo,8,6) IN ('060116', '060117') then '0'
													   When status_arq 	= '0' then '0'
													   Else '0' End
						  ,qtd_lineas_arq		= @p_qtd_lineas_arq
						  ,date_changed 		= @p_date_process						  ,user_id_changed 		= @p_user_process
						  ,chgstamp  			= chgstamp + 1
					 Where cd_aerop 			= @p_cd_aerop
					   And cd_terminal 			= @p_cd_terminal
					   And dt_mov  				= @p_dt_mov
					   And hh_mm  				= @p_hh_mm
					   And tp_selo				= @v_tp_selo
					   And arquivo 				= @p_arquivo

					Select @v_mensaje = 'ARQUIVO:' + 
										@p_arquivo + ' ESTA DUPLICADO. STATUS DO ARQUIVO ' + 
										@p_status_arq_aux + ' NOVO STATUS ' + 
										Case When @p_status_arq_aux 	= '2' then '0'
											 When @p_status_arq_aux 	= '3' then '0'
											 When @p_status_arq_aux 	= '1' then '1'
											 When @p_status_arq_aux 	= '0' then '0' End		

					Insert into  pax_erro_job_selos_u Values (@v_mensaje, @p_date_process)		
		
				End	

				LEER_PROXIMO:

				Fetch next from cursor_arquivos_coletados into
					  @p_arquivo
					 ,@p_serie_coletor
					 ,@p_qtd_lineas_arq
			End

			Close cursor_arquivos_coletados
			Deallocate  cursor_arquivos_coletados

		Insert into  pax_erro_job_selos_u 
		Values ( 'Fim do Processo (' + CONVERT(varchar(30), GETDATE(), 131) + ')', @p_date_process )

		/* MOSTRAR SAIDA DO PROCESSO */
		Open cursor_log_processo

		Fetch next from cursor_log_processo into
			  @p_linha
			 ,@p_mensaje
 
		While @@FETCH_STATUS = 0
		Begin
			Set @v_mensaje = @p_mensaje + char(10) + char(13) 
			Print @v_mensaje
			
			Fetch next from cursor_log_processo into
				  @p_linha
				 ,@p_mensaje

		End
 
		Close cursor_log_processo
		Deallocate  cursor_log_processo

	Set NOCOUNT OFF
