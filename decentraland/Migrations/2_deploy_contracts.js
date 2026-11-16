const Tether = artifacts.require('Tether');
const RWD = artifacts.require('rwd');
const Management = artifacts.require('Management');

module.exports = async function(deployer, network, accounts) {
  
    // Deploy Mock Tether Token
    await deployer.deploy(Tether)
    const tether = await Tether.deployed()
  
    // Deploy RWD Token
    await deployer.deploy(RWD)
    const rwd = await RWD.deployed()
  
    // Deploy DecentralBank
    await deployer.deploy(Management, rwd.address, tether.address)
    const management = await Management.deployed()
    
}
  