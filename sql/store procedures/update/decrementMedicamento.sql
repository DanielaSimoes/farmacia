CREATE PROCEDURE db.sp_decrementMedicamento

				@codigo				 INT

WITH ENCRYPTION
AS
	IF @codigo is null

	BEGIN
		PRINT 'The code cannot be empty!'
		RETURN
	END

	DECLARE @count int

	-- verificar se o medicamento existe pelo codigo
	SELECT @count = count(codigo) FROM db.medicamento WHERE codigo = @codigo;

	IF @count = 0
	BEGIN
		RAISERROR ('The code that you provided do not exists!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;

	DECLARE @units int

	-- verificar se existe stock
	SELECT @units = unidades FROM db.medicamento WHERE codigo = @codigo;

	IF @units = 0
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('No stock!', 14, 1)
		RETURN
	END

	BEGIN TRY
		SET @units = @units - 1;
		UPDATE  [farmacia].[db].[Medicamento] SET
				unidades = @units
		WHERE codigo = @codigo;

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when updating the medicament!', 14, 1)
	END CATCH;