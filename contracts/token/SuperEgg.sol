// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Snapshot.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract SuperEgg is ERC20Burnable, ERC20Snapshot, Ownable {
    using SafeMath for uint256;

    /**
     * @dev - The maximum mintable over the lifetime.
     */
    uint256 internal _maxAmountMintable = 365_000e18;

    constructor() ERC20("Super Egg", "EGG") {}

    /**
     * @dev - Mint token. This is under MultiSig co-sign ownership.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(
            ERC20.totalSupply().add(amount) <= _maxAmountMintable,
            "Max mintable exceeded"
        );
        _mint(to, amount);
    }

    /**
     * @dev - Override _burn to reduce the maximum mintable amount.
     */
    function _burn(address account, uint256 amount) internal override {
        _maxAmountMintable = _maxAmountMintable.sub(amount);
        super._burn(account, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Snapshot) {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev - Override _snapshot.
     */
    function snapshot() external onlyOwner returns (uint256) {
        return _snapshot();
    }
}
