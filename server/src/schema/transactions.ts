import { z } from 'zod';

export const User = z.object({
  sgId: z.string(),
  walletAddress: z.string(),
});

export const InitiateTransactionPostBody = z.object({
  seller: User,
  itemName: z.string(),
  amount: z.number(), // This is in lamports
  validator: z.union([z.literal('internal'), z.literal('public')]),
  // Internal stands for using the automated validation service provided by us.
  // Public means any validator that signs up to be one.
});

export const InitiatedTransaction = InitiateTransactionPostBody.extend({
  transactionHash: z.string(), // Generated on server
});

export const AcceptingTransactionPostBody = z.object({
  buyer: User,
  transactionHash: z.string(),
});

export const Transaction = InitiateTransactionPostBody.merge(
  AcceptingTransactionPostBody
).extend({
  validator: User.nullable(),
  inProgressTransactionPubkey: z.string().nullable(),
  validatedTransactionPubkey: z.string().nullable(),
  status: z.union([
    z.literal('pendingValidator'), // When the seller accept
    z.literal('validatorFound'), // When a validator has agreed to validate this tx
    z.literal('validatorInitiated'), // When a validator initiate the blockchain tx
    z.literal('inProgressTransaction'), // When the transaction has been pushed on chain
    z.literal('transactionValidated'),
    // When the transaction has been validated by validator that the goods received and everything is good.
    z.literal('transactionRejected'),
    // When the transaction has been rejected by validator as item is faulty / unauthentic or goods not received.
    z.literal('error'), // Error likely only occured if buyer has not enough lamports / tx rejected by program.
  ]),
});
