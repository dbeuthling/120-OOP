require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]].freeze

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(' ')}
  end

  def unmarked_keys
    @squares.select {|_,v| v.unmarked? }.keys
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(square, marker)
    @squares[square].marker = marker
  end

  def full?
    unmarked_keys.empty?
  end

  def winner?
    !!detect_winner
  end

  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  def detect_winner
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return "Player"
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return "Computer"
      end
    end
    nil
  end

  def reset
    initialize
  end
end

class Square
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
     marker != "X" && marker != "O"
  end
end

class Player
  attr_reader :marker
  def initialize(marker)
    @marker = marker
  end

end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing. Bye now."
  end

  def display_result
    display_board
    if board.detect_winner
      puts "#{board.detect_winner} won!"
    else
      puts "Tie game!"
      
    end
  end

  def display_board(clear = true)
    clear_screen if clear
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
  end

  def human_moves
    puts "Choose a square #{board.unmarked_keys.join(', ')}."
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Please pick a valid number."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    square = board.unmarked_keys.sample
    board.set_square_at(square, computer.marker)
  end

  def play_again?
    again = nil
    loop do
    puts "Would you like to play again? (y/n)"
      again = gets.chomp.downcase
      break if %w(y n).include?(again)
      puts "You must enter a y or n"
    end
    again == 'y'    
  end

  def clear_screen
    system 'clear'
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      display_board(false)
      loop do
        human_moves
        break if board.winner? || board.full?
        computer_moves
        break if board.winner? || board.full?
        display_board

      end
      display_result
      break unless play_again?
    board.reset
    clear_screen
    puts "Here we go!"
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play