CREATE FUNCTION db.udf_stock_data_grid(@nome varchar(30) = null)
RETURNS @table TABLE ("Nome" varchar(30), "Laboratório" int, "Quantidade" int, "Validade" date, "Dose" int, "Unidades" int, "Categoria" int, "Tipo" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id
			FROM db.Medicamento;
		END;
	ELSE
		BEGIN
            INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id
            FROM db.Medicamento WHERE db.Medicamento.nome = @nome;
		END;
RETURN;
END;