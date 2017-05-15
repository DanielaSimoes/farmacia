use farmacia;

-- Pessoa add
INSERT INTO db.Pessoa VALUES(2, 'Daniela', NULL, NULL, NULL);
-- Pessoa add
INSERT INTO db.Pessoa VALUES(19, 'Cristiana', '01/01/0100', 'cristiana@ua.pt', 1233);
-- Laboratorio add
INSERT INTO db.Laboratorio VALUES(3, 'lab@lab.pt', 'Lab', 'Aveiro');
-- Categoria add
INSERT INTO db.Categoria VALUES(4, 'Medicamento');
-- Tipo add
INSERT INTO db.Tipo VALUES(1, 'Medicamento');
-- Medicamento add
INSERT INTO db.Medicamento VALUES('Ben-u-ron', 1, 1, NULL, 9,3,4,1,3);
INSERT INTO db.Laboratorio VALUES(1, 'sjhdshd', 'skjsd', 'sjdfh');
INSERT INTO db.Categoria VALUES(4, 'sjhdshd');
INSERT INTO db.Tipo VALUES(1, 'sjhdshd');
-- Funcionario add
INSERT INTO db.Funcionario VALUES('direcao',1,'funcionario',2);
-- Fornecedor add
INSERT INTO db.Distribuidor VALUES(1,'Distribuidor XPTO', 234111111, 'Aveiro');

INSERT INTO db.Utente VALUES('xoxox', 1233, 19);

INSERT INTO db.Medico VALUES('xoxox', 1, 2);

INSERT INTO db.Prescricao VALUES(1,2,'10/10/2010', 'SJJJ', 2, '10/10/2018', 1233222, 2, 19, NULL, NULL, NULL);