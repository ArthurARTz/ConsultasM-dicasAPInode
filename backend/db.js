const mysql = require("mysql2");

const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "a03012005A*",
    database: "sis_medic"
});

connection.connect((err) => {
    if (err) {
        console.error("Erro ao conectar no MySQL:", err);
        return;
    }
    console.log("MySQL conectado com sucesso!");
});

module.exports = connection;
