# Setting the board
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]].freeze

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(Square::INITIAL_MARKER) }
  end

  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end

  def unmarked_keys
    @squares.select { |_, v| v.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def winner?
    !!winning_marker
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    initialize
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

# Square
class Square
  INITIAL_MARKER = ' '.freeze
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker != TTTGame::HUMAN_MARKER && marker != TTTGame::COMPUTER_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

# Player
class Player
  attr_reader :marker
  attr_accessor :score
  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

# Gameplay
class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      loop do
        clear_board
        display_board
        loop do
          current_player_moves
          break if board.winner? || board.full?
          clear_screen_and_display_board
        end
        display_result
        sleep(1)
        add_point_to_winner
        display_score
        break if champion?
      end
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def clear_board
    board.reset
    @current_marker = FIRST_TO_MOVE
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thank you for playing. Bye now.'
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts 'Tie game!'
    end
  end

  def display_board
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts ''
    board.draw
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def joinor(nums, sep=", ", word="or")
    nums[-1] = "#{word} #{nums.last}" if nums.size > 1
    nums.join(sep)
  end

  def human_moves
    puts "Choose a square #{joinor(board.unmarked_keys)}."
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts 'Please pick a valid number.'
    end
    board[square] = human.marker
  end

  def computer_moves
    square = board.unmarked_keys.sample
    board[square] = computer.marker
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def champion?
    if human.score == 5
      puts "You win the match!"
      return true
    elsif computer.score == 5
      puts "Computer wins the match!"
      return true
    end
  end

    def add_point_to_winner
      case board.winning_marker
      when human.marker
        human.score += 1
      when computer.marker
        computer.score += 1
      end
    end

    def display_score
      clear_screen
      puts "The computer has: #{computer.score} wins."
      puts "You have: #{human.score} wins."
      
    end

  def play_again?
    again = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      again = gets.chomp.downcase
      break if %w(y n).include?(again)
      puts 'You must enter a y or n'
    end
    again == 'y'
  end

  def clear_screen
    system 'clear'
  end

  def reset
    board.reset
    human.score = 0
    computer.score = 0
    @current_marker = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts 'Here we go!'
  end
end

game = TTTGame.new
game.play
