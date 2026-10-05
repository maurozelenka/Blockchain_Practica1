pragma solidity ^0.4.25;

contract ZombieFactory {

    // 1. Declaración del evento NewZombie
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        // 5. Guardamos el índice del nuevo zombi en la variable 'id'
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        
        // 3. Emitimos el evento pasando id, _name y _dna
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
