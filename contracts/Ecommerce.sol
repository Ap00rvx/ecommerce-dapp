// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

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

    }
    uint public productCount = 0 ;
    string public nameOfDeveloper; 
    uint public orderCount = 0 ;
    address public admin; 

    mapping(uint => Product) public products; 
    mapping(uint => Order) public orders; 

    event ProductAdded(uint productId, string name, uint price, address indexed seller);
    event ProductPurchased(uint orderId, uint productId, address indexed buyer);
    event ProductDelivered(uint orderId, uint productId, address indexed buyer);
    
    modifier onlySeller(uint _productId) {
        require(products[_productId].seller == msg.sender, "Only seller can call this function");
        _;
    }
    modifier onlyBuyer(uint _orderId) {
        require(orders[_orderId].buyer == msg.sender, "Only buyer can call this function");
        _;
    }


    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    constructor(){
        admin = msg.sender; 
    }
    
    function testDevelopment()public{
        nameOfDeveloper = "Apurva"; 
    }


    function addProduct(string memory _name, string memory _description, uint _price) public {
        require(_price > 0, "Price must be greater than zero");

        productCount++;
        products[productCount] = Product(productCount,_price, _description,_name , payable(msg.sender), true);

        emit ProductAdded(productCount, _name, _price, msg.sender);
    }
        function buyProduct(uint _productId) public payable {
        Product memory product = products[_productId];
        require(product.isAvailable, "Product not available for purchase");
        require(msg.value == product.price, "Incorrect Ether sent for purchase");

       
        orderCount++;
        orders[orderCount] = Order(orderCount, _productId, msg.sender, msg.value, false);

        emit ProductPurchased(orderCount, _productId, msg.sender);
    }
    function markAsDelivered(uint _orderId) public onlySeller(orders[_orderId].productId) {
        Order storage order = orders[_orderId];
        require(!order.isDelivered, "Order already marked as delivered");

        order.isDelivered = true;
        
        Product memory product = products[order.productId];
        product.seller.transfer(order.amount);

        emit ProductDelivered(_orderId, order.productId, order.buyer);
    }
        function getProduct(uint _productId) public view returns (uint, string memory, string memory, uint, address, bool) {
        Product memory product = products[_productId];
        return (product.id, product.name, product.description, product.price, product.seller, product.isAvailable);
    }


    function getOrder(uint _orderId) public view returns (uint, uint, address, uint, bool) {
        Order memory order = orders[_orderId];
        return (order.orderId, order.productId, order.buyer, order.amount, order.isDelivered);
    }
}