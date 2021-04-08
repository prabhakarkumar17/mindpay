pragma solidity ^0.6.0;

abstract contract erc20{
    function totalSupply() virtual public returns(uint);
    function balanceOf(address owner_token) virtual public returns (uint balance);
    function allowance(address owner_token, address spender) virtual public returns(uint remaining);
    function transfer(address to, uint input_tokens) virtual public returns (bool success);
    function approve(address spender, uint tokens) virtual public returns (bool success);
    function transferFrom(address sender, address to, uint tokens) virtual public returns (bool success);
    
    event Transfer(address indexed sender, address indexed to, uint tokens);
    event Approval(address indexed owner_token, address indexed spender, uint tokens);
}

contract presale is erc20 {
    
    uint public _totalSupply;
    string public symbol;
    string public name;
    
    uint public input_tokens;
    address public user_address;
    
    mapping (address => uint) balances;
    mapping (address => uint) bonusToken;
    mapping (address => uint) invested;
    mapping (address => uint) token_purchased;
    mapping (address => mapping(address => uint)) allowed;
    
    event totalInvestmentByUser(uint totalToken);
    event totalTokenPurchasedByUser(uint value);
    event totalntwrkInv(uint _value);
    
    constructor() payable public {
        symbol = "MP";
        name = "MINDPAY";
        _totalSupply = 1000000;
        balances[0x4BBD291965245Bf62344A61C691F254629640f5f] = _totalSupply;
    }
    
    function totalSupply() override public returns (uint) {
        return _totalSupply - balances[address(0)];
    }
    
    function balanceOf(address owner_token) override public returns (uint balance) {
        emit totalntwrkInv(_totalSupply - balances[address(0)]);
        return balances[owner_token];
    }
    
    function transfer(address user_address, uint input_tokens) virtual override public returns (bool success){
        
        input_tokens = input_tokens * 8000;
        bonusToken[user_address] = 100;
        
        if(input_tokens < 1){
            
            bonusToken[user_address] = 100;
        } else if(input_tokens >= 1 && input_tokens < 3){
            
            bonusToken[user_address] = 200;
        } else if(input_tokens >= 3){
            
            bonusToken[user_address] = 500;
        }
        
        require(input_tokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - input_tokens;
        balances[user_address] = balances[user_address] + input_tokens + bonusToken[user_address];
        
        emit Transfer(msg.sender, user_address, input_tokens);
        return true;
    }
    
    function approve(address spender, uint tokens) override public returns (bool succcess) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function transferFrom(address sender, address to, uint tokens) override public returns (bool success) {
        require(tokens <= balances[sender]);
        balances[sender] = balances[sender] - tokens;
        
        require(tokens <= allowed[sender][msg.sender]);
        allowed[sender][msg.sender] = allowed[sender][msg.sender] - tokens;
        
        balances[to] = balances[to] + tokens;
        
        emit Transfer(sender, to, tokens);
        return true;
        
    }
    
    function allowance(address owner_token, address spender) override public returns (uint remaining){
        return allowed[owner_token][spender];
    }
    
}