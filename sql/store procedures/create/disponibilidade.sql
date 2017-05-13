CREATE PROCEDURE db.sp_createDisponibilidade

				@ID			 		INT,
				@disponibilidade    INT
              
WITH ENCRYPTION
AS
	IF @disponibilidade is null  

	BEGIN

		PRINT 'The availability cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(ID) FROM db.Disponibilidade WHERE ID=@ID

	IF @count != 0
	BEGIN
		RAISERROR('The ID already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [farmacia].[db].[Disponibilidade]
		VALUES (@ID, @disponibilidade)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the availability!', 14, 1)
	END CATCH;
