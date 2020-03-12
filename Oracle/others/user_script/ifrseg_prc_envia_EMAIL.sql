CREATE OR REPLACE PROCEDURE ifrseg.prc_envia_email (
   remetente      IN   VARCHAR2,
   destinatario   IN   VARCHAR2,
   assunto        IN   VARCHAR2,
   mensagem       IN   VARCHAR2
)
AS
--   servidor       VARCHAR2 (100)      := '10.0.17.29'; -- pode ser utilizado o 10.0.17.29 também.
   servidor       VARCHAR2 (100)      := '10.0.17.60'; -- pode ser utilizado o 10.0.17.60 também.   
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
  
   conexao_smtp := UTL_SMTP.open_connection (servidor); --  Abre conexão com o servidor SMTP
   UTL_SMTP.helo (conexao_smtp, servidor);              --  Executa o primeiro "HandShake"
   UTL_SMTP.mail (conexao_smtp, remetente);             --  Define o Remetente
   UTL_SMTP.rcpt (conexao_smtp, destinatario);          --  Define o destinatario
   UTL_SMTP.open_data (conexao_smtp);                   --  Abre a conexão para passagem de dados
                                                        --      de cabeçalho e do corpo do email
   UTL_SMTP.write_data (conexao_smtp, 'From:' || remetente);    --  Envia o cabeçalho - Remetente
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'To:' || destinatario);   --  Envia o cabeçalho - Destinatário
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || 'Subject:' || assunto);   --  Envia o cabeçalho - Assunto
   UTL_SMTP.write_data (conexao_smtp, UTL_TCP.crlf || mensagem);    --  Envia o corpo do email, isto é, a
                                                                    --  mensagem propriamente dita.
   UTL_SMTP.close_data (conexao_smtp);                  --  Fecha a conexão de dados com o servidor SMTP
   UTL_SMTP.quit (conexao_smtp);                        --  Finaliza a conexão do o servidor SMTP
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
