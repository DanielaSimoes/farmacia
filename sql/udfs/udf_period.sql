CREATE FUNCTION db.udf_period(@ID int)
RETURNS @table TABLE ("Begin" int, "End" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
	IF (@ID is null)
		BEGIN
			INSERT @table SELECT Periodo.inicio, Periodo.fim
			FROM db.Periodo;
		END
	ELSE
		BEGIN
			INSERT @table SELECT Periodo.inicio, Periodo.fim
			FROM db.Periodo WHERE db.Periodo.ID = @ID;
		END
RETURN;
END;