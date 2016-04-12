class Deck
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].freeze
  VALUES = ['H', 'S', 'C', 'D'].freeze 

  attr_accessor :new_deck

  def initialize
    @new_deck = FACES.product(VALUES).shuffle
  end

  def deal # does the dealer or the deck deal?
    cards = @new_deck
    cards.pop(2)
  end
end

module Hand

  def hand
    deck.deal
  end

end

class Player
  include Hand
  attr_accessor :cards

  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
    @cards = hand
    @name = 'Player'
  end

  def hit

  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer
  include Hand

  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end



class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

# Game.new.start
x = Player.new.hand
p x