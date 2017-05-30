CREATE FUNCTION db.udf_stock_data_grid(@nome varchar(30)=null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table
			SELECT Medicamento.nome, Medicamento.lab_id, Lotes.quantidade, Lotes.validade, Medicamento.dose, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento JOIN db.Lotes ON db.Medicamento.nome=db.Lotes.nome_med AND db.Medicamento.lab_id=db.Lotes.lab_id WHERE Lotes.quantidade > 0;
		END;
	ELSE
		BEGIN
	        INSERT @table
			SELECT Medicamento.nome, Medicamento.lab_id, Lotes.quantidade, Lotes.validade, Medicamento.dose, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento JOIN db.Lotes ON db.Medicamento.nome=db.Lotes.nome_med AND db.Medicamento.lab_id=db.Lotes.lab_id WHERE db.Medicamento.nome LIKE SUBSTRING(@nome,1,3) + '%' OR db.Medicamento.nome = @nome AND Lotes.quantidade > 0;
		END;
RETURN;
END;