// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Hello {
   bool public b = false;
    // !, ||, ==, &&
    bool public b1 = !b; // true
    bool public b2 = false || true; // true
    bool public b3 = false == true; // false
    bool public b4 = false && true; // false

    bytes4 public bt = 0x12345678;
    bytes public bt2 = "STRING";

    address public addr = 0x1234567890123456789012345678901234567890;

    int8 public int1 = 4;
    uint256 public uint1 = 132213;
    uint8 public uint2 = 255;
}

