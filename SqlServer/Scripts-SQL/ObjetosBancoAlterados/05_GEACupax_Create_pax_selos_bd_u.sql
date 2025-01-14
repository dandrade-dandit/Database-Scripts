USE GEACupax
GO
/****** Object:  Table dbo.pax_selos_bd_u    Script Date: 12/10/2010 08:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

If exists(select * from sysobjects where name = 'pax_selos_bd_u')
   drop table pax_selos_bd_u
go

CREATE TABLE pax_selos_bd_u (
    cd_aerop                                    char(4)     NOT NULL,
    cd_terminal                                 char(10)    NOT NULL,
    dt_mov                                      datetime    NOT NULL,
    nro_selo_electronico                        char(14)    NOT NULL,
    hh_mov                                      char(6)     NOT NULL,

    format_code                                 char(1)     NULL,
    num_legs_encode                             char(1)     NULL,
    passenger_name                              varchar(20) NULL,
    eletronic_ticket_ind                        char(1)     NULL,
    oper_carrier_pnr_code                       varchar(7)  NULL,
    source_code                                 char(3)     NULL,
    target_code                                 char(3)     NULL,
    oper_carrier_designator                     char(3)     NULL,
    flight_number                               varchar(5)  NULL,
    flight_date                                 char(3)     NULL,
    compartiment_code                           char(1)     NULL,
    seat_number                                 char(4)     NULL,
    checkin_seq_number                          varchar(5)  NULL,
    passenger_status                            char(1)     NULL,
    field_size_follow_var                       char(2)     NULL,
    beginning_version_number                    char(1)     NULL,
    version_number                              char(1)     NULL,
    field_size_follow_struc_unique              char(2)     NULL,
    passenger_desc                              char(1)     NULL,
    checkin_source                              char(1)     NULL,
    boarding_pass_source                        char(1)     NULL,
    boarding_pass_date                          varchar(4)  NULL,
    document_type                               char(1)     NULL,
    airline_desig_boarding_pass                 varchar(3)  NULL,
    field_size_follow_struc_repeat              varchar(2)  NULL,
    airline_numeric_code                        char(3)     NULL,
    document_form_serial_num                    varchar(10) NULL,
    selectee_indicator                          char(1)     NULL,
    international_doc_verification              char(1)     NULL,
    marketing_carrier_designator                varchar(3)  NULL,
    frequent_flyer_airline_desig                varchar(3)  NULL,
    frequent_flyer_num                          varchar(16) NULL,
    id_ad_indicator                             char(1)     NULL,
    free_baggage_allowance                      varchar(03) NULL,
    generic_individual_airline_use              char(1)     NULL,

    date_created                                datetime    NOT NULL,
    user_id_created                             char(30)    NOT NULL,
    date_changed                                datetime    NOT NULL,
    user_id_changed                             char(30)    NOT NULL,
    inactive_ind                                char(1)     NOT NULL,
    active_date                                 datetime    NOT NULL,
    chgstamp                                    smallint    NOT NULL,
    CONSTRAINT P_pax_selos_bd_u                 PRIMARY KEY CLUSTERED
             ( cd_aerop                         ASC,
               cd_terminal                      ASC,
               dt_mov                           ASC,
               nro_selo_electronico             ASC,
               hh_mov                           ASC )
          WITH (
               PAD_INDEX              = OFF, 
               STATISTICS_NORECOMPUTE = OFF, 
               IGNORE_DUP_KEY         = OFF, 
               ALLOW_ROW_LOCKS        = ON, 
               ALLOW_PAGE_LOCKS       = ON, 
               FILLFACTOR             = 80 ) ON [PRIMARY]
    ) ON [PRIMARY]

GO

/****** Object:  Index [nro_selo_electronico]    Script Date: 12/26/2010 09:43:29 ******/
CREATE NONCLUSTERED INDEX [nro_selo_electronico] ON [dbo].[pax_selos_bd_u]
     ( nro_selo_electronico ASC )
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

/****** Object:  Index [ChaveSelo]    Script Date: 12/26/2010 09:48:38 ******/
CREATE NONCLUSTERED INDEX [ChaveSelo] ON [dbo].[pax_selos_bd_u] 
     ( cd_aerop             ASC,
	   cd_terminal          ASC,
	   dt_mov               ASC,
	   nro_selo_electronico ASC )
  WITH 
     ( PAD_INDEX                = OFF, 
       STATISTICS_NORECOMPUTE   = OFF, 
       SORT_IN_TEMPDB           = OFF, 
       IGNORE_DUP_KEY           = OFF, 
       DROP_EXISTING            = OFF, 
       ONLINE                   = OFF, 
       ALLOW_ROW_LOCKS          = ON,
       ALLOW_PAGE_LOCKS         = ON, 
       FILLFACTOR               = 75 ) ON [PRIMARY]

SET ANSI_PADDING OFF
