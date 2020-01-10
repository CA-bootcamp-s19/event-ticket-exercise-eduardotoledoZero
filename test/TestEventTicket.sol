pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EventTickets.sol";
import "../contracts/EventTicketsV2.sol";

contract TestEventTicket {

EventTickets  eventTickets;
TicketsBuyer buyer;
    
constructor() public payable{}
    
 function beforeEach() public {
    eventTickets = EventTickets(DeployedAddresses.EventTickets());  
    buyer = new TicketsBuyer();
    address(buyer).transfer(100);
    Assert.equal(address(buyer).balance, 100, "Buyer initial balance should be 100 wei.");

 }


}

contract TicketsBuyer{
    constructor() public payable{}
    function buyTicket(EventTickets _eventTickets, uint paidAmount,uint _tickets) public returns(bool){
        //address(_eventTickets).call.value(paidAmount)(abi.encodeWithSignature("buyTickets(uint256)", tickets);
        _eventTickets.buyTickets.value(paidAmount)(_tickets);
    }


    function  () external payable{}

}
