CREATE FUNCTION db.udf_stock_data_grid(@nome varchar(30)=null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Vende.PVP, Vende.Preco, Vende.IVA, NULL
			FROM db.Vende JOIN db.Medicamento ON db.Vende.medicamento_nome=db.Medicamento.nome AND db.Vende.lab_NIPC=db.Medicamento.lab_id WHERE Medicamento.unidades > 0;
		END;
	ELSE
		BEGIN
	        INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Vende.PVP, Vende.Preco, Vende.IVA, NULL
	        FROM db.Vende JOIN db.Medicamento ON db.Vende.medicamento_nome=db.Medicamento.nome AND db.Vende.lab_NIPC=db.Medicamento.lab_id WHERE db.Medicamento.nome = @nome AND Medicamento.unidades > 0;
		END;
RETURN;
END;