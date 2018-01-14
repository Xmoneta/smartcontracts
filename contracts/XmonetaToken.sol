pragma solidity ^0.4.19;

/**
 * @title XmonetaToken
 * @author Xmoneta.com
 *
 * ERC20 Compatible token
 * Zeppelin Solidity - v1.5.0
 */

// Contract interfaces from Zeppelin Solidity
import "zeppelin-solidity/contracts/token/StandardToken.sol";
import "zeppelin-solidity/contracts/ownership/Claimable.sol";

contract XmonetaToken is StandardToken, Claimable {

  /* ********** Token Predefined Information ********** */

  string public constant name = "Xmoneta Token";
  string public constant symbol = "XMN";
  uint256 public constant decimals = 18;

  /* ********** Defined Variables ********** */

  // Total tokens supply 1 000 000 000
  // For ethereum wallets we added decimals constant
  uint256 public constant INITIAL_SUPPLY = 1000000000 * (10 ** decimals);
  // Vault where tokens are stored
  address public vault = msg.sender;
  // Sales agent who has permissions to manipulate with tokens
  address public salesAgent;

  /* ********** Events ********** */

  event SalesAgentAppointed(address indexed previousSalesAgent, address indexed newSalesAgent);
  event SalesAgentRemoved(address indexed currentSalesAgent);
  event Burn(uint256 valueToBurn);

  /* ********** Functions ********** */

  // Contract constructor
  function XmonetaToken() public {
    owner = msg.sender;
    totalSupply = INITIAL_SUPPLY;
    balances[vault] = totalSupply;
  }

  // Appoint sales agent of token
  function setSalesAgent(address newSalesAgent) onlyOwner public {
    SalesAgentAppointed(salesAgent, newSalesAgent);
    salesAgent = newSalesAgent;
  }

  // Remove sales agent from token
  function removeSalesAgent() onlyOwner public {
    SalesAgentRemoved(salesAgent);
    salesAgent = address(0);
  }

  // Transfer tokens from vault to account if sales agent is correct
  function transferTokensFromVault(address fromAddress, address toAddress, uint256 tokensAmount) public {
    require(salesAgent == msg.sender);
    balances[vault] = balances[vault].sub(tokensAmount);
    balances[toAddress] = balances[toAddress].add(tokensAmount);
    Transfer(fromAddress, toAddress, tokensAmount);
  }

  // Allow the owner to burn a specific amount of tokens from the vault
  function burn(uint256 valueToBurn) onlyOwner public {
    require(valueToBurn > 0);
    balances[vault] = balances[vault].sub(valueToBurn);
    totalSupply = totalSupply.sub(valueToBurn);
    Burn(valueToBurn);
  }

}
