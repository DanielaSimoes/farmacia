CREATE TRIGGER db.trigger_stock_insert ON db.TemMV
AFTER INSERT
AS
	SET NOCOUNT ON;

	DECLARE @count int;
	DECLERE @lote_id int;
	DECLARE @lab_id INT;
	DECLARE @nome VARCHAR(30);

	SELECT @lab_id = inserted.lab_NIPC FROM inserted;
	SELECT @nome = inserted.nome FROM inserted;

	-- lote com a validade mais recente, decrementar a quantidade em Lotes
	SELECT @count = COUNT(db.Lotes.id) FROM db.Lotes JOIN inserted ON db.Lotes.nome_med = @nome AND db.Lotes.lab_id = @lab_id WHERE quantidade > 0;

	IF @count > 0
	BEGIN
		-- obter um lote para um determinado medicamento
		SELECT TOP @lote_id = db.Lotes.id, @count = db.Lotes.quantidade FROM db.Lotes JOIN inserted ON db.Lotes.nome_med = @nome AND db.Lotes.lab_id = @lab_id WHERE db.Lotes.quantidade > 0 ORDER BY db.Lotes.validade ASC;

		SET @count = @count - 1;
		UPDATE  db.Lotes SET quantidade = @count
		WHERE id=@lote_id;
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

	-- lote com a validade mais recente, decrementar a quantidade em Lotes
	SELECT @count = COUNT(db.Lotes.id) FROM db.Lotes JOIN inserted ON db.Lotes.nome_med = @nome AND db.Lotes.lab_id = @lab_id WHERE quantidade > 0;

	IF @count > 0
	BEGIN
		-- obter um lote para um determinado medicamento
		SELECT TOP @lote_id = db.Lotes.id, @count = db.Lotes.quantidade FROM db.Lotes JOIN inserted ON db.Lotes.nome_med = @nome AND db.Lotes.lab_id = @lab_id WHERE db.Lotes.quantidade > 0 ORDER BY db.Lotes.validade ASC;

		SET @count = @count - 1;
		UPDATE  db.Lotes SET quantidade = @count
		WHERE id=@lote_id;
	END
	ELSE
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The medicine do not have stock!', 16, 1)
		END