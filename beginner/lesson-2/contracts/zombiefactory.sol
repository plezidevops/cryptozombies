// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

contract ZombieFactory {

    // NewZombie event to inform when a new zombie is created
    event NewZombie(uint zombieId, string name,  uint dna);

    // zombie dna is composed of 16-didgits
    uint dnaDigits = 16;

    // Making our zombie's DNA is 16 characters
    uint dnaModulus = 10 ** dnaDigits;

    // collection of zombies and dna
    struct Zombie {
        string name;
        uint dna;
    }

    // Place holder for zombies and theirs dna
    Zombie[] public zombies;

    // keeps track of the address that owns a zombie
    mapping (uint => address) public zombieToOwner;

    // keeps track of how many zombies an owner has
    mapping (address => uint) ownerZombieCount;

    // _createZombie creates zombies and their dna
    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender; // the address that create that zombie
        ownerZombieCount[msg.sender]++; // the number of zombies that adress created
        // fire an event to let the app know the function was called:
        emit NewZombie(id, _name, _dna);
    }

    // _generateRandomDna creates random dna for zombies
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // createRandomZombie creates and stored random zombie on the blockchain database
    function createRandomZombie(string memory _name) public {
        // making sure user's call this function once
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}