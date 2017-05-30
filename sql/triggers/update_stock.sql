CREATE TRIGGER db.trigger_stock_insert ON db.TemMV
AFTER INSERT
AS
	SET NOCOUNT ON;

	DECLARE @count int;
	DECLARE @lab_id INT;
	DECLARE @nome VARCHAR(30);

	SELECT @lab_id = inserted.lab_NIPC FROM inserted;
	SELECT @nome = inserted.nome FROM inserted;

	SELECT @count = db.Medicamento.unidades FROM db.Medicamento JOIN inserted ON db.Medicamento.nome = @nome AND db.Medicamento.lab_id = @lab_id;

	IF @count > 0
	BEGIN
		SET @count = @count - 1;
		UPDATE  db.Medicamento SET
				unidades = @count
		WHERE nome = @nome AND lab_id = @lab_id;
	END
	ELSE
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The medicine do not have stock!', 16, 1)
		END

go
-- DROP TRIGGER db.trigger_stock_update
CREATE TRIGGER db.trigger_stock_update ON db.TemMV
AFTER UPDATE
AS
	SET NOCOUNT ON;

	DECLARE @count int;
	DECLARE @lab_id INT;
	DECLARE @nome VARCHAR(30);

	SELECT @lab_id = inserted.lab_NIPC FROM inserted;
	SELECT @nome = inserted.nome FROM inserted;

	SELECT @count = db.Medicamento.unidades FROM db.Medicamento JOIN inserted ON db.Medicamento.nome = @nome AND db.Medicamento.lab_id = @lab_id;

	IF @count > 0
	BEGIN
		SET @count = @count - 1;
		UPDATE  [master].[db].[Medicamento] SET
				unidades = @count
		WHERE nome = @nome AND lab_id = @lab_id;
	END
	ELSE
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The medicine do not have stock!', 16, 1)
		END