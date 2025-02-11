USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[psp_carrega_selos_from_file]    Script Date: 12/28/2010 14:09:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER Procedure [dbo].[psp_carrega_selos_from_file]
As
    Declare @p_nro_selo                          Char(14),    -- Numero do selo lido (utilizado para os selos fisicos e eletronicos)
            @p_dt_leitura                        datetime,    -- Data da leitura (data e hora)
	        @p_tp_baixa                          Char(1),     -- Tipo da baixa (U=Utilizado, C=Cancelado, D=Devolvido)
            @p_cpf_agente                        Char(11),    -- Cpf do agente coletor (fornecido na inicialização do coletor)
            @p_serie_coletor                     Char(16),    -- Nº de série do coletor
            @p_cd_aerop_num                      Char(3),     -- sigla aeroporto iata de utilizacao
            @p_cd_terminal                       Char(10),    -- Identificação do terminal de passageiro (fornecido na inicialização do coletor)

            @p_format_code                       char(1),
            @p_num_legs_encode                   char(1),
            @p_passenger_name                    varchar(20),
            @p_eletronic_ticket_ind              char(1),
            @p_oper_carrier_pnr_code             varchar(7),
            @p_source_code                       char(3),
            @p_target_code                       char(3),
            @p_oper_carrier_designator           char(3),
            @p_flight_number                     varchar(5),
            @p_flight_date                       char(3),
            @p_compartiment_code                 char(1),
            @p_seat_number                       char(4),
            @p_checkin_seq_number                varchar(5),
            @p_passenger_status                  char(1),
            @p_field_size_follow_variable        char(2),
            @p_beginning_version_number          char(1),
            @p_version_number                    char(1),
            @p_field_size_follow_struc_unique    char(2),
            @p_passenger_desc                    char(1),
            @p_checkin_source                    char(1),
            @p_boarding_pass_source              char(1),
            @p_boarding_pass_date                varchar(4),
            @p_document_type                     char(1),
            @p_airline_desig_boarding_pass       varchar(3),
            @p_field_size_follow_struc_repeat    varchar(2),
            @p_airline_numeric_code              char(3),
            @p_document_form_serial_num          varchar(10),
            @p_selectee_indicator                char(1),
            @p_international_doc_verification    char(1),
            @p_marketing_carrier_designator      varchar(3),
            @p_frequent_flyer_airline_desig      varchar(3),
            @p_frequent_flyer_num                varchar(16),
            @p_id_ad_indicator                   char(1),
            @p_free_baggage_allowance            varchar(3),
            @p_generic_individual_airline_use    char(1),

            @w_selo                              varchar(255),
            @w_i                                 int,
            @w_dt_leitura_str                    char(19)

    Declare cursor_selos_coletados insensitive cursor for

        Select selo
          From TEMP_SELO_TRASFERIDO (nolock)

	    /* ABRIR CURSOR DE selos coletados */
	    Open cursor_selos_coletados

	    Fetch next from cursor_selos_coletados into
              @w_selo

	    While @@FETCH_STATUS = 0
	    Begin

            If @w_selo is Null Set @w_selo = space(255)

            -- selo fisico
            If Len(@w_selo) = 66
            Begin
                Set  @p_nro_selo                          = substring(@w_selo,   1,  9)
                Set  @w_dt_leitura_str                    = substring(@w_selo,  11, 19)
                Set  @p_tp_baixa                          = substring(@w_selo,  31,  1)
                Set  @p_cpf_agente                        = substring(@w_selo,  33, 11)
                Set  @p_serie_coletor                     = substring(@w_selo,  45, 16)
                Set  @p_cd_aerop_num                      = substring(@w_selo,  62,  3)
                Set  @p_cd_terminal                       = substring(@w_selo,  66,  1)
            End

            -- selo eletronico
            If Len(@w_selo) = 71
            Begin
                Set  @p_nro_selo                          = substring(@w_selo,   1, 14)
                Set  @w_dt_leitura_str                    = substring(@w_selo,  16, 19)
                Set  @p_tp_baixa                          = substring(@w_selo,  36,  1)
                Set  @p_cpf_agente                        = substring(@w_selo,  38, 11)
                Set  @p_serie_coletor                     = substring(@w_selo,  50, 16)
                Set  @p_cd_aerop_num                      = substring(@w_selo,  67,  3)
                Set  @p_cd_terminal                       = substring(@w_selo,  71,  1)
            End

            -- selo bidimensional
            If Len(@w_selo) > 71
            Begin
                Set  @p_nro_selo                          = Ltrim(Rtrim(substring(@w_selo,   1, 14)))
                Set  @w_dt_leitura_str                    = substring(@w_selo,  16, 19)
                Set  @p_tp_baixa                          = substring(@w_selo,  36,  1)
                Set  @p_cpf_agente                        = substring(@w_selo,  38, 11)
                Set  @p_serie_coletor                     = substring(@w_selo,  50, 16)
                Set  @p_cd_aerop_num                      = substring(@w_selo,  67,  3)
                Set  @p_cd_terminal                       = substring(@w_selo,  71,  1)

                Set  @w_i                                 = 72
                Set  @p_format_code                       = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_num_legs_encode                   = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_passenger_name                    = substring(@w_selo, @w_i, 20)
                Set  @w_i                                 = @w_i + 20
                Set  @p_eletronic_ticket_ind              = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_oper_carrier_pnr_code             = substring(@w_selo, @w_i,  7)
                Set  @w_i                                 = @w_i + 7
                Set  @p_source_code                       = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_target_code                       = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_oper_carrier_designator           = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_flight_number                     = substring(@w_selo, @w_i,  5)
                Set  @w_i                                 = @w_i + 5
                Set  @p_flight_date                       = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_compartiment_code                 = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_seat_number                       = substring(@w_selo, @w_i,  4)
                Set  @w_i                                 = @w_i + 4
                Set  @p_checkin_seq_number                = substring(@w_selo, @w_i,  5)
                Set  @w_i                                 = @w_i + 5
                Set  @p_passenger_status                  = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_field_size_follow_variable        = substring(@w_selo, @w_i,  2)
                Set  @w_i                                 = @w_i + 2
                Set  @p_beginning_version_number          = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_version_number                    = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_field_size_follow_struc_unique    = substring(@w_selo, @w_i,  2)
                Set  @w_i                                 = @w_i + 2
                Set  @p_passenger_desc                    = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_checkin_source                    = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_boarding_pass_source              = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_boarding_pass_date                = substring(@w_selo, @w_i,  4)
                Set  @w_i                                 = @w_i + 4
                Set  @p_document_type                     = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_airline_desig_boarding_pass       = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_field_size_follow_struc_repeat    = substring(@w_selo, @w_i,  2)
                Set  @w_i                                 = @w_i + 2
                Set  @p_airline_numeric_code              = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_document_form_serial_num          = substring(@w_selo, @w_i, 10)
                Set  @w_i                                 = @w_i + 10
                Set  @p_selectee_indicator                = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_international_doc_verification    = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_marketing_carrier_designator      = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_frequent_flyer_airline_desig      = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_frequent_flyer_num                = substring(@w_selo, @w_i, 16)
                Set  @w_i                                 = @w_i + 16
                Set  @p_id_ad_indicator                   = substring(@w_selo, @w_i,  1)
                Set  @w_i                                 = @w_i + 1
                Set  @p_free_baggage_allowance            = substring(@w_selo, @w_i,  3)
                Set  @w_i                                 = @w_i + 3
                Set  @p_generic_individual_airline_use    = substring(@w_selo, @w_i,  1)
            End

            -- converte data da leitura do selo
            Set @p_dt_leitura = Cast(@w_dt_leitura_str as datetime)

            If Cast(substring(@w_dt_leitura_str, 6, 2) as int) < 12
                Set @p_dt_leitura = Cast( Substring(@w_dt_leitura_str, 1, 4) + '/' +
                                          Substring(@w_dt_leitura_str, 9, 2) + '/' +
                                          Substring(@w_dt_leitura_str, 6, 2) + ' ' +
                                          Substring(@w_dt_leitura_str, 12, 8) as datetime )

            -- busca serie do coletor pela dependencia
            Select Top 1
                   @p_serie_coletor = serial
              From GEACupax..pax_coletor_u (nolock)
             Where inactive_ind     = 0
               And dependencia      = @p_cd_aerop_num

            -- carrega nas tabelas de selos coletados
            Exec GEACupax..psp_carrega_selos_bd
                 @p_format_code,
                 @p_num_legs_encode,
                 @p_passenger_name,
                 @p_eletronic_ticket_ind,
                 @p_oper_carrier_pnr_code,
                 @p_source_code,
                 @p_target_code,
                 @p_oper_carrier_designator,
                 @p_flight_number,
                 @p_flight_date,
                 @p_compartiment_code,
                 @p_seat_number,
                 @p_checkin_seq_number,
                 @p_passenger_status,
                 @p_field_size_follow_variable,
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
                 @p_international_doc_verification,
                 @p_marketing_carrier_designator,
                 @p_frequent_flyer_airline_desig,
                 @p_frequent_flyer_num,
                 @p_id_ad_indicator,
                 @p_free_baggage_allowance,
                 @p_generic_individual_airline_use,

	             @p_tp_baixa,               -- Tipo da baixa (U=Utilizado, C=Cancelado, D=Devolvido)
                 @p_dt_leitura,             -- Data da leitura (data e hora)
                 @p_serie_coletor,          -- Nº de série do coletor (os 9 caracteres da direita para a esquerda)
                 '1',                       -- 1 para off-line (quando descarregado do desktop) | 2 para coletor (on-line)
                 @p_cd_terminal,            -- Identificação do terminal de passageiro
                 @p_cpf_agente,             -- Cpf do agente coletor (fornecido na inicialização do coletor)
	             '',                        -- Quando o envio for do coletor enviar uma string vazia, quando for transferencia off-line, enviar o login do usuario do programa coleta de selos 
               --'100',                     -- Versao do software do coletor (esta versão deverá conter três caracteres numericos - ex: 200)
                 @p_nro_selo                -- Numero do selo lido (utilizado para os selos fisicos e eletronicos)

            Fetch next from cursor_selos_coletados into
                  @w_selo

        End

    	Close cursor_selos_coletados
	    Deallocate  cursor_selos_coletados

