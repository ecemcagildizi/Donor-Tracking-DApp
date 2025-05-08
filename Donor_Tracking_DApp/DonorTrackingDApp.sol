// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This project name is Donor Tracking App. I created owner and this owner can do check own balance and can do withdraw.
// And the donors just can do send ETH. When the donor sends ETH, displays name, donor address, amount and timestamp information of process in terminal.  

contract DonorTrackingDApp{
    address public owner;

    mapping(address => uint) public balances;  // This code is for getting balance of address.

    constructor(){
        owner = msg.sender;
    }

    function getBalances() public view returns (uint){
        return address(this).balance;
    }

    function withdraw(uint amount) public{
        require(msg.sender == owner,'Just owner can withdraw');
        balances[owner] -= amount;
        payable(msg.sender).transfer(amount);
    }



    // Donor information kept in struct.
    struct Donor{
        string name;
        address donor_address;
        uint amount;
        uint timestamp;
    }

    Donor[] public donorList;  // This is keeps to donors list.


    event Transferred(address donor_address,address owner, uint amount);

    // This function built for sends donation.
    function transfer(string memory _name) public payable{
        balances[msg.sender] += msg.value;

        Donor memory newDonor = Donor({
            name : _name,
            donor_address : msg.sender,
            amount : msg.value,
            timestamp: block.timestamp
        });

        donorList.push(newDonor);

        emit Transferred(msg.sender,owner,msg.value);
    }

    function getDonors() public view returns (Donor[] memory){
        return donorList;
    }
}