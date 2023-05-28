// ** Express Import
import { Router } from 'express';
import {
  benchmarkController,
  initiateTransactionsController,
} from './controllers';

// Initializing Router
const router = Router();

router.post('/initiateTransactions', initiateTransactionsController);

router.get('/', benchmarkController);

export default router;
