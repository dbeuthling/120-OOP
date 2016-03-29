class Player

  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ''
      loop do
        puts "What is your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Please enter your name."
      end
      self.name = n
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Choose rock, paper, or scissors."
        choice = gets.chomp
        break if ["rock", "paper", "scissors"].include? choice
        puts "Please enter rock, paper, or scissors."
      end
      self.move = choice
    else
     self.move = ["rock", "paper", "scissors"].sample
    end

  end

  def human?
    @player_type == :human
  end

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors, #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    if
      (human.move == 'rock' && computer.move == 'scissors') ||
      (human.move == 'scissors' && computer.move == 'paper') ||
      (human.move == 'paper' && computer.move == 'rock')
      puts "#{human.name} wins!"
    elsif
      human.move == computer.move
      puts "It's a tie game!"
    else
      puts "#{computer.name} wins!"
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
    return false if answer == 'n'
    return true
  end


  def play
    display_welcome_message


    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end  
end

RPSGame.new.play