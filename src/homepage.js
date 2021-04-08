import React from 'react'
import web3 from './web3'
import userContract from './userContract'

class user extends React.Component{    

    constructor(props){
        super(props);
        this.state ={
              totalUserToken : '',
              totalInvUser : '',
              totalInvNtwrk : '',
              totalToken : ''
        }
    }
    
    totalInvestment = async (event) => {
        event.preventDefault();

        const accounts = await web3.eth.getAccounts();

        const result = await userContract.methods.transfer(this.state.totalInvUser, this.state.totalUserToken)
        .send({from: accounts[0]})

        var status = result.events.checkStatus.returnValues;
        document.getElementById("userInv").innerHTML = status[0];

        const ntwrk = await userContract.methods.balanceOf(this.state.totalInvNtwrk)
        .send({from: accounts[0]})
        
        var ntwrkIn = result.events.ntwrk.totalntwrkInv;

        document.getElementById("ntwrkInv").innerHTML = ntwrkIn[0];

    }
    
    handleTotalInvByUser = (event) => {
            event.preventDefault();
            this.setState({totalInvUser: event.target.value})
    }

    handleTotalInvByNtwrk = (event) => {
        event.preventDefault();
        this.setState({totalInvNtwrk: event.target.value})
    }

    handleTotalToken = (event) => {
        event.preventDefault();
        this.setState({totalToken: event.target.value})
    }

    handleTotalTokenByUser = (event) => {
        event.preventDefault();
        this.setState({totalUserToken: event.target.value})
    }

    render(){
        return(            
            <div>
                <form onSubmit={this.totalInvestment}>
                    <div>
                        <label for="totalInvUser">Total Investment of user</label>
                        <input type="text" id="totalInvUser" placeholder="Enter address " 
                        onChange={this.handleTotalInvByUser} value={this.state.value} />

                        <input type="text" id="totalUserToken" placeholder="Enter no of tokens " 
                        onChange={this.handleTotalTokenByUser} value={this.state.value} />
                        <p id="userInv"></p>
                    </div>

                    <div>
                        <label for="totalInvNtwrk">Total Investment till network</label>
                        <input type="text" id="totalInvNtwrk" placeholder="Enter address " 
                        onChange={this.handleTotalInvByNtwrk} value={this.state.value} />

                        <p id="ntwrkInv"></p>
                    </div>

                    <div>
                        <label for="totalTokenUser">Total tokens of user</label>
                        <input type="text" id="totalTokenUser" placeholder="Enter address" 
                        onChange={this.handleTotalToken} value={this.state.value} />

                        <p id="totTokens"></p>
                    </div>
                </form>
            </div>
        )
    }
}

export default user;