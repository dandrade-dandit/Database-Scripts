CREATE OR REPLACE PROCEDURE ifrseg.prc_envia_email (
   remetente      IN   VARCHAR2,
   destinatario   IN   VARCHAR2,
   assunto        IN   VARCHAR2,
   mensagem       IN   VARCHAR2
)
AS
--   servidor       VARCHAR2 (100)      := '10.0.17.29'; -- pode ser utilizado o 10.0.17.29 tamb�m.
   servidor       VARCHAR2 (100)      := '10.0.17.60'; -- pode ser utilizado o 10.0.17.60 tamb�m.   
   conexao_smtp   UTL_SMTP.connection;
------------------------------------------------------------------------------------
--                                   ENVIA_EMAIL                                  --
--                                                                                --
-- Procedure utilizada para envio de e-mails via servidor SMTP.                   --
-- Autor: Luiz Fernando Bastos Coura - Grupo IOS                                  --
-- Data: 18/02/2005                                                               --
--                                                                                --
------------------------------------------------------------------------------------
BEGIN
  
   conexao_smtp := UTL_SMTP.open_connection (servidor); --  Abre conex�o com o servidor SMTP
   UTL_SMTP.helo (conexao_smtp, servidor);              --  Executa o primeiro "HandShake"
   UTL_SMTP.mail (conexao_smtp, remetente);             --  Define o Remetente
   UTL_SMTP.rcpt (conexao_smtp, destinatario);          --  Define o destinatario
   UTL_SMTP.open_data (conexao_smtp);                   --  Abre a conex�o para passagem de dados
                                                        --      de cabe�alho e do corpo do email
   UTL_SMTP.write_data (conexao_smtp, 'From:' || remetente);    --  Envia o cabe�alho - Remetente
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'To:' || destinatario);   --  Envia o cabe�alho - Destinat�rio
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'Subject:' || assunto);   --  Envia o cabe�alho - Assunto
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || mensagem);    --  Envia o corpo do email, isto �, a
                                                                    --  mensagem propriamente dita.
   UTL_SMTP.close_data (conexao_smtp);                  --  Fecha a conex�o de dados com o servidor SMTP
   UTL_SMTP.quit (conexao_smtp);                        --  Finaliza a conex�o do o servidor SMTP
EXCEPTION
   WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error
   THEN
      UTL_SMTP.quit (conexao_smtp);
      raise_application_error
                        (-20000,
                            'Failed tosend mail due to the following error: '
                         || SQLERRM
                        );
   WHEN OTHERS
   THEN
      raise_application_error (-20001,
                               'The following error has occured: ' || SQLERRM
                              );
END;
/

GRANT EXECUTE ON ifrseg.prc_envia_email TO seg_geral
/
GRANT EXECUTE ON ifrseg.prc_envia_email TO bde_geral
/
