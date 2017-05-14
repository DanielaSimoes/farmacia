CREATE FUNCTION db.udf_login(@NIF INT, @password VARCHAR(30))
RETURNS @table TABLE ("NIF" int, "Password" VARCHAR(30))

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
		BEGIN
			INSERT @table SELECT funcionario.NIF, funcionario.password
			FROM db.funcionario WHERE db.funcionario.NIF=@NIF AND db.funcionario.password=@password;
		END;
RETURN;
END;

