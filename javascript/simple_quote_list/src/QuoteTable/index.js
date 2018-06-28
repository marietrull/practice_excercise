import React, {Component} from 'react';
import './style.css';

class QuoteTable extends Component {

	constructor(){

		super ();

		// Using state to track pagination.  
		this.state = {
			pageOne: true,
			pageTwo: false,
			pageThree: false

		}
	}

	showPageOne = e => {

		this.setState({
			pageOne: true,
			pageTwo: false,
			pageThree: false
		})

	}

	showPageTwo = e => {

		this.setState({
			pageOne: false,
			pageTwo: true,
			pageThree: false
		})
		
	}

	showPageThree = e => {

		this.setState({
			pageOne: false,
			pageTwo: false,
			pageThree: true
		})
		
	}

	render () {
		// map through given quotes to create table items
		const quoteList = this.props.showQuotes.map((quote, i) => {
			// put the first fifteen quotes on page one
			if (i < 15){
				// if the user clicks on page one, show page one quotes (other quotes will be set to display-none)
				return <tr className={this.state.pageOne ? 'showPage' : 'hidePage'} id={quote.id} key={i}>
							<td>{quote.source}</td>
							<td>{quote.context}</td>
							<td>{quote.quote}</td>
							<td>{quote.theme}</td>
						</tr>
			// put the next fifteen quotes on page two
			} else if (i >= 15 && i < 30){
				// if the user clicks on page two, show page two quotes (other quotes will be set to display-none)
				return <tr className={this.state.pageTwo ? 'showPage' : 'hidePage'} id={quote.id} key={i}>
					<td>{quote.source}</td>
					<td>{quote.context}</td>
					<td>{quote.quote}</td>
					<td>{quote.theme}</td>
				</tr>
			// put quotes 30-38 on page three
			} else {
				// if the user clicks on page three, show page three quotes (other quotes will be set to display-none)
				return <tr className={this.state.pageThree ? 'showPage' : 'hidePage'} id={quote.id} key={i}>
					<td>{quote.source}</td>
					<td>{quote.context}</td>
					<td>{quote.quote}</td>
					<td>{quote.theme}</td>
				</tr>
			}
			
		})

		return (

			<div>  

				<div id="pagination">
				  <a> Pagination </a>
				  <a id='oneTab' href="#" onClick={this.showPageOne}>1</a>
				  <a id='twoTab' href="#" onClick={this.showPageTwo}>2</a>
				  <a id='threeTab' href="#" onClick={this.showPageThree}>3</a>
				</div>

				<table id="quoteTable">
					<tbody>
						<tr>
							<th className='columnHead'> Source </th>
							<th className='columnHead'> Context </th>
							<th className='columnHead'> Quote </th>
							<th className='columnHead'> Theme </th>
						</tr>
						{quoteList}
					</tbody>
				</table>


			</div>

			)
		}
	
}

export default QuoteTable;