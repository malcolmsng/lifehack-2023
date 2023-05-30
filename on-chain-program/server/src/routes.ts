// ** Express Import
import { Router } from 'express';
import {
  benchmarkController,
  initiateTransactionsController,
} from './controllers';
import logger from './utils/logger';
import { Connection, PublicKey, clusterApiUrl } from '@solana/web3.js';
import { Idl, Program, Provider, web3 } from '@coral-xyz/anchor';
import { OnChainProgram } from '../../target/types/on_chain_program';
import * as anchor from '@coral-xyz/anchor';

// Initializing Router
const router = Router();

router.post('/initiateTransactions', initiateTransactionsController);

router.get('/testing123', async (req, res) => {
  anchor.setProvider(anchor.AnchorProvider.env());

  logger.info('here');

  const program = anchor.workspace.OnChainProgram as Program<OnChainProgram>;

  // Add your test here.
  const myAccount = anchor.web3.Keypair.generate();

  const tx = await program.rpc.initialize({
    accounts: {
      myAccount: myAccount.publicKey,
      user: anchor.getProvider().publicKey!,
      systemProgram: anchor.web3.SystemProgram.programId,
    },
    signers: [myAccount],
  });
  console.log('Your transaction signature', tx);

  const account = await program.account.myAccount.fetch(myAccount.publicKey);

  res.status(200).json(account);
});

router.get('/', benchmarkController);

export default router;
