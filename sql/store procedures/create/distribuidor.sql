CREATE PROCEDURE db.sp_createDistribuidor

				@NIPC      		INT,
				@nome    		VARCHAR(30),
				@telefone		INT,
				@morada    		VARCHAR(30)

WITH ENCRYPTION
AS
	IF @nome is null OR @telefone is null 

	BEGIN

		PRINT 'The Name and phone number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(NIPC) FROM db.Distribuidor WHERE NIPC=@NIPC

	IF @count != 0
	BEGIN
		RAISERROR('The NIPC already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Distribuidor([NIPC],[nome],[telefone],[morada])
		VALUES (@NIPC, @nome, @telefone, @morada)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the distributor!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
