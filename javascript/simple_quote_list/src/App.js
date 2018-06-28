import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import QuoteContainer from './QuoteContainer';

class App extends Component {

  constructor () {

    super();

  }


  render() {


    return (
      
      <div className="App">

        <h1> This is a List of Quotes </h1>

        <QuoteContainer />

      </div>
    );
  }
}

export default App;

