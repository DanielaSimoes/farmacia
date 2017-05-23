CREATE FUNCTION db.udf_stock_data_grid(@nome varchar(30)=null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento WHERE Medicamento.unidades > 0;
		END;
	ELSE
		BEGIN
	        INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
	        FROM db.Medicamento WHERE db.Medicamento.nome LIKE SUBSTRING(@nome,1,3) + '%' OR db.Medicamento.nome = @nome AND Medicamento.unidades > 0;
		END;
RETURN;
END;