CREATE FUNCTION db.udf_pessoa_data_grid(@NIF INT)
RETURNS @table TABLE ("nome" varchar(1), "NIF" int, "telefone" int, "dataNasc" date, "email" varchar(1))

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN

INSERT @table SELECT pessoa.nome, pessoa.NIF, pessoa.telefone, pessoa.dataNasc, pessoa.email
FROM db.pessoa

END;
RETURN;