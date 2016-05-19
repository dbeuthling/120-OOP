class Deck
  FACES = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
  VALUES = %w(H D C S).freeze

  def initialize
    @deck = FACES.product(VALUES).shuffle
  end

  def deal(num = 1)
    @deck.pop(num)
  end
end

module Hand
  def total
    sum = 0
    ranks = @hand.collect { |card| card[0] }
    ranks.each do |value|
      if value == 'A'
        sum += 11
      elsif value.to_i == 0
        sum += 10
      else
        sum += value.to_i
      end
    end
    ranks.count('A').times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def busted?
    total > 21
  end
end

class Participant
  include Hand
  attr_accessor :hand, :name

  def initialize
    @hand = nil
    set_name
  end

  def stay
    puts "#{name} stays."
  end

  def busted
    puts "#{name} busted!"
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts 'What\'s your name?'
      name = gets.chomp
      break unless name.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = name
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].freeze

  def set_name
    self.name = ROBOTS.sample
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

  def hit(player)
    player.hand << deck.deal.flatten
    puts "#{player.name} drew a:"
    graphic_card(player.hand.last)
    puts "#{player.name}'s new total is #{player.total}"
  end

  def show_initial_cards
    puts "#{computer.name} is showing:"
    graphic_card(computer.hand[0])
    puts 'You have:'
    graphic_card(human.hand[0])
    graphic_card(human.hand[1])
    puts "For a total of #{human.total}"
  end

  def graphic_card(card)
    puts ' __ '
    if card[0] == '10'
      puts "|#{card[0]}|"
    else
      puts "|#{card[0]} |"
    end
    puts '|  |'
    puts "|_#{card[1]}|"
    puts ''
  end

  def player_turn
    answer = nil
    loop do
      loop do
        puts 'Would you like to hit or stay? (h/s)'
        answer = gets.chomp.downcase
        break if %w(h s).include?(answer)
        puts 'You must enter an h or s!'
      end
      hit(human) if answer == 'h'
      if human.busted?
        human.busted
        sleep(1)
        break
      end
      if answer == 's'
        human.stay
        break
      end
    end
  end

  def dealer_turn
    puts '-----Dealer Turn-----'
    sleep 1
    puts "#{computer.name} has:"
    graphic_card(computer.hand[0])
    graphic_card(computer.hand[1])
    puts "For a total of #{computer.total}"
    loop do
      if computer.total < 17
        puts "#{computer.name} must hit!"
        sleep(2)
        hit(computer)
      elsif computer.busted?
        computer.busted
        break
      else
        computer.stay
        break
      end
    end
  end

  def find_winner
    if human.total > computer.total
      human.name
    elsif computer.total > human.total
      computer.name
    end
  end

  def show_result
    puts '=====RESULT====='
    if human.busted?
      puts "#{computer.name} wins!"
    elsif computer.busted?
      puts "#{human.name} wins!"
    else
      puts "#{human.name} stayed with #{human.total}."
      puts "#{computer.name} stayed with #{computer.total}."
      puts "#{find_winner} wins!" if find_winner
      puts 'Push!' unless find_winner
    end
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn unless human.busted?
    show_result
  end
end

Game.new.start
