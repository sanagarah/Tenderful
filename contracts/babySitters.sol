pragma solidity ^0.6.0;

contract babySitters {
    string public name;
    uint256 public NannyCount = 0; // trake #of nanny
    mapping(address => Nanny) public Nannies; //store the nanny Id with ather info in blockchain
    address[100] public nannyAddresses;
    address[100] public users;
    address[100] public nanniesHired;
    uint public hiredNannies = 0;
    uint public numberOfOpinioners = 0;
    uint public someOfRates = 0;
    address developers;
    uint[100] public money;

    struct Nanny {
        // all nanny data
        uint256 age;
        string name;
        string info;
        uint256 point;
    }

    constructor() public {
        // first thing will apper
        name = "Tenderful";
    }

    function registerAsNanny(string memory _name,uint256 _age, string memory _info) public {
        // Create the nanny
        // Require valid _info
      require(searchAddress(msg.sender),"Already registerd");
      require(bytes(_name).length > 0 && _age >= 18 && bytes(_info).length > 5,"Something is wrong!!");
      Nannies[msg.sender] = Nanny(_age, _name, _info,0); // nannyID ,age, name,info 
      nannyAddresses[NannyCount] = msg.sender;
      // Increment the nanny count
       NannyCount++;
    }
    
    function searchAddress(address _sender) private view returns(bool){
        bool condition = true;
        for(uint i=0;i<nannyAddresses.length;i++){
            if(nannyAddresses[i]==_sender){
                condition = false;
            }
        }
        return condition;
    }
    
     function unRegisterANanny(address _unRegister) public {
         
         
     }

    function hireNanny(address _nanny) payable public {
        require(isNotANanny(msg.sender),"Nanny cannot hireself!!");
        require(isANanny(_nanny),"She is not registerd as a nanny!");
        require(msg.value >=3 ether,"Not enough ether!!");
        money[hiredNannies] = msg.value;
        nanniesHired[hiredNannies] = _nanny;
        hiredNannies++;
    }
    
    function isNotANanny(address _sender) private view returns(bool){
        bool condition = true;
        for(uint i=0;i<nannyAddresses.length;i++){
            if(nannyAddresses[i]==_sender){
                condition = false;
            }
        }
        return condition;
    }
    
    function isANanny(address _sender) private view returns(bool){
        bool condition = false;
        for(uint i=0;i<nannyAddresses.length;i++){
            if(nannyAddresses[i]==_sender){
                condition = true;
            }
        }
        return condition;
    }

    function fireNanny(address _hiredNanny) public {
        for (uint256 i = 0; i < nanniesHired.length; i++) {
            if (_hiredNanny == nanniesHired[i]) {
                nanniesHired[i] = 0x0000000000000000000000000000000000000000;
                hiredNannies--;
            }
        }
    }
    
    function tellOpinion(address _nanny, uint _rate) public {
        require(_rate >= 0 && _rate <= 5,"Invalid rating!!");
        numberOfOpinioners++;
        uint average = calculateAverage(_rate);
        Nannies[_nanny].point=average;
    }
    function calculateAverage(uint _rate) private returns(uint) {
        someOfRates += _rate;
        uint averageCalculation = someOfRates /numberOfOpinioners;
        return averageCalculation;
    }
    
}