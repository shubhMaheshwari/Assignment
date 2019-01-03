var Auction = artifacts.require("auction");

module.exports = function(deployer) {
	deployer.deploy(Auction, 19, 10);
};
