CREATE FUNCTION db.udf_prescricao_data_grid(@utente_NIF varchar(30) = null)
RETURNS @table TABLE ("N�mero de Prescri��o" int, "Data da Emiss�o" date, "C�digo de acesso de dispensa" int, "Medicamento" VARCHAR(30))

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@utente_NIF is not null)
		BEGIN
			INSERT @table SELECT Prescricao.num_prescricao, Prescricao.data, Prescricao.codigo_acesso_dispensa, Contem.nome_medicamento 
			FROM db.Prescricao, db.Contem WHERE  db.Prescricao.utente_NIF = @utente_NIF AND db.Contem.num_prescricao = Prescricao.num_prescricao;
		END;
RETURN;
END;