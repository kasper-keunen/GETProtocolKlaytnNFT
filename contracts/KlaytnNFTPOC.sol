pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed originAddress, address indexed destinationAddress, uint256 indexed nftIndex);
    event Approval(address indexed owner, address indexed approved, uint256 indexed nftIndex);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /// NEW EVENTS - ADDED BY KASPER 
    event txMint(address indexed from, address indexed to, uint256 indexed nftIndex);
    event txPrimary(address indexed originAddress, address indexed destinationAddress, uint256 indexed nftIndex);
    event txSecondary(address indexed originAddress, address indexed destinationAddress, uint256 indexed nftIndex);
    event txCollect(address indexed originAddress, address indexed destinationAddress, uint256 indexed nftIndex);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `nftIndex`.
     */
    function ownerOf(uint256 nftIndex) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`nftIndex`) from one account (`originAddress `) to
     * another (`to`).
     * Requirements:
     * - `originAddress `, `to` cannot be zero.
     * - `nftIndex` must be owned by `originAddress `.
     * - If the caller is not `originAddress `, it must be have been allowed to move this
     * NFT by either {approve} or {setApprovalForAll}.
     */
    function safeTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex) public;
    /**
     * @dev Transfers a specific NFT (`nftIndex`) from one account (`originAddress `) to
     * another (`to`).
     * Requirements:
     * - If the caller is not `originAddress `, it must be approved to move this NFT by
     * either {approve} or {setApprovalForAll}.
     */
    function transferFrom(address originAddress, address destinationAddress, uint256 nftIndex) public;
    function approve(address destinationAddress, uint256 nftIndex) public;
    function getApproved(uint256 nftIndex) public view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);
    function safeTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex, bytes memory data) public;
}

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a {IERC721-safeTransferFrom}. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param originAddress The address which previously owned the token
     * @param nftIndex The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address originAddress, uint256 nftIndex, bytes memory data)
    public returns (bytes4);
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
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
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}



/**
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the {SafeMath}
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        // The {SafeMath} overflow check can be skipped here, see the comment at the top
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts may inherit from this and call {_registerInterface} to declare
 * their support of an interface.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See {IERC165-supportsInterface}.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is Context, ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param nftIndex uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 nftIndex) public view returns (address) {
        address owner = _tokenOwner[nftIndex];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param destinationAddress address to be approved for the given token ID
     * @param nftIndex uint256 ID of the token to be approved
     */
    function approve(address destinationAddress, uint256 nftIndex) public {
        address owner = ownerOf(nftIndex);
        require(destinationAddress != owner, "ERC721: approval to current owner");

        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[nftIndex] = destinationAddress;
        emit Approval(owner, destinationAddress, nftIndex);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param nftIndex uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 nftIndex) public view returns (address) {
        require(_exists(nftIndex), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[nftIndex];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param destinationAddress operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address destinationAddress, bool approved) public {
        require(destinationAddress != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][destinationAddress] = approved;
        emit ApprovalForAll(_msgSender(), destinationAddress, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function transferFrom(address originAddress, address destinationAddress, uint256 nftIndex) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), nftIndex), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(originAddress, destinationAddress, nftIndex);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex) public {
        safeTransferFrom(originAddress, destinationAddress, nftIndex, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the _msgSender() to be the owner, approved, or operator
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex, bytes memory _data) public {
        require(_isApprovedOrOwner(_msgSender(), nftIndex), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(originAddress, destinationAddress, nftIndex, _data);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex, bytes memory _data) internal {
        _transferFrom(originAddress, destinationAddress, nftIndex);
        require(_checkOnERC721Received(originAddress, destinationAddress, nftIndex, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param nftIndex uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 nftIndex) internal view returns (bool) {
        address owner = _tokenOwner[nftIndex];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param nftIndex uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 nftIndex) internal view returns (bool) {
        require(_exists(nftIndex), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(nftIndex);
        return (spender == owner || getApproved(nftIndex) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param destinationAddress The address that will own the minted token
     * @param nftIndex uint256 ID of the token to be minted
     */
    function _safeMint(address destinationAddress, uint256 nftIndex) internal {
        _safeMint(destinationAddress, nftIndex, "");
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param destinationAddress The address that will own the minted token
     * @param nftIndex uint256 ID of the token to be minted
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeMint(address destinationAddress, uint256 nftIndex, bytes memory _data) internal {
        _mint(destinationAddress, nftIndex);
        require(_checkOnERC721Received(address(0), destinationAddress, nftIndex, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param destinationAddress The address that will own the minted token
     * @param nftIndex uint256 ID of the token to be minted
     */
    function _mint(address destinationAddress, uint256 nftIndex) internal {
        require(destinationAddress != address(0), "ERC721: mint to the zero address");
        require(!_exists(nftIndex), "ERC721: token already minted");

        _tokenOwner[nftIndex] = destinationAddress;
        _ownedTokensCount[destinationAddress].increment();

        emit Transfer(address(0), destinationAddress, nftIndex);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {_burn} instead.
     * @param owner owner of the token to burn
     * @param nftIndex uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 nftIndex) internal {
        require(ownerOf(nftIndex) == owner, "ERC721: burn of token that is not own");

        _clearApproval(nftIndex);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[nftIndex] = address(0);

        emit Transfer(owner, address(0), nftIndex);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param nftIndex uint256 ID of the token being burned
     */
    function _burn(uint256 nftIndex) internal {
        _burn(ownerOf(nftIndex), nftIndex);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function _transferFrom(address originAddress, address destinationAddress, uint256 nftIndex) internal {
        require(ownerOf(nftIndex) == originAddress, "ERC721: transfer of token that is not own");
        require(destinationAddress != address(0), "ERC721: transfer to the zero address");

        _clearApproval(nftIndex);

        _ownedTokensCount[originAddress].decrement();
        _ownedTokensCount[destinationAddress].increment();

        _tokenOwner[nftIndex] = destinationAddress;

        emit Transfer(originAddress, destinationAddress, nftIndex);
    }

    /** 
    * @dev Only used/called by GET Protocol relayer - ADDED / NEW 
    * @notice The function assumes that the originAddress has signed the tx. 
    * @param originAddress the address the NFT will be extracted from
    * @param destinationAddress the address of the ticketeer that will receive the NFT
    * @param nftIndex the index of the NFT that will be returned to the tickeer
    */
    function _relayerTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex) internal {

        _clearApproval(nftIndex);
        _ownedTokensCount[originAddress].decrement();
        _ownedTokensCount[destinationAddress].increment();

        _tokenOwner[nftIndex] = destinationAddress;
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param originAddress address representing the previous owner of the given token ID
     * @param destinationAddress target address that will receive the tokens
     * @param nftIndex uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address originAddress, address destinationAddress, uint256 nftIndex, bytes memory _data)
        internal returns (bool)
    {
        if (!destinationAddress.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(destinationAddress).onERC721Received(_msgSender(), originAddress, nftIndex, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 nftIndex) private {
        if (_tokenApprovals[nftIndex] != address(0)) {
            _tokenApprovals[nftIndex] = address(0);
        }
    }
}



/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 nftIndex);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Enumerable is Context, ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor () public {
        // register the supported interface to conform to ERC721Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferoriginAddress, this imposes no restrictions on msg.sender.
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function _transferFrom(address originAddress, address destinationAddress, uint256 nftIndex) internal {
        super._transferFrom(originAddress, destinationAddress, nftIndex);

        _removeTokenFromOwnerEnumeration(originAddress, nftIndex);

        _addTokenToOwnerEnumeration(destinationAddress, nftIndex);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferoriginAddress, this imposes no restrictions on msg.sender.
     * @param originAddress current owner of the token
     * @param destinationAddress address to receive the ownership of the given token ID
     * @param nftIndex uint256 ID of the token to be transferred
     */
    function _relayerTransferFrom(address originAddress, address destinationAddress, uint256 nftIndex) internal {
        super._relayerTransferFrom(originAddress, destinationAddress, nftIndex);

        _removeTokenFromOwnerEnumeration(originAddress, nftIndex);

        _addTokenToOwnerEnumeration(destinationAddress, nftIndex);
    }    

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param destinationAddress address the beneficiary that will own the minted token
     * @param nftIndex uint256 ID of the token to be minted
     */
    function _mint(address destinationAddress, uint256 nftIndex) internal {
        super._mint(destinationAddress, nftIndex);

        _addTokenToOwnerEnumeration(destinationAddress, nftIndex);

        _addTokenToAllTokensEnumeration(nftIndex);
    }


    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {ERC721-_burn} instead.
     * @param owner owner of the token to burn
     * @param nftIndex uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 nftIndex) internal {
        super._burn(owner, nftIndex);

        _removeTokenFromOwnerEnumeration(owner, nftIndex);
        // Since nftIndex will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[nftIndex] = 0;

        _removeTokenFromAllTokensEnumeration(nftIndex);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param destinationAddress address representing the new owner of the given token ID
     * @param nftIndex uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address destinationAddress, uint256 nftIndex) private {
        _ownedTokensIndex[nftIndex] = _ownedTokens[destinationAddress].length;
        _ownedTokens[destinationAddress].push(nftIndex);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param nftIndex uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 nftIndex) private {
        _allTokensIndex[nftIndex] = _allTokens.length;
        _allTokens.push(nftIndex);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param originAddress address representing the previous owner of the given token ID
     * @param nftIndex uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address originAddress, uint256 nftIndex) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[originAddress ].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[nftIndex];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastnftIndex = _ownedTokens[originAddress ][lastTokenIndex];

            _ownedTokens[originAddress ][tokenIndex] = lastnftIndex; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastnftIndex] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[originAddress ].length--;

        // Note that _ownedTokensIndex[nftIndex] hasn't been cleared: it still points to the old slot (now occupied by
        // lastnftIndex, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param nftIndex uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 nftIndex) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[nftIndex];

        /** When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        * rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        * an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        */
        uint256 lastnftIndex = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastnftIndex; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastnftIndex] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[nftIndex] = 0;
    }
}


/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function nftMetadata(uint256 nftIndex) external view returns (string memory);
}

contract ERC721Metadata is Context, ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _nftMetadatas;

    // // Optional mapping for tickeer_ids (underwriter)
    mapping (uint256 => address) private _ticketeerAddresss;    

    // Base URI
    string private _baseURI;    

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('nftMetadata(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns an URI for a given token ID.
     * Throws if the token ID does not exist. May return an empty string.
     * @param nftIndex uint256 ID of the token to query
     */
    function nftMetadata(uint256 nftIndex) external view returns (string memory) {
        require(_exists(nftIndex), "ERC721Metadata: URI query for nonexistent token");
        return _nftMetadatas[nftIndex];
    }

    /// NEW 
    function getTicketeerOwner(uint256 nftIndex) public view returns (address) {
        require(_exists(nftIndex), "ERC721Metadata: Tickeer owner query for nonexistent token");
        return _ticketeerAddresss[nftIndex];
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     * Reverts if the token ID does not exist.
     * @param nftIndex uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setnftMetadata (uint256 nftIndex, string memory uri) internal {
        require(_exists(nftIndex), "ERC721Metadata: URI set of nonexistent token");
        _nftMetadatas[nftIndex] = uri;
    }

    /** NEW FUNCTION - ADDED BY KASPER
     * @dev Sets `_nftMetadata ` as the nftMetadata  of `nftIndex`.
     */ 
    function _addTicketeerIndex(uint256 nftIndex, address _ticketeerAddress) internal {
        require(_exists(nftIndex), "ERC721Metadata: URI set of nonexistent token");
        _ticketeerAddresss[nftIndex] = _ticketeerAddress;
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param nftIndex uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 nftIndex) internal {
        super._burn(owner, nftIndex);

        // Clear metadata (if any)
        if (bytes(_nftMetadatas[nftIndex]).length != 0) {
            delete _nftMetadatas[nftIndex];
        }
    }
}


/** NEW ADDED
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

/**
 * @title Full ERC721 Token
 * @dev This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology.
 *
 * See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Full is ERC721, ERC721Enumerable, ERC721Metadata {
    constructor (string memory name, string memory symbol) public ERC721Metadata(name, symbol) {
        // solhint-disable-previous-line no-empty-blocks
    }
}


/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}


contract MinterRole is Context {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(_msgSender());
    }

    modifier onlyMinter() {
        require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter role");
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(_msgSender());
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}


contract RelayerRole is Context {
    using Roles for Roles.Role;

    event RelayerAdded(address indexed account);
    event RelayerRemoved(address indexed account);

    Roles.Role private _relayers;

    constructor () internal {
        _addRelayer(_msgSender());
    }

    modifier onlyRelayer() {
        require(isRelayer(_msgSender()), "RelayerRole: caller does not have the Relayer role");
        _;
    }

    function isRelayer(address account) public view returns (bool) {
        return _relayers.has(account);
    }

    function addRelayer(address account) public onlyRelayer {
        _addRelayer(account);
    }

    function renounceRelayer() public {
        _removeRelayer(_msgSender());
    }

    function _addRelayer(address account) internal {
        _relayers.add(account);
        emit RelayerAdded(account);
    }

    function _removeRelayer(address account) internal {
        _relayers.remove(account);
        emit RelayerRemoved(account);
    }
}



/**
 * @title ERC721Mintable
 * @dev ERC721 minting logic.
 */
contract ERC721Mintable is ERC721, MinterRole, RelayerRole {
    /**
     * @dev Function to mint tokens.
     * @param destinationAddress The address that will receive the minted token.
     * @param nftIndex The token id to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address destinationAddress, uint256 nftIndex) private onlyMinter returns (bool) {
        _mint(destinationAddress, nftIndex);
        return true;
    }

    /**
     * @dev Function to safely mint tokens.
     * @param destinationAddress The address that will receive the minted token.
     * @param nftIndex The token id to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function safeMint(address destinationAddress, uint256 nftIndex) private onlyMinter returns (bool) {
        _safeMint(destinationAddress, nftIndex);
        return true;
    }

    /**
     * @dev Function to safely mint tokens.
     * @param destinationAddress The address that will receive the minted token.
     * @param nftIndex The token id to mint.
     * @param _data bytes data to send along with a safe transfer check.
     * @return A boolean that indicates if the operation was successful.
     */
    function safeMint(address destinationAddress, uint256 nftIndex, bytes memory _data) private onlyMinter returns (bool) {
        _safeMint(destinationAddress, nftIndex, _data);
        return true;
    }
}


/**
 * @title ERC721MetadataMintable
 * @dev ERC721 minting logic with metadata.
 */
contract ERC721MetadataMintable is ERC721, ERC721Metadata, MinterRole {
    /**
     * @dev Function to mint tokens.
     * @param destinationAddress The address that will receive the minted tokens.
     * @param nftIndex The token id to mint.
     * @param nftMetadata The token URI of the minted token.
     * @return A boolean that indicates if the operation was successful.
     */
    function mintWithNftMetadata(address destinationAddress, uint256 nftIndex, string memory nftMetadata) private onlyMinter returns (bool) {
        _mint(destinationAddress, nftIndex);
        _setnftMetadata(nftIndex, nftMetadata);
        return true;
    }
}


/**
 * @title ERC721 Burnable Token
 * @dev ERC721 Token that can be irreversibly burned (destroyed).
 */
contract ERC721Burnable is Context, ERC721 {
    /**
     * @dev Burns a specific ERC721 token.
     * TODO This needs to be made onlyOwner as destroying NFTs is a form of control.
     * @param nftIndex uint256 id of the ERC721 token to be burned.
     */
    function burn(uint256 nftIndex) private {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), nftIndex), "ERC721Burnable: caller is not owner nor approved");
        _burn(nftIndex);
    }
}


/**
 * @title GET_NFTV02
 * TODO Add Description
 * checking token existence, removal of a token from an address
 */
contract SmartTicketingERC721 is ERC721Full, ERC721Mintable, ERC721MetadataMintable, ERC721Burnable, Ownable {
    constructor (string memory _nftName, string memory _nftSymbol) public ERC721Mintable() ERC721Full(_nftName, _nftSymbol) {
        // solhint-disable-previous-line no-empty-blocks
    }

    using Counters for Counters.Counter;
    Counters.Counter private _nftIndexs;

    /** @notice This function mints a new NFT
    * @dev the nftIndex (NFT_index is auto incremented)
    * @param destinationAddress addres of the underwriter of the NFT
    */
    function mintNFTIncrement(address destinationAddress) public onlyMinter returns (uint256) {
    
        _nftIndexs.increment();

        uint256 newNFTIndex = _nftIndexs.current();
        _mint(destinationAddress, newNFTIndex);

        _addTicketeerIndex(newNFTIndex, destinationAddress);
        return newNFTIndex;
    }

    /** @notice This function mints a new NFT -> 
    * @dev the nftIndex needs to be provided in the call
    * @dev ensure that the provided newNFTIndex is unique and stored/cached. 
    * @param newNFTIndex uint of the nftIndex that will be minted
    * @param destinationAddress addres of the underwriter of the NFT
    */
    function mintNFT(address destinationAddress, uint256 newNFTIndex) public onlyMinter returns (uint256) {
    
        _mint(destinationAddress, newNFTIndex);

        _addTicketeerIndex(newNFTIndex, destinationAddress);
        return newNFTIndex;
    }
    
    /** @param originAddress addres of the underwriter of the NFT 
    * @param destinationAddress addres of the to-be owner of the NFT 
    * @param ticket_execution_data string containing the metadata about the ticket the NFT is representing
    */
    function primaryTransfer(address originAddress, address destinationAddress, uint256 nftIndex, string memory ticket_execution_data) public {
        /// Check if originAddress currently owners the NFT
        require(ownerOf(nftIndex) == originAddress, "ERC721: transfer of token that is not own");
        require(destinationAddress != address(0), "ERC721: transfer to the zero address");

        /// Store the ticket_execution metadata in the NFT
        _setnftMetadata(nftIndex, ticket_execution_data);

        /// Transfer the NFT to the new owner
        safeTransferFrom(originAddress, destinationAddress, nftIndex);
        emit txPrimary(originAddress, destinationAddress, nftIndex);
    
    }

    /** 
    * @notice This function can only be called by a whitelisted relayer address (onlyRelayer).
    * @notice As tx is relayed msg.sender is assumed to be signed by originAddress.
    * @dev Tx will fail/throw if originAddress is not owner of nftIndex
    * @dev Tx will fail/throw if destinationAddress is genensis address.
    * @dev TODO Tx should fail if destinationAddress is smart contract
    * @param originAddress address the NFT is asserted 
    * @param destinationAddress addres of the to-be owner of the NFT 
    * @param nftIndex  uint256 ID of the token to be transferred
    */
    function secondaryTransfer(address originAddress, address destinationAddress, uint256 nftIndex) public {

        /// Verify if originAddress is owner of nftIndex
        require(ownerOf(nftIndex) == originAddress, "ERC721: transfer of token that is not owned by owner");
        
        /// Verify if destinationAddress isn't burn-address
        require(destinationAddress != address(0), "ERC721: transfer to the zero address");

        /// Transfer the NFT to the new owner
        safeTransferFrom(originAddress, destinationAddress, nftIndex);
        emit txSecondary(originAddress, destinationAddress, nftIndex);
    }


    /** Returns the NFT of the ticketeer back to its address + cleans the ticket_execution metadata from the NFT 
    * @notice This function doesn't require autorization of the NFT owner! This is basically a "seizing' of the NFT
    * @param nftIndex  \uint256 ID of the token to be transferred
    * @param destinationAddress addres of the to-be owner of the NFT (should be tcketeer)
    * @dev It is possible for us to pass the "originAddress" in the contract call, but this can just as
    * well be fetched in the smart contract. Works ether way. 
    */
    function collectTransfer(uint256 nftIndex, address destinationAddress) public {

        /// Check if originAddress is actually the ticketeer owning the NFT
        require(getTicketeerOwner(nftIndex) == destinationAddress, "ERC721: transfer of token that is not own");

        /// Check if the originAddress is the ticketeer
        require(getTicketeerOwner(nftIndex) == msg.sender, "ERC721: collection can only be done by ticketeer");

        /// Fetch the address that owns the NFT
        address originAddress = ownerOf(nftIndex);

        address _ticketeerAddress = getTicketeerOwner(nftIndex);
        require(_ticketeerAddress == destinationAddress, "ERC721: collection of token that is not owned by the ticketeer");

        /// Clean out  ticketExectionHash
        _setnftMetadata(nftIndex, "NONE");

        /// Transfer the NFT to the new owner
        _relayerTransferFrom(originAddress, destinationAddress, nftIndex);
        emit txCollect(originAddress, destinationAddress, nftIndex);
    }

    function exists(uint256 nftIndex) public view returns (bool) {
        return _exists(nftIndex);
    }

    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return _tokensOfOwner(owner);
    }

    function setnftMetadata(uint256 nftIndex, string memory uri) private {
        _setnftMetadata(nftIndex, uri);
    }
}



/** @title A scalable implementation of all ERC721 NFT standards combined.
* @author Kasper Keunen
* @dev Extends SmartTicketingERC721
*/
contract GET_NFTVPOC is SmartTicketingERC721 { 
    constructor(string memory _nftName, string memory _nftSymbol) public SmartTicketingERC721(_nftName, _nftSymbol) { }
}
