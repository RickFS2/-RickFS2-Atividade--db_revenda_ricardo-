create database db_revenda_Ricardo

create table usuario (
	id serial primary key,
	nome varchar (30),
	sobrenome varchar (50),
	cpf char (11),
	celular char (11),
	e_mail varchar (50)
);

create table produto (
	id serial primary key,
	Titulo varchar (50),
	descricao text,
	preco numeric (5 , 2),
	quantidade varchar (20),
	cores varchar (50),
	estoque boolean
);

create table pagamento(
id serial primary key,
cartao_id int, foreign key (cartao_id) references cartao(id),
pix varchar (100),
boleto varchar (100),
parcelamento varchar (10),
pedidos_id int, foreign key (pedidos_id) references pedidos(id)
);

create table cartao (
id serial primary key,
numero char (19),
validade char (5),
cvc char (3),
nome varchar (50)
);

create table pedidos (
id serial primary key,
n_pedido varchar (10),
data date,
endereco_id int, foreign key (endereco_id) references endereco(id),
usuario_id int, foreign key (usuario_id) references usuario(id)
);

create table endereco (
id serial primary key,
CEP char (8),
Rua varchar (50),
Numero Varchar (6),
Ponto_referencia text,
bairro varchar (50),
cidade varchar (50),
Estado Char (2)
);


create table usuario_endereco (
usuario_id int, foreign key (usuario_id) references usuario(id),
endereco_id int, foreign key (endereco_id) references endereco(id)
);

CREATE VIEW view_dados_usuario_com_endereco AS
SELECT 
    u.id AS usuario_id,
    u.nome,
    u.sobrenome,
    u.cpf,
    u.celular,
    u.e_mail,
    e.id AS endereco_id,
    e.CEP,
    e.Rua,
    e.Numero,
    e.Ponto_referencia,
    e.bairro,
    e.cidade,
    e.Estado
FROM 
    usuario u
JOIN 
    usuario_endereco ue ON u.id = ue.usuario_id
JOIN 
    endereco e ON ue.endereco_id = e.id;
   
   
   CREATE VIEW view_pedidos_com_pagamento AS
SELECT 
    p.id AS pedido_id,
    p.n_pedido,
    p.data,
    u.nome || ' ' || u.sobrenome AS nome_usuario,
    pg.pix,
    pg.boleto,
    pg.parcelamento,
    c.numero AS numero_cartao,
    c.validade,
    c.nome AS nome_cartao
FROM 
    pedidos p
JOIN 
    usuario u ON p.usuario_id = u.id
LEFT JOIN 
    pagamento pg ON pg.pedidos_id = p.id
LEFT JOIN 
    cartao c ON pg.cartao_id = c.id;


select * from view_dados_usuario_com_endereco;
select * from view_pedidos_com_pagamento;

