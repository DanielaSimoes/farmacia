CREATE PROCEDURE db.sp_createMedicamento

				@nome                VARCHAR(30),
				@lab_id              INT,
				@quantidade          INT,
				@validade            DATE,
				@dose                INT,
				@unidades            INT,
				@categoria_id        INT,
				@tipo_id             INT

WITH ENCRYPTION
AS
	IF @quantidade is null OR @dose is null OR @unidades is null OR @categoria_id is null OR @tipo_id is null 

	BEGIN

		PRINT 'The quantity, dosage, units, category_ID and type_ID cannot be empty!'
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


	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Medicamento([nome],[lab_id],[quantidade],[validade],[dose],[unidades],[categoria_id],[tipo_id])
		VALUES (@nome, @lab_id, @quantidade, @validade, @dose, @unidades, @categoria_id, @tipo_id)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the medicament!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
