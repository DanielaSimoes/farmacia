CREATE FUNCTION db.preco_code(@codigo int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@codigo is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento
		END;
	ELSE
		BEGIN
		IF (@codigo is not null)
			BEGIN
				INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
				FROM db.Medicamento WHERE db.Medicamento.codigo = @codigo;
			END;
		END;
RETURN;
END;