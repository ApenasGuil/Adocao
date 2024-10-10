import express from "express";
import backendRoutes from "./routes/backend.js";
import cors from "cors";

const app = express();

app.use(express.json());
app.use(cors());

// Routes
app.use("/server-test", backendRoutes); // Testando conexão com DB

app.listen(3001, () => {
    console.log("Backend rodando na porta 3001");
});