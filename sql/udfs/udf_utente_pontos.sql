CREATE FUNCTION db.udf_utente_pontos(@NIF INT)
RETURNS @table TABLE ("Pontos" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
    INSERT @table SELECT sum(Venda.pontos)
    FROM db.Venda WHERE Venda.utente_NIF = @NIF;
RETURN;
END;