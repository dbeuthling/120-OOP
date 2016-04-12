class Deck
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
  VALUES = ['H', 'S', 'C', 'D'].freeze 

  attr_accessor :deck

  def initialize
    @deck = FACES.product(VALUES).shuffle
  end

  def deal(num=1)
    @deck.pop(num)
  end

  def count
  end

end

module Hand #each player's cards

  def total(cards)
    sum = 0
    rank = cards.collect { |card| card[0] }
    rank.each do |value|
      if value == "A"
        sum += 11
      elsif value.to_i == 0
        sum += 10
      else
        sum += value.to_i
      end
    end
    rank.count("A").times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def hit(player)
    player.hand << deck.deal
  end

end

class Player
  include Hand
  attr_accessor :hand

  def initialize
    @hand = nil
    @name = 'Human'
  end

  def hit

  end

  def stay
  end

  def busted?
  end



end

class Dealer
  include Hand
  attr_accessor :hand

  def initialize
    @hand = nil
    @name = 'Computer' # seems like very similar to Player... do we even need this?
  end


  def hit
  end

  def stay
  end

  def busted?
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
  attr_accessor :human, :computer, :deck

  def initialize
    @deck = Deck.new
    @human = Player.new
    @computer = Dealer.new
  end


  def deal_cards
    human.hand = deck.deal(2)
    computer.hand = deck.deal(2)
  end

  def show_initial_cards
    puts "Dealer is showing:"
    graphic_card(computer.hand[0])
    puts "You have:"
    graphic_card(human.hand[0])
    graphic_card(human.hand[1])
    puts "For a total of #{human.total(human.hand)}"
    # p deck.instance_variable_get(:@deck).count
  end

  def graphic_card(card)
    print ""
    puts " __ "
    if card[0] == '10'
      puts "|#{card[0]}|"
    else
      puts "|#{card[0]} |"
    end
    puts "|  |"
    puts "|_#{card[1]}|"
    puts ""
  end



  

  def start
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

 Game.new.start
