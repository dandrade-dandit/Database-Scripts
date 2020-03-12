alter Trigger T_CHG_TRU On T_CHG
For Update As
Begin
IF @@ROWCOUNT = 0 RETURN
SET NOCOUNT ON
If Update (CD_CHG)
Begin
  RollBack Transaction
  RaisError 20002 'Operação não executada: A informação <Código do Vôo de Chegada> da tabela <Chegadas> não pode ser alterada.'
  Return
End
If Update (CD_AER)
/* Aeroporto»Chegadas: Aeroporto da Chegada */
If (Select Count(*) From T_AER, Inserted
Where T_AER.CD_AER = Inserted.CD_AER)
 <>(Select Count(CD_AER) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Aeroporto> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_AEN_CHG)
/* Aeronave»Chegadas: Aeronave da Chegada */
If (Select Count(*) From T_AEN, Inserted
Where T_AEN.CD_AEN = Inserted.CD_AEN_CHG)
 <>(Select Count(CD_AEN_CHG) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Aeronave> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_COM)
/* Companhia Aérea»Chegadas: Comapanhia Aérea da Chegada */
If (Select Count(*) From T_COM, Inserted
Where T_COM.CD_COM = Inserted.CD_COM)
 <>(Select Count(CD_COM) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Companhia Aérea> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_EQP_CHG)
/* Equipamento»Chegadas: Equipamento da Chegada */
If (Select Count(*) From T_EQP, Inserted
Where T_EQP.CD_EQP = Inserted.CD_EQP_CHG)
 <>(Select Count(CD_EQP_CHG) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Equipamento> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_BOX)
/* Box»Chegadas: Box da Chegada */
If (Select Count(*) From T_BOX, Inserted
Where T_BOX.CD_BOX = Inserted.CD_BOX)
 <>(Select Count(CD_BOX) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Box> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_SIT)
/* Situação»Chegadas: Situação da Chegada */
If (Select Count(*) From T_SIT, Inserted
Where T_SIT.CD_SIT = Inserted.CD_SIT)
 <>(Select Count(CD_SIT) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Situação> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_IFT)
/* Informante da Situação de Vôo»Chegadas: Informante da Situação de Chegada */
If (Select Count(*) From T_IFT, Inserted
Where T_IFT.CD_IFT = Inserted.CD_IFT)
 <>(Select Count(CD_IFT) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Informante da Situação de Vôo> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_CHG_VIN)
/* Chegadas»Chegadas: Chegada Vinculada */
If (Select Count(*) From T_CHG, Inserted
Where T_CHG.CD_CHG = Inserted.CD_CHG_VIN)
 <>(Select Count(CD_CHG_VIN) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Chegadas> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (CD_USR)
/* Usuários»Chegadas: Usuário logado */
If (Select Count(*) From T_USR, Inserted
Where T_USR.CD_USR = Inserted.CD_USR)
 <>(Select Count(CD_USR) From Inserted)
Begin
  RollBack Transaction
  RaisError 20001 'Operação não executada: A informação <Usuários> que se deseja incluir na tabela <Chegadas> não está cadastrada'
  Return
End
If Update (TP_CHG_GRU)
Or Update (TP_CHG)
Or Update (TP_CHG_NAT)
Or Update (TP_CHG_CTG)
Or Update (TP_CHG_STA)
/* Domínio de: Grupo do Vôo */
/* 1 - Grupo 1 */
/* 2 - Grupo 2 */
If (Select Count(*) From Inserted
    Where TP_CHG_GRU In (1,2))
 <>(Select Count(*) From Inserted)
Begin
  RollBack Transaction
  RaisError 20004 'Operação não executada: A informação <Grupo do Vôo> que se deseja incluir na tabela <Chegadas> não é uma opção válida'
  Return
End
/* Domínio de: Tipo do Vôo de Chegada */
/* 1 - DOM-Doméstico */
/* 2 - INT-Internacional */
/* 3 - REG-Regional */
If (Select Count(*) From Inserted
    Where TP_CHG In (1,2,3))
 <>(Select Count(*) From Inserted)
Begin
  RollBack Transaction
  RaisError 20004 'Operação não executada: A informação <Tipo do Vôo de Chegada> que se deseja incluir na tabela <Chegadas> não é uma opção válida'
  Return
End
/* Domínio de: Natureza do Vôo de Chegada */
/* 1 - PAX-Passageiro */
/* 2 - CRG-Carga */
/* 3 - MIS-Misto */
/* 4 - TSL-Translado */
If (Select Count(*) From Inserted
    Where TP_CHG_NAT In (1,2,3,4))
 <>(Select Count(*) From Inserted)
Begin
  RollBack Transaction
  RaisError 20004 'Operação não executada: A informação <Natureza do Vôo de Chegada> que se deseja incluir na tabela <Chegadas> não é uma opção válida'
  Return
End
/* Domínio de: Categoria do Vôo de Chegada */
/* 1 - RGL-Regular */
/* 2 - CHT-Charter */
/* 3 - CSH-Codeshare */
/* 4 - DPL-Duplicate Leg */
/* 5 - TEC-Pouso Técnico */
/* 6 - TSL-Translado */
/* 7 - AVG-Aviação Geral */
/* 8 - MLT-Militar */
/* 9 - NRG-Não Regular */
/* 10 - TXA-Táxi Aéreo */
/* 11 - RGA-Regular Alternado */
If (Select Count(*) From Inserted
    Where TP_CHG_CTG In (1,2,3,4,5,6,7,8,9,10,11,12))
 <>(Select Count(*) From Inserted)
Begin
  RollBack Transaction
  RaisError 20004 'Operação não executada: A informação <Categoria do Vôo de Chegada> que se deseja incluir na tabela <Chegadas> não é uma opção válida'
  Return
End
/* Domínio de: Status de Chegada do Vôo */
/* 1 - Em Aberto */
/* 2 - Concluído */
If (Select Count(*) From Inserted
    Where TP_CHG_STA In (1,2))
 <>(Select Count(*) From Inserted
    Where TP_CHG_STA Is Not Null)
Begin
  RollBack Transaction
  RaisError 20004 'Operação não executada: A informação <Status de Chegada do Vôo> que se deseja incluir na tabela <Chegadas> não é uma opção válida'
  Return
End
/* Regra de negócio */
--CSH OU DPL
IF UPDATE(TP_CHG_CTG) OR UPDATE(CD_CHG_VIN)
	--Um vôo do tipo normal ou charter não pode ter vôo vinculado e um vôo do tipo CSH ou DPL tem de ter vôo vinculado
	IF (	SELECT 	COUNT(*) FROM INSERTED
		WHERE	(TP_CHG_CTG NOT IN (3,4) AND CD_CHG_VIN IS NOT NULL) OR (TP_CHG_CTG IN (3,4) AND CD_CHG_VIN IS NULL)) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: Um vôo do tipo Normal ou Charter não pode ter vôo vinculado, e um vôo do tipo Codeshare ou Duplicate Leg tem de ter vôo vinculado.'
		ROLLBACK TRANSACTION
		RETURN
	END
IF UPDATE(TP_CHG_CTG)
	--Um vôo do tipo CSH ou DPL não pode ter vôo de PAR associado 
	IF (	SELECT 	COUNT(*) FROM	INSERTED INS
		WHERE	TP_CHG_CTG IN (3,4) AND 
			EXISTS (SELECT * FROM T_PAR PAR WHERE PAR.CD_CHG_AEN_ANT = INS.CD_CHG)) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: Um vôo do tipo Codeshare ou Duplicate Leg não pode ter vôo de partida associado.'
		ROLLBACK TRANSACTION
		RETURN
	END
--Não permitir que um vôo de CHG que tenha sido alterado para concluído, sem estar Cancelado e sem ser CSH ou DPL, possua o campo de aeronave nulo
IF (	SELECT 	COUNT(*) FROM 	INSERTED INS, T_SIT SIT
	WHERE	SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CON_VOO = 1 AND INS.FL_CHG_CAN = 0 AND INS.TP_CHG_CTG NOT IN (3, 4) AND INS.CD_AEN_CHG IS NULL) > 0
BEGIN
	RAISERROR 20999 'Operação não executada: <Hora de Entrada de Estacionamento> ou <Aeronave> não informados.'
	ROLLBACK TRANSACTION
	RETURN
END
IF UPDATE(CD_SIT)
BEGIN
	--Verificar se a situação informada é uma situação de CHG
	IF (SELECT COUNT(*) FROM	INSERTED INS, T_SIT SIT WHERE SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CHG <> 1) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: A situação informada não é uma situação de chegada.'
		ROLLBACK TRANSACTION
		RETURN
	END
END
--Atualizar o complemento de chegada
IF UPDATE(CD_SIT) OR UPDATE(DH_CHG_EFE)
BEGIN
	--Hora
	UPDATE	T_CHG SET NM_CHG_COM_SIT = CONVERT(CHAR(5), CHG.DH_CHG_EFE, 8)
	FROM	T_CHG CHG, INSERTED INS, T_SIT SIT
	WHERE	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = CHG.CD_SIT AND SIT.TP_SIT_COM = 1
	--Nenhum
	UPDATE	T_CHG SET NM_CHG_COM_SIT = NULL
	FROM	T_CHG CHG, INSERTED INS, T_SIT SIT
	WHERE	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = CHG.CD_SIT AND SIT.TP_SIT_COM = 3
	--Caso a Data e Hora da Situação não já tenha sido alerada
	IF NOT UPDATE(DH_CHG_SIT)
	BEGIN
		--Atualizar hora da alteração da situação do vôo de CHG
		UPDATE	T_CHG SET DH_CHG_SIT = GETDATE()
		FROM	T_CHG CHG, INSERTED INS
		WHERE	CHG.CD_CHG = INS.CD_CHG
	END
END
IF UPDATE(CD_SIT)
BEGIN
	--Um vôo de PAR não pode ser cancelado se existir algum registro em T_DEC para este vôo ou para um dos seus vôos vinculados
	IF (	SELECT	COUNT(*) FROM INSERTED INS, T_SIT SIT
		WHERE	SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1 AND
			(EXISTS (SELECT CD_CHG FROM T_DEC WHERE CD_CHG = INS.CD_CHG) OR
			EXISTS (SELECT DEC.CD_CHG FROM T_DEC DEC, T_CHG CHG WHERE CHG.CD_CHG_VIN = INS.CD_CHG AND DEC.CD_CHG = CHG.CD_CHG))) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: O vôo de Chegada não pode ser cancelado pois existe registro de <Dados Estatísticos de Chegada> para este vôo ou para algum de seus vôos vinculados.'
		ROLLBACK TRANSACTION
		RETURN
	END

	--Atualizar Flag de CHG Cancelada em vôo
	UPDATE 	T_CHG SET FL_CHG_CAN = SIT.FL_SIT_CAN_VOO
	FROM 	T_CHG CHG, INSERTED INS, T_SIT SIT
	WHERE 	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND (SIT.FL_SIT_CAN_VOO = 1 OR SIT.FL_SIT_CON_VOO = 0)
	--Setar CD_CHG_ANT do vôo sucessor para nulo caso a CHG seja cancelada
	IF (	SELECT 	COUNT(*) FROM T_PAR PAR, INSERTED INS, T_SIT SIT
		WHERE 	PAR.CD_CHG_ANT = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1) > 0
	BEGIN
		UPDATE 	T_PAR SET CD_CHG_ANT = NULL
		FROM 	T_PAR PAR, INSERTED INS, T_SIT SIT
		WHERE 	PAR.CD_CHG_ANT = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1
	END
	--Setar CD_CHG_AEN_ANT do vôo da aeronave sucessora para nulo caso a CHG seja cancelada
	IF (	SELECT 	COUNT(*) FROM T_PAR PAR, INSERTED INS, T_SIT SIT
		WHERE 	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1) >0
	BEGIN
		UPDATE 	T_PAR SET CD_CHG_AEN_ANT = NULL
		FROM 	T_PAR PAR, INSERTED INS, T_SIT SIT
		WHERE 	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1
	END
	--Atualizar o Código da Aeronave para Null caso a CHG tenha sido cancelado
	IF (	SELECT COUNT(*) 	FROM T_CHG CHG, INSERTED INS, T_SIT SIT
		WHERE  	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1) > 0
	BEGIN
		UPDATE 	T_CHG SET CD_AEN_CHG = NULL
		FROM 	T_CHG CHG, INSERTED INS, T_SIT SIT
		WHERE  	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1
	END
	--Apagar os HPA's de CHG caso a CHG tenha sido cancelada
	IF (	SELECT	COUNT(*) FROM T_HPA001 HPA, T_SIT SIT, INSERTED INS
		WHERE  	HPA.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1) > 0
	BEGIN
		DELETE 	T_HPA001
		FROM 	T_HPA001 HPA, T_SIT SIT, INSERTED INS
		WHERE  	HPA.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1
	END
	--Excluir vôo da tabela de vôos candidatos a vôos Antecessores se a CHG tiver sido cancelada
	IF (	SELECT 	COUNT(*) FROM T_CHGANT CHGANT, T_SIT SIT, INSERTED INS
		WHERE	CHGANT.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1) > 0
	BEGIN
		DELETE	T_CHGANT
		FROM	T_CHGANT CHGANT, T_SIT SIT, INSERTED INS
		WHERE	CHGANT.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CAN_VOO = 1
	END
	--Incluir vôo na tabela de vôos candidatos a vôos Antecessores se a CHG estiver cancelada e for alterada para uma situação diferente de Etapa Concluída  e Cancelado
	IF (	SELECT 	COUNT(*) FROM T_CHG CHG, T_SIT SIT, INSERTED INS, DELETED DEL
		WHERE	CHG.CD_CHG = INS.CD_CHG AND INS.CD_CHG = DEL.CD_CHG AND
			DEL.FL_CHG_CAN = 1 AND SIT.CD_SIT = INS.CD_SIT AND
			SIT.FL_SIT_CON_VOO = 0 AND SIT.FL_SIT_CAN_VOO = 0) > 0
	BEGIN
		INSERT	T_CHGANT (CD_CHG)
		SELECT	CHG.CD_CHG FROM T_CHG CHG, T_SIT SIT, INSERTED INS, DELETED DEL
		WHERE	CHG.CD_CHG = INS.CD_CHG AND INS.CD_CHG = DEL.CD_CHG AND
			DEL.FL_CHG_CAN = 1 AND SIT.CD_SIT = INS.CD_SIT AND
			SIT.FL_SIT_CON_VOO = 0 AND SIT.FL_SIT_CAN_VOO = 0
	END
	--Deletar da tabela T_REP todos os registros que tiverem os campos companhia e número do vôo iguais aos do registro atualizado e o aeroporto destino igual ao aeroporto usuário, caso a situação	do vôo tenha sido alterada para "Etapa Concluída"
	DELETE	T_REP001 FROM INSERTED INS, T_REP001 REP, T_COM COM, T_SIT SIT
	WHERE	SIT.CD_SIT = INS.CD_SIT AND
		SIT.FL_SIT_CON_VOO = 1 AND	--Etapa Concluída
		COM.CD_COM = INS.CD_COM AND
		RTRIM(REP.SG_COM_IAT_003) = RTRIM(COM.SG_COM_IAT_003) AND
		RTRIM(REP.NR_VOO) = RTRIM(INS.NR_CHG_VOO) AND
		REP.SG_AER_ICA_DES = (SELECT SG_AER_ICA FROM T_AER WHERE CD_AER = (SELECT CD_AER FROM T_PSI))
	--Setar flag de vôo não concluído ou concluído
	UPDATE 	T_CHG SET TP_CHG_STA = SIT.FL_SIT_CON_VOO + 1   --2=Concluída
	FROM 	T_CHG CHG, T_SIT SIT, INSERTED INS
	WHERE 	CHG.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT
	--Atualizar Flag de entrada concluída em T_HPA
	/*UPDATE 	T_HPA001 SET FL_HPA_ENT = SIT.FL_SIT_CON_VOO*/
 	UPDATE 	T_HPA001 SET FL_HPA_ENT = 1
	FROM 	T_HPA001 HPA, T_SIT SIT, INSERTED INS
	WHERE  	HPA.CD_CHG = INS.CD_CHG AND SIT.CD_SIT = INS.CD_SIT 
	

	--Cancelar o Status caso a CHG esteja concluída e a situação seja alterada para outra qualquer
/*	IF (	SELECT COUNT(*) 	FROM T_STA STA, INSERTED INS, DELETED DEL, T_SIT SITDEL, T_SIT SITINS, T_HPA001 HPA
		WHERE 	STA.CD_STA = HPA.CD_STA AND HPA.CD_CHG = INS.CD_CHG AND
			DEL.CD_CHG = INS.CD_CHG AND SITDEL.CD_SIT = DEL.CD_SIT AND
			SITDEL.FL_SIT_CON_VOO = 1 AND SITINS.CD_SIT = INS.CD_SIT AND
			SITINS.FL_SIT_CON_VOO = 0) > 0
	BEGIN
		UPDATE 	STA
		SET 	TP_STA = 3,  --Cancelado
			DH_STA_FEC = NULL, 
			CD_STA_ANT = NULL
			
		FROM 	T_STA STA, INSERTED INS, DELETED DEL, T_SIT SITDEL, T_SIT SITINS, T_HPA001 HPA
		WHERE  STA.CD_STA = HPA.CD_STA AND  HPA.CD_CHG = INS.CD_CHG AND
			DEL.CD_CHG = INS.CD_CHG AND SITDEL.CD_SIT = DEL.CD_SIT AND
			SITDEL.FL_SIT_CON_VOO = 1 AND SITINS.CD_SIT = INS.CD_SIT AND
			SITINS.FL_SIT_CON_VOO = 0
	END
 */   
            --Alterar CD_STA de HPA para NULL caso a CHG esteja concluída e a situação seja alterada para outra qualquer
              /*IF (	SELECT COUNT(*) 	FROM T_HPA001 HPA, INSERTED INS, DELETED DEL, T_SIT SITDEL, T_SIT SITINS
		WHERE 	HPA.CD_CHG = INS.CD_CHG AND DEL.CD_CHG = INS.CD_CHG AND
			SITDEL.CD_SIT = DEL.CD_SIT AND SITDEL.FL_SIT_CON_VOO = 1 AND
			SITINS.CD_SIT = INS.CD_SIT AND SITINS.FL_SIT_CON_VOO = 0) > 0
	BEGIN
		UPDATE 	HPA SET CD_STA = NULL
		FROM 	T_HPA001 HPA, INSERTED INS, DELETED DEL, T_SIT SITDEL, T_SIT SITINS
		WHERE 	HPA.CD_CHG = INS.CD_CHG AND DEL.CD_CHG = INS.CD_CHG AND
			SITDEL.CD_SIT = DEL.CD_SIT AND SITDEL.FL_SIT_CON_VOO = 1 AND
			SITINS.CD_SIT = INS.CD_SIT AND SITINS.FL_SIT_CON_VOO = 0
	END*/
	
END
IF UPDATE(NR_CHG_VOO)
BEGIN
	--Atualizar o prefixo da aeronave dos vôos do grupo 2 caso o número do vôo tenha sido alterado
	UPDATE	CHG
	SET	CD_AEN_CHG = (	SELECT 	CD_AEN 
					FROM 	T_AEN AEN WHERE RTRIM(AEN.NR_AEN) = RTRIM(INS.NR_CHG_VOO))
	FROM	T_CHG CHG, INSERTED INS
	WHERE	CHG.CD_CHG = INS.CD_CHG AND INS.TP_CHG_GRU = 2
	--Atualizar o número do vôo de PAR associado caso este voo seja do Grupo 2
	IF (	SELECT COUNT(*) 	FROM T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
			INS.TP_CHG_GRU = 2 AND PAR.TP_PAR_GRU = 2) > 0
	BEGIN
		UPDATE	PAR SET NR_PAR_VOO = INS.NR_CHG_VOO
		FROM	T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
			INS.TP_CHG_GRU = 2 AND PAR.TP_PAR_GRU = 2
	END
	--Atualizar em HPA o prefixo da aeronave dos vôos do grupo 2 caso o número do vôo tenha sido alterado
	IF (	SELECT 	COUNT(*) FROM T_HPA001 HPA, INSERTED INS
		WHERE	HPA.CD_CHG = INS.CD_CHG AND INS.TP_CHG_GRU = 2) > 0
	BEGIN
		UPDATE	T_HPA001
		SET	CD_AEN = (	SELECT 	CD_AEN 
					FROM 	T_AEN AEN WHERE RTRIM(AEN.NR_AEN) = RTRIM(INS.NR_CHG_VOO))
		FROM	T_HPA001 HPA, INSERTED INS
		WHERE	HPA.CD_CHG = INS.CD_CHG AND INS.TP_CHG_GRU = 2 
	END
END
IF UPDATE(TP_CHG_CTG)
BEGIN
	--Apagar os hpa dos vôos de CHG que passaram a ser CSH ou DPL
	DELETE	T_HPA001 FROM T_HPA001 HPA, INSERTED INS
	WHERE	HPA.CD_CHG = INS.CD_CHG AND INS.TP_CHG_CTG IN (3,4)
	--Anular o tipo de equipamento, o box e a aeronave dos vôos que passaram a ser CSH ou DPL
	UPDATE	T_CHG
	SET	CD_EQP_CHG = NULL, CD_AEN_CHG = NULL, CD_BOX = NULL
	FROM	T_CHG CHG, INSERTED INS
	WHERE	CHG.CD_CHG = INS.CD_CHG AND INS.TP_CHG_CTG IN (3,4)
	--Incluir vôo na tabela de vôos candidatos a vôos Antecessores se TP_CHG_CTG mudar de 3 ou 4 para uma categoria que seja diferente de 3 ou 4
	INSERT	T_CHGANT(CD_CHG)
	SELECT	INS.CD_CHG FROM INSERTED INS, DELETED DEL
	WHERE	INS.CD_CHG = DEL.CD_CHG AND DEL.TP_CHG_CTG IN (3,4) AND INS.TP_CHG_CTG NOT IN (3,4)
	--Excluir vôo da tabela de vôos candidatos a vôos Antecessores se TP_CHG_CTG mudar para 3 ou 4
	DELETE	T_CHGANT FROM T_CHGANT CHGANT, INSERTED INS
	WHERE	CHGANT.CD_CHG = INS.CD_CHG AND INS.TP_CHG_CTG IN (3,4)
END
IF UPDATE(DH_CHG_EFE)
BEGIN
	--Atualizar a hora do vôo de PAR caso a diferença entre a hora da PAR e a hora da CHG seja menor que o tempo mínimo de permanência do vôo.
	IF (	SELECT COUNT(*) 	FROM T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND 
			(DATEDIFF(MI, INS.DH_CHG_EFE, PAR.DH_PAR_EFE) < INS.QT_CHG_PER_MIN OR PAR.DH_PAR_EFE > PAR.DH_PAR_NRM)) >0
	BEGIN
		UPDATE 	T_PAR
		SET 	DH_PAR_SIT = GETDATE(),
			DH_PAR_EFE  =  DATEADD( MI, INS.QT_CHG_PER_MIN, INS.DH_CHG_EFE),
			DH_PAR_EST  =  DATEADD( MI, INS.QT_CHG_PER_MIN, INS.DH_CHG_EFE)
		FROM 	T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND (DATEDIFF(MI, INS.DH_CHG_EFE, PAR.DH_PAR_EFE) < INS.QT_CHG_PER_MIN OR PAR.DH_PAR_EFE > PAR.DH_PAR_NRM)
	END
	--Atualizar a hora prevista e de estacionamento dos vôos que ficaram com estas horas menores que a hora normal
	IF (	SELECT	COUNT(*) FROM T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND PAR.DH_PAR_EFE < PAR.DH_PAR_NRM) > 0
	BEGIN
		UPDATE 	T_PAR
		SET	DH_PAR_EFE = PAR.DH_PAR_NRM, DH_PAR_EST = PAR.DH_PAR_NRM
		FROM 	T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND PAR.DH_PAR_EFE < PAR.DH_PAR_NRM
	END
	--Atualizar os campos DH_STA_ABE e MA_STA_ABE do Status de Aeronave associado ao primeiro HPA do vôo alterado, se houver alteração na Data/Hora Efetiva do Vôo de CHG, e o Status associado ao primeiro HPA desse vôo, estiver aberto
	/*UPDATE	STA
	SET	DH_STA_ABE = INS.DH_CHG_EFE,
		MA_STA_ABE = DATEADD(DD, 1- DATEPART(DD, Dateadd(HH, -Datepart(HH, INS.DH_CHG_EFE), Dateadd(mi, -datepart(mi, INS.DH_CHG_EFE), INS.DH_CHG_EFE))), Dateadd(HH, -Datepart(HH, INS.DH_CHG_EFE), Dateadd(mi, -datepart(mi, INS.DH_CHG_EFE), INS.DH_CHG_EFE))) --Primeiro dia do mês da Data da CHG
	FROM	T_STA STA, T_CHG CHG, INSERTED INS, T_HPA001 HPA
	WHERE	CHG.CD_CHG = INS.CD_CHG AND HPA.CD_CHG = INS.CD_CHG AND
		HPA.NR_HPA_SEQ = 1  AND 	STA.CD_STA = HPA.CD_STA  AND STA.TP_STA = 1 */
END
--Se o vôo possuir CHG e atualizarmos a aeronave de CHG do vôo, temos que atualizá-la também em HPA
IF UPDATE(CD_AEN_CHG)
BEGIN
	IF (	SELECT 	COUNT(*) FROM INSERTED INS, T_CHG CHG
		WHERE	CHG.CD_CHG = INS.CD_CHG AND CHG.FL_CHG_CAN = 1 AND INS.CD_AEN_CHG IS NOT NULL) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: Não é permitido definir aeronave para vôos cancelados.'
		ROLLBACK TRANSACTION
		RETURN
	END
	--Não permitir que o prefixo da aeronave seja nulo para vôos do grupo 2
	IF (	SELECT 	COUNT(*) FROM INSERTED INS
		WHERE	INS.TP_CHG_GRU = 2 AND INS.CD_AEN_CHG IS NULL) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: O <Prefixo da Aeronave> para vôos da Aviação Geral não deve ser nulo, e sim igual ao <Número do Vôo>.'
		ROLLBACK TRANSACTION
		RETURN
	END
	
	--Atualizar o número do vôo de CHG para vôos do grupo 2 caso o prefixo da aeronave tenha sido alterado
	UPDATE	CHG
	SET	NR_CHG_VOO = (SELECT NR_AEN FROM T_AEN AEN WHERE AEN.CD_AEN = INS.CD_AEN_CHG)
	FROM	T_CHG CHG, INSERTED INS
	WHERE	CHG.CD_CHG = INS.CD_CHG AND INS.TP_CHG_GRU = 2

	--Atualizar o número do vôo de PAR para vôos do grupo 2 caso o prefixo da aeronave tenha sido alterado
	IF (	SELECT	COUNT(*) FROM T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
			INS.TP_CHG_GRU = 2 AND PAR.TP_PAR_GRU = 2) >0
	BEGIN
		UPDATE	PAR
		SET	NR_PAR_VOO = (SELECT NR_AEN FROM T_AEN AEN WHERE AEN.CD_AEN = INS.CD_AEN_CHG)
		FROM	T_PAR PAR, INSERTED INS
		WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
			INS.TP_CHG_GRU = 2 AND 	PAR.TP_PAR_GRU = 2
	END
	--Atualizar aeronave em HPA
	UPDATE 	T_HPA001 SET CD_AEN = INS.CD_AEN_CHG
	FROM 	T_HPA001 HPA, T_CHG CHG, INSERTED INS
	WHERE  	HPA.CD_CHG = INS.CD_CHG AND CHG.CD_CHG = INS.CD_CHG
END
--Se atualizarmos a aeronave de CHG do vôo para outra que não seja Null e a situação do vôo for etapa concluída, temos que atualizar as informações referentes à aeronave em STA
/*IF UPDATE(CD_AEN_CHG) 
BEGIN
	UPDATE 	T_STA SET FL_STA_AEN_ISE = AEN.FL_AEN_ISE
	FROM 	T_STA STA, T_CHG CHG, T_HPA001 HPA, T_AEN AEN, T_SIT SIT, INSERTED INS
	WHERE  STA.CD_STA = HPA.CD_STA AND HPA.CD_CHG = INS.CD_CHG AND
		CHG.CD_CHG = INS.CD_CHG AND AEN.CD_AEN = INS.CD_AEN_CHG AND
		INS.CD_AEN_CHG is not Null AND SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CON_VOO = 1
END 
--Se atualizarmos a companhia aérea do vôo de CHG e a situação do vôo for etapa concluída, temos que atualizar as informações referentes à companhia aérea em STA
IF UPDATE(CD_COM) 
BEGIN
	UPDATE 	T_STA SET FL_STA_COM_TAR_RED = COM.FL_COM_TAR_RED
	FROM 	T_STA STA, T_CHG CHG, T_HPA001 HPA, T_COM COM, T_SIT SIT, INSERTED INS
	WHERE  STA.CD_STA = HPA.CD_STA AND HPA.CD_CHG = INS.CD_CHG AND
		CHG.CD_CHG = INS.CD_CHG AND COM.CD_COM = INS.CD_COM AND
		SIT.CD_SIT = INS.CD_SIT AND SIT.FL_SIT_CON_VOO = 1 
END CELIUS TESTE */
IF UPDATE(DH_CHG_EST)
BEGIN
	--Não permitir alteração na Data ou Hora de Estacionamento de um Vôo de CHG, se o Status de Aeronave associado ao primeiro HPA desse vôo, estiver Fechado
	/*IF (	SELECT	COUNT(*)
		FROM 	T_CHG CHG, INSERTED INS, T_HPA001 HPA, T_STA STA
		WHERE	CHG.CD_CHG = INS.CD_CHG AND HPA.CD_CHG = INS.CD_CHG AND
			HPA.NR_HPA_SEQ = 1 AND STA.CD_STA = HPA.CD_STA AND STA.TP_STA = 2) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: A <Data ou Hora de Estacionamento> do vôo de Chegada não pode ser alterada, se o Status de Aeronave associado ao primeiro HPA desse vôo, estiver Fechado.'
		ROLLBACK TRANSACTION
		RETURN
	END CELIUS TESTE 17/09 */
	--Atualizamos Hora de Entrada em HPA como Hora de Estacionamento de CHG, no registro que possue o Vôo sendo atualizado como Vôo de CHG
	UPDATE 	T_HPA001 SET DH_HPA_ENT = CHG.DH_CHG_EST
	FROM	T_HPA001 HPA, T_CHG CHG, INSERTED INS
	WHERE 	CHG.CD_CHG = INS.CD_CHG AND HPA.CD_CHG = INS.CD_CHG AND HPA.NR_HPA_SEQ = 1
END
--CONSISTÊNCIAS A SEREM FEITAS APÓS AS ATUALIZAÇÕES
--Verificar se há horas de CHG maiores que as horas de PAR
IF   (	SELECT COUNT(*) FROM T_CHG CHG, T_PAR PAR, INSERTED INS
	WHERE 	CHG.CD_CHG = INS.CD_CHG AND PAR.CD_CHG_AEN_ANT = CHG.CD_CHG AND
		( (CHG.DH_CHG_EFE >= PAR.DH_PAR_EFE) OR (CHG.DH_CHG_EST >= PAR.DH_PAR_EST))) > 0
BEGIN
	RAISERROR 20999 'Operação não executada: A hora de chegada não pode ser maior nem igual à hora de partida.'
	ROLLBACK TRANSACTION
	RETURN
END
--Alexei 18/06/01
IF UPDATE(FL_CHG_TEL)
BEGIN
	--Se desmarcar da tela desmarcar do anunciador automático
	Update	T_CHG
	set	FL_CHG_ANU = 0
	FROM	T_CHG CHG
	JOIN	INSERTED INS ON INS.CD_CHG = CHG.CD_CHG
	WHERE	INS.FL_CHG_TEL = 0
END

--Verificar se são satisfeitas as condições para a nova situação de CHG
--Alexei 18/06/01
IF UPDATE(CD_SIT) OR UPDATE(DH_CHG_EFE)
BEGIN
	--Lançar Histórico de Situação de Vôo
	INSERT T_HSC (DH_HSC, CD_CHG, CD_IFT, CD_SIT, DH_HSC_CHG, CD_USR) SELECT GETDATE(), INS.CD_CHG, INS.CD_IFT, INS.CD_SIT, INS.DH_CHG_EFE, INS.CD_USR FROM INSERTED INS

	--Deleta todos os registros da programação não anunciados e que estejam vinculados a este vôo
	DELETE T_PRALOG FROM T_PRALOG JOIN INSERTED INS ON INS.CD_CHG = T_PRALOG.CD_CHG WHERE T_PRALOG.FL_LOG = 0

	--Inserir programação de Log
	--Antes da Hora Prevista
	INSERT INTO T_PRALOG (CD_PRA, CD_CHG, CD_PAR, DH_LOG, FL_LOG)
	SELECT 	CD_PRA, INS.CD_CHG, NULL, DATEADD(MI, -PRA.QT_PRA_TMP, INS.DH_CHG_EFE), 0
	FROM	T_PRA PRA JOIN INSERTED INS ON INS.CD_SIT = PRA.CD_SIT AND INS.FL_CHG_TEL = 1 AND INS.FL_CHG_ANU = 1
	JOIN	T_TPA TPA ON TPA.CD_TPA = PRA.CD_TPA AND TPA.TP_TPA = 1 JOIN T_SIT SIT ON SIT.CD_SIT = INS.CD_SIT AND FL_SIT_CON_VOO = 0
	WHERE	PRA.TP_PRA = 1 AND NOT EXISTS (SELECT * FROM T_PRALOG WHERE CD_PRA = PRA.CD_PRA AND CD_CHG = INS.CD_CHG) 

	 --Após a Alteração da Situação
	INSERT INTO T_PRALOG (CD_PRA, CD_CHG, CD_PAR, DH_LOG, FL_LOG)
	SELECT 	CD_PRA, INS.CD_CHG, NULL, DATEADD(MI, PRA.QT_PRA_TMP, GETDATE()), 0
	FROM	T_PRA PRA JOIN INSERTED INS ON INS.CD_SIT = PRA.CD_SIT AND INS.FL_CHG_TEL = 1 AND INS.FL_CHG_ANU = 1
	JOIN	T_TPA TPA ON TPA.CD_TPA = PRA.CD_TPA AND TPA.TP_TPA = 1 JOIN T_SIT SIT ON SIT.CD_SIT = INS.CD_SIT AND FL_SIT_CON_VOO = 0
	WHERE	PRA.TP_PRA = 2 AND NOT EXISTS (SELECT * FROM T_PRALOG WHERE CD_PRA = PRA.CD_PRA AND CD_CHG = INS.CD_CHG)
END
IF UPDATE(CD_SIT)
BEGIN

	/*CELIUS - 16/10/2002 *---------------------------------------------------------------------------------------------------*/
	--Não permitir que o prefixo da aeronave seja nulo para situação de Aeronave no Pátio
	IF (	SELECT 	COUNT(*) FROM INSERTED INS
		WHERE	INS.CD_SIT = 5 AND INS.CD_AEN_CHG IS NULL) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: O <Prefixo da Aeronave> para a situação de Aeronave no Pátio não deve ser nulo.'
		ROLLBACK TRANSACTION
		RETURN
	END

	/*--------------------------------------------------------------------------------------------------------------------------------------*/
	IF (	SELECT	COUNT(*) FROM INSERTED INS, T_PAR AEN, T_SIT SITAEN
		WHERE	AEN.CD_CHG_AEN_ANT = INS.CD_CHG AND 
			SITAEN.CD_SIT = AEN.CD_SIT AND SITAEN.FL_SIT_TOD = 1 AND 
			EXISTS (SELECT * FROM T_SCA SCA WHERE SCA.CD_SIT = AEN.CD_SIT) AND 
			INS.CD_SIT NOT IN (SELECT CD_SIT_ANT FROM T_SCA SCA WHERE SCA.CD_SIT = AEN.CD_SIT)) > 0
	BEGIN
		RAISERROR 20999 'Operação não executada: A nova situação do vôo de chegada é incompatível com as situações dos vôos sucessores.'
		ROLLBACK TRANSACTION
		RETURN
	END


/* ************************************************************************************************************************************************************************************* */

/*               INCLUSÃO DE STATUS NA SITUAÇÃO DE POUSO -	GRUPO 1         CELIUS 17/10/02       */


IF 	(SELECT COUNT(*) FROM  INSERTED INS/*Apenas para vôos do grupo 1*/
	WHERE INS.TP_CHG_GRU=1 and  INS.CD_SIT=39) > 0
BEGIN


IF	(SELECT COUNT(*) FROM T_STA STA, INSERTED INS/* Verifica se já existe o Status correspondente a esse Vôo de Chegada*/ 
	WHERE STA.CD_COM = INS.CD_COM AND STA.NR_CHG_VOO = INS.NR_CHG_VOO AND STA.DH_VOO_HT_CHG = Dateadd(HH, -Datepart(HH, INS.DH_CHG_NRM), Dateadd(mi, -datepart(mi, INS.DH_CHG_NRM), Dateadd(SS, -datepart(SS, INS.DH_CHG_NRM),Dateadd(MS, -datepart(MS,  INS.DH_CHG_NRM), INS.DH_CHG_NRM)))) 
	) = 0
BEGIN


IF	(SELECT COUNT(*) FROM T_STA STA, INSERTED INS, T_MOV MOV
	WHERE STA.CD_AEN = INS.CD_AEN_CHG AND STA.TP_STA=1 AND STA.CD_STA=MOV.CD_STA AND MOV.TIPO_MOV='PO')=0
BEGIN


IF 	(SELECT COUNT(*) FROM INSERTED INS /* Criar Status apenas se  for na Situação de Pouso */
	WHERE INS.CD_SIT =39) >0
BEGIN
         DECLARE  @DATA_FECHC DATETIME
         SELECT  @DATA_FECHC =  DATEADD(MM, 1,GETDATE())

IF (SELECT COUNT(*) FROM T_NRO NRO  WHERE NRO.MES = MONTH(GETDATE()))=1
BEGIN
     UPDATE T_NRO SET NRO_MES = NRO_MES +1
     FROM T_NRO
     WHERE CD_NRO=1
END
ELSE
BEGIN
     UPDATE T_NRO SET NRO_MES_2= NRO_MES_2,  NRO_MES_1 = NRO_MES, NRO_MES =1, MES=MONTH(GETDATE())
     FROM T_NRO
     WHERE CD_NRO=1
END


/*Declaração do Cursor*- ANGELA MODIFICADO EM 26/10/2003 PARA PERMITIR + DE 1 VINCULADO*/
DECLARE INSCHGVIN CURSOR FOR
		SELECT 	CHG5.CD_CHG,
			CHG5.NR_CHG_HOT
	
		FROM	
		T_CHG CHG5, INSERTED INS5
		WHERE	 CHG5.CD_CHG_VIN = INS5.CD_CHG AND
                        CHG5.TP_CHG_CTG = 3

/*Declaração das variáveis*/
		DECLARE	@CD_CHG5 		INT,
			@NR_CHG_HOT5            CHAR(8),
                        @NR_VIN1                CHAR(8),
                        @NR_VIN2                CHAR(8)
/*Abre o cursor*/ 
		OPEN INSCHGVIN

/*Posiciona no primeiro registro*/
		FETCH	INSCHGVIN 
		INTO 	@CD_CHG5, 	
			@NR_CHG_HOT5 	

/*Processar todos os registros de INSCHG*/
		IF @@FETCH_STATUS = 0
		BEGIN
	
		SELECT 	@NR_VIN1 = @NR_CHG_HOT5 
/* Ir para o próximo registro */
		FETCH NEXT FROM INSCHGVIN
		INTO 	@CD_CHG5, 	
		@NR_CHG_HOT5 
	             IF @@FETCH_STATUS = 0
		      BEGIN
	                       SELECT 	@NR_VIN2 = @NR_CHG_HOT5 
                                 END
 
                END




/*Declaração do Cursor*/
DECLARE INSCHGA CURSOR FOR
		SELECT 	CHG.CD_AER,
				CHG.CD_EQP_CHG,
				CHG.CD_AEN_CHG,
				CHG.CD_BOX,
				CHG.CD_CHG,
				CHG.DH_CHG_EFE,
				CHG.DH_CHG_NRM,
				CHG.CD_COM,
				CHG.TP_CHG_GRU,
				CHG.CD_USR,
				CHG.TP_CHG,
				CHG.NR_CHG_VOO,
				CHG.TP_CHG_NAT,
				CHG.TP_CHG_CTG,
                                                     AER.SG_AER_ICA
				
		FROM	
				T_CHG CHG, T_ECC001 ECC, T_AER AER,
				INSERTED INS
		WHERE	CHG.CD_CHG = INS.CD_CHG AND
                                                      ECC.CD_CHG = INS.CD_CHG AND
                                                      ECC.CD_ECC = (select ISNULL(MAX(cd_ecc), 0)from T_ecc001 where CD_CHG =  INS.CD_CHG)  AND
                                                      AER.CD_AER=ECC.CD_AER AND
				CHG.TP_CHG_CTG NOT IN (3,4) AND
				CHG.CD_SIT = 39 /* Pouso  */
		ORDER BY 	CHG.CD_CHG

/*Declaração das variáveis*/
		DECLARE	@CD_AER2 		INT,
				@CD_EQP_CHG2 	INT,
				@CD_AEN_CHG2	INT,
				@CD_BOX2 		INT,
				@CD_CHG2		INT,
				@DH_CHG_EFE2	SMALLDATETIME,
				@DH_CHG_NRM2	SMALLDATETIME,
				@CD_COM2		INT,
				@TP_GRU2		INT,
				@CD_USR2		INT,
				@TP_CHG2		INT,
				@NR_CHG_VOO2	CHAR(10),
				@TP_CHG_NAT2	INT,
				@TP_CHG_CTG2	INT,
                                                     @CD_AER_ORI              CHAR(4)		
         
/*Abre o cursor*/ 
		OPEN INSCHGA

/*Posiciona no primeiro registro*/
		FETCH	INSCHGA 
		INTO 	@CD_AER2, 	
			@CD_EQP_CHG2, 	
			@CD_AEN_CHG2,	
			@CD_BOX2 ,	
			@CD_CHG2,	
			@DH_CHG_EFE2,
			@DH_CHG_NRM2,
			@CD_COM2,
			@TP_GRU2,
			@CD_USR2,
			@TP_CHG2,
			@NR_CHG_VOO2,
			@TP_CHG_NAT2,
			@TP_CHG_CTG2,	
                                        @CD_AER_ORI

/*Processar todos os registros de INSCHG*/
		WHILE @@FETCH_STATUS = 0
		BEGIN
  			/*destino dos dados*/
		INSERT 	T_STA (
			CD_STA,
			CD_AEN,
			CD_AER,
			NR_STA,
			MA_STA_ABE,
			TP_STA,
			DH_VOO_HT_CHG,
                                        HR_VOO_HT_CHG,
			CD_COM,
			TP_GRU,
			CD_USR,
			TP_CHG,
			DH_STA_ABE,
			DH_STA_FEC,
			NR_CHG_VOO,
			TP_CHG_NAT,
			TP_CHG_CTG,
                                        CD_ICAO_PRO,
                                        VOO_CHG_VIN,
                                        VOO_CHG_VIN2)
			/*Origem dos dados*/			
		SELECT 	ISNULL(MAX(CD_STA), 0) +1,
			@CD_AEN_CHG2,
			@CD_AER2,
			(SELECT NRO_MES FROM T_NRO NRO WHERE CD_NRO=1),
			Dateadd(HH, -Datepart(HH, @DH_CHG_EFE2), Dateadd(mi, -datepart(mi, @DH_CHG_EFE2), Dateadd(SS, -datepart(SS, @DH_CHG_EFE2),Dateadd(MS, -datepart(MS, @DH_CHG_EFE2),@DH_CHG_EFE2)))),
			1,
			Dateadd(HH, -Datepart(HH, @DH_CHG_NRM2), Dateadd(mi, -datepart(mi, @DH_CHG_NRM2), Dateadd(SS, -datepart(SS, @DH_CHG_NRM2),Dateadd(MS, -datepart(MS, @DH_CHG_NRM2),@DH_CHG_NRM2)))),
                                        /*Dateadd(dd, -Datepart(dd, @DH_CHG_NRM2), Dateadd(MM, -datepart(MM, @DH_CHG_NRM2), Dateadd(YY, -datepart(YY, @DH_CHG_NRM2),@DH_CHG_NRM2))),*/
			@DH_CHG_NRM2,
                                        @CD_COM2,
			@TP_GRU2,
			@CD_USR2,
			@TP_CHG2,
			Dateadd(HH, -Datepart(HH, @DH_CHG_EFE2), Dateadd(mi, -datepart(mi, @DH_CHG_EFE2), Dateadd(SS, -datepart(SS, @DH_CHG_EFE2),Dateadd(MS, -datepart(MS, @DH_CHG_EFE2),@DH_CHG_EFE2)))),
			/*Dateadd(HH, -Datepart(HH, GETDATE()), Dateadd(mi, -datepart(mi, GETDATE()), Dateadd(SS, -datepart(SS, GETDATE()),Dateadd(MS, -datepart(MS, GETDATE()),GETDATE())))),*/
			/*@DH_CHG_EFE2 + 30,*/
			Dateadd(HH, -Datepart(HH, @DATA_FECHC), Dateadd(mi, -datepart(mi,@DATA_FECHC), Dateadd(SS, -datepart(SS, @DATA_FECHC),Dateadd(MS, -datepart(MS, @DATA_FECHC),@DATA_FECHC)))),
			@NR_CHG_VOO2,
			@TP_CHG_NAT2,
			@TP_CHG_CTG2,
                                        @CD_AER_ORI,
                                        @NR_VIN1,
                                        @NR_VIN2
		FROM	T_STA STA
		
			/*destino dos dados*/
		INSERT 	T_MOV (
			CD_STA,
			CD_MOV,
			TIPO_MOV,
			DH_MOV,
			HR_MOV)
			/*Origem dos dados*/			
		SELECT 	 ISNULL(MAX(CD_STA), 0) ,
				1,
				'PO',
				Dateadd(HH, -Datepart(HH, @DH_CHG_EFE2), Dateadd(mi, -datepart(mi, @DH_CHG_EFE2), Dateadd(SS, -datepart(SS, @DH_CHG_EFE2),Dateadd(MS, -datepart(MS, @DH_CHG_EFE2),@DH_CHG_EFE2)))),
				@DH_CHG_EFE2
		FROM	T_STA STA

/* Ir para o próximo registro */
						
		FETCH NEXT FROM INSCHGA
		INTO 	
			@CD_AER2, 	
			@CD_EQP_CHG2, 	
			@CD_AEN_CHG2,	
			@CD_BOX2 ,	
			@CD_CHG2,	
			@DH_CHG_EFE2,
			@DH_CHG_NRM2,
			@CD_COM2,
			@TP_GRU2,
			@CD_USR2,
			@TP_CHG2,	
			@NR_CHG_VOO2,
			@TP_CHG_NAT2,
			@TP_CHG_CTG2,
                                         @CD_AER_ORI	
                END
		CLOSE INSCHGA
		DEALLOCATE INSCHGA
                         CLOSE INSCHGVIN
		DEALLOCATE INSCHGVIN
END

end
ELSE
BEGIN
RAISERROR 21999 'Operação não executada: Essa Aeronave já se encontra pousada.'
		ROLLBACK TRANSACTION
		RETURN
END 
End
END
/* ************************************************************************************************************************************************************************************* */
/* ************************************************************************************************************************************************************************************* */

/*               INCLUSÃO DE STATUS NA SITUAÇÃO DE POUSO -	GRUPO 2         CELIUS 17/10/02       */

BEGIN
                            DECLARE  @DATA_FECH DATETIME
                            SELECT  @DATA_FECH =  DATEADD(MM, 1,GETDATE())

IF 	(SELECT COUNT(*) FROM  INSERTED INS/*Apenas para vôos do grupo 2*/
	WHERE INS.TP_CHG_GRU=2  and  INS.CD_SIT=39 ) > 0
BEGIN

IF	(SELECT COUNT(*) FROM T_STA STA, INSERTED INS/* Verifica se já existe o Status correspondente a esse Vôo de Chegada*/ 
	WHERE STA.TP_STA=1 AND STA.CD_AEN= INS.CD_AEN_CHG) = 0 
BEGIN

IF 	(SELECT COUNT(*) FROM INSERTED INS /* Criar Status apenas se  for na Situação de Pouso */
	WHERE INS.CD_SIT =39) >0
BEGIN

IF (SELECT COUNT(*) FROM T_NRO NRO  WHERE NRO.MES = MONTH(GETDATE()))=1
BEGIN
     UPDATE T_NRO SET NRO_MES = NRO_MES +1
     FROM T_NRO
     WHERE CD_NRO=1
END
ELSE
BEGIN
     UPDATE T_NRO SET NRO_MES_2= NRO_MES_2,  NRO_MES_1 = NRO_MES, NRO_MES =1, MES=MONTH(GETDATE())
     FROM T_NRO
     WHERE CD_NRO=1
END

/*Declaração do Cursor*/
DECLARE INSCHGA CURSOR FOR
		SELECT 	CHG.CD_AER,
				CHG.CD_EQP_CHG,
				CHG.CD_AEN_CHG,
				CHG.CD_BOX,
				CHG.CD_CHG,
				CHG.DH_CHG_EFE,
				CHG.DH_CHG_NRM,
				CHG.CD_COM,
				CHG.TP_CHG_GRU,
				CHG.CD_USR,
				CHG.TP_CHG,
				CHG.TP_CHG_NAT,
				CHG.TP_CHG_CTG,
				AER.SG_AER_ICA

		FROM	
				T_CHG CHG, T_ECC001 ECC, T_AER AER,
				INSERTED INS
		WHERE	CHG.CD_CHG = INS.CD_CHG AND
	                                        ECC.CD_CHG = INS.CD_CHG AND
                                                      ECC.CD_ECC = (select ISNULL(MAX(cd_ecc), 0)from T_ecc001 where CD_CHG =  INS.CD_CHG) AND
                                                      AER.CD_AER=ECC.CD_AER AND
		              	CHG.TP_CHG_CTG NOT IN (3,4) AND
				CHG.CD_SIT = 39 /* Pouso  */
		ORDER BY 	CHG.CD_CHG

/*Declaração das variáveis*/
		DECLARE	@CD_AER3 		INT,
				@CD_EQP_CHG3 	INT,
				@CD_AEN_CHG3	INT,
				@CD_BOX3		INT,
				@CD_CHG3		INT,
				@DH_CHG_EFE3	DATETIME,
				@DH_CHG_NRM3	DATETIME,
				@CD_COM3		INT,
				@TP_GRU3		INT,
				@CD_USR3		INT,
				@TP_CHG3		INT,
				@TP_CHG_NAT3	INT,
				@TP_CHG_CTG3	INT,
				@CD_AER_ORI3           CHAR(4)

/*Abre o cursor*/ 
		OPEN INSCHGA

/*Posiciona no primeiro registro*/
		FETCH	INSCHGA 
		INTO 	@CD_AER3, 	
			@CD_EQP_CHG3, 	
			@CD_AEN_CHG3,	
			@CD_BOX3 ,	
			@CD_CHG3,	
			@DH_CHG_EFE3,
			@DH_CHG_NRM3,
			@CD_COM3,
			@TP_GRU3,
			@CD_USR3,
			@TP_CHG3,
			@TP_CHG_NAT3,
			@TP_CHG_CTG3,
                                        @CD_AER_ORI3

/*Processar todos os registros de INSCHG*/
		WHILE @@FETCH_STATUS = 0
		BEGIN
			/*destino dos dados*/
		INSERT 	T_STA (
			CD_STA,
			CD_AEN,
			CD_AER,
			NR_STA,
			MA_STA_ABE,
			TP_STA,
			DH_VOO_HT_CHG,
                                        HR_VOO_HT_CHG,
			CD_COM,
			TP_GRU,
			CD_USR,
			TP_CHG,
			DH_STA_ABE,
			DH_STA_FEC,
			TP_CHG_NAT,
			TP_CHG_CTG,
                                        CD_ICAO_PRO)
			/*Origem dos dados*/			
		SELECT 	ISNULL(MAX(CD_STA), 0) +1,
			@CD_AEN_CHG3,
			@CD_AER3,
			(SELECT NRO_MES FROM T_NRO NRO WHERE CD_NRO=1),
			Dateadd(HH, -Datepart(HH, @DH_CHG_EFE3), Dateadd(mi, -datepart(mi, @DH_CHG_EFE3), Dateadd(SS, -datepart(SS, @DH_CHG_EFE3),Dateadd(MS, -datepart(MS, @DH_CHG_EFE3),@DH_CHG_EFE3)))),
			1,
			Dateadd(HH, -Datepart(HH, @DH_CHG_NRM3), Dateadd(mi, -datepart(mi, @DH_CHG_NRM3), Dateadd(SS, -datepart(SS, @DH_CHG_NRM3),Dateadd(MS, -datepart(MS, @DH_CHG_NRM3),@DH_CHG_NRM3)))),
                                        @DH_CHG_NRM3, 
			@CD_COM3,
			@TP_GRU3,
			@CD_USR3,
			@TP_CHG3,
			Dateadd(HH, -Datepart(HH, GETDATE()), Dateadd(mi, -datepart(mi, GETDATE()), Dateadd(SS, -datepart(SS, GETDATE()),Dateadd(MS, -datepart(MS, GETDATE()),GETDATE())))),
			/*@DH_CHG_EFE2 + 30,*/
			Dateadd(HH, -Datepart(HH, @DATA_FECH), Dateadd(mi, -datepart(mi, @DATA_FECH), Dateadd(SS, -datepart(SS, @DATA_FECH),Dateadd(MS, -datepart(MS, @DATA_FECH),@DATA_FECH)))),
			@TP_CHG_NAT3,
			@TP_CHG_CTG3,
                                        @CD_AER_ORI3

		FROM	T_STA STA
		
			/*destino dos dados*/
		INSERT 	T_MOV (
			CD_STA,
			CD_MOV,
			TIPO_MOV,
			DH_MOV,
			HR_MOV)
			/*Origem dos dados*/			
		SELECT 	 ISNULL(MAX(CD_STA), 0) ,
				1,
				'PO',
				Dateadd(HH, -Datepart(HH, GETDATE()), Dateadd(mi, -datepart(mi, GETDATE()), Dateadd(SS, -datepart(SS, GETDATE()),Dateadd(MS, -datepart(MS, GETDATE()),GETDATE())))),
				GETDATE()

		FROM	T_STA STA

/* Ir para o próximo registro */
						
		FETCH NEXT FROM INSCHGA
		INTO 	
			@CD_AER3, 	
			@CD_EQP_CHG3, 	
			@CD_AEN_CHG3,	
			@CD_BOX3 ,	
			@CD_CHG3,	
			@DH_CHG_EFE3,
			@DH_CHG_NRM3,
			@CD_COM3,
			@TP_GRU3,
			@CD_USR3,
			@TP_CHG3,	
			@TP_CHG_NAT3,
			@TP_CHG_CTG3,
                                        @CD_AER_ORI3
		END
		CLOSE INSCHGA
		DEALLOCATE INSCHGA

END
END
ELSE
BEGIN
RAISERROR 23999 'Operação não executada: Essa Aeronave já se encontra pousada.'
		ROLLBACK TRANSACTION
		RETURN
END 

END

END

/* ************************************************************************************************************************************************************************************* */




	--Antes da Hora Prevista
	INSERT INTO T_PRALOG (CD_PRA, CD_CHG, CD_PAR, DH_LOG, FL_LOG)
	SELECT 	CD_PRA, NULL, NULL, DATEADD(MI, -PRA.QT_PRA_TMP, INS.DH_CHG_EFE), 0
	FROM	T_PRA PRA JOIN INSERTED INS ON INS.CD_SIT = PRA.CD_SIT AND INS.FL_CHG_TEL = 1 AND INS.FL_CHG_ANU = 1
	JOIN	T_TPA TPA ON TPA.CD_TPA = PRA.CD_TPA AND TPA.TP_TPA = 3 JOIN T_SIT SIT ON SIT.CD_SIT = INS.CD_SIT AND FL_SIT_CON_VOO = 0
	WHERE	PRA.TP_PRA = 1 AND NOT EXISTS (SELECT * FROM T_PRALOG WHERE CD_PRA = PRA.CD_PRA AND CD_CHG = INS.CD_CHG) AND TP_PRA_TPA = 1

	--Após a Alteração da Situação
	INSERT INTO T_PRALOG (CD_PRA, CD_CHG, CD_PAR, DH_LOG, FL_LOG)
	SELECT 	CD_PRA, NULL, NULL, DATEADD(MI, PRA.QT_PRA_TMP, GETDATE()), 0
	FROM	T_PRA PRA JOIN INSERTED INS ON INS.CD_SIT = PRA.CD_SIT AND INS.FL_CHG_TEL = 1 AND INS.FL_CHG_ANU = 1
	JOIN	T_TPA TPA ON TPA.CD_TPA = PRA.CD_TPA AND TPA.TP_TPA = 3 JOIN T_SIT SIT ON SIT.CD_SIT = INS.CD_SIT AND FL_SIT_CON_VOO = 0
	WHERE	PRA.TP_PRA = 2 AND NOT EXISTS (SELECT * FROM T_PRALOG WHERE CD_PRA = PRA.CD_PRA AND CD_CHG = INS.CD_CHG) AND TP_PRA_TPA = 1
END
--JOGAR os dados dos vôos do tipo Normal, nos vôos do tipo Codeshare
IF (	SELECT 	COUNT(*)  FROM T_CHG CHG, T_CHG CHGVIN, INSERTED INS
	WHERE	CHG.CD_CHG_VIN = INS.CD_CHG AND CHGVIN.CD_CHG = INS.CD_CHG) >0
BEGIN
	UPDATE	CHG
	SET	CD_EQP_CHG = CHGVIN.CD_EQP_CHG, CD_BOX = CHGVIN.CD_BOX,
		QT_CHG_PER_MIN = CHGVIN.QT_CHG_PER_MIN, DH_CHG_NRM = CHGVIN.DH_CHG_NRM,
		DH_CHG_EFE = CHGVIN.DH_CHG_EFE, DH_CHG_EST = CHGVIN.DH_CHG_EST,
		NM_CHG_COM_SIT = CHGVIN.NM_CHG_COM_SIT, DH_CHG_SIT  = CHGVIN.DH_CHG_SIT,
		FL_CHG_CAN = CHGVIN.FL_CHG_CAN, CD_SIT = CHGVIN.CD_SIT,
		TP_CHG_STA = CHGVIN.TP_CHG_STA, CD_USR = CHGVIN.CD_USR
	FROM	T_CHG CHG, T_CHG CHGVIN, INSERTED INS
	WHERE	CHG.CD_CHG_VIN = INS.CD_CHG AND CHGVIN.CD_CHG = INS.CD_CHG
END
--PUXAR os dados dos vôos do tipo Normal, nos vôos do tipo Codeshare
IF (	SELECT 	COUNT(*) FROM T_CHG CHG, T_CHG CHGVIN, INSERTED INS
	WHERE	CHG.CD_CHG = INS.CD_CHG AND CHGVIN.CD_CHG = INS.CD_CHG_VIN) > 0
BEGIN
	UPDATE	CHG
	SET	CD_EQP_CHG = CHGVIN.CD_EQP_CHG, CD_BOX = CHGVIN.CD_BOX,
		QT_CHG_PER_MIN = CHGVIN.QT_CHG_PER_MIN, DH_CHG_NRM = CHGVIN.DH_CHG_NRM,
		DH_CHG_EFE = CHGVIN.DH_CHG_EFE, DH_CHG_EST = CHGVIN.DH_CHG_EST,
		NM_CHG_COM_SIT = CHGVIN.NM_CHG_COM_SIT, DH_CHG_SIT  = CHGVIN.DH_CHG_SIT,
		FL_CHG_CAN = CHGVIN.FL_CHG_CAN, CD_SIT = CHGVIN.CD_SIT,
		TP_CHG_STA = CHGVIN.TP_CHG_STA, CD_USR = CHGVIN.CD_USR
	FROM	T_CHG CHG, T_CHG CHGVIN, INSERTED INS
	WHERE	CHG.CD_CHG = INS.CD_CHG AND CHGVIN.CD_CHG = INS.CD_CHG_VIN
END
--Lançar registro para Replicação na tabela T_REP001
IF UPDATE(CD_SIT) OR UPDATE(CD_AEN_CHG)
BEGIN
	DECLARE @HR_REP_ZUL INT
	DECLARE @HR_HOR_NRM INT
	DECLARE @HR_HOR_VER INT

	--Verifica Defazagem em relação ao horário Zulu
	SELECT 	@HR_HOR_NRM = HR_HOR_NRM, @HR_HOR_VER = HR_HOR_VER
	FROM 	T_HOR HOR, T_AER AER, T_CID CID, T_PSI PSI
	WHERE 	CID.CD_CID = AER.CD_CID And HOR.CD_HOR = CID.CD_HOR And AER.CD_AER = PSI.CD_AER
   
	--Verifica se o Aeroporto está no Horário de Verão
	IF (SELECT COUNT(*) FROM T_HRV WHERE GETDATE() BETWEEN DT_HRV_INI AND DT_HRV_FIM) > 0
		SELECT @HR_REP_ZUL = @HR_HOR_VER
	ELSE
		SELECT @HR_REP_ZUL = @HR_HOR_NRM
END
IF UPDATE(CD_SIT)
BEGIN
		
	/* Newton - 25/03/2002 */
	IF (	SELECT	COUNT(*)
		FROM	T_CHG CHG,
			INSERTED INS
		WHERE	CHG.CD_CHG = INS.CD_CHG AND
			CHG.TP_CHG_STA = 2)  > 0  /* TP_CHG_STA = 2 ---> Etapa concluída */
	--Atualizar os  Históricos de Esteira de Vôo que estiverem em aberto
	UPDATE T_HES SET DH_HES_CHG_DES = GETDATE()  FROM T_HES HES, INSERTED INS WHERE HES.CD_CHG = INS.CD_CHG And HES.DH_HES_CHG_DES is Null
	-------------
	--Vôos de CHG cujas situações estão sendo atualizadas para "Etapa Concluída" e cuja primeira escala posterior do vôo de PAR associado é um dos aeroportos ativos existentes na tabela T_RED
	DECLARE REP1 CURSOR FOR
	SELECT 	PAR.CD_PAR, SG_COM_IAT_003, NR_VOO = PAR.NR_PAR_VOO, 
		DH_VOO_EFE = INS.DH_CHG_EFE, QT_VOO_DIF = DATEDIFF(MI, INS.DH_CHG_NRM, INS.DH_CHG_EFE)
	FROM 	INSERTED INS, T_CHG CHG, T_SIT SIT, T_PAR PAR, T_COM COM
	WHERE	INS.CD_CHG = CHG.CD_CHG AND SIT.CD_SIT = INS.CD_SIT AND
		SIT.FL_SIT_CON_VOO = 1 AND CHG.FL_CHG_CAN = 0 AND
		PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
		PAR.CD_PAR IN (	SELECT	CD_PAR FROM T_ECP001 ECP
				WHERE	ECP.CD_PAR = PAR.CD_PAR AND
					ECP.CD_ECP = (SELECT MIN(CD_ECP) FROM T_ECP001 ECP1 WHERE ECP1.CD_PAR = ECP.CD_PAR) AND
					ECP.CD_AER IN (SELECT CD_AER FROM T_AER WHERE SG_AER_ICA IN (SELECT SG_AER_ICA FROM T_RED WHERE FL_RED_ATI = 1))) AND
		COM.CD_COM = PAR.CD_COM
	--Declaração das variáveis
	DECLARE @CD_PAR INT, @SG_COM_IAT_003 CHAR(3), 	@NR_VOO CHAR(10), @DH_VOO_EFE SMALLDATETIME, @QT_VOO_DIF INT
	--Abre cursor e posiciona no primeiro registro
	OPEN REP1
	FETCH REP1 INTO	@CD_PAR, @SG_COM_IAT_003, @NR_VOO, @DH_VOO_EFE, @QT_VOO_DIF
	--Processar todos os registros de REP1
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Inserir registro na tabela T_REP001
		INSERT INTO T_REP001 (
			SG_AER_ICA_ORI, SG_AER_ICA_DES, SG_COM_IAT_003, NR_VOO, 
			DH_VOO_EFE, QT_VOO_DIF, NM_SIT, NR_AEN,
			FL_CHG_CON, FL_PAR_CON, FL_AEN, DH_REP, DH_REP_ORI, HR_REP_ZUL)
		SELECT 	(SELECT SG_AER_ICA FROM T_AER WHERE CD_AER = (SELECT CD_AER FROM T_PSI)),
			(SELECT SG_AER_ICA FROM T_ECP001 ECP, T_AER AER WHERE ECP.CD_PAR = @CD_PAR AND ECP.CD_ECP = (SELECT MIN(CD_ECP) FROM T_ECP001 WHERE CD_PAR = @CD_PAR) AND ECP.CD_AER = AER.CD_AER),
			@SG_COM_IAT_003, @NR_VOO,
			@DH_VOO_EFE, @QT_VOO_DIF,
			NULL, NULL, 1, 0, 0, GETDATE(), GETDATE(), @HR_REP_ZUL
		--Ir para o próximo registro
		FETCH NEXT FROM REP1
		INTO	@CD_PAR, @SG_COM_IAT_003, @NR_VOO, @DH_VOO_EFE, @QT_VOO_DIF
	END
	CLOSE REP1
	DEALLOCATE REP1
END
IF UPDATE(CD_AEN_CHG)
BEGIN
	--Vôos de CHG cujas prefixos das aeronaves estão sendo atualizadas e cuja primeira escala posterior do vôo de PAR associado é um dos aeroportos ativos existentes na tabela T_RED
	DECLARE REP2 CURSOR FOR
	SELECT 	PAR.CD_PAR, SG_COM_IAT_003, NR_VOO = PAR.NR_PAR_VOO, NR_AEN
	FROM 	INSERTED INS, T_PAR PAR, T_COM COM, T_AEN AEN
	WHERE	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
		PAR.CD_PAR IN (	SELECT	CD_PAR 	FROM T_ECP001 ECP
				WHERE	ECP.CD_PAR = PAR.CD_PAR AND
					ECP.CD_ECP = (SELECT MIN(CD_ECP) FROM T_ECP001 ECP1 WHERE ECP1.CD_PAR = ECP.CD_PAR) AND
					ECP.CD_AER IN (SELECT CD_AER FROM T_AER WHERE SG_AER_ICA IN (SELECT SG_AER_ICA FROM T_RED WHERE FL_RED_ATI = 1))) AND
		COM.CD_COM = PAR.CD_COM AND AEN.CD_AEN =* INS.CD_AEN_CHG
	--Declaração das variáveis
	DECLARE @NR_AEN CHAR(10)
	--Abre curso e posiciona no primeiro registro
	OPEN REP2
	FETCH REP2 INTO @CD_PAR, @SG_COM_IAT_003, @NR_VOO, @NR_AEN
	--Processar todos os registros de REP2
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Inserir registro na tabela T_REP001
		INSERT INTO T_REP001 (
			SG_AER_ICA_ORI, SG_AER_ICA_DES, SG_COM_IAT_003, NR_VOO, 
			DH_VOO_EFE, QT_VOO_DIF, NM_SIT, NR_AEN,
			FL_CHG_CON, FL_PAR_CON, FL_AEN, DH_REP, DH_REP_ORI, HR_REP_ZUL)
		SELECT 	(SELECT SG_AER_ICA FROM T_AER WHERE CD_AER = (SELECT CD_AER FROM T_PSI)),
			(SELECT SG_AER_ICA FROM T_ECP001 ECP, T_AER AER WHERE ECP.CD_PAR = @CD_PAR AND ECP.CD_ECP = (SELECT MIN(CD_ECP) FROM T_ECP001 WHERE CD_PAR = @CD_PAR) AND ECP.CD_AER = AER.CD_AER),
			@SG_COM_IAT_003, @NR_VOO,
			NULL, NULL, NULL, @NR_AEN, 0, 0, 1, GETDATE(), GETDATE(), @HR_REP_ZUL

		--Ir para o próximo registro
		FETCH NEXT FROM REP2 INTO @CD_PAR, @SG_COM_IAT_003, @NR_VOO, @NR_AEN
	END
	CLOSE REP2
	DEALLOCATE REP2
END
--INCLUIR REGISTROS EM T_ACH
INSERT	T_ACH (DH_ACH, CD_CHG)
SELECT GETDATE(), CD_CHG FROM INSERTED

IF 	UPDATE(NR_CHG_VOO) OR UPDATE(TP_CHG_GRU) OR UPDATE(TP_CHG) OR 
	UPDATE(TP_CHG_NAT) OR UPDATE(TP_CHG_CTG) OR UPDATE(CD_COM)
BEGIN
	--Incluir registros em T_AHP
	INSERT	T_AHP (CD_HPA, DH_AHP)
	Select 	DISTINCT CD_HPA, GETDATE()
	From 	T_HPA001 HPA, T_CHG CHG, T_SIT SIT, INSERTED INS
	Where	HPA.CD_CHG = CHG.CD_CHG AND SIT.CD_SIT = CHG.CD_SIT AND
		HPA.CD_AER = (Select CD_AER From T_PSI) AND
		(HPA.FL_HPA_ENT = 1 OR SIT.FL_SIT_AEN_PAT = 1) AND HPA.FL_HPA_SAI = 0 AND
		HPA.CD_AEN IS NOT NULL AND CHG.CD_CHG = INS.CD_CHG
END
IF 	UPDATE(CD_AEN_CHG)
BEGIN
	--Incluir registros em T_APA
	INSERT	T_APA (CD_PAR, DH_APA)
	Select 	DISTINCT CD_PAR, GETDATE()
	From 	T_PAR PAR, INSERTED INS
	Where	PAR.CD_CHG_AEN_ANT = INS.CD_CHG AND
		PAR.TP_PAR_STA = 1 AND
		PAR.CD_AER = (Select CD_AER From T_PSI)

END
End
