USE [GEACupax]
GO
/****** Object:  StoredProcedure [dbo].[usp_val_upza]    Script Date: 12/29/2010 10:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  Stored Procedure dbo.usp_val_upza    Script Date: 19/09/2008 15:21:37 ******/



/*
EXECUTE DCDF0087.GEACupax.dbo.usp_val_upza 
'SBGR', 
'1', 
'20041123', 
'0012401002', 
'1900-01-01 00:00:00', 
'D', 
'2', 
'', 
'F', 
'TAM', 
'A', 
'19000101', 
'SBGR', 
'1', 
'01', 
'EMBDOM1ESPECIAL', 
0, 
'19000101', 
'', 
'', 
'000000000', '0', '20041123', '000000', '20041125', 'DBS', '', '0', '20041125', 'upa9922', '1', 'nro_selo_electronico','X', '0000' , '', '' 

*/





Alter Procedure [dbo].[usp_val_upza] 
     ( @p_cd_aerop                  char(4), 
       @p_cd_terminal               char(10), 
       @p_dt_mov                    datetime, 
       @p_nro_selo_electronico      char(14), 
       @p_date_changed_char         char(20), 
       @p_tp_natureza               char(1), 
       @p_selo_status               char(1), 
       @p_cd_motivo                 char(2), 
       @p_tp_fat                    char(1), 
       @p_cd_cia_aerea              char(3), 
       @p_tp_unid                   char(1), 
       @p_dt_confirma               datetime, 
       @p_cd_aerop_utilizacao       char(4), 
       @p_cd_terminal_utilizacao    char(10), 
       @p_tp_coletor                char(16), 
       @p_item_fat                  char(26), 
       @p_billing_line_id           int, 
       @p_billing_int_date          datetime, 
       @p_billing_int_type          char(1), 
       @p_billing_user_1            char(10),
       @p_recv_doc_id               char(9),
       @p_voo_rea                   char(4), 					
       @p_dt_voo_rea                datetime,
       @p_hh_voo_rea                char(6), 
       @p_date_created              datetime, 
       @p_user_id_created           char(30), 
       @p_user_id_changed           char(30), 
       @p_inactive_ind              char(1), 
       @p_active_date               datetime, 
       -- Especiais
       @p_activity_id               char(10),           -- Código da Atividade
       @p_output                    char(1) ,           -- 1 faz select do codigo da mensagem-- 0 nao faz deve utilizar variavel output
       @p_campo                     char(20),           -- Nome do campo a ser validado, ou 'todos' para validar tudo
       @p_acao                      char(1),            -- I Inclusao  U Update  D Delete  C Consulta  X viene del itemghanged
       @p_error_message_id          char(10)  output,   -- Código da mensagem de erro ou 0000 se estiver tudo OK
       @p_error_complemento         char(100) output,   -- Complemento da mensagem
       @p_error_campo               char(20)  output)   -- Código do campo com erro

AS 
-- Iniciando Variaveis de Retorno
SELECT  @p_error_message_id = '0000', @p_error_complemento = ' ',  @p_error_campo = ' '
-- Outras Variaveis
DECLARE @result  			VARCHAR(255)
		,@v_cd_cia_num		CHAR(2)
		,@v_cd_cia_aerea	CHAR(3)

-- ------------------------------------------------------------------------
-- VALIDAR AEROPORTO
IF @p_campo = 'cd_aerop' OR @p_campo = 'todos'
BEGIN
    SELECT @result = no_aerop FROM GEACutcx..cor_aeroporto_u (NOLOCK INDEX = P_cor_aeroporto_u) WHERE cd_aerop = @p_cd_aerop
    IF  @result = '' OR @result IS NULL
    BEGIN
        SELECT @p_error_message_id   	= 'utc0026'
        SELECT @p_error_complemento   	= ''
        SELECT @p_error_campo     		= 'cd_aerop'
        GOTO  TERMINA 
    END 
    ELSE
    BEGIN
        SELECT @p_error_message_id   	= '0000'
        SELECT @p_error_complemento   	= @result
        SELECT @p_error_campo     		= 'cd_aerop'
        IF @p_acao = 'X' GOTO TERMINA
    END
END
-- ------------------------------------------------------------------------
-- VALIDAR TERMINAL
IF @p_campo = 'cd_terminal' OR @p_campo = 'todos'
BEGIN
    SELECT @result = terminal 
    FROM GEACutcx..cor_terminal_aerop_u  (NOLOCK INDEX = P_cor_terminal_aerop_u) 
    WHERE cd_aerop  	= @p_cd_aerop
      and terminal   	= @p_cd_terminal
      and inactive_ind  	= '0'
    IF  @result = '' OR @result IS NULL
    BEGIN
        SELECT @p_error_message_id   	= 'utc0049'
        SELECT @p_error_complemento   	= ''
        SELECT @p_error_campo     		= 'cd_termina'
        GOTO  TERMINA 
    END 
    ELSE
    BEGIN
        SELECT @p_error_message_id   	= '0000'
        SELECT @p_error_complemento   	= @result
        SELECT @p_error_campo     		= 'cd_termina'
        IF @p_acao = 'X' GOTO TERMINA
    END
END 

-- ------------------------------------------------------------------------
-- VALIDAR DT_MOV
IF @p_campo = 'dt_mov' OR @p_campo = 'todos'
BEGIN
    IF @p_dt_mov > GETDATE()
    BEGIN
        SELECT @p_error_message_id   	= 'upa9010'
        SELECT @p_error_complemento   	= ''
        SELECT @p_error_campo     		= 'dt_mov'
        GOTO  TERMINA 
    END
END

-- ------------------------------------------------------------------------
-- VALIDAR NRO_SELO_ELECTRONICO
IF @p_campo = 'nro_selo_electronico' OR @p_campo = 'todos'
BEGIN

	IF LEN(@p_nro_selo_electronico) <> 14
	BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'O número de Selo deve estar composto por 14 dígitos.'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
	END 

	IF ISNUMERIC(@p_nro_selo_electronico) = 0
	BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'O número de Selo deve estar composto só por dígitos numéricos.'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
	END 

    IF SUBSTRING(@p_nro_selo_electronico, 1,1) NOT IN ('0', '1')
    BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'O primeiro dígito do número de Selo deve ser [0] para Doméstico ou [1] para Internacional.'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
    END

	SET @v_cd_cia_num = SUBSTRING(@p_nro_selo_electronico, 2,2)	

    SELECT @v_cd_cia_aerea = cd_cia_aerea 
    FROM GEACutcx..cor_cia_aerea_u  (NOLOCK INDEX = ix_cd_cia_num)
    WHERE cd_cia_num  			= @v_cd_cia_num
      and inactive_ind  	= '0'
    IF  @v_cd_cia_aerea = '' OR @v_cd_cia_aerea IS NULL
    BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'A companhia aérea não existe [' + @v_cd_cia_num + '].'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
    END 

	IF @p_campo = 'todos'
	BEGIN
		IF @v_cd_cia_aerea <> @p_cd_cia_aerea		
		BEGIN
	        SELECT @p_error_message_id   	= 'upa9097'
	        SELECT @p_error_complemento   	= 'O Selo não pertence à companhia indicada. O Selo pertenece a [' + @v_cd_cia_aerea + '].'
	        SELECT @p_error_campo     		= 'nro_selo_electronico'
	        GOTO  TERMINA 
		END
	END

    -- devolve se selo bidimensional
    Select @result              = count(1) 
      From GEACupax..pax_selos_bd_u (NOLOCK) 
     Where cd_aerop             = @p_cd_aerop
       And cd_terminal          = @p_cd_terminal
       And dt_mov               = @p_dt_mov
       And nro_selo_electronico = @p_nro_selo_electronico
    
    Select @p_error_message_id   	= '0000'
    Select @p_error_complemento   	= @result
    Select @p_error_campo     		= 'nro_selo_electronico'
    If @p_acao = 'X' Goto TERMINA
END

-- ------------------------------------------------------------------------
-- VALIDAR cd_cia_aerea
IF @p_campo = 'cd_cia_aerea' OR @p_campo = 'todos'
BEGIN
    SELECT @result = no_cia_aerea 
    FROM GEACutcx..cor_cia_aerea_u  (NOLOCK INDEX = P_cor_cia_aerea_u)  
    WHERE cd_cia_aerea  = @p_cd_cia_aerea
      and inactive_ind   = '0'
    IF  @result = '' OR @result IS NULL    BEGIN
        SELECT @p_error_message_id   	= 'utc0074'
        SELECT @p_error_complemento   	= ''
        SELECT @p_error_campo     		= 'cd_cia_aerea'
        GOTO  TERMINA 
    END 
    ELSE
    BEGIN
        SELECT @p_error_message_id   	= '0000'
        SELECT @p_error_complemento   	= @result
        SELECT @p_error_campo     		= 'cd_cia_aerea'
        IF @p_acao = 'X' GOTO TERMINA
    END
END 

IF @p_campo = 'todos'
	IF @p_tp_natureza = 'D' AND SUBSTRING(@p_nro_selo_electronico,1,1) <> '0'
	BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'Natureza do Selo inválida.'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
	END

	IF @p_tp_natureza = 'I' AND SUBSTRING(@p_nro_selo_electronico,1,1) <> '1'
	BEGIN
        SELECT @p_error_message_id   	= 'upa9097'
        SELECT @p_error_complemento   	= 'Natureza do Selo inválida.'
        SELECT @p_error_campo     		= 'nro_selo_electronico'
        GOTO  TERMINA 
	END

TERMINA:
IF @p_output = '1'
BEGIN
    SELECT @p_error_message_id,  @p_error_complemento ,  @p_error_campo         
END
IF  @p_error_message_id = '0000'
    RETURN 0
ELSE
    RETURN 1
