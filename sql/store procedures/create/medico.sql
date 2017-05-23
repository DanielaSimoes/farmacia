CREATE PROCEDURE db.sp_createMedico

				@especialidade	    VARCHAR(30),
				@numSNS      		INT,
				@NIF           		INT,
				@nome 				VARCHAR(30),
				@telefone 			INT = null,
                @dataNasc 			DATE = null,
                @email 				VARCHAR(30) = null

WITH ENCRYPTION
AS
	IF @NIF is null OR @especialidade is null OR @numSNS is null or @nome is null

	BEGIN

		PRINT 'The NIF, the Name, the Specialty or the SNS number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Medico WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF as a doctor already exists!', 14, 1)
	END

	SELECT @count = count(numSNS) FROM db.Medico WHERE numSNS=@numSNS

	IF @count != 0
	BEGIN
		RAISERROR('The SNS number already exists!', 14, 1)
	END

	SELECT @count = DATALENGTH(nif) FROM db.Medico WHERE nif=@NIF

	IF @count != 8
	BEGIN
		RAISERROR('The NIF need to have 8 digits!', 14, 1)
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
		END CATCH;
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Medico([NIF],[especialidade],[numSNS])
		VALUES (@NIF, @especialidade, @numSNS)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the person!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
