const BabySitters = artifacts.require("./babySitters.sol");

contract("BabySitters", () => {
  let babySitters;

  before(async () => {
    babySitters = await BabySitters.deployed();
  });

  describe("deployment", async () => {
    it("The address is correct", async () => {
      const address = await babySitters.address;
      assert.notEqual(address, "");
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
    });

    it("The name is correct", async () => {
      const name = await babySitters.name();
      assert.equal(name, "Tenderful");
    });
  });
});
