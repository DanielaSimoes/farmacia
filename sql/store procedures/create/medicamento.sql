CREATE PROCEDURE db.sp_createMedicamento

				@nome                VARCHAR(30),
				@lab_id              INT,
				@dose                INT,
				@categoria_id        INT,
				@tipo_id             INT,
				@codigo				 INT,
				@PVP				 FLOAT,
				@preco				 FLOAT,
				@IVA				 INT

WITH ENCRYPTION
AS
	IF @categoria_id is null OR @tipo_id is null OR @codigo is null OR @preco is null OR @PVP is null OR @IVA is null

	BEGIN

		PRINT 'The quantity, dosage, units, category_ID, type_ID, code, price, PVP and IVA cannot be empty!'
		RETURN

	END
	BEGIN
		BEGIN TRANSACTION;

		BEGIN TRY

			INSERT INTO db.Medicamento
			VALUES (@nome, @lab_id, @dose, @categoria_id, @tipo_id, @codigo, @PVP, @preco, @IVA)

		COMMIT TRANSACTION;

		END TRY


	BEGIN CATCH
		RAISERROR('An error occurred when creating the medicament!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
	END