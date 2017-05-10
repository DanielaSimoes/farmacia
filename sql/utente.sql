CREATE PROCEDURE db.sp_createUtente

				@morada			    VARCHAR(30),
				@num_utente  		INT,
				@NIF           		INT
              
WITH ENCRYPTION
AS
	IF @NIF is null OR @num_utente is null 

	BEGIN

		PRINT 'The NIF and the Utente number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Utente WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF already exists!', 14, 1)
	END

	SELECT @count = count(num_utente) FROM db.Utente WHERE num_utente=@num_utente

	IF @count != 0
	BEGIN
		RAISERROR('The Utente number already exists!', 14, 1)
	END


	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Person([NIF],[morada],[num_utente])
		VALUES (@NIF, @morada, @num_utente)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the Utente!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
