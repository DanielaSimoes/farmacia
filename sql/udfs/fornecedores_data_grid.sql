CREATE FUNCTION db.udf_fornecedor_data_grid(@NIPC INT)
RETURNS @table TABLE ("Name" varchar(30), "Provider ID" int, "Phone" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@NIPC is null)
		BEGIN
			INSERT @table SELECT Distribuidor.nome, Distribuidor.NIPC, Distribuidor.telefone
			FROM db.Distribuidor;
		END;
	ELSE
		BEGIN
			INSERT @table SELECT Distribuidor.nome, Distribuidor.NIPC, Distribuidor.telefone
			FROM db.Distribuidor WHERE db.Distribuidor.NIPC=@NIPC;
		END;
RETURN;
END;