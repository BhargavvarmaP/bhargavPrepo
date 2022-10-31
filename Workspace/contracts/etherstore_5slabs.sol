//SPDX-License-Identifier:MIT
pragma solidity >=0.4.0 <0.9.0;
contract EtherStore_Slabs{
    uint public maxslab=10 ether;
    mapping(uint=>mapping(address=>uint)) public slots;
    mapping(uint=>uint) public slotbal;
    uint public id;
    uint256 public interval=2 ether;
    receive() payable external{}
    function deposit() payable public {
          uint amount = msg.value;
          require(maxslab!=0,"vault full");
            (bool sent,)=payable(address(this)).call{value:amount}("");
            require(sent,"Transaction failed");
            slotbal[id]=maxslab;
        if(amount<=slotbal[id]&&slots[id][msg.sender]<=slotbal[id]){
            slots[id][msg.sender]+=amount;
            slotbal[id]-=amount;
            updatebal();
        }
        else {
              slots[id][msg.sender]+=amount;
              updatebal();
        }
    }
    function updatebal() internal{
            if(slots[id][msg.sender]>maxslab){ 
               uint x=slots[id][msg.sender]-maxslab;
               slots[id][msg.sender]-=x;
               slotbal[id]=slots[id][msg.sender];
               id++;
               maxslab-=interval;
               if(maxslab!=0){
               slots[id][msg.sender]+=x;
               }
               else{
                   revert("Enter less amount Slab is almost full ");
               }
            }
    }   
    function withdraw() payable public {
        for(uint256 i=0;i<=id;i++){
           uint256 amount = slots[id][msg.sender];
           slots[id][msg.sender]-=amount;
            (bool sent,)=payable(msg.sender).call{value:amount}("");
            require(sent,"Tx failed");
        }
    }    
}       