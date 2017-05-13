CREATE PROCEDURE db.sp_createLaboratorio

				@NIPC      		INT,
				@email	    	VARCHAR(30),
				@nome		    VARCHAR(30),
				@localizacao	VARCHAR(30)

WITH ENCRYPTION
AS
	IF @email is null OR @nome is null OR @localizacao is null

	BEGIN

		PRINT 'The email, name, and location cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(NIPC) FROM db.Laboratorio WHERE NIPC=@NIPC

	IF @count != 0
	BEGIN
		RAISERROR('The NIPC already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Laboratorio([NIPC],[email],[nome],[localizacao])
		VALUES (@NIPC, @email, @nome, @localizacao)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the LAB!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
