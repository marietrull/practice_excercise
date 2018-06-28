import React, {Component} from 'react';
import './style.css';
import QuoteTable from '../QuoteTable';

class QuoteContainer extends Component {

	constructor () {
		
		super();

		this.state = {
			allQuotes: [],
			showQuotes: [],
			searchParam: ''
		}
	}

	componentDidMount(){
		this.getallQuotes()
		.then((response) => {
			this.setState({
				allQuotes:response,
				showQuotes:response
			})
		})
	}

	getallQuotes = async () => {
    const allQuotesJson = await fetch('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/allQuotes.json')

    const allQuotes = await allQuotesJson.json();

    return allQuotes;
    }

    showAll = async () => {

    	const allQuotes = this.state.allQuotes;

    	this.setState({
    		showQuotes: allQuotes,
		})

    	return allQuotes;
    }

    showMovies = e => {

    	const movieQuotes = [];

   		const quoteList = this.state.allQuotes.map((quote, i) => {
   			if (quote.theme == "movies"){
   				movieQuotes.push(quote);
   			}
   		})

   		console.log(movieQuotes, 'movieQuotes')

    	this.setState({
    		showQuotes: movieQuotes,
		})
    }

    showGames = e => {

    	const gameQuotes = [];

   		const quoteList = this.state.allQuotes.map((quote, i) => {
   			if (quote.theme == "games"){
   				gameQuotes.push(quote);
   			}
   		})

   		console.log(gameQuotes, 'movieQuotes')

    	this.setState({
    		showQuotes: gameQuotes,
		})
    }

    updateSearchParam = e => {
    	const search = e.currentTarget.value;
    	this.setState({searchParam: search})
    }

    submitSearch = e => {
    	const searchQuotes = [];

    	const quoteList = this.state.allQuotes.map((quote,i) => {
    		if(quote.quote == this.state.searchParam){
    			searchQuotes.push(quote);
    		}
    	})

    	this.setState({
    		showQuotes: searchQuotes,
    		searchParam: ''
    	})
    }


    render (){

    	return (
    		<div>
    			<form id="searchDiv" onSubmit={this.submitSearch}>
    				<input id="quoteSearch" placeholder="Search for a Quote" value={this.state.searchParam} onChange={this.updateSearchParam}/>
    				<input id='newSubmit' type='submit'/>
    			</form>

    			<div id="themeFilter">
					<a id='all' href="#" onClick={this.showAll}>All</a>
					<a id='movies' href="#" onClick={this.showMovies}>Movies</a>
					<a id='games' href="#" onClick={this.showGames}>Games</a>
				</div>

    			<QuoteTable showQuotes={this.state.showQuotes}/>
    		</div>

    	)
    }
}

export default QuoteContainer;