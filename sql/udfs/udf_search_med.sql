CREATE FUNCTION db.udf_search_med(@codigo int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
		INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, 1, Medicamento.validade, Medicamento.dose, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, NULL
		FROM db.Medicamento WHERE Medicamento.unidades > 0;
RETURN;
END;