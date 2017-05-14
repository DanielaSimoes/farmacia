CREATE PROCEDURE db.sp_processPurchase
				@codigo				 INT,
				@func_NIF			 INT,
				@num_prescricao INT = null
AS
	IF @codigo is null

	BEGIN
		PRINT 'The code cannot be empty!'
		RETURN
	END

	DECLARE @count int

	-- verificar se o medicamento existe pelo codigo
	SELECT @count = count(codigo) FROM db.medicamento WHERE codigo = @codigo;

	IF @count = 0
	BEGIN
		RAISERROR ('The code that you provided do not exists!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;

	DECLARE @units int

	-- verificar se existe stock
	SELECT @units = unidades FROM db.medicamento WHERE codigo = @codigo;

	IF @units = 0
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('No stock!', 14, 1)
		RETURN
	END

	-- se tiver prescription, verificar o numero de Prescription existe

	DECLARE @num int, @med int, @unidades_med int, @lab_NIPC int, @num_unidades_vendidas int, @unidades_em_falta int, @NIF int, @num_venda int
	DECLARE @data date
	DECLARE @nome varchar(30)
	DECLARE @today date = GETDATE();
	SET @num_unidades_vendidas=0

	IF @num_prescricao is not null
	BEGIN
		SELECT @num = COUNT(num_prescricao) FROM db.Prescricao WHERE num_prescricao = @num_prescricao;
		IF @num = 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The prescription number that you provided do not exists!', 14, 1)
			RETURN
		END

		SELECT @data = data_processa FROM db.Prescricao WHERE num_prescricao = @num_prescricao;

		IF @data is not null
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The prescription already have been processed!', 14, 1)
			RETURN
		END

		SELECT @nome = nome FROM db.Medicamento WHERE codigo = @codigo;
		SELECT @lab_NIPC = lab_id FROM db.Medicamento WHERE codigo = @codigo;

		SELECT @med = COUNT(nome_medicamento) FROM db.Contem WHERE num_prescricao = @num_prescricao AND nome_medicamento=@nome AND lab_NIPC=@lab_NIPC;

		IF @med = 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The medicine does not exist in the prescription!', 14, 1)
			RETURN
		END

		-- unidades que estão na prescrição
		SELECT @unidades_med = unidades FROM db.Contem WHERE num_prescricao = @num_prescricao AND nome_medicamento=@nome AND lab_NIPC=@lab_NIPC;
		-- verificar se já foram vendidas todas as unidades da prescrição
		SELECT @num_unidades_vendidas=TemMV.num_unidades FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
				JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
				WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=@nome AND TemMV.lab_NIPC=@lab_NIPC;

		-- no caso de já terem sido vendidos todos
		SET @unidades_em_falta = @unidades_med - @num_unidades_vendidas
		IF @unidades_em_falta = 0
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('The medicine cannot be sold because all these type of medicine was already sold!', 14, 1)
			RETURN
		END

		-- NIF do utente
		SELECT @NIF = utente_NIF FROM db.Prescricao WHERE num_prescricao = @num_prescricao;

		-- verificar se existe numero de venda
		SELECT @num_venda = num_venda FROM db.Prescricao WHERE num_prescricao=@num_prescricao;

		IF @num_venda IS NULL
		BEGIN
			INSERT INTO db.Venda ([pontos], [utente_NIF], [func_NIF], [data]) VALUES (1, @NIF, @func_NIF, @today);
			SELECT @num_venda=SCOPE_IDENTITY();
		END

		-- no caso de ainda não ter sido vendido nenhuma
		IF @num_unidades_vendidas = 0
			BEGIN
				INSERT INTO db.TemMV VALUES(@nome, @num_venda, 1, @lab_NIPC);
				UPDATE db.Prescricao SET num_venda = @num_venda WHERE num_prescricao=@num_prescricao;
			END
		ELSE
			BEGIN
				SET @num_unidades_vendidas = @num_unidades_vendidas + 1;
				UPDATE db.TemMV SET num_unidades=@num_unidades_vendidas WHERE nome=@nome AND lab_NIPC=@lab_NIPC AND num_venda=@num_venda;
			END

		-- ADICIONAR A DATA
	    DECLARE db_cursor CURSOR FOR SELECT Contem.nome_medicamento as nome, Contem.lab_NIPC, Contem.unidades as num_unidades FROM db.Contem WHERE db.Contem.num_prescricao=@num_prescricao
	    DECLARE @nome VARCHAR(30);
	    DECLARE @lab_NIPC INT;
	    DECLARE @num_unidades INT;
	    DECLARE @num_unidades_vendidas INT;
		DECLARE @ha_medicamento BIT;
		SET @nao_ha_medicamento_por_vender = 1 /* true */


	    OPEN db_cursor;
	    FETCH NEXT FROM db_cursor INTO @nome, @lab_NIPC, @num_unidades;
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	            -- verificar se ja esta vendido o medicamento
	            SELECT @count = count(*) FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
	                    JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
	                    WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=@nome AND TemMV.lab_NIPC=@lab_NIPC;

	            IF @count = 1
	                BEGIN
	                    -- verificar se a quantidade corresponde
	                    SELECT @num_unidades_vendidas=TemMV.num_unidades FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
	                            JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
	                            WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=@nome AND TemMV.lab_NIPC=@lab_NIPC;

	                    SET @num_unidades = @num_unidades - @num_unidades_vendidas

	                    IF @num_unidades != 0
	                        BEGIN
								SET @nao_ha_medicamento_por_vender = 0 /* false */
	                        END
	                END
	            ELSE
	                BEGIN
						SET @nao_ha_medicamento_por_vender = 0 /* false */
					END
	            FETCH NEXT FROM db_cursor INTO @nome, @lab_NIPC, @num_unidades;
	    END;
	    CLOSE db_cursor;
	    DEALLOCATE db_cursor;

		IF @nao_ha_medicamento_por_vender
		BEGIN
			UPDATE db.Prescricao SET data_processa = @today WHERE num_prescricao=@num_prescricao;
		END
	END

	BEGIN TRY
		SET @units = @units - 1;
		UPDATE  [farmacia].[db].[Medicamento] SET
				unidades = @units
		WHERE codigo = @codigo;

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when updating the medicament!', 14, 1)
	END CATCH;