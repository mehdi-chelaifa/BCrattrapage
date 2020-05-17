pragma solidity >=0.4.24 <0.7.0;

contract ERC20{

    string public constant _name="Token";
    string public constant _symbol="T";
    uint8 public constant _decimals=8;
    uint256 _totalSupply=100;
    address public own;  

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    constructor() public
    {
        balances[msg.sender] = _totalSupply;
        own=msg.sender;
    }


    function name() public pure returns (string memory)
    {
        return _name;
    }

    function symbol() public pure returns (string memory)
    {
        return _symbol;
    }

    function decimals() public pure returns (uint8)
    {
        return 8;
    }

    
    function totalSupply() public view returns (uint256)
    {
        return _totalSupply ;
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance)
    {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool)
    {
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool)
    {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from] - _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

        
    function allowance(address _owner, address _spender) public view returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }

   
}