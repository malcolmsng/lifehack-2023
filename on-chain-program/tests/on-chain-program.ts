import * as anchor from "@coral-xyz/anchor";
import { Program, SystemProgram } from "@coral-xyz/anchor";
import { OnChainProgram } from "../target/types/on_chain_program";
import { assert } from "chai";

describe("on-chain-program", () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.AnchorProvider.env());

  const program = anchor.workspace.OnChainProgram as Program<OnChainProgram>;

  it("Is initialized!", async () => {
    // Add your test here.
    const myAccount = anchor.web3.Keypair.generate();

    const tx = await program.rpc.initialize({
      accounts: {
        myAccount: myAccount.publicKey,
        user: anchor.getProvider().publicKey,
        systemProgram: anchor.web3.SystemProgram.programId
      },
      signers: [myAccount],
    });
    console.log("Your transaction signature", tx);

    const account = await program.account.myAccount.fetch(myAccount.publicKey)

    assert.ok(account.data.eq(new anchor.BN(0)))
  });
});
