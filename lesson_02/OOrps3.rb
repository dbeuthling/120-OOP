class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end

  # def >(other_move)
  #   (rock? && (other_move.scissors? || other_move.lizard?)) ||
  #     (paper? && (other_move.rock? || other_move.spock?)) ||
  #     (scissors? && (other_move.paper? || other_move.lizard?)) ||
  #     (lizard? && (other_move.paper? || other_move.spock?)) ||
  #     (spock? && (other_move.rock? || other_move.scissors?))
  # end
end

class Rock < Move

  def initialize
    'rock'
  end

  def >(other_move)
    other_move == 'scissors' || other_move == 'lizard'
  end

  def <(other_move)
    other_move == 'paper' || other_move == 'spock'
  end

  def to_s
    'rock'
  end

end

class Paper < Move

  def initialize
    'paper'
  end

  def >(other_move)
    other_move == 'rock' || other_move == 'spock'
  end

  def <(other_move)
    other_move == 'scissors' || other_move == 'lizard'
  end

  def to_s
    'paper'
  end

end

class Scissors < Move

  def initialize
    'scissors'
  end

  def >(other_move)
    other_move == 'paper' || other_move == 'lizard'
  end

  def <(other_move)
    other_move == 'rock' || other_move == 'spock'
  end

  def to_s
    'scissors'
  end

end

class Lizard < Move

  def initialize
    'lizard'
  end

  def >(other_move)
    other_move == 'paper' || other_move == 'spock'
  end

  def <(other_move)
    other_move == 'rock' || other_move == 'scissors'
  end

  def to_s
    'lizard'
  end

end

class Spock < Move

  def initialize
    'spock'

  end

  def >(other_move)
    other_move == 'rock' || other_move == 'scissors'
  end

  def <(other_move)
    other_move == 'paper' || other_move == 'lizard'
  end

  def to_s
    'spock'
  end

end



class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
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
      puts "Choose rock, paper, scissors, lizard, or spock."
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Please enter rock, paper, scissors, lizard, or spock."
    end
    # self.move = Move.new(choice)
    case choice
    when "rock"
      self.move = Rock.new
    when "paper"
      self.move = Paper.new
    when "scissors"
      self.move = Scissors.new
    when "lizard"
      self.move = Lizard.new
    when "spock"
      self.move = Spock.new
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    # self.move = Rock.new
    choice = Move::VALUES.sample
    case choice
    when "rock"
      self.move = Rock.new
    when "paper"
      self.move = Paper.new
    when "scissors"
      self.move = Scissors.new
    when "lizard"
      self.move = Lizard.new
    when "spock"
      self.move = Spock.new
    end
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors Lizard Spock, #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def increase_winner_score
    human.score += 1 if human.move > computer.move.to_s 
    computer.score += 1 if human.move < computer.move.to_s 
  end

  def display_winner
    if human.move > computer.move.to_s 
      puts "#{human.name} wins!"
    elsif human.move < computer.move.to_s 
      puts "#{computer.name} wins!"
    else
      puts "It's a tie game!"
    end
  end

  def display_score
    puts "The score is #{computer.name}: #{computer.score}
             #{human.name}: #{human.score}"
  end

  def winner?
    if computer.score == 3
      puts "#{computer.name} wins!"
      true
    elsif human.score == 3
      puts "#{human.name} wins!"
      true
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
    if answer == 'y'
      computer.score = 0
      human.score = 0
      return true
    end
    false
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        increase_winner_score
        display_score
        break if winner?
      end
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
