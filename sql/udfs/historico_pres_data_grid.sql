CREATE FUNCTION db.udf_historico_pres_data_grid(@nif int = null)
RETURNS @table TABLE ("Nº Prescrição" int, "Código Acesso e Dispensa" int, "Data" date, "Local" varchar(30), "Código Opção" int, "Validade" date, "Telefone" int, "Médico NIF" int, "Utente NIF" int, "Data Levantamento" date, "Número de Venda" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nif is null)
		BEGIN
			INSERT @table SELECT Prescricao.num_prescricao, Prescricao.codigo_acesso_dispensa, Prescricao.data, Prescricao.local, Prescricao.codigo_opcao, Prescricao.validade, Prescricao.telefone, Prescricao.medico_NIF, Prescricao.utente_NIF, Prescricao.data_processa, Prescricao.num_venda
			FROM db.Prescricao;
		END;
	ELSE
		BEGIN
            INSERT @table SELECT Prescricao.num_prescricao, Prescricao.codigo_acesso_dispensa, Prescricao.data, Prescricao.local, Prescricao.codigo_opcao, Prescricao.validade, Prescricao.telefone, Prescricao.medico_NIF, Prescricao.utente_NIF, Prescricao.data_processa, Prescricao.num_venda
            FROM db.Prescricao WHERE db.Prescricao.utente_NIF = @nif;
		END;
RETURN;
END;