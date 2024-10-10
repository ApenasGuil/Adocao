import mysql from "mysql";

export const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "guildev123",
    database: "adocao",
    // connectionLimit: 10 // Limite de conexões simultâneas
})