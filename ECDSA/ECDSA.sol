// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
library ECDSA {
    function recover(bytes32 hash, bytes memory sig)
        internal
        pure
        returns (address)
    {
        bytes32 r;
        bytes32 s;
        uint8 v;

        // Check the signature length
        if (sig.length != 65) {
            return (address(0));
        }

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) {
            return (address(0));
        } else {
            // solium-disable-next-line arg-overflow
            return ecrecover(hash, v, r, s);
        }
    }

    function toEthSignedMessageHash(bytes32 hash)
        internal
        pure
        returns (bytes32)
    {
        // 32 is the length in bytes of hash,
        // enforced by the type signature above
        return
            keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)
            );
    }
}

contract whitelistUsingECDSA {
    using ECDSA for bytes32;
    address public ownerAddress = 0x94d5BFEe7b8663b6d495a07B2918bb96ECC15A36;

    function checkWhitelisted(
        address _user,
        uint256 _nonce,
        bytes calldata _sig
    ) public view returns (bool) {
        bytes32 _hash = keccak256(abi.encodePacked(_user, _nonce));
        bytes32 hash = _hash.toEthSignedMessageHash();
        return (address(hash.recover(_sig)) == address(ownerAddress));
    }

}
