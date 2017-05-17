CREATE FUNCTION db.tipo_data_grid(@code INT = null, @name varchar(30) = null)
RETURNS @table TABLE ("Name" varchar(30), "Lab NIPC" int, "Code" int)

WITH SCHEMABINDING, ENCRYPTION
AS

BEGIN
    IF (@code is null and @name is null)
    -- list all meds
    BEGIN
        INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.codigo
        FROM db.Medicamento;
    END

	IF (@name is null)
		BEGIN
			INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.codigo
		    FROM db.Medicamento WHERE db.Medicamento.tipo_id = @code;
		END;
	ELSE
    	BEGIN
            DECLARE @tipo INT;
            SELECT @tipo = db.tipo.id FROM db.tipo WHERE db.tipo.nome LIKE SUBSTRING(@name,1,3) + '%'

    		INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.codigo
    		FROM db.Medicamento WHERE db.Medicamento.tipo_id = @tipo;
    	END;

RETURN;
END;