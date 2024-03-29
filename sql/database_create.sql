go
CREATE SCHEMA db;
go
CREATE TABLE db.Prescricao(
		num_prescricao			     INT NOT NULL,
        codigo_acesso_dispensa       INT NOT NULL,
        data                         DATE NOT NULL,
        local                        VARCHAR(30) NOT NULL,
        codigo_opcao				 INT NOT NULL,
        validade                     DATE NOT NULL,
        telefone                     INT NOT NULL,
        medico_NIF                   INT NOT NULL,
        utente_NIF                   INT NOT NULL,
        data_processa				 DATE,
        num_venda					 INT,
		PRIMARY KEY(num_prescricao),
		Check(num_prescricao>=0), Check(codigo_acesso_dispensa>=0), Check(codigo_opcao>=0), Check(medico_NIF>=0), Check(utente_NIF>=0)
);

CREATE TABLE db.Pessoa(
		NIF	          	INT NOT NULL,
		nome			VARCHAR(30) NOT NULL,
		dataNasc		DATE,
		email     		VARCHAR(30),
        telefone        INT,
		PRIMARY KEY (NIF),
		Check(NIF>=0)
);

CREATE TABLE db.Funcionario(
		funcao			    VARCHAR(30) NOT NULL,
		num_funcionario		INT UNIQUE NOT NULL,
		password			VARCHAR(30) NOT NULL,
		NIF           		INT NOT NULL CHECK(NIF>=0),
		PRIMARY KEY(NIF)
);

CREATE TABLE db.Utente(
        morada			    VARCHAR(30),
        num_utente  		INT UNIQUE NOT NULL,
        NIF           		INT NOT NULL CHECK(NIF>=0),
        PRIMARY KEY(NIF)
);

CREATE TABLE db.Medico(
        especialidade	    VARCHAR(30) NOT NULL,
        numSNS      		INT UNIQUE NOT NULL,
        NIF           		INT NOT NULL CHECK(NIF>=0),
        PRIMARY KEY(NIF)
);

CREATE TABLE db.Medicamento(
		nome                VARCHAR(30),
        lab_id              INT,
        dose                INT NOT NULL CHECK(dose>=0),
        categoria_id        INT NOT NULL CHECK(categoria_id>=0),
        tipo_id             INT NOT NULL CHECK(tipo_id>=0),
		codigo				INT UNIQUE NOT NULL,
		PVP					FLOAT NOT NULL,
		preco				FLOAT NOT NULL,
		IVA					INT NOT NULL,
        PRIMARY KEY(nome,lab_id)
);

CREATE TABLE db.Laboratorio(
		NIPC      		INT,
		email	    	VARCHAR(30)	NOT NULL,
        nome		    VARCHAR(30)	NOT NULL,
		localizacao		VARCHAR(30)	NOT NULL,
		PRIMARY KEY(NIPC)
);

CREATE TABLE db.Ingredientes(
		ID        		INT,
		nome      		VARCHAR(30)	NOT NULL,
		PRIMARY KEY(ID)
);

CREATE TABLE db.Distribuidor(
        NIPC      		INT,
		nome    		VARCHAR(30)	NOT NULL,
		telefone		INT			NOT NULL,
		morada    		VARCHAR(30),
		PRIMARY KEY(NIPC)
);

CREATE TABLE db.Categoria(
		ID    		INT,
		nome		VARCHAR(30)	NOT NULL,
		PRIMARY KEY(ID)
);

CREATE TABLE db.Tipo(
        ID    		INT,
        nome		VARCHAR(30)	NOT NULL,
        PRIMARY KEY(ID)

);

CREATE TABLE db.Periodo(
		ID        		    INT IDENTITY,
		inicio    		    INT			NOT NULL,
        fim    		        INT			NOT NULL,
        dia_da_semana       VARCHAR(30)	NOT NULL,
		PRIMARY KEY(ID)
);

CREATE TABLE db.Disponibilidade(
        ID        		    INT,
        disponibilidade     VARCHAR(30)	NOT NULL,
        PRIMARY KEY(ID)
);

CREATE TABLE db.TemPD(
		periodo_ID		    INT,
		disponibilidade_ID	INT,
		PRIMARY KEY(periodo_ID,disponibilidade_ID)
);

CREATE TABLE db.Contem(
		forma_farmaceutica		VARCHAR(30)	NOT NULL,
		embalagem		        VARCHAR(30)	NOT NULL,
		dosagem		            INT	NOT NULL,
        posologia               VARCHAR(30)	NOT NULL,
        num_prescricao          INT	NOT NULL,
        nome_medicamento        VARCHAR(30)	NOT NULL,
        lab_NIPC                INT	NOT NULL,
		unidades				INT DEFAULT 1,
		PRIMARY KEY(nome_medicamento,num_prescricao,lab_NIPC)
);

CREATE TABLE db.Venda(
		pontos	               	INT			NOT NULL,
		utente_NIF		        INT			NOT NULL,
        func_NIF                INT			NOT NULL,
        data                    Date NOT NULL,
        num_venda               INT IDENTITY,
		PRIMARY KEY(num_venda)
);

CREATE TABLE db.AIM(
		distribuidor_NIPC		INT			NOT NULL,
		lab_NIPC                INT			NOT NULL,
		medicamento_nome		VARCHAR(30)	NOT NULL,
		PRIMARY KEY(distribuidor_NIPC,lab_NIPC,medicamento_nome)
);


CREATE TABLE db.Formula(
		ingrediente_ID    		INT			NOT NULL,
		lab_NIPC		        INT			NOT NULL,
		medicamento_nome		VARCHAR(30)	NOT NULL,
		PRIMARY KEY(ingrediente_ID,lab_NIPC,medicamento_nome)
);

CREATE TABLE db.TemMV(
		nome		    	VARCHAR(30)	NOT NULL,
		num_venda			INT			NOT NULL,
		num_unidades		INT			NOT NULL,
		lab_NIPC			INT			NOT NULL,

		PRIMARY KEY(nome,num_venda,lab_NIPC)
);

CREATE TABLE db.Lotes(
		id				INT IDENTITY NOT NULL,
		nome_med		VARCHAR(30) NOT NULL,
		lab_id			INT NOT NULL,
		quantidade		INT NOT NULL,
		validade		DATE NOT NULL

		PRIMARY KEY(id)

);


-- FOREIGN KEY:

-- Prescri��o
ALTER TABLE db.Prescricao ADD CONSTRAINT MEDICO_NIF FOREIGN KEY(medico_NIF) REFERENCES db.Medico(NIF) ON UPDATE NO ACTION;
ALTER TABLE db.Prescricao ADD CONSTRAINT UTENTE_NIF FOREIGN KEY(utente_NIF) REFERENCES db.Utente(NIF) ON UPDATE NO ACTION;
ALTER TABLE db.Prescricao ADD CONSTRAINT NUM_VENDA FOREIGN KEY(num_venda) REFERENCES db.Venda(num_venda) ON UPDATE NO ACTION;

--Funcionario
ALTER TABLE db.Funcionario ADD CONSTRAINT NIFF FOREIGN KEY(NIF) REFERENCES db.Pessoa(NIF) ON UPDATE NO ACTION;

--Utente
ALTER TABLE db.Utente ADD CONSTRAINT NIFU FOREIGN KEY(NIF) REFERENCES db.Pessoa(NIF) ON UPDATE NO ACTION;

--Medico
ALTER TABLE db.Medico ADD CONSTRAINT NIFM FOREIGN KEY(NIF) REFERENCES db.Pessoa(NIF) ON UPDATE NO ACTION;

--Medicamento
ALTER TABLE db.Medicamento ADD CONSTRAINT NIPCM FOREIGN KEY(lab_id) REFERENCES db.Laboratorio(NIPC) ON UPDATE NO ACTION;
ALTER TABLE db.Medicamento ADD CONSTRAINT CIDM FOREIGN KEY(categoria_id) REFERENCES db.Categoria(ID) ON UPDATE NO ACTION;
ALTER TABLE db.Medicamento ADD CONSTRAINT IIDM FOREIGN KEY(tipo_id) REFERENCES db.TIPO(ID) ON UPDATE NO ACTION;


--TemPD
ALTER TABLE db.TemPD ADD CONSTRAINT PID FOREIGN KEY(periodo_ID) REFERENCES db.Periodo(ID) ON UPDATE NO ACTION;
ALTER TABLE db.TemPD ADD CONSTRAINT DID FOREIGN KEY(disponibilidade_ID) REFERENCES db.Disponibilidade(ID) ON UPDATE NO ACTION;

--Venda
ALTER TABLE db.Venda ADD CONSTRAINT UtenteNIF FOREIGN KEY(utente_NIF) REFERENCES db.Utente(NIF) ON UPDATE NO ACTION;
ALTER TABLE db.Venda ADD CONSTRAINT FUNCNIF FOREIGN KEY(func_NIF) REFERENCES db.Funcionario (NIF) ON UPDATE NO ACTION;

--Contem
ALTER TABLE db.Contem ADD CONSTRAINT NUMP FOREIGN KEY(num_prescricao) REFERENCES db.Prescricao (num_prescricao) ON UPDATE NO ACTION;
ALTER TABLE db.Contem ADD CONSTRAINT LABNIPC FOREIGN KEY(nome_medicamento,lab_NIPC) REFERENCES db.Medicamento(nome,lab_id) ON UPDATE NO ACTION;

--AIM
ALTER TABLE db.AIM ADD CONSTRAINT Naim FOREIGN KEY(distribuidor_NIPC) REFERENCES db.Distribuidor(NIPC) ON UPDATE NO ACTION;
ALTER TABLE db.AIM ADD CONSTRAINT LABNC FOREIGN KEY(medicamento_nome,lab_NIPC) REFERENCES db.Medicamento(nome,lab_id) ON UPDATE NO ACTION;

--Formula
ALTER TABLE db.Formula ADD CONSTRAINT FORNOME FOREIGN KEY(medicamento_nome, lab_NIPC) REFERENCES db.Medicamento(nome, lab_id) ON UPDATE NO ACTION;
ALTER TABLE db.Formula ADD CONSTRAINT INGRE FOREIGN KEY(ingrediente_ID) REFERENCES db.Ingredientes(ID) ON UPDATE NO ACTION;

--TemMV
ALTER TABLE db.TemMV ADD CONSTRAINT FORME FOREIGN KEY(nome, lab_NIPC) REFERENCES db.Medicamento(nome, lab_id) ON UPDATE NO ACTION;
ALTER TABLE db.TemMV ADD CONSTRAINT NV FOREIGN KEY(num_venda) REFERENCES db.Venda(num_venda) ON UPDATE NO ACTION;


-- LOTES
ALTER TABLE db.Lotes ADD CONSTRAINT lotes1 FOREIGN KEY(nome_med, lab_id) REFERENCES db.Medicamento(nome, lab_id) ON UPDATE NO ACTION;


