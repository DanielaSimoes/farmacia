CREATE PROCEDURE db.sp_createPeriodo
				@id_periodo			INT,
				@inicio    		    INT,
				@fim    		    INT,
				@dia_da_semana      VARCHAR(30),
				@id_disponibilidade INT

WITH ENCRYPTION
AS
	IF @inicio is null OR @fim is null OR @dia_da_semana is null or @id_disponibilidade is null or @id_periodo is null
	BEGIN
		PRINT 'The begin, end, day of the week cannot be empty!'
		RETURN
	END

	BEGIN TRANSACTION;

	BEGIN TRY
		SET IDENTITY_INSERT db.Periodo ON 
		INSERT INTO db.Periodo ([ID],[inicio],
					 [fim],
					 [dia_da_semana])
		VALUES (@id_periodo, @inicio, @fim, @dia_da_semana)

		INSERT INTO db.TemPD
		VALUES (@id_periodo, @id_disponibilidade)
		SET IDENTITY_INSERT db.Periodo OFF


	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the period!', 14, 1)
	END CATCH;
