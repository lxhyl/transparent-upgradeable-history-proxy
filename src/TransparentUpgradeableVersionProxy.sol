// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {TransparentUpgradeableProxy} from "openzeppelin-contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ITransparentUpgradeableVersionProxy} from "./interfaces/ITransparentUpgradeableVersionProxy.sol";
contract TransparentUpgradeableVersionProxy is ITransparentUpgradeableVersionProxy,TransparentUpgradeableProxy {
    uint256 public override version = 1;
    
    mapping(uint256 => address) override public historyImplementation;
    constructor(address implementationInit)
        TransparentUpgradeableProxy(implementationInit, msg.sender, "")
    {
        historyImplementation[version] = implementationInit;
    }
    function upgrade(address newImplementation) public ifAdmin {
        _upgradeToAndCall(newImplementation, bytes(""), false);
        version++;
        historyImplementation[version] = newImplementation;
    }
    function rollback() external {
      backToVersion(version - 1);
    }
    function backToVersion(uint256 toVersion) public ifAdmin{
       address implementationByVersion = historyImplementation[toVersion];
       upgrade(implementationByVersion);
    }
}
