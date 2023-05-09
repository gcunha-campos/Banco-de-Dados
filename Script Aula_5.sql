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

-- por inner join --
select f.nome_funcionario, d.nome_departamento
from funcionarios f
join departamentos d
on d.id_departamento = f.id_departamento
where f.id_departamento = 1;


-- produto cartesiano dos funcionarios do departmanto 1 com a tabela de departamentos --
SELECT f.nome_funcionario, d.nome_departamento
FROM funcionarios f, departamentos d
WHERE f.id_departamento = 1;

-- da certo pois o departamento n equivale a d.id_departamento = f.id_departamento (SE SOMENTE SE)--
SELECT f.nome_funcionario, d.nome_departamento 
FROM funcionarios f, departamentos d
WHERE f.id_departamento = 1
and d.id_departamento = 1;

-- seleciona os ids de departamento--
-- ao add o excepet, exclui-se o que não está na tabela funcionarios--
select d.id_departamento
from departamentos d
except 
select f.id_departamento
from funcionarios f;

-- query full (tem subquery)--
select d2.nome_departamento
from departamentos d2,
(select d.id_departamento 
from departamentos d
except 
select f.id_departamento 
from funcionarios f) d_sem_func
where d2.id_departamento = d_sem_func.id_departamento;


-- abordagem com view --
create view depto_sem_func as
select d.id_departamento
from departamentos d
except 
select f.id_departamento
from funcionarios f;

-- juncao com a tabela depto para achar o nome
create view nome_depto_sem_func
as 
select d2.nome_departamento 
from departamentos d2, depto_sem_func dsf
where d2.id_departamento = dsf.id_departamento;

-- linhas de uma tabela que não existem = Nomes de departamentos sem funcionarios
-- solução com except e join
select d.id_departamento 
from departamentos d
except 
select f.id_departamento 
from funcionarios f;

-- equivalente ao except e join, apenas com conectios lógicos --
select d.id_departamento 
from departamentos d
where d.id_departamento not in 
		(select f.id_departamento from funcionarios f);
	
-- para ver apenas os departamentos com funcionarios 
select d.id_departamento 
from departamentos d
where d.id_departamento in 
		(select f.id_departamento from funcionarios f);

-- outer join sem filtrar 
select *
from departamentos d
left outer join funcionarios f
on d.id_departamento = f.id_departamento 

-- outer join apenas para nulos 
select *
from departamentos d
left outer join funcionarios f
on d.id_departamento = f.id_departamento 	
where f.id_departamento is null;

