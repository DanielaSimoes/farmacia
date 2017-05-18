CREATE TRIGGER trigger_stock ON db.Medicamento
AFTER UPDATE
AS
	SELECT db.Medicamento.unidades FROM db.Medicamento JOIN inserted ON db.Medicamento.nome = inserted.nome;