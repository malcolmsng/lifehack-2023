// ** Import types
import type { CorsOptions } from 'cors';

const CORS: Readonly<CorsOptions> = {
  origin: ['http://localhost:3000'],
  credentials: true,
  allowedHeaders: ['Content-Type', 'Authorization'],
  methods: ['GET', 'PUT', 'POST', 'DELETE'],
};

const LOG_MESSAGES = {
  TRACE: {
    ZOD_PARSING: (schemaName: string) =>
      `Parsing JSON into Zod Schema (${schemaName}).` as const,
    TRANSACTION: {
      SELLER_INITIATED: (sellerId: string, txHash: string) =>
        `Seller (${sellerId}) successfully initiated transaction (${txHash}).` as const,
      BUYER_ACCEPTED: (buyerId: string, txHash: string) =>
        `Buyer (${buyerId}) accepted transaction (${txHash}).` as const,
      PENDING_VALIDATOR: (
        transactionHash: string,
        validatorType: 'internal' | 'manual' | 'auto'
      ) =>
        `Transaction (${transactionHash}) is pending ${validatorType} validator.` as const,
      CONFIRMED_VALIDATOR: (
        transactionHash: string,
        validatorType: 'internal' | 'manual' | 'auto'
      ) =>
        `Transaction (${transactionHash}) has confirmed ${validatorType} validator.` as const
    },
  },
  ERROR: {
    INVALID_BODY: 'Invalid JSON Body.',
    TX_HASH_NOT_FOUND: (hash: string) =>
      `Cannot find the specific transaction hash: ${hash}.` as const,
    UNKNOWN: 'Unknown error. Returned 404 to client.',
  },
} as const;

export default {
  CORS,
  LOG_MESSAGES,
} as const;
