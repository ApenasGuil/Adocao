import express from "express";
import backendTest from "../controllers/backend.js";

const router = express.Router();

router.get('/', backendTest); 

export default router;