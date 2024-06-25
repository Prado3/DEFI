// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./JamToken.sol";
import "./StellarToken.sol";

contract TokenFarm {
    // Declaraciones iniciales
    string public name = "Stellar Token Farm";
    address public owner;
    JamToken public jamToken;
    StellarToken public stellarToken;

    // Estructuras de datos
    address [] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // constructor
    constructor(StellarToken _stellarToken, JamToken _jamToken) {
        stellarToken = _stellarToken; 
        jamToken = _jamToken;
        owner = msg.sender;
    }

    // Stake de tokens
    function stakeTokens(uint _amount) public {
        require(_amount > 0, "La cantidad no puede menor a 0");
        jamToken.transferFrom(msg.sender, address(this), _amount);
        // actualizar el saldo del staking
        stakingBalance[msg.sender] += _amount;
        // guardar el usuario staker
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        } 

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // quitar el staking de los tokens
    function unstakeTokens() public {
        //saldo del staking de un usuario
        uint balance = stakingBalance[msg.sender];
        //se requiere una cantidad superior a 0
        require(balance > 0, "El balance del staking es 0");
        // transferir al usuario
        jamToken.transfer(msg.sender, balance);
        // resetea balance en staking del usuario
        stakingBalance[msg.sender] = 0;
        // actualizar el estado de staking
        isStaking[msg.sender] = false;
    }
    
    // emision de token de recompensa
    function issueTokens() public {
        // unicamente ejecutable por el owner
        require(msg.sender == owner, "No eres el owner");
        //emitir tokens a todos los staker actuales
        for(uint i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0){
                stellarToken.transfer(recipient, balance);
            }
        }
    }

}