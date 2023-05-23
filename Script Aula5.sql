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
		 where d.nome_departamento ilike '%marketing%')
 
		 
-- 		 
CREATE TABLE funcionarios_bonus(
id_funcionario int primary key,
foreign key (id_funcionario) references funcionarios (id_funcionarios)
);

insert into funcionarios_bonus (id_funcionario)
values 
(1),
(2);

update funcionarios 1
set salario_funcionarios = salario_funcionarios*1.10
where id_funcionarios in (select id_funcionario from funcionarios_bonus);









