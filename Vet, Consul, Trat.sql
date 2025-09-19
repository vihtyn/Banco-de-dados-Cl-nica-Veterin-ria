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