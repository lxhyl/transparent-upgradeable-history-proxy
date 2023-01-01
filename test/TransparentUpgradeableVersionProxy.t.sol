// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {ITransparentUpgradeableVersionProxy} from "../src/interfaces/ITransparentUpgradeableVersionProxy.sol";
import {TransparentUpgradeableVersionProxy} from "../src/TransparentUpgradeableVersionProxy.sol";

contract Implementation {}
contract TransparentUpgradeableVersionProxyTest is Test {
    ITransparentUpgradeableVersionProxy public proxy;
    
    address implementation1 ;
    address implementation2 ;
    address implementation3 ;
    address implementation4 ;
    function setUp() public {
        proxy = ITransparentUpgradeableVersionProxy(address(new TransparentUpgradeableVersionProxy(address(new Implementation()))));
        implementation1 = address(new Implementation());
        implementation2 = address(new Implementation());
        implementation3 = address(new Implementation());
        implementation4 = address(new Implementation());
    }
    function testVersion() public {
        assertEq(proxy.version(), 1);
        proxy.upgrade(implementation1);
        assertEq(proxy.historyImplementation(proxy.version()), implementation1);
        assertEq(proxy.version(), 2);
        proxy.upgrade(implementation2);
        proxy.upgrade(implementation3);
        proxy.rollback();
        assertEq(proxy.version(),5);
        assertEq(proxy.historyImplementation(proxy.version()), implementation2);
        assertEq(proxy.historyImplementation(3), implementation2);
    }
}
