pragma solidity >=0.4.24 <0.7.0;

import "./ERC20.sol";

contract marketwithERC20 {
	struct Item {
	    string description;
	    address seller;
	    address buyer;
	    uint price;
	    bool sold;
	}

	ERC20 public emark;

	mapping(uint256=>Item) public items;
	uint256 public itemCount;

	constructor (address _emark) public {
		emark = ERC20(_emark);
	}

	function addItem(string memory _description, uint _price) public returns(uint) {
	    itemCount++;
	    items[itemCount].description = _description;
	    items[itemCount].seller = msg.sender;
	    items[itemCount].price = _price;
	    return itemCount;
	}

	function getItem(uint _index) public view returns(string memory, uint){
	    Item storage i = items[_index];
	    require(i.seller != address(0), "no such item"); 
	    return(i.description, i.price);
	}


	function removeItem(uint _index) public {
	    Item storage i = items[_index];
	    require(i.seller != address(0), "no such item"); 
	    require(i.seller == msg.sender, "only seller can remove item");
	    require(!i.sold, "item sold already");
	    delete items[_index];
	}

	function buyItem(uint _index) public {
	    Item storage i = items[_index];
	    require(i.seller != address(0), "no such item"); 
	    require(!i.sold, "item sold already");
	    require(i.price <= emark.balanceOf(msg.sender), "not enough tokens");
	    i.buyer = msg.sender;
	    i.sold = true;
	    emark.transferFrom(msg.sender, i.seller, i.price);
	}

}