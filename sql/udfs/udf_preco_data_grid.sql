CREATE FUNCTION db.udf_preco_data_grid(@nome varchar(30) = null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table SELECT Vende.medicamento_nome, Vende.lab_NIPC, Vende.PVP, Vende.Preco, Vende.IVA
			FROM db.Vende;
		END;
	ELSE
		BEGIN
        INSERT @table SELECT Vende.medicamento_nome, Vende.lab_NIPC, Vende.PVP, Vende.Preco, Vende.IVA
        FROM db.Vende WHERE db.Vende.medicamento_nome = @nome;
		END;
RETURN;
END;