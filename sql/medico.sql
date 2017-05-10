CREATE PROCEDURE db.sp_createMedico

				@especialidade	    VARCHAR(30),
				@numSNS      		INT,
				@NIF           		INT
              
WITH ENCRYPTION
AS
	IF @NIF is null OR @especialidade is null OR @numSNS is null

	BEGIN

		PRINT 'The NIF, the Specialty and the SNS number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Medico WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF already exists!', 14, 1)
	END

	SELECT @count = count(numSNS) FROM db.Medico WHERE numSNS=@numSNS

	IF @count != 0
	BEGIN
		RAISERROR('The SNS number already exists!', 14, 1)
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
