var Web3 = require('web3');
var web3 = new Web3();
const createSignature = params => {
    params = {recipient: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", nonce: 0, ...params};
    const message = web3.utils.soliditySha3(
      {t: 'address', v: params.recipient},
      {t: 'uint256', v: params.nonce}
    
    ).toString('hex');
    const privKey = '-------owner private key-----------for sign user or investors addresses';
    const { signature } = web3.eth.accounts.sign(
      message,  
      privKey
    );
    return { signature, recipient: params.recipient, nonce: params.nonce };
  };

const a= createSignature()

console.log(a)
