CREATE PROCEDURE db.sp_createCategoria

				@ID    		INT,
				@nome		VARCHAR(30)

WITH ENCRYPTION
AS
	IF @nome is null 

	BEGIN

		PRINT 'The Name cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(ID) FROM db.Categoria WHERE ID=@ID

	IF @count != 0
	BEGIN
		RAISERROR('The ID already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Categoria([ID],[nome])
		VALUES (@ID, @nome)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the categorys!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;
