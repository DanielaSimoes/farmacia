CREATE PROCEDURE db.sp_createLote
			@nome_med		VARCHAR(30),
			@lab_id			INT,
			@quantidade		INT,
			@validade		DATE

WITH ENCRYPTION
AS
	IF @nome_med is null OR @lab_id is null OR @quantidade is null OR @validade is null

	BEGIN

		PRINT 'The id, nome_med, lab_id, quantidade, and validade cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nome_med) FROM db.Lotes WHERE nome_med=@nome_med and lab_id=@lab_id

	IF @count != 0
	BEGIN
		UPDATE db.Lotes SET
		quantidade=quantidade + @quantidade
		WHERE nome_med=@nome_med
	END

	ELSE
	BEGIN
		BEGIN TRANSACTION;

		BEGIN TRY

			INSERT INTO db.Lotes
			VALUES (@nome_med, @lab_id, @quantidade, @validade)

		COMMIT TRANSACTION;

		END TRY


	BEGIN CATCH
		RAISERROR('An error occurred when creating the lot!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
	END