CREATE FUNCTION db.udf_preco_data_grid(@nome varchar(30) = null, @codigo int = null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null and @codigo is null)
		BEGIN
			INSERT @table SELECT Vende.medicamento_nome, Vende.lab_NIPC, Vende.PVP, Vende.Preco, Vende.IVA
			FROM db.Vende
		END;
	ELSE
		BEGIN
		IF (@nome is not null)
			BEGIN
				INSERT @table SELECT Vende.medicamento_nome, Vende.lab_NIPC, Vende.PVP, Vende.Preco, Vende.IVA
				FROM db.Vende WHERE db.Vende.medicamento_nome = @nome;
			END;
			ELSE
			BEGIN
				INSERT @table SELECT Vende.medicamento_nome, Vende.lab_NIPC, Vende.PVP, Vende.Preco, Vende.IVA
				FROM db.Vende JOIN db.Medicamento ON db.Vende.medicamento_nome=db.Medicamento.medicamento_nome AND db.Vende.lab_NIPC=db.Medicamento.lab_id WHERE db.Medicamento.codigo = @codigo;
			END;
		END;
RETURN;
END;