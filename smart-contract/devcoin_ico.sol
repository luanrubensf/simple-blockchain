// DevCoins ICO

// prama solidity ^0.4.11;

contract devcoin_ico {
    
    // total number of coins available
    uint public max_devcoins = 1000000;
    
    // USD to devcoin conversion rate
    uint public usd_to_devcoins = 1000;
    
    // total number of devcoins bouht by the investors
    uint public total_bought = 0;
    
    // mapping investor address to its equity in devcoins and USD
    mapping(address => uint) equity_devcoins;
    mapping(address => uint) equity_usd;
    
    modifier can_buy_devcoins(uint usd_amount) {
        require (usd_amount * usd_to_devcoins + total_bought <= max_devcoins);
        _;
    }
    
    function buy_devcoins(address investor, uint usd_amount) external can_buy_devcoins(usd_amount) {
        uint devcoins_bought = usd_amount * usd_to_devcoins;
        equity_devcoins[investor] += devcoins_bought;
        equity_usd[investor] += usd_amount;
        total_bought += devcoins_bought;
    }
    
    function sell_devcoins(address investor, uint devcoins_sold) external {
        uint usd_sold = devcoins_sold / usd_to_devcoins;
        equity_devcoins[investor] -= devcoins_sold;
        equity_usd[investor] -= usd_sold;
        total_bought -= devcoins_sold;
    }
    
    function equity_in_devcoins(address investor_address) external view returns (uint) {
        return equity_devcoins[investor_address];
    }
    
    function equity_in_usd(address investor_address) external view returns (uint) {
        return equity_usd[investor_address];
    }
}

