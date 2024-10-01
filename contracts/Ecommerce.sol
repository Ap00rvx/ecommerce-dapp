// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ecommerce {
    struct Product {
        uint id ; 
        uint price ; 
        string name ;
        string description; 
        address payable seller; 
        bool isAvailable ; 
    }
    struct Order {
        uint orderId;
        uint productId;
        address buyer;
        uint amount;
        bool isDelivered;
        bool isDisputed;
        bool isResolved;
    }
    uint public productCount = 0 ;
    uint public orderCount = 0 ;
    address public admin; 


    constructor(){
        admin = msg.sender; 
    }
}