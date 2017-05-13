CREATE PROCEDURE db.sp_modifyPessoa
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

	IF @count = 0
	BEGIN
		RAISERROR('The NIF does not exists!', 14, 1)
	END

    BEGIN TRANSACTION;

	BEGIN TRY

        UPDATE  [farmacia].[db].[Pessoa] SET
                nome = @nome,
                dataNasc = @dataNasc,
                email= @email,
                telefone = @telefone
        WHERE NIF=@NIF

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when updating the user!', 14, 1)
	END CATCH;