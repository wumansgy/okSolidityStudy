//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IScore {
    function AddScore(uint256 amount) external;
    function SubScore(uint256 amount) external;
}

library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}


contract Score {
    using SafeMath for uint256;

    mapping(address => uint256) score;
    address teacher;

    constructor() {
        teacher = address(new Teacher(address(this)));
    }

    modifier _onlyTeacher() {
        require(msg.sender == teacher, "Score: not teacher");
        _;
    }

    function addScore(uint256 amount) external _onlyTeacher {
        require(score[msg.sender].add(amount) <= 100, "Score: add too much");
        score[msg.sender] = score[msg.sender].add(amount);
    }

    function subScore(uint256 amount) external _onlyTeacher {
        score[msg.sender] = score[msg.sender].sub(amount);
    }
}


contract Teacher {
    IScore score;

    constructor(address _score) {
        score = IScore(_score);
    }

    function addScore(uint256 amount) external {
        score.addScore(amount);
    }

    function subScore(uint256 amount) external {
        score.subScore(amount);
    }
}
