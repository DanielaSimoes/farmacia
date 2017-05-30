--DROP FUNCTION db.udf_pres_med_por_vender
CREATE FUNCTION db.udf_pres_med_por_vender(@num_prescricao int)
RETURNS @table TABLE ("Name" varchar(30), "Lab" int, "Qty" int, "Validity" date, "Dose" int, "Category" int, "Type" int, "Code" int, "PVP" int, "Price" int, "IVA" int, "Prescription" int)

WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
	INSERT INTO @table
	SELECT Medicamento.nome, Medicamento.lab_id, E.Qty, Medicamento.validade, Medicamento.dose, Medicamento.categoria_id, Medicamento.tipo_id, Medicamento.codigo, Medicamento.PVP, Medicamento.preco, Medicamento.IVA, @num_prescricao FROM
	(db.Medicamento JOIN
	(
	SELECT A.name, A.lab_NIPC, (A.unidades-B.unidades) AS Qty FROM
	(SELECT Contem.nome_medicamento as 'name', Contem.lab_NIPC, Contem.unidades FROM db.Prescricao JOIN db.Contem ON db.Prescricao.num_prescricao=db.Contem.num_prescricao WHERE db.Prescricao.num_prescricao=@num_prescricao) AS A JOIN
	(SELECT  db.TemMV.nome, db.TemMV.lab_NIPC, db.TemMV.num_unidades as 'unidades' FROM (db.Prescricao JOIN db.Venda ON Prescricao.num_venda = db.Venda.num_venda) JOIN db.TemMV ON db.Prescricao.num_venda=db.TemMV.num_venda WHERE db.Prescricao.num_prescricao=@num_prescricao) AS B
	ON A.name=B.nome AND A.lab_NIPC=B.lab_NIPC
	UNION
	SELECT C.name, C.lab_NIPC, D.unidades FROM (
	(SELECT Contem.nome_medicamento as 'name', Contem.lab_NIPC FROM db.Prescricao JOIN db.Contem ON db.Prescricao.num_prescricao=db.Contem.num_prescricao WHERE db.Prescricao.num_prescricao=@num_prescricao)
	EXCEPT
	(SELECT  db.TemMV.nome as 'name', db.TemMV.lab_NIPC FROM (db.Prescricao JOIN db.Venda ON Prescricao.num_venda = db.Venda.num_venda) JOIN db.TemMV ON db.Prescricao.num_venda=db.TemMV.num_venda WHERE db.Prescricao.num_prescricao=@num_prescricao)
	) C JOIN (SELECT Contem.nome_medicamento as 'name', Contem.lab_NIPC, Contem.unidades FROM db.Prescricao JOIN db.Contem ON db.Prescricao.num_prescricao=db.Contem.num_prescricao WHERE db.Prescricao.num_prescricao=@num_prescricao) AS D ON C.name = D.name AND C.lab_NIPC = D.lab_NIPC
	) AS E ON db.Medicamento.nome = E.name AND db.Medicamento.lab_id=E.lab_NIPC)
RETURN
END;

