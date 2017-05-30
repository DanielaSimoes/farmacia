drop procedure db.sp_createPeriodo
CREATE PROCEDURE db.sp_createPeriodo
				@inicio    		    INT,
				@fim    		    INT,
				@dia_da_semana      VARCHAR(30),
				@id_disponibilidade INT

WITH ENCRYPTION
AS
	IF @inicio is null OR @fim is null OR @dia_da_semana is null or @id_disponibilidade is null
	BEGIN
		PRINT 'The begin, end, day of the week cannot be empty!'
		RETURN
	END
	DECLARE @ID int
	
	BEGIN TRANSACTION;

	BEGIN TRY
		
		INSERT INTO db.Periodo ([inicio],
					 [fim],
					 [dia_da_semana])
		VALUES (@inicio, @fim, @dia_da_semana)

		SELECT @ID=SCOPE_IDENTITY();

		INSERT INTO db.TemPD
		VALUES (@ID, @id_disponibilidade)


	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the period!', 14, 1)
	END CATCH;
