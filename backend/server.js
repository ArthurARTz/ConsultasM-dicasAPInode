const express = require("express");
const cors = require("cors");
const db = require("./db");
const path = require("path");


const app = express();
app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, "../frontend")));


// 1. Pacientes com + especialidades

app.get("/pacientes/multiespecialidades", (req, res) => {
    const sql = `
        SELECT p.nome, COUNT(DISTINCT e.id_especialidade) AS qtd_especialidades
        FROM consultas c
        JOIN pacientes p ON p.id_paciente = c.id_paciente
        JOIN medicos m ON m.id_medico = c.id_medico
        JOIN especialidades e ON e.id_especialidade = m.id_especialidade
        GROUP BY p.id_paciente
        HAVING COUNT(DISTINCT e.id_especialidade) > 1;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 2. Médicos com mais atendimentos

app.get("/medicos/mais-atendimentos", (req, res) => {
    const { mes, ano } = req.query;
    const sql = `
        SELECT m.nome, COUNT(*) AS total_atendimentos
        FROM consultas c
        JOIN medicos m ON m.id_medico = c.id_medico
        WHERE MONTH(c.data_consulta) = ? AND YEAR(c.data_consulta) = ?
        GROUP BY m.id_medico
        HAVING COUNT(*) > 10;
    `;
    db.query(sql, [mes, ano], (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 3. Consultas por convênio (procedure)

app.get("/consultas/convenio/:nome", (req, res) => {
    db.query("CALL consultasPorConvenio(?)", [req.params.nome], (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows[0]);
    });
});


// 4. Pacientes com apenas 1 consulta

app.get("/pacientes/uma-consulta", (req, res) => {
    const sql = `
        SELECT p.nome
        FROM pacientes p
        JOIN consultas c ON c.id_paciente = p.id_paciente
        GROUP BY p.id_paciente
        HAVING COUNT(c.id_consulta) = 1;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 5. Faturamento por especialidade

app.get("/faturamento/especialidades", (req, res) => {
    const sql = `
        SELECT e.nome, SUM(c.valor) AS faturamento
        FROM consultas c
        JOIN medicos m ON m.id_medico = c.id_medico
        JOIN especialidades e ON e.id_especialidade = m.id_especialidade
        GROUP BY e.id_especialidade
        ORDER BY faturamento DESC;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 6. Médicos sem consultas (procedure)

app.get("/medicos/sem-consultas", (req, res) => {
    const { inicio, fim } = req.query;
    db.query("CALL medicosSemConsultasSemana(?, ?)", [inicio, fim], (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows[0]);
    });
});


// 7. Pacientes com vários médicos

app.get("/pacientes/multimedicos", (req, res) => {
    const sql = `
        SELECT p.nome, COUNT(DISTINCT m.id_medico) AS total_medicos
        FROM consultas c
        JOIN pacientes p ON p.id_paciente = c.id_paciente
        JOIN medicos m ON m.id_medico = c.id_medico
        GROUP BY p.id_paciente
        HAVING COUNT(DISTINCT m.id_medico) > 1;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 8. Faturamento por convênio

app.get("/faturamento/convenios", (req, res) => {
    const sql = `
        SELECT co.nome AS convenio, SUM(c.valor) AS total
        FROM consultas c
        JOIN convenios co ON co.id_convenio = c.id_convenio
        GROUP BY co.id_convenio;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});


// 9. Últimos 30 dias

app.get("/consultas/ultimos30dias", (req, res) => {
    const sql = `
        SELECT *
        FROM consultas
        WHERE data_consulta BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});

// 10. Média de consultas

app.get("/consultas/media", (req, res) => {
    const sql = `
        SELECT p.nome, COUNT(c.id_consulta) AS total_consultas,
               (SELECT COUNT(*) FROM consultas) / (SELECT COUNT(*) FROM pacientes) AS media_geral
        FROM pacientes p
        LEFT JOIN consultas c ON c.id_paciente = p.id_paciente
        GROUP BY p.id_paciente;
    `;
    db.query(sql, (err, rows) => {
        if (err) return res.status(500).json(err);
        res.json(rows);
    });
});

app.listen(3000, () => console.log("API rodando em http://localhost:3000"));
