pragma solidity ^0.4.21;

/**
 * @title XmonetaSale
 * @author Xmoneta.com
 *
 * Zeppelin Solidity - v1.5.0
 */

// SafeMath contract from Zeppelin Solidity
import "zeppelin-solidity/contracts/math/SafeMath.sol";
// XmonetaToken contract
import "./XmonetaToken.sol";

contract XmonetaSale {

  using SafeMath for uint256;

  /* ********** Defined Variables ********** */

  // The token being sold
  XmonetaToken public token;
  // Crowdsale start timestamp - 03/13/2018 at 12:00pm (UTC)
  uint256 public startTime = 1520942400;
  // Crowdsale end timestamp - 05/31/2018 at 12:00pm (UTC)
  uint256 public endTime = 1527768000;
  // Addresses where ETH are collected
  address public wallet1 = 0x36A3c000f8a3dC37FCD261D1844efAF851F81556;
  address public wallet2 = 0x8beDBE45Aa345938d70388E381E2B6199A15B3C3;
  // How many token per wei
  uint256 public rate = 20000;
  // Cap in ethers
  uint256 public cap = 8000 * 1 ether;
  // Amount of raised wei
  uint256 public weiRaised;

  // Round B start timestamp - 05/04/2018 at 12:00pm (UTC)
  uint256 public round_b_begin_date = 1522929600;
  // Round B start timestamp - 30/04/2018 at 12:00pm (UTC)
  uint256 public round_c_begin_date = 1525089600;

  /* ********** Events ********** */

  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 weiAmount, uint256 tokens);

  /* ********** Functions ********** */

  // Contract constructor
  function XmonetaSale() public {
    token = XmonetaToken(0x99705A8B60d0fE21A4B8ee54DB361B3C573D18bb);
  }

  // Fallback function to buy tokens
  function () public payable {
    buyTokens(msg.sender);
  }

  // Bonus calculation for transaction
  function bonus_calculation() internal returns (uint256, uint256) {
    // Round A Standard bonus & Extra bonus
    uint256 bonusPercent = 30;
    uint256 extraBonusPercent = 50;

    if (now >= round_c_begin_date) {
      // Round C Standard bonus & Extra bonus
      bonusPercent = 10;
      extraBonusPercent = 30;
    } else if (now >= round_b_begin_date) {
      // Round B Standard bonus & Extra bonus
      bonusPercent = 20;
      extraBonusPercent = 40;
    }

    return (bonusPercent, extraBonusPercent);
  }

  // Token purchase function
  function buyTokens(address beneficiary) public payable {
    require(validPurchase());

    uint256 weiAmount = msg.value;

    // Send spare wei back if investor sent more that cap
    uint256 tempWeiRaised = weiRaised.add(weiAmount);
    if (tempWeiRaised > cap) {
      uint256 spareWeis = tempWeiRaised.sub(cap);
      weiAmount = weiAmount.sub(spareWeis);
      beneficiary.transfer(spareWeis);
    }

    // Define standard and extra bonus variables
    uint256 bonusPercent;
    uint256 extraBonusPercent;

    // Execute calculation
    (bonusPercent, extraBonusPercent) = bonus_calculation();

    // Accept extra bonus if beneficiary send more that 1 ETH
    if (weiAmount >= 1 ether) {
      bonusPercent = extraBonusPercent;
    }

    // Token calculations with bonus
    uint256 additionalPercentInWei = rate.div(100).mul(bonusPercent);
    uint256 rateWithPercents = rate.add(additionalPercentInWei);

    // Calculate token amount to be sold
    uint256 tokens = weiAmount.mul(rateWithPercents);

    // Update state
    weiRaised = weiRaised.add(weiAmount);

    // Tranfer tokens from vault
    token.transferTokensFromVault(msg.sender, beneficiary, tokens);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    forwardFunds(weiAmount);
  }

  // Send wei to the fund collection wallets
  function forwardFunds(uint256 weiAmount) internal {
    uint256 value = weiAmount.div(2);

    // If buyer send amount of wei that can not be divided to 2 without float point, send all weis to first wallet
    if (value.mul(2) != weiAmount) {
      wallet1.transfer(weiAmount);
    } else {
      wallet1.transfer(value);
      wallet2.transfer(value);
    }
  }

  // Validate if the transaction can be success
  function validPurchase() internal constant returns (bool) {
    bool withinCap = weiRaised < cap;
    bool withinPeriod = now >= startTime && now <= endTime;
    bool nonZeroPurchase = msg.value != 0;
    return withinPeriod && nonZeroPurchase && withinCap;
  }

  // Show if crowdsale has ended or no
  function hasEnded() public constant returns (bool) {
    return now > endTime || weiRaised >= cap;
  }

}
