import type { RequestHandler } from 'express';
import { InitiateTransactionPostBody } from '../schema';
import logger from '../utils/logger';

export const initiateTransactionsController: RequestHandler = (req, res) => {
  let result = InitiateTransactionPostBody.safeParse(req.body);

  // Checking if zod type parsing has any error
  if (!result.success) {
    logger.error(result.error.toString());
    return res.status(400).json({
      error: result.error,
      message: 'Invalid body',
    });
  }

  let { data } = result;

  res.status(201).json({ ...data, success: true });
};
