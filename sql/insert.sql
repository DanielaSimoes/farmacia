--Pessoa
INSERT INTO db.pessoa VALUES (55771105, 'Vasco Santos', '1998/4/4', 'vasco@ua.pt', 919191919);
INSERT INTO db.pessoa VALUES (55771103, 'Carla Santos', '1993/5/6', 'cs@ua.pt', 919191913);
INSERT INTO db.pessoa VALUES (55771102, 'Albertino Fonseca', '1970/4/4', null, 919191000);
INSERT INTO db.pessoa VALUES (55741105, 'Eduardo Silva', '1992/4/6', 'eduardo@ua.pt', 919191918);

--Funcion�rio
INSERT INTO db.Funcionario VALUES ('func', 1, 'pass', 55771105);

-- MEDICO
INSERT INTO db.Medico VALUES ('Ortopedia', 123, 55771103);

--Utente
INSERT INTO db.utente VALUES ('Agueda', 1, 55771102);
INSERT INTO db.utente VALUES ('Aveiro', 2, 55741105);

--Laborat�rio
INSERT INTO db.laboratorio VALUES (11111111, 'lab@hotmail.com', 'Lab1', 'Aveiro');
INSERT INTO db.laboratorio VALUES (11111112, 'lab2@hotmail.com', 'Lab2', 'Viseu');
INSERT INTO db.laboratorio VALUES (11111113, 'lab3@hotmail.com', 'Lab3', 'Guarda');
INSERT INTO db.laboratorio VALUES (11111114, 'lab4@hotmail.com', 'Lab4', 'Guarda');
INSERT INTO db.laboratorio VALUES (11111115, 'lab5@hotmail.com', 'Lab5', 'Guarda');
INSERT INTO db.laboratorio VALUES (11111116, 'lab6@hotmail.com', 'Lab6', 'Guarda');


--Categoria
INSERT INTO db.categoria VALUES (1, 'Anti-inflamat�rio');
INSERT INTO db.categoria VALUES (2, 'Analg�sico');
INSERT INTO db.categoria VALUES (3, 'Suplemento Alimentar');

--Tipo
INSERT INTO db.tipo VALUES (1, 'Creme');
INSERT INTO db.tipo VALUES (2, 'Comprimido');
INSERT INTO db.tipo VALUES (3, 'C�psula');
INSERT INTO db.tipo VALUES (4, 'Amp�la');

--Periodo
INSERT INTO db.Periodo VALUES (1, 8, 19, 'Monday');
INSERT INTO db.Periodo VALUES (2, 19, 23, 'Tuesday');

--Disponibilidade
INSERT INTO db.Disponibilidade VALUES ('Available');
INSERT INTO db.Disponibilidade VALUES ('Unavailable');

--TemPD
INSERT INTO db.TemPD VALUES(1,2);
INSERT INTO db.TemPD VALUES(2,2);

--Medicamento
INSERT INTO db.Medicamento VALUES ('Brufen', 11111114, 100, '2018/7/7', 2, 100, 2, 2, 1010, 2, 4, 5);
INSERT INTO db.Medicamento VALUES ('Aspirina', 11111115, 100, '2018/7/7', 2, 100, 2, 2, 2020, 3, 5, 5);
INSERT INTO db.Medicamento VALUES ('Ben-u-ron', 11111116, 100, '2018/7/7', 2, 100, 2, 2, 2021, 2, 6, 5);

--Prescri��o
INSERT INTO db.Prescricao VALUES (1, 10, '2017/1/20', 'Agueda', 5, '2018/2/10', 912188210, 55771103, 55771102, null, null);

--Cont�m
INSERT INTO db.Contem VALUES ('Comprimido', 'Comprimido', 1, '1 por dia', 1, 'Brufen', 11111111,1);
INSERT INTO db.Contem VALUES ('Comprimido', 'Comprimido', 1, '2 por dia', 1, 'Aspirina', 11111111,1);




