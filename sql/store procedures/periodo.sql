CREATE PROCEDURE db.sp_createPeriodo

				@ID        		    INT,
				@inicio    		    INT,
				@fim    		    INT,
				@dia_da_semana      INT,
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

	SELECT @count = count(ID) FROM db.Periodo WHERE ID=@ID

	IF @count != 0
	BEGIN
		RAISERROR('The ID already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Periodo([ID],[inicio],[fim],[dia_da_semana],[db_NIPC])
		VALUES (@ID, @inicio, @fim, @dia_da_semana, @db_NIPC)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the period!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
