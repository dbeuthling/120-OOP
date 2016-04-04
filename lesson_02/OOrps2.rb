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

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.paper? || other_move.spock?)) ||
      (spock? && (other_move.rock? || other_move.scissors?))
  end
end

module Winner
  # attr_accessor :rock_loser
  def initialize
    @winner = nil
    @history_of_wins = []
    @@rock_losing_percent = 0
    @@rock_loser = 0
  end

  def find_winner
    if human.move > computer.move
      @winner = :human
    elsif computer.move > human.move
      @winner = :computer
    else
      @winner = :tie
    end
    @winner
  end

  def increase_winner_score
    human.score += 1 if @winner == :human
    computer.score += 1 if @winner == :computer
  end

  def display_winner
    if @winner == :human
      puts "#{human.name} wins!"
    elsif @winner == :computer
      puts "#{computer.name} wins!"
    else
      puts "It's a tie game!"
    end
  end

  def winner_history
    @history_of_wins << @winner
  end

  def winning_move
    if @winner == :human && computer.history.last == 'rock'
         p @@rock_loser +=1
    end
    @@rock_losing_percent = (@@rock_loser.to_f / computer.history.count('rock').to_f)*100
  end
      
end

class Player
  include Winner
  attr_accessor :move, :name, :score, :history, :rock_loser, :rock_losing_percent

  def initialize
    set_name
    @score = 0
    @history = []
    super
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
      # choice = 'paper'
      break if Move::VALUES.include? choice
      puts "Please enter rock, paper, scissors, lizard, or spock."
    end
    self.move = Move.new(choice)
    p self.history << choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    if @@rock_losing_percent > 60
    # choice = Move::VALUES.sample
      choice = 'paper'
    else
      choice = Move::VALUES.sample
    end
    self.move = Move.new(choice)
    self.history << choice
    p @@rock_loser
    p @@rock_losing_percent
  end
end



class RPSGame
  include Winner
  attr_accessor :human, :computer, :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    super
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

  def display_score
    puts "The score is #{computer.name}: #{computer.score}
             #{human.name}: #{human.score}"
  end

  def display_human_history
    puts "Here is the history of your choices:\n #{human.history}"
  end

  def display_computer_history
    puts "Here is the history of the comupter choices:\n #{computer.history}"
  end

  def match_winner?
    if computer.score == 10
      puts "#{computer.name} wins the match!"
      true
    elsif human.score == 10
      puts "#{human.name} wins the match!"
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
        system "clear"
        loop do
        human.choose
        computer.choose
        display_moves
        find_winner
        display_winner
        increase_winner_score
        display_score
        p winning_move
        winner_history
        break if match_winner?
      end
      display_human_history
      display_computer_history
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play