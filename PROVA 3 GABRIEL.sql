

-- QUESTÃO 1 --

create table tab_tels as
select ((random() * 88 + 11)::int || ' (' ||
		(random() * 88 + 11)::int || ') ' ||
		(random() * 49999 + 49999)::int || '-' ||
		(random() *  4999 + 4999)::int)
from generate_series(1,250);



-- QUESTÃO 2--
create table funcionarios as
select CONCAT ('funcionario', generate_series) as nome,
round (random ()*9000 +1000):: int as salarios
from generate_series (1,100);

-- QUESTÃO 3-- 	
create table cagada as 
select concat ('funcionario-', generate_series, round(random ()*9000 +1000):: int)
from generate_series (1,100);
select split_part(VALOR, 'funcionario-')
from cagada;


--QUESTÃO 4--
select valores, contagem, rnk
from(
select valores, contagem,
	dense_rank () over (order by contagem desc) as rnk
		from (
			select valores, count(*) as contagem
			from (
				select (random()*40 +10)::int as valores
					from generate_series(1,200)) tab_val
						group by valores)tab_cont
										)tab_rank
											where rnk =1
												limit 1;
										
-- QUESTÃO 5 --
create table Vendas as
select(('2020-01-01')::date + interval '1 month' * generate_series)::date as mês_atual,
(random()*800 + 200)::int as total_de_vendas
from GENERATE_SERIES(1,50);											
		

-- QUESTÃO 5 B--
select 'INSERT INTO ' || table_name || ' VALUES ' || column_name inserts
from information_schema.columns
WHERE TABLE_NAME = 'vendas'
and table_schema ='public';
