const { assert } = require('chai');

const DaiToken = artifacts.require('DaiToken');
const DappToken = artifacts.require('DappToken');
const TokenFarm = artifacts.require('TokenFarm');

require('chai')
    .use(require('chai-as-promised'))
    .should()

function tokens(n) {
    return web3.utils.toWei(n, 'ether');
}
contract('TokenFarm', ([owner,investor]) => {

    let daiToken, dappToken, tokenFarm

    before(async () => {
        daiToken = await DaiToken.new()
        dappToken = await DappToken.new()
        tokenFarm = await TokenFarm.new(dappToken.address, daiToken.address)

        await dappToken.transfer(tokenFarm.address, tokens('1000000'))

        await daiToken.transfer(investor, tokens('100'),{from:owner})


    })

    describe('Mock Dai Deployement', async () => {
        it('has a name', async () => {
            const name = await daiToken.name()
            assert.equal(name, 'Mock DAI Token')
        })
    })
    
    describe('Dapp Token Deployement', async () => {
        it('has a name', async () => {
            const name = await dappToken.name()
            assert.equal(name, 'DApp Token')
        })
    })
    
    describe('Token Farm Deployement', async () => {
        it('has a name', async () => {
            const name = await tokenFarm.name()
            assert.equal(name, 'Dapp Token Farm')
        })
        it('contract has token', async () => {
            let balance = await dappToken.balanceOf(tokenFarm.address)
            assert.equal(balance.toString(), tokens('1000000'))
        })
        
    })

    describe('FArming Tokens', async () => {
        it('rewards investors for staking mDai token', async () => {
            let result
            result = await daiToken.balanceOf(investor)
            assert.equal(result.toString(), tokens('100'))
            
            await daiToken.approve(tokenFarm.address, tokens('100'),{from: investor})
            await tokenFarm.stakeTokens(tokens('100'),{from:investor})

            result = await daiToken.balanceOf(investor)
            assert.equal(result.toString(), tokens('0'))

            result = await daiToken.balanceOf(tokenFarm.address)
            assert.equal(result.toString(), tokens('100'))

            result = await tokenFarm.stakingBalance(investor)
            assert.equal(result.toString(), tokens('100'))

            result = await tokenFarm.isStaking(investor)
            assert.equal(result.toString(), 'true')

            await tokenFarm.issueTokens({from:owner})
            
            result = await dappToken.balanceOf(investor)
            assert.equal(result.toString(), tokens('100'))
            
            await tokenFarm.issueTokens({from:investor}).should.be.rejected;

            await tokenFarm.unstakeTokens({from:investor})

            result = await daiToken.balanceOf(investor)
            assert.equal(result.toString(), tokens('100'))
            
            result = await daiToken.balanceOf(tokenFarm.address)
            assert.equal(result.toString(), tokens('0'))
            
            result = await tokenFarm.stakingBalance(investor)
            assert.equal(result.toString(), tokens('0'))
            
            result = await tokenFarm.isStaking(investor)
            assert.equal(result.toString(), 'false')

        })
        
        
    })
})
