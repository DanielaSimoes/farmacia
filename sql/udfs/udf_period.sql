CREATE FUNCTION db.udf_period(@ID int)
RETURNS @table TABLE ("ID_dispo" INT, "ID_per" INT, "Disponibilidade" VARCHAR(30), "Begin" int, "End" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@ID is null)
		BEGIN
			INSERT @table SELECT Disponibilidade.ID, Periodo.ID, Disponibilidade.disponibilidade, Periodo.inicio, Periodo.fim
			FROM (db.Periodo JOIN db.TemPD ON db.Periodo.ID=db.TemPD.periodo_ID) JOIN db.Disponibilidade ON db.TemPD.disponibilidade_ID=db.Disponibilidade.ID
		END
	ELSE
		BEGIN
			INSERT @table SELECT  Disponibilidade.ID, Periodo.ID, Disponibilidade.disponibilidade, Periodo.inicio, Periodo.fim 
			FROM (db.Periodo JOIN db.TemPD ON db.Periodo.ID=db.TemPD.periodo_ID) JOIN db.Disponibilidade ON db.TemPD.disponibilidade_ID=db.Disponibilidade.ID
			WHERE db.Periodo.ID = @ID;
		END
RETURN;
END;