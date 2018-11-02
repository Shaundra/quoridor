class Player
  attr_accessor :player_token, :fence_count, :current_position, :board, :baseline

  def initialize(player_token, initial_position, board)
    @player_token = player_token
    @current_position = initial_position
    @board = board
    @fence_count = 10
    @baseline = initial_position[0]

    # Move to starting position
    move(initial_position)
  end

  def ask_turn_type
    puts "Would you like to move your pawn or place a fence? Type pawn or fence."
    user_input = gets.strip.downcase

    if %w[pawn p fence f].member?(user_input) == false
      puts "Invalid move type."
      ask_turn_type
    else
      user_input
    end
  end

  def get_new_position
    puts "Where would you like to move? Use the guide to choose coordinates. Ex. 2, 4"
    user_input = gets.strip.split(",").map { |x| x.to_i }

    if user_input.is_a?(Array) && user_input.size == 2
      user_input
    else
      puts "Invalid form. Try again,"
      ask_where_to
    end
  end

  def where_to_valid_form?
    ask_where_to.is_a?
  end

  def move(new_position_coord)
    # Remove 'from' position
    self.board[self.current_position[0]][self.current_position[1]] = nil
    
    # Place in 'to' position
    self.board[new_position_coord[0]][new_position_coord[1]] = self.player_token

    # Update current_position
    self.current_position = new_position_coord
  end

end