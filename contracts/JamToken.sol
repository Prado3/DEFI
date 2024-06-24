// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract JamToken {
    // Declaraciones
    string public name = "JAM Token";
    string public symbol = "JAM";
    uint256 public totalSupply = 1000000000000000000000000;
    uint8 public decimals = 18;

    // Evento para la transferencia de tokens de un usuario
    event Transfer (
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    // Evento para la aprovacion de un operador
    event Approval (
        address indexed _owner,
        address indexed _spender,
        uint256 value
    );

    // Estructuras de datos
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
}