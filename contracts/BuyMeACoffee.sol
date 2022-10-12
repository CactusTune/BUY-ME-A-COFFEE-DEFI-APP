// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "hardhat/console.sol";

//contract deployed to goerli testnet at 0x0B2465eA52eef2D679576B701D3CA3EB95e97F20

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint timestamp;
        string name;
        string message;
    }


    Memo[] memos;

    address payable owner ;

    constructor() {
        owner = payable(msg.sender);

    }
     
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
             msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function returnMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
