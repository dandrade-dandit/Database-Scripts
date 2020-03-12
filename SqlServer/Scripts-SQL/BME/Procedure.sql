CREATE OR REPLACE PROCEDURE IFRSRH.ChefeImediato( uor in number, matricula in number, chefe out number ) is
BEGIN
 chefe:= IFRSRH.PK_VIAGENS.CHEFE_IMEDIATO (uor, matricula);
END;
/


