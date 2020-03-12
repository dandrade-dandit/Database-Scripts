SELECT DISTINCT 
        ISNULL(id.CPF,'0') AS NUM_CPF, 
        id.Nome AS NME_CADASTRO, 
        id.DtNasc AS DAT_NASCIMENTO, 
        id.RG AS NUM_CARTEIRA_IDENTIDADE, 
        id.OrgaoExp AS NOM_ORGAO_EXPEDICAO_CI, 
        id.DDDFoneRes AS NUM_DDD_FONE_RESIDENCIAL, 
        id.FoneRes AS NUM_FONE_RESIDENCIAL, 
        id.Ativo AS ID_ATIVO, 
        ep.NomeFantasia AS NME_FANTASIA, 
                ep.RazaoSocial AS DS_RAZAO_SOCIAL, 
        v.DtRegistro AS DAT_REGISTRO, 
        v.Matricula AS NUM_MATRICULA, 
        lot.Sigla AS SIG_UOR_FISICA, 
        lot.Descricao AS NME_UOR_FISICA, 
        v.DtVencimento AS DAT_VENCIMENTO_CRACHA, 
        aer.IATA AS SIG_IATA , v.CodAeroporto vincCodAer, aer.CodAeroporto
FROM
        Vinculos AS v 
    join aeroportos as aer 
        on v.CodAeroporto = aer.CodAeroporto    
        LEFT OUTER JOIN 
        Identificados AS id 
                ON v.CodIdentificado = id.CodIdentificado 
        LEFT OUTER JOIN 
        Lotacoes AS lot 
                ON lot.CodLotacao = v.CodLotacao 
        LEFT OUTER JOIN 
        Empresas AS ep 
                ON ep.CodEmpresa = v.CodEmpresa 
WHERE 
        v.DtRegistro = (SELECT MAX(v2.DtRegistro) AS DT_REGISTRO FROM Vinculos AS v2 WHERE v.CodIdentificado = v2.CodIdentificado and v2.ativo = 1) 
and AcessoRedeInfraero = 1 
and id.DtNasc between '1900/01/01' and getdate() 
and datediff(yy,id.DtNasc,getdate()) > 14 
and ( ep.NomeFantasia NOT like '%ESTAGI%' AND 
         ep.NomeFantasia NOT like '%CIEE%' AND 
         ep.NomeFantasia <> 'INFRAERO' )
and id.nome  like 'MARCO ANTONIO GOOD%'         
         ORDER BY ep.RazaoSocial 
