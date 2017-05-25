CREATE PROCEDURE db.sp_createUtente

				@num_utente  		INT,
				@NIF           		INT,
				@nome 				VARCHAR(30),
				@morada			    VARCHAR(30) = null,
				@telefone 			INT = null,
                @dataNasc 			DATE = null,
                @email 				VARCHAR(30) = null

WITH ENCRYPTION
AS
	IF @NIF is null OR @num_utente is null OR @nome is null

	BEGIN

		PRINT 'The NIF or the User number or the Name cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Utente WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF already exists as user!', 14, 1)
		RETURN
	END

	SELECT @count = count(num_utente) FROM db.Utente WHERE num_utente=@num_utente

	IF @count != 0
	BEGIN
		RAISERROR('The User number already exists!', 14, 1)
		RETURN
	END

	SELECT @count = count(NIF) FROM db.Pessoa WHERE NIF=@NIF

	IF @count = 0
	BEGIN
		SET XACT_ABORT ON; --> the only change
		BEGIN TRANSACTION;

		BEGIN TRY

			INSERT INTO [master].[db].[Pessoa] VALUES (@NIF, @nome, @dataNasc, @email, @telefone)

			COMMIT TRANSACTION;

		END TRY

		BEGIN CATCH
			ROLLBACK TRANSACTION
			RAISERROR('An error occurred when creating the person!', 14, 1)
			RETURN
		END CATCH;
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Utente
		VALUES (@morada, @num_utente, @NIF)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the Utente!', 14, 1)
		RETURN
	END CATCH;


