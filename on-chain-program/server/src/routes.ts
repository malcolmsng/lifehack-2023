// ** Express Import
import { Router } from 'express';
import {
  benchmarkController,
  confirmTransaction,
  initializeTransaction,
  initiateTransactionsController,
  rejectTransaction,
} from './controllers';

// Initializing Router
const router = Router();

router.post('/initiateTransactions', initiateTransactionsController);

router.post('/initialize', initializeTransaction);
router.put('/confirm/:accountPubkey', confirmTransaction);
router.put('/reject/:accountPubkey', rejectTransaction);

router.get('/', benchmarkController);

export default router;
