CREATE PROCEDURE db.sp_createPeriodo
				@inicio    		    INT,
				@fim    		    INT,
				@dia_da_semana      VARCHAR(30),
				@db_NIPC            INT

WITH ENCRYPTION
AS
	IF @inicio is null OR @fim is null OR @dia_da_semana is null OR @db_NIPC is null

	BEGIN

		PRINT 'The begin, end, day of the week and NIPC cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(db_NIPC) FROM db.Periodo WHERE db_NIPC=@db_NIPC

	IF @count != 0
	BEGIN
		RAISERROR('The NIPC already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO [farmacia].[db].[Periodo] ([inicio],
					 [fim],
					 [dia_da_semana],
					 [db_NIPC])
		VALUES (@inicio, @fim, @dia_da_semana, @db_NIPC)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when creating the period!', 14, 1)
	END CATCH;
