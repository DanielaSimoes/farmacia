CREATE FUNCTION db.udf_get_function(@NIF int)
RETURNS @table TABLE ("Function" varchar(30))

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
    INSERT @table SELECT Funcionario.funcao
    FROM db.Funcionario WHERE Funcionario.NIF = @NIF;
RETURN;
END;