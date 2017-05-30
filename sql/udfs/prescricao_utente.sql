CREATE FUNCTION db.udf_prescricao_utente(@num_prescricao int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
    BEGIN
        INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, @num_prescricao
        FROM db.Medicamento JOIN db.Contem ON db.Contem.nome_medicamento=db.Medicamento.nome AND db.Contem.lab_NIPC=db.Medicamento.lab_id
        WHERE db.Contem.num_prescricao=@num_prescricao AND Medicamento.nome=Contem.nome_medicamento AND Medicamento.lab_id=Contem.lab_NIPC;
    END;
RETURN;
END;
