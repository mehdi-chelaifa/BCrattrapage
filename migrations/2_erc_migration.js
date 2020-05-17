const ERC223 = artifacts.require("ERC223.sol");

module.exports = async function(deployer) {
  await deployer.deploy(ERC223, "ERC223", "ERC223", 18)
  await ERC223.deployed()

};