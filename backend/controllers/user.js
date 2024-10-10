import { db } from "../db.js";

export const addUser = (req, res) => {
    const { name } = req.body; // { name } é igual à: req.body.name;
    const { email } = req.body;
    const { password } = req.body;

    // console.log(name);

    let query = "INSERT INTO users ( name, email, password ) VALUES ( ?, ?, ? )";

    db.query(query, [
        name, email, password
    ], (err, result) => {
        console.log("Usuário adicionado!", err);
    });
};

export const getUsers = (req, res) => {
    let query = "SELECT * FROM users";
    
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
};

export const editUser = (req, res) => {
    const { id } = req.body;
    const { name } = req.body;
    const { email } = req.body;
    const { password } = req.body;

    let query = "UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?";

    db.query(query, [
        name, email, password, id
    ], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
};

export const deleteUser = (req, res) => {
    const { id } = req.params;

    let query = "DELETE FROM users WHERE id = ?";

    db.query(query, [
        id
    ], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
}