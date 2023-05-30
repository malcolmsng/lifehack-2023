import express from 'express';
import cors from 'cors';
import * as anchor from '@coral-xyz/anchor';

import { constants } from './config';

import routes from './routes';

import accessLog from './middlewares/accessLog';

const app = express();
anchor.setProvider(anchor.AnchorProvider.env());

// Apply Cors
app.use(cors(constants.CORS));

// Parsing json bodies
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Middlewares
app.use(accessLog);

// Configuring routes
app.use('/api/v1', routes);

// Catch 404
app.use('*', (req, res) => {
  res.status(404).json({
    error: `No API matches "${req.method.toUpperCase()} ${req.baseUrl}".`,
  });
});

export default app;
