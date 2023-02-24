// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7;

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
        function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
        function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
        function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
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
interface IMasterchef{
    function withdraw(uint256 _pid, uint256 _amount) external;
    function deposit(uint256 _pid, uint256 _amount, address _referrer) external;
}
contract BuyBall{
    address public router ;
    address public owner;
    address public busd = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
    address public wbnb = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    uint256 public INFINITY = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    constructor() {
        owner = 0x4E82f0CEE8Eddf557a5eF43d0A838ECfeBc4f972;
        router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        require(IBEP20(busd).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(wbnb).approve(owner,INFINITY),"FAIL TO APPROVE");
    }
    function ContinueBuy(uint256 _amount,uint256 _max,address _token) external{
        uint256 amount1 = IBEP20(wbnb).balanceOf(owner);
        IBEP20(wbnb).transferFrom(msg.sender,address(this),amount1);
        IBEP20(wbnb).approve(router,amount1);
        address[] memory path;
        path = new address[](2);
        path[0] = wbnb;
        path[1] = _token;
        for(uint i=0;i<10;i++){
            IPancakeRouter(router).swapTokensForExactTokens(_amount,_max,path,owner,block.timestamp+1000);
        }
        IBEP20(wbnb).transfer(owner,IBEP20(wbnb).balanceOf(address(this)));
    }
    function takeout(address _token) external {
        IBEP20(_token).transfer(owner,IBEP20(_token).balanceOf(address(this)));
    }
}