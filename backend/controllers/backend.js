import { db } from "../db.js";

const backendTest = (req, res) => {
  db.getConnection((err) => {
    if (err) {
      console.error('Backend DOWN; ', err);
      return res.status(500).json({ message: 'Backend DOWN', error: err });
    }
    console.log('Backend UP');
    res.status(200).json({ message: 'Backend UP' });
  });
};

export default backendTest;