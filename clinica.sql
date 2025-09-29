CREATE DATABASE IF NOT EXISTS clinica;
USE clinica;

CREATE TABLE Dono(
    CPF varchar(11) PRIMARY KEY UNIQUE NOT NULL,
    Nome varchar(30),
    Endereco varchar(255),
    data_nasc date
);

CREATE TABLE Animal(
    ID int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    Especie varchar(20) not null,
    CPF_dono varchar(11) not null,
    Nome varchar(100) not null,
    Idade int not null,
    Porte varchar(40) not null, 
    CONSTRAINT FK_Dono_CPF_Animal
    FOREIGN KEY (CPF_dono) REFERENCES Dono (CPF)
);

CREATE TABLE veterinario(
    CRMV varchar(13) primary key not null,
    nome varchar(100) not null,
    idade int not null,
    data_graduacao date not null
);

CREATE TABLE Exotico(
    RFIDEX varchar(11) PRIMARY KEY NOT NULL,
    Nota_Fiscal varchar(100) not null,
    animal_ID int,
    CONSTRAINT FK_Animal_ID_Exotico
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);

CREATE TABLE Pet(
    RFID varchar(11) PRIMARY KEY NOT NULL,
    animal_ID int, 
    CONSTRAINT FK_anima_ID_Pet
    FOREIGN KEY (animal_ID) REFERENCES Animal (ID)
);

CREATE TABLE consulta(
    id int primary key auto_increment not null,
    diagnostico varchar(255) not null,
    id_animal int not null,
    CRMV_veterinario varchar(13) not null,
    CONSTRAINT fk_CRMV_VET
    FOREIGN KEY (CRMV_veterinario) REFERENCES veterinario(CRMV),
    CONSTRAINT FK_Animal_Consulta
    FOREIGN KEY (id_animal) REFERENCES Animal(ID)
);

CREATE TABLE tratamento(
    id int primary key auto_increment not null,
    antibiotico boolean not null,
    id_consulta int not null,
    descricao_tratamento varchar(255) not null,
    CONSTRAINT FK_id_consulta
    FOREIGN KEY (id_consulta) REFERENCES consulta(id)
);



INSERT INTO Dono (CPF, Nome, Endereco, data_nasc) VALUES 
("12345678912", "Renan Watanabe", "Aguas Claras", "2006-06-26"), 
("12345678934", "Gabriel Antônio", "Aguas Claras", "2006-04-07"), 
("12345678901", "Kauan Henrique", "Ceilândia", "2005-07-06");


INSERT INTO Animal(Especie, CPF_dono, Nome, Idade, Porte) VALUES
("Cachorro", "12345678912", "Mack", 11, "Médio"),
("Coelho", "12345678934", "Mike nelson", 4, "Pequeno"),
("Jibóia", "12345678901", "Princesa", 3, "Grande");

INSERT INTO veterinario (CRMV, nome, idade, data_graduacao) VALUES
("CRMV-DF 07439", "Victor Caldas", 19, "2023-09-08");


INSERT INTO Pet(RFID, animal_ID) VALUES
("222/333", 1), 
("333/444", 2); 

INSERT INTO Exotico(RFIDEX, Nota_Fiscal, animal_ID) VALUES
("111/222", "NF-0012345-BR", 3); 


INSERT INTO consulta(diagnostico, id_animal, CRMV_veterinario) VALUES 
("Sarna", 1, "CRMV-DF 07439"), 
("Gases", 2, "CRMV-DF 07439"),
("Pneumonia bacteriana", 3, "CRMV-DF 07439");


INSERT INTO tratamento(antibiotico, id_consulta, descricao_tratamento) VALUES
(0, 1, 'Tratar com banhos periódicos usando um shampoo anti sarna de sua preferencia.'),
(0, 2, 'Fazer massagens abdominais periódicas monitorando a melhora do animal ou não. Caso não haja melhora, retorne para mais exames.'),
(1, 3, 'Tomar o antibiótico de 8 em 8 horas, aumentar a temperatura e umidade do recinto, e reduzir o estresse do animal.');


SELECT
    d.Nome AS "Nome do Dono",
    d.CPF,
    a.Nome AS "Nome do Animal",
    a.Especie,
    a.Porte,
    a.Idade
FROM
    Dono d
INNER JOIN
    Animal a ON d.CPF = a.CPF_dono
ORDER BY
    "Nome do Dono";
    
SELECT
    c.id AS "ID da Consulta",
    a.Nome AS "Paciente",
    d.Nome AS "Dono",
    v.nome AS "Veterinário",
    c.diagnostico AS "Diagnóstico"
FROM
    Consulta c
INNER JOIN
    Animal a ON c.id_animal = a.ID
INNER JOIN
    Dono d ON a.CPF_dono = d.CPF
INNER JOIN
    veterinario v ON c.CRMV_veterinario = v.CRMV;
    
SELECT
    c.id AS "ID da Consulta",
    a.Nome AS "Paciente",
    c.diagnostico AS "Diagnóstico",
    IF(t.antibiotico = 1, 'Sim', 'Não') AS "Usa Antibiótico?",
    t.descricao_tratamento AS "Descrição do Tratamento"
FROM
    Consulta c
INNER JOIN
    Tratamento t ON c.id = t.id_consulta
INNER JOIN
    Animal a ON c.id_animal = a.ID;
    
SELECT
    a.Nome AS "Animal Exótico",
    a.Especie,
    d.Nome AS "Nome do Dono",
    d.Endereco AS "Endereço do Dono",
    e.Nota_Fiscal
FROM
    Animal a
INNER JOIN
    Exotico e ON a.ID = e.animal_ID
INNER JOIN
    Dono d ON a.CPF_dono = d.CPF;
