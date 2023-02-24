// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7;
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
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
}
interface IBEP20 {
        function transferFrom(address sender,address recipient,uint256 amount) external returns (bool);
        function approve(address spender, uint256 amount) external returns (bool);
        function balanceOf(address account) external view returns (uint256);
        function transfer(address recipient, uint256 amount) external returns (bool);
        function totalSupply() external view returns (uint256);
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
contract WhaleMaxy{
    using SafeMath for uint256;
    address public router ;
    address public owner;
    address public Masterchef = 0xcf067c9D591c3bdDf706e1D7dB3B646Ef712DBA1;
    address public frozen = 0xd07efBcDD7242212fF67372cDB2c9DDAa0290fAe;
    address public busd = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
    address public wbnb = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    uint256 public INFINITY = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    address public LPtoken = 0xec69b0bE38B4BEf378F808f9F4cAcbeC79934B0d;
    uint public blockNumber = 8799602;
    uint256 pid = 0;
    uint256 timeharvest = 1624982400;
    address public refer = 0x0000000000000000000000000000000000000000;
    constructor() {
        owner = 0x4E82f0CEE8Eddf557a5eF43d0A838ECfeBc4f972;
        router = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
        require(IBEP20(frozen).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(busd).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(wbnb).approve(owner,INFINITY),"FAIL TO APPROVE");
        require(IBEP20(LPtoken).approve(owner,INFINITY),"FAIL TO APPROVE");
    }
    function HarvestAmount(uint256 _amount) external{
        require(block.number>=blockNumber, "Aint that time");
        IMasterchef(Masterchef).withdraw(pid,_amount);
        uint256 LPharvest = IBEP20(LPtoken).balanceOf(address(this));
        if(LPharvest>0){
            IBEP20(LPtoken).approve(router,LPharvest);
            IPancakeRouter(router).removeLiquidity(frozen,busd,LPharvest,0,0,address(this),block.timestamp+10000);
        }

        address[] memory path;
        path = new address[](2);
        path[0] = frozen;
        path[1] = wbnb;
        uint256 reward = IBEP20(frozen).balanceOf(address(this));
        IBEP20(frozen).approve(router,reward);
        uint256 Maxsell = IBEP20(frozen).totalSupply().mul(10).div(100000);
        while(reward>Maxsell){
            IPancakeRouter(router).swapExactTokensForTokensSupportingFeeOnTransferTokens(Maxsell,0,path,owner,block.timestamp+10000);
            reward = reward - Maxsell;
        }
        IPancakeRouter(router).swapExactTokensForTokensSupportingFeeOnTransferTokens(IBEP20(frozen).balanceOf(address(this)),0,path,owner,block.timestamp+10000);
        IBEP20(busd).transfer(owner,IBEP20(busd).balanceOf(address(this)));
    }
    function TestWithdraw(uint256 _amount) external{
        IMasterchef(Masterchef).withdraw(pid,_amount);
        uint256 LPharvest = IBEP20(LPtoken).balanceOf(address(this));
        if(LPharvest>0){
            IBEP20(LPtoken).approve(router,LPharvest);
            IPancakeRouter(router).removeLiquidity(frozen,busd,LPharvest,0,0,address(this),block.timestamp+10000);
        }

        address[] memory path;
        path = new address[](2);
        path[0] = frozen;
        path[1] = wbnb;
        uint256 reward = IBEP20(frozen).balanceOf(address(this));
        IBEP20(frozen).approve(router,reward);
        uint256 Maxsell = IBEP20(frozen).totalSupply().mul(10).div(100000);
        while(reward>Maxsell){
            IPancakeRouter(router).swapExactTokensForTokensSupportingFeeOnTransferTokens(Maxsell,0,path,owner,block.timestamp+10000);
            reward = reward - Maxsell;
        }
        IPancakeRouter(router).swapExactTokensForTokensSupportingFeeOnTransferTokens(IBEP20(frozen).balanceOf(address(this)),0,path,owner,block.timestamp+10000);
        IBEP20(busd).transfer(owner,IBEP20(busd).balanceOf(address(this)));
    }
    function depositLP() external{
        uint256 amountDeposit = IBEP20(LPtoken).balanceOf(msg.sender);
        IBEP20(LPtoken).transferFrom(msg.sender,address(this),amountDeposit);
        IBEP20(LPtoken).approve(Masterchef,amountDeposit);
        IMasterchef(Masterchef).deposit(pid,amountDeposit,refer);
    }
    function depositfrombusd () external{
        //sell busd to frozen through wbnb pair
        uint256 amount = IBEP20(busd).balanceOf(owner);
        IBEP20(busd).transferFrom(msg.sender,address(this),amount);
        IBEP20(busd).approve(router,amount);
        address[] memory path;
        path = new address[](3);
        path[0] = busd;
        path[1] = wbnb;
        path[2] = frozen;
        //sell busd to frozen
        IPancakeRouter(router).swapExactTokensForTokens(amount/2,0,path,address(this),block.timestamp+10000);
        //add LP
        uint256 amountA = IBEP20(busd).balanceOf(address(this));
        uint256 amountB = IBEP20(frozen).balanceOf(address(this));
        // IBEP20(dolly).transferFrom(msg.sender,address(this),amountDolly);
        // IBEP20(AAPL).transferFrom(msg.sender,address(this),amountAAPL);
        IBEP20(busd).approve(router,amountA);
        IBEP20(frozen).approve(router,amountB);
        IPancakeRouter(router).addLiquidity(busd,frozen,amountA,amountB,0,0,address(this),block.timestamp+10000);

        //deposit
        uint256 LpAmount = IBEP20(LPtoken).balanceOf(address(this));
        // IBEP20(dollyAAPL).transferFrom(msg.sender,address(this),LpAmount);
        IBEP20(LPtoken).approve(Masterchef,LpAmount);
        IMasterchef(Masterchef).deposit(pid,LpAmount,refer);
        
        //clear dust
        uint256 token0Amt = IBEP20(busd).balanceOf(address(this));
        uint256 token1Amt = IBEP20(frozen).balanceOf(address(this));
        if(token0Amt>0){
            IBEP20(busd).transfer(owner,token0Amt);
        }
        if(token1Amt>0){
            IBEP20(frozen).transfer(owner,token1Amt);
        }
    }
    function takeout(address _token) external payable{
        IBEP20(_token).transfer(owner,IBEP20(_token).balanceOf(address(this)));
    }
    function getMaxsell() external view returns(uint256){
        return IBEP20(frozen).totalSupply().mul(10).div(100000);
    }



    
}