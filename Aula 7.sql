CREATE TABLE departamento (
	id_departamento INT,
	nome_departamento VARCHAR (50),
	PRIMARY KEY (id_departamento) 
	);
	
	INSERT INTO departamento (id_departamento, nome_departamento)
	VALUES
	(1, 'Vendas'),
	(2, 'Marketing'),
	(3, 'TI'),
	(4, 'Estagiario'),
	(5, 'Financeiro'),
	(6, 'RH'),
	(7, 'Administração');

CREATE TABLE funcionarios (
	id_funcionarios INT,
	nome_funcionarios VARCHAR (50),
	salario_funcionarios DECIMAL (10,2),
	id_departamento INT,
	PRIMARY KEY (id_funcionarios),
	FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento)
	);

	INSERT INTO funcionarios (id_funcionarios, nome_funcionarios, salario_funcionarios, id_departamento)
	VALUES
	(1, 'João', 5000,1),
	(2, 'Maria', 6000,2),
	(3, 'Carlos', 5500,1),
	(4, 'Ana', 4500,2),
	(5, 'Paulo', 7000,3),
	(6, 'Lucia', 6500,2);

INSERT INTO funcionarios (id_funcionarios, nome_funcionarios, salario_funcionarios, id_departamento)
	values 
	(7, 'Ana Castela', 4800,2),
	(8, 'Paulo Berbarick', 7200,3),
	(9, 'Lucia Vellasco', 1200,3);

INSERT INTO departamento (id_departamento, nome_departamento)
	values
	(8, 'Fiscalização');


-- reaproveitando definição de tabela --
CREATE TABLE departamento2
AS select *
from departamento d
where 1 = 0;

-- reaproveitando paret da definição --
CREATE TABLE funcionarios2 as
select id_funcionarios as id, nome_funcionarios as nome
from funcionarios f
where 1 = 0;

-- reaproveitando paret da definição e retornando infos selecionadas--
CREATE TABLE funcionarios3 AS 
select id_funcionarios as id, nome_funcionarios as nome
from funcionarios f
where f.id_departamento in (1,2); --tupla de range de valores--

-- atualizar linhas tabela (TI) -- 
UPDATE funcionarios  
SET 
    salario_funcionarios = salario_funcionarios*1.10
WHERE
    id_departamento = 3;
   
-- atualizar linhas tabela sem saber o id --
UPDATE funcionarios  
SET 
    salario_funcionarios = salario_funcionarios*1.10
where id_departamento in
		(select d.id_departamento
		 from departamento d
		 where d.nome_departamento ilike '%marketing%');
 
		 
-- 		 
CREATE TABLE funcionarios_bonus(
id_funcionario int primary key,
foreign key (id_funcionario) references funcionarios (id_funcionarios)
);

insert into funcionarios_bonus (id_funcionario)
values 
(1),
(2);

update funcionarios
set salario_funcionarios = salario_funcionarios*1.10
where id_funcionarios in (select id_funcionario from funcionarios_bonus);


-- previnir usuários de utilizar a tabela e colunas--
CREATE VIEW views_func AS 
SELECT id_funcionarios, nome_funcionarios, id_departamento 
FROM funcionarios f;

-- inserção de dados através da view --
insert into views_func (id_funcionarios, nome_funcionarios, id_departamento) values
(10, 'Tavora', 2),
(11, 'GC', 1);

-- adicionar salario para os novos campos inseridos pela view--
update funcionarios set salario_funcionarios = 5000 
where id_funcionarios in (10, 11);

 
-- deletando itens de uma tabela --
delete * from funcionarios_bonus;


-- deletando funcionarios especificos --
delete from funcionarios f
where f.id_departamento in (select id_departamento from departamento d  where d.nome_departamento ilike '%vendas%');

-- ver todas as tabelas de um schema --
select table_name
from information_schema.tables
where table_schema ='public';

-- listar as colunas de uma tabela, seus tipos de dado e sua posição na tabela --
select column_name, data_type, ordinal_position
from information_schema.columns
where table_schema = 'public'
and table_name = 'departamento';

-- listar indices, suas colunas e a posição da coluna no índice dada uma tabela --
select a.tablename, a.indexname, b.column_name
from pg_catalog.pg_indexes a, information_schema.columns b
where a.schemaname = 'public'
and a.tablename = b.table_name;

--listando as restrições de uma tabela--
select a.table_name, a.constraint_name, b.column_name, a.constraint_type
from information_schema.table_constraints a, information_schema.key_column_usage b
where a.table_name = 'funcionario'
and a.table_schema = 'public'
and a.table_name = b.table_name
and a.table_schema = b.table_schema
and a.constraint_name = b.constraint_name;

select table_name
from information_schema.tables
where table_schema ='public';

-- query inteligente para me dar queries de count das linhas das tabelas --
select 'select count(*) from ' || table_name || ';' counts 
from information_schema.tables
where table_schema ='public';

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'funcionarios'
AND CONSTRAINT_TYPE = 'FOREIGN KEY';

-- query inteligente para me dar queries de quebrar as quebras de Foreign Key--
-- a tabela information_schema é do postgress e recebe o apelido "a"--
-- selecionamos os rows da tabela "a" table_name e table_constraints --
select 'ALTER TABLE ' || a.table_name || 'DISABLE CONSTRAINT' || a.constraint_name || ';'  alteracao
from information_schema.table_constraints a
where a.table_schema ='public'
and a.constraint_type = 'FOREIGN KEY';











