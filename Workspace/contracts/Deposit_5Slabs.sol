//SPDX-License-Identifier:MIT
pragma solidity >=0.4.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract Deposit_5Slabs {

    address tokenAddress;    //address of the ERC20 token which is to be deposited by users
    uint256 public maxslab=500; //size of current maximum slab
    uint256 public interval=100; //decrement of slabsize for next slabs
    uint256 public slabs; // slab counter

    event DepositedTokens(address indexed Depositor,uint256 amount);
    event Withdrawtokens(address indexed Depositor,uint256 amount);
    // useraddress => slab => balance ----------- User Balances
    mapping(address=>mapping(uint256=>uint256)) public Balances;
    // slab => Remaining balance of slab ---------- tracks the slab balances 
    mapping(uint=>uint) public slab_track;
    
    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }
    // Deposit funcctions to deposit ERC20 tokens by users
     function Deposit( uint256 _amount) public  {

        require(IERC20(tokenAddress).balanceOf(msg.sender) >= _amount, "Amount must be less than wallet funds"); 
        require(IERC20(tokenAddress).approve(address(this), _amount));
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _amount),"Token Deposit Failed");
        require(maxslab!=0,"All Slabs Visited"); 

            slab_track[slabs]= maxslab; // Assigning the current capacity of slab to slab balance

        if (_amount<=slab_track[slabs] && Balances[msg.sender][slabs]<=slab_track[slabs] ) {
            
            Balances[msg.sender][slabs]+=_amount;

            slab_track[slabs]-=_amount;
            Updateslab(msg.sender);
        }
        else {
              Balances[msg.sender][slabs]+=_amount;
              Updateslab(msg.sender);
        }
        emit DepositedTokens(msg.sender,_amount);
    }
    //Updateslab function is to update the values of slab effectiely
    function Updateslab(address _addr) internal {

            if(Balances[_addr][slabs]>maxslab){

               uint256 temp = Balances[_addr][slabs]-maxslab;
               Balances[_addr][slabs]-=temp;
               slab_track[slabs]=Balances[_addr][slabs];
               
               slabs++;
               maxslab-=interval;

            if(maxslab!=0){

               Balances[_addr][slabs]+=temp;
               
               }

            else{
                   revert("Enter less amount Slab is almost full ");
               }
            }
    }   
    //WithdrawTokens function is to withdraw all the tokens by user from all the slabs
    function WithdrawTokens() public {
        uint256 amount ;

        for(uint256 i=0;i<=slabs;i++){

           require(Balances[msg.sender][i]!=0);
           amount += Balances[msg.sender][i];
           Balances[msg.sender][i]-=amount;
       
        }
       require(IERC20(tokenAddress).transfer(msg.sender, amount), "withdraw failed");
       emit Withdrawtokens(msg.sender,amount);
    }  
    //DepositInfo function is to giving information about deposited tokens in different slabs 
    function DepositInfo() public view returns(uint256[] memory) {

        uint256[] memory Storedslots=new uint256[](slabs);
        
        for(uint256 i=0;i<slabs;i++){
            require(Balances[msg.sender][i]!=0);
            Storedslots[i]=i; 
        }
        return Storedslots;
    } 

    }