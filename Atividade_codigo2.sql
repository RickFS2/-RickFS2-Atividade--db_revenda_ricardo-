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

INSERT INTO usuario (nome, sobrenome, cpf, celular, e_mail) VALUES
('Ana', 'Silva', '12345678901', '11999999999', 'ana.silva@email.com'),
('Bruno', 'Souza', '23456789012', '21988888888', 'bruno.souza@email.com'),
('Carla', 'Mendes', '34567890123', '31977777777', 'carla.mendes@email.com'),
('Diego', 'Almeida', '45678901234', '41966666666', 'diego.almeida@email.com'),
('Elisa', 'Costa', '56789012345', '51955555555', 'elisa.costa@email.com'),
('Fábio', 'Lima', '67890123456', '61944444444', 'fabio.lima@email.com'),
('Gisele', 'Pereira', '78901234567', '71933333333', 'gisele.pereira@email.com'),
('Hugo', 'Fernandes', '89012345678', '81922222222', 'hugo.fernandes@email.com'),
('Iara', 'Rocha', '90123456789', '91911111111', 'iara.rocha@email.com'),
('João', 'Martins', '01234567890', '11900000000', 'joao.martins@email.com');



INSERT INTO endereco (CEP, Rua, Numero, Ponto_referencia, bairro, cidade, Estado) VALUES
('01001000', 'Rua A', '100', 'Próximo ao mercado', 'Centro', 'São Paulo', 'SP'),
('02002000', 'Rua B', '200', 'Em frente à escola', 'Jardim', 'Rio de Janeiro', 'RJ'),
('03003000', 'Rua C', '300', 'Perto do hospital', 'Bela Vista', 'Belo Horizonte', 'MG'),
('04004000', 'Rua D', '400', 'Ao lado da igreja', 'Centro', 'Porto Alegre', 'RS'),
('05005000', 'Rua E', '500', 'Próximo ao parque', 'Jardim América', 'Curitiba', 'PR'),
('06006000', 'Rua F', '600', 'Próximo ao shopping', 'Centro', 'Salvador', 'BA'),
('07007000', 'Rua G', '700', 'Em frente ao banco', 'Mooca', 'São Paulo', 'SP'),
('08008000', 'Rua H', '800', 'Perto da praça', 'Centro', 'Fortaleza', 'CE'),
('09009000', 'Rua I', '900', 'Ao lado da padaria', 'Vila Nova', 'Recife', 'PE'),
('10010000', 'Rua J', '1000', 'Em frente ao estádio', 'Centro', 'Manaus', 'AM');


INSERT INTO produto (Titulo, descricao, preco, quantidade, cores, estoque) VALUES
('Camisa Polo', 'Camisa polo 100% algodão', 79.90, '50', 'Azul, Branco', true),
('Calça Jeans', 'Calça jeans masculina', 120.00, '40', 'Azul escuro', true),
('Tênis Esportivo', 'Tênis confortável para corrida', 150.50, '30', 'Preto, Cinza', true),
('Jaqueta Couro', 'Jaqueta de couro legítimo', 350.00, '15', 'Preto', true),
('Relógio Digital', 'Relógio com funções múltiplas', 199.99, '25', 'Preto, Vermelho', true),
('Mochila Escolar', 'Mochila resistente com vários compartimentos', 89.90, '60', 'Preto, Azul', true),
('Óculos de Sol', 'Óculos de sol UV400', 59.90, '45', 'Preto, Marrom', true),
('Boné Esportivo', 'Boné com proteção UV', 39.90, '70', 'Azul, Vermelho', true),
('Camiseta Básica', 'Camiseta 100% algodão', 29.90, '100', 'Branco, Preto', true),
('Calção Praia', 'Calção leve para praia', 49.90, '80', 'Azul, Verde', true);




INSERT INTO cartao (numero, validade, cvc, nome) VALUES
('1234 5678 9012 3456', '12/25', '123', 'Ana Silva'),
('2345 6789 0123 4567', '11/24', '456', 'Bruno Souza'),
('3456 7890 1234 5678', '10/23', '789', 'Carla Mendes'),
('4567 8901 2345 6789', '09/26', '321', 'Diego Almeida'),
('5678 9012 3456 7890', '08/27', '654', 'Elisa Costa'),
('6789 0123 4567 8901', '07/28', '987', 'Fábio Lima'),
('7890 1234 5678 9012', '06/22', '147', 'Gisele Pereira'),
('8901 2345 6789 0123', '05/24', '258', 'Hugo Fernandes'),
('9012 3456 7890 1234', '04/25', '369', 'Iara Rocha'),
('0123 4567 8901 2345', '03/23', '159', 'João Martins');



INSERT INTO pagamento (cartao_id, pix, boleto, parcelamento, pedidos_id) VALUES
(1, NULL, 'BOL123456', '3x', 1),
(2, 'pix123@banco.com', NULL, '1x', 2),
(3, NULL, 'BOL123457', '2x', 3),
(4, 'pix234@banco.com', NULL, '1x', 4),
(5, NULL, 'BOL123458', '4x', 5),
(6, 'pix345@banco.com', NULL, '1x', 6),
(7, NULL, 'BOL123459', '3x', 7),
(8, 'pix456@banco.com', NULL, '1x', 8),
(9, NULL, 'BOL123460', '5x', 9),
(10, 'pix567@banco.com', NULL, '1x', 10);






























