--SP_HELP AUTHORS

SET NOCOUNT ON

DECLARE @TAB_TEMP TABLE(
au_id             varchar(12),
au_lname          varchar(40),
au_fname          varchar(20),
phone             char(12),
address           varchar(40),
city              varchar(20),
state             char(2),
zip               char(5),
contract          bit)

INSERT INTO @TAB_TEMP
SELECT * FROM AUTHORS

SELECT * FROM @TAB_TEMP