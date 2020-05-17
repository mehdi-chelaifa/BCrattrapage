
import "./marketwithERC20.sol";

contract EmarketTest is DSTest {
    Emarket emarket;

    function setUp() public {
        emarket = new Emarket();
    }

    function testAddAnItem() public {

        string memory desc_token = "a token";
        uint price_token= 300;
        emarket.addItem(desc_token, price_token);


        assertTrue(emarket.itemCount() == 1);

    }

    function testGetItem() public {

        string memory desc_token = "a token";
        uint price_token= 300;
        emarket.addItem(desc_token, price_token);

        string memory desc;
        uint price;

        (desc, price) = emarket.getItem(1);
        assertTrue(price == 300);

    }

    function testRemoveItem() public {

        string memory desc_token = "a token";
        uint price_token= 300;
        emarket.addItem(desc_token, price_token);

        assertTrue(emarket.checkItemExisting(1));

        emarket.removeItem(1); 

        assertTrue(!emarket.checkItemExisting(1));
    }

    function testBuyItem() public {

        string memory desc_token = "a token";
        uint price_token= 300;
        emarket.addItem(desc_token, price_token);
        assertTrue(!emarket.checkItemSold(1));

        emarket.buyItem(1);
        assertTrue(emarket.checkItemSold(1));

    }

}