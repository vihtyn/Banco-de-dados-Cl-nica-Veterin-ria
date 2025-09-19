create database clinica;

use clinica;

create table consulta(
	id int primary key auto_increment not null,
    diagnostico varchar(255) not null,
    RFID_consulta varchar(11) not null,
    CRMV_veterinario varchar(11) not null,
    RFIEX varchar(11) not null,
	constraint fk_CRMV_VET
    foreign key (CRMV_veterinario) references veterinario(CRMV),
    constraint FK_Identificacao_exotico
    foreign key (RFIDEX) references exotico(RFIDEX)
);

create table veterinario(
	CRMV varchar(13) primary key not null,
    nome varchar(100) not null,
    idade int not null,
    data_graduacao date not null
);

create table tratamento(
	id int primary key auto_increment not null,
    antibiotico boolean not null,
    id_consulta int not null,
    constraint FK_id_consulta
    foreign key (id_consulta) references consulta(id)
);


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
