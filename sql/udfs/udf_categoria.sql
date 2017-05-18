CREATE FUNCTION db.categoria_data_grid(@code INT = null, @name varchar(30) = null)
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
		    FROM db.Medicamento WHERE db.Medicamento.categoria_id = @code;
		END;
	ELSE
    	BEGIN
            DECLARE @categoria INT;
            SELECT @categoria = db.categoria.id FROM db.categoria WHERE db.categoria.nome LIKE SUBSTRING(@name,1,3) + '%'

    		INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.codigo
    		FROM db.Medicamento WHERE db.Medicamento.categoria_id = @categoria;
    	END;

RETURN;
END;