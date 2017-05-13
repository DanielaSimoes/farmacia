CREATE PROCEDURE db.sp_createFarmacia

				@NIPC      		INT,
				@fax	        INT,
				@telefone		INT,
				@nome		    VARCHAR(30),
				@localizacao	VARCHAR(30),
				@email		    VARCHAR(30)

WITH ENCRYPTION
AS
	IF @nome is null OR @localizacao is null OR @email is null

	BEGIN

		PRINT 'The Name, email, location and cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(NIPC) FROM db.Farmacia WHERE NIPC=@NIPC

	IF @count != 0
	BEGIN
		RAISERROR('The NIPC already exists!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Farmacia([NIPC],[nome],[fax],[localizacao],[email],[telefone])
		VALUES (@NIPC, @nome, @fax, @localizacao, @email, @telefone)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the drugstore!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
