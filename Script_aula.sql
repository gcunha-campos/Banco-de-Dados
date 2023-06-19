create table departamento (
	id_departamento int primary key,
	nome_departamento varchar(50)
	);

create table funcionarios (
	id_funcionario int primary key,
	nome_funcionario varchar(200),
	salario decimal(10, 2),
	id_departamento int,
	foreign key (id_departamento) references departamento(id_departamento)
	);

insert into departamento (id_departamento, nome_departamento) values
	(1, 'Vendas'),
	(2, 'Marketing'),
	(3, 'TI');
	
insert into funcionarios (id_funcionario, nome_funcionario, salario, id_departamento) values
	(1, 'João', 5000, 1),
	(2, 'Maria', 6000, 2),
	(3, 'Carlos', 5500, 1),
	(4, 'Ana', 4500, 2),
	(5, 'Paulo', 7000, 3),
	(6, 'Lucia', 6500, 2);

INSERT INTO departamento (id_departamento, nome_departamento) values
	(4, 'RH');

create table departamento3 AS
SELECT id_departamento as id, nome_departamento as nome
FROM departamento d
where 1 = 0;

create table funcionario2 AS
SELECT id_funcionario as id, nome_funcionario as nome
FROM funcionarios f 
where 1 = 0;

create table funcionario3 AS
SELECT id_funcionario as id, nome_funcionario as nome
FROM funcionarios f
where 1 = 0;

create table departamento2 AS
SELECT id_funcionario as id, nome_funcionario as nome
FROM funcionarios f
where 1 = 0;

UPDATE funcionarios
SET nome_funcionario='João', salario=5000.00, id_departamento=1
WHERE id_funcionario=1;
UPDATE funcionarios
SET nome_funcionario='Maria', salario=6000.00, id_departamento=2
WHERE id_funcionario=2;
UPDATE funcionarios
SET nome_funcionario='Carlos', salario=5500.00, id_departamento=1
WHERE id_funcionario=3;
UPDATE funcionarios
SET nome_funcionario='Ana', salario=4500.00, id_departamento=2
WHERE id_funcionario=4;
UPDATE funcionarios
SET nome_funcionario='Paulo', salario=7000.00, id_departamento=3
WHERE id_funcionario=5;
UPDATE funcionarios
SET nome_funcionario='Lucia', salario=6500.00, id_departamento=2
WHERE id_funcionario=6;

-- OU

UPDATE funcionarios f
SET f.salario = f.salario * 1.10
WHERE id_funcionario in 
	(select d.id_departamento
	from departamento d
	where d.nome_departemanto ilike '%marketing%');
	
create table funcionario_bonus AS
SELECT id_funcionario as id, nome_funcionario
FROM funcionarios f
where id_funcionario = 2;

UPDATE funcionario_bonus
SET f.salario = f.salario * 1.10;

-- Resposta:

create table funcionario_bonus (
	id_funcionario int primary key,
	foreign key (id_funcionario) references funcionario(id_funcionario)
	);

insert into funcionario_bonus (id_funcionario) values
	(1),
	(2);
	
create view funcionarios_nomes as 
select id_funcionario as id, nome_funcionario as nome, id_departamento
from funcionarios f;

insert into funcionarios_nomes (id, nome, id_departamento) values
	(7, 'Francisco', 2);

delete from funcionario_bonus fb;

delete from funcionarios f
where f.id_departamento in (select d.id_departamento
		from departamento d
		where d.nome_departamento ilike '%Vendas');

select *
from information_schema.tables
where table_schema = 'public';

select column_name, data_type, ordinal_position
from information_schema.columns
where table_schema = 'public'
and table_name = 'departamento';

---------------Aula 13/06------------------------

create table t10(id int primary key);
insert into t10(id) values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

select nome_funcionario from funcionarios where nome_funcionario = 'Carlos';
select id as pos from t10;

select nome_funcionario, iter.pos
from (select nome_funcionario from funcionarios where nome_funcionario = 'Carlos')func,
	 (select id as pos from t10)iter;
	
select substr(func.nome_funcionario, iter.pos, 1)
from (select nome_funcionario from funcionarios where nome_funcionario = 'Carlos')func,
	 (select id as pos from t10)iter
where iter.pos <= length(func.nome_funcionario);

---------------Aula 15/06------------------------

-- Gerar ips aleatórios
create table tabela_ips (ip VARCHAR(15) primary key);
insert into tabela_ips(ip)
select((RANDOM()*255)::int||'.'||
	   (RANDOM()*255)::int||'.'||
	   (RANDOM()*255)::int||'.'||
	   (RANDOM()*255)::int)
from GENERATE_SERIES(1,5);

-- Pegando os mesmos ips e dividindo em colunas
create table tabela_ips2 (ip VARCHAR(15) primary key);
select ip, SPLIT_PART(ip, '.', 1),
	   	   SPLIT_PART(ip, '.', 2),
	       SPLIT_PART(ip, '.', 3),
	       SPLIT_PART(ip, '.', 4)
from tabela_ips;

-- Calcular média dos salários
select d.nome_departamento, round(avg(f.salario),2)
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento
group by d.id_departamento;

-- Maior e menor salário
select d.nome_departamento, min(f.salario) as min, max(f.salario) as max
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento
group by d.id_departamento;

-- Soma de todos os salários
select d.nome_departamento, sum(f.salario) as soma_total
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento
group by d.id_departamento;

-- Número de funcionários por departamento
select d.nome_departamento, count(f.id_funcionario) 
from funcionarios f, departamento d
where f.id_departamento = d.id_departamento
group by d.id_departamento;

-- Somas acumulativas
select f.nome_funcionario, f.salario,
	sum(f.salario) over (order by f.salario, f.nome_funcionario) as soma_acumulativa
from funcionarios f;

-- Calculando média móvel
create table Vendas as
select(('2020-01-01')::date + interval '1 month' * generate_series)::date as Periodo,
(random()*10000)::int
from GENERATE_SERIES(1,24);

select Periodo, Vendas,
	lag(Vendas,1) over (order by Periodo) as Vendas_Ultimo1,
	lag(Vendas,2) over (order by Periodo) as Vendas_Ultimo2,
	(Vendas + lag(Vendas,1) over (order by Periodo)
		    + lag(Vendas,2) over (order by Periodo)) as Media_Movel
from Vendas;















