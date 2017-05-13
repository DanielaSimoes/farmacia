CREATE FUNCTION db.udf_prescricao_data_grid(@utente_NIF varchar(30) = null)
RETURNS @table TABLE ("Número de Prescrição" int, "Data da Emissão" date)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@utente_NIF is not null)
		BEGIN
			INSERT @table SELECT Prescricao.num_prescricao, Prescricao.data
			FROM db.Prescricao WHERE  farmacia.db.Prescricao.utente_NIF = @utente_NIF;
		END;
RETURN;
END;