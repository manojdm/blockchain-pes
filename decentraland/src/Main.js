import { useEffect, useState } from 'react'
import Web3 from 'web3'
import Tether from './truffle_abis/Tether.json'
import RWD from './truffle_abis/RWD.json'
import Management from './truffle_abis/Management.json'
import './style.css'



function App() {

  const [account, setAccount] = useState();
  const tether = Tether;

  useEffect(() => {
    return async () => {
      await loadWeb3();
      await loadBlockChainData();
    };
  }, []);

  const loadBlockChainData = async () => {
    const web3 = window.web3
    const accounts = await web3.eth.getAccounts()
    console.log(accounts);
    const networkId = await web3.eth.net.getId()
    console.log(networkId);
    
  }


  const loadWeb3 = async () => {

    console.log('Started load')

    if(window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    }
    else {
      window.alert('Non ethereum browser detected. You should consider Metamask!')
    }
  }


  
  return (

      <div className="main">
        <div className="header-container">
          <header>
            <div className="logo">
              logo
            </div>
            <div className="menu">
              Welcome to ABC DAPP
            </div>
          </header>
        </div>
        <div className="container">
          <div className="stake-details">
            <div className="title">
              ABC TOKEN STAKING
            </div>
            <div className="details">
              Staking Balance: 0&nbsp; AUSDT
              <br />
              Reward Balance: 0&nbsp; AUSDT
            </div>
          </div>
          <div className="stake-tokens-form">
            <form>
              <div className="form-attribute">
                <label>Stake Tokens: </label>
                <input type="number" placeholder={0} />
              </div>
              <input type="submit" defaultValue="stake" />
            </form>
          </div>
          <div className="unstake-tokens">
            <input type="submit" defaultValue="unstake tokens" />
          </div>
        </div>
      </div>


    );
}

export default App;
