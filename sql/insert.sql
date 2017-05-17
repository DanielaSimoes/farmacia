use farmacia;

INSERT INTO db.laboratorio VALUES (11111111, 'dani', 'lab', 'aveiro')
INSERT INTO db.farmacia VALUES (1, null, null, 'ala', 'aveiro', 'email')
INSERT INTO db.categoria VALUES (1, 'categoria');
INSERT INTO db.tipo VALUES (1, 'tipo');
INSERT INTO db.Medicamento VALUES ('benuron', 11111111, 2, '2018/7/7', 100, 15, 1, 1, 1010);
INSERT INTO db.Medicamento VALUES ('aspirina', 11111111, 2, '2018/7/7', 100, 15, 1, 1, 2020);

INSERT INTO db.pessoa VALUES (1999, 'danna', '1998/4/4', 'email', 9191)
INSERT INTO db.pessoa VALUES (1989, 'danna', null, null, null);
INSERT INTO db.pessoa VALUES (2000, 'func', null, null, null);

INSERT INTO db.utente VALUES ('agueda', 1, 1999);
INSERT INTO db.Medico VALUES ('ortopedia', 12, 1989);
INSERT INTO db.Funcionario VALUES ('func', 56, 'pass', 2000);

INSERT INTO db.Prescricao VALUES (10, 10, '2017/1/20', 'Agueda', 5, '2018/2/10', 912188210, 1989, 1999, 1, null, null)

INSERT INTO db.Vende VALUES (20, 21, 23, 'aspirina', 1, 11111111)
INSERT INTO db.Vende VALUES (19, 20, 23, 'benuron', 1, 11111111)

INSERT INTO db.Contem VALUES ('as', 'teste', 1, 'teste', 10, 'benuron', 11111111,1)
INSERT INTO db.Contem VALUES ('as', 'teste', 2, 'teste', 10, 'aspirina', 11111111,1)

INSERT INTO db.Periodo VALUES (8, 19, 'Monday',1);



