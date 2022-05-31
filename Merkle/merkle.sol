//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

library MerkleProof {
    function verify(
        bytes32[] calldata proof,
        bytes32 root,
        bytes32 leaf
    ) internal pure returns (bool) {
        bytes32 computedHash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (computedHash < proofElement) {
                computedHash = keccak256(
                    abi.encodePacked(computedHash, proofElement)
                );
            } else {
                computedHash = keccak256(
                    abi.encodePacked(proofElement, computedHash)
                );
            }
        }
        return computedHash == root;
    }
}

contract whitelistUsingMerkleTree {
    using MerkleProof for bytes32[];

    function checkForWhitelistedUsers(
        bytes32[] calldata proof,
        bytes32 rootHash,
        address listedAddress
    ) public pure returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(listedAddress));
        bool existence = proof.verify(rootHash, leaf);
        return existence;
    }
}
