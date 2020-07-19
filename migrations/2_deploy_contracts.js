var babySitters = artifacts.require("babySitters");

module.exports = function (deployer) {
  deployer.deploy(babySitters);
};
