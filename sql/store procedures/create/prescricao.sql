CREATE PROCEDURE db.sp_createPrescricao

				@num_prescricao			     INT,
				@codigo_acesso_dispensa       INT,
				@data                         DATE,
				@local                        VARCHAR(30),
				@codigo_opcao				 INT ,
				@validade                     DATE,
				@telefone                     INT ,
				@medico_NIF                   INT ,
				@utente_NIF                   INT ,
				@db_NIPC                      INT ,
				@data_processa				 DATE,
				@num_venda					 INT
              
WITH ENCRYPTION
AS
	IF @num_prescricao is null OR @codigo_acesso_dispensa is null OR @local is null OR @codigo_opcao is null OR @telefone is null OR @medico_NIF is null OR @utente_NIF is null
	OR @db_NIPC is null OR @num_venda is null  

	BEGIN

		PRINT 'The prescription number, codigo de acesso à dispensa, local, codigo de opcao, phone number, doctor NIF, Utente NIF, employee NIF, drugstore NIPC and sales number cannot be empty!'
		RETURN

	END

	DECLARE @count int
	SELECT @count = count(@num_prescricao) FROM db.Prescricao WHERE num_prescricao=@num_prescricao

	IF @count != 0
	BEGIN
		RAISERROR('The prescription number already exists!', 14, 1)
	END

	BEGIN TRANSACTION;

	BEGIN TRY

		INSERT INTO db.Prescricao([num_prescricao],[codigo_acesso_dispensa],[codigo_opcao],[data],[local],[data_processa],[validade],[telefone],[medico_NIF],[utente_NIF],[db_NIPC],[num_venda])
		VALUES (@num_venda, @codigo_acesso_dispensa,@codigo_opcao,@data,@local,@data_processa,@validade,@telefone,@medico_NIF,@utente_NIF,@db_NIPC,@num_venda)

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when creating the prescription!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;