import type { RequestHandler } from 'express';
import {
  InitiatedTransaction,
  AcceptingTransactionPostBody,
  InitiateTransactionPostBody,
  TransactionBody,
} from '../schema';
import logger from '../utils/logger';
import generateTxHash from '../utils/generateTxHash';
import { constants, env } from '../config';

export const initiateTransactionsController: RequestHandler = async (
  req,
  res
) => {
  try {
    logger.trace(
      constants.LOG_MESSAGES.TRACE.ZOD_PARSING('InitiateTransactionPostBody')
    );
    let result = InitiateTransactionPostBody.safeParse(req.body);

    // Checking if zod type parsing has any error
    if (!result.success) {
      logger.error(
        {
          endpoint: req.url,
          status: 400,
          err: result.error.toString(),
        },
        constants.LOG_MESSAGES.ERROR.INVALID_BODY
      );
      return res.status(400).json({
        error: result.error,
        message: constants.LOG_MESSAGES.ERROR.INVALID_BODY,
        success: false,
      });
    }

    let transactionHash = await generateTxHash();

    let { data } = result;
    // TODO: Register in FireStore as a pending transaction

    logger.trace(
      constants.LOG_MESSAGES.TRACE.TRANSACTION.SELLER_INITIATED(
        data.seller.sgId,
        transactionHash
      )
    );
    return res.status(201).json({ transactionHash, success: true });
  } catch (err) {
    logger.error(err, constants.LOG_MESSAGES.ERROR.UNKNOWN);
    return res.status(500).json({
      err: err,
      success: false,
    });
  }
};

export const acceptingTransactionController: RequestHandler = async (
  req,
  res
) => {
  try {
    let transactionHash = req.params['txHash']

    if (transactionHash === '') {
      logger.error(
        constants.LOG_MESSAGES.ERROR.TX_HASH_NOT_FOUND(transactionHash),
      );
      return res.status(404).json({
        error: constants.LOG_MESSAGES.ERROR.TX_HASH_NOT_FOUND(transactionHash),
        success: false,
      });
    }

    logger.trace(
      constants.LOG_MESSAGES.TRACE.ZOD_PARSING('AcceptingTransactionPostBody')
    );
    let result = AcceptingTransactionPostBody.safeParse(req.body);

    // Checking if zod type parsing has any error
    if (!result.success) {
      logger.error(
        {
          endpoint: req.url,
          status: 400,
          err: result.error.toString(),
        },
        constants.LOG_MESSAGES.ERROR.INVALID_BODY
      );
      return res.status(400).json({
        error: result.error,
        message: constants.LOG_MESSAGES.ERROR.INVALID_BODY,
        success: false,
      });
    }

    let { data } = result;

    // TODO: Find FireStore for transaction hash
    let notFound = false; // TODO

    if (notFound) {
      logger.error(
        constants.LOG_MESSAGES.ERROR.TX_HASH_NOT_FOUND(
          data.transactionHash
        ),
      );
      return res.status(404).json({
        err: constants.LOG_MESSAGES.ERROR.TX_HASH_NOT_FOUND(
          data.transactionHash
        ),
        success: false,
      });
    }

    // TODO: To fetch from FireStore
    logger.trace(
      constants.LOG_MESSAGES.TRACE.ZOD_PARSING('InitiatedTransaction')
    );
    let pendingTransaction = InitiatedTransaction.parse({
      seller: {
        sgId: 'someID',
        walletAddress: 'someWalletAddress',
      },
      amount: 5000,
      itemName: 'some item',
      transactionHash: 'txHash',
      validator: 'internal',
    });

    logger.trace(constants.LOG_MESSAGES.TRACE.ZOD_PARSING('TransactionBody'));
    let transaction = TransactionBody.parse({
      buyer: { ...data.buyer },
      ...pendingTransaction,
      validator: { type: pendingTransaction.validator },
      inProgressTransactionPubkey: null,
      validatedTransactionPubkey: null,
      status: 'pendingValidator',
    });

    logger.trace(constants.LOG_MESSAGES.TRACE.TRANSACTION.PENDING_VALIDATOR(transactionHash, pendingTransaction.validator))

    if (pendingTransaction.validator === 'internal') {
      // TODO: Calls the On Chain Program using SDK to initiate instruction

      transaction.status = 'validatorInitiated';
      // TODO: Replace with the transaction hash that comes back from the On Chain Program
      transaction.inProgressTransactionPubkey = '';
    } else {
      // TODO: Fetch from FireStore to check if there's any available
      // TODO: validator, if not we will proceed to push into a local queue
    }

    // TODO: Update Transaction Object in FireStore

    return res.status(200).json({ transaction, success: true });
  } catch (err) {
    logger.error(err, constants.LOG_MESSAGES.ERROR.UNKNOWN);
    return res.status(500).json({
      err: err,
      success: false,
    });
  }
};
