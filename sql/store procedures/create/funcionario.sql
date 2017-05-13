--DROP PROCEDURE db.sp_createFuncionario
CREATE PROCEDURE db.sp_createFuncionario

				@funcao			    VARCHAR(30),
				@num_funcionario	INT,
				@pass				VARCHAR(30),
				@NIF           		INT,
				@nome 				VARCHAR(30),
				@telefone 			INT = null,
                @dataNasc 			DATE = null,
                @email 				VARCHAR(30) = null

WITH ENCRYPTION
AS
	IF @NIF is null OR @funcao is null OR @num_funcionario is null OR @pass is null OR @nome is null

	BEGIN

		PRINT 'The NIF, the Name, the Function, the Employee number and the Password cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nif) FROM db.Funcionario WHERE nif=@NIF

	IF @count != 0
	BEGIN
		RAISERROR('The NIF as employee already exists!', 14, 1)
	END

	SELECT @count = count(num_funcionario) FROM db.Funcionario WHERE num_funcionario=@num_funcionario

	IF @count != 0
	BEGIN
		RAISERROR('The Employee number already exists!', 14, 1)
	END

	SELECT @count = count(NIF) FROM db.Pessoa WHERE NIF=@NIF

	IF @count = 0
	BEGIN
		SET XACT_ABORT ON; --> the only change
		BEGIN TRANSACTION;

		BEGIN TRY

			INSERT INTO [farmacia].[db].[Pessoa] VALUES (@NIF, @nome, @dataNasc, @email, @telefone)

			COMMIT TRANSACTION;

		END TRY

		BEGIN CATCH
			ROLLBACK TRANSACTION
			RAISERROR('An error occurred when creating the person!', 14, 1)
		END CATCH;
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [farmacia].[db].[Funcionario] VALUES (@funcao, @num_funcionario, @pass, @NIF)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the employee!', 14, 1)
	END CATCH;
