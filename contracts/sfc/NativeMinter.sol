pragma solidity ^0.5.0;

import "./NodeDriver.sol";
import "./SFCI.sol";
import "../ownership/Ownable.sol";
import "../common/Initializable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract NativeMinter is Initializable, Ownable {
    using SafeMath for uint256;

    mapping(address => bool) public minters;
    SFCI public sfc;
    EVMWriter public evmWriter;

    modifier onlyMinter() {
        require(minters[msg.sender], "caller is not a minter");
        _;
    }

    function initialize(
        address _sfc,
        address _evmWriter,
        address _owner
    ) external initializer {
        Ownable.initialize(_owner);
        sfc = SFCI(_sfc);
        evmWriter = EVMWriter(_evmWriter);
    }

    function addMinter(address minter) external onlyOwner {
        minters[minter] = true;
    }

    function removeMinter(address minter) external onlyOwner {
        minters[minter] = false;
    }

    function mintNativeToken(address to, uint256 amount) external onlyMinter  {
        // balance will be increased after the transaction is processed
        evmWriter.setBalance(to, address(to).balance.add(amount));
        sfc.incSupply(amount);
    }

    function burnNativeToken(address from, uint256 amount) external onlyMinter {
        // balance will be decreased after the transaction is processed
        evmWriter.setBalance(from, address(from).balance.sub(amount));
        sfc.decSupply(amount);
    }
}
