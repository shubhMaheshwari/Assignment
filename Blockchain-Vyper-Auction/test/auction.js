var Auction = artifacts.require("auction");

// Helps is asserting events
const truffleAssert = require("truffle-assertions");

contract("auction", accounts => {
	const owner = accounts[0];
	describe("constructor", () => {
		describe("Assert Contract is deployed", () => {
			it("should deploy this contract", async () => {
				const instance = await Auction.new(19, 10, { from: owner });

				let q = await instance.q.call();
				let M = await instance.M.call();

				assert.isNotNull(instance);
				assert.equal(q.toNumber(), 19);
				assert.equal(M.toNumber(), 10);

				// Taken from https://github.com/rkalis/truffle-assertions
				let result = await truffleAssert.createTransactionResult(
					instance,
					instance.transactionHash
				);

				truffleAssert.eventEmitted(result, "AuctionStarted");
			});
		});
		describe("Fail case", () => {
			it("should revert on invalid from address", async () => {
				try {
					const instance = await Auction.new(19, 10, {
						from: "lol"
					});
					assert.fail(
						"should have thrown an error in the above line"
					);
				} catch (err) {
					assert.equal(err.message, "invalid address");
				}
			});
		});
	});
	describe("Notary Register", () => {
		let instance;

		beforeEach(async () => {
			instance = await Auction.new(19, 10, { from: owner });
		});

		describe("Success Case", () => {
			it("1 Notary can successfully register and event is emitted", async () => {
				let result = await instance.notaryRegister({
					from: accounts[1]
				});
				truffleAssert.eventEmitted(result, "NotaryRegister");
				assert.equal(
					await instance.notaries_size.call(),
					1,
					"num of notaries should be 1"
				);
			});
		});

		describe("Success Case", () => {
			it("4 notaries can register, and we can check with notaries_size", async () => {
				await instance.notaryRegister({ from: accounts[1] });
				await instance.notaryRegister({ from: accounts[2] });
				await instance.notaryRegister({ from: accounts[3] });
				await instance.notaryRegister({ from: accounts[4] });
				assert.equal(
					await instance.notaries_size.call(),
					4,
					"There should be 4 Registered Notaries"
				);
			});
		});

		describe("Fail Case", () => {
			it("notary cannot register with owner address", async () => {
				try {
					await instance.notaryRegister({ from: accounts[0] });
				} catch (err) {
					assert.equal(
						err.message,
						"VM Exception while processing transaction: revert"
					);
				}
			});
		});

		describe("Fail Case", () => {
			it("Notary cannot register twice", async () => {
				await instance.notaryRegister({ from: accounts[1] });
				try {
					await instance.notaryRegister({ from: accounts[1] });
				} catch (err) {
					assert.equal(
						err.message,
						"VM Exception while processing transaction: revert"
					);
				}
			});
		});
	});
	describe("Bidder Register", () => {
		let instance;

		beforeEach(async () => {
			instance = await Auction.new(19, 10, { from: owner });
			await instance.notaryRegister({ from: accounts[1] });
			await instance.notaryRegister({ from: accounts[2] });
			await instance.notaryRegister({ from: accounts[3] });
			await instance.notaryRegister({ from: accounts[4] });
		});

		describe("Success Case", () => {
			it("Bidder can register with new address", async () => {
				let result = await instance.bidderRegister(
					[12, 12],
					[8, 9],
					[5, 6],
					2,
					{
						from: accounts[5],
						value: web3.toWei(16, "wei")
					}
				);
				truffleAssert.eventEmitted(result, "BidderRegister");
				assert.equal(
					await instance.bidders_size.call(),
					1,
					"num of bidders should be 1"
				);
			});
		});

		describe("Fail case", () => {
			it("bidder should deposit min value of w*sqrt(num_items) wei", async () => {
				try {
					await instance.bidderRegister([12, 12], [8, 9], [5, 6], 2, {
						from: accounts[5],
						value: web3.toWei(1, "wei")
					});
					assert.fail(
						"should have thrown an error in the above line"
					);
				} catch (err) {
					assert.equal(
						err.message,
						"VM Exception while processing transaction: revert"
					);
				}
			});
		});

		describe("Fail case", () => {
			it("bidder should not be Registered as notary", async () => {
				try {
					await instance.bidderRegister([12, 12], [8, 9], [5, 6], 2, {
						from: accounts[1],
						value: web3.toWei(16, "wei")
					});
					assert.fail(
						"should have thrown an error in the above line"
					);
				} catch (err) {
					assert.equal(
						err.message,
						"VM Exception while processing transaction: revert"
					);
				}
			});
		});
		describe("success case", () => {
			it("multiple bidders can successfully register", async () => {
				await instance.bidderRegister([12, 12], [8, 9], [5, 6], 2, {
					from: accounts[5],
					value: web3.toWei(16, "wei")
				});
				await instance.bidderRegister(
					[7, 12, 11],
					[1, 9, 11],
					[4, 6],
					3,
					{ from: accounts[6], value: web3.toWei(18, "wei") }
				);
				await instance.bidderRegister([13, 12], [10, 8], [3, 4], 2, {
					from: accounts[7],
					value: web3.toWei(16, "wei")
				});
				assert.equal(
					await instance.bidders_size.call(),
					3,
					"num of bidders should be 3"
				);
			});
		});
	});
	describe("Winner Determination", () => {
		let instance;
		beforeEach(async () => {
			console.log("before");
			accounts.forEach(x => {
				console.log("in account " + x);
				console.log(web3.fromWei(web3.eth.getBalance(x)).toNumber());
			});
			instance = await Auction.new(19, 10, { from: owner });
			await instance.notaryRegister({ from: accounts[1] });
			await instance.notaryRegister({ from: accounts[2] });
			await instance.notaryRegister({ from: accounts[3] });
			await instance.notaryRegister({ from: accounts[4] });
			// 1, 2 || 11
			await instance.bidderRegister([12, 12], [8, 9], [5, 6], 2, {
				from: accounts[5],
				value: web3.toWei(16, "wei")
			});
			// 8, 4, 3 || 10
			await instance.bidderRegister([7, 13, 11], [1, 10, 11], [4, 6], 3, {
				from: accounts[6],
				value: web3.toWei(18, "wei")
			});

			// 4, 1 || 7
			await instance.bidderRegister([13, 12], [10, 8], [3, 4], 2, {
				from: accounts[7],
				value: web3.toWei(16, "wei")
			});
			// 4, 5 || 9
			await instance.bidderRegister([13, 13], [10, 11], [8, 1], 2, {
				from: accounts[8],
				value: web3.toWei(20, "wei")
			});
		});
		describe("success case", () => {
			it("check payments", async () => {
				result = await instance.winnerDetermine({ from: owner });
				// assert.equal(
				// 	await instance.total_winners.call(),
				// 	2,
				// 	"num of winners should be 2"
				// );

				console.log("after");
				accounts.forEach(x => {
					console.log("in account " + x);
					console.log(
						web3.fromWei(web3.eth.getBalance(x)).toNumber()
					);
				});
			});
		});
	});
});
