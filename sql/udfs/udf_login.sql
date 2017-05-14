CREATE FUNCTION db.udf_login(@NIF INT, @password VARCHAR(30))
RETURNS @table TABLE ("NIF" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	INSERT @table SELECT funcionario.NIF
	FROM db.funcionario WHERE db.funcionario.NIF=@NIF AND db.funcionario.password=@password;
	RETURN;
END;

