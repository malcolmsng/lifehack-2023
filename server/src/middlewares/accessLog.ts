import type { RequestHandler } from 'express';
import logger from '../utils/logger';

const accessLogger: RequestHandler = (req, res, next) => {
  logger.trace(`Accessed: ${req.url}`);
  next();
};

export default accessLogger;
