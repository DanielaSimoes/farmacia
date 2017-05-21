CREATE PROCEDURE db.sp_update_points
                @NIF INT

WITH ENCRYPTION
AS
	IF @NIF is null

	BEGIN
		PRINT 'The NIF cannot be empty!'
		RETURN
	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Pessoa WHERE nif=@NIF

	IF @count = 0
	BEGIN
		RAISERROR('The NIF does not exists!', 14, 1)
	END

    BEGIN TRANSACTION;

	BEGIN TRY

        UPDATE  db.Venda SET
                pontos = 0
        WHERE utente_NIF=@NIF

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when updating the user!', 14, 1)
	END CATCH;