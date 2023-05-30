// ** Third Party Imports
import express from 'express';
import cors from 'cors';

// ** Constants Import
import { constants } from './config';

// ** Main Router Import
import routes from './routes';

// ** Middlewares Import
import accessLog from './middlewares/accessLog';

const app = express();

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
