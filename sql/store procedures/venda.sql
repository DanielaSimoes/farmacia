CREATE PROCEDURE db.sp_createVenda

				@pontos	               	INT,			
				@utente_NIF		        INT,			
				@func_NIF               INT,			
				@data                   Date, 
				@num_venda              INT
              
WITH ENCRYPTION
AS
	IF @pontos is null OR @utente_NIF is null OR @func_NIF is null OR @data is null OR @num_venda is null  

	BEGIN

		PRINT 'The points, Utente_NIF, employee NIF, date and sales number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(num_venda) FROM db.Venda WHERE num_venda=@num_venda

	IF @count != 0
	BEGIN
		RAISERROR('The sales number already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Venda([pontos],[utente_NIF],[func_NIF],[data],[num_venda])
		VALUES (@pontos, @utente_NIF,@func_NIF,@data,@num_venda)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the sale!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;