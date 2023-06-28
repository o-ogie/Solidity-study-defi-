pragma solidity ^0.8.0;

// ERC20 토큰 인터페이스
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

// DEX 거래소 컨트랙트
contract DEX {
    address private owner;
    mapping(address => mapping(address => uint256)) private balances;
    mapping(address => mapping(address => uint256)) private allowed;

    event Deposit(address indexed token, address indexed user, uint256 amount);
    event Withdraw(address indexed token, address indexed user, uint256 amount);
    event Trade(address indexed token, address indexed user, uint256 inputAmount, uint256 outputAmount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit(address token, uint256 amount) external {
        require(amount > 0, "Amount should be greater than zero.");

        // 토큰을 이 컨트랙트로 예치
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Failed to transfer tokens.");

        // 사용자의 예치량 갱신
        balances[token][msg.sender] += amount;

        emit Deposit(token, msg.sender, amount);
    }

    function withdraw(address token, uint256 amount) external {
        require(amount > 0, "Amount should be greater than zero.");
        require(balances[token][msg.sender] >= amount, "Insufficient balance.");

        // 사용자의 예치량 갱신
        balances[token][msg.sender] -= amount;

        // 토큰을 사용자에게 반환
        require(IERC20(token).transfer(msg.sender, amount), "Failed to transfer tokens.");

        emit Withdraw(token, msg.sender, amount);
    }

    function trade(address inputToken, uint256 inputAmount, address outputToken) external {
        require(inputAmount > 0, "Input amount should be greater than zero.");
        require(balances[inputToken][msg.sender] >= inputAmount, "Insufficient input balance.");

        uint256 outputAmount = getOutputAmount(inputToken, inputAmount, outputToken);

        // 토큰 스왑
        require(balances[outputToken][msg.sender] >= outputAmount, "Insufficient output balance.");
        balances[inputToken][msg.sender] -= inputAmount;
        balances[outputToken][msg.sender] += outputAmount;

        emit Trade(outputToken, msg.sender, inputAmount, outputAmount);
    }

    function getBalance(address token, address user) external view returns (uint256) {
        return balances[token][user];
    }

    function getOutputAmount(address inputToken, uint256 inputAmount, address outputToken) internal view returns (uint256) {
        // 이 부분은 원하는 거래 로직에 맞게 작성해야 합니다.
        // 예시로 간단히 1:1 비율로 스왑되도록 작성합니다.
        return inputAmount;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid owner address.");
        owner = newOwner;
    }
}
