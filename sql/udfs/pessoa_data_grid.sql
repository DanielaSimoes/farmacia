CREATE FUNCTION db.udf_pessoa_data_grid(@NIF INT)
RETURNS @table TABLE ("Nome" varchar(30), "NIF" int, "Telefone" int, "Data Nascimento" date, "E-mail" varchar(30))

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@NIF is null)
		BEGIN
			INSERT @table SELECT pessoa.nome, pessoa.NIF, pessoa.telefone, pessoa.dataNasc, pessoa.email
			FROM db.pessoa;
		END;
	ELSE
		BEGIN
			INSERT @table SELECT pessoa.nome, pessoa.NIF, pessoa.telefone, pessoa.dataNasc, pessoa.email
			FROM db.pessoa WHERE db.pessoa.NIF=@NIF;
		END;
RETURN;
END;