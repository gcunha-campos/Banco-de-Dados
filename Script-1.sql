3: a query falharia a depender da indexação do funcionario, já que você percorre a string de 13 em diante. Mas por exemplo, se o número de linhas aumentasse e o número de digitos aumentasse, as referencias mudariam. A query resolve o caso especifico, mas não é solução para o problema proposto para o exercício.; 4: sua query não executa aqui. O max tenta extrair algo de numbers, mas sua coluna chama numero. Além disso eu pedi uma query só, não múltiplas. Para todos os exercícios.; 5.a: eu queria 50 meses a partir do início de 2020. Você colocou um intervalo arbitrário e provavelmente calculou manualmente 50 meses, o que não era a ideia do exercícios (há queries igualmente simples, usando o generate_series e aritmética com datas que calculariam automaticamente isso); 5.b: não trouxe nada. 6: não feito





--(1)

select concat ('+', (random()* 99):: int, ' ',
	'(', (random()* 99)::int, ')', ' ',
	(random()* 9)::int, (random()* 9)::int,
	(random()* 9)::int, (random()* 9)::int,
	(random()* 9)::int, '-', (random()* 9)::int,
	(random()* 9)::int, (random()* 9)::int,
	(random()* 9)::int) :: varchar(255) as numero_telefone
from generate_series(1, 250, 1);

-- (2)

select concat('funcionario', generate_series) as nome,
round((random()*  9000 + 1000)::decimal, 2) as salario
from generate_series(1, 100, 1);

-- (3)

select substring(concat('funcionario', generate_series, round((random()*  10000 + 1000)::decimal, 2)) from 13 for 10) as salario
from generate_series(1, 100, 1)

-- (4)
create table numbers
(numero int);

insert into numbers
select (random() * 40 + 10)::int as numero
from generate_series(1, 200, 1);

select numero,
max(numbers) as maxd
from numbers;

-- (5)

--(a)
SELECT GENERATE_SERIES('2008-03-01 00:00'::TIMESTAMP,
'2012-04-01 12:00', '1 month') as mes_atual,
(random()* 800 + 200)::int as total_de_vendas;

--(b)

create table vendas_mensais
(mes_atual timestamp,
total_de_vendas int);






