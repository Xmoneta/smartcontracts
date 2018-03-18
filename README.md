### Xmoneta Token Contract / XmonetaToken.sol
* Solidity version: **0.4.19**
* Zeppelin Solidity: **v1.5.0**
* Token name: **Xmoneta Token**
* Token symbol: **XMN**
* Token decimals: **18**
* Tokens total supply: **1 000 000 000 XMN**

ERC20 Compatible token with sales agent functionality and tokens transfer from vault method.

***

### Xmoneta Presale Contract / XmonetaPresale.sol
* Solidity version: **0.4.19**
* Zeppelin Solidity: **v1.5.0**
* Hard cap: **16 000 ETH** or **50 000 000 XMN**
* Rate without bonuses: **2 000 XMN per 1 ETH**
* Rate with 30% bonus (standard pre-sale bonus): **2 600 XMN per 1 ETH**
* Rate with 50% bonus (pre-sale more than 5 ETH bonus): **3 000 XMN per 1 ETH**

Standard sale contract with all necessary functions to sell tokens for ethers. Basic token price with 30% bonus is **2600 XMN per 1 ETH**. If buyer send 5 or more ethers, bonus will be increased to 50% and token price will be **3000 XMN per 1 ETH**. Presale will **begin on January 25th 2018 at 12:00pm UTC** and **end on February 25th 2018 at 12:00pm UTC**.

***

### Xmoneta Sale Contract / XmonetaSale.sol
* Solidity version: **0.4.21**
* Zeppelin Solidity: **v1.5.0**
* **Round A:**
  * Standard **30%** bonus: **26 000 XMN per 1 ETH**
  * Extra **50%** bonus: **30 000 XMN per 1 ETH**
  * Start date: **13th March 2018 at 12:00pm UTC**
  * End date: **5th April 2018 at 12:00pm UTC**
* **Round B:**
  * Standard **20%** bonus: **24 000 XMN per 1 ETH**
  * Extra **40%** bonus: **28 000 XMN per 1 ETH**
  * Start date: **5th April 2018 at 12:00pm UTC**
  * End date: **30th April 2018 at 12:00pm UTC**
* **Round C:**
  * Standard **10%** bonus: **22 000 XMN per 1 ETH**
  * Extra **30%** bonus: **26 000 XMN per 1 ETH**
  * Start date: **30th April 2018 at 12:00pm UTC**
  * End date: **31th May 2018 at 12:00pm UTC**

Standard sale contract with all necessary functions to sell tokens for ethers. Contract sell tokens with bonus, that are counted relative dates and transfered ETH amount. Sale will **begin on March 13th 2018 at 12:00pm UTC** and **end on May 31th 2018 at 12:00pm UTC**
