-- AV2.1 : Thiago Gough

create table livros (
ISBN varchar(20) primary key,
titulo varchar(100),
autor_id int,
categoria_id int,
editora_id int,
foreign key (autor_id) references autores(autor_id),
foreign key (categoria_id) references categorias(categoria_id),
foreign key (editora_id) references editoras(editora_id));

create table categorias(
categoria_id int primary key,
nome varchar(50));

create table editoras(
editora_id int primary key,
nome varchar(100),
endereco varchar(200));

create table clientes(
cliente_id int primary key,
nome varchar(100),
endereco varchar(200),
telefone varchar(20));

create table itempedidos(
item_id int primary key,
pedido_id int,
livro_id varchar(20),
quantidade int,
foreign key (pedido_id) references pedidos(pedido_id),
foreign key (livro_id) references livros(ISBN));

create table autores(
autor_id int primary key,
nome varchar(100),
nacionalidade varchar(100));-- metodo 2

create table funcionarios(
funcionario_id int primary key,
nome varchar(100),
cargo varchar(50));

create table pedidos(
pedido_id int primary key,
p_data date,
cliente_id int,
funcionario_id int,
foreign key (cliente_id) references clientes(cliente_id),
foreign key (funcionario_id) references funcionarios(funcionario_id));

-- populando tabelas
insert into clientes(cliente_id, nome, endereco, telefone) values
(1, 'thiago', 'brasilia', 123498345),
(2, 'laura', 'brasilia', 373873828),
(3, 'vinicius', 'sao paulo', 123454636);

insert into funcionarios(funcionario_id, nome, cargo) values
(1, 'marcos', 'vendedor'),
(2, 'joao', 'vendedor');

insert into funcionarios(funcionario_id, nome, cargo) values
(3, 'amanda' , 'vendedor');

insert into categorias(categoria_id, nome) values
(1, 'ficcao'),
(2, 'nao ficcao');

insert into categorias(categoria_id, nome) values
(3, 'ciencias');

insert into autores(autor_id, nome, nacionalidade) values
(1, 'augusto', 'brasileiro'),
(2, 'machado', 'brasileiro');

insert into editoras(editora_id, nome, endereco) values
(1, 'pinguim', 'rio'),
(2, 'livros publicos', 'brasilia');

insert into editoras(editora_id, nome, endereco) values
(3, 'compania de livros', 'acre');

insert into livros(ISBN, titulo, autor_id, categoria_id, editora_id) values
(123456789, 'o livro um', 1, 1, 1),
(162637487, 'o livro dois', 1, 2, 2);

insert into livros(ISBN, titulo, autor_id, categoria_id, editora_id) values
(213543434, 'o livro tres', 2, 2, 1);

insert into pedidos(pedido_id, p_data, cliente_id , funcionario_id) values
(1, '2023-10-10', 1, 2),
(2, '2021-03-03', 1, 1);


insert into itempedidos(item_id, pedido_id, livro_id, quantidade) values
(1, 1, 123456789, 1),
(2, 2, 162637487, 1);

-- questao 1 

-- metodo 1
select c.nome as cliente_nome, f.nome as funcionario_nome, l.titulo
from clientes c
join pedidos p on c.cliente_id = p.cliente_id
join funcionarios f on p.funcionario_id = f.funcionario_id
join itempedidos i on p.pedido_id = i.pedido_id
join livros l on i.livro_id = l.ISBN;

--metodo 2
select c.nome as cliente_nome, f.nome as funcionario_nome, l.titulo
from clientes c, pedidos p , funcionarios f , itempedidos i , livros l
where c.cliente_id = p.cliente_id 
and f.funcionario_id = p.funcionario_id
and i.pedido_id = p.pedido_id 
and l.isbn = i.livro_id;

-- questao 2

-- metodo 1
create view categorias_disponiveis as
select c.nome 
from categorias c join
livros l on l.categoria_id = c.ca--metodo 2

select l.titulo, c.nome as categoria_nome
from livros ltegoria_id;

select c.nome
from categorias c
except
select cd.nome
from categorias_disponiveis cd;

--questao 3

--metodo 1
select l.titulo, c.nome as categoria_nome
from livros l
join categorias c on l.categoria_id = c.categoria_id
full join itempedidos i on l.isbn = i.livro_id
where i.quantidade is null;

--questao 4

(select c.nome as clientes_e_funcionarios_nao_involvidos from
clientes c
except
select c.nome from
clientes c 
join pedidos p on p.cliente_id = c.cliente_id)
union all
(select f.nome from
funcionarios f 
except
select f2.nome from
funcionarios f2
join pedidos p on p.funcionario_id = f2.funcionario_id);

--questao 5

select a2.nome from
autores a2
except
select a.nome from
autores a
join livros l on l.autor_id = a.autor_id
join itempedidos i on i.livro_id = l.isbn;

--questao 6

(select e.nome from
editoras e
except 
select e2.nome from
editoras e2 
join livros l on l.editora_id = e2.editora_id)
union all
(select e3.nome from
editoras e3
join livros l2 on l2.editora_id = e3.editora_id
except
select e4.nome from
editoras e4
join livros l3 on l3.editora_id = e4.editora_id
join itempedidos i on i.livro_id = l3.isbn);



