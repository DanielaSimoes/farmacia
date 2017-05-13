CREATE FUNCTION db.utente_data_grid(@NIF INT)
RETURNS @table TABLE ("Name" varchar(30), "NIF" int, "Utente Number" int, "Phone" int, "E-mail" varchar(30))

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@NIF is null)
		BEGIN
			INSERT @table SELECT pessoa.nome, utente.NIF, utente.num_utente, pessoa.telefone, pessoa.email
		FROM db.pessoa, db.utente WHERE db.pessoa.NIF = db.utente.NIF;
		END;
	ELSE
	BEGIN
		INSERT @table SELECT pessoa.nome, utente.NIF, utente.num_utente, pessoa.telefone, pessoa.email
		FROM db.pessoa, db.utente WHERE db.pessoa.NIF=@NIF AND db.pessoa.NIF = db.utente.NIF;
	END;

RETURN;
END;
