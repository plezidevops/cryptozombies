// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

import "./zombiefactory.sol";

contract zombiefeeding is ZombieFactory {

  // feedAndMultiply gives zombie ability to feed and multiply
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    // only zombies owner can feed them
    require(msg.sender == zombieToOwner[_zombieId]);
    // need to get zombie's DNA
    Zombie storage myZombie = zombies[_zombieId];
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }
}