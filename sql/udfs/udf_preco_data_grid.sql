CREATE FUNCTION db.udf_preco_data_grid(@nome varchar(30)=null)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "PVP" int, "Price" int, "IVA" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nome is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento
		END;
	ELSE
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA
			FROM db.Medicamento WHERE db.Medicamento.nome LIKE SUBSTRING(@nome,1,3) + '%' OR db.Medicamento.nome = @nome;
		END;
RETURN;
END;