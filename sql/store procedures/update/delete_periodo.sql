CREATE PROCEDURE db.sp_delete_periodo
                @ID_disponibilidade INT,
				@ID_periodo INT
WITH ENCRYPTION
AS
    BEGIN TRANSACTION;

	BEGIN TRY

		DELETE FROM db.Disponibilidade WHERE @ID_disponibilidade=ID;
		DELETE FROM db.Periodo WHERE @ID_periodo=ID;
		DELETE FROM db.TemPD WHERE @ID_disponibilidade=db.TemPD.disponibilidade_ID AND @ID_periodo=db.TemPD.periodo_ID;

	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('An error occurred when updating the user!', 14, 1)
	END CATCH;