CREATE FUNCTION db.udf_prescricao_utente(@num_prescricao int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
    DECLARE db_cursor CURSOR FOR SELECT  Contem.nome_medicamento as nome, Contem.lab_NIPC, Contem.unidades as num_unidades FROM db.Contem WHERE db.Contem.num_prescricao=@num_prescricao
    DECLARE @nome VARCHAR(30);
    DECLARE @lab_NIPC INT;
    DECLARE @num_unidades INT;
    DECLARE @num_unidades_vendidas INT;
    DECLARE @count INT;

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @nome, @lab_NIPC, @num_unidades;
    WHILE @@FETCH_STATUS = 0
    BEGIN
            -- verificar se ja esta vendido o medicamento
            SELECT @count = count(*) FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
                    JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
                    WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=@nome AND TemMV.lab_NIPC=@lab_NIPC;

            IF @count = 1
                BEGIN
                    -- verificar se a quantidade corresponde
                    SELECT @num_unidades_vendidas=TemMV.num_unidades FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
                            JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
                            WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=@nome AND TemMV.lab_NIPC=@lab_NIPC;

                    SET @num_unidades = @num_unidades - @num_unidades_vendidas

                    IF @num_unidades != 0
                        BEGIN
                            DECLARE @cnt INT = 0;

                            WHILE @cnt < @num_unidades
                            BEGIN
                                INSERT @table SELECT  Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Vende.PVP, Vende.Preco, Vende.IVA, @num_prescricao
                                FROM (db.Vende JOIN db.Medicamento ON db.Vende.medicamento_nome=db.Medicamento.nome
                                    AND db.Vende.lab_NIPC=db.Medicamento.lab_id) JOIN db.Contem
                                    ON db.Contem.nome_medicamento=db.Medicamento.nome
                                    AND db.Contem.lab_NIPC=db.Medicamento.lab_id
                                    WHERE db.Contem.num_prescricao=@num_prescricao AND Medicamento.nome=@nome AND Medicamento.lab_id=@lab_NIPC;

                                SET @cnt = @cnt + 1;
                            END;
                        END
                END
            ELSE
                BEGIN
                    -- nao foi vendido, inserir no resultado
                    INSERT @table SELECT  Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Vende.PVP, Vende.Preco, Vende.IVA, @num_prescricao
                    FROM (db.Vende JOIN db.Medicamento ON db.Vende.medicamento_nome=db.Medicamento.nome
                        AND db.Vende.lab_NIPC=db.Medicamento.lab_id) JOIN db.Contem
                        ON db.Contem.nome_medicamento=db.Medicamento.nome
                        AND db.Contem.lab_NIPC=db.Medicamento.lab_id
                        WHERE db.Contem.num_prescricao=@num_prescricao AND Medicamento.nome=@nome AND Medicamento.lab_id=@lab_NIPC;
                END
            FETCH NEXT FROM db_cursor INTO @nome, @lab_NIPC, @num_unidades;
    END;
    CLOSE db_cursor;
    DEALLOCATE db_cursor;
RETURN;
END;