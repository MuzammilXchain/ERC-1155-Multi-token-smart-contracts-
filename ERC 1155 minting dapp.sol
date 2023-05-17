// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.3/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.8.3/access/Ownable.sol";

contract MyToken is ERC1155, Ownable {
    uint16 [] Supplies =[50, 100, 150];
    uint256 [] minted = [0,0,0];
    uint256 [] rates = [0.05 ether , 0.1 ether, 0.0025 ether ];
    constructor() ERC1155("https://api.mysite.com/token/{id}") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint( uint256 id, uint256 amount)
        public payable 
        
    {
        require(id <= Supplies.length, "Token doesn't exists" );
        require(id != 0 ,"Token doesn't exists");
        uint256 index = id-1;
        require (msg.value  >= amount * rates[index], " Not enogh ether");
        
        require ( minted [index] + amount <= Supplies[index], "Not enough supply ");
        minted[index] <= amount;

        _mint(msg.sender, id, amount, "");
    }

    function withdarw () public onlyOwner 
    {
        require (address(this).balance >=0);
        payable(owner()).transfer(address(this).balance);
    }
}
