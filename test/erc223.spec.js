
import chai from 'chai'
import chaiAsPromised from 'chai-as-promised'
chai.use(chaiAsPromised)
const { expect, assert } = chai


const ERC223 = artifacts.require("ERC223");
const SafeContract = artifacts.require("SafeContract");
const BalanceContract = artifacts.require("BalanceContract");
const UnsafeContract = artifacts.require("UnsafeContract");

contract('Testing ERC223 contract', function(accounts) {

    let erc223Token
    let safeContract
    const ownerAccount = accounts[0]
    const name = "ERC223 Token"
    const symbol = "ERC223"
    const decimals = 16

    it(' should be able to deploy and mint ERC223 token', async () => {
        erc223Token = await ERC223.new(name, symbol, decimals)
        await erc223Token.mint(ownerAccount, 1000, {from: ownerAccount})
        expect(Number(await erc223Token.totalSupply())).to.equal(1000)
    })

 
    it(' transfer of the ERC223 tokens to a zeppelin HasNoTokens contract should fail', async () => {
        safeContract = await SafeContract.new()
        const transferFailure = erc223Token.transfer(safeContract.address, 100, {from: ownerAccount})
        expect(transferFailure).to.be.rejectedWith(/VM Exception while processing transaction: revert/)
    })



    it(' transfer of the ERC223 tokens to a regular contract NOT implementing the ERC223 fallback should fail', async () => {
        const unsafeContract = await UnsafeContract.new()
        const transferFailure = erc223Token.transfer(unsafeContract.address, 100, {from: ownerAccount})
        expect(transferFailure).to.be.rejectedWith(/VM Exception while processing transaction: revert/)
    })

    it(' transfer of the ERC223 tokens to a balance contract implementing the ERC223 fallback should succeed', async () => {
        const balanceContract = await BalanceContract.new()
        await erc223Token.transfer(balanceContract.address, 100, {from: ownerAccount})
        expect(await balanceContract.from()).to.equal(ownerAccount)
        expect(Number(await balanceContract.value())).to.equal(100)
    })
})