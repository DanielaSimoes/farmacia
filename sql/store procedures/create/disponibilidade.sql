CREATE PROCEDURE db.sp_createDisponibilidade
				@disponibilidade    varchar(30)

WITH ENCRYPTION
AS
	IF @disponibilidade is null

	BEGIN

		PRINT 'The availability cannot be empty!'
		RETURN

	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Disponibilidade ([disponibilidade])
		VALUES (@disponibilidade)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the availability!', 14, 1)
	END CATCH;
