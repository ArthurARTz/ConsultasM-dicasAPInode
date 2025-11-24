-- OAT BANCO DE DADOS - SISTEMA DE GESTÃO DE CLÍNICA MÉDICA 
-- NOME: Arthur Amaral Ricardo Ferreira
-- CURSO: SIS

-- CRIAÇÃO DO BANCO

CREATE DATABASE sis_medic;
USE sis_medic;


-- TABELA: PACIENTES

CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);


-- TABELA: ESPECIALIDADES

CREATE TABLE especialidades (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);


-- TABELA: MÉDICOS

CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    id_especialidade INT NOT NULL,
    FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade)
);


-- TABELA: CONVÊNIOS

CREATE TABLE convenios (
    id_convenio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_plano VARCHAR(50)
);


-- TABELA: CONSULTAS

CREATE TABLE consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_convenio INT,
    data_consulta DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status_pagamento ENUM('PAGO', 'PENDENTE') NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_convenio) REFERENCES convenios(id_convenio)
);


-- INSERTS DAS TABELAS


-- PACIENTES 

INSERT INTO pacientes (nome, data_nascimento, telefone, email) VALUES
('João Silva', '1985-03-15', '11999998888', 'joao@gmail.com'),
('Maria Santos', '1990-07-22', '11988887777', 'maria@gmail.com'),
('Carlos Pereira', '1978-11-01', '11977776666', 'carlos@gmail.com'),
('Ana Souza', '1995-05-12', '11966665555', 'ana@gmail.com'),
('Fernando Rocha', '1982-04-18', '11955554444', 'fernando@gmail.com'),
('Julia Martins', '2000-01-09', '11944443333', 'julia@gmail.com'),
('Paulo Almeida', '1975-12-30', '11933332222', 'paulo@gmail.com'),
('Rita Lopes', '1993-06-14', '11922221111', 'rita@gmail.com'),
('Luciano Costa', '1988-09-25', '11911110000', 'luciano@gmail.com'),
('Helena Farias', '1999-10-10', '11888889999', 'helena@gmail.com'),
('Thiago Ramos', '1987-02-28', '11877778888', 'thiago@gmail.com'),
('Bianca Oliveira', '1992-08-20', '11866667777', 'bianca@gmail.com'),
('Eduardo Lima', '1983-03-03', '11855556666', 'eduardo@gmail.com'),
('Mariana Carvalho', '1997-09-11', '11844445555', 'mariana@gmail.com'),
('Felipe Duarte', '2001-05-05', '11833334444', 'felipe@gmail.com');

-- ESPECIALIDADES

INSERT INTO especialidades (nome, descricao) VALUES
('Cardiologia', 'Especialidade do coração'),
('Ortopedia', 'Especialidade do sistema locomotor'),
('Dermatologia', 'Cuidado da pele'),
('Pediatria', 'Atendimento de crianças'),
('Gastroenterologia', 'Sistema digestivo');

-- MÉDICOS

INSERT INTO medicos (nome, crm, id_especialidade) VALUES
('Dr. Roberto Haddad', 'CRM12345', 1),
('Dra. Luciana Ramos', 'CRM54321', 1),
('Dr. Marcos Vieira', 'CRM11111', 2),
('Dra. Paula Fonseca', 'CRM22222', 2),
('Dr. André Farias', 'CRM33333', 3),
('Dra. Camila Prado', 'CRM44444', 3),
('Dr. João Matos', 'CRM55555', 4),
('Dra. Silvia Mendes', 'CRM66666', 4),
('Dr. Pedro Arruda', 'CRM77777', 5),
('Dra. Bruna Santos', 'CRM88888', 5);

-- CONVÊNIOS

INSERT INTO convenios (nome, tipo_plano) VALUES
('Unimed', 'Premium'),
('Amil', 'Standard'),
('Bradesco Saúde', 'Master'),
('SulAmérica', 'Gold'),
('Particular', 'Avulso');

-- CONSULTAS

INSERT INTO consultas (id_paciente, id_medico, id_convenio, data_consulta, valor, status_pagamento) VALUES
(1, 1, 1, '2025-01-10', 250.00, 'PAGO'),
(1, 3, 2, '2025-02-14', 300.00, 'PAGO'),
(2, 2, 1, '2025-01-12', 250.00, 'PENDENTE'),
(2, 4, 3, '2025-02-20', 350.00, 'PAGO'),
(3, 5, 4, '2025-01-15', 200.00, 'PAGO'),
(3, 6, 4, '2025-03-01', 220.00, 'PAGO'),
(4, 1, 1, '2025-01-18', 250.00, 'PENDENTE'),
(4, 7, 5, '2025-02-10', 400.00, 'PAGO'),
(5, 8, 3, '2025-03-12', 350.00, 'PAGO'),
(6, 9, 2, '2025-04-02', 280.00, 'PAGO'),
(7, 10, 1, '2025-02-14', 260.00, 'PAGO'),
(8, 1, 1, '2025-03-05', 250.00, 'PAGO'),
(8, 5, 4, '2025-04-09', 200.00, 'PAGO'),
(9, 3, 3, '2025-03-20', 300.00, 'PAGO'),
(9, 4, 3, '2025-03-30', 350.00, 'PENDENTE'),
(10, 7, 5, '2025-01-25', 400.00, 'PAGO'),
(11, 2, 1, '2025-02-17', 250.00, 'PENDENTE'),
(12, 6, 4, '2025-03-07', 220.00, 'PAGO'),
(12, 5, 4, '2025-04-15', 200.00, 'PAGO'),
(13, 9, 2, '2025-01-13', 280.00, 'PAGO'),
(14, 10, 1, '2025-02-28', 260.00, 'PAGO'),
(15, 1, 1, '2025-02-10', 250.00, 'PAGO'),
(15, 3, 2, '2025-04-12', 300.00, 'PAGO');


-- CONSULTAS 


-- 1. Pacientes que realizaram consultas em mais de uma especialidade

SELECT p.nome, COUNT(DISTINCT e.id_especialidade) AS qtd_especialidades
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidade = m.id_especialidade
GROUP BY p.id_paciente
HAVING COUNT(DISTINCT e.id_especialidade) > 1;

-- 2. Médicos que atenderam mais de 10 pacientes em um mês

SELECT m.nome, COUNT(*) AS total_atendimentos
FROM consultas c
JOIN medicos m ON m.id_medico = c.id_medico
WHERE MONTH(c.data_consulta) = 2 AND YEAR(c.data_consulta) = 2025
GROUP BY m.id_medico
HAVING COUNT(*) > 10;

-- 3. Consultas pagas por convênios específicos, aqui usei uma procedure, pois como tem vários convênios eu consigo passar o nome dele como parâmetro 
-- Parâmetro : Nome do Convênio

DELIMITER $$

CREATE PROCEDURE consultasPorConvenio(IN nomeConvenio VARCHAR(100))
BEGIN
    SELECT c.id_consulta, p.nome AS paciente, m.nome AS medico, co.nome AS convenio,
           c.data_consulta, c.valor, c.status_pagamento
    FROM consultas c
    JOIN pacientes p ON p.id_paciente = c.id_paciente
    JOIN medicos m ON m.id_medico = c.id_medico
    JOIN convenios co ON co.id_convenio = c.id_convenio
    WHERE co.nome = nomeConvenio
      AND c.status_pagamento = 'PAGO';
END $$

DELIMITER ;

-- 4. Pacientes que nunca retornaram após a primeira consulta

SELECT p.nome
FROM pacientes p
JOIN consultas c ON c.id_paciente = p.id_paciente
GROUP BY p.id_paciente
HAVING COUNT(c.id_consulta) = 1;

-- 5. Especialidades com maior faturamento

SELECT e.nome, SUM(c.valor) AS faturamento
FROM consultas c
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidade = m.id_especialidade
GROUP BY e.id_especialidade
ORDER BY faturamento DESC;

-- 6. Médicos sem consultas na semana, também usei uma procedure para passar qualquer semana do ano
-- Parâmetro: Data de inicio da semana, data fim da semana

DELIMITER $$

CREATE PROCEDURE medicosSemConsultasSemana(
    IN dataInicio DATE,
    IN dataFim DATE
)
BEGIN
    SELECT m.id_medico, m.nome AS medico
    FROM medicos m
    LEFT JOIN consultas c 
        ON c.id_medico = m.id_medico
        AND c.data_consulta BETWEEN dataInicio AND dataFim
    WHERE c.id_consulta IS NULL;
END $$

DELIMITER ;

-- 7. Pacientes atendidos por mais de um médico

SELECT p.nome, COUNT(DISTINCT m.id_medico) AS total_medicos
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
GROUP BY p.id_paciente
HAVING COUNT(DISTINCT m.id_medico) > 1;

-- 8. Total de faturamento por convênio

SELECT co.nome AS convenio, SUM(c.valor) AS total
FROM consultas c
JOIN convenios co ON co.id_convenio = c.id_convenio
GROUP BY co.id_convenio;

-- 9. Consultas realizadas nos últimos 30 dias 

SELECT *
FROM consultas
WHERE data_consulta BETWEEN '2025-03-30' AND '2025-04-30';

-- 10. Média de consultas por paciente

SELECT p.nome, COUNT(c.id_consulta) AS total_consultas,
       (SELECT COUNT(*) FROM consultas) / (SELECT COUNT(*) FROM pacientes) AS media_geral
FROM pacientes p
LEFT JOIN consultas c ON c.id_paciente = p.id_paciente
GROUP BY p.id_paciente;


-- VIEWS


-- View 1: Consultas com detalhes completos

CREATE VIEW vw_consultas_detalhes AS
SELECT c.id_consulta, p.nome AS paciente, m.nome AS medico, e.nome AS especialidade,
       co.nome AS convenio, c.data_consulta, c.valor, c.status_pagamento
FROM consultas c
JOIN pacientes p ON p.id_paciente = c.id_paciente
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidade = m.id_especialidade
LEFT JOIN convenios co ON co.id_convenio = c.id_convenio;

-- View 2: Faturamento por especialidade

CREATE VIEW vw_faturamento_especialidade AS
SELECT e.nome AS especialidade, SUM(c.valor) AS total_faturado
FROM consultas c
JOIN medicos m ON m.id_medico = c.id_medico
JOIN especialidades e ON e.id_especialidade = m.id_especialidade
GROUP BY e.id_especialidade;

-- View 3: Pacientes que possuem mais de uma consulta

CREATE VIEW vw_pacientes_frequentes AS
SELECT p.id_paciente, p.nome, COUNT(c.id_consulta) AS total_consultas
FROM pacientes p
JOIN consultas c ON c.id_paciente = p.id_paciente
GROUP BY p.id_paciente
HAVING COUNT(c.id_consulta) > 1;

-- Chamando as procedures

CALL consultasPorConvenio('Unimed');
CALL medicosSemConsultasSemana('2025-02-10', '2025-02-17')
