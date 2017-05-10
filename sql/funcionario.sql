CREATE PROCEDURE db.sp_createFuncionario

				@funcao			    VARCHAR(30),
				@num_funcionario	INT,
				@password			VARCHAR(30),
				@NIF           		INT

WITH ENCRYPTION
AS
	IF @NIF is null OR @funcao is null OR @num_funcionario is null OR @password is null

	BEGIN

		PRINT 'The NIF, the Function, the Employee number and the Password cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Funcionario WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF already exists!', 14, 1)
	END

	SELECT @count = count(num_funcionario) FROM db.Funcionario WHERE num_funcionario=@num_funcionario

	IF @count != 0
	BEGIN
		RAISERROR('The Employee number already exists!', 14, 1)
	END


	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Person([NIF],[funcao],[num_funcionario],[password])
		VALUES (@NIF, @funcao, @num_funcionario, @password)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the employee!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
