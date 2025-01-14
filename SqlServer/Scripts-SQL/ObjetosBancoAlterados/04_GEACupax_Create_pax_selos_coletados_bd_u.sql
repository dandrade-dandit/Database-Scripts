USE GEACupax
GO
/****** Object:  Table dbo.pax_selos_coletados_bd_u    Script Date: 12/10/2010 07:28:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

if exists(select * from sysobjects where name = 'pax_selos_coletados_bd_u')
   drop table pax_selos_coletados_bd_u
go


CREATE TABLE pax_selos_coletados_bd_u (
    arquivo                                  char(40)    NOT NULL,
    nro_linha                                int         NOT NULL,
    linha                                    char(30)    NOT NULL,
    cd_aerop_num                             char(3)     NULL,
    tp_selo                                  char(1)     NOT NULL,
    nro_selo                                 char(14)    NOT NULL,
    format_code                              char(1)     NULL,
    num_legs_encode                          char(1)     NULL,
    passenger_name                           varchar(20) NULL,
    eletronic_ticket_ind                     char(1)     NULL,
    oper_carrier_pnr_code                    varchar(7)  NULL,
    source_code                              char(3)     NULL,
    target_code                              char(3)     NULL,
    oper_carrier_designator                  char(3)     NULL,
    flight_number                            varchar(5)  NULL,
    flight_date                              char(3)     NULL,
    compartiment_code                        char(1)     NULL,
    seat_number                              char(4)     NULL,
    checkin_seq_number                       varchar(5)  NULL,
    passenger_status                         char(1)     NULL,
    field_size_follow_var                    char(2)     NULL,
    beginning_version_number                 char(1)     NULL,
    version_number                           char(1)     NULL,
    field_size_follow_struc_unique           char(2)     NULL,
    passenger_desc                           char(1)     NULL,
    checkin_source                           char(1)     NULL,
    boarding_pass_source                     char(1)     NULL,
    boarding_pass_date                       varchar(4)  NULL,
    document_type                            char(1)     NULL,
    airline_desig_boarding_pass              varchar(3)  NULL,
    field_size_follow_struc_repeat           varchar(2)  NULL,
    airline_numeric_code                     char(3)     NULL,
    document_form_serial_num                 varchar(10) NULL,
    selectee_indicator                       char(1)     NULL,
    international_doc_verification           char(1)     NULL,
    marketing_carrier_designator             varchar(3)  NULL,
    frequent_flyer_airline_desig             varchar(3)  NULL,
    frequent_flyer_num                       varchar(16) NULL,
    id_ad_indicator                          char(1)     NULL,
    free_baggage_allowance                   varchar(3)  NULL,
    generic_individual_airline_use           char(1)     NULL,
    tp_baixa                                 char(1)     NULL,
    dt_leitura                               datetime    NULL,
    serie_coletor                            char(9)     NULL,
    tp_coletor                               char(16)    NULL,
    cd_terminal                              char(10)    NULL,
    user_id                                  char(30)    NULL,
    cpf_agente                               char(11)    NULL,
    login                                    char(60)    NULL,
    versao_coletor                           char(3)     NULL,
    status_linha                             char(1)     NOT NULL,
    user_id_created                          char(30)    NULL,
    date_created                             datetime    NOT NULL,

    CONSTRAINT P_pax_selos_coletados_bd_u PRIMARY KEY CLUSTERED (
               arquivo    ASC,
               nro_linha  ASC )
          WITH (
               PAD_INDEX              = OFF, 
               STATISTICS_NORECOMPUTE = OFF, 
               IGNORE_DUP_KEY         = OFF, 
               ALLOW_ROW_LOCKS        = ON, 
               ALLOW_PAGE_LOCKS       = ON, 
               FILLFACTOR             = 80 )  ON [PRIMARY]
    ) ON [PRIMARY]

GO

/****** Object:  Index [nro_selo_electronico]    Script Date: 12/26/2010 09:43:29 ******/
CREATE NONCLUSTERED INDEX [nro_selo] ON [dbo].[pax_selos_coletados_bd_u]
     ( nro_selo ASC )
  WITH 
     ( PAD_INDEX                = OFF, 
       STATISTICS_NORECOMPUTE   = OFF, 
       SORT_IN_TEMPDB           = OFF, 
       IGNORE_DUP_KEY           = OFF, 
       DROP_EXISTING            = OFF, 
       ONLINE                   = OFF, 
       ALLOW_ROW_LOCKS          = ON, 
       ALLOW_PAGE_LOCKS         = ON, 
       FILLFACTOR               = 80 ) ON [PRIMARY]

go

SET ANSI_PADDING OFF