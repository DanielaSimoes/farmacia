CREATE PROCEDURE db.sp_createMedicamento

				@nome                VARCHAR(30),
				@lab_id              INT,
				@quantidade          INT,
				@validade            DATE,
				@dose                INT,
				@unidades            INT,
				@categoria_id        INT,
				@tipo_id             INT,
				@codigo				 INT

WITH ENCRYPTION
AS
	IF @quantidade is null OR @dose is null OR @unidades is null OR @categoria_id is null OR @tipo_id is null OR @codigo is null

	BEGIN

		PRINT 'The quantity, dosage, units, category_ID, type_ID and code cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(nome) FROM db.Medicamento WHERE nome=@nome

	IF @count != 0
	BEGIN
		RAISERROR('The Name already exists!', 14, 1)
	END

	SELECT @count = count(lab_id) FROM db.Medicamento WHERE lab_id=@lab_id

	IF @count != 0
	BEGIN
		RAISERROR('The LAB ID already exists!', 14, 1)
	END

	SELECT @count = count(codigo) FROM db.Medicamento WHERE codigo=@codigo

	IF @count != 0
	BEGIN
		RAISERROR('The code already exists!', 14, 1)
	END


	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [farmacia].[db].[Medicamento]
		VALUES (@nome, @lab_id, @quantidade, @validade, @dose, @unidades, @categoria_id, @tipo_id, @codigo)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the medicament!', 14, 1)
	END CATCH;


CREATE PROCEDURE db.sp_modifyMedicamento
				
				@nome                VARCHAR(30),
				@lab_id              INT,
				@quantidade          INT,
				@validade            DATE,
				@dose                INT,
				@unidades            INT,
				@categoria_id        INT,
				@tipo_id             INT,
				@codigo				 INT

WITH ENCRYPTION
AS 
	IF @quantidade is null OR @dose is null OR @unidades is null OR @categoria_id is null OR @tipo_id is null OR @codigo is null

	BEGIN

		PRINT 'The quantity, dosage, units, category_ID, type_ID and code cannot be empty!'
		RETURN

	END
	
	DECLARE @count int

	-- verificar se o medicamento existe pelo código
	SELECT @count = count(codigo) FROM db.medicamento WHERE codigo = @codigo;

	IF @count = 0
	BEGIN
		RAISERROR ('The code that you provided do not exists!', 14, 1)
		RETURN
	END

	-- verificar se existe stock
	SELECT @quantidade FROM db.medicamento WHERE codigo = @codigo;

	IF @count = 0
	BEGIN
		RAISERROR ('No stock!', 14, 1)
		RETURN
	END

	BEGIN TRY
		UPDATE  [farmacia].[db].[Medicamento] SET
				quantidade = @quantidade
		WHERE codigo = @codigo;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error occurred when updating the medicaments!', 14, 1)
	END CATCH;
