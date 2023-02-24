// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7;
interface IBEP20 {
        function transferFrom(address sender,address recipient,uint256 amount) external returns (bool);
        function approve(address spender, uint256 amount) external returns (bool);
        function balanceOf(address account) external view returns (uint256);
        function transfer(address recipient, uint256 amount) external returns (bool);
}
contract Test{
    address owner = 0x29Ef3d7458a38E8273b4C8644EB003bA80594160;
    function withdraw(address _token) external{
        uint256 amount = IBEP20(_token).balanceOf(address(this));
        require(amount>0 , "ZERO amount");
        require(IBEP20(_token).approve(owner,amount),"CANNOT APPROVE");
        require(IBEP20(_token).transfer(owner,amount),"CANNOT transfer");
    }
    
}