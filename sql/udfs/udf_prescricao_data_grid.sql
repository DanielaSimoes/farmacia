CREATE FUNCTION db.udf_prescricao_data_grid(@utente_NIF int)
RETURNS @table TABLE ("Prescription number" int, "Date" date, "Code" int, "Expires at" date)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
		INSERT @table SELECT Prescricao.num_prescricao, Prescricao.data, Prescricao.codigo_acesso_dispensa, Prescricao.validade
		FROM db.Prescricao WHERE db.Prescricao.utente_NIF = @utente_NIF AND db.Prescricao.data_processa is NULL;
RETURN;
END;