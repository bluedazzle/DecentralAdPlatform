pragma solidity ^0.4.17;

contract Adx {

  address[10] public advs;  // 广告主与广告计划
  uint[10] public bids; // 出价表
  mapping(address => uint) budgets; // 预算
  address creator; // 合约创建者

  function Adx() public payable {
      creator = msg.sender;
  }

  // 创建广告
  function createAd(uint adId, uint bid, uint budget) public payable{
    advs[adId] = msg.sender;
    bids[adId] = bid;
    budgets[msg.sender] = budget;
    this.transfer(msg.value);
  }

  // 修改出价
  function modifyBid(uint adId, uint bid) public {
      bids[adId] = bid;
  }

  // 获取竞价胜利广告
  function getAd() public view returns (uint) {
    uint adId = 0;
    uint hightestBid = 0;
    for (uint8 i = 0; i < bids.length; i++){
        if(bids[i] > hightestBid && budgets[msg.sender] > bids[i]){
            adId = i;
            hightestBid = bids[i];
        }
    }
    return adId;
  }


  // 计费（分钱）
  function chargeingAd(uint adId) public payable {
      uint bid = bids[adId];
      budgets[msg.sender] = budgets[msg.sender] - bid;
      msg.sender.transfer(bid / 2);
      creator.transfer(bid / 2);
  }

  function () public payable {

  }

}