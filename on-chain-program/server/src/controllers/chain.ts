import logger from '../utils/logger';
import { Connection, Keypair, PublicKey, clusterApiUrl } from '@solana/web3.js';
import { Idl, Program, Provider, web3 } from '@coral-xyz/anchor';
import { OnChainProgram } from '../../../target/types/on_chain_program';
import * as anchor from '@coral-xyz/anchor';
import { RequestHandler } from 'express';
import { BN } from 'bn.js';
import { TransactionBody } from '../schema';
import { constants, env } from '../config';

let _account: Keypair;

export const initializeTransaction: RequestHandler = async (req, res) => {
  try {
    logger.trace(
      constants.LOG_MESSAGES.TRACE.ZOD_PARSING('InitiateTransactionPostBody')
    );
    let result = TransactionBody.safeParse(req.body);

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

    let validatorAddress =
      result.data.validator.type === 'internal'
        ? env.PROGRAM_ID
        : result.data.validator.walletAddress!;

    const program = anchor.workspace.OnChainProgram as Program<OnChainProgram>;

    const newDataAccount = anchor.web3.Keypair.generate();
    _account = newDataAccount;

    const tx = await program.rpc.initialize(
      new BN(result.data.amount),
      result.data.itemName,
      new PublicKey(result.data.buyer.walletAddress),
      new PublicKey(result.data.seller.walletAddress),
      new PublicKey(validatorAddress),
      {
        accounts: {
          data: newDataAccount.publicKey,
          user: anchor.getProvider().publicKey!,
          systemProgram: anchor.web3.SystemProgram.programId,
        },
        signers: [newDataAccount],
      }
    );

    const account = await program.account.dataAccount.fetch(
      newDataAccount.publicKey
    );

    res
      .status(200)
      .json({ tx, pubkey: newDataAccount.publicKey, account, success: true });
  } catch (err) {
    logger.error(err, constants.LOG_MESSAGES.ERROR.UNKNOWN);
    return res.status(500).json({
      err: err,
      success: false,
    });
  }
};

export const confirmTransaction: RequestHandler = async (req, res) => {
  try {
    const program = anchor.workspace.OnChainProgram as Program<OnChainProgram>;

    const tx = await program.rpc.confirm({
      accounts: {
        data: req.params.accountPubkey,
        user: anchor.getProvider().publicKey!,
        systemProgram: anchor.web3.SystemProgram.programId,
      },
    });

    const account = await program.account.dataAccount.fetch(
      req.params.accountPubkey
    );

    res.status(200).json({ tx, account, success: true });
  } catch (err) {
    logger.error(err, constants.LOG_MESSAGES.ERROR.UNKNOWN);
    return res.status(500).json({
      err: err,
      success: false,
    });
  }
};

export const rejectTransaction: RequestHandler = async (req, res) => {
  try {
    const program = anchor.workspace.OnChainProgram as Program<OnChainProgram>;

    const tx = await program.rpc.reject({
      accounts: {
        data: req.params.accountPubkey,
        user: anchor.getProvider().publicKey!,
        systemProgram: anchor.web3.SystemProgram.programId,
      },
    });

    const account = await program.account.dataAccount.fetch(
      req.params.accountPubkey
    );

    res.status(200).json({ tx, account, success: true });
  } catch (err) {
    logger.error(err, constants.LOG_MESSAGES.ERROR.UNKNOWN);
    return res.status(500).json({
      err: err,
      success: false,
    });
  }
};
