class Move
  VALUES = ['rock', 'paper', 'scissors'].freeze

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def to_s
    @value
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter your name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose rock, paper, or scissors."
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Please enter rock, paper, or scissors."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors, #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} wins!"
    elsif computer.move > human.move
      puts "#{computer.name} wins!"
    else
      puts "It's a tie game!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y or n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Please enter a y or n."
    end
    return true if answer == 'y'
    false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
