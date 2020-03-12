USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[psp_carrega_selos_bd]    Script Date: 12/31/2010 08:37:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists(select * from sysobjects where name = 'psp_carrega_selos_bd')
   drop procedure psp_carrega_selos_bd
go

Create procedure [dbo].[psp_carrega_selos_bd] (
      -- Parametros utilizados para selos bidimensionais (exceto o campo @p_souce_code que será utilizado em todos os tipos de selo)
      @p_format_code                       char(1)    = '',
      @p_num_legs_encode                   char(1)    = '',
      @p_passenger_name                    varchar(20),
      @p_eletronic_ticket_indicator        char(1)    = '',
      @p_operation_carrier_prn_code        varchar(7),
      @p_source_code                       char(3), -- quando for a leitura de um selo unidimensional (fisico ou eletronico) enviar o codigo do aeroporto de leitura (exemplo: 057), quando for um selo bidimensional enviar o dado vindo do código 2d
      @p_target_code                       char(3)    = '',  
      @p_operation_carrier_designator      char(3)    = '',
      @p_flight_number                     varchar(5) = '',
      @p_flight_date                       char(3)    = '',
      @p_compartiment_code                 char(1)    = '',
      @p_seat_number                       char(4)    = '',
      @p_checkin_seq_number                varchar(5) = '',
      @p_passenger_status                  char(1)    = '',
      @p_field_size_following_variable     char(2)    = '',
      @p_beginning_version_number          char(1)    = '',
      @p_version_number                    char(1)    = '',
      @p_field_size_follow_struc_unique    char(2)    = '',
      @p_passenger_desc                    char(1)    = '',
      @p_checkin_source                    char(1)    = '',
      @p_boarding_pass_source              char(1)    = '',
      @p_boarding_pass_date                varchar(4) = '',
      @p_document_type                     char(1)    = '',
      @p_airline_desig_boarding_pass       varchar(3) = '',
      @p_field_size_follow_struc_repeat    varchar(2) = '',
      @p_airline_numeric_code              char(3)    = '',
      @p_document_form_serial_num          varchar(10),
      @p_selectee_indicator                char(1),
      @p_internat_document_verific         char(1)    = '',
      @p_marketing_carrier_designator      varchar(3) = '',
      @p_frequent_flyer_airl_design        varchar(3) = '',
      @p_frequent_flyer_num                varchar(16),
      @p_id_ad_indicator                   char(1)    = '',
      @p_free_baggage_allowance            varchar(3) = '',
      @p_generic_indiv_airline_use         char(1)    = '',
	  -- Parametros utilizados em todos os tipos de selo
	  @p_tp_baixa                          Char(1)   = 'U',  -- Tipo da baixa (U=Utilizado, C=Cancelado, D=Devolvido)
      @p_dt_leitura                        datetime,         -- Data da leitura (data e hora)
      @p_serie_coletor                     Char(9),          -- Nº de série do coletor (os 9 caracteres da direita para a esquerda)
      @p_tp_coletor                        Char(16),         -- 1 para off-line (quando descarregado do desktop) | 2 para coletor (on-line)
      @p_cd_terminal                       Char(10),         -- Identificação do terminal de passageiro
      @p_cpf_agente                        Char(11),         -- Cpf do agente coletor (fornecido na inicialização do coletor)
	  @p_login                             Char(60)   = '',  -- Quando o envio for do coletor enviar uma string vazia, quando for transferencia off-line, enviar o login do usuario do programa coleta de selos 
    --@p_versao_coletor                    Char(3),          -- Versao do software do coletor (esta versão deverá conter três caracteres numericos - ex: 200)
	  -- Parâmetro utilizado para selos fisicos e eletronicos (codigo de barras unidimensional)
      @p_nro_selo                          Char(14)   = '' ) -- Numero do selo lido (utilizado para os selos fisicos e eletronicos)
As

    /*
    Select
      @p_format_code,
      @p_num_legs_encode,
      @p_passenger_name,
      @p_eletronic_ticket_indicator,
      @p_operation_carrier_prn_code,
      @p_source_code,
      @p_target_code,
      @p_operation_carrier_designator,
      @p_flight_number,
      @p_flight_date,
      @p_compartiment_code,
      @p_seat_number,
      @p_checkin_seq_number,
      @p_passenger_status,
      @p_field_size_following_variable,
      @p_beginning_version_number,
      @p_version_number,
      @p_field_size_follow_struc_unique,
      @p_passenger_desc,
      @p_checkin_source,
      @p_boarding_pass_source,
      @p_boarding_pass_date,
      @p_document_type,
      @p_airline_desig_boarding_pass,
      @p_field_size_follow_struc_repeat,
      @p_airline_numeric_code,
      @p_document_form_serial_num,
      @p_selectee_indicator,
      @p_internat_document_verific,
      @p_marketing_carrier_designator,
      @p_frequent_flyer_airl_design,
      @p_frequent_flyer_num,
      @p_id_ad_indicator,
      @p_free_baggage_allowance,
      @p_generic_indiv_airline_use,
	  @p_tp_baixa,
      @p_dt_leitura,
      @p_serie_coletor,
      @p_tp_coletor,
      @p_cd_terminal,
      @p_cpf_agente,
	  @p_login,
    --@p_versao_coletor,
      @p_nro_selo
    */

    Declare @w_nro_linha                   int,
            @w_tp_selo                     char(1),
            @w_tp_natureza                 char(1),
            @w_archivo                     char(40),
            @w_tipo_baixa                  char(1),
            @w_status_linha                char(1),
            @w_data_leitura                char(6),
            @w_data_leitura_str            char(12),
		    @w_user_id                     char(30),
		    @w_cd_aerop                    char(4),
            @w_cd_aerop_num                char(3),
            @w_cd_cia_num                  char(2),
            @w_data_envio_str              char(13),
            @w_date_created                datetime,
            @w_qtd_voo                     int,
            @w_hotran_voo_dd               char(2),
            @w_hotran_voo_mm               char(2),
            @w_passenger_seq               char(3),
            @w_nro_selo                    char(14),
            @w_linha                       char(30),
            @w_versao_coletor              Char(3)


    If @p_dt_leitura is Null Set @p_dt_leitura = GETDATE()

    Set    @p_tp_baixa         = 'U'
    Set    @w_versao_coletor   = '100'
    Set    @w_data_leitura     = CONVERT(char(6), @p_dt_leitura, 12)
    Set    @w_data_leitura_str = @w_data_leitura + REPLACE(CONVERT(char(8), @p_dt_leitura, 108), ':', '')
    Set    @p_serie_coletor    = rtrim(@p_serie_coletor)
    Set    @w_tipo_baixa       = @p_tp_baixa
    Set    @w_nro_selo         = @p_nro_selo
    Set    @w_status_linha     = '0'
    Set    @w_data_envio_str   = Convert(char(6), GETDATE(), 12) + '-000000'
    Set    @w_user_id          = suser_sname()
    Set    @w_date_created     = getdate()

    Select @w_cd_aerop_num     = dependencia
      From GEACupax..pax_coletor_u (nolock)
     Where serial              = @p_serie_coletor

    If @p_nro_selo Is Null Or len(Ltrim(rtrim(@p_nro_selo))) = 0 
    Begin
        -- monta natureza do voo
        Set     @w_tp_selo       = 'T'
        Set     @w_tp_natureza   = '0'
        Set     @w_passenger_seq = Right(Cast(Ltrim(Rtrim(@p_checkin_seq_number)) as bigint) + 1000, 3)

        Select @w_qtd_voo        = COUNT(1)
          From GEACutcx..cor_aeroporto_u (nolock)
         Where inactive_ind      = 0
           And (sigla_aerop_iata = @p_source_code
            Or  sigla_aerop_iata = @p_target_code)
        
        If @w_qtd_voo != 2 Set @w_tp_natureza = '1'

        -- monta cia aerea
        Select @w_cd_cia_num     = cd_cia_num
          From GEACutcx..cor_cia_aerea_u (nolock)
         Where sigla_iata        = @p_operation_carrier_designator
           And inactive_ind      = 0

        -- monta data da hotran do voo
        Set @w_hotran_voo_dd     = Right( Day( Dateadd(day, Cast(@p_flight_date as int)-1, Ltrim(Str(Year(getdate())) + '0101') ) ) + 100, 2)
        Set @w_hotran_voo_mm     = Right( Month( Dateadd(day, Cast(@p_flight_date as int)-1, Ltrim(Str(Year(getdate())) + '0101') ) ) + 100, 2)

        -- monta numero do selo
        Set @w_nro_selo          = @w_tp_natureza            + 
                                   @w_cd_cia_num             +
                                   Left(@p_flight_number, 4) +
                                   @w_hotran_voo_mm          +
                                   @w_hotran_voo_dd          +
                                   @w_passenger_seq
    End

    Set    @w_linha   = @w_data_leitura_str + '*' + rtrim(@w_nro_selo)
    Select @w_tp_selo = Case When len(rtrim(@w_nro_selo)) =  9  Then 'F'
                             When len(rtrim(@w_nro_selo)) = 10  Then 'L'
                             When len(rtrim(@w_nro_selo)) = 14  Then 'T'
                        End

    -- monta nome do arquivo
    Select @w_archivo = @w_cd_aerop_num + 
                        Rtrim(@p_cd_terminal) + '_' +
                        @w_tp_selo + '_' + 
                        @w_data_envio_str + '_' +
                        @p_tp_baixa + '00' + '_' +
                        @w_versao_coletor +
                        '.TXT'

    -- recupera ultima linha
    Begin  tran

    Select @w_nro_linha = max(nro_linha)
      From GEACupax..pax_selos_coletados_u (tablockx)
     Where arquivo      = @w_archivo

    Set    @w_nro_linha    = IsNull(@w_nro_linha, 2) + 1

    /*
    Select @w_archivo         as archivo,
           @w_nro_linha       as nro_linha,
           @w_linha           as linha,
           @w_cd_aerop_num    as cd_aerop_num,
           @w_tp_selo         as tp_selo,
           @w_nro_selo        as nro_selo,
           @w_tipo_baixa      as tipo_baixa,
           @p_serie_coletor   as serie_coletor,
           @p_cpf_agente      as cpf_agente,
           @w_status_linha    as status_linha,
           @w_user_id         as user_id,
           @w_date_created    as date_created
    */

    Insert Into GEACupax..pax_selos_coletados_u
    Values ( 
           @w_archivo,
           @w_nro_linha,
           @w_linha,
           @w_cd_aerop_num,
           @w_tp_selo,
           @w_nro_selo,
           @w_tipo_baixa,
           @p_serie_coletor,
           @p_cpf_agente,
           @w_status_linha,
           @w_user_id,
           @w_date_created )

    If @p_nro_selo Is Null Or len(Ltrim(rtrim(@p_nro_selo))) = 0 
    Begin

        /*
        Select archivo                          = @w_archivo,
               nro_linha                        = @w_nro_linha,
               linha                            = @w_linha,
               cd_aerop_num                     = @w_cd_aerop_num,
               tp_selo                          = @w_tp_selo,
               nro_selo                         = @w_nro_selo,

               format_code                      = @p_format_code,
               num_legs_encode                  = @p_num_legs_encode,
               passenger_name                   = @p_passenger_name,
               eletronic_ticket_indicator       = @p_eletronic_ticket_indicator,
               operation_carrier_prn_code       = @p_operation_carrier_prn_code,
               source_code                      = @p_source_code,
               target_code                      = @p_target_code,
               operation_carrier_designator     = @p_operation_carrier_designator,
               flight_number                    = @p_flight_number,
               flight_date                      = @p_flight_date,
               compartiment_code                = @p_compartiment_code,
               seat_number                      = @p_seat_number,
               checkin_seq_number               = @p_checkin_seq_number,
               passenger_status                 = @p_passenger_status,
               field_size_following_variable    = @p_field_size_following_variable,
               beginning_version_number         = @p_beginning_version_number,
               version_number                   = @p_version_number,
               field_size_follow_struc_unique   = @p_field_size_follow_struc_unique,
               passenger_desc                   = @p_passenger_desc,
               checkin_source                   = @p_checkin_source,
               boarding_pass_source             = @p_boarding_pass_source,
               boarding_pass_date               = @p_boarding_pass_date,
               document_type                    = @p_document_type,
               airline_desig_boarding_pass      = @p_airline_desig_boarding_pass,
               field_size_follow_struc_repeat   = @p_field_size_follow_struc_repeat,
               airline_numeric_code             = @p_airline_numeric_code,
               document_form_serial_num         = @p_document_form_serial_num,
               selectee_indicator               = @p_selectee_indicator,
               internat_document_verific        = @p_internat_document_verific,
               marketing_carrier_designator     = @p_marketing_carrier_designator,
               frequent_flyer_airl_design       = @p_frequent_flyer_airl_design,
               frequent_flyer_num               = @p_frequent_flyer_num,
               id_ad_indicator                  = @p_id_ad_indicator,
               free_baggage_allowance           = @p_free_baggage_allowance,
               generic_indiv_airline_use        = @p_generic_indiv_airline_use,
			   tp_baixa                         = @p_tp_baixa, 
               dt_leitura                       = @p_dt_leitura,
               serie_coletor                    = @p_serie_coletor,
               tp_coletor                       = @p_tp_coletor,
               cd_terminal                      = @p_cd_terminal,
               user_id                          = @w_user_id,
               cpf_agente                       = @p_cpf_agente,
			   login                            = @p_login,
               versao_coletor                   = @p_versao_coletor,
               status_linha                     = @w_status_linha,
               user_id                          = @w_user_id,
               date_created                     = @w_date_created
        */

        Insert Into GEACupax..pax_selos_coletados_bd_u
        Values (
               @w_archivo,
               @w_nro_linha,
               @w_linha,
               @w_cd_aerop_num,
               @w_tp_selo,
               @w_nro_selo,

               @p_format_code,
               @p_num_legs_encode,
               @p_passenger_name,
               @p_eletronic_ticket_indicator,
               @p_operation_carrier_prn_code,
               @p_source_code,
               @p_target_code,
               @p_operation_carrier_designator,
               @p_flight_number,
               @p_flight_date,
               @p_compartiment_code,
               @p_seat_number,
               @p_checkin_seq_number,
               @p_passenger_status,
               @p_field_size_following_variable,
               @p_beginning_version_number,
               @p_version_number,
               @p_field_size_follow_struc_unique,
               @p_passenger_desc,
               @p_checkin_source,
               @p_boarding_pass_source,
               @p_boarding_pass_date,
               @p_document_type,
               @p_airline_desig_boarding_pass,
               @p_field_size_follow_struc_repeat,
               @p_airline_numeric_code,
               @p_document_form_serial_num,
               @p_selectee_indicator,
               @p_internat_document_verific,
               @p_marketing_carrier_designator,
               @p_frequent_flyer_airl_design,
               @p_frequent_flyer_num,
               @p_id_ad_indicator,
               @p_free_baggage_allowance,
               @p_generic_indiv_airline_use,
			   @p_tp_baixa, 
               @p_dt_leitura,
               Right(@p_serie_coletor, 9),
               @p_tp_coletor,
               @p_cd_terminal,
               @w_user_id,
               @p_cpf_agente,
			   @p_login,
               @w_versao_coletor,
               @w_status_linha,
               @w_user_id,
               @w_date_created )
    End

    Commit

Go

Grant Execute On psp_carrega_selos_bd To Public
Go




