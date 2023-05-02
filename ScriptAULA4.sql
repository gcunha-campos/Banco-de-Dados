CREATE DATABASE aula_4

create TABLE departamentos(
id_departamento SERIAL primary KEY,
nome_departamento varchar 
);



create table funcionarios(
id_funcionario SERIAL primary key,
nome_funcionario varchar(255),
salario decimal (10,2),
id_departamento int,
foreign key (id_departamento) references departamentos(id_departamento)
);

insert into departamentos(nome_departamento) values
('Vendas'),
('Marketin'),
('TI');

-- Da um update no nome da coluna errada--
UPDATE public.departamentos
SET nome_departamento='Marketing'
WHERE id_departamento=2;


insert into funcionarios (nome_funcionario, salario, id_departamento) values
('João', 5000, 1),
('Maria', 6000, 2),
('Carlos', 5500, 1),
('Ana', 4500, 2),
('Paulo', 7000, 3),
('Lucia', 6500, 2);

insert into departamentos (nome_departamento) values
('RH');

-- Deleta a uma adição dupliacada --
DELETE FROM public.departamentos
WHERE id_departamento=5;


select f.nome_funcionario, d.nome_departamento from funcionarios f, departamentos d
where d.id_departamento = f.id_departamento;

select f.nome_funcionario, d.nome_departamento from funcionarios f
join departamentos d on d.id_departamento = f.id_departamento;

select f.nome_funcionario, d.nome_departamento from funcionarios f, departamentos d
where f.id_departamento = 1;

-- seleciona a coluna que não aparece na tabela funcionarios --
select d.id_departamento from departamentos d
except 
select f.id_departamento from funcionarios f;

