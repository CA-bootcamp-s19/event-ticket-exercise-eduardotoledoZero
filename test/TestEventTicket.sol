pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EventTickets.sol";
import "../contracts/EventTicketsV2.sol";

contract TestEventTicket {

EventTickets  eventTickets;
TicketsBuyer buyer;
    
constructor() public payable{}
  function () external payable {}
 uint256 ticketPrice = 100;
 function beforeEach() public {
    eventTickets =  new EventTickets("Dsc", "Web", 100);
    buyer = new TicketsBuyer();
    //address(buyer).transfer(100);
    //Assert.equal(address(buyer).balance, 100, "Buyer initial balance should be 100 wei.");

 }

 function testreadEvent() 
    public 
{
    
   (string memory description, string memory website, uint totalTickets, uint sales, bool isOpen) = 
                eventTickets.readEvent();
    Assert.equal(description, "Dsc", "Event Description should be Dsc");
    Assert.equal(website, "Web", "Event Website should be Web");
    Assert.equal(totalTickets, 100, "Event Total tickets should be 100");
 }

 function testBuyerHasNoEnoughFunds()
    public
 {
    uint numberOfTicketsToBuy= 1;    
    bool result = buyer.buyTickets(eventTickets,  numberOfTicketsToBuy * ticketPrice , numberOfTicketsToBuy );
    Assert.isFalse(result, "Buyer  Paid Right Price ");
 }


}

contract TicketsBuyer{
    constructor() public payable{}
    function buyTickets(EventTickets _eventTickets, uint paidAmount,uint _tickets) 
    public 
    returns(bool)
    {
        (bool r, bytes memory b) = address(_eventTickets).call.value(paidAmount)(abi.encodeWithSignature("buyTickets(uint256)", _tickets));
        //_eventTickets.buyTickets.value(paidAmount)(_tickets);
        return r;
    }


    function  () external payable{}

}
