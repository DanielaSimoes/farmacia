CREATE FUNCTION db.udf_verificar_prescricao(@num_prescricao int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Units" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
    DECLARE @count INT;
	DECLARE @num_unidades_vendidas INT;
	DECLARE @num_unidades INT;
    BEGIN
            -- verificar se ja esta vendido o medicamento
            SELECT @count = count(*) FROM (SELECT Contem.nome_medicamento as nome, Contem.lab_NIPC as lab_NIPC, Contem.unidades as num_unidades FROM db.Contem
					JOIN (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda) ON db.TemMV.lab_NIPC=db.Contem.lab_NIPC
                    JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
                    WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=Contem.nome_medicamento AND TemMV.lab_NIPC=db.Contem.lab_NIPC) AS cont;

            IF @count = 0
                BEGIN
                    -- nao foi vendido, inserir no resultado
                    INSERT @table SELECT Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, @num_prescricao
                    FROM db.Medicamento JOIN db.Contem ON db.Contem.nome_medicamento=db.Medicamento.nome AND db.Contem.lab_NIPC=db.Medicamento.lab_id
                    WHERE db.Contem.num_prescricao=@num_prescricao AND Medicamento.nome=Contem.nome_medicamento AND Medicamento.lab_id=Contem.lab_NIPC;
                END
			ELSE
				BEGIN
                    -- verificar se a quantidade corresponde
                    SELECT @num_unidades_vendidas=TemMV.num_unidades FROM (db.TemMV JOIN db.Venda ON db.TemMV.num_venda=db.Venda.num_venda)
                            JOIN db.Prescricao ON db.Venda.num_venda=db.Prescricao.num_venda
                            WHERE db.Prescricao.num_prescricao=@num_prescricao AND TemMV.nome=nome AND TemMV.lab_NIPC=lab_NIPC;

                    SET @num_unidades = @num_unidades - @num_unidades_vendidas

                    IF @num_unidades != 0
                        BEGIN
                            DECLARE @cnt INT = 0;

                            WHILE @cnt < @num_unidades
                            BEGIN
                                INSERT @table SELECT  Medicamento.nome, Medicamento.lab_id, Medicamento.quantidade, Medicamento.validade, Medicamento.dose, Medicamento.unidades, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.Preco, Medicamento.IVA, @num_prescricao
                                FROM db.Medicamento JOIN db.Contem ON db.Contem.nome_medicamento=db.Medicamento.nome AND db.Contem.lab_NIPC=db.Medicamento.lab_id
                                WHERE db.Contem.num_prescricao=@num_prescricao AND Medicamento.nome=nome AND Medicamento.lab_id=lab_NIPC;

                                SET @cnt = @cnt + 1;
                            END;
                        END
                END
    END;
RETURN;
END;
