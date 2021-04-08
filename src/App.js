import logo from './logo.svg';
import React, { Component } from 'react'
import { browserHistory, Router, Route } from 'react-router';
import './App.css';
import User from './homepage'

class App extends Component {
  render(){
    return(
      <Router>
        <Route path="/" exact render = {props => 
        <div>
            <User />
        </div>
} />
      </Router>
      
    )
  }
}

export default App;
