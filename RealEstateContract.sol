// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract RealEstateContract {
    address public owner;       // Owner of the contract
    uint256 private counter;    // This would increment everytim a property is purchased.

    constructor() {
        counter = 0;
        owner = msg.sender;
    }

    struct listingInfo {
        string propertyName;
        string propertyCity;
        string propertyState;
        string lat;
        string long;
        string propertyDescription;
        uint256 listingDate;
        string imgUrl;
        uint256 propertyPrice;
        uint256 id;
        string agentName;
        uint256 agentIdNumber;
        address agent;
    }

    event listingCreated (
        string propertyName,
        string propertyCity,
        string propertyState,
        string lat,
        string long,
        string propertyDescription,
        uint256 listingDate,
        string imgUrl,
        uint256 propertyPrice,
        uint256 id,
        string agentName,
        uint256 agentIdNumber,
        address agent
    );

    event propertyPurchased (
        string propertyName,
        string propertyCity,
        string propertyState,
        string imgUrl,
        uint256 propertyPrice,
        uint256 id,
        address buyer
    );

    mapping(uint256 => listingInfo) listings;
    uint256[]  public listingIds;

    function addListing(
        string memory propertyName,
        string memory propertyCity,
        string memory propertyState,
        string memory lat,
        string memory long,
        string memory propertyDescription,
        uint256 memory listingDate,
        string memory imgUrl,
        uint256 propertyPrice,
        string memory agentName,
        uint256 agentIdNumber
    ) public {
        require(msg.sender == owner, "Only the owner of the smart contract can put up property lisitngs.");
        listingInfo storage newListing = listings[counter];
        newListing.propertyName = propertyName;
        newListing.propertyCity = propertyCity;
        newListing.propertyState = propertyState;
        newListing.lat = lat;
        newListing.long = long;
        newListing.propertyDescription = propertyDescription;
        newListing.listingDate = listingDate;
        newListing.imgUrl = imgUrl;
        newListing.propertyPrice = propertyPrice;
        newListing.id = counter;
        newListing.agentName = agentName;
        newListing.agentIdNumber = agentIdNumber;
        newListing.agent = owner;
        listingInfo.push(counter);
        emit listingCreated(
            propertyName,
            propertyCity,
            propertyState,
            lat,
            long,
            propertyDescription,
            listingDate,
            imgUrl,
            propertyPrice,
            counter,
            agentName,
            agentIdNumber,
            owner);
        counter++;
    }

    function getListing(uint256 id) public view returns (string memory, uint256){
        require(id < counter, "No such listing available.");
        listingInfo storage s = listings[id];
        return (s.propertyName, s.property.propertyDescription, s.propertyPrice, s.listingDate);
    }

    function buyProperty(uint256 id, uint256 propertyPrice) public payable {
        require(id < counter, "No such property listing available.");
        require(msg.value == (listings[id].propertyPrice * 1 ether), "Please pay the asking price in order to complete the purchase.");
        require(msg.value == propertyPrice, "Please send the complete payment for the property.");
        address payable agent = listingInfo.owner;
        require(listing.id > 0 && listing.id <= counter);
        require(!listingInfo.purchased);
        require(_agent != msg.sender);
        listingInfo.owner = payable(msg.sender);
        listingInfo.purchased = true;
        listings[id] = listingInfo;
        payable(owner).transfer(msg.value);
        emit propertyPurchased(
            id,
            msg.sender,
            listings[id].propertyCity,
            listings[id].propertyState,
            listings[id].propertyPrice,
            listings[id].imgUrl
        );
    }
}