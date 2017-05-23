CREATE FUNCTION db.udf_stock_data_code(@codigo int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@codigo is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, NULL
			FROM db.Medicamento WHERE Medicamento.unidades > 0;
		END;
	ELSE
		BEGIN
			IF (@codigo is not null)
			BEGIN
	            INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, NULL
	            FROM db.Medicamento WHERE db.Medicamento.codigo = @codigo AND Medicamento.unidades > 0;
			END;
		END;
RETURN;
END;