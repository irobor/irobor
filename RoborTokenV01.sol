pragma solidity ^0.4.18;
/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}
/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
contract Owanble{
    address public owner ;
    function Owanble(){
        owner = msg.sender ;
    } 
}
library SafeMath {
    
  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
  
}

contract TestRoborToken is ERC20, Owanble {
    using SafeMath for uint256;
    
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply; 
    
    mapping (address => uint256) balances ;
    mapping (address => mapping(address => uint256)) allowed ;
    
     // Constructor
    function TestRoborToken() public {
        symbol = "TestR";
        name = "Test Robor Token";
        decimals = 18;
        _totalSupply = 1000000 * 10**uint(decimals);
        balances[owner] = _totalSupply;
        Transfer(address(0), owner, _totalSupply);
    }
    // Total supply----
    function totalSupply() public view returns (uint256) {
        return _totalSupply  - balances[address(0)];
    }
    
    function trans( address _to, uint256 tokens) returns (bool){
        balances[_to] = balances[_to].add(tokens);
        return true ;
    } 
    
    function transfer( address _to, uint256 tokens) public returns (bool){
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[_to] = balances[_to].add(tokens);
        Transfer(msg.sender, _to, tokens);
        return true ;
    } 
    // разрешаем spender-у переводить указанное колличество токенов с нашего кошелька (owner)
    function approve(address spender, uint tokens) public returns (bool) {
        allowed[msg.sender][spender] = tokens;
        Approval(msg.sender, spender, tokens);
        return true;
    }
    // _from это адрес с котрого нужно отравить токены
    // _to это адрес куда нужно отправить
    // transferFrom(0x1111, 0x22222 или любой другой, 20) причём я это делаю с адреса  0x22222
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool){
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        Transfer(_from, _to, _value);
        return true;
    }
   // Функция проверяет кол-во токенов, которые владелец (owner) разрешил для _spender
   // скорее это для бирж
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
    
    
    function balanceOf(address _owner) public view returns(uint256){
        return balances[_owner] ;
    }
    // нужно смотреть с адреса approve(address spender)
    // msg.sender - Это кошелёк spender,
    // _from - это кошелёк с которого разрешено снимать токены
    function balancesAllowed(address _from) constant returns(uint256 balance){
        return allowed[_from][msg.sender] ;
    }
}
