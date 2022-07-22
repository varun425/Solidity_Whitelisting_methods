const { MerkleTree } = require('merkletreejs')
const keccak256 = require("keccak256");
//---------------------generate merkle tree and root hash------------//
const leaves =  [
    "0x31D0A9A6C679598446245f0a01Ee09e26c1183E3",
    "0x8b80805b94286ABb973cc0CDFE13d0e9f88dc394",
    "0x8675832492Cc8E0A21AC4A9ed266786012a51Fd5",
    "0xe6E16263A024C218b70E23eAD9A4fFd4d68a1c3b",
    "0x64f272836B79AC001ed4E4A01CC561176cD65A30",
    "0x8e2ac8988147f1650C5a9d31D9b36Ec7fb6C9dFE", 
    "0xF3013278cC56191D4E5e522f74DD725324de40F8" 
  ].map(x => keccak256(x))
const tree = new MerkleTree(leaves, keccak256,{sortPairs:true})
const root = tree.getHexRoot()
console.log("rootHash =: ",root) // root hash 
console.log("string: \n",tree.toString()) // merkle tree


//----------------------generate merkle proof for address---------------------//
const leaf = keccak256('0x31D0A9A6C679598446245f0a01Ee09e26c1183E3')
const proof = tree.getHexProof(leaf)
console.log("Merkle Proof\n",proof)
