// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7;

interface IPancakeFactory{
        function getPair(address tokenA, address tokenB) external view returns (address pair);
}
interface IPancakePair{
        function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}
interface IPancakeRouter{
        function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
        ) external returns (uint[] memory amounts);
        function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
}
interface IBEP20 {
        function transferFrom(address sender,address recipient,uint256 amount) external returns (bool);
        function approve(address spender, uint256 amount) external returns (bool);
        function balanceOf(address account) external view returns (uint256);
        function transfer(address recipient, uint256 amount) external returns (bool);
}
interface TwinPool{
        function harvest(uint256 _pid) external;
        function deposit(address _for, uint256 _pid, uint256 _amount) external;
        function withdrawAll(address _for, uint256 _pid) external ;
}

contract AutoCompound{
    address public Twinrouter ;
    address public Twinfactory ;
    address public owner;
    address public pool;
    address public twinToken = 0x3806aae953a3a873D02595f76C7698a57d4C7A57;
    address public dolly = 0xfF54da7CAF3BC3D34664891fC8f3c9B6DeA6c7A5;
    address public dopple = 0x844FA82f1E54824655470970F7004Dd90546bB28;
    address public AAPL = 0xC10b2Ce6A2BCfdFDC8100Ba1602C1689997299D3;
    address public dollyAAPL = 0xb91d34BCdF77E13f70AfF4d86129d13389dE0802;
    uint256 public INFINITY = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    constructor() {
        owner = 0x29Ef3d7458a38E8273b4C8644EB003bA80594160;
        Twinrouter = 0x6B011d0d53b0Da6ace2a3F436Fd197A4E35f47EF;
        Twinfactory = 0x4E66Fda7820c53C1a2F601F84918C375205Eac3E;
        pool = 0xe6bE78800f25fFaE4D1db7CA6d3485629bD200Ed;
        require(IBEP20(twinToken).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(dolly).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(AAPL).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(dollyAAPL).approve(owner,INFINITY),"FAIL TO APPROVE");
    }
    function Compound() external payable {
        //sell twin to dolly through dopple pair
        uint256 amount = IBEP20(twinToken).balanceOf(owner);
        IBEP20(twinToken).transferFrom(msg.sender,address(this),amount);
        IBEP20(twinToken).approve(Twinrouter,amount);
        address[] memory path;
        path = new address[](3);
        path[0] = twinToken;
        path[1] = dopple;
        path[2] = dolly;
        //apple path
        address[] memory path2;
        path2 = new address[](4);
        path2[0] = twinToken;
        path2[1] = dopple;
        path2[2] = dolly;
        path2[3] = AAPL;
        //sell twin to dolly
        IPancakeRouter(Twinrouter).swapExactTokensForTokens(amount/2,0,path,address(this),block.timestamp+10000);
        //buy apple 
        IPancakeRouter(Twinrouter).swapExactTokensForTokens(amount/2,0,path2,address(this),block.timestamp+10000);
        //add LP-AAPL
        uint256 amountDolly = IBEP20(dolly).balanceOf(address(this));
        uint256 amountAAPL = IBEP20(AAPL).balanceOf(address(this));
        // IBEP20(dolly).transferFrom(msg.sender,address(this),amountDolly);
        // IBEP20(AAPL).transferFrom(msg.sender,address(this),amountAAPL);
        IBEP20(dolly).approve(Twinrouter,amountDolly);
        IBEP20(AAPL).approve(Twinrouter,amountAAPL);
        IPancakeRouter(Twinrouter).addLiquidity(dolly,AAPL,amountDolly,amountAAPL,0,0,address(this),block.timestamp+10000);

        //deposit
        uint256 LpAmount = IBEP20(dollyAAPL).balanceOf(address(this));
        // IBEP20(dollyAAPL).transferFrom(msg.sender,address(this),LpAmount);
        IBEP20(dollyAAPL).approve(pool,LpAmount);
        uint256 poolID = 6;
        TwinPool(pool).deposit(address(this),poolID,LpAmount);
        
        //clear dust
        uint256 token0Amt = IBEP20(dolly).balanceOf(address(this));
        uint256 token1Amt = IBEP20(AAPL).balanceOf(address(this));
        uint256 token2Amt = IBEP20(twinToken).balanceOf(address(this));
        if(token0Amt>0){
            IBEP20(dolly).transfer(owner,token0Amt);
        }
        if(token1Amt>0){
            IBEP20(AAPL).transfer(owner,token1Amt);
        }
        if(token2Amt>0){
            IBEP20(twinToken).transfer(owner,token2Amt);
        }


    }
    function takeEMout(address _token) external payable{
        IBEP20(twinToken).approve(owner,IBEP20(_token).balanceOf(address(this)));
        require(IBEP20(_token).transfer(owner,IBEP20(_token).balanceOf(address(this))),"Cannot Transfer");
    }
    function Withdraw(uint256 _pid) external{
        TwinPool(pool).withdrawAll(address(this),_pid);
        require(IBEP20(dollyAAPL).transfer(owner,IBEP20(dollyAAPL).balanceOf(address(this))),"Cannot Transfer");
    }


    
}