CREATE TABLE Dono(
	CPF varchar(11) PRIMARY KEY UNIQUE NOT NULL,
    Nome varchar(30),
    Endereço varchar(255),
    data_nasc date
);

CREATE TABLE Animal(
	ID int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    Espceie varchar(20),
    CPF_dono varchar(11),
    CONSTRAINT FK_Dono_CPF_Animal
    FOREIGN KEY (CPF_dono) REFERENCES Dono (CPF) 
);

CREATE TABLE Pet(
	RFID varchar(11) PRIMARY KEY NOT NULL,
    Nome varchar(30),
    Idade int,
    Sexo char(1),
    animal_ID int,
    CONSTRAINT FK_anima_ID_Pet
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);

CREATE TABLE Exotico(
	RFIDEX varchar(11) PRIMARY KEY NOT NULL,
    Especie varchar(40),
    Porte varchar (14),
    Idade int,
    Nome varchar(30),
    Sexo char(1),
    animal_ID int,
    CONSTRAINT FK_Animal_ID_Exotico
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);
