
class Card
  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit, @name, @value = suit, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITS = [:Hearts, :Diamonds, :Spades, :Clubs]
  NAME_VALUES = {
    :Two   => 2,
    :Three => 3,
    :Four  => 4,
    :Five  => 5,
    :Six   => 6,
    :Seven => 7,
    :Eight => 8,
    :Nine  => 9,
    :Ten   => 10,
    :Jack  => 10,
    :Queen => 10,
    :King  => 10,
    :Ace   => [11, 1]}

  # when we initialize, shuffle the deck
  def initialize
    shuffle
  end

  def deal_card
    # grab a random card out of the playable cards
    random = rand(@playable_cards.size)
    # remove the random card so that it can't be re-played
    @playable_cards.delete_at(random)
  end

  def shuffle
    # generate cards and store them in playable_cards array
    @playable_cards = []
    SUITS.each do |suit|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suit, name, value)
      end
    end
  end
end

# Create a hand
class Hand
  # added points to the hand
  attr_accessor :cards, :points

  # created an empty array to store the cards in each hand
  def initialize
    @cards = []
  end

  def deal_cards(allCards)
    # grab a new card from the deck and push into the cards array (add it to the hand)
    @cards << allCards.deal_card
  end

  def show_cards
    # hand starts out with zero points
    @points = 0

    # show the user the cards in the hand via .map
    puts @cards.map { |card| "#{card.name} of #{card.suit}"}.join(' and ')

    @cards.each do |card|
      # conditional logic to track the points in a hand
      if card.value.is_a?(Array)
        if @points + card.value[0] <= 21
          @points += card.value[1]
        else
          @points += card.value[0]
        end
      else 
        @points += card.value
      end
    end
    # show the user what the points in the hand are
    puts "\nTotal points are #{@points}."
  end

  def hitOrStay
    # set the input to an empty string/allow the user to have a fresh choice each time
    input = ""
    # If the user inputs anything other than "H" or "S", ask them again
    while (input != "H" && input != "S" ) do
      puts "\nWould you like to stay or hit?? Input S or H"
      # take the user's input and make it uppercase/account for the user not remembering to capitalize their choice
      input = gets.chomp.upcase
    end
    return input
  end
end

class BlackJack
  # give each game a deck, a player, and a dealer
  attr_reader :deck, :player, :dealer

  def initialize
    # where we actually create a new deck and hands for the player and dealer
    @deck = Deck.new
    @player = Hand.new
    @dealer = Hand.new
    ### REQUIREMENT - As a player or dealer, I can get a hand with two cards in it ###
    2.times do 
      player.deal_cards(@deck) 
    end
    2.times do 
      dealer.deal_cards(@deck) 
    end
  end

  def start
    # show the user what they've been dealt
    puts "\nYour hand has the following cards:  "
    @player.show_cards
    ### REQUIREMENT - As a player,I can bust or win immediately when I am getting/dealt cards ###
    player_points
    # show the user what the dealer has been dealt
    puts "\nThe Dealer has the following cards: "
    @dealer.show_cards
    # While the player keeps on hitting
    while @player.hitOrStay == "H" do
      # Remind them that they decided to hit + give them a new card
      puts "\nYou have decided to hit."
      player.deal_cards(@deck)
      puts "\nThe following card is being added to your hand: "
      @player.show_cards
      ### REQUIREMENT - As a player,I can bust or win immediately when I am getting/dealt cards ###
      player_points
    end
    # when the player decides to stay or inputs "S"
    puts "\nYou have decided to stay."
    # Show them the dealer's cards
    puts "\nThe Dealer has the following cards: "
    @dealer.show_cards
    # ### REQUIREMENT - As a dealer,I can draw cards after the player until I win or lose(based on conditional logic in dealer_points)###
    dealer_points
    # look for a winner
    find_winner
  end

  def dealer_points
    if @dealer.points < 17
      @dealer.deal_cards(@deck)
      ### REQUIREMENT - As a player,I can see what card the dealer is showing ###
      puts "\nThe Dealer has the following cards:"
      @dealer.show_cards
    end
    if @dealer.points == 21
      # show the user that the dealer won and prompt for a new game
      puts "\nThe Dealer hit 21 and won!The Dealer wins."
      new_hand
    end
    if @dealer.points > 21
      # show the user that the dealer busted and prompt for a new game
      puts "\nThe Dealer has exceeded 21 and Busted! You win."
      new_hand
    end
  end

  def player_points
    if @player.points == 21
      # notify the user that they've won and prompt for a new game
      puts "\nWell look what we have here - BlackJack! You win!"
      new_hand
    elsif @player.points > 21
      # notify the user that they have busted and prompt for a new game
      puts "\nYou have exceeded 21 and Busted! The Dealer wins."
      new_hand
    end
  end

  def find_winner
    if @player.points > @dealer.points
      # notify the user that they've won and prompt for a new game
      puts "\nYou have more points than the Dealer. You Win!"
      new_hand
    else
      # notify the user that they have lost and prompt for a new game
      puts "\nLooks like the dealer has more points than you. The Dealer wins."
      new_hand
    end
  end

  def new_hand
    # set the input to an empty string/allow the user to have a fresh choice each time
    new_hand = ""
    # If the user inputs anything other than "Y" or "N", ask them again
    while (new_hand != "Y" && new_hand != "N") do
      puts "\nWould you like to try again? Type Y or N"
      # take the user's input and make it uppercase/account for the user not remembering to capitalize their choice
      new_hand = gets.chomp.upcase
    end
    if new_hand == "Y"
      # start a new game
      puts "\nExcellent! We will start a new round."
      newgame = BlackJack.new
      newgame.start

    else 
      # end the game
      puts "\nThank you for playing! See you next time."
      # exit the program
      exit(0)

    end
  end
end

blackjack = BlackJack.new
blackjack.start

require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suit_is_correct
    assert_equal @card.suit, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end
  
  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end
  
  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    # added ! --> originally this read that the test card SHOULD be included. 
    # new statement says that this should NOT be included
    assert(!@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class GameTest < Test::Unit::TestCase

  def setup
    @blackjack = Blackjack.new
  end

end
