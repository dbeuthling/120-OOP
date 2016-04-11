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

  def [](num)
    @squares[num]
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def play_offence
    square_at_risk?(TTTGame::COMPUTER_MARKER)
  end

  def play_defence
    square_at_risk?(TTTGame::HUMAN_MARKER)
  end

  def square_at_risk?(marker_to_check)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares, marker_to_check)
        return squares.select {|square| square.marker == Square::INITIAL_MARKER}[0]
      end
    end
    nil
  end

  def two_identical_markers?(squares, marker_to_check)
    markers = squares.collect(&:marker)
    return true if markers.count(marker_to_check) == 2 && markers.include?(Square::INITIAL_MARKER)
    false
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
  @first_to_move = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = @first_to_move
    @player_name = nil
    @computer_name = ["Ralph", "Jean-Claude", "Butter Passer"].sample
  end

  def play
    clear_screen
    display_welcome_message
    set_player_name
    introduce_computer
    set_player_one
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

  def computer_moves
    if board.play_offence
      board.play_offence.marker = computer.marker
    elsif board.play_defence
      board.play_defence.marker = computer.marker
    elsif board[5].marker == Square::INITIAL_MARKER
      board[5] = computer.marker
    else
      square = board.unmarked_keys.sample
      board[square] = computer.marker
    end
  end

  private

  def set_player_one
    puts "Would you like to go first? (y/n)"
    first = gets.chomp.downcase
    loop do
      break if %w(y n).include?(first)
      puts 'You must enter a y or n'
    end
    if first == 'y'
      @first_to_move = HUMAN_MARKER
    else
      @first_to_move = COMPUTER_MARKER
    end
  end

  def set_player_name
    puts "What is your name?"
    @player_name = gets.chomp
  end

  def introduce_computer
    puts "Hello #{@player_name}, my name is #{@computer_name}."
  end

  def clear_board
    board.reset
    @current_marker = @first_to_move
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
      puts "#{@player_name} wins!"
    when computer.marker
      puts "#{@computer_name} wins!"
    else
      puts 'Tie game!'
    end
  end

  def display_board
    puts "#{@player_name} is #{human.marker}. #{@computer_name} is #{computer.marker}."
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
      puts "#{@player_name} wins the match!"
      return true
    elsif computer.score == 5
      puts "#{@computer_name} wins the match!"
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
      puts "#{@computer_name} has: #{computer.score} wins."
      puts "#{@player_name} has: #{human.score} wins."
      
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
    @current_marker = @first_to_move
    clear_screen
  end

  def display_play_again_message
    puts 'Here we go!'
  end
end

game = TTTGame.new
game.play
