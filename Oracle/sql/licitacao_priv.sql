DELETE FROM PRIVILEGIO;
DELETE FROM FUNCIONALIDADE;

-- CADASTRO DE CARGO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (1,'Página de cadastro de cargo','/cargo/cadastra_cargo.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (2, 'Servlet de cadastro de cargo - Alias','/servlet/CadastraCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (3,'Servlet de cadastro de cargo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (4,'Servlet de pesquisa de cargo - Alias','/servlet/PesquisaCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (5,'Servlet de pesquisa de cargo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (6,'Servlet de alteração de cargo - Alias','/servlet/AlteraCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (7,'Servlet de alteração de cargo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (8,'Servlet de remoção de cargo - Alias','/servlet/DeletaCargo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (9,'Servlet de remoção de cargo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaCargo')
/

-- CADASTRO DE MODALIDADE

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (20,'Página de cadastro de modalidade','/modalidade/cadastra_modalidade.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (21, 'Servlet de cadastro de modalidade - Alias','/servlet/CadastraModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (22,'Servlet de cadastro de modalidade - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (23,'Servlet de pesquisa de modalidade - Alias','/servlet/PesquisaModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (24,'Servlet de pesquisa de modalidade - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (25,'Servlet de alteração de modalidade - Alias','/servlet/AlteraModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (26,'Servlet de alteração de modalidade - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (27,'Servlet de remoção de modalidade - Alias','/servlet/DeletaModalidade')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (28,'Servlet de remoção de modalidade - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaModalidade')
/

-- CADASTRO DE SITUAÇÃO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (40,'Página de cadastro de tp_situacao','/tp_situacao/cadastra_tp_situacao.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (41, 'Servlet de cadastro de tp_situacao - Alias','/servlet/CadastraTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (42,'Servlet de cadastro de tp_situacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (43,'Servlet de pesquisa de tp_situacao - Alias','/servlet/PesquisaTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (44,'Servlet de pesquisa de tp_situacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (45,'Servlet de alteração de tp_situacao - Alias','/servlet/AlteraTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (46,'Servlet de alteração de tp_situacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (47,'Servlet de remoção de tp_situacao - Alias','/servlet/DeletaTpSituacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (48,'Servlet de remoção de tp_situacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaTpSituacao')
/

-- CADASTRO DE TIPO DE DOCUMENTO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (60,'Página de cadastro de tp_documento','/tp_documento/CadastraTpDocumento.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (61, 'Servlet de cadastro de tp_documento - Alias','/servlet/CadastraTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (62,'Servlet de cadastro de tp_documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (63,'Servlet de pesquisa de tp_documento - Alias','/servlet/PesquisaTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (64,'Servlet de pesquisa de tp_documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (65,'Servlet de alteração de tp_documento - Alias','/servlet/AlteraTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (66,'Servlet de alteração de tp_documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (67,'Servlet de remoção de tp_documento - Alias','/servlet/DeletaTpDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (68,'Servlet de remoção de tp_documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaTpDocumento')
/

-- CADASTRO DE USUÁRIOS

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (80,'Página de cadastro de usuario','/usuario/cadastra_usuario.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (81, 'Servlet de cadastro de usuario - Alias','/servlet/CadastraUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (82,'Servlet de cadastro de usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (83,'Servlet de pesquisa de usuario - Alias','/servlet/PesquisaUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (84,'Servlet de pesquisa de usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (85,'Servlet de alteração de usuario - Alias','/servlet/AlteraUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (86,'Servlet de alteração de usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (87,'Servlet de remoção de usuario - Alias','/servlet/DeletaUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (88,'Servlet de remoção de usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (89,'Página para pesquisa de usuario','/usuario/pesquisa_usuario.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (90,'Servlet de remoção de unidades asscociadas a um usuario - Alias','/servlet/DeletaUnidadeAssociada')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (91,'Servlet de remoção de unidades asscociadas a um usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaUnidadeAssociada')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (92, 'Servlet de cadastro de unidades asscociadas a um usuario - Alias','/servlet/CadastraUnidadeAssociada')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (93,'Servlet de cadastro de unidades asscociadas a um usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraUnidadeAssociada')
/

-- CADASTRO DE FORNECEDOR

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (100,'Página de cadastro de fornecedor','/fornecedor/cadastra_fornecedor.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (101, 'Servlet de cadastro de fornecedor - Alias','/servlet/CadastraFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (102,'Servlet de cadastro de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (103,'Servlet de pesquisa de fornecedor - Alias','/servlet/PesquisaFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (104,'Servlet de pesquisa de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (105,'Servlet de alteração de fornecedor - Alias','/servlet/AlteraFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (106,'Servlet de alteração de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (107,'Página para pesquisa de fornecedor','/fornecedor/pesquisa_fornecedor.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (108,'Servlet de pesquisa do historico de fornecedor - Alias','/servlet/PesquisaHistFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (109,'Servlet de pesquisa do historico de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (110,'Servlet de remoção de fornecedor - Alias','/servlet/DeletaFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (111,'Servlet de remoção de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaFornecedor')
/
-- PESQUISA LICITAÇÃO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (130,'Página para pesquisa de licitação','/licitacao/pesquisa_licitacao.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (131,'Servlet de pesquisa de licitação - Alias','/servlet/PesquisaLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (132,'Servlet de pesquisa de licitação - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (133,'Servlet de alteração de licitacao - Alias','/servlet/AlteraLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (134,'Servlet de alteração de licitaco - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (135,'Servlet de pesquisa de comissão - Alias','/servlet/PesquisaComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (136,'Servlet de pesquisa de comissão - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (137,'Servlet de pesquisa de documento - Alias','/servlet/PesquisaDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (138,'Servlet de pesquisa de documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (139,'Servlet de pesquisa de participante - Alias','/servlet/PesquisaParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (140,'Servlet de pesquisa de participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (141,'Servlet de alteração de documento - Alias','/servlet/AlteraDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (142,'Servlet de alteração de documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (143,'Servlet de pesquisa do historico de fornecedor - Alias','/servlet/PesquisaHistParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (144,'Servlet de pesquisa do historico de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (145,'Servlet de alteração de Participante - Alias','/servlet/AlteraParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (146,'Servlet de alteração de Participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraParticipante')
/


-- PESQUISA FUNCIONARIO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (170,'Página para pesquisa de funcionário','/funcionario/pesquisa_funcionario.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (171,'Servlet de pesquisa de funcionário - Alias','/servlet/PesquisaFuncionario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (172,'Servlet de pesquisa de funcionário - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaFuncionario')
/

-- CADASTRO LICITAÇÃO

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (180,'Página de cadastro de licitação','/licitacao/cadastra_licitacao.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (181, 'Servlet de cadastro de licitação - Alias','/servlet/CadastraLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (182,'Servlet de cadastro de licitação - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (183,'Servlet de remoção de licitacao - Alias','/servlet/DeletaLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (184,'Servlet de remoção de licitacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (185,'Página cadastro de membro de uma comissão de uma licitação','/comissao/cadastra_comissao.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (186, 'Servlet de cadastro de membro de uma comissão de uma licitação - Alias','/servlet/CadastraComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (187,'Servlet de cadastro de membro de uma comissão de uma licitação - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (188,'Servlet de remoção de membro de uma comissão de uma licitacao - Alias','/servlet/DeletaComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (189,'Servlet de remoção de membro de uma comissão de uma licitacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (190,'Página de cadastro de documento','/documento/cadastro_documento.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (191,'Página de cadastro de arquivo','/documento/cadastra_arquivo.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (192, 'Servlet de cadastro de documento - Alias','/servlet/CadastraDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (193,'Servlet de cadastro de Documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (194,'Servlet de remoção de documento - Alias','/servlet/DeletaDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (195,'Servlet de remoção de documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (196, 'Servlet de cadastro de arquivo - Alias','/servlet/CadastraArquivo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (197,'Servlet de cadastro de arquivo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraArquivo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (198,'Servlet de remoção de arquivo - Alias','/servlet/DeletaArquivo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (199,'Servlet de remoção de arquivo - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaArquivo')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (200,'Página cadastro de participante','/participante/cadastra_participante.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (201,'Página para a pesquisa de participante para uma licitação','/participante/pesquisa_participante.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (202, 'Servlet de cadastro de participante - Alias','/servlet/CadastraParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (203,'Servlet de cadastro de participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.CadastraParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (204,'Servlet de remoção de participante - Alias','/servlet/DeletaParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (205,'Servlet de remoção de participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.DeletaParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (206,'Servlet de notificação de participante - Alias','/servlet/NotificarParticipantes')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (207,'Servlet de notificação de participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.NotificarParticipantes')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (208,'Página para notificar participante','/notificacao/notificar_participantes.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (209,'Servlet de notificação de comissão - Alias','/servlet/NotificarComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (210,'Servlet de notificação de comissão - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.NotificarComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (211,'Página para notificar comissão','/notificacao/notificar_comissao.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (212,'Servlet de pesquisa de fornecedor - Alias','/servlet/PesquisaFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (213,'Servlet de pesquisa de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (214,'','/dhtmlEditor/insertTable.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (215,'','/dhtmlEditor/paletteColor.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (216,'Página para notificar presidente','/notificacao/notificar_presidente.jsp')
/

insert into funcionalidade (ID,DESCRICAO, URI) 
values(217,'Servlet de notificacao de Presidente - Alias','/servlet/NovaNotificacaoPresidente')
/

insert into funcionalidade (ID,DESCRICAO, URI)
values(218,'Servlet de notificacao de Presidente - Caminho completo', '/servlet/br.com.formatool.infraero.sede.licitacao.web.NovaNotificacaoPresidente')


-- PARTES COMUNS

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (240, 'Página inicial', '/index.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (241, 'Página de login', '/seguranca/login.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (242,'Servlet para autenticar usuario - Alias','/servlet/Autenticador')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (243,'Servlet para autenticar usuario - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.Autenticador')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (244, 'Página de alteração de senha', '/seguranca/alteraSenha.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (245,'Servlet para alterar senha - Alias','/servlet/AlteraSenha')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (246,'Servlet para alterar senha - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.AlteraSenha')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (247,'Servlet para realizar logoff - Alias','/servlet/LogoffUsuario')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (248,'Servlet para realizar logoff - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.LogoffUsuario')
/

-- AUDITORIA

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (260,'Servlet de pesquisa do historico de licitacao - Alias','/servlet/PesquisaHistoricoLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (261,'Servlet de pesquisa do historico de licitacao - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistoricoLicitacao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (262,'Servlet de pesquisa do historico de documento - Alias','/servlet/PesquisaHistoricoDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (263,'Servlet de pesquisa do historico de documento - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistoricoDocumento')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (264,'Servlet de pesquisa do historico de comissão - Alias','/servlet/PesquisaHistoricoComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (265,'Servlet de pesquisa do historico de comissão - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistoricoComissao')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (266,'Servlet de pesquisa do historico de participante - Alias','/servlet/PesquisaHistoricoParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (267,'Servlet de pesquisa do historico de participante - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistoricoParticipante')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (268,'Servlet de pesquisa do historico de fornecedor - Alias','/servlet/PesquisaHistoricoFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (269,'Servlet de pesquisa do historico de fornecedor - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaHistoricoFornecedor')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (270,'Servlet de pesquisa para licitação removida - Alias','/servlet/PesquisaLicitacaoRemovida')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (271,'Servlet de pesquisa para licitacao removida - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaLicitacaoRemovida')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (272,'Página para pesquisa de licitação removida ','/licitacao/pesquisa_licitacao_removida.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (273,'Servlet de pesquisa para fornecedor removido - Alias','/servlet/PesquisaFornecedorRemovido')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (274,'Servlet de pesquisa para fornecedor removido - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaFornecedorRemovido')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (275,'Página para pesquisa de fornecedor removido ','/fornecedor/pesquisa_fornecedor_removido.jsp')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (276,'Servlet de pesquisa para participante removido - Alias','/servlet/PesquisaParticipanteRemovido')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (277,'Servlet de pesquisa para participante removido - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaParticipanteRemovido')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (278,'Servlet de pesquisa para documento removido - Alias','/servlet/PesquisaDocumentoRemovido')
/

INSERT INTO FUNCIONALIDADE (ID,DESCRICAO, URI)
VALUES (279,'Servlet de pesquisa para documento removido - Caminho completo','/servlet/br.com.formatool.infraero.sede.licitacao.web.PesquisaDocumentoRemovido')
/
----------------------------------------------------

--PRIVILEGIO

  -- PARA O PERFIL ADMINISTRADOR
  
    -- ACESSO TOTAL
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 1
      FROM FUNCIONALIDADE
/

  -- PARA O PERFIL CADASTRADOR DE LICITAÇÃO
    
    -- PRIVILEGIO PARA AS PARTES COMUNS
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 2
      FROM FUNCIONALIDADE
      WHERE ID >= 240 AND ID < 260
/

    -- PRIVILEGIO PARA CONSULTA A LICITACAO
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 2
      FROM FUNCIONALIDADE
      WHERE ID >= 130 AND ID < 170
/

    -- PRIVILEGIO PARA PESQUISA DE FUNCIONARIO
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 2
      FROM FUNCIONALIDADE
      WHERE ID >= 170 AND ID < 180
/

    -- PRIVILEGIO PARA CADASTRO DE LICITACAO
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 2
      FROM FUNCIONALIDADE
      WHERE ID >= 180 AND ID < 240
/
	
	-- PRIVILEGIO PARA CADASTRO DE FORNECEDOR
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 2
      FROM FUNCIONALIDADE
      WHERE ID >= 100 AND ID < 111
/
	
  -- PARA O PERFIL CONSULTA
  
    -- PRIVILEGIO PARA AS PARTES COMUNS
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 3
      FROM FUNCIONALIDADE
      WHERE ID >= 240 AND ID < 260
/

    -- PRIVILEGIO PARA CONSULTA A LICITACAO
    INSERT INTO PRIVILEGIO (ID_FUNCIONALIDADE, ID_PERFIL)
      SELECT ID, 3
      FROM FUNCIONALIDADE
      WHERE ID >= 130 AND ID < 170
/
