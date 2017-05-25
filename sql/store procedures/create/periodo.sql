CREATE PROCEDURE db.sp_createPeriodo
				@inicio    		    INT,
				@fim    		    INT,
				@dia_da_semana      VARCHAR(30)

WITH ENCRYPTION
AS
	IF @inicio is null OR @fim is null OR @dia_da_semana is null

	BEGIN

		PRINT 'The begin, end, day of the week cannot be empty!'
		RETURN

	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Periodo ([inicio],
					 [fim],
					 [dia_da_semana])
		VALUES (@inicio, @fim, @dia_da_semana)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the period!', 14, 1)
	END CATCH;
