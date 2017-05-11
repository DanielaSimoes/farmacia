CREATE PROCEDURE db.sp_createPessoa
                @nome VARCHAR(30) ,
                @NIF INT ,
				@telefone INT,
                @dataNasc DATE ,
                @email VARCHAR(30)
WITH ENCRYPTION
AS
	IF @NIF is null OR @nome is null

	BEGIN

		PRINT 'The NIF and the Name cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Pessoa WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF already exists!', 14, 1)
	END


	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Person([NIF],[nome],[dataNasc], [email], [telefone], [dataNasc])
		VALUES (@NIF, @nome, @dataNasc, @email, @telefone, @dataNasc)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the person!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
