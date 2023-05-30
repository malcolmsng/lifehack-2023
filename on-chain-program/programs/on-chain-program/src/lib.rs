use anchor_lang::prelude::*;

declare_id!("LFnX9eor6aBpmMdcF1QqWcbf2q6doTkvAYUxAGtq3MP");

#[program]
pub mod on_chain_program {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>, amount: u64, item_name: String, buyer: Pubkey, seller: Pubkey, validator: Pubkey) -> Result<()> {
        let data = &mut ctx.accounts.data;
        data.amount = amount.clone();
        data.buyer = buyer.clone();
        data.seller = seller.clone();
        data.item_name = item_name.clone();
        data.status = Status::Created.clone();
        data.validator = validator.clone();
        Ok(())
    }

    pub fn confirm(ctx: Context<Confirm>) -> Result<()> {
        let data = &mut ctx.accounts.data;
        if data.status != Status::Created {
            return err!(ErrorEnum::StatusImmutable)
        }
        data.status = Status::Confirmed;
        Ok(())
    }

    pub fn reject(ctx: Context<Reject>) -> Result<()> {
        let data = &mut ctx.accounts.data;
        if data.status != Status::Created {
            return err!(ErrorEnum::StatusImmutable)
        }
        data.status = Status::Rejected;
        Ok(())
    }

}

#[derive(Accounts)]
pub struct Initialize<'info> {
    #[account(init, payer = user, space = 8 + (4 + 512) + (3 * 32) + 1)]
    pub data: Account<'info, DataAccount>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[derive(Accounts)]
pub struct Confirm<'info> {
    #[account(mut)]
    pub data: Account<'info, DataAccount>,
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[derive(Accounts)]
pub struct Reject<'info> {
    #[account(mut)]
    pub data: Account<'info, DataAccount>,
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[account]
pub struct DataAccount {
    pub amount: u64,
    pub item_name: String,
    pub seller: Pubkey,
    pub buyer: Pubkey,
    pub validator: Pubkey,
    pub status: Status
}

#[derive(Clone, Debug, PartialEq, Eq, AnchorSerialize, AnchorDeserialize)]
pub enum Status {
    Created,
    Confirmed,
    Rejected
}

#[error_code]
pub enum ErrorEnum {
    #[msg("Unable to change transaction status after it is finalized.")]
    StatusImmutable
}