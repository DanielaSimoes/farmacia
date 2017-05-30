CREATE FUNCTION db.udf_historico_pres_data_grid(@nif int = null)
RETURNS @table TABLE ("Prescription number" int, "Access code and dispense" int, "Date" date, "Local" varchar(30), "Option Code" int, "Validity" date, "Phone" int, "Doctor NIF" int, "User NIF" int, "Sale Date" date, "Sale number" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nif is null)
		BEGIN
			INSERT @table SELECT Prescricao.num_prescricao, Prescricao.codigo_acesso_dispensa, Prescricao.data, Prescricao.local, Prescricao.codigo_opcao, Prescricao.validade, Prescricao.telefone, Prescricao.medico_NIF, Prescricao.utente_NIF, Prescricao.data_processa, Prescricao.num_venda
			FROM db.Prescricao WHERE db.Prescricao.data_processa = NULL;
		END;
	ELSE
		BEGIN
            INSERT @table SELECT Prescricao.num_prescricao, Prescricao.codigo_acesso_dispensa, Prescricao.data, Prescricao.local, Prescricao.codigo_opcao, Prescricao.validade, Prescricao.telefone, Prescricao.medico_NIF, Prescricao.utente_NIF, Prescricao.data_processa, Prescricao.num_venda
            FROM db.Prescricao WHERE db.Prescricao.utente_NIF = @nif AND db.Prescricao.data_processa = NULL;
		END;
RETURN;
END;