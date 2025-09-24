create database clinica;

use clinica;

CREATE TABLE Dono(
	CPF varchar(11) PRIMARY KEY UNIQUE NOT NULL,
    Nome varchar(30),
    Endereco varchar(255),
    data_nasc date
);

CREATE TABLE Animal(
	ID int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    Espcie varchar(20) not null,
    CPF_dono varchar(11) not null,
    Nome varchar(100) not null,
    Idade int not null,
    CONSTRAINT FK_Dono_CPF_Animal
    FOREIGN KEY (CPF_dono) REFERENCES Dono (CPF) 
);

create table veterinario(
	CRMV varchar(13) primary key not null,
    nome varchar(100) not null,
    idade int not null,
    data_graduacao date not null
);

CREATE TABLE Exotico(
	RFIDEX varchar(11) PRIMARY KEY NOT NULL,
    Especie varchar(40) not null,
    Porte varchar (40) not null,
    animal_ID int,
    CONSTRAINT FK_Animal_ID_Exotico
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);

create table consulta(
	id int primary key auto_increment not null,
    diagnostico varchar(255) not null,
    id_animal int not null,
    CRMV_veterinario varchar(13) not null,
	constraint fk_CRMV_VET
    foreign key (CRMV_veterinario) references veterinario(CRMV),
    constraint FK_Animal_Consulta
	foreign key (id_animal) references Animal(ID)
);

create table tratamento(
	id int primary key auto_increment not null,
    antibiotico boolean not null,
    id_consulta int not null,
    descricao_tratamento varchar(255) not null,
    constraint FK_id_consulta
    foreign key (id_consulta) references consulta(id)
);

CREATE TABLE Pet(
	RFID varchar(11) PRIMARY KEY NOT NULL,
    Especie varchar(40) not null,
    animal_ID int,
    CONSTRAINT FK_anima_ID_Pet
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);

insert into Dono values ("12345678912", "Renan Watanabe","Aguas Claras", "2006-06-26"), ("12345678934","Gabriel Antônio", "Aguas Claras","2006-04-07"), ("12345678901","Kauan Henrique"," Ceilândia","2005-07-06");

insert into Animal(Especie, CPF_dono, Nome, Idade, tipo) values("Cachorro", "12345678912", "Mack", 11, "pet"),("Coelho","12345678934", "Mike nelson", 4, "pet"),("Jibóia", "12345678901","Princesa", 3, "exotico");

insert into veterinario values("CRMV-DF 07439", "Victor Caldas", 19, "2023-09-08");

insert into Exotico values("111/222", "Jibóia", "Grande", 9);
insert into Pet values("222/333","Cachorro", 7), ("333/444","Coelho", 8);

insert into consulta(diagnostico, id_animal, CRMV_veterinario) values ("sarna", 7,"CRMV-DF 07439"), ("gases", 8,"CRMV-DF 07439"),("pneumonia bacteriana", 9,"CRMV-DF 07439");

insert into tratamento(antibiotico, id_consulta) values(0, 1), (0, 2), (1, 3);

select * from Dono;
select * from veterinario;
select * from Animal;
select * from Pet;
select * from Exotico;
select * from consulta;
select * from tratamento;

alter table tratamento
add column descricao_tratamento varchar(255) not null;

update tratamento set descricao_tratamento = 'Tomar o antibiótico de 8 em 8 horas, aumentar a temperatura do recinto do animal em cerca de 3 a 4 graus celcius, aumente a umidade do recinto em cerca de 4 a 5 %, e reduza o estresse do animal o maximo possivel.' where id = 3;
update tratamento set descricao_tratamento = 'Tratar com banhos periódicos usando um shampoo anti sarna de sua preferencia. ' where id = 1;
update tratamento set descricao_tratamento = 'Fazer massagens abdominais periódicas monitorando a melhora do animal ou não. Caso não haja melhora, retorne para mais exames.' where id = 2;