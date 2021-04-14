const Batch = artifacts.require('Batch');

module.exports = function(_deployer) {
    _deployer.deploy(Batch)
};
