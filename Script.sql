create table departamento
(
	id_depart serial primary key,
	nome_depart varchar(60)
	
);

create table projeto
(
	id_proj serial primary key,
	nome_proj varchar(60)
	
);

create table empregado
(
	id_emp serial primary key,
	nome_emp varchar(60),
	id_depart int,
	id_proj int,
	foreign key (id_depart) references departamento (id_depart),
	foreign key (id_proj) references projeto (id_proj)
);

create table dependente
(
	id_dep serial primary key,
	nome_dep varchar(60),
	id_dep_emp int references empregado (id_emp)
	
);




