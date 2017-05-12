CREATE FUNCTION db.udf_historico_meds_data_grid(@nif int = null)
RETURNS @table TABLE ("User NIF" int, "Employee NIF" int, "Date" date, "Sale number" int, "Medicine" varchar(30), "Lab" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@nif is null)
		BEGIN
			INSERT @table SELECT Venda.utente_NIF, Venda.func_NIF, Venda.data, Venda.num_venda, temmv.nome, temmv.lab_NIPC
			FROM db.venda LEFT OUTER JOIN db.prescricao ON db.venda.num_venda=db.prescricao.num_venda JOIN db.temmv ON db.venda.num_venda=db.temmv.num_venda WHERE db.prescricao.num_prescricao is null;
		END;
	ELSE
		BEGIN
            INSERT @table SELECT Venda.utente_NIF, Venda.func_NIF, Venda.data, Venda.num_venda, temmv.nome, temmv.lab_NIPC
            FROM db.venda LEFT OUTER JOIN db.prescricao ON db.venda.num_venda=db.prescricao.num_venda JOIN db.temmv ON db.venda.num_venda=db.temmv.num_venda WHERE db.prescricao.num_prescricao is null and db.venda.utente_NIF=@nif;
		END;
RETURN;
END;