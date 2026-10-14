// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.30;
contract TokenContract {

    address public owner;
    struct Receivers {
        string name;
        uint256 tokens;
    }
    mapping(address => Receivers) public users;

    uint256 public constant TOKEN_PRICE = 5 ether;

    event TokensPurchased(address indexed buyer, uint256 amount, uint256 cost);
    event TokensGiven(address indexed receiver, uint256 amount);

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor(){
        owner = msg.sender;
        users[owner].tokens = 100;
    }

    function double(uint _value) public pure returns (uint){
        return _value*2;
    }

    function register(string memory _name) public{
        users[msg.sender].name = _name;
    }

    function giveToken(address _receiver, uint256 _amount) public onlyOwner {
        require(users[owner].tokens >= _amount, "El propietario no tiene suficientes tokens");
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
        emit TokensGiven(_receiver, _amount);
    }
    function buyTokens(uint256 _amount) public payable {
        require(_amount > 0);
        
        uint256 totalCost = _amount * TOKEN_PRICE;
        require(msg.value >= totalCost, "Cantidad de Ether insuficiente. 1 token cuesta 5 Ether");
        require(users[owner].tokens >= _amount, "El propietario no dispone de suficientes tokens a la venta");

        users[owner].tokens -= _amount;
        users[msg.sender].tokens += _amount;

        if (msg.value > totalCost) {
            payable(msg.sender).transfer(msg.value - totalCost);
        }

        emit TokensPurchased(msg.sender, _amount, totalCost);
    }


    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
