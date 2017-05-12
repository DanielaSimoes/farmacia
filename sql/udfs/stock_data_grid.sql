CREATE FUNCTION db.udf_stock_data_grid(@nome varchar(30) = null, @codigo int = null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null and @codigo is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo
			FROM db.Medicamento;
		END;
	ELSE
		BEGIN
			IF (@nome is not null)
			BEGIN
	            INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo
	            FROM db.Medicamento WHERE db.Medicamento.nome = @nome;
			END;
			ELSE
			BEGIN
				INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo
				FROM db.Medicamento WHERE db.Medicamento.codigo = @codigo;
			END;
		END;
RETURN;
END;