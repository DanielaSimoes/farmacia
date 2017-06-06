--DROP PROCEDURE db.sp_delete_periodo
CREATE PROCEDURE db.sp_delete_periodo
                @ID_disponibilidade INT,
				@ID_periodo INT
AS
    BEGIN TRANSACTION;

	BEGIN TRY

		DELETE FROM db.TemPD WHERE db.TemPD.disponibilidade_ID=@ID_disponibilidade AND db.TemPD.periodo_ID=@ID_periodo;
		DELETE FROM db.Periodo WHERE db.Periodo.ID=@ID_periodo;


	COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
		RAISERROR('An error occurred when deleting the period!', 14, 1)
		ROLLBACK TRANSACTION
	END CATCH;